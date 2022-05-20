Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B08C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWcmjHxVvCkOxG1z+lqRA9bprQ9RJiXcv6vgQCSVJso=; b=FkJeGvF6X+eqB/BDGsxU5PFjjl
	JEEuYiPX/afDo3scGx2eO/QOmrQxmQCGr0/0uML/Ey8YRlu66dCsBkogkUSOZDR8YXum+UqZONSin
	o3vIQ+Qf+I4amXiHW8JOtQzG0tB0Ce7J1R5Ec/ot66uA917bOhsgtDj0ovuGLC/acjvYIQr+F2P7a
	lPPfS8LEfqKD9Z1EvY7pMLXkZ/k7o5JkgavzhouXrXgHFq0jo4/Wt9u+fF8sA3b8pfplJcBdfyIF6
	DxxE3jOjZRGsoL9V7oeij+KfXxxQs79ZIHM2NP8fRqBavoRqy/1h+etyXFng5Iw74IInXFZcZic8/
	EuElxc6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrw6l-00Alb3-KO; Fri, 20 May 2022 06:27:31 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrw6h-00AlZH-Qz
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 06:27:29 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220520062724euoutp01bb7f02cfb5c899789dcf9db233243181~wvD_P7S5N3126031260euoutp01y
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 06:27:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220520062724euoutp01bb7f02cfb5c899789dcf9db233243181~wvD_P7S5N3126031260euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653028044;
 bh=NWcmjHxVvCkOxG1z+lqRA9bprQ9RJiXcv6vgQCSVJso=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=ZFy/4xVl3d3hjX0Z/G9HEvtfxQflLB02JHHJfq4i8Gm4jV6OlFSWAnQXo5zCtiwdP
 HmAGlJsF/MOxE7W1TQyHEtURCMu28pARFdHKn0tJ9L4VXqh4Ebf878pPcMnV6Zzbfa
 iXC6KtuFS/Z6MQcBxleS54Rq7SxzOw2f/YXOwqhY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220520062724eucas1p214361a79ca87b367183b71a01e2378ee~wvD_AVEY92215422154eucas1p2P;
 Fri, 20 May 2022 06:27:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 97.F3.10260.CC437826; Fri, 20
 May 2022 07:27:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220520062723eucas1p240797e3e285a45576201cf785e92a677~wvD9oan6J1329813298eucas1p2g;
 Fri, 20 May 2022 06:27:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220520062723eusmtrp2fe5220a95ad3bee610b372f5fe699a3b~wvD9njb0S2573125731eusmtrp2f;
 Fri, 20 May 2022 06:27:23 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-7e-628734cc74ea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.62.09522.BC437826; Fri, 20
 May 2022 07:27:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520062723eusmtip1533e0c66af30c7e4b73d513c38052c01~wvD9dFNwx1838918389eusmtip1j;
 Fri, 20 May 2022 06:27:23 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 20 May 2022 07:27:21 +0100
Date: Fri, 20 May 2022 08:27:20 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Hannes Reinecke <hare@suse.de>
CC: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>, Pankaj
 Raghav <p.raghav@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>, "gost.dev@samsung.com"
 <gost.dev@samsung.com>, "jiangbo.365@bytedance.com"
 <jiangbo.365@bytedance.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Jaegeuk Kim
 <jaegeuk@kernel.org>
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7pnTNqTDFovs1isvtvPZvH77Hlm
 i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uPR4BbvFnr0nWSwu
 75rDZjF/2VN2ixsTnjJarLn5lMWitecnu4Ogx78Ta9g8ds66y+5x+Wypx6ZVnWwem5fUe+y+
 2cDm0XTmKLPHztb7rB7v911l81i/5SqLx+bT1R6fN8l5tB/oZgrgjeKySUnNySxLLdK3S+DK
 uPf0IXPBO5GK9+27WRoYvwp0MXJySAiYSGx+95cNxBYSWMEocXteXhcjF5D9hVHiwc17zBCJ
 z4wSh5ZbdTFygDXcvSgCUbOcUeLblV/MEA5QzcH599ggnK2MEldfXwQbyyKgKtGz8gkTiM0m
 YC9xadktsKkiAkoSH9sPsYM0MAv8YpO43f4ArEFYwF9i4q47YDavgIvEmbVnmSBsQYmTM5+w
 gNjMAlYSnR+aWEFOYhaQllj+jwMkzClgLdGy6xkLxKXKEsun+0J8WSux9tgZsFUSAs84JTZ1
 fWKCSLhI7Pp1iRHCFpZ4dXwLO4QtI/F/53yommyJi2e6mSHsEonF748xQ8y3lug7kwMRdpRo
 v7WXHSLMJ3HjrSDEkXwSk7ZNh6rmlehoE4KoVpPY0bSVcQKj8iwkb81C8tYshLcWMDKvYhRP
 LS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEyIp/8d/7qDccWrj3qHGJk4GA8xSnAwK4nwMua2
 JAnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQWgSTZeLglGpgWhM0hfv2
 /LULZOclTI2XckvavO3etZebVBW2LHC6rK+2fI/17Z7fOhcqwnfbTb1yMa5BQWi9R2z21pNu
 Z0TNIkNf3VWfG7bX/ZB/g+jHgo2nbtvvEbjSz7uiRczla3+02+ZKtT/1StNXrtkjvWPG70rr
 lCU9rlvfzvn2ZfWGu8sur+//wnXp3KQfag5TPWvz6012ME1u9Lt6tzt/sfea6GpVxzW73p3v
 4d+ss1j/16+CqUt18xcdPRLyZFltVlOsmbP8i5dJnz+mLOHV5NfMCpf4+2GT6Oc1B4x3Z5Zq
 NQnufKq27OjhHq2nnBXPklceFVBYlRVyJOy6wfLuuzHZ8UY3+jy1LlpxBPCb3BO5JK/EUpyR
 aKjFXFScCACm8OgY9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Xd3TJu1JBjvXaFqsvtvPZvH77Hlm
 i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uPR4BbvFnr0nWSwu
 75rDZjF/2VN2ixsTnjJarLn5lMWitecnu4Ogx78Ta9g8ds66y+5x+Wypx6ZVnWwem5fUe+y+
 2cDm0XTmKLPHztb7rB7v911l81i/5SqLx+bT1R6fN8l5tB/oZgrgjdKzKcovLUlVyMgvLrFV
 ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuPf0IXPBO5GK9+27WRoYvwp0
 MXJwSAiYSNy9KNLFyMUhJLCUUeJCw03GLkZOoLiMxKcrH9khbGGJP9e62CCKPjJKPJv/hRHC
 2cooce9/JytIFYuAqkTPyidMIDabgL3EpWW3mEFsEQEliY/th9hBGpgFfrBJ/Dt6EmyFsICv
 xNUpb1hAbF4BF4kza88yQUzdxCKx4PlnZoiEoMTJmU/AipgFLCRmzj/PCHI3s4C0xPJ/HCBh
 TgFriZZdz1gg3lGWWD7dF+LqWolX93czTmAUnoVk0Cwkg2YhDFrAyLyKUSS1tDg3PbfYUK84
 Mbe4NC9dLzk/dxMjMD1sO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMLLmNuSJMSbklhZlVqUH19U
 mpNafIjRFBgUE5mlRJPzgQkqryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQim
 j4mDU6qBiWXvbkvfKLFr03W+iKazKzXfOTdPsigvpem9dYSrpdqe1EVffCbWeApb/sm37pa+
 5T8pROjmh/a+6LUiV7+FmnUHbfd9rd69hSWSMX3t9V8T12xNXe7Dvzv/38XnFs3sDxlUUqdl
 z+zwcntixHDjq8PC+TW2NYEWf1n4beQzwxjsfFP4Q6SS0icwfH0xz5U7X1SosivVsu1xQe7+
 Sgf+J5LvV0XYfrQRSvrh93K7gGNW+uPpQf/m3zGoXOTUbHTRJi206tr6kwfffJTxWWgf6CPx
 SJxjikOv6YQD/8WtXllmC5VyGdZ9V5Y9s09B6uh6ReGsO9nKMSIH57J/si3/uW+3201jH9Y0
 hv7iCCWW4oxEQy3mouJEAIId+h+YAwAA
X-CMS-MailID: 20220520062723eucas1p240797e3e285a45576201cf785e92a677
X-Msg-Generator: CA
X-RootMTR: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
 <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_232728_346652_81C68ACA 
X-CRM114-Status: GOOD (  18.58  )
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

On 20.05.2022 08:07, Hannes Reinecke wrote:
>On 5/19/22 20:47, Damien Le Moal wrote:
>>On 5/19/22 16:34, Johannes Thumshirn wrote:
>>>On 19/05/2022 05:19, Damien Le Moal wrote:
>>>>On 5/19/22 12:12, Luis Chamberlain wrote:
>>>>>On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>>>>On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>>>>On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>>>>>>I'm a little surprised about all this activity.
>>>>>>>>
>>>>>>>>I though the conclusion at LSF/MM was that for Linux itself there
>>>>>>>>is very little benefit in supporting this scheme.  It will massively
>>>>>>>>fragment the supported based of devices and applications, while only
>>>>>>>>having the benefit of supporting some Samsung legacy devices.
>>>>>>>
>>>>>>>FWIW,
>>>>>>>
>>>>>>>That wasn't my impression from that LSF/MM session, but once the
>>>>>>>videos become available, folks can decide for themselves.
>>>>>>
>>>>>>There was no real discussion about zone size constraint on the zone
>>>>>>storage BoF. Many discussions happened in the hallway track though.
>>>>>
>>>>>Right so no direct clear blockers mentioned at all during the BoF.
>>>>
>>>>Nor any clear OK.
>>>
>>>So what about creating a device-mapper target, that's taking npo2 drives and
>>>makes them po2 drives for the FS layers? It will be very similar code to
>>>dm-linear.
>>
>>+1
>>
>>This will simplify the support for FSes, at least for the initial drop (if
>>accepted).
>>
>>And more importantly, this will also allow addressing any potential
>>problem with user space breaking because of the non power of 2 zone size.
>>
>Seconded (or maybe thirded).
>
>The changes to support npo2 in the block layer are pretty simple, and 
>really I don't have an issue with those.
>Then adding a device-mapper target transforming npo2 drives in po2 
>block devices should be pretty trivial.
>
>And once that is in you can start arguing with the the FS folks on 
>whether to implement it natively.
>

So you are suggesting adding support for !PO2 in the block layer and
then a dm to present the device as a PO2 to the FS? This at least
addresses the hole issue for raw zoned block devices, so it can be a
first step.

This said, it seems to me that the changes to the FS are not being a
real issue. In fact, we are exposing some bugs while we generalize the
zone size support.

Could you point out what the challenges in btrfs are in the current
patches, that it makes sense to add an extra dm layer?

Note that for F2FS there is no blocker. Jaegeuk picked the initial
patches, and he agreed to add native support.

