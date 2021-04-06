Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A73C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:00:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A37613A3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A37613A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hn6RGDdzq/QHj7TVxj72xp/gSlHVanyYK7KQ8+3TlYQ=; b=Yl7K2xwid4ffMhL6Vv08lVLvM8
	vSca8MPb2ddNd+anH0QLzIlVOyrzZKRu2z5DuzO/82KzJVgiqEyVlqi/Z6dYA1RVdsjsnqjd7BA1U
	18qdoi6yz2RFN6gSYmi7KHHr8so4S7pjO2eDOIECwBWX4mO9li/Ac/Aav3e5CwjyzZzY7jYk3qq4X
	btOIds+MU+MJQLpyKWOFP++LucoTx/x3XNVBjHOMi7NJmQSjDYTSCLdEm/glO2dnTSdDgWDzaKYg9
	otkVSJDbrdnEUyOSYXSCbhoqVDXbWsvlGFVzmIgpLsp2CcdYINZYxTc1q7Z1B3OcAAP8Gg/qEEhsW
	y0FfnObA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU1EV-0049v7-Qp; Wed, 07 Apr 2021 06:00:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1EQ-0049uS-Me
 for linux-nvme@desiato.infradead.org; Wed, 07 Apr 2021 06:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Xtei7AcH32LL4hEWVnCnqanpf4rlVpleKW63FrYDEVo=; b=ibksnC2t2UKD0+0xjk9FQx5DyB
 EO3/avn5IdT8/nYWgbQYL+EXkL53IwfjiccQN9RGcsleT1BCjOW9RadEbDAqp8Mohh/1UWNybkmEm
 rTQsAJLl09oYsWCAAIIb5slzYyva1KZBQqc8KmQHyQ69XEjhWWqVBjrrBM0Fr3Epu9gWXWoYyn7y4
 84TBCEuEF7bjYUcjprEQ/VhSVnKWol6amCTg/JSgNEEi3WPf/IFoIbKSH+cdI5r5NohxchHslU8kR
 +UUj0WNvSjB4q/NEFxCV/3DmdC++hbpksNa0NEMjZ+vujNp5cVXjpd0qUObUtxBm0uecNd583p+vN
 CP0cWM5w==;
Received: from saphodev.broadcom.com ([192.19.232.172]
 helo=relay.smtp-ext.broadcom.com)
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1Dg-00DyT6-8O
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 05:59:44 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 2768724327;
 Tue,  6 Apr 2021 22:59:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2768724327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1617775145;
 bh=eqfrgpU+xADC8MjGPT1dnR7HyFlz7pQOQegKFR7A5Jk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jJvIH1SdN0RnNY36/Uv87wjkO+3b9rP1Fc6nT+TlLw2Yd4vLKQieptVTzeRc/PIs+
 A3wy1pAW2cZTq0OEabpes4CWpKufeBQu0NXvvmd14QjLv0/+RY+Dd0s4wLL5TDxc3l
 VJrVkLS6kHtb+Fi0CLIfokSnltr9oGvSMXZgXsuw=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v9 03/13] nvme: Added a newsysfs attribute appid_store
Date: Wed,  7 Apr 2021 04:36:27 +0530
Message-Id: <1617750397-26466-4-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_065930_014564_AB024D45 
X-CRM114-Status: GOOD (  17.44  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v9:
No change

v8:
No change

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
index 20dadd86e981..f0ce876700d6 100644
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
@@ -3782,10 +3782,81 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 
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
