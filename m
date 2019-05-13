From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Mon, 13 May 2019 14:24:41 +0000
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>

> > Cc: Mario Limonciello <Mario.Limonciello at dell.com>
> > Cc: Kai Heng Feng <kai.heng.feng at canonical.com>
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> > ---
> > Disclaimer: I've tested only on emulation faking support for the feature.
> 
> Thanks for sharing.  I'll arrange some testing with this with storage partners early
> next week.
> 

I've received the result that from one of my partners this patch doesn't work properly
and the platform doesn't go into a lower power state.  (The patch submitted by KH/me
did work on said system to get it into a lower power state for them).

This was not a disk with HMB, but with regard to the HMB I believe it needs to be
removed during s0ix so that there isn't any mistake that SSD thinks it can access HMB
memory in s0ix.
