Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11561C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:03:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D6364DF2
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 16:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D6364DF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OYYOIC5M6TSTEIAibRCw6I/sqXv7a5LsbTYDrfOG5YY=; b=3dhBQMbLMl5b6JkswSlHvoHkKH
	7r/5uzKYlJEBRRRdhV8hjCrps4eAukBBbw6JJxvJIgQfSN3vG1n+E2XKtFjbieWsGHXASoAutknqp
	lGyuc3tVpz70jHD74qvCwxAPKpaTlKdLWfEXD0IXx/X/wF6S7HEBqa7o6cqNeXk7h6AV6FT4pdd3k
	sTEre3K7vlN8ul+9sF0Es1hh4iW9Qt3nBOLdD2/soRNOEY//yqlK63GzBeVgftb1jHY29CZFbG49b
	VB+eaIRkOcweS7smEL11NDElgbHNiaGdRwCR1xbdh36tGWGyJIyTspQyUh05yBbvYrSLFlIphcTK+
	LoEQB2uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8mX9-0004lb-Ip; Sun, 07 Feb 2021 16:03:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8mX7-0004lP-HN
 for linux-nvme@merlin.infradead.org; Sun, 07 Feb 2021 16:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=caubP3x4F2N1fMwvC+jHPhSbeSXCkxkUALBFz4aHrhY=; b=OYsthj5oNsV6Gvobfqu2KBiGzP
 dImcZ0Y5D62EEK/7FFoJNYFuuLou2PpukTOKA+AkOEKO/e8TGkz95H+PR8NcigdVw6wbS5RRDnwKN
 XdXzhWPq5VtxY5LUnzPSamVROIdZS1PhodYNJnH2ucNioNWgjeNWDbgj1p5vx/EmIaTCrn3WGQJR+
 G/xwS1N91tQ3Cf8C3DYLD6ugwFroQ4DaUYsytOsyM5DCvSA7L4apLl0UeplyNlkOllyySbwZM1wru
 kBUBaPAibcsoZGFrw0SXPc5kTGsMap2Dnlu3v10KehJrRJ5IfQeiY0KFzGj9KsMixSIBwHpNTjO6y
 2BMeKgtQ==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8mX4-004tMv-Bg; Sun, 07 Feb 2021 16:03:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: preserve DMA offsets when using swiotlb v2
Date: Sun,  7 Feb 2021 17:03:18 +0100
Message-Id: <20210207160327.2955490-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this series make NVMe happy when running with swiotlb.  This caters
towards to completely broken NVMe controllers that ignore the
specification (hello to the biggest cloud provider on the planet!),
to crappy SOC that have addressing limitations, or "secure"
virtualization that force bounce buffering to enhance the user
experience.  Or in other words, no one sane should hit it, but
people do.

It is basically a respin of the

    "SWIOTLB: Preserve swiotlb map offset when needed."

series from Jianxiong Gao.  It complete rewrites the swiotlb part so that
the offset really is preserved and not just the offset into the swiotlb
slot, and to do so it grew half a dozen patches to refactor the swiotlb
so that a mere mortal like me could actually understand it.

Changes since v2:
 - cleanup nr_slots a little more
 - fix a check in get_max_slots
 - add a IO_TLB_SIZE define
 - cleanup find_slots a little more
 - fix the nvme patch to actually compile

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
