From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 Jan 2018 08:05:14 +0100
Subject: [PATCH 2/3] nvme: Asynchronous driver commands API
In-Reply-To: <20180129235949.26267-2-keith.busch@intel.com>
References: <20180129235949.26267-1-keith.busch@intel.com>
 <20180129235949.26267-2-keith.busch@intel.com>
Message-ID: <20180130070514.GA12196@lst.de>

As pointed our by Roland we'll need to make sure req->cmd is allocated
dynamically for async commands.  I suspect the best way to handle that
is to turn it into an actual embedded structure instead of a pointer.
