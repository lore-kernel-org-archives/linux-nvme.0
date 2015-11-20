From: raymond.c.robles@intel.com (Robles, Raymond C)
Date: Fri, 20 Nov 2015 19:54:40 +0000
Subject: Question on NVMe SCSI Translation Ref 1.5
In-Reply-To: <20151120183206.GA11043@infradead.org>
References: <BL2PR04MB1634A1D6C773CDEC0C45D9A921A0@BL2PR04MB163.namprd04.prod.outlook.com>
 <20151120183206.GA11043@infradead.org>
Message-ID: <49158E750348AA499168FD41D889836072538066@fmsmsx117.amr.corp.intel.com>

Hi Chris/Jeff,

The SCSI to NVMe translation spec was written as part of the NVMe working group initiative to enable broad adoption of NVMe in the ecosystem. There are other OS environments besides Linux (i.e. VMware, Windows, etc.) where the NVMe driver resides within a SCSI storage stack and therefore receives native OS SCSI commands. For Linux, agreed it does not have much usage considering where the NVMe driver sites in the Linux kernel. However, the NVMe spec or translation spec was not written just for Linux. 

Thanks,
Ray

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Christoph Hellwig
Sent: Friday, November 20, 2015 11:32 AM
To: Jeffrey Lien
Cc: linux-nvme at lists.infradead.org
Subject: Re: Question on NVMe SCSI Translation Ref 1.5

Hi Jeffrey,

SG_IO is sent to a device node.  For actualy SCSI devices you'll get the LUN from sdev->lun.  For NVMe there obviously aren't any LUNs, so you'll have to come up with a tranlation.  The current Linux driver translated namespaces 1 to LUN 0 and so on.  In general sending a REPORT LUNS to a NVMe device node does not seem very useful, and I have no idea why it even was specified.  Then again the whole SCSI translation layer concept seems incredbile braindead and I think we should at least optionally remove it from the NVMe driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
