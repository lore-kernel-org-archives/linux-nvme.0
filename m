Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6818EDEC73
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LhY8UpJkEBTqBgFi2YqSxfpesn6wl+U13LO1ChC9Jc=; b=xERqbSdGzInDbqBIC2dxHrxdIO
	1PhvNMVm4k7ToidK+RcdE+N98v+jP7N8b7cQx+LxSOQlykZW7VncY4J1n0Lk1WEciVGMd9pv3F1aX
	Td+HXEd00SJuaTYA7wEk4akFbim/hQ9tY8c4JF8/kLeWfr/pn/5wHXrzfqyy1me70p7iy1exIi2RO
	G+xeHHStMcBX9h9TsNfJBy+qbReaqe9weQFLM8ygVdnjfMN2yhd4ot5ul9HR5EZMxwpSej8LuXtF9
	0EnYwROiuve2U9VrOqZafnAvK/TdSvVLNWYDtLgzcztNKP1G5FZHReafR1BfTcb1hiHXX2EubzG4V
	zMbiWIUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRvP-006Fpv-2I;
	Wed, 13 Sep 2023 15:37:07 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRvK-006Fn5-0z
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 15:37:05 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230913153650epoutp014f99e3f559186d9e80c0c930d7f7c452~Ef2AExSXl2252522525epoutp01H
	for <linux-nvme@lists.infradead.org>; Wed, 13 Sep 2023 15:36:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230913153650epoutp014f99e3f559186d9e80c0c930d7f7c452~Ef2AExSXl2252522525epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1694619410;
	bh=8LhY8UpJkEBTqBgFi2YqSxfpesn6wl+U13LO1ChC9Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p3OTevIIjqIiIrEHIonddbpNjPW/HGDsUcDIEiqM8JFi/G4LeORveLEUgOoQeGYd1
	 q55jnDHVbsJ114l8uIm320d65J8baXvnOOAF7Z7Ns2LCznIvptC/kZNjgpyCD+jza1
	 FTz1DSZ1Z/3sL6tG56bxsms1R99WkIYF0Z+yW9fE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230913153649epcas5p45c5f439072b4d4cb1505fc4fdc29dff6~Ef1-cVWKG2512725127epcas5p40;
	Wed, 13 Sep 2023 15:36:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Rm4Lm2dkzz4x9Pr; Wed, 13 Sep
	2023 15:36:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.BA.09635.017D1056; Thu, 14 Sep 2023 00:36:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230913153647epcas5p461ea50e0e6e01f7ded889cdd049728fc~Ef19lDgxR2511725117epcas5p4r;
	Wed, 13 Sep 2023 15:36:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230913153647epsmtrp2afca93fcdd7f382ee583c8739712b882~Ef19kW8oM1128411284epsmtrp2x;
	Wed, 13 Sep 2023 15:36:47 +0000 (GMT)
X-AuditID: b6c32a4b-563fd700000025a3-9c-6501d7100acd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.60.18916.F07D1056; Thu, 14 Sep 2023 00:36:47 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230913153645epsmtip1a5f9eb79f5b01853e4762ddd2c013041~Ef18AzQII3165031650epsmtip1T;
	Wed, 13 Sep 2023 15:36:45 +0000 (GMT)
Date: Wed, 13 Sep 2023 21:00:42 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: soni.ankit@samsung.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, sathya.m@samsung.com, d.palani@samsung.com,
	prakash.bv@samsung.com, anshul@samsung.com
Subject: Re: [PATCH 1/1] nvme: host: changing data type for variable from
 bool to int.
Message-ID: <20230913153033.GA27448@green245>
MIME-Version: 1.0
In-Reply-To: <1694490911-32299-1-git-send-email-soni.ankit@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmlq7AdcZUgw+zBS1+T5/CavF/zzE2
	i7dfH7BZrFx9lMli0qFrjBbzlz1lt7g3o4vdYt3r9ywWWy8vYLc4uvQ9swOXx8Tmd+we5+9t
	ZPHYtKqTzWPzknqP3Tcb2Dz6tqxiDGCLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	UqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsWDKZsaC1TwVp37VNzCe5Opi5OCQEDCR2LhCu4uR
	i0NIYDejRO/a28wQzidGiTctx9jhnCmXW1hhOm6eUYGI72SUOLHgHVTRM0aJ7Vc3M4MUsQio
	Shw/nQ5isgloSlyYXApiighISfT1lYBUMwvsZZT4e6gLaCQnh7BAhMSUr20sIDavgK7E3ym/
	2SBsQYmTM5+AxTkF3CX6mq4xg9iiAsoSB7YdZwIZJCEwlUPi2Zp1YEUSAi4Say91Q9nCEq+O
	b2GHsKUkPr/bywZhJ0tcmnmOCcIukXi85yCUbS/ReqofbAGzQIbEm0PvoGw+id7fT5ggfueV
	6GgTgihXlLg36SkrhC0u8XDGEijbQ2Lypm9skCCZxShxeeF7xgmMcrOQ/DMLyQoI20qi80MT
	6yygFcwC0hLL/3FAmJoS63fpL2BkXcUomVpQnJueWmxaYJyXWg6P4OT83E2M4JSq5b2D8dGD
	D3qHGJk4GA8xSnAwK4nw9u5hTBXiTUmsrEotyo8vKs1JLT7EaAqMnYnMUqLJ+cCknlcSb2hi
	aWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA5OZUN7sC29mLnb7vJtn/9ye
	ss17r5Zo96QXOzxpk7HrluiXan3+pVXrspk+35+CmbLsG29b3l2YLJNb2Xr1tNT26RcXKEx+
	kzVlia7bl4/5Haebd+m3q1hO9neRyL3x7uzUf3tZ1J2Kkx455hzgUHbWurX6u6TP4vATs/pE
	TTerrnnz16y7K62fM++iVZN3xVHnawElh68Kr9SrW/S9K23jxZU6ml2GKYti1/yMmSTAm1QX
	U5/Ck7nBOHjqjadbpjyJ9pEx1PgdoDKj0qaufa1J/1auDJOo69/292QlyBSceVwSwtvDpLRz
	n+HKkDdBJlz7/a5PKOTJtnh1+09x3Y5Jj+P/evKnKh998vv1DyWW4oxEQy3mouJEAGQxG5Ay
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnC7/dcZUg6ZOCYvf06ewWvzfc4zN
	4u3XB2wWK1cfZbKYdOgao8X8ZU/ZLe7N6GK3WPf6PYvF1ssL2C2OLn3P7MDlMbH5HbvH+Xsb
	WTw2repk89i8pN5j980GNo++LasYA9iiuGxSUnMyy1KL9O0SuDLmH/zLVnCXs+LuxL9sDYxT
	OboYOTgkBEwkbp5R6WLk4hAS2M4o8fbIC7YuRk6guLhE87Uf7BC2sMTKf8/BbCGBJ4wSndfF
	QXpZBFQljp9OBzHZBDQlLkwuBTFFBKQk+vpKQIqZBfYySnw9pQdiCwtESEz52sYCYvMK6Er8
	nfKbDWLrLEaJ/QdPMEIkBCVOznzCAtFsJjFv80NmkJnMAtISy/9xgIQ5Bdwl+pquMYPYogLK
	Ege2HWeawCg4C0n3LCTdsxC6FzAyr2IUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIjg2toB2M
	y9b/1TvEyMTBeIhRgoNZSYS3dw9jqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS
	1OzU1ILUIpgsEwenVAPT6jPWiTfS3dmNxA488q/mib/8WaW+ZXHWFp7XvGHB4jkbxBMSOi/V
	zlB1+rJ9yxXz/HcMPFzH595p2L331uJz7a6HDloIpSiwTlpyQkixIXBb4G3btVPCwnKfvUva
	kjJv8zKDOde9dZ3eOv87+uyg82yD+/M85wRMbOiQlkrbzb/8/Zvp5hZTO9svbDhpJ/PzqAez
	6j9uEYtAwReZ65Z/ddtaIn1KJf+OmG2pRVpnanBr4HHmPssIn0yxx7E3N5zJuHGndUfyU5t2
	gYcsTqG5vLp9XuvaDEw623K4yzaFfag4vHWn+ImnVeXBhbMneSX1tLhdfHelll2yQH3q2+rA
	nSkr/Vbeyt91xiNa7IwSS3FGoqEWc1FxIgDMXLPD/AIAAA==
X-CMS-MailID: 20230913153647epcas5p461ea50e0e6e01f7ded889cdd049728fc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0fR5D8yIpNNl77tk4nXhNCfTmNnUnmvpDlxfu2XVSHf_RJiV=_e7ee2_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912092353epcas5p130b50fa2030574071c41461447fddd52
References: <CGME20230912092353epcas5p130b50fa2030574071c41461447fddd52@epcas5p1.samsung.com>
	<1694490911-32299-1-git-send-email-soni.ankit@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_083702_797939_89A2212D 
X-CRM114-Status: GOOD (  19.59  )
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

------0fR5D8yIpNNl77tk4nXhNCfTmNnUnmvpDlxfu2XVSHf_RJiV=_e7ee2_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Sep 12, 2023 at 09:25:11AM +0530, soni.ankit@samsung.com wrote:
>From: Ankit Soni <soni.ankit@samsung.com>
>
>Changing data type of  local variable to make it aligned with
>return type of "nvme_poll_cq" function.
>
>Signed-off-by: Ankit Soni <soni.ankit@samsung.com>
>Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
>---
> drivers/nvme/host/pci.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>index 2f57da12..b328a65 100644
>--- a/drivers/nvme/host/pci.c
>+++ b/drivers/nvme/host/pci.c
>@@ -1116,7 +1116,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
> static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> {
> 	struct nvme_queue *nvmeq = hctx->driver_data;
>-	bool found;
>+	int found;

Before this change, the function used to return 1 even if more
completions were reaped underneath.

Not a functional issue, as only place actual count mattered was in
io_uring, but it did not rely on this return anyway and used
completion-batching to process multiple completions.

But this was bit confusing, so good to have this cleaned up.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


------0fR5D8yIpNNl77tk4nXhNCfTmNnUnmvpDlxfu2XVSHf_RJiV=_e7ee2_
Content-Type: text/plain; charset="utf-8"


------0fR5D8yIpNNl77tk4nXhNCfTmNnUnmvpDlxfu2XVSHf_RJiV=_e7ee2_--

