From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Tue, 4 Nov 2014 21:48:38 +0000
Subject: [PATCH] NVMe: Re-attach waitqueue following device reset
In-Reply-To: <alpine.LNX.2.00.1411041452350.4225@localhost.lm.intel.com>
References: <5453DE85.90407@micron.com>
 <alpine.LNX.2.00.1411041452350.4225@localhost.lm.intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A99458A207@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Keith Busch [mailto:keith.busch at intel.com]
> Sent: Tuesday, November 04, 2014 6:55 AM
> To: Sam Bradshaw (sbradshaw)
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Re-attach waitqueue following device reset
> 
> On Fri, 31 Oct 2014, Sam Bradshaw wrote:
> > Bios queued to sq_cong prior to and during a device reset may not get
> > re-issued or may get issued very slowly following the completion of
> > the reset sequence.  The waitqueue was detached as part of the
> > sequence and never re-attached, forcing all new make_request() bios
> to
> > be queued and the queue to be flushed out without the help of the
> > completion path waking the kthread.
> 
> Hi Sam,
> 
> Are you using the latest from linux-nvme tree? I could have sworn this
> bug was fixed in commit:
> 
> http://git.infradead.org/users/willy/linux-
> nvme.git/commitdiff/3559b4d2159aaae42f0fc0fa22e40312c45d4606
> 
> Please let me know if there's still a gap.

Yes, I was apparently testing against an old tree.  The commit above
fixes the problem I was observing.

I still see queued bio's getting lost if a successful device reset
is followed by a failed resume.  I'm working on a patch for that case.

-Sam
