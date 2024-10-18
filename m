Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF28D2FFEE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a6GZtz02sRXMNYbtfu3vRBWPZjl0hOynSDjR+0HGGEs=; b=uKic3MPQcwiP87fY8bQ2PG3zpR
	4R8w5YmG6L6VU7WKb4AEjT/ps9YtO6i5550oAwESrteXoLbPaiycNLBAmq1Ip87Y5s2vPdZQHR+Hd
	b2r4+8b3JAnfPHqmj+ctkcXTbkotrdC27+IwASe4KhgXU/fBOqZ+ytgyuZAm2Oc9k7eMVYLINiQru
	tqOiHQd0Y3hJbOju969PGPryumPqtEvUVKtEj/CtivXLhJU5ouTWQNaq13rcaNIqrSBUcuNY5sMzu
	O/QiOuNyxvo7AB6QSG1gI2dSCVZtHPRoJGBtZMdZjRshJ/k7eIMl5qiM89aYfabT9seY62xRrHo4p
	lxCCsJ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1kYc-00000000QW9-1LyN;
	Fri, 18 Oct 2024 10:50:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1kWz-00000000Q1q-1mOj
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 10:48:31 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241018104822epoutp04cea74788fedebf817cbcbea99f31e251~-hlnRuYMP1930519305epoutp04Q
	for <linux-nvme@lists.infradead.org>; Fri, 18 Oct 2024 10:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241018104822epoutp04cea74788fedebf817cbcbea99f31e251~-hlnRuYMP1930519305epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729248502;
	bh=a6GZtz02sRXMNYbtfu3vRBWPZjl0hOynSDjR+0HGGEs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AQ1EnjKU06KoznaLLsOWeGfkz3zY/6bVElMQ21acRQvqQDm4v6bxlfuB+xN6ScJqo
	 CSpFbU6v2789yO1J+ONsA5wKAUP6aIyJ3B9Dv3WKcdaNGNf2CZdPfg7KtMWmBaIBdh
	 UyDjlDmgF24IfC9yDaAvskJiLzj1/XMDgkyArs1k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241018104821epcas5p2ca965e217820ebd922ffc32a546d261d~-hlm-9e4A0569605696epcas5p2S;
	Fri, 18 Oct 2024 10:48:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XVLys1yjzz4x9Pp; Fri, 18 Oct
	2024 10:48:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.3F.08574.5FC32176; Fri, 18 Oct 2024 19:48:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241018104820epcas5p44da029e96f7fc71ac491ad4e3cffd0e1~-hlmCrmUO1092410924epcas5p4x;
	Fri, 18 Oct 2024 10:48:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241018104820epsmtrp1387a5804edd25426b3b35c7f7b19370b~-hlmB9PnI0866408664epsmtrp1K;
	Fri, 18 Oct 2024 10:48:20 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-b7-67123cf50659
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BE.FC.18937.4FC32176; Fri, 18 Oct 2024 19:48:20 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241018104818epsmtip2c585eb3baf60bf763056efa92948d37a~-hlkMYvxl2276622766epsmtip2b;
	Fri, 18 Oct 2024 10:48:18 +0000 (GMT)
Message-ID: <77feb398-d6af-4f07-93bc-b12165604f04@samsung.com>
Date: Fri, 18 Oct 2024 16:18:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 6/6] nvme: enable FDP support
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, javier.gonz@samsung.com, Hui Qi
	<hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>, Hannes
	Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241017160937.2283225-7-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmhu5XG6F0g+43vBar7/azWexZNInJ
	YuXqo0wWO5etZbd413qOxeLxnc/sFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFtt/zmR14
	PC6fLfXYtKqTzWPzknqP3Tcb2DzOXazw6NuyitFj8+lqj8+b5AI4orJtMlITU1KLFFLzkvNT
	MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVVIoS8wpBQoFJBYXK+nb2RTl
	l5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZxyeMIupYCZjxdwPL1gb
	GCu7GDk5JARMJBb2zWbpYuTiEBLYzSix+OURJgjnE6PE6f/XWeGcbS/3scC0nNjwAiqxk1Hi
	5a6vzBDOW0aJG68+sHUxcnDwCthJXNkqBmKyCKhKTG5gB+nlFRCUODnzCdgcUQF5ifu3ZrCD
	lAgLGEtM6XEAmSIiMJNR4sS0CYwgDrPAUUaJC9v+M4E0MAuIS9x6Mp8JpIFNQFPiwuRSkDCn
	gLnE6pWr2CBK5CW2v50Ddo6EwA4OibN377JCHO0i0bdvGyOELSzx6vgWdghbSuJlfxuUnS3x
	4NEDqCdrJHZs7oPqtZdo+HODFWQvM9De9bv0IXbxSfT+fgJ2joQAr0RHmxBEtaLEvUlPoTrF
	JR7OWAJle0gcnX0cGmzbGSU+NW9nnsCoMAspWGYh+XIWkndmIWxewMiyilEytaA4Nz012bTA
	MC+1HB7dyfm5mxjByVjLZQfjjfn/9A4xMnEwHmKU4GBWEuFNqhdMF+JNSaysSi3Kjy8qzUkt
	PsRoCoyeicxSosn5wHyQVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMH
	p1QDk5DEgzZhTs9AQ/eyPf/4n3Wu0FjeuD2ayVb+VynDZKlZvfqXJXkfxvGuCVm99Z2ugK5r
	1PKFr0PE5vM97Vl8+3DjrxUTD9xS2LjjY3mn4/UDu31uVrNszpE+NkPmnu+xcBHLEJnZldXL
	y36c/HG3Msx47/vdNrF17bceCaatsZu0nEXdVEdno574l6o4za2pja/Wrrt191dL7ZuTWffl
	L7/O25LfeuyOf2jtq74PZU+fNp5YYbA1r2ExL0vupAOh814FnA52Lzd35CpqlGow+8Tv1dJy
	RIH98sm0g88CCnRUJvAdszrbIG5f8unE133M0sUbsq+rMDMti/zP97TAt3zx6jcVjPPZLi53
	6l7/TYmlOCPRUIu5qDgRAGLEF0FPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvO4XG6F0g8nLjC1W3+1ns9izaBKT
	xcrVR5ksdi5by27xrvUci8XjO5/ZLSYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLbb/nMzvw
	eFw+W+qxaVUnm8fmJfUeu282sHmcu1jh0bdlFaPH5tPVHp83yQVwRHHZpKTmZJalFunbJXBl
	HJ4wi6lgJmPF3A8vWBsYK7sYOTkkBEwkTmx4wdrFyMUhJLCdUWLZucfsEAlxieZrP6BsYYmV
	/56zQxS9ZpRYvOUPcxcjBwevgJ3Ela1iICaLgKrE5Aawcl4BQYmTM5+wgNiiAvIS92/NYAcp
	ERYwlpjS4wASFhGYySjx7aYfyERmgaOMEisOnGeDu2HVon9sIFXMQDfcejKfCaSZTUBT4sLk
	UpAwp4C5xOqVq6BKzCS6tnYxQtjyEtvfzmGewCg0C8kZs5BMmoWkZRaSlgWMLKsYRVMLinPT
	c5MLDPWKE3OLS/PS9ZLzczcxguNNK2gH47L1f/UOMTJxMB5ilOBgVhLhTaoXTBfiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgYs30WvDnpek0y9jVxgW2
	++vPFF/6e3+29rumrU1HlD0zV7w8ahA9TfG8180EtkB+fvl8z9USyxbrm8wTPJee5PWy8epi
	5lMNHcuuTV/ixXVSTn7Xo3Re33vX8rs32T//kmRYx7F2+tGzyxhjuCevtj+ut+ZW4rwNdtuM
	ne4HdlZ/X8mwoUuavzSk4l3Lebc3jf5ul6YdWqdgmW2c+KiAWURres+bbXKFly/vlnJkqzz0
	z4Sv0aDrndxcjrfXL9U2fLh8/qtZ1lxTr8we97Ibeulr2urTmDc8iHA9v7Cp66a33JJp4bNL
	2D9aJV6WWnM6ZL5tV+CCl626c1aEZ95h6vigUHGwas60Bat4ikvfKrEUZyQaajEXFScCAGWq
	BS4mAwAA
X-CMS-MailID: 20241018104820epcas5p44da029e96f7fc71ac491ad4e3cffd0e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241017161628epcas5p1006f392dc6c208634997f3a950ec8c67
References: <20241017160937.2283225-1-kbusch@meta.com>
	<CGME20241017161628epcas5p1006f392dc6c208634997f3a950ec8c67@epcas5p1.samsung.com>
	<20241017160937.2283225-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_034830_159094_70034AD8 
X-CRM114-Status: UNSURE (   8.30  )
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

On 10/17/2024 9:39 PM, Keith Busch wrote:
>   
> +#define NVME_MAX_PLIDS   (NVME_CTRL_PAGE_SIZE / sizeof(16))
> +

Seems you intended sizeof(u16).

