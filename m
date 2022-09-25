Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F12DC04A95
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OWfX54HqbvG9emkZ5yG9m2A9p0d53tVfjUM9ft+8e3U=; b=Lhu3WSQaSbbmwxJYNGuAi8lMfB
	VqS8Of7OVSxRx0D4xc4dZGViEGhFhR43a1Fme/pgEuDd+w9xNZgslJ56ekfkLsbS5/EAxKd8NQq/D
	h8wmqV+DZPfw4AGQfk0eu8w3dJ+XsabJl4+eawwgDNv5p2PGk0snU0i+gAvbIF6LTjHyyXmVc56dS
	zpk4Ls0aLOUrZzRIBP9oDXfTukYBMYObCoABQkA/KvX8uLrS2AkGOdA3lW+f7mBOglntjEEBL5MAy
	t24H2I2PLwWF5iCBQhPLqfm7w1RVPjCUi4Ng4pWx+j4SkZgfMrFuhN+pCjsPQoD9sWxrb8CuyuCoz
	URlhiwSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocYKC-00GS5f-Ar; Sun, 25 Sep 2022 20:34:04 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocYJn-00GRp5-9L
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 20:33:42 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220925203334epoutp020f8690a47a31a82d396056117deaae4a~YNLUAQVqq0567205672epoutp02o
	for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 20:33:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220925203334epoutp020f8690a47a31a82d396056117deaae4a~YNLUAQVqq0567205672epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664138014;
	bh=OWfX54HqbvG9emkZ5yG9m2A9p0d53tVfjUM9ft+8e3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcuFPrU5+Q/ZG9hTbXYqaV5iM55MDndCDcOmCyrOmv0Ri2/EKCWiEbdoyWBMKNZz5
	 Qa1jCa/YCNkV3IH3tpJ+RrDZ9/fySS3eDS44QuChDixxZCHVrSNVqxs9TUecbzlADy
	 9HJ2Vni6wlJjieiSl9ECySsah0b+CQMrwdewKQ4Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220925203333epcas5p4b9eff4cf934ce5ba2c0725927f98a05c~YNLTVw1H92831828318epcas5p42;
	Sun, 25 Sep 2022 20:33:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MbHf33bWyz4x9Pp; Sun, 25 Sep
	2022 20:33:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.54.39477.B1BB0336; Mon, 26 Sep 2022 05:33:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220925203330epcas5p20c712fa919a4cc2a5ec3bbaa94bb72ca~YNLQS-OyI2718327183epcas5p2I;
	Sun, 25 Sep 2022 20:33:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220925203330epsmtrp287aa87128a20e7c5717c502cc881b6ad~YNLQSSKwD1586315863epsmtrp2K;
	Sun, 25 Sep 2022 20:33:30 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-8d-6330bb1b77cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.1A.18644.A1BB0336; Mon, 26 Sep 2022 05:33:30 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220925203329epsmtip13580b9ae4f15707ab0740f8442451752~YNLPFPyA20205902059epsmtip1I;
	Sun, 25 Sep 2022 20:33:28 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v9 4/7] nvme: refactor nvme_alloc_request
Date: Mon, 26 Sep 2022 01:53:01 +0530
Message-Id: <20220925202304.28097-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925202304.28097-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTQ1d6t0Gywco1Uhar7/azWdw8sJPJ
	YuXqo0wW71rPsVgc/f+WzWLSoWuMFntvaVvMX/aU3YHD4/LZUo9NqzrZPDYvqffYfbOBzaNv
	yypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
	dN0yc4CuUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZY
	GRoYGJkCFSZkZ6yde4W94KxuRcO59YwNjEtUuhg5OSQETCQudz9mAbGFBHYzSuzqsuli5AKy
	PzFKfH9+gx3C+cwoMeHgLaAqDrCOKQtdIeK7GCVOrX6BUPTwyFx2kCI2AU2JC5NLQaaKCBhJ
	7P90khWkhllgBqPE6o7X7CAJYQEniVPLJoLZLAKqEu3d25lBbF4BC4nZd1exQ5wnLzHz0ncw
	m1PAUuLJ3K1QNYISJ2c+ATubGaimeetsZpAFEgJf2SW+/5nICNHsIvHgVRvUIGGJV8e3QNlS
	Ep/f7WWDsJMlLs08xwRhl0g83nMQyraXaD3VzwzyDDPQM+t36UPs4pPo/f2ECRIQvBIdbUIQ
	1YoS9yY9ZYWwxSUezlgCZXtIXDz/kRUSPj2MEtMbt7JMYJSfheSFWUhemIWwbQEj8ypGydSC
	4tz01GLTAqO81HJ4vCbn525iBKdJLa8djA8ffNA7xMjEwXiIUYKDWUmEN+WibrIQb0piZVVq
	UX58UWlOavEhRlNgGE9klhJNzgcm6rySeEMTSwMTMzMzE0tjM0Mlcd7FM7SShQTSE0tSs1NT
	C1KLYPqYODilGpgmNosZ3gvdK1ghUVPhfKXS45nqroK2GwL7PggkT3uyMupETWCV/SxplQv+
	+S8eSX0TLu7/lRul/irA6rbaJBvXczNm/+BdMJ3pH+OTA303Un/cufzfzvP01qio8Koy5j2x
	TOsD990vuGz6YV3A8ivcOioerM5mc4velJmfvlm5/pbB+YMVNpt5f4nUaCiaHT7fWPjh4l+X
	m3mtdsw3i+xYcx6+e8m1OOyi33UHV5lnYt/MJxgcqztuplfAWPx+e5G2w3WXsgPXblccSNYT
	OlZg3XbDKc7u80Sz3wVzq3U0z8keKLZe9ur0/xtheeE57u+TrE11FlssvMLC93bmmuuaQst/
	S766zHDj8Q/x9jQlluKMREMt5qLiRAAm4zVBHAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnK7UboNkg+OL+SxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRXHZpKTmZJalFunbJXBlrJ17hb3grG5Fw7n1jA2MS1S6GDk4JARMJKYsdO1i
	5OIQEtjBKHFp2SnWLkZOoLi4RPO1H+wQtrDEyn/P2SGKPjJKPFx+jQWkmU1AU+LC5FKQGhEB
	M4mlh9ewgNQwC8xhlLh8eQ9Ys7CAk8SpZRPBbBYBVYn27u3MIDavgIXE7LuroBbIS8y89B3M
	5hSwlHgydyszyHwhoJqt57UgygUlTs58wgJiMwOVN2+dzTyBUWAWktQsJKkFjEyrGCVTC4pz
	03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA1xLawfjnlUf9A4xMnEwHmKU4GBWEuFNuaibLMSb
	klhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMTU+mNO575Rs3r
	Ph5dMfWP24HKCar+c5cYzpV+aXxXfH139X/TSs23hxdxLDl+T2vSGsbYayZZDVLbbrc/TxI5
	8VD5y5ctGs0V9+ZqP93ZtS9sqtDZfZN5ZhRsumyp9aOqXCbPh22HmNc8CYYDy5a9Mp7cP41n
	k3hGo7dubc2jLeWdSQyZudpc+Tt6JfhXWXWmGX4SlZH68/crR1eed7r8I70lW48sVfz7evsO
	vnvVC40TNM8LKvRPMK9XvVZxJbP55t4LWVKJEiZ/r0peEOSQWnbEb9fOJmdd2TWPNe49VGbW
	tIkQ/P6jtKXDwMOgyqn3bkW3UvKty5cZUjdnr+H0rnXaFvLy8OGQCv/bvzKUWIozEg21mIuK
	EwEshiac3wIAAA==
X-CMS-MailID: 20220925203330epcas5p20c712fa919a4cc2a5ec3bbaa94bb72ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220925203330epcas5p20c712fa919a4cc2a5ec3bbaa94bb72ca
References: <20220925202304.28097-1-joshi.k@samsung.com>
	<CGME20220925203330epcas5p20c712fa919a4cc2a5ec3bbaa94bb72ca@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_133339_696169_19DE090F 
X-CRM114-Status: GOOD (  19.89  )
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

nvme_alloc_alloc_request expects a large number of parameters.
Split this out into two functions to reduce number of parameters.
First one retains the name nvme_alloc_request, while second one is
named nvme_map_user_request.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 121 ++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8f8435b55b95..b9f17dc87de9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -70,68 +70,69 @@ static int nvme_finish_user_metadata(struct request *req, void __user *ubuf,
 }
 
 static struct request *nvme_alloc_user_request(struct request_queue *q,
-		struct nvme_command *cmd, void __user *ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, void **metap, unsigned timeout, bool vec,
-		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)
+		struct nvme_command *cmd, blk_opf_t rq_flags,
+		blk_mq_req_flags_t blk_flags)
 {
-	struct nvme_ns *ns = q->queuedata;
-	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	struct request *req;
-	struct bio *bio = NULL;
-	void *meta = NULL;
-	int ret;
 
 	req = blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return req;
 	nvme_init_request(req, cmd);
-
-	if (timeout)
-		req->timeout = timeout;
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
+	return req;
+}
 
-	if (ubuffer && bufflen) {
-		if (!vec)
-			ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
-				GFP_KERNEL);
-		else {
-			struct iovec fast_iov[UIO_FASTIOV];
-			struct iovec *iov = fast_iov;
-			struct iov_iter iter;
-
-			ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
-					UIO_FASTIOV, &iov, &iter);
-			if (ret < 0)
-				goto out;
-			ret = blk_rq_map_user_iov(q, req, NULL, &iter,
-					GFP_KERNEL);
-			kfree(iov);
-		}
-		if (ret)
+static int nvme_map_user_request(struct request *req, void __user *ubuffer,
+		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
+		u32 meta_seed, void **metap, bool vec)
+{
+	struct request_queue *q = req->q;
+	struct nvme_ns *ns = q->queuedata;
+	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	struct bio *bio = NULL;
+	void *meta = NULL;
+	int ret;
+
+	if (!vec)
+		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+			GFP_KERNEL);
+	else {
+		struct iovec fast_iov[UIO_FASTIOV];
+		struct iovec *iov = fast_iov;
+		struct iov_iter iter;
+
+		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
+				UIO_FASTIOV, &iov, &iter);
+		if (ret < 0)
 			goto out;
-		bio = req->bio;
-		if (bdev)
-			bio_set_dev(bio, bdev);
-		if (bdev && meta_buffer && meta_len) {
-			meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
-					meta_seed);
-			if (IS_ERR(meta)) {
-				ret = PTR_ERR(meta);
-				goto out_unmap;
-			}
-			*metap = meta;
+
+		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
+		kfree(iov);
+	}
+	if (ret)
+		goto out;
+	bio = req->bio;
+	if (bdev)
+		bio_set_dev(bio, bdev);
+
+	if (bdev && meta_buffer && meta_len) {
+		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
+				meta_seed);
+		if (IS_ERR(meta)) {
+			ret = PTR_ERR(meta);
+			goto out_unmap;
 		}
+		*metap = meta;
 	}
 
-	return req;
+	return ret;
 
 out_unmap:
 	if (bio)
 		blk_rq_unmap_user(bio);
 out:
-	blk_mq_free_request(req);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
@@ -144,13 +145,19 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	struct bio *bio;
 	int ret;
 
-	req = nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
-			meta_len, meta_seed, &meta, timeout, vec, 0, 0);
+	req = nvme_alloc_user_request(q, cmd, 0, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	bio = req->bio;
+	req->timeout = timeout;
+	if (ubuffer && bufflen) {
+		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
+				meta_len, meta_seed, &meta, vec);
+		if (ret)
+			goto out;
+	}
 
+	bio = req->bio;
 	ret = nvme_execute_passthru_rq(req);
 
 	if (result)
@@ -160,6 +167,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 						meta_len, ret);
 	if (bio)
 		blk_rq_unmap_user(bio);
+out:
 	blk_mq_free_request(req);
 	return ret;
 }
@@ -421,6 +429,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	void *meta = NULL;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -460,13 +469,18 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		rq_flags |= REQ_POLLED;
 
 retry:
-	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(d.addr),
-			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, 0, &meta, d.timeout_ms ?
-			msecs_to_jiffies(d.timeout_ms) : 0, vec, rq_flags,
-			blk_flags);
+	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
+
+	if (d.addr && d.data_len) {
+		ret = nvme_map_user_request(req, nvme_to_user_ptr(d.addr),
+			d.data_len, nvme_to_user_ptr(d.metadata),
+			d.metadata_len, 0, &meta, vec);
+		if (ret)
+			goto out_err;
+	}
 	req->end_io = nvme_uring_cmd_end_io;
 	req->end_io_data = ioucmd;
 
@@ -489,6 +503,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
+out_err:
+	blk_mq_free_request(req);
+	return ret;
 }
 
 static bool is_ctrl_ioctl(unsigned int cmd)
-- 
2.25.1


