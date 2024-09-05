Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA140CD5BC9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Buxnn03sjLxKGzojZB/OsfcXOINOBgXFeRjhnu+DLA4=; b=UHoejZqzmqnSJigqPX0B5mUS/x
	TfIPBwUz3T3FuiA1bdpxsXtVfa/pUl09KCOSgFf8Vnpoa4Dr/UrCwqFpgdUcu/96QRawqq2HtZQnA
	ggrKpEYlUnl8Cgjjf4Mj76ogCCaqQdg1IXZRW6QrwgJnkLIHuNrcRTvuIPoXNOfYDXhKwkZE/Xv3r
	bMCLI0hOZE0u1/yj4EJN61Ye/L0O3e5GEJ8BjfiQUexjx/9QNiOZItDROwYZJIyj9H5S2Flo4Zxz9
	2om6C0+BOIkoO0bOAaE6sXs+HkQ8c61ngokfmuJFGgC6/f+O++QfnsRGknNFnn7ob4wjVJtD8GSRf
	WY28SvOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smDhL-00000008ltH-2wuF;
	Thu, 05 Sep 2024 14:42:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smDfW-00000008lPH-3V11
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 14:41:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD7255C59E3;
	Thu,  5 Sep 2024 14:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966C6C4CEC3;
	Thu,  5 Sep 2024 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547265;
	bh=oVY5ow3vpbfLHFxDfGIJcV6jYif7zUmkC781yDzRjpg=;
	h=Date:From:To:Cc:Subject:From;
	b=I9cMvFFK3MneRfEMNLTZ/NUpk7d7eGZPXXSiZJwnuJQwXcweRpASJGQsTNbNOQr+Q
	 nJ8v2RxfwyBxAhLb0kR2Zkh+091RoOHi2wlCkVTHQnxA1DXgCd9AG/2qFFGPmKTTKU
	 yg2FhGy9AHUsJ8J30XOV6F2Q79NNhUpo0VgC1yleSGFP37SXYzrnJT2FszOP/bTd4y
	 e3omG4CjPB0vJnAcUHlO7KDD01Whs5XQNLzOFzIJrk4tdwuKO6ATNYpsn14uMHrm+H
	 loJHCG0rAYSA2TAanIFgF5XQ0mTLQ4Jam5uKkUeAAFA9CPvK94gPU6X5IkgeuG3Z0C
	 X2NiFf2idmkng==
Date: Thu, 5 Sep 2024 08:41:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.11
Message-ID: <ZtnC_xT5S0X2ZuZB@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_074106_936279_65687DBB 
X-CRM114-Status: UNSURE (   8.34  )
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

The following changes since commit e6b09a173870720e4d4c6fd755803970015ac043:

  Merge tag 'nvme-6.11-2024-08-22' of git://git.infradead.org/nvme into block-6.11 (2024-08-22 16:20:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.11-2024-09-05

for you to fetch changes up to 899d2e5a4e3d36689e8938e152f4b69a4bcc6b4d:

  nvmet: Identify-Active Namespace ID List command should reject invalid nsid (2024-09-03 10:05:40 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.11

 - Sparse fix on static symbol (Jinjie)
 - Misleading warning message fix (Keith)
 - TCP command allocation handling fix (Maurizio)
 - PCI tagset allocation handling fix (Keith)
 - Low-power quirk for Samsung (Georg)
 - Queue limits fix for zone devices (Christoph)
 - Target protocol behavior fix (Maurizio)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: set BLK_FEAT_ZONED for ZNS multipath disks

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Samsung 990 Evo

Jinjie Ruan (1):
      nvmet: Make nvmet_debugfs static

Keith Busch (2):
      nvme: use better description for async reset reason
      nvme-pci: allocate tagset on reset if necessary

Maurizio Lombardi (2):
      nvmet-tcp: fix kernel crash if commands allocation fails
      nvmet: Identify-Active Namespace ID List command should reject invalid nsid

 drivers/nvme/host/core.c        |  3 ++-
 drivers/nvme/host/multipath.c   |  4 +++-
 drivers/nvme/host/pci.c         | 17 +++++++++++++++++
 drivers/nvme/target/admin-cmd.c | 10 ++++++++++
 drivers/nvme/target/debugfs.c   |  2 +-
 drivers/nvme/target/tcp.c       |  4 +++-
 6 files changed, 36 insertions(+), 4 deletions(-)


