Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93579D1AD5E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mT4K+F2A/kIqOZdL/ZLie0ICYJwUxyCwdVtyep16tb0=; b=MELjkPSv2RkvvCdQQiYJOBc4ZO
	L0q5wWiHfjiNDGvYnRtK8FGJuTNQuWKNbKVyIW2i3guW/ePSblYJNOMrpGyxBn9640yvuz7L1P3tR
	CibSOEKhP6+Z46JNIXtI0EsX700EgGeGJc43FXZSw3dytgmvngkirUM1GA9TL/+Ff5CBHmzD+/WX8
	vhbQ0OLF3H4FhAQrLrsMLuQ3ex5ouDrPbDmynpPJTFeBi1O7rTdDrscMP4h3KKzZVmt9hbvxFdAeM
	dTgKsBWGjIyzBKvkGKw/yMUjP3qIafXby7cfj0Z5t8vXG+dKLa91uGm4pwVkDEWaeKy5SP6wr0ac7
	v+A0pzGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t14LT-0000000Bxv6-17nc;
	Wed, 16 Oct 2024 13:45:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13GL-0000000Bl7A-0cjC
	for linux-nvme@bombadil.infradead.org;
	Wed, 16 Oct 2024 12:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=mT4K+F2A/kIqOZdL/ZLie0ICYJwUxyCwdVtyep16tb0=; b=D+qzzQzmMLlw+jPD2mtdCMLiRz
	d7n9p19IMdMZ4S8Ys/QXrs7skBDAXCdauzKN29gVBPAeM6Ojlf1+d/uI7qvhxqu5mXGF+7yvXb18A
	lvQjzJOBn1oyWqykLrHxp7241qQuvITDspHJ4vH7WO9iLV9mQpjsTC3ng/94CWu8WfSdYk5TJ0NtZ
	WZhS6swRXg+JhApipi0cLlNT5coKdT6/mFkgWAcEzqeUfp7IDMVlKrw+A/jbwFftV8WRyM9CQxc4b
	vKdh64dnZWuMfZoAo184sF3mKpFlC7uasW4fkD8kk8jOD8eG+dfwbFSfuwqVDa+vfcUHi5viQfv+t
	ITVFC88Q==;
Received: from mailout2.samsung.com ([203.254.224.25])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13GG-00000006nTN-3kMI
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 12:36:24 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241016123607epoutp02c9001db27be11c4d87484283089d8b0a~_7xIYkQea1590215902epoutp022
	for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 12:36:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241016123607epoutp02c9001db27be11c4d87484283089d8b0a~_7xIYkQea1590215902epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729082167;
	bh=mT4K+F2A/kIqOZdL/ZLie0ICYJwUxyCwdVtyep16tb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ht2Br2qQE1/xjML/XgUa4yqRwI8Qaw0/v/uubUH/cRExyq8AxMAgDR8O9t9rDUdNQ
	 CObhJb4xUfutGTZX9d3vq/x7pjuCpc5cZ2GVvuMGLn983Fbm3erz12D8xmsBoOxs0s
	 9C6u4bUyCQE7uO+P0A6h+LzKabQY+TW2FMdRwCwo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241016123607epcas5p162635bbc7397511c995cc07acfa59885~_7xHsMBzi2383423834epcas5p1A;
	Wed, 16 Oct 2024 12:36:07 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XT9S43ZR7z4x9Ps; Wed, 16 Oct
	2024 12:36:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.F7.09420.433BF076; Wed, 16 Oct 2024 21:36:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241016113724epcas5p191ccce0f473274fc95934956662fc769~_692-Rjvd0520505205epcas5p1c;
	Wed, 16 Oct 2024 11:37:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241016113724epsmtrp14aee8d06e2ce78c541c7ba97a7ba58b8~_692_Xuqb0254402544epsmtrp1W;
	Wed, 16 Oct 2024 11:37:24 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-8c-670fb334c4bf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.9A.07371.475AF076; Wed, 16 Oct 2024 20:37:24 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241016113722epsmtip137a8c8fd22cb33714a53dfc2f84ee787~_691Clh-33048330483epsmtip1f;
	Wed, 16 Oct 2024 11:37:22 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v4 01/11] block: define set of integrity flags to be
 inherited by cloned bip
Date: Wed, 16 Oct 2024 16:59:02 +0530
Message-Id: <20241016112912.63542-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016112912.63542-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhq7JZv50g7efxC0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7O4eWAnk8XK1UeZLN61nmOxmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jsjg/aw67A5/Hzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fm09UenzfJ
	BXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2u
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOeDLVrmAJd8W8Vr0GxqOcXYycHBICJhJ/n+9k62Lk4hAS2M0osff+WSYI5xOjRMvtf1CZ
	b4wSZ5b0s8O0HHzcxQyR2Mso0dxxkgkkISTwmVFie7s6iM0moC5x5HkrI4gtIjCJUeL55VAQ
	m1ngFKPE2l8KXYwcHMICcRLNL9lATBYBVYmvV+1AKngFLCWalu5jglglLzHz0newtZwCVhKn
	zh1kh6gRlDg58wkLxER5ieats8HOkRDYwSFxeuFLqDtdJJbOfMcKYQtLvDq+BSouJfGyvw3K
	Tpf4cfkp1LICieZj+xghbHuJ1lP9zCC3MQtoSqzfpQ8RlpWYemodE8RePone30+gWnkldsyD
	sZUk2lfOgbIlJPaea4CyPSQ2fv4NDdxeRoldzaeYJjAqzELyzywk/8xCWL2AkXkVo2RqQXFu
	emqxaYFhXmo5PIaT83M3MYJTspbnDsa7Dz7oHWJk4mA8xCjBwawkwjupizddiDclsbIqtSg/
	vqg0J7X4EKMpMLwnMkuJJucDs0JeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWp
	RTB9TBycUg1MS1QXv6r6qvM671X9sflFC2ZenH90roDMRq2t1zTLQlUOiu422pN/ie18dvOn
	iYrJkvV/X9zS9vl7VsbmZcbLCWd7pmkc6Xoho7qhtikhMi1S9qw/D0vNjGNrvDkVjjLlTa+o
	eb1lyuLt8/dZOhSs+Pg1aGHAkrk1jdeMzp8rPbaf4br25r/zL05fMWlhxtfGbctWr9i09sHn
	qUkv63Wcjos0z2L73HY+5tN3gR+Wgrs2/+gwjE8Rz1i7sdvU7vCPm6ZvP5rGCsYFXbx9/jtL
	3aOyJX0JM/JO71ru8MVKUmLjnDPcwjyzbZ9JRPlOEF5/ZYd6+vK7Oo1XNk5O52N44JHA4bE9
	0eOWhKCRX8G9KHclluKMREMt5qLiRABo0A6/UgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnG7JUv50g7730hYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1ncPLCTyWLl6qNMFu9az7FYTDp0jdFi+5mlzBZ7b2lbzF/2lN2i+/oONovl
	x/8xWZyfNYfdgc9j56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweH5/eYvHo27KK0WPz6WqPz5vk
	AjijuGxSUnMyy1KL9O0SuDKeTLUrWMJdMa9Vr4HxKGcXIyeHhICJxMHHXcxdjFwcQgK7GSUO
	3PvECJGQkDj1chmULSyx8t9zdoiij4wSa7fsZwdJsAmoSxx53soIkhARmMUocXjWfCYQh1ng
	AqPE1X3PwKqEBWIkzj2fxNLFyMHBIqAq8fWqHUiYV8BSomnpPiaIDfISMy99ByvnFLCSOHXu
	IJgtBFTzb/IHRoh6QYmTM5+wgNjMQPXNW2czT2AE2oqQmoUktYCRaRWjZGpBcW56brJhgWFe
	arlecWJucWleul5yfu4mRnDsaGnsYLw3/5/eIUYmDsZDjBIczEoivJO6eNOFeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoEk2Xi4JRqYDJ2FJoTeIf//llDlqVnljlO
	vXsk//QVhnPPTxbME9hjpH/8/sL98VZv1pa92r5EqflgufM+Zlbd7EfG//mNDc89XrJ9cuM9
	HamrG9ZeO7d6dmL67o6uKVt+/H/xJGvXFJkUlnj/stlP0t++6Wc7/pipRmiG3vJLmdN7V/Pc
	Czl087/ei7Ly6eLn5H2fn71sfV7nb/Z55v5JbsXZW/kKjjXKXapIY1we7qIvptn3Z9IbZQaN
	ddXX9e1vPxeaqt9xls/eNK94m0F094Fngg55E6X/WX1xCDS3WuhXpjZxQ0bX/cf8q46f7fxc
	p9xpzbhkZsmPrOb1T0209+qG749q6J/VmR7fv//TD81m729NyxuUWIozEg21mIuKEwFe/GhU
	DAMAAA==
X-CMS-MailID: 20241016113724epcas5p191ccce0f473274fc95934956662fc769
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016113724epcas5p191ccce0f473274fc95934956662fc769
References: <20241016112912.63542-1-anuj20.g@samsung.com>
	<CGME20241016113724epcas5p191ccce0f473274fc95934956662fc769@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_133621_617116_1DAD0107 
X-CRM114-Status: GOOD (  17.16  )
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
---
 block/bio-integrity.c         | 2 +-
 include/linux/bio-integrity.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 88e3ad73c385..8c41a380f2bd 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -562,7 +562,7 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	bip->bip_vec = bip_src->bip_vec;
 	bip->bip_iter = bip_src->bip_iter;
-	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
+	bip->bip_flags = bip_src->bip_flags & BIP_CLONE_FLAGS;
 
 	return 0;
 }
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index dd831c269e99..485d8a43017a 100644
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


