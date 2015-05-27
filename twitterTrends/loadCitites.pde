void loadCities(City[][] c){
  String[] files = {"222_1010_data.csv", "222_1110_data.csv", "222_1210_data.csv",
                    "222_1310_data.csv", "222_1410_data.csv", "222_1510_data.csv",
                    "222_1610_data.csv", "222_1710_data.csv", "222_1810_data.csv",
                    "222_1910_data.csv", "222_2010_data.csv", "222_2240_data.csv"};
  // load tables
  for(int i = 0; i < 12; i++){
     Table table = loadTable(files[i], "header");
    //println("Read in the trends table");
    //println(files[i]);
    //println(table.getRowCount() + " total rows in table"); 
    int count = 0;
    int j = -1;
    for (TableRow row : table.rows()) {
      // store in temp value
      int rank = row.getInt("rank");
      String location = row.getString("location");
      String name = row.getString("name");
      if(count%3==0){j++; c[i][j] = new City(location);}
      c[i][j].addTrend(name,rank);
      count++;
    }
  }
  c[11][59] = new City("Denver");
  
  /*for(int i = 0; i < 60; i++){
     println(c[11][i].cityName, cityIndex.get(c[11][i].cityName)-1, c[11][i].position.x, c[11][i].position.y);
     println(c[11][i].trends[0],c[11][i].trends[1],c[11][i].trends[2]);
   }*/
}
