From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 Jan 2019 19:35:35 +0100
Subject: [PATCH 1/1] nvme-pci: check that sqid match in nvme cqe
In-Reply-To: <20190109183521.GA21992@lst.de>
References: <1546349838-5126-1-git-send-email-maxg@mellanox.com>
 <20190104181336.GA25593@lst.de>
 <d45e8fe6-5c58-f8f5-5b74-3e261222e089@mellanox.com>
 <20190109183521.GA21992@lst.de>
Message-ID: <20190109183535.GA22051@lst.de>

On Wed, Jan 09, 2019@07:35:21PM +0100, Christoph Hellwig wrote:
> Yes, but hardware that gets this wrong will just blow up and timeout
> anyway.  I'm not sure this case is worth adding a special detetion
> in the slow path.

s/slow/fast/
