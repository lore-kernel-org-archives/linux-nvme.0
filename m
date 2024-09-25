Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5AECF58C1
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+1Yc1j/F9EUOGjp4C92RegYtPjoX8rRZqa0vTdTHK48=; b=gnKGARTdPRXqRQPwUtihFnQFW8
	mLlPH587VzjCnCuBQe5QMkGVGGWMcVMjr/y6Bb7QPlZR4Y8ItlKiHrO3Qn8w/XDLTyj5NIhK/lwcz
	lNoU6pj4F+dCxDo8bQ/7h/enrv72MzchlAQrbFhKzYCShIUj6c5tLsZSIs1kSNHkJ9OskfOjp5R0L
	3StrTrmG7m7rmMIMtGuENfyVV+12ZcdWbZQ6JCxtwGoYvVGnq79MegNgdIDQOzfSXZRNi/9uU4pp3
	tG1jIcF2Tf5wKD4xkZZR8J6GMxV1Ca4NOcx34tu96ILHHtJ9wrU5OnDPnBsnVwr9sMjuq1AkifGAl
	lP3SCilw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stRxi-00000005Lgz-0dMv;
	Wed, 25 Sep 2024 13:21:46 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stRxd-00000005Ldu-06yx
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 13:21:43 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240925132127epoutp02b062f7461c96a80147fe310584907810~4f1tPQc612482824828epoutp02K
	for <linux-nvme@lists.infradead.org>; Wed, 25 Sep 2024 13:21:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240925132127epoutp02b062f7461c96a80147fe310584907810~4f1tPQc612482824828epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727270487;
	bh=+1Yc1j/F9EUOGjp4C92RegYtPjoX8rRZqa0vTdTHK48=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Lc2HD6blpJLV/4WfxwsAMpBsi8DR/GOPrjWsVCPHq5pNPwKz1Gs5TMn5c8GQkysLI
	 5omKhiT71xcyqH1j/ZPBXqq2N/H1VD5qhpZb2PAV0d9v+dXE9fnnWpCb7McLLolakE
	 0WNG7VZu3dH6EYYYyk1EtjeTpayhfHnFRxa3wYyM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240925132126epcas5p2b8370189c618a80127d8cb97c040f7a7~4f1somcHI0162601626epcas5p2T;
	Wed, 25 Sep 2024 13:21:26 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XDHS52bxdz4x9Ps; Wed, 25 Sep
	2024 13:21:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.A5.08855.55E04F66; Wed, 25 Sep 2024 22:21:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240925132124epcas5p1cc362b7e5fec64e41bde11aec1ab9ea5~4f1qS-viC2284122841epcas5p1t;
	Wed, 25 Sep 2024 13:21:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240925132124epsmtrp1de7dc004f5a08b5d887f6fa16623a015~4f1qSD7971595215952epsmtrp1w;
	Wed, 25 Sep 2024 13:21:24 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-b7-66f40e5581c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.C3.19367.35E04F66; Wed, 25 Sep 2024 22:21:23 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240925132120epsmtip1fc0524d7ed2f4e6e95512f107b748adb~4f1nR6kh43096430964epsmtip1w;
	Wed, 25 Sep 2024 13:21:20 +0000 (GMT)
Message-ID: <8665404f-604e-ef64-e8d7-2a2e9de60ba7@samsung.com>
Date: Wed, 25 Sep 2024 18:51:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v6 3/3] io_uring: enable per-io hinting capability
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, Hannes Reinecke <hare@suse.de>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <cb3302c0-56dd-4173-9866-c8e40659becb@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTZRzH7/nuyzYo3NcJ8UCezVXegYFbwXzwQEyJ+wqeoV53FiEt9uXH
	bWxrP0Cgu8gOyl0OGYY0EEwpYXJ4DAQGA71JN1H5kQQBDV0xSuCGAXYlBLQxIv97PZ/P+33v
	5/N57mHS2GWMIGamVEUppEIJl+6Dt9wKDgl9Z9OTNN5tPQtVGloAujpeTEealWYczdyaB6js
	j6c0NHtqCUejN00YMl/SYaju6vcYmi3sw1HF+c8w5Limp6EJ2wID6SzDAJ0rOwVQ59hOZO7s
	wVH1d5MMdMW6gqGWpWoaaph5jKP+ZasX6tdXMvYFkIM/JpAm/TiD7H/QiJODvWrSaDhNJ43z
	OgbZVPMJ2TFaQCfnJsdw8nHXEJ3UNhsAee9it6t5N59cMG4jjQ4nlsh6TxyVQQlFlIJDSVNl
	okxpejQ34VjKgZQIAY8fyo9Eu7kcqTCLiubGHkoMjcuUuHbA5WQLJWpXKVGoVHJ37Y1SyNQq
	ipMhU6qiuZRcJJGHy8OUwiylWpoeJqVUe/g83usRLuEH4ozZykeYvIR50jltoheARroGeDMh
	EQ6nJ0cYbmYTHQA2n35FA3xcPA9gZ3UTtnFwtmoYG47yy7inYQKwR9u3bncCWDGb7GZfYi+c
	LDhHczNOvAqHp/6me+qbYc/XDtzN/sSHcHGoErh5CxEHmyr6vdxMIwLgmKN6LdmPMGHw9+WH
	dPeBRqwC+FWdwaViMulEMBwoVbvRm4iGc/YTHu9LsNVZSXPLIXHDGzospZjn1rHQbm/GPbwF
	Tlub16cJglPFResshvZf7euaj2Fbk9bLwzGw4J+RtViaK/Za+y5P1iZ4ZsmBucuQ8IVfFLE9
	6u3wgW5y3RkAfymv8fJISKhZPuxZ230M6qYasbOAo39mK/pnptc/M43+/+CLADeAQEquzEqn
	UiPkfCmVs/HcqbIsI1j7ICGxbWCkeiXMAjAmsADIpHH9fHWjc2lsX5EwN49SyFIUagmltIAI
	1/OU0IL8U2WuHyZVpfDDI3nhAoEgPPINAZ8b4DtTeEHEJtKFKkpMUXJK8Z8PY3oHFWDPr34e
	efd624HzXBtrtWX5uslywvnbRM3TrbJs0p6fPWC9uZg0ZDOHmi0Nmi8f2pNfCNhzKHfHQved
	Ny//FdpRP/Hn23NHqnKOaI/Xq80/JwR+GtX1TVVR1ftgoEXbvhI3ulj6shcLTxhOHjLyrqjr
	XsyLqt3fwW+focyHbfPlTxrz7MYLtuAYa28WK95vlX20py3wUq6O+e3x2nf9WfcT2IzsnO3i
	sJKF27263UofwbYbkj4+ETNm08RSE0kN8Zoigah1q+FMzXh+ak7XkvZk0sGDZfU7jg7WxFGF
	jyLFzxXv3CwpP1b5U0h3oJVzJ62PN3LvtfiPbEv794W8VWsK+yGQiyszhPwQmkIp/Bd5Uipy
	qQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCSnG4w35c0gxc3rCzmrNrGaLH6bj+b
	Rde/LSwWrw9/YrSY9uEns8W7pt8sFjcP7GSy2LNoEpPFytVHmSzetZ5jsZg9vZnJ4sn6WcwW
	j+98ZreYdOgao8WUaU2MFntvaVvs2XuSxWL+sqfsFsuP/2Oy2PZ7PrPFutfvWSzO/z3OanF+
	1hx2B3GPy1e8PXbOusvucf7eRhaPy2dLPTat6mTz2PRpErvH5iX1HrtvNrB5fHx6i8Xj/b6r
	bB59W1YxepxZcAQoebra4/MmOY9NT94yBfBHcdmkpOZklqUW6dslcGW8m/OCqWAiR8XbVzvZ
	Ghg3snUxcnJICJhIvJqxmKWLkYtDSGA7o8SfXXNZIRLiEs3XfrBD2MISK/89Z4coes0o0XRq
	Mlg3r4CdxNOGKcwgNouAqsS1lz+g4oISJ2c+YQGxRQWSJPbcb2QCsYUF3CQ2zz4PtoAZaMGt
	J/OZQIaKCOxkkvi48T8biMMs8J9RouPYMiaIdZeYJHa93QCU4eBgE9CUuDC5FMTkFLCV+Pgg
	DmKQmUTX1i5GCFteYvvbOcwTGIVmIbljFpJ9s5C0zELSsoCRZRWjaGpBcW56bnKBoV5xYm5x
	aV66XnJ+7iZGcKrQCtrBuGz9X71DjEwcjIcYJTiYlUR4J938mCbEm5JYWZValB9fVJqTWnyI
	UZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAtGty91rZVe5KTw30j9rtT5U90HPz0buu
	I1u55tobHwuyyKmdd4VhWvP1rz9+WLO73TH4v/O5cvSMKWtkub1UZTae4+jWOr4gyY35iekh
	YQ2lrUFL5zL9zNryWrdU1KWIffO67WoMpQtEP3JPaWx8YzTDsKnJ8olqVtgcnbBvwVYL20zO
	r/nXsD5c535PaaF0dxun9QuR2Y9vVzWeePDfj8v1BXMiT73B5e8v9r/UuN75fpJoq/bCIl2e
	617qXBm/PPndHsw8+TV86uppvWuqFba+2b/yNkOE8oHrwU6Psz7naGQFp/9b/e349F6u3ILV
	7zYvVuP89zp7sWVYhcn14wxBqXILZeI7bh345/34sBJLcUaioRZzUXEiAE9puQyEAwAA
X-CMS-MailID: 20240925132124epcas5p1cc362b7e5fec64e41bde11aec1ab9ea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240924093257epcas5p174955ae79ae2d08a886eeb45a6976d53
References: <20240924092457.7846-1-joshi.k@samsung.com>
	<CGME20240924093257epcas5p174955ae79ae2d08a886eeb45a6976d53@epcas5p1.samsung.com>
	<20240924092457.7846-4-joshi.k@samsung.com>
	<28419703-681c-4d8c-9450-bdc2aff19d56@suse.de>
	<678921a8-584c-f95e-49c8-4d9ce9db94ab@samsung.com>
	<cb3302c0-56dd-4173-9866-c8e40659becb@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_062141_434747_2F1D88CE 
X-CRM114-Status: GOOD (  17.62  )
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

On 9/25/2024 5:53 PM, Pavel Begunkov wrote:
> On 9/25/24 12:09, Kanchan Joshi wrote:
>> On 9/25/2024 11:27 AM, Hannes Reinecke wrote:
> ...
>> As it stands the new struct will introduce
>>> a hole of 24 bytes after 'hint_type'.
>>
>> This gets implicitly padded at this point [1][2], and overall size is
>> still capped by largest struct (which is of 16 bytes, placed just above
>> this).
> 
> For me it's about having hardly usable in the future by anyone else
> 7 bytes of space or how much that will be. Try to add another field
> using those bytes and endianess will start messing with you. And 7
> bytes is not that convenient.
> 
> I have same problem with how commands were merged while I was not
> looking. There was no explicit padding, and it split u64 into u32
> and implicit padding, so no apps can use the space to put a pointer
> anymore while there was a much better option of using one of existing
> 4B fields.

How would you prefer it. Explicit padding (7 bytes), hint_type as u16 or 
anything else?

