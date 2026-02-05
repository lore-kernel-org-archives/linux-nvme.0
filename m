Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14BEC1EB1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NfEHNuRYIgB1FHaSXS+32Er6Es43D7Lh/L1gUfPx2JI=; b=BcswhozK+0xI49MKxMYCG1T5CI
	xEkYpN/D1VgEQEruDhPi0F1Cp3f+fd8cNdqbVjSquHiDcrP+IYXgVcVs2WfRmIV7t+B98NlZJ3jxf
	LHrp/FeuNFRJfzQodaMepXBVapevLn/OhQJ82KqBLsEeUsUs7aUmoHmzqQTW3q8BBVQFqXkics0fN
	yX34bvGyYBByFYTAcef0QUUxwZcVcchgHikLb7rGRYz0b47yDJ7yfzRCxpwnBGPJZH/Jj+eUyJqy9
	rw3EskCg/vcYZR3i7cBm0pW5vQJUp5GncDrt9zJCceCDAikCkBEl3ejKaAY9AweKwG82Uip2X0bct
	6ajlpt/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymq-00000009tfW-3QKb;
	Thu, 05 Feb 2026 12:48:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymk-00000009tej-0aLS
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:39 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6157Hx9f023156;
	Thu, 5 Feb 2026 12:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NfEHNuRYIgB1FHaSX
	S+32Er6Es43D7Lh/L1gUfPx2JI=; b=W38xUfmvPpYhylNlJJVYUi5PG5Cq5SCUH
	3rhiBo1OWiix+sQ4kN9hPs6proLltj2iuBVydQnvRBf1Y2ZDFwxRlhBYy+aQIhkE
	t2TdFPxstcg0XYEjee33R6dGswK3z3D5TmgNqEFYUEGOb0nLMOxRX9Bujg0iKDHT
	5Gm1CCfBGVvkXE1fos4RBEPhwaZBCilR9U8eWx/Fw1gHNymn0mDR4vOWq4v563Qq
	gmwUoewPuZvu3JHqKxNa4gEY9WBv+Ad0EZp9fCPLCDNhHX8Auxxh6omtX3mP0OGl
	EBoNXm6fLocAErVQ/PMeVXxMJPVPL4GYjJ3hwtgC6IOOasrowP+mQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwbtbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615BCNrv025706;
	Thu, 5 Feb 2026 12:48:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2n1reh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmR3A47251852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C552004B;
	Thu,  5 Feb 2026 12:48:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6564D20040;
	Thu,  5 Feb 2026 12:48:25 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 2/7] nvme: export multipath failover count via sysfs
Date: Thu,  5 Feb 2026 18:18:01 +0530
Message-ID: <20260205124810.682559-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfX7utympANIuh9
 jXB1pz7w6WIVnfgClGV6cjzsU4CbmfXjbWuYd7bxOo2sx245tIH5lCMbzOFKVcbe2bHN8ZhalIY
 Fdwzzt3zH47hXjVVMRJ4zD55lb1pkQS0EtY7eoWpHkjGeH/tiuqLA2WdprrosU23gVUn9vVBQLg
 QMzQfKL9YxOH7Nq1oNbNNf3UPyivhjcQkeqUG2eRXXSeHJ/89Dm8srWRx7QMzFQ/2W36o4QWmJC
 rXpyiQxmpE2tRrfokRxde2uQ9uzPmzJGEVgNjfuWCJF5evUnfvAezwkMBGaRz8ALlbiJ6PuXyjT
 FD4tX7hi9oWNX1zTOQNFWfAFugWkeuBENLp4ooL4QlqgsaLRaD2kRtZa6lYArxu/vuwPDJzFizz
 MnXfYc31/1cPb5ntIyBkdPZK312ykdvVCjVKNkry0RB5rX48EGf9E9OxtCkpULR9GPhIVXNudO/
 6vyY3lB0bWgdvMIy1gg==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=698491a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1zOl6gyKi9DvVLTnCpsA:9
X-Proofpoint-ORIG-GUID: -bQfGPWf0jNk0ErHXpUIQCANgGN8aN2A
X-Proofpoint-GUID: -bQfGPWf0jNk0ErHXpUIQCANgGN8aN2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044838_322715_7FC15418 
X-CRM114-Status: GOOD (  19.72  )
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

Export the multipath failover count through sysfs to provide visibility
into path failover behavior. This statistic can be consumed by
monitoring tools such as nvme-top to help identify paths that
consistently trigger failovers under load.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 174027d1cc19..792385477211 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -142,6 +142,7 @@ void nvme_failover_req(struct request *req)
 	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
+	ns->failover = size_add(ns->failover, 1);
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
@@ -1168,6 +1169,15 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t multipath_failover_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", ns->failover);
+}
+DEVICE_ATTR_RO(multipath_failover_count);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 237829cdc151..6307243fd216 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -533,6 +533,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	size_t failover;
 #endif
 	size_t retries;
 	struct list_head siblings;
@@ -1000,6 +1001,7 @@ extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 174d099246b4..34dcb6db9b5c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -270,6 +270,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_multipath_failover_count.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
@@ -317,6 +318,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_disk_is_ns_head(disk))
 			return 0;
 	}
+	if (a == &dev_attr_multipath_failover_count.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.52.0


