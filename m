Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28814C98324
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K+6hJkQZXBI7+kt2si6ixIxxX6RQAlBTCzqmPu/WmyQ=; b=UM1y6llOXR4XJABOO1rZBSoVYB
	k0MV0+eXvKdWVXRE+AEgSD7+9/q+KNcTcyDGgrYWTxCU+HOt7JTGgRnTGsQ1DT2BsH/kNY0pYNbP/
	CYwot+VYvlj57MsvqfzPqlMm18DD/3n/865p/Wtsmq2O07dUhKnyleREppa+FM1k16EDrVV4ezAae
	a21ZGrmtJq3lFmmH2relTLYWUc5GV9cOt3jf4egZ0LLWm0s6wqTeyOiaXoD3maid6oCzCjAVvwBcY
	+S1UZiHuwddYwbEBz0jDXnUciEoeKnIjCHwbYT8c3vpMCR7r3FZJ6vIcAAJcWmFeyQ++Iqhp2cJjG
	s5HX9Pcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA3zu-0000000DBKY-2xT0;
	Fri, 25 Sep 2026 11:21:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA3zs-0000000DBK5-2AK9
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 11:21:46 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a5AH4104451;
	Fri, 25 Sep 2026 11:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K+6hJkQZXBI7+kt2s
	i6ixIxxX6RQAlBTCzqmPu/WmyQ=; b=S5IESxStX1wZwFWhlojXb02KdagBfX917
	x1sEumR458ojbl/Gm29CRu6F4cG/jSSbr9zQCH+zo09Byc8+/Uj80V2VfZeKJi2c
	K6eUl/4TxkYrdJ32womydzeQJp3Xq/Trm4GSip+/iw2U4E4W2EnXQihPgEc4vIDl
	hbRDi/7KaxSopbvDNy6MHxqnkpUAPdzBZo2ZzVmOdIKOSbwoo7OD8PvXgN8PlcWs
	+HwO2yWLFYTmXXZh5DIOVSkMhU1jq4x1fgsW9du2zQLijlWjGQyEORBiuCb2SVF2
	/3HgZ6EBZUk7biK67NnSVOD/82jgqpAHPhRBtW9Pa+X/bn0MgTz4g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1wujd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:21:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA4DVe3248931;
	Fri, 25 Sep 2026 11:21:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt323xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:21:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PBLWLs44892558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 11:21:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8603A20043;
	Fri, 25 Sep 2026 11:21:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B48F20040;
	Fri, 25 Sep 2026 11:21:30 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 11:21:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/2] nvmet: introduce struct nvmet_passthru
Date: Fri, 25 Sep 2026 16:51:09 +0530
Message-ID: <20260925112120.790530-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925112120.790530-1-nilay@linux.ibm.com>
References: <20260925112120.790530-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2LHjZZEMoNwK_GQNmfsDL7l1Z1z-PkD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXyLELj5nNfolj
 DFe92vE3ynkccxuWlTIPzDT5IVe6zwlWmb5hIMpzNVtWto5lJdNvCXytuNKWDeIXXQqGJCskD9a
 uwUlCBVzrWSR9SacSeBnlTE2bar39lRpTQY2A4fRnv1NStpaUzgO1pSeHvHH5B9GVYiq5oGJTe8
 9idNU0GHH5Vbt6SIa0eJmC5/ZsUvNnjnPyenroBrOoXjJ3SjuM3eNJHKDZXRqM2oC2Qv4FM5S9h
 KEGL7U6A4ZoH6Hi8ptTIQimXH6mGyBwD4KswijTwJpHdg8V241xue19BqO98b7AoTyUPvck8E/n
 OIx5aHea16octEQwhB3zEfYjT3ksu/HEtnCx3T41vX64GIz7FqPNqv7Nh+OsEq5uvBuRULPnqD8
 yQeiPgOz5Bgdl7tG83WtTzarzEbPLpR7uwwKzTaAxKZ0oLChAXzXG5yMExPMYGI2JL0IKsqX3Sm
 bAgGABoa3RzUDg4eMhQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab65941 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dvvbgF2KBwy678vMdXUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX3uBTSij6rr55
 Mq0O7F2kuLYyNn3SoIRatn+0OswcAY4lvlqgpsCm0j+zopo5VJBNGn8licdXIXDlHISlPigF4cc
 7ABruSdLW+RXECsApm8UqTGz9HSCAwc=
X-Proofpoint-GUID: 2LHjZZEMoNwK_GQNmfsDL7l1Z1z-PkD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_042144_684658_030AFEA2 
X-CRM114-Status: GOOD (  23.59  )
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

There are no functional changes intended.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 45 ++++++++++++++++++++--------------
 drivers/nvme/target/core.c     |  2 +-
 drivers/nvme/target/nvmet.h    | 18 ++++++++------
 drivers/nvme/target/passthru.c | 44 ++++++++++++++++++---------------
 4 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b03b5d1c2dc3..6f060ee7e15b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -904,22 +904,23 @@ static const struct config_item_type nvmet_namespaces_type = {
 static ssize_t nvmet_passthru_device_path_show(struct config_item *item,
 		char *page)
 {
-	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
 
-	return snprintf(page, PAGE_SIZE, "%s\n", subsys->passthru_ctrl_path);
+	return snprintf(page, PAGE_SIZE, "%s\n", passthru->ctrl_path);
 }
 
 static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru = &subsys->passthru;
 	size_t len;
 	int ret;
 
 	mutex_lock(&subsys->lock);
 
 	ret = -EBUSY;
-	if (subsys->passthru_ctrl)
+	if (passthru->ctrl)
 		goto out_unlock;
 
 	ret = -EINVAL;
@@ -927,10 +928,10 @@ static ssize_t nvmet_passthru_device_path_store(struct config_item *item,
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
@@ -945,9 +946,9 @@ CONFIGFS_ATTR(nvmet_passthru_, device_path);
 static ssize_t nvmet_passthru_enable_show(struct config_item *item,
 		char *page)
 {
-	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
 
-	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
+	return sprintf(page, "%d\n", passthru->ctrl ? 1 : 0);
 }
 
 static ssize_t nvmet_passthru_enable_store(struct config_item *item,
@@ -972,18 +973,20 @@ CONFIGFS_ATTR(nvmet_passthru_, enable);
 static ssize_t nvmet_passthru_admin_timeout_show(struct config_item *item,
 		char *page)
 {
-	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->admin_timeout);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
+
+	return sprintf(page, "%u\n", passthru->admin_timeout);
 }
 
 static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
 	unsigned int timeout;
 
 	if (kstrtouint(page, 0, &timeout))
 		return -EINVAL;
-	subsys->admin_timeout = timeout;
+	passthru->admin_timeout = timeout;
 	return count;
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
@@ -991,18 +994,20 @@ CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
 		char *page)
 {
-	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->io_timeout);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
+
+	return sprintf(page, "%u\n", passthru->io_timeout);
 }
 
 static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
 		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
 	unsigned int timeout;
 
 	if (kstrtouint(page, 0, &timeout))
 		return -EINVAL;
-	subsys->io_timeout = timeout;
+	passthru->io_timeout = timeout;
 	return count;
 }
 CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
@@ -1010,18 +1015,20 @@ CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
 static ssize_t nvmet_passthru_clear_ids_show(struct config_item *item,
 		char *page)
 {
-	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->clear_ids);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
+
+	return sprintf(page, "%u\n", passthru->clear_ids);
 }
 
 static ssize_t nvmet_passthru_clear_ids_store(struct config_item *item,
 		const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	struct nvmet_passthru *passthru = &to_subsys(item->ci_parent)->passthru;
 	unsigned int clear_ids;
 
 	if (kstrtouint(page, 0, &clear_ids))
 		return -EINVAL;
-	subsys->clear_ids = clear_ids;
+	passthru->clear_ids = clear_ids;
 	return count;
 }
 CONFIGFS_ATTR(nvmet_passthru_, clear_ids);
@@ -1042,9 +1049,9 @@ static const struct config_item_type nvmet_passthru_type = {
 
 static void nvmet_add_passthru_group(struct nvmet_subsys *subsys)
 {
-	config_group_init_type_name(&subsys->passthru_group,
+	config_group_init_type_name(&subsys->passthru.group,
 				    "passthru", &nvmet_passthru_type);
-	configfs_add_default_group(&subsys->passthru_group,
+	configfs_add_default_group(&subsys->passthru.group,
 				   &subsys->group);
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8eea0a504308..9ab07dbe8cbe 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1646,7 +1646,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	/* By default, set loop targets to clear IDS by default */
 	if (ctrl->port->disc_addr.trtype == NVMF_TRTYPE_LOOP)
-		subsys->clear_ids = 1;
+		subsys->passthru.clear_ids = 1;
 #endif
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 162e2fdd848e..8f5dccee7d26 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -319,6 +319,15 @@ struct nvmet_ctrl {
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
 
+struct nvmet_passthru {
+	struct nvme_ctrl	*ctrl;
+	char			*ctrl_path;
+	struct config_group	group;
+	unsigned int		admin_timeout;
+	unsigned int		io_timeout;
+	unsigned int		clear_ids;
+};
+
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
 
@@ -358,12 +367,7 @@ struct nvmet_subsys {
 	char			*firmware_rev;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
-	struct nvme_ctrl	*passthru_ctrl;
-	char			*passthru_ctrl_path;
-	struct config_group	passthru_group;
-	unsigned int		admin_timeout;
-	unsigned int		io_timeout;
-	unsigned int		clear_ids;
+	struct nvmet_passthru	passthru;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -793,7 +797,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req);
 static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
-	return subsys->passthru_ctrl;
+	return subsys->passthru.ctrl;
 }
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
 static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fa6527c537e2..81ac220da8ba 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -26,7 +26,7 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
 	 * Multiple command set support can only be declared if the underlying
 	 * controller actually supports it.
 	 */
-	if (!nvme_multi_css(ctrl->subsys->passthru_ctrl))
+	if (!nvme_multi_css(ctrl->subsys->passthru.ctrl))
 		ctrl->cap &= ~(1ULL << 43);
 }
 
@@ -39,7 +39,7 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 	void *data;
 	u8 csi;
 
-	if (!ctrl->subsys->clear_ids)
+	if (!ctrl->subsys->passthru.clear_ids)
 		return status;
 
 	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
@@ -89,7 +89,7 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
+	struct nvme_ctrl *pctrl = ctrl->subsys->passthru.ctrl;
 	u16 status = NVME_SC_SUCCESS;
 	struct nvme_id_ctrl *id;
 	unsigned int max_hw_sectors;
@@ -208,7 +208,7 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	 */
 	id->mc = 0;
 
-	if (req->sq->ctrl->subsys->clear_ids) {
+	if (req->sq->ctrl->subsys->passthru.clear_ids) {
 		memset(id->nguid, 0, NVME_NIDT_NGUID_LEN);
 		memset(id->eui64, 0, NVME_NIDT_EUI64_LEN);
 	}
@@ -305,7 +305,8 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
+	struct nvmet_passthru *passthru = &nvmet_req_subsys(req)->passthru;
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
+	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru.ctrl;
 	struct nvme_feat_host_behavior *host;
 	u16 status = NVME_SC_INTERNAL;
 	int ret;
@@ -586,15 +587,16 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
+	struct nvmet_passthru *passthru = &subsys->passthru;
 	struct nvme_ctrl *ctrl;
 	struct file *file;
 	int ret = -EINVAL;
 	void *old;
 
 	mutex_lock(&subsys->lock);
-	if (!subsys->passthru_ctrl_path)
+	if (!passthru->ctrl_path)
 		goto out_unlock;
-	if (subsys->passthru_ctrl)
+	if (passthru->ctrl)
 		goto out_unlock;
 
 	if (subsys->nr_namespaces) {
@@ -602,7 +604,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	file = filp_open(passthru->ctrl_path, O_RDWR, 0);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
@@ -611,7 +613,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	ctrl = nvme_ctrl_from_file(file);
 	if (!ctrl) {
 		pr_err("failed to open nvme controller %s\n",
-		       subsys->passthru_ctrl_path);
+		       passthru->ctrl_path);
 
 		goto out_put_file;
 	}
@@ -626,7 +628,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	if (old)
 		goto out_put_file;
 
-	subsys->passthru_ctrl = ctrl;
+	passthru->ctrl = ctrl;
 	subsys->ver = ctrl->vs;
 
 	if (subsys->ver < NVME_VS(1, 2, 1)) {
@@ -636,7 +638,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
 	nvme_get_ctrl(ctrl);
-	__module_get(subsys->passthru_ctrl->ops->module);
+	__module_get(passthru->ctrl->ops->module);
 	ret = 0;
 
 out_put_file:
@@ -648,12 +650,14 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 
 static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
-	if (subsys->passthru_ctrl) {
-		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->instance);
-		module_put(subsys->passthru_ctrl->ops->module);
-		nvme_put_ctrl(subsys->passthru_ctrl);
+	struct nvmet_passthru *passthru = &subsys->passthru;
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
 
@@ -669,5 +673,5 @@ void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 	mutex_lock(&subsys->lock);
 	__nvmet_passthru_ctrl_disable(subsys);
 	mutex_unlock(&subsys->lock);
-	kfree(subsys->passthru_ctrl_path);
+	kfree(subsys->passthru.ctrl_path);
 }
-- 
2.53.0


