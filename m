Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8F8CCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYQdxiS3AvO3OgYA7rxOFIp1sYac5g574PXtWf/KzB4=; b=kJE/JxjM1uq5fvXbZrVZECOcby
	LJVvcHytfysgNtVRb74fNCbCG0THPx8g65/cRMJwfBpImqWJ89TyfURO40AYYWlE6e3Cf3WH1yMh5
	9A7Yh65HmoyoER+h93pFb1RN03guiVCZAzIYie/+JofrirPJWa45pp4UyZtAaUN6PE2d02taEz08r
	z3UJ5DxcVUSuzN/A7gwO2F02Yo8KaCFJVV/wu9VK+zQ3n2aFuMiXoRFvpqKGcQ3/bq9Sd+S15FcCv
	uf0qRueoMs6ksDCxhzAeDBM3U3G/dPykF/hrJrq0Hj3yiOVnq8sorEuJJbJw5oVYxLlyvhnbKXEis
	E12ldliw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqP-0000000DTqP-3Bbb;
	Wed, 05 Nov 2025 10:34:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqM-0000000DTn6-3dxC
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Nov 2025 10:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PYQdxiS3AvO3OgYA7rxOFIp1sYac5g574PXtWf/KzB4=; b=Q7IjPIFFwoJrgPbtzUfvXe89mJ
	RwHKffXuevRlhw4PbkIjSE8mFZG8Q6glnMg3C4eF3NNIoKbxnYIhwvkrDzl/14jDr5SBGAK4HkGUC
	fjiAlCgeloDZfB9N0xUXGv8iICaO7GE13o+SOr9Cm+vQDAYGzu8GtJrXq5TuHm7QAqh+8winbib/C
	ehwDqwzpkix+aTOMYXBeQvVnVwHOAKrKQqmdhqupqjuSOHiRqw9RxwC7xsYAThT6dd6SrzCpjAnB9
	8BzkNUQ7RPUBfWzbO31FQu1LynEMQ4bscCoZ4iUHrRZEhlfM3oOK7ThFZAFoF2+AeuwabPOVIku6R
	RjBia2/A==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGZyb-00000001rXl-4BCl
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 09:38:52 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A52aTXQ009252;
	Wed, 5 Nov 2025 10:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PYQdxiS3AvO3OgYA7
	rxOFIp1sYac5g574PXtWf/KzB4=; b=FYwgyW2mSpswML1Bm2nkEDEnRCG8B6AB8
	A29FANRe17hMSOHSyhnFUkcFc3cJnGCDsE2K8RxxCnpxd05T5gTCj70+fIFnIVMK
	vyE3pys6hEQ9B39ixDY3/4r30ZVnD1C9e4U6MgAptbSOc0uc4LwnmWZcCc1v7EoZ
	wpym+Dq1Yt2lv7qQOE24+IO/5yySz6dJtRPhpyeLvjbOHkS+Wxr9Er1lWB8xVBSx
	darQbOiGCyRI4tSbwalczcjRnwxNYgLceWhRIPETJ2mytwBDTS6LtlJhJwfoMwzV
	8TmKx8PiomlsbO7xVGWURd32OgFrDQ7jOAgKk4ZnNfS7BN0LvB2Dw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc0ns6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5ASFfa025012;
	Wed, 5 Nov 2025 10:34:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc0ns4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A597Nk8021515;
	Wed, 5 Nov 2025 10:34:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjqbf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5AY4hu42991880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 10:34:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D460B2005A;
	Wed,  5 Nov 2025 10:34:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF93720043;
	Wed,  5 Nov 2025 10:34:01 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 10:34:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, kanie@linux.alibaba.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 5/7] nvme-multipath: add debugfs attribute adaptive_weight_timeout
Date: Wed,  5 Nov 2025 16:03:24 +0530
Message-ID: <20251105103347.86059-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
References: <20251105103347.86059-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX1MHag+XVmjcf
 lj/bwPx7NiK+nss6AvmsqB1rP+maNA/p0/hQe03h0S4QeGb/mJOt56Vc65URVqd7SxnXL3B5DBX
 SxyssE64UCm2nd8gAbyPj3RSGqN8di/OmX51gEufZVzYkKu5VqjksoeQADSG4iZoUHyeKk9Yl/m
 ziTw/gO07Lxk+Aitq4+VNzh0AqH1OYlEkj/W+uQajb40ttRVCYrtr6DCbo/iLd5LUs2dnPIsGDh
 KyDIwW1SfbXUQUN7XAvZtLFxH77wI+kd01MUCDvJIJzqJTJhyBTgIxqMb3jI2CU+m8eP/b8WKET
 siOLbXLohbR+1nC6R/xMvimmJM4+XImmnK0gVGFcbyKJDVOtUbPFuS9Mavh9fVfpZFsn+E7KOzh
 E+2aIYiiwP3kxoQWCWkm6mOq96P5kQ==
X-Proofpoint-GUID: wMqLdegVaNcDoClGB55WT4i9qooNl67x
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690b2820 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=lAPw0pASQEPevriW-_sA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: oJBEFv0j18iJh7HCnckvLggOPX1dGep7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_093850_453846_2CFE89E3 
X-CRM114-Status: GOOD (  19.86  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
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


