//***************************************************************************
//                                                                           
//  Module Name:     JTest.java
//                                                                           
//  Description:     This is a standard Java program which illustrates the      
//                   use of the IBM's JavaPOS services.
//                                                                           
//      Copyright (C) IBM Corporation 1999,2000
//                                                                           
//      DISCLAIMER OF WARRANTIES.  The following [enclosed] code is          
//      sample code created by IBM Corporation. This sample code is not      
//      part of any standard or IBM product and is provided to you solely    
//      for  the purpose of assisting you in the development of your         
//      applications.  The code is provided "AS IS", without                 
//      warranty of any kind.  IBM shall not be liable for any damages       
//      arising out of your use of the sample code, even if they have been   
//      advised of the possibility of such damages.   
//                             
//      Modified by Dawei Chen, Oct 30, 2000.                                                                     
//                                                                           
//***************************************************************************

import java.util.*;

import jpos.*;
import jpos.config.*;
import jpos.loader.*;

import com.ibm.jpos.services.*;

public class JTest
{
    //Create array of device objects.
    jpos.BaseControl devices[] = 
    { 
        new jpos.CashDrawer(),
        new jpos.HardTotals(),
        new jpos.Keylock(),
        new jpos.LineDisplay(),
        new jpos.MICR(),
        new jpos.MSR(),
        new jpos.POSKeyboard(),
        new jpos.POSPrinter(),
        new jpos.Scale(),
        new jpos.Scanner(),
        new jpos.ToneIndicator()
    };


    static String logicalDeviceName;
    static String deviceCategory;

    // Verbose output flag.
    static boolean verbose = false;


    /**
     * Main program entry point
     */
    public static void main(String[] argv) 
    {
        int i;
        JTest JTest= new JTest();

        // Show the IBM JavaPOS version.
        System.out.println("");
        System.out.println("IBM JavaPOS V" + com.ibm.jpos.Version.getVersionString());
        System.out.println("");

        if (argv.length > 0)
        {

            for (i=0; i<argv.length; i++)
            {

                // See if they want to be verbose about it.
                if (argv[i].equalsIgnoreCase("-v"))
                    verbose = true;

                else if (argv[i].equalsIgnoreCase("-h"))

                    // Display helpfull (?) information.
                    displayHelpAndExit();


                //Test the specific device base on the input.  You can only test one device at a time.
                else
                {

                    JTest.SingleDeviceTest(argv[i]);
                    System.exit(0);
                }
            }

        }



        // If there is no deveice specified for the test, then get entry from JCL and test the deveices that has boolean JTEST set to true.
        JTest.JTEST();
        System.out.println("---------------------------------------------");
        //Sleep a while.
        try
        {
            Thread.currentThread().sleep( 1000 );
        }
        catch ( Exception e )
        {

        }

        System.exit(0);
    }
    //Method that does the test for the specific device base on input.
    public void SingleDeviceTest(String logicalDeviceName)
    {
        JposEntryRegistry registry;
        Enumeration entries;
        JTest JTest= new JTest();
        boolean gotADevice = false;

        // Get JCL device info.
        registry = JposServiceLoader.getManager().getEntryRegistry();

        entries = registry.getEntries();

        // Get all JCL entries and do the test.

        while ( entries.hasMoreElements() )
        {
            JposEntry entry = (JposEntry)entries.nextElement();

            if ( entry.hasPropertyWithName( JposEntry.LOGICAL_NAME_PROP_NAME ) )
            {
                String devNam = (String)entry.getPropertyValue( JposEntry.LOGICAL_NAME_PROP_NAME );
                
                //Test
                if (devNam.equalsIgnoreCase(logicalDeviceName))
                {
                    String deviceCategory = (String)entry.getPropertyValue( JposEntry.DEVICE_CATEGORY_PROP_NAME);
                    gotADevice = true;
                    if (JTest.openClaimEnable(deviceCategory, devNam))
                        JTest.testDevice(deviceCategory);
                }
            }
        }

        if (!gotADevice) 
        {
            System.out.println("Could not find device configuration information for " + logicalDeviceName + ".");
        }
    }

    public  void JTEST()
    {
        JposEntryRegistry registry;
        Enumeration entries;
        JTest JTest= new JTest();

        // Get JCL device info.
        registry = JposServiceLoader.getManager().getEntryRegistry();
        entries = registry.getEntries();

        //set flag JT, use to check if there is any JTEST.
        boolean JT=false;

        // Search JTEST from JCL entries and do the test.

        while ( entries.hasMoreElements() )
        {
            JposEntry entry = (JposEntry)entries.nextElement();

            if ( entry.hasPropertyWithName( JposEntry.LOGICAL_NAME_PROP_NAME ) )
            {

                Boolean JTEST= new Boolean(false);
                String devNam = (String)entry.getPropertyValue( JposEntry.LOGICAL_NAME_PROP_NAME );

                String deviceCategory = (String)entry.getPropertyValue( JposEntry.DEVICE_CATEGORY_PROP_NAME);

                //Search JTEST and check if JTEST set to true.
                if (entry.hasPropertyWithName("JTEST"))
                {
                    JTEST= (Boolean)entry.getPropertyValue( "JTEST");

                    if ( JTEST.booleanValue() )
                    {

                        JT=true;

                        //Test

                        if (JTest.openClaimEnable(deviceCategory, devNam))

                            JTest.testDevice(deviceCategory);

                    }
                }

            }

        }
        if (!JT)
        {
            System.out.println("There is no device specified for testing.");
        }



    }


    /** 
     * Return string version of JPOS error.
     */

    String jposError(int ec, int ece)
    {
        switch (ec)
        {
        case jpos.JposConst.JPOS_E_CLOSED        : 
            return("JPOS_E_CLOSED");

        case jpos.JposConst.JPOS_E_CLAIMED       : 
            return("JPOS_E_CLAIMED");

        case jpos.JposConst.JPOS_E_NOTCLAIMED    : 
            return("JPOS_E_NOTCLAIMED");

        case jpos.JposConst.JPOS_E_NOSERVICE     : 
            return("JPOS_E_NOSERVICE");

        case jpos.JposConst.JPOS_E_DISABLED      : 
            return("JPOS_E_DISABLED");

        case jpos.JposConst.JPOS_E_ILLEGAL       : 
            return("JPOS_E_ILLEGAL");

        case jpos.JposConst.JPOS_E_NOHARDWARE    : 
            return("JPOS_E_NOHARDWARE");

        case jpos.JposConst.JPOS_E_OFFLINE       : 
            return("JPOS_E_OFFLINE");

        case jpos.JposConst.JPOS_E_NOEXIST       : 
            return("JPOS_E_NOEXIST");

        case jpos.JposConst.JPOS_E_EXISTS        : 
            return("JPOS_E_EXISTS");

        case jpos.JposConst.JPOS_E_FAILURE       : 
            return("JPOS_E_FAILURE");

        case jpos.JposConst.JPOS_E_TIMEOUT       : 
            return("JPOS_E_TIMEOUT");

        case jpos.JposConst.JPOS_E_BUSY          : 
            return("JPOS_E_BUSY");

        case jpos.JposConst.JPOS_E_EXTENDED      : 
            return("JPOS_E_EXTENDED = " + ece);

        default:
            return("Unknown error from JavaPOS");
        }
    }

    /**
     * Test the device. Testing not supported for all devices.
     */
    boolean testDevice(String deviceCategory)
    {
        boolean good = true;
        java.util.Date theDate = new java.util.Date();

        try
        {
            if (deviceCategory.equalsIgnoreCase("CashDrawer"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing CashDrawer");

                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("HardTotals"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing HardTotals");

                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("KeyLock"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing Keylock");

                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("LineDisplay"))
            {
                ((jpos.LineDisplay)(devices[3])).displayText(theDate.toString(), 0);
                System.out.println("");
                System.out.println("displayText() = JPOS_E_SUCCESS");

            }
            else if (deviceCategory.equalsIgnoreCase("MICR"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing MICR");

                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("MSR"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing MSR");

                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("POSKeyboard"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing POSKeyboard");
                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("POSPrinter"))
            {
                ((jpos.POSPrinter)(devices[7])).printNormal(jpos.POSPrinterConst.PTR_S_RECEIPT, "JTest POSPrinter\n");
                ((jpos.POSPrinter)(devices[7])).printNormal(jpos.POSPrinterConst.PTR_S_RECEIPT, theDate.toString() + "\n");
                System.out.println("");
                System.out.println("printNormal() = JPOS_E_SUCCESS");

            }
            else if (deviceCategory.equalsIgnoreCase("Scale"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing Scale");
                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("Scanner"))
            {
                // Not yet tested...
                System.out.println("");
                System.out.println("Testing Scanner");
                return(true);

            }
            else if (deviceCategory.equalsIgnoreCase("ToneIndicator"))
            {
                // Make some noise!
                int pitches[] =   { 875, 875, 1300, 2000, 1300, 2000};
                int durations[] = { 300, 300, 300,  500,  300,  1000};

                ((jpos.ToneIndicator)(devices[10])).setTone1Volume(1);

                // CHARGE !!!!
                for (int j=0; j<pitches.length; j++)
                {
                    ((jpos.ToneIndicator)(devices[10])).setTone1Pitch(pitches[j]);    
                    ((jpos.ToneIndicator)(devices[10])).setTone1Duration(durations[j]);
                    ((jpos.ToneIndicator)(devices[10])).sound(1, 0);
                }
                System.out.println("");
                System.out.println("sound() = JPOS_E_SUCCESS");


            }
        }
        catch (jpos.JposException je)
        {
            System.out.println(jposError(je.getErrorCode(), je.getErrorCodeExtended()) + " received while testing device.");
            good = false;
        }


        return(good);
    }

    /**
     * Try to open, claim, and enable a device.
     */
    boolean openClaimEnable(String deviceCategory, String devNam)
    {

        int i=0;
        String errorString;
        boolean good = true;

        if (deviceCategory!=null)
        {

            if (deviceCategory.equalsIgnoreCase("CashDrawer") ) i=0;
            else if (deviceCategory.equalsIgnoreCase("HardTotals") )i=1;
            else if (deviceCategory.equalsIgnoreCase("Keylock") )i=2;
            else if (deviceCategory.equalsIgnoreCase("LineDisplay") ) i=3;
            else if (deviceCategory.equalsIgnoreCase("MICR") ) i=4;
            else if (deviceCategory.equalsIgnoreCase("MSR") ) i=5;
            else if (deviceCategory.equalsIgnoreCase("POSKeyboard") ) i=6;
            else if (deviceCategory.equalsIgnoreCase("POSPrinter") ) i=7;
            else if (deviceCategory.equalsIgnoreCase("Scale") ) i=8;
            else if (deviceCategory.equalsIgnoreCase("Scanner") ) i=9;
            else if (deviceCategory.equalsIgnoreCase("ToneIndicator") ) i=10;
        }

        // Perform open.
        if (verbose)
        {

            System.out.println("---------------------------------------------");
            System.out.print("open(" + devNam + ") = ");
        }
        errorString = "JPOS_E_SUCCESS";
        try
        {
            devices[i].open(devNam);
        }
        catch (jpos.JposException e)
        {
            errorString = jposError(e.getErrorCode(), e.getErrorCodeExtended()); 
            good = false;
        }

        // Sleep a bit.
        try
        {
            Thread.sleep(1000);
        }
        catch (Exception e)
        {
        }

        // Display status
        if (verbose)
            System.out.println(errorString);
        else
        {
            if (good)
            {
                System.out.println("---------------------------------------------" );
                System.out.println("Open " + devNam + " Successful." );

            }

            else
            {
                System.out.println("---------------------------------------------" );
                System.out.println("Open " + devNam + " Unsuccessful.");

            }

        }

        // Perform claim unless it's the Keylock device.
        if ( !(devices[i] instanceof jpos.Keylock) )
        {
            if (verbose)
            {
                System.out.print("claim(5000) = ");
            }
            errorString = "JPOS_E_SUCCESS";
            try
            {
                devices[i].claim(5000);
            }
            catch (jpos.JposException e)
            {
                errorString = jposError(e.getErrorCode(), e.getErrorCodeExtended()); 
                good = false;
            }
            if (verbose)
                System.out.println(errorString);
            else
            {
                if (good)
                    System.out.println("Claim " + devNam + " Successful.");
                else
                    System.out.println("Claim " + devNam + " Unsuccessful.");
            }
        }

        // Perform enable.
        if (verbose) System.out.print("setDeviced(true) = ");
        errorString = "JPOS_E_SUCCESS";
        try
        {
            devices[i].setDeviceEnabled(true);
        }
        catch (jpos.JposException e)
        {
            errorString = jposError(e.getErrorCode(), e.getErrorCodeExtended()); 
            good = false;
        }
        if (verbose)
            System.out.println(errorString);
        else
        {
            if (good)
                System.out.println("Enable " + devNam + " Successful.");
            else
                System.out.println("Enable " + devNam + " Unsuccessful.");
        }

        // Return how we did.
        return(good);
    }


    /**
     * Display help.
     */
    static void displayHelpAndExit()                                                                                                                                                                                                                                                                                                                                                                                                     
    {
        System.out.println("");
        System.out.println("Usage:");
        System.out.println("    JTest [-v] [-h] [DeviceLogicalName]");
        System.out.println("        -v Verbose Mode");
        System.out.println("        -h Displays Help");
        System.out.println("        DeviceLogicalName Specify one device you want to test"); 
        System.out.println("                          such as OperatorDisplay.");
        System.out.println("");
        System.out.println("JTest attempts to Open, Claim and Enable attached POS Devices.");
        System.out.println("If a logical device name is specified in the command line, then");
        System.out.println("only that specific device is tested. Multiple devices can be");
        System.out.println("tested automatically by adding a boolean property named JTEST");
        System.out.println("to a devices configuration entry and setting the value to true.");
        System.out.println("");
        System.exit(0);
    }
}

