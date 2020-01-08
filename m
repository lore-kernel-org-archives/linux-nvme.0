Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1484CC282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 17:42:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE53E20692
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mD4Aok6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE53E20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MfAs49nq8keMHLAc30Ibbu63zEnivuEhqZiKue4nvg8=; b=mD4Aok6aQZbYgP
	8ihXlVSu08haQLrn6GMM4tv3ibJcyI+kFYkiUAS7wAGw5FouGu4SqYY8+LYHQToMauoIyiN8AztH8
	/kAYeqnLRu9nZPyQfW77ckbmNHJiZ0VgGJs3JY4ERiJa3zwcPiufrGZ7bEZ0qa1EdPqlyH3RZjVAS
	CwazbfEKfL4p7R4ibkQBbP7pcBpYVqcHgaHrmOxuoAF8yABGC3tWukCIH/uhLLLdRdiY4eahv1q9B
	TbucSeYt/WVVRsm+HuQVuh02/K9eHdX+1run0zz6VWvBmn28CNaNS/Nq6F7mzi96y/0ATfEBXxrGG
	ElgjNS9M8JmOpo/QIwIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipFLN-0003Hd-LB; Wed, 08 Jan 2020 17:42:09 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipFK1-0002Cd-6x
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 17:40:49 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1ipFJt-0004hf-AR; Wed, 08 Jan 2020 10:40:44 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ipFJr-0000ud-Eo; Wed, 08 Jan 2020 10:40:35 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Wed,  8 Jan 2020 10:40:30 -0700
Message-Id: <20200108174030.3430-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108174030.3430-1-logang@deltatee.com>
References: <20200108174030.3430-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v10 9/9] nvmet-configfs: Introduce passthru configfs interface
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_094045_381585_70708ACC 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When CONFIG_NVME_TARGET_PASSTHRU as 'passthru' directory will
be added to each subsystem. The directory is similar to a namespace
and has two attributes: device_path and enable. The user must set the
path to the nvme controller's char device and write '1' to enable the
subsystem to use passthru.

Any given subsystem is prevented from enabling both a regular namespace
and the passthru device. If one is enabled, enabling the other will
produce an error.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 99 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 354d43fab8db..1ae3f87f611d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -615,6 +615,103 @@ static const struct config_item_type nvmet_namespaces_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+
+static ssize_t nvmet_passthru_device_path_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->passthru_ctrl_path);
+}
+
+static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	size_t len;
+	int ret;
+
+	mutex_lock(&subsys->lock);
+
+	ret = -EBUSY;
+	if (subsys->passthru_ctrl)
+		goto out_unlock;
+
+	ret = -EINVAL;
+	len = strcspn(page, "\n");
+	if (!len)
+		goto out_unlock;
+
+	kfree(subsys->passthru_ctrl_path);
+	ret = -ENOMEM;
+	subsys->passthru_ctrl_path = kstrndup(page, len, GFP_KERNEL);
+	if (!subsys->passthru_ctrl_path)
+		goto out_unlock;
+
+	mutex_unlock(&subsys->lock);
+
+	return count;
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+CONFIGFS_ATTR(nvmet_passthru_, device_path);
+
+static ssize_t nvmet_passthru_enable_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+
+	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
+}
+
+static ssize_t nvmet_passthru_enable_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	bool enable;
+	int ret = 0;
+
+	if (strtobool(page, &enable))
+		return -EINVAL;
+
+	if (enable)
+		ret = nvmet_passthru_ctrl_enable(subsys);
+	else
+		nvmet_passthru_ctrl_disable(subsys);
+
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, enable);
+
+static struct configfs_attribute *nvmet_passthru_attrs[] = {
+	&nvmet_passthru_attr_device_path,
+	&nvmet_passthru_attr_enable,
+	NULL,
+};
+
+static const struct config_item_type nvmet_passthru_type = {
+	.ct_attrs		= nvmet_passthru_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
+{
+	config_group_init_type_name(&subsys->passthru_group,
+				    "passthru", &nvmet_passthru_type);
+	configfs_add_default_group(&subsys->passthru_group,
+				   &subsys->group);
+}
+
+#else /* CONFIG_NVME_TARGET_PASSTHRU */
+
+static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
+{
+}
+
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
 static int nvmet_port_subsys_allow_link(struct config_item *parent,
 		struct config_item *target)
 {
@@ -918,6 +1015,8 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 	configfs_add_default_group(&subsys->allowed_hosts_group,
 			&subsys->group);
 
+	nvmet_add_passthru_group(subsys);
+
 	return &subsys->group;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9e7d492aedbd..a6b29102a925 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -233,6 +233,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
+	struct config_group	passthru_group;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
