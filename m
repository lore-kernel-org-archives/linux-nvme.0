Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619C1C4742C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 21:24:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CA220870
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D9tNjjdW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="WgiN9CB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CA220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P8ogPgLZ5/dbCLnpFJXcTXzf1t3/vlwIsGnARaxPa7I=; b=D9tNjjdWyQpC+89wzqWzJUpKT
	cKTjaO2ufMnZbJ2p2MktFplInzoM5h1Prq9et42groUFo1iqreLp2Q87uH5eY+rDW3lfMvcCFZrbJ
	4R7egrlY3MFsloVbz3VVHaqBUnNGiekYbE8W+sTs2qhvDtQ6ec/O1+TzMEm/XGva1Ibx9s3w7K0uC
	ZonoDVT2QB3HZiyqqstyeh0LmfXO0d1MHSZkhlYWsebhGHRY3RU5FBwYo1274/2i+LaOfR3gxTT02
	BwUaCLJ752cpE2Q2B9UcfHEHp5dyEMeNFXIuwgw+uUWLKEvRJ6cZPvaCra/dh6ip91LSQzfJkSslq
	oP8bN2GIA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZhJD-0003zM-Ei; Mon, 02 Nov 2020 21:24:11 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZhJA-0003yQ-I7
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 21:24:09 +0000
Received: by mail-ej1-x633.google.com with SMTP id za3so20847198ejb.5
 for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2020 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BipIl57MTmMMQMBlG+7ISd6m7Cm+omAdyc53iQ+SbyY=;
 b=WgiN9CB3FL0EJYyG1GCyEB83z1+z9qoXNdxL4XRxwQ66wq9l+rgeMHEI7HoOU2XzUo
 x1iQKoZv08dY7TSmZgT5mFjjlErBQsD5h0TRyk8UvMx8MLmC3lhmN0WLNQCT3f1hO1JT
 jqrwQpCduRgHyRv6gIxXOwrSszFzvsGwu+IaBexg7nQ3fJ8XSF95BrWHV53FbRN97xmm
 aKrMPM/zu34D0JRdEJssSXudTLPguORdZ7qZ/XPm62UDCRUbw0N+QVLnpz41yyvMk/xn
 YAplXYesI/FfMCseHg/aORc1qrBMa3tSCJwyi5nHkFt1C2dVhuKmacn76sD1NHk8qo1h
 qA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BipIl57MTmMMQMBlG+7ISd6m7Cm+omAdyc53iQ+SbyY=;
 b=fVa3HqSoXuR95U+aJeoQlDebDTGswvXbdjeHVFsx4QpF2URdv12OAEfKfq2ZDtHAHx
 tnNAN28SA81fgOitkb5X7Nk08D8lSo1n0kkwpMEj46Q7+12Lbb67WzdfbHG5rehq/U5p
 mU8ceCyymhwAsdlar8YbG2+7kdDM8PjxpZdWd8+sXdo8ARBQBdbMZX1KAMgqNEWxaJhu
 T6mkCek/uUmIXNOYaI2z6HUyhVNFVrXiAKadakBqutrHqRfpWCCrNI3OaxlsToaxmzdu
 0qtgQCwe4LvcWWYjMHWo/EKyu5gsfcXW379x/ajGR+sCJfdrDP2+seo2FDZKEO4UHnhO
 vCMA==
X-Gm-Message-State: AOAM533SMxNuDNpr3D0ORpkEb2dRfZVF7p0+Q2tXSlxr8LVaVAyNC3y7
 CQTMBScdjEgdSnwNteBQa9pg2w==
X-Google-Smtp-Source: ABdhPJxah9ERjLK5n4yrv9cRj2vDgPvBvq6uF5pZsPQOVp962pYQY2uZvpKkhzWxtCIObyacP8P64w==
X-Received: by 2002:a17:906:52c6:: with SMTP id
 w6mr16228680ejn.199.1604352247302; 
 Mon, 02 Nov 2020 13:24:07 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id k26sm11091887edf.85.2020.11.02.13.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 13:24:06 -0800 (PST)
From: Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date: Mon, 2 Nov 2020 22:24:05 +0100
To: "hch@lst.de" <hch@lst.de>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102185851.GA21349@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_162408_761935_128EFD50 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02.11.2020 19:58, hch@lst.de wrote:
>On Mon, Nov 02, 2020 at 10:33:55AM -0800, Keith Busch wrote:
>> I can see this going one of two ways:
>>
>>  a) Set up the existing controller character device with a generic
>>     disk-less request_queue to the IO queues accepting IO commands to
>>     arbitrary NSIDs.
>>
>>  b) Each namespace that can't be supported gets their own character
>>     device.
>>
>> I'm leaning toward option "a". While it doesn't create handles to unique
>> namespaces, it has more resilience to potentially future changes. And I
>> recall the target side had a potential use for that, too.
>
>The problem with a) is that it can't be used to give users or groups
>access to just one namespaces, so it causes a real access control
>nightmare.  The problem with b) is that now applications will break
>when we add support for new command sets or features.  I think
>
>  c) Each namespace gets its own character device, period.
>
>is the only sensible option.

This sounds reasonable. We have been back and forth on a patchset with
async passthru using io_uring. I believe this can help with some of the
questions we are preparing for a RFC.

If I understand correctly, the model would be that a namespace will
always have (i) a character device associated where I/O is always allowed
through user formed commands, and if the namespace has full support in
the kernel (ii) a block device where I/O is as it is today. In case of
(ii) both interfaces can be used for I/O.

While we work on iterations for c), do you believe it is reasonable to
merge a version of the current path that follows the PI convention for
unsupported command sets and features? I would assume that we will have
to convert PI to this model too when it is available.

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
