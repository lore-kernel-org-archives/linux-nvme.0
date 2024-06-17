Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF2C27C79
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iyz4lhwHzIQ2xM7JeB8g3lGuDxIxMLt9noIUFj6buu8=; b=stZTU/I/boZXQQXtS3Qgp+9Oym
	aFRxskwbfvCH4EDIqZ3klRHDHbfMKm4unvEHf0vyXQ3aYm2L2uVJZw0PLK26HUfEFPHOw6uCxA/P7
	a7q6gchLl9cbOD3Dm1fuiPI/PlxRTgy1BoKfGzw746YSl57n8cLWWMjdZbTTEPQMBkxMSIcTvlh45
	uGgU9BIgdU/db3OYTG3W8xlJcKpT0kjDPR1656KSF8TMSm5SPXuc1zclYXdPHliXMBwEvM6eN1gEW
	BKQDyAKzpSvFLDnPoKarx6aGHtb0LWHRZJlF7k9oOZPAYAEbEWjzxli8aXX2epD043amJTFXhBYVu
	yGk1GPHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJDNA-0000000BBB0-1qk4;
	Mon, 17 Jun 2024 14:30:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJDN6-0000000BB8r-16Th
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 14:30:15 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240617143004epoutp02f4ee2a9f7dd15b28a1d5a69e4a3b1d3f~Z0RE9bKJZ0735307353epoutp025
	for <linux-nvme@lists.infradead.org>; Mon, 17 Jun 2024 14:30:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240617143004epoutp02f4ee2a9f7dd15b28a1d5a69e4a3b1d3f~Z0RE9bKJZ0735307353epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718634604;
	bh=iyz4lhwHzIQ2xM7JeB8g3lGuDxIxMLt9noIUFj6buu8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=I+ADQyxXxS5bZOs6GIL71GIFsHGCO3o2Ut9jceSwaJIW1mXSJg/OgYkZJEk5u/O7J
	 9xqibIkzqsXjtp2cPfk1YA/qP29YMTyGdVJHetVWILIjTfBVbsv2TtM+PleHuAxMOv
	 ilWLCMOQnzP2DmvpwGwZceBKpoJ5Z5Eb9/V/UeLk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240617143003epcas5p4bb7207b37df8b199a55d7496931926ec~Z0REGWHl61570915709epcas5p4j;
	Mon, 17 Jun 2024 14:30:03 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W2sjQ4RdWz4x9Pq; Mon, 17 Jun
	2024 14:30:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.B9.19174.A6840766; Mon, 17 Jun 2024 23:30:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240617143002epcas5p452f4bfa436d4c58418fe7a073823f355~Z0RCikIXc0444604446epcas5p4U;
	Mon, 17 Jun 2024 14:30:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240617143002epsmtrp19cb132c9b9b0b1f8f339c4c397a620fa~Z0RCcgLrR2965729657epsmtrp13;
	Mon, 17 Jun 2024 14:30:02 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-f8-6670486a2488
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.16.08336.A6840766; Mon, 17 Jun 2024 23:30:02 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240617143000epsmtip1d34a910d9e918b9434cddb96b1c5e409~Z0RBaa3fk3010430104epsmtip14;
	Mon, 17 Jun 2024 14:30:00 +0000 (GMT)
Message-ID: <90f3cedb-7553-9007-6ab1-38e1562c8f33@samsung.com>
Date: Mon, 17 Jun 2024 20:00:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] nvme: fix NVME_NS_DEAC may incorrectly identifying the
 disk as EXT_LBA.
Content-Language: en-US
To: Boyang Yu <yuboyang@dapustor.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240617131144.48955-1-yuboyang@dapustor.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhm6WR0Gawa0OOYvVd/vZLFauPspk
	MenQNUaLy7vmsFnMX/aU3WLd6/csFtPamRzYPT63/mD1OH9vI4vH5bOlHptWdbJ5bF5S77H7
	ZgObx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4B
	um6ZOUDXKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkus
	DA0MjEyBChOyM/4dOMJU0MVcsfPgF8YGxkNMXYwcHBICJhLdU3y6GLk4hAT2MEr8nX6HBcL5
	xChx6+x6ZgjnG6PE1kPdQBlOsI7ri45AJfYySpx++ATKecsoMa3zKwvIXF4BO4nvL3lATBYB
	VYkpr3JBenkFBCVOznwCNkdUIFniZ9cBNhBbWCBO4kbDSVYQm1lAXOLWk/lg14kIZEp83ygN
	EXaQuHC1mw0kzCagKXFhcilImFPAWuLZuhtMECXyEtvfzgE7RkJgKofErOX7oE52kbj++TI7
	hC0s8er4FihbSuJlfxuUnSxxaeY5Jgi7ROLxnoNQtr1E66l+ZpC9zEB71+/Sh9jFJ9H7+wk0
	DHklOtqEIKoVJe5NesoKYYtLPJyxBMr2kNjZDDIRFE59jBLnn/9mnsCoMAspUGYheX4Wkndm
	IWxewMiyilEqtaA4Nz012bTAUDcvtRwe28n5uZsYwSlVK2AH4+oNf/UOMTJxMB5ilOBgVhLh
	dZqWlybEm5JYWZValB9fVJqTWnyI0RQYOxOZpUST84FJPa8k3tDE0sDEzMzMxNLYzFBJnPd1
	69wUIYH0xJLU7NTUgtQimD4mDk6pBqa5584KvGzpjFy/WTykfFoKh4NRoJ9myVF96ckKosL+
	z5g7DsxKPHY361ENm+lH67pYgRKlTdf+nGn/cnddtPbs9cIyeeZSv0Wc+Is1d55hebm33IFn
	vc6qI0vZMgRzT0n+nMq+surcSXPfaOfD33/U+2uxmsm++tTiO2lK2UKJJefU9l19OWdTvAM/
	i+qJzGsz3nhd2STklefh1sL/tXleS8Y7sbxtEeWzUzXspFxytnSZZFzo/NDz2GPNStFk36Sf
	ItZHve0iFeelmLE+vXPwuFQoX9mWX+//Ge1bb1pSEn5mB0Od49KH80+X+nSLTDMLr9jY/YCp
	sKFk+9PV4Z0hS7SnzBBsfOIfsKLIT4mlOCPRUIu5qDgRAAH8NPMyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG6WR0GawZRpzBar7/azWaxcfZTJ
	YtKha4wWl3fNYbOYv+wpu8W61+9ZLKa1Mzmwe3xu/cHqcf7eRhaPy2dLPTat6mTz2Lyk3mP3
	zQY2j8+b5ALYo7hsUlJzMstSi/TtErgy/h04wlTQxVyx8+AXxgbGQ0xdjJwcEgImEtcXHWHu
	YuTiEBLYzSjxbl87M0RCXKL52g92CFtYYuW/5+wQRa8ZJZ79usjWxcjBwStgJ/H9JQ+IySKg
	KjHlVS5IOa+AoMTJmU9YQGxRgWSJl38mgo0RFoiTuNFwkhXEZgYaf+vJfLAbRAQyJZY0HGeE
	iDtIXLjazQaxqo9RYsrb04wg89kENCUuTC4FqeEUsJZ4tu4GE0S9mUTX1i6oXnmJ7W/nME9g
	FJqF5IxZSNbNQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwRGkpbmD
	cfuqD3qHGJk4GA8xSnAwK4nwOk3LSxPiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2x
	JDU7NbUgtQgmy8TBKdXAlLXuhY9lh9zLTzuKKr/sD35+fIr9PB9dQ9l5kv0WHVeXr9C/vH7P
	Xc9Qz6TVJQJq27USO4NumG85dHmhyt1dXwoeejOt+XLlwtmJrjLHt6gEdG+1v8ux9t1pY1tW
	1sLrfm9NXjuUT6y75vbOyezz7qZ4hc1hz8Xa9A5yifU3OP6MuFbIYuL314T7sY6XRZX9nMAL
	SenKs3a9eDJTqz9XzdGiU7C9SkbY7tGPl5kywtaLCioXGt88ILTm5cYteqvVojOXXFE/1bKj
	qln0SLeCvO7OSWqX14cv/aD0g72fV+2n/FHppbvfX6mzsbiiEd0bPfEwb8aHPA/u7ztWHeLa
	aPbgUNndyIZvX97+0UroUmIpzkg01GIuKk4EAC9+8MgPAwAA
X-CMS-MailID: 20240617143002epcas5p452f4bfa436d4c58418fe7a073823f355
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240617131354epcas5p189a78f2cedf7f3a3552df5e881e547c4
References: <CGME20240617131354epcas5p189a78f2cedf7f3a3552df5e881e547c4@epcas5p1.samsung.com>
	<20240617131144.48955-1-yuboyang@dapustor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_073013_787137_F2D34958 
X-CRM114-Status: UNSURE (   8.63  )
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

On 6/17/2024 6:41 PM, Boyang Yu wrote:
> The value of NVME_NS_DEAC is 3,
> which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS.
> 
> Signed-off-by: Boyang Yu<yuboyang@dapustor.com>

Maybe this requires fixes tag [*].
Looks good regardless.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

[*] 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes 
command")



