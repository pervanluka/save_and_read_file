// Autogenerated from Pigeon (v16.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): FlutterError {
  return FlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Generated class from Pigeon that represents data sent in messages. */
data class SaveFileMessage (
  val filename: String,
  val content: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): SaveFileMessage {
      val filename = list[0] as String
      val content = list[1] as String
      return SaveFileMessage(filename, content)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      filename,
      content,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class ReadFileMessage (
  val filename: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): ReadFileMessage {
      val filename = list[0] as String
      return ReadFileMessage(filename)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      filename,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class FileResponse (
  val successful: Boolean,
  val content: String? = null,
  val error: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): FileResponse {
      val successful = list[0] as Boolean
      val content = list[1] as String?
      val error = list[2] as String?
      return FileResponse(successful, content, error)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      successful,
      content,
      error,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object DeviceFileApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          FileResponse.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ReadFileMessage.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          SaveFileMessage.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is FileResponse -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is ReadFileMessage -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is SaveFileMessage -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface DeviceFileApi {
  fun saveFile(msg: SaveFileMessage, callback: (Result<FileResponse>) -> Unit)
  fun readFile(msg: ReadFileMessage, callback: (Result<FileResponse>) -> Unit)

  companion object {
    /** The codec used by DeviceFileApi. */
    val codec: MessageCodec<Any?> by lazy {
      DeviceFileApiCodec
    }
    /** Sets up an instance of `DeviceFileApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: DeviceFileApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.save_and_read_file.DeviceFileApi.saveFile", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val msgArg = args[0] as SaveFileMessage
            api.saveFile(msgArg) { result: Result<FileResponse> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.save_and_read_file.DeviceFileApi.readFile", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val msgArg = args[0] as ReadFileMessage
            api.readFile(msgArg) { result: Result<FileResponse> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object FlutterFileApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          FileResponse.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is FileResponse -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class FlutterFileApi(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by FlutterFileApi. */
    val codec: MessageCodec<Any?> by lazy {
      FlutterFileApiCodec
    }
  }
  fun displayContent(responseArg: FileResponse, callback: (Result<Unit>) -> Unit)
{
    val channelName = "dev.flutter.pigeon.save_and_read_file.FlutterFileApi.displayContent"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(responseArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
