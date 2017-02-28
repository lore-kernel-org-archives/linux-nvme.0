From: JBauer@sjm.com (Bauer, John)
Date: Tue, 28 Feb 2017 21:37:00 +0000
Subject: NVMe nvme_queue_rq crash
In-Reply-To: <20170228211953.GA7861@localhost.localdomain>
References: <AEFEA030B02DC74F8C729339175739E672D4F97D@USC1PMSG10.ad.sjm.com>
 <20170228211953.GA7861@localhost.localdomain>
Message-ID: <AEFEA030B02DC74F8C729339175739E672D4FA3A@USC1PMSG10.ad.sjm.com>

That does make sense as I just did the uname today and a new kernel was supplied since the crash log I supplied. I was told there was still a problem with the new kernel even though crashing has stopped. I was hoping that something from this crash log could be used to determine a stable mainline version to use.

I'll gather some more information and make sure that our support cases are on the same page, thanks for the quick response.

John

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com]
Sent: Tuesday, February 28, 2017 3:20 PM
To: Bauer, John
Cc: linux-nvme at lists.infradead.org
Subject: Re: NVMe nvme_queue_rq crash

On Tue, Feb 28, 2017@09:02:32PM +0000, Bauer, John wrote:
> Version info:
>
> Linux 3.10.0-520.el7_3.bz1392923.1.x86_64 #1 SMP Wed Jan 18 16:22:09
> EST 2017 x86_64 x86_64 x86_64 GNU/Linux

The bz1392923 above is the one for tracking this issue with RH bugzilla, and this issue should be corrected in that build.

Your crash, however, says you are running 3.10.0-514.2.2.el7.x86_64, which does not have the fix.
This communication may contain information that is proprietary, confidential, or exempt from disclosure. If you are not the intended recipient, please note that any other dissemination, distribution, use or copying of this communication is strictly prohibited. Anyone who receives this message in error should notify the sender immediately by telephone or by return e-mail and delete it from his or her computer.
