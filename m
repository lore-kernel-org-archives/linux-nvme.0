Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEF4C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJl7wp0u5LBKVaAXb9FrQp7PdLwwPnXgf+wQoRmK4Q8=; b=bGXbDBl2Ykw1/AuAlGWOvXSiT3
	OQg8bWqNYvD4/rgaimVwM4ZoVWJAf6YSULIo91y7/mDx2cRuly55+tFrj4PReC4PjsB0mgxOZ4+2a
	DCzfIxay6CDEuHQi1TamD+07ud7DsCfWGl+Dsaa6BqDFOvl4nkkSKdQueraCeTuSy7FAQ5NpBOveM
	F9AMdBboVcu7k1BTQPUlnc+Nw48VczHyk2IjrDAdW+6VlbhhhjQA553Gxe2aZ+dkipzIC1VuFCRL7
	PmEE/84VGUG51IERF8dNqkUYhxcAPpsb35N+oWce7RhyOit6CFwQKi8wA5sBCvtrA5GAWEFvQLv/h
	rU+Up3CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAo-00000004mnW-1385;
	Wed, 05 Jun 2024 06:31:02 +0000
Received: from 2a02-8389-2341-5b80-5bcb-678a-c0a8-08fe.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5bcb:678a:c0a8:8fe] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAk-00000004mj9-33wv;
	Wed, 05 Jun 2024 06:30:59 +0000
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
Subject: [PATCH 07/12] block: use kstrtoul in flag_store
Date: Wed,  5 Jun 2024 08:28:36 +0200
Message-ID: <20240605063031.3286655-8-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605063031.3286655-1-hch@lst.de>
References: <20240605063031.3286655-1-hch@lst.de>
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
---
 block/blk-integrity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 686b6adf0ea5c7..bb3cd1e0eeb58e 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -245,8 +245,12 @@ static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
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


