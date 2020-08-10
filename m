Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF066C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:58:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98214206B5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tD+QR08C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BugW6O+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98214206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O6OawzNlINoemZfWznOE1fXUy9S+cPcsVQPjYbqqtns=; b=tD+QR08Ceb5XAd66t/bJEZ8Z5
	4CRnz7djxVTkNRy8yOcBgSceWgdKke/oN1oq6ZtWp7gjlEv3GwiNWZdfx8NiLh+1gFT85Iobo1Nvg
	9/Qi1MQBo2OvZ2EllIrgDb5ZKvfigp5w2j+iRJEkHc3Ek7e+WwIlhMQsY3LNuvEwNr68T6XPKqfvv
	mEsaGcO0DCjKCnJRRYXfzg960NzX4vNqKRT8HGbXT9ZhkRyxL/S5G3/CgmBRoZUqCoZhMucM6vU6T
	gcFYSkGdXsUYbsT7xMRYbQYcquS8zLMPU/vEAmWpOFn14CslaMVC+kq3qqx2IjczJiwJZxoLCNGPQ
	hkmpf05fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5FoP-0006mP-6r; Mon, 10 Aug 2020 21:58:33 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5FoM-0006lg-TL
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 21:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1mp0rtcAkv6/8Sb/C8OQ1nOPgn4hg8QKAoywOtE5RU4=; b=BugW6O+1Ts3A0C9mcy7opiDAm4
 3NQKBFp/U0HYmbB1W14sZt9NAfm1iFooIgPlw9J6IhLBjQhWBGQSMSNE51xm95lp5xio0JMS3vjE9
 1CAqQuUVV3HsgOYRaRTCOoc7ndQJhJDXYjqMnyrj5p/bT0MJ39amHVUsGiy/XceXAL0ZhzUMX5T9m
 +KOQN08etaaYXnl7bT/BySI/ilBL4Ti6oMmNy5nX+u4kCH2iEeHfQ0RrUh9BRtdoYLqMDF+4Vq+Xl
 klSIxtM7+65aJLriZecutTObYrIFf3CiDxoNlRLirAj8j2WRZP9F//EkGGdN8oWIlM8GZs/Jn18XP
 Unmaz4VA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5FoK-0000Di-0d; Mon, 10 Aug 2020 15:58:28 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f7dfd268-9b02-4711-85d4-eebd8614f8d8@deltatee.com>
Date: Mon, 10 Aug 2020 15:58:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/14] nvmet: get rid of the extra variable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_175830_963746_EE97F96D 
X-CRM114-Status: GOOD (  21.82  )
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
> In function nvmet_passthru_execute_cmd() the return value of the
> function nvmet_passthru_map_sg() is not used to determine stauts i.e.
> we can safely ignore the actual cause of error that is returned and just
> check for binary status pass or fail.
> 
> The prior check to this function call can be combined safely with the &&
> so that we can get rid of the extra variable and second if condition.
> 
> Remove the extra variable and adjust the code accordingly to have only
> one if condition.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/passthru.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 58377420874f..9a175b8b9d57 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -221,7 +221,6 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>  	struct request *rq = NULL;
>  	u32 effects;
>  	u16 status;
> -	int ret;
>  
>  	if (likely(req->sq->qid != 0)) {
>  		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
> @@ -242,12 +241,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>  		goto out_put_ns;
>  	}
>  
> -	if (likely(req->sg_cnt)) {
> -		ret = nvmet_passthru_map_sg(req, rq);
> -		if (unlikely(ret)) {
> -			status = NVME_SC_INTERNAL;
> -			goto out_put_req;
> -		}
> +	if (likely(req->sg_cnt) && unlikely(nvmet_passthru_map_sg(req, rq))) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_put_req;
>  	}

IMO, that's really ugly and not at all an improvement.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
