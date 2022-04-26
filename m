Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E912C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5UBtS0ms0IOiJds1Mb3s7CJgKX4t4CEpR6CiZcgXT4k=; b=q4e9yhI8Mtgn+46avLuXpDlenV
	Gj77BQW9O8HTo82BwQLAUXNzVfF/PUrvhbkfcIbCXLe0XV5P9v2sLOdkPinK6T9YOzNeaupwyai1a
	9GVMHPnUER9qrmyDjxlKHdABAb3iAyn03XCwfunfUlH4s8C1auh/n00W47J4NACC4D7BDP8gZm04f
	CeU1Woj1zl+KeYGDaN9q34C6UTZ43cOYMnr8MccyEkbTYCG5wRKFdgFQi+ZgC9LFufmSptXZ1FBjh
	TZOdTb1clPzQoEn5IpK2Xf2hw5EozXQhW+TMTxGBiw0ZKU6ti0iMg+FudJ6IxP1NhLuGKnEacgKzy
	KA0wR/bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njKSr-00EILG-K9; Tue, 26 Apr 2022 12:38:45 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njK64-00ECYp-9E
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 12:15:14 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220426121509epoutp03683a4ab48b63f19af30f75532c893003~pcUwFM7631718017180epoutp03b;
 Tue, 26 Apr 2022 12:15:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220426121509epoutp03683a4ab48b63f19af30f75532c893003~pcUwFM7631718017180epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1650975309;
 bh=5UBtS0ms0IOiJds1Mb3s7CJgKX4t4CEpR6CiZcgXT4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O7TeS6sq8Oci60wRSJ7qFAkjawn4FheY56CIaaIzBg3HtgNMFPCL9UjGSbPBhV/eE
 SSi2HvTZOMK6g8miqJzN3/7Nc19EioG0vsXUYSP4xAgNSb8kJs3EddN6bWfkIFyH8i
 F7eYYXD6lFEhUWOulU6S1S7vHNW+e2HOtu3eG0Eo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220426121509epcas5p10681d041cb3a2dab2d7e9fac1d620772~pcUvv6drF2178321783epcas5p1r;
 Tue, 26 Apr 2022 12:15:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Kngn54tQ5z4x9Ps; Tue, 26 Apr
 2022 12:15:05 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A1.23.10063.942E7626; Tue, 26 Apr 2022 21:15:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220426101951epcas5p1f53a2120010607354dc29bf8331f6af8~pawFTa_Zl2413724137epcas5p1G;
 Tue, 26 Apr 2022 10:19:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220426101951epsmtrp176ced2e9b9a9f969fd96eb3b8dc05e12~pawFSMys82263822638epsmtrp1b;
 Tue, 26 Apr 2022 10:19:51 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-b7-6267e24970f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.AA.08924.747C7626; Tue, 26 Apr 2022 19:19:51 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
 [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220426101946epsmtip14d82f1c02263c9ee984eda8ecb45bbfd~pawAJsemo3271432714epsmtip1a;
 Tue, 26 Apr 2022 10:19:46 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: 
Cc: chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh Shetty
 <nj.shetty@samsung.com>, Vincent Fu <vincent.fu@samsung.com>, Arnav Dawn
 <arnav.dawn@samsung.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
 <snitzer@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, James Smart
 <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, Damien Le
 Moal <damien.lemoal@opensource.wdc.com>, Naohiro Aota
 <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/10] block: add emulation for copy
Date: Tue, 26 Apr 2022 15:42:32 +0530
Message-Id: <20220426101241.30100-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1RTZRg+3713dxun0RUhP/AQ8yLVQIUpG58oVEfqXJUKtXM6BzvglNuG
 jG3thwoeE0RQEViAPycJBOgRUhIFBtuM8BCKTtMJISYoIiUUCFpEYsQYlv893/O+z/P++M7L
 wz06uD68RJWe1apkSpp0I+ouigIXruyVbwz5+ao/qm77AUfW2084qOqukUSHHo/jaPj7BxxU
 YDzCRc/s13Hk6HNHtqFjHPTjX+kYelAziaHbTQ0Ysn5dgKFTVS0Y+uVkGUCW0hEMTdwXo/tP
 uwhU0NwB0MN2E4ZsXUHIartMIEdjEYmKTzzkov0/mUl0YdCGo5Ot/2DommmCRPmt5zjI3JcO
 UN2zYhxd7G4n0JnBYQJd6pqLMnPGuejB/r0AXX/eynkngHHcWs2Yeuwkk58xxGUaTHe5zPXu
 swTjsBuYmsp9JHOufCdT2HkSMJbbaSSz62oLzhwZfUoyuRlDJNOQ2cNhRh52EczwhXYyZk5s
 0nIFK0tgtUJWtUmdkKiSR9Cr18WviJdIQ8QLxUtRGC1UyZLZCDoqOmbh+4nKqW3Swi0ypWGK
 ipHpdHRw5HKt2qBnhQq1Th9Bs5oEpSZUs0gnS9YZVPJFKlYfLg4JWSyZStyQpGjKcABN2eJt
 eeM5RBqwv5UN+DxIhcLDtyqwbODG86AsAP79Ry/X9RgFcLz90EzkCYClWVXgheT3iwdIJ/ag
 GgGssPNdOBODZTf8swGPR1JB8Mokz0l7UgQ8NTZGOH1w6iAPHmitJ5yB2VQY/LO4aNqHoAKg
 dVfFNBZQ4XAibwg4fSAVDI09s5w0n1oGK1qGMFfKLHj5aN+0DU75wYzaY7jTH1JZbtCWe5hw
 9RkFe0sHSReeDQdaz3Nd2Ac+MmbN4K2wPqsEc4l3A5jd1jYjfhvesD7HnE3glAhWNwa7aF94
 sO0M5irsDnOf9WEuXgDNx19gf/hNdclMXW/YMZY+gxlYbDVzXAvNAzC9cx/3SyA0vTSQ6aWB
 TP+XLgF4JfBmNbpkOauTaMQqdut/n7xJnVwDpg8scKUZ3L33eFEzwHigGUAeTnsKDgZ8ttFD
 kCBLSWW16nitQcnqmoFkauH5uI/XJvXUhar08eLQpSGhUqk0dOkSqZieI7gi/1bmQcllejaJ
 ZTWs9oUO4/F90jCvxO/Cl0v2ONJwr09uJirv4YrNkQcqPduKrn0Vm3DeQu4oV9ypu//K7gb3
 Eyew3RXtonePn51rqxcGfT4/c9Dead2xwxAn1G1PWUvVxjbtzJ9Xzw3QfiFfmx9m9p/P1b/X
 4OcebRk4vmT01aTyvn7vkc30aRFpNEZExN4c8E3xHo1qWfXxmg+3+HHknoUbLYplY9Lq2l/t
 67ah4aCkD0p6RdvfTI2eVEQXi4R8fmRgv9caep7v86iRTz1TuzPnDxf1C0ciOxLClhh69m54
 bdVvqQuso471h/pzq1tOvx78KO5OdyHZFJfTuHXlJYmgU+ReUL/gKE+2Z5L2e2POepOkr8P8
 EU3oFDJxIK7Vyf4Ft6O9FOkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxzG/d1dr0cjy1FM+NUa7bqQzIq8ONFvQAnL/tglWxxGzSIxumPc
 QKSlaaky4xDpWKSAUIYMCwYFhQCJZlAIL0WklSG6WpOujJdgRwCNcRaZL0io6E63xP8+eT5P
 nr8ehpSXSNYyh3W5gkHHZ6tpGdXlUq/f/PlwRlps6dmNcPXWbyQ4xp9KoG2qnIbqJ0skzA/O
 SKCyvEYKy24PCd7ZD6A/UCuBuy9PETDT/pqA8es9BDgaKgloaRsi4EFzI4K+iwsEBKfjYPrZ
 BAWVzlEEcz4bAf0Tm8DRP0KBt7eOhvqmOSmU/NlNw7VH/SQ0D68QcMcWpME63CGB7tlTCLqW
 60lw3fNRcOXRPAU3J5RQVLokhZmS0wg8r4YlyZGc948vOJvfTXNWc0DK9dimpJzn3q8U53Wb
 uPbWYprruHSS+3msGXF94wU0V/j7EMnV/POM5srMAZrrKfJLuIW5CYqbv+ajUyJSZTvShezD
 RwVDTNI3sszrZi/SN27JO7NUShUg98cWFMJgdit+7KqiLUjGyNluhItamsl3QoGbXt34j8Nx
 y8oDqchy1kzgpuBWC2IYmt2Eb79mxHgNS+GWxUVK3CHZAQY7bhYToghnt+MX9XW0yBQbiR2F
 l99yKJuAg2cCSNzBbAwu94eJcQibiC8PBQgxlv9bGVvOe9cOwyPnZimRSXYDNnfWkhWItb2n
 bO+pC4hoRQpBb9RmaI1x+i064Vi0kdcaTbqM6G9ztO3o7V80mm7kaH0S7UQEg5wIM6R6TejZ
 yO/S5KHp/PfHBUPOIYMpWzA6kZKh1BGhdy0jh+RsBp8rHBEEvWD43xJMyNoCAu2632vha08c
 WK1bHiVN6/zFF/et4ruCyQ/z3UHVbD5fVT2w35ISk6ANuBaHYiPy0ajyljNs5srKCO8mWeV6
 3x3Vvpf37ZMxCfFPVccr1A1l7ZeCxaYNdQN79qu0zMLVlR9zv6KmCzMHlSdPZ50IV7TRhR/2
 tX1q3Ru365y9cXGbmU70dGzWa2TqnRFWpvq8IeqjRIW90fvQqvgpberA9JFO6su/f/hk3V/J
 ma4b0Vm1is7Y3p0enPXcQ9YnaiZTD5p/2QP687vjU5VNDb4QiWEM2UuPqmR5g7ejNA3uVZMV
 9tx4qqpm+2NrUk7O1/OfpQf9SVGr3WUpNeXpUjVlzOTjNKTByL8BBqQOep4DAAA=
X-CMS-MailID: 20220426101951epcas5p1f53a2120010607354dc29bf8331f6af8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101951epcas5p1f53a2120010607354dc29bf8331f6af8
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101951epcas5p1f53a2120010607354dc29bf8331f6af8@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_051512_739503_CC9B6F5C 
X-CRM114-Status: GOOD (  26.30  )
X-Mailman-Approved-At: Tue, 26 Apr 2022 05:38:22 -0700
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

For the devices which does not support copy, copy emulation is
added. Copy-emulation is implemented by reading from source ranges
into memory and writing to the corresponding destination synchronously.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 block/blk-lib.c        | 128 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-map.c        |   2 +-
 include/linux/blkdev.h |   2 +
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index ba9da2d2f429..58c30a42ea44 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -273,6 +273,65 @@ int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
 	return cio_await_completion(cio);
 }
 
+int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
+				sector_t sector, unsigned int op, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio, *parent = NULL;
+	sector_t max_hw_len = min_t(unsigned int, queue_max_hw_sectors(q),
+			queue_max_segments(q) << (PAGE_SHIFT - SECTOR_SHIFT)) << SECTOR_SHIFT;
+	sector_t len, remaining;
+	int ret;
+
+	for (remaining = buf_len; remaining > 0; remaining -= len) {
+		len = min_t(int, max_hw_len, remaining);
+retry:
+		bio = bio_map_kern(q, buf, len, gfp_mask);
+		if (IS_ERR(bio)) {
+			len >>= 1;
+			if (len)
+				goto retry;
+			return PTR_ERR(bio);
+		}
+
+		bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
+		bio->bi_opf = op;
+		bio_set_dev(bio, bdev);
+		bio->bi_end_io = NULL;
+		bio->bi_private = NULL;
+
+		if (parent) {
+			bio_chain(parent, bio);
+			submit_bio(parent);
+		}
+		parent = bio;
+		sector += len;
+		buf = (char *) buf + len;
+	}
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+
+	return ret;
+}
+
+static void *blk_alloc_buf(sector_t req_size, sector_t *alloc_size, gfp_t gfp_mask)
+{
+	int min_size = PAGE_SIZE;
+	void *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp_mask);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		/* retry half the requested size */
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
 static inline int blk_copy_sanity_check(struct block_device *src_bdev,
 		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
 {
@@ -298,6 +357,68 @@ static inline int blk_copy_sanity_check(struct block_device *src_bdev,
 	return 0;
 }
 
+/* returns the total copy length still need to be copied */
+static inline sector_t blk_copy_max_range(struct range_entry *rlist, int nr, sector_t *max_len)
+{
+	int i;
+	sector_t len = 0;
+
+	*max_len = 0;
+	for (i = 0; i < nr; i++) {
+		*max_len = max(*max_len, rlist[i].len - rlist[i].comp_len);
+		len += (rlist[i].len - rlist[i].comp_len);
+	}
+
+	return len;
+}
+
+/*
+ * If native copy offload feature is absent, this function tries to emulate,
+ * by copying data from source to a temporary buffer and from buffer to
+ * destination device.
+ */
+static int blk_copy_emulate(struct block_device *src_bdev, int nr,
+		struct range_entry *rlist, struct block_device *dest_bdev, gfp_t gfp_mask)
+{
+	void *buf = NULL;
+	int ret, nr_i = 0;
+	sector_t src, dst, copy_len, buf_len, read_len, copied_len,
+		 max_len = 0, remaining = 0, offset = 0;
+
+	copy_len = blk_copy_max_range(rlist, nr, &max_len);
+	buf = blk_alloc_buf(max_len, &buf_len, gfp_mask);
+	if (!buf)
+		return -ENOMEM;
+
+	for (copied_len = 0; copied_len < copy_len; copied_len += read_len) {
+		if (!remaining) {
+			offset = rlist[nr_i].comp_len;
+			src = rlist[nr_i].src + offset;
+			dst = rlist[nr_i].dst + offset;
+			remaining = rlist[nr_i++].len - offset;
+		}
+
+		read_len = min_t(sector_t, remaining, buf_len);
+		if (!read_len)
+			continue;
+		ret = blk_submit_rw_buf(src_bdev, buf, read_len, src, REQ_OP_READ, gfp_mask);
+		if (ret)
+			goto out;
+		src += read_len;
+		remaining -= read_len;
+		ret = blk_submit_rw_buf(dest_bdev, buf, read_len, dst, REQ_OP_WRITE,
+				gfp_mask);
+		if (ret)
+			goto out;
+		else
+			rlist[nr_i - 1].comp_len += read_len;
+		dst += read_len;
+	}
+out:
+	kvfree(buf);
+	return ret;
+}
+
 static inline bool blk_check_copy_offload(struct request_queue *src_q,
 		struct request_queue *dest_q)
 {
@@ -325,6 +446,7 @@ int blkdev_issue_copy(struct block_device *src_bdev, int nr,
 	struct request_queue *src_q = bdev_get_queue(src_bdev);
 	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
 	int ret = -EINVAL;
+	bool offload = false;
 
 	if (!src_q || !dest_q)
 		return -ENXIO;
@@ -342,9 +464,13 @@ int blkdev_issue_copy(struct block_device *src_bdev, int nr,
 	if (ret)
 		return ret;
 
-	if (blk_check_copy_offload(src_q, dest_q))
+	offload = blk_check_copy_offload(src_q, dest_q);
+	if (offload)
 		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
 
+	if (ret || !offload)
+		ret = blk_copy_emulate(src_bdev, nr, rlist, dest_bdev, gfp_mask);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_issue_copy);
diff --git a/block/blk-map.c b/block/blk-map.c
index 7ffde64f9019..ca2ad2c21f42 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -340,7 +340,7 @@ static void bio_map_kern_endio(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(struct request_queue *q, void *data,
+struct bio *bio_map_kern(struct request_queue *q, void *data,
 		unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c6cb3fe82ba2..ea1f3c8f8dad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1121,6 +1121,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+		gfp_t gfp_mask);
 int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
 		struct range_entry *src_rlist, struct block_device *dest_bdev, gfp_t gfp_mask);
 
-- 
2.35.1.500.gb896f729e2


