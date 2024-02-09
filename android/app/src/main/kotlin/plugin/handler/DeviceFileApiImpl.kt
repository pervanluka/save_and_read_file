import android.content.Context
import android.os.Environment
import kotlinx.coroutines.*
import java.io.File

class DeviceFileApiImpl(private val context: Context) : DeviceFileApi {
    private val scope = CoroutineScope(Dispatchers.IO) // Use the IO dispatcher for disk and network IO

    override fun saveFile(msg: SaveFileMessage, callback: (Result<FileResponse>) -> Unit) {
        scope.launch {
            // Use getExternalFilesDir to access app-specific external storage which does not require runtime permissions
            val documentsDir = context.getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS)
            if (documentsDir == null) {
                withContext(Dispatchers.Main) {
                    callback(Result.success(FileResponse(false, null, "Documents directory not accessible")))
                }
                return@launch
            }
            val file = File(documentsDir, msg.filename)
            try {
                file.writeText(msg.content)
                val response = FileResponse(true, null, null)
                withContext(Dispatchers.Main) {
                    callback(Result.success(response))
                }
            } catch (e: Exception) {
                val response = FileResponse(false, null, e.localizedMessage)
                withContext(Dispatchers.Main) {
                    callback(Result.success(response))
                }
            }
        }
    }

    override fun readFile(msg: ReadFileMessage, callback: (Result<FileResponse>) -> Unit) {
        scope.launch {
            val documentsDir = context.getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS)
            if (documentsDir == null) {
                withContext(Dispatchers.Main) {
                    callback(Result.success(FileResponse(false, null, "Documents directory not accessible")))
                }
                return@launch
            }
            val file = File(documentsDir, msg.filename)
            if (file.exists()) {
                try {
                    val content = file.readText()
                    val response = FileResponse(true, content, null)
                    withContext(Dispatchers.Main) {
                        callback(Result.success(response))
                    }
                } catch (e: Exception) {
                    val response = FileResponse(false, null, e.localizedMessage)
                    withContext(Dispatchers.Main) {
                        callback(Result.success(response))
                    }
                }
            } else {
                val response = FileResponse(false, null, "File not found")
                withContext(Dispatchers.Main) {
                    callback(Result.success(response))
                }
            }
        }
    }
}