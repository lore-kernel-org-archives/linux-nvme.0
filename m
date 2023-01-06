Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E53C3DA7A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLRJd/g9zW/ZTmb/70CCbE3iGbRVLutU6c9iT4cK22Q=; b=xxxGPqXn7gej6FwCSKrTsQTmpg
	L4VpmD3DSLL8zo52jYxUnROXbfoS5BPcep2omsuOLxjXbGBoI+hx7TO60RVXGS2uvZGMG2P8oYX09
	V3q12kL8OgqIhEsSz7oELrcNUlfst3MuB7/HMHX+y8+26l0KpKpAssv4oplLk1+1IfhCb0YOVpcK8
	1RjiC6Ocy8xgOliYPsAlUb7j07/uQGRrPyZsbyKciWXoXqoy6RaVSbHxW9TEUP0GH8BwFVqpG+AXT
	tSef6kZSPHdHPiffsum218svOUg0uEpoU7BIbkp/VjDxGAFNYtsftJqqjTPZgaq5/o1LAWNH/9K21
	HPcDNa2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDiBA-006eTT-K4; Fri, 06 Jan 2023 08:34:20 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDiAP-006e01-Bf
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 08:33:35 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083324euoutp01f4daed00148afdbd53d9017ba36c1be9~3qy7qEkMw1990819908euoutp01G
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 08:33:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083324euoutp01f4daed00148afdbd53d9017ba36c1be9~3qy7qEkMw1990819908euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1672994004;
	bh=VLRJd/g9zW/ZTmb/70CCbE3iGbRVLutU6c9iT4cK22Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9qafOCdbAJ7L0vtSLa2LQ7W3Ukf2Hi+mHXzG7ZYz4Zc6SaL+IoF9oAdgS3uWatzn
	 wiTMdjuJDgocD81JFFpBD6i49C8UtM6WvLYWnpdHht8RBh8VhG9Hub9Gd3+HHNVHoB
	 qkmzEGjGTTCTzsTLLScTOabHi33N1OpJxrWaEItY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230106083323eucas1p1a65f5682e8176e747042a06939916e1c~3qy6Zaafa1079910799eucas1p1N;
	Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 50.A3.56180.3DCD7B36; Fri,  6
	Jan 2023 08:33:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338~3qy6AgovI1079910799eucas1p1M;
	Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230106083322eusmtrp2ce6bf037b828e56c769e14ab7c11768d~3qy5-wgci1128211282eusmtrp2E;
	Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-a2-63b7dcd32d2f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.AB.52424.2DCD7B36; Fri,  6
	Jan 2023 08:33:22 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230106083322eusmtip1c280cca29120352af56f70ae80405570~3qy50uWRv0965409654eusmtip1b;
	Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
	bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
	damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com, Pankaj Raghav
	<p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, Johannes
	Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 6/7] dm-zone: use generic helpers to calculate offset from
 zone start
Date: Fri,  6 Jan 2023 09:33:16 +0100
Message-Id: <20230106083317.93938-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7qX72xPNvjwidNi9d1+NotpH34y
	W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLP523WOyOPPyM4vF3lvaFpd3zWGzmL/sKbvF
	jQlPGS0+L21htzhxS9qB3+PyFW+Py2dLPTat6mTz2Lyk3mP3zQY2j52t91k9zq509Hi/7yqb
	R9+WVYwem09Xe3zeJOfRfqCbKYAnissmJTUnsyy1SN8ugSvj+ZFnTAUTeSquzl7H2sDYzdXF
	yMkhIWAicf9FO1sXIxeHkMAKRoln656zQzhfGCX6ll1ihHA+M0o03ZvIBNPyqfs4E0RiOaNE
	Q89CKOcFo8Sjf5OB+jk42AS0JBo72UEaRASEJfZ3tLKA1DAL9DBLvF/wgxkkISwQLnF7xxYW
	EJtFQFVixsyTrCA2r4ClxK1pk5ghtslLzLz0HWwQp4CVxPPpa5ggagQlTs58AtbLDFTTvHU2
	VP1iTolJTZ4QtovE092PWSBsYYlXx7ewQ9gyEv93zof6plri6Y3fzCDHSQi0MEr071zPBvKA
	hIC1RN+ZHBCTWUBTYv0ufYioo8SSbeUQJp/EjbeCEAfwSUzaNp0ZIswr0dEmBDFbSWLnzydQ
	OyUkLjfNgbrFQ2Lb1FfsExgVZyF5ZRaSV2YhrF3AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9d
	Lzk/dxMjMN2d/nf80w7Gua8+6h1iZOJgPMQowcGsJMJb1r8tWYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjjvjK3zk4UE0hNLUrNTUwtSi2CyTBycUg1MCtdCDr/O2nvFKniZUEbj/aKtKUV99Te2
	xrydHFDNGtVtOqvroCZrYzmP9xl+m/xV0zaKnt8ZJKZUqtb+UDwuV0frSSb755N2Jd/sr2cy
	ya/+YGC3JnLv/dNr3z36XPEqO+3frlfZixY+2HrDYm1n4fEHdzf8f+fwIIuTY+eOWpYIu8uH
	QuRbjh6qf75sRunk/bapsY8abuz4+OXtP7+I0OcvTs58s+34LKZCpWdsb6P+vzq1qlkm0siy
	+8LRORyzN2+o+XfHqPvvk8JQD1f97U+Wfldiy/Py2yj7+tsf+4Wqtvsf8uc6RglGnrowMfzs
	k5Xb1TS8RO7/+FnT/0Lz+mINwfdp3GrMOrGZu/38OpVYijMSDbWYi4oTAV+xnYXmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7qX7mxPNrixWtdi9d1+NotpH34y
	W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLP523WOyOPPyM4vF3lvaFpd3zWGzmL/sKbvF
	jQlPGS0+L21htzhxS9qB3+PyFW+Py2dLPTat6mTz2Lyk3mP3zQY2j52t91k9zq509Hi/7yqb
	R9+WVYwem09Xe3zeJOfRfqCbKYAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbK
	yFRJ384mJTUnsyy1SN8uQS/j+ZFnTAUTeSquzl7H2sDYzdXFyMkhIWAi8an7OFMXIxeHkMBS
	RomLd2azQyQkJG4vbGKEsIUl/lzrYgOxhQSeMUos2ZPWxcjBwSagJdHYCVYuAlSyv6OVBWQO
	s8AcZomp66axgCSEBUIlDrz9DTaHRUBVYsbMk6wgNq+ApcStaZOYIebLS8y89B1sEKeAlcTz
	6WuYIHZZSnR87GWDqBeUODnzCdhMZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5x
	Ym5xaV66XnJ+7iZGYGxuO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMJb1r8tWYg3JbGyKrUoP76o
	NCe1+BCjKdDdE5mlRJPzgckhryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQim
	j4mDU6qBSXBea9OfVXM/ll56GbnRkEfp2+Vqr6VvhGQmTnwxN0e91m5x5mK5xbcFbD4uOmfH
	dX3OW182RuHV8ZPu8iTIbLE8ztXyVayoW+7Jnw8/HnEnC686cTq09r1G9dLY/rqHNhu1u1TW
	Ve+P5lF6sPL5kuuPA0vK1z2aukTymn3mw/gbuvfbeXZxv4/QtTpifefdK91IcYPAaduW9vp9
	EuFY4eLdL7z7SNieFfMNuaTfP9nyyjjI7cyee+f5btRE2ul9cT0qeolb/J8716tzbmvvB680
	/HhlWwxzfuAOsf+9at+uzWaTcPMR+X9yi5rV5ccrr4b0shRd+MagoGX5psXj64PEyF6e25Wl
	yxpmf/j25ZISS3FGoqEWc1FxIgBd2zqqVgMAAA==
X-CMS-MailID: 20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338
References: <20230106083317.93938-1-p.raghav@samsung.com>
	<CGME20230106083322eucas1p1ce3ca7b02ca87bb2be8543291e223338@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_003333_956366_C4D74E42 
X-CRM114-Status: GOOD (  14.36  )
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

Use the bdev_offset_from_zone_start() helper function to calculate
the offset from zone start instead of open coding.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-zone.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..ac6fc1293d41 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if (bdev_offset_from_zone_start(md->disk->part0,
+						clone->bi_iter.bi_sector) != zwp_offset)
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -602,11 +603,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask =
-				(sector_t)bdev_zone_sectors(disk->part0) - 1;
-
 			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
+				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
 		}
 
 		return;
-- 
2.25.1


