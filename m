Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B76DC4708F
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 22:54:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FBA6124B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 22:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FBA6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gj2mEUaLEXXT4DgSEitI7A2lD8a42Xype5JgFpSM0Rg=; b=WRZNYIzVjWl3dm
	H8wbQzfHUHjleRlVADrg4odoaQQuu4+ELlqQUaIxMJBBaBstz0rAlQj0RGLYOctuAKMhmvfyn4DOR
	Kz8NZJev8W2NO1IiqMg1jNfJegaVOrTJgGN9XOxr1sJfFNtzu1PbkXXITIlJvgKwtsmmXESrXxcdm
	91kbhnIylx6yQOUhvZhNd2f5IUDXy3yO5f44gUJaL4yAjxs273J/fV+dSrgCz/6JOSyr0aCz1AxQt
	L7szqdo6J3yORzuU9QnZt2FzOgi4LdJEsUGlxEnavD03lqFZ2wu9FfaDIEASSWyHqriuuhk/RQv56
	NjJZLNHYjZ/0c8Ihg94A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnqnr-00DhYk-LT; Mon, 31 May 2021 22:54:35 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqnK-00DhRH-5Y
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 22:54:03 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14VMorFg001343; Mon, 31 May 2021 15:53:55 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38vtnja4mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 31 May 2021 15:53:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 31 May 2021 15:53:49 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 31 May 2021 15:53:46 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v7 03/27] nvme-fabrics: Expose nvmf_check_required_opts()
 globally
Date: Tue, 1 Jun 2021 01:51:58 +0300
Message-ID: <20210531225222.16992-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210531225222.16992-1-smalin@marvell.com>
References: <20210531225222.16992-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: oQnhHioqWLfsTCs2armNGikqPxBFrJNP
X-Proofpoint-ORIG-GUID: oQnhHioqWLfsTCs2armNGikqPxBFrJNP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-31_15:2021-05-31,
 2021-05-31 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_155402_354727_6B678ADC 
X-CRM114-Status: GOOD (  12.26  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 5 +++--
 drivers/nvme/host/fabrics.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 9d5cf3454399..f71f3c229c0a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -868,8 +868,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	return ret;
 }
 
-static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
-		unsigned int required_opts)
+int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
+			     unsigned int required_opts)
 {
 	if ((opts->mask & required_opts) != required_opts) {
 		int i;
@@ -887,6 +887,7 @@ static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvmf_check_required_opts);
 
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 38ac7b757d78..15d9c15ef8a6 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -197,5 +197,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
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
