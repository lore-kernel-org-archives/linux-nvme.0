Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C691ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xl8ekM/fCifrSNkWoYenlh6/74fFdGGQzaDtP7DiP5M=; b=fVaobK1DJqType
	VIZO6C3Havh9Gr4iBPVes7iNoL4aUNn15bTU3GHE/7ssTj8uJox/wkPa0pJrqv4Judpc9tE4sBK8t
	8ivhr96f5CgV7eL3R/wajcyqYLpHf/XqGME4qxi6SomSkt9gJe0rWa+sDSyhsKsrMlCByuWDHeTGl
	ihytIY5jV2HSH0vDvDKcZaqwvVoKB/tFqDccLDzxJdT+VOPq7KhHer/uVi+LLFOC3CdgA9ey1xXzp
	ddoyyAefQ11BimAtciRAorxyi/lrjG+5N/eyEX1lP8k3j72UCVddfqE/ETNm04uGBsOsM4Kl2s6Is
	9IFFiStQb32yTf+LX72A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSy8m-00G1Ra-Db; Tue, 30 Aug 2022 10:06:40 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSy6M-00G0DN-Da
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 10:04:12 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220830100359euoutp016e00d82ea3f201f42db8b1569adf9c08~QF0MKaAS_1328413284euoutp01g
	for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 10:03:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220830100359euoutp016e00d82ea3f201f42db8b1569adf9c08~QF0MKaAS_1328413284euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1661853839;
	bh=Xl8ekM/fCifrSNkWoYenlh6/74fFdGGQzaDtP7DiP5M=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=Au13TcQx81hWxTjrLLu/B7nxkHvFmLEKWmZY6TaQMDjpJ4dO9Oc5tjRHErF7yHrmg
	 D4heSoPu2GQNdMCCu2fWLJM+23pnAim4ireIrGytQRFdW6YDBOeLmyB6Q+97G+O5DF
	 kBKH/FtDmAW17Y0MtdIJJGC8HkhFubXE3PH+BpF8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220830100358eucas1p2af1fbb0a82c2821242d06ca0e134bd5a~QF0L4lhMD2247422474eucas1p2x;
	Tue, 30 Aug 2022 10:03:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.A0.19378.E80ED036; Tue, 30
	Aug 2022 11:03:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220830100358eucas1p2f02eaa55af0113c1aee6ea579f549c33~QF0LXQAhH2046320463eucas1p2I;
	Tue, 30 Aug 2022 10:03:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220830100358eusmtrp12349e828db7354d492bbd6755edd86a9~QF0LWbizQ1029210292eusmtrp1X;
	Tue, 30 Aug 2022 10:03:58 +0000 (GMT)
X-AuditID: cbfec7f5-fc0a2a8000014bb2-28-630de08e0b56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.34.07473.E80ED036; Tue, 30
	Aug 2022 11:03:58 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220830100358eusmtip1348cb269f1db821d6093c62dedd1c9ac~QF0LLi4Be0117901179eusmtip1C;
	Tue, 30 Aug 2022 10:03:58 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.27) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 30 Aug 2022 11:03:56 +0100
Message-ID: <ea7e7c1c-b47a-6c3a-edce-502b58cc440e@samsung.com>
Date: Tue, 30 Aug 2022 12:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
	"hch@lst.de" <hch@lst.de>, "pankydev8@gmail.com" <pankydev8@gmail.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>, "hare@suse.de" <hare@suse.de>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
	<Matias.Bjorling@wdc.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Damien Le Moal <Damien.LeMoal@wdc.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220830025235.vesnxh6xw6j2vvsu@shindev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.27]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djPc7p9D3iTDT42GlmsP3WM2WL13X42
	i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
	nrJbTGj7ymyx5uZTFot9szwtTtySdhD0uHzF22PnrLvsHpfPlnpsWtXJ5rF5Sb3H7psNbB47
	W++zerzfdxUodLra4/MmOY/2A91MAdxRXDYpqTmZZalF+nYJXBnvOrczFezkrWhZu5+1gfEJ
	VxcjJ4eEgIlE29qXzF2MXBxCAisYJa4tnMkG4XxhlHi/+CCU85lR4ujSVkaYlsZnx6FaljNK
	LFy3mwWu6vLGm0wQzi5GiZ8fX4O18ArYSRxceZ4FxGYRUJU4N/8LC0RcUOLkzCdgtqhApMSa
	3WfZQWxhgWyJpX3HwWxmAXGJW0/mM4HYIgKmEk+2bGGCiO9nk/i327OLkYODTUBLorETrJxT
	wEzi5sN2qFZNidbtv6FseYntb+cwQ3ygJHFy2UomCLtWYu2xM+wgN0sIPOOU6Dp/nQUi4SIx
	p+E5VJGwxKvjW9ghbBmJ05N7oGqqJZ7e+M0M0dzCKNG/cz0byEESAtYSfWdyIGocJfYvOM8M
	EeaTuPFWEOIePolJ26YzT2BUnYUUErOQfDwLyQuzkLywgJFlFaN4amlxbnpqsXFearlecWJu
	cWleul5yfu4mRmBqPP3v+NcdjCtefdQ7xMjEwXiIUYKDWUmE9/s5nmQh3pTEyqrUovz4otKc
	1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTKKmzKk+hXePWs+zerf+sYsZp2lY
	wvWArn/Kh7d8nd9oJJFeclHwe/TZ6N1aUysEbl9befHW/h1LZ6Vt4nhtyaW8kcdqw0v2ntlG
	T29sPHZs/5yMT8mcvdKPBOc/iPZzk65hmyz11VH74N4zFya9WDBP54Hc0+t2E57ZV8oor84P
	vHW4XuZp1+bLR/vdNQO6s1pPGd7q81uR9tD4yd/8ubfn7fpwbdGeGwkP1K3TZA7wpbxzDBYQ
	Fji+86BFSSbDZW/x9Usa5204rC4kYu3C4D1D/vmZlxovJwrMuaCked/5YITYpl7eXSpFlwIC
	T9VHNLOGZaisjxUuuG4eZzB56rpn9w7cYFzBaNK1TyjR56YSS3FGoqEWc1FxIgDPdhDe/AMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xu7p9D3iTDXo2ClisP3WM2WL13X42
	i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
	nrJbTGj7ymyx5uZTFot9szwtTtySdhD0uHzF22PnrLvsHpfPlnpsWtXJ5rF5Sb3H7psNbB47
	W++zerzfdxUodLra4/MmOY/2A91MAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehnvOrczFezkrWhZu5+1gfEJVxcjJ4eEgIlE47PjzF2MXBxC
	AksZJVZ2/GODSMhIfLrykR3CFpb4c62LDaLoI6NEw68dUM4uRolLT/aCdfAK2EkcXHmeBcRm
	EVCVODf/CwtEXFDi5MwnYLaoQKTEw2VNTCC2sEC2xNK+42AbmAXEJW49mQ8WFxEwlXiyZQsT
	RHw/m8S/3Z4Qy94wSkxYvghoEAcHm4CWRGMnWC+ngJnEzYftUHM0JVq3/4ay5SW2v53DDPGB
	ksTJZSuZIOxaiVf3dzNOYBSdheS8WUjOmIVk1CwkoxYwsqxiFEktLc5Nzy021CtOzC0uzUvX
	S87P3cQITCjbjv3cvINx3quPeocYmTgYDzFKcDArifB+P8eTLMSbklhZlVqUH19UmpNafIjR
	FBhGE5mlRJPzgSktryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
	ycnpYjXXwqPTnwjvWO+3z3XTQ9stV6ZXR54Jf/70Eutf/bju1bHWx1VTLjaJxS5Zo2Q5v3DN
	+7mRwR4zlT5GtE8/0c4WP9/GdWZT1K7X/Xv2vJM5G/3o/9nY78s89YVS94hu8FF/7jb/yamt
	V2akqbyYXSaWzfdBaoeU8/yHhmnvLKatZ7k299zieIvHinv5e7ewLFTd4h7H29qWUbBHeSrL
	4V91j7J9j9b/DjrgNc25fseefyJa6QvitJQ4t+ad89pXeehsKUegiEvz1avlDledfp2VuvB7
	2dKiPan/lN77W+7QrmyeszE8KY0x4venFpvIiww2Dtnmk6y/qU53npGlce50xr6iWdtb783X
	CVBiKc5INNRiLipOBAA2RNjKsQMAAA==
X-CMS-MailID: 20220830100358eucas1p2f02eaa55af0113c1aee6ea579f549c33
X-Msg-Generator: CA
X-RootMTR: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
References: <20220823121859.163903-1-p.raghav@samsung.com>
	<CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
	<20220823121859.163903-14-p.raghav@samsung.com>
	<20220830025235.vesnxh6xw6j2vvsu@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_030411_037286_E6C7005F 
X-CRM114-Status: GOOD (  17.01  )
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

On 2022-08-30 04:52, Shinichiro Kawasaki wrote:
> On Aug 23, 2022 / 14:18, Pankaj Raghav wrote:
>> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
>> size) were supported in linux but now non power-of-2(npo2) zone sizes
>> support has been added to the block layer.
>>
>> Filesystems such as F2FS and btrfs have support for zoned devices with
>> po2 zone size assumption. Before adding native support for npo2 zone
>> sizes, it was suggested to create a dm target for npo2 zone size device to
>> appear as a po2 zone size target so that file systems can initially
>> work without any explicit changes by using this target.
> 
> FYI, with this patch series, I created the new dm target and ran blktests zbd
> group for it. And I observed zbd/007 test case failure (other test cases
> passed). The test checks sector mapping of zoned dm-linear, dm-flakey and dm-
> crypt. Some changes in the test case look required to handle the new target.
> 
Thanks for testing it. I am aware of this test case, and I skipped it while
I was testing my target.

The test needs to be adapted as the container's start, and the logical
device's start will be different for this target.

I initially thought this test case might not apply to the dm-po2zone
target, but at a closer look, it is helpful once the zone offset is adapted
while doing a reset and writing data as the test only verifies the relative
WP position.

I also noticed that this test relies on getting the underlying device id
using `dmsetup table` command. The target currently lacks the `.status`
callback which appends the device id details. I will add them as a part of
the next revision for this target. Thanks.

