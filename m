Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DiZwZQWOBXPeAE/uBNBvUQI06BqfJxgh8cNMlp7zy0I=; b=wmBbShiIqr3Qsa
	FEtNdT0Kb5vEAytcizmes46if8bHv9aDecTEfco1vZpP2k3FPkGOzPFUZDJFKzj3ctFRFPUMNQlcP
	SxOb9yByXxpjmvW1xYg27z5WI7bIbbIMAaQZEb26l5nXS1e+3lpJKlxxlW8X9t/iPOfrjfvAZt1Pq
	gd4tpCPEj7iKSbZKuXv4cLwUbN//U9wwu/QJ+QcKSGw7xdkq8pO4GUMTFC3pzzjOtJ+ephSgjC/oa
	UpFXGlXbeuTbeRYmSDVBEdXFYThLvQAMk/zN246wns/dp72iEKrshqMAlQOC7qcr8puQ+nKPBRpG+
	1NPgj7IWRJdWolVJG0vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUY0B-00E3pI-PM; Wed, 16 Mar 2022 18:04:03 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUY09-00E3or-FL
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 18:04:03 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220316180400euoutp015b999b745484589d7bf2a08c5a35bc7e~c7ooARc-P1320213202euoutp01J
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 18:04:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220316180400euoutp015b999b745484589d7bf2a08c5a35bc7e~c7ooARc-P1320213202euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647453840;
 bh=DiZwZQWOBXPeAE/uBNBvUQI06BqfJxgh8cNMlp7zy0I=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=E9p0kbZqdMmVFpZLGMShjAf5C/ZiXeELl3Z502RXVPgpD4FDsVkkZZ3sHcrQrWV55
 ZvuuJfp2sdoj5n1ceIoYXlVTV8YPyySpcE+5f/HLJgtlZzal6WFRr543B84JvfI2W/
 QkC6LMUX4NTQ7P0112jYcDfjqiRWSPIlE0pfM5MU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220316180359eucas1p15e71d4478deb637e42fca4f190f17e70~c7onrM5VW1797817978eucas1p1e;
 Wed, 16 Mar 2022 18:03:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 94.22.09887.F8622326; Wed, 16
 Mar 2022 18:03:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220316180359eucas1p22a908f93e9d7c642411bb87040161b56~c7onTcxS-1791917919eucas1p2e;
 Wed, 16 Mar 2022 18:03:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220316180359eusmtrp247e5e3da2416acbb29ceb6bc21fb05ab~c7onSwNF61610316103eusmtrp2G;
 Wed, 16 Mar 2022 18:03:59 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-56-6232268fd71f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.81.09522.F8622326; Wed, 16
 Mar 2022 18:03:59 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220316180359eusmtip115b062f6e56b55b11dde1ed380548899~c7onLGpqV1146011460eusmtip1U;
 Wed, 16 Mar 2022 18:03:59 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.179) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Mar 2022 18:03:55 +0000
Message-ID: <76525354-6d55-f4c9-2a74-bcfdcd75af70@samsung.com>
Date: Wed, 16 Mar 2022 19:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to
 export correct permissions
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens Axboe
 <axboe@kernel.dk>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier.gonz@samsung.com>, Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Christoph Hellwig" <hch@lst.de>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <e4ea80be-f9fe-c02b-ee53-c78ed41ef444@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.179]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87r9akZJBovealmsvtvPZvH+4GNW
 i99nzzNbrFx9lMnib9c9Jovzbw8zWUw6dI3RYv6yp+wWNyY8ZbRYc/Mpi8W61+9ZHLg9ds66
 y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP3uZ3bB47W++zerQf6GYK4IzisklJzcksSy3S
 t0vgylh58jJzwSqWiiuTpjI1MK5k7mLk5JAQMJF4vecQaxcjF4eQwApGibPvtrJDOF8YJdY+
 /Q2V+cwosW3RUSaYlqd/WpggEssZJY5Ons4EV/Xs1jKolt2MEvvbL4K18ArYSVz8fIwRxGYR
 UJWYfb6DFSIuKHFy5hMWEFtUIELi5ZG/QPUcHMICyRIvr8eChJkFxCVuPZkPNkZEQE/i6q0b
 YPcxC+xkkTg48xkrSD2bgJZEYyc7SA0n0KpDTxawQ/RqSrRu/w1ly0tsfzsH6mllic6rj6C+
 qZVYe+wM2EwJgc2cElc/NrBBJFwk2t/3s0PYwhKvjm+BsmUk/u+czwTR0M8oMbXlD5Qzg1Gi
 5/BmsA8kBKwl+s7kQDQ4Sjw8cZkNIswnceOtIMRBfBKTtk1nnsCoOgspKGYh+XkWkh9mIflh
 ASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMDEdvrf8S87GJe/+qh3iJGJg/EQowQH
 s5II75kX+klCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUa
 mOrias8Z/MzueCRywPVb64w9H8K85916xxJuWjYr3JH9TnDi3/VOC6oPf/5jsvrCJKlVTWeK
 HXY8XllzzNpaO0WVaf6KZfwnmAWZHA121j950OijFjzJ+X7FGfkUcQbhJL/SeZn3RYq0p0cu
 /sDW+id5ZXDNe5MfZzcW2TfMubJ3xbRJnN0maw9+0X9yuM0oyY37BGe5if2MrkhDhjqZaJbq
 tVsmqrxrnnup3Hvztf+fjTmtn7J+TVix6d1Kv8hLJku7V/Ie6Srft477T+/dC94C7/IefKoI
 2/tn94qtZbP2Pdi5LmXBKu54i80eKfe8Lv6JlpFdb++y69GzmX/m/5hb+uV36VcNrQ+n9z45
 OnGyEktxRqKhFnNRcSIA30WpsNsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7r9akZJBlN3i1usvtvPZvH+4GNW
 i99nzzNbrFx9lMnib9c9Jovzbw8zWUw6dI3RYv6yp+wWNyY8ZbRYc/Mpi8W61+9ZHLg9ds66
 y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP3uZ3bB47W++zerQf6GYK4IzSsynKLy1JVcjI
 Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1h58jJzwSqWiiuTpjI1
 MK5k7mLk5JAQMJF4+qeFqYuRi0NIYCmjxN7fx5ggEjISn658ZIewhSX+XOtigyj6yCix7N0n
 dghnN6PEtkdPwUbxCthJXPx8jBHEZhFQlZh9voMVIi4ocXLmExYQW1QgQqJt2RSwemGBZIlV
 a8+ygdjMAuISt57MB9ssIqAncfXWDXaI+E4WiRcTQyCW3WOSmH9lN9ACDg42AS2Jxk6wGk6g
 vYeeLICq15Ro3f4bypaX2P52DtSbyhKdVx9BfVYr8er+bsYJjKKzkJw3C8kZs5CMmoVk1AJG
 llWMIqmlxbnpucWGesWJucWleel6yfm5mxiByWDbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd4z
 L/SThHhTEiurUovy44tKc1KLDzGaAsNoIrOUaHI+MB3llcQbmhmYGpqYWRqYWpoZK4nzehZ0
 JAoJpCeWpGanphakFsH0MXFwSjUwiSeLKM+0OKzMwn1H6cJynaZHr9YJfDmdoWya+3a9rXyn
 ebPfjxKNz1r1imZuoewFhp0v2p5vD+xdvPXAMsOTpzdJn5T5cfnY8m3btoRLJHkJzF1XkqWT
 vVP41P5dHJu+bJm1Jj7b5vPG7nsK22Yx5BkmJ724ViYqNJM30z/pGM+VNQu4Mysl3ibNMV3t
 4Zremia8/KmFjnRORkfUawNmcV27tydbtJ8t/3kh7L23QurqTyJ3zwh5h6qs6FN4c5Ll/hsP
 m7xNP/uP+37cwvzpWT3Tq1L9GUzqNsZmppsb669V+1j0CMx6O9nbgunn3Kf5rLnbzgSLxMee
 kFPS6StKueypGSaUKPOG5/FNtX9KLMUZiYZazEXFiQD9LwsjjwMAAA==
X-CMS-MailID: 20220316180359eucas1p22a908f93e9d7c642411bb87040161b56
X-Msg-Generator: CA
X-RootMTR: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
 <9498d380-0172-dae0-9354-bd4d725fff5c@nvidia.com>
 <6e19b134-3ba1-432f-092d-ea526f09ef35@nvidia.com>
 <093f80d1-580a-11c5-057f-a231ecf99bae@samsung.com>
 <e4ea80be-f9fe-c02b-ee53-c78ed41ef444@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_110401_824958_83A18AD8 
X-CRM114-Status: GOOD (  13.44  )
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



On 2022-03-16 17:50, Chaitanya Kulkarni wrote:
> On 3/16/22 03:21, Pankaj Raghav wrote:
> why are you bloating header file with the function that has no
> other caller ?
> 
>>>
>>> Is this function in the fast path ?
>>>
>> No, this is called during init.
> 
> I don't see any point of making it inline n bloating header file.
> 
Got it. I will open code it in the next version. I am still waiting for
Christoph to reply on the next proposed solution as this patch has other
issues as he pointed out in his reply.

-- 
Regards,
Pankaj

