Return-Path: <SRS0=EcNd=W3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE19C3A5A6
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 18:51:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B0022D37
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 18:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RzN5copG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aAtYVb5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B0022D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vTaNEoYBAF6Rz+Sk7PDJF8j64hcnYa1lvoCZI541iEU=; b=RzN
	5copGIOOHZ17wEPkbyytu/8dqn6n64gs7ZdVMkb3eWPnrF/b++YEYvl57jWEpA6njMI/GdVyeNMr/
	NfVdb7r87VFBJSEOLYonL707LYlNn6xSq/TebeBv5shgMpqrQxqTNGyIaKJXq+2xcoOA65YWGwSZP
	pLZaLAr8BJhXdCGYzdbNJHT9YKR7xf8aMh9Kx3TmD6SK08lraTEhnzr52hs/6U7pukz23kQf2VNiU
	zrCGDl65kI/YaMXr02R3HveCppmkBI0+vk3IdrwHwzcp6jzpEsfy9F1UazRgWoxiLPCS0lAmEtfW7
	bciZ4RGsvznI/P++Q0M0JZPDoaxgVOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i48TL-0001dL-Fy; Sat, 31 Aug 2019 18:51:39 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i48TH-0001cT-KO
 for linux-nvme@lists.infradead.org; Sat, 31 Aug 2019 18:51:37 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x7VIoP3d030517; Sat, 31 Aug 2019 14:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=HVQYSXZC+veo3x0PDWRR/zxrRiCcTV25SemEZljuj8c=;
 b=aAtYVb5O87CT8Ze0Nr10sHESAGIIP51kPG2YAfH9tpEoqd3YubqTd9hsYaZXCb1zJKEB
 lMMGM2n6U6J1vbLRupAasc0ftd5lNTiZC43eKHOXowh0BAlPLwKmjD3VybGN4WFCaKL7
 ArP+IfFybkQymIxgUsuuTtSMZqzc/HU27lzBwsqX+bdGrtGvqclFdniE7gHfHUUNNXhA
 UlfOr8PmflSb87BDQYYMJDuQ55nbW+pHH8PTI15/gYES3asQYE4Sq2ZRjtbNdyikImQN
 qMXriivpWl9qvDrsV5aOPzYGjVe5j7jhxcoDumKVf1cIjln4S1Cu7jQPtvutn2B0ECtq Cw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 2uqnjp11vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 31 Aug 2019 14:51:26 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x7VIljQ6165250; Sat, 31 Aug 2019 14:51:25 -0400
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com [168.159.213.141])
 by mx0a-00154901.pphosted.com with ESMTP id 2uqk4r5jmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 31 Aug 2019 14:51:25 -0400
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x7VIpNxH016329; Sat, 31 Aug 2019 14:51:23 -0400
Received: from maildlpprd04.lss.emc.com ([maildlpprd04.lss.emc.com
 [10.253.24.36]]) by mailuogwprd02.lss.emc.com with ESMTP id x7VIomrY016185 ; 
 Sat, 31 Aug 2019 14:50:54 -0400
Received: from mailsyshubprd55.lss.emc.com (mailhub.lss.emc.com
 [10.106.48.137]) by maildlpprd04.lss.emc.com (RSA Interceptor);
 Sat, 31 Aug 2019 14:50:11 -0400
Received: from vd-amite.xiolab.lab.emc.com (vd-amite.xiolab.lab.emc.com
 [10.64.137.6])
 by mailsyshubprd55.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x7VIo9pZ007953; Sat, 31 Aug 2019 14:50:10 -0400
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fix a wrong error status returned in error log page
Date: Sat, 31 Aug 2019 21:50:06 +0300
Message-Id: <20190831185006.119748-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.5
X-RSA-Classifications: public
X-Sentrion-Hostname: mailuogwprd02.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-31_07:2019-08-29,2019-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=813
 mlxscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1908310217
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=895
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908310217
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190831_115135_842911_A8A1D9EA 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: Amit <Amit.Engel@Dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit <amit.engel@emc.com>

When the command data_len cannot hold all the controller errors,
we should simply return as much errors as we can fit
instead of failing the command.

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 51800a9ce9a9..f7753b8a485c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -40,13 +40,16 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 	u16 status = NVME_SC_SUCCESS;
 	unsigned long flags;
 	off_t offset = 0;
+	size_t num_of_sgl_slots;
 	u64 slot;
 	u64 i;
 
+	num_of_sgl_slots = do_div(req->data_len, sizeof(struct nvme_error_slot));
+
 	spin_lock_irqsave(&ctrl->error_lock, flags);
 	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
 
-	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
+	for (i = 0; i < NVMET_ERROR_LOG_SLOTS && i < num_of_sgl_slots; i++) {
 		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
 				sizeof(struct nvme_error_slot));
 		if (status)
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
