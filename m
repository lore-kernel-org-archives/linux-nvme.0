From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Mar 2018 10:06:46 +0200
Subject: [PATCH] nvme-multipath: implement active-active round-robin
 path selector
In-Reply-To: <20180327043851.6640-1-baegjae@gmail.com>
References: <20180327043851.6640-1-baegjae@gmail.com>
Message-ID: <20180328080646.GB20373@lst.de>

For PCIe devices the right policy is not a round robin but to use
the pcie device closer to the node.  I did a prototype for that
long ago and the concept can work.  Can you look into that and
also make that policy used automatically for PCIe devices?
