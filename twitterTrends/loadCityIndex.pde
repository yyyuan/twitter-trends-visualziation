void loadCityIndex(IntDict i){
   Table table = loadTable("cities.csv", "header");
    // test # of rows readed
    //println("Read in the trends table");
    //println(table.getRowCount() + " total rows in table"); 
    // read each row
    for (TableRow row : table.rows()) {
      String s = row.getString("location");
      int index = row.getInt("index");
      i.set(s,index);
    }
    return;
}

