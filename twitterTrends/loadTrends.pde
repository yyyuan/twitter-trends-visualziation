void loadTrends(Trends t){
  /*String[] files = {"222_1010_tags.csv", "222_1110_tags.csv", "222_1210_tags.csv",
                    "222_1310_tags.csv", "222_1410_tags.csv", "222_1510_tags.csv",
                    "222_1610_tags.csv", "222_1710_tags.csv", "222_1810_tags.csv",
                    "222_1910_tags.csv", "222_2010_tags.csv", "222_2240_tags.csv"};
  // load tables
  for(int i = 0; i < 12; i++){*/
  Table table = loadTable("222_tags.csv", "header");
  // test # of rows readed
  //println("Read in the trends table");
  //println(table.getRowCount() + " total rows in table"); 
  // read each row
  int num = 1;
  t.setFrequency(0);
  for (TableRow row : table.rows()) {
    String s = row.getString("name");
    int freq = row.getInt("frequency");
    t.setDict(s,num);
    t.setFrequency(freq);
    num ++;
   }
   //println("Total size of trends: "+t.trends.size());
   //println("Total size of frequency: "+t.frequency.size());
}


