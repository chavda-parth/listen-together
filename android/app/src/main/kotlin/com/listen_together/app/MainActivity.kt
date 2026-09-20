package com.listen_together.app

import android.app.Activity
import android.content.Intent
import android.database.Cursor
import android.net.Uri
import android.provider.OpenableColumns
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val channel = "com.listen_together.app/customfilepicker"
    private var pendingResult: MethodChannel.Result? = null

    private val filePickerLauncher = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()
    ) { activityResult ->

        if (activityResult.resultCode == Activity.RESULT_OK) {
            val uri: Uri? = activityResult.data?.data
            
            uri?.let {
                pendingResult?.success(getFileName(it))
            }
        } else {
            pendingResult?.success(null)
        }
        
        pendingResult = null
    }
    
    fun getFileName(uri: Uri): String? {
        var fileName: String? = null
        
        val cursor: Cursor? = contentResolver.query(
                    uri, 
                    arrayOf(OpenableColumns.DISPLAY_NAME), 
                    null, 
                    null,
                    null)

        
        cursor?.use { 
            if (it.moveToFirst()) {
                val index: Int = it.getColumnIndexOrThrow(
                    OpenableColumns.DISPLAY_NAME)
            
                fileName = it.getString(index)
            }  
        }
        
        return fileName
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                if (call.method == "pickFile") {
                    pendingResult = result
                    val openFileIntent = Intent(Intent.ACTION_OPEN_DOCUMENT)
                    openFileIntent.type = "*/*"
                    openFileIntent.addCategory(Intent.CATEGORY_OPENABLE)
                    filePickerLauncher.launch(openFileIntent)
                } else {
                    result.notImplemented()
                }
            }
    }
}
