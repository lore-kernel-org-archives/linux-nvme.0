From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Sep 2017 18:58:22 -0400
Subject: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170918231453.27128-10-hch@lst.de>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-10-hch@lst.de>
Message-ID: <20170920225822.GE1379@localhost.localdomain>

On Mon, Sep 18, 2017@04:14:53PM -0700, Christoph Hellwig wrote:

This is awesome! Looks great, just a minor comment:

> +	sprintf(head->disk->disk_name, "nvme/ns%d", head->instance);

Naming it 'nvme/ns<#>', kobject_set_name_vargs is going to change that
'/' into a '!', so the sysfs entry is named 'nvme!ns<#>'. Not a big
deal I suppose, but I just thought it looked odd since '!' has special
meaning in shells.

Otherwise, this is looking really solid, and test well on my single
ported NVMe. I had some trouble getting dual ported ones, but I've some
now and will run tests on those tomorrow with some failure injection.
