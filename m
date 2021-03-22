Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0E4C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:58:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FC961477
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FC961477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1pcPb6kIfger7mLgp5jVrSDJzTWqMZytjmEajeDlDfs=; b=UzRpn2TbYqkzL5cweeYOYSNv+2
	LH5XmDZ87P4ghG1t43d7lW87WsVclyA87IgOKQbRGN3q9IdGk2A1WGQ2brxULJKbm6VeWf85Cla/i
	cPju7lQiZ+Ob+AFsDczlHCCGGe+Epz6bxTYLWQc9MT0A+lmx9uvgZGTcIxmjKEwdjFmI0RBofvmGq
	zhm5fEPQ4+J5VdU2Wp151i3UQNL1h7B15WuILpkccGgDvnqEgF48O++T/OK89MTfT77fQE2avwnvi
	Dnm8BaS/0EE3WUcNUIOfkXa3dqnqoyke+QnsT8g1R/JBofPO2Y8xqIqJs0QjsTwyEdBwKQX4mzdqn
	0FZX6brg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOQg8-00CT2b-U8; Mon, 22 Mar 2021 19:57:33 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOQg3-00CT1p-NU
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 19:57:30 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12MJudDF031197
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 15:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=UBitxhjX9ruzFaIi6XuiaIDug9T/9cMUiF1IXc+5zkQ=;
 b=Pvxpvmm9m6Oz9MJ2QjeRiaR09JxlVTuY9wh4G7qGjzkVhboejEwCjtmhglnKdTl6xFTU
 wI+ugRu5VObzaRp/zm4S5G2yoWRek59B9fuuKX+ENxz43iohKgE3kq9XRmqRKhVInICW
 peAozhtWfKVyOHeunyRiEmgjb2txPmc02k1okxEif6b87PgmsN4mR3e1qZGKjcOf0M6Y
 416wTlg9/NQCEyFwoawiSi+NeLokVXi1rai5d2LzaLZNpWAuQ3cCzelUodlP5T6vdrmc
 0hamo+dEysqjuVuy7+t+oNGTBXKPKDRwqGe9QMg9A0LEgZes0h5Sot/QUU2IPe3Suv6x Ug== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 37dc6wpnhe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 15:57:25 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12MJt7bj077128
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 15:57:24 -0400
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 37dxc9cj5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 15:57:24 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
Received: from unknown (HELO vd-amite.xiolab.lab.emc.com) ([10.55.225.216])
 by esaploutdur05.us.dell.com with ESMTP; 22 Mar 2021 14:57:22 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, james.smart@broadcom.com,
 Chaitanya.Kulkarni@wdc.com
Cc: amit.engel@dell.com, James Smart <jsmart2021@gmail.com>
Subject: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Date: Mon, 22 Mar 2021 21:57:17 +0200
Message-Id: <20210322195717.13094-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-22_11:2021-03-22,
 2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220146
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_195728_475179_D71384DC 
X-CRM114-Status: GOOD (  20.41  )
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

Once a host is already created,
avoid allocate additional hostports that will be thrown away.
add an helper function to handle host search.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fc.c | 77 ++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d375745fc4ed..cfde3376b8ee 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1020,61 +1020,76 @@ nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
 	nvmet_fc_hostport_put(hostport);
 }
 
+static struct nvmet_fc_hostport *
+nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
+{
+	struct nvmet_fc_hostport *host;
+
+	lockdep_assert_held(&tgtport->lock);
+
+	list_for_each_entry(host, &tgtport->host_list, host_list) {
+		if (host->hosthandle == hosthandle && !host->invalid) {
+			if (nvmet_fc_hostport_get(host))
+				return (host);
+		}
+	}
+
+	return NULL;
+}
+
 static struct nvmet_fc_hostport *
 nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
-	struct nvmet_fc_hostport *newhost, *host, *match = NULL;
+	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/* take reference for what will be the newly allocated hostport */
+	/*
+	 * take reference for what will be the newly allocated hostport if
+	 * we end up using a new allocation
+	 */
 	if (!nvmet_fc_tgtport_get(tgtport))
 		return ERR_PTR(-EINVAL);
 
+	spin_lock_irqsave(&tgtport->lock, flags);
+	match = nvmet_fc_match_hostport(tgtport, hosthandle);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	if (match) {
+		/* no new allocation - release reference */
+		nvmet_fc_tgtport_put(tgtport);
+		return match;
+	}
+
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
 	if (!newhost) {
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
+		/* no new allocation - release reference */
 		nvmet_fc_tgtport_put(tgtport);
-		return (match) ? match : ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	newhost->tgtport = tgtport;
-	newhost->hosthandle = hosthandle;
-	INIT_LIST_HEAD(&newhost->host_list);
-	kref_init(&newhost->ref);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(host, &tgtport->host_list, host_list) {
-		if (host->hosthandle == hosthandle && !host->invalid) {
-			if (nvmet_fc_hostport_get(host)) {
-				match = host;
-				break;
-			}
-		}
-	}
+	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	if (match) {
+		/* new allocation not needed */
 		kfree(newhost);
-		newhost = NULL;
-		/* releasing allocation - release reference */
+		newhost = match;
+		/* no new allocation - release reference */
 		nvmet_fc_tgtport_put(tgtport);
-	} else
+	} else {
+		newhost->tgtport = tgtport;
+		newhost->hosthandle = hosthandle;
+		INIT_LIST_HEAD(&newhost->host_list);
+		kref_init(&newhost->ref);
+
 		list_add_tail(&newhost->host_list, &tgtport->host_list);
+	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	return (match) ? match : newhost;
+	return newhost;
 }
 
 static void
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
