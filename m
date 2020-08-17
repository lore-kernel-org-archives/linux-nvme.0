Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE8C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279B020658
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FuAZ/eqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279B020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lbTuG4ZjLDQvq6Qsn7qQMkKO0/XPV+RjdybGg82U4Gg=; b=FuAZ/eqPuXEDZg8mhtVZGO/o4
	8LXx8CF6hmiFaFdVsRao8e0b/5DtmOTyi+wVvWiXjfPKXPDefVn1X/+SSAX9UqhOEbLVg8I4sxd4o
	pBIgeYkAu1wgh1YJJtHSuqTz3f/0QTO/WuVi1V9S0RbaA/lODr7b+GAUxevNZH4ERuKhh+d8xMtIp
	OniS9iSYmaq+xQwpZbB3prVGD1T87/zjdnhZ+0Gf1ZJGV4yD3z4C5xoCJUR4VnAZMtwiv3H7SE0HR
	7Zh1JbIHpYAWSTkU8kQGHCAQYqggFcXQyZrfxMTp3rQJMS9CfspulQkr1cbyW9hbGJgAyDW5AR7pp
	BJf0I/44A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7jal-00055e-L0; Mon, 17 Aug 2020 18:10:43 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7jah-00054k-0a
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 18:10:39 +0000
Received: by mail-pl1-f170.google.com with SMTP id y6so7935675plt.3
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 11:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ilzjTm8ueSELQ69EqqtVtzSjyPmqx1wtmFWqOT/Hwls=;
 b=Z84vyV7Yw+i3CXt1Q11SJDkSoXsGM22OhVnHxMogfS23bVemL19ZI6k0FavYWqjH8s
 PoWTk95LuMPiwWfKv2oKeIvHoS5VziJaaUbg+UBegffXtxhRwUKZRRaTdABgJSkRqBuX
 P77X9ac66oa6ZBZ6F2ch2D4HAYXF3LA6avGamXQsp1VPDfIlMDcgohEejDj+r6oED1a0
 R+2sM8T6Jk+yUXFxuPtRMW8fXAOiX9uXfkfKIR+iw1cBVCIt6IWmw3898j+T6PISXrE4
 hZYYDigvgvIiRSgd8/FxHiZAsAHYBEOV3xen2qHLwIEtHA6j2ClX2O9CRmJqV7p4Pqwg
 cZzA==
X-Gm-Message-State: AOAM533nGscx78nVhVqbk1qGovU077ByX61In4jDKuzdaP8dSsphfMkM
 eS6+Er2Y44wskUTwxtFlZLejHoWxscxoLA==
X-Google-Smtp-Source: ABdhPJzOQT2BPxqwxMTZ6hIbUf6HOyICrycLw2HirF+wNUpHksGSGJRAmvI4TIR6tqB5lYdb+eCfbg==
X-Received: by 2002:a17:90a:d986:: with SMTP id
 d6mr12709430pjv.134.1597687837883; 
 Mon, 17 Aug 2020 11:10:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c8a:c3fd:4152:60d0?
 ([2601:647:4802:9070:c8a:c3fd:4152:60d0])
 by smtp.gmail.com with ESMTPSA id f63sm19089347pjk.53.2020.08.17.11.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 11:10:37 -0700 (PDT)
Subject: Re: nvme completion handling refactor and fix v2
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200817081544.837699-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f98bdfe-0e9f-60a5-85e3-88910ef0a8a4@grimberg.me>
Date: Mon, 17 Aug 2020 11:10:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_141039_137793_0A005364 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi all,
> 
> the first two patches refactor the common nvme completion code
> to be a little less obsfucated, and the third one is the fix
> from Chao to redirect to a different path ported on top of these
> changes, which now make the fix very simple.
> 
> Changes since v1:
>   - add a new patch to handle the path related errors using the
>     SCT class

This looks good to me,

Do you think this is 5.9-rc material? I'm thinking this should go
to 5.10...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
