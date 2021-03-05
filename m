Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE0FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:11:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45CE6509F
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45CE6509F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dQvYMJcwQ+fxh+eeDo7UvNXfshExBZC2TVWHQleG7Ys=; b=dP7q130eLridVCM7xMHWOfdT0
	mc1uorl69L8pxdBxH6goLrtUuqvn4RbOxBBVMFrLBYq+5jEjXyFZQyjUerXEVabBvhW6G5xEPbn+h
	BWRq/GKDyhVsGgtCMItQQ0nIIT/3vfngxzfYzaqPH6br3yZvFRUtPi/p0Y01WOVo0y6KdcbliYEJn
	M2LBuBx98ht++2M5X0W5nZ7YD5HglXCXtQ1oepqBTuqLAQ51ebD+r50irN+HNVIsA3al2Lr6idH/t
	urJK9v8pTLGnsThqIOSO6geiZY80JV9HN0/Tx7kvHmeAycIsW3SLOHLwzWf1TuC8toDiUHcY5UqJC
	48nL5g72w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIGn3-00GIwp-3N; Fri, 05 Mar 2021 20:11:13 +0000
Received: from mail-oo1-f47.google.com ([209.85.161.47])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIGmy-00GIvO-2h
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 20:11:10 +0000
Received: by mail-oo1-f47.google.com with SMTP id z12so286154ooh.5
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 12:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cjy8QJqEStaW4NVTvrXv6etFWcKeSSucLN2SVf9eYgk=;
 b=ubkgridOcHLr90DnoWEHyjbCV8/aK+hyOEQhusQErLb0SUJx8pzfLjqZPpjDl9F3op
 Cj+YMe2blZD0t413SNYCJNKOYBmHZ/cYznPIRq5x+Sqf+xHlc0bUbAPp6XYryXAhKSY7
 tNecw/+gAONbQ2VIpHot4oL+P2r7k4twMCJoBwUlwM9izOgi9bHs+WBN+Uanutu4+Bmq
 RipwiytAwzdpAjXr+5efg1qgMR4XRdHqQmuPtnJXlb05y8ZhzZN28hiyaCI7CIelMY+G
 o+EQygSWYhz0uO+b/YiK2AkL3RyQaM7kjHBkaqF/8y33S3W++ZikFXgG9wFUWX+3LtyE
 8aOQ==
X-Gm-Message-State: AOAM530j7x8mLopz27X25aIP2ok7RSfpEtxpwYLn8VBTBvg8eonm3z3C
 XCrUi+qySTjIrxtR43zDELc=
X-Google-Smtp-Source: ABdhPJw3wDxlimSzEV5ZeQUx4ov2eeAWckOrjHhITgJVxzKBOToPUCQq9F0IY/sW02dZZu9ysem/8Q==
X-Received: by 2002:a4a:d10f:: with SMTP id k15mr9128558oor.82.1614975065105; 
 Fri, 05 Mar 2021 12:11:05 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id n6sm725213oop.48.2021.03.05.12.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:11:04 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
 <00e75643-d422-ca12-1648-02ca89044182@suse.de>
 <20201006174100.GA959043@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <68ca5a63-e6e3-be5a-4b60-bd9db52ac9c1@grimberg.me>
Date: Fri, 5 Mar 2021 12:11:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201006174100.GA959043@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_201108_572268_CAE1DEF7 
X-CRM114-Status: GOOD (  21.82  )
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


> I think what you're showing is a problem for everyone, including
> fabrics. The namespace was attached to the previously existing
> subsystem, nvme1, but we didn't find the previously existing "head" to
> reattach the namespace.
> 
> I just threw the below together very hastily, so I'm sure there's
> something wrong with it, but just to capture what's wrong with the
> current code:
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3833584b5cee..0b3bbbe6d1e8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3897,8 +3897,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);

Not removing it ever from the head->list?

>   	mutex_unlock(&ns->ctrl->subsys->lock);
>   
>   	synchronize_rcu(); /* guarantee not available in head->list */
> --

This is a problem. beacuse if you don't remove the ns from the
head->list nothing prevents it from being re-selected as the
current_path after we synchronize the srcu, although it is going away...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
