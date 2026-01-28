Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B843ED3F07A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x+L2ILTa7ZjRT99RQlQromDSrliO0CyOsdegge8V9+8=; b=XnlQwpP6UBPf6Tvk1p4ZT0rOOb
	Mijj61q9HTTEQWCrfR3msC8sNoUaHuNef5a+DyWsSP3lIx4JCRw+vdZb0QeUPy9WdMRDubrLQYmeX
	gO0ZMrVKU46FBXkPnP/Umi6lGqj89yZG+LufF2E21QJK9ZXZZT/IZwdJg0IF4F+MiSyNwkkyTdpuU
	c+FYkoyw376e9gQxtr2E1HLR+5D/0j9QT4AZzhlgBF7Vi9k8xD8DxZPKv3SKv2FyIYeTGbSeq+cCQ
	xiG4YgYkTzi0DT8eikMLiH16+ylfReDD1wo3gK+WGKKxmGSkRmPauLpdh3qz1bJ0UD+7ruptXAAmZ
	cfjLNz0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7bN-0000000GIYJ-1TpI;
	Wed, 28 Jan 2026 15:37:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7bM-0000000GIY0-1T8O
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 15:37:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 64D9F6001A;
	Wed, 28 Jan 2026 15:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B4BC4CEF1;
	Wed, 28 Jan 2026 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769614623;
	bh=fWT5OTKflQj/5B1K8G47Zr3KLuuy5f+NKoYbOVGuwCg=;
	h=Date:From:To:Cc:Subject:From;
	b=fZlnxc0on6P/PwPeBB488VjwHahj9ZYYx7BY1ksjZNs+hLLf9Icfq20Jfoh2LTM+P
	 6KVb/sQ/hmXxtClKeUVf09DK3sIa35VS/r/y3oPBsCIJ7meEpUi6TfT8SyyqtFSo9v
	 dzwYJi1S8geGAxdjyRGHW8lwk/NvGyRdy5MEH/EVMKEncatl+/cEISMWWpmbyY7AVc
	 Bam0GvP24Q1LGgfGCopuYHkFxTsAA/C5UaUKxa6dR8b0sgOI9KcdkDpSbUOdGQlsO6
	 bgWK00Gmgb3NLPPSyazfJZ3kZGNXC4blaW80LpS2GKt96Kd+9ri2zTihvXqBTwScXC
	 ZB1238a5QRqfA==
Date: Wed, 28 Jan 2026 08:37:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.19
Message-ID: <aXotHSsu33lw7PiE@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit e7e1cc18f120a415646be12470169a978a1adcd9:

  selftests/ublk: fix garbage output in foreground mode (2026-01-21 07:54:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.19-2026-01-28

for you to fetch changes up to a54afbc8a2138f8c2490510cf26cde188d480c43:

  nvme-pci: DMA unmap the correct regions in nvme_free_sgls (2026-01-28 06:58:10 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.19

 - Target completion race condition fix (Ming)
 - DMA descriptor cleanup fix (Roger)

----------------------------------------------------------------
Ming Lei (1):
      nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference

Roger Pau Monne (1):
      nvme-pci: DMA unmap the correct regions in nvme_free_sgls

 drivers/nvme/host/pci.c           | 4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

