From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 01:02:31 +0900
Subject: Potential bug in queue_count_set
In-Reply-To: <d945096a-14d8-6d9f-187f-39501dfdb600@gmail.com>
References: <b62dde65-1abf-1391-9de6-9bcdf6a7fa07@gmail.com>
 <d945096a-14d8-6d9f-187f-39501dfdb600@gmail.com>
Message-ID: <b0d01a14-f80c-30f2-b190-d0bbe8eb6005@gmail.com>


>>
>> It looks like lines 154, 155 don't achieve anything as `n` is not being
>> used afterwards. Sorry if this is already known or a non-issue, just
>> wanted to let you guys know.
>>
> 
> It looks like module parameter "write_queues" is set to the actual given
> value (val) without considering reduced number of queues in case given
> value is greater than nr_cpus.
> 
> I think that might need sprintf() or something like this to make the
> actual value reduced in that case.


Sorry, the "val" is const so that we cannot go through it with sprintf().
My bad.  This function might return an error if invalid number is given.

Sorry for the confusion.

Have posted patches for it.
   http://lists.infradead.org/pipermail/linux-nvme/2019-April/023369.html

Thanks,
