Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4C7C98338
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2026 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V2dwCmnh4jcZ0MUl2mHzbEQ5hr9TbVsuwLEVbpur9Q0=; b=QymmvnINtxhlH00Q7RZa3xA0QW
	5+yX/8GJxL1f/Od6dsKO9DsRZ2THv6YlSTO2By97GFL2KDl4S+bPbJ2lwVLLaJYzuxnfd1pPoGEXk
	sblUnDEfo7kSxmVkSDJt8BdXgj5vyenqdDbSoK8/DjIAPwGOjPJtENUUowwwPGTz6X4WnVk5d3Lv7
	OJWc48H59hrawpU07/sihFEw0lmvxmK3wL0kw9Yr9CER3iaZXbYNsolFrESdWX3shf0C1Y5b4iM1E
	y85g3T2x59RdZTzlnj+97kv6PAMFzjVrGoFGKplYbo/pqRlRZEIOe0wAAdl0d5gFO74Hp07JeDCYb
	2ALMaGNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAk7c-0000000G8Tv-2jbh;
	Sun, 27 Sep 2026 08:20:32 +0000
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAk7Y-0000000G8SD-0RiD
	for linux-nvme@lists.infradead.org;
	Sun, 27 Sep 2026 08:20:30 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f3a443f6;
	Sun, 27 Sep 2026 16:20:22 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Hannes Reinecke <hare@suse.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v7 0/4] nvmet: avoid recursive configfs open
Date: Sun, 27 Sep 2026 16:20:07 +0800
Message-Id: <20260927082011.638723-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e1f36f2c03a1kunm12f6b69c1ac324
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQh0YVh4aH0hIGBpKTkJOSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CwU78sMvDEsOExt0w+ZbN1oR1EIflpiWsDeKOcKPl1d2iF4JrnrQb1RTUCnW7rCWG14K1qOW5yp6HyQcyQ5xvXIWKviazvbR72a7LBPRG4mMIc4Oq3VM7Ihaig2dc+thj6ikXEr2tROgyasyPEKlx4GLLj32YloHpPAqUZl4xHY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=V2dwCmnh4jcZ0MUl2mHzbEQ5hr9TbVsuwLEVbpur9Q0=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_012028_716089_648C5E29 
X-CRM114-Status: UNSURE (   7.93  )
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

Several configfs store callbacks open user-configured paths while holding
the item's frag_sem.  If a configured path resolves into configfs, the open
can re-enter __configfs_open_file() and try to acquire the same
non-recursive semaphore again.

Add helpers in configfs for opening non-configfs paths, then use them in the
nvmet file-backed namespace and passthru paths.  The series also pins the
target-core db_root path and uses the root-relative helper for ALUA and APTPL
metadata, with a dedicated lock protecting the path and its configuration.

Changes since v6:
- Honor O_NOFOLLOW when resolving paths in configfs_file_open().
- Protect db_root and db_root_path against concurrent metadata writes and
  configfs updates.
- Return an error when a db_root update races with target device creation.

Checks:
- scripts/checkpatch.pl --strict: all 4 patches pass.
- Built the affected configfs, nvmet, and target-core objects.
- Applied the complete series to the stated base commit with git am.

Runyu Xiao (4):
  fs: configfs: add helpers for opening non-configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru
  scsi: target: pin db_root for metadata writes

 drivers/nvme/target/io-cmd-file.c     |   3 +-
 drivers/nvme/target/passthru.c        |   3 +-
 drivers/target/target_core_alua.c     |  42 ++++----
 drivers/target/target_core_configfs.c | 142 +++++++++++++++++++++-----
 drivers/target/target_core_internal.h |   5 +
 drivers/target/target_core_pr.c       |  19 ++--
 fs/configfs/mount.c                   |  57 +++++++++++
 include/linux/configfs.h              |   5 +
 8 files changed, 219 insertions(+), 57 deletions(-)


base-commit: f741eaa40d2a8e199a31ceb683f30867537def70
-- 
2.34.1

