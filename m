Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A3C5AD44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CP40/3NHUj1Feqs+upYzlhj8seW7T8lS861/j670pic=; b=CzCWZElxkQuJ9W2/QxB9UrRryf
	anbUVQOF24dwd246Obx7DLevfENGxUHhTbEqbuBviWU6Y0KZcGYgEwWe4+plu4Jb5QULK0pcLifAq
	U7VSMkjSDjpBo/12tDy8vpkRpQCYN1Bzd2vJHP41Gmh/tluz5kR3L+Hrf4lFpN3Nj/RJJ9yEjxuvX
	kiNKC3YmWRn8scLYUoy/LvYFUW/epfRd5NDUr0ia16M3mKek/5Vn4qh0AyJqM0Wzi+daYpkLDk1gd
	CWkL768Ie4IJlfCSXXfLM7fLtwGgrPk3i9jdbTKRZqnKtB+JCUuA97GDjW48mAR1iadkV3B327OIp
	20Srbazg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUee-0000000FP0A-12ci;
	Fri, 20 Feb 2026 17:51:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUec-0000000FOzK-2Wr0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:51:03 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEJVO61600917;
	Fri, 20 Feb 2026 17:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CP40/3NHUj1Feqs+u
	pYzlhj8seW7T8lS861/j670pic=; b=jOIFYnmHPHmZWHuUsDuE9jUAESAI496Wj
	PnETzwG+2rm/Zznp7GcLIf2PHLcYoVsM/AMiRMhAP0+es0R/3hds/d7bRxJPa5KA
	V/5Z7T0KzsQMUseehpNaAeSj7okV8haGbR5e1qOZEMevrW0SxjNt80bslMjsew88
	GSRCn3eHMI8GQGVxnJF8m5EJIBUutU6H+sWrFUJKtMFo2sdOdzvMVIXfsC4nQrwx
	CUBj7wjuslz+ds5lDLZenijMPYZT9pBrYC42ou4H2MQGJ9Q2HUspfKGCrayvMqh1
	ABN+VEYAaAYBIW2SJlAnNeyThXxQQB9ghFN8QPJk6+Udys/NFwZGA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcrccxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:50:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEqKwf023889;
	Fri, 20 Feb 2026 17:50:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hd6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:50:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHopBG32047394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:50:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBAA20043;
	Fri, 20 Feb 2026 17:50:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F99220040;
	Fri, 20 Feb 2026 17:50:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:50:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 2/7] nvme: export multipath failover count via sysfs
Date: Fri, 20 Feb 2026 23:18:47 +0530
Message-ID: <20260220175024.292898-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bcfZb8fORovVub6fKhpL3cpe8zH_HmEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX2qzpQUd3zBca
 xZjViv2g2euaJoP3yYk0tDt0ggTC2Jhi1lXfgdo3EGHRzs6jdcqzsiipYbYfSJgkK1f4R5OiVXL
 dj9Q/x3VZdx89EONqq/6WkcTEnEPictQR4c8SRcA72jrvVU04aOAKAYr/GAExX9quP+EhnLFhGm
 +KK8mWHWu1Ub1PTgR5t9K7ZhLO34Krz1PxGPBZb3mKsrp65DC3xNF96yS1keGX7EpNhrp1XOSks
 VJ6K+cUNsb4GyeGmvc1o5BsNLw1HFxPx7iUExt0r5devNtTsG0NeS5LbAwkoih+S2dvJ6ArI28/
 QBeWx9gPBEblmiWTUwntrOMB2Kf8fN9P6z57hXyJ+mi/mkSXq48+JTVjGoQIzyRfiX0OQOIO2I5
 OuM3Q6wIAJAHK76GCLLo0TEbPYU8b83NCDtbgtJOxJ8HvJdg7CFnSBw8rRdNfKkiaKDizBeDZ9i
 RCGMsoPBcAgDEBGQlhA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69989eff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=sQcIgm_-tj0529r869QA:9
X-Proofpoint-ORIG-GUID: bcfZb8fORovVub6fKhpL3cpe8zH_HmEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095102_646420_C8707BDE 
X-CRM114-Status: GOOD (  20.04  )
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

Export the multipath failover count attribute named "multipath_failover
_count" via sysfs which is both readable and writable and thus allowing
user to reset the counter. This counter can be consumed by monitoring
tools such as nvme-top to help identify paths that consistently trigger
failovers under load.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  5 +++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 174027d1cc19..c8ae935658a4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -142,6 +142,7 @@ void nvme_failover_req(struct request *req)
 	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
+	WRITE_ONCE(ns->failover, size_add(READ_ONCE(ns->failover), 1));
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
@@ -1168,6 +1169,32 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t multipath_failover_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%lu\n", READ_ONCE(ns->failover));
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
+	WRITE_ONCE(ns->failover, failover);
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
index 11e7016954a7..78c3a6f78ef8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -286,6 +286,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_multipath_failover_count.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	&dev_attr_command_retries.attr,
@@ -333,6 +334,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
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


