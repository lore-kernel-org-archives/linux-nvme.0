Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47787CA0FE7
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7aG6r18hMlGAamFlYDC1obGB8eonZIXu+oCzZFw5QUo=; b=SjVqu/hvUdZdccj7EwIfPQSM2d
	seMfXuD8okQ8r90YV+QtAY66edqKGYJHlBugRfGS2WoSwhBTdDjZZxMAoNN8KjBiE6lTJbUzJ3aAz
	KRqXp16veb37wC1r2pUNdXQkS5HlegD3i4dA8BdoAtousP/9E3LWexi9+vj7I79k8/L9f96KNq7HC
	0S82S9W6RmVRgZw9L5lA54ikkSIl8pQYFEzByfSGpGsCN7vqPJEJJmZWQtyIzT9bfsq1ZAN0zWDU8
	0MBOyjYuYORXD98fANcVFfqkqemwsEz+avywk7P6yhNjJXoDgbnV8bjj8Hd2E8tJpIb8sDQPNyt8w
	YPXHZQRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqa6P-00000008fKy-3AJh;
	Mon, 25 Aug 2025 16:31:25 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXKE-000000085q7-3Gpy;
	Mon, 25 Aug 2025 13:33:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com,
	joshi.k@samsung.com
Subject: [PATCH v2] nvme: fix PI insert on write
Date: Mon, 25 Aug 2025 15:32:49 +0200
Message-ID: <20250825133327.518741-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
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

I recently ran into an issue where the PI generated using the block layer
integrity code differs from that from a kernel using the PRACT fallback
when the block layer integrity code is disabled, and I tracked this down
to us using PRACT incorrectly.

The NVM Command Set Specification (section 5.33 in 1.2, similar in older
versions) specifies the PRACT insert behavior as:

  Inserted protection information consists of the computed CRC for the
  protection information format (refer to section 5.3.1) in the Guard
  field, the LBAT field value in the Application Tag field, the LBST
  field value in the Storage Tag field, if defined, and the computed
  reference tag in the Logical Block Reference Tag.

Where the computed reference tag is defined as following for type 1 and
type 2 using the text below that is duplicated in the respective bullet
points:

  the value of the computed reference tag for the first logical block of
  the command is the value contained in the Initial Logical Block
  Reference Tag (ILBRT) or Expected Initial Logical Block Reference Tag
  (EILBRT) field in the command, and the computed reference tag is
  incremented for each subsequent logical block.

So we need to set ILBRT field, but we currently don't.  Interestingly
this works fine on my older type 1 formatted SSD, but Qemu trips up on
this.  We already set ILBRT for Write Same since commit aeb7bb061be5
("nvme: set the PRACT bit when using Write Zeroes with T10 PI").

To ease this, move the PI type check into nvme_set_ref_tag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - don't accidentally set the ILBRT field for type 3 PI

 drivers/nvme/host/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9707a0e8c431..fb36c5c9e55d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -903,6 +903,15 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 	u32 upper, lower;
 	u64 ref48;
 
+	/* only type1 and type 2 PI formats have a reftag */
+	switch (ns->head->pi_type) {
+	case NVME_NS_DPS_PI_TYPE1:
+	case NVME_NS_DPS_PI_TYPE2:
+		break;
+	default:
+		return;
+	}
+
 	/* both rw and write zeroes share the same reftag format */
 	switch (ns->head->guard_type) {
 	case NVME_NVM_NS_16B_GUARD:
@@ -942,13 +951,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 
 	if (nvme_ns_has_pi(ns->head)) {
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
-
-		switch (ns->head->pi_type) {
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
-			nvme_set_ref_tag(ns, cmnd, req);
-			break;
-		}
+		nvme_set_ref_tag(ns, cmnd, req);
 	}
 
 	return BLK_STS_OK;
@@ -1039,6 +1042,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
+			nvme_set_ref_tag(ns, cmnd, req);
 		}
 
 		if (bio_integrity_flagged(req->bio, BIP_CHECK_GUARD))
-- 
2.47.2


