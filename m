Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE6C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJl04ErTLf875XVO5CnaKN76goOZPoYUuUgwdqLgCvY=; b=MgvUPhZB+8SRFf4wRyjbPcXIFQ
	lzaOHf5vj5VEqG9IWR0p7dYgUYUH37tr4iKXOUw8lp9jY6wpXyDe/MtOs9GGdqXAF3CTJQrCuKOeC
	4h1xT7ckeEKEsoMiFJlYqfiyaeBhjp/QT99JgrtT+4zJxK3KZ+hKEO3VWENsidCGpJyxQfurWddbe
	0tQxKuZI9b1BcvZ47iN5Hi5go/d03ESMk3Cf0ZZOVz5omIe/sPk/dFFYmK8ou9kgrbG8N3d/8a318
	bVK8lYDUoRec3x+/4B5uZTq0xRnoqhDwtrqDfoJXlVNXNdh1QcuoNH0gUIN3bNfm/UEmzIxrrfXIk
	UCe4DUbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFId-00000001kb3-19do;
	Mon, 14 Jul 2025 09:16:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXl-3Xqb
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E4CE7462BF;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E29AC4CEF9;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=TtseZ4TcQtCKALUdMCarP65Y58vXB5ipsP5nGvWI3FY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RxLAYrQM9UqYP7C4TilHtGc7c8TRpikQVjJnB+DghKCQOrjJQ5QZJ5MlQSttA9t8Z
	 LOKTaOEB7MGfMEitIuhS+xsdjJ8lVW5nPIUywf2qkpmmqseazdaWBXvj5bjnPOWh10
	 W4w5JiI2h1qbDj/4kd6MJEVepjD8ZC6GHc/cXbTGLAgRn5PPsGcGd4EuKpd7z+qwvc
	 rTLfA3Pv6+jojXQRrShgauK5QAeDczRZHS6EbVOVP8hAGhkxGQSzj6mgJSP+lbm919
	 kIcgNo3cUy0OOIbctOEOUziDchPumjzC86lT+tm9kRtyHIUJk+nofYNiEDIlseDllf
	 8l5ApjeILOcmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A9C83F17;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:34 +0200
Subject: [PATCH RFC 3/8] nvme: Add file descriptor to read CDQs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-3-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4170;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=TtseZ4TcQtCKALUdMCarP65Y58vXB5ipsP5nGvWI3FY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yupLwwxxgJrdT4OCImvVb4tPC51BwzORZ
 pOM+8l5nbK/zYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrqAAoJELqXzVK3
 lkFPZd8L/RkR/7Fkg+619MfcZxBcXjZMOxL7y2OrZGCmS+dje9Lgd0/QgfCfwKb2/OXbeKfjr98
 2I4Xj1un/j9+qOdJj+v2F2J7F9eqsmp+0qT5b1l+LvhB5zwCE1sk//KQIH20xTRmeJjJCLsKrIA
 vjIxz6vIF6qNmiLjvZQfAOeqwk2jvczAEUO7y2hqSZBXqBWO6Umzpf04Kek6i1kWJ9uSS/VRAT9
 6EL9+Pa9EN+V5P29zCqsBcj5WdnxjHb4wzkPbbXMLdvLKEVcdqEyOogVt0DPzbQXQtJN+Ir2GZM
 moBm+Iw54083IQalIPhyU8ku1H1nZYDaTyQ4EwACAXfBwmdNtzvSSYBTGbe7lkb9avOuuwYfGTe
 Rw5dFwqcPbp3tVv7GoXgc8yFA5bX5inogPEzYa67MEmEpRq0KdC8IAAL6xKFU1MUDiiT7Frsc7z
 JxxRO4CqPfilGrDQcaAWHgXOXBEp602tBmtQS/5rrT3v8lMDHyoDICJYBRKuOMA00qaF3/JS9b7
 74=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_021632_942104_3876D9F1 
X-CRM114-Status: GOOD (  20.58  )
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

The file descriptor provided by nvme_cdq_fd is to be used to consume the
entries in the newly created CDQ. This commit both adds the creation of
the file descriptor as well as the mechanism to read and copy entry data
back to user space.

All available entries are consumed on every read. Phase bits and current
head are updated before sending the cdq feature id which tells the
controller the entries have been cosumed.

The nvme_cdq_fd is not called anywhere yet as this is a preparation
commit for when the CDQ create and delete are added.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b2de74d62f7a65aea2d28bbbed6681195d9afcd..8517253002941e1f892e62bb7dacac40395b16d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -23,6 +23,7 @@
 #include <linux/pm_qos.h>
 #include <linux/ratelimit.h>
 #include <linux/unaligned.h>
+#include <linux/anon_inodes.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -1228,6 +1229,96 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, "NVME_TARGET_PASSTHRU");
 
+/* Returns true if curr_entry forwarded by 1 */
+static bool nvme_cdq_next(struct cdq_nvme_queue *cdq)
+{
+	void *curr_entry = cdq->entries + (cdq->curr_entry * cdq->entry_nbyte);
+	u8 phase_bit = (*(u8 *)(curr_entry + cdq->cdqp_offset) & cdq->cdqp_mask);
+	/* if different, then its new! */
+	if (phase_bit != cdq->curr_cdqp) {
+		cdq->curr_entry = (cdq->curr_entry + 1) % cdq->entry_nr;
+		if (unlikely(cdq->curr_entry == 0))
+			cdq->curr_cdqp = ~cdq->curr_cdqp & 0x1;
+		return true;
+	}
+	return false;
+}
+
+static int nvme_cdq_send_feature_id(struct cdq_nvme_queue *cdq)
+{
+	struct nvme_command c = { };
+
+	c.features.opcode = nvme_admin_set_features;
+	c.features.fid = cpu_to_le32(NVME_FEAT_CDQ);
+	c.features.dword11 = cdq->cdq_id;
+	c.features.dword12 = cpu_to_le32(cdq->curr_entry);
+
+	return nvme_submit_sync_cmd(cdq->ctrl->admin_q, &c, NULL, 0);
+}
+
+/*
+ * Traverse the CDQ until max entries are reached or until the entry phase
+ * bit is the same as the current phase bit.
+ *
+ * cdq : Controller Data Queue
+ * count_nbyte : Count bytes to "traverse" before sending feature id
+ * priv_data : argument for consume
+ */
+static size_t nvme_cdq_traverse(struct cdq_nvme_queue *cdq, size_t count_nbyte,
+				 void *priv_data)
+{
+	int ret;
+	char __user *to_buf = priv_data;
+	size_t tx_nbyte, target_nbyte = 0;
+	size_t orig_tail_nbyte = (cdq->entry_nr - cdq->curr_entry) * cdq->entry_nbyte;
+	void *from_buf = cdq->entries + (cdq->curr_entry * cdq->entry_nbyte);
+
+	while (target_nbyte < count_nbyte && nvme_cdq_next(cdq))
+		target_nbyte += cdq->entry_nbyte;
+	tx_nbyte = min(orig_tail_nbyte, target_nbyte);
+
+	if (copy_to_user(to_buf, from_buf, tx_nbyte))
+		return -EFAULT;
+
+	if (tx_nbyte < target_nbyte) {
+		/* Copy the entries that have been wrapped around */
+		from_buf = cdq->entries;
+		to_buf += tx_nbyte;
+		if (copy_to_user(to_buf, from_buf, target_nbyte - tx_nbyte))
+			return -EFAULT;
+	}
+
+	ret = nvme_cdq_send_feature_id(cdq);
+	if (ret < 0)
+		return ret;
+
+	return tx_nbyte;
+}
+
+static ssize_t nvme_cdq_fops_read(struct file *filep, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct cdq_nvme_queue *cdq = filep->private_data;
+	size_t nbytes = round_down(count, cdq->entry_nbyte);
+
+	if (*ppos)
+		return -ESPIPE;
+
+	if (count < cdq->entry_nbyte)
+		return -EINVAL;
+
+	if (nbytes > (cdq->entry_nr * cdq->entry_nbyte))
+		return -EINVAL;
+
+	return nvme_cdq_traverse(cdq, nbytes, buf);
+}
+
+static const struct file_operations cdq_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nonseekable_open,
+	.read		= nvme_cdq_fops_read,
+};
+
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {

-- 
2.47.2



