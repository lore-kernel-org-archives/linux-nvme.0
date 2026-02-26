Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9284FFD8FF5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EE9GCHAQSw6mrIX8ElQ7NKpZSXk8hRc/W4CcnuMKHnA=; b=XkxVhqhtuhsHGuOli2lWcv4hxD
	Zq6AHT1+0atXKhWHv9w9dT6PGS85e2lXiaEZ8X2RbCbOez6/JzdtJDNZ94fwID/v6M3zj1sXqV5Q1
	qY5ZVx2jqnVFD7aHEBAYLu0SX0bDCOHsS7ArIykY+buLbETdk2mQ/uZxiOQQ/OVdK1b9AUvnhN2aV
	lc5xfhV83wKElVhGU95lrsgiDHeLYyBFaXJ/XH8JRqHfK8AUaW8+s6/wXYllEKAotNNZoVWZNgEWT
	xgTm2kFiVQXCXaH95s9PuDtgBBLnIwuXYMCLmFix5BxBLxy2dNm/cIt9XW6tGx5ALYmQ4evNVsxKY
	ZC1K5Lpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgAI-00000006yMs-49qP;
	Thu, 26 Feb 2026 18:32:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgAH-00000006yMF-2ZVG
	for linux-nvme@bombadil.infradead.org;
	Thu, 26 Feb 2026 18:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EE9GCHAQSw6mrIX8ElQ7NKpZSXk8hRc/W4CcnuMKHnA=; b=BPewwn8Xp0E4QsNzhW8BqBYIax
	/UloEiuc1hk82nUCtLnr3yE5ZX3pL6zl++pNUTFMPNyDnToLWzT/KSeS/56xa0Og3u0eljd5gqsnb
	d74ebYEh73GKFNzZUxzJ5sf3hHNpePoLU6tzmrs4kUU9xT3bHmLsS9kGjOWZMWS+Vlx/0biIkXw5w
	viASCHJd7HuwrAakFbjOjt+qMJ1eMCoElHCqowtuzz6kVF7/jPhmdfmx6Wg3ILJYBdHyTuMih+dmy
	oQbGhdITV56t6AntcsLxdz3UAno+yU3eWkzjq+c5XyQ8dmBzzOx3Rwl8aKGYco1bGv/4DgxoDsI3Z
	yk53bOYQ==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA4-0000000Bo3E-1yYP
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:32:36 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHblAo2065809
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=EE9GCHAQSw6mrIX8ElQ7NKpZSXk8hRc/W4CcnuMKHnA=; b=dsb+LjLHFWPo
	tm5WKkPqmZKmE8Y3FZjM8R14HOY/LToHUGaFqObXNBxTFo1sfAx6kRkcdz5KQ7FG
	w5G7imOh8A+O5Q6wukHCYQg2PBV7H5/M+bW0BpMZ3zejsq4oa4XjXUoDkR7YCs9p
	NRMmMSNVAjXOweYmlQDXwPEGnM9xxeCN8OrQ+p2ppMwd7iye3MNdy5dmmkRXHKnV
	a0RLRAUBYO48HQjg2oTECLy+T0aIkGdZ5tvBmScRy+b6ietxTFQYbEmbWpMxBLSh
	wPnoKdkBZpwGzmVt+LwCUzKpDHj8gzPONCV2hV5HuCMLCTjDTVHIFCS/ho2NW64s
	Pfpu9WsFoQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cjtr7rpa4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:28 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 26 Feb 2026 18:32:28 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CA18D90B6942; Thu, 26 Feb 2026 10:32:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <nilay@linux.ibm.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/3] nvme: fix unmatched id's under delayed path deletion
Date: Thu, 26 Feb 2026 10:32:16 -0800
Message-ID: <20260226183216.2098584-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226183216.2098584-1-kbusch@meta.com>
References: <20260226183216.2098584-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: j40hFkpAqS44O-SzPoj8ETBGdhv8Hvok
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2OSBTYWx0ZWRfX9Q6Ak0Nqhh50
 7xuHxSi1Ry7sWgISz+YyCbDqPckwIekp3QpozIRgi0Q+cMpxROgyjsGnVC5jlDyQtDI6fA6pybj
 AtIiBy5vbrwzJZSVYslSU+alPi9Gh+AFwNmcfyXsf8mfv2L7PTagMFs7h9f6c2D7ofLo+ZhTbGZ
 p48ZfTvlJeKxs3csfMYAt5lag2KRevtP3kzcgTOVhK9ZKULi1RMpquq/D/2ncFmxUOKOHHd6BS5
 3clMz0z9gXPVW1If3Cs4Fc52GXwjtS1udnEvpwtzzrTb3PTf9VFSp8S8ZVifKT6GBC/U4WVwJJa
 mSUnGMb8BnIZLRMllg6JXTrSsgsBOjRTEXxF9oqxv8ePW2Zqy4XFLkmKjdHZDG5hVuwDchtNs6q
 qG2uMziSrmkFx3OxncEUzVpXAee/YKCmV170C4MaIu+T45JKK5yapDYxufK9yVgVRQKkh9QJDLE
 w+g3olp+7I7RgVTdOCA==
X-Proofpoint-ORIG-GUID: j40hFkpAqS44O-SzPoj8ETBGdhv8Hvok
X-Authority-Analysis: v=2.4 cv=Xrn3+FF9 c=1 sm=1 tr=0 ts=69a091bc cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=uzgnYBMELU8uwzz-TnwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_183232_933101_CDF30D31 
X-CRM114-Status: GOOD (  14.17  )
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
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5bb4b18511b7b..906421047debd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3968,6 +3968,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, st=
ruct nvme_ns_info *info)
 {
 	struct nvme_ctrl *ctrl =3D ns->ctrl;
 	struct nvme_ns_head *head =3D NULL;
+	bool retried =3D false;
 	int ret;
=20
 	ret =3D nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
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
+			if (!retried && multipath && list_empty(&head->list)) {
+				mutex_unlock(&ctrl->subsys->lock);
+				nvme_mpath_flush_remove_work(head);
+				nvme_put_ns_head(head);
+				retried =3D true;
+				goto again;
+			}
+
+			WARN_ON_ONCE(list_empty(&head->list));
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
 					info->nsid);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e73cc2e67ac51..44801801fc289 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1042,6 +1042,11 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *h=
ead);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
=20
+static inline void nvme_mpath_flush_remove_work(struct nvme_ns_head *hea=
d)
+{
+	flush_delayed_work(&head->remove_work);
+}
+
 static inline void nvme_trace_bio_complete(struct request *req)
 {
 	struct nvme_ns *ns =3D req->q->queuedata;
@@ -1110,6 +1115,9 @@ static inline void nvme_mpath_clear_ctrl_paths(stru=
ct nvme_ctrl *ctrl)
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_flush_remove_work(struct nvme_ns_head *hea=
d)
+{
+}
 static inline void nvme_trace_bio_complete(struct request *req)
 {
 }
--=20
2.47.3


