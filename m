From: keith.busch@intel.com (Keith Busch)
Date: Tue, 28 Feb 2017 16:19:54 -0500
Subject: NVMe nvme_queue_rq crash
In-Reply-To: <AEFEA030B02DC74F8C729339175739E672D4F97D@USC1PMSG10.ad.sjm.com>
References: <AEFEA030B02DC74F8C729339175739E672D4F97D@USC1PMSG10.ad.sjm.com>
Message-ID: <20170228211953.GA7861@localhost.localdomain>

On Tue, Feb 28, 2017@09:02:32PM +0000, Bauer, John wrote:
> Version info:
> 
> Linux 3.10.0-520.el7_3.bz1392923.1.x86_64 #1 SMP Wed Jan 18 16:22:09 EST 2017 x86_64 x86_64 x86_64 GNU/Linux

The bz1392923 above is the one for tracking this issue with RH bugzilla,
and this issue should be corrected in that build.

Your crash, however, says you are running 3.10.0-514.2.2.el7.x86_64,
which does not have the fix.
