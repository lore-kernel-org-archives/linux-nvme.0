Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B015CCF9C6C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 06:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LgOPdE9j8PRX1g5kxaUyr2YwpTkcUYpfEkDnaoHB6kc=; b=FU7JLUHyKzvxFM1lXI68k3ZeIP
	eruJZbFDvpKdRFmCVDoj+ZXesjFIbiUs3bYkxdR9GuWDmltAa7DeOQ5lC/YovqV7mL7dfWupwo3Ih
	y6oGMB2dlmhe9TJBiPOZqn2xeaD2GxF6Xh+BGnVnUk86CtjhAlgzGuhrL2h9anbinQY4CQ83EO4sM
	WcwrHybUfEmII7C+rhjgsZ8pccl4k4OP38w4Q4VqixhqzZ1WRzitvs67NEDNNemtJxfF9IySykvtE
	9SzVwre8OeVELdIo5CB+5wBUU6NMe4VjB1/Tmaa0eu6u4vsLxE83Kb7ogjP209SQyDtCWmYNQS2su
	HPS8WjPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stLhR-00000004Brz-15D2;
	Wed, 25 Sep 2024 06:40:33 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stLhN-00000004BqU-2V1y
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 06:40:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1B23AA40D48;
	Wed, 25 Sep 2024 06:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C1FC4CEC3;
	Wed, 25 Sep 2024 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727246427;
	bh=F9+Tp+j5MxKx+3ioHYXv7xCDL1Op3Vk8zfj82wF8ppE=;
	h=Date:From:To:Cc:Subject:From;
	b=pf8g5b+ofA8V/WoQoicpjhZUiIVd/EVs94mcJeuHEKi7DRoLexqY4f2DbHMyt7den
	 8gZQTNK+g86tmw4uPPu1levEMsJS1F2zmgfvufIpxMG0lHG+uf2GaXhRriLJJJIB00
	 zaCBfDB1AFg5NkTGouEB18S/m0pFt/uDCVspj/YSjFce80Hb4t6DpRvQaHob/xqHrn
	 wJwnY3Vw6/k0/xAZ2Lvq6oxQwXEqZZdZdO4PNNQBPCjLXqc7DCbuIWDfbCANJ9vvUT
	 3deIBLtRoc/WhlxFQH+/fcDMIRpoyunpqpJHv0G/BJudzUf7RqGTF6cXbXwuVda8dO
	 39l8Eb5sEQU5Q==
Date: Wed, 25 Sep 2024 08:40:22 +0200
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.12
Message-ID: <ZvOwViViFuQSeyVk@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_234029_716259_6D7B33AA 
X-CRM114-Status: UNSURE (   7.48  )
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

The following changes since commit 65f666c6203600053478ce8e34a1db269a8701c9:

  lib/sbitmap: define swap_lock as raw_spinlock_t (2024-09-20 00:20:06 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-09-25

for you to fetch changes up to 9064610348b16356d43e59e286aedfec31825541:

  nvme: remove CC register read-back during enabling (2024-09-24 23:35:10 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.12

 - Multipath fixes (Hannes)
 - Sysfs attribute list NULL terminate fix (Shin'ichiro)
 - Remove problematic read-back (Keith)

----------------------------------------------------------------
Hannes Reinecke (2):
      nvme-multipath: system fails to create generic nvme device
      nvme-multipath: avoid hang on inaccessible namespaces

Keith Busch (1):
      nvme: remove CC register read-back during enabling

Shin'ichiro Kawasaki (1):
      nvme: null terminate nvme_tls_attrs

 drivers/nvme/host/core.c      |  5 -----
 drivers/nvme/host/multipath.c | 14 +++++++++++---
 drivers/nvme/host/sysfs.c     |  1 +
 3 files changed, 12 insertions(+), 8 deletions(-)


