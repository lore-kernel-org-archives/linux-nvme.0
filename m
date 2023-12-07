Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABFDC10F05
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RWT/ehxsghunK0ZIPR5t1t2S4SaQbq0Qgtg9cb6J+fU=; b=nAkTaIR8p8H3rghTEIO7QlM0t7
	is66IS1J7KBvhNHZ3jTX8kqx/qNxqHmq6rCtlZzyYXsCTJnn6LnX0IbzPVSNnpoNIrKnhj9n7NaoX
	4Nrov/IemDzTQCN2JelOQ/1PzATqPQ1hTp0T237fTcwm/uvrvS95kXMAVznqckH2VPmVrE46oa7rM
	Jfsjx51zUfYwq2JnvnqaGd4+8hnqoMs1HHHMZsBD8ta+0Y9G3uC2LjBccWBPD7VMZIB435gDCFXtn
	93v1Ci3IiFTX8AjTOtSRm2D9T30mtfkoigWTq4LxCuX24rji84c/6pwZyjMBuBOLFIJEDptpEYcZL
	M1GCq8+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHpp-00DUt0-2w;
	Thu, 07 Dec 2023 17:06:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHpm-00DUsE-1o
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 17:06:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 88A7ACE1FAD;
	Thu,  7 Dec 2023 17:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E07CC433C7;
	Thu,  7 Dec 2023 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701968803;
	bh=GFXV+Da8u/+ekm8DShpqNVIh5PgipQEWMVr0o4G/AR4=;
	h=Date:From:To:Cc:Subject:From;
	b=GGep2GKWMhkDVC7iI9AjzN7cEzepfKjF3vWPLSNcq1yAIKncPO1GUdH8e0H3O9fwa
	 cZT+zU2oNskgmll2InHXvIJkV0WbxinSNDQOF5hMLhZy48xngM/eTUqgq40DRCDTmY
	 vLf9taMrW9unV6CveNMPGlwNKzKrl3jHF0IKnkBOYRNVcgoCsoCKn7C1IrJPoXTnBG
	 MKswbUXl0s9Fn+xJhoOkJyx4lKpALmbTBIh/K78uAjxwGlAbaDgJIhzm6gnYdzj6wd
	 JJW7sBKF8kTCqWwC5pGjqpPaup3j86/MhapJnP/jCOhc06LM+6UphoPpwehq455cZu
	 KwZ8rASsrS9Ng==
Date: Thu, 7 Dec 2023 10:06:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.7
Message-ID: <ZXH7obrwhriIrzdg@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_090646_771544_3C86771E 
X-CRM114-Status: UNSURE (   7.29  )
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

The following changes since commit a134cd8dfb8cdfd8f019a7ec2ad5cb8e855f0245:

  Merge tag 'md-fixes-20231201-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7 (2023-12-01 18:37:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.7-2023-12-7

for you to fetch changes up to 107b4e063d78c300b21e2d5291b1aa94c514ea5b:

  nvme-pci: Add sleep quirk for Kingston drives (2023-12-07 08:53:20 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.7

 - Proper nvme ctrl state setting (Keith)
 - Passthrough command optimization (Keith)
 - Spectre fix (Nitesh)
 - Kconfig clarifications (Shin'ichiro)
 - Frozen state deadlock fix (Bitao)
 - Power setting quirk (Georg)

----------------------------------------------------------------
Bitao Hu (1):
      nvme: fix deadlock between reset and scan

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Kingston drives

Keith Busch (3):
      nvme: introduce helper function to get ctrl state
      nvme: ensure reset state check ordering
      nvme-ioctl: move capable() admin check to the end

Nitesh Shetty (1):
      nvme: prevent potential spectre v1 gadget

Shin'ichiro Kawasaki (1):
      nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config descriptions

 drivers/nvme/host/Kconfig      |  5 +++--
 drivers/nvme/host/core.c       | 52 ++++++++++++++++++++++++++++++++--------------------
 drivers/nvme/host/fc.c         |  6 +++---
 drivers/nvme/host/ioctl.c      | 21 +++++++++++----------
 drivers/nvme/host/nvme.h       | 11 +++++++++++
 drivers/nvme/host/pci.c        | 30 ++++++++++++++++++++++--------
 drivers/nvme/host/rdma.c       | 23 ++++++++++++++---------
 drivers/nvme/host/tcp.c        | 27 +++++++++++++++++----------
 drivers/nvme/target/Kconfig    |  5 +++--
 drivers/nvme/target/configfs.c |  3 +++
 10 files changed, 119 insertions(+), 64 deletions(-)

