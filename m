Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ACDC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zU7PuiJ1KZ8+CVYUOg4nHq63Q9/stHoIw4yuqAbJgE=; b=ndkI1u4HHKc4I78SiUM0mkhPHT
	5urNe2Sou8InfGTwriwSe91nwHWK4YrkhuxeDOM6fCFf+fGsm3FK52Kh1snUph/lws8g1OzLS1r5V
	eZL/AGDw8gKJE7f/V2gsvl7FsgPt+oc7PJaHZVImgshnlD9KDtqc11K3U7jlTa1SxkdFCarwW/27F
	92G91RoBsiZY29cN+hrku6wM24B1Pfxhf1c2iuNIIVshKUff+RfuzIGj18q+1ONAcEVKIQrBBFxsK
	lnPbC/iUnhUGi4qcGulRuWGNWnnfPgIa6GiaZaVU6ITUnpVleA71xr/WJKYaREFNJWF7q7M6gwotg
	cdrNIfHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o711V-001Tou-Hx; Thu, 30 Jun 2022 20:44:25 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7102-001T4t-On
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:56 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UF76BU021139
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/zU7PuiJ1KZ8+CVYUOg4nHq63Q9/stHoIw4yuqAbJgE=;
 b=GzX0fwCPvDst6W+MHhoP5cIyjQQ42Dt5FWXyLp14pumO7yb0Nma1gx6jEa/eaHQ2Aeon
 3OuFSazJgTp3++dJT0uTfzpFU3iY8c8nDeGC7eFGE+Di05ZXI6Aa+R+DD92RGfCMDWcd
 fsQStzlV/7l0E5m6TmbITyy3qRo1QuyBrUw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0dgqwy2u-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:53 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:52 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D79595932DBF; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 07/12] block: allow copying pre-registered bvecs
Date: Thu, 30 Jun 2022 13:42:07 -0700
Message-ID: <20220630204212.1265638-8-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tNDZHerWrwOaZdgQR38s51ELBqv9uEZH
X-Proofpoint-GUID: tNDZHerWrwOaZdgQR38s51ELBqv9uEZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134254_985618_62D8F3B5 
X-CRM114-Status: GOOD (  14.96  )
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

If a bio was initialized with bi_max_vecs, then append the requested
bvec instead of overriding it. This will allow mixing bvecs from
multiple sources.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b0c85778257a..391cad726ff2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1130,12 +1130,25 @@ void __bio_release_pages(struct bio *bio, bool ma=
rk_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
=20
+static void bio_copy_bvec(struct bio *bio, struct iov_iter *iter)
+{
+	memcpy(&bio->bi_io_vec[bio->bi_vcnt], iter->bvec,
+	       iter->nr_segs * sizeof(struct bio_vec));
+	bio->bi_vcnt +=3D iter->nr_segs;
+	bio->bi_iter.bi_size +=3D iov_iter_count(iter);
+}
+
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	size_t size =3D iov_iter_count(iter);
=20
 	WARN_ON_ONCE(bio->bi_max_vecs);
=20
+	if (bio->bi_max_vecs) {
+		bio_copy_bvec(bio, iter);
+		return;
+	}
+
 	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
 		struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 		size_t max_sectors =3D queue_max_zone_append_sectors(q);
--=20
2.30.2


