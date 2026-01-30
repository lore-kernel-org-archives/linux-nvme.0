Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5214E6BF2F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eGWPlZKnPgr0fGlFqfFbxHQKh31+i03h4+gDSE0vA5Y=; b=4+44NzLlv27m6dlCurFSRx8O+x
	6mqiuHV2fSlz6mvMQKZ66hGfhMk2KB9UJUWkvyYTfJZYj/9A05qAJHdwKyzRpsv0ItmsQRWQsPHCh
	p0/zFk3NnNStTlHJ9NsLAIKM1X7q0ndQYH5NYYYZe9jDOkoRJ0k4z4YXW2ojWXhByDz1hCH7OnNRr
	au8N7ZUIq87sK6lzRxmTo408qDGhs5IfuBYtjQV75dtgY5uw3qMJyLo5TzqqMuTdzUTo/naA8Urxt
	PiNdeWa9PBXw0gbWHaGHBO1gnG4U48xyRNj25JtprD02pXNWKBI18vPyyhTHydr2RJKfC+pKhh4IE
	41bJkVRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7Q-00000001p6L-1BbY;
	Fri, 30 Jan 2026 18:21:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7O-00000001p4H-2KB0
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UHw632029468;
	Fri, 30 Jan 2026 18:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eGWPlZKnPgr0fGlFq
	fFbxHQKh31+i03h4+gDSE0vA5Y=; b=cADyvvfjdI4R0Wf+YQYT7AZtWLhT/eP0i
	MZNbizO4nApMenI2isI8pegLBb2oaOzG4F4zICbNiDPuR4OWze2eS4Wz9O14KMXF
	yuh+jlM7Ko7lllNisH9gnM7HWUQyuTZEak5tpZp+PCvj/7KNNI9MKxkLyynZGRuU
	kZtZK3JUqA+UmwaulXD7bR1AZqpiQMUu0czjVDPibAdkVw45u8UzM/ySS9+rWTH0
	R09M+VFlsYmNuigIj+r0PCRtbaIBQSu6VDI6Vg0sst8R921I9VQqh5HJ94V7vZJm
	HALtwCkwLS8V984hUN3++6oqcKzjwizD7a7ZGnRYg4kel9JJmxxmg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt87d8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UHmiel017966;
	Fri, 30 Jan 2026 18:21:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb4272gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:21:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UIL8ai22544684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:21:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07E5C2004B;
	Fri, 30 Jan 2026 18:21:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0495A20040;
	Fri, 30 Jan 2026 18:21:04 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:21:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 5/7] nvme: export I/O failure count when no path is available via sysfs
Date: Fri, 30 Jan 2026 23:50:22 +0530
Message-ID: <20260130182028.885089-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9c1KRAX6UsfwX_Z7oFnEpvN3kh0aW_KJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfXz+Jf3WjJAW7d
 PYmHxcg8rQaayxTPZc1kKAJ7yM1tqlHCsgkWvuo1ZFBdBsHx8m7ZPKgy7vcSOJFQO2Dho3xgM80
 JezQxeQ5pqaPe5Hv9qFXg9bEOuQOVRlGAWzc/1PHeYsSeg/uFol2o04YE6FMprEI2Y8deiUlQzm
 OiRboItbHKEYinb5CUcTV72mj/2h53NjswL1sdfrBqjHAP6cKqNTGWZJSzFFhtDe4T4HDUrL/sk
 MkortPU+vZIh1H98H9eRIR6uYLIE6ecE/r0v/mMmBxJUyw9PebLd3kdow6lDcClRhM+K/0qg4Fw
 qeLnY7lsQb1VnjmwWQ4a9NwPES0ZINJ8WuXo2Ha+aB53p2vyu6LQDpMRAc0+1cIOAp0fN2iXle2
 DfeTqlRXgyG1ex11D1DsYOVNEBPSqft3KqUL3jdQj+KpplIPZS99TTmHwtUUZlQtelGx9iU3uiq
 OQu5rjEhcQ9B7NwOsEQ==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697cf698 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6zb8lMvYnNi-4QC_6R8A:9
X-Proofpoint-ORIG-GUID: 9c1KRAX6UsfwX_Z7oFnEpvN3kh0aW_KJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102118_596906_72DCB119 
X-CRM114-Status: GOOD (  17.12  )
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

Add a new sysfs counter, fail_no_available_path, to expose the number of
I/Os that failed due to the absence of an available path. This provides
persistent visibility into path-related I/O failures and can help users
diagnose the cause of I/O errors.

This counter can also be consumed by monitoring tools such as nvme-top.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 11 +++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 4e5f8523ca40..85641e8852ad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -544,6 +544,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
 		bio_io_error(bio);
+		head->fail_no_available_path++;
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -1189,6 +1190,16 @@ static ssize_t requeue_no_usable_path_show(struct device *dev,
 }
 DEVICE_ATTR_RO(requeue_no_usable_path);
 
+static ssize_t fail_no_available_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%llu\n", head->fail_no_available_path);
+}
+DEVICE_ATTR_RO(fail_no_available_path);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5836e4c557a2..66bd4db1fe0f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -510,6 +510,7 @@ struct nvme_ns_head {
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
 	u64			requeue_no_usable_path;
+	u64			fail_no_available_path;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1007,6 +1008,7 @@ extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_requeue_no_usable_path;
+extern struct device_attribute dev_attr_fail_no_available_path;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 84d33445a578..c23d9a0ba3f4 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -285,6 +285,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_delayed_removal_secs.attr,
 	&dev_attr_multipath_failover_count.attr,
 	&dev_attr_requeue_no_usable_path.attr,
+	&dev_attr_fail_no_available_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_io_command_retries.attr,
-- 
2.52.0


