From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 May 2016 00:56:32 -0700
Subject: [PATCHv2] nvme: Make CMB module parameter read-only
In-Reply-To: <1462204442-3368-1-git-send-email-jonathan.derrick@intel.com>
References: <1462204442-3368-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20160503075632.GA24350@infradead.org>

On Mon, May 02, 2016@09:54:02AM -0600, Jon Derrick wrote:
> This patch changes the use_cmb_sqes module parameter to read-only. This
> parameter allows the driver to place IO submission queues within the
> Controller Memory Buffer. The parameter is currently writable through
> sysfs at /sys/module/nvme/parameters/use_cmb_sqes.
> 
> Memory allocations for queues aren't dynamically reallocated between
> resets. For this reason, allowing the use_cmb_sqes module parameter to
> be written while the drive is loaded may be confusing because we have no
> mechanism to dynamically remap the queues.

I agree, so:

Reviewed-by: Christoph Hellwig <hch at lst.de>

But re-reviewing this again I really hate the whole idea of the user
having to chose what to do with the CMB.  Can you just add a quirk
to do the right thing for the controller(s) you care about, and work
with the NVMe TWG to have a standardized way for the controllers to
give this information to the host?
