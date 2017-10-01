From: hch@lst.de (Christoph Hellwig)
Date: Sun, 1 Oct 2017 10:00:03 +0200
Subject: [PATCH 1/2] block: genhd: add device_add_disk_with_groups
In-Reply-To: <20170928193637.24707-1-mwilck@suse.com>
References: <20170928193637.24707-1-mwilck@suse.com>
Message-ID: <20171001080003.GD11554@lst.de>

While this looks okay-ish to me I really don't want people confused
with three variants of add_disk, we really need to consolidate
our helpers there a bit..
