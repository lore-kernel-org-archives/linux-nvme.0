Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEBFC61D9C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 22:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hy/fP4Hyoq2fjOGKs/yhwBv466AETF7kDVfomVKGqZg=; b=0/Ss3C+USb45g/9/Wj2bm/iqaw
	NqNSYTMfxnQRcHyVhirdU744xYQF1IHz9LQDmoH7j000yB/ppUm5/YTivOR22yklwV4qWugZV+juX
	UPL7wvhptDiSRcVfZ20f37DB9GqrBLYK1EF41t0fOSUMvpRQB/78ScLCWIqGnuNNiH6NGpOkVROHR
	JwBt5nDztYY9rcE+VzjOTmqqwNLpsLgIbVNYZ5xKVLk8dOhi8M4fOo2654ThbVtK7M6Mgp6cyQrSW
	HN6x4xyPO49WiacEWP4yks6S99fCvf7plS6MTetDlC6vdYz4CqZYxAx+U6nMobag+RoD8NdVg68Wo
	8PMYEWjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5w0K-003Elx-15;
	Wed, 22 Nov 2023 22:47:32 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5w0H-003Ekt-24
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 22:47:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 66725CE1F1B;
	Wed, 22 Nov 2023 22:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1099C433C9;
	Wed, 22 Nov 2023 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700693246;
	bh=SHbQMMey11hjBP8yxns0NPFvAu9Nr0TqmQigEjIJlYM=;
	h=From:To:Cc:Subject:Date:From;
	b=U4rkAg4i2SQA52TT1dNYTVXHK/TLxnH9GwQW7J98OUhJQxyRkAsdV5WDO/jSphGJ2
	 QS3mj5Vg7rHPwsMFNggbk+eqZ3+T+s0QHnYLOQ1mPBJkzBZ9Dic8RCRqRcSS8jaGdJ
	 grEY/6irykIEN0RaEdTasyRkrWZhAT/eRRtq+lIwXlhLEFbZ95RWp5o9hmHtiGpHVy
	 +tpUVcppJHU9TOnOZVTb0gBTQYZLG1wm0on5IgrN46LefIOdKrg0D/WsEbM4HzW/gD
	 yHdfI6l/FUaRPzMLUxUilHHxPMBAgb/7CLHPXpu7GwHpllrhCtMJOAPYAJmsBDYUG4
	 X/JFSvJIRQLYQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-nvme@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] nvme link failure fixes
Date: Wed, 22 Nov 2023 23:47:16 +0100
Message-Id: <20231122224719.4042108-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_144729_936064_94633645 
X-CRM114-Status: GOOD (  13.08  )
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

From: Arnd Bergmann <arnd@arndb.de>

There are still a couple of link failures that I tried to address
with a previous patch. I've split up the missing bits into smaller
patches and tried to explain the bugs in more detail.

With these applied, randconfig builds work again. Please either
merge them or treat them as bug reports and find a different fix,
I won't do another version.

Arnd Bergmann (3):
  nvme: target: fix nvme_keyring_id() references
  nvme: target: fix Kconfig select statements
  nvme: tcp: fix compile-time checks for TLS mode

 drivers/nvme/host/tcp.c        | 31 ++++++++++++++-----------------
 drivers/nvme/target/Kconfig    |  4 ++--
 drivers/nvme/target/configfs.c |  2 +-
 3 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.39.2

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org


