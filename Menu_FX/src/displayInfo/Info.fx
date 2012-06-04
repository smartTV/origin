package displayInfo;
/*
 * MainFrame.fx
 *
 * Created on Feb 10, 2009, 2:41:07 PM
 */

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.scene.CustomNode;
import javafx.ext.swing.SwingLabel;
import javafx.ext.swing.SwingComboBox;
import javafx.ext.swing.SwingComboBoxItem;
import javafx.scene.Group;
import org.cybergarage.upnp.Device;
import org.cybergarage.upnp.Action;
import javaLimpios.DeviceInfo;
//import javaLimpios.DeviceInfo;
//import device_menu.DeviceInfo;
//import org.cybergarage.upnp.Device;

/**
 * @author Maider
 */
public class Info extends CustomNode {
// Application Width and Height

    def width = 600;
    def height = 400;
    def dispositivo = "Dispositivo: ";
    def nombre = "Nombre: ";
    def fabricante = "Fabricante: ";
/*AÑADIDO*/    def estado = "Estado: ";
    var titleLableInformacion = "Información general del dispositivo";
    var titleLabelConfigurar = "Configurar información sobre...";
    var titleLabelConsultar = "Consultar información sobre...";
    var labelFont = Font.font("", FontWeight.BOLD, 15); //Para los LABELs
    var titleLabelFont = Font.font("", FontWeight.BOLD, 16);

    var devnombre = "";
    var devdispositivo = "";
    var devfabricante = "";
/*AÑADIDO*/    var devestado = "";
    var dev : DeviceInfo;

    var LabeltitleTextInformacion = Text {
        translateY: 20
        translateX: width / 3
        font: titleLabelFont
        fill: Color.AZURE
        content: bind titleLableInformacion //Para que introduzca el texo de titleLabelInformacion
    }
    var LabeltitleTextConfigurar = Text {
        translateY: 140
        translateX: width / 3
        font: titleLabelFont
        fill: Color.AZURE
        content: bind titleLabelConfigurar //Para que introduzca el texo de titleLabelConfigurar
    }
    var LabeltitleTextConsultar = Text {
        translateY: 250
        translateX: width / 3
        font: titleLabelFont
        fill: Color.AZURE
        content: bind titleLabelConsultar //Para que introduzca el texo de titleLabelConsultar
    }

    var labelDispositivo = SwingLabel{
        text: bind "{dispositivo}{devdispositivo}"
        font: labelFont
    }

    var labelNombre = SwingLabel {
        text: bind "{nombre}{devnombre}"
        font: labelFont
    }

    var labelFabricante = SwingLabel {
        text: bind "{fabricante}{devfabricante}"
        font: labelFont
    }

    /*AÑADIDO*/var labelEstado = SwingLabel {
        text: bind "{estado}{devestado}"
        font: labelFont
    }
    var Informacion = HBox {
                translateX: 50 //Desplazar el texto del label a la derecha
                translateY: 20
                content: [
                    VBox {
                        spacing: 10 //Espacio entre los labels
                        content: [
                            labelDispositivo,
                            labelNombre,
                            labelFabricante
                        ]
                    }
                ]
            }
    var setPowerButton: ImageView = ImageButton {
                x: 20
                y: 200

                normalImage: Image {
                    url: "{__DIR__}images/set_power_no_pulsado.jpg"
                    width: 50
                    height: 50
                };
                selectImage: Image {
                    url: "{__DIR__}images/set_power_pulsado.jpg"
                    width: 50
                    height: 50
                };

                onMouseClicked: function(e) {
                    if (setPowerButton.image.url.equals("{__DIR__}images/set_power_no_pulsado.jpg")){
                        setPowerComboBox.visible = false;
                        setPowerAceptar.visible = false;
                    }
                    else
                        if (setPowerButton.image.url.equals("{__DIR__}images/set_power_pulsado.jpg")){
                            setPowerComboBox.visible = true;
                            setPowerAceptar.visible = true;
                        }
                }
            }
    def setPower: String[] = ["Apagar", "Encender"];
    var setPowerComboBox = SwingComboBox {
                translateY: 65
                translateX: 100
                visible: false

                width: 150
                items: for (state in setPower)
                    SwingComboBoxItem {
                        text: state
                    }
            }
    var setPowerAceptar: ImageView = ImageButton {
                translateY: 34
                translateX: 200
                visible: false

                normalImage: Image {
                    url: "{__DIR__}images/AceptarNoPulsado.jpg"
                    width: 80
                    height: 20
                };

                selectImage: Image {
                    url: "{__DIR__}images/AceptarNoPulsado.jpg"
                    width: 80
                    height: 20
                };
                onMouseClicked: function(e) {
                    println("Pulsando Aceptar");
                    println ("SELECCIONADO: {setPowerComboBox.getJComboBox().getSelectedItem()}");
                    var nuevoEstado:Boolean;
                    if(setPowerComboBox.getJComboBox().getSelectedItem().toString().equals("Apagar")){
                        nuevoEstado = false;
                    }else
                    if (setPowerComboBox.getJComboBox().getSelectedItem().toString().equals("Encender")){
                        nuevoEstado = true;
                    }
                    setDevicePower(nuevoEstado);
                }
            }
    var Consultas = HBox {
                translateX: 50 //Desplazar el texto del label a la derecha
                translateY: 115
                content: [
                    VBox {
                        spacing: 10 //Espacio entre los labels
                        content: [
                            labelEstado
                        ]
                    }
                ]
            }
    var frontPage = VBox {
                spacing: 10
                content: [Informacion, setPowerComboBox, setPowerAceptar, Consultas];
            };
    var pageHolder = frontPage;
// used this VBox to take advantage of "bind" key word with content
    var pageWrapperBox = VBox {
                spacing: 10
                content: bind pageHolder
            };
// organizes the contents in a box and provide spacing between adjacent ccomponents
    var contentBox = VBox {
                content: [LabeltitleTextInformacion, LabeltitleTextConfigurar, LabeltitleTextConsultar, pageWrapperBox]
            };
// Background Image
    var bgImage = ImageView {
                image: Image {
                    height:height
                    width: width
                    url: "{__DIR__}images/Fondo_azul.JPG"
                }
            }
    var group: Group = Group {
                content: [bgImage, setPowerButton, contentBox];
            };

    override public function create(): Node {

        return group;
    }
    var nuevoEstado = "";

/*AÑADIDO*/    public function getDeviceInfo (device:DeviceInfo){
        dev = device;
    }

/*MODIFICADO*/    public function setDevicePower(power:Boolean)
    {
        
	if (dev == null)
            return;
        var disp :Device = dev.getDispositivo();
	if(power){
            nuevoEstado = "1";
            devestado = "Endendido";
	}else{
            nuevoEstado = "0";
            devestado = "Apagado";
	}
	var setPowerAct:Action = disp.getAction("SetPower");
	setPowerAct.setArgumentValue("Power", nuevoEstado);
	setPowerAct.postControlAction();
    }

    public function setdevnombre(nomb:String)
    {
       devnombre = nomb;
    }

    public function getdevnombre():String
    {
        return devnombre;
    }

    public function setdevdispositivo(dispositivo:String)
    {
        devdispositivo = dispositivo;
    }

    public function getdevdispositivo():String
    {
        return devdispositivo;
    }

    public function setdevfabricante(fabricante:String)
    {
        devfabricante = fabricante;
    }

    public function getdevfabricante():String
    {
        return devfabricante;
    }

   /*AÑADIDO*/  public function setdevestado(estado:String)
    {
        devestado = estado;
    }

    /*AÑADIDO*/  public function getdevestado():String
    {
         return devestado;
    }

}
