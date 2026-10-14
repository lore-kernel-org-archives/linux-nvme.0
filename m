Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6A5CC6B2A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TI1InYuhv2BOMB8UNQLzhmzx2APX9vyjkfAbRr4ddfE=; b=ZPAPxC628wcG3XN6O8TZjcTiuQ
	bIgqd78BVtB1//MZMuk8fCAskkvMnZgIgIKDVZjN4RcfGhbOv0AP1glgz78/OddPL8FN1KhuYviPN
	r6IQI+GsCilJcBtTqp0nvAWhyh0+yxyXOZFQ0I4ECmjMupRLQ8mD6IBmuEfTH4QxD50ucsD/k5O2c
	xrR0qwwFyGen6aziJ8ZgGvC6uIsOCqr/fLoBIcv38HOXqonrJcEYHf63yykr5zexMbHRp1OZD+0Ud
	V2ObrjFa+WgMdjRWW+xwpgrM1H4o1/XgveTJWD7MqwPlPQSjEjwqh41Sq1s3A0pMs50Gi7umtOv4V
	7HZeFHSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzE5-0000000Fcnk-0CHz;
	Wed, 14 Oct 2026 13:41:01 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGzE2-0000000Fcmh-138C
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 13:41:00 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-82621039b6bso665364a34.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791985257; x=1792590057; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TI1InYuhv2BOMB8UNQLzhmzx2APX9vyjkfAbRr4ddfE=;
        b=rhqzeZiyp3mV5kLDBVkVkbGbvhmS07vAQj5xwkHKuJVh+46/UPqptbzPNHrZpH3JfA
         IPOc6aeO78FDcRY0FvsZCKZXpiSLOSpGHWwBY8QNAaYZYyaUtgLDbX3mjzQLstDR6HLS
         sxIF86xJ6zl8crciCxyCzhj+hqaiBJHpgLxQS0O9M4SJdTFYNrgqXfQTCOYwp87uNzYv
         E+Yax6lk8fwTbBrIuI0DxEHkD+tBt93HpJIvigjdt0BtvuXXbhh8QbxTborg0BpbEOr6
         CC0+s8A/sij3MJaCh3/61zTdBBQOapaqHKg/9L9Audpr8gRKm6LiKGV2o09tXNGffYQj
         BOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985257; x=1792590057;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TI1InYuhv2BOMB8UNQLzhmzx2APX9vyjkfAbRr4ddfE=;
        b=nMBRLKtcdySnxF2llZJJrI77bWisfkiJI+hpASq587hpUbIVabKSM702eRT/e2+zWh
         fyE4CHCyABLQMbR1BZPwCbmsYZdi/PWiHyzGUCrTONMdyc/kPCGywGFQ3ArLop7G6s0L
         T3L27gQuc2PclQOuIL+KQB/j4VUc8nO3o2AZORT1Yig20UJu9vyrRveSqNdKK/GMGR7U
         4nvIh4pbE2qhxyroFxENQJcVy2cKHtcpBr0Xxi2Gi42M0S4bC7+EXbebSSbolZ3Q5vk0
         Xh7g3x0fjWqoY/pyM94mJ1cJeUTQQU9lFDT+PYesnJBtAMl5S0gRSxZ4S3uRtdds6tPB
         jHaQ==
X-Forwarded-Encrypted: i=1; AKwUvByyPR5wZScg6Jebinyp0pYIfQZaDRxKSLYndywoRjVOtyNY4JNtU/MEKwR4D/zcNoEsTD4O9Y1oyFXV@lists.infradead.org
X-Gm-Message-State: AFq9FYJURQtfU1kaHzQWzE0MSajNXOTKEiiiZcaKpQiqhHccXyXrY+cU
	eIHQ1CNV3psD42CziYoKEwhIc0TWFWSZQ3PujskGR6eU+VDVm0QFF542AubjxDbf6HM=
X-Gm-Gg: AYBFou2QgJs9EyvJ5pYz2upUqb8Wqzj+l0buPZDicwBdrGkCTxvW/PADS6gZiH7JHJe
	lNs8v9kkB8i9zCc+OxXZ67YByFNpqavGxIiw8UBOTIfmLkG7H6njekd7AZzGk54WGZbeRzdOklW
	NhLBftz+8NFK/19f9bMkd4gv6ib16WCg8Z7F2h+Jr7Zf9YFPT3KfXqcRB/RXu6ntVhe7BwVGQUR
	ro8huoXqcsLDLSR5C5BS1DyVUEHEHAvhTuF94CMV+gz7WenTfORQ2iGwVhCeIDWna6KHigV3dKe
	qj8xFie4VKiT8oprplX5dWee0ghRt7t213Asd9/Ejzyesol/vjyeudJ19KRFBrQpYyVPhVD7prA
	5UTg3kyCceqYZLMElazYCTkO0p2E7OHhuggZTG9UO6ezxCnKqus3TNRujAsLqgZfnF9H4JKn4D1
	AqBJnoXziKdWKeS3/+PcdDR3qIsGm4Wg5971mptXZgT/PBwFoT3ULyz/9U4sEMgDlDlRSvEStAR
	m+AlBZ+tHUPCjPa5j3zFBG6KYNdIaa7ZmFKX39BFTQKr87+iF4PvVf6jw==
X-Received: by 2002:a05:6830:67e4:b0:812:4cc7:4afe with SMTP id 46e09a7af769-830969d183fmr14838309a34.17.1791985256814;
        Wed, 14 Oct 2026 06:40:56 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83038f822dcsm14657364a34.10.2026.10.14.06.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:40:56 -0700 (PDT)
Message-ID: <81e6538c-977c-4b45-bd44-242ce5e00dd7@kernel.dk>
Date: Wed, 14 Oct 2026 07:40:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/13] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_064058_455291_FA94651C 
X-CRM114-Status: GOOD (  14.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A few nits:

> diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
> new file mode 100644
> index 000000000000..1a1a88640823
> --- /dev/null
> +++ b/io_uring/dma-buf.c
> @@ -0,0 +1,66 @@
> +#include "dma-buf.h"

Needs SPDX license header.

> diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
> new file mode 100644
> index 000000000000..a876a9e5e272
> --- /dev/null
> +++ b/io_uring/dma-buf.h
> +static inline int io_attach_dmabuf_map(struct io_kiocb *req,
> +					struct iov_iter *iter,
> +					unsigned issue_flags)
> +{
> +	bool nowait = issue_flags & IO_URING_F_NONBLOCK;
> +	struct dma_buf_io_map *map;
> +	struct io_buf_dma *bd;
> +
> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> +		return -EOPNOTSUPP;
> +	if (!(req->flags & REQ_F_DMABUF))
> +		return 0;
> +
> +	bd = req->buf_node->buf->priv;
> +	map = dma_buf_io_get_map(bd->ctx, nowait);
> +	if (unlikely(IS_ERR(map)))
> +		return PTR_ERR(map);

No need for unlikely() with IS_ERR(), it already includes that.

-- 
Jens Axboe

