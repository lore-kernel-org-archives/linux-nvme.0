Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DACBC5AD5A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=du8sImzkrd5gcTQ8j6gKSWMZAbK/vPQvFMg0dtKvVEg=; b=h2mF8IgOb798StlpcZIkeWqSve
	jYhLSOFDpWtyFpz4RXWdT0LJkgAga+HcZOUUvuuhP3UqBDNiYn9Ouus0SXgP0YtuchxqQYwEADKzG
	FgHTjXlojLn1Mgl7ilujNI0aYOY7SlWOHpHrTfKsGGz2f4ykRGhIaGtnCwD57UxqkTMn2TjwuAJwy
	8tv4DV9PIq3HDn8hgNYyn1xnYapwG3HGtwU8KK6Ug4MxydmKbtRA3WzDaLTcolDhRa+aKs9leF8p9
	9srSUHVxlyVl55VVPiPAkCIIUCk5w7hNlfcml0SRjkWM0CABo/wqB1ZqDZl/YVyZkNgneCchcEMjT
	bQCS1Ciw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIu-00000003zt2-0iSC;
	Sat, 15 Aug 2026 17:36:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIr-00000003zqW-2Jke
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:36:18 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVaNH265222;
	Sat, 15 Aug 2026 17:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=du8sImzkrd5gcTQ8j
	6gKSWMZAbK/vPQvFMg0dtKvVEg=; b=VTHIdqoDoD/7y/caoDH/gDRL7cOtUKp73
	5jsQv5Ad6hUKcOLOO1snpRfHjLJ1BIMtL8O01mXQvzTUsfIjwnpjn22ldU36o0o1
	ZCM0kf5qhZAnpNdbOqzAggzPrIaOrfGy84vUqMDKi9GLDQrYgdmIdlqB/3om12Xo
	z89BhyhV6cBye5Oecey9hVmRFAaq5++vk/rEquMyVCkWHP3NuORg6WND/leOYhRD
	AbgnppTME0L9nfSbBIgREyVw20yEU4/i3j2cGlZbfkOLtEvx+NdH0ot4QcENfynB
	tp6DoAKA9pGupFuqRGPdWCYv3tDB+J56ah9ZrCTjnGEQacMA0n2mA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3a8bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQZA9005929;
	Sat, 15 Aug 2026 17:36:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvesq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHa65n46530924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:36:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335B72004E;
	Sat, 15 Aug 2026 17:36:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3259120043;
	Sat, 15 Aug 2026 17:36:01 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:36:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 07/10] nvme-multipath: add debugfs attribute latency_ewma_shift
Date: Sat, 15 Aug 2026 23:04:29 +0530
Message-ID: <20260815173502.1185929-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: YpTufw1Z_6xm6Hi2h87qmzRFrKNTzDGz
X-Proofpoint-ORIG-GUID: QGfpahXdlBK-P30dKXJxE8pGVqj1nzOv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX7EkZUTWogymw
 BgrEIXsAa43V5v8NhlLzKGZpmIzPjE/h/OkK4dv1R1G4toXNDLEIQnBiDAAiQt+SgVPMwX/Xk/s
 pk3oiJgZSE+ZNvJsmhl+qSTP7Zu+9vI=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a80a389 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=fnyYJAEsthLFXFqb5O8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX75Bona4A3mm6
 sTy2xMIvjcHGcRE2TecpebeQonZcESqe4sq4RV06oC/C/HwD++vkTFHKmiJ09PE9WELQkDcszDt
 0uQJJsIn029RCxbJbfMVJjxa/OECDogsgyVz9IKW8nROQGVbDpAtTzVSvUB8texMAmyKtQTaPMV
 Rh0brHna1DJhipfNXWpZfg5DZeazlc9omc8QjVCobdlci/PKhxstwmcWhyVporAylgRG0PLoLB6
 81QnUxc6RP5NfpTOuID9PNXHuDewGQ/RBrgO1a/5W+QzIjd9O+2Kmjm4TeF/cEUVvsDPDBWOzH7
 mxkgB8cMujWMhXQNokt++3pPFuB/OVwvK2zxSJuRbahUEHC+jVwOubsvGveH6tZCzw7ALaW+mL2
 KWKOJjEer2R/lXHAgDuc3YnBwZfHka1SPVefjDbotsBjb9QKQsRYnzMVHuIF3z5ks5HU4avzIy+
 3JOkhysI1r1WnvfiC0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103617_601583_A957792F 
X-CRM114-Status: GOOD (  19.83  )
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

By default, the EWMA (Exponentially Weighted Moving Average) shift
value, used for storing latency samples for latency iopolicy, is set
to 3. The EWMA is calculated using the following formula:

ewma = (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;

The default value of 3 assigns ~87.5% weight to the existing EWMA value
and ~12.5% weight to the new latency sample. This provides a stable
average that smooths out short-term variations.

However, different workloads may require faster or slower adaptation to
changing conditions. This commit introduces a new debugfs attribute,
latency_ewma_shift, allowing users to tune the weighting factor.

For example:
   - latency_ewma_shift = 2 => 75% old, 25% new
   - latency_ewma_shift = 1 => 50% old, 50% new
   - latency_ewma_shift = 0 => 0% old, 100% new

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c   | 46 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  9 ++++---
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 04f8250fe607..ca1a670bea78 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -108,8 +108,54 @@ static const struct file_operations nvme_debugfs_fops = {
 	.release = nvme_debugfs_release,
 };
 
+#ifdef CONFIG_NVME_MULTIPATH
+static int nvme_latency_ewma_shift_show(void *data, struct seq_file *m)
+{
+	struct nvme_ns_head *head = data;
+
+	seq_printf(m, "%u\n", READ_ONCE(head->latency_ewma_shift));
+	return 0;
+}
+
+static ssize_t nvme_latency_ewma_shift_store(void *data,
+		const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct nvme_ns_head *head = data;
+	char kbuf[8];
+	u32 res;
+	int ret;
+	size_t len;
+	char *arg;
+
+	len = min(sizeof(kbuf) - 1, count);
+
+	if (copy_from_user(kbuf, ubuf, len))
+		return -EFAULT;
+
+	kbuf[len] = '\0';
+	arg = strstrip(kbuf);
+
+	ret = kstrtou32(arg, 0, &res);
+	if (ret)
+		return ret;
+
+	/*
+	 * Values greater than 8 are nonsensical, as they effectively assign
+	 * zero weight to new samples.
+	 */
+	if (res > 8)
+		return -EINVAL;
+
+	WRITE_ONCE(head->latency_ewma_shift, res);
+	return count;
+}
+#endif
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
+#ifdef CONFIG_NVME_MULTIPATH
+	{"latency_ewma_shift", 0600, nvme_latency_ewma_shift_show,
+			nvme_latency_ewma_shift_store},
+#endif
 	{},
 };
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8d5f1e42d10a..82a4f2326b79 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -293,10 +293,9 @@ static void nvme_mpath_weight_work(struct work_struct *weight_work)
  * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
  * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
  */
-static inline u64 calc_ewma_update(u64 old, u64 new)
+static inline u64 calc_ewma_update(u64 old, u64 new, u32 ewma_shift)
 {
-	return (old * ((1 << NVME_DEFAULT_LATENCY_EWMA_SHIFT) - 1)
-			+ new) >> NVME_DEFAULT_LATENCY_EWMA_SHIFT;
+	return (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;
 }
 
 static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
@@ -388,7 +387,8 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 		if (unlikely(!stat->slat_ns))
 			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
 		else {
-			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns);
+			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns,
+					READ_ONCE(head->latency_ewma_shift));
 			WRITE_ONCE(stat->slat_ns, slat_ns);
 		}
 
@@ -1170,6 +1170,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
+	head->latency_ewma_shift = NVME_DEFAULT_LATENCY_EWMA_SHIFT;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 040307c6534a..55e4d1344e5e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -626,6 +626,7 @@ struct nvme_ns_head {
 	atomic_long_t		io_requeue_no_usable_path_count;
 	atomic_long_t		io_fail_no_available_path_count;
 	struct nvme_ns * __percpu	*latency_path;
+	u32				latency_ewma_shift;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.53.0


