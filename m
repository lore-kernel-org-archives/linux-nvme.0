Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 10:42:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8AB61040
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 10:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F8AB61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2w6MoYTQcYhg9UWzUhtIYpP2ItQosRsTSRlp/OWbo7I=; b=OG881KghUtpMmNH6Xz2SAqtJNH
	qNOVdNmpo7NscCFu2oL1EH0sgnyqif1EfG3I1Cjv0+YIER9jLm/QNNcIfLZOGrdgBnst8iOxClRA+
	sPRK3iq9E+l3arY0qORSsiQ5tL5aRNiLMbrHo1q97qNPb+ruzPWPbYHt3i1vcz3Fdbt4s8qw7Hk7N
	BHVcTJ5XNiSMiU0CkYUsrRMljr+jp6Fr/xhqP6LjEnaP6mzMpI/+OUmkF7G6sMs7m6ody4e9A4icO
	CeqPrF1nHm5KlwyMbdRO4AyBWAEldlRVRmWXIQ9YL72c6gFIhNyELVEdNM2r7NdNnblovB45ZJ1ji
	KP1HwB0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mabhw-00G44X-H4; Wed, 13 Oct 2021 10:42:01 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maZjf-00Fb9g-VD
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 08:35:42 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20211013083536euoutp02379ebd839d8f2c615a224cfb8e55e79e~tiiY8gM-X1909819098euoutp02o
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 08:35:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20211013083536euoutp02379ebd839d8f2c615a224cfb8e55e79e~tiiY8gM-X1909819098euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1634114136;
 bh=lEXMQGbCbMscpq5Afgy20WzMWHP7jdEjLxxE5OlTv9w=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=Lrtu5DaW4v3dIKxcvPevjQhUxvpsJLRlXsW4Wnbr84VYuhvGUIDXAfyCHuFq5iwKw
 qpOTfmtjw+Gn3w/3v3tctgsc2kUt6/AU5JZL+GUlfPqpC9URXHugzYODUXMYvQbLcX
 2g/ID1y3UP+e9Ts7OV0Ncv7UISPCqOj3MlNoM45Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20211013083536eucas1p1a795c57a764df3335f868000c9bd6669~tiiYmAiHG0164501645eucas1p1B;
 Wed, 13 Oct 2021 08:35:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.15.45756.85A96616; Wed, 13
 Oct 2021 09:35:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20211013083535eucas1p13f4ddfc4b6ee1a62c824d48b0cc0e105~tiiYLEzD81511715117eucas1p1f;
 Wed, 13 Oct 2021 08:35:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20211013083535eusmtrp1e3e4270a1575147c3e0ee833770dc49b~tiiYKE2KJ2173921739eusmtrp1c;
 Wed, 13 Oct 2021 08:35:35 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-16-61669a58817f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.C0.20981.75A96616; Wed, 13
 Oct 2021 09:35:35 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20211013083535eusmtip2ecd856f2ed1ab8f61ba652b25279da00~tiiX7G0Tr2272522725eusmtip2s;
 Wed, 13 Oct 2021 08:35:35 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 13 Oct 2021 09:35:34 +0100
Date: Wed, 13 Oct 2021 10:35:33 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>, "bvanassche@acm.org"
 <bvanassche@acm.org>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "roland@purestorage.com"
 <roland@purestorage.com>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>, SelvaKumar S
 <selvakuma.s1@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>, "Kanchan
 Joshi" <joshi.k@samsung.com>, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211013083533.hhgrkm3lhoytfp3a@mpHalley-2.domain_not_set.invalid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211006100121.2hqfdkyuivzvzd33@mpHalley.domain_not_set.invalid>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7djPc7oRs9ISDc53c1qsvtvPZjHtw09m
 i1m3X7NYvD/4mNVi77vZrBaPN/1nstizaBKTxcrVR5ks/nbdY7KYdOgao8XeW9oW85c9Zbfo
 vr6DzWLf673MFsuP/2OymNhxlcni3Kw/bBaH711lsVj9x8Ji5TMmi1f74xxEPS5f8faY2PyO
 3ePy2VKPTas62Tw2L6n3mHxjOaPH7psNbB4zPn1h87h+ZjuTR2/zOzaPj09vsXhse9jL7vF+
 31Wg2tPVHp83yXm0H+hmChCI4rJJSc3JLEst0rdL4MroPu9ecE+y4t9/1wbGVyJdjJwcEgIm
 Ehe/LmLrYuTiEBJYwSjxafZfRpCEkMAXRonmLZkQic+MEh2vn7HAdJx8+pIZIrGcUeJa6zVW
 uKqGUwegMlsZJZadvssG0sIioCrx4OUvVhCbTcBe4tKyW8wgtoiAnsTVWzfYQRqYBTZwSmxa
 tAGsQVjAU2LHhn4mEJtXwF/i6eJZbBC2oMTJmU/A7mAWsJLo/NAENJQDyJaWWP6PAyIsL9G8
 dTbYfE4BP4nm67vZQUokBJQllk/3hfigVmLtsTNgayUElnJJzJ/wkhUi4SJx/eIiZghbWOLV
 8S3sELaMxOnJPSwQDc2MEmfWXGGGcHoYJf5MWsEIscFaou9MDkSDo8T2KQ+ZIcJ8EjfeCkLc
 xicxadt0qDCvREeb0ARGlVlIHpuF5LFZCI/NQvLYAkaWVYziqaXFuempxYZ5qeV6xYm5xaV5
 6XrJ+bmbGIGp9vS/4592MM599VHvECMTB+MhRgkOZiURXsOM1EQh3pTEyqrUovz4otKc1OJD
 jNIcLErivKtmr4kXEkhPLEnNTk0tSC2CyTJxcEo1MCXLzpqz3Cqm+6/Xr8t3/TvrmYvbXdOf
 a0483P2k7Fjwf4NXutccvutv7U4SDJLMmSP0Ji+g2nDlbdbV87JezJlorBf15HMj3+Ku1Qn/
 HgX+OqbA2/PMbUvT169MZx3uNEQ9vPpkQ/aSrfozPf1C+7oKYp5q6+THK/c7z3W9ZXTCWjve
 cfbn+rlMl45zrT0cwFW2MGLuqYLtNzOb71nIxzu3Xlpzr77uZsfOey+5kp4JPbpcmsO1v/Xp
 /whxwzme7Noni2uOLO82OHlI2n+7ke+9MvZ8hnTOj9fefvxnPO3b5D2BXXL8RRkGWd7a2mFp
 FyNbD87J3ap6tvG71TOPrxNehs09pCeSFVtio155SImlOCPRUIu5qDgRAIXemJckBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsVy+t/xe7rhs9ISDQ7vU7dYfbefzWLah5/M
 FrNuv2axeH/wMavF3nezWS0eb/rPZLFn0SQmi5WrjzJZ/O26x2Qx6dA1Rou9t7Qt5i97ym7R
 fX0Hm8W+13uZLZYf/8dkMbHjKpPFuVl/2CwO37vKYrH6j4XFymdMFq/2xzmIely+4u0xsfkd
 u8fls6Uem1Z1snlsXlLvMfnGckaP3Tcb2DxmfPrC5nH9zHYmj97md2weH5/eYvHY9rCX3eP9
 vqtAtaerPT5vkvNoP9DNFCAQpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqk
 b2eTkpqTWZZapG+XoJfRfd694J5kxb//rg2Mr0S6GDk5JARMJE4+fcncxcjFISSwlFFi18Ev
 jBAJGYlPVz6yQ9jCEn+udbFBFH1klFj8vIkJwtkK5OyaAtbBIqAq8eDlL1YQm03AXuLSslvM
 ILaIgJ7E1Vs32EEamAU2cEpsWrSBDSQhLOApsWNDPxOIzSvgL/F08SyoFfuZJTo2/WCFSAhK
 nJz5hAXEZhawkJg5/zzQNg4gW1pi+T8OiLC8RPPW2WDLOAX8JJqv72YHKZEQUJZYPt0X4oNa
 iVf3dzNOYBSZhWToLCRDZyEMnYVk6AJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBqWjb
 sZ9bdjCufPVR7xAjEwfjIUYJDmYlEV7DjNREId6UxMqq1KL8+KLSnNTiQ4ymwCCayCwlmpwP
 TIZ5JfGGZgamhiZmlgamlmbGSuK8JkfWxAsJpCeWpGanphakFsH0MXFwSjUwzXKcnt9/9urp
 FfIp8xYvYWI9ovucP8NhyrR7kjIx9cLX7HbOfjStX/VJkFbXjXVbO97Lny6YNq9BjTGSf2lV
 39pvqgufWZy8bGO5KqjUv1Fkxbki/XC/bXmnGNYoruLmCnvZox0574F4y4evJ3an1Z9LDxPe
 3nbu1rIt3D2yc42eXmn4sExZVePLFX2lx1N+adWlZCfUv4ueuVff+Crnr5aDr2bpRGzdY/Wu
 ecHd0sh/F8U/Wm+bpTtli5HjQi07908/V9b2zBNM5QkxKtr99HeueqJjzY6MjbWRqevEP0cs
 Mdx+4pqcS+mWl3efr94+76DhlzjfNcZOc2bIeG7ijDvAtkfQadnTSz7rrGaaP1diKc5INNRi
 LipOBAAGHKBGzgMAAA==
X-CMS-MailID: 20211013083535eucas1p13f4ddfc4b6ee1a62c824d48b0cc0e105
X-Msg-Generator: CA
X-RootMTR: 20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c1b0f954-0728-e6ab-73ab-7b466a7d2eb7@nvidia.com>
 <20211006100121.2hqfdkyuivzvzd33@mpHalley.domain_not_set.invalid>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_013540_325179_215409A2 
X-CRM114-Status: GOOD (  17.63  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q2hhaXRhbnlhLAoKRGlkIHlvdSBoYXZlIGEgY2hhbmNlIHRvIGxvb2sgYXQgdGhlIGFuc3dlcnMg
YmVsb3c/CgpJIHdvdWxkIGxpa2UgdG8gc3RhcnQgZmluZGluZyBjYW5kaWRhdGUgZGF0ZXMgdGhy
b3VnaG91dCB0aGUgbmV4dCBjb3VwbGUKb2Ygd2Vla3MuCgpUaGFua3MsCkphdmllcgoKT24gMDYu
MTAuMjAyMSAxMjowMSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPk9uIDMwLjA5LjIwMjEgMDk6
NDMsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToKPj5KYXZpZXIsCj4+Cj4+Pgo+Pj5IaSBhbGws
Cj4+Pgo+Pj5TaW5jZSB3ZSBhcmUgbm90IGdvaW5nIHRvIGJlIGFibGUgdG8gdGFsayBhYm91dCB0
aGlzIGF0IExTRi9NTSwgYSBmZXcgb2YKPj4+dXMgdGhvdWdodCBhYm91dCBob2xkaW5nIGEgZGVk
aWNhdGVkIHZpcnR1YWwgZGlzY3Vzc2lvbiBhYm91dCBDb3B5Cj4+Pk9mZmxvYWQuIEkgYmVsaWV2
ZSB3ZSBjYW4gdXNlIENoYWl0YW55YSdzIHRocmVhZCBhcyBhIHN0YXJ0LiBHaXZlbiB0aGUKPj4+
Y3VycmVudCBzdGF0ZSBvZiB0aGUgY3VycmVudCBwYXRjaGVzLCBJIHdvdWxkIHByb3Bvc2UgdGhh
dCB3ZSBmb2N1cyBvbgo+Pj50aGUgbmV4dCBzdGVwIHRvIGdldCB0aGUgbWluaW1hbCBwYXRjaHNl
dCB0aGF0IGNhbiBnbyB1cHN0cmVhbSBzbyB0aGF0Cj4+PndlIGNhbiBidWlsZCBmcm9tIHRoZXJl
Lgo+Pj4KPj4KPj5JIGFncmVlIHdpdGggaGF2aW5nIGEgY2FsbCBhcyBpdCBoYXMgYmVlbiB0d28g
eWVhcnMgSSdtIHRyeWluZyB0byBoYXZlCj4+dGhpcyBkaXNjdXNzaW9uLgo+Pgo+PkJlZm9yZSB3
ZSBzZXR1cCBhIGNhbGwsIHBsZWFzZSBzdW1tYXJpemUgZm9sbG93aW5nIGhlcmUgOi0KPj4KPj4x
LiBFeGFjdGx5IHdoYXQgd29yayBoYXMgYmVlbiBkb25lIHNvIGZhci4KPgo+Cj5XZSBjYW4gY2F0
ZWdvcml6ZSB0aGF0IGludG8gdHdvIHNldHMuIEZpcnN0IG9uZSBmb3IgWENvcHkgKDIwMTQpLCBh
bmQKPnNlY29uZCBvbmUgZm9yIE5WTWUgQ29weSAoMjAyMSkuCj4KPlhDT1BZIHNldCAqKioqKioq
KioKPi0gYmxvY2stZ2VuZXJpYyBjb3B5IGNvbW1hbmQgKHNpbmdsZSByYW5nZSwgYmV0d2VlbiBv
bmUKPiAgc291cmNlL2Rlc3RpbmF0aW9uIGRldmljZSkKPi0gaW9jdGwgaW50ZXJmYWNlIGZvciB0
aGUgYWJvdmUKPi0gU0NTSSBwbHVtYmluZyAoYmxvY2stZ2VuZXJpYyB0byBYQ09QWSBjb252ZXJz
aW9uKQo+LSBkZXZpY2UtbWFwcGVyIHN1cHBvcnQ6IG9mZmxvYWQgY29weSB3aGVuZXZlciBwb3Nz
aWJsZSAoaWYgSU8gaXMgbm90Cj4gIHNwbGl0IHdoaWxlIHRyYXZlbGluZyBsYXllcnMgb2Ygdmly
dHVhbCBkZXZpY2VzKQo+Cj5OVk1lLUNvcHkgc2V0ICoqKioqKioqKioqKioKPi0gYmxvY2stZ2Vu
ZXJpYyBjb3B5IGNvbW1hbmQgKG11bHRpcGxlIHJhbmdlcywgYmV0d2VlbiBvbmUKPiAgc291cmNl
L2Rlc3RpbmF0aW9uIGRldmljZSkKPi0gaW9jdGwgaW50ZXJmYWNlIGZvciB0aGUgYWJvdmUKPi0g
TlZNZSBwbHVtYmluZyAoYmxvY2stZ2VuZXJpYyB0byBOVk1lIENvcHkgY29udmVyc2lvbikKPi0g
Y29weS1lbXVsYXRpb24gKHJlYWQgKyB3cml0ZSkgaW4gYmxvY2stbGF5ZXIKPi0gZGV2aWNlLW1h
cHBlciBzdXBwb3J0OiBubyBvZmZsb2FkLCByYXRoZXIgZmFsbCBiYWNrIHRvIGNvcHktZW11bGF0
aW9uCj4KPgo+PjIuIFdoYXQga2luZCBvZiBmZWVkYmFjayB5b3UgZ290Lgo+Cj5Gb3IgTlZNZSBD
b3B5LCB0aGUgbWFqb3IgcG9pbnRzIGFyZSAtIGEpIGFkZCBjb3B5LWVtdWxhdGlvbiBpbgo+Ymxv
Y2stbGF5ZXIgYW5kIHVzZSB0aGF0IGlmIGNvcHktb2ZmbG9hZCBpcyBub3QgbmF0aXZlbHkgc3Vw
cG9ydGVkIGJ5Cj5kZXZpY2UgYikgdXNlci1pbnRlcmZhY2UgKGlvY3RsKSBzaG91bGQgYmUgZXh0
ZW5kYWJsZSBmb3IgY29weSBhY3Jvc3MKPnR3byBkZXZpY2VzIChvbmUgc291cmNlLCBvbmUgZGVz
dGluYXRpb24pIGMpIGRldmljZS1tYXBwZXIgdGFyZ2V0cwo+c2hvdWxkIHN1cHBvcnQgY29weS1v
ZmZsb2FkLCB3aGVuZXZlciBwb3NzaWJsZQo+Cj4id2hlbmV2ZXIgcG9zc2libGUiIGNhc2VzIGdl
dCByZWR1Y2VkIGNvbXBhcmVkIHRvIFhDT1BZIGJlY2F1c2UgTlZNZQo+Q29weSBpcyB3aXQKPgo+
PjMuIFdoYXQgYXJlIHRoZSBleGFjdCBibG9ja2Vycy9vYmplY3Rpb25zLgo+Cj5JIHRoaW5rIGl0
IHdhcyBkZXZpY2UtbWFwcGVyIGZvciBYQ09QWSBhbmQgcmVtYWlucyB0aGUgc2FtZSBmb3IgTlZN
ZQo+Q29weSBhcyB3ZWxsLiAgRGV2aWNlLW1hcHBlciBzdXBwb3J0IHJlcXVpcmVzIGRlY29tcG9z
aW5nIGNvcHkgb3BlcmF0aW9uCj50byByZWFkIGFuZCB3cml0ZS4gIFdoaWxlIHRoYXQgaXMgbm90
IGdyZWF0IGZvciBlZmZpY2llbmN5IFBvViwgYmlnZ2VyCj5jb25jZXJuIGlzIHRvIGNoZWNrIGlm
IHdlIGFyZSB0YWtpbmcgdGhlIHNhbWUgcm91dGUgYXMgWENPUFkuCj4KPkZyb20gTWFydGluJ3Mg
ZG9jdW1lbnQgKGh0dHA6Ly9ta3AubmV0L3B1YnMveGNvcHkucGRmKSwgaWYgSSBnb3QgaXQKPnJp
Z2h0LCBvbmUgdGhlIG1ham9yIGJsb2NrZXIgaXMgaGF2aW5nIG1vcmUgZmFpbHVyZSBjYXNlcyB0
aGFuCj5zdWNjZXNzZnVsIG9uZXMuIEFuZCB0aGF0IGRpZCBub3QganVzdGlmeSB0aGUgZWZmb3J0
L2NvZGUgdG8gd2lyZSB1cAo+ZGV2aWNlIG1hcHBlci4gIElzIHRoYXQgYSBmYWN0b3IgdG8gY29u
c2lkZXIgZm9yIE5WTWUgQ29weSAod2hpY2ggaXMKPm5hcnJvd2VyIGluIHNjb3BlIHRoYW4gWENP
UFkpLgo+Cj4+NC4gUG90ZW50aWFsIHdheXMgb2YgbW92aW5nIGZvcndhcmQuCj4KPmEpIHdlIGRl
ZmVyIGF0dGVtcHQgZGV2aWNlLW1hcHBlciBzdXBwb3J0ICh1bnRpbCBOVk1lIGhhcwo+c3VwcG9y
dC91c2VjYXNlKSwgYW5kIGFkZHJlc3MgZXZlcnl0aGluZyBlbHNlIChyZXVzYWJsZSB1c2VyLWlu
dGVyZmFjZQo+ZXRjLikKPgo+Yikgd2UgYXR0ZW1wdCBkZXZpY2UtbWFwcGVyIHN1cHBvcnQgKGJ5
IG1vdmluZyB0byBjb21wb3NpdGUgcmVhZCt3cml0ZQo+Y29tbXVuaWNhdGlvbiBiZXR3ZWVuIGJs
b2NrLWxheWVyIGFuZCBudm1lKQo+Cj4KPklzIHRoaXMgZW5vdWdoIGluIHlvdXIgbWluZCB0byBt
b3ZlIGZvcndhcmQgd2l0aCBhIHNwZWNpZmljIGFnZW5kYT8gSWYKPndlIGNhbiwgSSB3b3VsZCBs
aWtlIHRvIHRhcmdldCB0aGUgbWVldHVwIGluIHRoZSBuZXh0IDIgd2Vla3MuCj4KPlRoYW5rcywK
PkphdmllcgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
