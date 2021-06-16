Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339DC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD63B613E7
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD63B613E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GARoRPAAe7risitpRNuH8aqK4iemlBgbjotkxackiSY=; b=ASrkh2G/FYRwGE
	Ee3NhNVkV90KNbubrRVKN716Us0oI3OTFwyXuzYV9R6xnTDDCYwIz9d+sk40Sj+tAVmdOurFLsVsK
	9vF/q9Lnd2kXK93EIOT3SvDESpLxvF7YH+/wdm91rmaMu/zautcFyFsi7VKtgDLAfLwk5JuGEQYvS
	Jrpv4wXZKKctaIwvHIsnFceObQWWCF+OkKgB7g66GJMQ+vnKeCZH/aH4vIRmvgM06X8+KSTc7Ey0E
	DPFA3cl/Ofvdxas3Xa/ItP13EvYinCsOeWbIelGwmWE+dwwIWJVovvuti4zlTCYAHgciHq+51tS6O
	NzJjyCZuIW/0iezjMQNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltcxN-007k9J-Hf; Wed, 16 Jun 2021 21:20:17 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcwo-007jzl-S1
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 21:19:44 +0000
Received: by mail-pl1-f181.google.com with SMTP id h12so1796371plf.4
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 14:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DGp08+LHVapWk7kKj+n1FjkqLPzQBASX5Eix/QAVj6c=;
 b=ujz7HA4BtOF3azAwF0UFVjfwVRV1u4MnHQr8W3A1ymT+KYJ8hnQK/uluD03D4yFvfd
 RANRd5+PSxYd4LUuWJDT2Aa3vvGLohacpCfMc0tQRIyMjJUkScfqddFvckGSztrhzwsL
 iprjPjTP5UR1m6n9uEIUVuCc9d7Asynrx31EQENtvhzkzYA1PVuZsgEyTuoeBZXsqRkt
 +H+4kUeNy3gFjW3uNLpY6wKXMskdKpWBxIa9ovYrQE+CLIHT3g6olnxtmvDIApDHlDjl
 BAOqIykRMZfPCl48Jlb9PICKJ0L38nU0Lo08Ltm5TZyCKVz56p3Obr9Cf4gkl4KQRJIM
 K8CQ==
X-Gm-Message-State: AOAM532BpQny2V5RE/joKlxvsf3oz3amZvEMC5m7H0s1Nm2Gm3A4zbEY
 xCMGHUJGd3vmjKzpj1rTD+pWGEIDlKc=
X-Google-Smtp-Source: ABdhPJwMawWlsfdvaRLxQiqox1XSRJrb+b/ddHsEXcLAYNVwUZ8G6CNgkApQksm4aYT1NuFi+ZyHgg==
X-Received: by 2002:a17:902:f54d:b029:107:b14c:423d with SMTP id
 h13-20020a170902f54db0290107b14c423dmr1448597plf.77.1623878380766; 
 Wed, 16 Jun 2021 14:19:40 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:1036:8496:ef40:673a])
 by smtp.gmail.com with ESMTPSA id e188sm3003046pfe.23.2021.06.16.14.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 14:19:40 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v3 2/4] nvme-pci: limit maximum queue depth to 4095
Date: Wed, 16 Jun 2021 14:19:34 -0700
Message-Id: <20210616211936.451128-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210616211936.451128-1-sagi@grimberg.me>
References: <20210616211936.451128-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_141943_020036_1D1F58A5 
X-CRM114-Status: GOOD (  13.58  )
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

We are going to use the upper 4-bits of the command_id for a generation
counter, so enforce the new queue depth upper limit. As we enforce
both min and max queue depth, use param_set_uint_minmax istead of
open coding it.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9cdf2099027a..d2ee9e46f5d3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,6 +60,8 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
 
+#define NVME_PCI_MIN_QUEUE_SIZE 2
+#define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -68,7 +70,7 @@ static const struct kernel_param_ops io_queue_depth_ops = {
 
 static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
-MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
+MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -157,14 +159,9 @@ struct nvme_dev {
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
-	int ret;
-	u32 n;
-
-	ret = kstrtou32(val, 10, &n);
-	if (ret != 0 || n < 2)
-		return -EINVAL;
-
-	return param_set_uint(val, kp);
+	return param_set_uint_minmax(val, kp,
+			NVME_PCI_MIN_QUEUE_SIZE,
+			NVME_PCI_MAX_QUEUE_SIZE);
 }
 
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
