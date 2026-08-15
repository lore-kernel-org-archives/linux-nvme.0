Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F6C5AD5A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aEM9BAnivw6BIYG0aOqjQlE1hUkhd7XdOJXk3eg8bOg=; b=xuXQ2eNt++BdUr6snzDru2yEe/
	OMQyOUyKWHrY9XoHLH9BkWRUXKTnlZKt7sMpVu0Rrc3A/zzp6hn8IvUCqWWHzheuuBC5xf4755ngN
	3/AIU6/CxzRWPZlHa01Zh6BERVzZCimgU0ZzXAhFQdD6YqFbuNzkhi5FDX6o24oPQt5d3zhzRqc8O
	4TITixWOHSfOYxaa5Mk6K/YGybzUjoofFODmp9m0v2WatHpWlDWv9ZiFGL3hi4X7AMYyET+9TruND
	6a7bK8Fa1cbf2dAKVbBsnDEZTYzW97oVHZ8d2cnR7J79wfTBvlZsrJJsVA50emYaCEHEnA3+2Q5Xs
	TeNqFLuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIx-00000003zvB-31uR;
	Sat, 15 Aug 2026 17:36:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIt-00000003zsI-3uLF
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:36:21 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVV682639848;
	Sat, 15 Aug 2026 17:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aEM9BAnivw6BIYG0a
	OqjQlE1hUkhd7XdOJXk3eg8bOg=; b=ZcO6OoXettgFEX2Z7hQjLFrK8ba2szVeA
	shHRx7CZELar0AApBH7Y5TobDl2BIGwG7e0DyQ+E5AJYY6J3DjQ5FcxkJ3RK0+h6
	V8vmDP2q+JKof3l+CuiG9pa0RfDu1BlMIUvaf2cQJ430eppeRnW7HzzOqGz2i0zK
	4lcl1FGuNHPVl12w9xRKsDWB3NPlhUeBrfh/bdatINzdDH8HFdJTQ9FN8aAbGqkP
	Yr4eujLYYU1sgO+9lvavMqwr0fgn1Yeg2xHv4n+v+AERylPox/gag3IIOCy8j5mJ
	ClUIUTH6wqbySh+Ify7HrYc3ZcnbOspvEHNoYWAqz1HSyAjLOYZPQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqa7hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQLc7032045;
	Sat, 15 Aug 2026 17:36:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hm0cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHaCgh41877950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:36:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 036D020043;
	Sat, 15 Aug 2026 17:36:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1A7320040;
	Sat, 15 Aug 2026 17:36:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:36:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 08/10] nvme-multipath: add debugfs attribute latency_batch_timeout
Date: Sat, 15 Aug 2026 23:04:30 +0530
Message-ID: <20260815173502.1185929-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX2HFc+nYhi5Yo
 mlFoX+4h6ZFChQ9dOUeKTMMRzxwNxnwPPhnmAdqzZYeOqtMbtqZ5i49OrO/8S/l7uwZtcmgMziY
 uIxUoR4GuSYMlfUeOOajjU+AC+wHWlWKDTqwe+I97ovG8iAGmov0H7F5oVekF3SoLOE7JrLJhy3
 BQw/A3oPoMzvtHPyM3QL06P9KOSERKSYIbMKFuJNfpX8ZVh9nTIXQlbp0nvSBm1TXtw8PYpU4vE
 D7gPXHEvhAyE2SYw0dTGrvs7FQCkWkR/FTbNAQko6GypSC6eKvP6UTSqpQ1qT1/b0MnznhKm6wl
 6WV8p04/InZVw/+/lcPcXLk6O5uhmLKumfOGzNPG/IVpujNSb1/9vmKoszQ94j4G492oDSCqdN+
 AA4sVtSThb8/D/xaDbXNb8aYV5Z6ih6q5XQMQgCXuyv+HPbRFL9KhY27kuzB7vydr/eKO69qw9y
 P3aUpE38334GUDAmuqw==
X-Proofpoint-ORIG-GUID: wBP14W7jRznAmjd6VWv7UHbn1slDoNQY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX0s37CDcEhxde
 4uxYcmMgHOz7ZmFVGxyzVjX7kkxk5P+VdG9DhG0kN5a/y6KfNY3+iGCZiys1+2Sg6pRBCqbO8bN
 qwig5u1hEBsXuz5qT1/VzrLUGxu1hvg=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a80a38f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=3Tk138P-CERNP3DrbOAA:9
X-Proofpoint-GUID: bZlcgsBcaUobsBb6pI9W06ni1d6ZaiIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103619_978798_E894E057 
X-CRM114-Status: GOOD (  19.41  )
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

By default, the latency I/O policy accumulates latency samples over a
15-second window. When this window expires, the driver computes the
average latency and updates the smoothed (EWMA) latency value. The
path weight is then recalculated based on this data.

A 15-second window provides a good balance for most workloads, as it
helps smooth out transient latency spikes and produces a more stable
path weight profile. However, some workloads may benefit from faster
or slower adaptation to changing latency conditions.

This commit introduces a new debugfs attribute, latency_batch_timeout,
which allows users to configure the latency batch window and thus path
weight calculation interval based on their workload requirements.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c   | 37 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  8 ++++++--
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index ca1a670bea78..b8850d37edce 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -149,12 +149,49 @@ static ssize_t nvme_latency_ewma_shift_store(void *data,
 	WRITE_ONCE(head->latency_ewma_shift, res);
 	return count;
 }
+
+static int nvme_latency_batch_timeout_show(void *data, struct seq_file *m)
+{
+	struct nvme_ns_head *head = data;
+
+	seq_printf(m, "%llu\n",
+		div_u64(READ_ONCE(head->latency_batch_timeout), NSEC_PER_SEC));
+	return 0;
+}
+
+static ssize_t nvme_latency_batch_timeout_store(void *data,
+		const char __user *ubuf, size_t count, loff_t *ppos)
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
+	WRITE_ONCE(head->latency_batch_timeout, res * NSEC_PER_SEC);
+	return count;
+}
 #endif
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	{"latency_ewma_shift", 0600, nvme_latency_ewma_shift_show,
 			nvme_latency_ewma_shift_store},
+	{"latency_batch_timeout", 0600, nvme_latency_batch_timeout_show,
+			nvme_latency_batch_timeout_store},
 #endif
 	{},
 };
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 82a4f2326b79..a4cca27e8eb5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -362,8 +362,11 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 	stat->batch_count++;
 	stat->nr_samples++;
 
-	if (now > stat->last_batch_ts && ((now - stat->last_batch_ts) >=
-			NVME_DEFAULT_LATENCY_BATCH_TIMEOUT)) {
+	if (now > stat->last_batch_ts) {
+		u64 timeout = READ_ONCE(head->latency_batch_timeout);
+
+		if ((now - stat->last_batch_ts) < timeout)
+			return;
 
 		/*
 		 * Find simple average latency for the last epoch (~15 sec
@@ -1171,6 +1174,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->latency_ewma_shift = NVME_DEFAULT_LATENCY_EWMA_SHIFT;
+	head->latency_batch_timeout = NVME_DEFAULT_LATENCY_BATCH_TIMEOUT;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55e4d1344e5e..133a22611597 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -627,6 +627,7 @@ struct nvme_ns_head {
 	atomic_long_t		io_fail_no_available_path_count;
 	struct nvme_ns * __percpu	*latency_path;
 	u32				latency_ewma_shift;
+	u64				latency_batch_timeout;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.53.0


