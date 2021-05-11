Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F820C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:08:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6740261352
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6740261352
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jmANvSPBurztYB/YGDUy1pK3WAQ+5ZQlDRSkugwfnco=; b=dMWhgcmTUMDEGdgMgZOmgcfWf
	f6ztM0oDqOOYlg/vgu9oRMgw0SoBHEX3iBtfoxSKdH18gPObhrQdytrnIDbfmcF347JauIgI4rUpm
	gLYoloWmPv9mFEBTMMQE86k3+L8QNqTA7afiwB4USh6D38U2jUSW1bmvktNVKEixxmpD7iEguFsap
	AgZz9FPbyafGxydNsvWP8zMEnClfYL2rFhj9NqJsbVl3in8uVC4pQs1nv88njUB/L7Cl9r8YWiHae
	bdwSF5vb+oOsxsY3MVSpEyP9Cux5KNKZF8K7h4BrjVYpCMwTnmBwgKHg/6Croqlpo8q2CVI2V0com
	hlYY3L9lA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVs7-000sPe-OD; Tue, 11 May 2021 17:08:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVs3-000sOU-M1
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 17:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=o0FW4dEcugPrJa+NluZNgrr+ybg/TqFz6Lc/5J8b0sM=; b=jLJjx4YPXOf7N/dY59MYG/vA33
 //gLEEFx0VG0CK8QI4Z7Jl7fB9l+s6nDRPu66J/hgzGpzhz5Jzv2ztSzp6Lg3eN9/xWJL42zUFRyx
 oT5xsgx46qE4DsFSMJQho9UeUgbBcSCSKaojLTWQJJ7SO1sivcsiGLKK+pWnvfN9moPa06CxZT8jE
 kc2N53p2XJlfwN0Nds7p8S7fvCYakBgVoLlLExvcwmgCTH0nM8SiXeyWnUQp4todm6D3+Ogf7QISp
 uykzIusPkgpHyLloPjIPUP5UcdiuxXLu0GoglZLiLd5M3vsApqGoOowY7Y4cSg8VfWHLBsQPZSzUN
 y2mjXf2w==;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVs1-009naF-2L
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 17:08:34 +0000
Received: by mail-pj1-f48.google.com with SMTP id ge1so12033327pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 10:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o0FW4dEcugPrJa+NluZNgrr+ybg/TqFz6Lc/5J8b0sM=;
 b=hz9+2dWlJwIN7P0aVQGHdoJchqbRcPC8dOOlyOKN8gq1G/1nmP9cAa0VnxfREgIaEp
 EnGTUIzsaEnlWda6o8coSjyMva/3ggccv+fkYQ7xgLJEiLbCyCEiIky+CkwmvihcKFdr
 kEJTeX6Z6rZ7ROtMtQ8hNZfSMQy7Ts+YSLlIEYao6OQExg9vzehHhZ5H++oeqVc+rdeb
 AsvMlVuAUmYwSp7w8ZIJfC1fNQQ/tWMXLhb8IXwFG8Axc3PEakAvmtHWOGRUdnXsmjIN
 mbSL8wC6SIfhD8XyEeQl7DxG70vC1MkUDbayACuUzKCr4pF1qY9zVCmeYvNImlTs8NPB
 1tTw==
X-Gm-Message-State: AOAM533xetFGwZXP67QIxgCN2r6r6do5nhYAgooUNC9eoFYHJ1d/8/Jx
 tQ+MFQ/3hvjfbSsTGk8PpZFRsM9MlsE=
X-Google-Smtp-Source: ABdhPJy471jdA8R++QqbiIHUvGByb+IHKgqnEsQEoo7bqYdVPjMc+AwhO0seUev8UHSx/dhhsem9Zg==
X-Received: by 2002:a17:903:18b:b029:ee:d430:6c4d with SMTP id
 z11-20020a170903018bb02900eed4306c4dmr31226450plg.34.1620752907565; 
 Tue, 11 May 2021 10:08:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id o4sm2557803pjs.38.2021.05.11.10.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 10:08:27 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: generate uevent once a multipath namespace is
 operational again
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210511080308.6734-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b289bd87-6d36-8c68-18a0-b9c8ef7da1fa@grimberg.me>
Date: Tue, 11 May 2021 10:08:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511080308.6734-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_100833_139127_F3038C59 
X-CRM114-Status: GOOD (  19.88  )
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


> In an all paths down scenario I/O will be requeued or aborted, so no
> further I/O will be ongoing on this namespace.
> This leaves upper layers like MD unable to determine if the namespace
> becomes operational again after a successful controller reset.
> This patch will send an uevent per multipathed namespace once the
> underlying controller is LIVE, allowing MD to start resync.
> 
> Changes to v1:
> - use disk_uevent() as suggested by hch
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/multipath.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0551796517e6..ecc99bd5f8ad 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -100,8 +100,11 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		if (ns->head->disk)
> -			kblockd_schedule_work(&ns->head->requeue_work);
> +		if (!ns->head->disk)
> +			continue;
> +		kblockd_schedule_work(&ns->head->requeue_work);
> +		if (ctrl->state == NVME_CTRL_LIVE)
> +			disk_uevent(ns->head->disk, KOBJ_CHANGE);
>   	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }

Why only for multipath namespaces though? This is not needed for 
non-multipath namespaces

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
