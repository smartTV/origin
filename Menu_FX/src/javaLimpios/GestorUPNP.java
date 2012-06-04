package javaLimpios;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
//import javafx.scene.CustomNode;


import org.cybergarage.util.*;
import org.cybergarage.upnp.*;
import org.cybergarage.upnp.ssdp.*;
import org.cybergarage.upnp.device.*;
import org.cybergarage.upnp.event.*;
import org.cybergarage.upnp.Device;

//import org.cybergarage.upnp.device.DeviceChangeListener;


public class GestorUPNP extends ControlPoint implements NotifyListener, EventListener, SearchResponseListener {

    public final static String TECHNOLOGY = "@DOMOLAN";
    private final static String TITLE = "Smart TV Control Point";
    public static int DEFAULT_WIDTH = 640;
    public final static int DEFAULT_HEIGHT = 480;

    public GestorUPNP() {
        addNotifyListener(this);
        addSearchResponseListener(this);
        addEventListener(this);

        Thread buscador = new Thread(new Runnable() {

            @Override
            public void run() {
                while(true){

                    search("upnp:rootdevice");

                    try {
                        Thread.sleep(5000);
                    } catch (InterruptedException ex) {
                        ex.printStackTrace();
                    }
                }
            }
        });

        buscador.start();
        Debug.on();
    }

    ////////////////////////////////////////////////
    //	Graphics
    ////////////////////////////////////////////////
    public void printConsole(String msg) {

        FileWriter fichero = null;
        PrintWriter pw = null;
        String hora;
        String fecha;

        try {
            fichero = new FileWriter("log.txt", true); //Segundo parametro a true para indicar que a�ada texto al fichero.
            //Si no se pone, sobreescribe el fichero. Elimina la fila que estaba escrita anteriormente
            fecha = getFechaActual();
            hora = getHoraActual();

            pw = new PrintWriter(fichero);

            pw.write("(" + fecha);
            pw.write(" " + hora + ") ");
            pw.write(msg + "\r\n"); //Solamente con \n no funciona

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                //Nuevamente aprovechamos el finally para
                //asegurarnos que se ciera el fichero
                if (null != fichero) {
                    fichero.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    ////////////////////////////////////////////////
    //	Obtener fecha y hora
    ////////////////////////////////////////////////
    //Metodo usado para obtener la fecha actual
    //@return Retorna un <b>STRING</b> con la fecha actual formato "dd-MM-yyyy"
    public static String getFechaActual() {
        Date ahora = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
        return formateador.format(ahora);
    }

    //Metodo usado para obtener la hora actual del sistema
    //@return Retorna un <b>STRING</b> con la hora actual formato "hh:mm:ss"
    public static String getHoraActual() {
        Date ahora = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat("hh:mm:ss a");

        return formateador.format(ahora);
    }


    ////////////////////////////////////////////////
    //	Listener
    ////////////////////////////////////////////////
    public void deviceNotifyReceived(SSDPPacket packet) {
        System.out.println(packet.toString());

        if (packet.isDiscover() == true) {
            String st = packet.getST();
            printConsole("ssdp:discover : ST = " + st);
        } else if (packet.isAlive() == true) {
            String usn = packet.getUSN();
            String nt = packet.getNT();
            String url = packet.getLocation();
            printConsole("ssdp:alive : uuid = " + usn + ", NT = " + nt + ", location = " + url);
        } else if (packet.isByeBye() == true) {
            String usn = packet.getUSN();
            String nt = packet.getNT();
            printConsole("ssdp:byebye : uuid = " + usn + ", NT = " + nt);
        }
    }

    public void deviceSearchResponseReceived(SSDPPacket packet) {
        String uuid = packet.getUSN();
        String st = packet.getST();
        String url = packet.getLocation();
        printConsole("device search res : uuid = " + uuid + ", ST = " + st + ", location = " + url);
    }

    public void eventNotifyReceived(String uuid, long seq, String name, String value) {
        printConsole("event notify : uuid = " + uuid + ", seq = " + seq + ", name = " + name + ", value =" + value);
    }


    /*public void addMyDeviceChangeListener(DeviceChangeListener node){
        addDeviceChangeListener(node);
    }*/

}
