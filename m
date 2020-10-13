Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB6FC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:46:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A4821D40
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PhJhj4gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A4821D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zQen0sC4xcTGNUDe0qlJe9lbqYWuyZGxW6wSHsSz4Zo=; b=PhJhj4gTUyo4Gq
	A59HJ3roJJfVPBfQpnepfIQUYSnMvk8FlPpACcUgzUCCCQKR6GZaRI+cdSW+71qpBxx4VZ1LAESgP
	wSXEIkwH1d3V8qzFTkfGlzmDIOZ6mARgXX+ky8G8Wkq/oizEH+ZhSF2VsaBob/0hC0xIW/7WGcdGI
	qie9bv5iKrQjnT/uwaqoSw1ldtlL5L8lKUNm2nqkiegHojyprBZlyk5HPp5YPo4Q9PCl1FV8ZHU7g
	F/CEr54Vt6Q5B3f/p1mqxWlU4pP3tPqU+ieVP+bDkAC1t/VomNNXlZGOfrh2j5+vy/rM3ATHmPiIG
	tAxgJYcImqmsLKLTF3HA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kST3g-0004hh-2P; Tue, 13 Oct 2020 22:46:16 +0000
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kST3e-0004hK-Fu
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 22:46:15 +0000
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
 by mail-1.ca.inter.net (Postfix) with ESMTP id 6407F2EA9AD;
 Tue, 13 Oct 2020 18:38:48 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
 with ESMTP id BHABXUl5Q5EG; Tue, 13 Oct 2020 18:31:42 -0400 (EDT)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca
 [104.157.204.209])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dgilbert@interlog.com)
 by mail-1.ca.inter.net (Postfix) with ESMTPSA id 1030F2EA9C9;
 Tue, 13 Oct 2020 18:38:46 -0400 (EDT)
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
To: Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org
References: <20201009231816.1524-1-logang@deltatee.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <1b6ced06-dd44-ac20-cafa-b4724d9a188d@interlog.com>
Date: Tue, 13 Oct 2020 18:38:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009231816.1524-1-logang@deltatee.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_184614_544228_2801EE07 
X-CRM114-Status: GOOD (  23.57  )
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
Reply-To: dgilbert@interlog.com
Cc: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-10-09 7:18 p.m., Logan Gunthorpe wrote:
> Clean up some confusing elements of nvmet_passthru_map_sg() by returning
> early if the request is greater than the maximum bio size. This allows
> us to drop the sg_cnt variable.
> 
> This should not result in any functional change but makes the code
> clearer and more understandable. The original code allocated a truncated
> bio then would return EINVAL when bio_add_pc_page() filled that bio. The
> new code just returns EINVAL early if this would happen.
> 
> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>


I have commented offline to Logan about the return from bio_alloc()
not being checked for NULL. He assures me that can't happen but I believe
that is true only for small scatter-gather lists. So I guess it depends
on the size of the data this is planned to be sent through this
pass-through.

> ---
>   drivers/nvme/target/passthru.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index dacfa7435d0b..076e829490a1 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -180,18 +180,20 @@ static void nvmet_passthru_req_done(struct request *rq,
>   
>   static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>   {
> -	int sg_cnt = req->sg_cnt;
>   	struct scatterlist *sg;
>   	int op_flags = 0;
>   	struct bio *bio;
>   	int i, ret;
>   
> +	if (req->sg_cnt > BIO_MAX_PAGES)
> +		return -EINVAL;
> +
>   	if (req->cmd->common.opcode == nvme_cmd_flush)
>   		op_flags = REQ_FUA;
>   	else if (nvme_is_write(req->cmd))
>   		op_flags = REQ_SYNC | REQ_IDLE;
>   
> -	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
>   	bio->bi_end_io = bio_put;
>   	bio->bi_opf = req_op(rq) | op_flags;
>   
> @@ -201,7 +203,6 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>   			bio_put(bio);
>   			return -EINVAL;
>   		}
> -		sg_cnt--;
>   	}
>   
>   	ret = blk_rq_append_bio(rq, &bio);
> 
> base-commit: 549738f15da0e5a00275977623be199fbbf7df50
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
