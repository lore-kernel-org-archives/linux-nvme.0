Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F77C43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 08:19:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E12F206D9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 08:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M6MO9LwF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="OLbORvrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E12F206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MZEXPXhkbFjihk6mwVXbHGmOmeF8UFymxQN7RxP8cy4=; b=M6M
	O9LwFCOfJTUcPy3X7QaDvKxRgNwu028ntNVEs/NDKQik4eIOdqdD+fBCxAqotIHUX6Skwm3KY30Sh
	aZkC61Y746wiS4dZG1t8d+dokCDIufEYYxaasZZlZBlYylHk+GXX8Ssvcv3+E1J+Ijj0qwZKLMNhW
	O1c77ZxGXQQKhQO8WRZ9KzCpdMlVg40la1AybDdLQOHVfu4dpH1Gqh6CZbnGwURQPNhHHKims6wHK
	j/uiKCuT7m156DFhrBdHD46osQoVoAnsbE5j6t3Ue7+FoUKyIKVcwXjwNl+P+/iIeJyTsStSU3Ic1
	HDFBeesSE3B/AGZy6mTgkgFBcLObiYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icmLi-0002xY-2k; Thu, 05 Dec 2019 08:18:58 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icmLf-0002wf-BZ
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 08:18:56 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB58F60X000990; Thu, 5 Dec 2019 03:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=Pz/kCrIEgmdUp6g1wiNmPl1ByCB7rSMIxoXA7+k9hN0=;
 b=OLbORvrwa1EFpLGivCJXkLpDeMt44XnglwnieQ1qdtpIFvsJOF/WHlHWv1WnhpyZIGnI
 +7SKMh8WMo0OMQUmcZteMoMBMA7Qx5p7k5fDoPTxZHPmrxWyC6ik461VE/jLtPpCwob2
 EUkf6b1Uoxnt0i/XRDZJMs/dp10xaz9w+yHkiFTvz/QGiRzidS+NWRsB6cJ0h+UINLEe
 8wW6pSGrLabEsy4VKfqeBqG7C3z3ko5eWGfxRk7ggNpwTsLqWQhGlzL3py1LVES5zyuY
 OZoBIwYXiLD3jPjonr1dTPC8E6m7zNrU3uHSUYRfeSugNCnANoJbCqWpBJiS1IxPz2Qo Cw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 2wp3f6xtu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Dec 2019 03:18:48 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB58IjnV041104; Thu, 5 Dec 2019 03:18:48 -0500
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com
 [128.221.224.79] (may be forged))
 by mx0a-00154901.pphosted.com with ESMTP id 2wkkhwcc2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Dec 2019 03:18:48 -0500
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id xB58IB5k006506; Thu, 5 Dec 2019 03:18:11 -0500
Received: from maildlpprd55.lss.emc.com ([maildlpprd55.lss.emc.com
 [10.106.48.159]]) by mailuogwprd54.lss.emc.com with ESMTP id xB58H5Nl005945 ; 
 Thu, 5 Dec 2019 03:17:36 -0500
Received: from mailsyshubprd52.lss.emc.com (mailsyshubprd52.lss.emc.com
 [10.106.48.27]) by maildlpprd55.lss.emc.com (RSA Interceptor);
 Thu, 5 Dec 2019 03:15:44 -0500
Received: from vd-amite.xiolab.lab.emc.com (vd-amite.xiolab.lab.emc.com
 [10.64.137.6])
 by mailsyshubprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id xB58FhPS022583; Thu, 5 Dec 2019 03:15:44 -0500
From: Amit <Amit.Engel@Dell.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Date: Thu,  5 Dec 2019 10:15:41 +0200
Message-Id: <20191205081541.55962-1-amit.engel@emc.com>
X-Mailer: git-send-email 2.16.5
X-RSA-Classifications: public
X-Sentrion-Hostname: mailuogwprd54.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=856 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050067
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=926 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912050067
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_001855_452387_3803B18E 
X-CRM114-Status: GOOD (  13.41  )
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

In feature id 0x81 NVME_FEAT_HOST_ID, nvmet_copy_to_sgl is called
req->data_len shall hold a non-zero value which is
'sizeof(req->sq->ctrl->hostid)'

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 831a062d27cb..0e1668274872 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -812,6 +812,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 	u16 ret;
+	u8 feature;
 
 	ret = nvmet_check_ctrl_status(req, cmd);
 	if (unlikely(ret))
@@ -875,7 +876,10 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	case nvme_admin_get_features:
 		req->execute = nvmet_execute_get_features;
-		req->data_len = 0;
+		if (feature == NVME_FEAT_HOST_ID)
+			req->data_len = sizeof(req->sq->ctrl->hostid);
+		else
+			req->data_len = 0;
 		return 0;
 	case nvme_admin_async_event:
 		req->execute = nvmet_execute_async_event;
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
