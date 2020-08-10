Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:57:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECFF206B5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VB1jVd4d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KYfgeOaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECFF206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KN9Fq74NCworMU9WPA9fR45f+M62ZN7ht5XlqaXHrWs=; b=VB1jVd4d7jRjG2uWmahVp9XIc
	uyzfTenqXVCQ8Lm8EvEYLOYjMi3uaKbvYKbeym6ZvaelC98fJOg6FNAsiUULeJqKHCQFvwrXyqXc5
	3LdeKESUB03COeHccFr2CcWBZwiFIHiEL+mLRqrtFOFEW2UCnL7mzYGxOaq3zoHBShgWBqxRrwqgT
	RrJrmr4ma7QAWFvf7ppisMrEi248iCCz7u526DnxvcrpT62Lk903M4zZSBxYFmJABUv6AFZAEMZ3u
	spAzM0/NG4OvP/r4C3BSvUEjTBT8DFuwLA1YZmTLmLIb/yai5CY+/wC5S3hYyfz/eEpNzPbNkE1UQ
	cWzm8bFFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Fn0-0006dH-5W; Mon, 10 Aug 2020 21:57:06 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Fmy-0006cm-IS
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 21:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=166IsjlbMHj2TS/iKYLYh7jDEguvmfKVl9h6oUqsXTM=; b=KYfgeOajjzmuXkK1ydG0OSrFhI
 yEDPZKbX9EEnYhuJxZzni6+TYJUPtDVGKzURhFcs+pEsuEl1g92lvJuFa6HPvwMcbjtXoVQc/YnVR
 y0G1p4TS5tIHfOmT7G+xjAeUvOVS112XLUFDn16pR2YfOox+JSHpK7Q4RUn5G/wX3vHoscWUv0KPk
 G07qt3wb6UcR2DqwsAWuPu0JQ20QU89jYJV17bHX1quF+gizWyQQwb8JVUDw1LFNrg2z0U8lUUmAb
 St/VfzGOyUmUxg5oa3zNqNw+4G2y0gPQZsW5McnCv6J2/EMKVupNdp5PARlveUYQqu0C4Y4CdgUTV
 DPjW7Iaw==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5Fmt-0000CX-HK; Mon, 10 Aug 2020 15:57:01 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-5-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <32e5116d-4a35-b7ee-e73f-bcb957e8ebdb@deltatee.com>
Date: Mon, 10 Aug 2020 15:56:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-5-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 04/14] nvmet: use consistent type for op_flag
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_175704_645227_1D4D996C 
X-CRM114-Status: GOOD (  17.50  )
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
> In function nvmet_passthru_map_sg() we set the bio->bi_opf ored with
> req_op and op_flags set based on the NVMe cmd. The variable bio->bi_opf
> is declared as unsigned int use same type for op_flag.
> 
> Also, adjust the indentation according to new length.

I think you mean "order" (per reverse christmas-tree convention)... Not
"indentation".

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Reviewed By: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/nvme/target/passthru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 13d73f36e927..58377420874f 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -180,9 +180,9 @@ static void nvmet_passthru_req_done(struct request *rq,
>  
>  static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  {
> +	unsigned int op_flags = 0;
>  	int sg_cnt = req->sg_cnt;
>  	struct scatterlist *sg;
> -	int op_flags = 0;
>  	struct bio *bio;
>  	int i, ret;
>  
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
