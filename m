From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 13 Aug 2017 04:53:59 -0700
Subject: nvmet panics during high load
In-Reply-To: <ee61dc25-bb67-8466-6cc9-d20b4ff0104f@grimberg.me>
References: <CAF9HSikTcqojqWOx7cjBsv9fLCvbkU_f6-1CgQ16Wpb1f5oQ4g@mail.gmail.com>
 <ee61dc25-bb67-8466-6cc9-d20b4ff0104f@grimberg.me>
Message-ID: <4d0b76b9-4358-6043-4eba-9d5504ce3a1e@grimberg.me>


>> Hi All,
> 
> Hey Alon,
> 
>> This is my first post on this mailing list. Let me know if this is the
>> wrong place or format to post bugs in.
> 
> This is the correct place.
> 
>> We're running nvmef using RDMA on kernel 4.11.8.
>> We found a zero-dereference bug in nvmet during high load and
>> identified the root cause:
>> The location according to current linux master (fd2b2c57) is
>> drivers/nvme/target/rdma.c at function nvmet_rdma_get_rsp line 170.
>> list_first_entry is called on the list of free responses (free_rsps)
>> which is empty and obviously unexpected. I added an assert to validate
>> that and also tested a hack that enlarges the queue times 10 and it
>> seemed to solve it.
>> It's probably not a leak but a miscalculation of the size of the queue
>> (queue->recv_queue_size * 2). Can anyone explain the rationale behind
>> this calculation? Is the queue assumed to never be empty?
> 
> Well, you are correct that the code assumes that it always has a free
> rsp to use, and yes, its a wrong assumptions. The reason is that
> rsps are freed upon the send completion of a nvme command (cqe).
> 
> If for example one or more acks from the host on this send were dropped
> (which can very well happen on a high load switched fabric environment),
> then we might end up needing more resources than we originally thought.
> 
> Does your cluster involve one or more switches cascade? That would
> explain how we're getting there.
> 
> We use heuristics of 2x the queue_size so that we can't pipeline
> queue-depth and also have a queue-depth to spare as completions might
> take time.
> 
> I think that allocating 10x is an overkill, but maybe something that
> grows lazily can fit better (not sure if we want to shrink as well).
> 
> Can you tryout this (untested) patch:

Alon, did you happen to test this?
