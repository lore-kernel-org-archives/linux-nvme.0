Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB3C47089
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:01:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C19B613BA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C19B613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtRck7mhNR+BoGAs7i+6ZNx+Jaz7E1qfY27RKrGlPSE=; b=ZZVSHgZxHNQrok
	iTPHliwA4XV349uVaPYmZV2f3FXYQKIMEWmEw8QkF/e1zQd7LGM9k7z5RU+NeD5ZhbGaTUmy+9kXZ
	vGW0V4px5BehcfrkUlXS8wL1yVkMTW2/CjrZmfPspY80fkK3fNuXtdHkc2GBqclpZNHU5atSSzqCS
	7E7bMWXSaCiCM8/sp6BAtGnu82Rj7zv2rsgZ7TqmZGKQta0xV65hFo2j39xZp6KWBwMBfPcoHi5zb
	0DiUnsSWV102nxuH5K4XtrIbBbR+9C0vB5eQwK73XUE5DSi0oAHvNq7EC2TQFO1blcoXo927bgMtG
	nYVEmjKEh8iflHTxFShA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmPw7-00AQ0c-VJ; Fri, 28 May 2021 00:01:11 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPvV-00APgJ-Ub
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:00:35 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14RNp1au024322; Thu, 27 May 2021 17:00:26 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38sxpmcyvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:00:26 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:00:24 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:00:21 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v6 03/27] nvme-fabrics: Expose nvmf_check_required_opts()
 globally
Date: Fri, 28 May 2021 02:58:38 +0300
Message-ID: <20210527235902.2185-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210527235902.2185-1-smalin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 8QcrLUzyWa_v-ip1-ecuNRrhjmuingJW
X-Proofpoint-GUID: 8QcrLUzyWa_v-ip1-ecuNRrhjmuingJW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_170034_139026_B70D0721 
X-CRM114-Status: GOOD (  11.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

nvmf_check_required_opts() is used to check if user provided opts has
the required_opts or not. if not, it will log which options are not
provided.

It can be leveraged by nvme-tcp-offload to check if provided opts are
supported by this specific vendor driver or not.

So expose nvmf_check_required_opts() globally.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/host/fabrics.c | 5 +++--
 drivers/nvme/host/fabrics.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index e1e05aa2fada..ceb263eb50fb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -860,8 +860,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	return ret;
 }
 
-static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
-		unsigned int required_opts)
+int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
+			     unsigned int required_opts)
 {
 	if ((opts->mask & required_opts) != required_opts) {
 		int i;
@@ -879,6 +879,7 @@ static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvmf_check_required_opts);
 
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index ce7fe3a842b1..8399fcc063ef 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -193,5 +193,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
+			     unsigned int required_opts);
 
 #endif /* _NVME_FABRICS_H */
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
