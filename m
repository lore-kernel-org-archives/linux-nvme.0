From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Mon, 5 Jun 2017 13:39:40 +0200 (CEST)
Subject: [PATCH] nvme-rdma: remove race conditions from IB signalling
In-Reply-To: <97a72992-3ac3-74d9-96dc-22c31bbb6694@grimberg.me>
References: <1785464880.73761005.1496655938570.JavaMail.zimbra@kalray.eu>
 <97a72992-3ac3-74d9-96dc-22c31bbb6694@grimberg.me>
Message-ID: <398638390.74484157.1496662780144.JavaMail.zimbra@kalray.eu>


>> -static inline int nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
>> +static inline int nvme_rdma_init_sig_count(int queue_size)
>>   {
>> -       int sig_limit;
>> -
>> -       /*
>> -        * We signal completion every queue depth/2 and also handle the
>> -        * degenerated case of a  device with queue_depth=1, where we
>> -        * would need to signal every message.
>> +       /* We want to signal completion at least every queue depth/2.
>> +        * This returns the largest power of two that is not above half
>> +        * of (queue size + 1) to optimize (avoid divisions).
>>           */
>> -       sig_limit = max(queue->queue_size / 2, 1);
>> -       return (++queue->sig_count % sig_limit) == 0;
>> +       return 1 << ilog2((queue_size + 1) / 2);
>> +}
>> +
>> +static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
>> +{
>> +       int count, limit;
>> +
>> +       limit = nvme_rdma_init_sig_count(queue->queue_size);
> 
> Why calling it init? you're not initializing anything...
> 
> I'd just call it nvme_rdma_sig_limit()
> 
>> +       count = atomic_inc_return(&queue->sig_count);
>> +
>> +       /* Signal if count is a multiple of limit */
>> +       if ((count & (limit - 1)) == 0)
>> +               return true;
>> +       return false;
>>   }
> 
> You can replace it with:
>	return (atomic_inc_return(&queue->sig_count) & (limit - 1)) == 0;
> 
> And lose the local count variable.

The init part is a leftover from one of the previous versions and we do not need
the value anywhere else. As the sig_limit() function is quite short now it I can
also put the ilog part + comments in the same place too. Wouldn't it be easier
to read?

Marta
