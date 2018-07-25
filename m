From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jul 2018 09:45:12 +0200
Subject: [PATCH 1/5] genhd: drop 'bool' argument from __device_add_disk()
In-Reply-To: <20180725062840.94114-2-hare@suse.de>
References: <20180725062840.94114-1-hare@suse.de>
 <20180725062840.94114-2-hare@suse.de>
Message-ID: <20180725074512.GA13812@lst.de>

> +void __device_get_disk(struct gendisk *disk)

This function can be static. Also it is a bit misnamed.  I'm not
really sure this split is worth it, but if we really want to kill
off the argument it might be worth to just open code the new
__device_get_disk in both callers.
