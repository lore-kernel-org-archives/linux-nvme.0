Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1032CE8E6A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCzriyhqNMjlcIsM4ZnEFnslNDwAfcUmDNhnQeHmzBE=; b=DvxB8YN7J+f1qCT+0cePNl8XYx
	8n7Ch9Zs8zNnQTJRFR1KQNgLwgggfMns1GJYSqDbSPKBBOBYtpjBBFCowVDm+bLnHdRdjRbYTwui7
	Q6NPhQgtKxwySG78nxO0/XI/nCPwwo5v7BzDlOcEFxDI5Oq9JFnDL5MNlmxq0t/UYJ50O+5af8yHf
	LLDsdtn6P/T7zxNfRnIAmYRMiGLCzos9WFY43+hEsvXJezhPmgeExTDVBpefQz5qS4t9dXWWcgv8I
	Gjoj9YHQXvdMjlnuhgM0qB8/sGbBicL+b3G79B+hAnYicMtfPJF5rM7NWraszaSnN40OUhP7lPCGg
	rfBTJruw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4222-00000001Mh7-3nkf;
	Thu, 24 Oct 2024 17:53:58 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t41f4-00000001IEA-3K7b
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 17:30:16 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241024173007epoutp04c4fc7625b1b12ab73bc0f9241b361567~Bc8GtJ2v_0298902989epoutp04u
	for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 17:30:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241024173007epoutp04c4fc7625b1b12ab73bc0f9241b361567~Bc8GtJ2v_0298902989epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729791007;
	bh=dCzriyhqNMjlcIsM4ZnEFnslNDwAfcUmDNhnQeHmzBE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YfPI9fEAYScxZlFn1MTO5RzXb15VHeZJSMAlBKTWbv/fJ01CYZ/avJ5kqpwVtk1nv
	 FHWTR0UxAGjmrOIGJNeFqCxV5Ix4RbgqjL88pSGC4QP1g/cSnwQybCRdhdOUCl5ER8
	 E/khQ0CXfjZKnjdltHGGBYe2HsCi/qTFmrHhzl4w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241024173007epcas5p26dfa5fe2babb33348a30b6b36d7f360b~Bc8GQlQRE2236722367epcas5p22;
	Thu, 24 Oct 2024 17:30:07 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XZCbd6fQrz4x9Pr; Thu, 24 Oct
	2024 17:30:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.AE.08574.D148A176; Fri, 25 Oct 2024 02:30:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241024173005epcas5p31d296cd70b58182b3c2ff1f22e2c14b0~Bc8Epz0qP0348603486epcas5p3Y;
	Thu, 24 Oct 2024 17:30:05 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241024173005epsmtrp23134de308f5a05afa6dc3d59d8af6d02~Bc8EpAOqX2374523745epsmtrp25;
	Thu, 24 Oct 2024 17:30:05 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-db-671a841d51a6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.B8.18937.D148A176; Fri, 25 Oct 2024 02:30:05 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241024173004epsmtip12c67612520c435496d6e1b1148ffb215~Bc8Do6nF12141621416epsmtip1N;
	Thu, 24 Oct 2024 17:30:04 +0000 (GMT)
Message-ID: <79039108-47d1-4fe2-9a93-e44553e7896a@samsung.com>
Date: Thu, 24 Oct 2024 22:59:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: module parameter to disable pi with offsets
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, martin.petersen@oracle.com,
	David Wei <dw@davidwei.uk>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Zxp5hNBP-dAaCrBn@kbusch-mbp.dhcp.thefacebook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmuq5si1S6wbu5RhavZqxls1i5+iiT
	xaRD1xgtzlxdyGIxf9lTdovlx/8xObB5XJsxkcVj06pONo/NS+o9dt9sYPM4d7HC4+PTWywB
	bFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
	lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoT
	sjOOXF/IWHCAqeLa4b0sDYwtTF2MnBwSAiYSqy/eY+ti5OIQEtjNKLHzfC8zhPOJUeLS3IUs
	cM6z75fhWpZcnM4IYgsJ7GSU6DuRBlH0llFix66fzCAJXgE7iUctb8FsFgFViQNbpzJCxAUl
	Ts58wgJiiwrIS9y/NYMdxBYW8JC4+GwvG4gtIuAk8eHjHLB6ZoEMiTs3PjND2OISt57MBzqC
	g4NNQFPiwuRSkDCngL3E4gXnmSBK5CW2v53DDHFnI4fE2854CNtF4mrjJ6j7hSVeHd/CDmFL
	SXx+B7FWQiBb4sGjBywQdo3Ejs19rBC2vUTDnxusIGuZgdau36UPsYpPovf3E7BrJAR4JTra
	hCCqFSXuTXoK1Sku8XDGEijbQ6L/2XYmSEjtZ5RoOPKGbQKjwiykQJmF5MlZSL6ZhbB5ASPL
	KkbJ1ILi3PTUZNMCw7zUcnh0J+fnbmIEJ1Etlx2MN+b/0zvEyMTBeIhRgoNZSYT3YoZkuhBv
	SmJlVWpRfnxRaU5q8SFGU2DsTGSWEk3OB6bxvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNIT
	S1KzU1MLUotg+pg4OKUamLyPel//q/x8DmeZ5Yx39RfNGwwLfZ4GhZjb2Eo12Vlc476QfMnM
	e2/gt5e+0xYaHD90NdkwsGrBwh4B2TjTuon1fiGnWs3r/K1FvYpn+kxJ2b/gqWFakXDD3ohk
	7x+F6U+OTgp8dUYu+VjO/uNysTNbBC0D3ddd8qhu9Xz6uvjlFVk/i3d+2iZ/lnIx866bbvnM
	Q9zo7i2RLK2vF+2Ej9xPaFwwYY5ByhGp/NBtr7+/C9Lf//JoNeeaTd7vzhVanna44vb3nxbn
	htOLV7wTnJRlflZGrdd+/aaznFvdpx1/FPL+LH9yvOXCc74G/gH7jifZvn91MbTnkMtxJ8+b
	Cvd+nAtqzNUsbZp86qrCMSWW4oxEQy3mouJEACcXieArBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnK5si1S6wal1AhavZqxls1i5+iiT
	xaRD1xgtzlxdyGIxf9lTdovlx/8xObB5XJsxkcVj06pONo/NS+o9dt9sYPM4d7HC4+PTWywB
	bFFcNimpOZllqUX6dglcGUeuL2QsOMBUce3wXpYGxhamLkZODgkBE4klF6czdjFycQgJbGeU
	6D0yjxUiIS7RfO0HO4QtLLHy33N2iKLXjBK3rpxiAUnwCthJPGp5ywxiswioShzYOpURIi4o
	cXLmE7AaUQF5ifu3ZoANEhbwkLj4bC8biC0i4CTx4eMcsHpmgQyJg8ub2SAW7GeUmDfpG1RC
	XOLWk/lAp3JwsAloSlyYXAoS5hSwl1i84DwTRImZRNfWLqhyeYntb+cwT2AUmoXkjFlIJs1C
	0jILScsCRpZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMHRohW0g3HZ+r96hxiZOBgPMUpw
	MCuJ8F7MkEwX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRq
	YAq1XnFgw9eWLq+UMmOjf/8MX6Zn3dLs9Fb48/aNUmHJ9ys3F/AdXnVA0ZxviqaabvZ2l7AX
	Ou39fIHTFsu195yU6XCzmNHKv4H5gf9vHc2GHfP7+FJ+VveX9tTkpSUW3/3n/Sf85K2TihPk
	XHw2Gk/ZvrKIsTFc+fL0GVt2TdfiZNdacI0l9uyZmASP5XYZrre/NU1hWT/3VF7r4n3n2Dh0
	rRgcnD2fBnxoPatrvcncntUmTHUzi+H9OdU7JRLKc5//7GeqtlQz3zPFMWfmZ/eyRVsVD7LE
	LmnxZOERkzVvtt9lxnPuU+zmJqFdDKv6FeP+FS5zb+SLSEhJ+2q8JdDRwVxE2Znvtr7Kp2Al
	luKMREMt5qLiRAAGQ9bQBQMAAA==
X-CMS-MailID: 20241024173005epcas5p31d296cd70b58182b3c2ff1f22e2c14b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241024164500epcas5p4f26444456efae1a21c454048e225397c
References: <20241024154923.3156803-1-kbusch@meta.com>
	<CGME20241024164500epcas5p4f26444456efae1a21c454048e225397c@epcas5p4.samsung.com>
	<Zxp5hNBP-dAaCrBn@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_103015_510268_4C9109FE 
X-CRM114-Status: GOOD (  10.31  )
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

On 10/24/2024 10:14 PM, Keith Busch wrote:
> On Thu, Oct 24, 2024 at 08:49:23AM -0700, Keith Busch wrote:
>> +	if (info->pi_offset && disable_pi)
>> +		head->pi_type = 0;
> Added to nvme-6.12, with the typo fix: should be "disable_pi_offsets"

With that change

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

