Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ADD1094486
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVDw+RDGjCfAeDh+0mKD4Um8UDQRGxqpkoCAbYKaNTo=; b=ZfOyiCm73VYMTUWOkRb+oPmtuL
	v4cxeGPnoayTuvLdQWjxfn0gNxTkOZ/LJgvJ556AQQM2P4CmNmaOexlG4al3omPI3Kr2VTleDToUs
	hD6Pidrftb/l1QNMTf2RTj4/3ALgcse7/X3ihMWGaMj1mugIO8/wnrvImfVSlFgDgdeDW8OMAlFE4
	4XHKBoNajntuVST+JJA4vyxT1YojtLvkGW1xfD7N4acvT1BnqwTXyCnSlHF7qQeTPOeQ4t3rL8s4T
	llGB2kpQovSMf/UhiDRzKl4/wfT94apYOpDY29s4ap3dcVASm+d1ynuOViWR/7c9NnJgMxhzVm/Qk
	ve7/S9Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGO-0000000EaWP-0OhY;
	Sat, 21 Mar 2026 15:29:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yGI-0000000EaPZ-3Vk8
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:29:18 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAvAbi637363;
	Sat, 21 Mar 2026 15:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iVDw+RDGjCfAeDh+0
	mKD4Um8UDQRGxqpkoCAbYKaNTo=; b=WKQmOolbodVkPkjQGe9WBN1F+9F3/u/Ba
	bgngrAVHNj1cdEt9LbNdo2tbsYaADPaARCHqkXEypeHYnUm/5dSB5mib/YEO5BrD
	x75cW2O9EyL8qZtvTMfhM8WGnNuj5PR/ZJudAPdfEsNgz0u2ISbEdlA3uKUP/yCi
	RFOcTo3Edh1onibOgwtVI7JudAfiI3xFcXPQ6elWNDe2VPzvjvkGkfYbOgErvPQ3
	xY/GX5GoR/MqdmvUlzVEWnnmjvF/X2GIKX8uRZL+zZbJWq4t2YdsGOKwCbJetW6f
	1h2tBAmsoVEb9nvpiVmiNUgBQ5AxMAJIU9fSaqjZgcdsipjTk07hg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxys683-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LA8YEc006359;
	Sat, 21 Mar 2026 15:29:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkux1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:29:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFT77e45744388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:29:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E550A2004B;
	Sat, 21 Mar 2026 15:29:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ECAC20040;
	Sat, 21 Mar 2026 15:29:04 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:29:04 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 9/9] libnvme: add support for ctrl diagnostic counters
Date: Sat, 21 Mar 2026 20:58:08 +0530
Message-ID: <20260321152823.3197870-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX3aNRw00gZWOx
 DbusnfreVOPfHM8iCPevDDgL1rDYqcoqthS6S83vOiffpe74FrJmyVynPHB0rvhEDETJHZMbweQ
 iCjWEY/Plnv1Dn1mpwO6oB0F7NwvhTnbwRjM8wEoyqhFwQYbZ+/8QsSyM0zvsnbKlWD+GSl0Tqm
 4d+cmQFglumQzNrPaIvTZeG5LubWvwrxmOPMKVMvD7+47xzn2X8mfk/2C5kqkpiAWczlWrR/ydR
 3h47Ejwe/ua1Ch4aCZgotOAbiwTzjbZnstUfVQsG1XkRfCy1bDYlB91JWJHbwDvEim4X/KFWkAj
 5k1Q44pZ1xUgddPrclzF26EHnN3n8j9PGGKVDS/7iAkIhLD+Cv5BIIjtLYECWPpb148evQ6lTE2
 3vXov5DsESdHK32XdcKPIHs5sZE+FCBUhxBzszoDWT9bzeNzK0MmZSR/3rJtTuWMzt+Ij+hFOzr
 JhdnpfjltSujdh5IBbg==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69beb947 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=UWddX7ZrEUmAjO3ds3UA:9
X-Proofpoint-ORIG-GUID: 8pNRR_-9iDj9sKuNMqiaWqVmSHlvx16J
X-Proofpoint-GUID: 8pNRR_-9iDj9sKuNMqiaWqVmSHlvx16J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082917_410951_8F6DE37B 
X-CRM114-Status: GOOD (  15.47  )
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
index e3d2ca1bb..964066e8c 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -16,6 +16,9 @@ LIBNVME_3 {
 		nvme_ctrl_get_subsysnqn;
 		nvme_ctrl_get_subsystem;
 		nvme_ctrl_get_transport_handle;
+		nvme_ctrl_get_command_error_count;
+		nvme_ctrl_get_reset_count;
+		nvme_ctrl_get_reconnect_count;
 		nvme_ctrl_identify;
 		nvme_ctrl_next_ns;
 		nvme_ctrl_next_path;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index f7f8b4f76..12b6351f2 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -250,6 +250,9 @@ struct nvme_ctrl { /*!generate-accessors*/
 	bool unique_discovery_ctrl;
 	bool discovered;
 	bool persistent;
+	long command_error_count; //!accessors:none
+	long reset_count; //!accessors:none
+	long reconnect_count; //!accessors:none
 	struct nvme_fabrics_config cfg;
 };
 
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 0f0761005..d15118c21 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -1400,6 +1400,39 @@ __public const char *nvme_ctrl_get_state(nvme_ctrl_t c)
 	return c->state;
 }
 
+__public long nvme_ctrl_get_command_error_count(nvme_ctrl_t c)
+{
+	_cleanup_free_ char *error_count = NULL;
+
+	error_count = nvme_get_ctrl_attr(c, "command_error_count");
+	if (error_count)
+		sscanf(error_count, "%ld", &c->command_error_count);
+
+	return c->command_error_count;
+}
+
+__public long nvme_ctrl_get_reset_count(nvme_ctrl_t c)
+{
+	_cleanup_free_ char *reset_count = NULL;
+
+	reset_count = nvme_get_ctrl_attr(c, "reset_count");
+	if (reset_count)
+		sscanf(reset_count, "%ld", &c->reset_count);
+
+	return c->reset_count;
+}
+
+__public long nvme_ctrl_get_reconnect_count(nvme_ctrl_t c)
+{
+	_cleanup_free_ char *reconnect_count = NULL;
+
+	reconnect_count = nvme_get_ctrl_attr(c, "reconnect_count");
+	if (reconnect_count)
+		sscanf(reconnect_count, "%ld", &c->reconnect_count);
+
+	return c->reconnect_count;
+}
+
 __public struct nvme_fabrics_config *nvme_ctrl_get_config(nvme_ctrl_t c)
 {
 	return &c->cfg;
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index a34a31601..b79254f86 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -1047,6 +1047,31 @@ unsigned long long nvme_ns_get_write_sectors(nvme_ns_t n, int curr);
  */
 struct nvme_fabrics_config *nvme_ctrl_get_config(nvme_ctrl_t c);
 
+/**
+ * nvme_ctrl_get_command_error_count() - Get admin command error count
+ * @c: Controller instance
+ *
+ * Return: Number of times admin command issued to controller @c failed or
+ * returned error status
+ */
+long nvme_ctrl_get_command_error_count(nvme_ctrl_t c);
+
+/**
+ * nvme_ctrl_get_reset_count() - Get controller reset count
+ * @c: Controller instance
+ *
+ * Return: Number of timer controller @c is reset
+ */
+long nvme_ctrl_get_reset_count(nvme_ctrl_t c);
+
+/**
+ * nvme_ctrl_get_reconnect_count() - Get controller reconnect count
+ * @c: Controller instance
+ *
+ * Return: Number of times controller has to reconnect to the target
+ */
+long nvme_ctrl_get_reconnect_count(nvme_ctrl_t c);
+
 /**
  * nvme_ctrl_identify() - Issues an 'identify controller' command
  * @c:	Controller instance
-- 
2.53.0


