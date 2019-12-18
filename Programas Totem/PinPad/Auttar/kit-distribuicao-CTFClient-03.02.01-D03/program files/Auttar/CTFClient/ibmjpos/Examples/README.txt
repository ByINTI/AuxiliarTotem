                     IBM(R) UnifiedPOS(TM) Demo Readme

                                                               August, 2006
                             

  INTRODUCTION:

  Thank you for your interest in the IBM UnifiedPOS(TM) Demo - a tool that shows 
  the basic functionality of IBM devices, and provides sample code that will  
  assist in the development of your applications using IBM(R) JavaPOS.

  Disclaimer of Warranties:  The following (enclosed) sample code is developed
  by IBM Corporation.  The sample code is not part of any standard or IBM product
  and is provided to you solely for the purpose of assisting you in the development
  of your applications.  The code is provided "AS IS", without warranty of any kind. 
  IBM shall not be liable for any damages arising out of your use of the sample
  code, even if they have been advised of the possibility of such damages.           


 ==============================================================================

  CONTENTS:

  I    How to execute UnifiedPOS Demo
  II   How to Compile UnifiedPOS Demo code
  III  Warnings
       

  ==============================================================================

  I.    How to execute UnifiedPOS Demo

  From a system prompt enter:
    java com.ibm.jpos.tools.sdicc.demo.<DeviceCategory>Demo <logicalName> 

  Where :
    DeviceCategoy : is the programmatic  name of the device in UnifiedPOS 
    logicalName   : the logical name of the device in the jpos.xml

  for example
     java com.ibm.jpos.tools.sdicc.demo.POSPrinterDemo ibmprinter 

  ==============================================================================

  II.    How to complile UnifiedPOS demo code
 
  The ibmuposdemo.jar includes the UnifiedPOS demo source code. This jar file 
  can be found in IBMJPOs/Examples (Windows) or /opt/ibm/javapos/Examples (Linux)
  directory. 

  To compile the source code

  a) Extract the ibmuposdemo.jar into a directory in your system. 
  b) Add this directory  to your classpath
  c) To compile all sources, enter -  javac *.java

 ==============================================================================
  III.  Warnings:

  UnifiedPOS demo is also included in the jtux.jar file that is in the IBM UnifiedPOS 
  installation directory. If you make changes to the demo tool in order take effect
  make sure you add your classes to the classpath before jtux.jar file.

  To avoid namespace collision, be sure to change the package names.

 ==============================================================================

  * IBM is a registered trademark of the International Business Machines
    Corporation.
  * Java and all Java-based trademarks and logos are trademarks or
    registered trademarks of Sun Microsystems, Inc. in the United States
    and other countries.

 
