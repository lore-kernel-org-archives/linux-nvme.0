From: Jeff.Lien@hgst.com (Jeffrey Lien)
Date: Fri, 20 Nov 2015 18:02:28 +0000
Subject: Question on NVMe SCSI Translation Ref 1.5
Message-ID: <BL2PR04MB1634A1D6C773CDEC0C45D9A921A0@BL2PR04MB163.namprd04.prod.outlook.com>

In the SCSI Translation Ref 1.5 spec, section 4.5 Reports LUNs, the actions for the different Select Report fields are defined.   For value 11h, it describes what should be done when the LUN addressed in the command is for LUN 0 vs not.  My question is how do we know which LUN is being addressed?   I didn't see anything in the CDB or the sg_io_hdr that specified  a LUN.   Does anyone know how to clarify this?   

Jeff Lien

Jeff.Lien at hgst.com
507 322-2416/23-2416
3605 Hwy 52 N.  
Rochester, MN 55901
