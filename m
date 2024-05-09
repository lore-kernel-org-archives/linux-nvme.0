Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090ACC10F1A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q0TDw+ZUXlTsPzSAOhFQgsKQvVHxKmRQhUxSGo7SIzQ=; b=gExxZj2Bn9aO+mlUS5tFEb/jdR
	9mQwgkbNhxDYNnFJoAni2mJFoIUgfaVk5g0vxLdHOILyCHNc4UD0Q7AJT0q1vTiXI1CzCD6moAbI+
	ig3PPCxIT+Mk1rQeDKWGkf9z2s7TuNxnyhbn6J6NmyyRStLfSYZmU92JlQmxKqcAE/RBlPvaeDWBT
	cOzuloTYdFI0Kz04/5q6RBO1YQ3pYfR14hZa14/Gl5qBnJMlZ4cd4y1gV4g4+0XA/D8ND0RqpBsTy
	BJVZmDeSBcgwprikoRyYZDDureA2Yxmw+wQk7kQoRGsR3bjxVqajCdNxjBkgndwNjcRxMm6xRgsOU
	X3vI9bnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s57sn-00000002Hrt-0a7i;
	Thu, 09 May 2024 17:48:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s57sh-00000002HrB-1drp
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 17:48:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4192861DA9;
	Thu,  9 May 2024 17:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5490C116B1;
	Thu,  9 May 2024 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715276913;
	bh=aAy24KI6UfsDCcaNkfZB8H70thYNNAIPOY+q/rCKJY0=;
	h=Date:From:To:Cc:Subject:From;
	b=koL391BHL7sztvZMQd9H4z4l4VDw+Jnh8dOXS3a/7i9MfAGatk4bOcjliMdxrDz/f
	 EKAZ9eGy7DBkroPESk5zDvaoPAec5bD0Kyt4jfsMbsi3jpJZ2P5QGdlWMhb50vV5v8
	 NCN52OABrnF1yqe8UzxgdYSBpop3ay0lEJk8dnhd1KiPE3+ayBHmVdOOwHIU6i0KOL
	 l03l31p1spn76w/VdLc0fV3giQUrlTsCgkgYZydx2JDzRR2Hu3nn2J/itlb53SCjwK
	 zOAYZphq+oHsPMVwVs+PJupeaHhvhq+u05ekOIs/ASsFmKNetGiW00fvpQUxxiAkBN
	 XipmQBZ6n2VnQ==
Date: Thu, 9 May 2024 11:48:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.9
Message-ID: <Zj0MbxfIuy8Hd03c@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_104835_571221_78B0A555 
X-CRM114-Status: UNSURE (   7.39  )
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

The following changes since commit ffd379c13fc0ab2c7c4313e7a01c71d9d202cc88:

  block: set default max segment size in case of virt_boundary (2024-05-06 20:27:51 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.9-2024-05-09

for you to fetch changes up to 73964c1d07c054376f1b32a62548571795159148:

  nvmet-rdma: fix possible bad dereference when freeing rsps (2024-05-08 06:17:01 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.9

 - nvme target fixes (Sagi, Dan, Maurizo)
 - new vendor quirk for broken MSI (Sean)

----------------------------------------------------------------
Dan Carpenter (1):
      nvmet: prevent sprintf() overflow in nvmet_subsys_nsid_exists()

Maurizio Lombardi (1):
      nvmet-auth: return the error code to the nvmet_auth_ctrl_hash() callers

Sagi Grimberg (2):
      nvmet: make nvmet_wq unbound
      nvmet-rdma: fix possible bad dereference when freeing rsps

Sean Anderson (1):
      nvme-pci: Add quirk for broken MSIs

 drivers/nvme/host/nvme.h       |  5 +++++
 drivers/nvme/host/pci.c        | 14 +++++++++++---
 drivers/nvme/target/auth.c     |  2 +-
 drivers/nvme/target/configfs.c |  5 ++---
 drivers/nvme/target/core.c     |  3 ++-
 drivers/nvme/target/rdma.c     | 16 ++++------------
 6 files changed, 25 insertions(+), 20 deletions(-)

