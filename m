Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF4C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:47:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDEC20748
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ca/ujYQV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="eINeH6yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDEC20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AGa10hsBD85E34k4XmzVgq6U0xUSz5QZIvtelbDECX4=; b=ca/ujYQV3jlJfIrn6GVdDxXeI
	Rcv1yc6zKwrwuJTc5rIW0mx4oivmB+/3pFtOZ4Sm7oZucpko/WAA/Ww++uNL3ESotNKqN4qpfsI6r
	RmUcESkkK9phNHADoymQDhZXRJgMpbgb8M+1pswcL7GQrbwXA03APyH/ckP7IgtA33ZoTM4bizL0R
	lg/7ZsMI1qwrJwWuOFGEMhrLV/hBlTenKPmyFFMlFABg4sgR0B12GspGKDNcuUaiBcZQxFvRAztiO
	lRgvK6UQJuVIa9AJDH1aMjqTsAmaD9dpi1iZfZJRskDSem0RfqqY4A4w3vQYHfRNvzeYr+9v1tpdV
	jvevxqhBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Ga3-0005Zy-QO; Mon, 10 Aug 2020 22:47:47 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Ga1-0005Zb-JB
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3w9O70o5OXhpqCBzSEt0DzbEXHawBChplEz3l7btrZc=; b=eINeH6yp08lnGAPLt92tQ/npMa
 OWde0dMtB53QMDjgTE6h6mvB5z1gFN5nuIKrvfUZ9RSj4aUoI7svsecJnTZPiK2Bu0byWtYyFiWM8
 B7i0pJj8bLDCaq5beauBYQ2woElJdtJWIcDzBeFqHjYf9ZoLRZef3MaWJY35RSu5fxm0UWMbu9iDF
 VfH+OaBR+dLk1v9if82awpur8bhdwPXYEGb6NgFtn5ODFQriSYCQFgoM8WQXib6ok8rQrpTX1yw2n
 D+R7mwe6AevSPm4/wVNRHwrM8nZpeBydfGN9SAaq7JZXljygA7Lv+lwTNWVuGkr2vzSG1+x4VDTQo
 0boDNgjw==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5GZx-0001D5-L2; Mon, 10 Aug 2020 16:47:42 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-15-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <30a5a7b1-eb30-8488-850e-7ee5aabde933@deltatee.com>
Date: Mon, 10 Aug 2020 16:47:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-15-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 14/14] nvmet: use inline bio for passthru fast path
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_184745_699829_2AAC4115 
X-CRM114-Status: GOOD (  25.20  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> In nvmet_passthru_execute_cmd() which is a high frequency function
> it uses bio_alloc() which leads to memory allocation from the fs pool
> for each I/O.
> 
> For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
> request allocation that can be used with preallocated bio when we
> already know the size of request before bio allocation with bio_alloc(),
> which we already do.
> 
> Introduce a bio member for the nvmet_req passthru anon union. In the
> fast path, check if we can get away with inline bvec and bio from
> nvmet_req with bio_init() call before actually allocating from the
> bio_alloc().
> 
> This will be useful to avoid any new memory allocation under high
> memory pressure situation and get rid of any extra work of
> allocation (bio_alloc()) vs initialization (bio_init()) when
> transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
> compile time.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/nvmet.h    |  1 +
>  drivers/nvme/target/passthru.c | 21 ++++++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 47ee3fb193bd..3dd18f593472 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -331,6 +331,7 @@ struct nvmet_req {
>  		} f;
>  		struct {
>  			struct request		*rq;
> +			struct bio		inline_bio;
>  			struct work_struct      work;
>  			bool			use_workqueue;
>  		} p;
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index a7ccc817ac2d..8b22a6c8f57c 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -200,6 +200,14 @@ static inline bool nvmet_write_cmd_group(__u8 opcode)
>  	return ret;
>  }
>  
> +static void nvmet_passthru_bio_done(struct bio *bio)
> +{
> +	struct nvmet_req *req = bio->bi_private;
> +
> +	if (bio != &req->p.inline_bio)
> +		bio_put(bio);
> +}
> +
>  static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  {
>  	unsigned int op_flags = 0;
> @@ -219,14 +227,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  	} else if (unlikely(req->cmd->common.opcode == nvme_cmd_flush))
>  		op_flags = REQ_FUA;
>  
> -	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> -	bio->bi_end_io = bio_put;
> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
> +		bio = &req->p.inline_bio;
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> +	} else {
> +		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +	}
> +
> +	bio->bi_end_io = nvmet_passthru_bio_done;

Why not just only set bi_end_io to bio_put if it's not an inline bio?
Then we don't need the extra bio done function and an extra if() on
every bio_put() call.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
