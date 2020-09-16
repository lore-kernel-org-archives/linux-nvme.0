Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_RCVD_SPACE_BRACKET,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE71C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 17:47:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C422C206B6
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/yvrTRg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mXK5hhC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C422C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fo4YtuTnztNRkiQZnnziO22RM9xnBmfvrJAfl8udje8=; b=Q/yvrTRgHeSF+ZQdZ+LEOb1mxh
	XjXiCl/UEPwoZxsirzSO1XEPuLAqswmKn/g5IX34GQ6G34RNfGnTFio130b5+ZGb8SoLkWcpAnud+
	eH5Sxvwdo7C6Q7opM5vzXO4hezt6/6FS+mbIWcvJgjF/NJQCjml5TL5J4Tx+W+qZGv0wtVxVtKtjl
	rZbnCiLIJWHj3DG89BpXTUgrWg0LfusRmLLTA7xhq78kA6DlaPVHJJQUcZ3ebCG6Iq2uW1h9xYFIk
	4C6/ReLGmD7IFww5KQJmOzC8AzG/ALCbBfpdo0dCuTMXeRFappxF2rbRHHkFLMlGmtfkOFB/TMij5
	ur8rNQZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIbWx-0004wL-KI; Wed, 16 Sep 2020 17:47:43 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIbWu-0004ve-B2
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 17:47:41 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08GHiL4b004928; Wed, 16 Sep 2020 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=FSxVlejNlt0zr68BQ7Ico4EsMtEKEnf3ChP6TC26zh4=;
 b=mXK5hhC84aV2TD5CcnIaJ5Zo62nggbYHjxDQPRxWoUDnOf7yJnojKgLhlML54hGaHC6J
 7j9f0sK8fFdNLvhwlXGks4DctgIjx+EJ1Oijoop2wkYcvRaXs2HFJVyCwTARQ3dWSrkl
 cYEn1OF3lKIILrrgU3SG5JguKrak5Srv3GY0nRZOdX33Vx17ktMJcZn5z7BzTDCtax0Y
 xforRGnY+kXlwfm0MjFQ3ZpwscARaze2GerJOb9zdQ9hP7D+L42aUW7tWyPngnhVWgQ9
 vjehSIeuazBfHAH6+T0hFYR1oUNehP7yyXmBKJ+TmwMea3E39t9lRImJ7rTegRgSow8e xg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 33k5r4v4sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 13:47:36 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08GHhUii074183; Wed, 16 Sep 2020 13:47:35 -0400
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com
 [128.221.224.79] (may be forged))
 by mx0a-00154901.pphosted.com with ESMTP id 33khed6mkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Sep 2020 13:47:35 -0400
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 08GHlYGI015760; Wed, 16 Sep 2020 13:47:34 -0400
Received: from mailsyshubprd52.lss.emc.com ([mailsyshubprd52.lss.emc.com
 [10.106.48.27]]) by mailuogwprd54.lss.emc.com with ESMTP id 08GHlOvS015589 ; 
 Wed, 16 Sep 2020 13:47:25 -0400
Received: from arwen1.xiolab.lab.emc.com (arwen1.xiolab.lab.emc.com
 [10.76.211.111])
 by mailsyshubprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id 08GHlN0a022112; Wed, 16 Sep 2020 13:47:23 -0400
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: handle keep-alive timer when kato is modified by a set
 features cmd
Date: Wed, 16 Sep 2020 20:47:20 +0300
Message-Id: <20200916174720.12610-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.2
X-Sentrion-Hostname: mailuogwprd54.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-16_11:2020-09-16,
 2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=985 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160124
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_134740_536484_4FE783C4 
X-CRM114-Status: GOOD (  17.92  )
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

A user may modify the kato by a set features cmd,
In that case, the right flow is:
- cancel the timer
- update kato to the new value
- start the timer again

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 drivers/nvme/target/core.c      | 4 ++--
 drivers/nvme/target/nvmet.h     | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e9fe91786bbb..dca34489a1dc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -727,7 +727,9 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 {
 	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
+	nvmet_stop_keep_alive_timer(req->sq->ctrl);
 	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
+	nvmet_start_keep_alive_timer(req->sq->ctrl);
 
 	nvmet_set_result(req, req->sq->ctrl->kato);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c052c922853a..40861d303335 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -395,7 +395,7 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	nvmet_ctrl_fatal_error(ctrl);
 }
 
-static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
+void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
 		return;
@@ -407,7 +407,7 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
-static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
+void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
 		return;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 47ee3fb193bd..559a15ccc322 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -395,6 +395,8 @@ void nvmet_get_feat_async_event(struct nvmet_req *req);
 u16 nvmet_set_feat_kato(struct nvmet_req *req);
 u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
 void nvmet_execute_async_event(struct nvmet_req *req);
+void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
+void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id);
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
