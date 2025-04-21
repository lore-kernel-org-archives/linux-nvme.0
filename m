Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543D7C369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9M8knapvAhU+6QfKbaIXib+N0ZVMGdHnsGWUU+mG8kM=; b=y39XMESs9vqovfodU+ZVZuzIAU
	zV0p3XVoNdt4KdNeLwgDSiEcrVxAPBKnQ2I/RGkrrImaQWT2nfoBuv0Ujp7CzA+1uW7a9c3cYp8sd
	ObgU7yZrDVY/SkT1TzUM5oR9Xz6hIOX47dZ35GS9yOnOWJoSccmPihFss6a0iE0hni08RViy+R4kY
	EhY6m5m4425dDT2kawD1SCYKN91maTxDfYRAxE76JE9G69RM4HYAwdTXylTHgUQmEWVbcj2rsvckO
	JSA6hsehxtOFIZicDiCdrtTxJCyYI52WXPTy4NPqrsYYs3I05rVQ2OTA21iPWKfllntxS+8vjShxv
	rmuByhew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lI9-00000003kvU-25f7;
	Mon, 21 Apr 2025 07:10:09 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lHl-00000003krd-1Zrn
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 07:09:48 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250421070939epoutp02f91b464577d7ab417f589f0cec68b445~4Q8depR-z2828828288epoutp02F
	for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 07:09:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250421070939epoutp02f91b464577d7ab417f589f0cec68b445~4Q8depR-z2828828288epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745219379;
	bh=9M8knapvAhU+6QfKbaIXib+N0ZVMGdHnsGWUU+mG8kM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gPcj5Q5ao9gEmezDUAMs86BP5eCKM4pKQ+05rKp3nxEyIgzmrE9MDvlD+StabwUQ6
	 Khh5VO1ejwHqBNkt+l+zm5LsXrCx5ldQV2aGooy1hXckiLb1PR9Zc0mX0kycW699oc
	 JmxCwnU49yFbFC40WHQNz7H733Tv/wTubEQqHBKU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250421070938epcas5p419e7717b2a9e817ec66425c6c26acbd9~4Q8dFc57P2581825818epcas5p41;
	Mon, 21 Apr 2025 07:09:38 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.175]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZgxM52hPvz3hhTQ; Mon, 21 Apr
	2025 07:09:37 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250421070936epcas5p37a043a207dbd7e81baea9affc451a591~4Q8bXlsB92455624556epcas5p3o;
	Mon, 21 Apr 2025 07:09:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250421070936epsmtrp25fb82bc4d78fe7553186e3f93c76cb83~4Q8bW6BDN2454924549epsmtrp2s;
	Mon, 21 Apr 2025 07:09:36 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-58-6805ef30e1d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.BC.07818.03FE5086; Mon, 21 Apr 2025 16:09:36 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250421070935epsmtip2b5b59bebdfdc4b946d67d78a6e74f797~4Q8aRLvOr0499504995epsmtip2Q;
	Mon, 21 Apr 2025 07:09:35 +0000 (GMT)
Message-ID: <ba40abc8-8b41-4e2c-a700-04e8e424bcc3@samsung.com>
Date: Mon, 21 Apr 2025 12:39:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Caleb Sander Mateos <csander@purestorage.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250420164450.1144416-1-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvK7Be9YMg+lnjSxW3+1ns/i/cC6r
	xcrVR5ksJh26xmhxedccNov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	2x72snt83iQXwB7FZZOSmpNZllqkb5fAlbHrQ2rBY6aKdQ0f2RoYpzJ1MXJySAiYSCy/dJi9
	i5GLQ0hgN6PE8bUTGSES4hLN136wQ9jCEiv/PYcqes0o0dGzEayIV8BO4vruPSwgNouAqkT/
	qcfMEHFBiZMzn4DFRQXkJe7fmgE2SFjAReLD72+sIINEBLYxSuz+sBesgVnAQeLC1W42iA2T
	GCXW3//HCJEQl7j1ZD7QrRwcbAKaEhcml4KEOQXsJTZtOAZVYibRtbULypaX2P52DvMERqFZ
	SO6YhWTSLCQts5C0LGBkWcUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERxHWho7GN99
	a9I/xMjEwXiIUYKDWUmE1zyIOUOINyWxsiq1KD++qDQntfgQozQHi5I470rDiHQhgfTEktTs
	1NSC1CKYLBMHp1QDk0lG9ocdlVZLp18RFQjYlbv93JG6nVymUyMcuXZZH/t410o3dmHt41tv
	86fz/Yld51YU/El+x6xjx7dkdjCw9zw/VTN7dZT5mtL8u4dWyoom3nY5KXL/hMTcyqfrGm0+
	COofKmVmfW/FdSNCSPDYhIapJdqXkt1mXt1VM3m+mln+k8bodOcrBbtOR9y+ctq6orpQjaXw
	/8c31WLzXt+0dVA7Klq5Sj9ZsMylq+bbLoeX1xfOv9X0W9LRInSfYEnkpNwqhZWWBzS2Pbso
	HXRCcuKBaxu/pDjKSfZe89r1sn33QdlulYduUqEbZM/L7FXgnmEl9EroSHXd/Cgfc+53LGzc
	Oxcdv68jm8Ikah5dqMRSnJFoqMVcVJwIAIqnuJISAwAA
X-CMS-MailID: 20250421070936epcas5p37a043a207dbd7e81baea9affc451a591
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250420164653epcas5p10dba2c638655fd4b16c6553d5125a3a0
References: <CGME20250420164653epcas5p10dba2c638655fd4b16c6553d5125a3a0@epcas5p1.samsung.com>
	<20250420164450.1144416-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_000946_082440_9B536ED2 
X-CRM114-Status: GOOD (  10.34  )
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

On 4/20/2025 10:14 PM, Caleb Sander Mateos wrote:
>   static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   			  unsigned int hctx_idx)

Missing this handling for admin queue.

We may go to that case (i.e., admin command with data payload > 1 
segment) less often. But when we do, this code will give 
null-pointer-deference.



