From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 27 Apr 2015 18:00:13 +0000
Subject: [PATCH 6/8] nvme: handle invalid SCSI LBAs correctly
In-Reply-To: <1429388864-29648-7-git-send-email-hch@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
 <1429388864-29648-7-git-send-email-hch@lst.de>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93BABFA56@fmsmsx104.amr.corp.intel.com>

> Trap LBAs behind the end of the device and return the correct
> sense code.

Should the driver be responsible to catch these kinds of errors
on a passthrough IOCTL? Why not let the device deal with it?

Yeah, I have a drive with accessible LBAs outside the reported
capacity (queue the criticism). I wouldn't use the SCSI
translation layer for that device anyway, so this isn't a NAK.

I'm all for the rest of the series; looks good to me!
