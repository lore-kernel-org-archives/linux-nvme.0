Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82880C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 19:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEV/bh6TIeyBF9RZvk4fsPGC/T7IdL+5JXfCNPOX0gg=; b=obJPhMKsSrG4ukC5SUKI2xy2Qg
	Va0buuLiP8QEySFJRD0lGo76N9+9l2wpyB0aU+9FY9PAI6sRWw751wMSN6T/XQnNBXpUKucTC9yUK
	4xJ8ywWIY+wTDO5CqMS9M6Z0T8g7wg4D4Y2n7yYJYgHUsh9V8ZPVjioCEliB4DAaPB2spQmWhe3tg
	sGa7YS3uObRW3dPlFIo679ck1U5Yt4FfDf7cRMlKgdz4y6JSbbdqd6z/QDgr3tYFVSMJHlxXgZb6+
	C+JL1lGbgqKEHMbRepex+ff/GqXq+QGS3OLzl1DcXDBHDQCaJmUlMqCYV1KGFWjNaOVzWdy6SmG4a
	utCn/tQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMa5e-00CR2Z-Qo; Fri, 12 Aug 2022 19:13:02 +0000
Received: from out1.migadu.com ([91.121.223.63])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMa5a-00CQu2-Uq
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 19:13:01 +0000
Message-ID: <8e9c4838-515a-69e4-3933-3d5a6e791deb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1660331568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEV/bh6TIeyBF9RZvk4fsPGC/T7IdL+5JXfCNPOX0gg=;
	b=eKkLyWvhSHI1j0/tKkQZnACNpll0NmYasO1Y3meqU/elK+Ct9kQel5BqvsyyHAhzHSKCuQ
	4GmZJlgcVoemeKekUJRfuLAgc7Pf6yXyYn8sDb5tx9KLGzPlrb6GU6SXPRRo+Q0SAxFGV3
	NK7ciVxRrhAo2FK8+BaMG2fAzUtBRyg=
Date: Fri, 12 Aug 2022 13:12:50 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20220812182147.1564958-1-kbusch@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220812182147.1564958-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_121300_240902_72C9F567 
X-CRM114-Status: GOOD (  20.89  )
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



On 8/12/2022 12:21 PM, Keith Busch wrote:
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

Seems to fix the repro case. Thanks Keith.

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
> +
>   	return ret;
>   }
>   

