From: sbauer@eng.utah.edu (Scott Bauer)
Date: Tue, 20 Dec 2016 09:05:32 -0700
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161220154639.GA16393@infradead.org>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
 <20161219222311.GA2056@sbauer-Z170X-UD5>
 <20161220061744.GB4765@infradead.org>
 <20161220154916.GC10634@localhost.localdomain>
 <20161220154639.GA16393@infradead.org>
Message-ID: <aa3b337c-deeb-057d-1054-1443a43dbae4@eng.utah.edu>



On 12/20/2016 08:46 AM, Christoph Hellwig wrote:
> On Tue, Dec 20, 2016@10:49:16AM -0500, Keith Busch wrote:
>> On Mon, Dec 19, 2016@10:17:44PM -0800, Christoph Hellwig wrote:
>>> As far as I can tell Security Send / Receive has always been intended to
>>> apply to the whole controller, even if that's something I would not
>>> personally think is a good idea.
>>
>> NVMe security commands required the namespace ID since the very
>> beginning. It's currently documented in figure 42 of section 5,
>> "Namespace Identifier Used" column.
> 
> Oh, for some reason I read a no there when looking it up.
> Good to know, although TCG spec still seem to ignore it.

Thanks Keith. Although TCG Spec currently ignores it in the future it may not.
In that case we should probably attempt to future proof it a bit. Since the
namespace ID is accessible via the block device structure I'll find a way to
include that in some opaque pointer that we can deliver through the core into
NVMe.

But this also brings up another question (and part of the reason I moved from
the block ioctl to fs ioctl): For drives with multiple namsepaces is it 
acceptable to allow a namespace, who has a segregated chunk of space, the ability
to perform actions outside of its range? Since the multiple namespaces portion
of the spec says there will be one Global LR a namespace that doesn't encompass
the entire LBA range can end up locking other LBAs via locking the global.

That's why I wanted to go to char dev because it seemed like a better fit for 
this scenario. Any thoughts on the above?



> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
