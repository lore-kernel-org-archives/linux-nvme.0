Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790F6C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 01:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cOSys9NZHQpHRYWmgnimn/Nu4HZ11el9o5hMuxrQVQ=; b=YZuo7MsQBXfXkSkpbhsQlRi5jp
	nA2F0q5qU3E39Ts4sXGQIaWJIvWm34yM0VISktXfGQmDVpuWBFkp+dLGxDc7V2ucBCEDe70zerGiI
	mwwNoQgK3j8l0FoWPl0mgdFt3uz4ybXmAbT5SwEKYG1cIw2t4aWR+BxQoFufoQsMgqzrh15/hMRpg
	DgUXYmgc2/cTsZR5dAXUOWJBt7qWmkqTR6l8SSEIrR0yF2hEQOcTIfnxAK60moZF66KOKgY+95iH8
	XFMyejXqG2e5PqRzbI7uLtjlbAWhs/UzMpNVCVudLAZPh2rj8AswuUFUmXkmBOge7rRQL4xfo1gBj
	T90s/YDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwcP-0000000Ex60-4B21;
	Sun, 23 Aug 2026 01:03:25 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwcN-0000000Ex5S-1A0n
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 01:03:24 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so3854986a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 18:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447001; x=1788051801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cOSys9NZHQpHRYWmgnimn/Nu4HZ11el9o5hMuxrQVQ=;
        b=Z72ct5OUX5pgFiv8NLDbBNmlV2OjJAuJxVRijcbTvnODbX8FPuJvReoH2FilQXPasy
         N7nL/Q7S3NIM4EBMdA11MckUWloJ0G38N91BUWF0p2J3mtqKnuLlwCn7QXHrDwd72j3B
         erl+Yr5xqc/XqHjGALDN3JMpZDy2B5cGZQCtBlb6RM3CzOBIMRmeZ7DYr6XokV5+8ZK+
         oj9lCqK3fHFNdqx7R+iadnA9c8NPRDPyCObee5ScO3bJltkOo5aZOuVdeM9sNVS5A684
         x7ms2NpVx0LGR0yHy7M255zOE8gffaNPk8+OaXgCYUi4PNpiERZSLutdF7i3WSL2sRqv
         tUbw==
X-Forwarded-Encrypted: i=1; AHgh+RpEImeFq9DO8EBelcMK9AnXPtdEscZIgZyltadlMk61m5q9kXeyt6w8fJ5RuLAAXCs6rn2MaQi2IHun@lists.infradead.org
X-Gm-Message-State: AFuF++lia+Y3yM9E1nF3KNGDQQVbQZBpElX10NvlPugD4eXebYW3YqT6
	8JC4nlh6dZkfc4Dw1RPPKWBCCZWFRcRrCfEUWd62kPO+/yaGGRvwkPX9
X-Gm-Gg: AR+sD121v1ksMxMk++8kGfEzlKZATemPpnlqMLacDWRMrabSzkRvpmpJmT4kbUBgpwC
	iR/llvKPu85uh+BHxcAmmVcrD40dWcQ6E1woEJGsN9Mg+d0G0JJ3FTZ5lVW7bPfLAGAiqEobazW
	MEDuLw6Duh7KngsWSfn1CoinuhkfC5C+XDAgld+AP9talV6tlSKsZ3xtuKk8S6DP1qUADL40HYG
	WggqCjGzlMEWUIGMwod3WEUF8mymLNzlKowWJWcqHOam8GHdoUHlwKEeTOZzT59YxQM+8rDnNiD
	qbmgiOOu7SeDoUH+PB3qllOF3X99QFrqYTowQwk+zP9FzT6jQCpHafO7byjXaMm4Z2ptrkrP7ID
	ktZAC8yYVOBZN84EUfda+vgQ0OZau2b9BARF0fCtgF6aVeIt3bOWvMT+4/SfdGPWIUZ8hnoG3UH
	7lVEa7GtYKHOqpwPmiruw4MtLr6rpjSjmZ1zKQfnA1pyTWPA2zxTbqUrZ/EHOyqxOXTfQQTVs0q
	UI7vnheGBSAnniTbvBJdPQ=
X-Received: by 2002:a05:6402:320c:b0:6a3:fdb0:c374 with SMTP id 4fb4d7f45d1cf-6a42f2054b1mr19479957a12.13.1787447001285;
        Sat, 22 Aug 2026 18:03:21 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e19a05bsm695651a12.17.2026.08.22.18.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 18:03:20 -0700 (PDT)
Message-ID: <3bc07e43-750d-4e8d-a209-e1d45acbb230@grimberg.me>
Date: Sun, 23 Aug 2026 04:03:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-11-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-11-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_180323_343111_E85F56AE 
X-CRM114-Status: GOOD (  18.80  )
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



On 12/07/2026 5:23, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..a1711dd1d3c2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -161,6 +161,7 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> +	struct work_struct	fencing_work;
>   	struct work_struct	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
> @@ -605,6 +606,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   {
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->device, "starting controller fencing\n");
> +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> +		return;
> +	}
> +
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>   		return;
>   
> @@ -2494,12 +2501,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
> +static void nvme_tcp_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> +			struct nvme_tcp_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	rem = nvme_fence_ctrl(ctrl);
> +	if (rem)
> +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> +}
> +
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   {
>   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
>   				struct nvme_tcp_ctrl, err_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);

Agree we shouldn't be here with fencing work running.

>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_keep_alive(ctrl);
> @@ -2542,6 +2566,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);

Isn't it being called in nvme_stop_ctrl? - perhaps it should be called 
in ->stop_ctrl() callback.

Other than that, this looks reasonable to me.

