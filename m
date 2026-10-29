Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF202606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=5Bnm/zBy;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEhg2t0T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FK9xnQsk0+KWozuuwP8x71kNiKRFmMpgW9T43Fhprkk=; b=5Bnm/zBy8yDfTQ
	9eUXYVffw83xusws249dnZ/xIIFjzBG4VRhvMTc8FHhUncTFINrzmI8f1M2UIwqvnqs/I3Vm69j2p
	6Ui3ccbnG9t2dwGgpcNu2p5D56KygcsA0cMYypvtnj5Z68u4oiH6Iiy7ihEIg1SVDLCp8WgpmxGUQ
	ArlEt7pG4qyymw34qLW+AflxuwDct4JfT4DgC4Ve8QkZLCCvnSsOeWxev3lTjE9AYTw+ZIViAYdeb
	N0pALWHLplKhOnamHPWhpXpiQBG8tMECUf47k/XcsLPIVzZ4W8eitGPYYNj5MjVYjcY/s/j0GhfB6
	5L41Fc3CAWRdpI9+h7qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOfR-000000095ye-2D9y;
	Thu, 29 Oct 2026 11:51:37 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOfN-000000095wu-42xA
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 11:51:35 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso16483555e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793274691; x=1793879491; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FK9xnQsk0+KWozuuwP8x71kNiKRFmMpgW9T43Fhprkk=;
        b=wEhg2t0TrWwrKAFPT9YQ8duPj5WlGqIyiDWsnj7w7RFBrXf/UcWKmTNjro3E4Uxpgi
         oc0XAKmZeYWIUx5CUi+Lke4Xk8t0vTLs+ZZW4qCIiuN/4q7y4wQlgmsAGwFwpv/jch3c
         Ujc4IMlV+m5fiNG1OqUbiCCQF7ptIP/nbAvbygJv1IcX0I9y+n+gQQjSIVZ3TL0U30gt
         FSZJMKHBH7dE2KBN5nYyqrzD2CgIyCgYJ6gvBUct9hLNXwTgryoLVenhro3NFAFBr3eO
         jLkgH5nwGAcnDtm0WmVs9OEvRBqWiyJekmTVvO35jklkRLoxKL/QDzhjLXkbZ0goF7dL
         ltaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274691; x=1793879491;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FK9xnQsk0+KWozuuwP8x71kNiKRFmMpgW9T43Fhprkk=;
        b=yzeNqsWKGPsE566FCBD8BOnqnSZgdYfVBnGh3wZfNvhrAWYwCgIVvi9IHCQy154hhR
         bg7KEg3b8FsbTnGJhv92hRitYQolzhzdzKf424gceaeZ9cjcP8jg6Ops/e4zJGuLglOT
         1pMAYAzCGWv4hdD6YQmq8ZX2cPK9dDiKIK0zaNolmMUN6rwhszVdhyBijvMUvIi62Kex
         zUiiAH7piA0a6bMbQomQDRjS0eyAK+kxpuTfFM9vM9AOZWeADVew+npqx01uA7OU00kI
         Y3qQtpy2yVJIJw8LOcoxHc97NJF37rzBXwDSx1eNRJYSzGZbx5vbLvgaX2khXrBlEf6t
         /42Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgCWnGG9IZ6GuuJiOa3dgSsvCO5u/cqrXeifS2E3hJFWdgnUg8839qrgF//1fMJ98V1+A96FfhaXyZ@lists.infradead.org
X-Gm-Message-State: AFq9FYJV+3zavlMnodNEvuoCYi9J6hqta02hV3Nt4seZuBUJ5kfY2qhl
	dliNUNoOrU0naFl/SAC9o8q5SyCfSWs/dciViuqKMRtxke9DiZN3hmei
X-Gm-Gg: AYBFou0lUjJVNwhC+j9yXtKX+4DMXXENbvHXsXe16Tg7m2zeFiVbjNwif49Zm3gyhsj
	bFqCo4fAlyyPi5HCjQUjY4duexyIMahDEP9Ba5np8FaLl/QNV6/3isN1r7XqRSuhD+GCt1BreLf
	CkuIqAqjjQQNz0Z//TpoOUEkqj0Y77hOf7VHfzWHBJoFcXzIuAKx1KkiojD0FJpYdLizOZtuyXR
	50uNdn8b/ilORWqL1PdCW9PwSkzdvDI6Vtm5rQPvDv5A3A+FAny/5NSEft/3YYJ6CP2h3iNx0p1
	u+VxM72KYziCiT1L/8q2uqXwX5oGci4LGHVdy5DR+uFJoayXky6hEh05eN0LFrRorI6l+wjNNbc
	frbkY5ivm7c/rNCSvJqfey4oWMeZNHXBEJ52HrJMCYN3SzfFWD8IlzT52ZxjbUZK8KN09h/l/Pi
	dtY0kJGq0xJJGmnvP6A1ha4YK7hwm6FIQMbMN/ZaH9LmypZU3TqVczHJzTyJ9ttqCaNZqI6vBf6
	BKFtjyjtoupu1bTYwFQNRVhSS1gikK+wFJf+wGTjBPm/Hs1nwMQ/ahdhedP4EJv3qRUqKZZb3Yf
	ephTA+T6C2vpqks7NLpa+OFI6CRHxEcyDeYetwJSqtKbWM4a547Q4iesSu+J09RTgje8rIePHwj
	opCOnS5BSKKxZK28LIGgZM3VwBPz+lW2s0MgkUd8pel7Xx1I7+UN4SGNEhe951pVRGUCnD6/K28
	N6Kw==
X-Received: by 2002:a05:600c:4692:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4a9667756c9mr115880235e9.21.1793274690699;
        Thu, 29 Oct 2026 04:51:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm59046015e9.11.2026.10.29.04.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:51:30 -0700 (PDT)
Message-ID: <134aa376-7441-46e1-8d04-be327747b4a9@gmail.com>
Date: Thu, 29 Oct 2026 11:51:31 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
To: Kyle Bader <kbader@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261028181412.1919506-1-kbader@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261028181412.1919506-1-kbader@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_045134_035478_F2EF9D3B 
X-CRM114-Status: GOOD (  42.76  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 18:14, Kyle Bader wrote:
> From: Kyle Bader <kbader@ibm.com>
> 
> Any dma-buf I/O to a device with a PI checksum fails today.
> blkdev_init_dma_buf_io_ctx() returns -EOPNOTSUPP at registration, and
> blk_mq_submit_bio() fails each dma-buf bio with BLK_STS_NOTSUPP. The
> checks prevent a crash: bi_dmabuf_map shares a union with bi_io_vec,
> and bio_integrity_generate() and bio_integrity_verify() walk bi_io_vec
> to compute the guards over the data.
> 
> Only the BI_ACT_CHECK action walks the data, and a dma-buf bio does not
> need it in two cases. In the first case, the submitter attaches its own
> integrity payload, for example with the io_uring PI attribute
> (IORING_RW_ATTR_FLAG_PI). Then bio_integrity_action() returns 0, and
> the device checks the PI as the submitter asked. The block layer only
> touches the integrity buffer, to remap the ref tags. In the second
> case, read_verify or write_generate is off. Then the device inserts and
> strips the PI, or the block layer allocates an integrity buffer without
> PI in it. This is the same as for any other bio.
> 
> The first case lets an application read data into device memory, for
> example a GPU buffer or an NVMe CMB. The device checks each block and
> puts the guards in host memory. The application can then check the
> data, or combine the guards into a checksum of the whole buffer. The
> CPU does not read the data.
> 
> If bio_integrity_action() asks for BI_ACT_CHECK, fail the dma-buf bio,
> and otherwise let it through. Remove the check at registration, because
> the integrity payload comes with each I/O. With the default integrity
> settings, a dma-buf I/O without an integrity payload still fails with
> -EOPNOTSUPP.
> 
> Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
> Assisted-by: LLM
> Signed-off-by: Kyle Bader <kbader@ibm.com>
> ---
> This applies to for-7.4/io_uring-dmabuf (45b716456dd9).
> 
> Anuj's check in v10 fixed the crash in blk_integrity_iterate(). This
> patch keeps that check for the bios that need block layer PI, and lets
> the other dma-buf bios through.
> 
> The sysfs knobs change the integrity flags only with the queue frozen,
> and blk_mq_submit_bio() holds a queue reference from the new check to
> bio_integrity_prep(). So the two calls to bio_integrity_action() give
> the same result for a bio.
> 
> I tested in a QEMU 10.2.2 guest, with udmabuf and with an NVMe CMB
> that a small module exports as a dma-buf. The namespaces have 4 KiB
> blocks with these metadata formats:
> 
>   - 16 bytes, PI type 1 with the 64b guard
>   - 64 bytes, PI type 1 with the 64b guard in the last 16 bytes
>   - 8 bytes, PI type 1 with the 16b guard
>   - no metadata
> 
> With a user PI buffer, reads and writes pass on all three PI formats,
> and the data and the PI match. This is also true for a 2 MiB I/O that
> the block layer splits, and for four commands with one PI slice each.
> A write with one bad guard fails with -EILSEQ from the device. Without
> a PI buffer, a dma-buf I/O fails with -EOPNOTSUPP. If read_verify or
> write_generate is off, that I/O passes. Pavel's rw-dmabuf test from
> liburing rw-dmabuf-tests-v8 passes on the namespace without metadata.
> On the PI namespaces it passes with read_verify=0 and write_generate=0,
> and with the defaults it fails with -EOPNOTSUPP on the first read.
> The tree builds with CONFIG_BLK_DEV_INTEGRITY=n.
> 
> Without this patch, every PI case fails at registration with
> -EOPNOTSUPP, also with read_verify and write_generate off.

Thanks, looks good from a quick glance, I'll take another look in
a bit. It might be nice to somehow support kernel generated PI
as well later, looks like there will be a good bunch of cases that
might want to have CPU access.

> If a liburing test helps, I can turn the test program into one.
> 
>   block/blk-mq.c | 9 ++++++++-
>   block/fops.c   | 2 --
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7fff1305b..3fc9fdeb3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3138,8 +3138,15 @@ void blk_mq_submit_bio(struct bio *bio)
>   		goto queue_exit;
>   	}
>   
> +	/*
> +	 * The block layer cannot generate or verify PI for a dma-buf bio, as
> +	 * that walks the data pages.  Only fail the bio if it needs that, not
> +	 * if the submitter attached its own integrity payload or if PI
> +	 * generation or verification is turned off for the device.
> +	 */
>   	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
> -		     bdev_has_integrity_csum(bio->bi_bdev))) {
> +		     bdev_has_integrity_csum(bio->bi_bdev) &&
> +		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
>   		bio_endio_status(bio, BLK_STS_NOTSUPP);
>   		goto queue_exit;
>   	}
> diff --git a/block/fops.c b/block/fops.c
> index 01bc8afe3..5c8024011 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -947,8 +947,6 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>   		return -EINVAL;
>   	if (!disk->fops->init_dma_buf_io_ctx)
>   		return -EOPNOTSUPP;
> -	if (bdev_has_integrity_csum(bdev))
> -		return -EOPNOTSUPP;
>   	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>   }
>   
> 
> base-commit: 45b716456dd99488a0cef58482120dc0474aa696

-- 
Pavel Begunkov


