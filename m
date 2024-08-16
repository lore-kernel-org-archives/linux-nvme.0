Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706DDC52D7D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Aug 2024 05:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=wkX/HvuQM32Zc/PWJnWCw/lm1t
	sWbP8V+qC+gHuGQ0U+Qn0VU/9LACS2zfHOeBVxyy31PkPVxL4c69uSp1hwqKkxadp1LSojUj8NG6g
	VR9ZnmR82uM+Cn85tXBZFPmo2XJzvzONiR7HnAPdKqnzuNKZ9lwCFsPhn00J+LT4PdsO2LQpnK4Mv
	1P+LK+7yNKhncekGmAlwNPRmfLEzfqEMvNNyzXC+v+cdPm8OcNEV/ne69En0ZAQpd2lNL7GC/w+MU
	HSkS7nK85YHC77t0cV1FPn4FhTItnXhI1UJHoV7JwUM+p9eIB9GA11gMHghKf9+seyRsonlJ18vjc
	xyzFvnIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sepZ3-0000000BrSH-2Qyx;
	Fri, 16 Aug 2024 05:31:53 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sepYy-0000000BrQb-2Pdn
	for linux-nvme@lists.infradead.org;
	Fri, 16 Aug 2024 05:31:52 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240816053138epoutp03df5b21d70c4f5160dd88a77266798651~sHoFhtRu72861028610epoutp03M
	for <linux-nvme@lists.infradead.org>; Fri, 16 Aug 2024 05:31:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240816053138epoutp03df5b21d70c4f5160dd88a77266798651~sHoFhtRu72861028610epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723786298;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QhjoW9s6vorpHWp3Hax+Rr5qRTHzRLBLSaerrVEr05HFiO5zHJ8sVfCabI09oMNbU
	 NGZVKE7Lw8SvYoTBHQDBC6yjg4fSYet31oKHbH0pqZcCpGIvQ6RKAYrImdufVygLOM
	 AapR3aOt6ULqbBLIYeYf/barYAImlsS/4OiCN/uc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240816053138epcas5p172c0bb4866c2d69432871d753bf4cc3b~sHoFK8fIz2702727027epcas5p1g;
	Fri, 16 Aug 2024 05:31:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WlVwT0wLRz4x9Q7; Fri, 16 Aug
	2024 05:31:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.A4.09642.734EEB66; Fri, 16 Aug 2024 14:31:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240816053135epcas5p18bb797638e55b63b04159d8475d945a7~sHoC07wYb2967629676epcas5p1I;
	Fri, 16 Aug 2024 05:31:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240816053135epsmtrp128d2a65b3372cc94ee26f0f8241aa648~sHoC0SodK1844818448epsmtrp1R;
	Fri, 16 Aug 2024 05:31:35 +0000 (GMT)
X-AuditID: b6c32a4b-ea91fa80000025aa-d7-66bee437a60c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.47.08964.734EEB66; Fri, 16 Aug 2024 14:31:35 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240816053134epsmtip2214d6bbebc8443c444b23e79193acb50~sHoBvfaCq0577705777epsmtip2c;
	Fri, 16 Aug 2024 05:31:34 +0000 (GMT)
Message-ID: <7bd0b3fe-0863-e946-86e4-3e3e3394c950@samsung.com>
Date: Fri, 16 Aug 2024 11:01:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] nvme: Remove unused parameter
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	gjoyce@linux.ibm.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240814135702.99402-1-nilay@linux.ibm.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmuq75k31pBpMXGFr833OMzeLKjqWs
	FitXH2WymHToGqPF/GVP2S22TPzAZLHu9XsWB3aPic3v2D3O39vI4rFpVSebx4RFBxg9Ni+p
	99h9s4EtgC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
	LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWh
	gYGRKVBhQnbGqR1LmQqMKq7N7WNqYNTtYuTkkBAwkZh6pIWpi5GLQ0hgN6PEue7nUM4nRom9
	v/azQDjfGCUWH5zNBtNyv3syG0RiL6PEsxs/oareMkqs6FnNBFLFK2An0bT8J1AVBweLgKrE
	weumEGFBiZMzn7CA2KICyRI/uw6ADRUWMJJov/EdLM4sIC5x68l8sDEiAm4SHW3X2CDikRLX
	Pq4AG8kmoClxYXIpSJhTwFJi9bwHjBAl8hLb385hBjlHQqCXQ2JZ22xmkHoJAReJFVMyIe4X
	lnh1fAs7hC0l8bK/DcrOlnjw6AELhF0jsWNzHyuEbS/R8OcGK8gYZqC163fpQ6zik+j9/YQJ
	Yjov0JVCENWKEvcmPYXqFJd4OGMJlO0h8WLFX1ZIQPUwSkyf3sY0gVFhFlKgzELy/Cwk38xC
	2LyAkWUVo2RqQXFuemqxaYFxXmo5PLKT83M3MYKTqZb3DsZHDz7oHWJk4mA8xCjBwawkwvv0
	y940Id6UxMqq1KL8+KLSnNTiQ4ymwMiZyCwlmpwPTOd5JfGGJpYGJmZmZiaWxmaGSuK8r1vn
	pggJpCeWpGanphakFsH0MXFwSjUw8ZyZoTtnwZ/KW4tOJv13i32Qpur2XFnm/tGPt0M6ak2T
	mphVX9UYbZyr8vL2l68FSn63Ii99PrB+cYZI+4TX7SWtbH1ZTu1PBFz0/6t87bx+Yb7nyfq3
	zUszu0L3/C+8nDkxo6vaWHuF7i82pb1LN2iaud//NEH54odD0TGP2PIMLO4F31LjMVT9WN5z
	ZWuNQHnpP/9P1Tsyg81uxeS6RoQ+/P9FLr22nIVh+ovcOQ+/fV7quDmQn+uJw7mFvPV9shEb
	lGZFdp96+b1gkiDn8vNcuf6XGdu/3v9b66TzP++c1+bGe/PkppZMTOLjD4pxuNnoX8WySS16
	u/XLGX0qs4L/5K4+s3/5vWULOxsalFiKMxINtZiLihMBgLZj5y8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvK75k31pBms7pCz+7znGZnFlx1JW
	i5WrjzJZTDp0jdFi/rKn7BZbJn5gslj3+j2LA7vHxOZ37B7n721k8di0qpPNY8KiA4wem5fU
	e+y+2cAWwBbFZZOSmpNZllqkb5fAlXFqx1KmAqOKa3P7mBoYdbsYOTkkBEwk7ndPZuti5OIQ
	EtjNKPFkzhkmiIS4RPO1H+wQtrDEyn/P2SGKXjNKbN07nxEkwStgJ9G0/CdQNwcHi4CqxMHr
	phBhQYmTM5+wgNiiAskSL/9MBJsjLGAk0X7jO1icGWj+rSfzwXaJCLhJdLRdY4OIR0pMPXEP
	alcPo8TSlqmsIPPZBDQlLkwuBanhFLCUWD3vASNEvZlE19YuKFteYvvbOcwTGIVmITljFpJ1
	s5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDsaGnuYNy+6oPeIUYm
	DsZDjBIczEoivE+/7E0T4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUI
	JsvEwSnVwDR7Pc/a66cPP+yzSr3Tf+So8Jfzn04e38ETzsuyXaz17tybM+e+favz8vg/yUv1
	D9Q2BO38augl+y3mmu+HphkFdw753ogUlVxuM1f/obTgkiZV2bPWO//kV91KmPR7sXq6ud+9
	1KfvtgosuyaXMmdT6JRTS/aV8ldsFVsTKMd6XWD5zod+c8xa92odWxR6IzamrthdyNLTy8Hw
	C9M+k+p33X5zfsse45y4nXsRz3Sm7/fDFtuHMc7fqele/P0Z0+0HTpVPwg5/4Fi5cVuch+uU
	S4Jn0orf9MpczmCQPjznx+e73TU+l+y4JvQtn3Uov3u2R9qEH4XXnea+TmSNcrv0YIvDZ+1f
	Cc05p2YGSpa8UWIpzkg01GIuKk4EAHNgAXgMAwAA
X-CMS-MailID: 20240816053135epcas5p18bb797638e55b63b04159d8475d945a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240814135805epcas5p319d7763f641ae4aeac6b4f39fba0072f
References: <CGME20240814135805epcas5p319d7763f641ae4aeac6b4f39fba0072f@epcas5p3.samsung.com>
	<20240814135702.99402-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_223150_071768_45385555 
X-CRM114-Status: UNSURE (   6.62  )
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

