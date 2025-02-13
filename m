Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702ADC021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lHO/e1kP3T3vxCGT4kSbIRJmy3KLzPFvq3IAT23/mHE=; b=oN6GGOOsCIOWfd63+/A9Nw2SS9
	k59upOIzrx/uAhldrLI9klJT7uGI4sWj8+sqD77GlNV3ayG9S5Rkwaj8IrXF82sNnNw/kFG4UbfvH
	6azAQNdxcL1RIEQtUqxD68ys522q5epkFzmwXpfd13Z6sWGkZdGUr4+oEZi2+ZeCLEtBsS182+Z5/
	K7B/qIaFEcqLYhUn1E78Aox4N7ACGbJpJ7h/0DQI5hxtYpGhE4Bs0Fme9PzRel9Cd33BFkvSH31ne
	tfuAPdkd73LNMFi5B02TvVL9PqAKCvmCpZBEpuqpINtLWyk19TnVE1PDsFwZ49wi2A5T1sIX71jCj
	D6jR9tcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5P-0000000A0Fn-3TM4;
	Thu, 13 Feb 2025 06:52:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5N-0000000A0Ea-3Qb8
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:52:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ACF69A41E70;
	Thu, 13 Feb 2025 06:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1821AC4CED1;
	Thu, 13 Feb 2025 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429552;
	bh=pozc24DNIVX3d1IJLykyuieG1DYynBTwgYPnKoVCy0Y=;
	h=From:To:Subject:Date:From;
	b=RcsPbew+bhFB+0p3FkI6bQ+z5ntE60ZOxUWfYkKMUNffjq5SRfYAHLY1XasgKqG3Y
	 a7RK3XWU2pHPco80pYfgDBFwU1aqUWxeyb5R2ic0QUwrjStJspZQoTOXYHzaqUjIYh
	 MbGBNwdKRc7SiDqd4qIafbHggRWOVNIY+PtFI8RBcUFPYqBDPpMvaUjgdq/aR0d+dA
	 lTzqAv5f47luZaVyBIsrKkg+eqemIlixniM+ixq5It0pXRPZgiyyRtiHtkzUQPQJ0P
	 qmW3hbFOtWANPMnBxhm89nHJDwTz2FWp3WhB3G7e1sEZy8DLKmHHTUFak1Sm0OqWgV
	 t5dw7CVHAEEGA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 0/4] nvme pci-epf target and tcp host fixes
Date: Thu, 13 Feb 2025 15:52:27 +0900
Message-ID: <20250213065231.598527-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225233_934639_E2DD0502 
X-CRM114-Status: GOOD (  10.10  )
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

All,

4 patches in this series to fix some issues with the PCI endpoint
function target driver and a trivial fix for a compilation warning with
the tcp fabrics host driver.

Changes from v2:
 - Fixed a typo in the commit message of patch 3
 - Added review tags from Christoph

Changes from v1:
 - Added patch 3 to fixe RCU stalls under heavy workload with the
   pci-epf target driver

Damien Le Moal (4):
  nvmet: pci-epf: Correctly initialize CSTS when enabling the controller
  nvmet: pci-epf: Do not uselessly write the CSTS register
  nvmet: pci-epf: Avoid RCU stalls under heavy workload
  nvme: tcp: Fix compilation warning with W=1

 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/pci-epf.c | 39 ++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.48.1


