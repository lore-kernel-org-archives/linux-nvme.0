Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0460F8FA78
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aHjDrjf1+0olF/ArTIUuOlPCt7VSq+MMjWEpW7Xtv+I=; b=qB6Qzk0AQyAz84GK64G6cPS1Hc
	Btim4EYEdoclLkyoW8vJ3dYkt3BQP+BRNYKdREaOIbSYEJJOaZOFo8guji5/kEe8V2AzRgULwpp+B
	CcB2IYCyRx34fe6rvV3uSzVGq1AaZ/a68OUrlJynQkjaMtBbCs+CkqKEbx0e3LsuooOUVYK+F/jA5
	pX9E3HwQOUENeBcU/jDJt/qiCd29GNxPOxZ40MTXVJT80HgYpYJFwYvc+e5A2ws6WvvcGG5U6TULW
	aaj2U5yzz50SGb9MQXyIgf5BJKvQviekH7y1MKADU8FoB7lj5b30ibdZzr6zD0S7T/DEFsl/cwK+g
	sD2mqKXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRd-00000008m2k-3QFV;
	Tue, 21 Apr 2026 14:51:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRa-00000008lyS-2lJ4
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:20 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCFEhj1686174;
	Tue, 21 Apr 2026 14:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aHjDrjf1+0olF/ArT
	IUuOlPCt7VSq+MMjWEpW7Xtv+I=; b=f9pzKrDiFfH8kA4gQzDovIo5NCSCG6IJW
	iF27Tn8MJFLJ179OZGOohFefQDjTt5OHmcnGfNH+JZYKs71AAPiqNsmBKG8x/O6t
	dHsHcxGPxOLwh49CzJZJ93JROAm8FedpqshHxlRzhi531IUaXg3KxknzbyFW9RdH
	aIJzaaWNSASY0rbFBUcMnF7amjcBAq49RLAKzVc0rD7T68TZ7/5B4kzQIKPfFDhy
	V4PnhSFdAJiBcpbnNLnyIEBEdiw2Jv2zSEVLciye/0JGBBdjf75GgEc/wRXIcJdh
	Gr9I4pJPg/fOrACo+eMJevW1nlcpsIltTB3qLPgNyPfWuLPou2erw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6mu0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoF9C012915;
	Tue, 21 Apr 2026 14:51:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg8y0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEpBYb43516222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:51:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 481DA20043;
	Tue, 21 Apr 2026 14:51:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E050D20040;
	Tue, 21 Apr 2026 14:51:08 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:51:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 9/9] libnvme: add support for ctrl diagnostic counters
Date: Tue, 21 Apr 2026 20:20:30 +0530
Message-ID: <20260421145038.3458987-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX8OGUF8hekGAi
 5OGPhw1lLrB24T9DEPaoxiRbzvuxvzG+9QHEKhaqKb5pj4e9+t3I3L0dRYKTnj4DPeibRC0meOg
 0BcUfr1F3G+HHmR6l9QUvSp1UW4BcndFSQASuGtlp/UxwAL4+9ysH4oXSsfQV2FA3OOgviGC3N4
 Cn+O715MQ6LAb6tSgIT21GpvRuPTXTQSnhnfRNLR5e8NV8vR+XzlUpiJoDe2+Gxn8y/Yhy3suNX
 ukyldKFGy8ErAUvUwcEIBTJzABdtnzHRj0p0kCYxogRUq3AJsGaGLNPWOUlrPOqaP7B1gu+N8hc
 GL71rj/yyvUlryCJA3VWugzvZWF1O8OWqJxbVapdUL7RFvyPWHffQGaSd0pxwulIneT0ObkM04J
 nPltWl1uRVFqZp8Mv2FNvL5dnwjGeZseeUey40aewCzlfFz5UiZbTJ44Cu1//1OmvsAgSD+E36I
 aea5eyAbgbuR17e8mBg==
X-Proofpoint-GUID: C2EBmpIzG2UTVgqDVX77MJwIOF6WZQv3
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e78ee3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=miZTg8r9HIEdnQr3rz0A:9
X-Proofpoint-ORIG-GUID: C2EBmpIzG2UTVgqDVX77MJwIOF6WZQv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075118_774013_E8060526 
X-CRM114-Status: GOOD (  15.64  )
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

Add support for retrieving ctrl diagnostic counters such as command_
error_count, reset_count and reconnect_count. These counters improve
visibility and can be useful for tools such as nvme-top to display
real-time statistics.

Unlike other sysfs attributes, these counters can change dynamically.
Annotate them with "!accessors:none" and provide custom implementations
to always retrieve the latest (non-cached) values.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  3 +++
 libnvme/src/nvme/private.h |  3 +++
 libnvme/src/nvme/tree.c    | 33 +++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 25 +++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index c9841e45c..68df5e2b6 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -14,6 +14,9 @@ LIBNVME_3 {
 		libnvme_ctrl_get_subsysnqn;
 		libnvme_ctrl_get_subsystem;
 		libnvme_ctrl_get_transport_handle;
+		libnvme_ctrl_get_command_error_count;
+		libnvme_ctrl_get_reset_count;
+		libnvme_ctrl_get_reconnect_count;
 		libnvme_ctrl_identify;
 		libnvme_ctrl_match_config;
 		libnvme_ctrl_next_ns;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 170445927..f7612c06d 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -295,6 +295,9 @@ struct libnvme_ctrl { // !generate-accessors
 	bool unique_discovery_ctrl;
 	bool discovered;
 	bool persistent;
+	long command_error_count; //!accessors:none
+	long reset_count; //!accessors:none
+	long reconnect_count; //!accessors:none
 	struct libnvme_fabrics_config cfg;
 };
 
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 085d79558..f87a6d0c3 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -1458,6 +1458,39 @@ __public const char *libnvme_ctrl_get_state(libnvme_ctrl_t c)
 	return c->state;
 }
 
+__public long libnvme_ctrl_get_command_error_count(libnvme_ctrl_t c)
+{
+	__cleanup_free char *error_count = NULL;
+
+	error_count = libnvme_get_ctrl_attr(c, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &c->command_error_count);
+
+	return c->command_error_count;
+}
+
+__public long libnvme_ctrl_get_reset_count(libnvme_ctrl_t c)
+{
+	__cleanup_free char *reset_count = NULL;
+
+	reset_count = libnvme_get_ctrl_attr(c, "reset_count");
+	if (reset_count)
+		sscanf(reset_count, "%ld", &c->reset_count);
+
+	return c->reset_count;
+}
+
+__public long libnvme_ctrl_get_reconnect_count(libnvme_ctrl_t c)
+{
+	__cleanup_free char *reconnect_count = NULL;
+
+	reconnect_count = libnvme_get_ctrl_attr(c, "reconnect_count");
+	if (reconnect_count)
+		sscanf(reconnect_count, "%ld", &c->reconnect_count);
+
+	return c->reconnect_count;
+}
+
 __public int libnvme_ctrl_identify(libnvme_ctrl_t c, struct nvme_id_ctrl *id)
 {
 	struct libnvme_transport_handle *hdl =
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 6bfc8cf98..48f1beb49 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -1007,6 +1007,31 @@ unsigned long long libnvme_ns_get_read_sectors(libnvme_ns_t n);
  */
 unsigned long long libnvme_ns_get_write_sectors(libnvme_ns_t n);
 
+/**
+ * libnvme_ctrl_get_command_error_count() - Get admin command error count
+ * @c: Controller instance
+ *
+ * Return: Number of times admin command issued to controller @c failed or
+ * returned error status
+ */
+long libnvme_ctrl_get_command_error_count(libnvme_ctrl_t c);
+
+/**
+ * libnvme_ctrl_get_reset_count() - Get controller reset count
+ * @c: Controller instance
+ *
+ * Return: Number of timer controller @c is reset
+ */
+long libnvme_ctrl_get_reset_count(libnvme_ctrl_t c);
+
+/**
+ * libnvme_ctrl_get_reconnect_count() - Get controller reconnect count
+ * @c: Controller instance
+ *
+ * Return: Number of times controller has to reconnect to the target
+ */
+long libnvme_ctrl_get_reconnect_count(libnvme_ctrl_t c);
+
 /**
  * libnvme_ctrl_identify() - Issues an 'identify controller' command
  * @c:	Controller instance
-- 
2.53.0


