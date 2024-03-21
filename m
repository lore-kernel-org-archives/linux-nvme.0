Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76675C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pfQ9zpHsEhcd0hthL4ZaUhMaCvU+yww+JMQfl5Ve3OY=; b=RFVTJY5z0lttuz/OQRVApkQPYX
	v0yUdB70BH2RU0Z3jZC90wApva++SytMU2di9lRcZHyTcAgV5LrOXOqZ1abUO2y0KBN3iAawMUS3M
	f89Md+uGWN4Jqt5rAVL2cPT8SGwHjBj8PwJUxR1klklUyEXxyraSEeVjyOmXtZy7du3phA+N4OENT
	R/oJyOhce2NuS2eMRGC4Z5lfP8pclH8o3MnVJEPO0K/LMLTtAtLMK7VRz1Fk8DmOBG157hc9OTXlg
	MNm/gI6r0uIIxAr6K4/iAOiwT6hvQ2oLjlY/bTrfZsHmm4o+vEbHoLoHnuBPDVvfCtSHiOjM18XKI
	6nJMZwyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMwb-00000004EWi-0kJa;
	Thu, 21 Mar 2024 18:15:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMwY-00000004EWL-1H8S
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 18:15:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0EE4D611AF;
	Thu, 21 Mar 2024 18:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0B7C433C7;
	Thu, 21 Mar 2024 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044908;
	bh=YJdxAgu1ig4uGflIMl6Qjm4lI/hs+DyyuzfxdFlfAuw=;
	h=Date:From:To:Cc:Subject:From;
	b=ow/xe1beghtZH0sbiBni333NtvLEcIUaZpPS3R8qTpwUV/EftCDSTOs/DdQpDHIBf
	 Y2nq59gDlClyRtnCSobvZpHUi+aqJITAYiL1I/u87GF6Wfep7Mk3EV12UWcQlcEDTx
	 JJUEBpgdsZ7ol7Z+JEPDZIcpLrorkFoiM3fqPY4M0BzwjssyXkEf45d85su8v9vTWS
	 EjNkEsGePVjNJzhi+71x2mpRc+jwYzhYgMpYEVDuJwWD1jeceX5j/4KBwCc20lIOXA
	 HUQrnXXCOVUz1fGXi5wSpeHBNSyQ9rhUdUpdhInjuL3Z4DhxxMTc28CXoLBD/4B4xK
	 nKNL3Q6SzDxUw==
Date: Thu, 21 Mar 2024 12:15:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.9
Message-ID: <Zfx5KbCt1RDMXmzO@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_111510_414905_C11701D9 
X-CRM114-Status: UNSURE (   8.56  )
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

The following changes since commit 0dc31b98d7200a0046de5c760feb0aaff6c4b53c:

  cdrom: gdrom: Convert to platform remove callback returning void (2024-03-07 11:53:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.9-2024-03-21

for you to fetch changes up to 910934da9444dbb102294796481ab05e4419d311:

  nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag (2024-03-21 10:46:53 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.9

 - Make an informative message less ominous (Keith)
 - Enhanced trace decoding (Guixin)
 - TCP updates (Hannes, Li)
 - Fabrics connect deadlock fix (Chunguang)
 - Platform API migration update (Uwe)
 - A new device quirk (Jiawei)

----------------------------------------------------------------
Chunguang Xu (1):
      nvme: fix reconnection fail due to reserved tag allocation

Guixin Liu (8):
      nvmet: add tracing of authentication commands
      nvmet: add tracing of zns commands
      nvme: use nvme_disk_is_ns_head helper
      nvme: parse zns command's zsa and zrasf to string
      nvme: add tracing of reservation commands
      nvme: parse format command's lbafu when tracing
      nvme: remove redundant BUILD_BUG_ON check
      nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag

Hannes Reinecke (1):
      nvmet-tcp: do not continue for invalid icreq

Jiawei Fu (iBug) (1):
      drivers/nvme: Add quirks for device 126f:2262

Keith Busch (1):
      nvme: change shutdown timeout setting message

Li Feng (2):
      nvme-tcp: Export the nvme_tcp_wq to sysfs
      nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq

Uwe Kleine-König (1):
      nvme-apple: Convert to platform remove callback returning void

 drivers/nvme/host/apple.c   |   6 +--
 drivers/nvme/host/core.c    |  11 +++--
 drivers/nvme/host/fabrics.h |   7 ---
 drivers/nvme/host/pci.c     |   3 ++
 drivers/nvme/host/pr.c      |   3 +-
 drivers/nvme/host/sysfs.c   |   3 +-
 drivers/nvme/host/tcp.c     |  21 +++++++--
 drivers/nvme/host/trace.c   | 105 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/rdma.c  |   8 ++--
 drivers/nvme/target/tcp.c   |   1 +
 drivers/nvme/target/trace.c |  98 +++++++++++++++++++++++++++++++++++++++++
 11 files changed, 233 insertions(+), 33 deletions(-)


