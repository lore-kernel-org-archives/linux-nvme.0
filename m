Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B24CCF9EE
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 09:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HoFcUdgHWPBHk7/lC7OD6u/+fnaG4nnZDC3OrZ/liQk=; b=MzpGPDjAiBU2bcAK8xvbAtMEXm
	i9+KadYWX/FNx3LKGihEtEvyWmCrMXRp1zbkiIT7GoYajNPGY7xoAJWXEuzzYN+r0atZ5QIrI6nka
	t7sXmhdQj6BOXnHqI9VbBnLNjgVjcpXKIUIoGhykRaG04PeMhI1Or+8ND0K24LNmpUGsFvIsYzX12
	Vze9Gr91MZTZR6Af5K+iwoSzqpezJAkAe9Dcoay4MQg8un9urDd7iD+5BXRijQuNoJ0KNHjyKyGhD
	D76lUCeAxiFRrKDrtZMLoaSUfQv+rGibt8axXVIstagv3rayHNZvXW4G1shIWYL2wnwgggni5jAGA
	ZpZX3Lsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYY-0000000DX7C-1np9;
	Mon, 27 Oct 2025 09:30:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYX-0000000DX5r-031M
	for linux-nvme@bombadil.infradead.org;
	Mon, 27 Oct 2025 09:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HoFcUdgHWPBHk7/lC7OD6u/+fnaG4nnZDC3OrZ/liQk=; b=K0o6bjeRQszuUXTNnV2FRLj8bu
	ej80Ce1+dziYnov7PPJ1sOQYJjMgDn23bn+HvlmPUvZIa+JqAXtWiTHerJFyNC1Zxx6pVh6zLXxkM
	QzSI9JZ1HTBvui9ZOriVzniQjzwMtRlqc+r3i9Pv8riIMS5cZzPsxzt/ITnGzN2hVQeigP0oJ/jjm
	GFmPvm06x9yPN7Oj3hYoD1oo7Axj9ClrQ/mJlYBw/dXxBYOLUX6uZPf4iFdwyUrXZVGkcccgWmy4P
	nLNUe0AlTxu2GZItSdml0w6HvEa1wl/zzT/nSdm4ZzcNgoiNpvBelNGWVnvG20/4lIel177WIFAd7
	+JtUYypQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIgj-00000001kWo-3rAu
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 08:34:51 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QK8Mn5003035;
	Mon, 27 Oct 2025 09:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HoFcUdgHWPBHk7/lC
	7OD6u/+fnaG4nnZDC3OrZ/liQk=; b=EaQskD5tQ5gQbGbZadWE7uFDxh4hyCqfJ
	H+vbr9oMwFYTn2q8TZTR5AyaWWiYUUckxZVXGNxjuM/ee4HYj5Uvrq5I4s1r08lz
	1fO3FzBU21pq3lLsZWn0SfzyeM5Gkx7/ggzYQMrwaaBNelom5oJFnhS0L1X3F0cw
	vOOOL9byUYFHyaz6h68mRxcbILTTCyYd5nPYYPPDqzJkGpo4F10yCK7OpLkLvqEi
	06iZyrh4GdBj9BeWfeB1gTxvRJgQVbEGFW5FdaArydpSsM9lGF4+ZrCm2cfrVrCg
	gt2TYkDFY1pIrefgt1l0WF/OAGwszw4JsU8IAZt3ZqLWRBHp+d+cg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81p11m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R75MM8022886;
	Mon, 27 Oct 2025 09:30:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xcwp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R9U9IU35389894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 09:30:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 853062004B;
	Mon, 27 Oct 2025 09:30:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2B8020040;
	Mon, 27 Oct 2025 09:30:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 09:30:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv3 3/6] nvme: add sysfs attribute adp_ewma_shift
Date: Mon, 27 Oct 2025 14:59:37 +0530
Message-ID: <20251027092949.961287-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027092949.961287-1-nilay@linux.ibm.com>
References: <20251027092949.961287-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=68ff3ba4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-5tJOOCdRLKl4jesFIoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: e_M4xd2Nn85sjic-VmygAfRHYSO3ghZO
X-Proofpoint-GUID: e_M4xd2Nn85sjic-VmygAfRHYSO3ghZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX4o/4fB5VwRff
 W3U0ReH39KhJrO2+LcxePQaHYUlfsNULYdouftnnTdumips0+u/UNRYEwllXhgyj9nkaeLVrQHU
 7yCqCoINJDB4+3mH78KSSnTfMyN/iuCZU8VVkCb0Vwc211be8+U1CrvT5zBaF6ePA4LPBwO7n0F
 Obc4p2wNx9JAqpLZH1eJv2n1Nn7+YJe117XAA+nMeHSaJNv6blYEmgo8lEz4QNuQNnCakFitpAX
 ZsvLItOldBsRYbmgB7jnyoobgOEFnIUUjt7nG/UwuSsnLnNtWs9I3CsKmYdmINC+jfPsHrEfiCy
 ayvjdVLpodXOQXmw1T81o6oqQ0oVI2T4gUCu0cbO38P0CfhbqxsTHEkfuZ6TdmxVfurHhqukkq/
 Swt07cm8JkOFs4HDqjUymivOHjd7OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_083450_303526_CA7A4E90 
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

By default, the EWMA (Exponentially Weighted Moving Average) shift
value, used for storing latency samples for adaptive iopolicy, is set
to 3. The EWMA is calculated using the following formula:

    ewma = (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;

The default value of 3 assigns ~87.5% weight to the existing EWMA value
and ~12.5% weight to the new latency sample. This provides a stable
average that smooths out short-term variations.

However, different workloads may require faster or slower adaptation to
changing conditions. This commit introduces a new sysfs attribute,
adp_ewma_shift, allowing users to tune the weighting factor.

For example:
  - adp_ewma_shift = 1 => 50% old, 50% new
  - adp_ewma_shift = 0 => 0% old, 100% new

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      | 10 ++++++++-
 drivers/nvme/host/multipath.c | 38 +++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  1 +
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 284a7c9c5d1d..ab09b9724674 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3240,7 +3240,15 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		return -EINVAL;
 	}
 	nvme_mpath_default_iopolicy(subsys);
-
+#ifdef CONFIG_NVME_MULTIPATH
+	/*
+	 * Default value of emwa_shift is set to 3 so that we can assign ~87.5 %
+	 * weight to the existing ewma and ~12.5% weight to the new latency
+	 * sample. This default could be changed through sysfs. This value is
+	 * used while adding latency sample for adaptive iopolicy.
+	 */
+	subsys->adp_ewma_shift = NVME_DEFAULT_ADP_EWMA_SHIFT;
+#endif
 	subsys->dev.class = &nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b438371b8494..95407c0f2f4b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -294,10 +294,9 @@ static void nvme_mpath_weight_work(struct work_struct *weight_work)
  * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
  * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
  */
-static inline u64 ewma_update(u64 old, u64 new)
+static inline u64 ewma_update(u64 old, u64 new, int ewma_shift)
 {
-	return (old * ((1 << NVME_DEFAULT_ADP_EWMA_SHIFT) - 1)
-			+ new) >> NVME_DEFAULT_ADP_EWMA_SHIFT;
+	return (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;
 }
 
 static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
@@ -389,7 +388,8 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 		if (unlikely(!stat->slat_ns))
 			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
 		else {
-			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
+			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns,
+				READ_ONCE(head->subsys->adp_ewma_shift));
 			WRITE_ONCE(stat->slat_ns, slat_ns);
 		}
 
@@ -1465,6 +1465,36 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
 
+static ssize_t nvme_subsys_adp_ewma_shift_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return sysfs_emit(buf, "%d\n", READ_ONCE(subsys->adp_ewma_shift));
+}
+
+static ssize_t nvme_subsys_adp_ewma_shift_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int shift, err;
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	err = kstrtoint(buf, 0, &shift);
+	if (err)
+		return -EINVAL;
+
+	if (shift < 0)
+		return -EINVAL;
+
+	WRITE_ONCE(subsys->adp_ewma_shift, shift);
+	return count;
+}
+
+SUBSYS_ATTR_RW(adp_ewma_shift, 0644, nvme_subsys_adp_ewma_shift_show,
+		nvme_subsys_adp_ewma_shift_store);
+
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5baf0232726f..9f5b233c747a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -450,6 +450,7 @@ struct nvme_subsystem {
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
+	int			adp_ewma_shift; /* used for adaptive iopolicy */
 #endif
 };
 
@@ -1043,6 +1044,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
+extern struct device_attribute subsys_attr_adp_ewma_shift;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 1cbab90ed42e..cf9711961b00 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -917,6 +917,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_subsystype.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
+	&subsys_attr_adp_ewma_shift.attr,
 #endif
 	NULL,
 };
-- 
2.51.0


