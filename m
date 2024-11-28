Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E906D690FF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r23oSTZl50mKsH838ytL5lDlNxkmkMYy4oR7U1Ruz2Y=; b=UTjTh/+M7k2QPCDq39OFVp01/X
	XcEzVrf3g3CiHeRlB4Ck6xsQcwn36Gc3dDZ/YLGvmXJRJQgDYTIqnaZwpHQTvmhomBtGRkpOK9Ebg
	NM7NoBmKVieO31JmEhECxTNqYbiP/Aa+WA8gZd6PL9U9/uyGEj7fIjQuXJv8vtTLjo3TrURvzwAnH
	4n7Nxc0bDjHLskkpEC3Nni6AH/jXbdFUIYaRzlW4Z5q6Bamu2vn/iErCHhAaS++TgCbgBrjTOcvMy
	JJPfOgBpvr4yMSfH2kc1pOhNVK7KSW39IYWH5zDNr2ZkWO1XtptHY4NWJtzO/EcSkvGNtb/sUEPGM
	8O3NqCpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyL-0000000FO0W-1uiL;
	Thu, 28 Nov 2024 11:46:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyK-0000000FNzd-0jRE
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Nov 2024 11:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=r23oSTZl50mKsH838ytL5lDlNxkmkMYy4oR7U1Ruz2Y=; b=MUhgxz4BCo8wuRUY2QGxWDYw1x
	ktWfmdcF+T+WLoexfH0ZqkRK7ktWASnJkjE8gBRZgGyz4TpRIDLU0K+vUf5G5WpmSTsJG9Ohllbpk
	6fTp+W8biMhtoKzGY5+tJgnPw83PVusHLjZsAWw0P74J7/9MJ0pGlPz6wKmn1Km5dGWDZTxIc06Dd
	DHE1bkRG6j4SC5q0XE4TqDBXlUVMN6ZvGJGH96DBl4PaU/qUfs4FYp80D5vIEm5OvqHIBvwnY5Xyg
	GIccrhHHQX4b2BvhCqytecSgJMLqPu4bCDcq03BplKMmN8X81n+QfhLRCMWvdEWBaplb8U0uV/dpj
	9Z8dc+Sg==;
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyG-00000001awy-0jWA
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 11:46:11 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241128114600epoutp022fea31dda5579983feb8d54322bc8e95~MH0o95Efy1279912799epoutp02E
	for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2024 11:46:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241128114600epoutp022fea31dda5579983feb8d54322bc8e95~MH0o95Efy1279912799epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732794360;
	bh=r23oSTZl50mKsH838ytL5lDlNxkmkMYy4oR7U1Ruz2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2unj1ShZtgvlk2yRO3idObv1vytSo5DVSiniR/4MNoGEBz4drzVLN8SJAzjiUerv
	 rSF1W7R9Lh+xKqCYVFcxBmFME/oZga+nJIfzlHtfy4wqgBBEvpQgbZN+y33FNYIrwm
	 x4IKDB0m0AqN/CxB/wFUPEihRz2atHUKDOPyWQzI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241128114559epcas5p4de7b1ade7af45ae9ef8be4d17549089f~MH0oL_Y7l1496914969epcas5p4W;
	Thu, 28 Nov 2024 11:45:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XzZJP6Fj4z4x9Pp; Thu, 28 Nov
	2024 11:45:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.6F.20052.5F758476; Thu, 28 Nov 2024 20:45:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241128113101epcas5p3fefab67892c16c7bbaba8063c5c4a2c1~MHnjpWL2V2753027530epcas5p3_;
	Thu, 28 Nov 2024 11:31:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241128113101epsmtrp22eed36114a530ac46f9ef1b852596c9f~MHnjoKm1w0053700537epsmtrp2k;
	Thu, 28 Nov 2024 11:31:01 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-79-674857f59385
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.4E.18949.57458476; Thu, 28 Nov 2024 20:31:01 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241128113058epsmtip24543a12bd1e65a89a01572043324f0af~MHnhO3wlj2509525095epsmtip2V;
	Thu, 28 Nov 2024 11:30:58 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v11 03/10] block: modify bio_integrity_map_user to accept
 iov_iter as argument
Date: Thu, 28 Nov 2024 16:52:33 +0530
Message-Id: <20241128112240.8867-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128112240.8867-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmlu7XcI90gycbDS0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBZH/79ls5h06Bqjxd5b2hZ7
	9p5ksZi/7Cm7Rff1HWwWy4//Y7I4//c4q8X5WXPYHYQ8ds66y+5x+Wypx6ZVnWwem5fUe+y+
	2cDm8fHpLRaPvi2rGD3OLDjC7vF5k5zHpidvmQK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od
	403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4B+UlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fY
	KqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZzx98ZmpYI9cxe7LHg2M2yS7GDk5JARM
	JG5N2MLUxcjFISSwm1Fi3oxNbBDOJ0aJmS9vMEM43xglzr78xwbTMvfoUqjEXkaJ5iO3oPo/
	M0ocXPofrIpNQF3iyPNWRpCEiMAeRonehadZQBxmgQlMEu0T57CDVAkLJEjM6lnMDGKzCKhK
	nDn/iwXE5hWwkNhx4wQrxD55iZmXvoPVcwpYSsy+9o0VokZQ4uTMJ2D1zEA1zVtng90kIXCD
	Q2Lryw52iGYXiQkz1rNA2MISr45vgYpLSXx+txfqoXSJH5efMkHYBRLNx/YxQtj2Eq2n+oGG
	cgAt0JRYv0sfIiwrMfXUOiaIvXwSvb+fQLXySuyYB2MrSbSvnANlS0jsPdfABDJGQsBD4nS/
	FSS0eoChdfw88wRGhVlI3pmF5J1ZCJsXMDKvYpRMLSjOTU8tNi0wzEsth0dzcn7uJkZwQtfy
	3MF498EHvUOMTByMhxglOJiVRHgLuN3ThXhTEiurUovy44tKc1KLDzGaAsN7IrOUaHI+MKfk
	lcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXAtHMaE4+yxIQfjheF
	LFUOJ286/JUz8uEtPx9dqUvXq/oDbC7XnL2t8qa0PH2R3KXMlblq8vmKbq3cz/ryC653drQy
	WirWeFe++Ns97fGut+ftuO9/MM/OaQjU2GNqo+HPUtXz3jfPL/7vxDviJXr+6qtlNl6KZvJb
	FzR3d03UtuJUuQbhs9MTp39/98KXoe7FgX8da+ryb9y+mdw6L55l/Z4FZoIKT2atO9B5mW9h
	5zSuuaerjHmcnfrcKzYf4HjknPXLcwLn8cWLzj5W5/AIO8p4ZefWa2u+3SnVeBm3+8qixFUl
	RiEruXnmrHg505TVtuia41plPvfJmj9n5pffd/SPKbfYdPb7hccNs86tVWIpzkg01GIuKk4E
	AHpzDANxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvG5piEe6QesxbouPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8XR/2/ZLCYdusZosfeWtsWe
	vSdZLOYve8pu0X19B5vF8uP/mCzO/z3OanF+1hx2ByGPnbPusntcPlvqsWlVJ5vH5iX1Hrtv
	NrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgCuKC6blNSczLLUIn27BK6Mpy8+MxXskavY
	fdmjgXGbZBcjJ4eEgInE3KNLmUFsIYHdjBIr/ipCxCUkTr1cxghhC0us/PecvYuRC6jmI6NE
	T8NcdpAEm4C6xJHnrWBFIgInGCXmT3QDKWIWmMEk0fNrBRtIQlggTuLOpIlgDSwCqhJnzv9i
	AbF5BSwkdtw4wQqxQV5i5qXvYDWcApYSs699Y4W4yELi8uPrrBD1ghInZz4B62UGqm/eOpt5
	AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMebltYOxj2rPugd
	YmTiYDzEKMHBrCTCW8Dtni7Em5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC
	1CKYLBMHp1QD04oefuHpb1vcQs8Fb7pUvUw0/h7jVp66HoGlOrsCV1Q/1tdkK36u2slQe9l5
	c7K6/dMpNn4fLRcmd4cETTvTxxOxcHlb5L7l2acXuh/4eJBp97b3n2ycA+ucCpIVtFeIrOwP
	bSu79j1B9hvfQZbiq7nemQYmfuvsTbS/cKba7TaXv2d6cOd2BanZG9ifLfTvlfFRr2Zd23HB
	j+tQ1XmLRQYLFX+ve6juZnVy7+uN5X/tlhTHnsyIP75r+ok1hppb7keeZV5ik5fa/cDu3ucL
	UUnqNhNCl1+94qKosmYZy9fai4o2wRwnNkjnvzw+c67eCQYhRQe2zeXnH3/9skBFtPzKx2qG
	137Ru455LDqTrMRSnJFoqMVcVJwIAFS07ZImAwAA
X-CMS-MailID: 20241128113101epcas5p3fefab67892c16c7bbaba8063c5c4a2c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128113101epcas5p3fefab67892c16c7bbaba8063c5c4a2c1
References: <20241128112240.8867-1-anuj20.g@samsung.com>
	<CGME20241128113101epcas5p3fefab67892c16c7bbaba8063c5c4a2c1@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_114608_992873_EE92948B 
X-CRM114-Status: GOOD (  17.65  )
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

This patch refactors bio_integrity_map_user to accept iov_iter as
argument. This is a prep patch.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 12 +++++-------
 block/blk-integrity.c         | 10 +++++++++-
 include/linux/bio-integrity.h |  5 ++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4341b0d4efa1..f56d01cec689 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -302,16 +302,15 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 	return nr_bvecs;
 }
 
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes)
+int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	unsigned int align = blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages = stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec = stack_vec;
+	size_t offset, bytes = iter->count;
 	unsigned int direction, nr_bvecs;
-	struct iov_iter iter;
 	int ret, nr_vecs;
-	size_t offset;
 	bool copy;
 
 	if (bio_integrity(bio))
@@ -324,8 +323,7 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes)
 	else
 		direction = ITER_SOURCE;
 
-	iov_iter_ubuf(&iter, direction, ubuf, bytes);
-	nr_vecs = iov_iter_npages(&iter, BIO_MAX_VECS + 1);
+	nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS + 1);
 	if (nr_vecs > BIO_MAX_VECS)
 		return -E2BIG;
 	if (nr_vecs > UIO_FASTIOV) {
@@ -335,8 +333,8 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes)
 		pages = NULL;
 	}
 
-	copy = !iov_iter_is_aligned(&iter, align, align);
-	ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);
+	copy = !iov_iter_is_aligned(iter, align, align);
+	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
 
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index b180cac61a9d..4a29754f1bc2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -115,8 +115,16 @@ EXPORT_SYMBOL(blk_rq_map_integrity_sg);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes)
 {
-	int ret = bio_integrity_map_user(rq->bio, ubuf, bytes);
+	int ret;
+	struct iov_iter iter;
+	unsigned int direction;
 
+	if (op_is_write(req_op(rq)))
+		direction = ITER_DEST;
+	else
+		direction = ITER_SOURCE;
+	iov_iter_ubuf(&iter, direction, ubuf, bytes);
+	ret = bio_integrity_map_user(rq->bio, &iter);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 0f0cf10222e8..58ff9988433a 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -75,7 +75,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 		unsigned int nr);
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 		unsigned int offset);
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len);
+int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter);
 void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
@@ -101,8 +101,7 @@ static inline void bioset_integrity_free(struct bio_set *bs)
 {
 }
 
-static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
-					 ssize_t len)
+static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	return -EINVAL;
 }
-- 
2.25.1


