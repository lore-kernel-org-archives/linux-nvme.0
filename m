Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:33:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72ED64DCF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72ED64DCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/Z1A8J9W+HlCrt75Nkjtpa7o6fkHsUXux7utnSHCvr0=; b=2vhqC/nT0xdFLhNj4ZESsU/nh
	C7LfDaGhkLSqCosSSI5tLH5HiZFVKX+VBJp2IuQLPAdYcj9QJsJ/6fR6xKxPsHe2UuDs0bPe9n8yb
	T+LMvzJ353SXXGz9WBu+Lnt95Yq2iSDA8j9TiMilowsjuSPqJCDogY4pKWzaJWSngIsqinzXqjAor
	I7QX521lU5TOLqlq1c5xqSCKEvQfdBuSwInzpq78/EHHizL3GMfMBgDRCN/iS8RP2eMBqYJmE4nmc
	MIuo5C+VQv4Tp4aZC0pgxdAHtD0bQBoC7EgzpuJ0f5LC44VTtCW46hc4lHMpKWTZvCopK7fNL6R53
	TDptajOtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGmN-0003LK-UK; Thu, 11 Feb 2021 18:33:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGmL-0003KY-Eo
 for linux-nvme@merlin.infradead.org; Thu, 11 Feb 2021 18:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vk/zx/cn4qqDUcNFMuSktnN4N6etVJhff6bENdZeajI=; b=uwhKmEuj07URDtJuU6fveCDVAI
 ncbpoRDyaGup9iiaTxtRaD7ExW5tg5lpP/BLS32jfiKVShp4Bm2hkqGBe9UajYyUzvNs8ERK6Ori2
 RmsDtAGGNs4+zOfcgN9SSoodKZ0MTj88fNbJcFJQ9FqgVTe8D35gB/S8KVaxjh4r2kD8NygdKkaPM
 nOXx6HNL1QxwtfIr8F76EYNTnanY1toXKyzWhyGZ1Nso+9w1t5sxVvwiP3ld4f1pxSFr1arO4bA5R
 YqKAeeoBLndSJRDoASv6/d60QwfklrV17XYyJ7QYeeTjzFljy85mevy4XASY4FG0JHdpgoG9hNBAz
 EdaOSxHg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lAGmC-00AbdW-37; Thu, 11 Feb 2021 18:33:21 +0000
Date: Thu, 11 Feb 2021 18:33:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] second round of nvme updates for 5.12
Message-ID: <20210211183316.GA2527859@infradead.org>
References: <YCV0PmcdMDOeQp5Q@infradead.org>
 <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 11:31:58AM -0700, Jens Axboe wrote:
> On 2/11/21 11:15 AM, Christoph Hellwig wrote:
> > Note that we have some issues with the previous updates.  We're working
> > fast on fixes for those, but in the meantime I think it is good to get
> > these changes out to you and into linux-next.
> 
> Pulled - it throws a trivial reject in the quirks list, fwiw.

Yes, people are producing buggy controllers way to quickly.. :(

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
