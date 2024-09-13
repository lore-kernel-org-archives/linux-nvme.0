Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8516EEE26C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=jrAS75Pi33Hpgay7t8P8WqwSrZ
	4swRcC1BYDO5CD6j/Ys3GPS0T4TBjdZ5Cq2b/pRxrXf7VyeupGB409vAbMnKsDa7nmbqeJTtwt433
	234mFo9fp+FnYpvv+8zrUBuv5Z6BRlMfhLe7362kVJfEOaAma+urjHv4i7tncq+j3rj8GSTMzHcxY
	lNSpKGsgRnWrVMQfU0SWOUyJu12QK8tOtfb2Q8OvztpQpr/C2asPVIkZCVDHLpVY+Y6IMS/qkejK7
	WwBIQPG75iDvrGYHbzS3aNCgBoYT3SRkn470fYE2ausDG/ESZQG+8dQ/Rht4e0sRbDk0fF/b6IjSs
	qG+DS/1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5Vj-0000000FufP-3IkB;
	Fri, 13 Sep 2024 12:34:51 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5Uw-0000000FuYn-1Ajn
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 12:34:04 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240913123355epoutp0279a325e95837cad4a06c8eb0806711cd~0zcyDP7FM3222132221epoutp021
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 12:33:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240913123355epoutp0279a325e95837cad4a06c8eb0806711cd~0zcyDP7FM3222132221epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726230835;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MBRb6g8sT1ktQyi4DmncwqaE6fSFrjnm8Ga0VO+xCufWCWn8hqYC9KW74xXwl5dSr
	 h/d0D+lQoNbijpm70W1GNXW3usbf5rfotwMO06YyIs2qj00nrkI5VlKhohuyNL8maz
	 oun2EeOMREP38j2wDiPh1rKoVLnEqkNYeUYFBU8k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240913123354epcas5p4bb058553c09e6883fbe141af0b27f2bc~0zcxm8hbc0204402044epcas5p4L;
	Fri, 13 Sep 2024 12:33:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X4tyn5Jfnz4x9Pw; Fri, 13 Sep
	2024 12:33:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.F7.09743.13134E66; Fri, 13 Sep 2024 21:33:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240913123353epcas5p4976f0b6db7bfc557eb7f6b7630122e46~0zcv_Vnru2094120941epcas5p4R;
	Fri, 13 Sep 2024 12:33:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913123353epsmtrp2db5accb13158447798a731232e2a2673~0zcv9uf6X1555615556epsmtrp2d;
	Fri, 13 Sep 2024 12:33:53 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-a0-66e4313106b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.41.19367.13134E66; Fri, 13 Sep 2024 21:33:53 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913123351epsmtip15a51dd22ee25357c93be15e0231fc13b~0zcuq2u7W3163331633epsmtip1E;
	Fri, 13 Sep 2024 12:33:51 +0000 (GMT)
Message-ID: <33cb5c6b-66cf-3c3d-774a-5d3e40032368@samsung.com>
Date: Fri, 13 Sep 2024 18:03:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCHv4 05/10] block: provide a request helper for user
 integrity segments
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240911201240.3982856-6-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmpq6h4ZM0g/fn1C1W3+1ns1i5+iiT
	xaRD1xgtzlxdyGKx95a2xfxlT9ktuq/vYLNYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDmce5ihcfHp7dYPD5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
	NbS0MFdSyEvMTbVVcvEJ0HXLzAG6TUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJT
	YFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnXFqx1KmAqOKa3P7mBoYdbsYOTkkBEwkLv75y9bF
	yMUhJLCbUeLFqQ/sEM4nRol/K74xwTn7/i1mg2vZ9pQFxBYS2Mko8XKfPETRW0aJ/W/fsoIk
	eAXsJP5PWgDWwCKgKtF0aR0zRFxQ4uTMJ2DNogJJEr+uzmHsYuTgEBaIktj4RxUkzCwgLnHr
	yXywxSICJxkldky4ygiRUJbo7PnIDlLPJqApcWFyKUiYU8Bc4viWHhaIEnmJ7W/nMIP0SgjM
	5ZDo3/adBeJoF4m5xy5BPSAs8er4FnYIW0ri87u9UPFsiQePHkDV10js2NzHCmHbSzT8ucEK
	spcZaO/6XfoQu/gken8/YQIJSwjwSnS0CUFUK0rcm/QUqlNc4uGMJVC2h8SfC+8ZIcG2nVFi
	e1PGBEaFWUiBMgvJ97OQfDMLYfECRpZVjJKpBcW56anFpgVGeanl8MhOzs/dxAhOtlpeOxgf
	Pvigd4iRiYPxEKMEB7OSCO8ktkdpQrwpiZVVqUX58UWlOanFhxhNgbEzkVlKNDkfmO7zSuIN
	TSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpg8li1dD6P4NrGB0X29n+T
	MiUzPG7yO1RXZS+b+2dz49uXjf9UmCd315vtkCh8bvz80GXTNyutluh2bRBT6DZdJrxDmdvr
	S9ShM6cWbduy12CKL89sOxVR45IP/2vbf6Ur21kLq8YbGKxTvtCyd+2r9F/2jp8fBZy6fvBv
	nnna2TDNOcrbbX999BY+8Mh3ShuzPGvlo0SmTTLKTT8dnhgu7b0uutxRsLe/XUytfqLwacaj
	xxavnr3lZKfLkYOrnOZnx/8/L3R1TXApc9eau6muM84tOhJ4Z+6frY8lb2y9YXbgxHEZVp6n
	S9JOsEm0KNnHuDx06PLf0qRoPHFFw5OZZ58Vp0hH7bm84s+lSgb9U0osxRmJhlrMRcWJAABB
	Jos/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTtfQ8EmaQc8UDovVd/vZLFauPspk
	MenQNUaLM1cXsljsvaVtMX/ZU3aL7us72CyWH//HZLHu9XsWB06P8/c2snhcPlvqsWlVJ5vH
	5iX1HrtvNrB5nLtY4fHx6S0Wj8+b5AI4orhsUlJzMstSi/TtErgyTu1YylRgVHFtbh9TA6Nu
	FyMnh4SAicTFbU9Zuhi5OIQEtjNKXL7/iQ0iIS7RfO0HO4QtLLHy33N2iKLXjBK/z75iBUnw
	CthJ/J+0AKyBRUBVounSOmaIuKDEyZlPWEBsUYEkiT33G5m6GDk4hAWiJDb+UQUJMwPNv/Vk
	PhPITBGBk4wSz758Y4JIKEt09nxkh7uoq7mHBaSZTUBT4sLkUpAaTgFzieNbelgg6s0kurZ2
	MULY8hLb385hnsAoNAvJGbOQ7JuFpGUWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3
	MYKjSitoB+Oy9X/1DjEycTAeYpTgYFYS4Z3E9ihNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9y
	TmeKkEB6YklqdmpqQWoRTJaJg1OqganxZF/xigs5cx9c3rlIxb5s2j496Q29M593Sd+Vnh2S
	/FfLSOB9YNm1HGHlzcJaj1TdE4sULX+1e5pbyzasyL4ot++WlNcqx50tXK49K6008qOUXff/
	Z1rC5e9l1Wm7SWd6W0EhL9skzX8L3BgOvl9cVFlU0MMof/iEeOeeLbypRZkq5RvfJZck+umc
	ujiBr3D9llf98nddmY4abBI/2X1Tt86au6ODpU+ypprBN22Hzdc5yzwtYh9NPrn/Xva80OUN
	PZ1+sktyIrW3HumIWz251eVyIUvnJPV1Kzf7LONgFbZb7yA0p8DezugV15O/CaZda303zb8p
	pB2pIvd5y+zdp5bEtPUlGLF6GyopsRRnJBpqMRcVJwIAoHouxhkDAAA=
X-CMS-MailID: 20240913123353epcas5p4976f0b6db7bfc557eb7f6b7630122e46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911201420epcas5p1e1a323b12f168dd6bed0583d58938e69
References: <20240911201240.3982856-1-kbusch@meta.com>
	<CGME20240911201420epcas5p1e1a323b12f168dd6bed0583d58938e69@epcas5p1.samsung.com>
	<20240911201240.3982856-6-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_053403_041392_3456EA9D 
X-CRM114-Status: UNSURE (   6.44  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

