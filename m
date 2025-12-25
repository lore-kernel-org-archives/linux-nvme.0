Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54137E7AD44
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBgdEXalUb5he9o3+VbaIAmoleCwvYIFnU8MOfTz47A=; b=5F+FghdGcXKpM++ygEtPMEJO3U
	Cd5gaA9xBaBI8UcMcbEqFcYrW5UgmY9RD6mSTDNeiyUnhUlbtD2S/oRC4uuLHUJjJ6Q3G/xqushPA
	RLIfV6+xvI1x1+NoaeZTDcc3Y6bnBDL5J02MsSkK149Q3pzfqeIJvIG/M8ycZv/Rxd8BfrMbPQI8w
	BjGC4Whr0AO81jYE2hscUkDdw+QRjwcgaDBj4kXDHkqYt2GPJDHp1/8Qe2W7BKuHg/ObuVoZgr4Ok
	G3g9QjDQXNeVo7lVra1CBUoTuxxfoVD54Y+kl+oDLUnk8ijGbkvS1Gq1OqVN/PHcu4qfr1apoMQ0/
	XAcvxrDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYlAt-00000000Qv6-3mxm;
	Thu, 25 Dec 2025 13:14:39 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYlAq-00000000Quh-0183
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 13:14:37 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f57cd471so3461261f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 05:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766668474; x=1767273274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBgdEXalUb5he9o3+VbaIAmoleCwvYIFnU8MOfTz47A=;
        b=NXMIoJdNqeQsgyIC+lsr1abXZ84oWRqo0gALBjsf77mhrVM6ckLdjFXpnr9L22pjRE
         PnB90UxF6Kgq3AG69yWpAxLu9Y79VJvZe88xAIGl4pYKtjTKZE9YaqEcnKN0gzF7n+kr
         rGy0a+Jz+822h/Bsgo+X12rYr9Mq9Dx13e8j06iwdWymVnkTLOYqDKnxpHGF6RnXt8tD
         e6RyBT0QhdSD16OeVJBrAwFAtSCQop97vmLSlPGNSHBwuVdUm22siP/7deVDVIBYP5Zb
         tKCMVMqNifUi6i3JbatLwnq4tgL6ZGfCWsVOEvBmxZzq53VfTUH8/2SvtSBWwQZy3D0h
         8Kfw==
X-Forwarded-Encrypted: i=1; AJvYcCVlKiDTKB9mwq6lMcR0ign6kKX0gwTQWSM0TclRTnecSl7nKo0ErtJ3Qe8P+SzharlxKUbxYW2HI9Uu@lists.infradead.org
X-Gm-Message-State: AOJu0YzwDmoDvtbY1fGDcYsQ19hw9fB3tF59G1k5DygqUngLAk84mTqx
	lgXYZi/6bMWP2Bhu9aQMoE90awoF69lC+p91yyLJGwiGYKWx2tTQh9pI
X-Gm-Gg: AY/fxX6Z0yyrcaCP5v0764//tN7lF0kJVGaPHANkCIhW/duU3seAYl/l0JSbiQqehBS
	IC6MnIGqMkwFEQctaqolYzVJY73to218udZpAe/Sf/rgpYwdUfBL1BHeKtG9kOmMZWVMNsu2l/k
	hKlFjcfiDrz0ch5MnhOx5BvMsSpPf/8AORJ2dZK6IHhGUYYCbTy2tGKbdJjhCdy+FVub7kyJNGq
	cAHm6n3KN71+l+Avk/sG69qBH7EGuy9a4OCQmz54jSdoP/4XPrBWzx1FvQZNxBglAylwd0e5SrL
	9jxYa9oNTAhr2NmnBQBlSINBxpPJiZOWgd+c7lfDte9wwrd7M7zG/9u2WdQgsLhvLkba7XE9pH/
	rbmK+5hcF9YjeJzU6GUzDRl0K5Jea0zWQSutsO9MY4I20hetWbi3+qn8kPudL/WUnEFXTQQidID
	9FuJOpX49G+8UAtUjbENZ4GJqOZhXN7HL78/T0X4j5RuokwA==
X-Google-Smtp-Source: AGHT+IG6PCGAIMcz62HJU1GeU/Kc0QPrcysQZWICO22rA4h6DFOn/bv2y/DCv97PA34yS05KXYGOqA==
X-Received: by 2002:a05:6000:22c8:b0:430:f6c0:6c47 with SMTP id ffacd0b85a97d-4324e4cbea8mr23733293f8f.21.1766668473706;
        Thu, 25 Dec 2025 05:14:33 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm31933520f8f.19.2025.12.25.05.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 05:14:32 -0800 (PST)
Message-ID: <3f2c8a9e-2e1c-4cb8-b296-8f61ab16b03a@grimberg.me>
Date: Thu, 25 Dec 2025 15:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-4-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-4-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_051436_166893_089A50F0 
X-CRM114-Status: GOOD (  18.21  )
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



On 26/11/2025 4:11, Mohamed Khalfella wrote:
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) command is an nvme command the is issued to source controller by
> initiator to reset impacted controller. Implement CCR command for linux
> nvme target.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 79 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      | 69 ++++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h     | 13 ++++++
>   include/linux/nvme.h            | 23 ++++++++++
>   4 files changed, 184 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index aaceb697e4d2..a55ca010d34f 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -376,7 +376,9 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
>   	log->acs[nvme_admin_get_features] =
>   	log->acs[nvme_admin_async_event] =
>   	log->acs[nvme_admin_keep_alive] =
> +	log->acs[nvme_admin_cross_ctrl_reset] =
>   		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
> +
>   }
>   
>   static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
> @@ -1615,6 +1617,80 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ictrl, *ctrl = req->sq->ctrl;
> +	struct nvme_command *cmd = req->cmd;
> +	struct nvmet_ccr *ccr, *new_ccr;
> +	int ccr_active, ccr_total;
> +	u16 cntlid, status = 0;
> +
> +	cntlid = le16_to_cpu(cmd->ccr.icid);
> +	if (ctrl->cntlid == cntlid) {
> +		req->error_loc =
> +			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}
> +
> +	ictrl = nvmet_ctrl_find_get_ccr(ctrl->subsys, ctrl->hostnqn,

What does the 'i' stand for?

> +					cmd->ccr.ciu, cntlid,
> +					le64_to_cpu(cmd->ccr.cirn));
> +	if (!ictrl) {
> +		/* Immediate Reset Successful */
> +		nvmet_set_result(req, 1);
> +		status = NVME_SC_SUCCESS;
> +		goto out;
> +	}
> +
> +	new_ccr = kmalloc(sizeof(*ccr), GFP_KERNEL);
> +	if (!new_ccr) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_put_ctrl;
> +	}

Allocating this later when you actually use it would probably simplify 
error path.

> +
> +	ccr_total = ccr_active = 0;
> +	mutex_lock(&ctrl->lock);
> +	list_for_each_entry(ccr, &ctrl->ccrs, entry) {
> +		if (ccr->ctrl == ictrl) {
> +			status = NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_DNR;
> +			goto out_unlock;
> +		}
> +
> +		ccr_total++;
> +		if (ccr->ctrl)
> +			ccr_active++;
> +	}
> +
> +	if (ccr_active >= NVMF_CCR_LIMIT) {
> +		status = NVME_SC_CCR_LIMIT_EXCEEDED;
> +		goto out_unlock;
> +	}
> +	if (ccr_total >= NVMF_CCR_PER_PAGE) {
> +		status = NVME_SC_CCR_LOGPAGE_FULL;
> +		goto out_unlock;
> +	}
> +
> +	new_ccr->ciu = cmd->ccr.ciu;
> +	new_ccr->icid = cntlid;
> +	new_ccr->ctrl = ictrl;
> +	list_add_tail(&new_ccr->entry, &ctrl->ccrs);
> +	mutex_unlock(&ctrl->lock);
> +
> +	nvmet_ctrl_fatal_error(ictrl);

Don't you need to wait for it to complete?
e.g. flush_work(&ictrl->fatal_err_work);

Or is that done async? will need to look downstream...

