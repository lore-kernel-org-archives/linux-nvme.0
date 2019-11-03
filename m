Return-Path: <SRS0=k2Ai=Y3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8DCA9EB0
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 18:14:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77137214D8
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2019 18:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tq5ElDsE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FCAF9/3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77137214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7qYR/KHv8p8x0xDjD+TORDwbrK2kPh++r/XG1XSKP7s=; b=tq5ElDsE7Af0zf
	2Up11nSDzTz5C5dxUvkXKFNbrvn/yGxxww/bHMxDdGW6HpKyQRBr6KF4wadQmYE1WYSP986UUMnKb
	N8dGoEkOokPJZHcx+6HfRyE9Q19kd/TuN9lV7ULPQftRlzHUUdw+KI+6OCbhw3HVtU5BTvWyKptr6
	FwDyQKKYKL5t9Bbe8xm+JjfFMP/650huLkQTzERYWM4jY75UnGvpohh3tNUrgNzf1axj9jwd7K1Y4
	1vnP14TlMKaT9abcicRP0uDwYbc6uEV0VnytLHQAjGSB8i2P4K3/nKR6KJwYIzhsTm1/D/BXnDsR0
	xNT2mJc7uh4ky6L2mPbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRKNv-0005Rp-Uk; Sun, 03 Nov 2019 18:13:55 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRKNq-0005Qz-Pn
 for linux-nvme@lists.infradead.org; Sun, 03 Nov 2019 18:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572804831; x=1604340831;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e0asMC4kNaUbPo8Ddw2x4Uls8FN0jDvuyJdDShKUXCI=;
 b=FCAF9/3AjIS4/+ilQxiiUsdxB9TzKct/LAJK6e6YmL5nUBLnEwmNwLVm
 oiRjuLucrhsnirOaQzjDAP0LNKcoGk/t5qWxgvhhCUVy0sqWXTI9kj7AQ
 /75L84xos+lHpzJ9HWgsRcxDy4YVgTu9aNh086lH8cBmu9RtBN7wtjBjJ
 Uk/uXW61MFmKzPJNN6EtXwmYRayuBFzL5EpT7jyiABCKK3+rCg6q/onRa
 OP2fccCSojOIq+JNoiIuhA6wjuyGuIJBf6nLPcGLTPOLyCXlhS6cOTo1k
 Jjmk9Maeo0lfi7HU1gm+LLfm3O0mTrb1dCOi+bpjCCgBO07umIkyIxn4/ w==;
IronPort-SDR: jx8R4n7NQdWSKr2X6+gytRX1tPsVZGmB8fdV/xd/FIq3C2unjLf5jiC0KhC/zyp4fPkSGXbryf
 ilZRgVVZOLvPMStJVlS8R7EE7nu9GgmyN/ueUzL4PQH3Xwb+NflofrVJuJhLY7ECXoUad5BbPE
 MuOu/UyIRnINZU3x0F37SuifZmJD5sWooTOcMHMByAA8GKmHxDqqEx2ueRYM00vSWPmTEToV2w
 5F04EllSrjGjPFjknoq4wbqw2YdmTobRuzo1HfnU/Wzr10JzOjxwjS1FP7aVfOd1Jotn3VU+AJ
 lpE=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; d="scan'208";a="122755665"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 02:13:46 +0800
IronPort-SDR: KDyleZwMQQfZgJB8VHdW7YxZSka6QRFyUnk0Td440Wod5sulmZRDoXvcDVRFpddEeva8z0VuWH
 RaQh4SL1Epy42sZiYNEenM3wy7x8hdy7pH2QFWKr8WrR1huFXctY6hweNODNnanUXnlkqdK4vX
 T4uySzHhrZe6+xMfGpC/2xDedb0o4QedQkx7anH+3doaBYHLDux92I2wE1S0D3nV3YWoWljaQE
 WpSACl9rTtPfNpHqlT2nhEjZocnD3MYqhjPcbbZ1AZ8/ymTCe4+y0W6M0ZKLYZlHoGMCBFzQHP
 Lvp8Le9lS/bC91gQDHdi/r2U
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2019 10:09:02 -0800
IronPort-SDR: f14FkUEyVanqSbFv9OP5AbRlcHqsxIXLKGw3zCJKfCgw4mE/7lFYhpMKFnMGebhuxRVCK4QrCd
 7AtvfP2nVmevdVb9DANW/GCMhWZgSW2UbiyQy+qKOWEuS5/Okm5enw5VCD7yK69Yor0WqKbnl0
 7YyFhVuv3DeCYH+iohH21ododAr9SjLQsKnun14gQb4VC3kxtmQjGStZdPhD7ZTy08jTkmXxnX
 jGH5y2hwiAvq4H1vXlsa8CH0SAbtreA+WMXU0ZEXFqbNSGy+Ct5k/rYwGhPSNO3FQri6oXzua4
 7V4=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2019 10:13:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: make ctrl-id configurable
Date: Sun,  3 Nov 2019 10:13:42 -0800
Message-Id: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191103_101352_095942_F412D1E0 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new target subsys attribute which allows user to
optionally specify target controller which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

When new attribute is not specified target will fall back to original
cntlid calculation method.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi Mark,

This patch allows user to set the contoller ID through configfs
which is target susbsy attribute.

Can you please take a look and provide feedback ? so that we can get
it to upstream ? I'm planning to send this on Sunday.

-Regards,
Chaitanya
---
 drivers/nvme/target/configfs.c | 23 +++++++++++++++++++++++
 drivers/nvme/target/core.c     | 23 +++++++++++++++--------
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..83391e54ed12 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,33 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_id_show(struct config_item *item,
+					     char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", subsys->id);
+}
+
+static ssize_t nvmet_subsys_attr_id_store(struct config_item *item,
+					  const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	down_write(&nvmet_config_sem);
+	/* should this be %x ? */
+	sscanf(page, "%hu\n", &subsys->id);
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_id);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_id,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..2396215a23c9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1267,13 +1267,18 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
-	ret = ida_simple_get(&cntlid_ida,
-			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
-			     GFP_KERNEL);
-	if (ret < 0) {
-		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
-		goto out_free_sqs;
-	}
+	if (!subsys->id) {
+		ret = ida_simple_get(&cntlid_ida,
+				NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+				GFP_KERNEL);
+		if (ret < 0) {
+			status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+			goto out_free_sqs;
+		}
+		ctrl->cntlid = ret;
+	} else
+		ret = subsys->id;
+
 	ctrl->cntlid = ret;
 
 	ctrl->ops = req->ops;
@@ -1330,7 +1335,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	if (!subsys->id)
+		ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
 	kfree(ctrl->sqs);
 	kfree(ctrl->cqs);
@@ -1416,6 +1422,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
+	subsys->id = 0;
 
 	kref_init(&subsys->ref);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..a3d3471bdf2d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -211,6 +211,7 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
+	u16			id;
 
 	struct list_head	ctrls;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
