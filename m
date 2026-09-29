Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE51CA5FA1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJH478k/Fgk+EMgd6NmOYnleFDGhoCKzCZ8uc3TFKDM=; b=cQbxcUhghuFIpJRgFwY8FhOK1l
	xrQHzSemN7fP6qdG0oECUBlou1/IakiucI5zz11lR2lPur+5aaWoCaNqCEgtMDhHbIw07A1gWyptj
	knE5y9GNek5c7V63YJI06JDryCyLpmFzIf+mtbqNYm+k05Sy+iZUQKnRRyafJq4yH46HHqDllMbhN
	Z3d/OjUdyaWXh9N9UHfdgeaPIDoxMpM7B1yiFnGRVuoV50NM/pLIBBfe9wMj3QvRYDRDuTvuqKTFr
	DYal0ZtPYLEDMkW6k6ClL4vcHXzfAO709YmNUr6Rb5Uu6dflJ8pvYfDgXnlUFTpeEaIFtMkWyxqpr
	MNv53XXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBW0S-00000003P7H-2xUs;
	Tue, 29 Sep 2026 11:28:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBW0O-00000003P5u-3Ap7
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 11:28:18 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB6guH2785452;
	Tue, 29 Sep 2026 11:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JJH478k/Fgk+EMgd6
	NmOYnleFDGhoCKzCZ8uc3TFKDM=; b=haQDb6jv7MTZ72wjqmkI1XfytrPr+acWj
	FanqD42uYsRHAyDhRIywdXrVrZJNjLX/Du08FNAWr1FX5WIsjP5ZTDDRl4bEu+Y7
	I5vgs8mhhKg67F16MxyaGxd6ZrLO7zjgHF7ON2yCRWPpMqeM8yW1yHfVZJv9TQMl
	lz/ctiBGcdbgDwYU9LI5ybuqcH2onPuHUrVNEUuLGVqPevfZu9jjlIRZdwZ9iotA
	GKY+zVbx3zkfXrUZ1rBCkMk7ClrsCS9GJ9Eq5lokrd58s3ca/NIMnpHUkDAkErCo
	DFyYOgU6FwXfhkXglm/ErRqAt4/xKQFXx3zI1x2+9sDi3qvn4KoZw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe637y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:28:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlZ461617033;
	Tue, 29 Sep 2026 11:28:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw9k08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:28:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBS7ih45548014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:28:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E146C20043;
	Tue, 29 Sep 2026 11:28:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93FFE20040;
	Tue, 29 Sep 2026 11:28:03 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.28.159])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:28:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 1/2] nvmet: introduce struct nvmet_passthru
Date: Tue, 29 Sep 2026 16:56:47 +0530
Message-ID: <20260929112751.2985483-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929112751.2985483-1-nilay@linux.ibm.com>
References: <20260929112751.2985483-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abba0cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=6A6WY_OvTnx7BfoVsBcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX34ggQkjVhXxH
 AQ+3WYYVt926DLex5UwHsM7+TMi88cQRN1vDazTNYKohEcl5XJKZGiYeTgPbgSyU+V75757IZrn
 ouNxHJP649hV69y6lbVNBd3kjSBLIfg=
X-Proofpoint-ORIG-GUID: yuU4urlYPp4fiyUiaZPBP2Nd3Q6_ZReX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXxYc1Rrbt8lsI
 6ZBbS9Hb+8UQM6ZMW9komkdDWRppxELEa8NaDtbTlmgC8g5k2SPB2By0b+Zr27kfu6JU0AEgFwK
 6vGALDIGcwy7+dtJBXIAQYWTaS0P75lKEWz3WZBVqBrCSDXhY9wUjyEnNSu6NdwAxO8qK8ye50W
 ZyKt4ynJuSh683puwBOHF8AIVfLLOTeGHtP3JwCDDXdK7ekGHL9JKqDjYNOAhHdFYSLu645vT9u
 SjioyJ5VOWkg7lmb3yucNP3eEuPkFmCQSlZ+Eoq0y/wOZ5pzcVLVthDlK7vuW2y+RMtA5slAzk5
 wfNX46DVtxLw9OaahpmPlQnO6qYG47yLH1qhNWiT6yOSQ8SMz+Dc0nRYECvwBtOTVLAPKhHsN6H
 V4fnpI2AmoVGUj074H7RuvWSWMw2Wb7BbJCaps9QpQ7tS4qJBnMxX3AnirY9CFsfZyyU4OZ+JQW
 BQ488HRrPCMeWQoGJ6Q==
X-Proofpoint-GUID: yuU4urlYPp4fiyUiaZPBP2Nd3Q6_ZReX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_042816_944354_14471BC8 
X-CRM114-Status: GOOD (  24.19  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently, passthru parameters are grouped under struct nvmet_subsys.
Since passthru can be configured through configfs and all passthru
parameters are exposed under a separate configfs subdirectory, group
these parameters under a new struct nvmet_passthru.

Grouping passthru-specific parameters in a separate structure makes
the code easier to maintain and reason about.

This also allows the passthru structure to be allocated on demand,
avoiding the memory overhead for subsystems that do not use passthru.
The structure is allocated when passthru configuration is needed and
its configfs attributes are accessed under subsys->lock. The passthru
configfs group is still created when the subsystem is allocated.

There are no functional changes intended.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 90 +++++++++++++++++++++++++++++-----
 drivers/nvme/target/core.c     | 12 ++++-
 drivers/nvme/target/nvmet.h    | 34 ++++++++++---
 drivers/nvme/target/passthru.c | 52 ++++++++++++--------
 4 files changed, 148 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b03b5d1c2dc3..6bac66c48bff 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -905,21 +905,34 @@ static ssize_t nvmet_passthru_device_path_show(struct config_item *item,
 		char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	ssize_t ret;
 
-	return snprintf(page, PAGE_SIZE, "%s\n", subsys->passthru_ctrl_path);
+	mutex_lock(&subsys->lock);
+	ret = snprintf(page, PAGE_SIZE, "%s\n",
+		       subsys->passthru && subsys->passthru->ctrl_path ?
+		       subsys->passthru->ctrl_path : "");
+	mutex_unlock(&subsys->lock);
+	return ret;
 }
 
 static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru;
 	size_t len;
 	int ret;
 
 	mutex_lock(&subsys->lock);
 
+	passthru = nvmet_subsys_passthru(subsys);
+	if (!passthru) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
 	ret = -EBUSY;
-	if (subsys->passthru_ctrl)
+	if (passthru->ctrl)
 		goto out_unlock;
 
 	ret = -EINVAL;
@@ -927,10 +940,10 @@ static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
 	if (!len)
 		goto out_unlock;
 
-	kfree(subsys->passthru_ctrl_path);
+	kfree(passthru->ctrl_path);
 	ret = -ENOMEM;
-	subsys->passthru_ctrl_path = kstrndup(page, len, GFP_KERNEL);
-	if (!subsys->passthru_ctrl_path)
+	passthru->ctrl_path = kstrndup(page, len, GFP_KERNEL);
+	if (!passthru->ctrl_path)
 		goto out_unlock;
 
 	mutex_unlock(&subsys->lock);
@@ -946,8 +959,13 @@ static ssize_t nvmet_passthru_enable_show(struct config_item *item,
 		char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	ssize_t ret;
 
-	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
+	mutex_lock(&subsys->lock);
+	ret = sprintf(page, "%d\n",
+		subsys->passthru && subsys->passthru->ctrl ? 1 : 0);
+	mutex_unlock(&subsys->lock);
+	return ret;
 }
 
 static ssize_t nvmet_passthru_enable_store(struct config_item *item,
@@ -972,18 +990,34 @@ CONFIGFS_ATTR(nvmet_passthru_, enable);
 static ssize_t nvmet_passthru_admin_timeout_show(struct config_item *item,
 		char *page)
 {
-	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->admin_timeout);
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	ssize_t ret;
+
+	mutex_lock(&subsys->lock);
+	ret = sprintf(page, "%u\n", subsys->passthru ?
+			subsys->passthru->admin_timeout : 0);
+	mutex_unlock(&subsys->lock);
+	return ret;
 }
 
 static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru;
 	unsigned int timeout;
 
 	if (kstrtouint(page, 0, &timeout))
 		return -EINVAL;
-	subsys->admin_timeout = timeout;
+
+	mutex_lock(&subsys->lock);
+	passthru = nvmet_subsys_passthru(subsys);
+	if (!passthru) {
+		mutex_unlock(&subsys->lock);
+		return -ENOMEM;
+	}
+	passthru->admin_timeout = timeout;
+	mutex_unlock(&subsys->lock);
 	return count;
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
@@ -991,18 +1025,34 @@ CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
 		char *page)
 {
-	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->io_timeout);
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	ssize_t ret;
+
+	mutex_lock(&subsys->lock);
+	ret = sprintf(page, "%u\n",
+		subsys->passthru ? subsys->passthru->io_timeout : 0);
+	mutex_unlock(&subsys->lock);
+	return ret;
 }
 
 static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru;
 	unsigned int timeout;
 
 	if (kstrtouint(page, 0, &timeout))
 		return -EINVAL;
-	subsys->io_timeout = timeout;
+
+	mutex_lock(&subsys->lock);
+	passthru = nvmet_subsys_passthru(subsys);
+	if (!passthru) {
+		mutex_unlock(&subsys->lock);
+		return -ENOMEM;
+	}
+	passthru->io_timeout = timeout;
+	mutex_unlock(&subsys->lock);
 	return count;
 }
 CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
@@ -1010,18 +1060,34 @@ CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
 static ssize_t nvmet_passthru_clear_ids_show(struct config_item *item,
 		char *page)
 {
-	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->clear_ids);
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	ssize_t ret;
+
+	mutex_lock(&subsys->lock);
+	ret = sprintf(page, "%u\n",
+		subsys->passthru ? subsys->passthru->clear_ids : 0);
+	mutex_unlock(&subsys->lock);
+	return ret;
 }
 
 static ssize_t nvmet_passthru_clear_ids_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru;
 	unsigned int clear_ids;
 
 	if (kstrtouint(page, 0, &clear_ids))
 		return -EINVAL;
-	subsys->clear_ids = clear_ids;
+
+	mutex_lock(&subsys->lock);
+	passthru = nvmet_subsys_passthru(subsys);
+	if (!passthru) {
+		mutex_unlock(&subsys->lock);
+		return -ENOMEM;
+	}
+	passthru->clear_ids = clear_ids;
+	mutex_unlock(&subsys->lock);
 	return count;
 }
 CONFIGFS_ATTR(nvmet_passthru_, clear_ids);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8eea0a504308..b09681cb4a1f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1645,8 +1645,16 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	/* By default, set loop targets to clear IDS by default */
-	if (ctrl->port->disc_addr.trtype == NVMF_TRTYPE_LOOP)
-		subsys->clear_ids = 1;
+	if (ctrl->port->disc_addr.trtype == NVMF_TRTYPE_LOOP) {
+		mutex_lock(&subsys->lock);
+		subsys->passthru = nvmet_subsys_passthru(subsys);
+		if (!subsys->passthru) {
+			mutex_unlock(&subsys->lock);
+			goto out_free_ctrl;
+		}
+		subsys->passthru->clear_ids = 1;
+		mutex_unlock(&subsys->lock);
+	}
 #endif
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 162e2fdd848e..eb0f965b1a7e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -319,6 +319,14 @@ struct nvmet_ctrl {
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
 
+struct nvmet_passthru {
+	struct nvme_ctrl	*ctrl;
+	char			*ctrl_path;
+	unsigned int		admin_timeout;
+	unsigned int		io_timeout;
+	unsigned int		clear_ids;
+};
+
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
 
@@ -358,12 +366,8 @@ struct nvmet_subsys {
 	char			*firmware_rev;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
-	struct nvme_ctrl	*passthru_ctrl;
-	char			*passthru_ctrl_path;
+	struct nvmet_passthru	*passthru;
 	struct config_group	passthru_group;
-	unsigned int		admin_timeout;
-	unsigned int		io_timeout;
-	unsigned int		clear_ids;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -793,7 +797,20 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req);
 static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
-	return subsys->passthru_ctrl;
+	return subsys->passthru && subsys->passthru->ctrl;
+}
+
+static inline struct nvmet_passthru *nvmet_subsys_passthru(
+		struct nvmet_subsys *subsys)
+{
+	lockdep_assert_held(&subsys->lock);
+
+	if (!subsys->passthru) {
+		subsys->passthru = kzalloc_obj(*subsys->passthru);
+		if (!subsys->passthru)
+			return NULL;
+	}
+	return subsys->passthru;
 }
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
 static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
@@ -814,6 +831,11 @@ static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
 	return NULL;
 }
+static inline struct nvmet_passthru *nvmet_subsys_passthru(
+		struct nvmet_subsys *subsys)
+{
+	return NULL;
+}
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 static inline bool nvmet_is_passthru_req(struct nvmet_req *req)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fa6527c537e2..16cd3fdf98ec 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -26,7 +26,7 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
 	 * Multiple command set support can only be declared if the underlying
 	 * controller actually supports it.
 	 */
-	if (!nvme_multi_css(ctrl->subsys->passthru_ctrl))
+	if (!nvme_multi_css(ctrl->subsys->passthru->ctrl))
 		ctrl->cap &= ~(1ULL << 43);
 }
 
@@ -39,7 +39,7 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 	void *data;
 	u8 csi;
 
-	if (!ctrl->subsys->clear_ids)
+	if (!ctrl->subsys->passthru->clear_ids)
 		return status;
 
 	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
@@ -89,7 +89,7 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
+	struct nvme_ctrl *pctrl = ctrl->subsys->passthru->ctrl;
 	u16 status = NVME_SC_SUCCESS;
 	struct nvme_id_ctrl *id;
 	unsigned int max_hw_sectors;
@@ -208,7 +208,7 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	 */
 	id->mc = 0;
 
-	if (req->sq->ctrl->subsys->clear_ids) {
+	if (req->sq->ctrl->subsys->passthru->clear_ids) {
 		memset(id->nguid, 0, NVME_NIDT_NGUID_LEN);
 		memset(id->eui64, 0, NVME_NIDT_EUI64_LEN);
 	}
@@ -305,7 +305,8 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
+	struct nvmet_passthru *passthru = nvmet_req_subsys(req)->passthru;
+	struct nvme_ctrl *ctrl = passthru->ctrl;
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
@@ -325,9 +326,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		}
 
 		q = ns->queue;
-		timeout = nvmet_req_subsys(req)->io_timeout;
+		timeout = passthru->io_timeout;
 	} else {
-		timeout = nvmet_req_subsys(req)->admin_timeout;
+		timeout = passthru->admin_timeout;
 	}
 
 	rq = blk_mq_alloc_request(q, nvme_req_op(req->cmd), 0);
@@ -386,7 +387,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
  */
 static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
+	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru->ctrl;
 	struct nvme_feat_host_behavior *host;
 	u16 status = NVME_SC_INTERNAL;
 	int ret;
@@ -586,15 +587,17 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
+	struct nvmet_passthru *passthru;
 	struct nvme_ctrl *ctrl;
 	struct file *file;
 	int ret = -EINVAL;
 	void *old;
 
 	mutex_lock(&subsys->lock);
-	if (!subsys->passthru_ctrl_path)
+	passthru = subsys->passthru;
+	if (!passthru || !passthru->ctrl_path)
 		goto out_unlock;
-	if (subsys->passthru_ctrl)
+	if (passthru->ctrl)
 		goto out_unlock;
 
 	if (subsys->nr_namespaces) {
@@ -602,7 +605,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	file = filp_open(passthru->ctrl_path, O_RDWR, 0);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
@@ -611,7 +614,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	ctrl = nvme_ctrl_from_file(file);
 	if (!ctrl) {
 		pr_err("failed to open nvme controller %s\n",
-		       subsys->passthru_ctrl_path);
+		       passthru->ctrl_path);
 
 		goto out_put_file;
 	}
@@ -626,7 +629,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	if (old)
 		goto out_put_file;
 
-	subsys->passthru_ctrl = ctrl;
+	passthru->ctrl = ctrl;
 	subsys->ver = ctrl->vs;
 
 	if (subsys->ver < NVME_VS(1, 2, 1)) {
@@ -636,7 +639,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
 	nvme_get_ctrl(ctrl);
-	__module_get(subsys->passthru_ctrl->ops->module);
+	__module_get(passthru->ctrl->ops->module);
 	ret = 0;
 
 out_put_file:
@@ -648,12 +651,17 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 
 static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
-	if (subsys->passthru_ctrl) {
-		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->instance);
-		module_put(subsys->passthru_ctrl->ops->module);
-		nvme_put_ctrl(subsys->passthru_ctrl);
+	struct nvmet_passthru *passthru = subsys->passthru;
+
+	if (!passthru)
+		return;
+
+	if (passthru->ctrl) {
+		xa_erase(&passthru_subsystems, passthru->ctrl->instance);
+		module_put(passthru->ctrl->ops->module);
+		nvme_put_ctrl(passthru->ctrl);
 	}
-	subsys->passthru_ctrl = NULL;
+	passthru->ctrl = NULL;
 	subsys->ver = NVMET_DEFAULT_VS;
 }
 
@@ -668,6 +676,10 @@ void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 {
 	mutex_lock(&subsys->lock);
 	__nvmet_passthru_ctrl_disable(subsys);
+	if (subsys->passthru) {
+		kfree(subsys->passthru->ctrl_path);
+		kfree(subsys->passthru);
+		subsys->passthru = NULL;
+	}
 	mutex_unlock(&subsys->lock);
-	kfree(subsys->passthru_ctrl_path);
 }
-- 
2.53.0


