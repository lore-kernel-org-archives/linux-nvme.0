Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C34EE6451
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85zhNINCKT+6BGT7RWnGjnpTeAcwsjxqzBVJwvv+VCM=; b=oS4jeu4ORkLjx2VBMTQdLNwPXE
	g8WfeOdwAo+kuIGKdpgeEmlcbKoCO8OZr9FIQGkoE0byt6xomd90aF3tgGed08cIjPcJa7ASdr2Is
	yjU9v/VyKFKcyCBct3tUYdlrIh2TNuSvCQQR4gCIOuGd5lblyy1jocxvMGtwfJHHAptkN2iYN+uwQ
	MKzPxoDcEjKimQkjMuCsDIIfDNvdjqt530hM9V+iqVn58dThbPTgChV7E0W7HGsaLn7NeLWtGXSTA
	aNkeWcd6PG/Ty3Bj+CAis0OySGGKtqv8NC0J1E3EQW7EzbKBmR8+TM0EkZN1PfQBGZZkygFO1/F5A
	dh2+Lrsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYe-0000000C3Ms-0gh9;
	Thu, 12 Sep 2024 06:44:00 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYX-0000000C3Iw-12AL
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:55 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5EDC7C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123430; bh=85zhNINCKT+6BGT7RWnGjnpTeAcwsjxqzBVJwvv+VCM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oIQZBANSpubLnxYCSINBEt04LIyedI/xm6sSVBG/2degtHBcebehqlK1ESCRePteT
	 O0JXVwY3yWDZrKa9LgevEobHD6rm5jrsn/Vpjg9dsEunHJ/WWgznOcBFABWuGkrwex
	 DdDy6HpMcePAIQ7YDzY3idvlvNnfNt/HxoKXa7jqT5u2qBwT0NoLZcJrAz4it0lYNf
	 jMMA2TYoSvggDKmLT2p/ex9zL/HS+ZrQTXNRYmlkcSL7tKuA2L+DNj+O/vylxqKDTd
	 hVT65J1JsW95WAS9/U0xzNZ1wCbK1ehHzi5MYFgHwggA/wQIBPU5yZPswRLn+T3Q90
	 T/s3lukGqcSxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123430; bh=85zhNINCKT+6BGT7RWnGjnpTeAcwsjxqzBVJwvv+VCM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZRIz964ZUfdLAPoo9ELZXLhLqf0SYLh8q8X9NC+I8MUaVy6RGXBikGnytNLaasImx
	 S/U4ScQYSNYmds9VzUDlRWOR9XQxl4gYmrSjS2DMCodJiv9PwOisYR8FlLcIBUy750
	 3jtBtYyy7tBqC6oJokMkByDigxweebpa0iARyM2QbQuXrx+oQjJoDEhsUMAp1ewg3y
	 qCOnNIIh8LrxX0t505xCiwSiRKOyOvydQyKvWLJtL411tFaOPNvwbCbqDW1QqA1UWQ
	 x5yASicDQaA9pN7eQbSss7P0ykIW44gONih5kltS3dyOUCQ74/mdVQSuioMfbKgJtG
	 o+yUEu0gMT6ew==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 2/7] nvmet: bdev: add support of Compare command
Date: Thu, 12 Sep 2024 09:42:54 +0300
Message-ID: <20240912064259.5228-3-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234353_955539_F5E2DD33 
X-CRM114-Status: GOOD (  11.32  )
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

Add handling of Compare command for block device backend.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 34 ++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..0bbe95585dcd 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -183,8 +183,19 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
+	u16 status;
+
+	status = blk_to_nvme_status(req, bio->bi_status);
+
+	if (req->cmd->rw.opcode == nvme_cmd_compare) {
+		if (likely(!status))
+			status = nvmet_compare_sg(req);
+
+		sgl_free(req->sg);
+		req->sg = req->cmp_sg;
+	}
 
-	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
+	nvmet_req_complete(req, status);
 	nvmet_req_bio_put(req, bio);
 }
 
@@ -262,14 +273,30 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		return;
 	}
 
-	if (req->cmd->rw.opcode == nvme_cmd_write) {
+	switch (req->cmd->rw.opcode) {
+	case nvme_cmd_write:
 		opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			opf |= REQ_FUA;
 		iter_flags = SG_MITER_TO_SG;
-	} else {
+		break;
+	case nvme_cmd_compare:
 		opf = REQ_OP_READ;
 		iter_flags = SG_MITER_FROM_SG;
+
+		req->cmp_sg = req->sg;
+		req->sg = sgl_alloc(nvmet_rw_data_len(req), GFP_KERNEL,
+					&req->sg_cnt);
+
+		if (unlikely(!req->sg || WARN_ON(sg_cnt != req->sg_cnt))) {
+			nvmet_req_complete(req, NVME_SC_INTERNAL);
+			return;
+		}
+		break;
+	default:
+		opf = REQ_OP_READ;
+		iter_flags = SG_MITER_FROM_SG;
+		break;
 	}
 
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
@@ -458,6 +485,7 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	switch (req->cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
+	case nvme_cmd_compare:
 		req->execute = nvmet_bdev_execute_rw;
 		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns))
 			req->metadata_len = nvmet_rw_metadata_len(req);
-- 
2.25.1


