Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF6C433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:54:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21A822D71
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21A822D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYuA9G6HSna6omGeDUnbnIt6vf6/Ak4EsTjHXDm3hHM=; b=2anwtaBNwzdHowUmrDmNTQ9RwU
	UeYJA0p7JGBQeTlEH4gto8Xr+8Sx72CcXffiahCMogPIpd9ph6gpedVh5wPJVq/5NuVLhquLPZPTf
	I9Fqy62DvhjCe+S58WQx6fggpJnQOHX0lj88ayLQ4fcDsW3YVXRP5OJV0VpL1oxpbskrlMBW6xTsU
	SnVavCc5zuXW/iIk8EgeYZnRTG+cLm+UGniOMQrYK+GDRpyDS0Y2Du+K8ky6RD39U5cosvzq0V4sG
	UR6VNgXeNJWmONYFy36sxMxhji/PlY7y7KP1iALieYTiBCpYrE3GOD3wZmFFBcUQNue73RJHy720h
	tB/oV91g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxNJZ-0007zF-Pr; Thu, 07 Jan 2021 04:54:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxNJX-0007yH-Jn
 for linux-nvme@merlin.infradead.org; Thu, 07 Jan 2021 04:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=U7aq9v/Gg4VqNLUxHx4k74hcMsNYVUlfBzpqbW3eMFk=; b=ZqOBqdTG3SW++ni+Xk0TWgpB6A
 ISZTitrMu74aFmu6eeV9BnkqI7ssssOhGlOLiI9SNxT6MPwPcZN9/lBm3hBb53M9Knzl4+pVNYVJX
 3drAJRug5qn9+Erufo1Gs+L4oUbPLwaMJUjl/5JAQH/XzQr7b+gzHRX8zqKElfsP85TjaNtTLjGem
 rSXTSTyiY9ctquOJa9dsWfESxMJONsvjzsVwwNB18xabnwG386PXtmv3zfy5XjmH1qOlfoRElrGd8
 M0z8SKDxNswBwlbmOypaQURRsluQoNci2vLyQJqKlwTym+zsAQxTWGciKEV0MLriNzaJhMsdl1A/Z
 eoKV5gow==;
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1kxNIr-0032qw-Oa
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 04:54:02 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id E714E82CF7;
 Wed,  6 Jan 2021 20:53:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E714E82CF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1609995201;
 bh=IY5AZBkAuG4FpPodP70+HurCIDI/lH6gVwDnfMqfS9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F88VrBKA1qYd11uacauQQlrsyxdjzgoE8KcHpB8aZu6vR/RxGvNvnbbxVsSvmxxop
 Be2RQTCAQ9fTicUDAacc96DyBOvHIxJYkeEU0wUBD0Ag9/9So1lyq+iQFYD4X6f/L1
 FhFWdTpg3pUXq3lbG9mjrXFYos5TprmfZif6EIQs=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Subject: [PATCH v7 03/16] nvme: Added a newsysfs attribute appid_store
Date: Thu,  7 Jan 2021 03:30:17 +0530
Message-Id: <1609970430-19084-4-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_045402_956827_35546126 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: Muneendra <muneendra.kumar@broadcom.com>, jsmart2021@gmail.com,
 mkumar@redhat.com, emilne@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Added a new sysfs attribute appid_store under
/sys/class/fc/fc_udev_device/*

With this new interface the user can set the application identfier
in  the blkcg associted with cgroup id.

Once the application identifer has set with this interface it allows
identification of traffic sources at an individual cgroup based
Applications (ex:virtual machine (VM))level in both host and
fabric infrastructure(FC).

Below is the interface provided to set the app_id

echo "<cgroupid>:<appid>" >> /sys/class/fc/fc_udev_device/appid_store
echo "457E:100000109b521d27" >> /sys/class/fc/fc_udev_device/appid_store

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v7:
No change

v6:
No change

v5:
Replaced APPID_LEN with FC_APPID_LEN

v4:
No change

v3:
Replaced blkcg_set_app_identifier function with blkcg_set_fc_appid

v2:
New Patch
---
 drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3c002bdcace3..ed689ba773b1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -9,7 +9,7 @@
 #include <uapi/scsi/fc/fc_els.h>
 #include <linux/delay.h>
 #include <linux/overflow.h>
-
+#include <linux/blk-cgroup.h>
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-fc-driver.h>
@@ -3821,10 +3821,81 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 
 	return count;
 }
+
+/*parse the Cgroup id from a buf and returns the length of cgrpid*/
+static int fc_parse_cgrpid(const char *buf, u64 *id)
+{
+	char cgrp_id[16+1];
+	int cgrpid_len, j;
+
+	memset(cgrp_id, 0x0, sizeof(cgrp_id));
+	for (cgrpid_len = 0, j = 0; cgrpid_len < 17; cgrpid_len++) {
+		if (buf[cgrpid_len] != ':')
+			cgrp_id[cgrpid_len] = buf[cgrpid_len];
+		else {
+			j = 1;
+			break;
+		}
+	}
+	if (!j)
+		return -EINVAL;
+	if (kstrtou64(cgrp_id, 16, id) < 0)
+		return -EINVAL;
+	return cgrpid_len;
+}
+
+/*
+ * fc_update_appid :parses and updates the appid in the blkcg associated with
+ * cgroupid.
+ * @buf: buf contains both cgrpid and appid info
+ * @count: size of the buffer
+ */
+static int fc_update_appid(const char *buf, size_t count)
+{
+	u64 cgrp_id;
+	int appid_len = 0;
+	int cgrpid_len = 0;
+	char app_id[FC_APPID_LEN];
+	int ret = 0;
+
+	if (buf[count-1] == '\n')
+		count--;
+
+	if ((count > (16+1+FC_APPID_LEN)) || (!strchr(buf, ':')))
+		return -EINVAL;
+
+	cgrpid_len = fc_parse_cgrpid(buf, &cgrp_id);
+	if (cgrpid_len < 0)
+		return -EINVAL;
+	/*appid len is count - cgrpid_len -1 (: + \n) */
+	appid_len = count - cgrpid_len - 1;
+	if (appid_len > FC_APPID_LEN)
+		return -EINVAL;
+
+	memset(app_id, 0x0, sizeof(app_id));
+	memcpy(app_id, &buf[cgrpid_len+1], appid_len);
+	ret = blkcg_set_fc_appid(app_id, cgrp_id, sizeof(app_id));
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+static ssize_t fc_appid_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret  = 0;
+
+	ret = fc_update_appid(buf, count);
+	if (ret < 0)
+		return -EINVAL;
+	return count;
+}
 static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
+static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 
 static struct attribute *nvme_fc_attrs[] = {
 	&dev_attr_nvme_discovery.attr,
+	&dev_attr_appid_store.attr,
 	NULL
 };
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
