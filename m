Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8095FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 16:11:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A559064EE7
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 16:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A559064EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xJjHicVL2PAidP0AZ37v+5HBg6I98zIqxHy3akXa0tw=; b=m2I8vBP15Hx+7Fucb4bYFzbj1u
	Rl7pC6JrsKbg9IgzKtsFgbm6XazeCfL7J8pSWAh5KMleDqYCWgRWw2e11fWjBVMtLFAwcKnsmLVEB
	EmURhGMfdmPHNqUK668S4c/ii4zagyucFlqZ6ynMsq7Q87wh3ZtWzoJ0g0db9qUfnIIgCCTH6s5oe
	ftEP2pQN2oHnTgTBL4/o4lwYLvvSMltg/RkIqEM1scaKaow9zqUXlkSEibvem4u091Q3tP/YSmkH6
	4MeB0ye+QBG+STDKVO8RjJ0nTLh+xZ5L7dSYGmCX/faWFAYA+6eDt9xpzsSr08diYExnrOQz32pPB
	HKyr2DcA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHU5J-005Xuh-CP; Wed, 03 Mar 2021 16:10:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSov-005Dl7-I6
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=CzaVg+5Q96aR8eHSFky1kOHxVmWqMrQ+D805RojM/v0=; b=iSUgsQDy83g4GfjbFZDiO3dGN9
 hiLd4djSmfBqeBGssn4ZqgyKqXQ1ZD3hRtyVpd3MY7sEUPGkZw7owFFJq/LqW//+q31UP8o3zgbAe
 HWgeaIx3pE5HUPQ9Z6aHXMiwk07ddSm8pYxKXVLk+XjpPWGTljkJ+Php+eM+W+BNZQscI40P50VU9
 Dvp7198Gwk5RT9zsXzgFx5tqpi0OISHDVFq+gX1IMh1IFT8DZTiHGxSnde4NbGm0vAWSl9SGpqsBT
 XUo9oARoMa3Xi7Ln5G2bhObSif5DZisxAoKQHx0CGKFC4vxzoKd2ClNwgicetGAJ6uxFE02DZpbsk
 DBc6GStw==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lH35g-00H0D6-Bj
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 11:21:26 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 122BIOaR002003
 for <linux-nvme@lists.infradead.org>; Tue, 2 Mar 2021 06:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=CzaVg+5Q96aR8eHSFky1kOHxVmWqMrQ+D805RojM/v0=;
 b=xMSNNsSHzDnNVtuO1SOLNfNBaM6ujCir1rTnceqTZhJ47ZTv8cxQGdqr3BVRSp5LfAXb
 U7ttzi1nyUT7XwpyWHweEBM+luiWKJ2WJ9T5Q0QRbC/urs5wXwZ0Qqo5GfersMfJx0LP
 wkBm3eMe4EP4Xxr2vmzFcS0nTVhWtutcWcD0IABWNiLn/GH4KuIkXF1GWdQuTuTQvaJ3
 qusUF3vx+5ecnl3Da4OqOw9vBeGgs586eMGGT8L8hkOceqb4SUPrq+4R/J0QoRUjCMaY
 RwHl4sSjU7GAaW0OYqg36r125fW8qI31ubjbx195yZQ45Ssrv7TtTmoMKdoXJYlkm8w/ 4Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 36yhhb8vdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 02 Mar 2021 06:21:08 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 122BFFT0085468
 for <linux-nvme@lists.infradead.org>; Tue, 2 Mar 2021 06:21:07 -0500
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 37046k7e7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Tue, 02 Mar 2021 06:21:07 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
Received: from unknown (HELO vd-amite.xiolab.lab.emc.com) ([10.55.225.216])
 by esaploutdur06.us.dell.com with ESMTP; 02 Mar 2021 05:21:06 -0600
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet-fc: simplify and fix nvmet_fc_alloc_hostport
Date: Tue,  2 Mar 2021 13:20:58 +0200
Message-Id: <20210302112058.24630-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-02_03:2021-03-01,
 2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=970
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020094
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_112125_965851_34F31897 
X-CRM114-Status: GOOD (  17.17  )
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

Alloc newhost only if no host has been found in host_list
Add a missing tgtport release reference

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fc.c | 45 +++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d375745fc4ed..debee48080d8 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1034,28 +1034,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (!nvmet_fc_tgtport_get(tgtport))
 		return ERR_PTR(-EINVAL);
 
-	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		spin_lock_irqsave(&tgtport->lock, flags);
-		list_for_each_entry(host, &tgtport->host_list, host_list) {
-			if (host->hosthandle == hosthandle && !host->invalid) {
-				if (nvmet_fc_hostport_get(host)) {
-					match = host;
-					break;
-				}
-			}
-		}
-		spin_unlock_irqrestore(&tgtport->lock, flags);
-		/* no allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
-		return (match) ? match : ERR_PTR(-ENOMEM);
-	}
-
-	newhost->tgtport = tgtport;
-	newhost->hosthandle = hosthandle;
-	INIT_LIST_HEAD(&newhost->host_list);
-	kref_init(&newhost->ref);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry(host, &tgtport->host_list, host_list) {
 		if (host->hosthandle == hosthandle && !host->invalid) {
@@ -1065,13 +1043,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 			}
 		}
 	}
-	if (match) {
-		kfree(newhost);
-		newhost = NULL;
-		/* releasing allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
-	} else
+	if (!match) {
+		newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
+		if (!newhost) {
+			/* no allocation - release reference */
+			nvmet_fc_tgtport_put(tgtport);
+			spin_unlock_irqrestore(&tgtport->lock, flags);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		newhost->tgtport = tgtport;
+		newhost->hosthandle = hosthandle;
+		INIT_LIST_HEAD(&newhost->host_list);
+		kref_init(&newhost->ref);
+
 		list_add_tail(&newhost->host_list, &tgtport->host_list);
+	}
+	/* release reference */
+	nvmet_fc_tgtport_put(tgtport);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
 	return (match) ? match : newhost;
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
