Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0987DC4741F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C6320739
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T2UqOyaI";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="kWksuQ/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C6320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r4DIW2P7EAdm5jQQEMc34UgkGckw/5pqghdEss/DBvk=; b=T2UqOyaIWwMx/6JMBzP1WZu77
	3wPWvYIIEcKLU3WEClrvwT6WXG9WJwcKeU/Rp24d5/IZCoK5nDNMOqJ7kSTUjl2lhm5MhwiPbWGZH
	GoRHo6gqR7ouP+a8GlWYBUVLgmeGrdDMEDXePudl+9KG9nDw/FWlmfgKgO7zeijkGU80XaVJNaz2C
	etgJvnRQkTuDc0zS/C/5NI5kv+YSH5xXEIHONI69oGcnMR3iRh0O9cdA1iTCKQCK4+oWEEe2Qh1i5
	lpqYPNYoo6plRU++e45R1aLLwF1gped5jqujhd3ZfaPFqywTe7jcN5a50rysoC/d/AUMMafHrcjQ8
	wdk8MwZUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeA-0000BQ-Hy; Thu, 29 Oct 2020 23:47:58 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHe8-0000Aw-BJ
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604016090; x=1635552090;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DAW2L9FG8Zdb8LoMLZ2kcdmXgAN6QSg/RZ8e3TBmNQ4=;
 b=kWksuQ/PYatrhL7mifAEXQRiMs2NItz2X7USqz14AjpzLAqbqOXR0B54
 ZjM6f7Y0erxQkx54DqChBWYnSC4lz+Q7bwtsCCxg86XTkQJOYaebw+Uwz
 7y9kKPxzGGA7nRXdE9cvhfXSR1XGfhtKNlTgh2UsIj2ucfSC2e21+skAM
 zgXvBadWJPanwpct1b2ZW5ylrfzYbp9C0WwRw306PJgPF/dIljDLe5HPR
 XzhirBBi5/QW+vom1FsqXnY1xI8m9tmZm7ZbEMo37VzTaRlpsYhQn7zkM
 Fup4hYG3KaWs65JqPa61HtXdK5Euq4p3ab0BwnZj6pl0kI6WI4G3xAihw Q==;
IronPort-SDR: D0PGZs+4d/RUAYaoDQU19kPwHJmhi4+mSV+66VBqjoIX4jQI4Dc3/f746NkRWwJTb/dUMfSG8k
 2ZDwscECN9GwR9pllnfZC6hB1EEiMLxhobQ24tb5lw6BLbg5Z1NxWEfoJ3hNzP0/+KzX6swtVJ
 sPUIa5ZbGUPL2p1Ut4tGwEji1MXYaKkC+0etJ3KnrMtq/xeF/7/8wlw338dtMP/4pII2bVxxgU
 IQohZ61WDxaPHEp2BarpGl41izjPtV5HWl4yPYI3CgQvLPGSPGJd0knt3dPHbu8XFjqdtgBAAM
 c00=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="254830179"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 08:01:27 +0800
IronPort-SDR: r1u61YGkalfApOAHFT/fCECM9ek0ZzBLBfVSe6NUsaZJqdvv1Tg3gPV0kPDl8Swj24HvpIyZCV
 Dpy3txpeTSxuGXlHUtD27LMQ0YVaUCmn/0BYXeP+0K6stirQr+O/zN+2ZwQ+0IAP/kbboP1pxD
 EPGr7JoBEmJzJnGxguzr73WG7TNBrGC7Jqi8YxTF5dwoH8Ygyszz6uJc1m2I00aiLxvo4Hnt2R
 K36Jk4pCdBjFjTAZcGeZLmfmGuL7bCQOrgP4r+TnDqmpokhZkI7YpFyGR79GUkQ4YFUbahDbQP
 F4un6QsZ3mCZ+AV/DFEQFRkk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:34:08 -0700
IronPort-SDR: /WpaXYr0uYyCKNMX2yQaGG6v7+89rX16faVb8Jj/+JKneCN1VOjiKKT6/0SLCblRV4MJzoUEEO
 nM7wXubDu6mRTE2E2LaarKN2wrRRbYFv/cwg33t8pJ2l1R/mWgW5GmXDZceScIADI5mYTGXeOt
 dyYMsj7e8RQYAgwbXuN3FSO8PrSNgr94tUKKrTs9aW8LFFrgF4vRxqtdTKEdpnK38XOUx+bSF+
 NT7zwrPWqGyt8GUgbc98JjstG+GCYSnK7dAYYcIlVIklx19AjJGY8piqUA5wmov+tV7n7HMJtZ
 NIk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:47:53 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 1/7] nvme-core: use I/O timeout in submit sync cmd
Date: Thu, 29 Oct 2020 16:47:33 -0700
Message-Id: <20201029234739.21266-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194756_509557_A009EBC9 
X-CRM114-Status: GOOD (  16.65  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
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
index 95ef4943d8bd..42ca1b04b6d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -901,7 +901,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (!req->timeout)
+		nvme_req_set_default_timeout(req);
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc111136a981..9eb75731c6d7 100644
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
