From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Thu, 18 Oct 2012 21:21:36 +0000
Subject: IRQ allocation in nvme driver
In-Reply-To: <20121017225518.GK4244@linux.intel.com>
References: <E821E2F372F08945977BD15EAE588D61084671CE@SACMBXIP02.sdcorp.global.sandisk.com>
 <82C9F782B054C94B9FC04A331649C77A07B9195D@FMSMSX106.amr.corp.intel.com>
 <E821E2F372F08945977BD15EAE588D610846763F@SACMBXIP02.sdcorp.global.sandisk.com>
 <20121017225518.GK4244@linux.intel.com>
Message-ID: <E821E2F372F08945977BD15EAE588D61084679EF@SACMBXIP02.sdcorp.global.sandisk.com>

Oh, that answers my first question - it is not a bug, it is a clever way of using Linux functionality to achieve the same approach used in Windows driver.

Thanks,
Chayan

-----Original Message-----
From: Matthew Wilcox [mailto:willy@linux.intel.com]
Sent: Wednesday, October 17, 2012 3:55 PM
To: Chayan Biswas
Cc: linux-nvme at lists.infradead.org
Subject: Re: IRQ allocation in nvme driver

On Wed, Oct 17, 2012@10:40:34PM +0000, Chayan Biswas wrote:
> Yes, that is a better approach.
>
> However, in the current Linux driver, the NVME queue pointer is passed in the IRQ handler and hence it will require lot more code to choose the correct NVME queue pointer for MSIX 0 handler. Hence I chose the easier approach of allocating an additional MSIX without changing a lot of tested code.

Huh?  The Linux NVMe driver requests vector 0 twice; once for the
admin queue and once for the first I/O queue.  The interrupt handler
is called twice on every interrupt; once with the admin queue as the
pointer and once with the I/O queue as the pointer.  This uses the
existing functionality in the Linux IRQ system rather than duplicating
it in the driver.  I bet you can't measure the difference in performance
between I/O on queue 1 and I/O on queue 2.

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
