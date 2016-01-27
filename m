From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 27 Jan 2016 10:51:04 -0700
Subject: dm-multipath low performance with blk-mq
In-Reply-To: <20160127174828.GA31802@redhat.com>
References: <569E11EA.8000305@dev.mellanox.co.il>
 <20160119224512.GA10515@redhat.com> <20160125214016.GA10060@redhat.com>
 <20160125233717.GQ24960@octiron.msp.redhat.com>
 <20160126132939.GA23967@redhat.com> <56A8A6A8.9090003@dev.mellanox.co.il>
 <20160127174828.GA31802@redhat.com>
Message-ID: <56A90388.1030105@kernel.dk>

On 01/27/2016 10:48 AM, Mike Snitzer wrote:
> On Wed, Jan 27 2016 at  6:14am -0500,
> Sagi Grimberg <sagig@dev.mellanox.co.il> wrote:
>
>>
>>>> I don't think this is going to help __multipath_map() without some
>>>> configuration changes.  Now that we're running on already merged
>>>> requests instead of bios, the m->repeat_count is almost always set to 1,
>>>> so we call the path_selector every time, which means that we'll always
>>>> need the write lock. Bumping up the number of IOs we send before calling
>>>> the path selector again will give this patch a change to do some good
>>>> here.
>>>>
>>>> To do that you need to set:
>>>>
>>>> 	rr_min_io_rq <something_bigger_than_one>
>>>>
>>>> in the defaults section of /etc/multipath.conf and then reload the
>>>> multipathd service.
>>>>
>>>> The patch should hopefully help in multipath_busy() regardless of the
>>>> the rr_min_io_rq setting.
>>>
>>> This patch, while generic, is meant to help the blk-mq case.  A blk-mq
>>> request_queue doesn't have an elevator so the requests will not have
>>> seen merging.
>>>
>>> But yes, implied in the patch is the requirement to increase
>>> m->repeat_count via multipathd's rr_min_io_rq (I'll backfill a proper
>>> header once it is tested).
>>
>> I'll test it once I get some spare time (hopefully soon...)
>
> OK thanks.
>
> BTW, I _cannot_ get null_blk to come even close to your reported 1500K+
> IOPs on 2 "fast" systems I have access to.  Which arguments are you
> loading the null_blk module with?
>
> I've been using:
> modprobe null_blk gb=4 bs=4096 nr_devices=1 queue_mode=2 submit_queues=12
>
> On my 1 system is a 12 core single socket, single NUMA node with 12G of
> memory, I can only get ~500K read IOPs and ~85K write IOPs.
>
> On another much larger system with 72 cores and 4 NUMA nodes with 128G
> of memory, I can only get ~310K read IOPs and ~175K write IOPs.

Look at the completion method (irqmode) and completion time 
(completion_nsec).

-- 
Jens Axboe
