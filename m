From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Dec 2014 18:42:00 +0000 (UTC)
Subject: how to pull out "hot plug patches alone" for nvme 
In-Reply-To: <6891C2FAE3B0F342A5B80AFBDCFB579714EA49D223@BLRX7MCDC204.AMER.DELL.COM>
References: <6891C2FAE3B0F342A5B80AFBDCFB579714EA49D223@BLRX7MCDC204.AMER.DELL.COM>
Message-ID: <alpine.LNX.2.00.1412091838160.3973@localhost.lm.intel.com>

I assume you want to cherry-pick commits to a driver back-port. Just so
you know, lots of hot plug fixes didn't even come from the driver, so
you'd be missing half the picture depending on which kernel you're
targeting.

On Tue, 9 Dec 2014, Lakshmi_Narayanan_Du@Dell.com wrote:
> Hi ,
>
> Could you kindly help on the way to pull /get the commit id's of hot plug patches alone for NVMe. Or anyone can list all the hotplug related patches that has gone in .
> I could search with the commit messages but not sure, how to consolidate which are the exact list of  patches  that will make the SRSI feature alone
>
> Thanks,
> Lakshmi
>
