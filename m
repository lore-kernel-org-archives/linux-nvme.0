Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EDFCCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ao/61fi6QHr7l2lDxdyzSklQYKVcdDpFMnEOe8M5YTI=; b=43+pV8dEE+am9h5CjH9M24aj18
	C0hsK6f9m6aRX6ALkiU8rBpHDthBVTPmeZ3kT1jNQh8yTofLVIQGBzpZ82TezS+blbUxo0R03wzMh
	YPULKlOV03FAo4bimOfwina2IgxETlkiJIH8i/wLCGyDvNC8aRfTn23lROEy+jvyIYJwhfr4HQKcu
	XMubJ1X/JOjr0uxh/nkD1xMGHZb/Th7T8i97KSwOck0cgmgcV1Hps8gH16wCkpfpkKYJyOFNTr827
	jSfieBF2guLKj3NOUkuEBL/bAz3FCC1h8NOp2f6OH4tGl0z0RUsGhpMAzdsgG2GDfbRj99jX51hYp
	RjisSLrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYX-0000000DX6A-0661;
	Mon, 27 Oct 2025 09:30:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYU-0000000DX4l-1u0H
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 09:30:23 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QKhd36017298;
	Mon, 27 Oct 2025 09:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ao/61fi6QHr7l2lDx
	dyzSklQYKVcdDpFMnEOe8M5YTI=; b=rTCF+xPTgjC8GBMdc9tO1gsa0X8kVIRiD
	xGXvyz4TRbh3MldRK5JEHlFAIo9Pb1pqb1rt6sH186MosXWpx9lV63WdnR4+QRZZ
	tdhdNRGquLvwHjPB63S0XRQhqWtUz6dxUM+zDiwH4N+R+ReANJetdvY+5ZZ32fMJ
	7VzyW24kH6RM4fPdHcGqphhp8JVkjI9eixs/ZyHql1+sXoB53DZ8wkM5uxdmpyHS
	2oIQe+1gtxU+oy0STowIG35WzUJXMsLerfSG/xO8G4TNiBng0j6WqcckH1J9epa/
	dtT0KL8EG0qnkKl2OBzXyYAL6kOVGPYihXX8HkIyTXOC79GSoEkzw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p98x119-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8bCOd009428;
	Mon, 27 Oct 2025 09:30:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hvm34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R9UEgf37290246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 09:30:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318BE20043;
	Mon, 27 Oct 2025 09:30:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 444D320040;
	Mon, 27 Oct 2025 09:30:10 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 09:30:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv3 4/6] nvme: add sysfs attribute adp_weight_timeout
Date: Mon, 27 Oct 2025 14:59:38 +0530
Message-ID: <20251027092949.961287-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027092949.961287-1-nilay@linux.ibm.com>
References: <20251027092949.961287-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=68ff3ba8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6kAmNtyT0nacYCdVA0AA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: zzqHUFS60UeQmmnpPgRBz3vXiWjqgJFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfXxvSmBJ8DTmiW
 OimmP7PHN6DSN2C15q50kcDWHZacoqFbIklx02JTXlxal3VeD2YraFF01pFoi1ERoJuTaXvTnK8
 UyWJQdIi9O/NoPUNDIwf6tyxXaRMrBenq+oyu1WwnhmI/7DXuMRxTMbAqvcD7ZTFPntZzK917be
 mZ6HTclMbx8yUr8kMw2sEpEtTPDiwLrrx9+Gugp3mJolQIcncQUyEp3g3zbQL/Jsi2M1Qe+EGwt
 B0PsfBBGlNJlR47rf3LnGEUTqricoHhPmrZfJblOLjhTRU/5086or1Ll+sOTH+O3MXDVvTwsLMk
 pOvu+1j5bgZR57NCMzQmOhWPJ+00fioRY1CesYtrI+WFkUC7GDBYhpNcjEkn0fUjeecdBaHpV24
 0ZRxr5uW0VyYWLU0ItnQeONx/VWp7g==
X-Proofpoint-ORIG-GUID: zzqHUFS60UeQmmnpPgRBz3vXiWjqgJFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_023022_498888_EF7FA6C4 
X-CRM114-Status: GOOD (  22.06  )
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

By default, the adaptive I/O policy accumulates latency samples over a
15-second window. When this window expires, the driver computes the
average latency and updates the smoothed (EWMA) latency value. The
path weight is then recalculated based on this data.

A 15-second window provides a good balance for most workloads, as it
helps smooth out transient latency spikes and produces a more stable
path weight profile. However, some workloads may benefit from faster
or slower adaptation to changing latency conditions.

This commit introduces a new sysfs attribute, adp_weight_timeout,
which allows users to configure the path weight calculation interval
based on their workload requirements.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  6 ++++++
 drivers/nvme/host/multipath.c | 38 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 +++-
 drivers/nvme/host/sysfs.c     |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab09b9724674..f48c6bc25055 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3248,6 +3248,12 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	 * used while adding latency sample for adaptive iopolicy.
 	 */
 	subsys->adp_ewma_shift = NVME_DEFAULT_ADP_EWMA_SHIFT;
+	/*
+	 * Path weight calculation timeout interval used for adaptive iopolicy.
+	 * The default value of this paremeter is set to 15 seconds. However, it
+	 * could be also changed through sysfs.
+	 */
+	subsys->adp_weight_timeout = NVME_DEFAULT_ADP_WEIGHT_TIMEOUT;
 #endif
 	subsys->dev.class = &nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 95407c0f2f4b..d4df01511ee9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -362,8 +362,11 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 	stat->batch_count++;
 	stat->nr_samples++;
 
-	if (now > stat->last_weight_ts &&
-	    (now - stat->last_weight_ts) >= NVME_DEFAULT_ADP_WEIGHT_TIMEOUT) {
+	if (now > stat->last_weight_ts) {
+		u64 timeout = READ_ONCE(head->subsys->adp_weight_timeout);
+
+		if ((now - stat->last_weight_ts) < timeout)
+			return;
 
 		stat->last_weight_ts = now;
 
@@ -1495,6 +1498,37 @@ static ssize_t nvme_subsys_adp_ewma_shift_store(struct device *dev,
 SUBSYS_ATTR_RW(adp_ewma_shift, 0644, nvme_subsys_adp_ewma_shift_show,
 		nvme_subsys_adp_ewma_shift_store);
 
+static ssize_t nvme_subsys_adp_weight_timeout_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return sysfs_emit(buf, "%llu\n",
+		div_u64(READ_ONCE(subsys->adp_weight_timeout), NSEC_PER_SEC));
+}
+
+static ssize_t nvme_subsys_adp_weight_timeout_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int timeout, err;
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	err = kstrtoint(buf, 0, &timeout);
+	if (err)
+		return -EINVAL;
+
+	if (timeout <= 0)
+		return -EINVAL;
+
+	WRITE_ONCE(subsys->adp_weight_timeout, timeout * NSEC_PER_SEC);
+	return count;
+}
+
+SUBSYS_ATTR_RW(adp_weight_timeout, 0644, nvme_subsys_adp_weight_timeout_show,
+		nvme_subsys_adp_weight_timeout_store);
+
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9f5b233c747a..2e58d4d6902a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -450,7 +450,8 @@ struct nvme_subsystem {
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
-	int			adp_ewma_shift; /* used for adaptive iopolicy */
+	int			adp_ewma_shift;     /* used for adaptive iopolicy */
+	u64			adp_weight_timeout; /* used for adaptive iopolicy */
 #endif
 };
 
@@ -1045,6 +1046,7 @@ extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
 extern struct device_attribute subsys_attr_adp_ewma_shift;
+extern struct device_attribute subsys_attr_adp_weight_timeout;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index cf9711961b00..18d7eddd477a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -918,6 +918,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
 	&subsys_attr_adp_ewma_shift.attr,
+	&subsys_attr_adp_weight_timeout.attr,
 #endif
 	NULL,
 };
-- 
2.51.0


