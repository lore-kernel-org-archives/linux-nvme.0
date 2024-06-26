Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB883C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8L/mX8O6BFJO/aguMkBtonWEoWBnd7DsBSRj6RxPZwA=; b=xZnQLQC2gS6HVdc3+08P2sZrZY
	DyyHrNa1OPUtIVd4B68+I5CZQQ+xWwTUGJcwJafhXxFQG1/TfeTD2oMVRe+kEzt01o9i/ioF3nXc3
	3MJbHWpLhYxoTYoOHjoBo4OMudNOSZJjbGG535N4kiSm+6OLQRwskZyoBynK0/Lelgn0Xt4iz+iDF
	ynUKB5FmktETKpRgDWQSj54tbBr8w37iLcMYkYxb6ooinM/jrX4GrKpa4GAuihrDjjG+BoyXV/MsR
	5/mYBxWAkLm4aTGTzFxkkHpY5kplDvXsKvAGO66TY0mz055kC7i4UyxtWZBDDjQ2utJQKUZsQ3QWi
	L1NcmSEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR3Y-00000006b2k-3xkJ;
	Wed, 26 Jun 2024 11:43:21 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR3J-00000006asA-0LOz
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 11:43:10 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240626114303epoutp027928f7f7059f871f4229aed34831d4a6~ciy0C4KDo0308303083epoutp02F
	for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 11:43:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240626114303epoutp027928f7f7059f871f4229aed34831d4a6~ciy0C4KDo0308303083epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719402183;
	bh=8L/mX8O6BFJO/aguMkBtonWEoWBnd7DsBSRj6RxPZwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvznAlIs9UqqQJ6VYiRGTQeuIL+sVKtUYCJn325AgNl/3rUvDhWUoEgTdONJwJK9g
	 NHH12vhlGL0LSeZ8iw+Q56J2uwbzP1blJsEUYHIriTl3Jvk3Y5lXiF2JOe4oMBVl5U
	 AFfaDVFAg09iwDtAo74Asv1fz6G+3KduFpGCl2sE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240626114302epcas5p35cf1dce423571350bd5b717f6e19a8e8~ciyzyVQun2534525345epcas5p3F;
	Wed, 26 Jun 2024 11:43:02 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W8KZY09f7z4x9Px; Wed, 26 Jun
	2024 11:43:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.95.19174.4CEFB766; Wed, 26 Jun 2024 20:43:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240626101529epcas5p49976c46701337830c400cefd8f074b40~chmW58ILl2295722957epcas5p45;
	Wed, 26 Jun 2024 10:15:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240626101529epsmtrp284792c42758cdf9b87c024ce28673c1a~chmW5ITko1237112371epsmtrp2i;
	Wed, 26 Jun 2024 10:15:29 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-41-667bfec42212
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.04.07412.14AEB766; Wed, 26 Jun 2024 19:15:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101527epsmtip1f357ba9816aaf746029621e642cca8bf~chmVN_59n0370603706epsmtip1I;
	Wed, 26 Jun 2024 10:15:27 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 10/10] nvme: add handling for user integrity buffer
Date: Wed, 26 Jun 2024 15:37:00 +0530
Message-Id: <20240626100700.3629-11-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmlu6Rf9VpBu37zC3mrNrGaLH6bj+b
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpu8Xy4/+YLCZ2XGVy4PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5vHx6e3WDze77vK5tG3ZRWjx+dNcgGcUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMx7vO8hYcFexYumEjSwNjE3S
	XYycHBICJhJP995nA7GFBPYwSqxq5upi5AKyPzFKNK25zgbhfGOU+PzmJzNMx7tZfewQib2M
	Er/e/WaFcD4zSsya8oUJpIpNQF3iyPNWRhBbRKBWYmXrdLAOZoEGRonuCd/ZQRLCAm4SPb+m
	gTWwCKhKzN+wFijOwcErYClxar4cxDZ5iZmXIMo5gcJ3Nm8Hm8krIChxcuYTFhCbGaimeets
	ZpD5EgIzOSTuN/5hgWh2kbj+5RPU2cISr45vYYewpSQ+v9vLBmGnS/y4/JQJwi6QaD62jxHC
	tpdoPdXPDHIPs4CmxPpd+hBhWYmpp9YxQezlk+j9/QSqlVdixzwYW0mifeUcKFtCYu+5Bijb
	Q2L26VVMkMDqYZQ4MOs74wRGhVlI/pmF5J9ZCKsXMDKvYpRKLSjOTU9NNi0w1M1LLYdHc3J+
	7iZGcNrVCtjBuHrDX71DjEwcjIcYJTiYlUR4Q0uq0oR4UxIrq1KL8uOLSnNSiw8xmgIDfCKz
	lGhyPjDx55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwLT83P47
	r/qXX3u2tO/NxFuSAQXbT38399B+yqh3Y6/L0ZbsF6HFm/pDkyq+ZlaWZT+c68Mk7rqueibL
	wtmWHOffnXpfXWjm+Xdicq9KqHGivnD/m6YZ87I3vbURnPpl/pk80bX7vZSa5c9cCnF6oKRd
	emWN2PRN5xnmK39wUs9I0b5tdGbZHOb9eyreSTzRNtIX9Xu9/7ntl5fqhkIvZKR6zSZyfujZ
	9iZO4ea7Q4uOcTMK3/E61m0n38Zp4Wla75T+ij9UI+9/mde6yS6b7m4RjnV988zS0+VRzmv/
	r1WHAjf8e94pss1wlcLDF4Zz97vw/HyV2vZ0j2Da85WWIh0HDjOIaOhmXWSRDQvalqLEUpyR
	aKjFXFScCADXjF6dRAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnK7jq+o0g8UvWC3mrNrGaLH6bj+b
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpu8Xy4/+YLCZ2XGVy4PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5vHx6e3WDze77vK5tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZj/cd
	ZCy4q1ixdMJGlgbGJukuRk4OCQETiXez+ti7GLk4hAR2M0r0zO1jgkhISJx6uYwRwhaWWPnv
	OTuILSTwkVFi2y1VEJtNQF3iyPNWRpBmEYFWRokDU1vAHGaBFkaJua0tYB3CAm4SPb+mgU1l
	EVCVmL9hLVCcg4NXwFLi1Hw5iAXyEjMvfQcr5wQK39m8nRFimYXEg+fNrCA2r4CgxMmZT1hA
	bGag+uats5knMArMQpKahSS1gJFpFaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcFxo
	aexgvDf/n94hRiYOxkOMEhzMSiK8oSVVaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThES
	SE8sSc1OTS1ILYLJMnFwSjUw2R/25Axlbgir05tkbcTxea630w3WYBPZGl6Jc/se9wfM+rLy
	7lPLciPnFu9tDpU5i2sOzrsl8UJrfdmv1gkPZqkYPRU/8e/kpKmxt9i23Lbe6b/RZOcduQdP
	yk6GRjlpPHGLiJtWIL/3o6CWJKdHp8apM4mK86R2VQil76pM67/FNWNx+b3LJ7ayfHYsZw/7
	UuxZ3eQdKFVW3CkmPf/ozzOXJv9NnNKZmNS7Z4v3jl9KJzjDL9defbf75IzpC/OTtkqe5A2+
	EcrbHxgxh+mxuojIj8yrs+YzPtK8FeBknTLT19tYsVd8o/Tq0pxPpiH79uhdM/vMvs7jPnea
	woRJ6w2Pdi1PSHquOlXk7vwzSizFGYmGWsxFxYkA2SNuovoCAAA=
X-CMS-MailID: 20240626101529epcas5p49976c46701337830c400cefd8f074b40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626101529epcas5p49976c46701337830c400cefd8f074b40
References: <20240626100700.3629-1-anuj20.g@samsung.com>
	<CGME20240626101529epcas5p49976c46701337830c400cefd8f074b40@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_044305_970734_BF845AF8 
X-CRM114-Status: GOOD (  21.85  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

Create a new helper that contains the handling for both kernel and user
generated integrity buffer.
For user provided integrity buffer, convert bip flags
(guard/reftag/apptag checks) to protocol specific flags. Also pass
apptag and reftag down.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 85 ++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab0429644fe3..d17428a2b1dd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -870,6 +870,13 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static void nvme_set_app_tag(struct nvme_command *cmnd, u16 apptag)
+{
+	cmnd->rw.apptag = cpu_to_le16(apptag);
+	/* use 0xfff as mask so that apptag is used in entirety*/
+	cmnd->rw.appmask = cpu_to_le16(0xffff);
+}
+
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
@@ -927,6 +934,55 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	return BLK_STS_OK;
 }
 
+static blk_status_t nvme_setup_rw_meta(struct nvme_ns *ns, struct request *req,
+				      struct nvme_command *cmnd, u16 *control,
+				      enum nvme_opcode op)
+{
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+
+	if (!bip || !(bip->bip_flags & BIP_INTEGRITY_USER)) {
+		/*
+		 * If formated with metadata, the block layer always provides a
+		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
+		 * we enable the PRACT bit for protection information or set the
+		 * namespace capacity to zero to prevent any I/O.
+		 */
+		if (!blk_integrity_rq(req)) {
+			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
+				return BLK_STS_NOTSUPP;
+			*control |= NVME_RW_PRINFO_PRACT;
+		}
+
+		switch (ns->head->pi_type) {
+		case NVME_NS_DPS_PI_TYPE3:
+			*control |= NVME_RW_PRINFO_PRCHK_GUARD;
+			break;
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			*control |= NVME_RW_PRINFO_PRCHK_GUARD |
+					NVME_RW_PRINFO_PRCHK_REF;
+			if (op == nvme_cmd_zone_append)
+				*control |= NVME_RW_APPEND_PIREMAP;
+			nvme_set_ref_tag(ns, cmnd, req);
+			break;
+		}
+	} else {
+		unsigned short bip_flags = bip->bip_flags;
+
+		if (bip_flags & BIP_USER_CHK_GUARD)
+			*control |= NVME_RW_PRINFO_PRCHK_GUARD;
+		if (bip_flags & BIP_USER_CHK_REFTAG) {
+			*control |= NVME_RW_PRINFO_PRCHK_REF;
+			nvme_set_ref_tag(ns, cmnd, req);
+		}
+		if (bip_flags & BIP_USER_CHK_APPTAG) {
+			*control |= NVME_RW_PRINFO_PRCHK_APP;
+			nvme_set_app_tag(cmnd, bip->apptag);
+		}
+	}
+	return 0;
+}
+
 /*
  * NVMe does not support a dedicated command to issue an atomic write. A write
  * which does adhere to the device atomic limits will silently be executed
@@ -963,6 +1019,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 {
 	u16 control = 0;
 	u32 dsmgmt = 0;
+	blk_status_t ret;
 
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
@@ -990,31 +1047,9 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.appmask = 0;
 
 	if (ns->head->ms) {
-		/*
-		 * If formated with metadata, the block layer always provides a
-		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
-		 * we enable the PRACT bit for protection information or set the
-		 * namespace capacity to zero to prevent any I/O.
-		 */
-		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
-				return BLK_STS_NOTSUPP;
-			control |= NVME_RW_PRINFO_PRACT;
-		}
-
-		switch (ns->head->pi_type) {
-		case NVME_NS_DPS_PI_TYPE3:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD;
-			break;
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD |
-					NVME_RW_PRINFO_PRCHK_REF;
-			if (op == nvme_cmd_zone_append)
-				control |= NVME_RW_APPEND_PIREMAP;
-			nvme_set_ref_tag(ns, cmnd, req);
-			break;
-		}
+		ret = nvme_setup_rw_meta(ns, req, cmnd, &control, op);
+		if (unlikely(ret))
+			return ret;
 	}
 
 	cmnd->rw.control = cpu_to_le16(control);
-- 
2.25.1


