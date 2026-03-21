Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764991094489
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aboCAMsqyao80GPARvkBCuX5VkgWtSbBg6f/5VS51CI=; b=cTC6H7kEjQwXcHmmQR6Q1Q/kpy
	MXxbHs1iuUpk1jZjJ7xwmgGZyku7VZ7wxC/Wac6h+N+HKDd2QZPd64+v5AaSi0YdfgFVNk/v74/uC
	82cOg7Cwi3XGHyv41y010y2l+hoFpHtN032fPux9uCXmVb9KyjhsDXqQR1HzAC6kOA+exE1vj/NFE
	YawlFfe0w9PAqvVoVvyij7op33ywhvdnWqDEmsvUr3W3rXm31glsekgZdBDpz7BMzy6z8/6a6ZNYC
	AQBxNuWG/TUTd1bD3wPKU30zsoxWcsQ0F2ly1jn5p0kvXznfOG1Tc0GhLCB76HnSogeu5DeLUi0MC
	EHKENwlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGB-0000000EaCP-2qnM;
	Sat, 21 Mar 2026 15:29:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG9-0000000Ea9n-00QZ
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:29:06 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L6nFpl562805;
	Sat, 21 Mar 2026 15:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aboCAMsqyao80GPAR
	vkBCuX5VkgWtSbBg6f/5VS51CI=; b=jmH0ky5eZdGsW+n9mJp7Z5AV6+ehckD2c
	L7XzjdY8q0xugKi4iffliHnY4NBJo/jSFVWYAuz996tDJS09oNmtAPJitpyJzwOg
	ElIHMiPzJb2lIzbvlQxSZThuxaOfEv91kJoZERtjcsb/3y/jrZXwpG9GgmzM0/qW
	dHQ44mc1qt8Py7RE5afj1AaysWIhWaydisdFE81zNlB5E/hQGxbc6aTy0Wj16rOP
	h3ioITqwYbvj+WkCM0oFd2K3rp1vAMVmWDMQArX4DW4j9Pmsc3gIBVufUG//M+Ww
	9VY0oorn4UKK/pUOFlnWG1EkG5/tZlHNN5jlK/HFRg4kz/+vUaABA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq18re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LAU1v3006315;
	Sat, 21 Mar 2026 15:29:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkux1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFSvKH51183890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:28:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D7D22004B;
	Sat, 21 Mar 2026 15:28:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B8220040;
	Sat, 21 Mar 2026 15:28:54 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 6/9] libnvme: add support for per-path diagnostic counters
Date: Sat, 21 Mar 2026 20:58:05 +0530
Message-ID: <20260321152823.3197870-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GEJItSBgAr9SBRS4DZ4-g8wCfUGMSFXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX8Yn0NyBuUAg2
 +uERIbQRAaqY57K2ifWYZg/lQp2HPlKtsBewsuhwQrMhiJeMqcleppGXM7xmEpQNA6k5Q0GzWdM
 rKU4nFAbZunPVKwlYNom+gYIA2K091XYTI58YwH3/E00I6mcKooz2cCbVkIM6ZKrt5SU/qEaM99
 zSKvL4359wbyM2llCeahZbpLJM+AoE4dVk57YpdbxZTqSCqrBGYI8/tMclLkP9ZiaO1ObZsaT26
 OueDdOcBvH4BX5fQBfxFCjjHG9kRHTymVWgdXys+c2HUj1zK51/d2EDCFm0P8CQ6Zc9z5RiTZpx
 Cprbqt9jdtsNpmm6zmrIkku42934msW17WV2xEjKFmDfDdDOvl0Eh+YsQTL2VE0fnA8EuGhtOF2
 CckDEP0nftskqKEtzMM9p+Zz3AeTKNMi/LO3GGhnBE2cJrxAo4Fk4afXjnt9wmCFLIrgSA6HYNE
 qheu1h1jjDsqPUzp04Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69beb93e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NKCsueVTR_sD4m4h2I0A:9
X-Proofpoint-GUID: GEJItSBgAr9SBRS4DZ4-g8wCfUGMSFXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082905_048136_42A96DCC 
X-CRM114-Status: GOOD (  15.57  )
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

Add support for retrieving per-path diagnostic counters such as
command_retry_count, command_error_count, and multipath_failover_count.
These counters improve visibility into NVMe native multipath behavior
and can be useful for tools such as nvme-top to display real-time
statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  3 +++
 libnvme/src/nvme/private.h |  3 +++
 libnvme/src/nvme/tree.c    | 33 +++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 27 +++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index c9550240d..20dcb24f1 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -167,6 +167,9 @@ LIBNVME_3 {
 		nvme_path_get_write_sectors;
 		nvme_path_reset_stat;
 		nvme_path_update_stat;
+		nvme_path_get_command_retry_count;
+		nvme_path_get_command_error_count;
+		nvme_path_get_multipath_failover_count;
 		nvme_filter_paths;
 		nvme_read_config;
 		nvme_read_key;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 858759a1b..bbddb9ba0 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -167,6 +167,9 @@ struct nvme_path { /*!generate-accessors*/
 	char *numa_nodes; //!accessors:none
 	int grpid;
 	int queue_depth; //!accessors:none
+	long multipath_failover_count; //!accessors:none
+	long command_retry_count; //!accessors:none
+	long command_error_count; //!accessors:none
 };
 
 struct nvme_ns_head {
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 3ad483557..a197b7a00 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -851,6 +851,39 @@ __public char *nvme_path_get_numa_nodes(nvme_path_t p)
 	return p->numa_nodes;
 }
 
+__public long nvme_path_get_multipath_failover_count(nvme_path_t p)
+{
+	_cleanup_free_ char *failover_count = NULL;
+
+	failover_count = nvme_get_path_attr(p, "multipath_failover_count");
+	if (failover_count)
+		sscanf(failover_count, "%ld", &p->multipath_failover_count);
+
+	return p->multipath_failover_count;
+}
+
+__public long nvme_path_get_command_retry_count(nvme_path_t p)
+{
+	_cleanup_free_ char *retry_count = NULL;
+
+	retry_count = nvme_get_path_attr(p, "command_retry_count");
+	if (retry_count)
+		sscanf(retry_count, "%ld", &p->command_retry_count);
+
+	return p->command_retry_count;
+}
+
+__public long nvme_path_get_command_error_count(nvme_path_t p)
+{
+	_cleanup_free_ char *error_count = NULL;
+
+	error_count = nvme_get_path_attr(p, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &p->command_error_count);
+
+	return p->command_error_count;
+}
+
 static nvme_stat_t nvme_path_get_stat(nvme_path_t p, int curr)
 {
 	if (curr < 0 || curr > 1)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index c69d0c8a0..3c651743d 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -704,6 +704,33 @@ char *nvme_path_get_ana_state(nvme_path_t p);
  */
 char *nvme_path_get_numa_nodes(nvme_path_t p);
 
+/**
+ * nvme_path_get_multipath_failover_count() - Get multipath failover count
+ * @p: &nvme_path_t object
+ *
+ * Return: Number of times I/Os have to be failed over to another active path
+ * from path @p maybe due to any transient error observed on path @p
+ */
+long nvme_path_get_multipath_failover_count(nvme_path_t p);
+
+/**
+ * nvme_path_get_command_retry_count() - Get command retry count
+ * @p: &nvme_path_t object
+ *
+ * Return: Number of times any command issued to the namespace represented by
+ * path @p has to be retried
+ */
+long nvme_path_get_command_retry_count(nvme_path_t p);
+
+/**
+ * nvme_path_get_command_error_count() - Get command error count
+ * @p: &nvme_path_t object
+ *
+ * Return: Number of times command issued to the namespace represented by path
+ * @p returns non-zero status or error
+ */
+long nvme_path_get_command_error_count(nvme_path_t p);
+
 /**
  * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
  * @p:	&nvme_path_t object
-- 
2.53.0


