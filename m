From: hch@infradead.org ('Christoph Hellwig')
Date: Sat, 21 Nov 2015 00:18:04 -0800
Subject: Question on NVMe SCSI Translation Ref 1.5
In-Reply-To: <49158E750348AA499168FD41D889836072538066@fmsmsx117.amr.corp.intel.com>
References: <BL2PR04MB1634A1D6C773CDEC0C45D9A921A0@BL2PR04MB163.namprd04.prod.outlook.com>
 <20151120183206.GA11043@infradead.org>
 <49158E750348AA499168FD41D889836072538066@fmsmsx117.amr.corp.intel.com>
Message-ID: <20151121081804.GA16229@infradead.org>

Hi Raymond,

I'm not complaining about the spec - I think it's clearly useful
as a reference.  For example it allows my pNFS SCSI layout spec to be
used with NVMe by providing a reference mapping, even if we never even
send SCSI commands in that case.  I just think the implementing it in
the Linux kernel is useless as we provide a rich block I/O abstraction.
