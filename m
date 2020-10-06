Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA97CC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6CA20B80
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JmKNwN6+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GgE5hR+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6CA20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SO46fbHp99d7xCE06EWdcCCp+T+xBAv+lRZ61UsuZfo=; b=JmKNwN6+y/RMpS2M4XNzppp/S
	QnyRsdAeesLtnaYRb4+LngEuyBnN9gSjLwSPn9NpR9h3n0Wxa/Jv98d+ksf7iyCb2xpCVvW+CjOnO
	4OLk2oAq5KmpRCAV5bER8QUQYYxmZq9QsVg21VhVGk9gIa0YJ1CGuIJMVFNA8c1Xnunp7ahEMqZ+4
	QV5toX0z/4NahCwVIwq/PIHDvFR346FhZ0NlG69LAh5ZBv73JjLlNN0Cr3M2yNIxq9Joq+ruSzeSQ
	knrCAPelzd0EyiORekdmZT2BqnPCpOW7KJbcvYSJ8jwbsnFkJSxobmaulaRGoCke9/E0L4hK6VKfP
	azYpHkgQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQI-0006EN-Pj; Tue, 06 Oct 2020 23:31:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQF-0006Cs-LA
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027067; x=1633563067;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S/MgRFXhmTVX42x7xXXBOPyH7Z6yhVxQA91nH8z+gX8=;
 b=GgE5hR+6XM/w4x9XFZEhykgZrN2y3QyesebcXUXFek1KzHaqI13Wxk3X
 nAud+jTRLwpQWQxIrhflUyHwlYktyLI2H5Scm5G70Q2w/f2TPm/R9nPbA
 +QpWFkzGiVr1iD/GSXPuzIVL4JVufqpcH5ai/yqy/ujNlKpOkcwZ9JFNe
 r74S2dnwYkiPwVLZBhlV5rYHzdUBu02t2Cf43qdvFLnybICxF8TtKDUpU
 8OZ94QBgS01oJCCxc6E7386s65Rw+B3XVvTLMBhFDH4+WeJj/fGMWnzoI
 W8zmo/XXjqs+pmPD8jaKGz84gPlcB7tLkRe2+e3wUGAYP92ukCSblQz5l A==;
IronPort-SDR: pIpOFxTQBPzl4+T3AWnlTt+iYfMj87FbH4G10oV5j/cv8oy5WxqFUl3RDm7IhwJlEXV7GHU6/g
 ApIhibZIKqAJIW2ymEhMlN+HMFAXtBdVkLYVKac66m6+UJLke/1pUXTL1KcMkh3p6A14S130vJ
 gfanaexj73v7Da42ixy20iN3xRsbnWBwgVhv+xSa40yFoOlXCTXI4t34pavarQ02eJ3aESfuK2
 rYwBGaqvID5KNllcgpKGQvaVCLeX0ppHCQT9xq5Fxa4adUJib0f0ZTaW8pRJwO9r3MKJtJKImP
 XRs=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="153631297"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:31:06 +0800
IronPort-SDR: 6QtSYPMhUwn8krYH/AAfrdSj4UuUKKi+jVNHnLQ8AuKJYySDQKOV7F7ycIHujYNnfE7OmRONAR
 gCopKzxOuKpA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:17:51 -0700
IronPort-SDR: YL5zpMn/NhpluxqCrtQLVdx/lqSuqSCR3tp0Suy9HbLKRELoTEzfWSDUtzv2DguQnLhQKOoMse
 AxJIbwS1j5PA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 1/7] nvme-core: use I/O timeout in submit sync cmd
Date: Tue,  6 Oct 2020 16:30:43 -0700
Message-Id: <20201006233049.55458-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193107_850392_DE058F3C 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function __nvme_submit_sync_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the NVMe commands contexts (nvme_pr_command()/
nvme_ns_report_zones()) where NVME_IO_TIMEOUT can be used instead of
ADMIN_TIMEOUT.

For now we don't set the request queue's queuedata for admin command.

Introduce a helper nvme_default_timeout() and when timeout is not set
for the block layer request  based on the request queue's queuedata,
set Admin timeout else I/O timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c20ce8eabe82..49662e2190d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -897,7 +897,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (!req->timeout)
+		nvme_req_set_default_timeout(req);
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7c88b40f5bb..3106d6133c8c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,14 @@ struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx);
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 
+static inline void nvme_req_set_default_timeout(struct request *req)
+{
+	if (req->q->queuedata)
+		req->timeout = NVME_IO_TIMEOUT;
+	else /* no queuedata implies admin queue */
+		req->timeout = ADMIN_TIMEOUT;
+}
+
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
