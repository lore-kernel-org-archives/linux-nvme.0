Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E2C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 10:15:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C5064E25
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 10:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C5064E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p+fy53GNtTWtsTfBhezY6l+ZXSZaeMbMvLit8W+VX3U=; b=09538JlPg1rFIIi7MSuoUGC8q
	6meFX+Lb8a7xMla7J2xBxM7f832J95HYbuWxUZlXfFxGX+D7smaDZ8dDyqreRBEbTrUt76St1hq4k
	VbiaqRVW9ADx9c2Yqr1wQwmfws2f5mK5lx/eJ9hJUkq3bFafWlAa8EpaE8ik7vwLpRCwtAbaVWv8o
	BYeg7TrR6/Hdzeo1QvVQ3F5upHx/Og2JWTk49lCW7YOUCL122nXHzu5pjXvBVU389Jcb4LczQPA7S
	zJK9quhoYRFUOYJnApyQbR9fezox2sE6jtaJ1P2uCLR2WQvmmdnh6nLdT2zeDnwMQj49CZf50+NuW
	+A78W2Asw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lE8FX-0006Nf-EC; Mon, 22 Feb 2021 10:15:31 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lE8FS-0006Lw-R1
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 10:15:29 +0000
Received: by mail-pg1-x531.google.com with SMTP id n10so9927149pgl.10
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2zJnU0ESjYaXiRyHZAvvTZq+ZXBv902m1CV66vN4qdU=;
 b=goURS9avAm/5hGlaG41kQN8mM4qvvsQrSB4d0yMzO4L5/EkYPvEaPKL69ys7wr2rOV
 Mq+BelVjIW/CFhA5RS8PvHwQ36llfrqqWVfrKnod5TsjuUl3kufudJgXF7v80eFD4GE1
 EqhClRalDkNhx9KLd80yjq2G3jcJ+ZLSepQZ6XxaUuV9zHlbMBiMMTx/GKZs4w/YELnZ
 nx0gSUTT1+lYesdGVuKWoHWUARDEoYay0Pzwc3xMFmAyaAkQ6tDjbC6MMYVG0m5MxnFr
 JgfA6uLlrP90QbCdEsgjb852rFP6OZ9IhAnt3B0b+ViI+u96qNeaZfGoVwny6gHcTPIm
 SxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2zJnU0ESjYaXiRyHZAvvTZq+ZXBv902m1CV66vN4qdU=;
 b=XjaquXwCL03rPDOCCje4IJ3l/Pr4ebU6CvsJKtvFY6x5X9FnjJdc7QaZ3Hwj61/HvB
 JwLhJ6q2pqFEBpl278+D1KzsrKcJBnKAJIpDToGDAaY16NF/H3j1DapepgLfM13rc0qT
 jnYgdGHgjLzsOCYdIN/zU7k9/LTN+8VVDRFoWRUs3JDlPblh7DsjjPmOXu0v0VIcoCLt
 vbxyVDW2lacV492HJP1BwWC4zOVQIZSh7E04VhRLafx0TpSMs3qcW2BUOuNdw1q+kO5j
 9x0B4TR3PCuskpdmWEpJz4+Yh6kEVmAlKRea0PAlF0sedM22TbTmOy3Hl9UNtUFW3jbY
 cZkw==
X-Gm-Message-State: AOAM533nv3B1o7n8+z9bPDsuJGfiNTFCX8I5bWySNhp0LYJdlliJrWfy
 JqKf7u4rH2lFUxYvUIMxGh8=
X-Google-Smtp-Source: ABdhPJyG6SXSjtHvRYdbo1XBPZvdoEj0Dqt89cw3TaDk9oSgs08hHny+/UXhf1k5yMTPFLfnArgpQA==
X-Received: by 2002:a63:794:: with SMTP id 142mr19232222pgh.323.1613988922186; 
 Mon, 22 Feb 2021 02:15:22 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id x184sm10730823pfx.2.2021.02.22.02.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 02:15:21 -0800 (PST)
Date: Mon, 22 Feb 2021 19:15:19 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme: add 'fail_if_no_path' sysfs attribute
Message-ID: <20210222101519.GA2856@localhost.localdomain>
References: <20210222064155.105742-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210222064155.105742-1-hare@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_051526_956146_BE9F3819 
X-CRM114-Status: GOOD (  20.68  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-22 07:41:55, Hannes Reinecke wrote:
> In some setups like RAID we need to return an I/O error
> once all paths are unavailable to allow the upper layers
> to start their own error recovery (like redirecting I/O
> to other mirrors).
> This patch adds a sysfs attribute 'fail_if_no_path' to
> allow the admin to enable that behaviour instead of the
> current 'queue until a path becomes available' policy.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c      |  5 +++++
>  drivers/nvme/host/multipath.c | 38 +++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/nvme.h      |  2 ++
>  3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5c1ec3bfb9d3..ef20029a46b2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3466,6 +3466,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
>  #ifdef CONFIG_NVME_MULTIPATH
>  	&dev_attr_ana_grpid.attr,
>  	&dev_attr_ana_state.attr,
> +	&dev_attr_fail_if_no_path.attr,
>  #endif
>  	NULL,
>  };
> @@ -3496,6 +3497,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>  		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
>  			return 0;
>  	}
> +	if (a == &dev_attr_fail_if_no_path.attr) {
> +		if (dev_to_disk(dev)->fops == &nvme_bdev_ops)
> +			return 0;
> +	}
>  #endif
>  	return a->mode;
>  }
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0696319adaf6..35ed2f6d431b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -283,10 +283,13 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>  			continue;
>  		switch (ns->ctrl->state) {
>  		case NVME_CTRL_LIVE:
> +			return true;

Hello Hannes,

May I ask there's any reason why LIVE state is not covered by the sysfs
attribute that this patch introduced ?  Wouldn't it be possible to have
no available paths (inaccessible) in LIVE state ?

Thanks! :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
