From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Jun 2017 08:33:32 +0300
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <c0e5ca5d-f048-cf9c-27d6-6a2a98a48251@mellanox.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
 <e9cccad7-804a-f68b-b184-46cc5be2f01d@grimberg.me>
 <c0e5ca5d-f048-cf9c-27d6-6a2a98a48251@mellanox.com>
Message-ID: <4da1ee67-052f-a0a1-ac9c-a3cb5f39b750@grimberg.me>


>>> +static int cpu_to_queue_index(unsigned int nr_queues, const int cpu,
>>> +                  const struct cpumask *online_mask)
>>>   {
>>> -    return cpu * nr_queues / nr_cpus;
>>> +    /*
>>> +     * Non online CPU will be mapped to queue index 0.
>>> +     */
>>> +    if (!cpumask_test_cpu(cpu, online_mask))
>>> +        return 0;
>>
>> Why not map offline cpus to what they would've map to if they were
>> online?
> 
> I didn't change logic for offline cpu's.
> Should it be done in this patch ?

The patch clearly treats offline cpus differently, maps them
to queue 0.
