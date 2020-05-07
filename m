Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1DC54E4B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:02:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E43B207DD
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0xG57Cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E43B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mwhG46uHqsYdt7lWeVD/mcG0bdtkcJLF3XBNZSGlxZ0=; b=d0xG57Cc1mGFfpuvDPiV7rKzu8
	S/+g8iYevgTERB1xTvtNs7kqwQqJI6yiRPHh43nHaPpKZmhlypqMCB0SLqSj43T2BPcdNw9A8qWtk
	CIg+BdG+mzYf3T9UNwuwUeVV9FOxBvwTUu2ObIGdgn1/wt0A5oejk0sIEzVDA58nWXvPknkP3hHGm
	bymPlRp7IKuMPdHuiXbfWZ7mHVL8qau7goe8Ej7OdqfmE2Sl4xQRWeRJfZpYqzIi/qzu+4gb+3WzK
	H0QJki7Lv5aCH8I2agBM0j4TfWr0LJcb1JejEeQbWN7XQa/zuG+rXSCVmiw7bGYUnA9JJvrfhihxd
	maF0XxpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWh6q-0006t4-IQ; Thu, 07 May 2020 14:02:44 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWh6k-0006oV-AR
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 14:02:42 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 yorayz@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 7 May 2020 17:02:26 +0300
Received: from dev-l-vrt-071.mtl.labs.mlnx (dev-l-vrt-071.mtl.labs.mlnx
 [10.134.71.1])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 047E2QST022772;
 Thu, 7 May 2020 17:02:26 +0300
From: Yoray Zack <yorayz@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] nvme-fabrics: Add support for padding alignment (pda)
 option on tcp
Date: Thu,  7 May 2020 17:02:02 +0300
Message-Id: <1588860124-40089-2-git-send-email-yorayz@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_070238_951652_3AD1853C 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Consume the pdu alignment from the nvme connect command according
to user-space directives.

Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/fabrics.c | 14 ++++++++++++++
 drivers/nvme/host/fabrics.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2a6c819..4468b57 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -612,6 +612,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_PDA,                 "pda_size=%d"           },
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -634,6 +635,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->pda = 0; /* default no padding */
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -851,6 +853,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->nr_poll_queues = token;
 			break;
+		case NVMF_OPT_PDA:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0 || token > NVMF_MAX_PDA_SIZE) {
+				pr_err("Invalid padding value ,should be 1-31 %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->pda = token;
+			break;
 		case NVMF_OPT_TOS:
 			if (match_int(args, &token)) {
 				ret = -EINVAL;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40a..f1e562c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -9,6 +9,7 @@
 #include <linux/in.h>
 #include <linux/inet.h>
 
+#define NVMF_MAX_PDA_SIZE	31
 #define NVMF_MIN_QUEUE_SIZE	16
 #define NVMF_MAX_QUEUE_SIZE	1024
 #define NVMF_DEF_QUEUE_SIZE	128
@@ -56,6 +57,7 @@ enum {
 	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
 	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 	NVMF_OPT_TOS		= 1 << 19,
+	NVMF_OPT_PDA            = 1 << 20,
 };
 
 /**
@@ -89,6 +91,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @pda: host pdu alignment (TCP)
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -111,6 +114,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	int			pda;
 };
 
 /*
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
