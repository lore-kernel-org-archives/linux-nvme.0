Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5844C00A8F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aJiESMjjEjNQPs1ZAJsVANKwy/33mcSwku5Li2utrDk=; b=miO/hzeAHQBYNiJ81MlWfGqmFj
	BfPh7W45WfvcZwqJAgOu+akjhNSstlP9W/OymP8hPQrtM8piZLLnKmt45qgr2yelnDZdbjSRq2mI2
	10f4insOwvHZjqC/4zPjSo8d4flP5nr+CveODjsxnEsUquUEG82UiPQ6uuanINqX7WK2pS7zQX6Zh
	ZsNnyc7fzHBSctyQauKpOigdosdkjeZXHsN/pjgaM8UUL+mQAe0ZYmwe7fTPbPN4n6is65kVFs5Ga
	5FtbV87izRZE3c3ESWFjWEPVLDj4F9vCEXF6KIWT2fBUGtdSuhIsVJFQVwEtcImItxbdhw2/e0Vh/
	AB3hrrMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qv3up-008PwI-1S;
	Mon, 23 Oct 2023 23:00:55 +0000
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qv3um-008Pw5-2t;
	Mon, 23 Oct 2023 23:00:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-keyring: add MODULE_LICENSE()
Date: Mon, 23 Oct 2023 16:00:52 -0700
Message-ID: <20231023230052.31161-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

When NVME_KEYRING=y (NVME_AUTH is not set), there is a modpost build
error:

ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o

so add a MODULE_LICENSE() to keyring.c (copied from auth.c).

Fixes: 9d77eb527784 ("nvme-keyring: register '.nvme' keyring")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
---
 drivers/nvme/common/keyring.c |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -180,3 +180,5 @@ void nvme_keyring_exit(void)
 	key_put(nvme_keyring);
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_exit);
+
+MODULE_LICENSE("GPL v2");

