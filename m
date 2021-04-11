Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDDC433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 08:19:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1584C611C9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 08:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1584C611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2Ed5eeBxFE9qS7frvNw8BJ4Xt6woJVJ6rU0vr/amUp8=; b=YCl7U3aN2s9iBFHv12Y0hxKsAG
	UUOV0ajfA9sJ5HPm73FqMpHGWVyedkXOJrJdP7NHij6q89qIJiXm+25OLboczfwWZPwfCaZyYZRPa
	E22MYd6PL8G54sYYYVm1xbZWZwq2vg2crdvw//GoUFsJJOOSumKZT8o+dP9EJukFaNzkoL3YPJgg6
	jSb0qamGuX2u+LhKVanxxxy1do9EEVZdoOqfrHjwdvHIKOyqAuJHmBCgxMvFlMaC2CR0H/T9mQtvI
	xEgY+33sMe54y/1uK5GnK+kU7eJBuPPCWttnivZhlupjSGVRG7mc4/qw29B9HKO18euZorWWlizeS
	3Dx6XYwA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVVIt-0049du-BI; Sun, 11 Apr 2021 08:18:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVVIp-0049dm-MO
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 08:18:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=TRPeusHU6llD9nDTk90PQJn4ZPY9FQoflkfSQrwfvTs=; b=2gdhReWXFHB+tejIU2bC6+IOwh
 RkO+jKDQ7GKqDz+5YLtcGEwzDjMbu4j8LWi8bz3x8IFbR3v8AuFyQKikO8QxL5tBGRpZiMlw6UpAc
 OUXUYSuUD37XcslE4p1asB0its2N8+NkmQloYqORjKniK9GFLirBHcaXLzsZFWO19voYshv+5/bBT
 3XiixIkrHc5vrrRnDzFXrmIpyWdsVcTmj8XMiSOJogGzlH9xdYnO4HQCTmVJvvL0lra33KT41iG9S
 aAsTopgjgQxGDvSSncMQhIZlE8dJVRLvTtuubqflqnL5Lhis/oVxWDROOB57bztT4YJZbUAY6UKks
 lBw59hZg==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVVIm-005PNV-AB
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 08:18:41 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13B8HYUo023126
 for <linux-nvme@lists.infradead.org>; Sun, 11 Apr 2021 04:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=TRPeusHU6llD9nDTk90PQJn4ZPY9FQoflkfSQrwfvTs=;
 b=uMqReVgDJetCRfhvQWbKyRtxF/Zb4pBcoHBu0zxEEjDICB+2lm8+PX9s1Ynk+/VEMSGI
 LLCI/xOOqLJBgvbGbiL7b2RkMeqR6d0tUCNv4TGT6uBDlU/vWNZlCwhhs1hgrf56NOdR
 39mm9wKnm9LSHOvpPMUG/4wOGDRgoWoPSWe/f5LK6J937Ho7qvVmwDnV49Ptt4DmSbV9
 vEQ4p88PYAjj13WDfOoWIKBVDYIIZRSw+wqEjugw2XzVA0xd4V275HXp9coldJD9IUlA
 2Aa+XmQkQ6dC8qF4VJDCW/+KNGeyOBGdzzJqoCfwNB3TkDcx3JW2o6rJr7cmXf+j6/gc LA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37u78a9ymh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sun, 11 Apr 2021 04:18:37 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13B8F5uo142245
 for <linux-nvme@lists.infradead.org>; Sun, 11 Apr 2021 04:18:37 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 37uskhsmug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sun, 11 Apr 2021 04:18:37 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
Received: from unknown (HELO vd-amite.xiolab.lab.emc.com) ([10.55.225.216])
 by esaploutdur02.us.dell.com with ESMTP; 11 Apr 2021 03:18:36 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: do not ignore error_location FFFFh
 (NVMET_NO_ERROR_LOC) on nvmet_set_error
Date: Sun, 11 Apr 2021 11:18:31 +0300
Message-Id: <20210411081831.15100-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-11_04:2021-04-09,
 2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110063
X-Proofpoint-ORIG-GUID: 7swetsHAKFb4cQ4dDk8zaEwA2tlZ6VyG
X-Proofpoint-GUID: 7swetsHAKFb4cQ4dDk8zaEwA2tlZ6VyG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104110063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210411_011840_535211_55A7A7CE 
X-CRM114-Status: GOOD (  17.41  )
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

From: Amit Engel <amit.engel@dell.com>

by nvme spec, get log page error information (lid 01h):
'parameter error location' field shall be set to FFFFh
"if the error is not specific to a particular command"

in addition, add missing error_loc in some flows

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 6 +++++-
 drivers/nvme/target/core.c      | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f4cc32674edd..2506f8de2e8b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -689,8 +689,10 @@ static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
 	else
 		status = nvmet_bdev_flush(req);
 
-	if (status)
+	if (status) {
 		pr_err("write protect flush failed nsid: %u\n", req->ns->nsid);
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+	}
 	return status;
 }
 
@@ -772,6 +774,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		nsqr = cdw11 & 0xffff;
 		if (ncqr == 0xffff || nsqr == 0xffff) {
 			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			req->error_loc = offsetof(struct nvme_common_command, cdw11);
 			break;
 		}
 		nvmet_set_result(req,
@@ -785,6 +788,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
 		break;
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_set_feat_write_protect(req);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index adbede9ab7f3..23874276a2aa 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -719,7 +719,7 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 
 	req->cqe->status = cpu_to_le16(status << 1);
 
-	if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
+	if (!ctrl)
 		return;
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
