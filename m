Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9FDC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 17:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OWfX54HqbvG9emkZ5yG9m2A9p0d53tVfjUM9ft+8e3U=; b=oxFPXpwSlGhicIC/C+qX3ewHHn
	1HqD+Jb6QqwQ/fNo7nzGOVG5CTItqOqT2DDW8tzumYP66vQDMwxwN6dJPcmjgmPSOrLG0DpvE7l6K
	DVUOxa5peGWn4iUVR62mY2ydNxBOQj6A6rCO5us5JZXmvKY78bDx+WsYDJ2eC/fsLGd7doAJA6m8m
	XhEibi/Axx/OJA9sNJRWhJIKJoZOtrHWB4aq+lP2GOvSSTpyr8pOnZIPS37JGyRXbL8oaWtatlz8k
	MW93bNSbnB9JarFAkNlq4as35Ww7qmDTIn+cCTwGz4BoHUt8k+zkHQeKT6bbnsp2LmFNJ37YLyFqt
	MSlF3JiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEfV-00C1bd-1a; Tue, 27 Sep 2022 17:46:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEfI-00C1Ti-DH
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 17:46:43 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220927174637epoutp02b2bbae55973c1ac341cf1d7768249925~YyMHx22rQ0128201282epoutp02O
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 17:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220927174637epoutp02b2bbae55973c1ac341cf1d7768249925~YyMHx22rQ0128201282epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664300797;
	bh=OWfX54HqbvG9emkZ5yG9m2A9p0d53tVfjUM9ft+8e3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6gE+UyDo0EWwXCPLeGcheXd9xcTdXGbQb2dSSusXf+36E34SgXM7aYPg/i/+JNrB
	 4D86S3I8grNNB8MIlBFzYCfvPPo7jUeNVuBdZY2/67ClMQiWuLeOGg5sBKwShDLgKP
	 YqBVP3pNuOATvaD4ytNMyEIZjSgsPElN+uwVejlc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220927174637epcas5p389de44897f5bc729b521d7a889e59ab7~YyMHcUzyY2603326033epcas5p30;
	Tue, 27 Sep 2022 17:46:37 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4McRrV5Vxsz4x9Pw; Tue, 27 Sep
	2022 17:46:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.1F.39477.AF633336; Wed, 28 Sep 2022 02:46:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869~YyMEZTz5x2946229462epcas5p4E;
	Tue, 27 Sep 2022 17:46:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220927174633epsmtrp2bc3676dfacf0cb26cbc2a3aaaec08337~YyMEYjynK3251332513epsmtrp2h;
	Tue, 27 Sep 2022 17:46:33 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-93-633336faf885
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.1D.14392.9F633336; Wed, 28 Sep 2022 02:46:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220927174632epsmtip1ee91eb40496b2853f7e8867313b472f1~YyMDB-hgn0699206992epsmtip1T;
	Tue, 27 Sep 2022 17:46:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v10 4/7] nvme: refactor nvme_alloc_request
Date: Tue, 27 Sep 2022 23:06:07 +0530
Message-Id: <20220927173610.7794-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927173610.7794-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTQ/eXmXGyQc80bYvVd/vZLG4e2Mlk
	sXL1USaLd63nWCyO/n/LZjHp0DVGi723tC3mL3vK7sDhcflsqcemVZ1sHpuX1HvsvtnA5tG3
	ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4B
	um6ZOUDXKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkus
	DA0MjEyBChOyM9bOvcJecFa3ouHcesYGxiUqXYycHBICJhLvJ11nBrGFBHYzSrxcXNLFyAVk
	f2KU+LfnHQuE841R4t2bVSwwHXvmX2OGSOxllFhw8wsbhPOZUWLWuy1AGQ4ONgFNiQuTS0Ea
	RASMJPZ/OskKUsMsMINRYnXHa3aQhLCAs8SJKQeZQGwWAVWJyZf+sYHYvALmEt93bGSF2CYv
	MfPSd3aQmZwCFhKHP2ZClAhKnJz5BOwgZqCS5q2zwQ6SEPjKLvHqTBsTRK+LRFPjS3YIW1ji
	1fEtULaUxOd3e9kg7GSJSzPPQdWXSDzecxDKtpdoPdUP9gsz0C/rd+lD7OKT6P39hAkkLCHA
	K9HRJgRRrShxb9JTqIvFJR7OWAJle0g82TQLGlbdjBKbv05knMAoPwvJC7OQvDALYdsCRuZV
	jJKpBcW56anFpgVGeanl8HhNzs/dxAhOk1peOxgfPvigd4iRiYPxEKMEB7OSCO/vo4bJQrwp
	iZVVqUX58UWlOanFhxhNgUE8kVlKNDkfmKjzSuINTSwNTMzMzEwsjc0MlcR5F8/QShYSSE8s
	Sc1OTS1ILYLpY+LglGpgYjoQeazPY9KPxYzBabsvubrP4vHiOyx6xFbr2j6OiDP9iX/2sf0+
	eHyVkT9va8QjjpuBGtN9P894XmDzYvcEk+rQd0pyh47vvJ8kyfhwymLTPmsJNh6hoGL3w77n
	NzyedYZDRu/Z6ict3JbnC7i/b+rYueHQz5LLgq0CE7LUl53gehY0aUOW/w9Zh/iXX2e5sMfF
	Gyco5DUy3ipizf21p1Lvw23F1Z6v9n4xWbC5e67eti0v6g+HcU1K3Fk3q/U3s/qbpvf1TBdf
	ZBrfuFGyy8uBQ+mQ2yTP9q8WxXMm9L+QCZBhdt1RH7N0Y00x89tLpiHbD8tbXKkt9nkw45nr
	jg39lzI1hV7M4Wmsq7sXpsRSnJFoqMVcVJwIAAWpIJccBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnO5PM+NkgwP7jS1W3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRXHZpKTmZJalFunbJXBlrJ17hb3grG5Fw7n1jA2MS1S6GDk5JARMJPbMv8bc
	xcjFISSwm1Fiz74brBAJcYnmaz/YIWxhiZX/nrNDFH1klDj/+CtQBwcHm4CmxIXJpSA1IgJm
	EksPr2EBqWEWmMMocfnyHrBmYQFniRNTDjKB2CwCqhKTL/1jA7F5Bcwlvu/YCLVMXmLmpe/s
	IDM5BSwkDn/MBAkLAZVs3fSBBaJcUOLkzCdgNjNQefPW2cwTGAVmIUnNQpJawMi0ilEytaA4
	Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOMS1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe30cNk4V4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgineT7d+0tCQ+
	V+ZBv3bGtvPbe12Uj3TPjfvUuqufQ2JV0ETdNI/O/1WuPoz735rpnr74kWtLn0tdmUYL//qN
	iRuVDnd580/gcrkvdu/i5t0vTQot68R5JRf/uML2x+P11TkRF9V+WOdNPdjOxbD2pKGXlqyU
	+LT//5v5HkQv4p3KnBXzc/3/y+dyWS3Mk1kcY47v8dr5Nizpofqi9FCz5dd3LPOKvbJoyZoo
	1qgmw7R2yQ/d79bbaBWKbuyttG19uFv7y6PJ9aJ9RkcXetwxiTTwub/uieki9mU/G06V3VWc
	9yPTLXHv3ishaccMmqZ82MMubcyRHV1Rauef4sBksZRnx8JXt5c/4FCufxeuxFKckWioxVxU
	nAgAHlwmQOACAAA=
X-CMS-MailID: 20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869
References: <20220927173610.7794-1-joshi.k@samsung.com>
	<CGME20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_104640_832538_3B94D7B0 
X-CRM114-Status: GOOD (  20.12  )
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


