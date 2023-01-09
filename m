Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A773DC5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uIZAuXJynrIa+NWRwrz5X++63oGXSArX7NDzF1O4Bwo=; b=ZL2A0XLxU7T7ainAf3SuSPhqfR
	6LwYXqou/v85paRXZiOD6foTEFItyVU1fRhytgo+43LusHmzl5uZjNGIpI208ZKP5XJ0Fm/lelToX
	3xptiu0O8VkR/KrxvmgmNqyvIEdVxZrRaCklV8NolnDAVRW8kr9coQVZbqKL9H6vJmYg4nsHN39Pc
	sz/dcZ4Rb1OrJk+XkCfQEoJehaR9Hpj0t/mL+akkBOuZXE64HguEp6WoDut23CVQ6roELoeLFnS6e
	d0pz/zaA6fhclH5K1vhJvqc77RkDIBPVXWb347usA+GhBrO41yOcMrBbuPhyDAxgY4hl4R5Ua8lNj
	v4Vd/ZHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEpf2-000tIT-4m; Mon, 09 Jan 2023 10:45:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEpew-000tGP-P9
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 10:45:46 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230109104535epoutp0483723800a5d2fbe6dd44dac84b2fa19c~4niMyLoGd1329713297epoutp04i
	for <linux-nvme@lists.infradead.org>; Mon,  9 Jan 2023 10:45:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230109104535epoutp0483723800a5d2fbe6dd44dac84b2fa19c~4niMyLoGd1329713297epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673261135;
	bh=uIZAuXJynrIa+NWRwrz5X++63oGXSArX7NDzF1O4Bwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=erHitgQQZrVJOPOpAiYA656rq8v9p+vVqJi38furRhxYw6Zjmu2vxVQM7B/kiil65
	 VNUV7haulh6p/pBBnyQ4dDmLZT7Gf3nboNEZ1qoe2+pgoOxxMSe5l2gzIqSxn96gpa
	 VR4lYDU6C76lxaMUY8kdMK0QAC8qDI6dbUDsRv9c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230109104535epcas5p1dfb5efc733bf94eeef1a24782ff0ff48~4niMiFZA22002620026epcas5p1M;
	Mon,  9 Jan 2023 10:45:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Nr9Zk4cjsz4x9Px; Mon,  9 Jan
	2023 10:45:34 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.5B.03362.E40FBB36; Mon,  9 Jan 2023 19:45:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230109104534epcas5p416a4ce73df72f999cfb0c956b4f19b19~4niLn3mdE2453524535epcas5p4T;
	Mon,  9 Jan 2023 10:45:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230109104534epsmtrp28977efd56060ce9f24c73f922a2322de~4niLnSG5L2547725477epsmtrp2q;
	Mon,  9 Jan 2023 10:45:34 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-04-63bbf04e35e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.47.02211.E40FBB36; Mon,  9 Jan 2023 19:45:34 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230109104533epsmtip2a8f05befdf223022fc9a0f930aba88ae~4niKoziQy0218502185epsmtip2e;
	Mon,  9 Jan 2023 10:45:33 +0000 (GMT)
Date: Mon, 9 Jan 2023 16:15:12 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: don't allow unprivileged passthrough on partitions
Message-ID: <20230109104512.GA9723@green5>
MIME-Version: 1.0
In-Reply-To: <20230108165033.380842-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTS9fvw+5kg9d9ChYrVx9lsph06Bqj
	xdOrs5gs5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwevc3v2AJYo7JtMlITU1KL
	FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
	lfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM3727mErWMNS
	cbJpEWMD4xvmLkZODgkBE4nf944D2VwcQgK7GSVWvZzCBOF8YpRYOvUXI0iVkMA3RonJlw27
	GDnAOtrWmEOE9zJK9C/igKh/wijR/nITO0iCRUBF4vXN/4wg9WwCmhIXJpeChEUElCSevjrL
	CFLPLNDDKHGufSUrSEJYwF5iTdt5MJtXQEtizu9jzBC2oMTJmU9YQGxOAUOJRdPmM4HYogLK
	Ege2HQc7VELgI7vEva+XmSCOc5F40soO8ZmwxKvjW6BsKYnP7/ayQdjJEpdmnmOCsEskHu85
	CGXbS7Se6gfbyyyQIfG08S87hM0n0fv7CdR4XomONiGIckWJe5OeskLY4hIPZyyBsj0k9v3+
	xwYJkxZGiZmr+tgmMMrNQvLOLCQrIGwric4PTayzgFYwC0hLLP/HAWFqSqzfpb+AkXUVo2Rq
	QXFuemqxaYFxXmo5PIaT83M3MYITo5b3DsZHDz7oHWJk4mA8xCjBwawkwlu6aVeyEG9KYmVV
	alF+fFFpTmrxIUZTYPRMZJYSTc4Hpua8knhDE0sDEzMzMxNLYzNDJXHe1K3zk4UE0hNLUrNT
	UwtSi2D6mDg4pRqYVrF03E4KmtRzLrjyx+fb5oX+T78b9XNzCvz9L6ihVvdpmV2c1T/fK9Oe
	X1F4xL707pPpHyf49V/p72X++oPJs21Ds46eWp/w3KtsPP94WFLrTAzWXu//vXMiw6bXpRsS
	psvX/j/k9LTqsWio7q8PNecvsvY5Fi3nO/pJa2nUiT2XdnwK0DgU+PrE5qNZ26XEtv1bahp/
	WkjvQ+qi3u15AQxFU93tHbgan3XP6rnUuv3SQQ3Wa3ymLXIc9iujWj+0q0Q/X8Xld/fnsb9s
	n201a3lOBp6997WPUWdB92SZzlXZUUnWvuelWLotltY4/Z3Ac7PnotfWzI2HOfPUFjnI3rx1
	yKNHp+U079urqlHWSizFGYmGWsxFxYkAimDlQRUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvK7fh93JBtcW8lmsXH2UyWLSoWuM
	Fk+vzmKymL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DKWHFpK1PBPcaKU69OsDUw7mDsYuTgkBAwkWhbY97FyMUhJLCbUWLps6XsXYycQHFx
	ieZrP6BsYYmV/56zQxQ9YpTY8XwDI0iCRUBF4vXN/2CD2AQ0JS5MLgUJiwgoSTx9dZYRpJ5Z
	oIdR4lz7SlaQhLCAvcSatvNgNq+AlsSc38eYIYa2MEps3/CSGSIhKHFy5hMWEJtZwExi3uaH
	zCALmAWkJZb/4wAJcwoYSiyaNp8JxBYVUJY4sO040wRGwVlIumch6Z6F0L2AkXkVo2RqQXFu
	em6xYYFhXmq5XnFibnFpXrpecn7uJkZwuGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrylm3YlC/Gm
	JFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBUcNii8281e6m4
	8x/XF+5zt++q3NS7WJNrpl7+Z05rn7Sn1m2mW1zfnA2e2rDWVljnCd/aCRYJAQ/XXY3f1L+m
	rilbRyPe76vq2vbme1qNMVNm2mqvf1915fzk3TdbIue8zI95xt7B49Hv4iJdwF2rLiIjvynY
	/uTcg0aSNu9+MLk+Yy88dyTM/YBRv+HcKWZHe4+t/nVHRLNyL9N5j5YVh3M45SSZTIwuuDcl
	qbB1CblcX3Ey62GGgPnD1Gt1l2S4/PQeqXOGn1uuFL8obMWdtWYzGO8vmqzxO+uBw2xNVx+1
	2Vuz0o2c2Ux7NBPfbtpe5+1xbtV3gf/fHDesfqZ/40SKKVemj0GK0wqvD0osxRmJhlrMRcWJ
	AEwVe3vmAgAA
X-CMS-MailID: 20230109104534epcas5p416a4ce73df72f999cfb0c956b4f19b19
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_9176c_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230108165424epcas5p2b6d079dfcc8b1a91692f19729cc45b9a
References: <CGME20230108165424epcas5p2b6d079dfcc8b1a91692f19729cc45b9a@epcas5p2.samsung.com>
	<20230108165033.380842-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_024544_021391_815093D1 
X-CRM114-Status: GOOD (  10.99  )
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

------r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_9176c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Sun, Jan 08, 2023 at 05:50:30PM +0100, Christoph Hellwig wrote:
>Hi all,
>
>this series fixes ensures that unprivileged passthrough can't be
>used on partitions.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_9176c_
Content-Type: text/plain; charset="utf-8"


------r7zkWJCji.Ym_y_k8RXupob0Z-0SuwAVE8dxRRT6SQvRmvau=_9176c_--

