Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B7C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:00:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF8C64EB7
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF8C64EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0ZH3b3gVAVatnXd34ziPVCDJm+bCNAgV520b6NkZeLw=; b=QeXu5fWxW7sO4r4EkviwnZoPs
	FD3fHHxzLPP0iubzaDhu1ldXIlh2960ENbrbGxgSzCqhgIR/C0PiGLzhWZD+Q23UMhay3+8sqMBDg
	AxbHKLRl62XhEEnpsQVLKcil4xwnpeg1wVuvDt0DwynHoiFuz00HROfbEJO6rQelRX2m0N6ak4qz5
	kB4pG5k0MpGdHDo0/Mk9IjUsz/gsYZcTjfcX2HOIyzOdzHuy4+oBCy+8ztrxInfRKqAhTh666ZJKw
	rmxbo5Gby5ZsHjMrvwtr2pmZkOCv/SHL39Nl/aN7PlqI9BGkRTClYn7Yzo1AnotMEd6Flz7Be4G32
	Zz04QzvXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFRU6-0000eG-5r; Fri, 26 Feb 2021 00:59:58 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFRU2-0000dO-CN
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 00:59:55 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Dmrq92hCnz5Vcm;
 Fri, 26 Feb 2021 08:57:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 08:59:43 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 08:59:43 +0800
Subject: Re: [PATCH 5/6] nvme: return NVME_SC_ABORT_QUEUE for cancelled
 commands
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-6-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <fd89fa3f-0c25-1cd0-a47d-06fca59469b7@huawei.com>
Date: Fri, 26 Feb 2021 08:59:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210225105527.75277-6-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_195954_672018_07D14BF6 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/25 18:55, Hannes Reinecke wrote:
> A request will be cancelled when a queue is deleted, so we should
> be returning a status of NVME_SC_ABORT_QUEUE.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   drivers/nvme/host/fc.c   | 9 ++++++---
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 04dc85e0810c..624531a6b7c6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -379,7 +379,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   	if (blk_mq_request_completed(req))
>   		return true;
>   
> -	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> +	nvme_req(req)->status = NVME_SC_ABORT_QUEUE;
Use NVME_SC_ABORT_QUEUE instead of NVME_SC_HOST_ABORTED_CMD is not a good idea.
NVME_SC_HOST_ABORTED_CMD is a host path related error, Now used to check if need
fail over retry by multipath.
>   	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   	blk_mq_complete_request(req);
>   	return true;
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 97e3424c7b03..86395b66310d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1955,9 +1955,12 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
>   				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
>   
> -	if (opstate == FCPOP_STATE_ABORTED)
> -		status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
> -	else if (freq->status) {
> +	if (opstate == FCPOP_STATE_ABORTED) {
> +		if (op->nreq.flags & NVME_REQ_CANCELLED)
> +			status = cpu_to_le16(NVME_SC_ABORT_QUEUE << 1);
> +		else
> +			status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
> +	} else if (freq->status) {
>   		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
>   		dev_info(ctrl->ctrl.device,
>   			"NVME-FC{%d}: io failed due to lldd error %d\n",
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
