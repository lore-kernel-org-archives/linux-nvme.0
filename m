From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 17 Oct 2012 18:55:18 -0400
Subject: IRQ allocation in nvme driver
In-Reply-To: <E821E2F372F08945977BD15EAE588D610846763F@SACMBXIP02.sdcorp.global.sandisk.com>
References: <E821E2F372F08945977BD15EAE588D61084671CE@SACMBXIP02.sdcorp.global.sandisk.com>
 <82C9F782B054C94B9FC04A331649C77A07B9195D@FMSMSX106.amr.corp.intel.com>
 <E821E2F372F08945977BD15EAE588D610846763F@SACMBXIP02.sdcorp.global.sandisk.com>
Message-ID: <20121017225518.GK4244@linux.intel.com>

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
