Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AEDC4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 07:15:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF0622275
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 07:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eWlVVH6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF0622275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aIAIEcJKvXOFNQHQJHsO/ktNR6EKQ5ICtFKFvfTdzys=; b=eWlVVH6ulustWma0dQMriXxOx
	09++VFzNDfG8x69uPVinOJColI3OURAszjHOtHbOjhKfgAVw3XyoiitCmkcRHSSeQnkOR3hwBjPGj
	wc78Wg91yWTgRXEBX7Ud0/5/ge/pKM+QbmlhiQ6yE3uiGOqTiZuZ7V4FWuT9FzcQEZ3v7jbP+BW1h
	1eWUBkcjzf5J0k3oKtIX1A0CR/sHkJsyjy+gldhflAccFE7e5DzZ1PUMUEW+AgdWnZv0C3/s5d1yT
	y74YHapuNA3alEk5zqVA2Wu06CpmqHoagg+EtR5/sCJqyt5GiCtcfy1FROFV2kKEvzjpIxMlM79Ge
	pvBaoqgFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXffu-0001hp-Qq; Wed, 28 Oct 2020 07:15:14 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXffq-0001hS-2W
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 07:15:11 +0000
Received: by mail-pj1-f65.google.com with SMTP id h4so2029223pjk.0
 for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2020 00:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iQWMFgTL/g1cDwMTtMSRR9uxZa2RFRhOoqtzI84yFZI=;
 b=hDnubauL9Zfnh3G9WieQ9N3DUeSY0atAsLsdTscdy2jdHFjiea5tmiPwO1neP04I5V
 bM7cVEVhzVchU4W2V9ugBKFhDoElCNPVAnuD5ie7WXyQczinOUh7BBFL7//W8IOT5nr9
 R0Ee6y9W6hzec+FF9+fTExmmMSO/TqA84jTXN91H0LhVAfHxaJF7KQ9DqI8wmocbI6m0
 xJgOsB/kTK/mli1Soo9u3EMAhDoxdaSIn5U+3n2d2KtvgBkcaJHEWtDOWlp6XW/A3tOJ
 vkNiZNxYU+kXJNlrc1Xu81UC2gZqD17atumOi3C2cIelDgqUes/wmopwENZflyOnpXxW
 am/w==
X-Gm-Message-State: AOAM530O9+3oBq0CmM9OjnzWvbLBvKg1lbVtPVg4xw8g3HlJTdfg6446
 N2pAwqFwebo5iRSBLso8e4SDdwvRKIk=
X-Google-Smtp-Source: ABdhPJznHoWcGJ/5HK7isQqT5Bd+ED3gs24v+mxa/4YxSlZkUySwloM1A2qzgyd5YZ6/oTRFCGMYPQ==
X-Received: by 2002:a17:902:9890:b029:d5:e447:6b32 with SMTP id
 s16-20020a1709029890b02900d5e4476b32mr5927231plp.51.1603869308349; 
 Wed, 28 Oct 2020 00:15:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8235:3100:f389:bca1?
 ([2601:647:4802:9070:8235:3100:f389:bca1])
 by smtp.gmail.com with ESMTPSA id 198sm4836143pfy.41.2020.10.28.00.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 00:15:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: introduce transport layer keep-alive
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de,
 chaitanya.kulkarni@wdc.com
References: <20201027121546.1776104-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bbbb8d0e-22a3-0e94-9a0a-b7ce1792a1ae@grimberg.me>
Date: Wed, 28 Oct 2020 00:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027121546.1776104-1-pizhenwei@bytedance.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_031510_172309_5906CBCE 
X-CRM114-Status: GOOD (  22.54  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/27/20 5:15 AM, zhenwei pi wrote:
> In the zero KATO scenario, if initiator crashes without transport
> layer disconnection, target side would never reclaim resources.
> 
> A target could start transport layer keep-alive to detect dead
> connection for the admin queue.

Not sure why we should worry about kato=0, it's really
more for debug purposes. I'd rather that we block this
option from the host altogether.

> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  2 +-
>   drivers/nvme/target/core.c      | 14 +++++++++++---
>   drivers/nvme/target/nvmet.h     |  3 ++-
>   3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index dca34489a1dc..53fbd5c193a1 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -729,7 +729,7 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
>   
>   	nvmet_stop_keep_alive_timer(req->sq->ctrl);
>   	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
> -	nvmet_start_keep_alive_timer(req->sq->ctrl);
> +	nvmet_start_keep_alive_timer(req->sq->ctrl, req);
>   
>   	nvmet_set_result(req, req->sq->ctrl->kato);
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 957b39a82431..451192f7ad6a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -395,10 +395,18 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
>   	nvmet_ctrl_fatal_error(ctrl);
>   }
>   
> -void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
> +void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   {
> -	if (unlikely(ctrl->kato == 0))
> +	if (unlikely(ctrl->kato == 0)) {
> +		if (req->ops->keep_alive)
> +			pr_info("ctrl %d starts with transport keep-alive %s\n", ctrl->cntlid,
> +				req->ops->keep_alive(req) ? "failed" : "succeed");
> +		else
> +			pr_info("ctrl %d starts without both NVMeOF and transport keep-alive",
> +				ctrl->cntlid);
> +
>   		return;
> +	}
>   
>   	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
>   		ctrl->cntlid, ctrl->kato);
> @@ -1383,7 +1391,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	ctrl->err_counter = 0;
>   	spin_lock_init(&ctrl->error_lock);
>   
> -	nvmet_start_keep_alive_timer(ctrl);
> +	nvmet_start_keep_alive_timer(ctrl, req);
>   
>   	mutex_lock(&subsys->lock);
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 559a15ccc322..de1785ce9fcd 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -305,6 +305,7 @@ struct nvmet_fabrics_ops {
>   	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
>   	void (*discovery_chg)(struct nvmet_port *port);
>   	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
> +	int (*keep_alive)(struct nvmet_req *req);
>   };
>   
>   #define NVMET_MAX_INLINE_BIOVEC	8
> @@ -395,7 +396,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req);
>   u16 nvmet_set_feat_kato(struct nvmet_req *req);
>   u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
>   void nvmet_execute_async_event(struct nvmet_req *req);
> -void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
> +void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
>   void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
>   
>   u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
