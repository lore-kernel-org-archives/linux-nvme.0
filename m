Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545CE88D66
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vs+Is0t4oCac3uoY+h4eTjZCo24oPNpwpqcqhAtWcZk=; b=BPC0UYueOI68yIYxoGv7xRZmFF
	GL9/ZpOc8JYh3d6BNoJgLR2NIKV8vN8MxVlXEkm+7ZLO+3IICJiyVIyREgq8w6S47JC7zzbIh3ySI
	PQrCNRPVydNI09TzruwbrRWDYCa2Zw1j2NpxsZo/CNAdONWK9xIpvDURiLCdQR5YVzOZjM4fr4J2z
	FxDrWply85ZUeUJqXZZjEw+OAaCVh5zSvW/PxHmyv2jiyTelJzQBAWV7GA5I2qcvVNaUV7is5L7vy
	oYoOAg6RBiRxnl/V2I6xV103bHc14pzD4heY0gTXk8mndDV/6UdAnyrhHtd25ZIld6spXAfS2zzBU
	0oQuKNRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2f-00000003MVq-1Q8E;
	Sat, 04 Apr 2026 10:15:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2d-00000003MTg-0hKp
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:48 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6347j4gF3593493;
	Sat, 4 Apr 2026 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vs+Is0t4oCac3uoY+
	h4eTjZCo24oPNpwpqcqhAtWcZk=; b=VoiTVvEtlCBpI4ukB3utMfxE96MO7l1RG
	qlPo/JfOWnNHdkezgyVyObhKkCxTBrhor6OSg0M707cmSxRryoPZjd2Pz6Vtdu1B
	7hHly2tUQGVzVQThZr6pS8paufVc0an0bebrv3td5Yly4eCqbIT6KWCRxU2Hb03s
	34DeHK4eHP7UH0VxHgkkZA6rx405Irca8xzXOsP8+vbFLKhSA/XFWoTRz3mwAZHk
	XiHGmx6dQ6+Pv11E2eeeyjBGCGPIiY9+FGAkTrMeppC2in7qabk20K8zPPTKIi25
	Bw5G7zoWt4n5oYv5L7src1MgTP6Mazc7WFVj6N+E8rxAoEUhqFh1Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2gqhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63477aWW021631;
	Sat, 4 Apr 2026 10:15:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sat19n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFdIH47251860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAAC62004F;
	Sat,  4 Apr 2026 10:15:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB212004E;
	Sat,  4 Apr 2026 10:15:36 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 7/9] libnvme: add support for namespace diagnostic counters
Date: Sat,  4 Apr 2026 15:44:57 +0530
Message-ID: <20260404101504.44539-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX36Ux0e/iUmwj
 Tsa4qu74Yg7/2Vhnao+wca8JYy0XgxeIc+DFzY0WDeFhaUWJHC/p8HvlRiZ06wMhZP7aMQ5/11E
 5NURm76PzliMlwyiFux30uHzsXVgFy6erB4wm8pQhDeqsIhF4dkbz8Z1jDjRQOI72UYPWivVgMv
 uCDn8kIgSg8I9kDhFYEXmlsy7j32z1XbkqXM0+8aVS9I0C2C50ouCog1opu/10Yh4VtyEJoTKve
 hNoW2q4uxlL98FJJxUiP6JxfN8+XFgDmX1e40SfZRe+fSohG+Qqo2OgU2qVotVR4esPT69J+xlh
 WdRabGk7DkgJSR2Vx++DbukI4fxlhEJlUW+TQSczPdPT3ZLMWilm/ecZfPWYPmPLJiz9xAikxnJ
 J8V1f7XvflBlKvAwlgI6S1Y7w04ROJuILpy7Z4WNIi+DN+a62ihyDXCUJm722Wo/WhpjwI7Bb+w
 mHpvZYjUOIwAk1Mrfzw==
X-Proofpoint-GUID: k9SU5exvS_wU-7Vf3ZeUGEQrhnlH8Mul
X-Proofpoint-ORIG-GUID: k9SU5exvS_wU-7Vf3ZeUGEQrhnlH8Mul
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d0e4d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZIl4JuDNgyyfCGH6ZssA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031547_209219_73B769D6 
X-CRM114-Status: GOOD (  14.06  )
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
index a10629dce..aa24adf59 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -142,6 +142,8 @@ LIBNVME_3 {
 		nvme_ns_get_write_sectors;
 		nvme_ns_get_inflights;
 		nvme_ns_get_io_ticks;
+		nvme_ns_get_command_retry_count;
+		nvme_ns_get_command_error_count;
 		nvme_ns_identify;
 		nvme_ns_read;
 		nvme_ns_verify;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 3d7dfb3c4..b2ba1948a 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -211,6 +211,9 @@ struct nvme_ns { /*!generate-accessors*/
 	uint8_t nguid[16];
 	unsigned char uuid[NVME_UUID_LEN];
 	enum nvme_csi csi;
+
+	long command_retry_count; //!accessors:none
+	long command_error_count; //!accessors:none
 };
 
 struct nvme_ctrl { /*!generate-accessors*/
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 844e18b5c..a8069072d 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -2592,6 +2592,28 @@ __public void nvme_ns_get_uuid(nvme_ns_t n, unsigned char out[NVME_UUID_LEN])
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
index 4b5d3fd70..ea5dc09a5 100644
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


