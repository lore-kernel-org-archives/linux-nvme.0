From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 2 Nov 2017 18:00:15 +0900
Subject: [PATCH 2/2] nvme: Check admin passthru command effects
In-Reply-To: <20171101180400.6619-2-keith.busch@intel.com>
References: <20171101180400.6619-1-keith.busch@intel.com>
 <20171101180400.6619-2-keith.busch@intel.com>
Message-ID: <CAA7jztcsxofX35nbg3UkA3MP0CE6FAV8cmTHavBmigeQq2gCjA@mail.gmail.com>

Hi Keith,

I have found a tiny typo in a comment during a review your code.

> +
> +static void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +                                                               u32 effects)
> +{
> +       /*
> +        * Revaildate LBA changes prior to unfreezing. This is necessary to
> +        * prevent memory corruption if a logical block size was changed by
> +        * this command.

"Revalidate" seems okay for this comment.

> +        */
> +       if (effects & NVME_CMD_EFFECTS_LBCC)
> +               nvme_update_formats(ctrl);
> +       if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
> +               nvme_unfreeze(ctrl);
> +       if (effects & NVME_CMD_EFFECTS_CCC)
> +               nvme_init_identify(ctrl);
> +       if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
> +               nvme_queue_scan(ctrl);
> +}
> +

I always appreciate your dedication to this amazing nvme driver.
Thanks,

Minwoo
