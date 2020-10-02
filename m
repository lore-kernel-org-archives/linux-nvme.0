Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CCC4727E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5098F206CA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 02:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fOF1J57b";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="McpLe4Zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5098F206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fmVstIv9TRdAA2jyQkbF/jLzmIJIMwrO2xMTyx6ECtU=; b=fOF1J57b0M8xjyCe+hFvcEeOB
	/5Sj7AJzx6Zaz4X/oHzdOFyra5EogwTfN8EfEcaWrdYeSXKlstoku6TMP/zDpAcEQdHneqIFDLf2A
	7x1pI6IWCKRms2n7kQ13v5DjNEFfAI1lGlBBuWCOLW0diUPcBY0AcLxHObmedlEenuSV1EcTyt0K5
	aGAS2iR/EiOPMgyyuJOahlkA9I5fc31tXFjiqH5P0iiTQkH1PZEdG3GaCB2/5aFKZeQ6DFpHSiQ+u
	uAEY5eSUr4SLH7Ni1BbEk7cCTzfMOWW08xwoVOn8WxmrW43SG7IZHtNgiI9rL+eRLHAji0rQ4aruY
	LAwsAIMRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOBFt-0004uF-I9; Fri, 02 Oct 2020 02:57:09 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOBFp-0004te-Rv
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 02:57:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601608533; x=1633144533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yM4lEu5jD6VBXHwXf+Z+MBwwjNYx2kI1tHl0Cv03kA0=;
 b=McpLe4Zt+6/eQCns4lMWrCop8d+HNr9sdR889CcXgbyTSFOg2tRWYyw7
 McX8XbPDopGgTFLTYwLu2WSJCB8TAdyh7IyLyLxOM/aAq/c/wKX/W7kjS
 xc6o0F4V8KiLgKO4AHsO07ZgUN6dfmYex45i36Nh8EjWQuaEWevqAp7If
 d5l5e7qYjKrBFHRfsziTMsdx0VHEf9eu5xaxtcYdGnnjWRLrslmq7Bgtq
 oy0+0ZQHWA5r5o6L0ZIn7tqz6FcKQII7/vier/AeQ9VsrbbAhGUMFlnT2
 l0kRarVHEIY8R9vZfmQJ7v02IWQxl06rZH4QHW8J6hnosfpzsfu7BgsgH Q==;
IronPort-SDR: 9gjnyMjM27Z12oYcISoqPqgxoKAq3cJtj3o62MhEOn21J8tuXtz58V7WXAuS6GBKWVcf51tyTk
 VAd8b5dzzqiazPtCxCNS3TG/j+MNGFKbB00d3WnvFKbGXu4fd1LQqd8YNfJUCB7NesGnxtHn3L
 rw6qhMfm25Q9Ob0qTVYlk3rMFRGSNe5erot70gcWfnKo4sufMYX1A4z/yBws3tgClA+sJfEzFM
 mSPLvchhENNHULBBBGjYbzV6Z2i1jpfFBM5S4cIJ19PF4L3mPW90KYlr23R+SR51P2UPWFddta
 qn0=
X-IronPort-AV: E=Sophos;i="5.77,326,1596470400"; d="scan'208";a="252290679"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 11:15:30 +0800
IronPort-SDR: wRlgaiTWMMZlOiJ9/NB2lTwQt65nJfOxt6sKBY1c6LnXOr7B+BdiH4+mqW7E7864Twderwy+uS
 dYrmc6P2zFbQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 19:43:00 -0700
IronPort-SDR: dJ2LJ1xPp927sgmeOchHfv1tYpny1JkI3zBUrmmrlw6D8dBZgaz1AN0Iyuwkf8y9hXmsSi2+3F
 Gwea/QYZvs3A==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 19:57:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/4] nvmet: allow user to set the ns readonly
Date: Thu,  1 Oct 2020 19:56:47 -0700
Message-Id: <20201002025649.30724-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
References: <20201002025649.30724-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_225706_015580_4C5A626B 
X-CRM114-Status: GOOD (  18.87  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

User may want to export readonly ns to host in order to export
read-only snapshots. Right now we don't have configfs attribute to
allow user to mark readonly & export ns.

Add a configfs attribute "write_protect" such that user can set the ns
and export ns readonly when it is not enabled.

Also, when user is setting the ns write protected from configfs we set
ns write protect state to NVME_NS_WRITE_PROTECT_PERMANENT and don't
allow user to change the value for the ns-write-protect feature.

We also update the id->nwpc to indicate the support for namespace
write protect permanent state. For RPMB clear the bit 1 of the field
Namesapce Write Protection Authentication Control to indicate Set
Features command which attenpts to set the namespace write protection
state to permanent write protect will fail.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c |  9 ++++++++-
 drivers/nvme/target/configfs.c  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 263cfff6ddd4..44ff847db83e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -457,7 +457,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->psd[0].entry_lat = cpu_to_le32(0x10);
 	id->psd[0].exit_lat = cpu_to_le32(0x4);
 
-	id->nwpc = 1 << 0; /* write protect and no write protect */
+	/* write protect permanent, write protect and no write protect */
+	id->nwpc = 1 << 2 | 1 << 0;
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
@@ -711,6 +712,11 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	}
 
 	mutex_lock(&subsys->lock);
+	if (req->ns->write_protect == NVME_NS_WRITE_PROTECT_PERMANENT) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		goto out;
+	}
+
 	switch (write_protect) {
 	case NVME_NS_WRITE_PROTECT:
 		status = nvmet_write_protect_flush_sync(req);
@@ -729,6 +735,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 
 	if (!status)
 		nvmet_ns_changed(subsys, req->ns->nsid);
+out:
 	mutex_unlock(&subsys->lock);
 	return status;
 }
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..5d8ee00b8fd0 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -595,6 +595,38 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 
 CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
 
+static ssize_t nvmet_ns_write_protect_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->write_protect);
+}
+
+static ssize_t nvmet_ns_write_protect_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting write_protect value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	if (val)
+		ns->write_protect = NVME_NS_WRITE_PROTECT_PERMANENT;
+	else
+		ns->write_protect = NVME_NS_NO_WRITE_PROTECT;
+
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, write_protect);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -603,6 +635,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
+	&nvmet_ns_attr_write_protect,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
