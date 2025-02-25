Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C89C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9Tg9dEYZ7udPxMEHX0kWt4cgTnXDyYwcn1NW9HJ9eU=; b=N2hZp90GLv4QarfTJKi8obOTFO
	r74ybXulwL2wgbJ+E8AW/KK5Fjv6b6UFYZbL93NkxacoFhRI6ZG62rXtupQvqP1oQauc5DgTXIQG8
	LY4oTpuNb4v4jNYkmZrsx5kRHMwa8WRh0h8roaGrtBb08XYbP8FyVO+l7/GgFXWtiMOnY25wVOKPN
	FSPCltz3Lt2yiT5aclrDPuAQhDqRmHNx3cKzh/bFmrHyo5YI7hi5ywRszwiLWTLnd8uL/Mv13Xouj
	kPzlsTwMfPeTbiaEHrqrOX7+RvD/KZzSOLTFJZbQBtHFhWe7K7sYkxLZAHsnJX5wKeqhzDNKGl+RR
	e1eZBo2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrgh-0000000GiB4-2BUI;
	Tue, 25 Feb 2025 09:57:15 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrJX-0000000GbSJ-1Emb
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 09:33:21 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250225093314epoutp02cab077cb62a0e85499ec37124828ee74~nabH414LN2140721407epoutp02Z
	for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 09:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250225093314epoutp02cab077cb62a0e85499ec37124828ee74~nabH414LN2140721407epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740475994;
	bh=u9Tg9dEYZ7udPxMEHX0kWt4cgTnXDyYwcn1NW9HJ9eU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FlbrqvVwBAsl/QmPFkm+teSbc540St8uclzrQrprVoO3/vxV++HeQg7N/W5/+8rcR
	 oS3ZZK3yycOFbAksY7ZpQuY8vhTCpxQwDasYHrYrSCb0W0Obv4JH6g/cGbljdR8KWa
	 Ncm+1jqdtgyVsHKDE1fs3V2q5ZUJUoQvTHr0iX28=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250225093313epcas5p1bc76f06b6383ebba24fcadfbd20c18cd~nabHfdDBU3042430424epcas5p1V;
	Tue, 25 Feb 2025 09:33:13 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z2C882kx6z4x9Pv; Tue, 25 Feb
	2025 09:33:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.2F.19710.85E8DB76; Tue, 25 Feb 2025 18:33:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250225093312epcas5p479591d2f85ff58caa378f811f04fcb85~nabF9H5Cy2994129941epcas5p4J;
	Tue, 25 Feb 2025 09:33:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225093312epsmtrp1290793248ddaf56e5310a0976ccfc731~nabF8avSO1979719797epsmtrp1M;
	Tue, 25 Feb 2025 09:33:12 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-63-67bd8e58334f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.51.18729.75E8DB76; Tue, 25 Feb 2025 18:33:11 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225093308epsmtip1a0c70fedc7d80e522b228deff82b03ff~nabCbkKJb0445504455epsmtip1r;
	Tue, 25 Feb 2025 09:33:07 +0000 (GMT)
Message-ID: <a6fa497e-30de-4ad3-a864-3736b9d86cce@samsung.com>
Date: Tue, 25 Feb 2025 15:03:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nvme-ioctl: combine alloc and map
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250224182128.2042061-6-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTXTeib2+6QdMvYYuVq48yWUw6dI3R
	4szVhSwW85c9ZbdY9/o9iwOrx/l7G1k8Nq3qZPPYvKTeY/fNBjaPcxcrAlijsm0yUhNTUosU
	UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
	9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzlvxbwFTwhbVi
	/bzjjA2Mv1i6GDk5JARMJFZ//8IMYgsJ7GaUuDBTCML+xChxd4dcFyMXkP2NUeLRqWY2uIY7
	bWwQib2MEn86fzFCOG8ZJc59WAY2llfATmLtp05GEJtFQFVi6/5XrBBxQYmTM5+A1YgKyEvc
	vzWDHcQWFrCSeHniDVi9iECixNkTm8G2MQsoS3T2fGSHsMUlbj2Zz9TFyMHBJqApcWFyKUiY
	U8BcouHvJ6gSeYntb+cwg9wjIfCVXeLYvn/MIPUSAi4Sb8/aQjwgLPHq+BZ2CFtK4mV/G5Sd
	LfHg0QNoqNRI7Njcxwph20s0/LnBCjKGGWjt+l36EKv4JHp/P2GCmM4r0dEmBFGtKHFv0lOo
	TnGJhzOWQNkeEm3v9zJDQmo7o8TLa7tZJzAqzEIKlFlInpyF5JtZCJsXMLKsYpRMLSjOTU9N
	Ni0wzEsth8d2cn7uJkZwutRy2cF4Y/4/vUOMTByMhxglOJiVRHg5M/ekC/GmJFZWpRblxxeV
	5qQWH2I0BcbORGYp0eR8YMLOK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5YkpqdmlqQWgTT
	x8TBKdXAlPNBbD3DvT+Tv6z9VPJN/G+3QQKf8oQJc+w4nOM1LhQlJJXUf9brvM6+XvxpwUlF
	mTmbrQNjQ2evSt955W7jFN5Z77Peeqi/K2MtdGSod9g/nbfvKHsoZ+4cjtATLYev6/YukhJe
	eJwr/et3Zn8bte/t/pXrp/rd0wja8+9OeKZLcOhd/kcqle6znu0UWarO/LL40e8jzr91uaRu
	ulUu2rIsUkVa9aDxxtZQTtuldZN/tX8y3Bq3eX/ErFU5z/LYitImC5+fVvZv5eeOR0J7PFPq
	fyibTBNaVyHb3MSXrKPTc/srwyOTg9ONHPhYsj3Xl+iUaDowXl5SxXC+v4v9fl9T3m7nY2bl
	LHdWvrNRYinOSDTUYi4qTgQACv9hyiAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnG543950g0dPLSxWrj7KZDHp0DVG
	izNXF7JYzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8zl2sCGCN4rJJSc3JLEst
	0rdL4MpY8m8BU8EX1or1844zNjD+Yuli5OSQEDCRWH2njQ3EFhLYzSix/lMNRFxcovnaD3YI
	W1hi5b/nQDYXUM1rRomO1QfAmnkF7CTWfupkBLFZBFQltu5/xQoRF5Q4OfMJWI2ogLzE/Vsz
	wAYJC1hJvDzxBqxeRCBR4u7qz2A2s4CyRGfPR6gF2xklpv1qh0qIS9x6Mp+pi5GDg01AU+LC
	5FKQMKeAuUTD30/sECVmEl1bu6DK5SW2v53DPIFRaBaSM2YhmTQLScssJC0LGFlWMUqmFhTn
	pucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4eW5g7G7as+6B1iZOJgPMQowcGsJMLLmbknXYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVANT/MRTfD8qU3Or
	2/8fDnP8XzNnwmKBV09Mv5eH558y9LKPffvJ6ftdr6/cE11OB90NSZv97cZSfdmHi/RjTlz6
	Y7lZoorbqX6HUPhz3WMvlh7el/DE1rinXN361M5PXe++7c//6pA9s333093/FE7uUZ5cNDWX
	ac3MtTs4/7EYmW115tS+/utZ9bdFi/b+NG06H9uhxhS40fLD0RxZj6t95dyNUqquJxsEa2be
	vmvVLfrQtHke73w7n58OtwKfNDH9W+60/KtWbnHFtnbJszKNd5/0LJxdv2nhn5YmOytXIQWN
	TJ4tLu5OQft3PU+c6uvcrmufoGP13rK9zsYtonT/7AX9Lj6bTy6tZmXv4fJXYinOSDTUYi4q
	TgQAGRgP0f4CAAA=
X-CMS-MailID: 20250225093312epcas5p479591d2f85ff58caa378f811f04fcb85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250224183304epcas5p36969433068ebb71b4a631ced34beb001
References: <20250224182128.2042061-1-kbusch@meta.com>
	<CGME20250224183304epcas5p36969433068ebb71b4a631ced34beb001@epcas5p3.samsung.com>
	<20250224182128.2042061-6-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_013319_989350_F8590709 
X-CRM114-Status: GOOD (  10.60  )
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

On 2/24/2025 11:51 PM, Keith Busch wrote:
> +static struct request *nvme_alloc_user_request(struct request_queue *q,
> +		struct nvme_command *cmd, blk_opf_t rq_flags,
> +		blk_mq_req_flags_t blk_flags, unsigned timeout_ms, u64 ubuffer,
> +		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
> +		struct io_uring_cmd *ioucmd, unsigned int flags)

Back in 2022, nvme_alloc_user_request used to take 12 arguments.
For fixed-buffer support, I added two more and got 'too many arguments' 
complaint [*]. So I did alloc/map split to trim arguments.

This patch, in itself, is going back to 2022.
But the last patch neutralizes 'too many arguments'.


[*] 
https://lore.kernel.org/linux-nvme/26490329-5b51-7334-1e2a-44edfe75d8fa@nvidia.com/

