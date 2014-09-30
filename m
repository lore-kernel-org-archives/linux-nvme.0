From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Tue, 30 Sep 2014 20:55:03 +0100
Subject: CQ Doorbells can be touched after queue deleted
In-Reply-To: <alpine.LRH.2.03.1409301309230.4688@AMR>
References: <542AF732.3060706@ranbarg.com>
 <alpine.LRH.2.03.1409301309230.4688@AMR>
Message-ID: <542B0A97.90309@ranbarg.com>

On 30/09/14 20:41, Keith Busch wrote:
> On Tue, 30 Sep 2014, Paul Grabinar wrote:
>> I've encountered an interesting issue with the driver as in v3.17-rc7.
>> The NVMe specification defines writing to CQ doorbells for non-existent
>> queues as "undefined", so it is probably not a good idea to do this.
>> I'm aware of at least one drive that gets very upset if you try.
>>
>> The case I hit was where there is I/O running to the drive, but the
>> drive is being reset in the kthread due to not responding to abort
>> requests.
>> When an I/O request came in, nvme_process_cq was called from
>> nvme_make_request, but the queue no longer exists as it has been torn
>> down by the reset.
>> During nvme_process_cq, the doorbell is updated, which upsets the drive.
>>
>> This is a bit of a corner case, but it has happened.
>> We probably need to skip the doorbell update if the queue has been
>> deleted.
>
> Thanks for the info. I agree the results are undefined in this case. Your
> situation is interesting, though. The driver won't update the doorbell
> if no completions were posted, so it sounds like your device is posting
> completions long after the queues were deleted if the problem occured
> in the make_request path.
>
> Anyway, here's a patch.
>
>> From a141c8116d1d8f86fffb58bb312ec4d75cdc82ef Mon Sep 17 00:00:00 2001
> From: Keith Busch <keith.busch at intel.com>
> Date: Tue, 30 Sep 2014 12:51:06 -0600
> Subject: [PATCH] NVMe: Skip updating cq doorbell on inactive queues
>
> The driver processes the completion queue after taking queues offline to
> check for new completions that may have occured when the device deleted
> the queue. We don't want to write the completion queue doorbell in this
> case as it has undefined results.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reported-by: Paul Grabinar <paul.grabinar at ranbarg.com>
> ---
>  drivers/block/nvme-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 28aec2d..6c077cd 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -828,7 +828,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
>      if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
>          return 0;
>
> -    writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
> +    if (!nvmeq->q_suspended)
> +        writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
>      nvmeq->cq_head = head;
>      nvmeq->cq_phase = phase;
>

Hi,
Yes, good point. I guess there are still commands that are being
processed and we are getting late completions.

Thanks for the patch.
