Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF62C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:29:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5112087D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdmpFtJV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KxsfJwGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5112087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/PUWs7E6HuQ+JIwc9mqIiPw9u9G5//bh128Sxw0Ct/w=; b=gdmpFtJV6+qSQhS7EuQbZp3cW
	zbu+XINNz4D+Qh/oPceA76Mnz90GptkrFVGYwARkozx1xDbUlg5r6erieTNf/x+O4dIigOjL6J7Lf
	OLhsvXcXwmY3bXGj6f2szs5LjPIe/j9V8i0zmiGofhrqA27ND+ah+zfNkxhpoiwe0IWd4Iokpj2To
	Zr4Wx7rwEDtNScX583V0B2CUWZ7PQbBxvo90R3gTfBxFKyc12bazH902QdFFLEcOoBl8IvBmoGY9y
	bGjPQ/RlIMSgD/FTe1v7x1rOcTXc2x4uNhPCNDGjqI2ZqahaDVFEH3bI0Hh9y/eV6XTxOzsp9APl7
	0jBXcr6GQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDA6K-0006rW-95; Tue, 01 Sep 2020 17:29:44 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDA6H-0006qc-Ny
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:29:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HQU2hKLkYYeC1YnXEIfgPjoZAd9OW1sYwmIIJvlIMaM=; b=KxsfJwGJi7T6zpl3LJcwO1wyC4
 xIM7+MvlIjATUJrpFEizxRAOCyrV+cDbbAiqmsMuaUodpZkPkzRyblyiPplMjWm7E7QbDm5C0NXLo
 msXkMY7J733q5V5gWqPizZ6XFCKpPfVY344QrlVsuAZkeC2So23BofdfbUMYyHtlpsYUSNrkTXgt4
 6MDYQm/O0mU7+SP+d7QWY9JveRI2hBAuj5WQCUgOmtJS5K6gvxMf1TmZj1OiM4nx2qL1n9d/TJbJ4
 Zw6SiAY84JfzlPZstNK8uG4dEVXCTT+cRIZlr3AXqPURf/T3sYOGIGJeI8W3vUliK9labBdlvhfmP
 63Zm4pJA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kDA6D-0007Kr-UX; Tue, 01 Sep 2020 11:29:38 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-13-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5f8c3740-9056-2eb2-90b8-1e7078492b4b@deltatee.com>
Date: Tue, 1 Sep 2020 11:29:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831222707.35611-13-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_132941_852465_B7D5AD72 
X-CRM114-Status: GOOD (  25.55  )
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
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-31 4:27 p.m., Chaitanya Kulkarni wrote:
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
> index 477439acb8e1..6b1430f8ac78 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -331,6 +331,7 @@ struct nvmet_req {
>  			struct work_struct      work;
>  		} f;
>  		struct {
> +			struct bio		inline_bio;
>  			struct request		*rq;
>  			struct work_struct      work;
>  			bool			use_workqueue;
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 89d848006bd5..ff39f0635451 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -179,6 +179,14 @@ static void nvmet_passthru_req_done(struct request *rq,
>  	blk_mq_free_request(rq);
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
> @@ -190,14 +198,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  	if (req->cmd->common.opcode == nvme_cmd_flush)
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
>  	bio->bi_opf = req_op(rq) | op_flags;
> +	bio->bi_private = req;

I still think this would be cleaner to just do:

if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
	bio = &req->p.inline_bio;
	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
} else {
	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
        bio->bi_end_io = bio_put;
}

>  	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>  		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
>  				    sg->offset) < sg->length) {
> -			bio_put(bio);
> +			nvmet_passthru_bio_done(bio);

Then just open code this function here...

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
