Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40629E77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sk6Alh08b5xmx85rMZUXL45YlSDk6ZaipyKClDG/SCw=; b=mPdCWD5NK6CBsEvzSRXqECWm05
	MwH86fd4uqRfbWIqXKvvA66s+7Pq8mBmR+C1rZFUP7tVO1qCXAIJvM4xxA6oQIENV+SZUzpgS4eIA
	Szw1a01cPj1VFr9JIgGsKdnmq5jIjUnjg4q0BvrMErLAnghE4mgPAzR6SOm8cSeBUqIeQ8/MeCO2p
	G9M9TrBfRvTfG3f6vSV46Syduer0iBLZ5YxHZY/HG1tvfVJKEWl6V/iFHWZbXoNeibxkA9Lt+EOrN
	Dse6801s4CpjswkOvJFsrtvGmbGC/7XPxbn0v/4ukybrCZFsvZTz4sdpBw42A8YPvPqRGuD8HUScq
	Cl++V4+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKSyC-00000006A7d-0ZJU;
	Mon, 09 Dec 2024 01:53:56 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKSy9-00000006A6h-1six
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 01:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733709231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sk6Alh08b5xmx85rMZUXL45YlSDk6ZaipyKClDG/SCw=;
	b=MUU06xH5JBdb0YtTo9raCPFIbYp2j6lkUyRFan1KqwtL7PtVhLzfXIkIasxq7+9WaSpSnvf0D4C4onPW3GlRTzBtD41bKO40x6E3bgbanZjIubjIF1PMxlKNkaWsyqcbCjbbUsBN1TehJtmnHlhnodjTJzXkJ/V3/dsI4gzxXXc=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WL1YDMM_1733709224 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 09:53:49 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3] nvmet: handle rw's limited retry flag
Date: Mon,  9 Dec 2024 09:53:44 +0800
Message-ID: <20241209015344.60861-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_175353_809469_37BB456E 
X-CRM114-Status: GOOD (  11.02  )
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

In some scenarios, some multipath software setup places the
REQ_FAILFAST_DEV flag on I/O to prevent retries and immediately
switch to other paths for issuing I/O commands. This will reflect
on the NVMe read and write commands with the limited retry flag.

However, the current NVMe target side does not handle the limited
retry flag, and the target's underlying driver still retries the
I/O. This will result in the I/O not being quickly switched to
other paths, ultimately leading to increased I/O latency.

When the nvme target receive an rw command with limited retry flag,
handle it in block backend by setting the REQ_FAILFAST_DEV flag to
bio.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes from v2 to v3:
- Add the rb tag from Christoph, thanks.

Changes from v1 to v2:
- Add details to commit body(Christoph).
- Add the rb tag from Chaitanya, thanks.

 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..6380b60fd490 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -272,6 +272,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		iter_flags = SG_MITER_FROM_SG;
 	}
 
+	if (req->cmd->rw.control & NVME_RW_LR)
+		opf |= REQ_FAILFAST_DEV;
+
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		opf |= REQ_NOMERGE;
 
-- 
2.43.0


