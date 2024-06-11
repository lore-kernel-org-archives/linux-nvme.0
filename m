Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3FDC27C75
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kGx9RtEnX9N8jjw+x54O+qITDZPZtKnDw4tDhFk02sA=; b=RvAFAJjPs2umzCJh419Zx/aRhD
	0S66D3tavaEDfylCXTgi4nIspjdeA0BEpVMRK5H/6DuxMoQ9QXeBp7i1//lpGsImncCln7aCu4/cC
	jJOKAH91jl/8OxMvk3droKBMpLu2RrEbhIkjDcAys+fGnNS3znBdkG0XBXeXKxPYzZVZpC3E2alBC
	pARBxwUNhr1UrJlL1EyLHYNuEHPcXLdgasaVvDHkNFS1OMGmZ3IhjHXATkizr+ClCQZ7DqZWnbNSH
	bPfYM1cVDadjGGsD8UyhqasdsGWO5MWCsUouRJb3/PHNhrq/+9Rt/6Tj4KxtmWb+WQOtPky11AVZp
	ieAbX3vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH3JH-00000009JC2-2gsh;
	Tue, 11 Jun 2024 15:21:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH3JC-00000009J8f-2PeQ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 15:21:17 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45B9k5Dc004990
	for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 08:21:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=kGx9RtEnX9N8jjw+x54O+qITDZPZtKnDw4tDhFk02sA=;
 b=MGTQmOQJ6SC+CBViAYSGlTdntrzQxefAlDsb/+AKjbYubEWzWJVCaj6VlFxOlIq1d31j
 msio2UQ6xaHRCZNjqPw/fMnUOr9s90lDOgySrJ/d0WrEUKzpBm7xqL0PQIU3/B2hkG87
 wv8emIa+dT42X6FWCI7RI7fYh9kkmoUxOqO9G4GL+gdv1h6vozRnr/K+aswEyckPpL9C
 OYRwggY+46tg9gZy0PD1tv+VgZ36468TIdH9ddbgsiTG1cBbH/ygZwmqPV2sbrF/j2bs
 MtWahCWIq38J4V8XfDXmgBezbAYBbwMWYyk6gkpRAg4dhmQ3c/3DnMZHyR4HAnXJbVTW wA== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ypm82a001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 08:21:09 -0700
Received: from twshared22606.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 11 Jun 2024 15:21:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8A056F54BF38; Tue, 11 Jun 2024 08:20:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>,
        Venkat Rao Bagalkote
	<venkat88@linux.vnet.ibm.com>
Subject: [PATCH] nvme: fix namespace removal list
Date: Tue, 11 Jun 2024 08:20:55 -0700
Message-ID: <20240611152055.2317197-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: E07hhFVAOuyCWsA4xUNkbt-oB3W5R8RN
X-Proofpoint-ORIG-GUID: E07hhFVAOuyCWsA4xUNkbt-oB3W5R8RN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_082114_790277_6C85C6BF 
X-CRM114-Status: GOOD (  14.61  )
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

This function wants to move a list element to another list, so do that
instead of using the wrong list splice API.

Fixes: be647e2c76b27f4 ("nvme: use srcu for iterating namespace list")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955d..3db8e94c85026 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct =
nvme_ctrl *ctrl,
=20
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			list_splice_init_rcu(&ns->list, &rm_list,
-					     synchronize_rcu);
+		if (ns->head->ns_id > nsid) {
+			list_del_rcu(&ns->list);
+			list_add_tail_rcu(&ns->list, &rm_list);
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
--=20
2.43.0


