Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279E6C2BB41
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=an2BEHvdWy2Lll1Dzj2R6KECBeA1H3BPaxlAK3IZvfs=; b=CBNTeVSEiaOzozXpnTnF77jIEV
	FzjUGe4s4mVMDxCLx2DMAQ7P0kD5tTDWpiEZ9SBRyGpCuEM3la88stCkCI4i1KM+/aniKtRwvHKu6
	gyxS3Quani+kz6uvliNL2AxyJf1Spt7kKWl1Lt+w3WLK+3LOLrXNg7mBdPu2Wtt5dexTOVEAYH89t
	GVc4cHu7AWncLPFGYwUZ/dNJI8MKFWRegn6/E/n5jYVNZlRfGDVtP15DunJ22D0T8g2FvAVB/gIh/
	Oqs1GS/goPr2G355bzCb5Tx51j0ZJyVezrlM8C9bckjY8GyI1DQCD50uJ+VM2GhVCtHfItdNy7NKf
	nJGVFgbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNsKc-00H1iS-MC; Tue, 16 Aug 2022 08:53:50 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNsKY-00H1Yu-Uq
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 08:53:49 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M6Px36zBwz1M8y8;
	Tue, 16 Aug 2022 16:50:15 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 16:53:34 +0800
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
To: Keith Busch <kbusch@fb.com>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jonathan Derrick
	<Jonathan.Derrick@solidigm.com>
References: <20220812182147.1564958-1-kbusch@fb.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e034ba1d-b43e-6813-37b8-7b341dbdb573@huawei.com>
Date: Tue, 16 Aug 2022 16:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220812182147.1564958-1-kbusch@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_015347_441232_1CFAF044 
X-CRM114-Status: GOOD (  20.80  )
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

Looks good to me.
Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/8/13 2:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If a reset occurs after the scan work attempts to issue a command, the
> reset may quisce the admin queue, which blocks the scan work's command
> from dispatching. The scan work will not be able to complete while the
> queue is quiesced.
> 
> Meanwhile, the reset work will cancel all outstanding admin tags and
> wait until all requests have transitioned to idle, which includes the
> passthrough request. But the passthrough request won't be set to idle
> until after the scan_work flushes, so we're deadlocked.
> 
> Fix this by moving the flush_work after the request has been freed.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216354
> Reported-by: Jonathan Derrick <Jonathan.Derrick@solidigm.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c  |  5 ++---
>   drivers/nvme/host/ioctl.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af367b22871b..1143f625e195 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1121,12 +1121,11 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
>   		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
>   		mutex_unlock(&ctrl->scan_lock);
>   	}
> +
>   	if (effects & NVME_CMD_EFFECTS_CCC)
>   		nvme_init_ctrl_finish(ctrl);
> -	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
> +	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
>   		nvme_queue_scan(ctrl);
> -		flush_work(&ctrl->scan_work);
> -	}
>   
>   	switch (cmd->common.opcode) {
>   	case nvme_admin_set_features:
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 27614bee7380..97febd5f41a3 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -136,9 +136,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
>   		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
>   {
> +	struct nvme_ctrl *ctrl;
>   	struct request *req;
>   	void *meta = NULL;
>   	struct bio *bio;
> +	u32 effects;
>   	int ret;
>   
>   	req = nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
> @@ -147,6 +149,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   		return PTR_ERR(req);
>   
>   	bio = req->bio;
> +	ctrl = nvme_req(req)->ctrl;
> +	effects = nvme_command_effects(ctrl, q->queuedata, cmd->common.opcode);
>   
>   	ret = nvme_execute_passthru_rq(req);
>   
> @@ -158,6 +162,14 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   	if (bio)
>   		blk_rq_unmap_user(bio);
>   	blk_mq_free_request(req);
> +
> +	/*
> +	 * Ensure the namespace inventory is up-to-date before returning if
> +	 * this command can change it.
> +	 */
> +	if (ret >= 0 && effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
> +		flush_work(&ctrl->scan_work);
Maybe it is better to move nvme_queue_scan together here.
> +
>   	return ret;
>   }
>   
> 

