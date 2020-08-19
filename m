Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95819C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 08:32:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C16420772
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 08:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i5k1FnFI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mzy4I9Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C16420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YqASvjrnaE/J5QXUcadnij5C1Cb8WCfFUcd7fQB9R7g=; b=i5k1FnFIBgdrg6aza7UnXBlnOb
	BzGF8cL1K4zc7sXBhJHi+S/kTiReI/JyIQOb1xigoEhETzWwPerTCf5LfseUkhJOPyKzrtv4XPJrK
	OCpcJ3hIMqAq2a86rPqKbOVR6A7xqqwCkyUCpiByxIH/x98krNcIb0zJgu1NSkxWqjXDK+0eGkVht
	t1Cd7ozldDiHG8nLLJmVPv8qoWuQmxsQzln5GIJPGzOimEzaANjSzuJBzTsSmdCk8m4PfU1Y9gthM
	AZcxvK/aQa9Egym3ctdQ7uxFewSfGNCzAJ18OnBsLJZI2zjOr6XDoGIDEvf5KdZGSxS2uLEpuufNl
	rCakiwAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8JVj-0003Ia-UU; Wed, 19 Aug 2020 08:31:55 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8JVg-0003I7-RT
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 08:31:54 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07J8T85x005053; Wed, 19 Aug 2020 04:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=ifiZ5ojFR6yvrEdXLOGKkQKV4b0buBFMWO3GW3lZU7Y=;
 b=mzy4I9Jifvn8IAE9bVZY/1kr9N/xZsXLg7+ot1gBPAjCqtFpaTHsIbZcEZue3v3G3Xne
 G9NCtBeB2sjioP4SWLebJVI9OsuEmCdBOXqnUEqZEjGGp0hWyMMaQyqVd8qi2t7LgNpW
 dZU1e+ZtTyCLv8F0v9j8L8m8OitQ4VL8yRA3jBKGqE9BYpXaid8QpxWCyZKg3n7BCSdf
 aJXlNEphOxUaNRlBumo0eaDPelm/miFLIjKrZ0IOFuQJbKuFlkMEsv5tUn9mrMJpuEBj
 MVU4Li8ozbVbJLjZG9eEPdymSqsFbJElTLhl2JFHFYfrI8CI3izysECiE/eGdsQyMIDS xw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 3304j0djkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 04:31:49 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07J8Tflp057943; Wed, 19 Aug 2020 04:31:49 -0400
Received: from mailuogwhop.emc.com (mailuogwhop-nat.lss.emc.com
 [168.159.213.141] (may be forged))
 by mx0b-00154901.pphosted.com with ESMTP id 3310410j76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Aug 2020 04:31:48 -0400
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 07J8VjkZ027927; Wed, 19 Aug 2020 04:31:48 -0400
Received: from mailapphubprd02.lss.emc.com ([mailapphubprd02.lss.emc.com
 [10.253.24.52]]) by mailuogwprd02.lss.emc.com with ESMTP id 07J8VFPt027688 ; 
 Wed, 19 Aug 2020 04:31:16 -0400
Received: from arwen3.xiolab.lab.emc.com (arwen3.xiolab.lab.emc.com
 [10.76.211.131])
 by mailapphubprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 07J8VD4C023012; Wed, 19 Aug 2020 04:31:14 -0400
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Disable keep-alive timer when kato is cleared to 0h
Date: Wed, 19 Aug 2020 11:31:11 +0300
Message-Id: <20200819083111.4679-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.2
X-Sentrion-Hostname: mailuogwprd02.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_04:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=954
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190072
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_043153_261335_3AB7E4A8 
X-CRM114-Status: GOOD (  16.47  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

Based on nvme spec, when keep alive timeout is set to zero
the keep-alive timer should be disabled.

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b92f45f5cd5b..c052c922853a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -397,6 +397,9 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 
 static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
@@ -406,6 +409,9 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
