Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533C2ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0NOo6f/pWYXuPoQFfjEOXBVE2XC8pCS60UOPZi9RzHU=; b=u/3wFQka3S4kyK
	+kWSh2qLtLzi4BT1yUqdpVfghZXyh40HbOViBThMsbpQoilKFaX+Mfg0EHqQWxABIxshcyUsGFbvf
	cyZgOlTnBCb6135n3pHKar0wifaGXy1j74jC+R5kIk668vGt3woXN/L7h0cEvS+BUvCDrMnRzhQOD
	J0pTx3IIn/h1p2fs25c5NzEx2AtAypl0ZnGagAMlsoxLNrqRXtbn5cjTGFMViazdAp/mJ8t7pHp9z
	eJ07wBtSmiNckIHls3n9x1JjuUOdqWoIgyUrRq8u+jbw3fH+Z0jFm8rF4+6q07pdJByv1H6NF9kx2
	FPvPOealcwv1SLZpomSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFcd-007JHw-VS; Mon, 05 Sep 2022 17:10:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDLJ-004ff0-0K
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 14:44:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:CC:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0NOo6f/pWYXuPoQFfjEOXBVE2XC8pCS60UOPZi9RzHU=; b=rGINjvmmQRJ+KYQ1XC/4P2sanE
	64Md4+SCs9BXRdsO2yfgvAhygYp/s9GxL7V4cGWklGNuwLp2iDRtUrO3GBN1gRJT2XMSKNhPqQmpg
	R7qx2aKRT7zleAqXuOB4zA8t23v5RKBPhv7l0fN8nPvOXqtZwiHMk+JRaNrxWpLoVM9cvMKJTslW6
	oMhmahSwEcya6ZeUfIYtPpbmJ7D9ABLTDQ9KXs+L64A8rifJ3n05sbKqGyCjZnr8rwnNm/uf4t5Q7
	IVaTjnLh9/M00oHmshRKPe/ZAaXZeaSUR+xdhNpx0Qh6PyAS2jG922WT7OXlkOc3SRVx4lUqRl5BJ
	AMK2Ryhg==;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVBfW-009dPJ-Um
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 12:57:41 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220905125712euoutp01a94193f15682c819b94214de2ec61f39~R_DJEMlsd0215402154euoutp012
	for <linux-nvme@lists.infradead.org>; Mon,  5 Sep 2022 12:57:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220905125712euoutp01a94193f15682c819b94214de2ec61f39~R_DJEMlsd0215402154euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662382632;
	bh=0NOo6f/pWYXuPoQFfjEOXBVE2XC8pCS60UOPZi9RzHU=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=VTfLqQvnkmQR5jnpxyrRplAXQzJpGY8cEDC/VxPF/ss42i1A7e0JnZRIXZvwMQ2v3
	 ltdgnBK7WdI7alhCoTIFjESpbRG4uLLXLct07aorwkeD7hiLOFohDIIbAGGYEtCAJJ
	 UFupAHtS1qJFBqYF9+xkpG0gRXNC35Rbr4GoFXxw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220905125712eucas1p27c789651a573fe2b0f6774b0a5c7889f~R_DI2eCzV1056610566eucas1p2j;
	Mon,  5 Sep 2022 12:57:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.2C.19378.722F5136; Mon,  5
	Sep 2022 13:57:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220905125711eucas1p12e53a64104034b1a8dca6ada0a79cf94~R_DIcHdgG1238212382eucas1p1v;
	Mon,  5 Sep 2022 12:57:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220905125711eusmtrp20c331e84f5a49de8bce1b5aa4250139d~R_DIbOf650766107661eusmtrp2u;
	Mon,  5 Sep 2022 12:57:11 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-e1-6315f2279068
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.CB.10862.722F5136; Mon,  5
	Sep 2022 13:57:11 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220905125711eusmtip19aba6d939273cea0e9076ccec1896a95~R_DILN56f3006530065eusmtip1b;
	Mon,  5 Sep 2022 12:57:11 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 5 Sep 2022 13:57:10 +0100
Message-ID: <67726654-2c13-2c41-c002-30dc99db8497@samsung.com>
Date: Mon, 5 Sep 2022 14:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To: Mike Snitzer <snitzer@redhat.com>
CC: <agk@redhat.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
	<damien.lemoal@opensource.wdc.com>, <hch@lst.de>, Damien Le Moal
	<damien.lemoal@wdc.com>, <bvanassche@acm.org>, <pankydev8@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	<linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
	<gost.dev@samsung.com>, <jaegeuk@kernel.org>, <matias.bjorling@wdc.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YxJwd7xcZRdznsYz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87rqn0STDbattbRYf+oYs8Xqu/1s
	FtM+/GS2+H32PLNFa/s3Jou972azWqxcfZTJ4sn6WcwWf7vuAcVuaVtc3jWHzWL+sqfsFhPa
	vjJbrLn5lMXixC1pi7aNXxkdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
	7/ddZfP4vEnOo/1AN1MAVxSXTUpqTmZZapG+XQJXxpEnKxkL1vJV3Nhwnb2BcRV3FyMnh4SA
	icSb93vZuxi5OIQEVjBK9FxcxAbhfGGU+DZrLSuE85lR4ta1uUwwLSvXvGGBSCxnlDjweSUz
	XFXvgbNQzi5GiYfrp7GCtPAK2EmcebkYqJ2Dg0VARaL3pCREWFDi5MwnLCC2qECkxJrdZ9lB
	bGGBbImlfcfBbGYBcYlbT+aDtYoIqErcmuYCET7ELHHhRjZImE1AS6KxE6yaE8h833OaCaJE
	U6J1+2+oKfIS29/OYYa4X0liwrz7bBB2rcTaY2fA3pcQeMQpcWV9KyNEwkVi7co/UEXCEq+O
	b2GHsGUk/u+cDw2IaomnN34zQzS3MEr071zPBnKQhIC1RN+ZHIgaR4n9C84zQ4T5JG68FYS4
	h09i0rbpzBMYVWchBcQsJA/PQvLCLCQvLGBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7
	iRGYBk//O/51B+OKVx/1DjEycTAeYpTgYFYS4U3ZIZIsxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nDc5c0OikEB6YklqdmpqQWoRTJaJg1Oqgalsziu3+lPvtAqrbp5f8SKMU+I5U3vIfd8odrXH
	bOKX+HN7t5w58ILZamXZJBXbG97X9AyPbDEwPKZjG7WwzkhA/at00YOGt/ed5gsmWMyQXDhX
	9rnggoBqt4uylZ1Nt+zd5h2YFx/W8aw2vW3WziZBTfHLnc/q+xiVSswr5d6kRkyP1Qr2CvFZ
	um/vzgdMNkUHI64LvtNNt/BQfv1i9WEWmRPsH+aUe3VXmO1WCOdcveTCX9lHG6PvLEu7Zajw
	Wk6w1tZub+rTo9OyOZb+eJ/yNsV5nkHu1faJjg/kmiWMO3heXPr0N/6x7qFy1RfuhicXHD1x
	8fitKfYrt219UX5bl/P0huqy6pyjK+e9rldiKc5INNRiLipOBACZzGsn8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7rqn0STDY5MlLJYf+oYs8Xqu/1s
	FtM+/GS2+H32PLNFa/s3Jou972azWqxcfZTJ4sn6WcwWf7vuAcVuaVtc3jWHzWL+sqfsFhPa
	vjJbrLn5lMXixC1pi7aNXxkdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
	7/ddZfP4vEnOo/1AN1MAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJexpEnKxkL1vJV3Nhwnb2BcRV3FyMnh4SAicTKNW9YQGwhgaWMEpN+Z0PE
	ZSQ+XfnIDmELS/y51sXWxcgFVPORUeLd00usEM4uRok9e+6yglTxCthJnHm5mKmLkYODRUBF
	ovekJERYUOLkzCdgC0QFIiUeLmtiArGFBbIllvYdB1vALCAucevJfLBWEQFViVvTXEDGMwsc
	YpZY1buZCWLXP0aJE+vmM4MUsQloSTR2gvVyApnve04zQczRlGjd/htqprzE9rdzmCEeUJKY
	MO8+G4RdK/Hq/m7GCYyis5CcNwvJGbOQjJqFZNQCRpZVjCKppcW56bnFRnrFibnFpXnpesn5
	uZsYgclj27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHelB0iyUK8KYmVValF+fFFpTmpxYcYTYFB
	NJFZSjQ5H5i+8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamIQC
	/od7nHUxdV+YvTZi47Z1XRVHtuy92nU+i5vh5z/269ei7XcsW61yTHyTyI2Li45GzKhQYcoJ
	3fVm8hOXL2YO+3ZEPThscE+mVv5d8b6t2TI/VB5c+XVIuHv66qtHtdvv5bbKyLjoMufXek4x
	XHrjsn3KYrODRUfUfx1VvP5B5OXpKf8qEsTtXsetZ7tU+TJ6gU3Ix+x3m7j+7z3NFdMb8P7G
	joyjje9lv1ez79h47nyhxF2jDbGc/zK6LPovpteZfT/KusxZuWSbiR8Pb5RAsvhaMUZFU34r
	o1TxRT9Pz5hv2qQh2LayVTplps2944v+ufVrTf6c8Oz15VxN+QX7d62InpP7wlty6lP3LfVK
	LMUZiYZazEXFiQDE0KUFpwMAAA==
X-CMS-MailID: 20220905125711eucas1p12e53a64104034b1a8dca6ada0a79cf94
X-Msg-Generator: CA
X-RootMTR: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
References: <20220823121859.163903-1-p.raghav@samsung.com>
	<CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
	<20220823121859.163903-14-p.raghav@samsung.com>
	<YxJttvB2Z5I58SQ5@redhat.com> <YxJwd7xcZRdznsYz@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_135739_142269_5D73E76E 
X-CRM114-Status: GOOD (  19.64  )
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

>>
>> 1) why is a partial mapping of the underlying device disallowed?
>> 2) why is it assumed all IO is read-only? (talk to me and others like
>>    we don't know the inherent limitations of this class of zoned hw)
>>
>> On a code level:
>> 1) are you certain you're properly failing all writes?
>>    - are writes allowed to the "zone capacity area" but _not_
>>      allowed to the "emulated zone area"? (if yes, _please document_). 
>> 2) yes, you absolutely need to implement the .status target_type hook
>>    (for both STATUS and TABLE).
>> 3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
>>    DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
>>    prefer to not have to do a depth-first search to see where and when
>>    dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
>>    justification for it.  To me it just obfuscates the DM interface a
>>    bit too much. 
>>
>> Otherwise, pretty clean code and nothing weird going on.
>>
>> I look forward to seeing your next (final?) revision of this patchset.
> 
> Thinking further.. I'm left confused about just what the heck this
> target is assuming.
> 
> E.g.: feels like its exposing a readonly end of the zone is very
> bi-polar... yet no hint to upper layer it shouldn't write to that
> read-only end (the "emulated zone").. but there has to be some zoned
> magic assumed?  And I'm just naive?
> 

You are absolutely right about "zoned magic". Applications that use a zoned
block device are aware of the zone capacity and zone size. BLKREPORTZONE
ioctl is typically used to get the zone information from a zoned block device.

This target adjusts the zone report so that zone size and zone capacity are
modified correctly (see dm_po2z_report_zones() and
dm_po2z_report_zones_cb() functions).

