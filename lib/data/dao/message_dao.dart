import 'package:flutter_chat_demo/data/dao/interface/common_dao.dart';
import 'package:flutter_chat_demo/data/database/database.dart';
import 'package:flutter_chat_demo/data/message.dart';

class MessageDao implements MessageCommonDao<Message> {
  final dbProvider = DatabaseProvider.dbProvider;

  @override
  Future<bool> add(Message message) async {
    final db = await dbProvider.database;
    int result = await db.insert(messageTABLE, message.toJson());

    return result == 1;
  }

  @override
  Future<bool> addAll(List<Message> list) async {
    final db = await dbProvider.database;
    int result = 0;

    for (Message message in list) {
      List<Map<String, dynamic>> messages = await db.query(messageTABLE,
          where: 'timestamp = ?', whereArgs: [message.timestamp]);
      if (messages.isEmpty) {
        await db.insert(messageTABLE, message.toJson());
      }
      result++;
    }
    return result != list.length;
  }

  @override
  Future<Message> find(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> messages =
        await db.query(messageTABLE, where: 'id = ?', whereArgs: [id]);

    return messages.isNotEmpty ? Message.fromJson(messages[0]) : null;
  }

  @override
  Future<List<Message>> findAll(String idTo, String idFrom) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> messages = await db.query(messageTABLE,
        where: 'idTo = ? AND idFrom = ?',
        whereArgs: [idTo, idFrom],
        orderBy: 'timestamp DESC');
    List<Message> mess = messages.isNotEmpty
        ? messages.map((message) => Message.fromJson(message)).toList()
        : [];

    return mess;
  }

  @override
  Future<bool> removeAll() async {
    final db = await dbProvider.database;

    int result = await db.delete(messageTABLE);

    return result == 1;
  }

  @override
  Future<bool> update(Message message) async {
    final db = await dbProvider.database;
    int result = await db.update(messageTABLE, message.toJson(),
        where: 'timestamp = ?', whereArgs: [message.timestamp]);

    return result == 1;
  }
}
