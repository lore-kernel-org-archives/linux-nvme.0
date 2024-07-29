Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACCDC3DA61
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=JuSuJBpkT8aUqU89Tbvtdko56NLRUdnAMNeLx8Pyavs=; b=LqtQ+IDDdRO95rWGvap50FSE+W
	D5BUCbctcFwPbHNIv+HZJr1HI9GkVI1FzBnEUhChk2dWHFk/Pk5iK9E428qzUBvhq40T5C4lkD2F9
	V/7nldc+GCZR8jrar76FEGAwbBQQ4i3qgEs32MhXC/GD1nc86uNlVRMKBqtTeAyrKjTAVKPHKIwEc
	SpegOnnQGglDxrexRsZ8Tu8ZNUup18PUro204I0/GBr0aiboGfsCUDwWI+ZdMGyhHVF/SqioZizUp
	V7IQ222VW517a9+Ro/hY1TA5j6Z5PtWuQ1WWprb9Y3inWIiguVIeUCBfeQ2z6/D0HrTvq0CoSs+0B
	7xnS9YZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYK2n-0000000ABqY-3N5I;
	Mon, 29 Jul 2024 06:39:41 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYK2j-0000000ABpX-3zL7
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 06:39:40 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240729063928epoutp015c643de0a7dc05625f338578470a4421~mm8LQLoOn0885708857epoutp01z
	for <linux-nvme@lists.infradead.org>; Mon, 29 Jul 2024 06:39:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240729063928epoutp015c643de0a7dc05625f338578470a4421~mm8LQLoOn0885708857epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722235168;
	bh=JuSuJBpkT8aUqU89Tbvtdko56NLRUdnAMNeLx8Pyavs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QkY1DMAsYLrsL193TscoRC/kDRmnWjSbPEqC20AQhIVAl38PHUkrWkbNQjXUVc9Mk
	 fpjMUydhp0E6ZJSseBbdVfMBevwqZetgQCYc5RTObHgvCQkN6br4A/PxCc8Sso2Xba
	 GTyOHxWoOCNhcDKeGdwGBX42iaBtjZjdCYcD5r8k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240729063925epcas5p46b33df7a83d751164e6d5e042e42c588~mm8I2sNkX0543205432epcas5p4B;
	Mon, 29 Jul 2024 06:39:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WXTH05FbDz4x9Q0; Mon, 29 Jul
	2024 06:39:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.51.09642.B1937A66; Mon, 29 Jul 2024 15:39:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240729063922epcas5p35577196a5bb929f1fdf60306987d134d~mm8GAFZZ21295912959epcas5p3O;
	Mon, 29 Jul 2024 06:39:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240729063922epsmtrp2469bfebd5af1af46998db3acfa355239~mm8F-ehNs1852118521epsmtrp2z;
	Mon, 29 Jul 2024 06:39:22 +0000 (GMT)
X-AuditID: b6c32a4b-613ff700000025aa-e3-66a7391bcaef
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.94.08964.A1937A66; Mon, 29 Jul 2024 15:39:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240729063921epsmtip1b3a16f98c659ca1367ef693f1e210f44~mm8FIj3lU3217032170epsmtip1r;
	Mon, 29 Jul 2024 06:39:21 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] nvme: remove unused parameter
Date: Mon, 29 Jul 2024 12:01:33 +0530
Message-Id: <20240729063133.198682-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmhq605fI0g9WPlS1Wrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjcq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIztj34g9LwVye
	iqZ3oQ2Mi7i6GDk5JARMJI5s/8DaxcjFISSwm1Fi1t51zBDOJ0aJRzvOsYBUCQl8Y5To36oB
	1zF5PVTHXkaJV79nM0E4nxklNq+fwtjFyMHBJqApcWFyKUiDiICxROfKBrBBzALuEref9DCB
	2MICehInDu5iA7FZBFQlft45xQxi8wpYSrz+vYIJYpm8xMxL39kh4oISJ2c+gZojL9G8dTbY
	pRICh9glDnf2sEE0uEisnLCJHcIWlnh1fAuULSXx+d1eqJpsiQePHrBA2DUSOzb3sULY9hIN
	f26wgtzPDHT/+l36ELv4JHp/P2ECCUsI8Ep0tAlBVCtK3Jv0FKpTXOLhjCVQtofEy9vL2SDh
	Fisxp6+LeQKj3CwkH8xC8sEshGULGJlXMUqmFhTnpqcWmxYY56WWw2MyOT93EyM40Wl572B8
	9OCD3iFGJg7GQ4wSHMxKIrzxV5amCfGmJFZWpRblxxeV5qQWH2I0BQbrRGYp0eR8YKrNK4k3
	NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBaQHjomkWKmFnfB01L2R+
	WOhuxbWjfpdh2XrTuHUiKewPHta/jbxvEXB1xc7rf3Ptbm5VarK+Mal39upi3defynrbt7Sf
	6jklr652jVNO7XHr3rZuUwfnK36C+1ZO2VZxylzI4saiGlXZG5ejCuqnbll9SPi4knHNi97O
	ZHZObr53ekc/Hm5mD9Av72E5t1Q08ofppCnN4urLRZgNJO/uTS/fUvf0+DXL87ZKbQ3h/cem
	6nHsL9F4VjxxoV7hiWMPNlq3GWzm3Cj1qdwhRebCt+vGoVHrAv2aricd2vbzouX5//Ov/RTx
	7ZbiOKSrfP6a8rmkZAmtavm5+dyNyx8d2uGzaOv9kA8nNZdWr9jpo8RSnJFoqMVcVJwIADrJ
	n+n9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnK6U5fI0gz1HjSxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjeKySUnNySxL
	LdK3S+DK2PfiD0vBXJ6KpnehDYyLuLoYOTkkBEwkjkxez9rFyMUhJLCbUWJWzzZmiIS4RPO1
	H+wQtrDEyn/P2SGKPjJKrP5+AqiDg4NNQFPiwuRSkBoRAXOJfReeg4WZBTwl1k+UBwkLC+hJ
	nDi4iw3EZhFQlfh55xTYeF4BS4nXv1cwQYyXl5h56Ts7RFxQ4uTMJywgNjNQvHnrbOYJjHyz
	kKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHIxamjsYt6/6oHeIkYmD
	8RCjBAezkghv/JWlaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFk
	mTg4pRqY0p6csOUNu6Ga2C0Rv6p3wrMzJYt/ZKbNPMq2aedp9q2OywtKLlioSc6ynOFeenHZ
	Y0N2SwH52VOXb/sr2J3TaLfE1JfPPztw9aXZfnO/OQgIPtsXKHTxRETcxtXP85V1Jquumvt3
	E9OedunUP9N/6F9pWsAm1WG15FSLfbyuwt7YzdueLvBZt/fL3fvCTU8vTT/avvPWo7MNmmw/
	6pgePdp+QtnvTZKySYrfQbVi13vfdd4Ymrxa7/C8ZJNn2yTeo0/6ZkoHvTg8aYH4bVPdKULM
	eSd7WS7fVb5qePCt4ZuMHxabjs0yY/DauGI1w+PJ6yNf738ZkLLzgNzNr+ZPP3So1h7RevyU
	4U/KulUK8pOVWIozEg21mIuKEwFP+mCltQIAAA==
X-CMS-MailID: 20240729063922epcas5p35577196a5bb929f1fdf60306987d134d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240729063922epcas5p35577196a5bb929f1fdf60306987d134d
References: <CGME20240729063922epcas5p35577196a5bb929f1fdf60306987d134d@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240728_233938_664100_6F732F6C 
X-CRM114-Status: GOOD (  18.68  )
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

First parameter of nvme_init_integrity() is unused.
Remove it, and modify the callers.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e78ef31eeef0..d7f5b24ce003 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1756,7 +1756,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static bool nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head,
+static bool nvme_init_integrity(struct nvme_ns_head *head,
 		struct queue_limits *lim)
 {
 	struct blk_integrity *bi = &lim->integrity;
@@ -2175,7 +2175,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (!nvme_init_integrity(ns->disk, ns->head, &lim))
+	if (!nvme_init_integrity(ns->head, &lim))
 		capacity = 0;
 
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2279,7 +2279,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		if (unsupported)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
 		else
-			nvme_init_integrity(ns->head->disk, ns->head, &lim);
+			nvme_init_integrity(ns->head, &lim);
 		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
 
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-- 
2.25.1


