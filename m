Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5582FC25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqVTPW/OO5rrONOkrboS3rJTnWgAy8fH13741LE3I6E=; b=XGtiJoeqzPeM1hGiO2nbnPcYKe
	jCGJnc3yfe2jwM7fGyy2ptxSPpBd5LyztQdABkiBFvtJLX4rUwMLdLvP7tk7QNhsTnTpmhomk+o2x
	YADJwkXIG5q2O7VSPg7bV6t9YqCJptiNgL+pKHBFjd+Loj6tCWynGR5SLdswh9/p3osxdWd0egbOw
	H/+KxV3yL/lTlqYnVY/OYHfWEBla1RnDZwcF82Ff9giA2Y8YjT8+arL5FskunYFivdQfTGz6dwwzf
	JR6wrTE3YSI3PKd/k3Si65pruJ0knsp06Ij4PkdTcD7y+AXJRaZwfyoJCqChipQuPkXSL/2pjLpGK
	6wuy73mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwH4l-00FlXo-1O;
	Fri, 27 Oct 2023 07:16:11 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwH4h-00FlX1-22
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 07:16:09 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231027071602epoutp03cec659aebe959828a2f8e0f5a66f4dfc~R5ZUARZ1R1845618456epoutp03I
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 07:16:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231027071602epoutp03cec659aebe959828a2f8e0f5a66f4dfc~R5ZUARZ1R1845618456epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698390962;
	bh=vqVTPW/OO5rrONOkrboS3rJTnWgAy8fH13741LE3I6E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SeVimsm1c9OwuISWeQtqXNyO/VM1AijhfZrfl5PXioi4NBcQ8qVgLCuURCEWxyibD
	 oC58A261vSUMe4XRrh/uvx1X+M4p8o4zfVEHHH8djPIhGwQe3kL0wzbom2YmMg8PBM
	 NstuNKDiN8zVG9j+Kk+CSHAS543Rbl6YQ1K/xqFI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231027071602epcas5p1ea637752568ff6d28d6a30ca9e255eca~R5ZTs9bSn2831128311epcas5p1i;
	Fri, 27 Oct 2023 07:16:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SGv8c1rzdz4x9Pv; Fri, 27 Oct
	2023 07:16:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.E0.10009.0B36B356; Fri, 27 Oct 2023 16:16:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231027071559epcas5p4cc7eb2a38e21776dcdf548406dfd617c~R5ZRgdz-81556915569epcas5p44;
	Fri, 27 Oct 2023 07:15:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231027071559epsmtrp16e50b5fd7611d52be0a6cd0d45dbb0ec~R5ZRfva2L2266822668epsmtrp1c;
	Fri, 27 Oct 2023 07:15:59 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-12-653b63b080af
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.61.08817.FA36B356; Fri, 27 Oct 2023 16:15:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231027071557epsmtip27d41aa15185a4e5bfe468830782755a9~R5ZPiE3bs2848128481epsmtip2d;
	Fri, 27 Oct 2023 07:15:57 +0000 (GMT)
Message-ID: <2dd010c2-32b2-05fd-2f8a-80e759e94d6e@samsung.com>
Date: Fri, 27 Oct 2023 12:45:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "vincentfu@gmail.com"
	<vincentfu@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <aesib7wh6jkm6tsvonsuk73pmsgi3h6aikpzf52vbjbak3jspd@kbi4cm2uhsak>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhu6GZOtUg4MnuCxW3+1ns7h5YCeT
	xcrVR5ksJh26xmgxf9lTdot1r9+zWOyb5WmxYOMjRosNbYIOnB47Z91l9zh/byOLx+WzpR6b
	VnWyeWxeUu+x+2YDm0ffllWMHp83yXm0H+hmCuCMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
	NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpQSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
	lFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8fPXb5aC81wVW1/9YW1gfM3RxcjBISFg
	InH8kXcXIxeHkMBuRonX516ydzFyAjmfGCUWNihBJL4xSrzY858ZJAHS8KxlPjNEYi+jxKOG
	5VDOW0aJnx+OsoJU8QrYScz+spgNxGYRUJXYuOwcO0RcUOLkzCcsILaoQJLEr6tzGEFsYQFX
	iWezWsDizALiEreezGcCsUUETCWebNnCBLKAWeANk8SZf1NZQO5mE9CUuDC5FKSGU8BP4nnH
	cTaIXnmJ7W/ngB0kIbCFQ2LXhx1QZ7tIfJu5AcoWlnh1fAs7hC0l8bK/DcpOlrg08xwThF0i
	8XjPQSjbXqL1VD8zyF5moL3rd+lD7OKT6P39hAkSjLwSHW1CENWKEvcmPWWFsMUlHs5YAmV7
	SLQ3gbwLCquLjBJXOzuYJzAqzEIKlllI3p+F5J1ZCJsXMLKsYpRMLSjOTU8tNi0wyksth8d3
	cn7uJkZw8tXy2sH48MEHvUOMTByMhxglOJiVRHgjfSxShXhTEiurUovy44tKc1KLDzGaAuNn
	IrOUaHI+MP3nlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXANHtG
	U3Yhl8UClhl7qib+nsLj29/9fO1LjbUVDt5vHz3bJXrxw5317A912+ydln/omb+yUmrSNnW1
	kv9GPqHphm65E532vtszs0sy8pjnpw07Iz79apP80rFiev7WvvOeEWdW3jmxJXxZz3GRlMXl
	2Yf/GK89evmole1ymdy1de0syi6/L4k/v1ox4/Qe4+LQ9vdRDu9uSjXrRAj0dS2I+usVv16Y
	a1/MVWM+yaYXJwW/TmlX/jZlyq0ghdXHbwg4bP1wSu2av7Pev7epN9hv7s61/BK6Y2fr/76l
	da/iZ4UeZPef+1b+md71tg3nStwjj6uwnkq23XcinvX/3RN3Ojcu3JdqkmD3rUXB7+yljnYl
	luKMREMt5qLiRADG0VqFRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO76ZOtUgwcNBhar7/azWdw8sJPJ
	YuXqo0wWkw5dY7SYv+wpu8W61+9ZLPbN8rRYsPERo8WGNkEHTo+ds+6ye5y/t5HF4/LZUo9N
	qzrZPDYvqffYfbOBzaNvyypGj8+b5DzaD3QzBXBGcdmkpOZklqUW6dslcGX8/PWbpeA8V8XW
	V39YGxhfc3QxcnJICJhIPGuZzwxiCwnsZpTYNjkYIi4u0XztBzuELSyx8t9zIJsLqOY1o8Sl
	l3/AGngF7CRmf1nMBmKzCKhKbFx2jh0iLihxcuYTFhBbVCBJYs/9RiYQW1jAVeLZrBawODPQ
	gltP5oPFRQRMJZ5s2cIEsoBZ4B2TxK3tv1khtl1klLjQ+w0ow8HBJqApcWFyKUgDp4CfxPOO
	42wQg8wkurZ2MULY8hLb385hnsAoNAvJHbOQ7JuFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL
	9YoTc4tL89L1kvNzNzGCY01LawfjnlUf9A4xMnEwHmKU4GBWEuGN9LFIFeJNSaysSi3Kjy8q
	zUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoEpJclw64SEI1yeYtKPzzcKc8rP
	OD5tT8IV9gzX9wXJbwxPXjrAJ/b/2T+BaQ/nsL/zuPLsXVXVw421Sz7Hdn/QZy+7J6R5mmmu
	0f1DJu+1VsnblUks+pesP8Fmu4fiVZ2T5xiTK1XFF64urZabms0U/DDLvq6YR+ON/xJ1bkmX
	eO03aRkb25fM8ZHj8l4zbVFr1tKZcww/T+eqffnimEN5b/Wtt5uL5sdF5zv4PPR4GJmwIuOB
	iY/TLbvys41bW/cVNW4SOnamZ9LNVeXPT6exO9yMPbzUbMlNBrXb8T6KjxTfKkbPXZ+6549o
	di9Lf/tUxRWCGWY5uzV5uWeEGDL5BudKrTVZd3WGo/CtZUVKLMUZiYZazEXFiQAsoaSjJAMA
	AA==
X-CMS-MailID: 20231027071559epcas5p4cc7eb2a38e21776dcdf548406dfd617c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016061151epcas5p1a0e18162b362ffbea754157e99f88995
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
	<20231016060519.231880-1-joshi.k@samsung.com>
	<aesib7wh6jkm6tsvonsuk73pmsgi3h6aikpzf52vbjbak3jspd@kbi4cm2uhsak>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_001608_004805_18F7991F 
X-CRM114-Status: GOOD (  13.47  )
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

On 10/27/2023 12:36 PM, Shinichiro Kawasaki wrote:
> On Oct 16, 2023 / 11:35, Kanchan Joshi wrote:
>> Passthrough has got a hole that can be exploited to cause kernel memory
>> corruption. This is about making the device do larger DMA into
>> short meta/data buffer owned by kernel [1].
>>
>> As a stopgap measure, disable the support of unprivileged passthrough.
>>
>> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
>> following patches:
>>
>> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
>> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
>> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
>> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
>> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
>> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
>>
>> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/
> 
> This change looks affecting the blktests test case nvme/046. Should we adjust
> the test case for the coarse-granular CAP_SYS_ADMIN checks?

Nothing to adjust in the test, as there is no change in the kernel (at 
this point). I have made a note to revisit the test if anything changes.

