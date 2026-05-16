Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B06ECD4F3C
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9yc1BRrRaZQCetKEU60tVATiGPSHuQyQo3n+6F/ZxQ=; b=Y15zPD3/smhNETZKFW/uRO4GKV
	yj9HjpJO/m25jQZUJFqJjJJ5UM0HybItAwiUIGCyHw+GgyAAkvcdylWAJaCubGfinTPEQSNUBu2RX
	FftR4x5+uvS56MG3eOZlH3H5PaEKYDPLAwbRXiNr+rJ3pZ1zcrE21rGNWeCV2yAZPqvd/l7A1N7Gf
	vQVku9ZvnVykZPy3bu93J3Ij8v01rM311CHJJNb7jH8uqx/hiFYKGhIaADiQ/rJGNQEf7kckcIiZR
	mGPuMtP6Drnz4P2gFJ3a1Z64WtlVnpK2HKV9ka0NSgYilCl5uobujeNnjqSuM4wLx1OhGMr1kX4uP
	U2vcu1lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtV-0000000BDou-3VuG;
	Sat, 16 May 2026 18:37:49 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtT-0000000BDnB-1txI
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:37:48 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G4BExf144026;
	Sat, 16 May 2026 18:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u9yc1BRrRaZQCetKE
	U60tVATiGPSHuQyQo3n+6F/ZxQ=; b=b8dPwb1gqqLzTf9i7zkKS07eP5Phq470z
	jM+ArWpoMk+CtEhw8zMEdC5W39OVdMEbmRLY2fasSQodyniegouNms4Mk82VoqJt
	/+hNJsfrg0yGHaVTnJvFiQSPf0pOsCwau/2E8O6wKTmX3Fsoktbt3cihjc0iRhsE
	g/1ZERtou+LsJ1nGcHUyQRlE0ay6X5SQ8W9O9Noyti0Z98lrQawKkJrAa0Hvw9eo
	1rHt8l1lKCjpCc0RZEdSTiaazaq1xYGkv+v2iXvRmWP+cBUQkb/cHURUng4TIZEU
	q9ABresgJw006mmJh2FyeXkk4ijKSzTnfBh4Z2nXe9SCNUTnSVfAA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havsrap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIO9ap023219;
	Sat, 16 May 2026 18:37:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcrsar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbbIJ27328888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE20820043;
	Sat, 16 May 2026 18:37:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C5EA20040;
	Sat, 16 May 2026 18:37:34 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 3/8] nvme: export multipath failover count via sysfs
Date: Sun, 17 May 2026 00:06:50 +0530
Message-ID: <20260516183709.269937-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfXys/NHSfidyMc
 ikFwZmRGJBMmqUuJpY42fa4bAnevddPliDec8Pz60/DHfvnDZ1USP+79dKFNnlzVX7kY+mdh8Lt
 4snaGWB+t/qzxIpfCMAT5QclG0Melqoz0+utmbfEF1TlzjT7Yl7W2mADdgMYDW8B0T295pOMy5m
 DjFVD0R+PFzY2RrFraZr/GmBiV1nSf0Qf3SXRCD67r73aUJCHK0L4saxPznY87loKe1Oel5oPZS
 TUuVjRyzVaMG5I8xEDI8uTwbOP1hxTDVMymC5jzIeNkJilzvn3c3rkYeFbAZaMcOFtehiZDkXFZ
 GhG43LCg1YipLLTRz5RAxMLc8VKvM158xAOC0TN6Q1921wLRpRqXkNDM6rnbZrF5wMRzDh5JbV8
 UwWah7DGZhK6blNZNaeDqPujFTc8CuKMGbfqW/HUKHq5kNQAUtO0RB8X0AqGvUtMVtVoMofH/CA
 9rcJy7fGRakhG5bPGDg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a08b976 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=QEoVRfFIZvqOl-q0980A:9
X-Proofpoint-ORIG-GUID: joImQD-RaatiXWo0jkJyamdDgtsX8inx
X-Proofpoint-GUID: joImQD-RaatiXWo0jkJyamdDgtsX8inx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113747_612192_C406F1A5 
X-CRM114-Status: GOOD (  20.27  )
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

When an NVMe command completes with a path-specific error, the NVMe
driver may retry the command on an alternate controller or path if one
is available. These failover events indicate that I/O was redirected
away from the original path.

Currently, the number of times requests are failed over to another
available path is not visible to userspace. Exposing this information
can be useful for diagnosing path health and stability.

Export per-path sysfs attribute "multipath_failover_count" under diag
attribute group. This attribute is both readable and writable and thus
allowing user to reset the counter. This counter can be consumed by
monitoring tools such as nvme-top to help identify paths that
consistently trigger failovers under load.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     | 10 +++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..032595502165 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -142,6 +142,7 @@ void nvme_failover_req(struct request *req)
 	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
+	atomic_long_inc(&ns->failover);
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
@@ -1151,6 +1152,32 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t multipath_failover_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", atomic_long_read(&ns->failover));
+}
+
+static ssize_t multipath_failover_count_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long failover;
+	int ret;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	ret = kstrtoul(buf, 0, &failover);
+	if (ret)
+		return -EINVAL;
+
+	atomic_long_set(&ns->failover, failover);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(multipath_failover_count);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7538153fa61c..68c9df4f457a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -589,6 +589,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	atomic_long_t failover;
 #endif
 	atomic_long_t retries;
 	struct list_head siblings;
@@ -1063,6 +1064,7 @@ extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 46071e87079f..35a42fd4aec4 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -378,6 +378,9 @@ static DEVICE_ATTR_RW(command_retries_count);
 
 static struct attribute *nvme_ns_diag_attrs[] = {
 	&dev_attr_command_retries_count.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&dev_attr_multipath_failover_count.attr,
+#endif
 	NULL,
 };
 
@@ -390,7 +393,12 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-
+#ifdef CONFIG_NVME_MULTIPATH
+	if (a == &dev_attr_multipath_failover_count.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
+#endif
 	return a->mode;
 }
 
-- 
2.53.0


