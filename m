Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE955C27C65
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEvcTF83bXOZ23el9r2TCn477dSWKAC8oqWBmZ1SUxc=; b=NNwiWzdLyMSPHOd6DTR0WS4i4o
	jeEYvZn3LmJMxL8o4bSLpzqc46Yq0/aXFV3gRSpIgi2+xBmj6h966XDCm1cr4jmTZBopIvzKXGrqm
	At56gaKm+WAv0WUF05EY+rPpEsfGuzAInbBvPtelvvikMXoTp5VWl/bMjqmUK7i26i0EegFnDwleJ
	8UY3DU6/ILwLvnFq4VtrLd0DDCv+2G4jx+rDisIYO7eDODQXvcioeOX2xi+vIgxz0FXmw7b34rvMn
	QeUBkqOzk+U7+AezvYdwzEIkhqAgFJKv1vONydRVUTBTBApgoipCbwRy462lO4DD8QjpfmDsFhtxi
	DpiWiNgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSeV-0000000CaYR-0LsN;
	Fri, 07 Jun 2024 06:00:39 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSda-0000000Ca4f-0ktN;
	Fri, 07 Jun 2024 05:59:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 07/11] block: use kstrtoul in flag_store
Date: Fri,  7 Jun 2024 07:59:01 +0200
Message-ID: <20240607055912.3586772-8-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607055912.3586772-1-hch@lst.de>
References: <20240607055912.3586772-1-hch@lst.de>
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

Use the text to integer helper that has error handling and doesn't modify
the input pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-integrity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 24671d9f90a124..58760a6d6b2209 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -247,8 +247,12 @@ static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
 		const char *page, size_t count, unsigned char flag)
 {
 	struct blk_integrity *bi = dev_to_bi(dev);
-	char *p = (char *) page;
-	unsigned long val = simple_strtoul(p, &p, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(page, 10, &val);
+	if (err)
+		return err;
 
 	if (val)
 		bi->flags |= flag;
-- 
2.43.0


