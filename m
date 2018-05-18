From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 18 May 2018 02:09:23 -0700
Subject: [PATCH] nvmet-loop: use nr_phys_segments when map rq to sgl
In-Reply-To: <CAK0tqinRpkb5JQY8W4jSA2onOHXbmnrzH8jOP8BGjfScmTJ1eg@mail.gmail.com>
References: <20180511063815.14911-1-chaitanya.kulkarni@wdc.com>
 <20180514083245.GA32761@infradead.org>
 <CAK0tqinRpkb5JQY8W4jSA2onOHXbmnrzH8jOP8BGjfScmTJ1eg@mail.gmail.com>
Message-ID: <20180518090923.GA31336@infradead.org>

On Mon, May 14, 2018@03:17:51PM -0700, chaitany kulkarni wrote:
> +static inline void nvme_setup_write_zeroes(struct nvme_ns *ns,
> +               struct request *req, struct nvme_command *cmnd)
> +{
> +       struct nvme_write_zeroes_cmd *write_zeroes = &cmnd->write_zeroes;
> +
> +       memset(cmnd, 0, sizeof(*cmnd));
> +       write_zeroes->opcode = nvme_cmd_write_zeroes;
> +       write_zeroes->nsid = cpu_to_le32(ns->head->ns_id);
> +       write_zeroes->slba =
> +               cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
> +       write_zeroes->length =
> +               cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> +       write_zeroes->control = 0;
> +}

This doesn't even set RQF_SPECIAL_PAYLOAD, so that is not the issue.

Actually reviewing things again I think your original patch is fine
as it actually uses blk_rq_nr_phys_segments() which checks
RQF_SPECIAL_PAYLOAD.
