Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C213D65C7E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=; b=doomgyA6B0rYd2/Pmcw2n90MUe
	BbPV0h3rvlBeXMhhLoLcfj2Y0T2VZxOiJBYtsx3P5WIRIsIgr8L1hQz9XUZrbwMVTUO2k30ZwHYa7
	1UVgYljuTIb/iqG+NozRujC+sPfByv5y5vF2varSG0s/GxmtgLtsg18pbMeoM97zs5anUlN2mrdwg
	KJPqQ/YIE6bdNlIDkFkYIt0lAliNXstb6s2C1h4KpFhtxNTW/UpTVSgLiG8rzvW7W4kHMfWSvt2ww
	x7QRdlhNiyzmtxGtni8WFRYN0K3+ZrPZK9tqgwtS9MfL4ducpPfne9SjrZhQvF7DRxLeHx2igPmoK
	rKG35jaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYTx-00000009oOj-3U9p;
	Thu, 14 Nov 2024 11:57:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXu3-00000009i55-06GB
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 11:20:50 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241114112044epoutp02bbbd97abcc7662533e751f3333719606~H0clwiCii0588005880epoutp02U
	for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 11:20:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241114112044epoutp02bbbd97abcc7662533e751f3333719606~H0clwiCii0588005880epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731583244;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxHkNspwD3MvmqnzD+uT4PZfdSb3n0sUqgMfIMJJvQ3Y8h7FhCridryGEoCt9qV35
	 c3XIHfwlX+EWXFgGO03HIrcIQc/TYHxLotFRi7Wvw1CR0eNltzjZOm9xsMcGjGZUvz
	 iX5QRnoXvOieoS7H3TOnyydbHHRhFv/87LCZ6o7Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241114112044epcas5p201405b0548d1fcb4fafdee083cdf0e3c~H0clL8nuO2483624836epcas5p2v;
	Thu, 14 Nov 2024 11:20:44 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XpyPj5wmNz4x9QP; Thu, 14 Nov
	2024 11:20:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.4F.37975.C3CD5376; Thu, 14 Nov 2024 20:17:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241114105354epcas5p49a73947c3d37be4189023f66fb7ba413~H0FKDmn8J3038330383epcas5p4N;
	Thu, 14 Nov 2024 10:53:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241114105354epsmtrp15b28b4f295e4fa2d17925eab21257562~H0FKB5O4R1625716257epsmtrp1v;
	Thu, 14 Nov 2024 10:53:54 +0000 (GMT)
X-AuditID: b6c32a50-085ff70000049457-97-6735dc3caa88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.5A.07371.2C6D5376; Thu, 14 Nov 2024 19:53:54 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241114105352epsmtip2e2b0eed35b9ebb8f60e972629024a793~H0FHuq9Fv1405814058epsmtip2H;
	Thu, 14 Nov 2024 10:53:51 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v9 02/11] block: copy back bounce buffer to user-space
 correctly in case of split
Date: Thu, 14 Nov 2024 16:15:08 +0530
Message-Id: <20241114104517.51726-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241114104517.51726-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc98rrwVX9igs3jRxkke2iQRose0eKI4BI484NxJi4n5k8AYv
	LevP9MfGcImNpDPIsM45DD8UcSjaRpgIAkKNlDIQpDBgMOSXmBJHcUxsNpwOXEvL5n+fc8/3
	nG/OufdyUN40xucUqPSMVkUrCCyEdb07ekcsNiOWCsZGxeTKn89Y5JETayhZbbkOSOuMGSOX
	uh8DcvJWO0JetvYg5LLJySKrThcj5En7OCBtd2PITtttFllzcYFNlk60YWR97zpCDq31BpFD
	ldXslDCqvXKGTY0OGqgmSwlGXas7THVMGjFqZeEuizrebAHUnXMONuVpepVqcv2OZIV8KN8j
	Y+h8RhvJqPLU+QUqaTKxLzsnLUcsEQhjhYnkm0SkilYyyUT6u1mxGQUK7zhE5Oe0wuA9yqJ1
	OiJ+7x6t2qBnImVqnT6ZYDT5Co1IE6ejlTqDShqnYvRJQoEgQewV5splnqojiMYaWmgxlmNG
	cPKlYyCYA3ERbL/jQI+BEA4P7wTw2lob2x88BvD+xEwg+AvA0iEjulkycr4syJ+wAdjwzSLL
	H3gAbJ33AJ8Kw9+Ajgcm4EtE+BqX1Q5sqFB8EcALlvMsnyocz4N9NwYxH7Pw1+DMkBvxMRdP
	hFPWWszvtx1WjKyyfRyMJ8FLxhbUrwmDtytcG31Qr6a4pWpjDIiPcWBjx6+B4nT4R6eH7edw
	6O5tDjAfLpq/DrAUPhldQPysgcU/3QR+fgua+s3ephyvQTRsvBHvP94Gv+9vQPy+obDsmStQ
	yoVtZzeZgEcvVwcYQpvTGGAKDpSbA+suA7Cv9FTQCRBZ+cI8lS/MU/m/9TmAWgCf0eiUUiZP
	rBHGqpgv/rvpPLWyCWw8851ZbcD641qcHSAcYAeQgxIR3P60XVIeN5/+sojRqnO0BgWjswOx
	d+PfovxX8tTef6LS5whFiQKRRCIRJe6SCImt3CXTmXweLqX1jJxhNIx2sw7hBPONCJdT/t3e
	h6yCrornGYmF9GrXhZx7Mqf0vbmoSzX/3Kpf/PuK2pQmS8jsy3W21i20jo9kIg9jtza5168I
	0+qfjqQXiXuDC8eotJrC39y8KVmNuXbb8EFe0WrG/WW5avazUNM7++3OsNCPzLsj5OmS/q7q
	lDX+7qtIdot4bK46NYXXM31Pse8XF3Aqy15+QB5w4WdipmPUuRHMJ5lR82db5jt6nE/chtz3
	rw6XUPjo6+ONp4ujtyxNlDQ7ir764eOft8RMnUpISo2K1yvqDzu6n+rnLg6mvr3jkDTEdmhg
	pYEnTj6a8unw7Af7J58fX17PtkMltE7UhWHTNx/NssMfTW4nWDoZLdyJanX0vyCGFjZvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvfQNdN0gx0PZCw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAVxSXTUpqTmZZapG+XQJXxufZTUwFq/kqVjVMY2tg
	nMTTxcjJISFgInFpUS9rFyMXh5DAbkaJzrfLmSESEhKnXi5jhLCFJVb+e84OUfSRUWLh2Q2s
	IAk2AXWJI89bwYpEBE4wSsyf6AZSxAxSNOHLbBaQhLBAosT2k21gU1kEVCXunn/FBGLzClhK
	3F69kA1ig7zEzEvf2UFsTgEriRUNW4HqOYC2WUp8Xy8CUS4ocXLmE7CRzEDlzVtnM09gFJiF
	JDULSWoBI9MqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgONPS2MF4b/4/vUOMTByM
	hxglOJiVRHhPORunC/GmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbL
	xMEp1cDkIFsRyVHulKmw2yjgzaJTKxKvc8XqdnltcJTdmOt1lPUmm0q9X9K+Vv4vT0zv8fgf
	TTRvjFybmv1cUHfVq882/a0rck1erTXb8u37/E25elHyk/+flNhw9XlvmkbUV+V/DrnvoipW
	GHRvaNs4f0vv70kTb2dN8IrzKPr/9v5shusTVjzv6H3Ta/XfI3je7n0Cmq/r9nTNv1fNeFph
	z447yZtjwtZdMNjUJXNB+/mFE0zr4ve/fLjDYYHaM9tuDd5lfldt2l0vvsx7WJTSt+Ro2vHL
	5nvnSaxcXiQdYG7FVD9p3r9sFRM5S64zLrPtePuM3OMOJZmLeAXvaOR8PG2BX/nZ6A2860uX
	3Pd/LrlfiaU4I9FQi7moOBEAaCGCdiIDAAA=
X-CMS-MailID: 20241114105354epcas5p49a73947c3d37be4189023f66fb7ba413
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241114105354epcas5p49a73947c3d37be4189023f66fb7ba413
References: <20241114104517.51726-1-anuj20.g@samsung.com>
	<CGME20241114105354epcas5p49a73947c3d37be4189023f66fb7ba413@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_032047_438298_D2AC713A 
X-CRM114-Status: GOOD (  16.48  )
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

From: Christoph Hellwig <hch@lst.de>

Copy back the bounce buffer to user-space in entirety when the parent
bio completes. The existing code uses bip_iter.bi_size for sizing the
copy, which can be modified. So move away from that and fetch it from
the vector passed to the block layer. While at it, switch to using
better variable names.

Fixes: 492c5d455969f ("block: bio-integrity: directly map user buffers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a448a25d13de..4341b0d4efa1 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -118,17 +118,18 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
-	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
-	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
-	struct iov_iter iter;
+	unsigned short orig_nr_vecs = bip->bip_max_vcnt - 1;
+	struct bio_vec *orig_bvecs = &bip->bip_vec[1];
+	struct bio_vec *bounce_bvec = &bip->bip_vec[0];
+	size_t bytes = bounce_bvec->bv_len;
+	struct iov_iter orig_iter;
 	int ret;
 
-	iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
-	ret = copy_to_iter(bvec_virt(bip->bip_vec), bytes, &iter);
+	iov_iter_bvec(&orig_iter, ITER_DEST, orig_bvecs, orig_nr_vecs, bytes);
+	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
 	WARN_ON_ONCE(ret != bytes);
 
-	bio_integrity_unpin_bvec(copy, nr_vecs, true);
+	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs, true);
 }
 
 /**
-- 
2.25.1


