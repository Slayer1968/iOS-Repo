//import Foundation
class Storage{
    private static var _list = read()
    
    private static var filename = "data.dat"
    
    
    //read
    static func read() -> [String]{
        let path = getDocumentDir().appendingPathComponent(filename)
        if let arr = NSArray(contentsOf: path) as? [String] {
            return arr
        }
        return [String]()
    }
    
    
    //create
    static func addItem(str:String){
        _list.append(str)
        save()
    }
    
    
    //delete
    static func remove(index:Int){
        _list.remove(at: index)
        save()
    }
    
    
    //edit-update
    //recieve an index and the new string
    //update the _list String Array
    //save to file
    static func edit(index:Int, txt:String){
        _list[index] = txt
        save()
    }
    
   
    
    
    
    //save method being called as save() above
    private static func save(){
        let nsArr = _list as NSArray
        let path = getDocumentDir().appendingPathComponent(filename)
        nsArr.write(to: path, atomically: true)
    }
    
    
    //getDocumentDir() method called above
    private static func getDocumentDir() -> URL{
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return url[0]
    }
}
