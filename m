Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3616AC98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 03:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C7RRtsNWLeNcIF2K/Vpd4E+BXgF+UtHFYZksle4q9+E=; b=SN+C0gpGw74SgkesRkKpqJUgd7
	bvqCLWJnmmxhJEPZp9EUxtkqdKEf6d2TJ0B8AT+0lhJ/SiEeFUzl8JPNadBSs9RH4ykeNgBXkR/JB
	5wBTepH7xpyf6dDoQKat5CxH5W4HQrh4UiHsnMNt7GD0c09QuuJIC1jcKiBh3xCjgSamOgNrjioJo
	61J79OXX+9NuoiReFlHqdkBx0vAOAcp8BxX+ENKLNpKzb9hBaAmBJL1jDjMcSvzcpCzBN5Mx4nz4p
	QpulHgmBaDxEb+x0WGDJFOb2oZ9AS/omwU8gUYoF/wowvjJvZ727EFGu90hyzk3yTnpX/iofADIT2
	8cvKyjVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9DTl-000000071QT-2CNU;
	Wed, 23 Sep 2026 03:17:05 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9DTh-000000071Pf-2lBP
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 03:17:04 +0000
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eceabcf1;
	Wed, 23 Sep 2026 11:16:56 +0800 (GMT+08:00)
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
Subject: [PATCH v5 0/3] nvmet: avoid recursive configfs open
Date: Wed, 23 Sep 2026 11:16:38 +0800
Message-Id: <20260923031641.2016406-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc44336203a1kunmae5dc6a4b63be
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx9MVktKHUtOQx9IGkhKQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Uhrspv5Go3edRSJCakrVJ8Ct/hJu2mXJsft565oXrjZwu349un2wQlVxjjeicJFymJCLpnOaL3hdIiS6qQrURQiglQgJ+C3HwXVbkqTlZvTom7+eHdH0m7aqOxwYWTzLCwZHO+p4jCaWtBhz1obdGnKSgvPfXZsq/eDPXdrCRbI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=C7RRtsNWLeNcIF2K/Vpd4E+BXgF+UtHFYZksle4q9+E=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_201702_775350_037189AE 
X-CRM114-Status: UNSURE (   8.85  )
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
re-enter __configfs_open_file() and try to acquire that same non-recursive
semaphore again, which deadlocks the task.

Add configfs helpers that reject configfs-backed roots or paths and open
the resulting path with file_open_root().  This keeps the normal open-time
permission and security checks while preventing the recursive configfs
open.

Changes since v4:
- Make the filesystem-type check local to configfs_open_root() in
  fs/configfs/mount.c instead of exporting a one-line predicate, since
  there is no user outside configfs for it.
- Add kerneldoc for both helpers, documenting how they are meant to be
  used by configfs store callbacks.
- Keep the Reviewed-by tags on 2/3 and 3/3: those patches are unchanged.

Runyu Xiao (3):
  fs: configfs: add helpers for opening non-configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c |  3 +-
 drivers/nvme/target/passthru.c    |  3 +-
 fs/configfs/mount.c               | 67 +++++++++++++++++++++++++++++++
 include/linux/configfs.h          |  5 +++
 4 files changed, 76 insertions(+), 2 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157

