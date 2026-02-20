Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D31C5AD46
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxgwZDyk2Ay0cZeXVBoht8YTN8INxzRdMbCXTcuJKdg=; b=mCLyO28t9KcApIiLeaJrjYfiOA
	WP2XSzNm9WQjBgf+2MS7pDTOrwLaeGplG7RqWqbKzxHAk133amtrC6O28D7GONjtDlRvjsx/qEwS6
	AxLrwtM03SZOylf5KWZ1sG/qmwj4ZTAWr4Co50H1u9fkkUf7Kicwu1chX4MJxnHx3XYytFjsYEIFt
	S6a8+iS1tU3mJf+fWNQUMKup54EOqpTSStaaQe8Y0kfsJV760FHW2QFrgxdUdmpE+AFFR0vm3wMo9
	NiJFbOr0viDrWOwZK9JblIXZE7L2+rEOXSqO6SnYbe634a5nMk9WeXIX8SthWjOsQenKnyXdKVj6s
	GSQEBXAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUeu-0000000FP8k-1agK;
	Fri, 20 Feb 2026 17:51:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUer-0000000FP7C-3LN8
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:51:18 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEnvkk1273920;
	Fri, 20 Feb 2026 17:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gxgwZDyk2Ay0cZeXV
	Boht8YTN8INxzRdMbCXTcuJKdg=; b=Dq2rf3sqPw2gB8396io8dfn/MdVE1Y6Z/
	8Y+XM87pAh51sKn/gzqCyFHQnfTgqNT3cvWqKI/WHOkHnlTC++urdEX2eiLJy3CH
	BMe3LZSbaf/mj+q5UMzA5eJRVzBt/9x+RGTSYFCd++klSPTrJaxOOesQXs91b8kM
	eTqJBDLD/uSjQZ6B1fNA6smIc5Loy53J5jCRDjw/7EQ7TsQr0i7/w7MG+VkaP6Y2
	miUiI9tt+EanLj34vwC1DwEHTGWfUWGoHo3GNczgv7xCJHmPUOWLujCq4XgrwWNZ
	9Z8199JBnZCCdY6HcOJ7Qx2PZ9zgc32hlwou55wKy6obrslKKpRXA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6v4brq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KFEdpw030615;
	Fri, 20 Feb 2026 17:51:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hcgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHp77h53019054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:51:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF63B20040;
	Fri, 20 Feb 2026 17:51:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24A8C20043;
	Fri, 20 Feb 2026 17:51:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:51:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 5/7] nvme: export I/O failure count when no path is available via sysfs
Date: Fri, 20 Feb 2026 23:18:50 +0530
Message-ID: <20260220175024.292898-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69989f10 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=qQBb9XtKKTvnMxOhsCgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX6JDw8cwnddk7
 jVYaVvPjzS9HW3+RvL6CWu+PDW0kmEzjjStZkIwTvp5Ali4QsA4LrwBJ2VMywWS/hGco5mzLwVi
 gx+QMnUb14oq5194FSkzklxx1q/5WFZKdVj2w94MkbIsGYccKFkmb30BaUuw05z6ntBWnqlXi2i
 20YzW02EdDrVlYI9jsg7hgxrpGpRRlOUbwNfsc5w6Tk8X92H7bmWqAg/x+9NXc3cDl8nt/PFwKr
 wwXezHbwlUqHyDqcoNu07AR+Q2kPWXHd9TkfJoNseNbwMmwWwH/nr6/PbwxxoL6h4X2TqdYet43
 pppQpl1+jyb32JCljhR3GIW6wIkP1tcUMswtaYjgyfnFCvcXUYr4/MaMDUt8vyrHUpOOsrHFQxC
 vvi+931rwz3xbm8UnvKnHt7LeIknHKvpeE6mZ4TMdEUh3vUocJg/eDGSJTAHPnc1VZ6XJF7sz8B
 rMxNYewTc9Ce5sljOEw==
X-Proofpoint-ORIG-GUID: 1wLAshLz0rHbNk36YlB-3wn5HS2OhfsD
X-Proofpoint-GUID: 1wLAshLz0rHbNk36YlB-3wn5HS2OhfsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095117_843128_A23EAD77 
X-CRM114-Status: GOOD (  19.93  )
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
diagnose the cause of I/O errors. This counter is also writable and so
user may reset its value, if needed.

This counter can also be consumed by monitoring tools such as nvme-top.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c80d5e27d318..a50845833c89 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -545,6 +545,8 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
 		bio_io_error(bio);
+		WRITE_ONCE(head->fail_no_available_path,
+			size_add(READ_ONCE(head->fail_no_available_path), 1));
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -1226,6 +1228,35 @@ static ssize_t requeue_no_usable_path_store(struct device *dev,
 
 DEVICE_ATTR_RW(requeue_no_usable_path);
 
+static ssize_t fail_no_available_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%lu\n",
+			READ_ONCE(head->fail_no_available_path));
+}
+
+static ssize_t fail_no_available_path_store(struct device *dev,
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
+	WRITE_ONCE(head->fail_no_available_path, fail_cnt);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(fail_no_available_path);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39e5b5c7885b..b1ce2857899a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -509,6 +509,7 @@ struct nvme_ns_head {
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
 	size_t			requeue_no_usable_path;
+	size_t			fail_no_available_path;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -1006,6 +1007,7 @@ extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_requeue_no_usable_path;
+extern struct device_attribute dev_attr_fail_no_available_path;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index a4700ef9d18a..790bf875dd1b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -317,6 +317,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_delayed_removal_secs.attr,
 	&dev_attr_multipath_failover_count.attr,
 	&dev_attr_requeue_no_usable_path.attr,
+	&dev_attr_fail_no_available_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
@@ -379,6 +380,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_fail_no_available_path.attr) {
+		if (!nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
-- 
2.52.0


