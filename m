Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 11:50:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5407464E43
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 11:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407464E43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wDbVIbCLRYN2/TAZ8ef9Wn4iKW4QtPodmMpSJDyzTwA=; b=GDCGXaVeUtv+F+wlatjO17wu6
	10BqyGr3vTF4M7h9HGG2hjiortgoZXkLGsiPnkZijt7hpQBpfaZuvj7dxMO9Ub4mBkfIai6Q1FSnX
	bL4BpJdZHpoHeXJfVODGhibTOhqTf6/J5D2SqFxN4mxH+x7jwRzKkAn/qokdjIMA2xaEpGMe0NEww
	bKtIOwcaKa4jlUS/zW3ogdaX5++Q53Ld7x4hNUdsjpEWphiSJX/UADFdxJd9eoP9zdnDmJvZU+rS/
	oPZQ70E6St3Heu3Xg/2r8g6c6yvbj6RLfnyg0hksLimFiFJBKBW6+kO9o6IM33fZkOL3YkFSW8opl
	heS5DM+MQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7zdH-0001Tv-TK; Fri, 05 Feb 2021 11:50:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7zdF-0001TM-3v
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 11:50:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6187268AFE; Fri,  5 Feb 2021 12:50:33 +0100 (CET)
Date: Fri, 5 Feb 2021 12:50:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com, gregkh@linuxfoundation.org
Subject: Re: preserve DMA offsets when using swiotlb
Message-ID: <20210205115033.GA12623@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204193035.2606838-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_065037_285871_AD7981BB 
X-CRM114-Status: UNSURE (   6.78  )
X-CRM114-Notice: Please train this message.
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've pushed the updated series out to:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-offset

but I'm going to wait until next week before patch bombing everyone
again.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
