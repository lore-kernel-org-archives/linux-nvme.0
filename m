Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1032CD3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Qev84oB/WNNKAORKgHjGWYS6Jca41BG3ZIzsvdmNNQ=; b=2yzNxt8bekslVv59HAOKydLDKA
	zXik33OU2EqtzHWm4Ihnws4VDsa9vadw4/y7yALNNJhPO9DimBrrrJiPSW/4ViXMZswRdXZ5X7d7a
	w2awZbBXetJow8EG7wZbnj7vIN3xoKPUTj9kXs5ia2c60eBdQl05iZRC3JOmkthW4uTLhZvYRDN4G
	zxbD6w/It+B08Wj9VIZ0TGOrJyWKh61XOSSwVJtavqVAT51CCLpkyZmZEed//4y+CwpQyYVgGkMvR
	uqeTwRP3mpDBHYOc0OuF1my4aqiQHm92v68MeCrPiGPJvoYPVS9kWX1icJ+qZvrWiV/C1nO5tU/5S
	IWgwcLxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qPx-0000000FOqK-35QD;
	Tue, 29 Oct 2024 17:54:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pwj-0000000FEw7-0YxT
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:23:58 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241029172353epoutp03e973d60731037927bacadda9964e4b11~C-FFwP5lX0223102231epoutp03a
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 17:23:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241029172353epoutp03e973d60731037927bacadda9964e4b11~C-FFwP5lX0223102231epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730222633;
	bh=0Qev84oB/WNNKAORKgHjGWYS6Jca41BG3ZIzsvdmNNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWZ27hw5oS9faQkRuFYeijnhnnmdQcuulTdhLsGRWNPBkSvkI1JIrYHEOBF8djrUw
	 pCDNHsCIgbd/cCo7H0Z+x1Hyu8+CfenjjHUsal8saWCUJWayfvKQnYIehsVdeXtlkd
	 pju8kqHsYz1AfcIbL9kMYJfk+2+S0cpBZaXg6vnk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241029172352epcas5p486cd4227fbfaf2132339288c04dd1c92~C-FEuMWFQ1636616366epcas5p4P;
	Tue, 29 Oct 2024 17:23:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XdHD71jzwz4x9Pp; Tue, 29 Oct
	2024 17:23:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.D1.09770.72A11276; Wed, 30 Oct 2024 02:23:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241029163222epcas5p4f46c83e92322214e00212cec15d29489~C_YHA9KY21629316293epcas5p45;
	Tue, 29 Oct 2024 16:32:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241029163222epsmtrp2f7ab7bd9f58f48551453104a414ef873~C_YHAG0HE1621316213epsmtrp26;
	Tue, 29 Oct 2024 16:32:22 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-b4-67211a27707c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.07.08227.61E01276; Wed, 30 Oct 2024 01:32:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163220epsmtip258ddab2cdea3fe699614b56f614f2efb~C_YExiXqj0975909759epsmtip2X;
	Tue, 29 Oct 2024 16:32:20 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v5 05/10] fs: introduce IOCB_HAS_METADATA for metadata
Date: Tue, 29 Oct 2024 21:53:57 +0530
Message-Id: <20241029162402.21400-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029162402.21400-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmhq66lGK6wY2JHBYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJotJh64xWuy9pW2xZ+9JFov5
	y56yW3Rf38Fmsfz4PyaL83+Ps1qcnzWH3UHQY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHh+f
	3mLx6NuyitHjzIIj7B6fN8l5bHrylimAKyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoHSWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsba02sYC66wVqy/1cLYwHiNpYuRk0NCwESi4+0a
	9i5GLg4hgd2MEvcfXWSGcD4xSrz+tY8JwvnGKHFs90xGmJaPk96zQCT2MkpM/LmCFcL5zCjR
	fH8zM0gVm4C6xJHnrYwgCRGBPYwSvQtPg7UwC7xklFi6ahHYemEBN4nPT+4xgdgsAqoSsx7c
	YwWxeQUsJWZ8PcYEsU9eYual7+wgNqeAlcSxo3uYIGoEJU7OfAI2hxmopnnrbLDLJQQucEh8
	ndcF1ewi8evhe3YIW1ji1fEtULaUxOd3e9kg7HSJH5efQtUXSDQf2wf1qL1E66l+oKEcQAs0
	Jdbv0ocIy0pMPbWOCWIvn0Tv7ydQrbwSO+bB2EoS7SvnQNkSEnvPNUDZHhK3pv6CBlcvo8Tk
	nftYJjAqzELyzywk/8xCWL2AkXkVo2RqQXFuemqxaYFRXmo5PKKT83M3MYJTuZbXDsaHDz7o
	HWJk4mA8xCjBwawkwrs6VjZdiDclsbIqtSg/vqg0J7X4EKMpMMAnMkuJJucDs0leSbyhiaWB
	iZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MHL+CJSdr1+Vq9BqFHt785PJ5
	o6Ccv0FVMcr775cs025IvztZWWXHo4ieK6+PzymKfP5rY/eCE9cOGEc9N2Ffu/yi8vHZU8+G
	3Hiodk/tgIvCq84JwrkSvCt0JX+eup/Km6Joq1Q22bmv7tWVYM2n3sF+032CF/L3crq0mDxR
	zSt86LlzNnPi1mvH/35WDqku4L+gmPg7x9Hwg+Vq/lvbrEWdNnsIW2wUu3Dgpf3bg3f0E+ba
	5H9YPeVaSsbh7kMZ5/4fFGOqMhfs/Xzql5iAyRfFf5djH7FMMlhhXLgncKn07Od6J/3fmh5N
	mVb/W2bz0TcaWT1dUQorMyYEhgo7Js08vnk+z87UzstsCWV3lViKMxINtZiLihMBiZlpUW4E
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXleMTzHdoKNbxuLj198sFk0T/jJb
	zFm1jdFi9d1+NovXhz8xWtw8sJPJYuXqo0wW71rPsVjMnt7MZDHp0DVGi723tC327D3JYjF/
	2VN2i+7rO9gslh//x2Rx/u9xVovzs+awOwh67Jx1l93j8tlSj02rOtk8Ni+p99h9s4HN4+PT
	WywefVtWMXqcWXCE3ePzJjmPTU/eMgVwRXHZpKTmZJalFunbJXBlrD29hrHgCmvF+lstjA2M
	11i6GDk5JARMJD5Oeg9kc3EICexmlGja0skOkZCQOPVyGSOELSyx8t9zdoiij4wSS5+vZgZJ
	sAmoSxx53gpWJCJwglFi/kQ3kCJmkKIJX2aDrRAWcJP4/OQeE4jNIqAqMevBPVYQm1fAUmLG
	12NMEBvkJWZe+g62mVPASuLY0T1AcQ6gbZYSJye5QZQLSpyc+QRsJDNQefPW2cwTGAVmIUnN
	QpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOM60tHYw7ln1Qe8QIxMH4yFG
	CQ5mJRHe1bGy6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJMnFw
	SjUwaWdsKb+XYjg3Z0ZXa5PhiRWe55aHnmSVFuu9MP3FtCclHf8mec6sv5wm3iFUKXbh3aOP
	U6QbNA6FVOy01pWaOSNCTviJ/+aSzvMH9JdnR/EmqqdqbNKLb1rcmNEq9iIzinvX3q2/OXv9
	jUzcZNWNdzna68+4Nj3gYRezmKrgsssXjXyyNfq91NdsFNVceuRL978z/GfcZ2cr9Xy9/mHC
	zq76qSxhYVc67Jf9aDsiELqhed9FqV0ORpwT1q3fXKil315dszhP3LL/ac5x00cCd5O/bNw+
	Z31UwvGQXrkJO8+5Mk78clNxreKnr0f/aTPqul98vuVhzl2DlhBj5ppPL2z5P0+X/nyve+Pd
	5TtmKbEUZyQaajEXFScCAMuhadwiAwAA
X-CMS-MailID: 20241029163222epcas5p4f46c83e92322214e00212cec15d29489
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163222epcas5p4f46c83e92322214e00212cec15d29489
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163222epcas5p4f46c83e92322214e00212cec15d29489@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_102357_526539_55344AA8 
X-CRM114-Status: GOOD (  13.62  )
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

Introduce an IOCB_HAS_METADATA flag for the kiocb struct, for handling
requests containing meta payload.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4b5cad44a126..7f14675b02df 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,6 +346,7 @@ struct readahead_control;
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 23)
+#define IOCB_HAS_METADATA	(1 << 24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
-- 
2.25.1


