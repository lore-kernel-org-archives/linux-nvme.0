From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:25:38 +0100
Subject: [PATCH 2/8] nvme/pci: Don't poll polled queues in timeout
In-Reply-To: <20190308174313.5134-2-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-2-keith.busch@intel.com>
Message-ID: <20190311182538.GB11448@lst.de>

> Polled queues are already polled. If a timeout occurs on such a queue,
> escalate the error recovery immediately.

But don't we still need to poll them when tearing down the queues?
