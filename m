From: mwilck@suse.com (Martin Wilck)
Date: Wed, 25 Jul 2018 10:27:30 +0200
Subject: [PATCH 2/5] block: genhd: add device_add_disk_with_groups
In-Reply-To: <20180725074613.GB13812@lst.de>
References: <20180725062840.94114-1-hare@suse.de>
 <20180725062840.94114-3-hare@suse.de> <20180725074613.GB13812@lst.de>
Message-ID: <4ee5b2d92f6044f87e3c369c5f456ca0a14682e3.camel@suse.com>

On Wed, 2018-07-25@09:46 +0200, Christoph Hellwig wrote:
> On Wed, Jul 25, 2018@08:28:37AM +0200, Hannes Reinecke wrote:
> > Update __device_add_disk() to take an 'groups' argument so that
> > individual drivers can register a device with additional sysfs
> > attributes.
> > This avoids race condition the driver would otherwise have if these
> > groups need to be created with sysfs_add_groups().
> > 
> > Signed-off-by: Martin Wilck <martin.wilck at suse.com>
> > Signed-off-by: Hannes Reinecke <hare at suse.com>
> 
> This should be From: Martin, shouldn't it?

I'm fine with From: Hannes here. I'll be mostly offline in the next few
weeks.

Martin

-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
