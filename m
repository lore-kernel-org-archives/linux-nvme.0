Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398B1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dB8+MrD5O9wi0ghEOijaYM33MpOL8F3wv6twB5MDRiQ=; b=uFpgCHJbUKGfPI+c8dgOoLNeGv
	VEhC3nLcTqh2Syy5A+E5z6rXy6eP3uxgAfB+uhop5d/MR173yE3pg8SSTqtWc7CQ+v0leNpgYVd0E
	Y+jFZE4V/IyUqDYBqe2ZyWth4dR+U1GUgS4cGXIMGVj1O8uBMcCoPCjZoor9/v8/3veA5IusMqlnR
	PmZfT8gIpb4qaX99ouE6pvgygU2kxPd1DQBlep6i7oQrIaqVBFBSDV12s9Sq+RseB8YNzTZCrTHLC
	f72S4PVE2eAkmYJ6NoF1nFkA+B8eAoLcwoYez9upKXHp/1PKGGjWn247vAN+3YeGbxC/Ts+wPh1qN
	uhcuG6PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njPuQ-00FiEW-6S; Tue, 26 Apr 2022 18:27:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPoo-00FfZL-UL
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:21:50 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGQaid011703
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dB8+MrD5O9wi0ghEOijaYM33MpOL8F3wv6twB5MDRiQ=;
 b=JiHDFo8Q33K0l/J9VLk/8PkW5n4BiCwFYgs6SAwNP1rPDWUi6E0Gi6uD/gbApCRJvCzp
 1/EfmRD2gNW6bWLR3INIbIOgxgNyJSy3fyoLvso12v2I/sKTZfkMQmdczQ3+1JY8Uj1c
 HUCqHcRHNiSVGCK2mjNXtCf2Nc4drT+Xkso= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmeyu3yk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:43 -0700
Received: from twshared6486.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:21:42 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 4FBB9E2E5692; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 03/12] io_uring: change ring size calculation for CQE32
Date: Tue, 26 Apr 2022 11:21:25 -0700
Message-ID: <20220426182134.136504-4-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: x0sn5fWDG3GugUZjc9nqcxNE7IaYd4AQ
X-Proofpoint-ORIG-GUID: x0sn5fWDG3GugUZjc9nqcxNE7IaYd4AQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112147_131302_65D1B872 
X-CRM114-Status: GOOD (  16.62  )
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

This changes the function rings_size to take large CQE's into account.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/io_uring.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bf2b02518332..9712483d3a17 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9693,8 +9693,8 @@ static void *io_mem_alloc(size_t size)
 	return (void *) __get_free_pages(gfp, get_order(size));
 }
=20
-static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries=
,
-				size_t *sq_offset)
+static unsigned long rings_size(struct io_ring_ctx *ctx, unsigned int sq=
_entries,
+				unsigned int cq_entries, size_t *sq_offset)
 {
 	struct io_rings *rings;
 	size_t off, sq_array_size;
@@ -9702,6 +9702,10 @@ static unsigned long rings_size(unsigned sq_entrie=
s, unsigned cq_entries,
 	off =3D struct_size(rings, cqes, cq_entries);
 	if (off =3D=3D SIZE_MAX)
 		return SIZE_MAX;
+	if (ctx->flags & IORING_SETUP_CQE32) {
+		if (check_shl_overflow(off, 1, &off))
+			return SIZE_MAX;
+	}
=20
 #ifdef CONFIG_SMP
 	off =3D ALIGN(off, SMP_CACHE_BYTES);
@@ -11365,7 +11369,7 @@ static __cold int io_allocate_scq_urings(struct i=
o_ring_ctx *ctx,
 	ctx->sq_entries =3D p->sq_entries;
 	ctx->cq_entries =3D p->cq_entries;
=20
-	size =3D rings_size(p->sq_entries, p->cq_entries, &sq_array_offset);
+	size =3D rings_size(ctx, p->sq_entries, p->cq_entries, &sq_array_offset=
);
 	if (size =3D=3D SIZE_MAX)
 		return -EOVERFLOW;
=20
--=20
2.30.2


