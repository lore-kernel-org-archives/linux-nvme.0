From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 May 2019 16:37:41 +0200
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <20190513143741.GA25500@lst.de>

On Mon, May 13, 2019@02:24:41PM +0000, Mario.Limonciello@dell.com wrote:
> I've received the result that from one of my partners this patch doesn't
> work properly and the platform doesn't go into a lower power state.

Well, it sounds like your partners device does not work properly in this
case.  There is nothing in the NVMe spec that says queues should be
torn down for deep power states, and that whole idea seems rather
counter productive to low-latency suspend/resume cycles.

> This was not a disk with HMB, but with regard to the HMB I believe it
> needs to be removed during s0ix so that there isn't any mistake that SSD
> thinks it can access HMB memory in s0ix.

There is no mistake - the device is allowed to use the HMB from the
point that we give it the memory range until the point where we either
disable it, or shut the controller down.  If something else requires the
device not to use the HMB after ->suspend is called we need to disable
the HMB, and we better have a good reason for that and document it in
the code.  Note that shutting down queues or having CPU memory barriers
is not going to help with any of that.
