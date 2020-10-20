Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC2C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 01:44:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9109E22277
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ECepIKjw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bfawpA0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9109E22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hhR1m1RJVeeSiOWCRYnFunqtNl22bU30J+zHUf1HDUY=; b=ECepIKjwTNiFQUyi5//uG0LMB
	nN41ZIftBl9I/UlhdoAWlePMYmQyQr/BwF7gK5JxSXylD+MwEc4nC/RAo++/l5wK9TFgR2owCGWBi
	TpeSS9ihEJ/6dNyk3wb/2FwJRfzjlVPKLLR5uwQKih/3H4yhykuw9AFJH1PlA+Ol0OyjXDAviY97W
	hRRjV6zjctK7m7CnnhSKjNeoNhk/9F4k6mQQSibqfE0Q+FDC1kNwR5GVutc7PHB9pmENjPMZYrzcL
	S62W03ANDYUPZL25Y5NNpBATBK/DnQbePXLzilORxep5LyRsqYXhy70416vSX36wCDPzwsAy+hJo1
	Ni1WTgboQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUghR-0000HL-Tz; Tue, 20 Oct 2020 01:44:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUghN-0000FB-DD
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 01:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603158265; x=1634694265;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FzpUGu4n9xfcIg+IlgXHO/syG0l9dVYFLxCH97DC768=;
 b=bfawpA0Dv4gg5k7piJO96wdYsJOaA/HCpwE5sPMpdiMkAMXjwEcTDz5h
 u9bWE3MYp5Bm/IU4520yppHABy5wCr8xmZfTVsPtcCqgifWScJc4KG5sX
 KOKW3kwDwR9PoInTOMmmD1kD2lK74HowMg0pbWhFo+wCKdaSQYVbcz1mh
 B0dSUGc2ZfaVp2QEEo9vxcH4mO3ELdFzqqutNFBkY5SvGPYsUq2XMeZSv
 hhjx7Wa0As5NeVV8XcDnJ8AVhHwzkOoCETrZFlYUYkdmXSMIBcJgx7cm9
 vbkS27MeFI9HjWiW4kOAbYTGdDor0Q6qO0uWiK/8G8llTavQ5yGzKz4Nx Q==;
IronPort-SDR: FJ2LMAjFeut4bnA0y2ulk+nxN+eQ1xOSxciFv+gdq6eldPlL/FGw/jZyQ9MQrZP8L+ecsfVuP/
 OfnHIV40PzvfH+jqj6FYcTWyBZdYsWX9InFrdbjeeyXGm2g7Bszd03EhANQKo8h46ZTwwN6fZd
 +D7yiBqWw45SzQRMuGa7I5W6jIn9LD6xwFzy3abcKQnvmOa+GdDAvWEhvZPS7dpD6hRO6ZVFnl
 Su0qcqvfazCxEnteFBxRsVtJ/m+brA4z2HE/uaOmzOqUAWOTZX6U6GNe4mtvs+UbjVxm7b5hHo
 WYg=
X-IronPort-AV: E=Sophos;i="5.77,395,1596470400"; d="scan'208";a="150292285"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2020 09:44:25 +0800
IronPort-SDR: 5qS0PZwFO3KSYAT0OW8D3cetkrmbNjN/lLdR90ifkykdekEX3DJpteGt82oPj+4CKw5M3+PPhN
 5o/qXQo3EKJ6+DD69hustGw6DvdhXTi5jdAgOczoYvSsd9qcNFKfwn1TogQvq0U7nFkQLiW5Ty
 5Dl3WO+ojYu16zUam64Wje6j7FGoN6esgR/teuI8demUW2snAScJPI84Sg85BPshsEozde2Dtx
 1lQVbCp30sAUPTsOGB/TX236IcR4A99bUmDwxahglCL3++hixS+p4Iabh0Oshr+r0mUUzjrX+b
 KFS7DUxN12zGMr8lSoOrhVZp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 18:30:51 -0700
IronPort-SDR: nTAssOtz9+OfvRIaLFO9FztJsX64k2mAnoRYDnrQnGUes5Rsw0GmVy+TnDTQXeOnemrkSVhpoM
 G+PnZ3UoO7Bjpeo5NVKUYIjGP25k/j2R7+q4PtGNMSKAOJWPoyrW+JDbQqE9XbnN0h62lojRpp
 9PweyU6Lw4AJdUzajqKrFqnBVGdL2GtPtGHvlf0hdslcXwvNYo6VBlgg2+yx8t80d6R0uOAqjx
 nbVXgwX4+MJKJMfbkiIp2V6saDQ6TbyFDD2UBTmyukp7qZZD0bejwwIijG4x24F0G5Hy3Rlabo
 qI0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Oct 2020 18:44:25 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/1] nvmet: allow user to set req alloc flag
Date: Mon, 19 Oct 2020 18:44:17 -0700
Message-Id: <20201020014417.3604-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201020014417.3604-1-chaitanya.kulkarni@wdc.com>
References: <20201020014417.3604-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_214425_657198_FC275FEE 
X-CRM114-Status: GOOD (  22.09  )
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
Cc: logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: multipart/mixed; boundary="===============1295503464551015262=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1295503464551015262==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

By default, we set the passthru request allocation flag such that it
returns the error in the following code patch and we fail the I/O when
BLK_MQ_REQ_NOWAIT is set:-

nvme_alloc_request()
 blk_mq_alloc_request()
  blk_mq_queue_enter()
   if (flag & BLK_MQ_REQ_NOWAIT)
        return -EBUSY; <-- return if busy.

On some controllers using BLK_MQ_REQ_NOWAIT ends up in I/O error where
the controller is perfectly healthy and not in a degraded state.

Block layer request allocation does allow us to wait instead of
immediately returning the error when we BLK_MQ_REQ_NOWAIT flag is not 
used. This has shown to fix the I/O error problem reported under
heavy random write workload.

This patch fixes the problem with the request allocation by adding
a new configfs attribute so that user can optionally decide whether
to use BLK_MQ_REQ_NOWAIT or not. We retain the default behavior by
using BLK_MQ_REQ_NOWAIT when creating the nvmet passthru subsystem.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 36 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  3 +++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  3 ++-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..3892b8fb0ff6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/blk-mq.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/ctype.h>
@@ -736,9 +737,44 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, enable);
 
+static ssize_t nvmet_passthru_req_nowait_show(struct config_item *item,
+						char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", subsys->req_nowait);
+}
+
+static ssize_t nvmet_passthru_req_nowait_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	bool req_nowait;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	if (subsys->passthru_ctrl) {
+		pr_err("disable passthru ctrl before setting req_nowait\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (strtobool(page, &req_nowait)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	subsys->req_nowait = req_nowait ? BLK_MQ_REQ_NOWAIT : 0;
+out:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, req_nowait);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
+	&nvmet_passthru_attr_req_nowait,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index aafcbc424b7a..50634945bd42 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1511,6 +1511,9 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	}
 	subsys->cntlid_min = NVME_CNTLID_MIN;
 	subsys->cntlid_max = NVME_CNTLID_MAX;
+#ifdef NVME_TARGET_PASSTHRU
+	subsys->req_nowait = BLK_MQ_REQ_NOWAIT;
+#endif
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..a7ca8f5860c9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -249,6 +249,7 @@ struct nvmet_subsys {
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
+	blk_mq_req_flags_t	req_nowait;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 56c571052216..7a2ce00f7a25 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -215,6 +215,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
+	blk_mq_req_flags_t req_nowait = req->sq->ctrl->subsys->req_nowait;
 	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
@@ -236,7 +237,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		q = ns->queue;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, req->cmd, req_nowait, NVME_QID_ANY);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.22.1



--===============1295503464551015262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1295503464551015262==--
