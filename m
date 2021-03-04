Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA472C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5658264EF4
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5658264EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xJjHicVL2PAidP0AZ37v+5HBg6I98zIqxHy3akXa0tw=; b=rMnwu7yicj7Xv8IOnp/UJxfgZ9
	sVka7APFZyx38GEADwfrJmu3j0WGigq+/Tr+mHc+LY7PlRNj8iGtcUH+0RUS+D5ECX7dx0jxiCtnp
	az0LQ9BKgU2AqVbmEtQit768rm9GNAxUCNm9gb2kbnbDHhgNpjB0glADEdQZtM1x1QwsRYFRQyAHD
	TI0QxOvkKhPyx9XFVyGPb40yqnQrei6eaJcaxHzNBFucAsCPpP1Wu5wSqsIUtlCGR3HbMkvv2t7kp
	uJkBrDGQTz63TBjcpPNf4eXpE6065EMTbtxzsH4ACwREAr5hHQIOTT8YvhzehS1fpPwTw6dt8rXOw
	aV9arIhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHjY6-0089cM-0x; Thu, 04 Mar 2021 08:41:34 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHj5v-0087Ja-T5
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 08:12:30 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12483009006031
 for <linux-nvme@lists.infradead.org>; Thu, 4 Mar 2021 03:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=CzaVg+5Q96aR8eHSFky1kOHxVmWqMrQ+D805RojM/v0=;
 b=jhImvlV8rnYNH4D2gHA3LgXQKIJMqd2rR0EBEXgQKKyptDmggfyOGtmbdaTtWGT3pY2w
 /DZ9+kpF3ZePs3w/D9kLr0aBPCr6TvJXajSiiennHIEhZ1xhOqlLNWq788i1RXR3lX5W
 BAtpuB3m4Lj/FsapU8Ch3J5G65NhrUvryJys3xTTw83v50GULL8QjJAVI2s4u6upFbGx
 RkwIG2BLX8Wjc47kchhlmxpWqO1bPz5BWVdpba/Gdt8HvrVEN6V5c2H42kK8iqFFiPUd
 QKOAq1F0fxO3flBmGuOj/NQEYN2lPvtldtgnvj8cEmSMJCrrkkx5On5vGBBKNdJg2YDn ZA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 36ykmu9e77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 03:12:21 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1248BACx014826
 for <linux-nvme@lists.infradead.org>; Thu, 4 Mar 2021 03:12:21 -0500
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 372myjcn95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 03:12:20 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
Received: from unknown (HELO vd-amite.xiolab.lab.emc.com) ([10.55.225.216])
 by esaploutdur05.us.dell.com with ESMTP; 04 Mar 2021 02:12:20 -0600
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, james.smart@broadcom.com
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet-fc: simplify and fix nvmet_fc_alloc_hostport
Date: Thu,  4 Mar 2021 10:12:15 +0200
Message-Id: <20210304081215.21042-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-04_02:2021-03-03,
 2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=991 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040035
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040034
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
