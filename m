Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F1EC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD462078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bcMFWk7o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lbHx3Dmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD462078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CQRqYfcFZmNb0K8bp82XiKh7HrLdAZ7omORI/+ZLAW8=; b=bcMFWk7o3g5ecsSt3JMd28Bwa
	u3v+H/OUDgslZjyzxcKz8ukA6AXxzUbet6yzkoyyF48P1oA4uc/FisdhZc/fbOLF8DWkRPk3NKJ2g
	wbjeTGL2kZAzC0adkQcHQgx6HwAwWUw+oDNxjbcYFd4sVsa1ixMbXn9wz1Q/SZsFhuyggcBlvvRKf
	pXkWD2RJjGMoRoAU99kvpiz7mSVmPvms0YDpH5Mr0k9stfhq92djHZBfihSaGvcKmt1sFpxeIKlq5
	+PzuNsb7JZanqRP38/UeF/UktPqWGW2tAOXcvnkOCz8h6ry9dcxnfVSeluC4cfaHBUFVz+z4zSLkb
	B20FbJKjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIrJ-0001VT-NB; Tue, 15 Sep 2020 21:51:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIrH-0001Uu-Jk
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206688; x=1631742688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=crxDfWAa9YsMsSkwR90yqcQOe8HhkdrneyuxJGANwgk=;
 b=lbHx3DmjKn7Ihg7QWyAc6YozX+Jd6+gmJHJF2bl0xzkHJSQbHay4LDNG
 amDvybQSGzAf/EpjrNIZdbscH/J8yAEXdT5gootLCMcYQ5Uk9kMaIkvQ5
 4VZDI22r67TTmrVAynzxcPiCUnpxAPko6JRRwchJCoOLMww5FmzpHAPjY
 Nd/T9AfSSbwBBMDuEvNkuETbeFi6ro71/auBbXSKxcWDfN6rcdWbubKQ0
 4cMwScFeWBOSuMf1I3zCn1JLA14NFSTlvC7/wacsPgB/YEfr8eZ4cZJWR
 +zgyfg0kx4jMKYGHMdsRYJSCsxCKlObvJdNkeWNBpdDlDQb0RsXkA63GL g==;
IronPort-SDR: Kp2KmDAZHHvDfArSGvDq5M0nJhOEaEvNiyWWGjA8toobcDqugFJ1kzq+lPsYkmqcGKxI7lOb3W
 qJBgq41fNp9lAxUjxGHK2JhV2Jv1KtAWUuW2YEfCzskpk3AU8vZhFdfYDW67xKOr/c7mQblqEP
 Ud14tmMC5eCGbO77x1hObvkbJ/29X2falqV8RHe7ZVBA/Jdmim2DRJpxbsjxuQrAF+EwZYKQ2x
 HRXd/xbKKAKVQ2jsbR6nNPlupRx2hMbL9rXunWoy+UUF3n01PlagumOTVXaxYOQDxhdQTCvM5A
 dTg=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="151828750"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:51:27 +0800
IronPort-SDR: 3m3Kwlp8gkEV5nYFwyxhCLKCpsyOyOlv6c74agMBnWSozvdLylHw1cZJvPHd6dxV7t6o0hxMGm
 KWMab1J9VZbw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:38:36 -0700
IronPort-SDR: uxmR30LFbLGNqKnWqn9FupgqbuH8c14N8HfIFHobq2ksoaCwulSbGdPEOeSPseuxxzGeJzV3LW
 /1C1UQzuK8RQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:51:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/7] nvme-core: use I/O timeout in submit sync cmd
Date: Tue, 15 Sep 2020 14:51:12 -0700
Message-Id: <20200915215118.3934-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175127_798944_5513DFCC 
X-CRM114-Status: GOOD (  16.44  )
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
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8b75f6ca0b61..0f878f5e07f0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -885,7 +885,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	nvme_default_timeout(req, timeout);
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fd45ff656da..78dc422ee42c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,21 @@ struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx);
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 
+static inline void nvme_default_timeout(struct request *req,
+					unsigned int timeout)
+{
+	void *queuedata = req->q->queuedata;
+
+	/*
+	 * For now admin request queue's queue data == NULL, if that assumption
+	 * changes it should reflect here.
+	 */
+	if (!timeout)
+		timeout = queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+
+	req->timeout = timeout;
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
