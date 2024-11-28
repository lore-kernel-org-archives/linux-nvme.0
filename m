Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7783ED69105
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6LNHR2UxOEOGCqUSfrJ4D/dcAXYHqklNM5hsVN/lLY=; b=ONdNy8BfM1NwnXpfodPDGxTgKm
	BUAxk4T4KfQDdfCUIM2FQkJzFDR56zYDIfxHW4ELu7lWG9vb6zlH93jkVFu/OOemXhxfzMufSvo+z
	IeZMdxESGUM1siVSyR9aTH3+ISnd7uhrjKeoxhxSqiOeM8OEAU3HXDgawUu6Ux5hpvvPsDeF4UV8x
	VKcBgEawgxuMAsSwzzuvOQ4m0tsOEDzNPTUqEkgefzsevtwDC3h6ygT0NVqyv1peP1px432zAsD4q
	risCGdIqORzkAiuufCcsZks2bxO2a6amZU8PahQRLrv8Y3bqao0kUNbJB/4UHKLYWdrhGgxXB87Rh
	/j84y7Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGe03-0000000FXzY-0xU0;
	Thu, 28 Nov 2024 12:52:03 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcxy-0000000FNsJ-1qFc
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 11:45:51 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241128114545epoutp04a87c266d5732a502167261f478fda606~MH0bRwPk90980109801epoutp04h
	for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2024 11:45:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241128114545epoutp04a87c266d5732a502167261f478fda606~MH0bRwPk90980109801epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732794345;
	bh=n6LNHR2UxOEOGCqUSfrJ4D/dcAXYHqklNM5hsVN/lLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ve7TH4UTrjaoxzxaVyMJPYLKmL3vANY90GJjHN+VnY21CbYuMJrOdMJegkLXxCz78
	 bT852QMNgL9IvFwKsR4cPeX6OCa0jPz5njFOjVb0Q09Pw1/v/S0UD/3nNcQcMORfFo
	 Xc5AF2u9oz9dV4iU1+xJcpUmaThhDslPikwBw/Gg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241128114545epcas5p315c08a232c61583b6ce602548eb40a87~MH0avYkSY0770307703epcas5p3G;
	Thu, 28 Nov 2024 11:45:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XzZJ737Jcz4x9Pq; Thu, 28 Nov
	2024 11:45:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.5F.20052.7E758476; Thu, 28 Nov 2024 20:45:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241128113056epcas5p2c9278736c88c646e6f3c7480ffb2211f~MHneuWfpJ0944809448epcas5p2b;
	Thu, 28 Nov 2024 11:30:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241128113055epsmtrp125914b31a9851fd5bfa2fbb23d18fb34~MHnetfzXq0051900519epsmtrp1w;
	Thu, 28 Nov 2024 11:30:55 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-5f-674857e7096b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.58.33707.F6458476; Thu, 28 Nov 2024 20:30:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241128113053epsmtip25c3e70b93be3b37eee03a79d53577f2a~MHnceONJ52429524295epsmtip2f;
	Thu, 28 Nov 2024 11:30:53 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v11 01/10] block: define set of integrity flags to be
 inherited by cloned bip
Date: Thu, 28 Nov 2024 16:52:31 +0530
Message-Id: <20241128112240.8867-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128112240.8867-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjlvvf6C9ftgS67ksG6Nw0oAVql9eJEjRB8brqRLBnLhEBDX1rS
	0j77WodkyxoZiihUXZi0FIFtgNYFA6grFhZEB1FRFuVHYAOd0BEgCsjKfiBmpQXnf+f77nfO
	yfnuvUI8tJ8fJszRmxijXqmj+MHElesbomLG02i11N0Zgma9CwQ6fHIRRw7nFYAuDFv5aOr6
	U4AG21swdP7Czxh6UniXQBVnCjB0uqMfoLahaNTadpNAVXUeATo+4OKj+q7nGOpZ7OKhHrtD
	sDOEbrEPC+j7d8x0k/MYn27+/kvaPWjh07OeIYIuveQEdHf1DQE91xRBN409xlKDP9Vu0zBK
	FWOUMPpsgypHr06k3v8oMylTrpDKYmQJaAsl0StzmUQqeW9qTEqOzheHkhxU6sy+VqqS46i4
	7duMBrOJkWgMnCmRYliVjo1nYzllLmfWq2P1jGmrTCrdJPcNZmk11qE6wN5blddpbQIW8ERU
	DERCSMZDr72YWMKhpBtA2yNJMQj24acAjje0ghfFVWs7WGHMWk7zAowWAEcbpIGhOQAvz1wT
	LB3wyUh4Y7zQz15DtgJYUnObWCpwcgLAWue3fsPVZCbsLR7Ai4FQSJDrYf3owaW2mETQOzrO
	C7i9BW33/vKLisgEWNE/zwvMhMCbtjG/DO6bKbhcgS/pQ7JbCKvGHvg1IZkMvV9JAjqr4WTX
	JUEAh8EJ65FlrIZ/3/dgAczCgs6fllPugIW3rH4ZnNwAL16NC7TDYdmtBixg+yosWRhbpoqh
	6+wKpuDR845lDGHbXcsypmHt2W+wwOJOAPjgSNZJILG/lMb+Uhr7/87VAHeCtQzL5aoZTs7K
	9MxnL+4425DbBPwPfOMeFxh+OBPbATAh6ABQiFNrxOyq3epQsUp5KJ8xGjKNZh3DdQC5b9un
	8LDXsw2+H6I3ZcriE6TxCoUiPmGzQka9IZ4qrFSFkmqlidEyDMsYV3iYUBRmwTSP4QfR50r3
	Vv8z+N68rUi7PTyq8YuuN1F3XFSHLELK6n4d6eGt++34lsb6XjqNDNIdHXAjed7h/ZXRiROf
	f3xqsaaMX578w4+qZ7cdKcaFlNpXRC3e8qy1Q2n7rH1xNdZpXmjVSB/O8ejnkxkRBk/pzL/m
	oF7izM53FO4DX58L/zMjS45Gmj39+Scs3p5nLmffu3atN9KllrZjseOexrr5WXN6fnmyo9M4
	GfI7mK4Jmkv7I+9h/570XxYu2kMy2H2SyEdijiqq1VYOV9tea1OX7Egua9btdie9PX3g2P5r
	bFrjd0PCQ5t2RdxxtQet3zyVvrWOcH8SFexJKtr14TqK4DRK2UbcyCn/A3YEze5pBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXjc/xCPd4OM5C4uPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8WkQ9cYLfbe0rbYs/cki8X8
	ZU/ZLbqv72CzWH78H5PF+b/HWS3Oz5rD7iDosXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49P
	b7F49G1ZxehxZsERdo/Pm+Q8Nj15yxTAFcVlk5Kak1mWWqRvl8CV0X9rGWPBJe6KY/2bGBsY
	33F2MXJySAiYSHxsmMTaxcjFISSwnVHi8d5j7BAJCYlTL5cxQtjCEiv/PWeHKPrIKDHt7kkW
	kASbgLrEkeetYEUiAicYJeZPdAMpYgYpmvBlNliRsECsRPfXm0DdHBwsAqoSyx+XgYR5BSwk
	vj5+zgqxQF5i5qXvYIs5BSwlZl/7BhYXAqq5/Pg6K0S9oMTJmU/ARjID1Tdvnc08gVFgFpLU
	LCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGC40sraAfjsvV/9Q4xMnEwHmKU4GBW
	EuEt4HZPF+JNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamAK
	PardtHOhY1OXeqRFMP8hDrYsO6vM9EllbXU2E/RirnLZX5bt/HjrjsXqk5t9fvFt+t35MfS5
	tN71Tdc9NjSLNV6aWLZdbkmF+sy5Eo/+/bTUzn37/gLvrtatMRtDzyozuLiK2lzhSHG5blM9
	RfQn68qEgywd3N7aCds3l7053HJli6+46Qm5aVxXX3ZouTn6dalUCjekh100SyrzL7ges8n5
	24HZoncEZobFndXbPPfXk6mSti4zvgRnOva/NU5jqN76Y89rJRmnb9GSbDXOIVfOhy/jaxZ0
	KK95EPn09Ixwjd9nb++TXXuF+UxYqfO7+59nBPm+3xAlEPh0VXGc4SXH2Y6sp3R+C2oG1Cqx
	FGckGmoxFxUnAgALE1Q0HgMAAA==
X-CMS-MailID: 20241128113056epcas5p2c9278736c88c646e6f3c7480ffb2211f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128113056epcas5p2c9278736c88c646e6f3c7480ffb2211f
References: <20241128112240.8867-1-anuj20.g@samsung.com>
	<CGME20241128113056epcas5p2c9278736c88c646e6f3c7480ffb2211f@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_034550_818263_2C61FDA7 
X-CRM114-Status: GOOD (  16.87  )
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


