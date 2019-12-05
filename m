Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C1AC43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 13:36:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078E522525
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHoSseZx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="a2MwqTcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078E522525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UGgfxx+US2fTfeufrfYHWtWOBFgSFNWSH2b929E99n8=; b=IHo
	SseZxZqtnbmR7kwxTUuyFgSz1u8d7fbAjBtbQP8NXEzS2mOe+7xQPXlIXfkKOZhB5FrXPPG0+tHdl
	snWNPstis+unfizBtpuIk7vD3MI36qafZh5naE1J3fjTSP7meu/IwVEnCCgXQ9GLmz8TbOX4882hM
	hA+zzPY3ZyxdtWsgSb+abHPb2SEaazviY5YltFOAFNV5U5DjaKmqD4o9LoKtlYaUgGCd8Ab/3IR9O
	PVMfrfO8XfSpqt+AFLDrqEvHcedr5XlKLyueCRRe1r7nMjCzXqpGOvmbXyiIEf0C0AplCBPZQzBO/
	m9/quJy5UB6HuOTO80Gq16fV+M8JAFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icrJR-0000PN-3G; Thu, 05 Dec 2019 13:36:57 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icrJN-0000NX-Ss
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 13:36:55 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5DZ4nT017351; Thu, 5 Dec 2019 08:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=vcfOx779cLba4EpMG2X5hHqtR8ydua5lBnUmdEFmLao=;
 b=a2MwqTcLoA5Gf9D2Mn2gwYc2R6Mn8hUp5hk/YtKkK0jmpNQXSw8tpVHMfO8vvJezqKk3
 2SWxu4GqKdLhV2zzUKKVHszPKXMcop+NP4VnGks1v/FrZ1h/vg/gzsUO44NZkGBpfoDF
 LG8RLrxRsJC/wnWzCy4ZRSO5rfMFpJH2y0dUzFh0XnUaKGMndALcoGoWZ4CzCG0CIffE
 fDUwQmjs09X2tzrerNfwYh3ZPHRwWQueLPmgQmGYfjyYDSriPWoNS+xrMroRnT0l2zET
 V0uq2zheToJPbM10JtifNXaAnr0AHi0wt59ROZ2ZWqpCcnfc/5/Fquiubia7p6gRPYLJ Rw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 2wpqsca9vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Dec 2019 08:36:51 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5DS0Jl029176; Thu, 5 Dec 2019 08:36:50 -0500
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com
 [128.221.224.79] (may be forged))
 by mx0a-00154901.pphosted.com with ESMTP id 2wpyckatkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Dec 2019 08:36:50 -0500
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id xB5DanFs013399; Thu, 5 Dec 2019 08:36:49 -0500
Received: from maildlpprd51.lss.emc.com ([maildlpprd51.lss.emc.com
 [10.106.48.155]]) by mailuogwprd54.lss.emc.com with ESMTP id xB5Da8NN013050 ; 
 Thu, 5 Dec 2019 08:36:47 -0500
Received: from mailapphubprd04.lss.emc.com (emcmail.lss.emc.com
 [10.253.24.71]) by maildlpprd51.lss.emc.com (RSA Interceptor);
 Thu, 5 Dec 2019 08:34:06 -0500
Received: from vd-amite.xiolab.lab.emc.com (vd-amite.xiolab.lab.emc.com
 [10.64.137.6])
 by mailapphubprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id xB5DY7RO003507; Thu, 5 Dec 2019 08:34:08 -0500
From: Amit <Amit.Engel@Dell.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Add helper function 'nvmet_feature_data_len' to
 calculate the required data_len
Date: Thu,  5 Dec 2019 15:34:06 +0200
Message-Id: <20191205133406.63791-1-amit.engel@emc.com>
X-Mailer: git-send-email 2.16.5
X-RSA-Classifications: public
X-Sentrion-Hostname: mailuogwprd54.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=878 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050114
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=945 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912050115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_053654_069125_7A1626B2 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: amit.engel@dell.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

This fixes a bug in nvmet_execute_get_features, fid 0x81, NVME_FEAT_HOST_ID
nvmet_check_data_len shall be called with a valid data_len value

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 11 ++++++++++-
 drivers/nvme/target/nvmet.h     |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b501185..f09d5fdc995f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -24,6 +24,15 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 	return len;
 }
 
+u32 nvmet_feature_data_len(struct nvmet_req *req)
+{
+	u8 feature = req->cmd->common.cdw10 & 0xff;
+
+	if (feature == NVME_FEAT_HOST_ID)
+		return sizeof(req->sq->ctrl->hostid);
+	return 0;
+}
+
 u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
 {
 	return le64_to_cpu(cmd->get_log_page.lpo);
@@ -778,7 +787,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_data_len(req, nvmet_feature_data_len(req))
 		return;
 
 	switch (cdw10 & 0xff) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..6422489d96cd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -434,6 +434,8 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
 
+u32 nvmet_feature_data_len(struct nvmet_req *req);
+
 extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
