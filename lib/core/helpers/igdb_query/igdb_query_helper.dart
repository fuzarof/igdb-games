class IGDBQueryHelper {
  static String buildQuery({
    List<String>? fields,
    int? limit,
    int? offset,
    String? search,
    Map<String, IGDBQueryData>? where,
  }) {
    // TODO: update default fields
    String query = "fields ${(fields ?? ['id', 'name']).join(',')};";
    if (search != null && search.isNotEmpty) query += 'search "$search";';
    if (where != null) {
      where.forEach((key, value) {
        if (where.keys.first == key) query += 'where ';
        query += '$key = ${value.data}';
        query += where.keys.last == key ? ';' : '&';
      });
    }
    query += 'limit ${(limit ?? 10)};';
    query += 'offset ${(offset ?? 0)};';
    return query;
  }
}

abstract class IGDBQueryData {
  late String data;
}

class Equal extends IGDBQueryData {
  Equal(dynamic data) {
    this.data = data.toString();
  }
}

class Or extends IGDBQueryData {
  Or(List<dynamic> dataList) {
    data = "(${dataList.join(',')})";
  }
}

class And extends IGDBQueryData {
  And(List<dynamic> dataList) {
    data = "{${dataList.join(',')}}";
  }
}
