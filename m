Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_SPACE_BRACKET,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEECC3F2D1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 12:53:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE4120665
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 12:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RfsDVzYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="FJCGHoeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE4120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QW0rYBE4G7dw/n+idnAWOWNsOkAcdHBa84yUXPn+0FU=; b=Rfs
	DVzYiotvI/yAzkjiz/a0C6N8jPZhOcy+rTX3cOTmkQX0Z6O7t8xYg/l5chvEg2Jrt0LOlK0X+7OZc
	u0XmrRpzswwK92pDP+2elOynKKeANpDK23i2iC4lUm2grdAvXTHCYCoLfOcgi5BBFef2FfsAG0ULK
	KKYm2LjTVaoQsAGv81O7zxgjNvAbZXWw/7p5XE9Nry6acOFH4TknPUj0IAodgIfkALtlh6o8UqWfQ
	L19OJKwQWBY9TWgPTIldl2K4uoPgSMDPCAwQtA14p4OJ3ON7QSllKOjVk3Pbnyc5kUdwnpf8UJBCJ
	SZE4+Mfkfd0DOMxBczJRjmXl2AHAC0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7f8X-0003vO-8C; Fri, 28 Feb 2020 12:53:01 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7f8S-0003pz-O0
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 12:52:58 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01SClfwt014890; Fri, 28 Feb 2020 07:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=OLxgFBeqsFjKcX3DIRHUfWBVxVFRFadiaZ45hMDwmmw=;
 b=FJCGHoeYICY9p7yKw234PB3xi7Yjn+hVM5wrCf0yIYKygJ+kMDCU/uJj1Cm2MFtEXuks
 YupBJP8ZrWpmCK3WoiOIvvLgeL94r1EQ8mR74L8+m29FWB6H0FYc5zi9D8NTMB5tPPuc
 HliADSMORES6jamYaQNH6O+Kf5ZF2gl7Hrz00sJ8SD9pV0lhoLFmX69p443tTZoc3gfI
 EDET6XLKzVcp7qWcXtWm7xdVDW3jWAVjPR4MEmzKWGHQvyROn6Jg2PfYxvHYTdnMapgb
 EtCd6hHge5kV+GE5/NjgLJYkLRGAAfIstXXMLOrFjJHnbUFMfuouwiuYm83Hqgac04xD xg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 2yepw3ah64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2020 07:52:50 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01SCnADC161952; Fri, 28 Feb 2020 07:52:50 -0500
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com
 [168.159.213.141] (may be forged))
 by mx0b-00154901.pphosted.com with ESMTP id 2yepwrs888-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Feb 2020 07:52:50 -0500
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd05.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 01SCqnO6008432; Fri, 28 Feb 2020 07:52:49 -0500
Received: from mailsyshubprd06.lss.emc.com ([mailsyshubprd06.lss.emc.com
 [10.253.24.24]]) by mailuogwprd05.lss.emc.com with ESMTP id 01SCqbeQ008361 ; 
 Fri, 28 Feb 2020 07:52:37 -0500
Received: from vd-amite.xiolab.lab.emc.com (vd-amite.xiolab.lab.emc.com
 [10.64.137.6])
 by mailsyshubprd06.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 01SCqZBB010384; Fri, 28 Feb 2020 07:52:36 -0500
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: return Invalid Field error on set features cmd fid 07h
Date: Fri, 28 Feb 2020 14:52:14 +0200
Message-Id: <20200228125214.100729-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.5
X-Sentrion-Hostname: mailuogwprd05.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-28_04:2020-02-26,
 2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280104
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_045256_968230_2CC24770 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Amit Engel <Amit.Engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

If the value specified in NCQR and NSQR fields (0's based) is 65,535
the controller should return an error of Invalid field in command

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 19f949570625..94b0ac923e99 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -733,6 +733,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	u16 ncqr = (cdw11 >> 16) & 0xffff;
+	u16 nsqr = cdw11 & 0xffff;
 	u16 status = 0;
 
 	if (!nvmet_check_data_len(req, 0))
@@ -740,6 +743,10 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 
 	switch (cdw10 & 0xff) {
 	case NVME_FEAT_NUM_QUEUES:
+		if (ncqr == 0xffff || nsqr == 0xffff) {
+			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			break;
+		}
 		nvmet_set_result(req,
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
 		break;
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
