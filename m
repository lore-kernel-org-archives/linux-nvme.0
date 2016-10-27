From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Oct 2016 14:30:27 +0200
Subject: [PATCH 1/2] nvme: introduce struct nvme_request
In-Reply-To: <5293ea38-f0ee-f0a0-9469-537444aab0db@grimberg.me>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
 <1477411779-2993-2-git-send-email-hch@lst.de>
 <5293ea38-f0ee-f0a0-9469-537444aab0db@grimberg.me>
Message-ID: <20161027123027.GB12867@lst.de>

On Thu, Oct 27, 2016@12:24:24PM +0300, Sagi Grimberg wrote:
>> +struct nvme_request {
>> +	struct nvme_command	*cmd;
>> +	union nvme_result	result;
>> +};
>
> I sorta agree with James, can we not enforce a "hidden assumption"
> of the core on how the transport drivers structures are built?

We have to, as this is the structure passed between the core and the
the drivers. 

>> +static inline struct nvme_request *nvme_req(struct request *req)
>> +{
>> +	return blk_mq_rq_to_pdu(req);
>> +}
>
> Maybe this can be a ctrl->ops->nvme_req() instead?

Why add indirections if we can avoid it?  Especially if we're ever
going to use the passthrough in a performance path (e.g. the target)
these indirect calls just to get an address will hurt us.

And it's not like requiring a common structure at the beginning is
unusual - this is how every Linux fs treats the inode structure.
