Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F55C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HVuWuz1UPJJnF0H/Od6KfXL+BZ14yoOAdr/ipDI2DXk=; b=ysok66ufYDtLGy
	g/3ltUSNFPbmqe9WUVF219NCmUTRk/KkT2A9HAEQ0ukc8jxF8tDHdEdlhO7lkCLJzWXEOu0QyaMnS
	Bh1uesFzeZTdRo0roz/1/gpjrKZ7ngaba1BOKp+SOl+Wt0D6JFVRHgUpEC9FROZrdiJ461KRyRMq6
	q5ZG2B5vTj1Liry5TO/Uw+MRlaHUhqD8SBcLx1xes/lXWcM++RApWmggjDYxSvgnm29WiK3m09/Rn
	YvdveiqjS70BENy7Vt10LS+dQQ8vzzHFaPCy6wErW0QbV8Jky/i9KWGkyU4L/Njji3hwi/+7ux689
	tEwyf2csTRUSgxZzeu5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD78c-00GL25-7e; Thu, 27 Jan 2022 15:56:42 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD78Y-00GL1a-2T
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 15:56:40 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220127155635euoutp02fd18085c07ce4ce7a844f62b6b516a7d~OK7rudAy23113431134euoutp02N
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 15:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220127155635euoutp02fd18085c07ce4ce7a844f62b6b516a7d~OK7rudAy23113431134euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1643298995;
 bh=HVuWuz1UPJJnF0H/Od6KfXL+BZ14yoOAdr/ipDI2DXk=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=fozXlqHlqhHxWA01no4qyT6VlbrU+3etS7ThyatXP6T3Q8gPN7RTBhoUEylF/j7TI
 suvXw/G/Mw7NyiGdNEwRUHt1ydCWJzLuFajGErlLxPSQznCVCRq0cag6FdqO1rxs0w
 yo/6lpsFS+NoTiM0YOSLEFFWA5l0pKoIarAUkBdA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220127155635eucas1p1e3d8814d8fec8f2412443eab52be81b5~OK7rlZ4B91331413314eucas1p17;
 Thu, 27 Jan 2022 15:56:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 4F.3A.10260.3B0C2F16; Thu, 27
 Jan 2022 15:56:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220127155635eucas1p13769159bf6b3ca09f3b8954704036312~OK7rUrY651330213302eucas1p1C;
 Thu, 27 Jan 2022 15:56:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220127155635eusmtrp1b545c4c66e21765b2c8da9768cc10d42~OK7rT-PfU0111901119eusmtrp1Z;
 Thu, 27 Jan 2022 15:56:35 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-8a-61f2c0b3d42c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.92.09522.3B0C2F16; Thu, 27
 Jan 2022 15:56:35 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220127155635eusmtip1a81b10f9dcb4f1c325737e1cd4032e6e~OK7rNVlsS1951519515eusmtip1C;
 Thu, 27 Jan 2022 15:56:35 +0000 (GMT)
Received: from [192.168.1.32] (106.210.248.16) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 Jan
 2022 15:56:32 +0000
Message-ID: <af495f19-b060-42bb-f22c-430dd79b98c0@samsung.com>
Date: Thu, 27 Jan 2022 21:26:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Use pci_iomap instead of ioremap
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <pankydev8@gmail.com>
CC: Keith Busch <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220127144508.GA20196@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.16]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
 CAMSVWEXC01.scsc.local (106.1.227.71)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd3NBz4lGrR0aFqsXH2UyWLSoWuM
 FvOXPWW3WHPzKYsDi8fOWXfZPTat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsErozr0z6w
 FUxkq3jx6RBbA+Nrli5GTg4JAROJKx3XmLoYuTiEBFYwSiy/OhvK+cIo0dl9kQ3C+cwo8ahv
 MhNMy48fj5khEssZJXbePM0IVzW/9zkrhLOGUeJczx2wLbwCdhLHm54wg9gsAqoSpw6uh4oL
 Spyc+QTMFhWIkHh55C/YCmEBa4m2Cf/AbGYBcYlbT+aD2SIC7hJ9p38B3cQBFHeVONpeDmKy
 CWhJNHayg1RwCuhI/Jk8nR2iU1OidftvKFteYvvbOcwQDyhJvJlxhxmkVUIgWWLDzDCQiyUE
 7nBI/G3+zQhR4yLxYN80NghbWOLV8S3sELaMxOnJPdCwK5ZYtK2VFcKukXi16DpU3F7i36dN
 UL2OEq/2rGOH2MUnceOtIMQ5fBKTtk1nnsCoOgspHGYh+XcWkg9mIflgASPLKkbx1NLi3PTU
 YuO81HK94sTc4tK8dL3k/NxNjMDkcvrf8a87GFe8+qh3iJGJg/EQowQHs5II74xNnxKFeFMS
 K6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MJU8ONusv4E3IvEF
 QxH3jG2xwgxNHZJb5HjKX35Z1rIq1GnDw+abzd5amoVhPWsDvu6oPi6xu/JHfm9Ns7tOb/Vi
 LaHbmz+FnxI6Hq0X8tSqltNq8QWZ2LnORvuupf2QiZGdVDglKq77/ZOJOyYsXS+T7JpyomBf
 fLnfqvKly/VZZZyEDh4N64phPrDUJqHshfOp4wp/1+/JD3AIqe+JN985y2kly6E63SiNFdwb
 cq/w//UpPH93QdnuCYdKe89KrFcNn/Bu3i6JfanX/0w0TXjHWn328/9nXaXdUrt579p/1rJM
 zqgUtMuUVYoI2lbwb3nlgVvGfkavKn9OU+Vmqgo4wP7l6l5OxonpLiyPlViKMxINtZiLihMB
 oaWatZ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7qbD3xKNJjSI2GxcvVRJotJh64x
 Wsxf9pTdYs3NpywOLB47Z91l99i0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
 9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKuT/vAVjCRreLFp0NsDYyvWboYOTkk
 BEwkfvx4zNzFyMUhJLCUUWJV3wSohIzEpysf2SFsYYk/17rYIIo+MkqsWbMUylnDKPGl8RBY
 Fa+AncTxpifMIDaLgKrEqYPrWSDighInZz4Bs0UFIiTalk0BqxEWsJZom/CPCcRmFhCXuPVk
 PpgtIuAu0Xf6F9ACDqC4q8TR9nKIXX8YJVY0nGIEibMJaEk0doKt5RTQkfgzeTo7xBhNidbt
 v6FseYntb+cwQzygJPFmxh1mkFYJgWSJv7fCJzCKzkJy3CwkR8xCMmkWkkkLGFlWMYqklhbn
 pucWG+oVJ+YWl+al6yXn525iBMbktmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8MzZ9ShTiTUms
 rEotyo8vKs1JLT7EaAoMoYnMUqLJ+cCkkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
 nZpakFoE08fEwSnVwGRwrV7KPEbaLuPNz4XVa197Hq3sa/+S1aCxKVHiaFX19LdZ5fcc715x
 mymrLXkvcvnTJ255r4qLqhgW/XbtKWBPi8sWOKMff5Or+4vGEm2tGFELx8dc0Yz5Se27p2xa
 PWfBzLMT9BrSlD9kPzL6H6xXbBWo0Sm15OqB6/rs29qUxWWENxwRdH57Tp3d75/0ixS2PU9+
 1q7z9f6lqW0cu7nKlqX5RqD0cZYzpwt/n9DmDS5RVLJ99r/rjYCKzESnYzY93hU/71vd6c/d
 vMpQvu6Uk+H6tnXLr+m/mVF8bsqbAuOIcOYzZ3xe/K5p/WvpW/v1vJP6Oue2KervPZh5+Pf7
 6zcHqz97e+rcjOx6JZbijERDLeai4kQA7hyzi1IDAAA=
X-CMS-MailID: 20220127155635eucas1p13769159bf6b3ca09f3b8954704036312
X-Msg-Generator: CA
X-RootMTR: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
 <20220121143533.164928-1-p.raghav@samsung.com>
 <20220126163306.GB31892@lst.de> <20220127130541.qxb6vk5lhoaa4ivl@quentin>
 <20220127144508.GA20196@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_075638_586943_3F12CF52 
X-CRM114-Status: GOOD (  14.19  )
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



On 2022-01-27 20:15, Christoph Hellwig wrote:
> On Thu, Jan 27, 2022 at 06:35:41PM +0530, Pankaj Raghav wrote:
>> On Wed, Jan 26, 2022 at 05:33:06PM +0100, Christoph Hellwig wrote:
>>> pci_iomap goes with the ioread/iowrite accessors which we absolutely
>>> do not want in nvme.
>> Is it because of ioread/iowrite has a conditional check everytime we do
>> a read/write with IO_COND? Or is there any other reason?
> 
> Yes, ioread* and iowrite* are more expensive.  And nvme doesn't support
> port I/O anyway so there is no point.

Ok. 

`ioremap` has a comment to prefer pci_iomap if the area we are trying 
to map is a PCI BAR. Does it makes sense then to have a comment in 
the nvme pci driver as to why ioremap is preferred over pci_iomap?

-- 
Regards,
Pankaj

