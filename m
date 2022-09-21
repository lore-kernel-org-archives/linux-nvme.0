Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D533AC6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 01:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pYNTElWAhP7B+iFoCIePLknIr0yf5uymv0DnvcNpTo=; b=szW5u+rCol97DUAb4FrQRLPYu3
	pDdNT0qn3Fxh2U1wL7Rn6UGpYgXka5nEW3SX3n87uEmPyauWlKKEMCdeQLg4PDMbRUKRGWur/mLMf
	6+c8Z1SxKIXWtg3cXLam2fswvyJOMwYVMqjXCBi16K3kXpl5oYNFlHsYaArwczhrCoGjH0BsALZCH
	oVL7761/R/LEW3+cM0xxYfzhry7k/jAHteAn8gf9ksyzFXsMZC/yKsQ4dFQqGHhNN0Va7pF1zND77
	SKmzKjY6hYioiwzl0sNjqUIv3Dwq+Ofbn+/sMpqrh1ZH2z4EopZL7mHDgy6QYT4lPKt5zRpnEs+OA
	qKBTj6fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaomj-0081gg-90; Wed, 21 Sep 2022 01:44:21 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaomg-0081cs-5R
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 01:44:20 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXLhF4FzYzmW5f;
	Wed, 21 Sep 2022 09:40:13 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:44:08 +0800
Subject: Re: [PATCHv2] nvme: handle effects after freeing the request
To: Keith Busch <kbusch@fb.com>, <linux-nvme@lists.infradead.org>,
	<hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Jonathan Derrick
	<Jonathan.Derrick@solidigm.com>
References: <20220919193646.1599162-1-kbusch@fb.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <94ba8746-0924-7a95-a31f-36b993ba177f@huawei.com>
Date: Wed, 21 Sep 2022 09:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220919193646.1599162-1-kbusch@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_184418_574279_6C1E21DD 
X-CRM114-Status: GOOD (  21.06  )
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/9/20 3:36, Keith Busch wrote:
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
> Fix this by handling the end effects after the request has been freed.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216354
> Reported-by: Jonathan Derrick <Jonathan.Derrick@solidigm.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Open code the effects end handling in each of the callers instead of
>    special casing just the 'flush_work' part.
> 
>   drivers/nvme/host/core.c       | 17 ++++++-----------
>   drivers/nvme/host/ioctl.c      |  9 ++++++++-
>   drivers/nvme/host/nvme.h       |  4 +++-
>   drivers/nvme/target/passthru.c |  7 ++++++-
>   4 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8c9c1176624d..ea6694fd550f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1111,8 +1111,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   	return effects;
>   }
>   
> -static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
> -			      struct nvme_command *cmd, int status)
> +void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
> +		       struct nvme_command *cmd, int status)
>   {
>   	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
>   		nvme_unfreeze(ctrl);
> @@ -1148,21 +1148,16 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
>   		break;
>   	}
>   }
> +EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
>   
> -int nvme_execute_passthru_rq(struct request *rq)
> +int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
>   {
>   	struct nvme_command *cmd = nvme_req(rq)->cmd;
>   	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>   	struct nvme_ns *ns = rq->q->queuedata;
> -	u32 effects;
> -	int  ret;
>   
> -	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> -	ret = nvme_execute_rq(rq, false);
> -	if (effects) /* nothing to be done for zero cmd effects */
> -		nvme_passthru_end(ctrl, effects, cmd, ret);
> -
> -	return ret;
> +	*effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> +	return nvme_execute_rq(rq, false);
>   }
>   EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
>   
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 27614bee7380..d3281f87cd6e 100644
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
> @@ -147,8 +149,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   		return PTR_ERR(req);
>   
>   	bio = req->bio;
> +	ctrl = nvme_req(req)->ctrl;
>   
> -	ret = nvme_execute_passthru_rq(req);
> +	ret = nvme_execute_passthru_rq(req, &effects);
>   
>   	if (result)
>   		*result = le64_to_cpu(nvme_req(req)->result.u64);
> @@ -158,6 +161,10 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   	if (bio)
>   		blk_rq_unmap_user(bio);
>   	blk_mq_free_request(req);
> +
> +	if (effects)
> +		nvme_passthru_end(ctrl, effects, cmd, ret);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1bdf714dcd9e..a0bf9560cf67 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1023,7 +1023,9 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
>   
>   u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			 u8 opcode);
> -int nvme_execute_passthru_rq(struct request *rq);
> +int nvme_execute_passthru_rq(struct request *rq, u32 *effects);
> +void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
> +		       struct nvme_command *cmd, int status);
>   struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
>   struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
>   void nvme_put_ns(struct nvme_ns *ns);
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 6f39a29828b1..94d3153bae54 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -215,9 +215,11 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>   {
>   	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
>   	struct request *rq = req->p.rq;
> +	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> +	u32 effects;
>   	int status;
>   
> -	status = nvme_execute_passthru_rq(rq);
> +	status = nvme_execute_passthru_rq(rq, &effects);
>   
>   	if (status == NVME_SC_SUCCESS &&
>   	    req->cmd->common.opcode == nvme_admin_identify) {
> @@ -238,6 +240,9 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>   	req->cqe->result = nvme_req(rq)->result;
>   	nvmet_req_complete(req, status);
>   	blk_mq_free_request(rq);
> +
> +	if (effects)
> +		nvme_passthru_end(ctrl, effects, req->cmd, status);
>   }
>   
>   static void nvmet_passthru_req_done(struct request *rq,
> 

