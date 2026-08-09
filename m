Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BD0C5AC80
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L8gFT3BSZMdqiW7Iq95QlGf3x0mvXiTZZs3y3KGvn0E=; b=w+Q00/I/W+WB2ZebiAFHbH9mSA
	NWJgGAZJiUNj8vu2cODNVYKamshLp4l/fy9TwTcFdHmnUUsqka++6XRo3IraN+EQn8T73bstZFBWY
	mAR+VsyULMrBW8KQFSnvp7AhXW2AYEOm2FBd7L/b5WyBwXZqrZIoBl1RTcCvsEvOLvRN+y5W+dzz/
	OLNBpegJnTOrjS+GNSPcXpUqSVbvpMLFw9chFdnLGThkEXPrpIDm+vxmzV2EsRLVOTQ4qSxDSdo0P
	U4JQ7AlwCn7vZEoiH239MyfkFykt9PzwjeF6ASaQP+WjrPuohUouqRMTwgS9tn/9SiqWrA+gTs5lw
	jMa+mXWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0T4-0000000AArk-2GS6;
	Sun, 09 Aug 2026 10:09:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0T2-0000000AAps-0qxG
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:21 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991aht699800;
	Sun, 9 Aug 2026 10:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L8gFT3BSZMdqiW7Iq
	95QlGf3x0mvXiTZZs3y3KGvn0E=; b=NdvM7XwzQccm9zN2xGdC01JJyrQNSrS06
	yYeC1kLTYppOnW383+Jn5aoYff1wLKKVC5Z2m05aVe+K1J1lDaqzeuWNj+azigSY
	BH6jp1xiAVHmUWlJ+pYF5GX6Lq2tJsVBvoPzXaT2xyhHLAZc7X6tC/uk6Yca4nyD
	BcO3ckUmBYuVq8PfyyJoELHV50tS5of0KeOH5ouSBN0bz2432CwHj6sh5f3+4vPf
	UrjjO32XJiKc5DB7wqrTOsqIAdaWdOcuTYth7cTeir1PPpDFKJEmmxTvp2M+UZ8n
	yvV5vqZed3y9ZpelnhvV3DCEUXHvNZ4JQRtnurx+w2ksTXj30Btiw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjykvsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uMQ5030274;
	Sun, 9 Aug 2026 10:09:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vs47c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A99Uo39977300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:09:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3048A20043;
	Sun,  9 Aug 2026 10:09:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A2D020040;
	Sun,  9 Aug 2026 10:09:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:09:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 7/9] nvme-multipath: add debugfs attribute latency_batch_timeout
Date: Sun,  9 Aug 2026 15:38:02 +0530
Message-ID: <20260809100825.2014133-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXxW1/ylLGlKoW
 Ni9+LBamopPeuTh4Wxq3vk3l0672SJrD0yRRvuHBNeAPPdtcG4k1kfqQ5rBv73yRS2B58iGBG93
 bmqzXQtqUHjlS/joJxxvPk7G6oczVnisAK30/CJEol0LhoRfsA6ib/0Mf2qNiwXAc78e6B2/NvR
 osUlXPApGzaAFHTYM8miSYm8XldMIrrN5Gmfz6cPKRMUNFGswRjjqMeW/UDOHALNG7yZGl6Hfed
 Q4VKrENkPAP1Wjapj7IiI/rz6HYi5bvcGpkrplxSPmkWuamZVw8dIqOjW5HxBoIjlT1oZ+ktJfV
 INk+wjQYcqHppmmb8R/leMLWhDwpuHLa3gpMzYs8dqZokaW7+dkM4bwPk3GTAkPahe7kanQ/grx
 EiJJiFDSJZmbOFNDYH8rRpj5IRRXQdplZezqMKmNPphW+MjuX/68rNFXEtwfm6nTFRA/0hdl0Ci
 0Ihrx+O8/sSPBBkIEsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX1rf/ndbaOp2N
 U0EUHdshrN591wng6Gm4OSXjYA4NL9StsMO05ZkZadDN8KhjjymBa+/cvG2nGyitPtWUJjpDdPA
 hqpoqpcHdFcHn7AFRzbJ+XQyBUkFwTA=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7851ca cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=-uU29Nhu3qfbNnVktN8A:9
X-Proofpoint-GUID: N4BwBY6GeVrEhB8d0gv0zTxZVs3ZgVl1
X-Proofpoint-ORIG-GUID: 1-cN29HFw6lKamjkYQQnJ3IH8pAGfrDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030920_252398_DC8B7EF8 
X-CRM114-Status: GOOD (  19.69  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c   | 37 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  8 ++++++--
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 4371d7aafae8..63b0ad5d105b 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -146,12 +146,49 @@ static ssize_t nvme_latency_ewma_shift_store(void *data,
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
index 70a72c1a1602..82a1bedd093c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -361,8 +361,11 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
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
@@ -1152,6 +1155,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->delayed_removal_secs = 0;
 	head->latency_ewma_shift = NVME_DEFAULT_LATENCY_EWMA_SHIFT;
+	head->latency_batch_timeout = NVME_DEFAULT_LATENCY_BATCH_TIMEOUT;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 842b9eace5dd..0f350bd52272 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -607,6 +607,7 @@ struct nvme_ns_head {
 	atomic_long_t		io_fail_no_available_path_count;
 	struct nvme_ns * __percpu	*latency_path;
 	u32				latency_ewma_shift;
+	u64				latency_batch_timeout;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.53.0


