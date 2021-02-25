Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E2C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 11:05:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12C864EF1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 11:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12C864EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YdSlamJy9RSacwvPAZ6C83jLdn2JdnCwr/SpSG9/qQg=; b=JXKrrA/QCKR/bj2jTwA2JkPr6
	dLlnjWFiipaTP4sB+vJRq4TPVKevAODPM4v2EGZ7uW4EJD1NykfPuNJR49/rIFSTqITWbuY658WDj
	9bfeSlUAtUwU/sY/LYOC0M/fy4JPnI31AfNXn4SUdoklRJ100viO0FMJo7B0LgRfU0wkMAuAdhpzA
	7NYsVeBx6WprqVERHo4Gar/Z5/v3udT1pV36uFU/YxcNrJmKClPNEvZ1pjWRg8Sjo4z4MRC1hFUcS
	k2GIP7TKih6OoxzezadBODcFWLNMPgdu4MMJp06RpqUh92rObxXXVc8x4MfRgHNRDVOTGq4i4Goli
	ZbjsfqLtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFESk-0007MH-AQ; Thu, 25 Feb 2021 11:05:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFESf-0007KX-IH
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 11:05:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 651ACADDD;
 Thu, 25 Feb 2021 11:05:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] nvme: add 'fast_io_fail_tmo' controller sysfs attribute
Date: Thu, 25 Feb 2021 12:05:33 +0100
Message-Id: <20210225110534.75710-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225110534.75710-1-hare@suse.de>
References: <20210225110534.75710-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_060537_751839_20D442EB 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a 'fast_io_fail_tmo' controller sysfs attribute to make the
setting configurable during runtime.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4de6a3a13575..ba639049e385 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3658,6 +3658,37 @@ static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
 static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
 	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
 
+static ssize_t nvme_fast_io_fail_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (opts->fast_io_fail_tmo == -1)
+		return sprintf(buf, "off\n");
+	return sprintf(buf, "%d\n", opts->fast_io_fail_tmo);
+}
+
+static ssize_t nvme_fast_io_fail_tmo_store(struct device *dev,
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
+	else if (fast_io_fail_tmo < 0)
+		opts->fast_io_fail_tmo = -1;
+	else
+		opts->fast_io_fail_tmo = fast_io_fail_tmo;
+	return count;
+}
+static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
+	nvme_fast_io_fail_tmo_show, nvme_fast_io_fail_tmo_store);
+
 static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -3703,6 +3734,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
+	&dev_attr_fast_io_fail_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
 	NULL
 };
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
