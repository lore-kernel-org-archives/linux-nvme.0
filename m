From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 30 Sep 2015 06:16:08 +0800
Subject: [PATCH 0/3] blk-mq & nvme: introduce .map_changed
In-Reply-To: <560AA46A.9060205@kernel.dk>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
 <alpine.LNX.2.00.1509291418270.23840@localhost.lm.intel.com>
 <560AA46A.9060205@kernel.dk>
Message-ID: <CACVXFVNQAO0rPQ_S4VWiywqa=7vzzAeoS7fN5ENw55DyL4Hzcw@mail.gmail.com>

On Tue, Sep 29, 2015@10:47 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 09/29/2015 08:26 AM, Keith Busch wrote:
>>
>> On Mon, 28 Sep 2015, Ming Lei wrote:
>>>
>>> This patchset introduces .map_changed callback into 'struct blk_mq_ops',
>>> and use this callback to get NVMe notified about the mapping changed
>>> event,
>>> then NVMe can update the irq affinity hint for its queues.
>>
>>
>> I think this is going the wrong direction. Shouldn't we provide blk-mq
>> the vectors in the tag set so that layer can manage the irq hints?
>>
>> This could lead to more cpu-queue assignment optimizations from using
>> that information. For example, two h/w contexts sharing the same vector
>> shouldn't be assigned to cpus on different NUMA nodes.
>
>
> I agree, this is moving in the wrong direction. Currently the sw <->hw queue
> mappings are in blk-mq, and this is the exact same information base we need
> for IRQ affinity handling. We need to move in the direction of having blk-mq
> helpers handle that part too, not pass notifications to the lower level
> driver to update its IRQ mappings.

Yes, I thought of that before, but it has the following cons:

- some drivers/devices may need different IRQ affinity policy, such as virtio
devices which has its own set affinity handler(see virtqueue_set_affinity()),
and it is offten not efficient to handle the virt queue's irq on more
than one CPU.

- block core has to get the irq vector information which has to be
setup/finalized
before blk-mq uses that for setting irq affinity, for example, in case
NVMe's admin
queue, its vector can be changed after admin queue's initialization.

That is why I said this approach is more flexible.

>
>>> Also the 'cpumask' in 'struct blk_mq_tags' isn't needed any more, so
>>> remove
>>> that and related kernel interface.
>>
>>
>> It was added to the tags because the cpu mask is an artifact of the
>> tags rather that duplicating it across all the h/w contexts sharing the
>> same set. It also doesn't let a h/w context from one namespace overwrite
>> another's cpu affinity mask when they share the same vector.
>
>
> So having the mask in the tags is really odd, it should be in some
> per-device type data instead.

Agree, removing the mask in tags is one of this patchset's motivation.


-- 
Ming Lei
