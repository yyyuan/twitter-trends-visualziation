class Trends{
   IntDict trends = new IntDict();
   IntList frequency = new IntList();
   void setDict(String s, int k){
     this.trends.set(s,k);
   }
   void setFrequency(int f){
     this.frequency.append(f);
   }
   int lookUpValue(String s){
     return this.trends.get(s);
   }
}
