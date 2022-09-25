Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76766C6FA82
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvisQxDCCiY/YZ3UCOZ2Bjwz4ZAQa8PRkCgpg4Fkog4=; b=zCa9l34dHB/JgfiWL9IWZLeF7y
	KcVTVkGUHOWs9J642EJ32o1oZ0d2JiujsenLOP6fgj3Hv5iua7QX5HQsJ9xYYKGnuzIU3gjb8dgjY
	vyy0ZIuSTcrRFatlAUwOt/9D6k7vC4ci368wL3Gx/HjRWwuwqdS8DGY0KE9S0aXSQ6YfpqIJW9wn7
	M4qKHkQVMgYyI8jWzRmZEijxygO3wc7xfWHMhxKQ8ggOcpPYMMoKZUKFB6m+E2aX6V6J4IsIJH9tp
	Vrp+hoYFRIl/lPJUxI+8QE+8IO1xBZPTV/JZPLe96c0/7B6KNMUjO4YsJsNf3bCZhguWG73cob6cp
	QgwKt/sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocYJo-00GRrX-WD; Sun, 25 Sep 2022 20:33:41 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocYJm-00GRmS-7l
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 20:33:40 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220925203332epoutp0166611773c9eccc2bd1cb5cb6996f3344~YNLSqBlF91954619546epoutp01w
	for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 20:33:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220925203332epoutp0166611773c9eccc2bd1cb5cb6996f3344~YNLSqBlF91954619546epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664138012;
	bh=YvisQxDCCiY/YZ3UCOZ2Bjwz4ZAQa8PRkCgpg4Fkog4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPlogZbhuT7uerT2YDoKPEDMrEyfFRwauYPAKibVec8ajg76xi8QG56YOWd6HHify
	 PzLHlBM9JX9hi8EL3rPnjPvGpXsOQm03hG7dghvc51UnTPxe+uIwAkWdicZzNkEOsz
	 Up2n/Udh+UAGusEGslmzghDNiNF+ajBdoXS4oKGw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220925203331epcas5p21f5dc19cc6f58a8e49e773e4449e7091~YNLROT9ia0635906359epcas5p2T;
	Sun, 25 Sep 2022 20:33:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MbHf03gZXz4x9Pv; Sun, 25 Sep
	2022 20:33:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.DF.56352.81BB0336; Mon, 26 Sep 2022 05:33:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220925203328epcas5p1872214ededaf3b75762dcb5af15199da~YNLOMXBtq0458804588epcas5p1D;
	Sun, 25 Sep 2022 20:33:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220925203328epsmtrp2d3c4637b5c4e6b4c4cc3a7edad3933a7~YNLOJDqs-1586315863epsmtrp2I;
	Sun, 25 Sep 2022 20:33:28 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-76-6330bb1897ca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.1A.18644.71BB0336; Mon, 26 Sep 2022 05:33:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220925203326epsmtip1e21d4e04714bed193e77562734905d21~YNLM7Hh9q0205602056epsmtip1L;
	Sun, 25 Sep 2022 20:33:26 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next v9 3/7] nvme: refactor nvme_add_user_metadata
Date: Mon, 26 Sep 2022 01:53:00 +0530
Message-Id: <20220925202304.28097-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925202304.28097-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTU1dit0GywdMp4har7/azWdw8sJPJ
	YuXqo0wW71rPsVgc/f+WzWLSoWuMFntvaVvMX/aU3YHD4/LZUo9NqzrZPDYvqffYfbOBzaNv
	yypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
	dN0yc4CuUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZY
	GRoYGJkCFSZkZ+w8P4mpYK9wRcsRywbGM/xdjJwcEgImEg+OTWDpYuTiEBLYzSjx9PgxJgjn
	E6PEluYdrBDOZ0aJa8eXssO0TJnYxAyR2MUoMWv/S4SqF32z2boYOTjYBDQlLkwuBWkQETCS
	2P/pJFgNs8AMRonVHa/ZQWqEBdwkdh3hBKlhEVCV+HziBQuIzStgIbH1zidGiGXyEjMvfQdb
	zClgKfFk7lZmiBpBiZMzn4DVMwPVNG+dDXaQhMBXdolVy05BNbtIfOnpgrpaWOLV8S1QtpTE
	53d72SDsZIlLM88xQdglEo/3HISy7SVaT/Uzg9zJDPTL+l36ELv4JHp/P2ECCUsI8Ep0tAlB
	VCtK3Jv0lBXCFpd4OGMJlO0hcbXvBjREexgl2l9PZ5rAKD8LyQuzkLwwC2HbAkbmVYySqQXF
	uempxaYFxnmp5fB4Tc7P3cQITpNa3jsYHz34oHeIkYmD8RCjBAezkghvykXdZCHelMTKqtSi
	/Pii0pzU4kOMpsAwnsgsJZqcD0zUeSXxhiaWBiZmZmYmlsZmhkrivItnaCULCaQnlqRmp6YW
	pBbB9DFxcEo1MBWbnXsnoipSeH92Y2zW3J1XrySuuBDap6EeX/eB+bVW1J7t1VGzX2UVdrMG
	ef26UKzlbjg1dqPY+4Q+1ovM1Xmb/otm/hL5zX/kY/JR5ykXlbi3aUqYZ74od9r21SV9o8Hc
	4g2PC5/k9zhGXMleeL9k7kS+pDf/5H7nvZMo46rwv5ibc1e2T0P326HyJP039l9YX7FM90/K
	ENOIaZKwY/QJn3LyoPqPqq2v+OLWnQ18+++FjeD8oNV9sttF+sLOc+mv55zPObvzsfvengim
	3Y5yM1rl9Dhevn5tI2KwKeWsp+AlZed/lx59MVa3DZv8Lef5Cb71Vg4KFukLndkC5X5HzWDw
	OSBfHDY18th2JZbijERDLeai4kQA+827ZRwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnK74boNkg1vvzCxW3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpuwOHx+WzpR6bVnWyeWxeUu+x+2YDm0ff
	llWMHp83yQWwRXHZpKTmZJalFunbJXBl7Dw/ialgr3BFyxHLBsYz/F2MnBwSAiYSUyY2MXcx
	cnEICexglNjR1cAOkRCXaL72A8oWllj57zk7RNFHRok3fU0sXYwcHGwCmhIXJpeC1IgImEks
	PbyGBaSGWWAOo8Tly3vYQWqEBdwkdh3hBKlhEVCV+HziBQuIzStgIbH1zidGiPnyEjMvfQfb
	xSlgKfFk7lZmkFYhkJrzWhDlghInZz4Ba2UGKm/eOpt5AqPALCSpWUhSCxiZVjFKphYU56bn
	FhsWGOWllusVJ+YWl+al6yXn525iBIe3ltYOxj2rPugdYmTiYDzEKMHBrCTCm3JRN1mINyWx
	siq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJt38uGUu21ud9x+a
	PHH2tyUnlk+XncGxNXfhj8uVoa5zH+bHbXJo37xYZfO8YE2eewEq1/aW26wv3rG8LF6+60a0
	YMafXoYwOZ/bCp3r3JSaJopPFl+asub5fi3FS3P3qkquvGB7IjHW6uNUT5PEIyfzQy25aj69
	ucYh+4WN/Z3ajjVWbDOjWz6/3NC7+qvqrH+qvQs6v8qXvdjfM9tzyg/x5WwzN3zZn99d2/nf
	MPqP8eMqD35Lm2civ97H6K7n2BIYVMS8Z2bctD3LWpiWrVh5Uszm4BxH5ddvmHc2OZmqT8lO
	2XkrqCex6R2fpp/71KWScW1Tz4o97F81//+NP+9fyEmZS7nteiezvXbJ8UIlluKMREMt5qLi
	RADkQPBL3gIAAA==
X-CMS-MailID: 20220925203328epcas5p1872214ededaf3b75762dcb5af15199da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220925203328epcas5p1872214ededaf3b75762dcb5af15199da
References: <20220925202304.28097-1-joshi.k@samsung.com>
	<CGME20220925203328epcas5p1872214ededaf3b75762dcb5af15199da@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_133338_649499_360F3525 
X-CRM114-Status: GOOD (  19.29  )
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

Pass struct request rather than bio. It helps to kill a parameter, and
some processing clean-up too.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 548aca8b5b9f..8f8435b55b95 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -20,19 +20,20 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
-static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
-		unsigned len, u32 seed, bool write)
+static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
+		unsigned len, u32 seed)
 {
 	struct bio_integrity_payload *bip;
 	int ret = -ENOMEM;
 	void *buf;
+	struct bio *bio = req->bio;
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto out;
 
 	ret = -EFAULT;
-	if (write && copy_from_user(buf, ubuf, len))
+	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
 		goto out_free_meta;
 
 	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
@@ -45,9 +46,13 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	bip->bip_iter.bi_sector = seed;
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf));
-	if (ret == len)
-		return buf;
-	ret = -ENOMEM;
+	if (ret != len) {
+		ret = -ENOMEM;
+		goto out_free_meta;
+	}
+
+	req->cmd_flags |= REQ_INTEGRITY;
+	return buf;
 out_free_meta:
 	kfree(buf);
 out:
@@ -70,7 +75,6 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 		u32 meta_seed, void **metap, unsigned timeout, bool vec,
 		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)
 {
-	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	struct request *req;
@@ -110,13 +114,12 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 		if (bdev)
 			bio_set_dev(bio, bdev);
 		if (bdev && meta_buffer && meta_len) {
-			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
-					meta_seed, write);
+			meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
+					meta_seed);
 			if (IS_ERR(meta)) {
 				ret = PTR_ERR(meta);
 				goto out_unmap;
 			}
-			req->cmd_flags |= REQ_INTEGRITY;
 			*metap = meta;
 		}
 	}
-- 
2.25.1


