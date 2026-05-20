Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFBFCD5BAA
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nlcwhs/mBXxNPqm+2uQHKpQkK5WIlvK9B2XuXS7z8MA=; b=elBypg9ZByrHrD9Guuu3dw0W9+
	HhoL0ga49jKKQsJahp7vuXUJJ6RYjGJYvYs6Is4qwVWk/b6qYGE5feut/zJbZatWRIbSvT8CnScSj
	1wcr288Ewp34+sVI2Q98QZxLWz2SIJ79cT6jz+pWZyMFAotib5dNJ3TNabWJ6EXt6MQE79j0hgOw8
	UtNcAUdP2Uf6FMunAuAi4mnf6TLNVmNdvfuMGXG0n/zfLYpyJ/zwsbgONuVhRAG/ElX46dTfB/KiS
	tlutQlxsh3SvNog43dYTcXbWv3t3rB8L27Qx3dv9zhg4QctfgaO1M2/Ky8tqWxHhC2tsbH8wIk1HF
	U8O5wIcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYN-00000005QKU-2Qzi;
	Wed, 20 May 2026 18:21:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYM-00000005QJB-056F
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:21:59 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCoDtD3350414;
	Wed, 20 May 2026 18:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nlcwhs/mBXxNPqm+2
	uQHKpQkK5WIlvK9B2XuXS7z8MA=; b=LmvaROLADHoty+XWHkbV9/nuEUKMpYCos
	+kx/qW/Fao7mNn14GCUnk/PN+KcIGgv32WFVA5iACS507BZFIXAhrJ303H92xFyw
	hqWwMT46FzppUF+NWEOaOWJ4xfJIPk3f+2q5iJt2r/QEER8MJaVuguklampH8lXd
	odsMuNVdwc/3GgN5/2kMIMNIvXgCmtAcuxXMbTduraXtAiin1QtIOuzjnqagTGVK
	DQGF1NDf57ub7k6W1M9gSbaIE7NGa4EU24SSraJSh3jSwMmpjzvB9bKNkLVTrUoT
	XXmO+A5RxDsahbWeldCOtX8zI3Ll+pZbSJt1XGHeWK/4lsE2yRy+g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h753c84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI97DZ006070;
	Wed, 20 May 2026 18:21:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w0nr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILorc40501754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4954520043;
	Wed, 20 May 2026 18:21:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F66020040;
	Wed, 20 May 2026 18:21:45 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 5/8] nvme-multipath: add debugfs attribute latency_ewma_shift
Date: Wed, 20 May 2026 23:51:01 +0530
Message-ID: <20260520182112.863076-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dfbc2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fnyYJAEsthLFXFqb5O8A:9
X-Proofpoint-ORIG-GUID: HqWzto0E_tUeD4HQeTRw3_QtcBi8EPBl
X-Proofpoint-GUID: PSf47COXqbjJQO0VaDcCJIoRnXBxY_kf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX5iDCG8Qe3j3p
 tPCQcBZOTAJbqHCLMH/6sGDXxLPOhBnQ+t1GEHShQ/3zDS5zuAJWdgpy4sdy0Rk9xIHJ5qhF1e9
 u1v8dPHdneNKb956FtqaZcr34DB5N0NZ67qBYyIojT36NR0uLYWE2bZSZk5SFh+oIO6B138iKhb
 gz+qMUr1mYQljJGbw517/kk7ZtRu3EnkwNEKxcTOPFPRRqS4nSnUCuGDU67pAO35Smaur5zaDx+
 HCM1cjlTQ1ChH8ESBQIo0qYOGZzdyxOB9mKbgkaoXaisLo/4ta9m+sC8n41bGK4BRkXqEIJKEQw
 o9hgg6LXwbjCNS6xsS2xYGoP5gGIiknHxNPxPoFbR4edldIq58TBpw/b4Qp7IhzNKjQoq51tXBB
 D/L0EgW7wxwcCaakN/l99vcEkWM4lu2L2NGxUyhOFhWmU6xxbxUys8+1Q+E+0bPNPiKpcwKjunK
 XlbQkhU6t6Si4Amu9iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112158_066582_27598D41 
X-CRM114-Status: GOOD (  21.58  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c   | 46 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  9 ++++---
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 26a50566e4a1..4371d7aafae8 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -105,8 +105,54 @@ static const struct file_operations nvme_debugfs_fops = {
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
index 541d12b73b74..3e76e07a0376 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -281,10 +281,9 @@ static void nvme_mpath_weight_work(struct work_struct *weight_work)
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
@@ -375,7 +374,8 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 		if (unlikely(!stat->slat_ns))
 			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
 		else {
-			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns);
+			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns,
+					READ_ONCE(head->latency_ewma_shift));
 			WRITE_ONCE(stat->slat_ns, slat_ns);
 		}
 
@@ -1113,6 +1113,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->delayed_removal_secs = 0;
+	head->latency_ewma_shift = NVME_DEFAULT_LATENCY_EWMA_SHIFT;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7ee9689ce07e..40009c024ab8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -599,6 +599,7 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 
 	struct nvme_ns * __percpu	*latency_path;
+	u32				latency_ewma_shift;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.53.0


