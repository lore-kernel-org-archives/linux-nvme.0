Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDDC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCE122D2A
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCE122D2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T4G2QLk1BmrOWuATbfmnhpqrTfGzINme5ZELNmJCGBE=; b=kc07BxIh8zLl2f9UlwhBB8sB3
	WFuk1SYi1ZKaTgIZU4orB7wSVpXilVTEdo+HkvtSOiNsBAWm31qnTVPHcCPNhrCDaLLmBf4qc8y6x
	966BVJ9r65i5APHV4tPUsiGjgaLaGLSqWY+5DW48dBoGlA4ziPYqYKUhzAg0qN9HhZEoDxkmlDmGB
	fT+94/ZfCfXXz15tme84p8uegbflkciaUqh26cGRldLBDynKJJNP2/WgNR/fgfeqBxpAbSlPLirJZ
	Ty+3GwNkYG0I1BJ38UJkp82+Mm8Wa4cSFiQfbtWe1DsL1HJ3QkWsa8nnIToHqH2cW7eikLimcG+9/
	BIVgBN+uQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBHi-000146-CL; Tue, 12 Jan 2021 04:27:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBHc-000110-IR
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610425672; x=1641961672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mkVK7yH9lL1rJQMlF1XEDeT3WD/vS4iMg1KelSLXgKo=;
 b=OQqjvGA29ngdrwuUpZgclKrrFXodCu8Qz4yaN20HS/sSySpsVT5NJZ0H
 u2yd0rSX0LnytweiuUz2q7vZOSjQmnbl+qYJLmaU98qgNEXONp+ZrZKB9
 Vtrvp3cWnI2k5oh1HGSMVbHd7AG3k5draHzoQzv0EZIceL1RI17S+bn7i
 /LQm+MPjOgLZMQAadF7fHgcR+eHp49L0/7LW/W5kH7XvAchiKG1eVf/uS
 KLE78FwyX4Br2bELzHOmzZoYc1KZO3nHsNydI65u1j8iYS03LOR9V65+b
 JHD66cYA3w7Sjv9ZMNQLUY5T7eSg8sD7XBPZt/6ff1v6DVv/90HZO0l4g g==;
IronPort-SDR: 5GqFz0gvNT0EvjhjLuDjnszrTrVGMo1cspg/PwqlO1qxdEZgkl2suA7nb9wzM/3ZFgi/lMvCj8
 rvU4uotC7yWXCcDRpAC/aihjq6M5eoB+Pd298V0C/es53a/y9Ep9HntpyjI5cMpda0xcj5a8k6
 uYn1/0Y2gjyq/WRhe6W90BIwnFn2q8ExlXHU0htXuytbHphBdueMgn4tiqag4ixf4ANuiP9LK2
 hHIuVmvHya3KfITh04jcoX4o75YfTS6Ujg9RpF0/cBvOs8ifpiYawiEryiCe0OjiuCMvJPCUkh
 YeA=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="158381174"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:27:51 +0800
IronPort-SDR: LxxqzQMwiHgRYAhqEtR/wpVTkIQZPq0iIGO1a90PL36Av8PJlS3t5vVSVQtePGLeQ2SeDTEv6g
 i1/FNNsOV15W38wn9rjE4gqqoOBEQN20PFf0g5rGa5Yzp47u8ZUJb64/IEtw6S0mY4ieFm/0Kz
 GojHSpEUZ0sN/IV+CsvWtIH9m3+4qpGr3dhKhqMoyoKa+07jggKdLE37tCYcQuEi1L52LtdkNP
 qS1bOkUVgBgjRqiaAGpKgy5qNBQt5Pum2bMH1h7C4PXjO4/VRwpRtAep/6r6u4pRdmCTkaPGhV
 zkM0ebE3xxUmKEz7dl8EIfcM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:10:44 -0800
IronPort-SDR: 7tCkuG4QOhKS272Hg88kxZohCM1ZnvsSJQI7gWspgz0AH+5wZl3u7NrxobRGnuMs04fmuGPvvU
 Segbqb1mC8uBV6gsLous42UXP4pdxVrse2TnqzuC203ErZ+gJrsLKPbs5JGkXultFjFrYfkOhn
 vejhVy8M6c0F7LiEa1V9VHr3YF9qPGsCo4XDuXD4Lderd3Xi7BUaSBvEGo2c3c4UKesnThw57q
 uGhDxWSWqNetmDy6ZBG8hH4tS83izbk1HT00rhjFrIddDWIYFoAzxLz9XE65s8HuB4NKXfLFR1
 EEs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 8/9] nvmet: add common I/O length check helper
Date: Mon, 11 Jan 2021 20:26:22 -0800
Message-Id: <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232752_782960_84C5CB52 
X-CRM114-Status: GOOD (  17.45  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the addition of zns backend now we have three different backends
with which checks for the nvmet request's transfer len and nvmet
request's sg_cnt. That leads to having duplicate code in for three
backends: generic bdev, file and generic zns.

Add a helper function to avoid the duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +-------
 drivers/nvme/target/io-cmd-file.c |  7 +------
 drivers/nvme/target/nvmet.h       | 14 ++++++++++++++
 drivers/nvme/target/zns.c         |  7 +------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 562c2dd9c08c..c23a719513b0 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -240,16 +240,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	int op, i, rc;
 	struct sg_mapping_iter prot_miter;
 	unsigned int iter_flags;
-	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
 
-	if (!nvmet_check_transfer_len(req, total_len))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req) + req->metadata_len))
 		return;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..e7caff221b7b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -241,14 +241,9 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req)))
 		return;
 
-	if (!req->sg_cnt || !nr_bvec) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC)
 		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				GFP_KERNEL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 93ebc9ae3fe4..f4f9d622df0d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -685,4 +685,18 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+static inline bool nvmet_continue_io(struct nvmet_req *req,
+				     unsigned int total_len)
+{
+	if (!nvmet_check_transfer_len(req, total_len))
+		return false;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return false;
+	}
+
+	return true;
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index bba1d6957b6a..149bc8ce7010 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -289,14 +289,9 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	int ret = 0, sg_cnt;
 	struct bio *bio;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req)))
 		return;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	bio = nvmet_req_bio_get(req, NULL);
 	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
