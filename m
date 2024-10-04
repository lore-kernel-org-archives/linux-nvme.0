Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B1ECFA749
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 07:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYN09Xbe0PYTJ9ppx0TFZKZbxwEzo13CyM8oiPI0iAw=; b=vQ258qUagwnjbHp+nyG2AIJXGz
	Kc8Zx8tJsmHCZXs6OlN9Bs0eHFDojQB3vlGQZy+bM8mObzRJQrshkNRY4d19S2Obx0+/H7PHYJQMF
	X+vNa5FdVHTi0nmiiYr05LV8lRbFWsvYfgbfeNYL+g25fdj6zT11LKQ6FFrM4CX6nzh1FnyqmaNEF
	S4r1F9dsRnwwLnXP21+NnmVRBzjHpen74AUfZpfgRolky2DUZdnICiLgcu+N8dOMMsEXA6u+iJzNG
	6kqeGRNFv9v2zc7jjHCsNUja/YG1MDgtnkHIYIyAA3S0mn9zXBGJ/Z390+plBSIpkJfYCn3dDnJxy
	2foVTgYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swcIL-0000000BBZZ-2VJ4;
	Fri, 04 Oct 2024 07:00:09 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swcHi-0000000BBUZ-1NRU
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 06:59:33 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241004065927euoutp028cd7ded3a43710a0a54c1846943a7f28~7LbwSe-1P0403504035euoutp023
	for <linux-nvme@lists.infradead.org>; Fri,  4 Oct 2024 06:59:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241004065927euoutp028cd7ded3a43710a0a54c1846943a7f28~7LbwSe-1P0403504035euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728025167;
	bh=SYN09Xbe0PYTJ9ppx0TFZKZbxwEzo13CyM8oiPI0iAw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U2wAIc13yrx/Yctii7AGAPt3xRg9kAJS7HluBrRYgFF7ADP9u+4Skf65ejl/ZyU8Y
	 VYUL84ar3zTvv52f3nPspIknxf10dwr9CYIymvh1/weHsMFZGSvXy8pnUEtOl6ZTfQ
	 W5iDtdspw+t886cF4l4pMlP+6cPWsjEv0nHp7eZA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241004065927eucas1p1e9b244cdb734ff657d36fa1743d0d817~7LbvtdUrD0035300353eucas1p1g;
	Fri,  4 Oct 2024 06:59:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9B.95.09624.F429FF66; Fri,  4
	Oct 2024 07:59:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241004065926eucas1p15ba0fcb2cecce51f4006abd5569012d8~7LbvMpqz00873808738eucas1p10;
	Fri,  4 Oct 2024 06:59:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241004065926eusmtrp1159c38c63f2d07b201a490752a3e857c~7LbvLh1tG0471004710eusmtrp1d;
	Fri,  4 Oct 2024 06:59:26 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-02-66ff924f034f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.F5.19096.E429FF66; Fri,  4
	Oct 2024 07:59:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241004065926eusmtip28a31675353c172ac8997699aa2c5014c~7Lbu01tpC0535105351eusmtip2Z;
	Fri,  4 Oct 2024 06:59:26 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 4 Oct 2024 07:59:24 +0100
Date: Fri, 4 Oct 2024 08:59:23 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>, <hare@suse.de>,
	<sagi@grimberg.me>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>,
	<jack@suse.cz>, <jaegeuk@kernel.org>, <bcrl@kvack.org>,
	<dhowells@redhat.com>, <asml.silence@gmail.com>,
	<linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<io-uring@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-aio@kvack.org>, <gost.dev@samsung.com>, <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241004065923.zddb4fsyevfw2n24@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004062415.GA14876@lst.de>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZduznOV3/Sf/TDNZtZ7WYs2obo8Xqu/1s
	Fl3/trBYvD78idFi2oefzBbvmn6zWOxZNInJYuXqo0wW71rPsVjMnt7MZPFk/Sxmi0mHrjFa
	TJnWxGix95a2xZ69J1ks5i97ym6x/Pg/Jot1r9+zWJz/e5zVQdjj8hVvj52z7rJ7nL+3kcXj
	8tlSj02rOtk8Nn2axO6xeUm9x+6bDWweH5/eYvF4v+8qm8eZBUeA4qerPT5vkvPY9OQtUwBf
	FJdNSmpOZllqkb5dAlfGrqMnmQuusVUcWPeSuYFxPWsXIyeHhICJxOLZ85hBbCGBFYwS048z
	djFyAdlfGCV2PHnBBuF8ZpR4evcCO0zH3s9vmSESyxklJr+8zghXtfHaO3YIZzOjxKm7B8Ba
	WARUJE6//MICYrMJ2EtcWnYLbKGIgJLE01dnwbqZBS6xSNy6eIYNJCEsYCDx/nsvkM3BwStg
	K7Fnui1ImFdAUOLkzCdgc5gFrCQ6PzSxgpQwC0hLLP/HARGWl2jeOhtsPKeAjsS3o6eYIK5W
	knj84i0jhF0rcWrLLSaQtRICfVwSe5p7oYpcJJbuegxVJCzx6vgWqJdlJE5P7mGBsKslGk6e
	gGpuYZRo7dgKdoSEgLVE35kciBpHiYOvfjNDhPkkbrwVhLiNT2LStulQYV6JjjahCYwqs5A8
	NgvJY7MQHpuF5LEFjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPp6X/HP+1gnPvq
	o94hRiYOxkOMEhzMSiK887b/TRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5Ykpqd
	mlqQWgSTZeLglGpgKnpbzWZ7fKfe35Bbb1/vv7/BQ0C68wULh8rf+0m7Ai+f9liRLv7XnKe8
	1PPOU+3cjizzkzP0nqs/YNMwvrrkmtHs3QsbD6YkF5+asnu1qMA//lLht7WZsWcso/mC0+TO
	mj5Jr8ttTvn/9YTrHElD/l5j9vX3FsWKnAkM/cYt8nBVz9zJ0y9tO+/0fs6OrHNzzrasNN2z
	zEjjn6tuM5vEsUrZ97s+fNlguK9gZ7R4/r8HbqvWOWvfCpuhL/fg6pVvc7xVd6l/WzldMyxv
	lvaLWdGmDb5aJ9JuKFcFBd61yH76PF7M3X/XiyrZ+ncnnyqebTiWWZIyO75re4zPntO8ERO2
	p+bF/tin8aZnd9FOVyWW4oxEQy3mouJEADqfXjwUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsVy+t/xe7p+k/6nGVyZKmMxZ9U2RovVd/vZ
	LLr+bWGxeH34E6PFtA8/mS3eNf1msdizaBKTxcrVR5ks3rWeY7GYPb2ZyeLJ+lnMFpMOXWO0
	mDKtidFi7y1tiz17T7JYzF/2lN1i+fF/TBbrXr9nsTj/9zirg7DH5SveHjtn3WX3OH9vI4vH
	5bOlHptWdbJ5bPo0id1j85J6j903G9g8Pj69xeLxft9VNo8zC44AxU9Xe3zeJOex6clbpgC+
	KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MXUdP
	MhdcY6s4sO4lcwPjetYuRk4OCQETib2f3zJ3MXJxCAksZZQ4v3EtVEJGYuOXq1C2sMSfa11s
	ILaQwEdGiYNfJSAaNjNKrFw5iR0kwSKgInH65RcWEJtNwF7i0rJbzCC2iICSxNNXZxlBGpgF
	LrFI3Lp4BmySsICBxPvvvUA2BwevgK3Enum2EENvM0vsO7sebCivgKDEyZlPwIYyC1hIzJx/
	nhGknllAWmL5Pw6IsLxE89bZYLs4BXQkvh09xQRxtJLE4xdvGSHsWonPf58xTmAUmYVk6iwk
	U2chTJ2FZOoCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgalm27GfW3Ywrnz1Ue8QIxMH
	4yFGCQ5mJRHeedv/pgnxpiRWVqUW5ccXleakFh9iNAUG0URmKdHkfGCyyyuJNzQzMDU0MbM0
	MLU0M1YS52W7cj5NSCA9sSQ1OzW1ILUIpo+Jg1OqgUl+3dXGSscNq6Jrw49PPj2hsuOSvVPG
	ie9Z94/89HzDvHDqEwa1gwz79qz7GerrXndJcFZl7dtDVeXnexyezD3h+a1l+SxLJ4dLEduy
	n1rO91ra1bzvvFiZeuqq3Utat+l/EThkkC2TX3fmh3bxtDsuEz+3iS535uBfcH9myBmFOpF5
	f5Y8PJji+Ci9jNvbesKbkLPmf9PfJCntWuHEOyHim6Z8dmWZdue7FO9D/5YJmnJzH+gNCYk7
	paESYKNWdm/RQ4lTRmZsJe6ro2KWnL1//9u7V31f563Sj3tWFHD12d39j6z6hd7kCSgeWf1S
	Ze1awzuXwi5cf+Lyac9VnuR7azNErj+zrTH5kfIlsMpMiaU4I9FQi7moOBEAUqqfUb4DAAA=
X-CMS-MailID: 20241004065926eucas1p15ba0fcb2cecce51f4006abd5569012d8
X-Msg-Generator: CA
X-RootMTR: 20241003125523eucas1p272ad9afc8decfd941104a5c137662307
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241003125523eucas1p272ad9afc8decfd941104a5c137662307
References: <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
	<20241002151344.GA20364@lst.de>
	<Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
	<20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
	<a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
	<CGME20241003125523eucas1p272ad9afc8decfd941104a5c137662307@eucas1p2.samsung.com>
	<20241003125516.GC17031@lst.de>
	<20241004062129.z4n6xi4i2ck4nuqh@ArmHalley.local>
	<20241004062415.GA14876@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_235930_794105_61F2F648 
X-CRM114-Status: GOOD (  12.57  )
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

On 04.10.2024 08:24, Christoph Hellwig wrote:
>On Fri, Oct 04, 2024 at 08:21:29AM +0200, Javier González wrote:
>>> So I think some peoples bonuses depend on not understanding the problem
>>> I fear :(
>>>
>>
>> Please, don't.
>>
>> Childish comments like this delegitimize the work that a lot of people
>> are doing in Linux.
>
>It's the only very sarcastic explanation I can come up with to explain
>this discussion, where people from the exactly two companies where this
>might be bonus material love political discussion and drop dead when it
>turns technical.

FDP has authors from Meta, Google, Kioxia, Micron, Hynix, Solidigm,
Microship, Marvell, FADU, WDC, and Samsung.

The fact that 2 of these companies are the ones starting to build the
Linux ecosystem should not surprise you, as it is the way things work
normally.


