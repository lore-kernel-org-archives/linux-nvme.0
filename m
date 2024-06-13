Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CF0C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ukz4u6wnq8+GVjMZ7x5zgDj6Z+Na2XO5gVAjzRTFRWw=; b=Tvcco/wzMWYkZCZ+TfPrAotXAq
	tkuJ+IqEIWpTu1+DSeh7ZUqrPPjSpysVcasMLGQSPF9CYl1AznVIFJbHXadIPHHwEcndlL3PrRXN1
	Amh0Sv2ulrP52HHzbSVAeN1A8Zb9BEbTfuro4OuauP3zUlSewrwo0gkh7mdpmeRXCl8mgtquFfJUo
	nqjSQhx0snVzCpfKQS/3wllNg4hW5da7cncG4tuk0GA8yz0mQR47D2mPkY2M+UpT22iEV7z2kNBwi
	A//wGS0uKRXeatXYCSuxAjQ7lLGr7QJxWZ2vutiwnliiK09yqG32pKudR+/4UFHC5IVLJcxhctotM
	XVAGTiMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHnYB-0000000HNxr-074L;
	Thu, 13 Jun 2024 16:43:47 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHnY9-0000000HNx2-0eeh
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 16:43:46 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DFU1mt031450
	for <linux-nvme@lists.infradead.org>; Thu, 13 Jun 2024 09:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=ukz4u6wnq8+GVjMZ7x5zgDj6Z+Na2XO5gVAjzRTFRWw=;
 b=jrdmhzV2pXwOJCK8kHYSE92pfN854EngpXoWYFt3aU6k5wAMm9KGk57eTiTLGwWHLe4y
 2kkJifKeZtY+rjhp+OiiLABJ7do64riDzwVX5RbgKUvtgliUDZoocDO5HOJUg5E5S627
 J/9JxqbSK0vcTu22iqyyp+6oHBOP3lskwuI7/eVIklrr6Kkp66g0PfHmXhmjC+7S4pmS
 nA+Z3nfpr7cLwGPlx7v22o2gmyxXQnuOLRbgVIexApjw3k9n+GB3jAwqlC6FtWl8aV0W
 riTPeVGeQqjSPjNVwKxShuH7kvSGo1jW0hpZP7mgbpnsPfoISNZhRVSjuUTV3F9GqGaX ZA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqqvdmg5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 13 Jun 2024 09:43:43 -0700
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 13 Jun 2024 16:43:41 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 3267BF6865F6; Thu, 13 Jun 2024 09:43:34 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Venkat
 Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [PATCHv3] nvme: fix namespace removal list
Date: Thu, 13 Jun 2024 09:42:46 -0700
Message-ID: <20240613164246.75205-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -jlXiKZE6fFUcL4hjdwUCnjGQKsqHNo9
X-Proofpoint-GUID: -jlXiKZE6fFUcL4hjdwUCnjGQKsqHNo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_094345_272758_CE88671C 
X-CRM114-Status: GOOD (  18.00  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

This function wants to move a subset of a list from one element to the
tail into another list. It also needs to use the srcu synchronize
instead of the regular rcu version. Do this one element at a time
because that's the only to do it.

Fixes: be647e2c76b27f4 ("nvme: use srcu for iterating namespace list")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
It would be neat to have a more elegant helper that we've been messing
with, and be able to use a single srcu synchronize, but in the interest
of time, this patch will fix the regression.

I was hoping to not have per-ns srcu sync's, but this path pretty
much only gets called on the last namespace anyway, so it should
functionally work out to be a single sync without to optimizations.

 drivers/nvme/host/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c40930d10bd34..782090ce0bc10 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3960,12 +3960,13 @@ static void nvme_remove_invalid_namespaces(struct=
 nvme_ctrl *ctrl,
=20
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			list_splice_init_rcu(&ns->list, &rm_list,
-					     synchronize_rcu);
+		if (ns->head->ns_id > nsid) {
+			list_del_rcu(&ns->list);
+			synchronize_srcu(&ctrl->srcu);
+			list_add_tail_rcu(&ns->list, &rm_list);
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
=20
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
--=20
2.43.0


