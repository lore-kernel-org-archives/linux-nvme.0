Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C74E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KDoj8a3Dw389lnF/CKXmN9Ulc94ReOPZArxeN0gdG0w=; b=UM1m6bB7T1lcwhsmyXFcK4Ci77
	+v82o2YAmoJcWJ9Ictzh09fLTUzQ/88azY8EaW0iAWfp3P0d8T12Hu9iaxyh95kf8xZ6Yq+JfD12G
	NiiS2jppUJ8tqt2cdMaWIkjUVptUdx97z1qSsai8c8+DpX84t15o7VV4YTLXrP2FTbFc+Pantyvpc
	opDY8Dmaj10JJSQ2fgflmRtzyimxBSwylQzPJNf6xvl5Co1JhpoVuB2PWyP+bqwoujNVMhdHf5vre
	Ir+AXcQh+w6fqjcyv3OtMiLMaNBT4cc7bZmPlVZU8NPUauNjLWlo7iow843MWDvT7rVPugF3WBgCD
	cStxHwdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv8G-0000000AcrO-0yev;
	Tue, 10 Dec 2024 07:58:12 +0000
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv8C-0000000Acqe-3Z51
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:58:10 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241210075802epoutp0204d68d22bafd400c53c880ede305e7da~PwdBdX6oT2882428824epoutp02T
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 07:58:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241210075802epoutp0204d68d22bafd400c53c880ede305e7da~PwdBdX6oT2882428824epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733817482;
	bh=KDoj8a3Dw389lnF/CKXmN9Ulc94ReOPZArxeN0gdG0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QLXQR+RZMa2op6UB70h6Lr9GbLZrPLK8ao+ndcI/Hd2Zl47e6Pt3Ft041CEGfJCqQ
	 21Qunc5t2BEcgfTyBrixF7+7bzOC0f7coLOvi8hKei9dkqjYzLL8ETIG+QRbLcORzq
	 9BDLXVCBWaDFW057lgGT/QNQ80f0+/Yf3L1dwFRM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241210075801epcas5p48b647e01e6a4840b420872afb1b53cb5~PwdBEn8zm0885808858epcas5p4D;
	Tue, 10 Dec 2024 07:58:01 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y6rgr32Jcz4x9Q7; Tue, 10 Dec
	2024 07:58:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3D.9A.19956.884F7576; Tue, 10 Dec 2024 16:58:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241210073225epcas5p4b2ed325714e6d17fae9e3e45b8e963f6~PwGqh4WWR0207602076epcas5p4L;
	Tue, 10 Dec 2024 07:32:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210073225epsmtrp2935e78eaa8167a45f1129f6ab26a77c1~PwGqgDLcy2482724827epsmtrp2q;
	Tue, 10 Dec 2024 07:32:25 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-0f-6757f4881437
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C7.07.18949.98EE7576; Tue, 10 Dec 2024 16:32:25 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210073223epsmtip2d8c1452b36d12327c1553e25b0773aa0~PwGoqYEb31903919039epsmtip2Y;
	Tue, 10 Dec 2024 07:32:23 +0000 (GMT)
Date: Tue, 10 Dec 2024 12:54:26 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 02/12] fs: add a write stream field to the kiocb
Message-ID: <20241210072426.onqpnz4twuqw44r2@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-3-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhm7Hl/B0gxePhC2aJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AMyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdkZb1xTGgues
	FX8OXmBpYOxh7WLk5JAQMJG4Oe8KWxcjF4eQwG5GiU2blrBAOJ8YJdYce80K4XxjlFjb2scI
	07KntQmqai+jxPqp/6D6nzBKnJ3/lw2kikVAVeLFj+/sXYwcHGwC2hKn/3OAhEUEFCXOA4MC
	pJ5ZYCKTxO9DTWA1wgLuEvd++IKYvEALNk8D28UrIChxcuYTFhCbU8BM4sLlw0wgrRICKzkk
	+m/tY4I4yEXiUudyqH+EJV4d38IOYUtJfH63lw3CLpdYOWUFG0RzC6PErOuzoL6xl2g91c8M
	YjMLZEj0r/0LNVRWYuqpdUwQcT6J3t9PoOK8EjvmwdjKEmvWL4BaIClx7XsjlO0hcW/abyZI
	oGxllDj++i7rBEa5WUg+moVkH4RtJdH5oYl1FjAAmAWkJZb/44AwNSXW79JfwMi6ilEytaA4
	Nz212LTAOC+1HB7Lyfm5mxjBaVjLewfjowcf9A4xMnEwHmKU4GBWEuHl8A5NF+JNSaysSi3K
	jy8qzUktPsRoCoyficxSosn5wEyQVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampB
	ahFMHxMHp1QDU+O3S4+UueyNCs2unj+989tTNS+TyN3XznLstT5283r0dKt3IWoe+kzTJOKX
	9VvfylwwN3enXfLDY95MlsfvL6uo5OWM2sAT0x+WmNSlGuVxIzR+C2vRxwUf7s5rY0nLfbCn
	b88/BQumY5+KUwzeOBrZ/NgtyVLs25533Ej756ydyq5yN2orjmSwb3vx5p1CX/uJtscBKrqe
	3k5T5U+Uls1mCpe78Gv5Jd0uNjXlCFnTrLRX642UFhxdfH5K1Aax0HM3iownZs6ykXj3UtU8
	OzA4ZD7H5gfKjvrmUoW7maauOfExUGRHq/7FL8+zhM/phq7aeXH75Y1ha5XtbgbO5GmJfRK9
	ytHG59/rK5w7lViKMxINtZiLihMBk8wXJkwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvG7nu/B0g10NahZNE/4yW8xZtY3R
	YvXdfjaLlauPMlm8az3HYnH0/1s2i0mHrjFanLm6kMVi7y1tiz17T7JYzF/2lN1i3ev3LA48
	Hjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObx7mLFR59W1YxenzeJBfAGcVlk5Kak1mW
	WqRvl8CV0dR5mrlgJnPF+c1XGBsYbzB1MXJySAiYSOxpbWLpYuTiEBLYzSgx//Q7ZoiEpMSy
	v0egbGGJlf+es0MUPWKUuDLjM1iCRUBV4sWP70AJDg42AW2J0/85QMIiAooS54HOAalnFpjM
	JPF85jEWkBphAXeJez98QUxeoMWbpzGClAsJJEqsmtYNdg+vgKDEyZlPWEBsZgEziXmbHzKD
	lDMLSEss/wc2nRMofOHyYaYJjAKzkHTMQtIxC6FjASPzKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
	0rx0veT83E2M4MjR0trBuGfVB71DjEwcjIcYJTiYlUR4ObxD04V4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpg2rFMN7NyssvkNZ+mflWT0/1wXWpB0715
	n+ffDO9u1D14If1JfGz8z30H3dm2KXhHdMuGpa8+tTv/k+2Cn6VazHpJkfUzCr5nxV1zSd+h
	4nU95KDroe//2X+9mb7Va8POtLe65UfNtbecmzpjMcMGTy37f/3u27/Z71kZLcnDNFVFdXv4
	2v/vJI/6p0xZ9XKCx12GwpVKYRF7Z06rZ2Jd5RnPeLJn0rz10svied2btU9UPMpqvNCycwWL
	TqxN9SapCFHDW/LfeJryLqrYzrW8Ef277NK5vs8Wm0sWlacln5c2ya0purnOfBuT6sXZZ9jL
	dfucQgS4XwfYSnY8/cWtfJbt8ZFJk08FvkwwvHPkjxJLcUaioRZzUXEiAPLU2goLAwAA
X-CMS-MailID: 20241210073225epcas5p4b2ed325714e6d17fae9e3e45b8e963f6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_712db_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210073225epcas5p4b2ed325714e6d17fae9e3e45b8e963f6
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-3-kbusch@meta.com>
	<CGME20241210073225epcas5p4b2ed325714e6d17fae9e3e45b8e963f6@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_235809_534063_B9E6DC25 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_712db_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Prepare for io_uring passthrough of write streams. The write stream
>field in the kiocb structure fits into an existing 2-byte hole, so its
>size is not changed.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_712db_
Content-Type: text/plain; charset="utf-8"


------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_712db_--

