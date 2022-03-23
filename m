Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0CFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aP9N1uGUfwl9XXK99ehd9TwG+gGvl78fZHigNzd1wSs=; b=Q7D9qJluBNnaFlQQufBr6piUOA
	pHrfCGOSFOWNIDKD81ad5yN6PWW6/nEsR3AZCE9MDDKedxM4GTo0/qMuMIDnRy7QwlOTzZJbwAOn0
	dbF8EHZFW+5CNfd7Li+AehE1CAZfiRtHlJIKozOjgjbLj5KJA/AcwaEFU7awv4ykGYRPEgE+dj9CZ
	1DOO7nzhwZImuETLwJNjBavcvg26vX2eIJfISqgnZ5m7KfsITJCjkxWxd8uBztgBBg/3y+Z/Vugh6
	9HYjvqV3vDCosmMRrKmFIoOThfTQc/QaV04l1wQwP62teDbBXMUqyYqnx2d6/3BgxYSbq2jjoXF5E
	3i7cLvew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2XF-00DzxE-1l; Wed, 23 Mar 2022 15:04:29 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2XC-00Dzvi-DV
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 15:04:28 +0000
Received: by mail-wr1-f54.google.com with SMTP id t11so2544531wrm.5
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 08:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aP9N1uGUfwl9XXK99ehd9TwG+gGvl78fZHigNzd1wSs=;
 b=JNBUZQ/JXkbWcrgQm+1yUaGwbW/fQjHxgX5YGR7p7Dnq6GBrlOemU6wMAHk6iYABq5
 +101TktcDzQ8Dz3uljEaRD6cjmKv6yyk93LUepqtjaVinweW5gVxYqJriLvdjykibj+6
 3icIIC6K4L9hSZFp6EmERSxFFASjR6CxYqAw+jufTuqK4zPkmcI5ro8bkhPkMfkEdOUN
 6PfAOPTV6SV7UR2s8qqI4XjON2q1+Oi8sGt2kkdzby0wi73ennepWl5YgWFMsgaUSvWg
 lp8Gavfxko45rszr3t4E+QgBB4V6o1YcXQk4FRehzDC57dOxJCbxPv5kTTSXZfuk8zc5
 iQ6Q==
X-Gm-Message-State: AOAM53148dzDuwpx8e+jm5oFRpbSb894EjRts3ORa5W8l4aQGrlZjRbS
 qghBCezj8HPZI3JJdxkECMq/XsOIs4k=
X-Google-Smtp-Source: ABdhPJz6EvGXrUCIvHOZE9hs6y52Yk6AUJEWF4h0bgp1U1F33RBimuQ7444IIa1yj7OIM1TaOrMPAQ==
X-Received: by 2002:adf:e589:0:b0:203:e324:3485 with SMTP id
 l9-20020adfe589000000b00203e3243485mr190371wrm.271.1648047863706; 
 Wed, 23 Mar 2022 08:04:23 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 i206-20020a1c3bd7000000b0038bfc3ab76csm119280wma.48.2022.03.23.08.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 08:04:23 -0700 (PDT)
Message-ID: <5aa3214f-d521-3c7e-6dcd-57e0cadbe761@grimberg.me>
Date: Wed, 23 Mar 2022 17:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: serialize delete_ctrl and install_queue flow to
 avoid race
Content-Language: en-US
To: =amit.engel@dell.com, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com
References: <20220322075234.29949-1-=amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220322075234.29949-1-=amit.engel@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_080426_493007_3366F2AF 
X-CRM114-Status: GOOD (  21.70  )
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


> From: Amit Engel <amit.engel@dell.com>
> 
> In case of delete_ctrl, need to ensure that no install_queue occurs
> delete_ctrl flow need to wait until all running install_queue will be done
> 
> without this fix, we might end up with a ctrl that will never be deleted

Is this a leak or a hang?

> 
> Signed-off-by: Amit Engel <amit.engel@dell.com>
> ---
>   drivers/nvme/target/core.c        | 10 ++++++++++
>   drivers/nvme/target/fabrics-cmd.c |  8 ++++++++
>   drivers/nvme/target/nvmet.h       |  1 +
>   3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 92af37d33ec3..f00f2636f4db 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -303,6 +303,11 @@ void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *subsys)
>   	struct nvmet_ctrl *ctrl;
>   
>   	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->port == port)
> +			ctrl->deleting = true;

Perhaps we need ctrls to have a proper state machine? Seems rather
random...

> +	}
> +	synchronize_rcu();
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>   		if (ctrl->port == port)
>   			ctrl->ops->delete_ctrl(ctrl);

Probably you want to introduce nvmet_delete_ctrl that sets the state
and calls ->delete_ctrl()

> @@ -1329,6 +1334,8 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
>   			container_of(work, struct nvmet_ctrl, fatal_err_work);
>   
>   	pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
> +	ctrl->deleting = true;
> +	synchronize_rcu();
>   	ctrl->ops->delete_ctrl(ctrl);
>   }
>   
> @@ -1593,6 +1600,9 @@ void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
>   	struct nvmet_ctrl *ctrl;
>   
>   	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
> +		ctrl->deleting = true;
> +	synchronize_rcu();
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>   		ctrl->ops->delete_ctrl(ctrl);
>   	mutex_unlock(&subsys->lock);
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 70fb587e9413..8758f4ae624f 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -134,8 +134,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
>   	}
>   
> +	rcu_read_lock();
> +	if (ctrl->deleting) {
> +		rcu_read_unlock();
> +		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
> +	}

I think that it should probably fail way sooner than that...

> +
>   	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
>   	if (old) {
> +		rcu_read_unlock();
>   		pr_warn("queue already connected!\n");
>   		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
>   		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
> @@ -144,6 +151,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	/* note: convert queue size from 0's-based value to 1's-based value */
>   	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
>   	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
> +	rcu_read_unlock();
>   
>   	if (c->cattr & NVME_CONNECT_DISABLE_SQFLOW) {
>   		req->sq->sqhd_disabled = true;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index d910c6aad4b6..ef56b4811918 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -209,6 +209,7 @@ struct nvmet_ctrl {
>   	u64			err_counter;
>   	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
>   	bool			pi_support;
> +	bool			deleting;
>   };
>   
>   struct nvmet_subsys {

