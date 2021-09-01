Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54936C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:42:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E081361057
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E081361057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DPCA3kefiQyNwo8Y/GXDPKPOdYN9GaKCt32FKLW7nKc=; b=mU+esJd6rju2oz3BnT4YJJZ2jN
	XaBPxSx7iFj9025ehZmxoKgpK61LXquE2AZ91lmZGFFSKHxZtfOZm44Tx6HYigEFWkrMIRMpOPagf
	3JOEGiM/7/Eu8eMyKyVdjBEQQOtsGBSeZfzWrJsEozSGTR4FgSNgVbmTxQhRFtBiogVld9czDLBcM
	43YRtYRfAO6nSslEyGzCSU1++QVvbuE38TlJCc5/q7SujjpRB/UOru/zhzt3+Jm62s4kSQ8URMZz3
	agiCcPv/EbtQQa1Gg0P7vbnpmoc3H+F5dvFxTEvA2Hyf70+68t53ULGwZvJxSaykirxbRpnPWXnrx
	A7smU4gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRRP-006Gtv-D8; Wed, 01 Sep 2021 14:42:15 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRRE-006GsH-2n
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:42:07 +0000
Received: by mail-wr1-f44.google.com with SMTP id b6so4865071wrh.10
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 07:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=75eTzhMZRQumzcA86dOnNSzdyqipor7hBIbb15dKKgw=;
 b=EKrEjDAeQZPwYo9PzDiBzZDtjm/5hitD7j72FR9eUzDScnFfAKx3MO+7p/8OyNcAXR
 Apx/kQ8sICZCKymo9E1/YkLWJscmjZkSuzstDvlQSAs1KdoPBmgU5dqat6eZz7GM4WVD
 ZvKJm7VZrfRBjV0I1DaKKcYWt2amiJvkWQsfKQaoSPed+Z+W39hfLvmqb2DjtFIP8UzF
 4QQ5gTg8ewJHf5y4GZrABluf33vkuBmHqwK4nmYvkiMDU7bX5pgSDF2MpMz1F8DDKCo3
 yMR0/rRIigd+IUfnV23L8KyeqNBm06gAY1SnJYVj/MF4btGIX4hkmJcppVc6+7pCBlGl
 1GVQ==
X-Gm-Message-State: AOAM530Q9FxRb6tMKg8TjeR1GOEa6hrMTNB51Va3itvl1DWHqmwSJYVK
 co3y4Rxm303jG8sqXclTP0Y=
X-Google-Smtp-Source: ABdhPJyEJyVZM6vdLCp9873clDBls8KUS5Y+4MFspEO1g+MLQfiNrZ/rNYMODJaawdB/7e+MNUlr0Q==
X-Received: by 2002:adf:ba4d:: with SMTP id t13mr37812523wrg.424.1630507320183; 
 Wed, 01 Sep 2021 07:42:00 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id l7sm6058110wmj.9.2021.09.01.07.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 07:41:59 -0700 (PDT)
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
To: Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210830093618.97657-1-dwagner@suse.de>
 <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
 <742108c3-7c76-0bc3-fc13-06acf975c25c@suse.de>
 <YS+AYA+5/o8Qj08Q@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7677d695-aa57-ee91-3b32-65570cefdff4@grimberg.me>
Date: Wed, 1 Sep 2021 17:41:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS+AYA+5/o8Qj08Q@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_074204_180150_D409DFD2 
X-CRM114-Status: GOOD (  24.59  )
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


>> Most likely. Do drop me a mail on how to create a reproducer for that; it's
>> not exactly trivial as you need to patch qemu for that
>> (and, of course, those patches will not go upstream as they again hit a
>> section which the maintainer deemed to be reworked any time now. So of
>> course he can't possibly apply them.)
>> (I seem to have a particular spell of bad luck, seeing that it's the _third_
>> time this happened to me :-( )
> 
> Soo.  What is the problem in simply checking in nvme_find_ns_head that
> h->list is non-empty?  E.g. this variant of the patch from Daniel:

Don't see why this won't work...

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d535b00d65816..ce91655fa29bb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3523,7 +3523,9 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
>   	lockdep_assert_held(&subsys->lock);
>   
>   	list_for_each_entry(h, &subsys->nsheads, entry) {
> -		if (h->ns_id == nsid && nvme_tryget_ns_head(h))
> +		if (h->ns_id != nsid)
> +			continue;
> +		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
>   			return h;
>   	}
>   
> @@ -3835,7 +3837,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	mutex_unlock(&ns->ctrl->subsys->lock);
> +	if (list_empty(&ns->head->list)) {
> +		list_del_init(&ns->head->entry);
> +		last_path = true;
> +	}
> +	mutex_unlock(&ns->head->subsys->lock);
>   
>   	/* guarantee not available in head->list */
>   	synchronize_rcu();
> @@ -3855,13 +3861,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	list_del_init(&ns->list);
>   	up_write(&ns->ctrl->namespaces_rwsem);
>   
> -	/* Synchronize with nvme_init_ns_head() */
> -	mutex_lock(&ns->head->subsys->lock);
> -	if (list_empty(&ns->head->list)) {
> -		list_del_init(&ns->head->entry);
> -		last_path = true;
> -	}
> -	mutex_unlock(&ns->head->subsys->lock);
>   	if (last_path)
>   		nvme_mpath_shutdown_disk(ns->head);
>   	nvme_put_ns(ns);
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
