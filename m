Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E6EC982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o7gILgiw1b8ufS9MixkHgWd/h6EpwrenjKOgQIs4Prs=; b=OrlLTCirlP4ayyIOLFpNsy5ld/
	leyXvqjxGYGfDHMtgE6T7IJ+23OpdmWrBqX+H4gBEuqn7yrmdZ8n/p2oSE5aAUFXVlMZ3adH4ceqt
	SQydpZjEmlK2g+xnaya3vNZ1jEPS0Xu/UCiHWc+sGg3xq2ZDimHM5MEhdGyeZspZfP83KoEAdoSEJ
	Y0GfUg9qjYKdb5gV19jQZ/iZlyK2vOVhxOrm27KI7I+ucCP9jjlFdcScfpVw4u9DxBq2oNnS5FGsu
	ushw61AX3uk+tp6TkUUtZZ6JLq8GEjFDbw6B4r5ab6IlVhXwmhhmaH+HUAhYbQJ0Fgpv494T8Hc5B
	TT+kQeNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZyX-00000001RyL-11nM;
	Mon, 21 Sep 2026 09:06:13 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZyU-00000001Rwh-1RdA
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 09:06:12 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8e74635;
	Mon, 21 Sep 2026 17:06:05 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v4 0/3] nvmet: avoid recursive configfs open
Date: Mon, 21 Sep 2026 17:05:56 +0800
Message-Id: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c337224a03a1kunm2bb71b5a410b3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0MYVk4eT0lKTR4fT0xOHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RcdTP9OZ0foDlQkFFLiAw5HmNI1pPBHEBj7kQP8EqqEfYCuAex/7KhwifrvGvpcWwcE9/Z3y8N7UdZ22YED07Ds6xwkkvVDID/R8QgVt4/AWV5XAGBkT3Y1D3W55u0WvmmwCAKA2LtWqjyJ4UL5cbTOgCKaWC8sj4hjuLVQQNWU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=o7gILgiw1b8ufS9MixkHgWd/h6EpwrenjKOgQIs4Prs=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020610_967219_2603A506 
X-CRM114-Status: UNSURE (   7.69  )
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

The nvmet configfs store callbacks hold the item's frag_sem while they
enable file-backed namespaces or passthru controllers. Both paths open a
user-configured pathname. If it resolves into configfs, the open path can
re-enter __configfs_open_file() and try to acquire the same frag_sem again.

Add configfs helpers that resolve configured paths, reject configfs-backed
paths, and open the resolved path with file_open_root(). This keeps the
normal open-time permission and security checks while preventing the
recursive configfs open.

Changes since v3:
- Move path lookup, configfs rejection, and file_open_root() into the
  configfs helper, as requested by Christoph Hellwig.
- Use the helper from both nvmet backend open paths.
- Provide a root-relative helper for callers that retain a resolved root,
  including callers that create files below a pinned root.
- Drop the previous Reviewed-by tags because the helper interface changed.

Runyu Xiao (3):
  fs: configfs: add helpers for opening non-configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c |  3 ++-
 drivers/nvme/target/passthru.c    |  3 ++-
 fs/configfs/mount.c               | 33 +++++++++++++++++++++++++++++++
 include/linux/configfs.h          |  6 ++++++
 4 files changed, 43 insertions(+), 2 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.34.1

