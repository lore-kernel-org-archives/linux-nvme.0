Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F2BC432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 09:40:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8ECD20678
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KJpwMfbQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JlwvyvZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ECD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=402NLd41jk3iTiWIFx4kRg9ZQmmMOpPX1+h3MFX9nzQ=; b=KJpwMfbQOwAoHq
	ftuylEIQMXb6KH5y+2+V2QOycKrpuJBzkszCU0aYvPdBCVTaLcvmCdq/EUUVQGJyfnSwTk8Lc+Cap
	XzRI0S08+hICRrcENLMe3C4dujjFKGGUgl56wTQgwJwt4nYSGH80T2hG44ydEcfIkcyKFuWDrdXFu
	STTt3nqS8RY0kjWciRe7oIKGIOjpvkTmN02gSLhuxWBf0N0lDmgrSIXWqmPcsNV4eY0Krx//5UK5t
	OMJSOB2mYnneIWEoUEbO6/m2J2i+E0zfllIqEadQjrAhYKzjE2g8BRbaDH5ivk8hBEmLc2+tzlSkv
	Y7xp9x2YUesOChPgqIxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZtoc-0004iS-8x; Wed, 27 Nov 2019 09:40:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZtoN-0004Xa-UL
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 09:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574847641; x=1606383641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wXsOzqGLQPVXzdMf4UsJJcx1wfrmwDtItXTgiTMNCLE=;
 b=JlwvyvZd+zt8PZNmXxJx6uM98UlWJZwvnD6GvVO97bCL13qshnMW8EQo
 H2gTYUfNgyT1G1k3iEt53lqak1zq4xmxG2wb6cWQBYaFObzjYPOCGhe0a
 BucWX9yg0ScnGt89B3nL3sZLuItNNZfbfq+b78nwAp4Mb382WCS5JyCgs
 ZmuwrITV6srwfXY1jwxwIO7t46jaoCjHzKyKhzh8I0inql+Hx9J4iB17u
 YpCapykT1OGAvG8HmJTNkWVS4B4KerSXjxO20WexS9ncYe+jnN7QUHUld
 TNGhZU9MZbrvB08eHW2psadoN21cIB+x/AeCSBXn5OciUBuX7PumLhgJu w==;
IronPort-SDR: iDja7x66ywWqcBl0ZD7MYbZ5BPm0FOjfuacQp3KHVeyOqWG2Xxor5LPgTVlY8NdXN1Kj1VCqJJ
 YvESvTnd1awhjNbfTnnvsuHWBrajhQ7FjstasnkZpB+u0xpCasvqEl9/v9zuWR/r/42nso9nCX
 ktQqVBaxScKbt3YIZHZSf8nRN3hkLRIqIoMb57c8ugFkwffJVivdeVA57QS6AE6zs/dYLd5Mbc
 b4btqwnsEWRIBigXFIljrFHcnrC93RVULXlhuCcGHfuOtAkvkz0bVbsbBB8uhCu4Htiw6TbCN6
 I3Y=
X-IronPort-AV: E=Sophos;i="5.69,249,1571673600"; d="scan'208";a="124872966"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 17:40:40 +0800
IronPort-SDR: OEioWWDAXAXJ6uAQEs9yo8na9PclD5eK4103IyIjcGtVLOXjFiE7sdOqnFQkWX3aiz1dR7DNLm
 Y81+IKat6/mib/h0snGqkkTr858i4Uy6MeTdKphPmvS1bczywZ9ApwFon1UE8Wcmn3uTfvnFHn
 BJqRPuAiD8XNrWNjWM9+TY/XBXsYtVM5AGGkbAzCxd5isc18Dvo/cQm9VHwLjbfGYpaHcgWgHi
 vW6pycPQ9y/xdRWrZh9a8wdQACfWuC4ColkecR5RrKOFXmoSNdVo4AZeaJcKjEZca0lRzIZB+g
 414sa5fqgm6/V4CWLTQvEaOJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 01:35:38 -0800
IronPort-SDR: 1k/3NYkRLXJXwAsQzK7UUAXg+98B30JE6LtIF+EurDTJjAO2VJrs3h0ok+ypMxwNhWd84FqyEA
 bP/Deuc3oXjEe4r140J8ZiSdroKT41yV5IscK0ehC9fKLRSTcwGdUpK4Ueq7DC5j/V/7YPfemy
 FkH1lBUIdwtjoxFDjnbFghTekcP2oc1xXtwyt0+5h6zUWvPz8gxF7Oc6Pr26Q08E2C9R0oR4Nu
 McWJRrPuGfoBTICg0fDA6zUoRJO4SBj/opr+u9nZM4fsLFDuxntZaBam/v+GBOMfS4ZalHW/sU
 9V4=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2019 01:40:39 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/3] nvmet: make ctrl-id configurable
Date: Wed, 27 Nov 2019 01:40:32 -0800
Message-Id: <20191127094034.12334-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_014039_986536_033FCE09 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new target subsys attribute which allows user to
optionally specify target controller IDs which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

For example, when using a cluster setup with two nodes, with a dual
ported NVMe drive and exporting the drive from both the nodes,
The connection to the host fails due to the same controller ID and
results in the following error message:-

"nvme nvmeX: Duplicate cntlid XXX with nvmeX, rejecting"

With this patch now user can partition the controller IDs for each
subsystem by setting up the cntlid_min and cntlid_max. These values
will be used at the time of the controller ID creation. By partitioning
the ctrl-ids for each subsystem results in the unique ctrl-id space
which avoids the collision.

When new attribute is not specified target will fall back to original
cntlid calculation method.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V2:-

1. Reduce the size of the lock for sscanf for cntlid_min and cntlid_max.
2. Remove the common show and store function for cntlid.
3. Move cntlid_min and cntlid_max check into the store function. 
4. Update the patch description.
5. Move check for valid cntlid_[min|max] parameter into configfs
   respective store function.

Changes from V1:-

1. Add cntlid max and min configfs attributes.
2. Use simple if .. else statements instead of ternary operators.
---
 drivers/nvme/target/configfs.c | 72 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  5 ++-
 drivers/nvme/target/nvmet.h    |  2 +
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..772a74a7d969 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,82 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
+						 char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_min);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	int ret = -EINVAL;
+	u16 cntlid_min;
+
+	if (sscanf(page, "%hu\n", &cntlid_min) != 1)
+		return ret;
+
+	if (cntlid_min == 0) {
+		pr_info("specified cntlid_min = 0 is not allowed\n");
+		return ret;
+	}
+
+	down_write(&nvmet_config_sem);
+	if (cntlid_min >= to_subsys(item)->cntlid_max) {
+		pr_info("specified cntlid_min is >= current cntlid_max\n");
+		goto out;
+	}
+
+	ret = 0;
+	to_subsys(item)->cntlid_min = cntlid_min;
+out:
+	up_write(&nvmet_config_sem);
+
+	return ret ? ret : cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_min);
+
+static ssize_t nvmet_subsys_attr_cntlid_max_show(struct config_item *item,
+						 char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_max);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	int ret = -EINVAL;
+	u16 cntlid_max;
+
+	if (sscanf(page, "%hu\n", &cntlid_max) != 1)
+		return ret;
+
+	if (cntlid_max == 0) {
+		pr_info("specified cntlid_max = 0 is not allowed\n");
+		return ret;
+	}
+
+	down_write(&nvmet_config_sem);
+	if (cntlid_max <= to_subsys(item)->cntlid_min) {
+		pr_info("specified cntlid_max is <= current cntlid_min\n");
+		goto out;
+	}
+
+	ret = 0;
+	to_subsys(item)->cntlid_max = cntlid_max;
+out:
+	up_write(&nvmet_config_sem);
+
+	return ret ? ret : cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_cntlid_min,
+	&nvmet_subsys_attr_attr_cntlid_max,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..387628ec7e37 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1268,7 +1268,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_free_cqs;
 
 	ret = ida_simple_get(&cntlid_ida,
-			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
@@ -1416,7 +1416,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
-
+	subsys->cntlid_min = NVME_CNTLID_MIN;
+	subsys->cntlid_max = NVME_CNTLID_MAX;
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..6492d12e626a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -211,6 +211,8 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
+	u16			cntlid_min;
+	u16			cntlid_max;
 
 	struct list_head	ctrls;
 
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
