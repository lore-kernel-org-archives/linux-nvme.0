From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 08:53:26 +0200
Subject: [PATCH 3/5] aoe: use device_add_disk_with_groups()
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-4-hare@suse.de>
Message-ID: <20180817065326.GB11170@lst.de>

On Tue, Aug 14, 2018@09:33:03AM +0200, Hannes Reinecke wrote:
> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.

The desxription and the subject line need an update now that
device_add_disk_with_groups is no more.
