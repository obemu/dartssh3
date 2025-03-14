import 'dart:isolate';

import 'ssh_socket.dart';

typedef _IsolateArgs = ({
  int instanceId,
  SendPort port,
});

abstract class IsolatedSSHSocket extends SSHSocket {
  IsolatedSSHSocket._() : _instanceId = _nextInstanceId++;

  static int _nextInstanceId = 0;

  static void _isolateEntrypoint(_IsolateArgs args) {

    }

  static String _getDebugName(int instanceId, [String? suffix]) {
    final name = "isolated_ssh_socket_$instanceId";
    if (null == suffix) return name;
    return "${name}_$suffix";
  }

  static Future<IsolatedSSHSocket> connect(
    String host,
    int port, {
    Duration? timeout,
  }) {
// TODO(obemu): Implement this.
    throw UnimplementedError();
  }

  final int _instanceId;
  late final Isolate _isolate;
  late final ReceivePort _receiver;

  Future<void> _start() async {
    _receiver = ReceivePort(_getDebugName(_instanceId, "receive_port"));
    _receiver.listen(_handleIsolateResponse);

    _isolate = Isolate.spawn(_handleIsolateResponse, message);
  }

  Future<void> _handleIsolateResponse(dynamic data) async {}
}
