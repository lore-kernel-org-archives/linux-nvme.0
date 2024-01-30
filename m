Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33BEC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALi6WQHoGA/cfYwa5637ScTtBXJR1LHhfdOZtxic6Kc=; b=QDMZwkfn6TYN/i1i/W6yl0X+7L
	qZGjjOmdEqAqb7ch1UFQZgyt3GFNpsGLoyLz/HIMBd1UxY+5eYOCJDn1wQPtIsouJg9oxIsPDhzqJ
	X+PMEQPOm3zQ39IQWH6ydKlU3HtMr6fcq2LLgBxhXnfyGZXut/ibR5oKUy/UfTgDummqRK2Vb/iSI
	5I+J7/hh55limO3oUm2y4xdoOwxMvkdqiG8dUs1hhDS/wjVeoRYcwK3+9LmPG0HeBw3XNUr9c22/G
	FflXmeZXltZwcSvL6O+lKOabEmI8LVfKweq36Vxai+zGTA2LKc8X0jr3/dTxGSUvzqlKQEW4Y25A/
	dk1nyHpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUrlo-0000000HXGN-1tdK;
	Tue, 30 Jan 2024 17:19:36 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUrlj-0000000HXCt-0IKw
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 17:19:34 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240130171926epoutp01c1702f119d3ba99c8d3579ddbccfb2ee~vL6RIDScw0779607796epoutp01Q
	for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 17:19:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240130171926epoutp01c1702f119d3ba99c8d3579ddbccfb2ee~vL6RIDScw0779607796epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706635166;
	bh=ALi6WQHoGA/cfYwa5637ScTtBXJR1LHhfdOZtxic6Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czboqW6LLPb3hDW9qZkFd1oc8VELYNe8LbZL1g4Tz5c+wBeyKPvzDWUpEOske8n8i
	 zaRW9y/OB7hSJNisxlAej21lCzMyKdfak3fKIsoshLz/iYehZnhXQ7fqJdugHeSb2l
	 gVi/3LpzkObbpyAWMfNXbQStJHIYmYdUnfAIXmKI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240130171925epcas5p43e53cc0bfc705f5647530a6dad166ee1~vL6QhS5ub0368303683epcas5p4q;
	Tue, 30 Jan 2024 17:19:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TPX300YzBz4x9Px; Tue, 30 Jan
	2024 17:19:24 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.58.09672.B9F29B56; Wed, 31 Jan 2024 02:19:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240130171923epcas5p4610296779861b362ef98f3b6f819a060~vL6OfCIF70368303683epcas5p4l;
	Tue, 30 Jan 2024 17:19:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240130171923epsmtrp1a3dda622b729f517c933658ecc49ce3a~vL6Oect2H2451024510epsmtrp12;
	Tue, 30 Jan 2024 17:19:23 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-a8-65b92f9ba434
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.32.18939.B9F29B56; Wed, 31 Jan 2024 02:19:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171922epsmtip20a28b01d04b99caf8ec772b551b7b325~vL6NGotzk1616116161epsmtip20;
	Tue, 30 Jan 2024 17:19:21 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/3] block: refactor guard helpers
Date: Tue, 30 Jan 2024 22:42:04 +0530
Message-Id: <20240130171206.4845-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130171206.4845-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu5s/Z2pBv/XWFmsvtvPZnHzwE4m
	i5WrjzJZHP3/ls1i0qFrjBZ7b2lbzF/2lN1i+fF/TBbrXr9nceD0OH9vI4vH5bOlHptWdbJ5
	bF5S77H7ZgObx8ent1g8+rasYvT4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
	UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
	ToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG19THjAXPxSoO793F0sB4T6iLkZNDQsBEouHi
	MuYuRi4OIYHdjBJ39r9mg3A+MUrMvb6eEc559XY3C0zLwhW9TBCJnYwSf540QPV/ZpTYvWEB
	axcjBwebgKbEhcmlIA0iAkkS2958ZgOxmQVqJC7fPc0EYgsLGEnMWnUQbCiLgKrEl9XLwWp4
	BcwlJnxawgqxTF5i5qXv7CA2p4CFRN/Kx4wQNYISJ2c+YYGYKS/RvHU22A0SAq0cEl9/3mMC
	uUFCwEXi79QEiDnCEq+Ob2GHsKUkXva3QdnJEpdmnmOCsEskHu85CGXbS7Se6mcGGcMM9Mr6
	XfoQq/gken8/gZrOK9HRBg1FRYl7k55CXSwu8XAGzPUeEvOurGAGsYUEuhklVt1TnsAoPwvJ
	A7OQPDALYdkCRuZVjJKpBcW56anFpgXGeanl8GhNzs/dxAhOoVreOxgfPfigd4iRiYPxEKME
	B7OSCO9KuZ2pQrwpiZVVqUX58UWlOanFhxhNgSE8kVlKNDkfmMTzSuINTSwNTMzMzEwsjc0M
	lcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgSnvg+/yGO/PzzT4aX35eddWuuv1srovrAV//
	92urp86xYdsd73ElpE89XGRXcZZFjMVHPdetP372zZn6fcsEu5qZyrV9W37FzKz3Oed1JLxY
	6P40/ZjtGV6+TgZlnyZsc+pkveaRccty9pTadZbGDJFx+9gmPvo2L7UqODXxs1q1rpv8sy1z
	hCevu1Cu9XeHT7vWzQrnvfNVT/s8rdx9b+rBh5nflue9m/z3EeuBqBeTmu/fevN5TsS8EM/p
	oT6FZWmNOwVS7kZoPjrAF//dWW5a3Kl7TidTFjo8nCkg0rH2vKzt6rMxi/5v0L315OkHRf/9
	vE3zv7TsZDa+lnhDZPmsFbXzDM6Hvigr4JPNvKTEUpyRaKjFXFScCAClYlx2KgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvO5s/Z2pBjumy1msvtvPZnHzwE4m
	i5WrjzJZHP3/ls1i0qFrjBZ7b2lbzF/2lN1i+fF/TBbrXr9nceD0OH9vI4vH5bOlHptWdbJ5
	bF5S77H7ZgObx8ent1g8+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK6Nr6mPGgudiFYf37mJp
	YLwn1MXIySEhYCKxcEUvUxcjF4eQwHZGiW+3DjBCJMQlmq/9YIewhSVW/nvODlH0kVGid+F7
	oA4ODjYBTYkLk0tBakQEMiRmr/4GVsMs0MAose71LiaQhLCAkcSsVQdZQGwWAVWJL6uXs4HY
	vALmEhM+LWGFWCAvMfPSd7BlnAIWEn0rH4MdIQRUs/TPWWaIekGJkzOfgM1hBqpv3jqbeQKj
	wCwkqVlIUgsYmVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBIe+VtAOxmXr/+odYmTiYDzE
	KMHBrCTCu1JuZ6oQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMH
	p1QDk/SHzK0lb5ZMu6Bx9LNe8Ku0GRrlS6bdltS0bjjzK0df2UZ25WWBc+ezXhUfP+M4f7NH
	5peU208cdkmtLCyd7cFQJVaVp3JL/nhKY5d2d+SiJe9rlvCdSjAs0LjMqiL56KxYmbha0+P9
	Fm2X+GJcxK7+bN80Qz9u62XlV4f8VgncUTfpOeAsUSP/QPYS6/G96TEbBcS1z0YVCq17+Eds
	/luv3GMnjstma7VY5Rm9+vHgwP/cQ+EyNQH8nFWs8ys5PyfpX5X80rG5Y9bVkt8JUQ/Em6er
	XTik/2fJe6m7Xh+8tJ8/vyfQmn58zeGT7izl4uzR655zRqW2aHksE75vGV4r8WXrw+dr9rHL
	X+LTVGIpzkg01GIuKk4EAEZWghrsAgAA
X-CMS-MailID: 20240130171923epcas5p4610296779861b362ef98f3b6f819a060
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130171923epcas5p4610296779861b362ef98f3b6f819a060
References: <20240130171206.4845-1-joshi.k@samsung.com>
	<CGME20240130171923epcas5p4610296779861b362ef98f3b6f819a060@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_091932_623766_9F838AE8 
X-CRM114-Status: GOOD (  17.31  )
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

Allow computation using the existing guard value.
This is a prep patch.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/t10-pi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 914d8cddd43a..251a7b188963 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -12,14 +12,14 @@
 #include <net/checksum.h>
 #include <asm/unaligned.h>
 
-typedef __be16 (csum_fn) (void *, unsigned int);
+typedef __be16 (csum_fn) (__be16, void *, unsigned int);
 
-static __be16 t10_pi_crc_fn(void *data, unsigned int len)
+static __be16 t10_pi_crc_fn(__be16 crc, void *data, unsigned int len)
 {
-	return cpu_to_be16(crc_t10dif(data, len));
+	return cpu_to_be16(crc_t10dif_update(be16_to_cpu(crc), data, len));
 }
 
-static __be16 t10_pi_ip_fn(void *data, unsigned int len)
+static __be16 t10_pi_ip_fn(__be16 csum, void *data, unsigned int len)
 {
 	return (__force __be16)ip_compute_csum(data, len);
 }
@@ -37,7 +37,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
 		struct t10_pi_tuple *pi = iter->prot_buf;
 
-		pi->guard_tag = fn(iter->data_buf, iter->interval);
+		pi->guard_tag = fn(0, iter->data_buf, iter->interval);
 		pi->app_tag = 0;
 
 		if (type == T10_PI_TYPE1_PROTECTION)
@@ -83,7 +83,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 				goto next;
 		}
 
-		csum = fn(iter->data_buf, iter->interval);
+		csum = fn(0, iter->data_buf, iter->interval);
 
 		if (pi->guard_tag != csum) {
 			pr_err("%s: guard tag error at sector %llu " \
@@ -280,9 +280,9 @@ const struct blk_integrity_profile t10_pi_type3_ip = {
 };
 EXPORT_SYMBOL(t10_pi_type3_ip);
 
-static __be64 ext_pi_crc64(void *data, unsigned int len)
+static __be64 ext_pi_crc64(u64 crc, void *data, unsigned int len)
 {
-	return cpu_to_be64(crc64_rocksoft(data, len));
+	return cpu_to_be64(crc64_rocksoft_update(crc, data, len));
 }
 
 static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
@@ -293,7 +293,7 @@ static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
 		struct crc64_pi_tuple *pi = iter->prot_buf;
 
-		pi->guard_tag = ext_pi_crc64(iter->data_buf, iter->interval);
+		pi->guard_tag = ext_pi_crc64(0, iter->data_buf, iter->interval);
 		pi->app_tag = 0;
 
 		if (type == T10_PI_TYPE1_PROTECTION)
@@ -343,7 +343,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 				goto next;
 		}
 
-		csum = ext_pi_crc64(iter->data_buf, iter->interval);
+		csum = ext_pi_crc64(0, iter->data_buf, iter->interval);
 		if (pi->guard_tag != csum) {
 			pr_err("%s: guard tag error at sector %llu " \
 			       "(rcvd %016llx, want %016llx)\n",
-- 
2.25.1


