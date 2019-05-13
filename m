From: kbusch@kernel.org (Keith Busch)
Date: Mon, 13 May 2019 09:04:58 -0600
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
 <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain>
 <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <20190513150458.GA15437@localhost.localdomain>

On Mon, May 13, 2019@03:05:42PM +0000, Mario.Limonciello@dell.com wrote:
> This system power state - suspend to idle is going to freeze threads.
> But we're talking a multi threaded kernel.  Can't there be a timing problem going
> on then too?  With a disk flush being active in one task and the other task trying
> to put the disk into the deepest power state.  If you don't freeze the queues how
> can you guarantee that didn't happen?

But if an active data flush task is running, then we're not idle and
shouldn't go to low power.
