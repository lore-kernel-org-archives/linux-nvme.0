Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028AEC021A8
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pPs1PULmyqROdduHY+BzBlpYj2mvi0SQhbf6xmXR4Es=; b=Tr/Ak1Xy8A9jGiWh7157KWgPYk
	odvqcp2QXKfI1TnG5YveZe1y2N6TMB4a+akBSL5RJfaeGTPwOMI6ZBeKe9iyzPiab1B1B9RGXwmKL
	QeBwm+1cTxbYdSkJLS5B9Q3A9vyR+WfVhXanAhDUNAJIEmlGhw5fOEUgLSdfxdLFQtmQDmkRefbcA
	FEetM33CYr7LeoJBJRB8svJ5yAAwyQvdAcX5AZQV3M+0chE3HZXUElx+gKW+bxWoo+IcpuNmt4F1x
	saMoM58vTzbCtaFmdwgMdkExORY3YpfPeaQb5sQJLuYMZ9CtvfaiG2ReR8zU6kyKycnXA4eENCNMB
	Qa68SyxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT30-00000009zea-0I0T;
	Thu, 13 Feb 2025 06:50:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT2x-00000009zdf-23Nh
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:50:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6D82DA40B53;
	Thu, 13 Feb 2025 06:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70C0C4CED1;
	Thu, 13 Feb 2025 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429402;
	bh=zqf5B/niBJim+NvwlOY3uDJHYnefz7CqH85yLyo+Spk=;
	h=From:To:Subject:Date:From;
	b=bfW2ohGrqi5qJxAsFYmoqCYSSdJEmNaBMsfaLXs2TcA1acAhAQfDE8dYTeVJGofhi
	 0XWtxDSHf6oFQLTvUPS0uSOi0MPQzpiLMiS+drb0IrubPOUQpNX7Kmdp3XueUHQaxh
	 T1+0ITuRnwncnu7xspDpz0xqmJt2Fop6kUFGoIYLgPI1ISjQ6/ke/VKiBZKzEQFw93
	 tAW9NKCZa5czwPYtGkHg0XDVZM0n8j/l6RpjMl/YD8cJE3nz6N0rmuX0JMMxapmypa
	 btN8OWepRcJsSj2BjwaT6qQ/b13Qo57rhEzFocdGFiv4ldGcfaZQmVKt5Tr7PGKDLQ
	 8hwvIQugu5xZA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 0/2] Cleanup controller configuration register handling
Date: Thu, 13 Feb 2025 15:49:58 +0900
Message-ID: <20250213065000.598443-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225003_608762_BFF69FE1 
X-CRM114-Status: UNSURE (   7.03  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A couple of patches to cleanup the definition and handling of the CC
register. No functional changes.

Changes from v1:
 - Added comments to describe the CC enum and its fields (patch 1)
 - Added review tags to patch 2

Damien Le Moal (2):
  nvme: Cleanup the definition of the controller config register fields
  nvmet: Use enum definitions instead of hardcoded values

 drivers/nvme/target/nvmet.h | 14 ++++++-------
 include/linux/nvme.h        | 40 ++++++++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.48.1


