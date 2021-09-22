Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D73C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 17:00:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45906611EE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 17:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45906611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0WFNKgCeea57iDRZs7ElD8JRvYwUd5Ge5miIPSlWlPQ=; b=3BYG+LR0Q/oref
	aFX/vjdoi1r0vDN7MKwZ45tt1NJN8lBC+sI8NaSibKOeQxTiDaCMud6ierSNocab8ELVrl1mZn3YS
	bBWf8UzSWkp+bzP2yOkRYZn6x72a71wLoAO3PufuGIGH67ofEZ13LW3KFb2ZIPq4mP5VpB4/vaU/f
	OmzOv2AGERTy9kaWmq9IwLkzMgR9mkTXG9smsBeQeTs5vnAIsbsBXfO9bRe51kVWuV3j3piedkpl6
	tj9J1U3xtKY5i9Ovamm3hEeHS4huyXDd8IqSzkgRYga4CKdm08quLWQR8CZLDrgb4iokiZHJHm4Hw
	rCO6ck4inMgjYIVCOFNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT5au-009Bkz-E9; Wed, 22 Sep 2021 16:59:40 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT5ar-009Bkc-AQ
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 16:59:38 +0000
Received: by mail-pg1-x530.google.com with SMTP id e7so3377889pgk.2
 for <linux-nvme@lists.infradead.org>; Wed, 22 Sep 2021 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iWFwX0IfGz2o+dtm7t4qroyBKTHFbmX+isPP+o06z2k=;
 b=ji0/NtHLfOeKx77DbmUSAAR9ga7/rsurJmBtxrseqwn3PBXQxUyuN+V4S1kEVkTNG0
 67yDQXRvv+OzTWilnGkaB2jkLNV/yZkVM/iG69sgsx1D0/h4yXc7o3XjXu08jOuxkTsf
 hNZEdyrW0+lSiL1CCsVtCK6alXhLI0qcspSRaQReW3/kaYiadZlGQ8cFab1HLtk4sc9J
 xx23HDNEcRck40cRWP/fK7CDtucV4UtKrTHMskaji5M+08OztZZFM8+SKwcGqHiCeCsV
 Z7i/oWYoyzURITuB9U9pqqDOT0MSuD7MLJehnw24pdR/StZQX9vnwd1H6vma4UirehGy
 gIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iWFwX0IfGz2o+dtm7t4qroyBKTHFbmX+isPP+o06z2k=;
 b=sFKCS1JvO0SKmusKmQfJVmaeib5D7lI65qCFAp2NEQnAQjkSmSHSltixmC7FvDlYHV
 4mBHOr+fSXNXriUoTq2Gz8suerlXANVu5IlGD2QcRvkab4uu2+f6tRGQHwbHMsiSKBEO
 qYcHXeN9DiM9MdH453wld2tVJpF0osoH0X0gXDQNqTCVkqXL+3ftSJSMnINPz3TxWckn
 E6jZ+/6BGBEWJGo9W6/6in9VS+7Jz2mUyuLlq0XqHh/SWv/IFlHwz7WZ4BQCGpS7sTcn
 /CNKKXrwRN+kTYdfe0TshyMkBSNmT0Pmnb02+NPg8hvNYLcuKbkJQlMzePC8GbtH1Uaj
 75cw==
X-Gm-Message-State: AOAM532UDLce8V7yr3+qCGZ2FVzAx2KEFNNHcn4zBYnNh0QVVOwQxNE7
 LiKGaQFCMPjznOh9i69KI6VMjqvrFs9RGXIT
X-Google-Smtp-Source: ABdhPJzxfeZ39Ii02QM2mXK3EDDN48nA4H7YTZBG7LL50lL1RqyvuUFklaoboDYhHXFgIkzmaxqZvQ==
X-Received: by 2002:a62:51c6:0:b0:43d:e849:c69d with SMTP id
 f189-20020a6251c6000000b0043de849c69dmr415219pfb.31.1632329975127; 
 Wed, 22 Sep 2021 09:59:35 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y7sm3043087pfr.33.2021.09.22.09.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Sep 2021 09:59:34 -0700 (PDT)
Message-ID: <f38f89f9-90c7-40ca-3d62-1491cb36be19@gmail.com>
Date: Wed, 22 Sep 2021 09:59:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 6/7] nvme: Add connect option 'discovery'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-7-hare@suse.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20210922063525.143045-7-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_095937_439392_34D825DA 
X-CRM114-Status: GOOD (  22.88  )
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/21/2021 11:35 PM, Hannes Reinecke wrote:
> Add a connect option 'discovery' to specify that the connection
> should be made to a discovery controller, not a normal I/O controller.
> With discovery controllers supporting unique subsystem NQNs we
> cannot easily distinguish by the subsystem NQN if this should be
> a discovery connection, but we need this information to blank out
> options not supported by discovery controllers.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c    | 7 +++++++
>   drivers/nvme/host/fabrics.c | 6 +++++-
>   drivers/nvme/host/fabrics.h | 1 +
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1ed1b7be2812..ad01e2778cb6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2715,6 +2715,13 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	else
>   		subsys->subtype = NVME_NQN_NVME;
>   
> +	if (nvme_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
> +		dev_err(ctrl->device,
> +			"Subsystem %s is not a discovery controller",
> +			subsys->subnqn);
> +		kfree(subsys);
> +		return -EINVAL;
> +	}
>   	subsys->awupf = le16_to_cpu(id->awupf);
>   #ifdef CONFIG_NVME_MULTIPATH
>   	subsys->iopolicy = NVME_IOPOLICY_NUMA;
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 668c6bb7a567..c5a2b71c5268 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
> +	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -823,6 +824,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_DISCOVERY:
> +			opts->discovery_nqn = true;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> @@ -949,7 +953,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
>   #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
>   				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
>   				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
> -				 NVMF_OPT_DISABLE_SQFLOW |\
> +				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
>   				 NVMF_OPT_FAIL_FAST_TMO)
>   
>   static struct nvme_ctrl *
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a146cb903869..b61b666e10ec 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -67,6 +67,7 @@ enum {
>   	NVMF_OPT_TOS		= 1 << 19,
>   	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
>   	NVMF_OPT_HOST_IFACE	= 1 << 21,
> +	NVMF_OPT_DISCOVERY	= 1 << 22,
>   };
>   
>   /**
> 


I think you need to be patching __nvme_find_get_subsystem(), which looks 
for subsystem name and opts out (allowing multiple connects to discovery 
subsystems) if discovery controller nqn.

e.g. the loop matching subsys name (assuming discovery ctlr now has a 
unique name) continues if subsys->subtype is NVME_NQN_DISC

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
