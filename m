Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C4C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 19:14:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D77611CD
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 19:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D77611CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8zWwQvA+JFF6Myc0K08w2UYiXcDxe2yVhe6gUGlQPA=; b=joOvXGZNm5VRWGvMXdfx0utA9J
	+/hRDK1ykU4u5wLYSkUruompJBmx8tdGivw2Y8P9Fm8mED1EWklA0qtUYtbfa6XMVrssmd0+WMss1
	jTpk3mWoe8rhKSNCK8N21hynw8/VD0BItjQ5w4D/JP8fR7YSAIy16vWzfY582i3egXgObMrxIYXpj
	b83FaXBDXzNTB9tdbVtuh+YGic+Te5wfqRTBPWNihtrzuTBJMGEju9sCRpqjS3yrlhu1FeL6Dxifa
	SoFAIAMvO4Yd1K8esAszL+RLntT2sCvlKuVf7sN/Rfj52BLG1cfh5Ehn1bXCGjsgLkHXNHKN/b6e7
	yrBQWbNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luJwS-00FGVK-Dr; Fri, 18 Jun 2021 19:14:12 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luJwQ-00FGUb-BJ
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 19:14:11 +0000
Received: by mail-wm1-f44.google.com with SMTP id k42so4378924wms.0
 for <linux-nvme@lists.infradead.org>; Fri, 18 Jun 2021 12:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2D0JIR/yCMWP9ddusUhsB4tHY7xNe3sUUBUBULDr2wU=;
 b=U5LsTHX1K2yOIN04QQDYZkPu5B7vrFcR8JbmeoLxOmBj54xG+xA1LTyrNRX8wY7ffb
 p9DAewmFBLO+jXrUv4hFClWodDeEwvGYybV4ikNx7HeHsXm4n+bsckpeiQCU9DC4XlPp
 mHyrl0yJ5aAmV2h4DyiJmcD9cxGBs4WuBB1l0X+XZT1IH2Bwkolk/cpgFLvJ1oTs9uwN
 7d9XroustfOyhLA/DVTdZ4U9Zs1y1kBrjYEB1iXwKTE4O6S3puT8VA5qNXjSOhtDA+kb
 nnlcZENESCqFGeJH/N+1xTt/mg1iPzOq4jiA8cntyuo2KRa1l+PHYsMX7VfyvRoYxU3p
 AAYg==
X-Gm-Message-State: AOAM532UGhTglF+UU8EyRUljpr0TWsOHe1kpWWe8n7qU4GuYukifaE4H
 IpHWRv1Sll3939j4ijABv6k=
X-Google-Smtp-Source: ABdhPJxDNvJ7A0V30xd9UcbyCOBs2YuLgZOQq0tRhfmmRYx9ktRh6mF3/iyVHgicTi64PnSVUu4ZpA==
X-Received: by 2002:a1c:2605:: with SMTP id m5mr6222972wmm.123.1624043648138; 
 Fri, 18 Jun 2021 12:14:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a7f7:d0fd:6992:6b31?
 ([2601:647:4802:9070:a7f7:d0fd:6992:6b31])
 by smtp.gmail.com with ESMTPSA id w23sm12450717wmi.0.2021.06.18.12.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jun 2021 12:14:07 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name
 for OPT_HOST_IFACE
To: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 martin.belanger@dell.com, aelior@marvell.com, okulkarni@marvell.com,
 smalin@marvell.com, prabhakar.pkin@gmail.com, malin1024@gmail.com
References: <20210618133956.10637-1-pkushwaha@marvell.com>
 <20210618134244.GA16005@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <78d5833d-2038-811c-f6a4-2f14a3996fc5@grimberg.me>
Date: Fri, 18 Jun 2021 12:14:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618134244.GA16005@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_121410_444893_FA580F60 
X-CRM114-Status: GOOD (  14.00  )
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


>> dev_get_by_name() finds network device by name but it also increases
>> reference count.
>> Increasing the ref count,
>> If nvme-tcp queue is present and the network device driver is removed
>> before nvme_tcp, we will face the following continuous log:
>>    "kernel:unregister_netdevice: waiting for <eth> to become
>>    free. Usage count = 2"
>> And rmmod further halts. Similar case arises during reboot/shutdown
>> with nvme-tcp queue present and both never completes.
>>
>> As a fix we will use __dev_get_by_name() which find network device by
>> name without increasing any reference counter.
> 
> And when you remove it without the refcount we'll now have a stale
> kernel pointer?

The netdev is not actually needed, its to make sure that it exist as
reference in the host_iface afaict (the netdev is never referenced
afterwards), and I'm pretty sure there was a matching put somewhere in
the former versions of this patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
