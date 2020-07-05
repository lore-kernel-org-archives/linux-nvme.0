Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F26C433DF
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:58:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D204520737
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="28mhCLXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D204520737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FTNe+ruK2mKzMTdHVE5gAnNrlfY/0vtOlvTTidfVohA=; b=28mhCLXapxpjq5FvGdtc6kFFBG
	DoL5yvvmnoK6HdsPZVOWS9lDuLdH65yYoN4UwdgdNFb0MQei9PJFngx3p7nP8wBtBepqCzWTTP276
	EYFE3dDWfjWE28UYNjUHzYGL2OdAnAwdPiGVSuQotZy/SE5BjvwP53rv4YsUIyO2EKfZrpeTk2ZTt
	qhiAkV7Er15DDmky1Dw9pdK7ZyrkH79Q0ALVIe66Vt7Skf1Vkyney2do+0Y7tSvA/pSQ3/myNAQJ6
	KeywtDTqbnZ/fniUTSBnP7V4Tg9HOIR/wShF6fqPsRzzHSkaAy4t6JanxLDFAuueBmVR9rt9Jt/VU
	Wf1XoVKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrzXG-00065I-Hp; Sun, 05 Jul 2020 07:58:02 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrzXD-00064j-Ap
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 07:58:00 +0000
Received: by mail-pl1-f194.google.com with SMTP id f2so14151566plr.8
 for <linux-nvme@lists.infradead.org>; Sun, 05 Jul 2020 00:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+XE4ct26KIAbZsS18R5j2LQbo8K53BdOKxvf4yyxVVI=;
 b=BTIrg1MLdg4kZMYLIL5RSHNWyaYHh0W3rc4uQ4ORQwXwgkR0dA4LY/Y8LSeBfmuNvm
 rtcBZzXXigUErq/KjqHluQOhN29tpSkam3FUzJ+6I1ESSWiKtWA3RSQ7t3dHu1UMPDC6
 Jcs9QpjrJTA4dvuo6sXHExRwXA/miDomtgK8b6WnXYejnaTkpta6V9LI7qsIG5KAlDLu
 A2royhtiG7tNbQ+ep9g8Wz/saO2X6ALkNgmyl325VYdTVgPyKX8CdnZrowyMBpw1lbwA
 eQgm2jsjlmoG+g58Ho2ygCyhOywQf5xJbpWdTUzklR7ezLmGswy3cgtxplU39g5q43Tb
 90sg==
X-Gm-Message-State: AOAM5300mQwHrk+L+arG2S45AMSkkKSoHMcDAB1zyhLtIc6L9MbNXTx3
 ohvuXt3vUcNw5C5LkN5xA81cVAVr
X-Google-Smtp-Source: ABdhPJzbeFlwDa05mw72JQ4db9A2tA+qLFabZrgZT5Q7bvAKyrYUhoqqgubiAi6+l/o7dXHT+01itw==
X-Received: by 2002:a17:90b:11d8:: with SMTP id
 gv24mr28496388pjb.131.1593935877688; 
 Sun, 05 Jul 2020 00:57:57 -0700 (PDT)
Received: from localhost.localdomain (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id m17sm15157650pfo.182.2020.07.05.00.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 00:57:56 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs
Date: Sun,  5 Jul 2020 00:57:55 -0700
Message-Id: <20200705075755.506069-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_035759_380569_F448CD20 
X-CRM114-Status: GOOD (  13.37  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is useful information, and moreover its it's useful to
be able to alter these parameters per controller after it
has been established.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2f1de986579..509bf4e1d423 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3534,6 +3534,68 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (ctrl->opts->max_reconnects == -1)
+		return sprintf(buf, "off\n");
+	else
+		return sprintf(buf, "%d\n",
+			opts->max_reconnects * opts->reconnect_delay);
+}
+
+static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ctrl_loss_tmo, err;
+
+	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
+	if (err)
+		return -EINVAL;
+	else if (ctrl_loss_tmo < 0)
+		opts->max_reconnects = -1;
+	else
+		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
+						opts->reconnect_delay);
+	return count;
+}
+DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
+
+static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->reconnect_delay == -1)
+		return sprintf(buf, "off\n");
+	else
+		return sprintf(buf, "%d\n", ctrl->opts->reconnect_delay);
+}
+
+static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned long v;
+	int err;
+
+	err = kstrtoul(buf, 10, &v);
+	if (err || v > UINT_MAX)
+		return -EINVAL;
+
+	ctrl->opts->reconnect_delay = v;
+
+	return count;
+}
+DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
+	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3551,6 +3613,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_sqsize.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
+	&dev_attr_ctrl_loss_tmo.attr,
+	&dev_attr_reconnect_delay.attr,
 	NULL
 };
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
