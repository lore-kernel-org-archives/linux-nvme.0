Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52190C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:52:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB122072E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cBdUMBwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB122072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UU06linNHUVqcwo69k3gqHcIYUfg5qR/EehIL2Z+HAs=; b=cBdUMBwlbVldHwhVr9ZPr7xed
	pOcgoAWOSypSqKqscRhFRap25PbxJ5pGAz/AV1gv9zqVmbgFiOPaK/Awdz/Xyot8bJW9PAf8FFNuF
	u2BYc5m2g486zdmcXV0QIzJqh5cjat854cOnrYE4y8WAdBX6jjUO86ixtFbj6gUYBMqbvK0lnKsGR
	jR2mJFbwU5LL5gU/plsQ7emYJbe8Yi1aLMQEFJnQRSRIwac1rNhlhTlH0PKuKkh4yP3mp14ETLpxY
	jrxJMPL4ehPsBo45e6+HPWTPYM6WGvRC1PP3j91zoauDD9ph98+n6k0bwlyESSZm3jCd3N9KfRRs5
	ZIy+e2frA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb7mh-0003nH-6y; Fri, 06 Nov 2020 19:52:31 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb7mc-0003mc-Fi
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 19:52:29 +0000
Received: by mail-wr1-f67.google.com with SMTP id w14so2511785wrs.9
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 11:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=82VBWRHTD/G66f+vt8o4R1g4BvDFQmUjE2w0WuNaobk=;
 b=TFvj+3+7/NmclG14qD7YtGZ3GASCrG2/yHbK76XUnz84Hsg2J/plV2a70jNmIhNiVL
 qhA6+khcnPLc4zsYGM7Nbhwq8mFCyk2mBbGpFM4igjMAGR8+8ExT1N27aW/9W8kaIsOH
 nGBtepZOGvMkoS0wg0G3CvYRDnIrSVem0l43TrvgyOQ21H8kMAu6YGDv5+UozxLr55yz
 OCjDHriOpWupPldxtP6t3yklssAGrbyj4eTuBsjKyNmBA9wH1dFRus5Z21sfcJMu5acG
 7zAuSgzn9+XGjgGCFZb1zkRrvUig3obZBoeSiBMqZVm60+8biG8r78NhkgKgTRbH9WDt
 YTVw==
X-Gm-Message-State: AOAM530I/vYCXiK6c4oNeu9Ny83cUhJJiFXGSfggfN9m+UCb+62p6eLU
 li6gi9dG4fNR6vFfl6uihKGwe8fFn6A=
X-Google-Smtp-Source: ABdhPJzvldpFYvcDoWKTT+638oLJZb6Ysgm+E6uCkbcynHjBtBV0w/yyRPp8JaoOZvkItFOydNpTOg==
X-Received: by 2002:adf:e446:: with SMTP id t6mr4195906wrm.46.1604692345004;
 Fri, 06 Nov 2020 11:52:25 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5d93:b4fd:df52:2680?
 ([2601:647:4802:9070:5d93:b4fd:df52:2680])
 by smtp.gmail.com with ESMTPSA id n123sm1755603wmn.38.2020.11.06.11.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 11:52:24 -0800 (PST)
Subject: Re: [PATCH] nvme: revert commit 1293477f4f32 as it is breaking
 BLKROSET
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20201106171835.38236-1-sagi@grimberg.me>
 <20201106175949.GA7529@lst.de>
 <443079c6-2dd0-f52d-4b2f-f7f9dec2792d@grimberg.me>
 <AEE672B4-1BEA-4DBF-9E86-0C443C10F842@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <edfbaf81-9d7f-7bc4-d78b-6dd67d351880@grimberg.me>
Date: Fri, 6 Nov 2020 11:52:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AEE672B4-1BEA-4DBF-9E86-0C443C10F842@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_145226_564472_7D00772E 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> The offending commit breaks BLKROSET ioctl because a device
>>>> revalidation will blindly override BLKROSET setting.
>>>>
>>>> The author should resubmit this commit in a way that does
>>>> not break BLKROSET.
>>> Let's fix this properly instead of a blind revert.
>>
>> I've asked Chaitanya to address this, but I guess he didn't
>> get to it so at the very least lets not keep the breakage.
> 
> Yes it is on the list. I am really sorry I got busy with blocktrace [1] 
> work for last couple of weeks.

Not a problem at all really, we are all busy.

> Sagi, I am okay if you want to fix this. Otherwise I'll try and get this 
> and the target side fix next week for sure.

There is no target side fix here, it's just the host that needs fixing.

Still I think this needs to be reverted first and pulled into stable and
re-added correctly. I'm waiting to hear Christoph's opinion here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
