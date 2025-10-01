Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C864CAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3IiCDV7KJbnLXGHgdn9Y693Y1pG63AaZdwpsFiezqig=; b=bLRs26yK1K7Y+1zgXfZTmgUrS+
	xdOPg5XdcGaLVqYPI8546uyZkD/1NV3DZeejx0BBnEYTB7D8tFTeIYHVRu3g8WHSUbp/VJhXI0U5T
	HWXVVyc26QyCT+yGq3GbTVVV57HRqkGV5bog0x0cgylVk0GyHs6ushSBX2bjAyDruORQekum+9USK
	VQxTr7itatd2iVQK1pMuBufRnz2g/TszoXsguLcSYl+vsrPwZ35/n0TvM477KONgM+v9icqJPoqu9
	Yk8L7PRg4fN74ikAGnuXbnT+vUmQqidCKlwZ0vbnnO0Pt8dilD9zJWRtAcnuBle/I5RG0lYFePgdS
	oobSd2vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xie-00000008A0z-3UNL;
	Wed, 01 Oct 2025 14:22:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xid-00000008A0Z-3BN9
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 14:22:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C30A61DD3;
	Wed,  1 Oct 2025 14:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876AFC4CEF1;
	Wed,  1 Oct 2025 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328530;
	bh=DxoR72EacgG2dbf0VB8ybSSAZQN6Zc4a5q/8XWzAOO8=;
	h=From:To:Cc:Subject:Date:From;
	b=bxlH/nTyyQmglTpVV0QfiLSg3to6H+73PBvwrSP1edsEMMpxMXcFtiNT+EYZw3pcK
	 r9ySpFUX7mbUJMJ2oDNheHPnUCSS+U6QEazbe3N6Zad/3KGLYhJGLttZYuRZ6ihXkb
	 WlFqZRrLXMllT+BHHk9qfZL6hMKL6W9D9mr72uHzwTaHF92IcbUFqGxYeTh+Uh3qA+
	 nLeFE+Q1iFHy6ybs9c5XbQDa8C+9Wz6N16zmADgRsA1xqpLDHkXzrZgpPfk6OJdqKb
	 ijGrRyb4zu1MZErPCQSX85gaJWXgXEoJ0Nlxsr7dMfDrBleV9xIe0Ym3idcJuwmBzr
	 hX+XT/31bXjsQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/3] nvme: kbuild robot fixes
Date: Wed,  1 Oct 2025 16:21:57 +0200
Message-ID: <20251001142200.61696-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

the kbuild robot uncovered some issues when having authentication
disabled. This patchset will correct them.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme-keyring: use correct format specifier
  nvme-keyring: typo in nvme_dhchap_psk_lookup()
  nvme-auth: move declaration of nvme_auth_extract_key()

 drivers/nvme/common/keyring.c | 2 +-
 drivers/nvme/host/nvme.h      | 9 +++++++++
 drivers/nvme/target/nvmet.h   | 9 +++++++++
 include/linux/nvme-auth.h     | 2 --
 include/linux/nvme-keyring.h  | 2 +-
 5 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0


