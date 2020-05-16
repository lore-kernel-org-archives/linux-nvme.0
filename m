Return-Path: <SRS0=k/Zk=66=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363CC433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2020 13:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679CC20643
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ClK1RATF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679CC20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MrE+oM0M0thnxhsE9n0h1IgDKcgAHZ5Ehp+V6e9bcy0=; b=ClK1RATFp1bcHN
	wiMwq8Suaek3ljnkxpmrvAGVASr5M/dovYU+T9fZM6BgjwuHaE0sumPLiI98mYeT2Xuj9rhO9cUqt
	qlPX+GQx6qY48zUNorxPQ7VsCcWE5BgLn1P8Wk/8QFXCFKwk4Bk0RD0Pt9kshOBWFLFPivejiY10J
	YRj0PvTHduTHIz5fVvSPdflxNQbAq/XWuyGZhJUCfq7BPJi342xBOgroLHOJr9xq0GWuxmOX7380J
	tJC9TdYll67GOuCgQCDOZPe/AjinkG/EIYAeRQQL1Zj3FhCn4e0IqfXVUNbCnmZ2G5W+fGPmwnKfl
	rcPf/MQ6dSTlu1IQ0bQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZwoq-0003Ch-NE; Sat, 16 May 2020 13:25:36 +0000
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZwop-0003CY-IM; Sat, 16 May 2020 13:25:35 +0000
Date: Sat, 16 May 2020 15:25:32 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] nvme fix for 5.7
Message-ID: <20200516132532.GA244143@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 59c7c3caaaf8750df4ec3255082f15eb4e371514:

  nvme: fix possible hang when ns scanning fails during error recovery (2020-05-09 16:07:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to b69e2ef24b7b4867f80f47e2781e95d0bacd15cb:

  nvme-pci: dma read memory barrier for completions (2020-05-12 18:02:24 +0200)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: dma read memory barrier for completions

 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
