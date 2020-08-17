Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E206C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 03:41:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEE3206A4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 03:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yyh+593B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEE3206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Krk/ZtK4mpvczxApmDUbTBWYg0UCxc36fYF8fPccaRE=; b=Yyh+593B5vwcD1a9Yd4h+l0E8
	d7oUDX5V5yKITmGDb2rw4Sz4b5Nit6P2z1cadjkybw7Ct4E5a62iUEmp9pgrHBOV343K0zYsTxqtE
	yu5GqceEHn3Mk0xSh/3UNGGthnPC6sbPUMfCMtaT/ktPjiu7SXeF8QPStTn/VzGLbDfGZy6VXqU3Y
	hBf3v0IijZJbF4IIvKs6Wgh5McwZq5phA5Cli0SnsHBvOSpfzMofxqhDEgoQImSdAwgmYiVirEIoc
	cSo/hJ8v5Jj28nhjm4TbJPBXWfAEp+TKDnWuxYvKFXhJuRy+ectMjq4eI+uOSzDBm6IAV3N1ktEB+
	oQ5SyJyGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7W1V-0003pQ-45; Mon, 17 Aug 2020 03:41:25 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7W1R-0003l8-Gv
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 03:41:23 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C9478D34EDE4FECE5A3B;
 Mon, 17 Aug 2020 11:41:16 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 17 Aug 2020 11:41:14 +0800
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
To: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <fa05af11-d82a-13a4-e892-6dd8e65bf981@huawei.com>
Date: Mon, 17 Aug 2020 11:41:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200814151528.277465-4-hch@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200816_234122_209787_1B11DE66 
X-CRM114-Status: GOOD (  16.74  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/14 23:15, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> If a command send through nvme-multupath failed on a dying queue, resend it
> on another path.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of the completion refactoring]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8d474adad721fb..271cb9bf29dcd0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -275,13 +275,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   		return COMPLETE;
>   
>   	if (req->cmd_flags & REQ_NVME_MPATH) {
> -		if (nvme_is_path_error(status))
> +		if (nvme_is_path_error(status) || blk_queue_dying(req->q))
>   			return FAILOVER;
> +	} else {
> +		if (blk_queue_dying(req->q))
> +			return COMPLETE;
>   	}
>   
> -	if (blk_queue_dying(req->q))
> -		return COMPLETE;
> -
>   	return RETRY;
>   } 
If path related error, retry maybe fail again. So we should not retry local
for path related error. Suggest do like this:
	if (nvme_is_path_error(status) || blk_queue_dying(req->q)) {
		if (req->cmd_flags & REQ_NVME_MPATH)
			return FAILOVER;
		else
			return COMPLETE;
	}
	return RETRY;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
