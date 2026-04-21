Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCBDF8FA8D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6kSawJKD+9RuaA3RmisN6u2rIiiremRl532yBqSntz4=; b=ujdef8T9QrArauSnRXBMWkxn7z
	polb5AkGD0ygQWRpxOzCi3GLsB4D9f4xBctF7qApaXugIERQ1ZkChi3db8D82ym4At+lmQhv1W66M
	DKVNnPskaBK03NXkW3T1C2pdCyGuuy+js05YrOwPKLnO8zp2v89bJ3Cm1k0cKHV5wW3g8TH15T5Ue
	iDmEi+r/C3Pk/gADunZMiX6P8/NiMZbx9CxEXAigfVOEBcUsa9i/m/IPax1HqPlTKYGyplzUVZPXv
	1BQbfUNo8rIFCRs7TwQGw4qZLMHSk0uB+oqj4eORqrkL0QhyuPgB5EA7f8kcop4+zCG6C+WDW8Xdv
	4gmJlMBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRX-00000008luY-2Fz0;
	Tue, 21 Apr 2026 14:51:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRV-00000008lqt-1sYQ
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:14 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCVWti2039384;
	Tue, 21 Apr 2026 14:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6kSawJKD+9RuaA3Rm
	isN6u2rIiiremRl532yBqSntz4=; b=Gyc4fSU6Xl9vZ71hCFVkh77OX6OAv0DCc
	opcngp4aGymAYkG/RRLds8DyD0wguLOcwVlwvdddIWtPxVslWjsQQY1aMkWu1Nvl
	wYSfUIPBzMqoNxnBjgFr9fUMmoT9ICqZuVyvfb21Q9d/i2lEbAyK/HgdLLQp8Fqv
	s4zgkNINOciDb5Dv30x2zw68/uvNbDZ33lQNmU0ZMJRj60LgPfZsk7eBqae+Hu7v
	QkNfTqZgoaaEbGWFpygnv2mmdim8yxsuexJGEJxd4LfzVG9FCGp6feYNBWsj6xok
	rYbYxvltQVfB6mOmsfagwdlmeiPh5pHScEU8pKN3MmaALo4KqQmVw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9m2ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoGYu016644;
	Tue, 21 Apr 2026 14:51:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q18ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEp5wF28377384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:51:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E39420040;
	Tue, 21 Apr 2026 14:51:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24C220043;
	Tue, 21 Apr 2026 14:51:02 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:51:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 7/9] libnvme: add support for namespace diagnostic counters
Date: Tue, 21 Apr 2026 20:20:28 +0530
Message-ID: <20260421145038.3458987-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LpY-oAVFKt7XGofg-Ntgu22H758npk06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX/TbSuSHNcJoY
 idEqlX6UTOKEfCiwnE1bpbUjrkNT1NRf+R12zzKBIzuaQilEdLWlM1/8RDc19fL0XTtkG8hA7ab
 BCd2hy8iueooBgglmNHsGuqL1VR82nDHtpI4h3tFXUMd6ckppuHq1uiLPS96Y+HwWb5vL3uzcDP
 qEIBWA88GgBxP+BESX1I0mobCWxITkD5xT6t07gFPk0zjrmsYqWX7gHzbOXvexCYaZ+E9m21xXT
 IJ0hGPJx6vll3zAJm3WFPTgMWH3NyrQa9OGHrtCinWYP6MH6hnp7w9m+uSaf8VqY18bNVg1aXNB
 2B7VkooG+I6XRm+kgbm/0tdPRmbbIyM2FLTr6Wtg1cxb3d7tC+VPXyt5rF8kV+0PjIwvLCfETxw
 S8qp2LTdI0ACYMPJ2wtdH66FkpmpOdQRevNNbEqc86Gx9QTfas5oIM6wq2rCLF0yiPGerKFhLMV
 17RV+S89Y3KhScIIx2g==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e78edd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=eWOsen54q2aj2Yl9ipMA:9
X-Proofpoint-GUID: LpY-oAVFKt7XGofg-Ntgu22H758npk06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075113_691751_D8B66927 
X-CRM114-Status: GOOD (  15.14  )
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
index 85ff00e55..2fafd333c 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -140,6 +140,8 @@ LIBNVME_3 {
 		libnvme_ns_get_write_sectors;
 		libnvme_ns_get_inflights;
 		libnvme_ns_get_io_ticks;
+		libnvme_ns_get_command_retry_count;
+		libnvme_ns_get_command_error_count;
 		libnvme_ns_identify;
 		libnvme_ns_read;
 		libnvme_ns_verify;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 7f01f8a7d..ec0e1e848 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -251,6 +251,9 @@ struct libnvme_ns { // !generate-accessors
 	uint8_t nguid[16];
 	unsigned char uuid[NVME_UUID_LEN];
 	enum nvme_csi csi;
+
+	long command_retry_count; //!accessors:none
+	long command_error_count; //!accessors:none
 };
 
 struct libnvme_ctrl { // !generate-accessors
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index a603c2fde..f1a1311b7 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -2611,6 +2611,28 @@ __public void libnvme_ns_get_uuid(libnvme_ns_t n,
 	memcpy(out, n->uuid, NVME_UUID_LEN);
 }
 
+__public long libnvme_ns_get_command_retry_count(libnvme_ns_t n)
+{
+	__cleanup_free char *retry_count = NULL;
+
+	retry_count = libnvme_get_ns_attr(n, "command_retry_count");
+	if (retry_count)
+		sscanf(retry_count, "%ld", &n->command_retry_count);
+
+	return n->command_retry_count;
+}
+
+__public long libnvme_ns_get_command_error_count(libnvme_ns_t n)
+{
+	__cleanup_free char *error_count = NULL;
+
+	error_count = libnvme_get_ns_attr(n, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &n->command_error_count);
+
+	return n->command_error_count;
+}
+
 __public int libnvme_ns_identify(libnvme_ns_t n, struct nvme_id_ns *ns)
 {
 	struct libnvme_transport_handle *hdl;
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 2eb4cea0e..63cd20838 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -510,6 +510,23 @@ const uint8_t *libnvme_ns_get_nguid(libnvme_ns_t n);
  */
 void libnvme_ns_get_uuid(libnvme_ns_t n, unsigned char out[NVME_UUID_LEN]);
 
+/**
+ * libnvme_ns_get_command_retry_count() - Get command retry count
+ * @n: &libnvme_ns_t object
+ *
+ * Return: Number of times any command issued to namespace @n has to be retried
+ */
+long libnvme_ns_get_command_retry_count(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_command_error_count() - Get command error count
+ * @n: &libnvme_ns_t object
+ *
+ * Return: Number of times command issued to namespace @n returns non-zero
+ * status or error
+ */
+long libnvme_ns_get_command_error_count(libnvme_ns_t n);
+
 /**
  * libnvme_ns_get_generic_name() - Returns name of generic namespace chardev.
  * @n:	Namespace instance
-- 
2.53.0


