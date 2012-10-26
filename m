From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Fri, 26 Oct 2012 17:23:05 +0000
Subject: nvme driver for 32 bit kernel
In-Reply-To: <E821E2F372F08945977BD15EAE588D6108468037@SACMBXIP02.sdcorp.global.sandisk.com>
References: <E821E2F372F08945977BD15EAE588D6108467AAD@SACMBXIP02.sdcorp.global.sandisk.com>
 <20121019184956.GN4244@linux.intel.com>
 <E821E2F372F08945977BD15EAE588D6108468037@SACMBXIP02.sdcorp.global.sandisk.com>
Message-ID: <E821E2F372F08945977BD15EAE588D6108469E7D@SACMBXIP02.sdcorp.global.sandisk.com>

Should we include the header file <asm-generic/io-64-nonatomic-lo-hi.h> in the nvme.c version from the nvme git repository or something else is planned to compile the git version in 32 bit?

Thanks,
Chayan Biswas

-----Original Message-----
From: linux-nvme-bounces@lists.infradead.org [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Chayan Biswas
Sent: Friday, October 19, 2012 3:27 PM
To: Matthew Wilcox
Cc: linux-nvme at lists.infradead.org
Subject: RE: nvme driver for 32 bit kernel

Sorry, I was referring to the nvme git version. 

We downloaded the nvme git version and in the nvme.c, the header file <asm-generic/io-64-nonatomic-lo-hi.h> was not included, which was there in the latest kernel version. 

Thanks,
Chayan

-----Original Message-----
From: Matthew Wilcox [mailto:willy@linux.intel.com] 
Sent: Friday, October 19, 2012 11:50 AM
To: Chayan Biswas
Cc: linux-nvme at lists.infradead.org
Subject: Re: nvme driver for 32 bit kernel

On Fri, Oct 19, 2012@12:26:46AM +0000, Chayan Biswas wrote:
> The current driver does not compile in 32 bit kernel. What is the plan to support 32 bit compilation?

What 'current driver' are you referring to?  The one merged in the Linux
kernel absolutely does compile for 32-bit.

> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

Your legal/IT department needs to figure out how to turn this off when
you're posting to public mailing lists.  It's worse than useless; it
may actually be legally harmful.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
