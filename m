From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Dec 2016 01:42:38 -0800
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <20161220215509.GA2462@sbauer-Z170X-UD5>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
 <20161220072847.GA11946@infradead.org>
 <20161220215509.GA2462@sbauer-Z170X-UD5>
Message-ID: <20161221094238.GC32084@infradead.org>

On Tue, Dec 20, 2016@02:55:10PM -0700, Scott Bauer wrote:
> Do you mean from nvme_ioctl? or from blk_ioctl? It was removed from  blk_ioctl
> because I must have misinterpreted your comments here:
> http://lists.infradead.org/pipermail/linux-nvme/2016-December/007364.html

nvme_ioctl, aka the ioctl method of the block driver.  In the future
I expect another caller in scsi_ioctl or sd_ioctl.

> I took your hesitation about the block_device to mean try something new,
> that combined with my concern about having namespaces have the ability to
> lock the global range which can span ourside their LBA ranges lead me to
> remove it from block and put it in the char dev world.

In the link I literally meant the struct block_device, not nessecarily
the block device node.

> 
> On the same note there is a public review of
> TCG Storage Opal SSC Feature Set: Configurable Namespace Locking:
> Which Jon Derrick found for us:
> https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Feature_Set_Namespaces_phase_1b_v1_00_r1_19_public-review.pdf
> 
> Where they are thinking about doing a complete 180 from:
> https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_05_Revision_1_00.pdf
> 
> And now Namespaces can have their own global locking range as well as locking
> objects within them. 

Interesting.  From a quick look this is how it should have been done
from the start.  Now the big question is when devices are going to
implement it, and how we can support both from the same driver, as this
means we'll have to deal with two different ways to allocate the
security context based on the device.  And do the horrible mess that the
TCG SIISs are there is absolute no way to discover this at the NVMe
level, but we actually need to start doing TCG method calls to even
figure out what's going on.
