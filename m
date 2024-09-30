Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B652CE8372
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2024 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqMKje6JL+Qc6lNjvzVQAFRWWti29S2KS24h0YpcuBs=; b=ew67pgpX9bm2GgUR0oDqUHtxZK
	7ivnPMkOUMOwKeTVS2ySTqmA+L1PhD/73WcQqY762aAnGUtPajsxhoazJIu5grrGEggROeIKJHrY1
	czRjY+l+/UO1/0/2x3oM+4SQEL3gDiRHTShQHKxs2rpF74rnSZj9j+EpHu0dxEDb4u2HNajGWQIus
	V2ceF569J6CuH/adv54Pbpw61SsW6MCQpZLfSiuXnHkQNq8133nEpbaSGblMmVIY7Ma01jdViDStB
	fUTW+rJUsv1BAtUh/Aa2MnKFUgZm7dF66wmX90ouy/+VsKgRHicy/l4TdmdTZVV54fxlfmahytIdN
	lzjve8vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svJaA-00000000I1R-36CB;
	Mon, 30 Sep 2024 16:49:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svJa8-00000000I0m-0Ct7
	for linux-nvme@lists.infradead.org;
	Mon, 30 Sep 2024 16:49:09 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDmkmJ021041;
	Mon, 30 Sep 2024 16:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lqMKje6JL+Qc6
	lNjvzVQAFRWWti29S2KS24h0YpcuBs=; b=DmzlybhRFunX0rgiPlCvfTGQCotGe
	hijpLWG90HDdRWlwB3fPTbzS5Xd8rj66ivgTAtIZKV1P4R/XQskLkvGDP9hTue3q
	XoyRUSazBOeTcpxMq0/S3YCWSKH2H2JTwRGv1Ml/KGtr5nHX1rKQOtjz4Del+S60
	zhBzsilL1FVvaHbC+GS4X/paXcEP5TTerVSYSKhvk3QznTmZ9pJzbqoFciRhByOW
	fubpekNPAav6JCnfSusR3U2Gmtb6qr3LZifwkZF+UuFMzLwdj9BMmxXCCFB/36WR
	BbAw9NbPXkRtsJ9/fwRv2kTn1wvkKI1NYusjuQWn+J7VvKqHZxe3uVCAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwu2u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:48:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UGmmKH007020;
	Mon, 30 Sep 2024 16:48:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwu2u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:48:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UFJdTR013006;
	Mon, 30 Sep 2024 16:48:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj7cv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:48:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UGmjr430147248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:48:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7A8D5805E;
	Mon, 30 Sep 2024 16:48:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89E8858065;
	Mon, 30 Sep 2024 16:48:45 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 16:48:45 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com,
        gjoyce@linux.ibm.com
Subject: [PATCH 1/1] nvme: retry security commands if media not ready
Date: Mon, 30 Sep 2024 11:48:43 -0500
Message-ID: <20240930164845.8406-2-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930164845.8406-1-gjoyce@linux.ibm.com>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g1sV6vbkXbfWEOivv7muGKh1kgq0PwWa
X-Proofpoint-GUID: DzDkdMXcCq_wkzuhfjZCoANU0ZQ5_kWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_094908_231745_86620DB7 
X-CRM114-Status: GOOD (  22.62  )
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

From: Greg Joyce <gjoyce@linux.ibm.com>

If NVME_CC_CRIME is set, security send/receive commands may fail
with status NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY until the
controller is able to accepts these commands. Retry the command
if this failure occurs.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
---
 drivers/nvme/host/core.c | 82 ++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..fc4bbf1adf9f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2320,12 +2320,53 @@ static int nvme_get_unique_id(struct gendisk *disk, u8 id[16],
 	return nvme_ns_get_unique_id(disk->private_data, id, type);
 }
 
+static u32 nvme_get_timeout(struct nvme_ctrl *ctrl)
+{
+	u32 timeout;
+	int ret;
+
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto, ready_timeout;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			ready_timeout = NVME_CRTO_CRIMT(crto);
+		else
+			ready_timeout = NVME_CRTO_CRWMT(crto);
+
+		if (ready_timeout < timeout) {
+			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
+				      crto, ctrl->cap);
+		} else
+			timeout = ready_timeout;
+	}
+	return timeout;
+}
+
 #ifdef CONFIG_BLK_SED_OPAL
 static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send)
 {
 	struct nvme_ctrl *ctrl = data;
 	struct nvme_command cmd = { };
+	u32 timeout;
+	unsigned long timeout_jiffies;
+	int ret;
+
+	timeout = nvme_get_timeout(ctrl);
+	timeout_jiffies = jiffies + timeout * HZ;
 
 	if (send)
 		cmd.common.opcode = nvme_admin_security_send;
@@ -2335,8 +2376,19 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
 			NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
+	while (ret == NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY) {
+		if (time_after(jiffies, timeout_jiffies)) {
+			dev_err(ctrl->device,
+				"Device media not ready; aborting\n");
+			return -ENODEV;
+		}
+		ssleep(1);
+		ret =  __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer,
+				len, NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
+	}
+	return ret;
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
@@ -2473,33 +2525,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto, ready_timeout;
-
-		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		/*
-		 * CRTO should always be greater or equal to CAP.TO, but some
-		 * devices are known to get this wrong. Use the larger of the
-		 * two values.
-		 */
-		if (ctrl->ctrl_config & NVME_CC_CRIME)
-			ready_timeout = NVME_CRTO_CRIMT(crto);
-		else
-			ready_timeout = NVME_CRTO_CRWMT(crto);
-
-		if (ready_timeout < timeout)
-			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
-				      crto, ctrl->cap);
-		else
-			timeout = ready_timeout;
-	}
+	timeout = nvme_get_timeout(ctrl);
 
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-- 
gjoyce@linux.ibm.com


