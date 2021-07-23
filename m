Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7AC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 19:58:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF7660F46
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 19:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACF7660F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7OrWg87x7TJunIIrsV0E3D6uE75BhpYldU/ecbhmlWI=; b=Jn1UheLjM3rtZODmNR8bQNjYn7
	8pxEsk0T6RiUd45HPUrI3rO++7ORLbAVSCTxi0lYl+QkQEdbRklaWIaEddjsd3bENh/dk9o7iJPM3
	oVozO9dLOWFlDxgoCv3cR6OE2xwEXTG8sQrFcXMypYkGL6S+sgh2DeK/UQoqy7KavI3i8WaLg3JIf
	yOpvAstFsHkj64MFZIq6ghhCO8wAMJqnoZ0cRjmbFhDsYl9Yj8b/LnpQ4y5qy2e5VaJhXx6G6HB6a
	rLcHtP4S47cp6eJPL1imagoY6sjykNPtUdJ5U6Ov0FySeZQDt7clf6LfL4xU3yfSfAGACl+fI5axA
	mjJwCJDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m71JO-005nyG-V4; Fri, 23 Jul 2021 19:58:22 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m71JM-005nwu-7H
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 19:58:21 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 q17-20020a17090a2e11b02901757deaf2c8so5313751pjd.0
 for <linux-nvme@lists.infradead.org>; Fri, 23 Jul 2021 12:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jwa5ti/ORoAwUR5iyL8Ob16r47r/8vJd+eK+diYFsCs=;
 b=mExPAN7AhzcOFrlWa2TGXLXkHMrGF8pTMhcGUM9aZyoRg/XbxT2TZGnrxZKa7Wfbfc
 jt1/3wOjvQGdX5cqQ/bDRVr2M0ZZNdAwvLrOnGFpbXWe8RdTaIr2TmIilY7SIchkulg1
 5m3lXrXX/SZogkYD8diGPuoG2Psp+YOGdDgBVMfxWxQm0cPrpG6fHJySs7hu30QXdCqz
 LWnocXm9cJ3H67e718ZuCvStQ+IodEMMg4BpirSlLO5txqbuPxrhpqkOpc2BdBmOazmr
 u7n2L+Dgj01qPmyftlXcwIB+j3c1QnuoTx5waixSLfwl72VRwOObElXfyiEPfHrmAylz
 9Myw==
X-Gm-Message-State: AOAM530N0dVAhee9ugXiNyUhOcPFyxA473ymHYHyVl1FP0uqWSSv2fdz
 C2Va+K+d6GKEiAV3kOcKojA=
X-Google-Smtp-Source: ABdhPJwu04p+vMma++kGC8BhDw5Ta5Sy6G1a5C5fSsuYcx73W4xK6RtWNMXyQdz9JDtulNOJeXOrYg==
X-Received: by 2002:a65:4307:: with SMTP id j7mr6238422pgq.387.1627070299141; 
 Fri, 23 Jul 2021 12:58:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a676:ed9f:319b:a155?
 ([2601:647:4802:9070:a676:ed9f:319b:a155])
 by smtp.gmail.com with ESMTPSA id b3sm35814048pfi.179.2021.07.23.12.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jul 2021 12:58:18 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 00/36] nvme-tcp receive and tarnsmit offloads
To: Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@nvidia.com>
Cc: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, benishay@nvidia.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210723055626.GA32126@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02c4e0af-0ae9-f4d9-d2ad-65802bdf036a@grimberg.me>
Date: Fri, 23 Jul 2021 12:58:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723055626.GA32126@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210723_125820_323390_5A14413C 
X-CRM114-Status: GOOD (  15.53  )
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


>> * Add transmit offload patches
> 
> But to be honest, the previous one was already mostly unreviewable,
> but this is now far beyond this.   Please try to get anything that
> is generally useful first in smaller series and the come back with
> a somewhat reviewable series.  That also means that at least for the
> code I care about (nvme) the patches should be grouped together,
> and actually provide meaningful functionality in each patch.  Right
> now even trying to understand what you add to the nvme code requires
> me to jump all over a gigantic series.

I agree as well. It is difficult to review.
The order should be:
1. ulp_ddp interface
2. nvme-tcp changes
3. mlx5e changes

Also even beyond grouping patches together I have 2 requests:
1. Please consolidate ddp routines under a single ifdef (also minimize
the ifdef in call-sites).
2. When consolidating functions, try to do this as prep patches
documenting in the change log that it is preparing to add ddp. Its
difficult digesting both at times.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
