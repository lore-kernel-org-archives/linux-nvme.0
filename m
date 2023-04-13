Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419BFC7619A
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWNzOCN0MtvrHBC32swpTu3eTZfE/OpUSdp520IVzoU=; b=IqbYV84n5+8n1+L8bwQW0vUaUs
	hy7Zvhlnq5/PCk5McovCvZ+ATxxUBLRskECIYuXS7DjSPT5jUXmqMhmLRBEZKZDCgKSn+USoKtP0f
	sET7nOzGoy10enojC4JrEpL57uVgaJXZXGJ0SHjS0E7bmIvIjgzkxAVhXndkVzc6ClCdNmK57lAVr
	19z9glBaTVzV7QDzWPzA7OE9eUDLXP0zaJxdyFQwasMDQVo8n+cpJd+kDHmW/pR+W4qPrVgF9MG7E
	nAhytpUdr6KgxSge1VaCl6rceelfDn8C/+jPe0hCVar/jS0Y9P+WVYiv+cGt/ieNtmHRmnuP3z2lT
	sEcKBzWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmmZ1-004o5n-0I;
	Thu, 13 Apr 2023 02:19:55 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmmYw-004o4n-2c
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 02:19:53 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230413021932epoutp0157326910ca1aa3b49ea8e9fc5faed647~VXRMnFQdT0616106161epoutp01T
	for <linux-nvme@lists.infradead.org>; Thu, 13 Apr 2023 02:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230413021932epoutp0157326910ca1aa3b49ea8e9fc5faed647~VXRMnFQdT0616106161epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681352372;
	bh=pWNzOCN0MtvrHBC32swpTu3eTZfE/OpUSdp520IVzoU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=JzoDWKU42rGG4DAT/V7hdHyEXiMczKJR1nI3/ZCtnFfa/KNcC5ozS24VhzHc0QNU0
	 B8zSRSOJcP7B9NU1Adbyg1RBFfrTvZyaM6ylb9LijC+ZTDBHFyoIN+OGNPVqKehZyE
	 0yRxLd3Q7xGFqjObOmVt4PY2J6KMHTZI75xNs5es=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20230413021932epcas2p1947091c70f4aa9c40e6f5ba29800dcfa~VXRMNCAEd2902829028epcas2p1M;
	Thu, 13 Apr 2023 02:19:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4PxjvR4lb9z4x9QF; Thu, 13 Apr
	2023 02:19:31 +0000 (GMT)
X-AuditID: b6c32a47-ca5fd700000026d2-2c-643766b3de64
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.30.09938.3B667346; Thu, 13 Apr 2023 11:19:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH 2/2] nvme-pci: fix metadata mapping length
From: Jinyoung CHOI <j-young.choi@samsung.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <yq13554bm4l.fsf@ca-mkp.ca.oracle.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230413021931epcms2p3bfbfbcd26e2732138bd66e3d9943d45c@epcms2p3>
Date: Thu, 13 Apr 2023 11:19:31 +0900
X-CMS-MailID: 20230413021931epcms2p3bfbfbcd26e2732138bd66e3d9943d45c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmqe7mNPMUgzk3VS3+7znGZvH+4GNW
	i5eHNC1Wrj7KZDHp0DVGi8u75rBZzF/2lN1i+fF/TBbrXr9nceD0mNj8jt3j/L2NLB6bVnWy
	eWxeUu+x+2YDm0dv8zs2j49Pb7F49G1ZxejxeZNcAGdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMpXMWMxX0cVTMn3mOuYHxGXsXIyeH
	hICJxMajh1i6GLk4hAR2MEp0r3oHlODg4BUQlPi7QxikRljAVeLlyW0sILaQgJLEuTWzGEFK
	hAUMJG71moOE2QT0JH4umcEGYosImEpM/rSVDWQks8BxJon5u5YwQ+zilZjR/pQFwpaW2L58
	KyOIzSlgLHHi+QpWiLiGxI9lvVD1ohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLikxKFD
	X9lAbpMQyJfYcCAQIlwj8Xb5AagSfYlrHRvBTuAV8JXYMbcRbC2LgKpE16JPUKe5SDyYtRzs
	F2YBbYllC18zg4xkFtCUWL9LH2K6ssSRWywQFXwSHYf/ssM82LDxN1b2jnlPmCBa1SQWNRlN
	YFSehQjlWUhWzUJYtYCReRWjWGpBcW56arFRgTE8YpPzczcxglOqlvsOxhlvP+gdYmTiYDzE
	KMHBrCTC+8PFNEWINyWxsiq1KD++qDQntfgQoynQkxOZpUST84FJPa8k3tDE0sDEzMzQ3MjU
	wFxJnFfa9mSykEB6YklqdmpqQWoRTB8TB6dUA9Nsh4wXl29pfim8p/g/xrnROK76bMHr1fmz
	SgMid+Y8m7d+hcVGxQU+H07sm8KRL643+eOT0q7ieSkXdJ9cdrCfODNL8/+uEmsxhwKBnLwT
	s3Lc/12ZbXSJZcP0Rxk5Lvr5N36Fc6+tvD7z87bUG2d+n5loW/pCStLjbG1/odHv6Rya04y/
	cYZtKYhexL2x6iFTtsekjkdr97zY8qlsla3Jw5PLjzzdmBDgffjjJaZVlmlGHrvuqyofeunS
	sHZRyk65LplQ/1fnnPcdTZqwXu7jl0Xnfq/77eAUEKvfqr9zUdsK34tBys5a9YJi0lwv39kt
	fXJm/wMJDsvFZlsr07WTSkwEG/WYXwqZrij486tJiaU4I9FQi7moOBEAEZ0qLDIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
References: <yq13554bm4l.fsf@ca-mkp.ca.oracle.com>
	<20230412065736.GB20550@lst.de>
	<20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
	<20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
	<CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_191952_000204_1F9E092D 
X-CRM114-Status: GOOD (  15.44  )
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
Reply-To: j-young.choi@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Jinyoung,
>=20
>> I think the problem is bio_integrity_add_page(). =C2=A0If=20it=20is=20mo=
dified,=0D=0A>>=20sg=20functions=20for=20blk-integrity=20should=20also=20be=
=20modified.=0D=0A>=0D=0A>=20The=20bio=20integrity=20scatterlist=20handling=
=20predates=20NVMe=20and=20wasn't=20written=0D=0A>=20with=20the=20single=20=
segment=20use=20case=20in=20mind.=20For=20SCSI=20we=20required=20the=0D=0A>=
=20hardware=20to=20support=20an=20integrity=20segment=20per=20data=20segmen=
t.=0D=0A>=20=0D=0A>=20--=20=0D=0A>=20Martin=20K.=20Petersen=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0Oracle=20Linux=20Engineering=0D=0A=0D=0AHi=20Martin.=
=0D=0AWhen=20merging=20is=20performed=20in=20bio_integrity_add_page(),=0D=
=0AI=20think=20SG=20functions=20for=20integrity=20will=20be=20able=20to=20b=
e=20modified=20more=20=0D=0Aconcisely.=20It=20was=20just=20the=20reason.=20=
:)=0D=0AIf=20you=20are=20okay,=0D=0Acan=20I=20try=20to=20modify=20it=20to=
=20solve=20the=20problem=20with=20add_page?=0D=0A=0D=0ABest=20Regards,=0D=
=0AJinyoung.

