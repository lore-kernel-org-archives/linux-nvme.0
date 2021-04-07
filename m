Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E61C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 11:50:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A008A6139E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 11:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008A6139E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vusx5cPg2ynuf0gjRXXaBCXPRdnC/7MbJb1Ygb++I2E=; b=mVc5dnWZRiMwKAjcckr9vWjBl
	N4O9TNY0UTOUZQ6oB1LQly9aNKbIkEvSYpsKRFvNlpdRrq1qzPLixQDOcSD08Q3/o0f2obUdgD9jo
	JkYWVTWpa3xZaGgDpR9hXBOFqcPJfYYKTDLczKvHOczFcYeZIcYcwF1Vn1AMDP/i2er+H1jkHJA5W
	GoE6Qm91Ot7LeUPqYuF5RLtdYr46ESSIbEn5lO1c65H+teBz1+Y4zD32NSU0T9FTHApb0a0IZ/Dyb
	F/TX8C264lh/9SS2cfjETEMteNMHykgID9mr7457h5F2UTamBD+9THG3EYEjGd6eEJmg8ZI/vLMFY
	uyxy29pfQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU6hU-004v5G-2q; Wed, 07 Apr 2021 11:50:24 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU6hI-004v37-UE
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 11:50:16 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210407115009euoutp018d294ac72be1136b7a9d5f4a00edf348~zkRTRTCdl2699026990euoutp01D
 for <linux-nvme@lists.infradead.org>; Wed,  7 Apr 2021 11:50:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210407115009euoutp018d294ac72be1136b7a9d5f4a00edf348~zkRTRTCdl2699026990euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617796209;
 bh=DCwP71KoqJsvQRaRDvznQaqC0aG0Zz+DupVzYot1ub8=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=j5/Cy6An8rrEL6w9FEFfLREO16BjOdt7i26tT+dUJCxaVFsZjbdUhq4QN8IJcxePe
 0c988uN3zK1OUF8rjaFDUovDJVub2jA9blkEu9lIrx6DfYgmx7WLubrRM3GRyl8FgJ
 IXkndtE/vcmeXHlYl6Po2i5zI58zFqvY8QgOFXwQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210407115009eucas1p1f36f3b8528d96f8d3e0443c36e923364~zkRTDFAnw2330423304eucas1p1E;
 Wed,  7 Apr 2021 11:50:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id F3.71.09444.17C9D606; Wed,  7
 Apr 2021 12:50:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210407115008eucas1p2fbff62bdf0285cc6cdca01fb919612d9~zkRSjwaiF1885718857eucas1p2n;
 Wed,  7 Apr 2021 11:50:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210407115008eusmtrp12dd41b649fd1d504d0fdcbb50bd07788~zkRSi8kSb0564005640eusmtrp1v;
 Wed,  7 Apr 2021 11:50:08 +0000 (GMT)
X-AuditID: cbfec7f4-dbdff700000024e4-4f-606d9c718a9b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.EA.08696.07C9D606; Wed,  7
 Apr 2021 12:50:08 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210407115008eusmtip25c850af0b3e063691a2ba8a30d37bb09~zkRSXTnaH2764827648eusmtip28;
 Wed,  7 Apr 2021 11:50:08 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 7 Apr 2021 12:50:08 +0100
Date: Wed, 7 Apr 2021 13:50:07 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
CC: Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi
 <joshiiitr@gmail.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407115007.rnpde3sut37563ff@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651481C1623F0B99F573168DE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7qFc3ITDP7vk7D4v+cYm0Vr+zcm
 i5WrjzJZnH97mMli0qFrjBbzlz1lt/jVyW3x4M9jdot1r9+zOHB6TGx+x+6xc9Zddo/z9zay
 eGxa1cnmsXlJvcfumw1sHu0HupkC2KO4bFJSczLLUov07RK4Mg7OXcJScJaj4tKP5ywNjO/Z
 uhg5OCQETCQeLQjvYuTiEBJYwSgxYfkcFgjnC6NEf89bKOczo8S23a+Zuhg5wTr2tvQyQySW
 M0os63nDApIAqzrwTRAisQVo1oHjTCA7WARUJD5sVACpYROwl7i07BYziC0ioCWxbN87VpB6
 ZoE9TBK/vnxhA0kIC3hKfOo7xQ5i8wo4SfR+eMUCYQtKnJz5BMxmFrCS6PzQxAoyn1lAWmL5
 Pw6QMKdArMS86b1QrylLLJ/uC3FzrcTaY2fYQVZJCLRzSjycvAvqGReJ3bf3s0PYwhKvjm+B
 smUkTk/uYYFoaGaUOLPmCjOE08Mo8WfSCkaIDdYSfWdyIBocJXY9PMsMEeaTuPFWEOJMPolJ
 26ZDhXklOtqEIKrVJHY0bWWcwKg8C8ljs5A8NgvhsQWMzKsYxVNLi3PTU4uN8lLL9YoTc4tL
 89L1kvNzNzEC09Hpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrw7erMThHhTEiurUovy44tKc1KL
 DzFKc7AoifMmbVkTLySQnliSmp2aWpBaBJNl4uCUamCqqLGNWL0rdz6396HpieFpZwXDnu/z
 E90lqVVjsE9m86XD/7jZqyVV2eovt314G9KznbuiLPumkiffrtqNAnkh8wO6EpfvbEjbOVvB
 vfFum/ekXtN3TXdFv8oe3d7F42gX9WX7lRXl1Wza/BwR+Y+9br3NrN/Q3hLdKeV5rWXCl91p
 dxelv2iIef3DXfzil4UH6uwF+FhE+v8J55n8qGK96JNrbeuyQ+KR1Ieb+gkmbPWnbzeZCk6z
 jDvdqbWZRUyq6OyjtJP5fw9f093cbiD19NTFGiHLBHmuS2+n5d2NejBt36pzbs6a5TYbDwWY
 JLy4nvPwxh4ZrzNr/rXfLP9o8MzCUEjok8n6M86/jZRYijMSDbWYi4oTAYll0kW2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oFc3ITDDo6TS3+7znGZtHa/o3J
 YuXqo0wW598eZrKYdOgao8X8ZU/ZLX51cls8+POY3WLd6/csDpweE5vfsXvsnHWX3eP8vY0s
 HptWdbJ5bF5S77H7ZgObR/uBbqYA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NY
 KyNTJX07m5TUnMyy1CJ9uwS9jINzl7AUnOWouPTjOUsD43u2LkZODgkBE4m9Lb3MXYxcHEIC
 SxklPm87ywqRkJH4dOUjO4QtLPHnWhcbRNFHRomOs1uhnC2MEt/m9wNVcXCwCKhIfNioANLA
 JmAvcWnZLWYQW0RAS2LZvnesIPXMAnuYJDbN3Q62WljAU+JT3ymwDbwCThK9H16xgNhCAhOZ
 JT7eY4aIC0qcnPkELM4sYCExc/55RpBdzALSEsv/cYCEOQViJeZN72UDCUsIKEssn+4LcXOt
 xKv7uxknMArPQjJoFpJBsxAGLWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYl9uO/dyy
 g3Hlq496hxiZOBgPMUpwMCuJ8O7ozU4Q4k1JrKxKLcqPLyrNSS0+xGgKDIiJzFKiyfnAxJBX
 Em9oZmBqaGJmaWBqaWasJM5rcmRNvJBAemJJanZqakFqEUwfEwenVAPTSv4Fs2/cVXxS8iug
 oPlneNlK2ZA3pg6/D73MkzpwxqJDar7BgpBunx37LdpTF27ZkjsliSXyo03o5f/yJ99+28LQ
 xMA9o/O25e1vq0s4eQMkjGfoHtIMeKju/mWVAfti56vHCgt/2EVN5Gjk0t6+atfX62tjLWYa
 Lg2b1vrhv8p/1uQ//aKTA3bMSJzE5mKVKh5w35jX3LliIq+loLRLTEqAmci2eTZlVxf/4bJf
 22Y+acEXtVOXREzO9c3adMBj9Zv1Vk88tCtcmP2nzqq+FrQr4YKTlPydpHqputi7spIMm554
 1LosFd1xZ51c65E5xpWdBi+THqyXtROrYN7L53YkPi02TENqxTlxzX4lluKMREMt5qLiRADc
 nX1OVAMAAA==
X-CMS-MailID: 20210407115008eucas1p2fbff62bdf0285cc6cdca01fb919612d9
X-Msg-Generator: CA
X-RootMTR: 20210407103601eucas1p10238155660419477d6dcb2b2d29ba7cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210407103601eucas1p10238155660419477d6dcb2b2d29ba7cf
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
 <20210406145948.GB7790@lst.de> <YG1g9bMYRjS3uCXs@x1-carbon.lan>
 <20210407093923.GA31210@lst.de>
 <CGME20210407103601eucas1p10238155660419477d6dcb2b2d29ba7cf@eucas1p1.samsung.com>
 <BL0PR04MB651481C1623F0B99F573168DE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_125013_284509_3913169B 
X-CRM114-Status: GOOD (  12.45  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 07.04.2021 10:34, Damien Le Moal wrote:
>On 2021/04/07 18:47, Christoph Hellwig wrote:
>> On Wed, Apr 07, 2021 at 07:36:22AM +0000, Niklas Cassel wrote:
>>> The SCSI generic devices are named /dev/sgX while the SCSI block devices
>>> are named /dev/sd*, so the names are more distinct compared to /dev/nvme*
>>> and /dev/nvme-generic-*.
>>>
>>> A "regular" Linux user who writes /dev/sd<tab> will not see the SCSI
>>> generic devices, but with the current proposal, if he writes
>>> /dev/nvme<tab>, he will see the NVMe generic devices.
>>>
>>> I just had a gut feeling that this could cause confusion in the future.
>>> However, I trust your experience and judgement more than my gut feeling.
>>
>> Should we call the nodes /dev/ng* ?
>
>That would be a nice symmetry with scsi / sg. I am all for it.
>This would also make it easier to read a "ls" output, avoiding a lot of nvme
>device names that differ only by 1 character ("c").
>

+1 to this naming convention

We will let the V2 hanging for a couple days and add this in V3 unless
any good argument against it comes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
