Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47581C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 20:42:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F2F61181
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 20:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4F2F61181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2ATB5B/aAuHb+uySg2JtlPSRQS6pY/8etvVfv+DRi8=; b=B2FAIjvFrg2EUh08H9cLKhWm4V
	uJtm0VpVr8pOmzR7ILoxmjjUJzZpJtobHl/hcAWaFnJiFo74yAvTjnR4BuqltX9aedavTlc3e6bFD
	7Tw7TUItYWm4sT0AiRl45TzBAcM0GWzhDpFq3GWLipjDxne/3ZO1EAUzlmwnhyl5TTjHaPrOZjmb1
	bkj4EHc3rGQ7Ic1B/0O0MJQ9Q3rzDcuZRmivhRraLxbNtmkIJ5Hi3OUZejEvJM83JHDzIaqlCftmK
	UOpUst1sUE9d9MWBh4E6Q1DN9dQgK8tfOKtdiCFf4EEKNtYZ070+QL7ezSdt+ph9+/CQEEIAJGyyT
	1IWJXoug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIdF2-004fMI-Rb; Tue, 24 Aug 2021 20:41:52 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIdEz-004fLZ-82
 for linux-nvme@lists.infradead.org; Tue, 24 Aug 2021 20:41:50 +0000
Received: by mail-ej1-f50.google.com with SMTP id ia27so24742518ejc.10
 for <linux-nvme@lists.infradead.org>; Tue, 24 Aug 2021 13:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lXjlGQeZwtGrCrOOb0RdT7e8+O8LKwMxLevcNbK09wA=;
 b=jpJYs8Pzltfv0CJ0CUcKDsSwMr27z6GHnZIERhiaafjQgiHgg68TKxyZMTvHaHig+d
 e1mHJDDpqyZSIFDh7XasiZq/jJQDS3Ki6l3DSrvMAo7UOLSjj7upBHGuWyVB0zrobl0H
 6B0kDf1cyMJlv39cQM7rJZkadUoSN1m8HxyMbDzfBZ+oNUeCBRAjG1IbYDjnIJ14Cfn0
 v+8IZ69q1NyUqWCBA4R5kfbJLrAA7r8KiRv9b0gXZf5lmTALYiEY/KVgYetUIpJVvTV8
 trKVoJienPOBEcIKrxW/44lbEmQD5sOp6isHfT7biSC/ZDddYoQsXstKMddJguT0eHit
 xrww==
X-Gm-Message-State: AOAM533CoTuPi4f2NXgTpujHWZ+M1UVdoQwqw/7VLnT3sdyQWaM7eDke
 iJkkGZPU8gYGPOukNt+lYEQ=
X-Google-Smtp-Source: ABdhPJxMtUR08EyoMF/xqa4kwmDcm1cw/WJoelupOJTNc0gB5HITs9wnej4S7UMh5AyF1F0bG/a03A==
X-Received: by 2002:a17:906:d057:: with SMTP id
 bo23mr42625526ejb.208.1629837707333; 
 Tue, 24 Aug 2021 13:41:47 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id js21sm4370502ejc.35.2021.08.24.13.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 13:41:47 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is modified
To: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
Date: Tue, 24 Aug 2021 13:41:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210824_134149_350122_49161B76 
X-CRM114-Status: GOOD (  28.24  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/23/21 10:44 PM, sasaki tatsuya wrote:
> Currently the connection between host and NVMe-oF target gets
> disconnected by keep-alive timeout when a user connects to a target
> with a relatively large kato value and then sets the smaller kato
> with a set features command (e.g. connects with 60 seconds kato value
> and then sets 10 seconds kato value).
> 
> The cause is that keep alive command interval on the host, which is
> defined as unsigned int kato in nvme_ctrl structure, does not follow
> the kato value changes.
> 
> This patch updates the keep alive interval in the following steps when
> the kato is modified by a set features command: stops the keep alive
> work queue, then sets the kato as new timer value and re-start the queue.
> 
> Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
> ---
> Changes since v1:
> - Add nvme_update_keep_alive to update keep alive timer in core routine.
> - Add nvme_user_cmd_post to call nvme_update_keep_alive in ioctl.c
> 
>   drivers/nvme/host/core.c  | 12 ++++++++++++
>   drivers/nvme/host/ioctl.c | 19 +++++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..76f0ee431b11 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1263,6 +1263,18 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   	nvme_queue_keep_alive_work(ctrl);
>   }
>   
> +void nvme_update_keep_alive(struct nvme_ctrl *ctrl, unsigned int new_kato)
> +{
> +	dev_info(ctrl->device,
> +		 "keep alive commands interval on the host is updated from %u ms to %u ms\n",
> +		 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> +
> +	nvme_stop_keep_alive(ctrl);
> +	ctrl->kato = new_kato;
> +	nvme_start_keep_alive(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_update_keep_alive);
> +
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
>   	if (unlikely(ctrl->kato == 0))
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 305ddd415e45..79006bfb5537 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -187,6 +187,22 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
>   	return true;
>   }
>   
> +static void nvme_user_cmd_post(struct nvme_passthru_cmd *cmd,
> +			       struct nvme_ctrl *ctrl)
> +{
> +	/*
> +	 * Keep alive commands interval on the host should be updated
> +	 * when KATO is modified by Set Features commands.
> +	 */
> +	if (cmd->opcode == nvme_admin_set_features &&
> +	    (cmd->cdw10 & 0xFF) == NVME_FEAT_KATO) {
> +		/* ms -> s */

no need for this comment.

> +		unsigned int new_kato = DIV_ROUND_UP(cmd->cdw11, 1000);
> +
> +		nvme_update_keep_alive(ctrl, new_kato);

I think you can now inline nvme_update_keep_alive here, no need to keep
it in a function.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
