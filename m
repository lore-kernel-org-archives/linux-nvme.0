From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 Mar 2017 14:09:47 +0300
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <277345557.313693033.1490279818647.JavaMail.zimbra@kalray.eu>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <20170323140042.GA30536@lst.de>
 <277345557.313693033.1490279818647.JavaMail.zimbra@kalray.eu>
Message-ID: <4951fac6-662f-29a6-5ba5-38d37a2c2dca@grimberg.me>


>> Thanks, this looks useful.  But wouldn't it be better to do something
>> like queue_size divided by 2 or 4 to get a better refill latency?
>
> That's an interesting question. The max number of requests is already at 3 or 4 times
> of the queue size because of different message types (see Sam's original
> message in 'NVMe RDMA driver: CX4 send queue fills up when nvme queue depth is low').
> I guess it would have inflence on configs with bigger latency.
>
> I would like to have Sagi's view on this as he's the one who has changed that
> part in the iSER initiator in 6df5a128f0fde6315a44e80b30412997147f5efd

Hi Marta,

This looks good indeed. IIRC both for IB and iWARP we need to signal
at least once every send-queue depth (in practice I remember that some
devices need more than once) so maybe it'll be good to have division by
2.

Maybe it'll be better if we do:

static inline bool queue_sig_limit(struct nvme_rdma_queue *queue)
{
	return (++queue->sig_count % (queue->queue_size / 2)) == 0;
}

And lose the hard-coded 32 entirely. Care to test that?
