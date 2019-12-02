Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908B2C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 14:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620222073C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 14:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O7G6EC3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620222073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=He/azRqGf/CI4bOKWW9ttIy30xMUqIVrpmVC+RZ0CLk=; b=O7G6EC3OC/DYUQ
	Ppg5w1danAT4EfHflzd8vaa22xg5ERDvAiJ+SKj1Xgnl9gQ7QzFwFVyDzbrS7LqELfi7+dwOXBiSE
	AN2SJl6KYsTrduIamwpUmSIdSjfkI3q/ZMMF24jRU1431NC6fvfqhfwqeBE6fdkBalOGYbc5Hc35+
	SMcW3G6yiupTiArw0RlNQqkyuTVGhWuizXg16TnTp9dH0re8tI6VPg8N64YJD7dbYkUZFd3dJBl71
	ma5juRFdYedX7kaUumacKbrRw3Cr799Gml90cevWAsllFZEqOgrja4RZWdM1KNnF0z3UV47EzdUKa
	HY3IH7m3weBnCui6UdIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibn00-0005Vr-EN; Mon, 02 Dec 2019 14:48:28 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibmzx-0005S0-9Q
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 14:48:27 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 2 Dec 2019 16:48:13 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xB2EmC1s004689;
 Mon, 2 Dec 2019 16:48:12 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 04/16] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
Date: Mon,  2 Dec 2019 16:48:00 +0200
Message-Id: <20191202144812.147686-6-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202144812.147686-1-maxg@mellanox.com>
References: <20191202144812.147686-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_064825_719733_2A0CFFA9 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Preparation for adding metadata (T10-PI) over fabric support. This will
allow end-to-end protection information passthrough and validation for
NVMe over Fabric.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c    |  3 ++-
 drivers/nvme/host/fabrics.c | 11 +++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3c1516fc5288..1ce15bddf390 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1860,7 +1860,8 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		 * controller.
 		 */
 		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
-			if (ns->ctrl->ops->flags & NVME_F_FABRICS ||
+			if ((ns->ctrl->ops->flags & NVME_F_FABRICS &&
+			     ns->ctrl->opts->pi_enable) ||
 			    !(ns->features & NVME_NS_EXT_LBAS))
 				ns->features |= NVME_NS_DIX_SUPPORTED;
 		}
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818ac9a1..c09230e18980 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -612,6 +612,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_PI_ENABLE,		"pi_enable"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -634,6 +635,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->pi_enable = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -867,6 +869,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+		case NVMF_OPT_PI_ENABLE:
+			if (opts->discovery_nqn) {
+				pr_debug("Ignoring pi_enable value for discovery controller\n");
+				break;
+			}
+			opts->pi_enable = true;
+			break;
+#endif
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40ab62ee..773f74873a9e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -56,6 +56,7 @@ enum {
 	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
 	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 	NVMF_OPT_TOS		= 1 << 19,
+	NVMF_OPT_PI_ENABLE	= 1 << 20,
 };
 
 /**
@@ -89,6 +90,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @pi_enable: Enable metadata (T10-PI) support
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -111,6 +113,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	bool			pi_enable;
 };
 
 /*
-- 
2.16.3


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
