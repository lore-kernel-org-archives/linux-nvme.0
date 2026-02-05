Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA16EC1EAD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAfNQwaKffxP9X6b2cFvLlCDF3oCCPBZFEh9chaNCd4=; b=n5/r+ldPFBS033xSXAG2oxc8CD
	UgMbhRJxrs0VHwVMLTBjf2gD4j4WEaUSmd9Xl4OMTG91RvpsCVgTRgWdDQqBtww1xta07TPMCf0rv
	2T0+CTx8XSkCnqLVEIiVwLHtxcJ0tHDkX7rg3E3gzlFQRWHQcRxLG1eFsn7Kx+wsdcEEjDCBu75pc
	tO4oaR5mFNsO4tKvMfZB3koXSfbHjAqjAoQxWHoiolbmNx0KEsNmUTdxXF2i9U4OFnh+usdFirOT9
	bDeJeD+/edGZnDM/2DcLHzroomNQprrXfY0Ly3QJzIE7OpMQKCzOfB7TTI1DKPbTWmCxfU6ZSyqG5
	lJ9zcXQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnyms-00000009tiG-2IpL;
	Thu, 05 Feb 2026 12:48:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymp-00000009tgz-1UV2
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:44 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6157Iuru007240;
	Thu, 5 Feb 2026 12:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JAfNQwaKffxP9X6b2
	cFvLlCDF3oCCPBZFEh9chaNCd4=; b=h4DshsL0OARKXSfMrDbOCvwxOBUrd2IR8
	N7gKBPf4SzujSaEdh4Fjk/gvJiqO1cRyYvSbBnv0WgZIsp7MxFZlJDxWs0EHwAzB
	eOBxebq35X/awcDPwDNdxQQJCkOYACbJ0wvwrMgBzdh3TCkhDTrasBUtrPTwZTSs
	1J4yainbLp+vAqxYfwoDWaTqT3klbdAzcfb93cY53DsZ7cr8sdDaYs6N1iCdwYlZ
	V/34QTmzpCJY/a9g/lNKbas8KKdDML9mqdp74Pz7TRFb2ZOopcN7rpJknb5tVh7X
	It4bWDwxgoiuRmJTEQxQSOud+Mo+RqHoywjYJHyYY6YkRhpkvkjLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986ps8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615AaSue009544;
	Thu, 5 Feb 2026 12:48:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vey9vq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmWlT16187766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 510542004B;
	Thu,  5 Feb 2026 12:48:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE3920040;
	Thu,  5 Feb 2026 12:48:30 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 4/7] nvme: export I/O requeue count when no path is available via sysfs
Date: Thu,  5 Feb 2026 18:18:03 +0530
Message-ID: <20260205124810.682559-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfXwAmWInEAgXi3
 FYHSw2ItqGAI1aZO7uPeUCm23eA1xJDm8W8tOJPTE4wX/F6PL9fMg99qxswLhZhCarjrdrcZ41q
 dFHp+/RX26/jqnLOhNUL8Hj5JLH5vBbuj1Mf/63euxpIPWOmYgtzzYX2BZ652eLBE8/743Ar5N4
 7GzmP1zscezZ+IAQ3HCQ38ocPvDpHKn8nwmsAB4POR/89u5EYkCmKYtnWahZBFE6SGsAc5rZ5tQ
 XSIddqsHk+IBasc4oUCNt4pwW+EjPxTbSHtASjeUBeJ9crl2zmSL8GeUM1JCfPjrUt9yO0KiBWw
 Adzbr1v+rvjdRUTbTLxwI+OCT70kPlmIQw2WvJ8jxFBoBe1skwbIeHOzoF60yeLCAf9r9C8yj28
 h6rAZFxJTvxoVh26RL3ZQuFV/nRKl+fyb8wywaUBwINLN5SDyVZZEhNF+fyZC95wKWoCye6ksti
 7GyFmM1RnhkIVejzLZg==
X-Proofpoint-GUID: Iz8SPVaKOYaqdPMffleUew8GBAPs5EOL
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=698491a5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=OdKbmu6maCxnhc5y6U8A:9
X-Proofpoint-ORIG-GUID: Iz8SPVaKOYaqdPMffleUew8GBAPs5EOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044843_398200_4C08CDE0 
X-CRM114-Status: GOOD (  18.23  )
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
an available path.

This statistic can help users understand I/O slowdowns or stalls caused
by temporary path unavailability, and can be consumed by monitoring
tools such as nvme-top for real-time observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 792385477211..e0bfbc659963 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -539,6 +539,8 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		spin_lock_irq(&head->requeue_lock);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
+		head->requeue_no_usable_path =
+				size_add(head->requeue_no_usable_path, 1);
 	} else {
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
@@ -1178,6 +1180,16 @@ static ssize_t multipath_failover_count_show(struct device *dev,
 }
 DEVICE_ATTR_RO(multipath_failover_count);
 
+static ssize_t requeue_no_usable_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%lu\n", head->requeue_no_usable_path);
+}
+DEVICE_ATTR_RO(requeue_no_usable_path);
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
index 4690ef9a1948..a6b8539074ee 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -282,6 +282,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
 	&dev_attr_multipath_failover_count.attr,
+	&dev_attr_requeue_no_usable_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
@@ -340,6 +341,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
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


