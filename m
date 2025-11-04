Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC18CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfGBVxnr+ETKpYgHlnuwjYgPQi6p9PwuHuOrK/bvmP8=; b=V5yG9JkpxfYAt21xrgFfod81b0
	xtt2jrBy4TGGs/OIEVqyGHleig2zpOvxh/TIgkGO/TUFJMShiL5d1OMtgPXt6P9WGK2PtVLmmTGnP
	zopZwvzq9ieQF4uBOQPk1h0BDHNC6CtF9eznFqY3uCIDMRBUp6bQzAmJDEOoPm+N+BJCOqXeYw7H1
	XNBY7AogOJ+ZbIRHYG8bywNCLFqRxny5xjQhwJLevOpzPGORbOuyZH4RH2jDA9iBoU++rAUgx1JtP
	mSpuHssgCdn1sWf17Km2NzcTgdZw754lSn0RatZsy573Bpu6iCN2hoBLjI/n8HiWEsc19UxkKtwxj
	lAhVHTwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEY3-0000000BdvY-0Ol5;
	Tue, 04 Nov 2025 10:45:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEY0-0000000BdsS-0rUx
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:45:57 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A43bVsD007179;
	Tue, 4 Nov 2025 10:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HfGBVxnr+ETKpYgHl
	nuwjYgPQi6p9PwuHuOrK/bvmP8=; b=kH6JIr1FW+Vd5Bxposz9c9tOxWleVgWkS
	UxBydUt9t1y/gUXReS5rOrmd932EivZ/CvdYJYwwy0RuaGJqoR4nv6GEQYwF5J3Z
	II2J3SNm0Lg82hjg8z4aVmfeH9QGWjyQgiBO5UT1JEEwlU0k09JLPDuULmlnJ6jx
	JhrjVQbhdZU1ssWW9gam+PCLo4hdN2kRIbUqv2+kolwAPCQMsi9UBqFsYFNTfUiN
	zBLIckcRbVP4qlEUp60lwOG9fNjeW1BE4ROfJUMTGvEbtdp/QnNb+lOpnGX3bTMG
	+l65Ri8K2+S1VMCEQQHQCxSS4uBsopuxNTlZTpVpCTkr/EpYol6mQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr3hrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A46e6TB009877;
	Tue, 4 Nov 2025 10:45:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kahbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4AjmWN15008060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 10:45:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DAEC20040;
	Tue,  4 Nov 2025 10:45:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9D4F2004B;
	Tue,  4 Nov 2025 10:45:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 10:45:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv4 5/6] nvme-multipath: add debugfs attribute adaptive_weight_timeout
Date: Tue,  4 Nov 2025 16:15:20 +0530
Message-ID: <20251104104533.138481-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104104533.138481-1-nilay@linux.ibm.com>
References: <20251104104533.138481-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kZhzmo9NHMgCdbFHeySDBGAdsl0YFWrY
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=6909d95f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=lAPw0pASQEPevriW-_sA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: kZhzmo9NHMgCdbFHeySDBGAdsl0YFWrY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX21Adt6GzbHif
 EuKDJVcWaK2UXNEf9D0KF+ap9H6BnCUPTTPzRHgASk9V0h803DJrT9HZS+1A5wXXZ7fnbr8POxs
 izgm66a2lxrud8Kd0c9AfHsUj7ImrLkDBo3XGWXv+DTBLckpOO0/X9ylwyysn8x0cQcfUYnMshr
 v2494zHXBEsw9yjNT+xa32rFTR4w2PBk2Dxn4O+S2IMrLeHfXN5Ncm2r+zVJ06bAueFbR65Un82
 lvxD2pVtYPdqxaR9FA6fTtnyOyJePmcA+0CoaH4lodLFZSVwz4iFWi0Je2DZxkqchMuS2D/dYFg
 tL01sduWdtoOz2CyUlWfQpdXZScfSRxfLtB2WJbEpAPWzJNLpp934iC/3dwUObn5PHAtA/xFUUI
 ZQXnrLBwhhaG5xbddFOHk36ijywIOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_024556_365641_3753DEDA 
X-CRM114-Status: GOOD (  20.41  )
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

By default, the adaptive I/O policy accumulates latency samples over a
15-second window. When this window expires, the driver computes the
average latency and updates the smoothed (EWMA) latency value. The
path weight is then recalculated based on this data.

A 15-second window provides a good balance for most workloads, as it
helps smooth out transient latency spikes and produces a more stable
path weight profile. However, some workloads may benefit from faster
or slower adaptation to changing latency conditions.

This commit introduces a new debugfs attribute, adaptive_weight_timeout,
which allows users to configure the path weight calculation interval
based on their workload requirements.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/debugfs.c   | 40 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c |  7 ++++--
 drivers/nvme/host/nvme.h      |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 43b9b0d6cbdf..d3828c4812fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3915,6 +3915,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->rotational = info->is_rotational;
 #ifdef CONFIG_NVME_MULTIPATH
 	head->adp_ewma_shift = NVME_DEFAULT_ADP_EWMA_SHIFT;
+	head->adp_weight_timeout = NVME_DEFAULT_ADP_WEIGHT_TIMEOUT;
 #endif
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index e3c37041e8f2..e382fa411b13 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -146,12 +146,50 @@ static ssize_t nvme_adp_ewma_shift_store(void *data, const char __user *ubuf,
 	WRITE_ONCE(head->adp_ewma_shift, res);
 	return count;
 }
+
+static int nvme_adp_weight_timeout_show(void *data, struct seq_file *m)
+{
+	struct nvme_ns_head *head = data;
+
+	seq_printf(m, "%llu\n",
+		div_u64(READ_ONCE(head->adp_weight_timeout), NSEC_PER_SEC));
+	return 0;
+}
+
+static ssize_t nvme_adp_weight_timeout_store(void *data,
+		const char __user *ubuf,
+		size_t count, loff_t *ppos)
+{
+	struct nvme_ns_head *head = data;
+	char kbuf[8];
+	u32 res;
+	int ret;
+	size_t len;
+	char *arg;
+
+	len = min(sizeof(kbuf) - 1, count);
+
+	if (copy_from_user(kbuf, ubuf, len))
+		return -EFAULT;
+
+	kbuf[len] = '\0';
+	arg = strstrip(kbuf);
+
+	ret = kstrtou32(arg, 0, &res);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(head->adp_weight_timeout, res * NSEC_PER_SEC);
+	return count;
+}
 #endif
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
-		{"adaptive_ewma_shift", 0600, nvme_adp_ewma_shift_show,
+	{"adaptive_ewma_shift", 0600, nvme_adp_ewma_shift_show,
 			nvme_adp_ewma_shift_store},
+	{"adaptive_weight_timeout", 0600, nvme_adp_weight_timeout_show,
+			nvme_adp_weight_timeout_store},
 #endif
 	{},
 };
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c7470cc8844e..e70a7d5cf036 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -362,8 +362,11 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 	stat->batch_count++;
 	stat->nr_samples++;
 
-	if (now > stat->last_weight_ts &&
-	    (now - stat->last_weight_ts) >= NVME_DEFAULT_ADP_WEIGHT_TIMEOUT) {
+	if (now > stat->last_weight_ts) {
+		u64 timeout = READ_ONCE(head->adp_weight_timeout);
+
+		if ((now - stat->last_weight_ts) < timeout)
+			return;
 
 		stat->last_weight_ts = now;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 97de45634f08..53d868cccbeb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -546,6 +546,7 @@ struct nvme_ns_head {
 
 	struct nvme_ns * __percpu	*adp_path;
 	u32				adp_ewma_shift;
+	u64				adp_weight_timeout;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.51.0


