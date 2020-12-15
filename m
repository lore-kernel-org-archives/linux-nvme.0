Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E089C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:03:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A0420791
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0420791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9/YS0nT176WF68HzwI9p/mphLX4VwJ6QU4oqXJurtrw=; b=3FXAjGFmc4D3RTNhJmlhHS7SL
	biLKAchrp4nRRNNKn9tPRxR1wTDplxRS1h8Dck7queHQ4hzz5PeaySsewnQ3kRA76I3SNx34AAXB7
	zO2GVKfqZEfrZcm8xHlnGwWOV/MqnnP9lqMJ13codtj9soTJuJpMBJEUKiOpICMH++p1sc8HK+WWg
	S+sB1iVXmubrpgfTBr8hZinkc4v3Xe8OkYpQ4hklZoKqA/D1UHtNl8KtWcKMuSLfpuQS6Gz5NqzqV
	oA2hoSDQtNZ0tbP9hZIjXVnlgCQlvN151+uPkfDBo+fz8n0yrLWZ6hQj3JFKepklqpb/l1/j+bc82
	2eE/uu0GQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp3Qm-0007g9-Ep; Tue, 15 Dec 2020 06:03:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp3Qj-0007fc-O1
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 06:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608012205; x=1639548205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yOc8tZLY9aTLtJqoqcpsKtJ8jkH3U8ob/P06alAcQUU=;
 b=c15eBkl7kWSIin2DHRo5NvPXAkSe52BWvuRavqNbCy2r43ayPaZ2WQZu
 qyewT+P99XiaM//E/u2b2uSuFMecCi546jQEfugtoP4OWdE3XOvH9sktp
 vVojwuRWS0YcSbC5ojTe2Vy9+zoSaYqebDQKl2qBjZsmZfnPj0QFazzrF
 PolvNrIrcKM8xxII+tpFNLfugqQoAXth+xIMiNxPNzAxfWdPCzxIp37vp
 33F585a7EarC4+T+pCpDw4TZ+e9jQca9mklw7IrDMbk+CSHR4/h2pviVj
 JXyRkVE6dnE5khCo/ZpdTuiTNj8pFrEyYuTSdAPPig4wp41phkUJJANXO A==;
IronPort-SDR: wK0ZTNsFDpHghPYQwecrbXlHjp6kC5FKoPDk4Mzb0BEkEcGnJvL7ohu1FYQvYVW1FnVP4D2PJA
 rp06lkW1UkpjRimfn+Mfshk0rQhDNNTOYZgU7gkHXK1FWGVCXJJg0OFsQ8FOmwB6NvMTmGWa22
 qgC39KTLRi5D+DTNHZyvd+WK93ysZFY5LAYMbuvppum6dgA6WWC8t/jeAp1lR/2F46H85qcJAo
 Yuzq96yPCm0mXUoNNoEzs//t5sgJPEub5VmO84m6LJIyWZLXD+S41qmpZL1ho4BECaPEaLashA
 58c=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; d="scan'208";a="159618773"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:03:24 +0800
IronPort-SDR: PCkAyS4yQvBedE2pFxovRt4iG6jVzUZdj1q9HcU1rwZfJEN7Xs+ez/5RPTmqS40dOT5FeXsZP1
 9xdgBL0nMkh3M5/3QBotWcLo0ImKAv07PYgUWH80uns0omkJ0o7T04fz1Ztzhr/fvXAy70+zjl
 42pxVFZ/gutAbqz4Mqn8XyxKbL0r0Vj17XgbqP97M9ffgc8VdpykrgLpS/dTHQDxCqyv5c24DB
 YQ5xlgKbz6t7bb7GqiBa0QDvP2aHANkszbCgwqBtc09hQOFDL6PoWUXIaqlHu6L5MZscmuUGCn
 HpG9KIDoskFxvxxDDZ8/m/vj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 21:47:06 -0800
IronPort-SDR: PBELf+KjLLZ/jBGYF6IGuZ2KKABaMegiWW4MIiDv6nEAu6GYKOUBan1d7bS95Jq2GzkLR8GUlF
 jUtlR0IlY3kHJmEMwSaOuD6DMC7W90v5t7MDGGGiT0tWi+WszaoSj1f31JAxsPPCI4NQPFAcGY
 DG7SZB7NXdJGSkkSfNj3AmwISLU3/36GSYCAgVplAX+pWhxTHIRDYN10cWQTYbUJX91YpiFBUx
 2rp3rr5wNinfYsrvfNtxA0rt/225/XYvtGEwAhtMwwnmTWHFF8lHgWfWTyBhBwqkFmu6hcLIfW
 qas=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:24 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V7 2/6] nvmet: add lba to sect conversion helpers
Date: Mon, 14 Dec 2020 22:03:01 -0800
Message-Id: <20201215060305.28141-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_010325_930759_ABCD724C 
X-CRM114-Status: GOOD (  12.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In this preparation patch we add helpers to convert lbas to sectors and
sectors to lba. This is needed to eliminate code duplication in the ZBD
backend.

Use these helpers in the block device backennd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..23095bdfce06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		op |= REQ_NOMERGE;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
@@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
+			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..8776dd1a0490 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
