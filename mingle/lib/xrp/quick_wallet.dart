// ignore_for_file: avoid_print


import 'package:xrpl_dart/xrpl_dart.dart';
import 'package:mingle/xrp/socket_service.dart';


class QuickWallet {
  QuickWallet(
    this.privateKey, 
    {XRPProvider? rpc}
  ): 
    rpc = rpc ?? _createDefaultProvider() {
      print("wallet created $address\n${privateKey.toHex()}\n$pubHex\n====================================");
  }
  
  // Static helper method to create WebSocket provider
  static XRPProvider _createDefaultProvider() {
    // Note: This is synchronous, so we'll use a factory pattern instead
    throw UnimplementedError('Use QuickWallet.connect() instead');
  }
  
  // Async factory constructor for WebSocket connection
  static Future<QuickWallet> connect(
    XRPPrivateKey privateKey,
    {XRPProvider? rpc}
  ) async {
    final provider = rpc ?? await _createWebSocketProvider();
    return QuickWallet._internal(privateKey, provider);
  }
  
  // Internal constructor
  QuickWallet._internal(this.privateKey, this.rpc) {
    print("wallet created $address\n${privateKey.toHex()}\n$pubHex\n====================================");
  }
  
  // Create WebSocket provider
  static Future<XRPProvider> _createWebSocketProvider() async {
    final service = await RPCWebSocketService.connect(
      'wss://s.altnet.rippletest.net:51233/'
    );
    return XRPProvider(service);
  }

  final XRPPrivateKey privateKey;
  final XRPProvider rpc;
  
  // Your other wallet properties and methods...
  String get address => privateKey.getPublic().toAddress().address;
  String get pubHex => privateKey.getPublic().toHex();
  XRPPublicKey get publicKey => privateKey.getPublic();
  XRPAddress get toAddress => publicKey.toAddress();

  String get xAddress => publicKey.toAddress().toXAddress(isTestnet: true);

  Future<double> balance() async {
    try {
      final accountInfo = await rpc.request(
        XRPRequestAccountInfo(account: address)
      );
      
      final drops = accountInfo.accountData.balance;
      return int.parse(drops) / 1000000.0; // Convert drops to XRP
    } catch (e) {
      print('Error getting balance: $e');
      rethrow;
    }
  }
}