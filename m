From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 10:22:31 +0530
Subject: [PATCHv1] NVMe: nvme_queue made cache friendly.
In-Reply-To: <1432241133.2454.53.camel@jpfreyen-mobl5.amr.corp.intel.com>
References: <1432154627-12336-1-git-send-email-parav.pandit@avagotech.com>
 <1432241133.2454.53.camel@jpfreyen-mobl5.amr.corp.intel.com>
Message-ID: <CAGgvQNRLaMQsrcHAtWKPpfXuLk6R4KooFCFp7eoXxU+0-KH44g@mail.gmail.com>

On Fri, May 22, 2015 at 2:15 AM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
> On Wed, 2015-05-20@16:43 -0400, Parav Pandit wrote:
>> nvme_queue structure made 64B cache friendly so that majority of the
>> data elements of the structure during IO and completion path can be
>> found in typical single 64B cache line size which was previously spanning
>> beyond single 64B cache line size.
>>
>> By aligning most of the fields are found at start of the structure.
>> Elements which are not used in frequent IO path are moved at the
>> end of structure.
>
> I'll repeat the same question Matthew said last time:
>
> "Have you done any performance measurements on this?"
>
> If the answer is no, then I'm not sure why the patch is even being sent
> to apply to the code base if the main reason is performance-related.
> From the comments from the last patch attempt, it did not even sound
> like there was a good understanding where the q_lock should go for best
> performance.
>

I should be able to do performance test for cache accesses in few days.

However its pretty clear from the nvme_queue structure that,
spinlock sitting between irq_name array and other data path specific
elements is not a best way because irq_name array is not needed along
with q_lock.
so other related elements should be close to it, instead of name.

On x86 in non paravirtualized mode, without any padding spinlock_t is 16-bit.
There is auto padding done to align to 32/64-bit boundary for spinlock.
spinlock placed along with other u16 elements further makes it
naturally aligned without need of padding.

Similarly DMA addresses at in middle of other data path structure is
not good idea as they are not needed in same cache line either.
With existing structure, IO path elements of nvme_queue are clearly
residing in two cache lines.
So moving irq_name and dma address at end is fairly simple change.

> I think it would be better to have some results to go along with the
> patch request.  At least it would be known for sure where the q_lock
> should go.  And that would be good knowledge to know for future
> programming projects.

>
>>
>> Signed-off-by: Parav Pandit <parav.pandit at avagotech.com>
>> ---
>>  drivers/block/nvme-core.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index b9ba36f..58041c7 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -98,23 +98,23 @@ struct async_cmd_info {
>>  struct nvme_queue {
>>       struct device *q_dmadev;
>>       struct nvme_dev *dev;
>> -     char irqname[24];       /* nvme4294967295-65535\0 */
>> -     spinlock_t q_lock;
>>       struct nvme_command *sq_cmds;
>> +     struct blk_mq_hw_ctx *hctx;
>>       volatile struct nvme_completion *cqes;
>> -     dma_addr_t sq_dma_addr;
>> -     dma_addr_t cq_dma_addr;
>>       u32 __iomem *q_db;
>> +     spinlock_t q_lock;
>>       u16 q_depth;
>> -     s16 cq_vector;
>>       u16 sq_head;
>>       u16 sq_tail;
>>       u16 cq_head;
>>       u16 qid;
>> +     s16 cq_vector;
>>       u8 cq_phase;
>>       u8 cqe_seen;
>>       struct async_cmd_info cmdinfo;
>> -     struct blk_mq_hw_ctx *hctx;
>> +     char irqname[24];       /* nvme4294967295-65535\0 */
>> +     dma_addr_t sq_dma_addr;
>> +     dma_addr_t cq_dma_addr;
>>  };
>>
>>  /*
>
>
