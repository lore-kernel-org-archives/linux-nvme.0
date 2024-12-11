Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630F3E77180
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=muEp29avMHP9Dfsx3yAgp2KHd89DMK17sHRSPGbmxUM=; b=SLGWR6uI24z+6xkOpBxs/P3lzP
	wQdusRrU0vadsR0rv5ibFIB3EC6hRCsvvwJgEMAF/EZ9HN/fAIrZ0xT5RRroMsQvuzv4HROT6GJlK
	djHSsW6505QBUDY6VuHG3LsoPFSDgY4Y45l5+01Kl5hA6nCBToc2deyCjSlOaBw6roFoxNnNOEyqp
	KO0z+SsiWjNoK7vn1AlGp6nsOLuTYAOv91ESAzQcFjjJ/DoF9m5ofshGOr4N/v3+KpekE8HNBtBsI
	R/jGAR9HhvgVQPa4saSH0tGWv0PlGhYHNTd+mq1/AIItyDLHP4k7+s73CGPJQ3cBzv0im88LFSOqw
	XNoofd3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLHo4-0000000EAtu-0tk1;
	Wed, 11 Dec 2024 08:10:52 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLHnn-0000000EAmd-0ClP
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 08:10:36 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241211081031epoutp0148ca4064902a7ad5fc3a9044eef8ad4c~QERNhxAXQ1331013310epoutp01V
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 08:10:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241211081031epoutp0148ca4064902a7ad5fc3a9044eef8ad4c~QERNhxAXQ1331013310epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733904631;
	bh=muEp29avMHP9Dfsx3yAgp2KHd89DMK17sHRSPGbmxUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EjxWY3XItegMM2or3nJIbZN6/D9TmxOj6NB1WHt7nkMdGqBURV5hlqZ4gsDBmb5A8
	 xU12CFjuVKTTf+aIvPPyifFhNCXwTSBh/vwT2XJvjYCjFrNK3qfio86VxMKA96HFbB
	 UaXprCWD+1M+nXtbg6QSsSiS+Vihz1iBLRmDVdRQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241211081031epcas5p3f961c90a3a9ee92b09d418cfa7b1ddbd~QERNP_6dj1823818238epcas5p35;
	Wed, 11 Dec 2024 08:10:31 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y7Svn2mH7z4x9Pq; Wed, 11 Dec
	2024 08:10:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.0B.19710.5F849576; Wed, 11 Dec 2024 17:10:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241211064906epcas5p3828a664815dd92ac462aa22c3e64d469~QDKIUT2YH3167431674epcas5p3L;
	Wed, 11 Dec 2024 06:49:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241211064906epsmtrp21a72278a6cbc165e8d24f6eee0539b6a~QDKITZ-CA0834008340epsmtrp2j;
	Wed, 11 Dec 2024 06:49:06 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-37-675948f55814
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.74.18729.2E539576; Wed, 11 Dec 2024 15:49:06 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241211064904epsmtip2e061df1a4f20639f72ba1c92a3f34579~QDKGeWa8x0125501255epsmtip21;
	Wed, 11 Dec 2024 06:49:04 +0000 (GMT)
Date: Wed, 11 Dec 2024 12:11:11 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv13 10/11] nvme: register fdp parameters with the block
 layer
Message-ID: <20241211064111.zo7nxoqczftixedt@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241210194722.1905732-11-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhu5Xj8h0g9ffhSyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AMyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdkbTnNdMBTe4
	Kv5cW8XewLiKs4uRk0NCwETiwYNzjF2MXBxCArsZJT7eWskG4XxilLh69QsTSJWQwDdGienL
	/WA6Dhw/zwxRtJdRor1xBlTHE0aJxh/n2UCqWARUJVZOmQA0l4ODTUBb4vR/DpCwiICixHlg
	SIDUMwtMZJL4faiJHaRGWCBIYsq1OJAaXqAFF7ecYIKwBSVOznzCAmJzClhILD+4lBWkV0Jg
	LYfEvNm72EB6JQRcJB6tSYI4Tlji1fEt7BC2lMTnd3vZIOxyoHNWsEH0tjBKzLo+ixEiYS/R
	eqqfGcRmFsiQ6F51hRUiLisx9dQ6Jog4n0Tv7ydMEHFeiR3zYGxliTXrF0AtkJS49r0R6h4P
	iT/NEZAw2cEoceTIZvYJjHKzkPwzC8k6CNtKovNDE5DNAWRLSyz/xwFhakqs36W/gJF1FaNk
	akFxbnpqsmmBYV5qOTyOk/NzNzGCU7CWyw7GG/P/6R1iZOJgPMQowcGsJMJ7wz4yXYg3JbGy
	KrUoP76oNCe1+BCjKTB6JjJLiSbnA7NAXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZ
	qakFqUUwfUwcnFINTAaipd86NupMSv7EGNK97uWlG5dPfnmvee6EmsLPtXuXdXVsu+Zbei7y
	X7Rl9CXtO+zpkncVJvtNuPhBmNNRJ173yVXbSfWPGF6/XlPwueTKPB2x379Kdiz6s/aG3E2L
	W2pPb2xsnHhs19cjygIPXRe3TTd+zSyv+iBMUEeYr3PNxsU1PiKvFK/wVJ+5m2v92ffM7sOz
	FQW/3U07tfD0/caTn2Rqt3i9W3tC+z3z2mOJ4qIrPRs3X9jebDn5vE2p7Eu1pfs4i6Q+98/a
	r7b/21/WAwKHet68eVvPN4tX6nvrgkWbph1S93k0o56n9bPCGdWiY6H9zQKi4Q9OLfogcODS
	N8f7Ji2G+Vc3NctmB0hUKbEUZyQaajEXFScCANDJx4JKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO4j08h0g+52bYumCX+ZLeas2sZo
	sfpuP5vFytVHmSzetZ5jsTj6/y2bxaRD1xgtzlxdyGKx95a2xZ69J1ks5i97ym6x7vV7Fgce
	j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HN49zFCo++LasYPT5vkgvgjOKySUnNySxL
	LdK3S+DKeNxymbWgi6Oi6esHpgbGb2xdjJwcEgImEgeOn2fuYuTiEBLYzShx69FOdoiEpMSy
	v0eYIWxhiZX/noPFhQQeMUrM6UgHsVkEVCVWTpnA2MXIwcEmoC1x+j8HSFhEQFHiPNA1IDOZ
	BSYzSTyfeYwFpEZYIEhiyrU4kBpeoL0Xt5xgghiZIvH09yomiLigxMmZT1hAbGYBM4l5mx8y
	g7QyC0hLLP8HNp5TwEJi+cGlrBMYBWYh6ZiFpGMWQscCRuZVjJKpBcW56bnFhgWGeanlesWJ
	ucWleel6yfm5mxjBkaOluYNx+6oPeocYmTgYDzFKcDArifByeIemC/GmJFZWpRblxxeV5qQW
	H2KU5mBREucVf9GbIiSQnliSmp2aWpBaBJNl4uCUamBiEnTS/TGDe8+Nv/Ot/Wb8CzN4Yjnb
	p/2VwLkkkyeiWwoU06Z13bnwgLdbRWFSa9u+r6uybhpsmL3pgpcpr3OsQPqyp/cPdXmW794U
	tSwhXPyS3i7DTVXyWg+P2CyftTLm/tl0m/m9e+7mWRu2+c1a+3VyKwfn2vOe1TskfJqOcSQL
	TH5jE5JYW/7iF6OTz7OX8Vt7ltxwPLiYU/1NbfniidfsXhc+XtzmK7z4hfanjF+TTPK+5tZy
	VAXH/Go70TxHc3niQtXMUw3vWou0Qi++8civ1eo3KVslZSU165Kp93PRkCsz9xU2TvltZXb8
	zSmjaKk5GRkmJ5V1uXkTl7b3MdSctJRXjPC5fa5U4a8SS3FGoqEWc1FxIgCodVCnCwMAAA==
X-CMS-MailID: 20241211064906epcas5p3828a664815dd92ac462aa22c3e64d469
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_765e6_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241211064906epcas5p3828a664815dd92ac462aa22c3e64d469
References: <20241210194722.1905732-1-kbusch@meta.com>
	<20241210194722.1905732-11-kbusch@meta.com>
	<CGME20241211064906epcas5p3828a664815dd92ac462aa22c3e64d469@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_001035_420540_19F8D3E8 
X-CRM114-Status: GOOD (  14.13  )
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

------QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_765e6_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/12/24 11:47AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Register the device data placement limits if supported. This is just
>registering the limits with the block layer. Nothing beyond reporting
>these attributes is happening in this patch.
>
>Merges parts from a patch by Christoph Hellwig <hch@lst.de>
>Link: https://lore.kernel.org/linux-nvme/20241119121632.1225556-15-hch@lst.de/
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/core.c | 139 +++++++++++++++++++++++++++++++++++++++
> drivers/nvme/host/nvme.h |   2 +
> 2 files changed, 141 insertions(+)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index c2a3585a3fa59..f7aeda601fcd6 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>+	/*
>+	 * The FDP configuration is static for the lifetime of the namespace,
>+	 * so return immediately if we've already registered this namespaces's
Nit: namespace's

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_765e6_
Content-Type: text/plain; charset="utf-8"


------QQbx9Hk6-Xl4D1oMwM2uYkP7uAkYtjoi7zPie6od2LiHNIsi=_765e6_--

