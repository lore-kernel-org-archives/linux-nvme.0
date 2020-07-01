Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86439C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 16:50:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513D82082F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 16:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2JPwqMPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513D82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=klg7GJkrFaMjhUXRd+GKYmmGC2B1VktsSUbvyQTJWq8=; b=2JPwqMPJ3fGT7HeZ4IeCNfYME
	fLz9BIdbbaAyqQ/RzkPR1RYrurSPB9p8AK3MQI/jDWm4a01qW7pdpBbhUhSxrsXgU7eS4pN5X4QOO
	w5fgNHCs4C8OdlQ50dwr1mPIeje2QxsN4yoAGM7P4vJh/3rTYx3a4Sfx5Fu1dlpFIaRnMA+FVFDSL
	lUCyoVKiqgVBukUH4hM7W5hwBEI/XBOsik6kCuV8592FDuhdiJKoTKQsT8ZgYcnXBBdFZ9b5Xr53l
	bbfprUERl4DG+7ATFnkzreOF9bDRolj+a8enCI0+cNCs0Umh+tb2T9ZjJL3jMIAXTvp2EGqDg9FWT
	cYtf0LpAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqfvr-0004Sz-Dk; Wed, 01 Jul 2020 16:49:59 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqfvo-0004S5-Cu
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 16:49:57 +0000
Received: by mail-wr1-f67.google.com with SMTP id a6so24809257wrm.4
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 09:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Il8M7piKZsLviUVc3qCtREK33rpPZK4ZrImpXyBCk4=;
 b=msFnW1FyaU4w1MiQ636dAWxPGCGNxvJjaBNfkYJ+WBejN1CUYcNRaEi4YfQyJx84fU
 DZGOtaNpyugBPxjUbfIplLVVKUpCaHvLqlr1CkWqtbw9gGKOtqyHx08nUBaOR3YkQkl2
 ei8k6rayTGgniujlN4oM4/Z7bGRQA94L1lemqW3G4B5bcsO3zHEKgOcvhFcmo4hwmR9T
 yXlVe2iznv/OyrdXmCyOlxwYP8pHLWBFKao52pBQsmjoICCT+nHFU8WmKCyzZIMevSc4
 lnzz9eYn4Qt2IOvVLYeBUdUrVlOPrUuaYgjVP4VdbwzuhQQgfAkwV04NHaYFR4SxH3wa
 2pLw==
X-Gm-Message-State: AOAM530iWEGieiNwIQ2KP+k1hPoaiD/SZFwf3hgZfQaWJt8TE7VcpQfh
 lvbdaFyuhN1C7Z1X/mnWoQE=
X-Google-Smtp-Source: ABdhPJzvavBWOE2uovtMKq9sH5CacZ7WjOpmtIOUr3wK8Kc+yY9aTByk3tVkOagY2t6R8GbSNpHVDA==
X-Received: by 2002:adf:8104:: with SMTP id 4mr28014812wrm.18.1593622194957;
 Wed, 01 Jul 2020 09:49:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:18f8:9053:b0e3:60d4?
 ([2601:647:4802:9070:18f8:9053:b0e3:60d4])
 by smtp.gmail.com with ESMTPSA id x11sm7417062wmc.26.2020.07.01.09.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 09:49:54 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701053609.GA28056@lst.de>
 <20200701132137.GA1988944@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d6d2853f-3600-514b-148c-3943338827d0@grimberg.me>
Date: Wed, 1 Jul 2020 09:49:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701132137.GA1988944@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_124956_466765_02F12EE0 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hi,
>>>
>>> This is a small patch-series which replaces ctrl->namespaces with
>>> xarray for host-core and target-core. We can see following
>>> performance improvement when running fio with 32 parallel jobs where
>>> first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
>>> detailed performance numbers.
>>
>> Why would that make any difference given that we don't look up namespaces
>> in the I/O path?
> 
> Not in host side. Target does a lookup on each IO through:
> 
>    nvmet_req_init()
>      nvmet_parse_io_cmrd()
>        nvmet_find_namespaces()
> 
> And this detail should be mentioned in the test setup for the cover
> letter, or in patch 2.

Maybe ns scanning performance will improve :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
