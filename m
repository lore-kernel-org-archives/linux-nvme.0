From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:05:59 +0200
Subject: [PATCH 05/10] nvme: add ANA support
In-Reply-To: <56eca832-5b3c-9ba8-c953-924f3fb7609f@grimberg.me>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-6-hch@lst.de>
 <56eca832-5b3c-9ba8-c953-924f3fb7609f@grimberg.me>
Message-ID: <20180607130559.GA13101@lst.de>

On Thu, Jun 07, 2018@03:49:20PM +0300, Sagi Grimberg wrote:
>> +		 * XXX: We should verify the controller doesn't die on during
>> +		 * the transition.  But that means we per-group timeout from
>> +		 * when we first hit the change state, so this won't be
>> +		 * entirely trivial..
>
> something is wrong with the sentence I think "that means we per-group
> timeout from when..."
>
> Not sure what you are trying to say.

Reading it again it really looks gibberish..  Hopefully we don't
need the comment any more for next time as Hannes is working on
actually implementing the ANATT timer.

>> +static void nvme_ana_work(struct work_struct *work)
>> +{
>> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
>> +
>> +	nvme_process_ana_log(ctrl, false);
>> +	nvme_kick_requeue_lists(ctrl);
>
> Won't it make sense to kick the requeue list only for namespaces that
> are involved in ana state change? Won't attempting this on all
> the namespaces might result in retry count increment for namespaces
> that are inaccessible? those retries are finite by nvme_max_retries...

It makes sense, except that we it would take a lot of effort to figure
out what namespace actually changed due to the group indirection.

What we can do more easily is to only kick it off again on live
namespaces, so I'll look into that.
