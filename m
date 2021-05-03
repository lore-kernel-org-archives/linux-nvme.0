Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F88BC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 22:57:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4A461244
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 22:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4A461244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MOEnyvYZC8+cVfsyLDM0dqqAH7Z0bns3ji1KMMiDIJ4=; b=L7hNnw2MB/jD5/b6GLAIpuWhc
	aVsyC/YB87s5RPzWpmMJpkjj4Z1ysXbbJlFmwDTkm1I1asM+YuSjTq4b4T48wKPlTZoTnTaMB5Kgs
	AmRpAVna39EwsaKwcWtWPCZEMJxWYQv89Hpll1n+CLl4ZMTutdCxO1z2IbgNrW2iJpQ9BOfhm7Vs6
	a8nvtMV5pImVCpZDrwYL04rkoORrZ3t9ET7nwNLCE2dBsS2wJoE8axJU1P0Gxi6FBv2SYleGOaQbX
	0wFPdMLljlwyaui5V2cgtVCPA9T5ZQqLr4W4THr0glt0faYKcBw5/oDHAISPlrUbhEwJZ4jgHcgDe
	3AVZRPqdQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldhV6-00EyWL-AZ; Mon, 03 May 2021 22:57:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhV3-00EyVK-L3
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 22:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xZZm+3MFuedFCkj1MfVgDeM954nHR/3fXds6exXmQfs=; b=U4NocDhj5P9vzHxZtxcn8Xd9LO
 gJBfCyHlwZQEEt0cuHv46fi4vT7g5m78/OFQ65F3mVEv7u6mxPt9EBGIRqeEHQNG6XsHJLC8RugJz
 E6TGb71DpTrxRsbDb95HtsQZHjxXpfxgTDQc+mMH31taXayFa7VFAKFHDSA63YYOfqL32fADQZd6Q
 HwXzQyslJQZ+p5fp+EQoRUSuRU5Mw2curSWjxcu9T7qZFNX1JKvIOGTrx7o0o8+nglRHQbMM1hsVT
 FXa0eAMM4UcffO0Ms8icAvhNgsLMfUfga2WnR3P2fdE1BLXHrLOXIykS28j9GC1zIrxkP7WI//P+y
 MMP+1FFw==;
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhV0-003XDc-QD
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 22:57:12 +0000
Received: by mail-qk1-x730.google.com with SMTP id i67so3726016qkc.4
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xZZm+3MFuedFCkj1MfVgDeM954nHR/3fXds6exXmQfs=;
 b=ouRSQEEjT38vBUuV862SeUlllVCT6eH9A/DLELLKUUCUzA1ShVzuWVXQ1MBHwfUp52
 o2iY2zmGF5v6LzhQq+GBDBerKVAePtFNVbGHvM38jkoESd9bfzmAI5TW5EmfL78E08Qn
 KIGOFGei7/yO8yCpBYVzXmS09DZEEm+pTY6CGCqEpqr9/YKTEYQHHgmnMtxfiJhxhwEM
 PI6Kaqk2dLQBbp3lySC34PVTv8PJZyC4fg+IILviuxHg1B8L5kSFMxjKrsIeWCcV13AT
 K2K+mR+5wr9SajVl5e5SOe9bFPiH9IuQFOm4a7VNUrSG+YlFkkc7yhkY+MYykwPRCxJe
 dU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xZZm+3MFuedFCkj1MfVgDeM954nHR/3fXds6exXmQfs=;
 b=oOlb4SWHYX0tSXJjcyr6IQATU3266uVHERRB2A6yDaf/MEzi+rUlCOmVvduu+xM7ea
 NNvaKCBRPsewLxWrMRrJjEJy1WSbfyKq+4xkaqtSV9va8U2+f9kA8DBR67FdvVivDPTy
 H995lbxO1AHYCakXY5+VFGx9FNYV5dvfxMOq6se11xgdYZezTrsR6cH2heb1Cf6F3G9Z
 ukMl+ArOy4wenh2Y8Z1LVtvRyGSiUp0whnijSXKOMAdfEdFrRsSXFFjxRQ55l8BiRdp+
 cEB7PUBwJNh0elQeTSLTh5kODl7i+wiL5H3U7jQkL1yz/93Id0wlGpNu6HWAaVmxKaEE
 iSYg==
X-Gm-Message-State: AOAM530XUHcEknGpyDm1D4J6xK+sjZ0RGMzqjRApZVADHo1X/4SeHY1s
 3SspCIJ/jKK+eA8VslKqKzFs9A==
X-Google-Smtp-Source: ABdhPJwB6nytiC0oDMbKJRBwSIes/jqgsePpJ+MXFQRNiesNGamVx4ATl+XqEZHAz4GA6Yzrb48bvQ==
X-Received: by 2002:a37:a9c8:: with SMTP id s191mr6160737qke.430.1620082626750; 
 Mon, 03 May 2021 15:57:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id c17sm897865qtd.71.2021.05.03.15.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 15:57:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ldhUv-00H3QZ-2z; Mon, 03 May 2021 19:57:05 -0300
Date: Mon, 3 May 2021 19:57:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
Message-ID: <20210503225705.GA2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
 <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
 <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
 <f07f0ca7-9772-5b3b-4cea-9defcefaaf8b@nvidia.com>
 <ab0e4256-79c9-c181-5aec-f6869a92a80c@deltatee.com>
 <d4f19947-d4c1-451b-311f-9e31a4ded6fc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4f19947-d4c1-451b-311f-9e31a4ded6fc@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_155710_871601_7005F6AB 
X-CRM114-Status: GOOD (  10.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 03, 2021 at 02:54:26PM -0700, John Hubbard wrote:

> I guess my main concern here is that there are these pci*() functions
> that somehow want to pass around struct device.

Well, this is the main issue - helpers being used inside IOMMU code
should not be called pci* functions. This is some generic device p2p
interface that happens to only support PCI to PCI transfers today.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
