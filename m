Return-Path: <SRS0=8Upu=34=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E75C2BA83
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2020 01:14:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DE72082E
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2020 01:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBxbCMFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DE72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WEx3rcIVJDJekvOnC4B6d6IiiCoXMo7IqPR6iEIRNmI=; b=GBxbCMFdQGdpOL
	It6NTJEvPjmJlyv6jQngHZ2yWv9ZZmY7J9cIbYL3zrPZD3yfdcYrhO4G4KafQ4KJXbW0V+CY/xIbc
	NRrZ8/SHG9M2rtxGW1rsvUhJmmXVE9hNX9R55MnCpe78JXX9+Ngu/eIOtBeY62lLiEmnlN9jD3GP5
	j6b98k/om64A507xGU9jKc18VGwet8LH7Vip+JQ9nE0Pf60EoTyHGb2zKq1s0Nj17KjUowXZ2xfcn
	3q6okXwGOd8Gdax9APCM1IBEfoj+cseBGXRURZRTf2JlGPgDdKKQ0lTdIHIOjakzzaYmmdLHSf7ni
	Lv3kz5DSMwsGDYrRHPcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j0Eh5-0004QH-Dj; Sat, 08 Feb 2020 01:13:59 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j0Eh1-0004MC-1y; Sat, 08 Feb 2020 01:13:55 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] nvme: expose hostid via sysfs for fabrics controllers
Date: Fri,  7 Feb 2020 17:13:54 -0800
Message-Id: <20200208011354.20889-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208011354.20889-1-sagi@grimberg.me>
References: <20200208011354.20889-1-sagi@grimberg.me>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We allow userspace to connect with a custom hostid which
is useful for certain use-cases. however there is is no way
to tell what is the hostid used to connect to a given controller.

Expose this so userspace can correlate controllers based on hostid.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- fix changelog
 drivers/nvme/host/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 29a4f14360fa..c2aba7d700ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3252,6 +3252,16 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
 }
 static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
 
+static ssize_t nvme_sysfs_show_hostid(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%pU\n", &ctrl->opts->host->id);
+}
+static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
+
 static ssize_t nvme_sysfs_show_address(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -3278,6 +3288,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
 	&dev_attr_hostnqn.attr,
+	&dev_attr_hostid.attr,
 	NULL
 };
 
@@ -3293,6 +3304,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_hostnqn.attr && (!ctrl->opts))
 		return 0;
+	if (a == &dev_attr_hostid.attr && (!ctrl->opts))
+		return 0;
 
 	return a->mode;
 }
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
