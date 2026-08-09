Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8909C5AD4E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRvQBRgQXdtExZSiVwKiWjW3tSyjvddxvRUTYMOok00=; b=1ptYdQ3eHbKBuWsyZw7KFYih9e
	QZ15SqmVJFf7uWiYVZI2yYd7EVKOy8tVqMKqRnVe2+juvc6Bwg0iceCCijcQXNhkuxmGoiz32j813
	FPnqPbURVgLjAFegyIR2wq7Vo1PmN0bu3b8Qq9GDKxi1D86ZZY9Q8wkzUNUwArgqrfGPYq4lFgSRf
	9JZpHubqsopoqlzq+GU1jvn4gdTSZHZODtPREOeekDQD92o24uUTX48Gv2Faeql3BBgOjxxLobSHA
	RooXvgH/6g5DLOFbfZ0MT7mMtohUwqFrZ95aGCw1ys697jJfayzNDzha5q4FYeXE3jsrh2eLAXNrA
	wxFSF07w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sz-0000000AAn9-1hjj;
	Sun, 09 Aug 2026 10:09:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sw-0000000AAk6-2JvE
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991WbA2443891;
	Sun, 9 Aug 2026 10:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eRvQBRgQXdtExZSiV
	wKiWjW3tSyjvddxvRUTYMOok00=; b=RT1RODOER5mBi2XAGFHSYlEdIrqXUcBEx
	hA1Wi580iJ0GvRGUdL2KQUiECLh3yyP7wLTSgc3gJaqtnRJvO7SIPAiZQ+jHghVq
	oyGFJapBZtUbiqyUBaxJawS+sVuzqeR58CZkjgdt5eqSp00oaGnDwRkErTKSobPo
	wmJY/7x+wvAnRKC7rW/bti/lG332Lah5E6LIKdVXZ7ulBexGYDhmYXFgF6nUrhkr
	7Wv2lW8+gnRD/b1P0RtZEN8cKKmcpoDD8IxATydVD4G74R+TOS6Yy7GFnhTrUy1c
	+QsKuA70joDVDAUSZk0V/kJYFXP9QhnI2wKHfJrJZnveTvpqE7bWg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkckmkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uPGR030462;
	Sun, 9 Aug 2026 10:09:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vs47b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A95mR31326488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:09:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29E220043;
	Sun,  9 Aug 2026 10:09:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0185B20040;
	Sun,  9 Aug 2026 10:09:03 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:09:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 6/9] nvme-multipath: add debugfs attribute latency_ewma_shift
Date: Sun,  9 Aug 2026 15:38:01 +0530
Message-ID: <20260809100825.2014133-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: j0jTKC8aEGJrAj2Ls4DdAel6isdawEkx
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a7851c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=fnyYJAEsthLFXFqb5O8A:9
X-Proofpoint-ORIG-GUID: HiV-fSGOBTCK5la88KKI6q6A8xDYXNEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXwR2adSdArhyK
 0KarESGbZdL0OSedtjF4YBp109QjuEA/jQImPSPABDPKDdXb4I2paS4LKlDOpXTHAEVmfOJIAYn
 yuxCchI1PCwgrPxq5D4jet+QjjaUf7k48ArB8vKYPvYtpUe/0EmgotmMP4xJpGUUjxJtpIrAxX1
 y4TtQqpMTQmRurS1pcoRxJtqll9r2Nvk5vopehBPR0v5oG2b5wcoJYC9sn5Pli0ckkQkrAqIrz0
 AKJ80g/xI8Kc7QAuo22Cq+ZySP/MFNsDnOGkg+1gSMvPJnxKer/nSXVjYXsDOhD4DT/ZWLhBgXX
 xCqPEs3f2M931IqDys7dd0a4AUqKUUpHsbL2lYUSccsWkV29fmnGDPORqgeiKqlxD0cEaeyWKWa
 PJpTvGKUO7EKnWNp3EacBk6K4Pn2r1HejCBXHF1sHeXAva3YLmjGyxilXal7lz5cF90pcLNRYdJ
 B6amruGrxGjOlVHrYQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX6myPPpbCxYqv
 Fnb3wXU/AAneB1BiDl59+TC7KL9YZqprYMxQnn6/hxDmoECAlxWeQR+XJ+IHbCbKTbZR34EE7ta
 a+9M0lvBJEyuk4RVZq5vFUmLixcakts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030914_717809_B3B7FC75 
X-CRM114-Status: GOOD (  21.55  )
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
index b893df83d821..70a72c1a1602 100644
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
@@ -387,7 +386,8 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 		if (unlikely(!stat->slat_ns))
 			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
 		else {
-			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns);
+			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns,
+					READ_ONCE(head->latency_ewma_shift));
 			WRITE_ONCE(stat->slat_ns, slat_ns);
 		}
 
@@ -1151,6 +1151,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->delayed_removal_secs = 0;
+	head->latency_ewma_shift = NVME_DEFAULT_LATENCY_EWMA_SHIFT;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cd0d4565ebeb..842b9eace5dd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -606,6 +606,7 @@ struct nvme_ns_head {
 	atomic_long_t		io_requeue_no_usable_path_count;
 	atomic_long_t		io_fail_no_available_path_count;
 	struct nvme_ns * __percpu	*latency_path;
+	u32				latency_ewma_shift;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.53.0


