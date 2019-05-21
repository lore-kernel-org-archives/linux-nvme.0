From: hch@lst.de (Christoph Hellwig)
Date: Tue, 21 May 2019 08:52:42 +0200
Subject: [PATCH] nvme-multipath: handle ANA log parse failures gracefully
In-Reply-To: <20190517112912.47055-1-hare@suse.de>
References: <20190517112912.47055-1-hare@suse.de>
Message-ID: <20190521065242.GF30402@lst.de>

On Fri, May 17, 2019@01:29:12PM +0200, Hannes Reinecke wrote:
> When we're failing to parse the ANA log the ana log buffer will
> not be allocated, causing a crash in nvme_mpath_add_disk().

How can we even reach nvme_mpath_add_disk?  If we fail to allocate the
buffer we error out in nvme_mpath_init, which leads to an error return
from nvme_init_identify, which should eventually lead to a probe
failure.
