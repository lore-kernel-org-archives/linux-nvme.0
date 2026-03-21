Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C901094489
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yiopa+8XXMpChs+VwNkNctGGoffLkdTUay/JmzrJwUU=; b=vdE3eSHVIGtFwkCVOXApDeQoCO
	JTHYNSBmmhkX+RRGJI+/m4RrwAz64hP3WLFpAJpzfKkLvX/wxgHdbV9+SqtyXchHNwMnfWW9daLgO
	2tDUHsdRaSllGU4WQi80MbaBOJjn5YboibloL8bfQtdvp5AteZUqpAIocP99R2XXhfcHDBlv/hsR9
	GhT/Kqo4qxnhBwwiDZAew7caCTJFiFha2dSARnpUM9Bb6zdqCwaXVgg92WgwblL3Cay33Y0fal68w
	8/PwVwygIpx/O7eMxs5is29XoqRGG1JZrFhd7P8UU5UmU3dLeDKQw/cw+dkAXaUTBJcEqyKuPJ+f0
	A4vjtphg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGG-0000000EaJL-0bN6;
	Sat, 21 Mar 2026 15:29:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGC-0000000EaD9-2Z2b
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:29:09 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LDTgMq926383;
	Sat, 21 Mar 2026 15:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Yiopa+8XXMpChs+Vw
	NkNctGGoffLkdTUay/JmzrJwUU=; b=Yy2fVbX1+uXYtlrrIGPno1zDWH5I8xlyJ
	bluZlR1X/QcML2U6VEeRpmjtBuSrRDfJFpLdkaoy+7WFNnlvaQfvpLFxOrd8RrJn
	OgDy8ybG4YSuFbEPs+H/MsbUxcwc2/XewHkg0yYO5SAy+v/Rny9p4+lyDF1fWFDG
	PPws9ixui9ef54VzLvvVod4fnpWK0Eu2xhD2us4gxJ+Lhpg06LN/WopkewpZxAvp
	mrtazq2VySL/tD3/zUf9xs3Q8NwFMzasFBsXym7Aec2hN1gLGj8LFyigOd4HOU9M
	L+Nmt60QsxBXkpkxHvsn9eB2JBQJnwNJXxwBNlEwUGteH+eeM7Kzg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxys67v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LA4FmO026484;
	Sat, 21 Mar 2026 15:29:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcym0hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFT0G746268710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:29:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 852632004B;
	Sat, 21 Mar 2026 15:29:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6CB20040;
	Sat, 21 Mar 2026 15:28:58 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 7/9] libnvme: add support for namespace diagnostic counters
Date: Sat, 21 Mar 2026 20:58:06 +0530
Message-ID: <20260321152823.3197870-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfXziD2fl+zq/qT
 tqyfoE8mHv9UstWgXRlIsnPtwxBixKVwgHa/eEMqssIgxfJIQa/Se2zMHf17cEZLap9a80sik2Q
 DQsROkV9/vzL/rHPKmIVopMR+WOW5y8LGFMjYHM2g9Ra8E8trLsTHEccXw4Rn30f0kNghRlgL4y
 J7lkauxiiZc1Se7/mkj2srwBKUl51qykgutE7TTmYbpS7Nss4ephlWMe9V744WHsiSmKTwuepeq
 /H1rxKGUbPseEkhZ55JLm6TSJg449HmV4jbKlmk7glMjk9atNyEgvaVxXA8JTDYeIVyHOsoZOQk
 wUERWmZYiPWZwbSe3tXpBP65FM9wuvAUwCCNX/F2o4YuM2msTjFDmqk88D1yTnDiKzptstkUKiF
 wKq/xqW+Xj4LwwhTrVlhwrbPc4D6Ob0phER1Ush0d0P5s0jeoR+guruN3RHc9cLbXzMPRmcmrhK
 THKsw2xyvno3n10mJ8A==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69beb941 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZIl4JuDNgyyfCGH6ZssA:9
X-Proofpoint-ORIG-GUID: bV08swT8z-f5HPRS_PXmt9c7wHcRwd74
X-Proofpoint-GUID: bV08swT8z-f5HPRS_PXmt9c7wHcRwd74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082908_770713_EEDE910D 
X-CRM114-Status: GOOD (  15.42  )
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

Add support for retrieving namespace diagnostic counters such as
command_retry_count and command_error_count. These counters improve
visibility and can be useful for tools such as nvme-top to display
real-time statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  2 ++
 libnvme/src/nvme/private.h |  3 +++
 libnvme/src/nvme/tree.c    | 22 ++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 17 +++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 20dcb24f1..a767eca5e 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -141,6 +141,8 @@ LIBNVME_3 {
 		nvme_ns_get_write_sectors;
 		nvme_ns_get_inflights;
 		nvme_ns_get_io_ticks;
+		nvme_ns_get_command_retry_count;
+		nvme_ns_get_command_error_count;
 		nvme_ns_identify;
 		nvme_ns_read;
 		nvme_rescan_ns;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index bbddb9ba0..f58b13bd7 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -206,6 +206,9 @@ struct nvme_ns { /*!generate-accessors*/
 	uint8_t nguid[16];
 	unsigned char uuid[NVME_UUID_LEN];
 	enum nvme_csi csi;
+
+	long command_retry_count; //!accessors:none
+	long command_error_count; //!accessors:none
 };
 
 struct nvme_ctrl { /*!generate-accessors*/
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index a197b7a00..f82ea4c02 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -2548,6 +2548,28 @@ __public void nvme_ns_get_uuid(nvme_ns_t n, unsigned char out[NVME_UUID_LEN])
 	memcpy(out, n->uuid, NVME_UUID_LEN);
 }
 
+__public long nvme_ns_get_command_retry_count(nvme_ns_t n)
+{
+	_cleanup_free_ char *retry_count = NULL;
+
+	retry_count = nvme_get_ns_attr(n, "command_retry_count");
+	if (retry_count)
+		sscanf(retry_count, "%ld", &n->command_retry_count);
+
+	return n->command_retry_count;
+}
+
+__public long nvme_ns_get_command_error_count(nvme_ns_t n)
+{
+	_cleanup_free_ char *error_count = NULL;
+
+	error_count = nvme_get_ns_attr(n, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &n->command_error_count);
+
+	return n->command_error_count;
+}
+
 __public int nvme_ns_identify(nvme_ns_t n, struct nvme_id_ns *ns)
 {
 	struct nvme_transport_handle *hdl;
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 3c651743d..6cff114bb 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -529,6 +529,23 @@ const uint8_t *nvme_ns_get_nguid(nvme_ns_t n);
  */
 void nvme_ns_get_uuid(nvme_ns_t n, unsigned char out[NVME_UUID_LEN]);
 
+/**
+ * nvme_ns_get_command_retry_count() - Get command retry count
+ * @n: &nvme_ns_t object
+ *
+ * Return: Number of times any command issued to namespace @n has to be retried
+ */
+long nvme_ns_get_command_retry_count(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_command_error_count() - Get command error count
+ * @n: &nvme_ns_t object
+ *
+ * Return: Number of times command issued to namespace @n returns non-zero
+ * status or error
+ */
+long nvme_ns_get_command_error_count(nvme_ns_t n);
+
 /**
  * nvme_ns_get_generic_name() - Returns name of generic namespace chardev.
  * @n:	Namespace instance
-- 
2.53.0


