Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD1C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E69D613AC
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E69D613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1jL2GtUPuE2xONEQdwYiU5NADrGNF0Fdwld3QVOsUU=; b=xkqEee0tJ4n5+mc57ZsVC4QWxm
	JWb2SmASeP0yxCseCdBurdJChgEB+E+MC1g9ckQGAdcp8WFDCry+nEnP/Wul60b8LolC/7RHCGoDE
	6Nr6LL/E7Fk6KlfL4BlUSQAO9cNmxPebURUAPzuSMBagsCj7tKcxoxH87RL1FMS2a8+2UHXQHN5EB
	uHhA8/pbC4LXgEfWiZjPbSqiO8yeXdCSOjzhk9k1Iw2hslcn8LzHj4u3dD3wgoJ9hGqg9HLMww0yx
	lOCrvas3CAG+Jko74wf+/Btnw9mWafZPdM35ldi8iZe9keK/aRNWv8vexTnMTTkqtDRnwUswNaKOi
	LjkJvxlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm89-008YHp-W4; Thu, 18 Nov 2021 18:27:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7t-008YEV-VQ
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:15 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHIoGw031401; 
 Thu, 18 Nov 2021 18:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=H1jL2GtUPuE2xONEQdwYiU5NADrGNF0Fdwld3QVOsUU=;
 b=EdB5fvCmBBndJ/kFkGW5zPUvUSAGX3FwuzC8tYMFRwJinMVm1ExqlhNllVP2OAJFeugR
 biP1GNu6xMIyJdacuxPjkgeIF8OLglZTXup1+c2YwXUsRESGx+9AS2UQtqGhMeENGsvK
 UVZRf9nNwq1RigofMwyYAgzdJjTO3L/+SVEmvN3y/hkEqvFryJCQQL5wPx+rvtdsvcb1
 pC0xF5RzRnSA+kh8edNXIkPa168rAoTSoB0clBtQBaUd/rIRZ7g6xpV9dXvAOfB1c39X
 iOH6+VE1gG0nLuRWNqLX4TfTuo7IaGLKWjcfjDGO5V0t/tlw95yoNW8dvArmaUDox4vG ZA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cdu4c1g65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:12 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIJ5ZU004645;
 Thu, 18 Nov 2021 18:27:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03wdc.us.ibm.com with ESMTP id 3ca50cb413-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIR9DZ15991240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F5EFB2072;
 Thu, 18 Nov 2021 18:27:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD0C7B205F;
 Thu, 18 Nov 2021 18:27:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:27:08 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 1/5] nvme-cli: Decode "Supported Events Bitmap" in PEL
 header
Date: Thu, 18 Nov 2021 10:57:24 -0600
Message-Id: <1637254648-19500-2-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1mxiTMisWemxsi-aH0zsvsXP9RB_Twja
X-Proofpoint-ORIG-GUID: 1mxiTMisWemxsi-aH0zsvsXP9RB_Twja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102714_163902_F4D4EBD4 
X-CRM114-Status: GOOD (  21.89  )
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
 nvme-print.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 nvme.c       |  4 ++--
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 1556b52..1b419b7 100644
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
@@ -1081,6 +1101,29 @@ static const char *nvme_show_nss_hw_error(__u16 error_code)
 	}
 }
 
+void add_bitmap(int i, __u8 seb, struct json_object *root, int json_flag)
+{
+	char evt_str[50];
+	char key[128];
+
+	for (int bit = 0; bit < 8; bit++) {
+		if (nvme_pel_event_to_string(bit + i * 8)) {
+			if (json_flag == 1) {
+				sprintf(key, "bitmap_%x", (bit + i * 8));
+				if ((seb >> bit) & 0x1)
+					snprintf(evt_str, sizeof(evt_str), "Support %s",
+						nvme_pel_event_to_string(bit + i * 8));
+				json_object_add_value_string(root, key, evt_str);
+			} else {
+				if (nvme_pel_event_to_string(bit + i * 8))
+					if ((seb >> bit) & 0x1)
+						printf("	Support %s\n",
+							nvme_pel_event_to_string(bit + i * 8));
+			}
+		}
+	}
+}
+
 void json_persistent_event_log(void *pevent_log_info, __u32 size)
 {
 	struct json_object *root;
@@ -1151,9 +1194,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 		for (int i = 0; i < 32; i++) {
 			if (pevent_log_head->seb[i] == 0)
 				continue;
-			sprintf(key, "bitmap_%d", i);
-			json_object_add_value_uint(root, key,
-				pevent_log_head->seb[i]);
+			add_bitmap(i, pevent_log_head->seb[i], root, 1);
 		}
 	} else {
 		printf("No log data can be shown with this log len at least " \
@@ -1479,12 +1520,11 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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
+			add_bitmap(i, pevent_log_head->seb[i], NULL, 0);
 		}
 	} else {
 		printf("No log data can be shown with this log len at least " \
diff --git a/nvme.c b/nvme.c
index 6ebfa92..a68db6c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4922,7 +4922,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 
 	nc = argconfig_parse_comma_sep_array(cfg.ctx_attrs, (int *)ctx_attrs, ARRAY_SIZE(ctx_attrs));
 	nb = argconfig_parse_comma_sep_array(cfg.blocks, (int *)nlbs, ARRAY_SIZE(nlbs));
-	ns = argconfig_parse_comma_sep_array_long(cfg.slbas, slbas, ARRAY_SIZE(slbas));
+	ns = argconfig_parse_comma_sep_array_long(cfg.slbas, (long long unsigned int *)slbas, ARRAY_SIZE(slbas));
 	nr = max(nc, max(nb, ns));
 	if (!nr || nr > 256) {
 		fprintf(stderr, "No range definition provided\n");
@@ -5067,7 +5067,7 @@ static int copy(int argc, char **argv, struct command *cmd, struct plugin *plugi
 		}
 	}
 
-	nvme_init_copy_range(copy, nlbs, slbas, eilbrts, elbatms, elbats, nr);
+	nvme_init_copy_range(copy, nlbs, (__u64 *)slbas, eilbrts, elbatms, elbats, nr);
 
 	err = nvme_copy(fd, cfg.namespace_id, copy, cfg.sdlba, nr, cfg.prinfor,
 			cfg.prinfow, cfg.dtype, cfg.dspec, cfg.format, cfg.lr,
-- 
2.27.0


