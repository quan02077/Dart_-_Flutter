// void main(){
//     print("Hello world!");
// }

void main(){
    int so = 2;
    double soThuc = 5.5;
    String chuoi = "Hello";
    List<int> listInt = [1,2,3,4,5];
    Set<int> setInt = {1,2,3,4};
    Map<String, int> mapData = {
        'tuoi': 19
    };

    dynamic soDong = 10;
    var chuoiVar = 'ChoNhien'; 

    print(listInt[2]);
    print(setInt.toList()[3]);

    if(so < 5) {
        print('ChoNhien');
    }else{
        print('NhienNgu');
    }

    for(int i in setInt){
        print(i);
    }

    List<Map<String, int>> listObject = [
        {
            'age': 9
        },
        {
            'tien': 10
        },
    ];

    for(Map<String, int> i in listObject){
        print(i);
    }
}