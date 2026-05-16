Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1ACD4F3C
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z+N5ifXeA8s1wpIQYQ0KAVXXnAaTD89UxsSmparKJo=; b=rArbE2yYg7p8et32vVS+lSTjfY
	noN70JkBvXsgSWzMccgVDrM0facLpJnQmbBDkKhkGjveA6SWRURNrQcE6my/pbGK2xM7eAYqyVE3h
	egMtZaZhu95lMwjGZNg64l6ynn0DFOahb580TdWyGeYO6U2pbmJI3GbVDM23DJ3Rp6ZsK5fkL7MxF
	o+1C45ZU4Kz8mpcYAwypL48BdO6Ghu1Tr0pFQFFAD52hUx2KrkCzPcN560Pfcc/caH4KsU4oIPoxc
	z5NVCU6gstXxjfFbW8ZZoY7N1vCU7W5NIXQns6oP0GQrqdsoSO8xoB9FYgE62dEfNYvAg6sx3ZVq2
	mDdArw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtl-0000000BE2l-1nWL;
	Sat, 16 May 2026 18:38:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJth-0000000BDyh-37uh
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:38:02 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GFx9wH1362884;
	Sat, 16 May 2026 18:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9z+N5ifXeA8s1wpIQ
	YQ0KAVXXnAaTD89UxsSmparKJo=; b=IgY4AqZf+N1Kv/Nbb1RtTkd4ybjEyASUb
	CBSLpdooEXhdhpv6IBXK20i4CCMudMOhi3bpyu5P12qFL6eOPv4pArg3UHnMOPJF
	oxM/XqRgm+PL/s36DbYCl/k1dajTUg20zQLUjB7IEhqQ8WTIrqEgR6nskcwr+Sxp
	cxdleHTU+a08DeTDfB8BAgHozuEK9Cls8xdlbjxNf4EjmD2wRjTxnfyXA3LVmaYs
	l+OVJ0VjkdYBPLDESW3t6lH5jAa9MYdNzH/x8Y9AbTzhFoyqcPY8x1goYFxjlCq8
	JOJUFq7dquhrUlu3bSILtXHmKf+5Td4v1xAHgc5svg2k0jABiVJFQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74hvd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIOSn1003362;
	Sat, 16 May 2026 18:37:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcrsjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIboTe25952742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D768920040;
	Sat, 16 May 2026 18:37:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1955720043;
	Sat, 16 May 2026 18:37:47 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 6/8] nvme: export I/O failure count when no path is available via sysfs
Date: Sun, 17 May 2026 00:06:53 +0530
Message-ID: <20260516183709.269937-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a08b983 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qQBb9XtKKTvnMxOhsCgA:9
X-Proofpoint-ORIG-GUID: 7-ed3Y-5mK2LwLgkYz7Oz1A1--VHVHOR
X-Proofpoint-GUID: 7-ed3Y-5mK2LwLgkYz7Oz1A1--VHVHOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfXwf8oXxO/hKcc
 wvEqewqlRkzB/eLkmV6CWsM/+hhRhBtR+eSzb1MfRSJWL4QSzmO8T825Ev/nzV5krSWnW7pFrWW
 m2Gfrcrkr6Ngv+kUJGenAWHsoReXmWchYbwBg+7YPMtLJ/L/813Ztv8aleGC6em1Il9YGIMZow4
 bOHzLK0gX76zaPL174yNQIedSZExchvx1//bdTG3Rd3UdKH5d6ZUVqtI1Dpmo+1W47Bl8KYyqkG
 YQj4240SlglnYiIfjklAcuHjnCm852J9MNUUI7PF3jyB56g5WWtgmUpiunLeNP46y+7sKccgK5o
 PdiG7rlLjHvOiwO2rkvGDsVvlDAC3lJrCT+YLToiFMx99W3rNomuQf6SbEKfgMlRcNdXYl13kOH
 WyePXCr4lyZvXIa5Nk4nyNP4/CiNjdaO+OleB0NdR5b2v7AOLAK1fWJ4/RyRkheaDpfPnCMFfY6
 iT7pRaLTXu0tFY6KF0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113801_794859_9391C482 
X-CRM114-Status: GOOD (  17.96  )
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

When I/O is submitted to the NVMe namespace head and no available path
can handle the request, the driver fails the I/O immediately. Currently,
such failures are only reported via kernel log messages, which may be
lost over time since dmesg is a circular buffer.

Add a new ns-head sysfs counter io_fail_no_available_path_count, under
diag attribute group to expose the number of I/Os that failed due to the
absence of an available path. This provides persistent visibility into
path-related I/O failures and can help users diagnose the cause of I/O
errors. This counter is also writable and so user may reset its value,
if needed.

This counter can also be consumed by monitoring tools such as nvme-top.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f72a687daa8f..dce566aca748 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -527,6 +527,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
 		bio_io_error(bio);
+		atomic_long_inc(&head->io_fail_no_available_path_count);
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -1208,6 +1209,35 @@ static ssize_t io_requeue_no_usable_path_count_store(struct device *dev,
 
 DEVICE_ATTR_RW(io_requeue_no_usable_path_count);
 
+static ssize_t io_fail_no_available_path_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%lu\n",
+		    atomic_long_read(&head->io_fail_no_available_path_count));
+}
+
+static ssize_t io_fail_no_available_path_count_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long fail_cnt;
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	err = kstrtoul(buf, 0, &fail_cnt);
+	if (err)
+		return -EINVAL;
+
+	atomic_long_set(&head->io_fail_no_available_path_count, fail_cnt);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(io_fail_no_available_path_count);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 845e338449ce..9434abf2659e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -565,6 +565,7 @@ struct nvme_ns_head {
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
 	atomic_long_t		io_requeue_no_usable_path_count;
+	atomic_long_t		io_fail_no_available_path_count;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1069,6 +1070,7 @@ extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
+extern struct device_attribute dev_attr_io_fail_no_available_path_count;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 9fe3a74b2bef..01d771d85f31 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -411,6 +411,7 @@ static struct attribute *nvme_ns_diag_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_multipath_failover_count.attr,
 	&dev_attr_io_requeue_no_usable_path_count.attr,
+	&dev_attr_io_fail_no_available_path_count.attr,
 #endif
 	NULL,
 };
@@ -439,6 +440,10 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_io_fail_no_available_path_count.attr) {
+		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.53.0


