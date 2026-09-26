Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AD1C98328
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a2KrQAmn3m5S4sDMBQfBCI0DjfyHtfNQlht7r6HJ/4Y=; b=OzV12mLPSYVHGfJ0SiQvI1aftT
	Q5fgAz+sVMX5CkQran2n6ZseVeQWeBJ+zIo9lmw6gqEFLASaPaQKzZ80/zn7JwOMUCrIPTCqCeH8j
	17uts8YgcuzRb/RE6i1TG/TC5TpiubPOPWAfcjHsXqyLFnDer4SmsaIztweijSiq2sqFASd09lIEI
	xjD4AyY4GLHcZtoFVWhDY/CRfZ5ZO1Fyq8sBLXAihJBi5+DhauLHHLVYW9gisC4HK9KExR8OQcMhu
	ijVcniougTvVruyeXOCC8F6eIcxZ66J1/leEzP7gUwLtPFFQzBe1UEO15HfJQUbutnrifHKMhTpVk
	R4k5eVGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAObc-0000000FC8h-2MQX;
	Sat, 26 Sep 2026 09:22:04 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAObZ-0000000FC7F-1FPK
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 09:22:03 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f2ff7121;
	Sat, 26 Sep 2026 17:21:53 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
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
Subject: [PATCH v6 0/4] nvmet: avoid recursive configfs open
Date: Sat, 26 Sep 2026 17:21:44 +0800
Message-Id: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0dd05665c03a1kunmac953e9e17aa20
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRlOVkoYSR1NH05JSx9MSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Fz/VZxVz/PWuYCuYwrwz2XrVbk7oBRQJFvoIkAQjyzm3u5XfLgCSd7SWmD6EcMU6sDrYmxsVwY6svKD/85IA5eFN2to5zJWJRHY23+9yFz6mSt98fzMiXlaZRganuymXlYzX0PMzQOhXguFQcStAP7QhXSzTKa9XAP1CbdNBdFY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=a2KrQAmn3m5S4sDMBQfBCI0DjfyHtfNQlht7r6HJ/4Y=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_022201_936780_6AC5AF3A 
X-CRM114-Status: UNSURE (   7.19  )
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
metadata, so the helper has its target-core consumer in the same series.

Changes since v5:
- Add the target-core db_root patch as 4/4 and use configfs_open_root() for
  validation and metadata opens.
- Replace the verbose helper kerneldoc with concise interface descriptions.
- Keep the Reviewed-by tags on the unchanged nvmet patches.

Runyu Xiao (4):
  fs: configfs: add helpers for opening non-configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru
  scsi: target: pin db_root for metadata writes

 drivers/nvme/target/io-cmd-file.c     |   3 +-
 drivers/nvme/target/passthru.c        |   3 +-
 drivers/target/target_core_alua.c     |  42 +++++-----
 drivers/target/target_core_configfs.c | 116 ++++++++++++++++++++------
 drivers/target/target_core_internal.h |   3 +
 drivers/target/target_core_pr.c       |  21 +++--
 fs/configfs/mount.c                   |  53 ++++++++++++
 include/linux/configfs.h              |   5 ++
 8 files changed, 189 insertions(+), 57 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.34.1

