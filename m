Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDC1C33CA2
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 19:02:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D1D20705
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 19:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Otj3QQc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D1D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=O3Dp6HSv5EGOvH11QUyeGFFPttL8aPy2d3I2IfXlr6E=; b=Otj
	3QQc0rqlA+m8Q6diNjFRe26/jNJBzlGt0Zg6MPpaXoMAgcySmlcNzEWM5u3luGBs38j1eJhE/XjAR
	1+YcFqe+AlRYgVV6kretMoBT0oIMgfLz4fwM8bEBDG9KIHRXkCD5G3LE4oqwEPDJP+ZbtgTvvZvde
	bHtxByq4UneGB6x43iL/seIjkHaGy89UlDR4npwlhI5ba9bPKiu3MuAS6UJiV4/d1BmR9wbFAcll6
	w1w4LOTuvOhdQceG6MqLpgpiXVmK8olWGgxU3kkKTzZma7wHQXbGaBxCVsFzEzKPbUXkh1FSxgkYE
	iy5EupqhQ7cTWmXUvITKrNNOZL56wTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipGaf-0004sk-Q0; Wed, 08 Jan 2020 19:02:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipGZu-00049t-4P
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 19:01:17 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 008Iq4Nu048454; Wed, 8 Jan 2020 14:01:10 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xdeb06s76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 14:01:10 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 008J174R010957;
 Wed, 8 Jan 2020 19:01:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02wdc.us.ibm.com with ESMTP id 2xajb76xsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 19:01:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 008J18v142926352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2020 19:01:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12498BE05A;
 Wed,  8 Jan 2020 19:01:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C24D3BE063;
 Wed,  8 Jan 2020 19:01:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2020 19:01:07 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-cli: improvment critical warning format
Date: Wed,  8 Jan 2020 11:39:35 -0600
Message-Id: <1578505175-15002-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-08_05:2020-01-08,
 2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=3 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_110114_331092_992C7815 
X-CRM114-Status: GOOD (  16.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, Wen Xiong <wenxiong@linux.vnet.ibm.com>,
 wenxiong@us.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

This patch improves the critical warning format with smart-log.

Signed-off-by: Wendy Xiong<wenxiong@linux.vnet.ibm.com>
---
 nvme-print.c |   28 +++++++++++++++++++++++++---
 nvme-print.h |    4 ++--
 nvme.c       |   11 +++++++++--
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index d3e3307..d64ae07 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1722,15 +1722,26 @@ void show_endurance_log(struct nvme_endurance_group_log *endurance_group,
 		int128_to_double(endurance_group->num_err_info_log_entries));
 }
 
-void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname)
+void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname, unsigned int flag)
 {
 	/* convert temperature from Kelvin to Celsius */
 	int temperature = ((smart->temperature[1] << 8) |
 		smart->temperature[0]) - 273;
 	int i;
+	int human = flag & HUMAN;
 
 	printf("Smart Log for NVME device:%s namespace-id:%x\n", devname, nsid);
-	printf("critical_warning			: %#x\n", smart->critical_warning);
+	printf("critical_warning                        : %#x\n", smart->critical_warning);
+
+	if (human) {
+		printf("      Available Spare[0]             : %d\n", smart->critical_warning & 0x01);
+		printf("      Temp. Threshold[1]             : %d\n", (smart->critical_warning & 0x02) >> 1);
+		printf("      NVM subsystem Reliability[2]   : %d\n", (smart->critical_warning & 0x04) >> 2);
+		printf("      Read-only[3]                   : %d\n", (smart->critical_warning & 0x08) >> 3);
+		printf("      Volatile mem. backup failed[4] : %d\n", (smart->critical_warning & 0x10) >> 4);
+		printf("      Persistent Mem. RO[5]          : %d\n", (smart->critical_warning & 0x20) >> 5);
+	}
+
 	printf("temperature				: %d C\n", temperature);
 	printf("available_spare				: %u%%\n", smart->avail_spare);
 	printf("available_spare_threshold		: %u%%\n", smart->spare_thresh);
@@ -3221,11 +3232,12 @@ void json_endurance_log(struct nvme_endurance_group_log *endurance_group,
 	json_free_object(root);
 }
 
-void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname)
+void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname, unsigned int flag)
 {
 	struct json_object *root;
 	int c;
 	char key[21];
+	int human = flag & HUMAN;
 
 	unsigned int temperature = ((smart->temperature[1] << 8) |
 		smart->temperature[0]);
@@ -3244,6 +3256,16 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	root = json_create_object();
 
 	json_object_add_value_int(root, "critical_warning", smart->critical_warning);
+
+	if (human) {
+		json_object_add_value_int(root,"   Available Spare[0]", smart->critical_warning & 0x01);
+		json_object_add_value_int(root,"   Temp. Threshold[1]", (smart->critical_warning & 0x02) >> 1);
+		json_object_add_value_int(root,"   NVM subsystem Reliability[2]", (smart->critical_warning & 0x04) >> 2);
+		json_object_add_value_int(root,"   Read-only[3]", (smart->critical_warning & 0x08) >> 3);
+		json_object_add_value_int(root,"   Volatile mem. backup failed[4]", (smart->critical_warning & 0x10) >> 4);
+		json_object_add_value_int(root,"   Persistent Mem. RO[5]", (smart->critical_warning & 0x20) >> 5);
+	}
+
 	json_object_add_value_int(root, "temperature", temperature);
 	json_object_add_value_int(root, "avail_spare", smart->avail_spare);
 	json_object_add_value_int(root, "spare_thresh", smart->spare_thresh);
diff --git a/nvme-print.h b/nvme-print.h
index dea8915..44d7ff6 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -24,7 +24,7 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void show_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11);
 void show_lba_range(struct nvme_lba_range_type *lbrt, int nr_ranges);
 void show_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
-void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
+void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname, unsigned int flag);
 void show_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname);
 void show_self_test_log(struct nvme_self_test_log *self_test, const char *devname);
 void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
@@ -57,7 +57,7 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vend
 void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void json_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11);
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
-void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
+void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname, unsigned int flag);
 void json_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname);
 void json_effects_log(struct nvme_effects_log_page *effects_log, const char *devname);
 void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *devname);
diff --git a/nvme.c b/nvme.c
index 0823267..c511f9d 100644
--- a/nvme.c
+++ b/nvme.c
@@ -174,11 +174,14 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 			"(default) or binary.";
 	const char *namespace = "(optional) desired namespace";
 	const char *raw = "output in binary format";
+	const char *human_readable = "show info in readable format";
 	int err, fmt, fd;
+	unsigned int flags = 0;
 
 	struct config {
 		__u32 namespace_id;
 		int   raw_binary;
+		int   human_readable;
 		char *output_format;
 	};
 
@@ -192,6 +195,7 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 		OPT_UINT("namespace-id", 'n', &cfg.namespace_id,  namespace),
 		OPT_FMT("output-format", 'o', &cfg.output_format, output_format),
 		OPT_FLAG("raw-binary",   'b', &cfg.raw_binary,    raw),
+		OPT_FLAG("human-readable", 'H', &cfg.human_readable,    human_readable),
 		OPT_END()
 	};
 
@@ -209,14 +213,17 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
+	if (cfg.human_readable)
+		flags |= HUMAN;
+
 	err = nvme_smart_log(fd, cfg.namespace_id, &smart_log);
 	if (!err) {
 		if (fmt == BINARY)
 			d_raw((unsigned char *)&smart_log, sizeof(smart_log));
 		else if (fmt == JSON)
-			json_smart_log(&smart_log, cfg.namespace_id, devicename);
+			json_smart_log(&smart_log, cfg.namespace_id, devicename, flag);
 		else
-			show_smart_log(&smart_log, cfg.namespace_id, devicename);
+			show_smart_log(&smart_log, cfg.namespace_id, devicename, flag);
 	} else if (err > 0)
 		show_nvme_status(err);
 	else
-- 
1.6.0.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
