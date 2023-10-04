Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF88E776F4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O01uaH/mWaIV06XbfQucqYnxGQibrAhKXDhf3cAFcVY=; b=KCp07qI+tTF4FTSDQYUugowe8v
	5nyXLJEBKcPB7g7To/Y913DTno+dDcdUNP9Gk/u7bKyyIgvEigpT6m0NsbZP4TE4i1ZWTpieiisAX
	VPtYdX7LETH+lKjIe2XrL/pNkw1oAVLEWpSjpRz2bdbXuA3sveEFmIdTNDpjAiuE9AAmsAAdmAZt4
	xmqTDS+9cRGi/qyFI5mqlRWK6W1yjLehQK+uexD8omyuTpDzmjpSD3XAqFwHrsMoF2AXgf8OxbRWY
	CuW8zlfFXnelUJc+v1uiB+XgV8GfVgRYnrtPgAcHALnP9aPu3/zWzpi0Mp8rdG/aKd+rvpb1nm5YB
	6M7I3pkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qny2J-00H2Go-2Y;
	Wed, 04 Oct 2023 09:19:19 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qny2G-00H2El-0I
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 09:19:18 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40651b22977so3934275e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 02:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411154; x=1697015954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O01uaH/mWaIV06XbfQucqYnxGQibrAhKXDhf3cAFcVY=;
        b=EZ2t9IP2X8QT5n3lfStL6i5kNfdbHWKP0oeQnwjRf3kemqzK26yoZrxALYDp3/Ea1y
         838oeVE3yVdjGJQDtWqluwwQVdR84V5sBCOifvXZIjHUAu1s6KoJkZmYeJkKSbO6+mDy
         HyT+0C/dKsYHelyF+156alYHxUZMwgkJcIUwUUpeZUWqbMb5Ym74UZWkOgjd87nEjuK4
         CbmKeiPHehDUTLG/ZJ9YAO7Cwr1A6wUNIfnByY+FO75IDdosLbTnNWizi2VRYgC5FgpK
         QbJ2WUd7EOZrqxbAJPr9h7TOxxc/Zt/xz3nd7jwMo2fM1tSH3q7yQbRsEIEWKl+I3/wA
         10bA==
X-Gm-Message-State: AOJu0YzxTZV/SaCZrrul0wZmp2O8P2j37vAMU0JwyJx5B8mg9BIXZGO0
	tSh6URrw53siW4wxp5xvv/65Z3zakCc=
X-Google-Smtp-Source: AGHT+IFpuIJeG00L/COf3bfIrEzYq4VgjvnCg79wpFdmR/NSUV2UBmJGhpFkOKEGDvcia6VzsDirnA==
X-Received: by 2002:a05:600c:448a:b0:404:74bf:fb3e with SMTP id e10-20020a05600c448a00b0040474bffb3emr1705040wmo.2.1696411153464;
        Wed, 04 Oct 2023 02:19:13 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm1002329wmm.43.2023.10.04.02.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:19:12 -0700 (PDT)
Message-ID: <5d482435-50b7-f549-d170-a58f29f5cf25@grimberg.me>
Date: Wed, 4 Oct 2023 12:19:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>, Ewan Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com,
 Thomas Song <thomassong0721@gmail.com>,
 Randy Jennings <randyj@purestorage.com>,
 Prabhath Sajeepa <psajeepa@purestorage.com>
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
 <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
 <CAGtn9rmi33WNTibBRWWDJV98QzC1-wPVEdYObtVbi6DihmmCYQ@mail.gmail.com>
 <ZRx1Vtz8A+5Bmo2f@dev-ushankar.dev.purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZRx1Vtz8A+5Bmo2f@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_021916_129143_DDCCD5EC 
X-CRM114-Status: GOOD (  15.85  )
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


> I don't know if this is due to the "using xarray on 'small' arrays is
> horrible for performance" that Hannes mentioned. Maybe reverting that
> patch would help things, but I still prefer the atomics approach for its
> simplicity and the fact that the data does not indicate that the two new
> RMW ops per I/O are a source of issues. If the contention is still
> considered a problem, we can "split" the atomic into pieces along:
> 
> - namespace boundaries, so that the atomic lives in struct nvme_ns
>    instead of struct nvme_ctrl. if different CPUs are doing I/O to
>    different namespaces (which may be a common access pattern), this will
>    reduce the contention on the atomic. this would give us pretty much a
>    1:1 translation of the queue-length path selector from dm.
> - hctx boundaries - when we calculate the queue depth, instead of
>    summing the depths for every path's hctxs, only consider the hctx
>    associated to the local CPU.

I think that this is the best approach. It is matching the existing
synchronization boundary in the io-path today.

