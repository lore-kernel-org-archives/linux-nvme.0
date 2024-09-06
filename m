Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC46CD5BDD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0f1g1OChAQVIg+/P+RwwpdB/T8a1mRhU53q+X5zvD8=; b=B6XSh5gcoWcrjoIozsEDXQegVQ
	m+VdpzzXOSxAYjSjMzgk8yW0d02AJJY4sa1mwR0ycb1N4mjTFGkdUaRlThs+fSv6CDP1iwD79rq6w
	nwRMIsXszdW0nRKkel4fcmkmtuQ0ZFUf/Ebv6XaFCrYnVauvYiVEY60sMjJDP2+KWLfVfd61WPksz
	ojm1W1lmkW4yW1BEN6eZsjphrsyVhKKIaXkA6URvogviFgKDdWl227yWo0ZyauCqffNpUtuVCaTRz
	jcPwIesnjt97P4zz8Vv2yT4E3kaDzrb29ju03QMA9usUN7m3VbOJTO3MKLNNzfV0oJQE3TTk2YNYt
	1VbVCU6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smXMw-0000000C1aM-3dKh;
	Fri, 06 Sep 2024 11:43:14 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smXMY-0000000C1XC-45is
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 11:42:53 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240906114241epoutp01e21a7cc41c17dd2706e334d9eea908f5~ypPC-vJTg0562505625epoutp01a
	for <linux-nvme@lists.infradead.org>; Fri,  6 Sep 2024 11:42:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240906114241epoutp01e21a7cc41c17dd2706e334d9eea908f5~ypPC-vJTg0562505625epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725622961;
	bh=I0f1g1OChAQVIg+/P+RwwpdB/T8a1mRhU53q+X5zvD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CuaqeVwEwlQet5FUxTC2AnwvVVNsB5oPe5DH5BN3NOVxLzzGes9oNrw97/f1FwrfM
	 q6GAdNKvdsudqqzLsx/fKeaMQ3N4Mp6oI124cXD6++HlxI24ocwvnWFqH3Y2npJlnX
	 A/a+8AutHqHjuxL4yvFipsPnzfMTRyskHLimpDvU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240906114240epcas5p2ff60a6faead4fdd6804a294c862c99c6~ypPCxpnxl2356423564epcas5p2D;
	Fri,  6 Sep 2024 11:42:40 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X0Z8v2tcyz4x9Pv; Fri,  6 Sep
	2024 11:42:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1E.95.09640.CAAEAD66; Fri,  6 Sep 2024 20:42:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240906113005epcas5p3834f1801e55f449145e07ec5f0f762f4~ypEDWS3Eh2321123211epcas5p30;
	Fri,  6 Sep 2024 11:30:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240906113005epsmtrp123e18d8ea38941253a7cd0c13027e0e4~ypEDVs6Ys2255522555epsmtrp1J;
	Fri,  6 Sep 2024 11:30:05 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-2d-66daeaac5a73
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.CE.19367.DB7EAD66; Fri,  6 Sep 2024 20:30:05 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240906113004epsmtip272e11f003d078dc152e09c3de233b2ba~ypEB6rDH02446224462epsmtip2U;
	Fri,  6 Sep 2024 11:30:03 +0000 (GMT)
Date: Fri, 6 Sep 2024 16:52:32 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [PATCH-part-2 2/9] nvme-pci: provide prp selection helper
Message-ID: <20240906112232.r6o65pqmt7knolw4@green245>
MIME-Version: 1.0
In-Reply-To: <20240904183818.713941-3-kbusch@meta.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpu6aV7fSDD4v17NYufook8WkQ9cY
	Lc5cXchiMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDzOHexIoA1KtsmIzUxJbVI
	ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2i3kkJZYk4pUCggsbhY
	Sd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y13nZfaC2ywV
	//uusDYwTmbpYuTkkBAwkei8/pati5GLQ0hgN6PE9yu3mSCcT4wSx5d/Y4Nz/k47wgrTsr5x
	ElRiJ6PEsf8rWSGcZ4wS67r/g1WxCKhI3Jh7gxnEZhNQlzjyvJURxBYRUJQ4DwwCEJtZIFli
	+6kTYPXCAm4Scztegtm8AmYSlzc1sUHYghInZz4BO5YTKL7u0S12EFtUQEZixtKvzCCLJQQe
	sUv8+/CGHeI8F4llh+ZD2cISr45vgbKlJF72t0HZ6RI/Lj9lgrALJJqP7WOEsO0lWk/1M0Mc
	ly6x/FEzG0RcVmLqqXVMEHE+id7fT6B6eSV2zIOxlSTaV86BsiUk9p5rALI5gGwPiTPbvSEB
	tJVR4sqKuywTGOVnIfltFpJ1ELaVROeHJtZZQO3MAtISy/9xQJiaEut36S9gZF3FKJlaUJyb
	nlpsWmCYl1oOj/Hk/NxNjOC0qeW5g/Hugw96hxiZOBgPMUpwMCuJ8D71vJUmxJuSWFmVWpQf
	X1Sak1p8iNEUGFcTmaVEk/OBiTuvJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILU
	Ipg+Jg5OqQamGX4fnWf9CJRKUeV+dffI/kMfPZ4edj0iZOC+l6Xp9KnKSxsUrB7yFR8OW7ml
	+rWrcdkZ4VO7pzvxpzed3X52j3pXp+3h/uSFGgdO3djfFHNDuKTYjPXGT75Et+d8/1/tfyFe
	f3UBb82mRbOXSFzMVz//z9GHnat6gvuP4sY7tX1XpGOOn7MoX580K/Cmvi2H8OtHE6Xq6m7s
	/nL1W+1Hb+1Dn/uOh57uu7/3zOazft+m9GzfuTj4a8Ml7jk+JxM2Flgu6q03fK9fb1tacm/R
	CkWTwOw3tuurRFb7OiWK6Aakdhkr1awXefjaWFr918vQIvvzsaENv5PTbLqa0k/qLbBh+72V
	I23zwQQr8xgnJZbijERDLeai4kQAZIgJKyQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvO7e57fSDG5/kbRYufook8WkQ9cY
	Lc5cXchiMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDzOHexIoA1issmJTUnsyy1
	SN8ugSvj4Yd29oIJTBV7ts1naWB8xNjFyMkhIWAisb5xEhuILSSwnVFi7RZjiLiExKmXy6Bq
	hCVW/nvO3sXIBVTzhFFi3eITLCAJFgEViRtzbzCD2GwC6hJHnreCNYgIKEqcB7oCxGYWSJbY
	seM+mC0s4CYxt+MlK4jNK2AmcXlTE9TiRIkZHbfZIOKCEidnPmGB6DWTmLf5IdB8DiBbWmL5
	Pw6QMCdQeN2jW+wgtqiAjMSMpV+ZJzAKzkLSPQtJ9yyE7gWMzKsYRVMLinPTc5MLDPWKE3OL
	S/PS9ZLzczcxgkNcK2gH47L1f/UOMTJxMB5ilOBgVhLhfep5K02INyWxsiq1KD++qDQntfgQ
	ozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qByUYl/Uun9pw9DMFuG1fEuHD8z3vGY2Pf
	aBF8ZnfKlcZp+xd4z5a0/X0n0Opu9d5E/8uv34v8/XNwf4TE5P0dRZlHV84qvpcWuE2p+hJn
	565Lnx4XH1w6bV+c0vruBCE95rupSaHbFoYZKi5+Ncl9yesDfE0PIvey7Wyum3Wys2XKjG+L
	Yg/cY99eqrb9gN3Emunyew8yaoYlvltzKO/iU86tlqqbl3Wse7LF4NiGLdIX4zqLDb9H+D1g
	W6TAcv8iy8kJV195FR27seqdhZFT5H31/VYbri9f5DMhjqt4U0hIiOEq46bOT3Pcz4jqJfiF
	v707Z62WWxDjBnHTfIPQ4795HsRXfyg6EbVlW8HCxBtKLMUZiYZazEXFiQDo8Hjz4AIAAA==
X-CMS-MailID: 20240906113005epcas5p3834f1801e55f449145e07ec5f0f762f4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_5add_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240906113005epcas5p3834f1801e55f449145e07ec5f0f762f4
References: <20240904183818.713941-1-kbusch@meta.com>
	<20240904183818.713941-3-kbusch@meta.com>
	<CGME20240906113005epcas5p3834f1801e55f449145e07ec5f0f762f4@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_044251_625813_EFA78393 
X-CRM114-Status: GOOD (  11.82  )
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

------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_5add_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/09/24 11:38AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>+static inline bool nvme_pci_use_prps(struct bio_vec *bv)
>+{
>+	unsigned int off = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);

Nit: please add a new line after variable declaration

------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_5add_
Content-Type: text/plain; charset="utf-8"


------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_5add_--

