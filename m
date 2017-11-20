From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Nov 2017 10:32:05 +0100
Subject: [PATCH v2 1/3] nvme-rdma: don't suppress send completions
In-Reply-To: <4ac0bc2e-498b-0fc1-4e30-7ff76bd036f1@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-2-sagi@grimberg.me> <20171109091858.GA16966@lst.de>
 <921c4331-9456-3783-423a-9c5c5e405131@grimberg.me>
 <20171120081809.GB27552@lst.de>
 <4ac0bc2e-498b-0fc1-4e30-7ff76bd036f1@grimberg.me>
Message-ID: <20171120093205.GB29719@lst.de>

On Mon, Nov 20, 2017@10:33:02AM +0200, Sagi Grimberg wrote:
>> I don't really like having a special case just for this slow path
>> special case.  So if we can avoid it without too much overhead let's
>> do it, otherwise we can keep it as-is.
>
> Saving the state of the request completions adds complication in
> general, and we don't even have a request for AENs so it would mean to
> keep it under the queue, and we don't really race anything because we
> don't have inline data there. So I think its simpler to keep it as is.

Ok, let's keep it.  But please add a comment explaining why the
non-signalled completions are fine for the AER but no one else.
