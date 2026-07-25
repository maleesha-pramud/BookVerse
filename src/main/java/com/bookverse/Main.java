package com.bookverse;

import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

import java.io.File;

public class Main {
    public static void main(String[] args) throws LifecycleException {
        Tomcat tomcat = new Tomcat();

        // Set Port
        tomcat.setPort(8080);
        tomcat.getConnector(); // Initialize default HTTP connector

        // Configure Web Application directory
        String webappDir = new File("src/main/webapp").getAbsolutePath();

        // Add web application context
        tomcat.addWebapp("", webappDir);

        System.out.println("Starting Embedded Tomcat on http://localhost:8080");
        tomcat.start();
        tomcat.getServer().await();
    }
}