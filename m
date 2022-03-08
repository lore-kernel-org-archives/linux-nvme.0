Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DDEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xggqX2s11RagKw4Q7ebC+vgPojKy+SUye6vkSA58oIg=; b=ijXFakV01aUiU/pCZKMpJLMFzx
	YyCaB5UsTe/DVLpzDiYoTqGgHY/zARy/ram6iEZFFdE3x568t0xiCwOkknlV+60VR5dIGtzEatGti
	XWnjvcjBUL3r5eWMOVLH2ZYchYIdQXP7bbJQPyMVn7qG+tCvfw7c5sKGWZzWZRwfw5lKwThi0+zcF
	ov5duX/Ksa7X5FWZyloMWsF1DYtTu+LO5IhrnLO95PROG9jIszC14KzOsSMVqSd8UcuJGM9J2VKdN
	GHGHUVgARusHb6VL8N1F5hc7lWUB7kL8Z1sqcWLEcsbnElOKnaV0epzGNGihbSC/XdJ0abILc4IsB
	R51FMiqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRc2m-0052IM-9I; Tue, 08 Mar 2022 15:46:36 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRbyv-0050lb-Fx
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 15:42:39 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220308154235epoutp02690091c5802f0ef1b8f6429dbb8bc93d~aci3-ee8q3174931749epoutp02K
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 15:42:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220308154235epoutp02690091c5802f0ef1b8f6429dbb8bc93d~aci3-ee8q3174931749epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646754155;
 bh=xggqX2s11RagKw4Q7ebC+vgPojKy+SUye6vkSA58oIg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XUBprxDBEA1meGt24m5+fi32r1T+0Dx/5sWsfVK1EzaOKrEddx5QdA8Ws2qcjycCa
 75700AJdOOkHEyCFcXPXnFiJbUJlUGEEt4Avf4Et6ELD6IsYJnQ7DLchDqIz0ozChU
 xTRjvj9/Qtd5Uf34suG0s0gw9Yr3XJF8cxzSbnSU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220308154234epcas5p213c09e68f69d6e005bc050a6bb38bb18~aci3YCqRz2884128841epcas5p2k;
 Tue,  8 Mar 2022 15:42:34 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4KCfj3309Mz4x9Pv; Tue,  8 Mar
 2022 15:42:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.57.06423.76977226; Wed,  9 Mar 2022 00:42:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c~acVZbAWje1997519975epcas5p1T;
 Tue,  8 Mar 2022 15:27:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220308152709epsmtrp198e5583e2cca027f550c02dfb6f25123~acVZaLrYR0125001250epsmtrp1W;
 Tue,  8 Mar 2022 15:27:09 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-f6-622779675e51
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 F6.96.03370.DC577226; Wed,  9 Mar 2022 00:27:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220308152707epsmtip153ad2d104b96e7f2f57cb6e851c5fda1~acVXZd2Mt3168431684epsmtip1D;
 Tue,  8 Mar 2022 15:27:07 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 pankydev8@gmail.com, javier@javigon.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
Date: Tue,  8 Mar 2022 20:50:56 +0530
Message-Id: <20220308152105.309618-9-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308152105.309618-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmhm56pXqSwc9ZQhbTDytaNE34y2wx
 Z9U2RovVd/vZLFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saE
 p4wWa24+ZbH4fGYeqwO/x7Orzxg9ds66y+7RvOAOi8fls6Uem1Z1snlsXlLvsftmA5vHtsUv
 WT36tqxi9Pi8SS6AKyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VW
 ycUnQNctMwfoByWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpe
 XmqJlaGBgZEpUGFCdsafbxfZC15oVWzd9JW1gXG2chcjJ4eEgInEibN7GbsYuTiEBHYzSrz5
 2s8OkhAS+MQocWGzHETiM6PEsSf9rDAd21f0MkEkdjFKTN/2nBWu6ui6KyxdjBwcbAKaEhcm
 l4I0iAh4Sdy//R6shlmgi0ni7b77bCAJYQFHiembH4KtYxFQldiw6yNYL6+ApcT7yZ4Qy+Ql
 Zl76DlbCKWAl8fPWVrAjeAUEJU7OfMICYjMD1TRvnc0MMl9C4AiHxOtZP5khml0kHt28zQJh
 C0u8Or6FHcKWknjZ3wZlF0v8unMUqrmDUeJ6w0yoBnuJi3v+MoEcxAz0zPpd+hBhWYmpp9Yx
 QSzmk+j9/YQJIs4rsWMejK0ocW/SU2hoiUs8nLEEyvaQ2L1lFzSwehklrq47zziBUWEWkodm
 IXloFsLqBYzMqxglUwuKc9NTi00LDPNSy+GxnJyfu4kRnK61PHcw3n3wQe8QIxMH4yFGCQ5m
 JRHe++dVkoR4UxIrq1KL8uOLSnNSiw8xmgIDfCKzlGhyPjBj5JXEG5pYGpiYmZmZWBqbGSqJ
 855O35AoJJCeWJKanZpakFoE08fEwSnVwKTFUVC5qOnBcQuvjdwJrV5cFt9O/P3oWSN+eANP
 tea56BbfIxJxt7SvmM5LFYl8ePthyIQqr77pHjFGd19UzDxTZn154/Ow1Spd88K8LCwN3WTY
 vVPyfpusS6x+a9dkaeGsx39q4tS7ZxSVn4sbCXyYXPTI2fPn2aW2e1bJifqqax7bvNpp0RfO
 jTOnivFIHPvsKHdAeY2wT3X1W9aADXtc+iKNjditp0RuXb97WdtXXcPvbhOZ2fZfsV+S8cvy
 Z1XMvgn8F1pq7u/Qz5rWwyLusmHi+Q8TuS68Douo5OJ+kpDa2+HRNOP4gush+Sz62u2ZHWzf
 jdcrMTTOFj3vEKFwRuTPbsFdaYfn7tGKU2Ipzkg01GIuKk4EAEmmsJ9gBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTvdsqXqSwZzHYhbTDytaNE34y2wx
 Z9U2RovVd/vZLFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saE
 p4wWa24+ZbH4fGYeqwO/x7Orzxg9ds66y+7RvOAOi8fls6Uem1Z1snlsXlLvsftmA5vHtsUv
 WT36tqxi9Pi8SS6AK4rLJiU1J7MstUjfLoEr48+3i+wFL7Qqtm76ytrAOFu5i5GTQ0LARGL7
 il4mEFtIYAejxJ2NfBBxcYnmaz/YIWxhiZX/ngPZXEA1Hxklpj3eCtTAwcEmoClxYXIpSI2I
 QIDEwcbLYDXMAjOYJHqaP7OAJIQFHCWmb34INohFQFViw66PLCC9vAKWEu8ne0LMl5eYeek7
 WAmngJXEz1tbWSHusZRYse43G4jNKyAocXLmE7CRzED1zVtnM09gFJiFJDULSWoBI9MqRsnU
 guLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgaNLS2sG4Z9UHvUOMTByMhxglOJiVRHjvn1dJ
 EuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHpSAur+syc
 h1sXL3p/ZL2uLOexL1f8j6rk3isyX3c9wvzkJqZ32lc6l0v/ajGaYhr2etv8dccXSh+flsGU
 v8pt34FtBtMLnXPtSnU9GLIkDQyXGGx88fJDvjN7/H3z/EsVpSzn3TZoWDNf/n3vwZQPTAst
 j+4UmMwxTdTvaa3kj2Prl/8IKrbq4O/g4f/54Fz83v5pz/7PnbCNJ7zshpGYwKqW21yLD/n7
 7Zr1PeLfrJ0W0yfp7qgRdpA32Wfz6ur6vN27p+Q9l1OWt/df5pFV2rl+jjNrzMZ4/4bP13na
 nmcLml3prpMt+/Qs/MYUpqtCFpoJj/4L7ZrF8XvrKTGZsn8Ha/adnyHvp3FuwewyXSWW4oxE
 Qy3mouJEAAC9jsYVAwAA
X-CMS-MailID: 20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_074237_957184_53A0989A 
X-CRM114-Status: GOOD (  22.22  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Add support to carry out passthrough command with pre-mapped buffers.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-map.c           | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 27 ++++++++++++++---------
 include/linux/blk-mq.h    |  2 ++
 3 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..027e8216e313 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -8,6 +8,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/uio.h>
+#include <linux/io_uring.h>
 
 #include "blk.h"
 
@@ -577,6 +578,50 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_user);
 
+/* Unlike blk_rq_map_user () this is only for fixed-buffer async passthrough. */
+int blk_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
+		     u64 ubuf, unsigned long len, gfp_t gfp_mask,
+		     struct io_uring_cmd *ioucmd)
+{
+	struct iov_iter iter;
+	size_t iter_count, nr_segs;
+	struct bio *bio;
+	int ret;
+
+	/*
+	 * Talk to io_uring to obtain BVEC iterator for the buffer.
+	 * And use that iterator to form bio/request.
+	 */
+	ret = io_uring_cmd_import_fixed(ubuf, len, rq_data_dir(rq), &iter,
+			ioucmd);
+	if (unlikely(ret < 0))
+		return ret;
+	iter_count = iov_iter_count(&iter);
+	nr_segs = iter.nr_segs;
+
+	if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
+		return -EINVAL;
+	if (nr_segs > queue_max_segments(q))
+		return -EINVAL;
+	/* no iovecs to alloc, as we already have a BVEC iterator */
+	bio = bio_alloc(gfp_mask, 0);
+	if (!bio)
+		return -ENOMEM;
+
+	ret = bio_iov_iter_get_pages(bio, &iter);
+	if (ret)
+		goto out_free;
+
+	blk_rq_bio_prep(rq, bio, nr_segs);
+	return 0;
+
+out_free:
+	bio_release_pages(bio, false);
+	bio_put(bio);
+	return ret;
+}
+EXPORT_SYMBOL(blk_rq_map_user_fixedb);
+
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @bio:	       start of bio list
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1df270b47af5..91d893eedc82 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -123,8 +123,13 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
+static inline bool nvme_is_fixedb_passthru(struct io_uring_cmd *ioucmd)
+{
+	return ((ioucmd) && (ioucmd->flags & IO_URING_F_UCMD_FIXEDBUFS));
+}
+
 static int nvme_submit_user_cmd(struct request_queue *q,
-		struct nvme_command *cmd, void __user *ubuffer,
+		struct nvme_command *cmd, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout,
 		struct io_uring_cmd *ioucmd)
@@ -152,8 +157,12 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
-				GFP_KERNEL);
+		if (likely(nvme_is_fixedb_passthru(ioucmd)))
+			ret = blk_rq_map_user_fixedb(q, req, ubuffer, bufflen,
+					GFP_KERNEL, ioucmd);
+		else
+			ret = blk_rq_map_user(q, req, NULL, nvme_to_user_ptr(ubuffer),
+					bufflen, GFP_KERNEL);
 		if (ret)
 			goto out;
 		bio = req->bio;
@@ -260,9 +269,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
 	return nvme_submit_user_cmd(ns->queue, &c,
-			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
-			NULL);
+			io.addr, length, metadata, meta_len,
+			lower_32_bits(io.slba), NULL, 0, NULL);
 }
 
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -314,9 +322,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			nvme_to_user_ptr(cmd.addr), cmd.data_len,
-			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout, NULL);
+			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
+			cmd.metadata_len, 0, &result, timeout, NULL);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -368,7 +375,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cptr->timeout_ms);
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			nvme_to_user_ptr(cptr->addr), cptr->data_len,
+			cptr->addr, cptr->data_len,
 			nvme_to_user_ptr(cptr->metadata), cptr->metadata_len,
 			0, &cptr->result, timeout, ioucmd);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d319ffa59354..48bcfd194bdc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -966,6 +966,8 @@ struct rq_map_data {
 
 int blk_rq_map_user(struct request_queue *, struct request *,
 		struct rq_map_data *, void __user *, unsigned long, gfp_t);
+int blk_rq_map_user_fixedb(struct request_queue *, struct request *,
+		     u64 ubuf, unsigned long, gfp_t,  struct io_uring_cmd *);
 int blk_rq_map_user_iov(struct request_queue *, struct request *,
 		struct rq_map_data *, const struct iov_iter *, gfp_t);
 int blk_rq_unmap_user(struct bio *);
-- 
2.25.1


