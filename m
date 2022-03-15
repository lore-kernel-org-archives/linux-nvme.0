Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83937C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WeT2OiKjyRSR+torxX2JuAR/sqg/VT5hyO6yN4/AqXg=; b=oYa1W1yihweu3c
	jYTwafr3G9KSEotwmNpp6VXyKVNBW2J70JTntyftvyOMMiGDKS0qZDqL+Cp6DKHIoSNTUC9LpfLi0
	AglzqkHKlPIEFvCbJ36P3uQ14h9nGcK8whVo+z3THls0xzVP0bVaDzUplBLqXCLse0WXtvwfKaBRT
	clMmFjZ3g4zycYo1lBDhjXvtFSdfYVwatepgE64IutLS6kPeFSJ/1mG33HIZMzLmlNvIAfOWg1/3t
	Vb66RqpifU+erdvGzzmlq4FAsStfJSjkTcObIULbWze7f7PmhgUH90L1SMXDJn1HIUBcvlH/Pamnp
	ntbP3S1XwmDXGNdoiKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUDHl-00AVVX-LZ; Tue, 15 Mar 2022 19:56:49 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUDHh-00AVUA-EM
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 19:56:47 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220315195641euoutp02a87af5636cff73630c613388d584e73c~cphutikRs1310513105euoutp024
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 19:56:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220315195641euoutp02a87af5636cff73630c613388d584e73c~cphutikRs1310513105euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647374201;
 bh=WeT2OiKjyRSR+torxX2JuAR/sqg/VT5hyO6yN4/AqXg=;
 h=Date:Subject:To:From:In-Reply-To:References:From;
 b=iU5jt6btCVWddDBCczfngauafMCuIuNZqfb8/bPkKE/LDMu5S6hllwKzApWkm8U3q
 KOz373SHjHNl9wbFukpgIGI4QPVqQfoWsctVpeWG/xyM2+6eCIpFgcfeOMxSdrlVdm
 5kSp/l2WEVUg37zK9TPncQ2QRD4BlTYL3MG2O65Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220315195640eucas1p15195bbcf50efff97649295304cabe7fe~cphtr4mHw2468824688eucas1p1-;
 Tue, 15 Mar 2022 19:56:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B4.F0.10260.87FE0326; Tue, 15
 Mar 2022 19:56:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220315195639eucas1p28b1204d5dcfc5c5ff7f219bd142af606~cphsdG_j30266502665eucas1p2Z;
 Tue, 15 Mar 2022 19:56:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220315195639eusmtrp21349e4ca5f824e0a0aee399cd64bbf1b~cphscTnaW3175731757eusmtrp21;
 Tue, 15 Mar 2022 19:56:39 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-96-6230ef786b00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.F0.09522.67FE0326; Tue, 15
 Mar 2022 19:56:38 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220315195638eusmtip1537eeac3e9a448034a01b420608041db~cphsQsqlU0430704307eusmtip1A;
 Tue, 15 Mar 2022 19:56:38 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 15 Mar 2022 19:56:36 +0000
Message-ID: <bc4764d4-0532-6dac-fb4c-7325c0f3c626@samsung.com>
Date: Tue, 15 Mar 2022 20:56:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: <dsterba@suse.cz>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>, Christoph Hellwig
 <hch@lst.de>, =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, "jiangbo.365@bytedance.com"
 <jiangbo.365@bytedance.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220315142740.GU12643@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7djP87oV7w2SDF71CFqsvtvPZvH77Hlm
 i8W/v7NYrFx9lMmi8/QFJoueAx9YLP523WOyOP/2MJPFpEPXGC323tK2uPR4BbvF/GVP2S0m
 tH1ltrgx4SmjxZqbT1ks1r1+z+Ig4PHvxBo2j52z7rJ7nL+3kcWjecEdFo/LZ0s9Nq3qZPPY
 vKTeY/fNBqCC1vusHmcWHGH3+LxJzqP9QDdTAE8Ul01Kak5mWWqRvl0CV8b27i1sBR95K1o/
 nmRuYOzg7mLk5JAQMJH49ekhWxcjF4eQwApGifM3/jBCOF8YJe5PbYFyPjNKTH+6kw2mpWHF
 JajEckaJtdsuMIIkwKquNqhBJHYzSkzaeo4JJMErYCex4MR0sCIWAVWJnk+T2SHighInZz5h
 AbFFBSIkXh75C1YvLOAl0fF2LVgNs4C4xK0n85lAhooIHGCTWLFvNVCCg4NNQEuisRPM5BQw
 ljh7JxaiXFOidftvqFZ5ie1v5zCDlEgIKEu8Xm8DcX+txNpjZ9hBJkoIvOKUuHrwNyNEwkVi
 +ccF7BC2sMSr41ugbBmJ/zshTpAQ6GeUmNryB8qZwSjRc3gzE8QGa4m+MzkQDY4SfWubWCDC
 fBI33gpC3MMnMWnbdKh7eCU62oQmMKrMQgqIWUgenoXkm1lIvlnAyLKKUTy1tDg3PbXYOC+1
 XK84Mbe4NC9dLzk/dxMjMD2e/nf86w7GFa8+6h1iZOJgPMQowcGsJMJ75oV+khBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYmnuSPbjxPC59u+qb4ZHnh
 /6oGa0Ov9Ud8z5tpy00UydTj0j3qKDYvyN9h/4/nXN3lbR0C29ifsbAov2X49213tGCBitTW
 vOp67ZhI56I1814sDiiYyNzCMPHLZRZGq1WcShJvmzS1/cx2MMjPTYw8rWtlf2jDUf9D7KLd
 ItFz1qSE7ZRi+m8VGrjBafpioU++U9i+pzYms0uXLfRbfOu6x0/5G/Z93ZdShI8+ZrFnev2X
 pbRtOqeZoEffydvLvXx9NOQd1/Eotaz5WzZ1L09ofFx9slWE8bPzsX0q1//Z/L7QGlSg8q/b
 bI7/h8gHF7Xcgtjen0g/o8f0JYlF6cw7783rvkv984nWk9hxV4mlOCPRUIu5qDgRANMNwYn+
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7pl7w2SDHa8t7ZYfbefzeL32fPM
 Fot/f2exWLn6KJNF5+kLTBY9Bz6wWPztusdkcf7tYSaLSYeuMVrsvaVtcenxCnaL+cuesltM
 aPvKbHFjwlNGizU3n7JYrHv9nsVBwOPfiTVsHjtn3WX3OH9vI4tH84I7LB6Xz5Z6bFrVyeax
 eUm9x+6bDUAFrfdZPc4sOMLu8XmTnEf7gW6mAJ4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
 E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzt3VvYCj7yVrR+PMncwNjB3cXIySEhYCLRsOIS
 YxcjF4eQwFJGiUuLzzBBJGQkPl35yA5hC0v8udbFBlH0kVFi4ZzFYAkhgd2MEn83FIDYvAJ2
 EgtOTGcEsVkEVCV6Pk1mh4gLSpyc+YQFxBYViJBoWzaFGcQWFvCS6Hi7FqyGWUBc4taT+Uwg
 C0QEDrBJrNi3mh1i2wtWicM/2oG6OTjYBLQkGjvZQUxOAWOJs3diIXo1JVq3/4aaIy+x/e0c
 ZpASCQFlidfrbSDur5V4dX834wRGkVlILpqFZPMsJJNmIZm0gJFlFaNIamlxbnpusaFecWJu
 cWleul5yfu4mRmDy2Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE98wL/SQh3pTEyqrUovz4otKc
 1OJDjKbAYJnILCWanA9MX3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1M
 HJxSDUyy3cUm+nXFFx7an/p3iIPJvXje3nlz2kSnrj9t9mwnn3nFhfKHs5J1bYQDv7fnxZ3s
 cjr/xSnnz/o8r+ksX7fcvHPfP+iRsEtSV2yb3Gfxj09XhovPyd56sGuKAd+Pv0vvH7y2Iszw
 bfCDQ/cTn9l2BnGkTX8y+2fZ6lU/jplaRzPNW244feosPRNFmZMJT2fN5Go/7bHRzipcSP7l
 doXtCVN33lTRCrKb3cR4oaB04SoRr79im65FG1v/+nugg/llzuGJV448mpsjFfh+SlVCUV+p
 UkPsXNOVTaFP2tVjI/9KSWSmTsq7q/P8hVroW4ObzfO/Rkf/2j9pec7euYW+emcrs7VEay+s
 VDhrePChEktxRqKhFnNRcSIAy6dyvacDAAA=
X-CMS-MailID: 20220315195639eucas1p28b1204d5dcfc5c5ff7f219bd142af606
X-Msg-Generator: CA
X-RootMTR: 20220315143148eucas1p157359f025cb46f8099385b48400bc638
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220315143148eucas1p157359f025cb46f8099385b48400bc638
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
 <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20220315143148eucas1p157359f025cb46f8099385b48400bc638@eucas1p1.samsung.com>
 <20220315142740.GU12643@twin.jikos.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_125645_859720_10F546D9 
X-CRM114-Status: GOOD (  21.84  )
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

Hi David,

On 2022-03-15 15:27, David Sterba wrote:
> 
> PO2 is really easy to work with and I guess allocation on the physical
> device could also benefit from that, I'm still puzzled why the NPO2 is
> even proposed.
> 
Quick recap:
Hardware NAND cannot naturally align to po2 zone sizes which led to
having a zone cap and zone size, where, zone cap is the actually storage
available in a zone. The main proposal is to remove the po2 constraint
to get rid of this LBA holes (generally speaking). That is why this
whole effort was started.

> We can possibly hide the calculations behind some API so I hope in the
> end it should be bearable. The size of block groups is flexible we only
> want some reasonable alignment.
>
I agree. I already replied to Johannes on what it might look like.
Reiterating here again, the reasonable alignment I was thinking while I
was doing a POC for btrfs with npo2 zone size is the minimum stripe size
that is required by btrfs (64K) to reduce the impact of this change on
the zoned support in btrfs.

> I haven't read the whole thread yet, my impression is that some hardware
> is deliberately breaking existing assumptions about zoned devices and in
> turn breaking btrfs support. I hope I'm wrong on that or at least that
> it's possible to work around it.
Based on the POC we did internally, it is definitely possible to support
it in btrfs. And making this change will not break the existing btrfs
support for zoned devices. Naive approach to making this change will
have some performance impact as we will be changing the po2 calculations
from log & shifts to division, multiplications. I definitely think we
can optimize it to minimize the impact on the existing deployments.

-- 
Regards,
Pankaj

