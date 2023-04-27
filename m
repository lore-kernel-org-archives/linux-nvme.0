Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04AEC77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imEaty5b2xSKM7A1afOPT3x5L5STE5Cj7Y+mkUgAQdk=; b=tDa/6EiYUB719Ls3rhjOQIm0LB
	FolPECOlj4lvpqXf10BR4FDpsOwuClA23SXW6yQ2GFJnbORyvFzV7xeGVVAngwwm7Xdnd8m0P+bO+
	dm3DOrQXAhDsrH22FY3N7uqmuH3uq/wYvdPFZcDUrjtwsIfRTswoQvSzJ77KP/NqVXQ9vFcwoSMl7
	WCZtcVusSuhunZ4nyhOhSvUr0fP0IEOzR341fq2LvD0wPR0zkOjE705E2OPvFRhU+bum1oV62tJLc
	8j+NPjTP935I3jd/Av3I4XPan9kiva/kg3bHUWLUyK/HCiYr4go2lDNb4TNkyBOpaaP2XkET0YYDd
	7v8T5+/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwL4-005iMd-20;
	Thu, 27 Apr 2023 07:46:50 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwL0-005iJu-2a
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 07:46:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230427074641euoutp0198dd7fe41285eb56858c391d7ce316aa~Zuw1e6tit3106131061euoutp01E
	for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 07:46:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230427074641euoutp0198dd7fe41285eb56858c391d7ce316aa~Zuw1e6tit3106131061euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1682581601;
	bh=imEaty5b2xSKM7A1afOPT3x5L5STE5Cj7Y+mkUgAQdk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Y8RsE4p8bfJIfo2+iURv6WnpWfNTbqQInhCEBtBjrBpjYVbnnAzeue1qlaWY327Xq
	 V3FYzcWcM2v+5cL95bxnQcsEnxgPlzMAJAaNOupkbOrOjnU/yzmGAHUN4A/mxAZsS9
	 JlkbksjxLpL1g2eBqqviwlS5MGH3+fwCpcJyA68E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230427074641eucas1p2d076324bb21bea87cabed7a32eca2d2a~Zuw1R-_kH1508615086eucas1p2r;
	Thu, 27 Apr 2023 07:46:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.52.37758.1682A446; Thu, 27
	Apr 2023 08:46:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230427074641eucas1p185bb564521b6c01366293d20970fdfe2~Zuw02AAQM2464524645eucas1p1H;
	Thu, 27 Apr 2023 07:46:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230427074641eusmtrp10246822cbb5418db012ab50aeb35875a~Zuw01b2LA3135831358eusmtrp1D;
	Thu, 27 Apr 2023 07:46:41 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-ca-644a2861ed25
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.C3.10549.1682A446; Thu, 27
	Apr 2023 08:46:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230427074640eusmtip2f738b30fa1fef5ebde035dc44dd5e662~Zuw0nrmfk1022910229eusmtip2T;
	Thu, 27 Apr 2023 07:46:40 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 27 Apr 2023 08:46:40 +0100
Date: Thu, 27 Apr 2023 09:37:52 +0200
From: Pankaj Raghav <p.raghav@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	<stable@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<p.raghav@samsung.com>, <javier.gonz@samsung.com>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20230427073752.3e3spo2vgfxdfcv2@localhost>
MIME-Version: 1.0
In-Reply-To: <20230414051259.GA11464@lst.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sd0wTYRjG890d16Om9VpUXhWJnFGqMiQQrHuRUEcIJgZnoidcapXRtIAD
	xRYMkaoIGBXQYDEqo1FWJYC4qpYgw21KjUgIqEFRzxlwUq4a/3ve3/c870g+Cpdf9phAaRKT
	OV0iG8+QYqLOPtgRyCpWxM2qMjLK3012UlluuYMp821PkfJR42lSeeZCn0h5vtSOKy+9eU8o
	zdU9aDGlyst8J1Ld66omVDUV2aSq9tx+1ZVOA6ni+5yE6lONb7Rog3h+HBevSeV0wQu3iLc1
	P3pBagtFu0r5MmRAWaQJeVJAh0F9psXDhMSUnC5DcL7fTArFZwRXs7twofiEoPCmY9hGjUSu
	N8UKvHSYH8nF/pkaHNXuhBVBZm8Vcg0h6Knw1vkCc6VJegYYs0UuPIZmoK+/Hbn8OF2Jwdei
	9pGlvOhoKHA+x11aQs+Gnm8Wt5ZBS2Ev4dKedADYmniRcAQDhto2QtD74K7VObIR0L8paLqU
	7zZFgN1xym3ygv5mq5v7QOuxw26eBn2O77gQPoDgaEMlKdw8D3La4l0enNZAxzUeCXgJtPKr
	BCkFx4BMcEghv+4kLmAJHMySC82ngaXrLSFgH+j4KM1FTNF/dxX9117QAWC+8pEsGk7g9EQo
	/UUJcjpUNgabkUcF8uZS9AlqTh+ayO0M0rMJ+pREdVBsUkINGv5Zrb+av9Sjsn4+yIYwCtkQ
	UDgzRiLZHRknl8Sxu/dwuqTNupR4Tm9DEymC8ZbMXNASK6fVbDK3g+O0nO7vK0Z5TjBgdUOh
	5rKazqCHrd4mU0lqSXj7oWVhtxeJMnj9/qry+w3+4nM5cj/Fm8qlfK7xpBGP3MqOK6y1rE2N
	lOU4kwP974ze67e+O+DZ9+Dto2RfnTEr81/zQ4rJ0Qkbn9yIuhlSPLfNUIFH3V++7tY49cBz
	bbj9+PgDeRHve3wGpYGaPYtfZoRhvuyoNEYRqx5omOtB+eHlD9LWxIRLtTvagrVhP+qLb++a
	b6ROdL/uxDdvz/JpvGUqkD75GZhsvZwe+nhOnWJsb3qS79MPLV5Gx8EYKyfLSJ9STOb5S6qP
	X1w7JeRz3ipNytnR5oKIQU2G76QFGLvm1eqfm2pPD3GNsqGttm6G0G9jQ2bgOj37B8zHsabI
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7qJGl4pBkdPsFr833OMzWLl6qNM
	FpMOXWO0uLxrDpvF/GVP2S2WLj/GbLHu9XsWiwUbHzE6cHhMbH7H7nH+3kYWj02rOtk8Ni+p
	99h9s4HN4+PTWywenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
	29mkpOZklqUW6dsl6GUcm3SLqeAaS8WpL/uYGxjvMHcxcnBICJhI7N+T3MXIxSEksJRRYmon
	SJwTKC4jsfHLVVYIW1jiz7UuNoiij4wSx+7sh3K2MEq8ezqRCaSKRUBV4s2t+0wgU9kEtCQa
	O9lBwiICShJPX51lBKlnFljPJPFt1lk2kISwgJ9ES08zI4jNK2Au8ej7amaIoV2MEt8/XmGG
	SAhKnJz5hAXEZhbQkViw+xMbyAJmAWmJ5f84QMKcQOFDez6yQ1yqJNGw+QwLhF0r8fnvM8YJ
	jMKzkEyahWTSLIRJCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG47ZjPzfvYJz36qPe
	IUYmDsZDjBIczEoivLyV7ilCvCmJlVWpRfnxRaU5qcWHGE2BQTGRWUo0OR+YEPJK4g3NDEwN
	TcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjY4sx/aez/LlXyzNnB/3ol34e5
	9qdnCR60d7Z8f2fyF+7rs4Ib+Tmy/65S+z3TVf15sJC1npbCQ76wrTOttBbyZTp7WRvX64jG
	efdca9Lnqtz/+W5f3LRTV/Y1ebff3O8YM/dN1GsGv+6d5tySB17kRpVtrLM8/9u1+9s88wy2
	6cd2Zeg8m315w5wFdS+2PNYK+b3tqdWRuKNOChc9drTemOyy1C5AuunFBt7NG77ZzzFZbTI7
	PWEuaxe7T0NJUs5FnZ1zNzekMX6d9HK5+9qMnSmFIgfyGI3fO0b1N6ryWz/+vN1m0mk3z+XH
	Hf/s21xrwr+4I+7fu0+N1QZrhZQ9vXf3GzcXrG7vjU3dG6fEUpyRaKjFXFScCAADnCJiUAMA
	AA==
X-CMS-MailID: 20230427074641eucas1p185bb564521b6c01366293d20970fdfe2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_103034_"
X-RootMTR: 20230427074641eucas1p185bb564521b6c01366293d20970fdfe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230427074641eucas1p185bb564521b6c01366293d20970fdfe2
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
	<20230321132604.GA14120@lst.de> <20230414051259.GA11464@lst.de>
	<CGME20230427074641eucas1p185bb564521b6c01366293d20970fdfe2@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_004647_228540_3102E572 
X-CRM114-Status: GOOD (  17.22  )
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

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_103034_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Christoph,
On Fri, Apr 14, 2023 at 07:12:59AM +0200, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 02:26:04PM +0100, Christoph Hellwig wrote:
> > Can you send a patch with a new quirk that just disables the EUI64,
> > but keeps the NGUID?
> 
> Did this go anywhere?
We had a discussion about this internally with our firmware team, and it
looks like these firmware were given to specific customers based on
mutual agreement. They are already in discussion with our firmware team
regarding this.

I don't think this should go into as a generic quirk in Linux for these
models.

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_103034_
Content-Type: text/plain; charset="utf-8"


------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_103034_--

