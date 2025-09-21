Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F003CAC59A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrZC/TrTQr1BAKQTUZDEgt5WVzg4Y44kX8OYKdSjzZA=; b=i6fsuW+AxIbofDCKO5E4u3osUu
	ztuonJox809eBCeSSEV6IfHnsciFlG6VqYfTq0/ODUUaNtdX7U3V0KqgRhP3XrbM4rXFX0IAtGfyE
	Wk0y+xVDTVDFq81SPycRdxG3XUbqGAJL7RAFKC2aEbCgZ+FBFAj8zF74v01cew2suAMgQ1gxWBAD4
	etfyGH6YZaya7rCNQYBdnxHxDwxC+psVZPghdl/pWlrnBN1vIY87ocC5CHlxH/qDhr+aNnJLXyAk/
	wB69NzlkZEyjRK9pYJ7S8L6XieWWdMEVf0Zw2SPv5rqrhyk/3l+s87QhH3gNjlncAhLJ8raJkxpYf
	AYBtVeOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I0A-00000007MSO-0qQH;
	Sun, 21 Sep 2025 11:13:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I07-00000007MQb-0FXk
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 11:13:04 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KK1bJY010787;
	Sun, 21 Sep 2025 11:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SrZC/TrTQr1BAKQTU
	ZDEgt5WVzg4Y44kX8OYKdSjzZA=; b=n1Q+tJgUyoM1EA39oYScyFIdPDgyOVsix
	1650MGw+HFf4Lu9xb4gLai2f54NTtrATWh6n0Wg8SGAq4YiIXTyhYiWoSr3GJn9i
	+GaM9LDRgyB64C5ZP8r+TkPPewQp7Bzh3nsl7Rr1O9phSYPooZI4DbNrICkvlvm3
	RGa6gWLl4yyr4klhVYHF9Jsy6fUyOgs4TDLEd7JonuYePCixnNqoU02kol0/8rJs
	3u4W7m8h9BmnIwk8p9CX6/KJ+slkATpOIdp3LgGNVnVrGEdA42H3qbEzYyRB+TP5
	XRGylv9IWzS2fadbp9qJuOX6ByYjFhc1UDfvZEc23h4RBK3ZFOm3A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5nchp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L6tacn018427;
	Sun, 21 Sep 2025 11:12:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a7km9hn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LBCnNs43713012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 11:12:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA55520043;
	Sun, 21 Sep 2025 11:12:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7282A20040;
	Sun, 21 Sep 2025 11:12:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.7])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 11:12:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        hare@suse.de, dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCH 3/5] nvme-multipath: add sysfs attribute for adaptive I/O policy
Date: Sun, 21 Sep 2025 16:42:23 +0530
Message-ID: <20250921111234.863853-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921111234.863853-1-nilay@linux.ibm.com>
References: <20250921111234.863853-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: doVB99kudA1vD4X2cb-_Q9zc2WA88-7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX4bS9ZiMQZjJy
 lmbC4AZOSoyQWIHxE+ALVKK1yGLyu73vIUF8ZLJi2NbRB2XY7QH4i05iwDZU9xfbXZXXWZxhN8I
 MTDXoaw2Stbo2lRutpo8s8uBUoqesC5Kcy/YtQBDNjWujfKYN5IrxQz2nTItTh3k409LmCbrGoq
 yaUZc2v2CKXWg1heF2rHSnxBtxISN6LPBQlyMJ0nM0I9cKsw2XlW/KoW/fdYM57fP9MJ4lDT6Nk
 5qAlxc3sTlKBFVurWNvSWx9m+vKAvGtJhwKbO+hqbQuNJSMcs/5CP8D1WJ2oaq9ixGIC74VEZlL
 f0bzFOqkJ8MzwReSGsrJg9LDOtE9q1VIwkJNhCYoYKy+UUpsPlQPIfGJngQQe3k8qSPEtrfKbhq
 p67qDqWW
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68cfddb4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ycxY8kIdQdZvmWMptMIA:9
X-Proofpoint-GUID: doVB99kudA1vD4X2cb-_Q9zc2WA88-7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_041303_103628_FA0FEE56 
X-CRM114-Status: GOOD (  26.41  )
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

This commit introduces a new sysfs attribute, "adp_stat", under the
nvme path block device. This attribute provides visibility into the
state of the adaptive I/O policy and is intended to aid debugging and
observability. We now also calculate the per-path aggregated smoothed
(EWMA) latency for reporting it under this new attribute.

The attribute reports per-path aggregated statistics, including I/O
weight, smoothed (EWMA) latency, selection count, processed samples,
and ignored samples.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 77 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  2 +
 drivers/nvme/host/sysfs.c     |  5 +++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 4f56a2bf7ea3..84c64605d05c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -224,6 +224,22 @@ static inline u64 ewma_update(u64 old, u64 new)
 	return (old * ((1 << NVME_EWMA_SHIFT) - 1) + new) >> NVME_EWMA_SHIFT;
 }
 
+static inline void path_ewma_update(atomic64_t *ptr, u64 new)
+{
+	u64 old, slat;
+
+	/*
+	 * Since multiple CPUs may update the per-path smoothed (EWMA)
+	 * latency concurrently, we use an atomic compare-and-exchange
+	 * loop to safely apply the update without losing intermediate
+	 * changes.
+	 */
+	do {
+		old = atomic64_read(ptr);
+		slat = ewma_update(old, new);
+	} while (atomic64_cmpxchg(ptr, old, slat) != old);
+}
+
 static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 {
 	int cpu, srcu_idx;
@@ -308,11 +324,18 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 		 * slat_ns = (prev_slat_ns * (WEIGHT - 1) + (latency)) / WEIGHT
 		 * With WEIGHT = 8, this assigns 7/8 (~87.5 %) weight to the
 		 * existing latency and 1/8 (~12.5%) weight to the new latency.
+		 *
+		 * Please note that we also calculate here the smooth/EWMA
+		 * latency per path which is then used for exposing aggregated
+		 * per-path latency using sysfs for observability/debugging.
 		 */
-		if (unlikely(!stat->slat_ns))
+		if (unlikely(!stat->slat_ns)) {
 			stat->slat_ns = avg_lat_ns;
-		else
+			atomic64_set(&ns->slat_ns[rw], avg_lat_ns);
+		} else {
 			stat->slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
+			path_ewma_update(&ns->slat_ns[rw], avg_lat_ns);
+		}
 
 		stat->batch = stat->batch_count = 0;
 
@@ -437,6 +460,7 @@ static void nvme_mpath_reset_current_stat(struct nvme_ns *ns)
 		stat = per_cpu_ptr(ns->cpu_stat, cpu);
 		memset(stat, 0, 2 * sizeof(struct nvme_path_stat));
 	}
+	memset(ns->slat_ns, 0, sizeof(ns->slat_ns));
 }
 
 static bool nvme_mpath_set_current_adaptive_path(struct nvme_ns *ns)
@@ -1450,6 +1474,55 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
 }
 DEVICE_ATTR_RO(numa_nodes);
 
+static void adp_stat_read_all(struct nvme_ns *ns, struct nvme_path_stat *batch)
+{
+	int i, cpu;
+	int ncpu[2] = {0};
+	struct nvme_path_stat *stat;
+
+	for_each_online_cpu(cpu) {
+		stat = per_cpu_ptr(ns->cpu_stat, cpu);
+
+		for (i = 0; i < 2; i++) {
+			if (stat[i].weight) {
+				batch[i].weight += stat[i].weight;
+				batch[i].sel += stat[i].sel;
+				batch[i].nr_samples += stat[i].nr_samples;
+				batch[i].nr_ignored += stat[i].nr_ignored;
+				ncpu[i]++;
+			}
+		}
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (!ncpu[i])
+			continue;
+		batch[i].weight = DIV_U64_ROUND_CLOSEST(batch[i].weight, ncpu[i]);
+	}
+}
+
+static ssize_t adp_stat_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_path_stat stat[2] = {0};
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	adp_stat_read_all(ns, stat);
+	return sysfs_emit(buf, "%u %llu %llu %llu %llu %u %llu %llu %llu %llu\n",
+			stat[READ].weight,
+			atomic64_read(&ns->slat_ns[READ]),
+			stat[READ].sel,
+			stat[READ].nr_samples,
+			stat[READ].nr_ignored,
+			stat[WRITE].weight,
+			atomic64_read(&ns->slat_ns[WRITE]),
+			stat[WRITE].sel,
+			stat[WRITE].nr_samples,
+			stat[WRITE].nr_ignored);
+
+}
+DEVICE_ATTR_RO(adp_stat);
+
 static ssize_t delayed_removal_secs_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index aa3f681d7376..22445cf4f5d5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -548,6 +548,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	atomic64_t slat_ns[2];	/* path smoothed (EWMA) latency in nanosconds */
 	struct nvme_path_stat __percpu *cpu_stat;
 #endif
 	struct list_head siblings;
@@ -1009,6 +1010,7 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_adp_stat;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 4f9607e9698a..cb04539e2e2c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_adp_stat.attr,
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
@@ -303,6 +304,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_disk_is_ns_head(disk))
 			return 0;
 	}
+	if (a == &dev_attr_adp_stat.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.51.0


