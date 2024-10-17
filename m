Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE02BD374A7
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=beNXhEpyIZiANUEMn8nKE0CKhf73IiUdcbZMH4SS2Uo=; b=QySwEjQMIovmfm3BzTqeWn5BI7
	kwaWJL/g/eHJeCZIN4jxTHQuYMpB6Cfy9ISFGQwS5+u7698nZ8gE6m3tW6qh1TDwzesEmtyE5hnUS
	BBs1SYKxcyQaty2LqLnjiMgyRA/0bDdZa5wUI0rSd4Ovf2cTt7BA9FX+Y33p//sct7ZjKJZWbwGOY
	awc9JmBaGyDpQTfCzqij3zGRPAK9JKJi+r9MIMDVfPp+08P7Tel+RDIbJye+3v76Xq5YwC8K5jSzz
	LVq7KHoEYcNht2NdzjI7kA1pk6vXqV7ykPnjDfOKiNAC+8KSYjNyDXOFC4q2u5M5taUTn5F0Qil/u
	1IzTdKIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RxI-0000000FC8g-0fZ7;
	Thu, 17 Oct 2024 14:58:24 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RxB-0000000FC6e-3HV7
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 14:58:21 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241017145812epoutp022f5709712460d06a4dacf9f244c01c58~-RWeKmZGE2577025770epoutp02R
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 14:58:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241017145812epoutp022f5709712460d06a4dacf9f244c01c58~-RWeKmZGE2577025770epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729177092;
	bh=beNXhEpyIZiANUEMn8nKE0CKhf73IiUdcbZMH4SS2Uo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=B2KFjIPokb/S5B9ki6uHhKk0nSmXfTmZDh0QND4TCrBlrrXlaqjAUm9yNjSuMdIS2
	 Gaeea8McR5VkPw9R45FVt4cbtPXWUs0/0WEqTVWE8e9hCdMT6WXVnFuLh8IE34Guui
	 Xhnzi2/5s+Y6qOJiiMhFy9k2RdZ3cnBpA8K86sjU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241017145811epcas5p449928f627dab5e2dbc1587250e38a55a~-RWcy9jqn2380023800epcas5p42;
	Thu, 17 Oct 2024 14:58:11 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XTrYY4rVLz4x9Pr; Thu, 17 Oct
	2024 14:58:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.C0.08574.10621176; Thu, 17 Oct 2024 23:58:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241017145808epcas5p2ed611f7ce0724b306904e79bc981da83~-RWZ7sUJr3187231872epcas5p2C;
	Thu, 17 Oct 2024 14:58:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241017145808epsmtrp1b2fc9c367fc982742bf34259080b48d8~-RWZ6iYgj2252222522epsmtrp1U;
	Thu, 17 Oct 2024 14:58:08 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-6f-67112601daf1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.2B.07371.00621176; Thu, 17 Oct 2024 23:58:08 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241017145805epsmtip2fafc1d1b5863a340ef8cd62961b3ef28~-RWW2D4Yo1155711557epsmtip2n;
	Thu, 17 Oct 2024 14:58:04 +0000 (GMT)
Message-ID: <2fa479d8-c51c-42a0-afc7-a18fe73b93a9@samsung.com>
Date: Thu, 17 Oct 2024 20:28:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] io_uring: enable per-io hinting capability
To: Pavel Begunkov <asml.silence@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <48c70b95-f0c9-44bc-8a3b-3010e8d682be@gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTZRzHffb97gfC8Msc8cSlrh2QoMCm23xQIb2QvknncUbXnXXRV/g6
	uI1t7QdKUqGACKjAQpBhQh5CgAcxkEBY2cAjEsQ70AMUhBodQfwIywoI2xgW/70+z/N+P+/n
	83nu4WC8IrY3J0Glp7UqSilkrceb2v23BgI/D7no4U0fdLm6CaCa4VwWyl5uxNFU+zxAhXN/
	Y2jm9CKOBm+1MFDbVSMDVdXcZqCZjLs4KilKYyBbnQlDPz16wkZG6wOACgpPA2QZ2obaLF04
	Kq0YZ6PKzmUGalosxVDt1CyOev/pZKJe02X2Pi+yrz+SbDENs8nekXqc7OsxkObqLBZpnjey
	yYbyT8nWwVQW+dv4EE7OfnOfRV5orAZkd1mHffPOSfKJeTNptk0zojYcUeyNp6k4WiugVbHq
	uASVPFQY+VbMazFSmUgcKA5Bu4QCFZVIhwrD34wKjEhQ2mcgFCRRSoN9KYrS6YTBYXu1aoOe
	FsSrdfpQIa2JU2okmiAdlagzqORBKlq/WywS7ZDahR8o4jOqOpmacxtOXPuuAEsFRrds4MKB
	hAR2zbYwHMwjWgF8Zj6YDdbbeR7AvOlSlnPjKYATP+x5bjD+eZvlFFkAHL5xne0spgEsr0y3
	H8XhcIkweNf2jsOAE76wYawFdzCX8IBdxbYV9iS2wMdDl9gO3khEQOv4V0zHOXyikgHni9pW
	EjDiGYAXq6qZDhVGeMEhW+lKAIvwh/c+MziWXYhQONhXtirZAtNulGAOLyTaXaAlx1E4rh0O
	rxebWE7eCCc7G9lO9oa/5J5ZZQUc/XEUd3IKbG64wHTyqzB1aYDpyMXsuXU3g51Z7vD8om3l
	OpDgwrNneE71y3DEOL7q9IJjl8pXmYR5v4+uDm4GwPqpBWYeEJjWzMW0pkvTmnZM/yeXAbwa
	vEhrdIlyOlaqEavo4/+9d6w60QxWfkhAeDMYKF0OsgIGB1gB5GBCPteYzZXzuHFU8ke0Vh2j
	NShpnRVI7Q+Uj3l7xqrtX0yljxFLQkQSmUwmCdkpEwu9uFMZn8fxCDmlpxU0raG1z30Mjot3
	KqNNZJyjfMq3S3KZ6+Tygv0Ko+DijhHdZkHmds6AX/jhfUHWPyxFH+5CWSfJqpwh8tQDv8OT
	kmSZTx3ZWM+0ZNS/4dne4a081/me6PGV4zW5HZB/4FFrZrTrvfzgVw5wXY98fCXlxNNMJVgK
	fNf9+76H8wL/Y0ejkwd7Dn4Z8Lr0paWm4EO1txa6u+8o/fhJhgo83WNC2c93d3Et9MkcbsqP
	oCZS2EmqeE6k719HS2q/2PrttU8a08TbklDJ7k1j71dcrUwvTsnK5L1dlJWx8wUpD2PzPXO9
	JjcN7MFmLNFRqkM5C8fu98+Fna3/uafZTex7ysdtHUdjTfZWfC05P/hrj7sQ18VT4gBMq6P+
	BQdbfPeqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCSvC6DmmC6wdtPfBZzVm1jtFh9t5/N
	ouvfFhaL14c/MVpM+/CT2eJd028Wi5sHdjJZ7Fk0icli5eqjTBbvWs+xWMye3sxk8WT9LGaL
	x3c+s1tMOnSN0WLKtCZGi723tC327D3JYjF/2VN2i+XH/zFZbPs9n9li3ev3LBbn/x5ntTg/
	aw67g7jH5SveHjtn3WX3OH9vI4vH5bOlHptWdbJ5bPo0id1j85J6j903G9g8Pj69xeLxft9V
	No++LasYPc4sOAKUPF3t8XmTnMemJ2+ZAvijuGxSUnMyy1KL9O0SuDJaVx5nLejhr1h6cApz
	A+Mkni5GTg4JAROJSd+PsoHYQgK7GSU2bwuBiItLNF/7wQ5hC0us/PccyOYCqnnNKLHo4g+m
	LkYODl4BO4lzT8JBalgEVCU2P9zJAmLzCghKnJz5BMwWFZCXuH9rBtgcYQE3iUNPN7CCzBER
	WM4k8fj0YTCHWeA/o0THsWVMEBveMUq8+LoVrJ0Z6IxbT+aDbWMT0JS4MLkUJMwpYCtx8/IC
	VogSM4murV2MELa8RPPW2cwTGIVmITlkFpJJs5C0zELSsoCRZRWjZGpBcW56brJhgWFearle
	cWJucWleul5yfu4mRnDC0NLYwXhv/j+9Q4xMHIyHGCU4mJVEeCd18aYL8aYkVlalFuXHF5Xm
	pBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwLTpobH39e6Nc02XZmqvMby2fmNn
	aOHNmEUh7uK2JV2sU7bYflH/K5RbLT9r87kzURzlCbMsZznecXt/n9lJbE/6ue8ZB9trdCdP
	579WpO2XOLFDxzJyZ1TS90+fQ1NXzft4/Fh2zC32i3e2KuzI4p+rfz9StGz9XsPTgiInumvP
	dTZ2+kruca5P/lapHPpRK8ynirXiRdvbkJMOP704Dc7q2QUJfOvRXeh06nrmLK9E0wBPpi3n
	nOSnfzgsktL7Tangf8O61WUzHC7OWjCpaMU0+UW+s6UCrVXL3pqcammRnPHtfuv7Za8vWefc
	+3r/fovmFk1d4/wHgSddT23m+Ve49W6MqFFWRHXeO/fuz0osxRmJhlrMRcWJAK3M3oqHAwAA
X-CMS-MailID: 20241017145808epcas5p2ed611f7ce0724b306904e79bc981da83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240930182103epcas5p4c9e91ca3cdf20e900b1425ae45fef81d
References: <20240930181305.17286-1-joshi.k@samsung.com>
	<CGME20240930182103epcas5p4c9e91ca3cdf20e900b1425ae45fef81d@epcas5p4.samsung.com>
	<20240930181305.17286-4-joshi.k@samsung.com>
	<48c70b95-f0c9-44bc-8a3b-3010e8d682be@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_075818_305066_A9374289 
X-CRM114-Status: GOOD (  17.46  )
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

On 10/2/2024 7:56 PM, Pavel Begunkov wrote:
> On 9/30/24 19:13, Kanchan Joshi wrote:
>> With F_SET_RW_HINT fcntl, user can set a hint on the file inode, and
>> all the subsequent writes on the file pass that hint value down.
>> This can be limiting for large files (and for block device) as all the
>> writes can be tagged with only one lifetime hint value.
>> Concurrent writes (with different hint values) are hard to manage.
>> Per-IO hinting solves that problem.
>>
>> Allow userspace to pass additional metadata in the SQE.
>> The type of passed metadata is expressed by a new field
>>
>>     __u16 meta_type;
> 
> The new layout looks nicer, but let me elaborate on the previous
> comment. I don't believe we should be restricting to only one
> attribute per IO. What if someone wants to pass a lifetime hint
> together with integrity information?

For that reason only I made meta_type to accept multiple bit values.
META_TYPE_LIFETIME_HINT and a new META_TYPE_INTEGRITY can coexist.
Overall 16 meta types can coexist.

> Instead, we might need something more extensible like an ability
> to pass a list / array of typed attributes / meta information / hints
> etc. An example from networking I gave last time was control messages,
> i.e. cmsg. In a basic oversimplified form the API from the user
> perspective could look like:
> 
> struct meta_attr {
>      u16 type;
>      u64 data;
> };
> 
> struct meta_attr attr[] = {{HINT, hint_value}, {INTEGRITY, ptr}};
> sqe->meta_attrs = attr;
> sqe->meta_nr = 2;


I did not feel like adding a pointer (and have copy_from_user cost) for 
integrity. Currently integrity uses space in second SQE which seems fine 
[*].
Down the line if meta-types increase and we are on verge of low SQE 
space, we can resort to add indirect reference.

[*] 
https://lore.kernel.org/linux-nvme/20241016112912.63542-8-anuj20.g@samsung.com/

