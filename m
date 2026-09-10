Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F67C79FB7
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 04:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4DZPSSWJirORZ4ABDo6ALp7Yp4ZhsDi/cAg9PK+Ixo=; b=emcxjxd1UXvNOibuQJt0zbaK7P
	jDvCjBumiy6qDgDMI56bHHeyBuKSI0Hz9U/F3msuSB4larpzkKtaVHYc89Wo75/X4hRCR+GWTwp1G
	DTIo4wXjDElfFQUIXrGLVntO/1F8ljKo5jxWxAaaR8XSNWVxkBpuGnbdfQq29aHunkubkN9ZQnqRg
	kb5i3XD+P7pskmEvoL5hDdB9qfcyiHxaKSNm+Frt3mvyNBW8edlPVw5oikZruayqMy9d/O8TY5fWx
	tm1zVho41CEgH/1ZQ3BMOCaddmO40DkQg3m4rZdOxzBhwkT/Wo8bwTixtl2LoaKn5ui3mGADywqqn
	Z6ML8hQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnn-0000000DPDH-0R3N;
	Thu, 10 Sep 2026 04:54:23 +0000
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnj-0000000DPAf-33Ic
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 04:54:21 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3c8;
	Thu, 10 Sep 2026 12:54:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3 0/3] nvmet: avoid recursive configfs open
Date: Thu, 10 Sep 2026 12:53:57 +0800
Message-Id: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902103202.GB8095@lst.de>
References: <20260902103202.GB8095@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa7def03a1kunm413fe85d181356
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSR8YVhpITENOSkoeHh4YSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Y//61vpseLMPMbRKNQjZO4WUB/OhsVOs0OQydhXCQO+PqaKk+zwOx/yMJuTH9Dp51t5qd4MOKZJGtaPZ+CrIImIseiPwFZg+9PMwXUYmsqUNrxm3nvx70vZrRIs38zN3iFG+SvBo+vIHLcyGGQ/U+HETqnTP+KiYqF5gj05kDVM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=r4DZPSSWJirORZ4ABDo6ALp7Yp4ZhsDi/cAg9PK+Ixo=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_215419_985099_710F8B8A 
X-CRM114-Status: UNSURE (   9.28  )
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
enable file-backed namespaces or passthru controllers.  Both paths open a
user-configured pathname.  If it resolves into configfs, the open path can
re-enter __configfs_open_file() and try to acquire the same frag_sem again.

Add a configfs helper for identifying resolved configfs paths, then use it
from both nvmet backend open paths.  The resolved path is opened directly
after the check so the backend does not perform a second pathname walk.

Changes since v2:
- Keep the filesystem type comparison in fs/configfs and export one helper.
- Use the helper from both nvmet callers.
- Use file_open_root() for already-resolved paths so standard open-time
  permission checks are preserved.
- Rebase the series on Linux 7.3-rc2.

Runyu Xiao (3):
  fs: configfs: add helper to identify configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 drivers/nvme/target/passthru.c    | 17 ++++++++++++++++-
 fs/configfs/mount.c               |  6 ++++++
 include/linux/configfs.h          |  2 ++
 4 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.34.1

