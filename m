Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49328C021BC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=hqrbzPt6hBXy4fSAZDehKvOQBX
	js8ypcLJO5Xr8iyYy515Uaqn47uNwP2uLc4+GE7R4IDjAfXjd2xURR1bLSZJx2qiAORo98X5+SUHA
	9gXM0OkMDNrXiyl1ICj19nnTKoN66P4aX65KA0AWyhgyLBRsN0SvN4gP1qAbFCv8Ds6QfD26q9fUm
	6lZ9gVdA46rDfX5WSjPX1c/eG5mDOTY0ZmF6IOKlDBDhI0lB6EunRdC15A2b9qLCZFj2D49X+egmD
	vEafWyT+0IE2whons+VTN2Iwj5qXzI+9FqRWHdPl9SoQkzOMYCHXqROMpAjwe8uN/BdRX1kBFvXWP
	3Gi2hOQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrPr-0000000GdmQ-2UGA;
	Tue, 25 Feb 2025 09:39:51 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmqvP-0000000GWHX-2kt1
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 09:08:26 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250225090816epoutp02dc6a07b202a7aaee445cc802a63cdc2b~naFUvNHD03166231662epoutp02z
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 09:08:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250225090816epoutp02dc6a07b202a7aaee445cc802a63cdc2b~naFUvNHD03166231662epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740474496;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VRwRyfTE0eINw/mh6oL03p/REpoREKpAhpYrTbtT3gBA93zQQ/VEPzfgDS2nM71WO
	 sHGBLRI4nR8PE61+JNgDgWQ53hPELg9/dkdJa1fOU5E5aOYVpnH9WCKpSF5QFulzaD
	 EY2SlfAcyrGApuFYclMbsqUA9uMcQLii55XgM/Vk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250225090815epcas5p3ccccf1bea192e2dd21732e5288712d77~naFUkCCqo2837828378epcas5p3m;
	Tue, 25 Feb 2025 09:08:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z2BbM1L6xz4x9Pq; Tue, 25 Feb
	2025 09:08:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.60.19933.E788DB76; Tue, 25 Feb 2025 18:08:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250225090814epcas5p16d8aefc7e2883dbfb9b94d24db20004e~naFTj1HZN0230002300epcas5p1g;
	Tue, 25 Feb 2025 09:08:14 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250225090814epsmtrp23c5e56f4e0e32db1fa598b4b8707ca84~naFTjOWJw2427224272epsmtrp2Q;
	Tue, 25 Feb 2025 09:08:14 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-df-67bd887e43e4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.C6.33707.E788DB76; Tue, 25 Feb 2025 18:08:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250225090811epsmtip2e12586b7d5eb56bf26b594730ba488d0~naFQPoNta2656926569epsmtip2o;
	Tue, 25 Feb 2025 09:08:10 +0000 (GMT)
Message-ID: <1388672d-bb07-4d66-beda-0fb00d489553@samsung.com>
Date: Tue, 25 Feb 2025 14:38:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme-ioctl: fold 'vec' into flags
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250224182128.2042061-4-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTS7e+Y2+6wbZPTBYrVx9lsph06Bqj
	xZmrC1ks5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwe5y5WBLBGZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
	6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnAqOLa
	3D6mBkbdLkZODgkBE4mmjU0sXYxcHEICuxklZj5/wwjhfGKUODy5jxnOedQ4gRmmZePGBawQ
	iZ2MEtcPTmKCcN4ySjz5vpoNpIpXwE5iycLJQLM4OFgEVCVu3XeECAtKnJz5hAXEFhWQl7h/
	awY7iC0sYCWx+uAJsAUiAokSZ09sBhvDLKAs0dnzkR3CFpe49WQ+E8hINgFNiQuTS0HCnALm
	Eo0bIUYyA43c/nYO2NESAm/ZJaZPvccGcbSLxJuOt+wQtrDEq+NboGwpic/v9kLVZEs8ePSA
	BcKukdixuY8VwraXaPhzgxVkLzPQ3vW79CF28Un0/n4Cdo6EAK9ER5sQRLWixL1JT6E6xSUe
	zlgCZXtI9D3vgYb0dkaJ+5tfsE5gVJiFFCqzkHw5C8k7sxA2L2BkWcUomVpQnJueWmxaYJSX
	Wg6P7eT83E2M4HSp5bWD8eGDD3qHGJk4GA8xSnAwK4nwcmbuSRfiTUmsrEotyo8vKs1JLT7E
	aAqMnYnMUqLJ+cCEnVcSb2hiaWBiZmZmYmlsZqgkztu8syVdSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gUnZTqe5rXhDoF6vzcOm9BsamQ+N+Z1iQ6qPhjUKhlaKTZn3+U53D9MSmUYD855NOh8Tcl9E
	TzW+dq2/9oVVwaRTx5+ckC/ZYDDpXJLdRI6gsgVczi9/cjAfX3J7xmrttbJvLuSU7E+bHC49
	J5EnkGWOBs8j2UtiyxT3TImRdD8g3zRZgSPw/POdCy5KzuO1u5/+0t9pmkeE4S3vqC3+PJyc
	Gp8zw3L03LsCrtXXfazed8Zqk4xF5f+N9/d/35FhfTa0em7d0soQHeOilkvr5s8PNnt+qHSW
	0aPGb3cn5KoZn1SOVp2Tsq226e/p9r1ZGzeKN9W/23rqYUPflJ+TP/4OfhYa0HBRvMrj0LTy
	E0osxRmJhlrMRcWJAC43fYwgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG5dx950gyX3dC1Wrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCN4rJJSc3JLEst
	0rdL4Mo4tWMpU4FRxbW5fUwNjLpdjJwcEgImEhs3LmDtYuTiEBLYziix8vA/ZoiEuETztR/s
	ELawxMp/z8FsIYHXjBKXtwuA2LwCdhJLFk5m7GLk4GARUJW4dd8RIiwocXLmExYQW1RAXuL+
	rRlgrcICVhKrD54AGy8ikChxd/VnRhCbWUBZorPnIzvcDSdPb2CBSIhL3HoynwlkPpuApsSF
	yaUgYU4Bc4nGjU+gSswkurZ2Qc2Rl9j+dg7zBEahWUjOmIVk0iwkLbOQtCxgZFnFKJpaUJyb
	nptcYKhXnJhbXJqXrpecn7uJERwRWkE7GJet/6t3iJGJg/EQowQHs5IIL2fmnnQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGpu1/UxRnHLh2wY2L/8uL
	sDqBSz9m5RjNND6o+fKCvfHej8dvXv+hWXvdtuL6faP/BS9MF4lcnyB94qKviYT2E55bB/tD
	7PIe9bw5yHV8ir1n5hI+Fccz+UcNMnZpS59bd7Lg+0Uetius6zZf5oqXlH0bdsN71fO7F80k
	ZjxVkpZMsIiafSJQtCm5PnzDuRjLgBXtQQkGAcVARRtvOTyP/qn9wVeUU/Lbl0Oe01I2PfcK
	P3XqS136uwMvha4wfz19XzTIUK3q99UZ4ZaCTcncx1p0QvbYMDn91fqaMoftHme7xV+1OfUK
	j3mabr9/u2UTM0/jJYcTS+Tff75weKOAQsexI4dmPPyaP0v1WWPQNSWW4oxEQy3mouJEACJW
	LsX3AgAA
X-CMS-MailID: 20250225090814epcas5p16d8aefc7e2883dbfb9b94d24db20004e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250224183338epcas5p483043647e340b96948fafdb0aee6d02b
References: <20250224182128.2042061-1-kbusch@meta.com>
	<CGME20250224183338epcas5p483043647e340b96948fafdb0aee6d02b@epcas5p4.samsung.com>
	<20250224182128.2042061-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_010824_010313_8FC6C265 
X-CRM114-Status: UNSURE (   7.98  )
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

