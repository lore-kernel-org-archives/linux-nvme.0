Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E35C5AD44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P01ck1uS5kRIgAFM1SKXB+hupmIDYlqzojZinxukknE=; b=QSs3OhcSXQqYCFNwF3oF3P0dx1
	xKs5wNi3VYeTYeXt7v8Av2Ga9Fpdy5fMRntjL6wYI6jmXBtcSh59Ay371FIe2Bjl8LMcQQE7k3/jc
	eJNRDfznL8RY/OrJ6fzO8ZkTnqYX0AxELlOfobc1HZExPnSLLKFvD3gAp/G/OF2hy0XF0Rj9vgThY
	LosMnYf7cEZbs5JvzQ//wd/EeP05d4hhSvam8FcsNl8kWEXt4PrnGJVrMnE1Rs7tbcE5Uwr9/WsrT
	ImWItia0g+lj5b56F3WnExuxaZp6XDPygX8Y0tigFtyiL5I2HU1ZR4JLIsBbCKBwf/CqZNT9mVEbX
	BGiIACsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUeo-0000000FP5A-0DYn;
	Fri, 20 Feb 2026 17:51:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUem-0000000FP4D-2ZDD
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:51:13 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEFkQe1273446;
	Fri, 20 Feb 2026 17:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P01ck1uS5kRIgAFM1
	SKXB+hupmIDYlqzojZinxukknE=; b=iKQKt/igBaWye+vCFII6rX/vNZSHW3PIc
	jFBG7HGv/wMOXNuWnmYH4k04MSzDSDmTo+iJ+5BlKzr2cv8sxFrCQ8Hie5MGAyNk
	ciFlhkEJE+PzrgsPdTFsKjjPEsNqSAWV/oSFgv3aiwAYWOpnVrWFVxBdLcqGR9H6
	twWzvmQRpSz5xq6XifBgF7cyVFi1q8db3GM2gNSPL0ZHdUxCh/6COBKMj/jOomCg
	twwL8PaG8PX5RXT+nHtOIhQbJWmWGMcMn3lXNIWY5CbtaaE890wqBXq9yVyxYz65
	4c6ScHfh27KmtbTb7zsLom7Jyse3oTekHqp9IHkfKcMPtnC+qfUvA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6v4brc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEQxSA001375;
	Fri, 20 Feb 2026 17:51:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bsc5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHp2oa50004334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:51:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60E4920043;
	Fri, 20 Feb 2026 17:51:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A06DE20040;
	Fri, 20 Feb 2026 17:50:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:50:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 4/7] nvme: export I/O requeue count when no path is available via sysfs
Date: Fri, 20 Feb 2026 23:18:49 +0530
Message-ID: <20260220175024.292898-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69989f0b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=N8iKQp9KpBaqfCmgdWYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX28tuH7urU0gv
 9vfBA1bRs5pgE9gpXMYMgQk+jbiZL8JGr8yshe1zcpFKyU7mOjZhlIAkoV0lH4uRMhMHNo3E22z
 LsD4ZMBB3ITL4coZXsPE1ThEl2Jlq37xcrC9SISly8cToRWkFKZ57PGmlXX5j7UrFrXieY0lax2
 5U4q6AABRpXnMPGkkSVFPMA3qI8b1NJo8SPrAdf+tBGUgq/pIsdzGSikgqOuyuDgmUMFzg2Y4Rq
 jGDCx5XDttzCoafwATXdWxHXDVuWS+awUBXHoX5vokvv6kzgz9hlYTDgzLRvg7Gh1L2AHzZ3oeK
 9CxHGNtww0u0LmXEsPfXRGDTnw90rSqiNyIRa4UMJywiHTCcVAn7ocoiLnCEEmK2t81QoLUKs5Q
 t/Db9GhdlSRB0+IitiCqNnnWqFRyiK6lDRQy+SuRLShOMogGTMUUnB0LrtjnO+qMSdW6i3iJbR7
 5kubsFO14o6qjs0bw2A==
X-Proofpoint-ORIG-GUID: bhYgnL2KPijS07Iv07k5vx6g11soGQSu
X-Proofpoint-GUID: bhYgnL2KPijS07Iv07k5vx6g11soGQSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095112_653479_570B1BCB 
X-CRM114-Status: GOOD (  18.97  )
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

When the NVMe namespace head determines that there is no currently
available path to handle I/O (for example, while a controller is
resetting/connecting or due to a transient link failure), incoming
I/Os are added to the requeue list.

Currently, there is no visibility into how many I/Os have been requeued
in this situation. Add a new sysfs counter, requeue_no_available_path,
to expose the number of I/Os that were requeued due to the absence of
an available path. This counter is also writable thus allowing user
to reset it, if needed.

This statistic can help users understand I/O slowdowns or stalls caused
by temporary path unavailability, and can be consumed by monitoring
tools such as nvme-top for real-time observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c8ae935658a4..c80d5e27d318 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -539,6 +539,8 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		spin_lock_irq(&head->requeue_lock);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
+		WRITE_ONCE(head->requeue_no_usable_path,
+			size_add(READ_ONCE(head->requeue_no_usable_path), 1));
 	} else {
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
@@ -1195,6 +1197,35 @@ static ssize_t multipath_failover_count_store(struct device *dev,
 
 DEVICE_ATTR_RW(multipath_failover_count);
 
+static ssize_t requeue_no_usable_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%lu\n",
+			READ_ONCE(head->requeue_no_usable_path));
+}
+
+static ssize_t requeue_no_usable_path_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long requeue_cnt;
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	err = kstrtoul(buf, 0, &requeue_cnt);
+	if (err)
+		return -EINVAL;
+
+	WRITE_ONCE(head->requeue_no_usable_path, requeue_cnt);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(requeue_no_usable_path);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 83b102a0ad89..39e5b5c7885b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -508,6 +508,7 @@ struct nvme_ns_head {
 	unsigned long		flags;
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
+	size_t			requeue_no_usable_path;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1004,6 +1005,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
+extern struct device_attribute dev_attr_requeue_no_usable_path;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 4012123be507..a4700ef9d18a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -316,6 +316,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
 	&dev_attr_multipath_failover_count.attr,
+	&dev_attr_requeue_no_usable_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
@@ -374,6 +375,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_requeue_no_usable_path.attr) {
+		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.52.0


