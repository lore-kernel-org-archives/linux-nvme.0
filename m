Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1661C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 22:09:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D81461208
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 22:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D81461208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZlH5NHDNaWhv05pvT3KiVpxBDjMR5aiWoUShvexNvyY=; b=Ouar5JP7cQPAl6Tu4ouBYVwKTj
	wHMk6+dLW316rJOPVuSrSSWQeREYtQLZJU/hPRX5DkQD3c7F2gYMkRb3k7hWnBG52JOnffhy0PVpp
	4tCKRTDbDGbak1FPdj8+br9wTwCPy73HDyIh3FzGnjqZg0w6urOHbsBjkKyQ2brzv1tHuvgOIrRUU
	CymVa+oIErzzUFh7oOmDjsJR7LxsDxl5/QcobpphxyCiYiEz9FNk8jYIQWau4SlfQgh6vnmxMq5/S
	yBSIdBkb5hBV3omAcNJDsrGcas7Tl4dS39SzhUC+c3CknyVittEU8s8efL3VARvvxbOtM6Rl8B/C5
	8b0Jr0Ew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldgkj-00Eu0w-1G; Mon, 03 May 2021 22:09:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldgkV-00Eu06-IF
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 22:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=NtmJLoOUE1nm7m01SPCJdRJYdmJTCQ100+6LKsW35dc=; b=vQTGGcxszqIBeeeZQ7BaFdhaBA
 M8r90lmxicu6NBB7IoCFHXV400PmMK1DkzOFoZEDgVWLwGhtHj9HCMY6N9D3eTzM0ZaiQPXwJDg/A
 arnO5h3oh3TMU3+kdCYTyiuMamQ4XFSG/IzMvH762f17rDIVO570P4WRu85WI3dPbbHWf6hUyMHom
 5LG4WYHMMjhXs/cG0UcfFw14Le+e6YZH/eHq8KBn/GVH6tlFJOhdp6eWLQJ+2eq7uHRLGXZhV3dMQ
 leBkokLYdm3RWcZZdAENcmJIVBjnOBlDw1f2jKJI/Bq/NY5LIP1P3fM6TKkgKccX0lmSV1+KQnjik
 KkYF4K4w==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldgkS-003W9c-3X
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 22:09:05 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 143M1jfK009913
 for <linux-nvme@lists.infradead.org>; Mon, 3 May 2021 18:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=NtmJLoOUE1nm7m01SPCJdRJYdmJTCQ100+6LKsW35dc=;
 b=eXi6CP+K1xXvcahqehmxnfnan+kceAaVP901Y81HSRAzxK1X2KWm5Z2egzgwbD8P6U1/
 SVG+3qOhNU17wTvsnDCcA8WAdTFOlrysetsFBKfQP4jDUnl+W9fuwD3gkbjclWDXlBSZ
 mnIWA0WfFZcemp2I32rVGYmLluT48mvw0Tesf1uc20GtJKcTk1KS0P3Aq4SDnbbZCZHR
 PX2DaMT3sSHxMDeZvOflZRuNDASKzOcWkXD3mjRg+uMrXWZO4gs4v1qhYDC7/Vze8ODw
 UFEOEVDVC8Ne3EYwT7gMO+/AsQAlkfU8F1CeWtCH8VA9qOHvuDVLRRSsgIcphp4T5/KE Dw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 38as8s84rt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 18:09:01 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 143M0HjH086234
 for <linux-nvme@lists.infradead.org>; Mon, 3 May 2021 18:09:01 -0400
Received: from esaploutpc105.us.dell.com (smtp-outbound-pc1.dell.com
 [143.166.24.15])
 by mx0b-00154901.pphosted.com with ESMTP id 38ap6p2xhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 18:09:01 -0400
X-PREM-Routing: D-Outbound
X-LoopCount1: from 128.221.233.10
Received: from smtp-outbound-dur.dell.com (HELO esaploutdur02.us.dell.com)
 ([128.221.233.10])
 by esaploutpc105.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2021 17:09:00 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.220
Received: from unknown (HELO vd-rana.xiolab.lab.emc.com) ([10.55.225.220])
 by esaploutdur02.us.dell.com with ESMTP; 02 May 2021 10:31:13 -0500
From: ran.anner@dell.com
To: hch@lst.de, linux-nvme@lists.infradead.org
Cc: Ran Anner <Ran.Anner@dell.com>
Subject: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes set
Date: Sun,  2 May 2021 18:31:06 +0300
Message-Id: <20210502153106.18970-1-ran.anner@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-03_20:2021-05-03,
 2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=914
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030150
X-Proofpoint-ORIG-GUID: w4J7-U8KIV_bjbgAH7wTE_Kg7fc7qzSv
X-Proofpoint-GUID: w4J7-U8KIV_bjbgAH7wTE_Kg7fc7qzSv
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=845
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_150904_342129_4E2349A9 
X-CRM114-Status: GOOD (  18.13  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ran Anner <Ran.Anner@dell.com>

According to the spec we should fail creation of IO queues
if iosqes or iocqes properties are not set but does not mention
preventing from changing ctrl status to ready.
We have seen host implementation which sets the property to 0x1
and waits endlessly until ctrl status changes to ready.

Signed-off-by: Ran Anner <Ran.Anner@dell.com>
---
 drivers/nvme/target/core.c        | 39 +------------------------------
 drivers/nvme/target/fabrics-cmd.c |  9 +++++++
 drivers/nvme/target/nvmet.h       | 34 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index adbede9ab7f3..559dc7354adb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1078,48 +1078,11 @@ void nvmet_req_free_sgls(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_free_sgls);
 
-static inline bool nvmet_cc_en(u32 cc)
-{
-	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
-}
-
-static inline u8 nvmet_cc_css(u32 cc)
-{
-	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
-}
-
-static inline u8 nvmet_cc_mps(u32 cc)
-{
-	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
-}
-
-static inline u8 nvmet_cc_ams(u32 cc)
-{
-	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
-}
-
-static inline u8 nvmet_cc_shn(u32 cc)
-{
-	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
-}
-
-static inline u8 nvmet_cc_iosqes(u32 cc)
-{
-	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
-}
-
-static inline u8 nvmet_cc_iocqes(u32 cc)
-{
-	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
-}
-
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
 
-	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
-	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
-	    nvmet_cc_mps(ctrl->cc) != 0 ||
+	if (nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
 	    nvmet_cc_css(ctrl->cc) != 0) {
 		ctrl->csts = NVME_CSTS_CFS;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 1420a8e3e0b1..421ab564ed5c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -259,6 +259,15 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 	}
 
+	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
+			nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES) {
+		pr_warn("reject connect cmd (IOSQES %u IOCSES %u)",
+				nvmet_cc_iosqes(ctrl->cc),
+				nvmet_cc_iocqes(ctrl->cc));
+		status = NVME_SC_QUEUE_SIZE;
+		goto out_ctrl_put;
+	}
+
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
 		/* pass back cntlid that had the issue of installing queue */
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5566ed403576..18213edb8a07 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -616,4 +616,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline bool nvmet_cc_en(u32 cc)
+{
+	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
+}
+
+static inline u8 nvmet_cc_css(u32 cc)
+{
+	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
+}
+
+static inline u8 nvmet_cc_mps(u32 cc)
+{
+	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
+}
+
+static inline u8 nvmet_cc_ams(u32 cc)
+{
+	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
+}
+
+static inline u8 nvmet_cc_shn(u32 cc)
+{
+	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
+}
+
+static inline u8 nvmet_cc_iosqes(u32 cc)
+{
+	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
+}
+
+static inline u8 nvmet_cc_iocqes(u32 cc)
+{
+	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
+}
 #endif /* _NVMET_H */
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
