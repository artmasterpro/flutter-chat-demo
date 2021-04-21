import 'dart:async';

abstract class MessageCommonDao<Entity> {
  Future<bool> add(Entity e);

  Future<bool> addAll(List<Entity> e);

  Future<bool> removeAll();

  Future<Entity> find(int id);

  Future<bool> update(Entity model);

  Future<List<Entity>> findAll(String idTo, String idFrom);
}
