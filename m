Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57994C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dp9jB3/zWqEW0lejCiauS6edrezGeGq1zpJr+Kx+fZI=; b=jEr82A9YtSJ0nHrtojsTQx3lYM
	9+llkXcu0/kJwCyLDBW548eJLyex6y2qqEfIQfs2JBOOngeJrXrgyIgtXkuChz1xlU2GgEilt7JxK
	h1jZNF0xOp7cqrzHZxWeLAN8+EU6oTqsJJmlmi6SqOuHAdBk41fTn8Dk77OABSBU0upImGkChZFfC
	nCxzoL8tlVfh4XhZa03R70RaqZDGBYVp/DP2skj7Ii12LiQWcYZVtQ+0vnrWnmjtM4gEXqxSpGN33
	JJib5ib/9zIbBn89vJvMA4XLXktny9RVsytUE3reHoN0wA4N4jszJl8fIR28tkLCWpa4J1oeiLpe8
	ZyjFdgDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHQGa-0000000DFI7-4BR5;
	Wed, 12 Jun 2024 15:52:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHQGY-0000000DFHI-3EFP
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 15:52:04 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 45CFbEQ4024314
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 08:52:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=Dp9jB3/zWqEW0lejCiauS6edrezGeGq1zpJr+Kx+fZI=;
 b=hV7y+HxNxvW3yl2z+NBnGRGgju03oovha427d0bVPLpvulwd7Dpxq4Z/NgoozRYJOvcR
 +Xt/4MxiTMlgoUXQAI1wFf+hX0TZ371I6GFpGXgXZYDPeqsTqNJsqQCuXrjkUtZbEZLZ
 66KEAGqPhDNDAwHI9Nc2QZmCkD7ILOwWNOvnsnuhKhv38YElYtKTzpjV6iuJ5CQZsYmc
 hSAus7BVC9RGLNJGgiUuanNri6MFatJb0TvpMAwnG0w+pslM1+mt45/+f+d6xKPDcJnc
 HxL7cuBYW+KevdR72T9866U/2E5/zvlZetAbPFaqIFQgjRNh8Wm42FYboUK1oU0mTctk Dg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3yqefm836f-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 08:52:00 -0700
Received: from twshared26916.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 12 Jun 2024 15:51:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 06B8FF5EA646; Wed, 12 Jun 2024 08:51:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <paulmck@kernel.org>,
        <davidgow@google.com>, <akpm@linux-foundation.org>,
        <venkat88@linux.vnet.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: fix namespace removal list
Date: Wed, 12 Jun 2024 08:51:35 -0700
Message-ID: <20240612155135.3060667-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612155135.3060667-1-kbusch@meta.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pbYPUus99QRrb0P984F_erxtbBEjFSUI
X-Proofpoint-ORIG-GUID: pbYPUus99QRrb0P984F_erxtbBEjFSUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_085203_025723_9131632B 
X-CRM114-Status: GOOD (  15.65  )
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

This function wants to move a subset of a list from an element to the
end to another list, so do that with the new list_cut helper instead of
using the wrong list splice.

Fixes: be647e2c76b27f4 ("nvme: use srcu for iterating namespace list")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955d..30fec15872b3d 100644
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
+			list_cut(&rm_list, &ctrl->namespaces, &ns->list);
+			break;
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
--=20
2.43.0


