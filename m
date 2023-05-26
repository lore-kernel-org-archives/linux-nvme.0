Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8C4C7EE2C
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 06:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1DA5eVoxay5m6uVcqP9E12+DnuEvzRHUGEIsBRwJC0=; b=dMVGLgKb+Akh5CHD9rwVDLumWj
	CbtYZ8uZAu2UpyUrfkUQRNSDtTG7MrgPdpTc2JGVW8j/OsYsMSTQrNc2n/h0vQtk9nIJbt6eQPHrT
	J3qA8nQsEkT45QS66rsFOfyxUIi3c/FLegLAdAeZWQAxeg9cecc0unpAn9SkEUpHOJtO9THcQ4eXO
	60hwD/t8ZjH5VGxZgiNQOdhiWgLSZc4efkCXY6joSs1tEfmU4r4PkqRUGvVBOQpu6+BQtCHcxLwBj
	afPAGNG9pD1AMgRjYVyxV/+yJqixM6UPSKlpqkEGhppX0PzATdNt/wIkbxt7gcoWDs5quJ0LLopxx
	lt6C3D7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2QhZ-001CzP-2N;
	Fri, 26 May 2023 06:13:25 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2QhV-001Cy8-1Q
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 06:13:23 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230526061316epoutp01aec52b4f382b79d20248d002eeab613c~inMi2AbPs1636916369epoutp01W
	for <linux-nvme@lists.infradead.org>; Fri, 26 May 2023 06:13:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230526061316epoutp01aec52b4f382b79d20248d002eeab613c~inMi2AbPs1636916369epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685081596;
	bh=M1DA5eVoxay5m6uVcqP9E12+DnuEvzRHUGEIsBRwJC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRVOuTYEJ7UfJDcqi15cdF5s/eZe/sXFOxhnUXd3Aar357KQ2YgaAEEjrMGoMtd7L
	 LfMppgt7Zfi7UzJRYQHWqpAaFAYRAwtMNku/PiFRnQm9x15F2F5IVZBdniD+ABNegC
	 9OvqahrHPoscK+YDEgxF7ZxMs4CgZErlCZPcmhpo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230526061316epcas5p4e3314fb8f2cbf0c141ac83e934856f64~inMifwITU0626306263epcas5p4Y;
	Fri, 26 May 2023 06:13:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4QSF3F6qP6z4x9QJ; Fri, 26 May
	2023 06:13:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.65.44881.6FD40746; Fri, 26 May 2023 15:13:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230526060832epcas5p24670023ac7184535bd9bcc0f970c276e~inIaiD25J0357903579epcas5p2K;
	Fri, 26 May 2023 06:08:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230526060832epsmtrp2dddc974c073fed8f4e8b4c7039ad307d~inIahbwh52955029550epsmtrp2e;
	Fri, 26 May 2023 06:08:32 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-1b-64704df6d709
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.77.28392.0EC40746; Fri, 26 May 2023 15:08:32 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230526060831epsmtip2d67d95a80f37e8b3f894c8d2cb376567~inIZlRdRp0282602826epsmtip2h;
	Fri, 26 May 2023 06:08:31 +0000 (GMT)
Date: Fri, 26 May 2023 11:35:33 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme-fcloop: no need to return from void function
Message-ID: <20230526060533.7342ue52kamb6ljg@green245>
MIME-Version: 1.0
In-Reply-To: <20230519094052.48575-2-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmlu4334IUg2PbtSz2LJrEZLFy9VEm
	i90LPzJZPL06i8li/rKn7BbrXr9ncWDzmHX/LJvH+XsbWTw2L6n32H2zgc2jt/kdm8fm09UB
	bFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
	lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoT
	sjPeXljJXvCeveLyur/sDYyv2LoYOTkkBEwk9k9vZO5i5OIQEtjNKNG4rAvK+cQo8fDbChYI
	5zOjRP+GdiaYlt7tJ1i7GDmAErsYJfbaQtQ8Y5R4vmAtWJxFQFXi6/8gEJNNQFvi9H8OkE4R
	AXWJqQd6WEFsZoEsiR0nFoJNFBbwktj/fD2YzStgJnHt9BkWCFtQ4uTMJ2A2J9DWDd9+MYPY
	ogIyEjOWfgW7U0LgJ7vEmc0vWSBOc5G41LCAHcIWlnh1fAuULSXx+d1eqI/LJVZOWcEG0dzC
	KDHr+ixGiIS9ROupfmaI6zIk5m9oZ4aIy0pMPbWOCSLOJ9H7+wk0HHgldsyDsZUl1qxfALVA
	UuLa90Yo20Pi4dRX0BDdyChxcd0ltgmM8rOQfDcLyT4I20qi80MT6yxg4DELSEss/8cBYWpK
	rN+lv4CRdRWjZGpBcW56arFpgVFeajk8vpPzczcxgtOoltcOxocPPugdYmTiYDzEKMHBrCTC
	uyEnP0WINyWxsiq1KD++qDQntfgQoykwriYyS4km5wMTeV5JvKGJpYGJmZmZiaWxmaGSOK+6
	7clkIYH0xJLU7NTUgtQimD4mDk6pBiYGcZ/Liq5BEjvENz/7yMbW8+OYlc7pQkEFpwLDTqko
	4aB/Fx4Xr7Xxj94cEhdgPPP844s5mRUVIU6sRmtviklL2WyoqGr+ETb3QG7AtdjdHWtdTgjp
	KPOfPdlwI2BZip2f+SZzEea2lvks+ndeRR47wRP66fk3trCM25ddApgeBd3pijpo1HzIf/Mh
	PV5xjrVPrzBUKbP0hzzdqJIlXMm+vEv4vqD7EaczhUeuxy+XyrK/z/DR1Cz8VMWkw93F84ye
	5d/Q4om78Yd7spH452dcxydP0vT2WWym79ayvPufbOXL+Yf7lnXO0V2/MpK58e+fqavyvG4K
	zVOc63cqI/ikZMvjHOuPdqZaAVOWKLEUZyQaajEXFScCAB2EYmssBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvO4Dn4IUg+MPlSz2LJrEZLFy9VEm
	i90LPzJZPL06i8li/rKn7BbrXr9ncWDzmHX/LJvH+XsbWTw2L6n32H2zgc2jt/kdm8fm09UB
	bFFcNimpOZllqUX6dglcGf++N7EXLGSteP3+C2sD4zaWLkZODgkBE4ne7SdYQWwhgR2MEmv2
	1UDEJSWW/T3CDGELS6z895y9i5ELqOYJo8TWRb+Zuhg5OFgEVCW+/g8CMdkEtCVO/+cAKRcR
	UJeYeqAHbCSzQJbEjhMLmUBsYQEvif3P14PZvAJmEtdOn2GBWBsrserlYmaIuKDEyZlPWCB6
	zSTmbX7IDDKeWUBaYvk/sPGcQBdv+PYLrFxUQEZixtKvzBMYBWch6Z6FpHsWQvcCRuZVjJKp
	BcW56bnFhgVGeanlesWJucWleel6yfm5mxjBoa+ltYNxz6oPeocYmTgYDzFKcDArifBuyMlP
	EeJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHJ2O8bm8jr
	bHm5hLxNm8O2fUp5X1Tx5e6GD98+8beosgRu23k9+8DVIoZA1Yr7DLcELgcuYref0lOyqaP/
	euIbf8uO0rp70Xc032oGzzE48P7Uuj+rLE7Hdk07U/7VRW++83fzr4kL5O8Un7j9dUpFzMzt
	OxtjJjcIGDjm8n/bq37+XdxMz5/+NX6ei2SmPalkyCjU2pEwI5yp4cvJx6reu/7Wf80Smj3r
	bVeHVLbbK+byCa8c3q2ZlaYuVjvxfybbTBYJsySp/3+3hB8M+5VdeFR8/cN5E9h2/A5b5Dk3
	rauqNSa4W9Pn4AZ+E4tDDRY7onc2GG9+darHnON2payuSfn+S8qruDaFr9i0UjVbiaU4I9FQ
	i7moOBEAHOJFzOwCAAA=
X-CMS-MailID: 20230526060832epcas5p24670023ac7184535bd9bcc0f970c276e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_22e3f_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526060832epcas5p24670023ac7184535bd9bcc0f970c276e
References: <20230519094052.48575-1-kch@nvidia.com>
	<20230519094052.48575-2-kch@nvidia.com>
	<CGME20230526060832epcas5p24670023ac7184535bd9bcc0f970c276e@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_231321_835577_27256876 
X-CRM114-Status: GOOD (  14.93  )
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

------hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_22e3f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/05/19 02:40AM, Chaitanya Kulkarni wrote:
>Remove return at the end of void function.
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> drivers/nvme/target/fcloop.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
>index e940a7d37a9d..1ab3d900f2bf 100644
>--- a/drivers/nvme/target/fcloop.c
>+++ b/drivers/nvme/target/fcloop.c
>@@ -645,8 +645,6 @@ fcloop_fcp_recv_work(struct work_struct *work)
> 	}
> 	if (ret)
> 		fcloop_call_host_done(fcpreq, tfcp_req, ret);
>-
>-	return;
> }
>
> static void
>-- 
>2.40.0
>
>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_22e3f_
Content-Type: text/plain; charset="utf-8"


------hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_22e3f_--

