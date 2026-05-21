Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AE8CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PA+GcyWVNyhoVcyvGU9daxm+x6MPwp7Cg4zdKvNvMrU=; b=v27tAfuya9g+YtwBO9XPdakwL2
	Lma9vfYZhMK4ddWf1PjrXrbI5offPXi0oHkUl248h5pvwQqvr/X+osp0/YeICzmdqBjkAkoiLXnop
	iylGGQOMYwBDtx3p5gSFanvDOQqaUKvK/QD2kRSTLAQA3VS61kk/eKvtevSVd4DH4neThsk0oHnmN
	C3qe2OUUoOkEVVPj/6DHwjH604TJ6c15ZTWZibVZ8CxpK0zsl48xHHmeNB9CKbCxWfo0WYoh/gpE2
	u3QyfV87cJX5fvHlFv/Q+wN0zEcKcOPITsGiGzVdTet171BmRuMk2/jFNrhNvwe/+xCzEiN/UsXmV
	L444C8RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4ww-00000008FgQ-3imz;
	Thu, 21 May 2026 15:04:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4wu-00000008Ffp-0JvW
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 15:04:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C15E143A98;
	Thu, 21 May 2026 15:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E91F000E9;
	Thu, 21 May 2026 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375875;
	bh=PA+GcyWVNyhoVcyvGU9daxm+x6MPwp7Cg4zdKvNvMrU=;
	h=Date:From:To:Cc:Subject;
	b=L82xk+dZ5djTfg75cUTz14oFduhRW8FpGc6d/r/SYgKaoAtkSZnVuz2ZQ6CzjL3kf
	 iJDa9cPx4Mn6SakiMDB4T8mbsAbFGT614XMOT6kfBA+i1UQWEqTW2O73lErgnofApk
	 1gRKQ+s6B/4h5RGBoWOx2kiBPl7GPpE3RmLfrBYHIC7OUz/NAAEuS7CqhLCyBwLMMx
	 Hh3dDtRauK+G/ibWdYbdpeLVeOCMD5WMvjZyWpunvh0iLYoXe6jDCrrlcT5MtkKj8V
	 QZ2QHPZPPAkIOuv7FgzmyH8mYMJJh6mIMGqxG8iDRgHlRdFOhpyg33Of1a2hMSyYb9
	 YF+mcjF83Lqiw==
Date: Thu, 21 May 2026 09:04:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: [GIT PULL] nvme fixes for Linux 7.1
Message-ID: <ag8fAfzFc31u2cct@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_080436_134857_D663E295 
X-CRM114-Status: UNSURE (   6.06  )
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

The following changes since commit 431e40042d3599559e588b8946bb28bd440b4f65:

  bio-integrity-fs: pass data iter to bio_integrity_verify() (2026-05-19 11:38:21 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.1-2026-05-21

for you to fetch changes up to 1bf86336e4b6cf40873fda47a7fe191446864937:

  nvme-pci: fix dma mapping leak on data setup error (2026-05-21 07:49:05 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.1

 - Fix memory leak for peer-to-peer addresses
 - Fix dma map leaks on resource errors

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: fix dma_vecs leak on p2p memory
      nvme-pci: fix dma mapping leak on data setup error

 drivers/nvme/host/pci.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)


