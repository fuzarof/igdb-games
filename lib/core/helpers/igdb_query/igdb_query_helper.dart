class IGDBQueryHelper {
  static String buildQuery({
    List<String>? fields,
    int? limit,
    int? offset,
    String? search,
    List<int>? inIds,
  }) {
    String query = "fields ${(fields ?? ['*']).join(',')};";
    if (search != null && search.isNotEmpty) query += 'search "$search";';
    if (inIds != null) query += 'where id = (${inIds.join(',')});';
    query += 'limit ${(limit ?? 10)};';
    query += 'offset ${(offset ?? 0)};';
    return query;
  }
}
