Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51306CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qgsCfMO+zmYEBVXmHXMd6u/YAZqPbncaE54xQQk9YKE=; b=mlcC4coRlP4h4HD8HoJY/UFJJA
	kl9DuiA5DtsZ/Ql7u629eUsy8TkzvBy0+uE6xloL810xBLBcfWhr4ralbrf6EtUFptW13wBlhxJBy
	P7ZsmxQl241Dp4iHNartHlPWsaX1lUwJF7517a64/kr9mLoio6r+VuLCRIv4LygTnd+59OWpyxueY
	/0xzhnojtLcLDYblIMdxoHzTHT94amSyQ12+72wU/0L5iP0oKZT+HrEb60QIADtjpvlZ08Bj1aWV4
	WqEDcha6/2DTsUbk4RKYVG0P13ve1jPMIutBvzYJdRRmMPQqs5VzHgpJUwkif3eWVLb4DcBzOWu4+
	JNzsAWJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqG-0000000DTkB-1fSk;
	Wed, 05 Nov 2025 10:34:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqF-0000000DTjE-1PSd
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Nov 2025 10:34:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qgsCfMO+zmYEBVXmHXMd6u/YAZqPbncaE54xQQk9YKE=; b=KviW6qcojP312/X5rKyh99qVlG
	GkSWLSIiodGJu1P0HTRon86g83iWm3wLEdwA1RHmZJRQqxLMM7nsC5VyhjN2kprczCbWXZbhL7U5W
	Jk987LpSGLpavYnnAHo6oGljizdWVoaXl/HsgDGArG+PEXgEpUceQL/Gea3BgvrR+hcjYSxxZBVvm
	VrcUGX+mwUOyz75db3ihbrr3zGzZN6cbgv3/4dMagqWRYvkGqDCxIfxP5O1utnVnDimvmzOtijC63
	pml7WXzLCG+wB2i3e0bnUnmbZcoOMaesBby6KKgKHF3iTEUnlB85w4LbsiHjPRY1TP3iSQOfBcx3A
	3oyjPhiw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGZyU-00000001rWs-3ods
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 09:38:45 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A56DOYq012681;
	Wed, 5 Nov 2025 10:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qgsCfMO+zmYEBVXmH
	XMd6u/YAZqPbncaE54xQQk9YKE=; b=ShMWorLqozIiUqSAOjTNNMXCGEp3LG2Xi
	rdBMxfzUedJT+1qc/sD04OJFYW0sMWtIDeu4ZsW8oeYvVna54WByGBHqFdt1dsRE
	u0l3Q4eSsO6fWj6sjWY5gAoox8ncFigEwCPY9oC59ucjXfCvd2zKPGIfxtcft0T7
	XXrAIq1uqbJRJGUmYR/SF6LKWYYPon1hGMGKRi94GqOwnf5zXdwnlfhib7I1jXh4
	yQ4KCg0uuVb56S9mZ0YPBDTHFpTEZmMW7npv6h//BQUSo6YWUJiqq+pdXZeLf+FR
	gwXcAGDUuLV56h7kEQ3mlGit7Yh6jZKih5AW48YJd6yc0+A/drvTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v20aax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5AOx5Z001205;
	Wed, 5 Nov 2025 10:34:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v20aat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A58A2sf009822;
	Wed, 5 Nov 2025 10:34:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kfg72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5AY1li28443244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 10:34:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA762004D;
	Wed,  5 Nov 2025 10:34:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26A0420043;
	Wed,  5 Nov 2025 10:33:59 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 10:33:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, kanie@linux.alibaba.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 4/7] nvme-multipath: add debugfs attribute adaptive_ewma_shift
Date: Wed,  5 Nov 2025 16:03:23 +0530
Message-ID: <20251105103347.86059-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
References: <20251105103347.86059-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zutEP2P_BgoGFwRu9Yk4AOWh7S0to6Ay
X-Proofpoint-ORIG-GUID: efaGXIK95RsDzFn1VSW70iJN03GhdqSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXz+6+WUoRQbVz
 TkLqir7VuFFCAIG8ulMSA/WuUE5hqmMICLEL2BdK/O/veKwO2ypRyl4DcN7eUf2GWWFUYV7fa0N
 M4rtfcBnZmXZhPiqzf0CckstzV5QUo+NTVBzasTAD62xR7wr5K/NnIL3I5Tj9Q2W9HHWdMuOvdP
 M55DkSxJP6YmCURi6cHSInHdT3w7nfInaPXu8V9K73b9wBiDkySEg7vt+TNE/V34Qg5arZiwE88
 w3+rkA47e716FNmRx4Bdh/p3DpgL7/yjCw4H8YrHmWMmtJdDXdubHOoUw5ehrBNZGnSsAKcAkd0
 PDLpO8IHR27n7Su3FsfSSEK0dkw4PRqZC3RIyOsOjCYbu8NJRUs2JfYfKROciHpnGHgw+zxyHht
 iSslk/ZuyzGOYUILEwLfH02QWM7LAw==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690b281c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=k3Spkpae0BRaQ9hHAkwA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_093843_444601_71796EE1 
X-CRM114-Status: GOOD (  22.71  )
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

By default, the EWMA (Exponentially Weighted Moving Average) shift
value, used for storing latency samples for adaptive iopolicy, is set
to 3. The EWMA is calculated using the following formula:

    ewma = (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;

The default value of 3 assigns ~87.5% weight to the existing EWMA value
and ~12.5% weight to the new latency sample. This provides a stable
average that smooths out short-term variations.

However, different workloads may require faster or slower adaptation to
changing conditions. This commit introduces a new debugfs attribute,
adaptive_ewma_shift, allowing users to tune the weighting factor.

For example:
  - adaptive_ewma_shift = 2 => 75% old, 25% new
  - adaptive_ewma_shift = 1 => 50% old, 50% new
  - adaptive_ewma_shift = 0 => 0% old, 100% new

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  3 +++
 drivers/nvme/host/debugfs.c   | 46 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  8 +++---
 drivers/nvme/host/nvme.h      |  1 +
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c15dfcaf3de2..43b9b0d6cbdf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3913,6 +3913,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ids = info->ids;
 	head->shared = info->is_shared;
 	head->rotational = info->is_rotational;
+#ifdef CONFIG_NVME_MULTIPATH
+	head->adp_ewma_shift = NVME_DEFAULT_ADP_EWMA_SHIFT;
+#endif
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 6bb57c4b5c3b..e3c37041e8f2 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -105,8 +105,54 @@ static const struct file_operations nvme_debugfs_fops = {
 	.release = nvme_debugfs_release,
 };
 
+#ifdef CONFIG_NVME_MULTIPATH
+static int nvme_adp_ewma_shift_show(void *data, struct seq_file *m)
+{
+	struct nvme_ns_head *head = data;
+
+	seq_printf(m, "%u\n", READ_ONCE(head->adp_ewma_shift));
+	return 0;
+}
+
+static ssize_t nvme_adp_ewma_shift_store(void *data, const char __user *ubuf,
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
+	/*
+	 * Values greater than 8 are nonsensical, as they effectively assign
+	 * zero weight to new samples.
+	 */
+	if (res > 8)
+		return -EINVAL;
+
+	WRITE_ONCE(head->adp_ewma_shift, res);
+	return count;
+}
+#endif
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
+#ifdef CONFIG_NVME_MULTIPATH
+		{"adaptive_ewma_shift", 0600, nvme_adp_ewma_shift_show,
+			nvme_adp_ewma_shift_store},
+#endif
 	{},
 };
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 047dd9da9cbf..c7470cc8844e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -294,10 +294,9 @@ static void nvme_mpath_weight_work(struct work_struct *weight_work)
  * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
  * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
  */
-static inline u64 ewma_update(u64 old, u64 new)
+static inline u64 ewma_update(u64 old, u64 new, u32 ewma_shift)
 {
-	return (old * ((1 << NVME_DEFAULT_ADP_EWMA_SHIFT) - 1)
-			+ new) >> NVME_DEFAULT_ADP_EWMA_SHIFT;
+	return (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;
 }
 
 static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
@@ -389,7 +388,8 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
 		if (unlikely(!stat->slat_ns))
 			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
 		else {
-			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
+			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns,
+					READ_ONCE(head->adp_ewma_shift));
 			WRITE_ONCE(stat->slat_ns, slat_ns);
 		}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1c1ec2a7f9ad..97de45634f08 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -545,6 +545,7 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 
 	struct nvme_ns * __percpu	*adp_path;
+	u32				adp_ewma_shift;
 
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-- 
2.51.0


