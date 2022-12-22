Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6CAC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 08:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxEUt0WA5qcnBwmnPlfch5IUE/QliNoBE2mfaFNfbYo=; b=Jd/fzC4RkuoC/CJvOKN3N7zTe2
	HxMEiUczoWvKTrlWhpMZuP4ZfHT7Y3MQBAmIVLVZhbUOAH5QfaD+ZVlrHDIgRhK0MNAD90fXfC8LQ
	Wf+iFna7yTQfxzhsdyWNo77nIodB1TuCGcGlQRE4Ip0EEhg/BoOg+9J/Mpv7mYKfSd6RtxmYe1wVy
	y0O8ixcCS06KmSuZObCE78L/7Jd+2yrkEBYtulEE4DtOzTEU/IkV7qfjrTGy5xCCB/9OMkhG9AlBy
	0Wv+bTYLMMcGLqb/Ef8ijF2p0dU2+Yg2Phg2Hj2Dk4jbgweugbUFBRW/jx5jWKewd/vCOvpUUHgOg
	fcqvk2pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8Gnb-008sic-OT; Thu, 22 Dec 2022 08:19:31 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8GnU-008scF-Kc
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 08:19:27 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221222081912epoutp045486afca4cf152648f6a7cd8bb9b8b26~zD7QV6G--0201602016epoutp04u
	for <linux-nvme@lists.infradead.org>; Thu, 22 Dec 2022 08:19:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221222081912epoutp045486afca4cf152648f6a7cd8bb9b8b26~zD7QV6G--0201602016epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1671697152;
	bh=pxEUt0WA5qcnBwmnPlfch5IUE/QliNoBE2mfaFNfbYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUxgtXf7eVWs+KSdD0Sxfk6sz1vxzpPr8CW+wRT4TJmstXNfqSrvyR8kx2ODKcYFO
	 U6VCsGQ7+7BcjN86dO7JdNYGXjKEMbrPUFJZt0ft2EdQfxpoLx5j6rh3fkPdysVDbn
	 ssMztNI+yl6xfhXu7088iZPPsUFEuMyct18TdNhw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20221222081912epcas5p117b318541f0de7d73c704370f7fb577a~zD7P_DvSN1556015560epcas5p1W;
	Thu, 22 Dec 2022 08:19:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Nd3B65X6Xz4x9Pr; Thu, 22 Dec
	2022 08:19:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.D8.62806.CF214A36; Thu, 22 Dec 2022 17:19:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20221222081908epcas5p2e16d1b45d2bf59db5eb538ab61918d4f~zD7MSMhRH0387403874epcas5p2t;
	Thu, 22 Dec 2022 08:19:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221222081908epsmtrp26110e210bf33580f79e1c916082fc9d9~zD7MRiymJ0694606946epsmtrp2F;
	Thu, 22 Dec 2022 08:19:08 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-1c-63a412fc8cdc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.2C.02211.CF214A36; Thu, 22 Dec 2022 17:19:08 +0900 (KST)
Received: from green (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221222081907epsmtip2befec5752026974d46b1c7c53acb2199~zD7LYlel00584605846epsmtip2Y;
	Thu, 22 Dec 2022 08:19:07 +0000 (GMT)
Date: Thu, 22 Dec 2022 13:49:04 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without
 effects v3
Message-ID: <20221222081904.GA4413@green>
MIME-Version: 1.0
In-Reply-To: <20221221101050.759606-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTQ/eP0JJkg77n2hYrVx9lsph06Bqj
	xdOrs5gs5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwevc3v2AJYo7JtMlITU1KL
	FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
	lfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM9ZvaWMu6GWr
	uHHUpIFxPmsXIyeHhICJxMbzLxm7GLk4hAR2M0q8+TCBCcL5xCix780TKOcbo0Tf79vMMC0N
	i1+yQCT2Mko8n/WHHcJ5zChxvW8KC0gVi4CqxPNpe9m6GDk42AQ0JS5MLgUJiwgoSTx9dRZs
	H7NAD6PEufaVYIcICwRJ7Hu/lhGknheo/vWVAJAwr4CgxMmZT8BGcgoYSqy41wVWLiqgLHFg
	23Gw6yQEvrJLbNs2lR3iOheJfV+2QdnCEq+Ob4GypSQ+vwO5B8ROlrg08xwThF0i8XjPQSjb
	XqL1VD/Yl8wCGRJLe3ezQNh8Er2/QUHBAVTDK9HRJgRRrihxb9JTaDiKSzycsQTK9pA48/0g
	2BghgRZGiS07xScwys1C8s4sJBsgbCuJzg9NrLOANjALSEss/8cBYWpKrN+lv4CRdRWjZGpB
	cW56arFpgVFeajk8ipPzczcxglOjltcOxocPPugdYmTiYDzEKMHBrCTCu+Xx4mQh3pTEyqrU
	ovz4otKc1OJDjKbA2JnILCWanA9Mznkl8YYmlgYmZmZmJpbGZoZK4rypW+cnCwmkJ5akZqem
	FqQWwfQxcXBKNTBFHb/GsOTaCp+pphePXdYP1DzurerNe9Pc5l5lVM11t5P1j54wVLwS1Nss
	2VfELvZ87bqq66LPjkeX9jdcCH2SqnJu8vzSR+bcymF171cx7X3nK2i47pfkl9Tgieel5p87
	WOvz6dArT7U7hnpxIV51k3IXfrq+JdtZg+Mp++vv+jX6qbtCBeNOtBX9/v3ByfXZGcEZy/rr
	WCYtb2M7Lxk0N6bghEbk0fff9+TvyGbbKnJb//xymS+ejkoPToorb337c8a2pazfRKQ6Nh5U
	s9324HlfeYHc0pb3G3SKPANfWPK9zuycYP2k9NADiz9bbry9XzLzwPN86Ye5FjO+7/rTmi8n
	d3n7X9aX0+fer9+apsRSnJFoqMVcVJwIAAEqcAgWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvO4foSXJBnM7hC1Wrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRnHZpKTmZJal
	FunbJXBl3J29m6lgP3NF85xnbA2Mr5m6GDk5JARMJBoWv2TpYuTiEBLYzSjx6MQ3doiEuETz
	tR9QtrDEyn/P2SGKHjJKzFrZwAqSYBFQlXg+bS9bFyMHB5uApsSFyaUgYREBJYmnr84ygtQz
	C/QwSpxrXwlWLywQJPHy6n5mkHpeoPrXVwIgZrYwSizY/poFpIZXQFDi5MwnYDazgJnEvM0P
	weqZBaQllv/jAAlzChhKrLjXBTZSVEBZ4sC240wTGAVnIemehaR7FkL3AkbmVYySqQXFuem5
	xYYFhnmp5XrFibnFpXnpesn5uZsYweGupbmDcfuqD3qHGJk4GA8xSnAwK4nwbnm8OFmINyWx
	siq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpkq92/ssOjMiW9zm
	7lwhtaHtwde32xZZlDjUmvyP5Or8UR1dueLzjfnnOBjm7a/223z+7HrLfJM5Wlpf/E1P77n3
	1P9v3SuBZUvX8ojFVc9b9Fc/+9HqZV3chwTrpHuet89VUvs0Zc0RmeyoXcdiX/ZecbBJKw7z
	vh+pOOfugg/lU9imqu+9+vWNv4AUd9kGbrXd01LN70T+3LDuweaauTFywv45rwQdeP6m7JG7
	qfx+UWm26L5X9x6yhHyZkrbxXvb/dey75x1rOsL8JZSr+nHqpc33OLT2TOG02Mt6wEljgdtu
	g3/bJmVP+Hjvx+Xn+jvmnmtICLZYHMf30lL5edbBXXzHwxlK//HdnsmVKxOgxFKckWioxVxU
	nAgA90LQUeYCAAA=
X-CMS-MailID: 20221222081908epcas5p2e16d1b45d2bf59db5eb538ab61918d4f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_50a1f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221221145321epcas5p4ff234021b074bf0a513d1cb233135656
References: <CGME20221221145321epcas5p4ff234021b074bf0a513d1cb233135656@epcas5p4.samsung.com>
	<20221221101050.759606-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_001925_403956_01111ED2 
X-CRM114-Status: GOOD (  14.29  )
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

------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_50a1f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Dec 21, 2022 at 11:10:44AM +0100, Christoph Hellwig wrote:
>Hi all,
>
>this series first fixes a few minor issues in the CES log support in the
>host and target drivers and then uses the log to deny unprivileged
>passthrough of commands that have effects, where the only practically
>relevant effect is the modification of contents of the data stored in the
>namespace.

LGTM.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_50a1f_
Content-Type: text/plain; charset="utf-8"


------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_50a1f_--

