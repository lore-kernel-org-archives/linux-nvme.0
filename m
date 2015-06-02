From: axboe@fb.com (Jens Axboe)
Date: Tue, 2 Jun 2015 13:09:07 -0600
Subject: NVMe scalability issue
In-Reply-To: <CANvN+e=se0_q+eC+KkBenM2asOSy3-9ZNveRm2YBXJ9-qVna1w@mail.gmail.com>
References: <1433199171.7699.22.camel@ssi>
 <CANvN+e=se0_q+eC+KkBenM2asOSy3-9ZNveRm2YBXJ9-qVna1w@mail.gmail.com>
Message-ID: <556DFF53.7030107@fb.com>

On 06/02/2015 01:03 PM, Andrey Kuzmin wrote:
> On Tue, Jun 2, 2015@1:52 AM, Ming Lin <mlin@kernel.org> wrote:
>> Hi list,
>>
>> I'm playing with 8 high performance NVMe devices on a 4 sockets server.
>> Each device can get 730K 4k read IOPS.
>>
>> Kernel: 4.1-rc3
>> fio test shows it doesn't scale well with 4 or more devices.
>> I wonder any possible direction to improve it.
>>
>> devices         theory          actual
>>                  IOPS(K)         IOPS(K)
>> -------         -------         -------
>> 1               733             733
>> 2               1466            1446.8
>> 3               2199            2174.5
>> 4               2932            2354.9
>> 5               3665            3024.5
>> 6               4398            3818.9
>> 7               5131            4526.3
>> 8               5864            4621.2
>>
>> And a graph here:
>> http://minggr.net/pub/20150601/nvme-scalability.jpg
>>
>>
>> With 8 devices, CPU is still 43% idle, so CPU is not the bottleneck.
>>
>> "top" data
>>
>> Tasks: 565 total,  30 running, 535 sleeping,   0 stopped,   0 zombie
>> %Cpu(s): 17.5 us, 39.2 sy,  0.0 ni, 43.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
>> KiB Mem:  52833033+total,  3103032 used, 52522732+free,    18472 buffers
>> KiB Swap:  7999484 total,        0 used,  7999484 free.  1506732 cached Mem
>>
>> "perf top" data
>>
>>     PerfTop:  124581 irqs/sec  kernel:78.6%  exact:  0.0% [4000Hz cycles],  (all, 48 CPUs)
>> -----------------------------------------------------------------------------------------
>>
>>       3.30%  [kernel]       [k] do_blockdev_direct_IO
>>       2.99%  fio            [.] get_io_u
>>       2.79%  fio            [.] axmap_isset
>
> Just a thought as well, but axmap_isset cpu usage is suspiciously
> high, given a read-only workload where it's essentially a noop.

Read or write doesn't matter, it's still marked in the random map. Both 
of them will maintain that state.

-- 
Jens Axboe
