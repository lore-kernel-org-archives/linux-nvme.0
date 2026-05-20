Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6A5CD5BA4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tAlr6KUN6o35eak5SQ819LC2x7xj9WSqF2QSpO5z2FE=; b=Benpfxw/R0FdEXdsaJV8ZeKW7s
	5t4EuCLrk/mk5XK3bPxwh3YAwh5Gs+sWqAiB1CHpYoRLO9R/m7VTOEvgOdP8YD1/8WH5O7lUKcxor
	cO7w/t1brDyz0FOSCc0U3o4n+uoP9bsgvqfRYRGOMgsURUKZPMFsbpg/bjCvoHgTn+UZmGwAfHeKg
	rvS9IP2TOIFvdiQseShG/sxsXZabNYXg7mUM5APaWqEo5FPHs/w2BXE6HP+Mut7ayx4jUmAMQXDvm
	9uFtZ8ps8qdTp+BK/B1CiGhNeDDSXZCS+ih5c0eOl60lYwxoZ4wWEm1ELprV8/EcYw2bDq4BLlNm3
	LvJxibSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYT-00000005QOt-2wah;
	Wed, 20 May 2026 18:22:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYR-00000005QNM-2WHD
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:22:04 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE5IYX414604;
	Wed, 20 May 2026 18:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tAlr6KUN6o35eak5S
	Q819LC2x7xj9WSqF2QSpO5z2FE=; b=qUpSJwrf960GBiA+i0/h43Cyu5jJX84Pt
	EFm0YNhv50dG9ZIDc4qyGhr87XT4oCaRnFRnB/UoirC5tVtWBrnlSV6xOqIt+rwd
	hfMjqDPgo0AhjFlOi8alXf11Mvs5c18+5odT4vg1YnQt3KViIhOf8/Fqkc0r74JM
	6vG+7oWh7BMU/aJU/eyTdfeV+Gx5MvDq/Ccw+46z8ftIPjrh10k86W5HjbPz7ND8
	Iqh5a5g71A1TyJgpaymonDvPb6YTLwmDpYROnN94fjsYS/H6UKwd55DPMysulGQF
	wVu+XSgxoFVQSmp4LXYYEv1KJVEXnxX5MBepsFVpiRyFhjQoeD/yQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88jc5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI9B8q028814;
	Wed, 20 May 2026 18:21:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk8j9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILu9R49283564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E518820043;
	Wed, 20 May 2026 18:21:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F352C20040;
	Wed, 20 May 2026 18:21:50 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 6/8] nvme-multipath: add debugfs attribute latency_batch_timeout
Date: Wed, 20 May 2026 23:51:02 +0530
Message-ID: <20260520182112.863076-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rfBBeg9z66kif__TmLLzEDjyCz_FPyjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX7+y2ZpCEyA+4
 1rXXcc4edvHCsnQ47olH5sLVTV/iOK0VLGO3M1cIEGPFGiYo2SEQEydhhvWcMPaFZZ2YobNdhDu
 VpzyQXFY+kkxpDoJpX0i6zL0rhJsGYMGHuvn2CVWqUGOqNwZTc9YdWtbw5m5g4TcU3jOaDC3OcK
 XsK2UAdIbVIpbqmRTomkW6zxtYwEbUXkzliO0zxfjBMzLLrvHxr6reWzfPbP/soD/WnsBeNOBhb
 Ry8lrxD+sC+yLu28E3lFjZyGdQ4a9W0UOrxPaRcqwv9YrWL9txAaZKITy+hhnV/7UnolbEAOj2u
 i/X/cdoK8V/8ocDm6GU6yE6GdO/4E/MvPGKeE3ci3x+QY+lDeOMmu4ejswnm1WhgognGrmz5jbi
 FpHX2uHbuZor7pTjNwYxS5eHfQdqJeSxhQxs5Azr6dcatBH1ejNBTyUldvhE6mlAkoPprANS3o5
 rEJ1qBOD741QC6G9cig==
X-Proofpoint-GUID: 2QuYr0LvSkvGm1ndHmEkxzgAuhyECw_H
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0dfbc6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-uU29Nhu3qfbNnVktN8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112203_759470_D4D08A6E 
X-CRM114-Status: GOOD (  20.11  )
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
index 3e76e07a0376..aa817bfa4b81 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -349,8 +349,11 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
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
@@ -1114,6 +1117,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->delayed_removal_secs = 0;
 	head->latency_ewma_shift = NVME_DEFAULT_LATENCY_EWMA_SHIFT;
+	head->latency_batch_timeout = NVME_DEFAULT_LATENCY_BATCH_TIMEOUT;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 40009c024ab8..a694dd091a16 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -600,6 +600,7 @@ struct nvme_ns_head {
 
 	struct nvme_ns * __percpu	*latency_path;
 	u32				latency_ewma_shift;
+	u64				latency_batch_timeout;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.53.0


