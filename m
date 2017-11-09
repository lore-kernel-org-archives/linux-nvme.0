From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:24:50 +0100
Subject: [PATCHv3 3/5] nvme: Single AEN request
In-Reply-To: <6cdfcd03-37d2-06cb-35e7-0d5798a2a827@huawei.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-4-keith.busch@intel.com>
 <6cdfcd03-37d2-06cb-35e7-0d5798a2a827@huawei.com>
Message-ID: <20171109092450.GC17120@lst.de>

On Wed, Nov 08, 2017@09:35:39AM +0800, Guan Junxiong wrote:
> If  le16_to_cpu(status) >> 1 is NVME_SC_ABORT_REQ, the current async event request is
> aborted and there is no pending request in the queue of async event request of the target.
> Why do you choose not to submit another async event request to the target?

We're never going to send an abort for the AER, so this status code
will only happen if the controller is being torn down, in that case we
don't want to submit another one until the controller is set up again.
