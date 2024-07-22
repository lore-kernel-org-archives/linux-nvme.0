Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F91C3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/WB1VIU0GWGMk90cU/Rp5JbfMX7utoS9JhIA6G9MJ5k=; b=sZZnUKBuIQWIx9U+3sbKp2WBqL
	dB17IMFe4dczT6ODn847TG2M6oMRPU8EOJ23RYUibQ0OuBeBkXH5/dsEgAUv3UZi6Xn1ZF3Q2UlMZ
	tgu4ylOZ1oP/qbCkFEYPgAW1ExH99w9a4ugDPGVatsWVvh0uViYOjIOUEnVv9n9HHA+/cCbqDSmV0
	znMKwOS023/S243cUxVdDdRH+CS7RtzewQg7+ZjemnGeFCDwVRUHdQjhGvtiArw6n+UGYYUDkPz3/
	mwC1/JFwctdcYqkx8ychminwYulaEs/f4gvAWoOa7QN4SzY3VSzW094Wsg20HE4jr9AG8sWQLMCOI
	0IdbexOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkT-00000009SWa-1qhE;
	Mon, 22 Jul 2024 12:02:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkQ-00000009SUU-2aY6
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E628CCE0B21;
	Mon, 22 Jul 2024 12:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC20EC116B1;
	Mon, 22 Jul 2024 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649750;
	bh=4VSvaKsKaSWJJZo48omTiQwjvKvN1Me3E21TKCH5D8A=;
	h=From:To:Cc:Subject:Date:From;
	b=OxMCirl9huX49+cAGXeac9YapG4tLWelMUlk4xjZNOcy645KktijuIbXTKnZq9CQD
	 E/HfYRdPAyWJMBX75505RvvikBcRyuVsbKaVliQAhpwDZybjqqZIKsUoB5AWCwv6NA
	 uUMuxNATswPIjNOr/hs19mAJ2Sy/z27mZ3w2UR+FtFB90+QdPv5x3cSpkOM8T0R2wZ
	 FD71pCYmMaCTYbYRvRP6QM4P/wJaHZ7tuHOpxLbP/hGRyHfpp2LFKPMwL7PftrJmdj
	 nD6s6e2sEzdUdq8TTQAVDD/YE2ABn79xlIgs2+yu9LTDCBP+2aVTU6qQNkRXtJvG2Y
	 URiDrFXHXmC1Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv8 0/9] nvme: fixes for secure concatenation
Date: Mon, 22 Jul 2024 14:02:17 +0200
Message-Id: <20240722120226.88737-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050234_857888_9245F895 
X-CRM114-Status: GOOD (  11.15  )
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

From: Hannes Reinecke <hare@suse.de>

Hi all,

here's a list of fixes split off from the secure concatenation patchset
as they really are unrelated and just are assorted fixes to get things
rolling.
The most important here is the first patch, which implements TP8018 to
support the 'version 1' format for TLS PSK identifiers. And it also
updates the sysfs interface to allow us to re-construct the nvme-cli
commandline from sysfs attributes.

As usual, comments and reviews are welcome.

Changes to v7:
- Include reviews from Sagi

Changes to v6:
- Include reviews from Christoph
- Add patch to split off tls attributes into a separate group

Hannes Reinecke (9):
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: check for invalidated or revoked key
  nvme: add a newline to the 'tls_key' sysfs attribute
  nvme: split off TLS sysfs attributes into a separate group
  nvme-sysfs: add 'tls_configured_key' sysfs attribute
  nvme-sysfs: add 'tls_keyring' attribute
  nvmet-auth: allow to clear DH-HMAC-CHAP keys
  nvme-target: do not check authentication status for admin commands
    twice

 drivers/nvme/common/keyring.c   | 58 +++++++++++++++++----
 drivers/nvme/host/core.c        |  1 -
 drivers/nvme/host/fabrics.c     |  2 +-
 drivers/nvme/host/nvme.h        |  2 +-
 drivers/nvme/host/sysfs.c       | 90 +++++++++++++++++++++++++--------
 drivers/nvme/host/tcp.c         | 55 +++++++++++++++-----
 drivers/nvme/target/admin-cmd.c |  2 -
 drivers/nvme/target/auth.c      | 12 +++++
 include/linux/nvme-keyring.h    |  6 ++-
 9 files changed, 177 insertions(+), 51 deletions(-)

-- 
2.35.3


