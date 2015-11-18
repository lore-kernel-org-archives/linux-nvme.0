From: Jeff.Lien@hgst.com (Jeffrey Lien)
Date: Wed, 18 Nov 2015 19:21:49 +0000
Subject: FW: [PATCH] NVMe: Correct casting in GET_U32_FROM_CDB to eliminate
 negative values
Message-ID: <BL2PR04MB16312935B46C389B335CD56921C0@BL2PR04MB163.namprd04.prod.outlook.com>



-----Original Message-----
From: Jeffrey Lien 
Sent: Wednesday, November 18, 2015 1:20 PM
To: Keith Busch <keith.busch at intel.com>; 'llinux-nvme at lists.infradead.org' <llinux-nvme at lists.infradead.org>
Cc: David Darrington <david.darrington at hgst.com>
Subject: [PATCH] NVMe: Correct casting in GET_U32_FROM_CDB to eliminate negative values

Attached a patch for the nvme legacy tree.? 

Jeff Lien

Jeff.Lien at hgst.com
507 322-2416/23-2416
3605 Hwy 52 N.? 
Rochester, MN 55901

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-NVMe-Correct-casting-in-GET_U32_FROM_CDB-to-eliminat.patch
Type: application/octet-stream
Size: 1641 bytes
Desc: 0001-NVMe-Correct-casting-in-GET_U32_FROM_CDB-to-eliminat.patch
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151118/05265076/attachment.obj>
