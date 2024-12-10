Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E00E77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Io1dmVRWP7SKH3/f0/rglBYCl5Tr0Zgn2Zk4fLy1Ne4=; b=ndSb2/n8wfOqAmy0+7+Bynzsq8
	4xsb1SEMu9hHFJMe1Ox+LVUybzm/8IS5Fl3iiWKcylJ7Wu+0DCjy7KyoDuTDTAD9UOhz2j2+gnBvH
	lh8fePxlpK0outFvqwmuF7z8lCXhQkVbNwGBSPHbvenlD36n2gzEn1X8/Gdp21eDiW/n5vdkeiGFw
	RcXcIqmGvZlZFwPI8POT65+NiBKbHkrtnt91+uOGUbOLMs/7vrYa0/k/rHzu1F5H3jnL3QNWEReo0
	HBg4pvyM3Dw7LLVYMkObQOKi1vVByaWmoHk8Ksr/7JfoM9McOzXFLNSK7r2lbfFJA+HviS1UaKylc
	Ju7vAu9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv8V-0000000Ad07-10Xw;
	Tue, 10 Dec 2024 07:58:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv8S-0000000AcyF-3ulb
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:58:26 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241210075822epoutp01b5bac5dbec672241aba2e8d51073eed6~PwdUmWsfq0567505675epoutp01q
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 07:58:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241210075822epoutp01b5bac5dbec672241aba2e8d51073eed6~PwdUmWsfq0567505675epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733817502;
	bh=Io1dmVRWP7SKH3/f0/rglBYCl5Tr0Zgn2Zk4fLy1Ne4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbvbDM1QfmzIp7ZyqQv1YRG6Xsy7ALDegXng1OU0Otg8r70nWk/v660V9T2OEDyzK
	 yztRxGLdzUoItFufH+N9iu1AxEiuQUA9n6/UtwMO4p69iJi29E47sjXEiZZhkU9V7e
	 2IA0PBO1VCJ1EWwwKBE+/NxM+H1oqVnE51bRuZg8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241210075822epcas5p22fa4b57d5c96923e971217a20018df5a~PwdUSioh72069920699epcas5p2_;
	Tue, 10 Dec 2024 07:58:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y6rhD5dCnz4x9Q2; Tue, 10 Dec
	2024 07:58:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.23.29212.A94F7576; Tue, 10 Dec 2024 16:58:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475~PwPNkpvtR2558425584epcas5p2O;
	Tue, 10 Dec 2024 07:42:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210074213epsmtrp1e300b5305edfb75406213617537015d1~PwPNj6CUU0312003120epsmtrp1Q;
	Tue, 10 Dec 2024 07:42:13 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-5f-6757f49af1cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.98.18949.5D0F7576; Tue, 10 Dec 2024 16:42:13 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210074211epsmtip290c7b0d6cc0bf48bb4d64e1074f40473~PwPLye_ld2843028430epsmtip2e;
	Tue, 10 Dec 2024 07:42:11 +0000 (GMT)
Date: Tue, 10 Dec 2024 13:04:17 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 03/12] block: add a bi_write_stream field
Message-ID: <20241210073417.xz2tpzqhvhgkwjid@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-4-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhu6sL+HpBot2qFk0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZ1S2TUZqYkpq
	kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
	YiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzPu94wFnSx
	VhydvomlgfEASxcjB4eEgInE5ifSXYxcHEICexgl9t/vYe9i5ARyPjFKfHoZC5H4xigx7+V+
	sARIw9vGCYwQib2MEs9+bGSB6HjCKDFxE1gRi4CqxOzZZ9hBNrAJaEuc/s8BEhYRUJQ4DwwH
	kF5mgYlMEr8PNYHVCws4SJyf+4kNxOYFWnDwTSMzhC0ocXLmE7D5nAJmEj0Le8CaJQRWckg0
	/jvGDHGRi8TctX8ZIWxhiVfHt0BdKiXxsr8Nyi6XWDllBVRzC6PErOuzoBrsJVpP9YMNYhbI
	kLhz/h4LRFxWYuqpdUwQcT6J3t9PmCDivBI75sHYyhJr1i9gg7AlJa59b4SyPSTu3d7GDAmi
	rYwS1ydfYp3AKDcLyUezkOyDsK0kOj80sc4ChhizgLTE8n8cEKamxPpd+gsYWVcxSqUWFOem
	pyabFhjq5qWWw2M5OT93EyM4DWsF7GBcveGv3iFGJg7GQ4wSHMxKIrwc3qHpQrwpiZVVqUX5
	8UWlOanFhxhNgVE0kVlKNDkfmAnySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1I
	LYLpY+LglGpg0imr22cUs3ta76rK4uW2K31XcOsZ5XyZ8U/+R9mexCrW0vXOim681UtPzghS
	DvU50v6bQ3nz52MPWM6pJM5i/LC4zKvkZImh4Nss0Tk1v+SrRSTEWm9xXtwZtG3OvxzH0zEJ
	0UbXzq23+PTN2slZqtaQe8Oc3Htmj7v/vXxucuvSlWVcm9bIRp06fC1ErqTvf870E3zOHUcy
	1wTsF5pW9SLrRIjo2mdZKf/jJCfudA/rcF57Nfg2z+aFSk+eirhf3OXheLlErmrt5Cn7vh3N
	nv340j8r76Vci3fv5jp4NLDh5rNrmyxvv56y6pOje/m68KzlxUc7L01wl5sezKtR3Lv/vX12
	qEa/nKjHk+tnqpVYijMSDbWYi4oTAcAIHdxMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvO7VD+HpBkdWsVo0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZxSXTUpqTmZZ
	apG+XQJXxvx5L9gK9jBVPG3vYmpg7GHqYuTkkBAwkXjbOIERxBYS2M0ocaBBECIuKbHs7xFm
	CFtYYuW/5+xdjFxANY8YJXbPPwGWYBFQlZg9+wxQgoODTUBb4vR/DpCwiICixHmga0DqmQUm
	M0k8n3mMBSQhLOAgcX7uJzYQmxdo8cE3jcwQixMl9q2+xQgRF5Q4OfMJWD2zgJnEvM0PmUHm
	MwtISyz/BzafEyjcs7CHbQKjwCwkHbOQdMxC6FjAyLyKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
	L10vOT93EyM4drS0djDuWfVB7xAjEwfjIUYJDmYlEV4O79B0Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGph0j1jYt1ywXONg4ZTjd5D/ydwvU7UuHeWY
	sUsvj0t+rl94+urvOcp80xfMCav7crJZUK0le8/9mdIJTzvyGWb+zf+uV7l+3vEXx6zOFl7W
	tZTnauIwatbsufr61KUMwxy+xQX2gcVh6XPmG5zVm7D3wPHvc9OPzXTQPG/h+PR51yH+on9T
	Z8tKy6XUF53UbNJt1bw4QTwjgSvXaqVm+gbGrdPq9h39zJxlvn9m4w2pwuXFUvzvO+SKRDlU
	z9vNeMzZIVpwZXXq07U3qqYtT3p37WdVQfnGFxo3jn02SD3z22z+3aSrodVh+/jFjy3b8OZV
	rYzjB7HTqVP79tdvf/vfK+RA6IHXPiEHTfbn2BsosRRnJBpqMRcVJwIA3Zn+mgwDAAA=
X-CMS-MailID: 20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-4-kbusch@meta.com>
	<CGME20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_235825_301062_6B45271F 
X-CRM114-Status: GOOD (  11.32  )
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

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Add the ability to pass a write stream for placement control in the bio.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_
Content-Type: text/plain; charset="utf-8"


------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_--

