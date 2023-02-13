Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12993C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ibeZKyoUDHdKplTx+a8TCV5vIMMLJvF9xWSvruzqHKE=; b=atzk4X/ZkLwAjyO56W4fHeX/DG
	cc4AxJ7WN+zMP+QGX01wfoHsEKjZWIE2L8F7K+m5SXZWNvk6Z4B5giSLHgwn4fyI7IjWazSGj716F
	qaqooqmmokS8zIxh9BH+AGoGDVS6pn5pTvq3XUvEV5hUek/lspr9STSs5m+dTZDoSq0Bhji5clpCy
	P/earPUrvHqVkCUiWPkaiBrKNDox9UpGn+7vH87ZwkIplm6ih93BBERNeWe6bQFtOyoslLvpXE1VE
	2W8nHQFcP8LJdqH5yU83XCKOrsPgMQFXIxJAqLYcyEswiw784tomXXsAGtlLEs1H5CaOD81q0eosW
	jIFB14zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVcf-00E0Kk-FT; Mon, 13 Feb 2023 09:59:45 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVca-00E0HT-3r
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 09:59:43 +0000
Received: by mail-wm1-f41.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso2385748wms.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 01:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibeZKyoUDHdKplTx+a8TCV5vIMMLJvF9xWSvruzqHKE=;
        b=hH0XzRwUnzg6V+C/mnbK/wD6VN5i65NLFdBaRGxyudlG0S5ZMK2FXQYS+jZmBw+Z/T
         Y4Wr4TvxdlbH7fkBQ0QdPhE4e2r+81aGNahmlhvpGhGJlzlfWUAm5t5OZUV3P79rtupr
         zWV2Gy6GkNqnyqUTP4YwVsG4OSIQGfoyfRWRMq8MWE1I+rCt2GnZEoxZeFwzB7Q1wUHA
         ah2u6ppkrolrHQZ9q7vLBKh5yvv78lbzcHvUo21/4qoQYThKADvXzW6nK5ql8CAHa8m6
         znhBySlDjCIbziVGrKVH+JLy7bN7kzINMC+O+Ms/Y3AJGUnCRv52gjJwljQ7dl810d/l
         SlEg==
X-Gm-Message-State: AO0yUKUSS9OdprKLeKsyoBMnfRUNvgjN6EVgdKGT5ehjYzWeann+RGql
	Vq7eQGk2XRd1pZBEeMMkb68=
X-Google-Smtp-Source: AK7set8kmTXI2IPdPeS/Ea2gOhYsXTFK0172oTajfmJHB6+w9ixFDiE8tzE3eT7sl911xIV3MMcidg==
X-Received: by 2002:a05:600c:3b8b:b0:3e1:bfc:f57b with SMTP id n11-20020a05600c3b8b00b003e10bfcf57bmr16957555wms.2.1676282376357;
        Mon, 13 Feb 2023 01:59:36 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003e1df9bc86csm6816842wmz.3.2023.02.13.01.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:59:35 -0800 (PST)
Message-ID: <a2b720a1-962b-5314-2475-8908a877b943@grimberg.me>
Date: Mon, 13 Feb 2023 11:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] nvme: move result handling into nvme_execute_rq()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230209143820.118097-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_015940_190940_6BECB338 
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



On 2/9/23 16:38, Hannes Reinecke wrote:
> and simplify the calling convention.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c       | 16 ++++++++++------
>   drivers/nvme/host/ioctl.c      |  5 +++--
>   drivers/nvme/host/nvme.h       |  3 ++-
>   drivers/nvme/target/passthru.c |  3 +--
>   4 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 78da9c6cbba8..11faebe87764 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1004,15 +1004,21 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
>    * >0: nvme controller's cqe status response
>    * <0: kernel error in lieu of controller response
>    */
> -int nvme_execute_rq(struct request *rq, bool at_head)
> +int nvme_execute_rq(struct request *rq, union nvme_result *result,
> +		    bool at_head)
>   {
>   	blk_status_t status;
> +	int ret;
>   
>   	status = blk_execute_rq(rq, at_head);
>   	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
>   		return -EINTR;
> -	if (nvme_req(rq)->status)
> -		return nvme_req(rq)->status;
> +	ret = nvme_req(rq)->status;
> +	if (ret) {
> +		if (result && ret >= 0)

How can ret be < 0 here?

Why not always take the result, unconditionally?

Is this really necessary though?

> +			*result = nvme_req(rq)->result;
> +		return ret;
> +	}
>   	return blk_status_to_errno(status);
>   }
>   EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
> @@ -1048,9 +1054,7 @@ int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
>   	if (ret)
>   		goto out;
>   
> -	ret = nvme_execute_rq(req, at_head);
> -	if (result && ret >= 0)
> -		*result = nvme_req(req)->result;
> +	ret = nvme_execute_rq(req, result, at_head);
>    out:
>   	blk_mq_free_request(req);
>   	return ret;
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 723e7d5b778f..cdba543cbd02 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -220,6 +220,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   		u64 *result, unsigned timeout, unsigned int flags)
>   {
>   	struct nvme_ns *ns = q->queuedata;
> +	union nvme_result res;
>   	struct nvme_ctrl *ctrl;
>   	struct request *req;
>   	void *meta = NULL;
> @@ -243,9 +244,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>   	ctrl = nvme_req(req)->ctrl;
>   
>   	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> -	ret = nvme_execute_rq(req, false);
> +	ret = nvme_execute_rq(req, &res, false);
>   	if (result)
> -		*result = le64_to_cpu(nvme_req(req)->result.u64);
> +		*result = le64_to_cpu(res.u64);
>   	if (meta)
>   		ret = nvme_finish_user_metadata(req, meta_buffer, meta,
>   						meta_len, ret);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9b4b3bb69e27..a63650b00d1a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1071,7 +1071,8 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
>   u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			 u8 opcode);
>   u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
> -int nvme_execute_rq(struct request *rq, bool at_head);
> +int nvme_execute_rq(struct request *rq, union nvme_result *result,
> +		    bool at_head);
>   void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
>   		       struct nvme_command *cmd, int status);
>   struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index aae6d5bb4fd8..f5ab4d7a8c1f 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -221,7 +221,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>   	int status;
>   
>   	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
> -	status = nvme_execute_rq(rq, false);
> +	status = nvme_execute_rq(rq, &req->cqe->result, false);
>   	if (status == NVME_SC_SUCCESS &&
>   	    req->cmd->common.opcode == nvme_admin_identify) {
>   		switch (req->cmd->identify.cns) {
> @@ -238,7 +238,6 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>   	} else if (status < 0)
>   		status = NVME_SC_INTERNAL;
>   
> -	req->cqe->result = nvme_req(rq)->result;
>   	nvmet_req_complete(req, status);
>   	blk_mq_free_request(rq);
>   

