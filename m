Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E023C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C750061007
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C750061007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n17afm/XdROdImDUptoORUhjJHQPUluywX6AX9lAXRw=; b=kpXPHu3aJCFLA1lvArNTKmqUP
	wo2Fab1QXC4Dh6T4sXGqlEr9eZ22X12tZBHRzJ4b9oyJPWLK8yhWndqczdlMuTg8nfi9WCQex2nKD
	ljY4qnSBvXRiMfXLFovjsJazf0UVgz9NS3KAra2HI5NZXOmyRlJXUDSkx1BMiv7juOyWVY1mEKmYg
	gyAmthgY98wFEvpQMw6z3e7yIGcQ4LHxVViy1sZ0kmOSBGq9PLXlbNxBlF1cJBHzk6yd/6BuKG+AL
	zB8fjv7DFXylf9b1b8NkEPlJmZ1aPbz7eY89Q+aw2vL3lxgBAIVuCKwHxe4WA5I2w8HScvKOg0PFt
	Q9w0V55Aw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRu2C-0098Zy-Pk; Thu, 01 Apr 2021 09:54:40 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRu1t-0098Wn-Bd
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 09:54:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A70BDAF5B;
 Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "Ewan D . Milne" <emilne@redhat.com>,
 Himanshu Madhani <himanshu.madhaani@oracle.com>
Subject: [PATCH v2 3/3] nvme: Export fast_io_fail_tmo to sysfs
Date: Thu,  1 Apr 2021 11:54:12 +0200
Message-Id: <20210401095412.84254-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_105421_567857_3E6CE818 
X-CRM114-Status: GOOD (  13.90  )
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

Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
introduced fast_io_fail_tmo but didn't export the value to sysfs. The
value can be set during the 'nvme connect'. Export the timeout value
to user space via sysfs to allow runtime configuration.

Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhaani@oracle.com>
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2b4c5567209..11fca6459812 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3696,6 +3696,36 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
 	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
 
+static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->fast_io_fail_tmo == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
+}
+
+static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int fast_io_fail_tmo, err;
+
+	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
+	if (err)
+		return -EINVAL;
+
+	if (fast_io_fail_tmo < 0)
+		opts->fast_io_fail_tmo = -1;
+	else
+		opts->fast_io_fail_tmo = fast_io_fail_tmo;
+	return count;
+}
+static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
+	&dev_attr_fast_io_fail_tmo.attr,
 	NULL
 };
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
