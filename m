From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Nov 2015 10:32:06 -0800
Subject: Question on NVMe SCSI Translation Ref 1.5
In-Reply-To: <BL2PR04MB1634A1D6C773CDEC0C45D9A921A0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB1634A1D6C773CDEC0C45D9A921A0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <20151120183206.GA11043@infradead.org>

Hi Jeffrey,

SG_IO is sent to a device node.  For actualy SCSI devices you'll
get the LUN from sdev->lun.  For NVMe there obviously aren't any LUNs,
so you'll have to come up with a tranlation.  The current Linux driver
translated namespaces 1 to LUN 0 and so on.  In general sending a
REPORT LUNS to a NVMe device node does not seem very useful, and I have
no idea why it even was specified.  Then again the whole SCSI
translation layer concept seems incredbile braindead and I think we
should at least optionally remove it from the NVMe driver.
