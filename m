From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 Jul 2015 02:19:57 -0700
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
 <CAA9_cmc2Kb=XRwPpOijT+T_1-qfPH-h7LeM0AGSP6ZOW72MjwQ@mail.gmail.com>
 <55A6D251.9050801@fb.com>
 <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>
Message-ID: <20150716091957.GA18310@infradead.org>

On Wed, Jul 15, 2015@10:28:32PM +0000, Keith Busch wrote:
> Should we make it so a driver can register with blk-integrity prior to
> calling add_disk()? The other thread on this issue sounded like that'd
> be better and removes the extra driver complexity to call blk_reread_part
> or revalidate after add_disk.
> 
> Here's a patch for that and the resulting nvme driver. It works the same
> as today if registered after add_disk(), but safe to call prior. If
> called prior, add_disk() handles the queue and backing info settings
> for integrity, and adds the kobj.

This looks sensible to me as a quick fix for the issue.

In the lng run I'd prefer to just pass the integrity template
to add_disk (or rather an add_disk_integrity helper, for which
add_disk becomes a wrapper).

Also the way struct blk_integrity is used is a bit of a mess,
instead of passing it and then copying into a newly allocated
copy of it I'd rather move the kobj to struct gendisk and then
just have a pointer to the original template in struct gendisk.
