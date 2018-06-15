From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Fri, 15 Jun 2018 19:28:42 +0530
Subject: Read request exceeding max_hw_sectors_kb
In-Reply-To: <20180614145447.GB8129@localhost.localdomain>
References: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>
 <20180614145447.GB8129@localhost.localdomain>
Message-ID: <CAOA9gs2AygM-QW2ij3NxDy_6phMJTcmpRRiKz4ViPmtKjDVHTA@mail.gmail.com>

> ---
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bca3a92eb55f..9c57b49a4132 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1118,8 +1118,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
>         if (!q->limits.chunk_sectors)
>                 return q->limits.max_sectors;
>
> -       return q->limits.chunk_sectors -
> -                       (offset & (q->limits.chunk_sectors - 1));
> +       return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
> +                       (offset & (q->limits.chunk_sectors - 1))));
>  }
>
>  static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
> --

OK, this should work too but I am running into some other issues with
this on my setup, will verify and update.
