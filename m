Return-Path: <SRS0=DKQ4=JV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C61C433ED
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Apr 2021 00:22:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B0161261
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Apr 2021 00:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B0161261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ROGH5OZ9C90hWNeP8M4tFuerZBLCksdkDzfZvbFeP7Y=; b=ORTuGi9KS8sTd/JKsAtbwfXqW
	GunY4FuB9QRnD7RWfo8+4AV81eufwKWs4twrn4ltcugr8cwmZlmhDa27SJcABJQKUhTJjMzpScfrf
	jCcdOvpX3oRBkP3kDsHXWRuK3iLRvfywno9xeyZv88Zp9PDDPGYKmZopitHoMbODnSKSlG9UcE4Zd
	o9IzZDTGi4RQllR8y9q02vHwPenBFvaTTtxFYfZiE8nP4ESnP8pITpokk0HWANUB9U1uIcbOCgfa1
	0woF2xjbFzOWVOrQ9Rucv0lqdasdZuS++g+mVeWhedsULHCthXkMNnEl/530lc7rwxTGKIH2ZzNvi
	XAQy4VXtQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la639-002fG6-Fa; Sat, 24 Apr 2021 00:21:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la62r-002fAi-9T
 for linux-nvme@desiato.infradead.org; Sat, 24 Apr 2021 00:21:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=FYUjE5U5DmAbXHy5qWCtaBVQ3/BeEgMoqcY+mRr3+oQ=; b=qeTNYRk9bgNtyVlv89CmN71Zzo
 VFGXWZ/pHA1MXoMh26bl6ZL4EqOfgGbGSJLNL0Rm/IrWIcDUjAP/jzbMJUjkePJHqf+FLRwua46TF
 QQVbDUe9r1ayOPboSXDrg01kmsQCB+FH5GJVycOf2f1xttr16srSSDjPv0ndhGMqw4aIO5yhJmklm
 08wW5OGgVH2b0fj3bCVUDBA7qnSlrUUw4V/SuNwZQo6kiN1Uu8lYhj1/3v7Kl44EhWUh0dFgvvcXx
 dS+gVMptp/d0ZE4wSMzoMpD/nspbDsy2zmeUCOUCUjmSissMV9fKtV+CcWKqSu8m+XPXaxMKBE6t7
 unuW0YZw==;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la62o-00Emog-RT
 for linux-nvme@lists.infradead.org; Sat, 24 Apr 2021 00:21:12 +0000
Received: by mail-wm1-f43.google.com with SMTP id n127so15058887wmb.5
 for <linux-nvme@lists.infradead.org>; Fri, 23 Apr 2021 17:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FYUjE5U5DmAbXHy5qWCtaBVQ3/BeEgMoqcY+mRr3+oQ=;
 b=Dp31hM+7DbFzAjVsIJc5ZEQjhkGMzgCaOWX+I6iP7ogGp9+uIPWWmopIKdSFKmtUns
 QP/P+AYbiPJebAPkqSKGVxanrjLHFyTaa6z7o1tMqNdybqWgpvDG21in0q5XVtdFj2O+
 0/W31iQGMtzJ2vGDA0nx95S4ed7pPZvjleT8fURCbLcVaWCKOGNiKKfK2Z+DRGuRewJX
 25g/NqfQSaoUEP5ifhEzZ7/XhM3so73xEM+aw9x1uKJ4/Mu9VXQM4CXSGZIZrW8Qoqf3
 pgcdHa6smVycD3J3OViATrLRGtyu54rDnEpgRps512itBL12nnAYxnFizPIOX3XnUdxA
 QTlQ==
X-Gm-Message-State: AOAM5326U08bct6A+tYIiTsNmYdg+jD1db1vxsqct/TnSjvfEanPd1kk
 AJBAaYuyN8VDFrJQ+2hV6cS7b4IMhEA=
X-Google-Smtp-Source: ABdhPJxHbjcluDqXS3XSihmjVv6ZNQaM56Va+IKQK2GT6KI31tzCEjwkMZuVNByaBV/yCw8/bSDg8Q==
X-Received: by 2002:a05:600c:3515:: with SMTP id
 h21mr7894778wmq.67.1619223668286; 
 Fri, 23 Apr 2021 17:21:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:42ed:4954:6c1c:e638?
 ([2601:647:4802:9070:42ed:4954:6c1c:e638])
 by smtp.gmail.com with ESMTPSA id c1sm10601432wrx.89.2021.04.23.17.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Apr 2021 17:21:07 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
References: <20210423133835.25479-1-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
Date: Fri, 23 Apr 2021 17:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423133835.25479-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_172110_918942_CE9B6D1D 
X-CRM114-Status: GOOD (  13.29  )
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


> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index be905d4fdb47..fc07a7b0dc1d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1202,6 +1202,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> +	nvme_mpath_stop(&ctrl->ctrl);
>   	nvme_rdma_reconnect_or_remove(ctrl);

Its pretty annoying to have to needlessly wait for the ana log page
request to timeout... But this is also needed because we init ana_lock
in nvme_mpath_init while it can be potentially taken in ana_work, which
is a precipice for bad things...

So...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

And this needs to go to stable, don't see a definitive offending
commit here, so maybe just CC stable and have the title be
more discriptive that it fixes a possible list-poison?

Something like:
nvme: rdma/tcp: fix a possible list corruption when reconnect work is 
racing with anatt timer


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
