Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93B6D1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 04:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QqvGmzDC6bpJgw+AsNy2pW5tXTHvz7tugrCFE7J3etE=; b=kqsM6pWCErX9tzonSJQeKoLT3e
	F+SLYTbrub32mlCN5hal0vR/jXKgJ6diiNyzjtHbQLUjM0VipU/4u6USkKa7T1baCXxTr8YJmIlF4
	v1HCEavCpvyFB4oyhHGlNcF/8H7v8FVB5sPWoQKYwJ7n7AnRV0dQ5LC9t2DOGOa4C0skDKSRCjzC1
	ZKLB9PPPqscPHs87Oj3Yix3Fy+fgPquq7U/sbgPvK4O2rSCxqu0uRqPJJIGWqIMcUietS0Duz1g1q
	vbf5s74+U1Ih/XcIz+8s6hL0nZpenkxlopavaXyJH2DqhVmBA3y/ha0f81gqggUefIV6RXM16STi2
	sb1KvIrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8XbV-00000001liw-2H8h;
	Wed, 06 Nov 2024 04:25:13 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8XbQ-00000001liQ-3YAO
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 04:25:11 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241106042459epoutp02fa2e7c27e0f10aa5220e197ddd991214~FRnTGk7hT0373803738epoutp022
	for <linux-nvme@lists.infradead.org>; Wed,  6 Nov 2024 04:24:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241106042459epoutp02fa2e7c27e0f10aa5220e197ddd991214~FRnTGk7hT0373803738epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730867099;
	bh=QqvGmzDC6bpJgw+AsNy2pW5tXTHvz7tugrCFE7J3etE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Lkduqapq0oSmWMMlkCSyqLaICyHWsK0KKVBN7XJTdE+A9Yz0VleMvn8250xs16R1D
	 mdScKXRBlN7BFu7YvOMhVFfF13LJxaIXxt6OPmOe1ptuLt7qPnU6TBooQUJddB3V96
	 AeHHhsWlvAlmV0AgFz4MbU+0argKN+gwb1f47Ncs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241106042458epcas5p28656d007144864f9ff24cd407165fdeb~FRnSp4fJb2786727867epcas5p2w;
	Wed,  6 Nov 2024 04:24:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XjsYk00rwz4x9Q7; Wed,  6 Nov
	2024 04:24:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.3E.09420.99FEA276; Wed,  6 Nov 2024 13:24:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241106042457epcas5p2b1c166723b976bf55cf56869fdf9c6e0~FRnRo6RHe3230732307epcas5p2T;
	Wed,  6 Nov 2024 04:24:57 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241106042457epsmtrp1dd14be06fb0480a65f891351e6f45500~FRnRoS-W-2751227512epsmtrp1o;
	Wed,  6 Nov 2024 04:24:57 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-3c-672aef99a369
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.9F.07371.99FEA276; Wed,  6 Nov 2024 13:24:57 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241106042456epsmtip28a07e735675d12c81774ade9dabfef01~FRnQmdpcf2422124221epsmtip2J;
	Wed,  6 Nov 2024 04:24:56 +0000 (GMT)
Message-ID: <b6e3aacd-c171-498e-bdcc-c5ada0777017@samsung.com>
Date: Wed, 6 Nov 2024 09:54:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 03/11] nvmet: implement supported log pages
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, m@bjorling.me, matias.bjorling@wdc.com, Keith Busch
	<kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241105174904.3612888-4-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmlu7M91rpBje/mFisXH2UyWLSoWuM
	FmeuLmSxmL/sKbvF898xFhPavjI7sHl0HOtm9Ni0qpPNY/OSeo/dNxvYPM5drPBoP9DNFMAW
	lW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SEkkJZ
	Yk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7
	48aRKewFlxkrDu2fytjAuI6xi5GTQ0LAROLI0VPMXYxcHEICuxkllvWfYYRwPjFKbNk9iR3C
	+cYoMf/sLLiW/st3mSASexkl7m77CuW8ZZR4fPAlC0gVr4CdxKzzd8BsFgEViSVr1rJBxAUl
	Ts58AhYXFZCXuH9rBjuILSzgKHHi8Q0wWwTI/vtiHhOIzSwQKdF2/D6ULS5x68l8IJuDg01A
	U+LC5FKQMKeAucT6Hy+gSuQltr+dA/aPhEArh8TstjVQV7tILP81hQXCFpZ4dXwLO4QtJfGy
	vw3KzpZ48OgBVE2NxI7NfawQtr1Ew58brCB7mYH2rt+lD7GLT6L39xOwcyQEeCU62oQgqhUl
	7k16CtUpLvFwxhIo20NixvQ50KDezihx8d0rlgmMCrOQQmUWki9nIXlnFsLmBYwsqxglUwuK
	c9NTi00LDPNSy+ERnpyfu4kRnEa1PHcw3n3wQe8QIxMH4yFGCQ5mJRHeeanq6UK8KYmVValF
	+fFFpTmpxYcYTYHRM5FZSjQ5H5jI80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0t
	SC2C6WPi4JRqYJrxZsXDP3qXrqr++69Wlbdt6twbPXPUEhhcN8yc+ODZmWcMRwLm/tm4Qnvz
	x9T/OV+PV8lM+2NvNO/UigUKT08HtD6dXqbT3pywteRVcKzzy1PrXUuOhiewL9aXSTQ7trvP
	8w0rX7nyfpn5nrYrruy4/Dzwv4hEWpLeWfO8n48/eoYt0dkUurnSNSlnzXRboeX56wuc1AXS
	hebfYW1mvbLVIziGI/GW5vNZd6/KVa3R0Ty+cunxWt71pl4rvyjKFohebz1gPdOP61/CmfVa
	9xVf8aaFb8oVT+kUTT9y5H+XwuHiyXYLkiTNXklYzt1pNv+c4ioLzeyP4k+Nt52/dnj+gZaN
	f0p2PI8sy1eTzYxRYinOSDTUYi4qTgQAiDTORCwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7M91rpBmevyFqsXH2UyWLSoWuM
	FmeuLmSxmL/sKbvF898xFhPavjI7sHl0HOtm9Ni0qpPNY/OSeo/dNxvYPM5drPBoP9DNFMAW
	xWWTkpqTWZZapG+XwJVx48gU9oLLjBWH9k9lbGBcx9jFyMkhIWAi0X/5LlMXIxeHkMBuRokp
	70+yQSTEJZqv/WCHsIUlVv57zg5R9JpRYu7MZawgCV4BO4lZ5++wgNgsAioSS9asZYOIC0qc
	nPkELC4qIC9x/9YMsEHCAo4SJx7fALNFgOy/L+YBbebgYBaIlLi3yAVi/nZGiW2NX8BqmIGO
	uPVkPlgNm4CmxIXJpSBhTgFzifU/XjBBlJhJdG3tYoSw5SW2v53DPIFRaBaSK2YhmTQLScss
	JC0LGFlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIER4yWxg7Ge/P/6R1iZOJgPMQo
	wcGsJMI7L1U9XYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5O
	qQYm+YAvZ3TSX0X3xhXNPnm2/+DpFewrnnsd+MG05/SCCRYirswvTYqk1s/kNaipZVOON9j/
	zzJltrvfxAX7z3P7TY/1dJl99+MpRUlXDvc3ghvOVX2/sKLUn3c929J/byuOFzzJvWi4/qpm
	x4Xd7BpL7zfef7jwxcrt32JPSCzwWxOhaip6prY3/6qY2smQXyab7p9y6dN7Kxv4yunGZCnW
	VZ+qT57MWnvuine9r1Xad9Z3O95cYapa3ay1RXVF50zj909kBMKebmS4Ueaj6/b40JzABdWl
	6RV35fM0/83J3c7/80MK11rvy69aIw5x7/WUVqziY1VWS+11y+wwtposI6ySybA1+vSzdKvO
	3hsvlViKMxINtZiLihMBmfQjsQcDAAA=
X-CMS-MailID: 20241106042457epcas5p2b1c166723b976bf55cf56869fdf9c6e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241105175036epcas5p2993cc9dc615a7f750e7fbec97080b673
References: <20241105174904.3612888-1-kbusch@meta.com>
	<CGME20241105175036epcas5p2993cc9dc615a7f750e7fbec97080b673@epcas5p2.samsung.com>
	<20241105174904.3612888-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_202509_407429_82DAAA61 
X-CRM114-Status: UNSURE (   9.05  )
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

On 11/5/2024 11:18 PM, Keith Busch wrote:
> +	status = nvmet_copy_to_sgl(req, 0, logs, 1024);
> +	kfree(logs);
> +out:
> +	nvmet_req_complete(req, 0);

Shouldn't this be: nvmet_req_complete(req, status)?

