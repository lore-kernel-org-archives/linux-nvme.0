Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A1C433E5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:01:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854532071A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYtavdY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854532071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDxpw5xZ0kt59EBzo4Fht10U+j4b8S9vmdYPaFOm+pY=; b=GYtavdY3zP45beJ+p7V0RxUJ5H
	OoLCTFbQqiwlyI4GwHZan9xzATfQerbil793XHu9nu5SGUZNKz6rPOMllLk3DhqAe0m83yzAfraGr
	sTDVpALUklXudGZpZP7XF7X8sMjE42amCrUvIS1B8f1iTrYBxlWOlrZm99UvLjPJjjfe2gYX/4z+D
	1p9XkTvUSEtF3ifRd6PXgIKeWfT9R1zSQQsCAvmYXHuC6VcvZOcDIcHlM3m2ioWKXqdQubEhw2ZbA
	qlsbTHwNEiRwp7H6lLPYZxdMKHACXv6fAdU3dbYcBJBpxHFAUIvYtArsspIpFtCSgiCdt1cqrm/8s
	cbVIguZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jydeZ-0008Qp-Vi; Thu, 23 Jul 2020 16:01:04 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jydeS-0008P8-Fz
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:00:57 +0000
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1jydbH-0001b3-Hf; Thu, 23 Jul 2020 15:57:40 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v2] nvme/pci: Add new quirk for SK hynix PC400 NLB off-by-one
 bug
Date: Thu, 23 Jul 2020 23:57:31 +0800
Message-Id: <20200723155731.22313-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417083641.28205-1-kai.heng.feng@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_120056_673308_6D9D174D 
X-CRM114-Status: GOOD (  14.31  )
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
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 kyounghwan sohn <kyounghwan.sohn@sk.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
command"), SK hynix PC400 becomes very slow with the following error
message:
[  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]

SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
of a range, so the NLB passed isn't a valid value to the firmware.

According to SK hynix there are three commands are affected:
- Write Zeroes
- Compare
- Write Uncorrectable

Write Uncorrectable isn't implemented yet, so add a new quirk to
workaround the former two commands.

BugLink: https://bugs.launchpad.net/bugs/1872383
Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- SK hynix found the root cause so change the approach accordingly.
- lspci is wrong, the device is PC400 instead of SC300.

 drivers/nvme/host/core.c | 11 ++++++++++-
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index add040168e67..1b51b6f5e2dd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -659,15 +659,21 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	u16 length;
+
 	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		return nvme_setup_discard(ns, req, cmnd);
 
+	length = (blk_rq_bytes(req) >> ns->lba_shift) - 1;
+	if (ns->ctrl->quirks & NVME_QUIRK_SKHYNIX_NLB_BUG)
+		length--;
+
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
-		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+		cpu_to_le16(length);
 	cmnd->write_zeroes.control = 0;
 	return BLK_STS_OK;
 }
@@ -1302,6 +1308,9 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	}
 
 	length = (io.nblocks + 1) << ns->lba_shift;
+	if (ns->ctrl->quirks & NVME_QUIRK_SKHYNIX_NLB_BUG && io.opcode == nvme_cmd_compare)
+		length--;
+
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = nvme_to_user_ptr(io.metadata);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1de3f9b827aa..4cbced5062a8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -129,6 +129,11 @@ enum nvme_quirks {
 	 * Don't change the value of the temperature threshold feature
 	 */
 	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
+
+	/*
+	 * SK Hynix PC400 NLB off-by-one bug
+	 */
+	NVME_QUIRK_SKHYNIX_NLB_BUG		= (1 << 15),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..b5a54e6726e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3122,6 +3122,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
+		.driver_data = NVME_QUIRK_SKHYNIX_NLB_BUG, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
