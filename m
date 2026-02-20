Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A4C5AD44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9OtTZ+iRenPWlLJ33ZhZisSqMeYpvODzfUqfMFlTMR8=; b=H/38S3Dl3Qr9KqXbSW03ZIRmLx
	HPGup+iJjCEegLq6xuQJ+JtzWmWvln6RfpmlIgvk9Q5W32MyzYx4+vvFYNy6/+NgZzqOpMI2mVl6r
	Z1OKdp53ejTP2u0aCUIjxdaBzuSGHsLVfiO7ehaKMmqwzK4+QnuvoQEx5b5dyHQvgeVWfyl2266rw
	+HzmOLfuJtUI0hkzFKUzVDCzBpknUFXfAJg/Q5gEhW4OvX+mX9cYqAzsRCvAitZbqoXN+XTW+0ZyO
	8hnSqt5AkSttH8ZMRB7JVaTxDdmxQTR3DIsZdr2i7cSkgXdccEzz4AVZ5lRw/e7+qczo07w/UML7f
	ZHE1GDIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUfM-0000000FPPD-2fQT;
	Fri, 20 Feb 2026 17:51:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUfK-0000000FPMz-22In
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:51:47 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KE9JQf1273842;
	Fri, 20 Feb 2026 17:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9OtTZ+iRenPWlLJ33
	ZhZisSqMeYpvODzfUqfMFlTMR8=; b=l1qrvWX9GLhzQZcQoUWY0C8mcLTMOhSMy
	MCahwp+ObtSJ3XtrsNdyOXRf5Lmfe3xDJzjIOk2QTTeyJ6u03W5N0QKGE/WsVXFE
	OD8oVt64MEiN7yYwXvDB4jnxLwdwXDFa0Q7oNQQnDnNGI1/rDafpodtE4G1ohA+T
	RSJA1lVTlhN/aTuwR91QhO05Lbq8JuNJA7aHxr5V9ElR9ZcjgVFDhhy83rPE4OSz
	4T6bHGBNum62JiPGRHzx8XpIxLiSYnOzoBT+lbpYnMRHqSdigcNLR3gSF0lwnUzq
	35EqBkEofXrLU8wJrSgsvt914FADA883XZn26TrA2uOn3iMtW4Eqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6v4bt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEpxjc017774;
	Fri, 20 Feb 2026 17:51:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28sbt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:51:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHpYu647251734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:51:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D72520074;
	Fri, 20 Feb 2026 17:51:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19AAE20043;
	Fri, 20 Feb 2026 17:51:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:51:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 7/7] nvme: export controller reconnect event count via sysfs
Date: Fri, 20 Feb 2026 23:18:52 +0530
Message-ID: <20260220175024.292898-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69989f2b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Rlo0OVkAtE1nHRIjL7IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX0c6E2u8dRWaL
 WdrmVN0AKTbuAVIoMbozNt/jbPpJJ5MjFXmGNvWq7vWBdNen0Vv1z15WkBdgKAHCXRcrrYafizW
 2dOXZcMOmvd0FOjUxrplo9sENDo2G7qxVbI8tbQuROX82/oCcazG3cKDq5/DHNL135txITw1Skg
 ssRj20wJdUNH7zvayET9a+XwUDpzRn3DfCpQR1pqCFVtb3c82LhRVN6Ofi3V83z3jMzvnHn3YLY
 r07YTO3KBEnJQs/LVS4npPhhujtXJF+9Yb0sFkXoltWGReAW/at485i6+8Echfyp+TEzUbWhLU0
 3OgNo9qwMmYQ1pfBfmSuhSKdyKPPlkwjoYnttdeIT5g59WV95sJjp2A54K3zogTUNTOYO1VhRTs
 HoziaoR/oTKlQVyGFrq4R37z5ubWIu+b+SvdxCqQTCZH81xqyPHYA4hvK+Rs55fVwXxWUGWkDC+
 WamDNPIcvD9MffbRfnw==
X-Proofpoint-ORIG-GUID: 2bJNkG093qb2Ct2SzpuWBu2je6_YN5AI
X-Proofpoint-GUID: 2bJNkG093qb2Ct2SzpuWBu2je6_YN5AI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095146_560548_D1B4495F 
X-CRM114-Status: GOOD (  21.19  )
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

When an NVMe-oF link goes down, the driver attempts to recover the
connection by repeatedly reconnecting to the remote controller at
configured intervals. A maximum number of reconnect attempts is also
configured, after which recovery stops and the controller is removed
if the connection cannot be re-established.

The driver maintains a counter, nr_reconnects, which is incremented on
each reconnect attempt. However if in case the reconnect is successful
then this counter reset to zero. Moreover, currently, this counter is
only reported via kernel log messages and is not exposed to userspace.
Since dmesg is a circular buffer, this information may be lost over
time.

So introduce a new accumulator which accumulates nr_reconnect
attempts and also expose this accumulator via a new sysfs attribute
"reconnect_events" to provide persistent visibility into the number
of reconnect attempts made by the host. This information can help
users diagnose unstable links or connectivity issues. Furthermore,
this sysfs attribute is also writable so user may reset it to zero,
if needed.

The "reconnect_events" can also be consumed by monitoring tools such
as nvme-top to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/fc.c    |  5 +++++
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/rdma.c  |  4 ++++
 drivers/nvme/host/sysfs.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c   |  3 +++
 5 files changed, 44 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6948de3f438a..a918217620d1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3148,6 +3148,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		goto out_term_aen_ops;
 	}
 
+	/* accumulate reconnect attempts before resetting it to zero */
+	WRITE_ONCE(ctrl->ctrl.acc_reconnects,
+			READ_ONCE(ctrl->ctrl.acc_reconnects) +
+			ctrl->ctrl.nr_reconnects);
 	ctrl->ctrl.nr_reconnects = 0;
 	nvme_start_ctrl(&ctrl->ctrl);
 
@@ -3470,6 +3474,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
+	ctrl->ctrl.acc_reconnects = 0;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5d90e5fa7298..9146d1b48606 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -401,6 +401,8 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	/* accumulate reconenct attempts, as nr_reconnects can reset to zero */
+	size_t acc_reconnects;
 	unsigned long flags;
 	struct nvmf_ctrl_options *opts;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..bd5492ad3da6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1110,6 +1110,10 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
 			ctrl->ctrl.nr_reconnects);
 
+	/* accumulate reconnect attempts before resetting it to zero */
+	WRITE_ONCE(ctrl->ctrl.acc_reconnects,
+			READ_ONCE(ctrl->ctrl.acc_reconnects) +
+			ctrl->ctrl.nr_reconnects);
 	ctrl->ctrl.nr_reconnects = 0;
 
 	return;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f3e6c7208315..166e45b589ad 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -736,6 +736,33 @@ static ssize_t reset_events_store(struct device *dev,
 
 static DEVICE_ATTR_RW(reset_events);
 
+static ssize_t reconnect_events_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n",
+			READ_ONCE(ctrl->acc_reconnects) + ctrl->nr_reconnects);
+}
+
+static ssize_t reconnect_events_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long reconnect_cnt;
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	err = kstrtoul(buf, 0, &reconnect_cnt);
+	if (err)
+		return -EINVAL;
+
+	WRITE_ONCE(ctrl->acc_reconnects, reconnect_cnt);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(reconnect_events);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -884,6 +911,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	&dev_attr_adm_errors.attr,
 	&dev_attr_reset_events.attr,
+	&dev_attr_reconnect_events.attr,
 	NULL
 };
 
@@ -913,6 +941,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
+	if (a == &dev_attr_reconnect_events.attr && !ctrl->opts)
+		return 0;
 
 	return a->mode;
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..46398c826368 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2460,6 +2460,9 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	dev_info(ctrl->device, "Successfully reconnected (attempt %d/%d)\n",
 		 ctrl->nr_reconnects, ctrl->opts->max_reconnects);
 
+	/* accumulate reconnect attempts before resetting it to zero */
+	WRITE_ONCE(ctrl->acc_reconnects,
+			READ_ONCE(ctrl->acc_reconnects) + ctrl->nr_reconnects);
 	ctrl->nr_reconnects = 0;
 
 	return;
-- 
2.52.0


