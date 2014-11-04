From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 4 Nov 2014 23:25:45 +0000
Subject: [PATCH] NVMe: Re-attach waitqueue following device reset
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A99458A207@NTXBOIMBX02.micron.com>
References: <5453DE85.90407@micron.com>
 <alpine.LNX.2.00.1411041452350.4225@localhost.lm.intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A99458A207@NTXBOIMBX02.micron.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93B08D540@fmsmsx104.amr.corp.intel.com>

> I still see queued bio's getting lost if a successful device reset
> is followed by a failed resume.  I'm working on a patch for that case.

Oh, that doesn't sound good. If the device fails to resume, the driver requests the pci layer remove it. That then calls the driver's .remove which clears the bio lists after the queue is freed.

This sequence may deadlock when bios are queued if you don't have this commit:

http://git.infradead.org/users/willy/linux-nvme.git/commitdiff/74bae7e0dd70f3eee05d577d3d25fbcd54af4228

But if you do have that commit, then something else is amiss.
