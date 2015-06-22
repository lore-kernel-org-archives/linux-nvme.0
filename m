From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Jun 2015 17:39:00 +0200
Subject: [PATCH] NVMe: Fix IO for extended metadata formats
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CBA2D95@fmsmsx104.amr.corp.intel.com>
References: <1434733650-16440-1-git-send-email-keith.busch@intel.com>
 <20150622053417.GA29813@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93CBA2D95@fmsmsx104.amr.corp.intel.com>
Message-ID: <20150622153900.GA7952@lst.de>

On Mon, Jun 22, 2015@03:17:07PM +0000, Busch, Keith wrote:
> Similar to SG_IO, we can submit arbitrary length commands using the nvme
> passthrough. It seems to work. Here's a test I did using the "nvme-cli"
> program.

Yeah, I was mostly worried about the request mapping code tripping
up on these unaligned sized.  I don't have a device that supports it
so I couldn't test it myself.

Btw, given your test below:  I had thought for a while to add unit
tests to the nvme-cli package for cases like the one you had below.

The use case would be mostly to verify the driver, less the hardware
unless the two are tangled up or the hardware specific cases are simple
enough.  I've had good succeed with the cunit based SCSI testsuite
in libiscsi, so I could come up with a skeleton for it.
