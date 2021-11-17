Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD32C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A49C61221
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A49C61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ePPDRModMKuYw3cQ4h/nf05LfuV3f94H6PHm6G9Gj2U=; b=YaWdW0H8WJOXURKEiI7rFc1dZE
	LA0RTXKP71vq2hqWVn9lIMxprultJkSz8t5UhOFpTui2RmBZyFNKrhKL7ytEYnu04QGfZ0cKeNCYk
	K0oj1pfbS5s46gszRB8JRYbMue/oivDbnhohb3knS4eLLztfW0O4+ZStocBWYJg8J51yC/HwOjU2J
	/aiKtg+kZHnw7oGk2TnmsPzviEpA+WRt1VlORvBqFazMSR3Yno2ZWamG7OhlY3XhqlmetV4XoCX+7
	XFEvieq21/V0QRDE+J2DzbrstctH82xljPq16zVDW5dWXzH4Hi+hUJMQeojAQJ+XIQnSshoIFVyPP
	H2c7uTHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnOpN-005rm3-6N; Wed, 17 Nov 2021 17:34:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOpJ-005rju-RT
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 17:34:31 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHCZVm029032; 
 Wed, 17 Nov 2021 17:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=ePPDRModMKuYw3cQ4h/nf05LfuV3f94H6PHm6G9Gj2U=;
 b=CqSRzSJkAKOvyjsY9bEDF+WuDYRXd1YknDuDUfPHFfzp6UP5pjwdyW+9kzPSHGMgqBuP
 IsWwO4UNsBy9K77G6PG8xGVv79ljOEsvonU+/KnIy21WnW5gvg1eLwCyHQtcoxV9aGdy
 CPOnC6DuLIpXF3JbdaCOh6/IjN7nEWgeeLN7IelOpZbR59WVUitqugIsTjivzXfHjsiS
 4hjvIbjBr42p/PZ8xyKFzTAEuFjMQH15kEOZW8rU3XPXrRaUOLsVs52tLTeyMWgnAcBl
 GobMAws8zkcpOddn/LSpu6VQTRD2lKFDpPl2nXsy9g8rjVnNhiDPmhjc5rFgaN4CuEPT /A== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cd5x78dks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:28 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHWs8H011777;
 Wed, 17 Nov 2021 17:34:27 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 3ca50brr95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:27 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AHHYQOl60097008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Nov 2021 17:34:26 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED0316E059;
 Wed, 17 Nov 2021 17:34:25 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E4ED6E053;
 Wed, 17 Nov 2021 17:34:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Nov 2021 17:34:25 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: anaidu.gollu@samsung.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 1/5] nvme-cli: Decode "Supported Events Bitmap" in PEL header
Date: Wed, 17 Nov 2021 10:04:44 -0600
Message-Id: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: igp_-dyN4EnWxBn4F1GA4VgrBGxWMOY0
X-Proofpoint-ORIG-GUID: igp_-dyN4EnWxBn4F1GA4VgrBGxWMOY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_093430_043131_6BD8B359 
X-CRM114-Status: GOOD (  21.98  )
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

From: Wen Xiong <wenxiong@linux.ibm.com>

"Supported Events Bitmap" in PEL header shows what events
are supported in current nvme devices.

Persistent Event Log for device: nvme0n1
Action for Persistent Event Log: 0
..
..
..
Supported Events Bitmap:
        Support SMART/Health Log Snapshot Event(0x1)
        Support Firmware Commit Event(0x2)
        Support Timestamp Change Event(0x3)
        Support Power-on or Reset Event(0x4)
        Support NVM Subsystem Hardware Error Event(0x5)
        Support Change Namespace Event(0x6)
        Support Format NVM Start Event(0x7)
        Support Format NVM Completion Event(0x8)
        Support Sanitize Start Event(0x9)
        Support Sanitize Completion Event(0xa)
        Support Set Feature Event(0xb)
        Support Set Telemetry CRT  Event(0xc)
        Support Thermal Excursion Event(0xd)

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 nvme-print.c | 44 ++++++++++++++++++++++++++++++++++++++------
 nvme.c       |  4 ++--
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 1556b52..16fd569 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1053,6 +1053,26 @@ void nvme_show_predictable_latency_event_agg_log(
 	}
 }
 
+const char *nvme_pel_event_to_string(int type)
+{
+	switch (type) {
+	case NVME_PEL_SMART_HEALTH_EVENT:	return "SMART/Health Log Snapshot Event(0x1)";
+	case NVME_PEL_FW_COMMIT_EVENT:	return "Firmware Commit Event(0x2)";
+	case NVME_PEL_TIMESTAMP_EVENT:	return "Timestamp Change Event(0x3)";
+	case NVME_PEL_POWER_ON_RESET_EVENT:	return "Power-on or Reset Event(0x4)";
+	case NVME_PEL_NSS_HW_ERROR_EVENT:	return "NVM Subsystem Hardware Error Event(0x5)";
+	case NVME_PEL_CHANGE_NS_EVENT:	return "Change Namespace Event(0x6)";
+	case NVME_PEL_FORMAT_START_EVENT:	return "Format NVM Start Event(0x7)";
+	case NVME_PEL_FORMAT_COMPLETION_EVENT:	return "Format NVM Completion Event(0x8)";
+	case NVME_PEL_SANITIZE_START_EVENT:	return "Sanitize Start Event(0x9)";
+	case NVME_PEL_SANITIZE_COMPLETION_EVENT:	return "Sanitize Completion Event(0xa)";
+	case NVME_PEL_SET_FEATURE_EVENT:	return "Set Feature Event(0xb)";
+	case NVME_PEL_TELEMETRY_CRT:		return "Set Telemetry CRT  Event(0xc)";
+	case NVME_PEL_THERMAL_EXCURSION_EVENT:	return "Thermal Excursion Event(0xd)";
+	default:			return NULL;
+	}
+}
+
 static const char *nvme_show_nss_hw_error(__u16 error_code)
 {
 	switch (error_code) {
@@ -1089,6 +1109,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
 	char key[128];
+	char evt_str[50];
 
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
@@ -1151,9 +1172,16 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 		for (int i = 0; i < 32; i++) {
 			if (pevent_log_head->seb[i] == 0)
 				continue;
-			sprintf(key, "bitmap_%d", i);
-			json_object_add_value_uint(root, key,
-				pevent_log_head->seb[i]);
+			for (int bit = 0; bit < 8; bit++) {
+				if (nvme_pel_event_to_string(bit + i * 8)) {
+					sprintf(key, "bitmap_%x", (bit + i * 8));
+					if ((pevent_log_head->seb[i] >> bit) & 0x1)
+						snprintf(evt_str, sizeof(evt_str), "Support %s",
+							nvme_pel_event_to_string(bit + i * 8));
+					json_object_add_value_string(root, key, evt_str);
+				}
+			}
+
 		}
 	} else {
 		printf("No log data can be shown with this log len at least " \
@@ -1479,12 +1507,16 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			le32_to_cpu(pevent_log_head->rci));
 		if (human)
 			nvme_show_persistent_event_log_rci(pevent_log_head->rci);
-		printf("Supported Events Bitmap: ");
+		printf("Supported Events Bitmap: \n");
 		for (int i = 0; i < 32; i++) {
 			if (pevent_log_head->seb[i] == 0)
 				continue;
-			printf("  BitMap[%d] is 0x%x\n", i,
-				pevent_log_head->seb[i]);
+			for (int bit = 0; bit < 8; bit++) {
+				if (nvme_pel_event_to_string(bit + i * 8))
+					if ((pevent_log_head->seb[i] >> bit) & 0x1)
+						printf("	Support %s\n",
+							nvme_pel_event_to_string(bit + i * 8));
+			}
 		}
 	} else {
 		printf("No log data can be shown with this log len at least " \
diff --git a/nvme.c b/nvme.c
index 303315c..7f89801 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4900,7 +4900,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 
 	nc = argconfig_parse_comma_sep_array(cfg.ctx_attrs, (int *)ctx_attrs, ARRAY_SIZE(ctx_attrs));
 	nb = argconfig_parse_comma_sep_array(cfg.blocks, (int *)nlbs, ARRAY_SIZE(nlbs));
-	ns = argconfig_parse_comma_sep_array_long(cfg.slbas, slbas, ARRAY_SIZE(slbas));
+	ns = argconfig_parse_comma_sep_array_long(cfg.slbas, (long long unsigned int *)slbas, ARRAY_SIZE(slbas));
 	nr = max(nc, max(nb, ns));
 	if (!nr || nr > 256) {
 		fprintf(stderr, "No range definition provided\n");
@@ -5044,7 +5044,7 @@ static int copy(int argc, char **argv, struct command *cmd, struct plugin *plugi
 		}
 	}
 
-	nvme_init_copy_range(copy, nlbs, slbas, eilbrts, elbatms, elbats, nr);
+	nvme_init_copy_range(copy, nlbs, (__u64 *)slbas, eilbrts, elbatms, elbats, nr);
 
 	err = nvme_copy(fd, cfg.namespace_id, copy, cfg.sdlba, nr, cfg.prinfor,
 			cfg.prinfow, cfg.dtype, cfg.dspec, cfg.format, cfg.lr,
-- 
2.27.0


