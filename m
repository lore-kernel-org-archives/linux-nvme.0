Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19CD132DF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6LNHR2UxOEOGCqUSfrJ4D/dcAXYHqklNM5hsVN/lLY=; b=enADPWTJ1B0+I2FNZbhSRIXdIB
	WuHcdFQasS3S290CCNo8aeCMpy+vYkW8raXcaCSkb+vj70dMBFjNj78XJTLn0xr6clbt+37IaMD1k
	GPFZy4Ox64c11Q5e56Es/9DZezu6f8VSIPo+d3MKy1gVArRh5ubH8Zer3NIuTM9Duvz8t8XGqKAh7
	3RrnBlmgxiJx9IS5iJF7j8/nXr/Jh204QES3KjfQ2HswPeoCsjlFSwSBhrfRYp1A2HEeIzANkznT3
	4SMKG/8iY62AsZ+yc35zdu/ImEzIw5elbB2ynkDfK7qnLlLhm6GevRB+KIDoJiaJAR5t3bmNWrjfn
	1kgQL4oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zQy-0000000EHBN-3LxB;
	Mon, 04 Nov 2024 15:56:04 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zQu-0000000EH9q-25iu
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 15:56:03 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241104155556epoutp01e5f5208b85eee57b1c69efc49a55d3f9~EzwA610rN2173721737epoutp01B
	for <linux-nvme@lists.infradead.org>; Mon,  4 Nov 2024 15:55:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241104155556epoutp01e5f5208b85eee57b1c69efc49a55d3f9~EzwA610rN2173721737epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730735756;
	bh=n6LNHR2UxOEOGCqUSfrJ4D/dcAXYHqklNM5hsVN/lLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snOvUU0PhjyxpXJ0ImpouSfoOsbjXA5lfd5QXcVj6VGLtDO59E/InvIWbbbJyc+Av
	 SPWXO1sM5Yb/uZVuvLMw861feTr1e53fmIlurIyEitDLE8XVQ3waNdnx2KTUseNgF0
	 4Ig3m+PNXU7+DtPdtkurEgaFWpkXwGAdS/DlYt1c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241104155555epcas5p31d8e2563298b091b0ce53f3e20fdb636~EzwAO_2lC0957809578epcas5p3W;
	Mon,  4 Nov 2024 15:55:55 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xhwzt30BLz4x9Pq; Mon,  4 Nov
	2024 15:55:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.8A.09770.A8EE8276; Tue,  5 Nov 2024 00:55:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241104141445epcas5p3fa11a5bebe88ac2bb3541850369591f7~EyXq4_IES2421324213epcas5p35;
	Mon,  4 Nov 2024 14:14:45 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241104141445epsmtrp2e82a212506f18b40914879ef41c4ab29~EyXq1QKGv1987019870epsmtrp2t;
	Mon,  4 Nov 2024 14:14:45 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-bc-6728ee8af0d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.DC.18937.5D6D8276; Mon,  4 Nov 2024 23:14:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141443epsmtip200aef7f4c224e5aa2969207f662dc83d~EyXoYPB9E3011030110epsmtip28;
	Mon,  4 Nov 2024 14:14:42 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v7 01/10] block: define set of integrity flags to be
 inherited by cloned bip
Date: Mon,  4 Nov 2024 19:35:52 +0530
Message-Id: <20241104140601.12239-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104140601.12239-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbZRzH89wdfWHUHKULj8hmc27pwADtLOVogBnE5aLbxKkz8WXsUs4W
	6Vt6RYfTCas4xbDiFiWUruVFQIrAUnDyVpxs0gyQTXCbw6EQqAYJKODiJoK2HOj++zzf3+/7
	fO/33PMIUPENXowgz2hlLEZaT/DCsfMX4+ISShd2aeVTjihy8fYKRp4oX0VJp+c8IJsn7Dxy
	7uISIG9e6ELIpuavEXKhZAQjqypsCHm6/zogfeMPk72+yxjpbgjwyQ9udPLIRv8aQl5Z9YeR
	VxxO/qORVJdjgk+NfVNAeT3v86j2T96mem4W8ajFwDhGnerwAGq4+hKfWvZup7wz80h2+Av5
	aTqGzmUsUsaoMeXmGbXpxJPP5DyWk6ySKxIUqWQKITXSBiadyNqXnbA3Tx8ch5C+RusLglI2
	zbJEUkaaxVRgZaQ6E2tNJxhzrt6sNCeytIEtMGoTjYxVrZDLdycHG4/k6+zjDcA8uuXogN0L
	isCCsBQIBRBXwoY/7vJDLMZ7ALzgfqkUhAd5CcDO6WkeVwguTg8/tGmoa5kM4/QuAKc9LGdY
	BrD323EQKvBwGbz0SwkIFSR4L4BlNUNYaIHiswDWe2qxUFcUfhjeHngPCTGG74T+63VoiEV4
	KrzWXo9ycQ/CytE/179PiKuhc3UC43oi4eXKmXVGgz22z6vQUADEhwVw8qszfM6cBev9fTyO
	o+Cv/o4NPQYuL/g2dC28MxZAODZD20Af4HgPLBm0BzcVBAPiYFt3Eidvgx8NtiJc7n2wbGVm
	wyqCna5NJuDJJucGQ+gbKUJC20CcgsVFh7nTKgOwozqAlAOp455xHPeM4/g/uRqgHnA/Y2YN
	WoZNNu82Mq//95M1JoMXrN/w+Cc6wdTk74n9ABGAfgAFKCERuRiZVizKpQvfYCymHEuBnmH7
	QXLwvD9EY7ZqTMEnYrTmKJSpcqVKpVKmPqJSENGiuZKzuWJcS1uZfIYxM5ZNHyIQxhQhMt3j
	863Rbd83er87IbC/Gyaua3nOdqw6MjIl0xUfm+3LEJ97/scjgeEzLx9sONc4IF6TzJtashSB
	d3RD/OhdY/vXhCsRJb9lVFbNH4yI695eFbst4sWcrVKzaMBV1zcllx1yRhc3X62Ab9amgPK/
	YHiP+ueRsY/bP5XOvpX97FzZgYSZxbQH9JK/T3ZGyH5QH28jdoyAOZtbUzGrqDF4JySZX2iw
	rO67g3Nhr9Kf+UbxJnOV++ktisKFWOh46tYr+9SZqdeKz95R7lhL2p/ZQ3xZO+E5NfSTN6U+
	Y+8hU6lLqPkndtQWfrzGnXF1T8dSVuGto06Jpk5D81ckXa29x7QExupoRTxqYel/AfMyFI5q
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXvfqNY10g4s9ihYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJotJh64xWuy9pW2xZ+9JFov5
	y56yW3Rf38Fmsfz4PyaL83+Ps1qcnzWH3UHQY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHh+f
	3mLx6NuyitHjzIIj7B6fN8l5bHrylimAK4rLJiU1J7MstUjfLoEro//WMsaCS9wVx/o3MTYw
	vuPsYuTkkBAwkVi89gEriC0ksJ1RYusdMYi4hMSpl8sYIWxhiZX/nrN3MXIB1XxklFh6ewUL
	SIJNQF3iyPNWsCIRgROMEvMnuoEUMYMUTfgyG6xIWCBGYs+Zh2AbWARUJY5fW8wMYvMKWEpc
	3byUGWKDvMTMS9/ZQWxOASuJOX/vskBcZCmxqekSC0S9oMTJmU/AbGag+uats5knMArMQpKa
	hSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwfGkF7WBctv6v3iFGJg7GQ4wSHMxK
	IrzzUtXThXhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpiY
	t63q2MV014XppY6qisINu2cH7Z18Yl5yWBQ8zo8r/bVq80EtjvUHn0xe8ujnnvnyB9W+PZnh
	nrZnxi79Wc8fH62eukjm7pwKJXbXzmPCizc8e748XubbzBMP6v0V/m39NO9Z/fyTn3OnPDev
	fvjw5S6mIKfC3wv9/S86KX4TNni67AEX+92ZNuvkvz9O0MzM36Jg7Ls8sfpKXNRP8WdFMmkX
	NzqK581NtLhtFrpjXs+ihSsC/a4HbhYrPzV/m+uUeRvOWV8Q23g0fG/CufdvdQ/meuqXvtqx
	eD63QQjfEQ/91QUrrf5vuazfYjJD9nqCiIy6ZG+p84zDsfXxP304H6ddfmLjPnH+qRgJ4fcN
	R5RYijMSDbWYi4oTAUT3tAgeAwAA
X-CMS-MailID: 20241104141445epcas5p3fa11a5bebe88ac2bb3541850369591f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104141445epcas5p3fa11a5bebe88ac2bb3541850369591f7
References: <20241104140601.12239-1-anuj20.g@samsung.com>
	<CGME20241104141445epcas5p3fa11a5bebe88ac2bb3541850369591f7@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_075600_893424_328E3004 
X-CRM114-Status: GOOD (  20.11  )
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

Introduce BIP_CLONE_FLAGS describing integrity flags that should be
inherited in the cloned bip from the parent.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 2 +-
 include/linux/bio-integrity.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2a4bd6611692..a448a25d13de 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -559,7 +559,7 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	bip->bip_vec = bip_src->bip_vec;
 	bip->bip_iter = bip_src->bip_iter;
-	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
+	bip->bip_flags = bip_src->bip_flags & BIP_CLONE_FLAGS;
 
 	return 0;
 }
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index dbf0f74c1529..0f0cf10222e8 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -30,6 +30,9 @@ struct bio_integrity_payload {
 	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
 };
 
+#define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
+			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM)
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 
 #define bip_for_each_vec(bvl, bip, iter)				\
-- 
2.25.1


