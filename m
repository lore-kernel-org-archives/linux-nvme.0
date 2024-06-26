Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E55C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lc4MBkJJg5V7b9dh7JN4sQekrc8Uu39ar65ub5yzidI=; b=c4nH4p82NPdnE0XkXTDe6z5/O9
	eBT86Sn+iYPWdYTxuXkyfhhhqaDuC+zhb0Gbn+hxSdi9MATmuG1/NmzHEl56CVqAaXQX3XZhpDiEB
	eDv7/OiseW2tE8x+9P2m5gtonVSA/veU6zeZ0oJqMjjkq3I5ziVKnOpDNfEKq9HZ5XqCwNETboOPc
	8dIPmucQl+rogQhCmy5w/MijJfimekSXRjwIXFD+ZQ2IR5yP8NdEUENKg9oYjS4aW5ogQjtvYQan7
	IxkU4DNADvfLj0F5vPUXJI2ISrmvllEi7muyUM+64M/sRGR+4MFclGC5ujHw6jP9Ado1R+dGXezaB
	9zA13Z3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR2j-00000006aVn-1jdp;
	Wed, 26 Jun 2024 11:42:29 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMR2g-00000006aTb-2jlT
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 11:42:28 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240626114223epoutp01e05fc33b3aebd484d519c2c1b70d4f41~ciyOqfpIV1613316133epoutp01R
	for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 11:42:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240626114223epoutp01e05fc33b3aebd484d519c2c1b70d4f41~ciyOqfpIV1613316133epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719402143;
	bh=Lc4MBkJJg5V7b9dh7JN4sQekrc8Uu39ar65ub5yzidI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fj6QdUHNB4opKGxHiICO6NGQANYtMqtxPwuIyIeFAeyj4Y8gUHmSPdM+sfIx48UMm
	 4zZcfItGTW0jeTjKcCHIkAjTIl35igqfjZHnhlTq0zj1NjifdniioOTSz8RIEOPO2z
	 yviER/qlDQlGBPO0gfdV3mz9H2GWBCpAkbltHG/U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240626114222epcas5p10bd1c047e8792f9dab1b780604d44b44~ciyOQVgNm3039430394epcas5p1j;
	Wed, 26 Jun 2024 11:42:22 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W8KYm29XLz4x9Pq; Wed, 26 Jun
	2024 11:42:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.56.07307.C9EFB766; Wed, 26 Jun 2024 20:42:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101518epcas5p17e046bca77b218fc6914ddeb182eb42e~chmMexGyY1565315653epcas5p1C;
	Wed, 26 Jun 2024 10:15:18 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240626101518epsmtrp280c286a42092f5e508e450312f9596b8~chmMeCAQH1237112371epsmtrp2R;
	Wed, 26 Jun 2024 10:15:18 +0000 (GMT)
X-AuditID: b6c32a44-3f1fa70000011c8b-f4-667bfe9cc062
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.4C.18846.53AEB766; Wed, 26 Jun 2024 19:15:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240626101516epsmtip1583ec8eff4ee86836d17d00a6e74a766~chmLATaVu0147101471epsmtip1R;
	Wed, 26 Jun 2024 10:15:16 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v2 04/10] block: Handle meta bounce buffer correctly in case
 of split
Date: Wed, 26 Jun 2024 15:36:54 +0530
Message-Id: <20240626100700.3629-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmuu6cf9VpBqt381k0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8WkQ9cYLfbe0raYv+wpu8Xy4/+YLCZ2XGVy4PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5vHx6e3WDze77vK5tG3ZRWjx+dNcgGcUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM/b8mchY8Jun4sjVNSwNjA+5
	uhg5OSQETCS2f93E3sXIxSEksJtRYv3Nk2wgCSGBT4wSD2ZFQySA7CePnwJVcYB1POp1gYjv
	ZJRoXvGMEcL5zChxYs5VRpBuNgF1iSPPW8FsEYFaiZWt09lBbGaBOolZN/6D2cIC4RL7tm1m
	AbFZBFQljk9cA7aAV8BC4vg5Fojr5CVmXvoOVs4pYClxZ/N2sJG8AoISJ2c+YYEYKS/RvHU2
	M8gNEgIzOSQ2tP5mg2h2kdg4cz4jhC0s8er4FnYIW0ri87u9UDXpEj8uP2WCsAskmo/tg6q3
	l2g91c8Mcg+zgKbE+l36EGFZiamn1jFB7OWT6P39BKqVV2LHPBhbSaJ95RwoW0Ji77kGKNtD
	4ubZx8yQwO1hlOjq5ZvAqDALyTuzkLwzC2HzAkbmVYySqQXFuempyaYFhnmp5fAoTs7P3cQI
	TrdaLjsYb8z/p3eIkYmD8RCjBAezkghvaElVmhBvSmJlVWpRfnxRaU5q8SFGU2BwT2SWEk3O
	Byb8vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamE757HzEM73t
	vrwx47Or68zWMi2TnLjB4ptm6BKV8BaFX/O+fFK3nxLzOrdhVtjZ5o4He23Mb6+KE/+l++BH
	4cELN/iTNx1fZ2RqfrDFdFOuWoXirFnXJS7Fdq/YbHJ4Y9fDtq2bhU7uXreps+j3esWYh6Lz
	K/uXmL69znd1xanrGz4rLw1oEVIz3JN9QaKwu3ry81DfXTcrD9/5unZHNufidqetnPeubeVJ
	fRsaHD1zqoBo5trsNv1XnJpKx18veq5U8ek79z2bE3vvGl33frNR6Gy+DV9YYHyiREnkhWtc
	zfkBBRzNAcWzFYLiw/dcWXj44YN/XRaZn/y+hqkJ2Ut7rFx/eK6QSTxn7x7d3OVKLMUZiYZa
	zEXFiQDOylAoQAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnK7pq+o0g913rSyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxWLSoWuMFntvaVvMX/aU3WL58X9MFhM7rjI5cHnsnHWX3ePy2VKP
	Tas62Tw2L6n32H2zgc3j49NbLB7v911l8+jbsorR4/MmuQDOKC6blNSczLLUIn27BK6MPX8m
	Mhb85qk4cnUNSwPjQ64uRg4OCQETiUe9Ll2MXBxCAtsZJb7dm83excgJFJeQOPVyGSOELSyx
	8t9zdoiij4wSV5ceBCtiE1CXOPK8lREkISLQyihxYGoLmMMs0MQoserBCTaQKmGBUIk/XT/B
	bBYBVYnjE9ewg6zmFbCQOH6OBWKDvMTMS9/BhnIKWErc2bwdbLMQUMmD582sIDavgKDEyZlP
	wOqZgeqbt85mnsAoMAtJahaS1AJGplWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwfGgFbSD
	cdn6v3qHGJk4GA8xSnAwK4nwhpZUpQnxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8s
	Sc1OTS1ILYLJMnFwSjUwzf7QLnUq27/vkpKufd8kxtTbMZ6r1uyZ9PpS9XnmWybvXr+ZWP95
	zZeZX6KmqN+f+em0n0+k17bH+8zlNmu9qrjFXmn0S154vm9NuF/1vxSHbX8+pokLXlGfmlN3
	Zm29XWfo06tbH3v+msyu9OBwuqPGgtTlim37/yVczjnafZxtYsPFrS7R677fmSM4/+4cj/nP
	81fkbey7Zae4kId3xep92h6qpoutHjolbVr/5eush44M3it2ZtmlbDz0l6lde6eMVm6D6MJG
	xtjd3P9KtN/+u+l+qk3r102d9K1FW3/Gn1MX+JS9cFHS+x3OxaWzH/TWzp20TlU8r+TmtuLU
	Mq/EU/eehfEHpi7dJ1ZtOkeJpTgj0VCLuag4EQBUMUEj9gIAAA==
X-CMS-MailID: 20240626101518epcas5p17e046bca77b218fc6914ddeb182eb42e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626101518epcas5p17e046bca77b218fc6914ddeb182eb42e
References: <20240626100700.3629-1-anuj20.g@samsung.com>
	<CGME20240626101518epcas5p17e046bca77b218fc6914ddeb182eb42e@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_044227_303023_3D2711EB 
X-CRM114-Status: GOOD (  17.98  )
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

Do not inherit BIP_COPY_USER for cloned bio.
Also make sure that bounce buffer is copied back to user-space in
entirety when the parent bio completes.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 5e7596b74ef1..845d4038afb1 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -105,9 +105,12 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
+	struct bio *bio = bip->bip_bio;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
 	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
+	size_t bytes = bio_integrity_bytes(bi,
+					   bvec_iter_sectors(bip->bio_iter));
 	struct iov_iter iter;
 	int ret;
 
@@ -277,6 +280,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	bip->bip_flags |= BIP_INTEGRITY_USER | BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_vcnt = nr_vecs;
+	bip->bio_iter = bio->bi_iter;
 	return 0;
 free_bip:
 	bio_integrity_free(bio);
@@ -656,8 +660,8 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	bip->bip_vcnt = bip_src->bip_vcnt;
 	bip->bip_iter = bip_src->bip_iter;
-	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
-
+	bip->bip_flags = bip_src->bip_flags & ~(BIP_BLOCK_INTEGRITY |
+						BIP_COPY_USER);
 	return 0;
 }
 
-- 
2.25.1


