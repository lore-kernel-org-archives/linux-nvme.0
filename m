Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78DC55178
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:28:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6267520719
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gz3HO0bp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ep9aooaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6267520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=scA0NShcKBUFM4hIwB2gUQsHUU8aD6lChlvQWDMeZy4=; b=Gz3HO0bpl+rCzB7SrRq4X3On8
	12MzArm6wE+6y1jz8lYxLHiHIXteF/PgC4kgq7pnOev21gaIU5r69kTxKXFifakk3Sw6xGG1y8rQB
	1PB23JjMYeaKzVDowvFLUNa8BX5F3hYqtj8PmnRV6z09Gin+pj6nfwquw9pzIOPYwVNTYo2mDDA4L
	LeSqbFae8IbPrCBcBmFLefN0LBwvkTo1sikIEJfrwuLGj47dlbUDAiNGGxDgDOOJCMXsBTklPjdbc
	ruCaFuP5U8GkwNk1MrRRcvpKjR+l4OCeIZqOjxit8NsdoZrHDafEhcuIAS3QPq1ewq8QfB8mUTQRC
	kFoaKAM4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaogb-00006v-7E; Thu, 05 Nov 2020 23:28:57 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaogY-000060-Rh
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 23:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604619024; x=1636155024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K4b3KW+d9+bXo02g8rZR2OatOUglBSsSsh9xtu6xmWg=;
 b=Ep9aooaZxDwQNmIoo/NlnYJeXOTsJlKmlnizgPwVyj4/YBHWd+GXWilj
 /dXM6TTZUMmRIVjClEmvY7XZKAXFa6da3L29KOHbj+it62pbiaVkplAFm
 OoYe7HT73wT8aDp9vqszjbx4E4LyZkASi+BQpUQNR1T+CwaF9fmjOH6Mx
 lIUIpqiVZ5PyvEeB8uKeKUpn8tWlKvPA+AGs5iPxrHy6MZ87ySoNOofO0
 yTj2d6/Ekgg0QfVAM7qoc4mtZvGWa9DZVHT01JT19/UUhsLxlY912kxc8
 xEZkbK7w7hHf8zm+oGOMwqAp9KbaDIx/H3jcqkOAPYcgdxlBOWuI37mre g==;
IronPort-SDR: AiRzDVP2KBPxE/vvCbLm4nVKBnfcj9D8Hj8ta7xUTOTE27EvH1ii4CPzeU94ngbjJnQGll1E1O
 t8SIe4yR2sLE6Bidmcy5UUPZ+wRXc4EW2lJzeUBaTVrXfSX1gEgXkOAnQ13G3sRlUyFO7J1+NY
 VSiXUXTWhxuzCe6Gu6J18OriK7hUCxUD1B1hPE/qqmXhKD8q3c8jY9swi8jRZsSgP2rrV2nywn
 CVZQ0pvH/ZMyd0erJ92bgeek3P44/3UcrV7fIgxB7Lx0p45fT2UaJN8j0g5W+hxGruupsDkqWj
 bQ0=
X-IronPort-AV: E=Sophos;i="5.77,454,1596470400"; d="scan'208";a="255523277"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 07:30:22 +0800
IronPort-SDR: rOMZ7U1TCsDI29wXFohC9QSEw29RguWrEJ3lkMnPP2eTmIsXOVyNWWx6p/XxOSyLTt86HuryIo
 sWYcSi6qsp89OkXjCoNoTEdKX5HZR9tzm4iCNHxY5A4Z69KmcB6V9CgidyP+cCEsLxM0ZbwX8V
 GXWfVJn23yfXiaSGG9k1AjCuw5ZdrIGAeMSQ25/087hK1+fWIL8RFpVzv/k54TyBEpJUh/3Rdm
 rUKCEWyoLbgNbsQhV8+mdz+xK2HcZp/8HhJATyD3wPesfx4mdc48l0HAbdnUUCYE15V/KYu315
 jpnV+LMB4NVf0vhbVBoGXsVp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:13:49 -0800
IronPort-SDR: /nj90dFHr0so9CwPdSe+2UFCnkrjiV/zy2I2FwurXEN14oZN1dYdkfQRxNnUPzRFK1II4cyk4Q
 76wcA9MAWMmx62ETNNDnhXLsSqvsHF4zZnehGhU2ZOqwxwb1n8oumQR+iTAL/nV0EMKWNv0aoI
 sIB0100Vmxe3ds4iDZl/lXPTs9CKs/ARgml2joNxzqUrSWXFrFrAm0W9BsnYuqiTwJ+AYugOyO
 EkyMqj4/DByDXoxzlRRj/DUeSWyOix0fsM93E4Wq68z7E+1XNASN5ObaDuEkAdNIuivFf/yDrj
 Tdw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2020 15:28:53 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V7 2/4] nvmet: add passthru admin timeout value attr
Date: Thu,  5 Nov 2020 15:28:30 -0800
Message-Id: <20201105232832.21216-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
References: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_182855_051773_36E221D0 
X-CRM114-Status: GOOD (  17.45  )
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

NVMeOF controller in the passsthru mode is capable of handling wide set
of admin commands including vender specific passhtru admin comands.

The vendor specific admin commands are used to read the large drive
logs and can take longer than default NVMe commands, i.e. for
passthru requests the timeout value may differ from the passthru
controller's default timeout values (nvme-core:admin_timeout).

Add a configfs attribute so that user can set the admin timeout values.
In case if this configfs value is not set nvme_alloc_request() will set
the ADMIN_TIMEOUT value when request queuedata is NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 24 ++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..67e231e3df2b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -736,9 +736,33 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, enable);
 
+static ssize_t nvmet_passthru_admin_timeout_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->admin_timeout);
+}
+
+static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int admin_timeout;
+	int ret = 0;
+
+	if (kstrtouint(page, 0, &admin_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->admin_timeout = admin_timeout;
+out:
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
+	&nvmet_passthru_attr_admin_timeout,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..a0c80e5179a2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -249,6 +249,7 @@ struct nvmet_subsys {
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
+	unsigned int		admin_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8ee94f056898..ef07b447d136 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -227,6 +227,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
+	unsigned int timeout;
 	u32 effects;
 	u16 status;
 	int ret;
@@ -242,6 +243,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		}
 
 		q = ns->queue;
+	} else {
+		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
 
 	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY);
@@ -250,6 +253,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
+	rq->timeout = timeout ? timeout : rq->timeout;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
