Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420D6C6FA86
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iwCntG/buA6//VKqNuXAbWrgGiDaWC0bADFiQoNYs8s=; b=RuoimZE2Uxf4AbiiHya2ELz/qK
	skH/6btAXJWI5k57FuuE5bJUynDFGiXyShn1bvZn220fAWyYx20MCrLqp2Y4IzZglPklP6KMc/kKO
	ctaF4gN+Ogon4Qk3blW//QgGy2OUlae6imuAdpSgGUTceNAtXFsOIFQU+p1q7tIrQqeIsRT9xh6cl
	NvcuJ/G3FZ3xa+teXaqZjShDkKGjJgqV8Q1s2ClmoY90SGc9vf76v4t3Gw6zuCebOdjxTmnnZ+CcA
	L3H1lLTKg8W7FNyvqjlB6xAKjiqjqx60tSFpzQZZpwUGXRB+QraR1XuxHCMBuePUR60/Azp/Hhs0h
	+cM0PNkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWMXJ-006vAF-By; Thu, 08 Sep 2022 18:46:01 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWMX2-006usL-UX
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 18:45:46 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220908184538epoutp02e1618f64dbae4f23fea341206435b0ef~S9vOsBM6o0702307023epoutp02f
	for <linux-nvme@lists.infradead.org>; Thu,  8 Sep 2022 18:45:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220908184538epoutp02e1618f64dbae4f23fea341206435b0ef~S9vOsBM6o0702307023epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662662738;
	bh=iwCntG/buA6//VKqNuXAbWrgGiDaWC0bADFiQoNYs8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra+6wkdJjc+XOIjMVcBlPPZS5SbjpabclVN9DvlTllck2f7B7fYXxdr6DcYoT9UU+
	 I7exdqAE/h3KnCAAR2cCBl8rF0xtoVDYXlplNjBuLL5TYdn6QXz85vG4/cgW91WhG7
	 Z2LA8LwAcGV+2vYGBPj7qe3zwuLCVqds0kXtByhc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220908184538epcas5p1b71c01e356e2dd7a0ca0daaa1cce0672~S9vOJZK622308423084epcas5p1N;
	Thu,  8 Sep 2022 18:45:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MNp3N1qvLz4x9Pt; Thu,  8 Sep
	2022 18:45:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.49.54060.0583A136; Fri,  9 Sep 2022 03:45:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220908184535epcas5p1e1f3d8b646d88079c3a7840f79e59508~S9vLonLK00840908409epcas5p1y;
	Thu,  8 Sep 2022 18:45:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220908184535epsmtrp18d7713c7a989ffbf7ac50509cd1e61ad~S9vLnymUV3080730807epsmtrp1f;
	Thu,  8 Sep 2022 18:45:35 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-d4-631a38505aa4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.DD.14392.F483A136; Fri,  9 Sep 2022 03:45:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220908184534epsmtip23a1089d549cf64d4ca50d13174d1cb8a~S9vKSKsR32413824138epsmtip2a;
	Thu,  8 Sep 2022 18:45:34 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v6 3/5] nvme: refactor nvme_alloc_user_request
Date: Fri,  9 Sep 2022 00:05:09 +0530
Message-Id: <20220908183511.2253-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908183511.2253-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmlm6AhVSywcqH7BZzVm1jtFh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsDpweO2fdZfe4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZyzcfYyuYqFuxdsVH9gbGv8pdjJwcEgImEj9PH2TrYuTi
	EBLYzSjxYWUnlPOJUeL4ydPsEM43RomeZbMZYVp+zNrHDJHYyyjRMeUNVNVnRolvrx6ydDFy
	cLAJaEpcmFwK0iAi4CVx//Z7VpAaZoEZjBKrO16zg9QIC7hLNB6yBalhEVCV6D9xjxnE5hUw
	l3g0/Ts7xDJ5iZmXIGxOAQuJi18eskHUCEqcnPmEBcRmBqpp3job7CAJgb/sEtc+vmSDaHaR
	OH59DQuELSzx6vgWqKFSEi/726DsZIlLM88xQdglEo/3HISy7SVaT/Uzg9zJDPTL+l36ELv4
	JHp/P2ECCUsI8Ep0tAlBVCtK3Jv0lBXCFpd4OGMJlO0hcWfDF2hYdTNKzFvQyT6BUX4Wkhdm
	IXlhFsK2BYzMqxglUwuKc9NTi00LjPNSy+ERm5yfu4kRnDy1vHcwPnrwQe8QIxMH4yFGCQ5m
	JRFe0bUSyUK8KYmVValF+fFFpTmpxYcYTYFhPJFZSjQ5H5i+80riDU0sDUzMzMxMLI3NDJXE
	eadoMyYLCaQnlqRmp6YWpBbB9DFxcEo1MD31VRFPflTIZphqsb6xrsuHaWpll/nPtHtaC+sM
	Tu/fbnJAaCv78oeMsT8j5HtWnW5bOeVzkpXORm3V1hued9ry1dys7GSWhS6qP77+25dtass5
	DS0iY794xBU7PPe9YOa+LLwuImze+Z8ZQdcff4vfdrS6d8MRu6MOOjfPi6dd4Z/JofjF0CpA
	9PaXx8FZs/IiYxWXzC+vqUn389x6IFTn/xm5X+sEms16NLNvr1plcFNv8dErsXss9Lbq15wU
	d/vuEX7zeUJOwBMti2Kfuxl/T1rd43XY4MP3sfVB8uYi12XnrvRLb5HYLGdewlLK2SN/Jcbj
	Q6XI/02VCqubHXSnTy7Ydb9h696sGU8WKrEUZyQaajEXFScCAMggBiQnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvK6/hVSywZvXMhZzVm1jtFh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22L+sqfsDpweO2fdZfe4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozlm4+xFUzUrVi74iN7A+Nf5S5G
	Tg4JAROJH7P2MYPYQgK7GSXaZgtCxMUlmq/9YIewhSVW/nsOZHMB1XxklNj/+SpTFyMHB5uA
	psSFyaUgNSICARIHGy+D1TALzGGUuHx5DztIjbCAu0TjIVuQGhYBVYn+E/fAdvEKmEs8mv4d
	ar68xMxLEDangIXExS8P2SDuMZe49mc6VL2gxMmZT1hAbGag+uats5knMArMQpKahSS1gJFp
	FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcNBrae5g3L7qg94hRiYOxkOMEhzMSiK8
	omslkoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgal+x
	9Oa23mmRpx2LeSx59nK8TVdJKpwXYsgd6XPCKVRM+9zXh85FK/5oCvpfXX/8+XWdIuduzu1r
	YtmvtJis/xc6+bn37qs7W5bsjPwXeKJu+qnMHMYJjx4c318cOdt56cG2BlnBJ2/YExJruo6X
	8ITt53kefXZeyL9v2jw/7OyZND9eUl5rNnNryVvTJDn/WfmPq+LTVNVnbjf4+vfZsw/524UF
	3lyddtuor+nMgukfOLwt9M+0/yie63M7Slw6qnL9JYk3C3NaIxdI9goFa+x4Uvn20Qq9y+5y
	AmwqO0o3vpLcysw17cPhILcNR2w7lDve1k7ba2mpvkdm8alrPn8iznzrur5adPdzsdAdS5VY
	ijMSDbWYi4oTAUsPDlrpAgAA
X-CMS-MailID: 20220908184535epcas5p1e1f3d8b646d88079c3a7840f79e59508
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220908184535epcas5p1e1f3d8b646d88079c3a7840f79e59508
References: <20220908183511.2253-1-joshi.k@samsung.com>
	<CGME20220908184535epcas5p1e1f3d8b646d88079c3a7840f79e59508@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_114545_367235_573EBE2F 
X-CRM114-Status: GOOD (  20.49  )
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

Separate this out to two functions with reduced number of arguments.
_
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 116 ++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 50 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 548aca8b5b9f..cb2fa4db50dd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -65,18 +65,10 @@ static int nvme_finish_user_metadata(struct request *req, void __user *ubuf,
 }
 
 static struct request *nvme_alloc_user_request(struct request_queue *q,
-		struct nvme_command *cmd, void __user *ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, void **metap, unsigned timeout, bool vec,
+		struct nvme_command *cmd, unsigned timeout,
 		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)
 {
-	bool write = nvme_is_write(cmd);
-	struct nvme_ns *ns = q->queuedata;
-	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	struct request *req;
-	struct bio *bio = NULL;
-	void *meta = NULL;
-	int ret;
 
 	req = blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags);
 	if (IS_ERR(req))
@@ -86,49 +78,61 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	if (timeout)
 		req->timeout = timeout;
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
+	if (!ubuffer || !bufflen)
+		return 0;
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
-			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
-					meta_seed, write);
-			if (IS_ERR(meta)) {
-				ret = PTR_ERR(meta);
-				goto out_unmap;
-			}
-			req->cmd_flags |= REQ_INTEGRITY;
-			*metap = meta;
+		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
+		kfree(iov);
+	}
+	bio = req->bio;
+	if (ret)
+		goto out_unmap;
+	if (bdev)
+		bio_set_dev(bio, bdev);
+	if (bdev && meta_buffer && meta_len) {
+		meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
+				meta_seed, req_op(req) == REQ_OP_DRV_OUT);
+		if (IS_ERR(meta)) {
+			ret = PTR_ERR(meta);
+			goto out_unmap;
 		}
+		req->cmd_flags |= REQ_INTEGRITY;
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
@@ -141,13 +145,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	struct bio *bio;
 	int ret;
 
-	req = nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
-			meta_len, meta_seed, &meta, timeout, vec, 0, 0);
+	req = nvme_alloc_user_request(q, cmd, timeout, 0, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	bio = req->bio;
+	ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
+			meta_len, meta_seed, &meta, vec);
+	if (ret)
+		goto out;
 
+	bio = req->bio;
 	ret = nvme_execute_passthru_rq(req);
 
 	if (result)
@@ -157,6 +164,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 						meta_len, ret);
 	if (bio)
 		blk_rq_unmap_user(bio);
+out:
 	blk_mq_free_request(req);
 	return ret;
 }
@@ -418,6 +426,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	void *meta = NULL;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -457,13 +466,17 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		rq_flags |= REQ_POLLED;
 
 retry:
-	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(d.addr),
-			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, 0, &meta, d.timeout_ms ?
-			msecs_to_jiffies(d.timeout_ms) : 0, vec, rq_flags,
-			blk_flags);
+	req = nvme_alloc_user_request(q, &c,
+			d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0,
+			rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+
+	ret = nvme_map_user_request(req, nvme_to_user_ptr(d.addr),
+			d.data_len, nvme_to_user_ptr(d.metadata),
+			d.metadata_len, 0, &meta, vec);
+	if (ret)
+		goto out_err;
 	req->end_io = nvme_uring_cmd_end_io;
 	req->end_io_data = ioucmd;
 
@@ -486,6 +499,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
+out_err:
+	blk_mq_free_request(req);
+	return ret;
 }
 
 static bool is_ctrl_ioctl(unsigned int cmd)
-- 
2.25.1


