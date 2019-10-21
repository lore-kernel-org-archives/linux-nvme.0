Return-Path: <SRS0=hg6U=YO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0274CA9EAC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CB521897
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAf6MLOm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e83J7PVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CB521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UoqWlh0c99XuPk0+OGe1jQXeafBEaFyTou4RsNF5vXo=; b=UAf6MLOmpwd78V
	gI2VUfYuJ+mzwcOl91okmj9+j5jFSBVk/4ii6EfFxlxgp9cnyxOq04iGsRXN/tp4bxuYxSmtzIvNA
	/0Yn7PjKcxcGv2CXVFCJmoASU5NsrzxPpdCy6xZRIWuvOxh0ZF53+/k/QniraFR95T6t1XxUYBNyi
	BaIkLA2NFQiwN2yYRfH58+gh8YV9CJVOWZ3hzjbuMtcN1AM0y0+bErIUd/I3tmrvJNzh5+NFgnpwS
	ZZIZ9D0+MDEnQoOny+M0A61pnAg4DCJG/ZbM0HbWijNUjU8jWq1C89sgI1DV93d7KZa6C1lmdJKaJ
	uIhjwDliKK/jo/y4sZQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMOYh-0005ff-Ro; Mon, 21 Oct 2019 03:40:39 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMOYd-0005bF-5K
 for linux-nvme@lists.infradead.org; Mon, 21 Oct 2019 03:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571629236; x=1603165236;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=au0G1pgDW3DNrrjgUkL/ruIzQrmyLurQUvshjXvhijI=;
 b=e83J7PVcRwp2z1clg866RPHlmbrgg2bn1WCPTu02FZ4sTNQWwoKiCGIk
 uN5KVk6mOxfELZDEU17z3BfnkEpzoetC3MvTsF3PFKWNxmsIHPw6ZjKab
 94ejAcfTyfOm9OQF8jcUyXAuFWRCpyh1tYG/98dZ+OsoCMpyUX1R+dkxJ
 FTY28YxQDkh7+WzSZwxxh1g0Otlx0yfhoaYi+hCXjhlZeAk1dWOt41Q2Q
 72VciwOW8lrg40GXPfUdKxCyrSAaIcniweDPCVq0qaW8TNXzTwbjF1fGM
 kXdcW5H76lggIlrb4WOor/ihmT8TAMn5qncDMSa5bRfJ9UIWXMKDbciKj g==;
IronPort-SDR: 3MZzAE1NDBfYDn7r14xmYoUfzN9ocqJc2pdY7ejAi9SiEhnC7T8OpocyayzUhuNU62liBm0UaK
 7g564GuarZ6g7NPdNdDEZSf8Q3cdygv0HPA3HIhl1Hv5zoUlgOlGJ1SH5z1n4IRg72N1LiWqFm
 vUpFT17JfYKp2LKjmNaYoqQvJQZM7rgbKHwvMOltHx1PfwbscRSZxGGNW2SEUgiFOnhq4ARIfi
 2VH0zmcEBGrJQxCN/z07mK2EhioTusB/DfuVm7a1jPn2UWKtAaiPfg08PmMZRYe4kXXql6LJes
 pFQ=
X-IronPort-AV: E=Sophos;i="5.67,322,1566835200"; d="scan'208";a="121721806"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 11:40:08 +0800
IronPort-SDR: areHNLg7BTaJfxAdHDowLn5km5rQvh/0pkk5/7/W9L7vTPYLdRWxPVZJE/+TPchnIIpUYlfEHi
 GakR8vbZpolnmNQ9d9fbm4e/W1i7ckjWOm7gS0DYWCFsgL/YvNOo5Al2P6aFB5ioU8qCKaBgmT
 b25ffuSt6S50h3YTbRJaGGjvV8ffpjdydTSNUZlQEg/Fz8WRsjjmoXbD0Qc3cASttVASX0YYQt
 WO/msG3YXu/cN38iwEkT4Yp5/mUoj2z7kgP+PDEfXIJz6Uj0hmIkfscVlMLA2HzGfOapUIiZmb
 2rtmLVdD5DC+hddph19bLkc/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 20:35:47 -0700
IronPort-SDR: Nj6qZn5E5glP1BejzB1k/G8skpZczsP6tHtKg+U/i9x/C8ptI0fe7EnNDDhyS3Unea7peaIQfG
 Ix+8hBpwU+apVdH0uKbOEPz8VScSbHelHCOdmHU9HZ9d4mWhnOq0sdHgjIQwpsxrp7gw2QWE/w
 fJ9tGNIeJwxEWwabIeJA9thYQ5dSv9h6G6YScDUagUcdtNCdhY9hIqK7o9xdKQtxiIhU0ZjKCt
 T1/+vQ6HeORjt7aTw9nV6BsLJJ9KztINt0YJFZBhxwnQE6tTQEdsoCXWdsVv6T+gbVQnSHeMGz
 1I0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 20:40:07 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2 v2] nvme: Cleanup and rename nvme_block_nr()
Date: Mon, 21 Oct 2019 12:40:03 +0900
Message-Id: <20191021034004.11063-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021034004.11063-1-damien.lemoal@wdc.com>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_204035_207740_10EFE698 
X-CRM114-Status: GOOD (  12.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Rename nvme_block_nr() to nvme_sect_to_lba() and use SECTOR_SHIFT
instead of its hard coded value 9. Also add a comment to decribe this
helper.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/nvme.h | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..6b37103b31d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -626,7 +626,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
+		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
 		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
 
 		if (n < segments) {
@@ -667,7 +667,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
-		cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 	cmnd->write_zeroes.control = 0;
@@ -691,7 +691,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
 	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..617ee8512f91 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -419,9 +419,12 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
-static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
+/*
+ * Convert a 512B sector number to a device logical block number.
+ */
+static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 {
-	return (sector >> (ns->lba_shift - 9));
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
 static inline void nvme_end_request(struct request *req, __le16 status,
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
