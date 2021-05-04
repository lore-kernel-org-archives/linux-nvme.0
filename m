Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39587C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:56:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43CA610A1
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43CA610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cd9ibg8xSKSAbjGnV46zAnZkPdHQnfXB4aCwgiOhoiY=; b=lxZcjMzvyubibhb5DWA/tU11m
	EbPcCW2daxyRZBj5W8KICxH6FTvnm29/jj7LBaxj4iz0wRY6o5avEz3s7MRorGr6F2udntK7qHAaD
	hJyte6/iY/2e3HoupSQNO8/UL2fkQ7lpiP1+vmGR8bwsf+5WHEVASCBE0Q3wV3tQeSjngxDYctdtQ
	o9IGZyqgsH6iHeCsCA3inFbchMYuIsrj48ct+wVtjQNvBXh+2FF/IFjsviQ1mJVY/UMaQOv5iDWS4
	htHPMq5V5HpZP+2jsc/L4dj0mT3JfQ5rmampf9TuMQek/rKRAsNXX5EYlCgZkFTRpAIBUI2KWcCpN
	yH1Ax17Ug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldqqr-00Fogy-TT; Tue, 04 May 2021 08:56:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldqqo-00FogW-RT
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 08:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ag9Gsq0BvRHF+NtImU324FHHEsCLSi88wQq+Nn81V74=; b=dMgwtC/k3AQ5uPxiDv4QfOdVO0
 iTMCmlp5HSOKZegg+s+nJmLAx5rufGmVByqLDHx199ZCgmcDha3+mPAZ1Lu4HyPPGB0xylKIXw4MD
 4ksxCL8yFVbfK/syHrDUUa/iK6NJBGCy9wqRy0iJsoLapR741bXOFtIiIa0rHQ7vyXxnCg2Dx3tPX
 uZLaQ/tBWLVcxdeVRTIJFYVUHkW5h5bgsyPJiFz7hI0ld2VjSS45smAgUWK/fquhf6c8Mu/Aq6XPP
 sxzhbC5MFDx7p5ha4M6sieDalNFisylO5dz3x7ffRNiFvw7pQc2aoO6iCIffpmXGJ8rQ2VTF9LIIL
 A4IdxTtw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldqqm-003pv5-Bz
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 08:56:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5190768AFE; Tue,  4 May 2021 10:56:14 +0200 (CEST)
Date: Tue, 4 May 2021 10:56:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 0/2] nvmet: consider req->sg_cnt for inline bio
Message-ID: <20210504085613.GA21953@lst.de>
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_015616_576002_1DFD0EFD 
X-CRM114-Status: GOOD (  13.58  )
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

On Thu, Apr 29, 2021 at 11:43:55AM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> While testing I came across the scenario where checking for the
> transfer size is not enough for inline bios, this issue is not easily
> reproducible with the test tools that I have.
> 
> This small patch-series adds an additional check so that we make sure 
> transfer size and the req->sg_cnt both fit in the inline bio for
> bdev and passthru backend.

How do you get the fragmented scatterlist?  Oh I guess this is due to
nvme-loop not using our page allocator but pages that come the
block layer?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
