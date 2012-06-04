package displayshelf;

import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.shape.*;
import javafx.scene.paint.*;
import javafx.scene.image.*;
import javafx.scene.input.*;
import javafx.scene.control.Button;
import displayInfo.Info;
import javaLimpios.GestorUPNP;
import org.cybergarage.upnp.Device;
import java.util.Date;
import org.cybergarage.upnp.device.DeviceChangeListener;
import javaLimpios.DeviceInfo;

public class Slider extends CustomNode, DeviceChangeListener
{
    var imagesLength: Integer = bind items.size();
    var half: Integer = bind imagesLength / 2;
    var items: Node[];
    var noFound = true;

    var gestorUPNP:GestorUPNP;

    var info: Info = Info{
        translateX: 700
        translateY: 300

    };
    
    var images = [
                "DSC_0026_2.jpg",
                "DSC_0040_2.jpg",
                "DSC_0068_2.jpg",
                "DSC_0083_2.jpg",
                "DSC_0094_2.jpg",
                "DSC_0129_2.jpg",
                "DSC_0152_2.jpg",
                "DSC_0162_2.jpg",
                "DSC_0172_2.jpg",
                "DSC_0178_2.jpg",
                "DSC_0199_2.jpg",
                "DSC_0277_2.jpg",
                "DSC_0290_2.jpg",
                "DSC_0425_2.jpg"
            ];
    var width = 600;
    var shelf: DisplayShelf = DisplayShelf 
    {
                layoutX: 80
                layoutY: 300
                spacing: 50
                scaleSmall: 0.7
                leftOffset: -110
                rightOffset: 110
                perspective: true
                focusTraversable: true
                content: bind items

                onKeyPressed: function(e: KeyEvent): Void {
                    if (e.code == KeyCode.VK_LEFT) {
                        shelf.shift(1);
                    }

                    if (e.code == KeyCode.VK_RIGHT) {
                        shelf.shift(-1);
                    }
                }
            }
    var firstItem: Item = Item {

                itemId: -1
                angle: 45
                position: items.size() - half
                image: Image { url: "{__DIR__}images/no_device_found.png" }
                shelf: bind shelf
                slider:null
            }
    var lastItem: Item;
   /* var control: Group = Group {
                content: [
                    Button {
                        layoutX: 200
                        text: "Add"
                        action: addDevice;
                    }
                    Button {
                        layoutX: 340
                        text: "Remove"
                        action: removeDevice;
                    }
                ]
            }*/

    init {
        println("Class init block");
        addNoDevice();
    }

    override public function create(): Node {
        shelf.translateX = width / 2 - 200 / 2;
        shelf.translateY = 50;
        shelf.shiftToCenter(firstItem);
        shelf.requestFocus();

        gestorUPNP = GestorUPNP{};
        gestorUPNP.addDeviceChangeListener(this);
        gestorUPNP.setSearchMx(1);
        //gestorUPNP.setSearchMx(3);
        gestorUPNP.start();

        var group: Group = Group
        {
                    content: [
                        Rectangle {
                            width: width
                            height: 300
                            layoutX:80
                            layoutY: 300
                            fill: LinearGradient {
                                startX: 0
                                startY: 0
                                endX: 0
                                endY: 1
                                proportional: true
                                stops: [
                                    Stop {
                                        offset: 0.0
                                        color: Color.rgb(150, 150, 150)
                                    }
                                    Stop {
                                        offset: 1.0
                                        color: Color.rgb(30, 30, 30)
                                    }
                                ]
                            }
                        },
                        shelf,
                        //control,
                        info
                    ]
                }

        return group;
    }

    public function addNoDevice() {
        insert firstItem into items;
        shelf.shift(0);
        println("Added No Device");

    }

    public function removeNoDevice() {
        delete firstItem from items;
        shelf.shift(0);
        println("Removed No Device");
    }

    public function addDevice(device:DeviceInfo) {
        if (noFound) {
            removeNoDevice();
            noFound = false;
        }
        var item: Item = Item {
                    itemId: imagesLength - 1
                    itemInfo: bind device
                    angle: 45
                    position: imagesLength - half
                    image: Image {url: device.getIconURL()}
                    shelf: bind shelf
                    slider: bind this
                };
                
        insert item into items;

        lastItem = item;

        println("Size: {items.size()}");

        shelf.refresh();
        //shelf.shiftToCenter(item);

        println("The button Add is clicked, size:{imagesLength}");

    }

    public function removeDevice(device:DeviceInfo) {
        println("Size: {items.size()}");

        delete lastItem from items;

        
        //shelf.shift(0);
        shelf.refresh();
        println("The button Remove is clicked");
    }

    override
    public function deviceAdded(device:Device) {
        //printConsole("deviceAdded");
        if (device.getUPC().equals(gestorUPNP.TECHNOLOGY)){
            var tmp:DeviceInfo = DeviceInfo{};
            tmp.setDispositivo(device);
            addDevice(tmp);
        }
    }

    override
    public function deviceRemoved(device:Device) {
        //printConsole("deviceRemoved");
        if (device.getUPC().equals(gestorUPNP.TECHNOLOGY)){
            var tmp:DeviceInfo = DeviceInfo{};
            tmp.setDispositivo(device);
            removeDevice(tmp);
        }

    }
    
    public function actualizarInformacion(dev: DeviceInfo) {
   /*AÑADIDO*/     info.getDeviceInfo(dev);
        info.setdevfabricante(dev.getFabricante());
        info.setdevnombre(dev.getNombre());
        info.setdevdispositivo(dev.getModeloDispositivo());
        info.setdevestado(dev.getEstado());
    }

}
