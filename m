From: keith.busch@intel.com (Keith Busch)
Date: Thu, 9 Nov 2017 09:04:11 -0700
Subject: [PATCHv3 3/5] nvme: Single AEN request
In-Reply-To: <20171109092450.GC17120@lst.de>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-4-keith.busch@intel.com>
 <6cdfcd03-37d2-06cb-35e7-0d5798a2a827@huawei.com>
 <20171109092450.GC17120@lst.de>
Message-ID: <20171109160410.GD25017@localhost.localdomain>

On Thu, Nov 09, 2017@10:24:50AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 08, 2017@09:35:39AM +0800, Guan Junxiong wrote:
> > If  le16_to_cpu(status) >> 1 is NVME_SC_ABORT_REQ, the current async event request is
> > aborted and there is no pending request in the queue of async event request of the target.
> > Why do you choose not to submit another async event request to the target?
> 
> We're never going to send an abort for the AER, so this status code
> will only happen if the controller is being torn down, in that case we
> don't want to submit another one until the controller is set up again.

Yeah, reclaiming the AER count on abort was a trick for controller resets
when we were tracking those requests. Back then, every reset you'd see
at least one "Cancelling I/O QID 0" message for AER commands. We've had
a better way to handle this wor a while now, so that was left-over
dead code.
