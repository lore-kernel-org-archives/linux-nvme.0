From: keith.busch@intel.com (Keith Busch)
Date: Mon, 27 Apr 2015 19:55:07 +0000 (UTC)
Subject: [PATCH 6/8] nvme: handle invalid SCSI LBAs correctly
In-Reply-To: <20150427192832.GA7802@lst.de>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
 <1429388864-29648-7-git-send-email-hch@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93BABFA56@fmsmsx104.amr.corp.intel.com>
 <20150427192832.GA7802@lst.de>
Message-ID: <alpine.LNX.2.00.1504271932250.19844@localhost.lm.intel.com>

On Mon, 27 Apr 2015, Christoph Hellwig wrote:
> On Mon, Apr 27, 2015@06:00:13PM +0000, Busch, Keith wrote:
>>> Trap LBAs behind the end of the device and return the correct
>>> sense code.
>>
>> Should the driver be responsible to catch these kinds of errors
>> on a passthrough IOCTL? Why not let the device deal with it?
>
> Because drives don't seem to report the right error code, and thus
> the translation isn't fully spec compliant.

Hm, the spec provides translations for status codes but doesn't say it
should short circuit the process. This layer is responsible for accurate
translations, so we'd fail complaince if we don't respect the controller's
completion, even if it returns the wrong code.
