From: hch@lst.de (Christoph Hellwig)
Date: Mon, 27 Apr 2015 21:28:32 +0200
Subject: [PATCH 6/8] nvme: handle invalid SCSI LBAs correctly
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93BABFA56@fmsmsx104.amr.corp.intel.com>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
 <1429388864-29648-7-git-send-email-hch@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93BABFA56@fmsmsx104.amr.corp.intel.com>
Message-ID: <20150427192832.GA7802@lst.de>

On Mon, Apr 27, 2015@06:00:13PM +0000, Busch, Keith wrote:
> > Trap LBAs behind the end of the device and return the correct
> > sense code.
> 
> Should the driver be responsible to catch these kinds of errors
> on a passthrough IOCTL? Why not let the device deal with it?

Because drives don't seem to report the right error code, and thus
the translation isn't fully spec compliant.
