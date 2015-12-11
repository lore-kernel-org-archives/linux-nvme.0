From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 11 Dec 2015 13:25:46 -0700
Subject: [PATCH] nvme: Allow controllers to specify a min queue depth for
 CMB
In-Reply-To: <20151211200653.GA26595@lst.de>
References: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>
 <20151211200653.GA26595@lst.de>
Message-ID: <20151211202546.GA4116@localhost.localdomain>

Hi Christoph,

>  - please don't overload the quirks bitmap with actual values
I agree it may not have been the best place for it, but I wasn't sure how/where it could go to be matched with specific devices. Certain devices may want 8, 16, or 32.

>  - why do we even need to set a size instead of using up the CMB
>    size?
Consider a device with 32kB allocated for CMB. The SQes alignment restriction (detailed below) requires us to align to the controller page size. If we consider an example of 4kB pages, that gives us 8 SQes in the CMB, each with 64 entries (assuming 64B-sized sq entries).

Or instead, we could have 32 queues, each with 1K alignment, and 16 entries (assuming the device is fast enough).

>  - why do we even need to add a quirk?  I quick look at the spec
>    doesn't seem to require us to align the submission queue size
>  - this patchs adds a quirk, but no use of it so it's effectively just dead
>    code
It is not that apparent. It inherits the restriction on the Create I/O Submission Queue command (NVM-Express 1.2a, 5.4, Figure 54).
