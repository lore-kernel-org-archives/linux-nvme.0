Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605F6CD4851
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKC93XJePQ90P/jOW5trsNHTQdfP1qMz62vUor7oORs=; b=Qi+nH/gJYiJrUPLehq1ub2b3tz
	yMs2YNWZj65Tw3mAC317LgvPndPYsaLKv4O9GCy/Wcfu5yZyA+4sIRYw1UTmCdRnMRXIWQ/pdNzqj
	2NvvaB8k4GRy7laBxj2G2YIM3HAGeBMUYukzqGNBLH6hoM7AVCOdrHDxts6jRdMG51qi9Px+KKReI
	ruG3LADejIzzdk2nv++qe57tzzspZmNYwOAADNNkUA6YTSrAlM7R4Glr4Ugsb8OhAU/miJ2XhEOoU
	QTzZtRs2nJMmgzFMdI8lgGwA95hwJF4A2PH04ID2Q/bDmughWz2E3igsseOnIao8ZtL5hHNLrE6SD
	ZHslszJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtq-0000000BE8y-3L2A;
	Sat, 16 May 2026 18:38:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJto-0000000BE5e-2Mof
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:38:10 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GAIRdC2038735;
	Sat, 16 May 2026 18:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rKC93XJePQ90P/jOW
	5trsNHTQdfP1qMz62vUor7oORs=; b=oXbCNHUuWsDs51H6XwkkK2JGOdS5BP04d
	Qz6CeBwzZxe7K7fDL4kjTwzSyIHBzOLzkmykGgmT3FJiv9+3eXX6aDjNXcN0q0A/
	Zpp1g98L+XUFoSeoP7I1ZTW3s1Y05wjHgzCmcuIDBnBitoOGBZsrZ1LruTj5zAbl
	51hTnLU5etk8GxKzNUjtkLlQwCbWTk45Da81OvULLgead9fNo0dqYH7PNGqNFSjX
	7t3VBHLYg6EtgqUG9LpV0PASkqYo9fseMMyhOPYOt0vl4WXdudEk333Tw45asYU0
	b2xkXYwcmKW/dUTwB6ABtSQiV2jftE7Ll6EqYFdmjTC/UxrmxPlWg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h881s0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:38:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIO9Uh022630;
	Sat, 16 May 2026 18:38:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcgskn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:38:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbxDV56426894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:38:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC10D20043;
	Sat, 16 May 2026 18:37:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11C2320040;
	Sat, 16 May 2026 18:37:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 8/8] nvme: export controller reconnect event count via sysfs
Date: Sun, 17 May 2026 00:06:55 +0530
Message-ID: <20260516183709.269937-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wn-rP1Rcn2tHvBpsAvL9EyZevpZEHNR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfX6IEpsGij4z5+
 tKvBHT07bfxFc/MBENxCcdTdmB+UucBFk2X0vvNLMFiewCYSfZHh4MZiUBWCWaFoslkYmoAcs1B
 q/MH3TUVQvkY8qEaFSTCf5td2lYjJ+SNVB+53YFNjaaQ0BHKldw10HFUEWjBhxQytzUIN2ULYUe
 GeEkyzKOw+/oPpTyGs4+6G782QZChGui/5/tXqAXFs9ATTqBvh6FTspcV1UsxsHD1HtDl1MglNA
 lVDeYVlo2DdTlW0fYA0zreJheZooK6B5gEfmMWl5Hpj7blo14nWqquCSEwviS8beaNBoH62q+Xa
 dKwlb++AxL6A2zXudaZNeg8fD3p5a1mxPmWMA3SfxnRB4tAQ8QCavLQjnS6UQmCNZ5bYKf1B9Xp
 vQ2CgH1y0y7L+TFGcylOJvXdZpUqDps6X64Di2kGuAC2K1lNsvr5dsZBHYWIlc2PuYz1PwAm9fW
 fWhOLqp6/aGlf6EmkfQ==
X-Proofpoint-GUID: Wn-rP1Rcn2tHvBpsAvL9EyZevpZEHNR2
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a08b98c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Rlo0OVkAtE1nHRIjL7IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113808_779500_620DF892 
X-CRM114-Status: GOOD (  20.08  )
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

So introduce a new accumulator which accumulates nr_reconnect attempts
and also expose this accumulator per-fabric ctrl via a new sysfs
attribute reconnect_count, under diag attribute grroup to provide
persistent visibility into the number of reconnect attempts made by the
host. This information can help users diagnose unstable links or
connectivity issues. Furthermore, this sysfs attribute is also writable
so user may reset it to zero, if needed.

The reconnect_count can also be consumed by monitoring tools such as
nvme-top to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/fc.c    |  3 +++
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/rdma.c  |  2 ++
 drivers/nvme/host/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c   |  2 ++
 5 files changed, 44 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e4f4528fe2a2..f04eb13dd5e9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3148,6 +3148,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		goto out_term_aen_ops;
 	}
 
+	/* accumulate reconnect attempts before resetting it to zero */
+	atomic_long_add(ctrl->ctrl.nr_reconnects, &ctrl->ctrl.acc_reconnects);
 	ctrl->ctrl.nr_reconnects = 0;
 	nvme_start_ctrl(&ctrl->ctrl);
 
@@ -3470,6 +3472,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
+	atomic_long_set(&ctrl->ctrl.acc_reconnects, 0);
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e575bef99d4a..22535328fdd5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -456,6 +456,8 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	/* accumulate reconenct attempts, as nr_reconnects can reset to zero */
+	atomic_long_t acc_reconnects;
 	unsigned long flags;
 	struct nvmf_ctrl_options *opts;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..de45fefdc15e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1110,6 +1110,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
 			ctrl->ctrl.nr_reconnects);
 
+	/* accumulate reconnect attempts before resetting it to zero */
+	atomic_long_add(ctrl->ctrl.nr_reconnects, &ctrl->ctrl.acc_reconnects);
 	ctrl->ctrl.nr_reconnects = 0;
 
 	return;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 72300d6de880..9c15e7d869ed 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1094,17 +1094,52 @@ static ssize_t reset_count_store(struct device *dev,
 	return count;
 }
 
+static ssize_t reconnect_count_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n",
+			  atomic_long_read(&ctrl->acc_reconnects) +
+			  ctrl->nr_reconnects);
+}
+
+static ssize_t reconnect_count_store(struct device *dev,
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
+	atomic_long_set(&ctrl->acc_reconnects, reconnect_cnt);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(reconnect_count);
+
 static DEVICE_ATTR_RW(reset_count);
 
 static struct attribute *nvme_dev_diag_attrs[] = {
 	&dev_attr_adm_errors.attr,
 	&dev_attr_reset_count.attr,
+	&dev_attr_reconnect_count.attr,
 	NULL,
 };
 
 static umode_t nvme_dev_diag_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (a == &dev_attr_reconnect_count.attr && !ctrl->opts)
+		return 0;
+
 	return a->mode;
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..ab9d19497b3f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2475,6 +2475,8 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	dev_info(ctrl->device, "Successfully reconnected (attempt %d/%d)\n",
 		 ctrl->nr_reconnects, ctrl->opts->max_reconnects);
 
+	/* accumulate reconnect attempts before resetting it to zero */
+	atomic_long_add(ctrl->nr_reconnects, &ctrl->acc_reconnects);
 	ctrl->nr_reconnects = 0;
 
 	return;
-- 
2.53.0


