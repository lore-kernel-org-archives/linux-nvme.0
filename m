From: helen.koike@collabora.com (Helen Koike)
Date: Mon, 10 Apr 2017 12:31:40 -0300
Subject: [PATCH v7 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <b421e5a1-d60d-10b0-1d26-33a38298e01e@collabora.com>
References: <20170330173324.GH20181@localhost.localdomain>
 <1490895961-28828-1-git-send-email-helen.koike@collabora.com>
 <20170331070128.GA28852@infradead.org>
 <b421e5a1-d60d-10b0-1d26-33a38298e01e@collabora.com>
Message-ID: <ad8d3e41-ef48-21fd-4d34-0cfe43760f90@collabora.com>

ping

On 2017-04-01 06:50 PM, Helen Koike wrote:
>
> Hi Christoph,
>
> Thanks for reviewing this patch
>
> On 2017-03-31 04:01 AM, Christoph Hellwig wrote:
>> I'd still prefer to not hide the MMIO path behind nvme_write_doorbell,
>> but except for that this looks fine to me:
>>
>
> Do you mean wrapping the call to writel()? What do you think if I send a
> new
> version with the changes below? It wouldn't hide the call to writel()
> inside nvme_write_doorbell anymore.
>
> Helen
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3ce705a..0e5f2a1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -277,8 +277,9 @@ static inline int nvme_dbbuf_need_event(u16
> event_idx, u16 new_idx, u16 old)
>         return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
>  }
>
> -static void nvme_write_doorbell(u16 value, u32 __iomem *db, u32 *dbbuf_db,
> -                               volatile u32 *dbbuf_ei)
> +/* Update dbbuf and return true if a MMIO is required */
> +static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
> +                                             volatile u32 *dbbuf_ei)
>  {
>         if (dbbuf_db) {
>                 u16 old_value;
> @@ -291,11 +292,12 @@ static void nvme_write_doorbell(u16 value, u32
> __iomem *db, u32 *dbbuf_db,
>
>                 old_value = *dbbuf_db;
>                 *dbbuf_db = value;
> +
>                 if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
> -                       return;
> +                       return false;
>         }
>
> -       writel(value, db);
> +       return true;
>  }
>
>  /*
> @@ -422,8 +424,9 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>
>         if (++tail == nvmeq->q_depth)
>                 tail = 0;
> -       nvme_write_doorbell(tail, nvmeq->q_db, nvmeq->dbbuf_sq_db,
> -                           nvmeq->dbbuf_sq_ei);
> +       if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
> +                                             nvmeq->dbbuf_sq_ei))
> +               writel(tail, nvmeq->q_db);
>         nvmeq->sq_tail = tail;
>  }
>
> @@ -839,8 +842,9 @@ static void __nvme_process_cq(struct nvme_queue
> *nvmeq, unsigned int *tag)
>                 return;
>
>         if (likely(nvmeq->cq_vector >= 0))
> -               nvme_write_doorbell(head, nvmeq->q_db +
> nvmeq->dev->db_stride,
> -                                   nvmeq->dbbuf_cq_db,
> nvmeq->dbbuf_cq_ei);
> +               if (nvme_dbbuf_update_and_check_event(head,
> nvmeq->dbbuf_cq_db,
> +                                                     nvmeq->dbbuf_cq_ei))
> +                       writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
>         nvmeq->cq_head = head;
>         nvmeq->cq_phase = phase;
>
