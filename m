Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993EDE6BF2F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZmz2Pu5jh0W4q/caBiS/qnWflsSXIAuDaRw+5gwzU0=; b=u17A8hWCMXDv6iGOYQk6PWPUs4
	+GrRaKjh+sf/myg/rdWeRP6/0VvLhbcpe2ymqffMQ4d+enRFEGBZ+hgTdPfpaqZ40aU+oGFGY/I85
	naV9T2GHx3a8h8jApIuxYGOCD38N4AQIwICENwf7SD+PnYajnROhya193VTJKio7I4qoyhvnISdjO
	AbKiyOtWGM7pBEV5r7BD2ZSVn6rjU50vrKXmXELem6mLr8t4UlQvMgg+oH+MAhS90INHC07ufAU55
	sE36/97ZmijzBF+CRWh/fSUvUfMpj/iD0XCb3dwPpX1PCkG5UudKgL7fKxnEEO7bkAsvYdJoN0L4O
	uAeujutA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7I-00000001p1V-3l1D;
	Fri, 30 Jan 2026 18:21:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7B-00000001oy4-3V1R
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:07 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UH4a4g011191;
	Fri, 30 Jan 2026 18:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KZmz2Pu5jh0W4q/ca
	BiS/qnWflsSXIAuDaRw+5gwzU0=; b=bQVL/yQfpbqYe83BFNa5w7jV9khkPB9D8
	dVwV3rP3+uyBLsCyBhsCpFbCp8ecloJ8ziVCFdMyH8FXCtR5fgT6O0Atv8evRHeN
	6kj77M8gm2n8mI23gzpgr7fvlbI6k5yWK3pa5yH5eZ6xPqcWLsqYVyx6S99Ydoxe
	zxpb+YaRXrjEuW54h5oVyEg3lxlOqY33ogTApRJNpFL5KGGELi0lg0nSQ+mAtFkQ
	qbV+YdK15c17IWBwWlAUcmYViQ5YjgQwCV0bKa05HmnciRXcfpO1Bn7TXL2uABfV
	qy4ZIgc/0iDJEEUiW+l9v+MaKfxYSZ5BJ++fr7GpnVCgZlgau4N3A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmggc55t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:20:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UHOvLp023635;
	Fri, 30 Jan 2026 18:20:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamk75v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:20:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UIKsbS29294892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:20:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7968B20040;
	Fri, 30 Jan 2026 18:20:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20DE20043;
	Fri, 30 Jan 2026 18:20:50 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:20:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/7] nvme: export multipath failover count via sysfs
Date: Fri, 30 Jan 2026 23:50:19 +0530
Message-ID: <20260130182028.885089-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130182028.885089-1-nilay@linux.ibm.com>
References: <20260130182028.885089-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697cf68b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1zOl6gyKi9DvVLTnCpsA:9
X-Proofpoint-GUID: uiDKRnxFeoHRriEotG-G3PUoJD5vVAgd
X-Proofpoint-ORIG-GUID: uiDKRnxFeoHRriEotG-G3PUoJD5vVAgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfXxAoLpHG9KWpI
 gPc7+ech/kJFdi2ad8o1Jn/pSn/QV3zKdproiul8MoUchW/6FtbrEdW9VoIH6iNTXnnsQgZORC6
 C+GSrHzYgoOwV7FNvO6MSrb9GYZETZpAEM19g3dF659E6fackspkHGQkl+FjsrUImpJiquxnSfu
 IirMtfKtlj6PiFW4lX/dKsLTCS8hOeRZ5gtq3upbAtCKzhV2q2mIYJeaf+DyByQSrEY9OrVD0U8
 yf+G/Z3I7pW/tj6otUIEIx9IX/v1CfEa39Wo7LXfUfOms+YhTEmbljDUURQsBLNZvLKK/4Fyive
 ZKsX394SY/8znb9FwVX6vTaR21MIIHWOvWzA7OZFKkgslAagQo2/952cjGQ0E8X4KEs3ieAlai8
 /5tmTGhAyr0v2oQyEVCoIW8J0oF2M7b7xLgMbhvB5DQ0j9OiDJ4HDXzRMooy95MZwwdiDNry7u5
 23rIASw0Qo1lwC/QH4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102105_987026_8A7561DC 
X-CRM114-Status: GOOD (  20.82  )
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
index 174027d1cc19..366b820e654a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -142,6 +142,7 @@ void nvme_failover_req(struct request *req)
 	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
+	ns->failover++;
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
@@ -1168,6 +1169,15 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t multipath_failover_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->failover);
+}
+DEVICE_ATTR_RO(multipath_failover_count);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d8a2831ed34c..119ba2344039 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -534,6 +534,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	u64 failover;
 #endif
 	u64 retries;
 	struct list_head siblings;
@@ -1001,6 +1002,7 @@ extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c1e27088a053..8fc593c36b74 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -272,6 +272,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_multipath_failover_count.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_io_command_retries.attr,
@@ -321,6 +322,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
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


