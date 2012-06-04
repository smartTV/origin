package javaLimpios;

import java.util.Vector;


import org.cybergarage.upnp.*;
import org.cybergarage.upnp.ssdp.SSDPPacket;



public class DeviceInfo {

	private String nombre = null;
	private String estado = "Apagado";
	private String fabricante = null;
	private String dispositivo = null;
	private Icon icono = null;
	Device dev;
	
	public DeviceInfo(){
            
	}
	
	public String getNombre() {
		return dev.getFriendlyName();
	}

	public void setNombre(String nombre) {
		this.dev.setFriendlyName(nombre);
	}

	public ServiceList getServiceList() {
		return dev.getServiceList();
	}

	public ActionList getActionList(Service service) {
		return service.getActionList();
	}
	
	public ActionList getSetActionList(Service service) {
		ActionList temp = new ActionList();
		ActionList actions = service.getActionList();
		for(int i =0;i<actions.size();i++){
			Action action = (Action) actions.get(i);
			System.out.println("Actions, " +action.getName());
			if(action.getName().startsWith("Set")){
				System.out.println("ActionsSet, " +action.getName());
				temp.add(action);
			}
		}
		return temp;
	}
	
	public ActionList getGetActionList(Service service) {
		ActionList temp = new ActionList();
		ActionList actions = service.getActionList();
		for(int i =0;i<actions.size();i++){
			Action action = (Action) actions.get(i);
			System.out.println("Actions, " +action.getName());
			if(action.getName().startsWith("Get")){
				System.out.println("ActionsGet, " +action.getName());
				temp.add(action);
			}
		}
		return temp;
	}
	
	
	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	public String getEstado() {
		return estado;
	}
	
	public String getFabricante (){
		return dev.getManufacture();
	}
	
	public void setFabricante (String fabricante){
		this.dev.setManufacture(fabricante);
	}
	
	public String getModeloDispositivo (){
		return dev.getModelName();
	}
	
	public Device getDispositivo (){
		return dev;
	}
        public void setDispositivo (Device device){
		dev = device;
	}
	
	public Icon getIcono() {
            Icon tmp = dev.getIconList().getIcon(0);
            //System.err.println("getURLBase: "+ dev.getURLBase() +"/"+dev.getIconList().getIcon(0).getURL());
            //System.err.println("getURLBase: "+ dev.getURLBase() +"/"+dev.getIconList().getIcon(0).getURL());


         //   System.err.println("getDeviceType: "+ dev.getDeviceType() /*+"/"+dev.getIconList().getIcon(0).getURL()*/);
         //   System.err.println("getFriendlyName: "+ dev.getFriendlyName() /*+"/"+dev.getIconList().getIcon(0).getURL()*/);
/*OK A veces*///System.err.println("getInterfaceAddress: "+ dev.getInterfaceAddress() /*+"/"+dev.getIconList().getIcon(0).getURL()*/);
            //System.err.println("getLocation: "+ dev.getLocation()/* +"/"+dev.getIconList().getIcon(0).getURL()*/);
        /*  System.err.println(dev.getIconList().getIcon(0).getURL());
            System.err.println(dev.getIconList().getIcon(0).getURL());
            System.err.println(dev.getIconList().getIcon(0).getURL());
            System.err.println(dev.getIconList().getIcon(0).getURL());
            System.err.println(dev.getIconList().getIcon(0).getURL());
        *///    System.err.println("getModelURL: "+ dev.getModelURL() /*+"/"+dev.getIconList().getIcon(0).getURL()*/);
        //    System.err.println("getPresentationURL: "+ dev.getPresentationURL() /*+"/"+dev.getIconList().getIcon(0).getURL()*/);
        //    System.err.println("getDescriptionFile: "+ dev.get /*+"/"+dev.getIconList().getIcon(0).getURL()*/);
		return tmp;
	}

	public void setIcono(Icon icono) {
		this.icono = icono;
	}

        public String getIconURL(){
            String tmp = dev.getLocation().replace("description.xml", dev.getIcon(0).getURL());
            System.out.println ("URL del ICONO: "+tmp);
            return tmp;
        }
/*
        public String getURL (){
            return dev.getLocation();
        }

        public String getURLBase(){
            return dev.getURLBase();
        }

        public IconList getIconList(){
            return dev.getIconList();
        }
*/

/*	public String getNombreHTML() { //En vez de getDescription() poner getNombre(), getEstado(), getFabricante(), getPeso().
		String html_head = "<html><head></head>";
		String html_body = "<body><b>"+ getNombre() +"</b></br></body></html>";
		
		return html_head + html_body;
	}
		
	public String getEstadoHTML(){
		String html_head = "<html><head></head>";
		String html_body = "<body><b>"+ getEstado() +"</b></br></body></html>";
		
		return html_head + html_body;
	}
	*/
/*	public String getFabricanteHTML(){
		String html_head = "<html><head></head>";
		String html_body = "<body><b>"+ getFabricante() +"</b></br></body></html>";
		
		return html_head + html_body;
	}
	*/
}
