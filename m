Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B5C48291
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iuRQg71KLk8ZUg2PsrQtiu0FAikWWEbLTq4Nl/5r9M=; b=l8PePMpLLxNjmlGGmU8H3uuVms
	cg5tqQTjJVAhwHr8K73ch82qUNfaUPkKdK46NBR8qS+BL3iJWTVdShfOBXDnGD6ZioXPob1skr2MP
	yuWgNV5L8Rhk7IXH6Hbby9opwyfECaRw/e6ETAS3aRPf4ZmH78YPajMb3afnuSGFPlomKsiJLpeS6
	zLU7QQ1oFcrdYhop5kQceaxz0W99946PBFIij6vsfKpTWWqcF1UqlBNXUfNZmMaFeWAZ6mMj22Qu1
	E7LI73k2h29XOiuJ8G/nqPxy+e7MjWMHCP03p7EG9nTpFBboxjPgslHt5pBP1JiVOnqruRs5umlzf
	uv+atUTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVXGl-000000087H3-0Ojc;
	Thu, 01 Feb 2024 13:38:19 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVWo8-00000007v3I-0ljl
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 13:08:46 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240201130841epoutp02c350e1103cc8d13e073fa2aee8ed94aa~vvx6A0Nxc3178131781epoutp02j
	for <linux-nvme@lists.infradead.org>; Thu,  1 Feb 2024 13:08:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240201130841epoutp02c350e1103cc8d13e073fa2aee8ed94aa~vvx6A0Nxc3178131781epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706792921;
	bh=0iuRQg71KLk8ZUg2PsrQtiu0FAikWWEbLTq4Nl/5r9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRrsyU5xGlIgnZwBKO7BX4rML8Kzqp0spz2R/Q1QAY+jp7L7gufrwnjB2bShAUf93
	 x9ayglci9shMMaG/pSN/RycRvo2QFvjul5YRs6qHjQY2mLp+nLqmNU24Nuabhau+IM
	 6xPCGlf4QV0FnoGIU9mPrkDydRiAs7hzP51R6rHY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240201130841epcas5p484c27ddda308ffbd9ce3f9dda28c5637~vvx5rMVQF1157611576epcas5p4E;
	Thu,  1 Feb 2024 13:08:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TQfNl3KvBz4x9Pt; Thu,  1 Feb
	2024 13:08:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.4E.10009.7D79BB56; Thu,  1 Feb 2024 22:08:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240201130839epcas5p363ac7d73a6f83eff79fde4cc1535712d~vvx314aat0679906799epcas5p3G;
	Thu,  1 Feb 2024 13:08:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240201130839epsmtrp25e32aa8ef96f85100bf2b7cc3f3775ad~vvx31PKCF2690026900epsmtrp2I;
	Thu,  1 Feb 2024 13:08:39 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-f0-65bb97d7f7e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.3C.08755.7D79BB56; Thu,  1 Feb 2024 22:08:39 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240201130836epsmtip1646d4c344c94e063c77e5fbddeb4ae0c~vvx1hB92k1933619336epsmtip1T;
	Thu,  1 Feb 2024 13:08:36 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 1/3] block: refactor guard helpers
Date: Thu,  1 Feb 2024 18:31:24 +0530
Message-Id: <20240201130126.211402-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmuu716btTDVbukrBYfbefzeLmgZ1M
	FitXH2WyOPr/LZvFpEPXGC323tK2mL/sKbvF8uP/mCzWvX7P4sDpcf7eRhaPy2dLPTat6mTz
	2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
	oa6hpYW5kkJeYm6qrZKLT4CuW2YO0HFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
	nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMB9ceMBWsl6jY+moWUwPjRJEuRk4OCQETieMP
	drJ2MXJxCAnsZpR4uXQxM4TziVHi3be7TBDON0aJRzdXM8O0fFt0jwUisZdRYtOHe1BVnxkl
	Whq2AWU4ONgENCUuTC4FaRARSJL42HeeEcRmFqiRuHz3NBOILSxgKjHh/FUWEJtFQFVixeP5
	YAt4BSwlzu1ZzgaxTF5i5qXv7CA2p4CVRP+UdjaIGkGJkzOfsEDMlJdo3job7GwJgV4OiSuf
	F0A1u0jM2/kF6mphiVfHt7BD2FISn9/thapJlrg08xwThF0i8XjPQSjbXqL1VD8zyC/MQL+s
	36UPsYtPovf3EyaQsIQAr0RHmxBEtaLEvUlPWSFscYmHM5ZA2R4SUz69g4ZVL6NE69qzzBMY
	5WcheWEWkhdmIWxbwMi8ilEytaA4Nz212LTAKC+1HB6xyfm5mxjBaVTLawfjwwcf9A4xMnEw
	HmKU4GBWEuFdKbczVYg3JbGyKrUoP76oNCe1+BCjKTCMJzJLiSbnAxN5Xkm8oYmlgYmZmZmJ
	pbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTPN+hbjkcb6c53H3y92zTSV9BZ9CV2gy
	zN3Q5beQ8cDWF7lxDF13o6r/+AUen5a1pS9hxQsuy8X8Pfs2Rbe9uvfoSfgmroz7k1+r3nyu
	ZbD4+B8hLfVngYunRG9nvCCmf7C5LT54u/7/xAfc62TWfXPfnnvXM+jHJLmCuXbXIxbwTCzZ
	JX35T1JCtmr7IeE1TucWVkcVht8IPf37/ANu5UJrC29l/67n6zomys3K2r5c/RLLX+0J7dPX
	aE9YuP6eja6sXVmIrNjEnxOZmO/HfHltNM0o0c4m+pr0gbs6ekzbdST9BfI9zr6a4T/xtGbd
	uoonW6PXnt+tbpKmWfK8an///MJ7syt2PN4y78HG5/OUWIozEg21mIuKEwGUShlqLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnO716btTDRZ9YrdYfbefzeLmgZ1M
	FitXH2WyOPr/LZvFpEPXGC323tK2mL/sKbvF8uP/mCzWvX7P4sDpcf7eRhaPy2dLPTat6mTz
	2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAEcUl01Kak5mWWqRvl0CV8aDaw+YCtZLVGx9NYup
	gXGiSBcjJ4eEgInEt0X3WLoYuTiEBHYzShx8vI4VIiEu0XztBzuELSyx8t9zdoiij4wSD1pW
	MHUxcnCwCWhKXJhcClIjIpAh0fF7BjNIDbNAA6PEute7mEASwgKmEhPOX2UBsVkEVCVWPJ7P
	DGLzClhKnNuznA1igbzEzEvfwZZxClhJ9E9pB4sLAdVMmz2FHaJeUOLkzCdgc5iB6pu3zmae
	wCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwTGgpbmDcfuqD3qH
	GJk4GA8xSnAwK4nwrpTbmSrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampB
	ahFMlomDU6qBiaN+j2MjX5ORlP6ZsGcKU7v7H9y+2sTiJ+Xi9dGrfd6NLbM11j9a8sXQNSB9
	aYvRj8yFZSZskVdsD+YFbeJcU/nj5//YPZ3+TdG2Frf9BT4EGO45ZOqfbMf4WueC/bTfaRee
	r8wP0vVJVvF7+dfGWyT62sX4njAuiTT7RSHL99y7sDbKXvzn9PY3Byf8F1+2woD1OL+shZej
	E8vxNXf2b778/e/36Os568Py7p0WNmfs3dX+a9M0zxky139GTZX/FHZse+a331daE03O5pWb
	zjMyifI8K7uw5llr0rL7170+6VubzLJblLFE1+T+csOVk+9ap/YvlUwKYpip/3bVNJtsE18b
	5gVz5K9euPp3ohJLcUaioRZzUXEiAPYwVSHwAgAA
X-CMS-MailID: 20240201130839epcas5p363ac7d73a6f83eff79fde4cc1535712d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130839epcas5p363ac7d73a6f83eff79fde4cc1535712d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130839epcas5p363ac7d73a6f83eff79fde4cc1535712d@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_050844_592871_8B6A3873 
X-CRM114-Status: GOOD (  16.42  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


