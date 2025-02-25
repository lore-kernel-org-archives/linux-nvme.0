Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD254C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=34JqRTlrCGOE+ilMWa2ivf47J5
	RsD+efOy4Fl8q8lJcdE/Ua/C5zGBmZqapV82tpKSO2ur75Wn4tDr598KD0geE/hZbzrU0hztN/aOb
	ZiMIoJ1Ffo/gB001JdMXpwJzWnTKA0N+dzqJnsuPtJcsHAEGYWpvlAZhr1Lb95oZen/d9+pWk22fC
	YNDzvyNW8ZoEOAZpc74F7SzVe/+DHmYDJs6WkZS4EKnHTY+gx8nF5hNKNDfhdK0k3QNhnqdL3lEfl
	j6wC/FIHAk+LWlNkZ2E0OiEGFkPouadIz7nvXH2gbOhUZWHJjSf77k4rC61U3elYrBRR9gNiVe833
	377rnTdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmmQc-0000000Fvpe-1dkg;
	Tue, 25 Feb 2025 04:20:18 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmmQY-0000000Fvp2-2s2u
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 04:20:17 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250225042006epoutp029fc30fbb7f4769e76df86e868a78c262~nWJu0iNSs2674726747epoutp02R
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 04:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250225042006epoutp029fc30fbb7f4769e76df86e868a78c262~nWJu0iNSs2674726747epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740457206;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KQ2xaKne3DUQVQcjjVo6xR5HSc7TFnhc9iz4cDR8rXgh77z9feYGU3PQ6Lx3/xEPI
	 vR8ynosNI1qV9Q2dLnzD5o45iypjzhut6JId5KWS2w2o+wBIC9BUma4zKA+4q0YFIw
	 r8jfd5Fm+rpG1ljb9V60lvvgkUMfL9P0ZKzBWO0g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250225042006epcas5p33627a58a570497f5a18b288aae3c396a~nWJuTyOSM2059620596epcas5p3H;
	Tue, 25 Feb 2025 04:20:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z24Br5wLYz4x9Px; Tue, 25 Feb
	2025 04:20:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.A4.20052.1F44DB76; Tue, 25 Feb 2025 13:20:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250225042001epcas5p4d7ffce3cd4f8fa4d641ef61e21ce4403~nWJqKlKPk2119821198epcas5p4F;
	Tue, 25 Feb 2025 04:20:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225042001epsmtrp18a1485eb4bb5264cb7120378214124b7~nWJqG3M3d2804528045epsmtrp1P;
	Tue, 25 Feb 2025 04:20:01 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-00-67bd44f1738c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.8D.18949.1F44DB76; Tue, 25 Feb 2025 13:20:01 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225041959epsmtip15a9e9416939d797eed0b524b09a557c7~nWJoQrM860306503065epsmtip1f;
	Tue, 25 Feb 2025 04:19:59 +0000 (GMT)
Message-ID: <138d8b34-ae16-4a39-9798-d3aa2481fb6f@samsung.com>
Date: Tue, 25 Feb 2025 09:49:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-ioctl: fix leaked requests on mapping error
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250225013547.1130524-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTXfeTy950g6nCFg/221usXH2UyWLS
	oWuMFmeuLmSxmL/sKbvFutfvWRzYPM7f28jisWlVJ5vH5iX1HrtvNrB5nLtYEcAalW2TkZqY
	klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7ReSaEsMacUKBSQ
	WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcWrHUqYC
	o4prc/uYGhh1uxg5OSQETCT+fJrN3MXIxSEksJtR4uWUDSwQzidGiSdz9zODVAkJfGOUePNP
	BqZj9pzpbBBFexklXtxbDeW8ZZTYeu8+G0gVr4CdRMPOLUxdjBwcLAKqEn2vDCDCghInZz5h
	AbFFBeQl7t+awQ5iCwu4SqyfdxOsVUQgUeLsic1gNrOAucT3ty/ZIWxxiVtP5oONZBPQlLgw
	uRQkzAlUMu/IbqgSeYntb+eAfSMh8JNd4vzaDiaIo10k7nw5BmULS7w6voUdwpaSeNnfBmVn
	Szx49IAFwq6R2LG5jxXCtpdo+HODFWQvM9De9bv0IXbxSfT+fgJ2joQAr0RHmxBEtaLEvUlP
	oTrFJR7OWMIKUeIhMaXFGxJQXYwSJ980M09gVJiFFCizkDw5C8k3sxAWL2BkWcUomVpQnJue
	WmxaYJiXWg6P6+T83E2M4ISp5bmD8e6DD3qHGJk4GA8xSnAwK4nwcmbuSRfiTUmsrEotyo8v
	Ks1JLT7EaAqMnInMUqLJ+cCUnVcSb2hiaWBiZmZmYmlsZqgkztu8syVdSCA9sSQ1OzW1ILUI
	po+Jg1OqgYn5yyT9T04qU31MXZM797Qlr70/Udhyk8qx979nTWS59v8K/8zNf7T1Dq36K/nC
	O7LxfMqZJfGLWISYnjTyFiU+ZNgk63XQbuFbn00KKdvmr1t/lOHma859NzTyFPWOMH9YPVnF
	5M2+yAV1tn43Db8dqu45Jmg/o/l7p0JqPkM0z8+wZzz/mpo0b/M8EtU+mN2sWL+wc+cBocwW
	sZXbnP4LaZUffjXhUmfJrX9R7podppdEP2rfrz3k5PDspSXTdEuVkGcTzR6YbBdcJ/ZprRHj
	7mdOEjKL2hNeGu9eHrr844MV2TrWC16v69IvnPJ9srH6tZlCb0RnvFvKviFBJUTCq5K/ctNJ
	v0NrEtnf3JimxFKckWioxVxUnAgALEj0cSEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO5Hl73pBp13NCwe7Le3WLn6KJPF
	pEPXGC3OXF3IYjF/2VN2i3Wv37M4sHmcv7eRxWPTqk42j81L6j1232xg8zh3sSKANYrLJiU1
	J7MstUjfLoEr49SOpUwFRhXX5vYxNTDqdjFyckgImEjMnjOdDcQWEtjNKPHsWgpEXFyi+doP
	dghbWGLlv+dANhdQzWtGiXufz4EleAXsJBp2bmHqYuTgYBFQleh7ZQARFpQ4OfMJC4gtKiAv
	cf/WDLByYQFXifXzboLtEhFIlLi7+jMjiM0sYC7x/e1LqPldjBJb/p1ghkiIS9x6Mh9sPpuA
	psSFyaUgYU6g+nlHdrNDlJhJdG3tgpojL7H97RzmCYxCs5CcMQvJpFlIWmYhaVnAyLKKUTK1
	oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4QrS0djDuWfVB7xAjEwfjIUYJDmYlEV7OzD3p
	QrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTAFhrSr1hnN
	c1iTeODuC8Pf97fzL8kK2R++ZovR6s5pXZ+dFTJarlu7pl/1CtTlEfYJOlHO49lj2ji3TnpB
	UqKT+Vq9QsEOTdb9kiteGCjs6jzLm80T9ew94/tyh+ffVzD+629OrOc6eJtNRvKp268pT14s
	uKU5xX/qAWfNf9/mit1cd7V+xt5zjWHzLdyM7HKm6z/MafwkcktEW67l/Cz3/E91Uyy4dy3y
	eK/l/yfjW+5E87e9q3OCgrMnns69qXJ1xpyEdQVnK4OM9NZfSVuomCmnsXf61J5qzztmZ5fN
	bXxTU/tYRyrB8Iva2eOatxeubY61Cjjz8Fp59qWsqu0yUj/jwtazzo05t8pu/holluKMREMt
	5qLiRACKP4BK/wIAAA==
X-CMS-MailID: 20250225042001epcas5p4d7ffce3cd4f8fa4d641ef61e21ce4403
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225013826epcas5p4e9524e752fb787d5ef2d8a883e5988c9
References: <CGME20250225013826epcas5p4e9524e752fb787d5ef2d8a883e5988c9@epcas5p4.samsung.com>
	<20250225013547.1130524-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_202015_361422_7361263E 
X-CRM114-Status: UNSURE (   8.19  )
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

