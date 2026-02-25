Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E328EFD45EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m7bgWncU2AuZW7BawRcoqT4+KgUPKPZzj9zc96TC0MM=; b=LgM5qx9Ldt1pBfmHe8pI1dJbbA
	/xtXu7FCjHbvgf59Ota5r0ZJOi2EZoaYHGz9m6NKnyjZEv/N2XvOznvOn5p/ITPz3jrfRQvuU0/vK
	noRsmx/r+PA4Z5XHVksxu2XKWHbeRTYY99D7SGaRuNo1i40KZg3gEE0skznBlCTJygiJyw+ur4Str
	dly7AFHWAmfvR5OE2jVNgtVOcPP8IFWtvuyp9rOGtoKpV+hxl+tWRwqu165KXUi7r3JL4uxW5Y9PK
	ji6vSx71n4mSYrT5G5OPFMRVX5keJFTWUcg4lpSiAp5u+f1k7RBqwW5aphAJJ7d0TFSS3kKKJwKvb
	hK8ouwQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLNt-00000004qMK-0dU6;
	Wed, 25 Feb 2026 20:21:25 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLNq-00000004qLV-1rfM
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 20:21:23 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PIopmi1806365
	for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 12:21:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=m7bgWncU2AuZW7BawRcoqT4+KgUPKPZzj9zc96TC0MM=; b=ES8Z3rxXSxKL
	6apJPqNQqMYy1HeRJz17KMyaT6ThrZUeIhY6eVCBlp4OV3UMhHZKaLsRd63SWGyw
	v3WqQOzhuFnvpk2Uh+tsRwsv5Pgwq//EwdZq/e74IJ1AAb6ZA9+vAH4vCV9Jy4Ky
	2lFYdNOEDDMUM2yr4ZxsrEUb8vk88P1k0Aq+G2NAGPPRYgZyAsT0VmuFRC4jkuNb
	kW2ycUO1gZZBAY+oOuuA8d90oUI6JWGVcJ+o98GOEAJe59IeRxGK6+/dNqaSPu2G
	iIJC9bRPbUCRc6f1zVSb1PO+PjbQOx5glYt0xmFFVJ4gQqKEBSnr7LKi1ysJqmCV
	ztEi3UGpxg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cj6qhs1fy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 12:21:22 -0800 (PST)
Received: from twshared23938.03.snb2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 20:21:19 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6A4548F4135B; Wed, 25 Feb 2026 12:21:10 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <nilay@linux.ibm.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: fix unmatched id's under delayed path deletion
Date: Wed, 25 Feb 2026 12:21:09 -0800
Message-ID: <20260225202109.447144-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225202109.447144-1-kbusch@meta.com>
References: <20260225202109.447144-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rm9PiQWG16C3cxT4s7SUfAMSqYKjIzul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5NCBTYWx0ZWRfX5OpyDxVOZJnG
 vBIcF4pxzZBqSp+PaqkkcoJDkMF29ry+kRiNBZwZoltRo6Zmrcq1aO6/zE2JNsnydUVmrf57gx9
 0PABBWe4KU3xgKPl1YFaQNtwmfUtEFdzfdKQ3Ewqpb2KQlZ65Rdcs+uxMUHu1niSvV6I++Xuqtv
 //6u7zWYKusYXwxKVFokhpWhKp+D804vkW8GGOx9ZWDXzfbBhndeI4HCgrTAbJCA7DzH5YiODeJ
 tWwtdk7JRhn14FyFfIlyz05By1vizppl/OJVCThCUF9TXWWzTxu08nrhl6nARep46WTG4eA508M
 ws7BQN3xLPBtzlBmxblD0w9tCSDSorcjtV5siY3MU8omVidAXqkTzoWSEAJc1nS0QPdeIuwwCz0
 fW3o1NXiMnQ7nStThUtCUwu5/W2BUP0xVMQuDCuAiso7VipM6SW6xtQMvaszfy6x8xJU5ZiGwzk
 JnFuGkoekIpiFu5EAkQ==
X-Authority-Analysis: v=2.4 cv=edMwvrEH c=1 sm=1 tr=0 ts=699f59c2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=Tj7H7vrIIguaIRWV7eoA:9
X-Proofpoint-GUID: rm9PiQWG16C3cxT4s7SUfAMSqYKjIzul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_122122_683752_D292CE73 
X-CRM114-Status: GOOD (  13.35  )
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

The NVMe controller is allowed to reuse an NSID for a new namespace after
deleting the previous namespace that had been using it. The delayed remov=
al may
have the stale namespace head in the subsystem list pending the timer, wh=
ich
would cause the scan to falsely report an ID mismatch error for the new
namespace. Flush the pending removal work and retry to resolve this.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3de52f1d27234..e731d3182f095 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3966,6 +3966,7 @@ static int nvme_global_check_duplicate_ids(struct n=
vme_subsystem *this,
=20
 static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *in=
fo)
 {
+	bool retry =3D IS_ENABLED(CONFIG_NVME_MULTIPATH);
 	struct nvme_ctrl *ctrl =3D ns->ctrl;
 	struct nvme_ns_head *head =3D NULL;
 	int ret;
@@ -4008,6 +4009,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, st=
ruct nvme_ns_info *info)
 		ctrl->quirks |=3D NVME_QUIRK_BOGUS_NID;
 	}
=20
+again:
 	mutex_lock(&ctrl->subsys->lock);
 	head =3D nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
@@ -4033,6 +4035,22 @@ static int nvme_init_ns_head(struct nvme_ns *ns, s=
truct nvme_ns_info *info)
 			goto out_put_ns_head;
 		}
 		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
+			/*
+			 * A newly created namespace can reuse an NSID that was
+			 * previously deleted. If the head has no active paths,
+			 * it is pending delayed removal and still occupying
+			 * this NSID in the subsystem list. Flush the removal
+			 * work to clear the stale head and retry.
+			 */
+			if (retry && list_empty(&head->list)) {
+				mutex_unlock(&ctrl->subsys->lock);
+				flush_delayed_work(&head->remove_work);
+				nvme_put_ns_head(head);
+				retry =3D false;
+				goto again;
+			}
+
+			WARN_ONCE(list_empty(&head->list));
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
 					info->nsid);
--=20
2.47.3


