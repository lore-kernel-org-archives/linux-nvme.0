From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Wed, 29 Mar 2017 11:36:40 +0200 (CEST)
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <20170323140042.GA30536@lst.de>
 <277345557.313693033.1490279818647.JavaMail.zimbra@kalray.eu>
 <4951fac6-662f-29a6-5ba5-38d37a2c2dca@grimberg.me>
 <1180136633.325075447.1490700022740.JavaMail.zimbra@kalray.eu>
 <8dc0414f-be90-ee30-0f66-8cee26c4c2aa@grimberg.me>
Message-ID: <1606981439.330477492.1490780200808.JavaMail.zimbra@kalray.eu>

>>> Maybe it'll be better if we do:
>>>
>>> static inline bool queue_sig_limit(struct nvme_rdma_queue *queue)
>>> {
>>> 	return (++queue->sig_count % (queue->queue_size / 2)) == 0;
>>> }
>>>
>>> And lose the hard-coded 32 entirely. Care to test that?
>>
>> Hello Sigi,
>> I agree with you, we've found a setup where the signalling every queue
>> depth is not enough and we're testing the division by two that seems
>> to work fine till now.
>>
>> In your version in case of queue length > 32 the notifications would
>> be sent less often that they are now. I'm wondering if it will have
>> impact on performance and internal card buffering (it seems that
>> Mellanox buffers are ~100 elements). Wouldn't it create issues?
>>
>> I'd like see the magic constant removed. From what I can see we
>> need to have something not exceeding send buffer of the card but
>> also not lower than the queue depth. What do you think?
> 
> I'm not sure what buffering is needed from the device at all in this
> case, the device is simply expected to avoid signaling completions.
> 
> Mellanox folks, any idea where is this limitation coming from?
> Do we need a device capability for it?

In the case of mlx5 the we're getting -ENOMEM from begin_wqe
(condition on mlx5_wq_overflow). This queue is sized in the driver
based on multiple factors. If we ack less often, this could
happen for higher queue depths too, I think.

Marta
