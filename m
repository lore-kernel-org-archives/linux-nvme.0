Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A110C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jiI5Em5yN7LXCzd4BU0QPHZ2+BpULve8s7MVTfLpnpk=; b=uI/2hwMDoiCLLr
	dmv4wIYcXPcIpPDG0I0/w8eq+ADL3nBNH/WJqyitUzuA6Alz/uayUk/sF75KNxxbeW53fOvfwuh17
	BgntmJi1hJl11x7mjDXwXEI4IUiUazxzql4YYqPbDW/WR2tbl9daN+A80Z1EdG/u4uXK+BztiSP9C
	xrxTQzHpz5p/ax/97sGOuETCtLtEcvGTqaq6GGSXAI41WV1ekNXmCHmf4JuC6YiteUUGSGtHKpdZL
	tQ08oDzhG5DotGIV7XJc3HnZtYFsLdzHk2p2socHAXUQA3hWLR/DEUC92rQrTQ/A8CEprR4AOt7et
	dbYcyvKBdGDOvLgIZgzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU5NM-004JP7-Q4; Fri, 02 Sep 2022 12:02:20 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU5NG-004JI9-T7
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 12:02:19 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220902120207euoutp027ed74a178431538395fdcbfc25ec7e91~RCXMAtyx_3219432194euoutp029
	for <linux-nvme@lists.infradead.org>; Fri,  2 Sep 2022 12:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220902120207euoutp027ed74a178431538395fdcbfc25ec7e91~RCXMAtyx_3219432194euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662120127;
	bh=jiI5Em5yN7LXCzd4BU0QPHZ2+BpULve8s7MVTfLpnpk=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=CD9DpNIQSQKNTw/2R7CunR6t1+/v4Xwggx+98RtRQ7nOHRwlvPoBAeCh8ti0FMQP5
	 sRMBiuACDRXtWvRZ7v4PuZcz7CtKfGxyceo0xeUmsij+L4aFy2l9UKpKJk4vkaX3BY
	 WM6i9SZJWgJQSj/+NGVjU9eXjUGBPqB6nwmny4aw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220902120206eucas1p2718c2f0ddf87452f3dd1bf6349e92563~RCXLpFLBu3079630796eucas1p2Y;
	Fri,  2 Sep 2022 12:02:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0A.52.07817.EB0F1136; Fri,  2
	Sep 2022 13:02:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220902120206eucas1p1bff06c1bc60d068c2807bad75ce342f2~RCXLHFq-_3031230312eucas1p1R;
	Fri,  2 Sep 2022 12:02:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220902120206eusmtrp2bce39382a0e300c0c835ba79a2b355f1~RCXLGKl2C0333103331eusmtrp2D;
	Fri,  2 Sep 2022 12:02:06 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-78-6311f0bee919
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.24.07473.DB0F1136; Fri,  2
	Sep 2022 13:02:05 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220902120205eusmtip11c33df1e1d97a92b6e98a09492ea4d42~RCXK7TqlI3188931889eusmtip1z;
	Fri,  2 Sep 2022 12:02:05 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.27) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 2 Sep 2022 13:02:04 +0100
Message-ID: <96f90e1d-aa0f-1c76-bfc9-a87e978ad655@samsung.com>
Date: Fri, 2 Sep 2022 14:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Content-Language: en-US
To: Mike Snitzer <snitzer@redhat.com>
CC: <agk@redhat.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
	<damien.lemoal@opensource.wdc.com>, <hch@lst.de>, <pankydev8@gmail.com>,
	<Johannes.Thumshirn@wdc.com>, <linux-block@vger.kernel.org>,
	<dm-devel@redhat.com>, <hare@suse.de>, <jaegeuk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <matias.bjorling@wdc.com>,
	<gost.dev@samsung.com>, <bvanassche@acm.org>,
	<linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YxFOS8fq8AeE5mkf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.27]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87r7PggmG5zfIWux/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rsWTSJyWLl6qNMFk/Wz2K2+Nt1j8li7y1ti8u75rBZzF/2lN1i
	QttXZos1N5+yWJy4JW3RtvEro4OAx+Ur3h47Z91l97h8ttRj06pONo/NS+o9dt9sYPPY2Xqf
	1eP9vqtAodPVHp83yXm0H+hmCuCO4rJJSc3JLEst0rdL4Mr4saeNraCHs2JaS2ED4zr2LkZO
	DgkBE4klK2ezdDFycQgJrGCUmHhnCVhCSOALo8STAzIQ9mdGid6t/DANm/69ZYVoWM4oMfXM
	PEYIB6io8fpydghnJ6PEwcctrCAtvAJ2Ert3dLGA2CwCKhJrL79ngYgLSpyc+QTMFhWIlFiz
	+yzYamEBL4m5H/4ygdjMAuISt57MB7I5OEQEVCVuTXMBmc8sMJ1Z4tWMRewgcTYBLYnGTrBW
	TiDz+54dLBCtmhKt23+zQ9jyEtvfzmGG+EBJ4uSylUwQdq3E2mNnoEHxiFPiwr4yCNtFYtOD
	ZkYIW1ji1fEtUDUyEv93zofqrZZ4euM3M8g9EgItjBL9O9ezgdwjIWAt0XcmB6LGUeLm2+3s
	EGE+iRtvBSHO4ZOYtG068wRG1VlIATELycOzkHwwC8kHCxhZVjGKp5YW56anFhvlpZbrFSfm
	Fpfmpesl5+duYgSmwtP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeKceFkgW4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwOQScp/VeVXdxNqYvoCJjb51KnO8
	dndrTl2j9+xA2FbXhedvNGst3yDjvNFX4RdjzgOd3k6dI9zc8zwSszKVVzallzxv4jpmKf1X
	2eTZ7lShDbODAm6fzKnhOTsl6fj7CLZb6YLKvPcWt6dE38/aaapx8PGnG/4zC7/0pEjbvdpY
	uEhPd5/9hitMrC5KP7NW9vwP/Sdq+y5oruvh0EdyWtuCJ+pxlluEq55zWxJy4+2DSPW5wUyd
	BmXm5/hF7+x7dde9k63a8deEy/m95jpXiv8UHzu2wbMlQu9h14fLRctO+Oc/KjvX873hSmKP
	9LkVWzhYjvWVfShsLdwe+Zj17/3FXQEXPt89tu3Tq9VytkosxRmJhlrMRcWJACswvdv0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xu7p7PwgmGyxqsrZYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS32LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8Wam09ZLE7ckrZo2/iV0UHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
	6vF+31Wg0Olqj8+b5DzaD3QzBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
	mSrp29mkpOZklqUW6dsl6GX82NPGVtDDWTGtpbCBcR17FyMnh4SAicSmf29ZQWwhgaWMEgff
	6UHEZSQ+XfkIVSMs8edaF1sXIxdQzUdGiY9tZ1khnJ2MEoumb2QCqeIVsJPYvaOLBcRmEVCR
	WHv5PQtEXFDi5MwnYLaoQKTEw2VNYPXCAl4Scz/8BbOZBcQlbj2ZD2RzcIgIqErcmuYCMp9Z
	YDqzxKsZi9ghrrvHKLH3RxFIDZuAlkRjJ1iYE8j8vmcHC8QYTYnW7b/ZIWx5ie1v5zBDPKAk
	cXLZSiYIu1bi1f3djBMYRWchuW4WkitmIRk1C8moBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS
	83M3MQJTyLZjPzfvYJz36qPeIUYmDsZDjBIczEoivFMPCyQL8aYkVlalFuXHF5XmpBYfYjQF
	BtFEZinR5HxgEssriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCy
	aLXrmNTIfD896G5c0iXX/0Y24n48L2QOm1wMfGCiZBu26uhTBtvQE18/TpcXtC9wFHj7W/2F
	aUsX69tVTfOlNEPkKnvcu3b+TnaIef06bPoO6bP/rjnLfJ1wnO3+wu9zZr0yUUnl0l5b3RLx
	513cjllVh8PZFk3I2DhnyaLutveXK61Pv0yPW3L98JGKvLP22fOtS/P91vbH5Lbejgg/n/6W
	i0VW/Yy8u5ZLo+nM02GKhvs13bZ7lVWVHT2W6LXyY/tcbh+DY7vOGMy8+CJwy/SoN2FNM0ND
	K/5EPXCv/ZRx8+Lj56sfSF+rV7jO/XbGcusUJtOvBzimqXRvs/18r/K+ou1fhlsv3kXb93Yr
	sRRnJBpqMRcVJwIAHouRhqoDAAA=
X-CMS-MailID: 20220902120206eucas1p1bff06c1bc60d068c2807bad75ce342f2
X-Msg-Generator: CA
X-RootMTR: 20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b
References: <20220823121859.163903-1-p.raghav@samsung.com>
	<CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
	<20220823121859.163903-13-p.raghav@samsung.com>
	<YxFOS8fq8AeE5mkf@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_050216_178773_D7F582BA 
X-CRM114-Status: GOOD (  15.44  )
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

On 2022-09-02 02:28, Mike Snitzer wrote:
> On Tue, Aug 23 2022 at  8:18P -0400,
> Pankaj Raghav <p.raghav@samsung.com> wrote:
> 
>> Introduce a new target type DM_EMULATED_ZONES for targets with
>> a different number of sectors per zone (aka zone size) than the underlying
>> device zone size.
>>
>> This target type is introduced as the existing zoned targets assume
>> that the target and the underlying device have the same zone size.
>> The new target: dm-po2zone will use this new target
>> type as it emulates the zone boundary that is different from the
>> underlying zoned device.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> This patch's use of "target type" jargon isn't valid. 
> 
> Please say "target feature flag" and rename DM_EMULATED_ZONES to
> DM_TARGET_EMULATED_ZONES in the subject and header.
> Good catch. I will fix it up for the next version.
> But, with those fixed:
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> 
You mean <Reviewed-By> ? :)
> (fyi, I'll review patch 13, the dm-po2zone target, tomorrow)
> 
Thanks.

