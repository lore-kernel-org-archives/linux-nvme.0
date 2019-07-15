From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jul 2019 10:10:41 +0200
Subject: [PATCH] nvme: Add support for Apple 2018+ models
In-Reply-To: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
Message-ID: <20190715081041.GB31791@lst.de>

> +	/*
> +	 * Apple 2018 and latter variant has a few issues
> +	 */
> +	NVME_QUIRK_APPLE_2018			= (1 << 10),

We try to have quirks for the actual issue, so this should be one quirk
for the irq vectors issues, and another for the sq entry size.  Note that
NVMe actually has the concept of an I/O queue entry size (IOSQES in the
Cc register based on values reported in the SQES field in Identify
Controller.  Do these controllers report anything interesting there?

At the very least I'd make all the terminology based on that and then
just treat the Apple controllers as a buggy implementation of that model.

Btw, are there open source darwin NVMe driver that could explain this
mess a little better?

> @@ -504,8 +505,11 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
>  static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
>  			    bool write_sq)
>  {
> +	u16 sq_actual_pos;
> +
>  	spin_lock(&nvmeq->sq_lock);
> -	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
> +	sq_actual_pos = nvmeq->sq_tail << nvmeq->sq_extra_shift;
> +	memcpy(&nvmeq->sq_cmds[sq_actual_pos], cmd, sizeof(*cmd));

This is a little too magic.  I think we'd better off making sq_cmds
a void array and use manual indexing, at least that makes it very
obvious what is going on.

> -				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
> +				nvmeq->sq_cmds, SQ_SIZE(nvmeq));

Btw, chaning SQ_SIZE to take the queue seems like something that should
be split into a prep patch, making the main change a lot smaller.

> -	if (!polled)
> +	if (!polled) {
> +
> +		/*
> +		 * On Apple 2018 or later implementations, only vector 0 is accepted

Please fix the > 80 char line.
