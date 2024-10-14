Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A799BCFC501
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sunEOuEjHhNMgJphtcwxnab8BPFnOqcscTv1UUEzpCQ=; b=iLQxaJJmMGB18jhhbp0W30ML0G
	KhQxvBOztcjW/FDWqOcIoDmOsr3bU6AmoNdUJLw3LFxV2zm8kyHmU803AWV8NS1PLbAyClnczZYg0
	BtVDtgui8jFjYusaI77CN/Mm9731IqtoMPWE0xLnmH3DWTepSwk8AvgXwUaN+GPPHoBs0zvFfMBcQ
	yVxeSKN8cme/POg1+caKIJp3NLZhPokFVz89xsuR9ecUWVXHanuxdAchpZ5ha7RSWFcepmd4dmIwb
	zI0QyeXfFWJ46oxM9KR0Vcd/1BQgChcyOhG6i4XIqQnPVP4cDH2uW7vwuK6r9AUsXqSvDR2tVXuGO
	4+sM62FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0F6Z-00000003z1b-14WB;
	Mon, 14 Oct 2024 07:02:59 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0F5v-00000003yrD-2Mk5
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 07:02:22 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241014070214euoutp01d4a88b7b633cdf36aaa5501a87d2f712~_P7CkP4ou1258512585euoutp01w
	for <linux-nvme@lists.infradead.org>; Mon, 14 Oct 2024 07:02:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241014070214euoutp01d4a88b7b633cdf36aaa5501a87d2f712~_P7CkP4ou1258512585euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728889334;
	bh=sunEOuEjHhNMgJphtcwxnab8BPFnOqcscTv1UUEzpCQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bKCSGLr76FD3op7lWFartWC6IY9mAa58Si5Dk9gjdCW1YEi7rjMaHUCROKZLCAHVB
	 antImKuID8OJa5k2eI83606yWl+9qBv626CXrA1KiNGMis0yaVLCIxfyPeKtbdsoVB
	 0dVYoJkoTCXEjgSxHneN9xOS+OTUQWQxysLMzh6A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241014070214eucas1p2e260aee82bbc2fe7c63b492d41d59f0c~_P7CMDN832659426594eucas1p2Y;
	Mon, 14 Oct 2024 07:02:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.C1.09875.6F1CC076; Mon, 14
	Oct 2024 08:02:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241014070214eucas1p190fe5b4e645abd0198787349ba61f845~_P7BxlZ-92283422834eucas1p1Z;
	Mon, 14 Oct 2024 07:02:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241014070213eusmtrp201aecd3d92d4fe6034c8f2b5c42be2a3~_P7Bwzivu2164021640eusmtrp2W;
	Mon, 14 Oct 2024 07:02:13 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-cb-670cc1f69da7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.92.19096.5F1CC076; Mon, 14
	Oct 2024 08:02:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241014070213eusmtip1c2a05b35489ff0f9da38e9ac1c867b72~_P7BjkM-Z2718327183eusmtip1h;
	Mon, 14 Oct 2024 07:02:13 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 14 Oct 2024 08:02:12 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 14 Oct
	2024 08:02:12 +0100
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"hare@suse.de" <hare@suse.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"brauner@kernel.org" <brauner@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "bcrl@kvack.org"
	<bcrl@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "io-uring@vger.kernel.org"
	<io-uring@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "vishak.g@samsung.com"
	<vishak.g@samsung.com>
Subject: RE: [PATCH v7 0/3] FDP and per-io hints
Thread-Topic: [PATCH v7 0/3] FDP and per-io hints
Thread-Index: AQHbG7xJFahlOOmkRUWBz3B/P2gFpLKBuCIAgAQCOYCAABtsUA==
Date: Mon, 14 Oct 2024 07:02:11 +0000
Message-ID: <34d3ad68068f4f87bf0a61ea8fb8f217@CAMSVWEXC02.scsc.local>
In-Reply-To: <20241014062125.GA21033@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.22]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZduznOd1vB3nSDW6cE7OYs2obo8Xqu/1s
	Fl3/trBYvD78idFi2oefzBbvmn6zWOxZNInJYuXqo0wW71rPsVjMnt7MZPFk/Sxmi0mHrjFa
	TJnWxGix95a2xZ69J1ks5i97ym6x/Pg/Jot1r9+zWJz/e5zVQdjj8hVvj52z7rJ7nL+3kcXj
	8tlSj02rOtk8Nn2axO6xeUm9x+6bDWweH5/eYvF4v+8qm8eZBUeA4qerPT5vkvPY9OQtUwBf
	FJdNSmpOZllqkb5dAlfGvzcT2AsaeCt2zV/K1sD4jKuLkZNDQsBE4t+X76xdjFwcQgIrGCV2
	/rzHAuF8YZS4+LAbKvOZUaJj+UZGmJb3q98xQSSWM0o8eX8DoWrRxn6ozBlGid0nFrKAtAgJ
	rGSU+HTFF8RmE9CXWLX9FNgoEQEHidkblrKBNDAL7GCX6DnTxw6SEBYwkGhesg+qyFDi3bKF
	ULaTxL7+N6wgNouAqsTL6yuA6jk4eAVcJdZ1G4KEOQV0JD7PewA2hlFAVuLRyl9gNrOAuMSt
	J/OZIF4QlFg0ew8zhC0m8W/XQzYI20Bi69J9LBC2okTf/PcsEL06Egt2f2KDsLUlli18DdbL
	CzTn5Mwn4ACTEDjLJTHv+AeoBS4SG8/0QcNLWOLV8S3sELaMxP+dMEdUSzScPME0gVFrFpL7
	ZiHZNwvJvllI9i1gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmFRP/zv+ZQfj8lcf
	9Q4xMnEwHmKU4GBWEuF9P5UzXYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZq
	akFqEUyWiYNTqoEpo+/Kbpa34VpFG6SXB80P2rLapOtFz/6/0rGpxpbzxBcG6u9LMbQwlXV+
	2dB0pzxj/rvi1Fbe6BvBy7oLNaKyXxndm7KLiePDg4kh1rPNZp/r5Wbbw7k4zS5uaTtvV0vj
	kRsJK9//P6zNHax+6JnTOuVDr5tOvW1omyDa8WyF9qZyxTfyMnbKMlMsq42+W3y952XlpT/n
	aMUkjaSn7+9c5k2o/H28dVPsdO1s/8i+Fd6XvOoOS3/pWKhamfCqR6nu7CrZOibFY/+3vbHo
	Oy4R9O+4lnb1/0VtVxu/Lr80p0pCueW46a6dvLnxzTFOVzjkV6V9sKpuXPJmg2ekrfOqZ225
	X1YXHJT+8NvB7YcSS3FGoqEWc1FxIgC8zrr0GQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRSH9957ub3FdblrmXslarSTmFC8tIXWl212xLjlZrhpon8oTmYz
	LgXlY/aDOc2wwky2buFrCNoRaJUPgYijw26z0IUO6ZBthLExx1YlWAwb2K6MacpGJ/Riwn/P
	ec958st5cyhc/G9MPJVXaOT0hdp8KRlLDEW8vpce9K3Vyc9MqVF9uxOgDl8FiSyRbgLNXJgD
	qPZeGEeB0ocE6vm2GkNtHb9gKPDlFQKdrCvDkP9HK46qPWMA1dSWAtQ7LkM9vYMEamyZEqBW
	bwRDnTNBAg0vemPSJezotQz2nNUnYId/7yLY0csm1tF+lGQdc9UC9nTT56zrpplkQ1PjBBt0
	XyfZS7b+pfehz9j7jmdZh/9v7M11mcxWfZHJyD2XW2QwviJ9T4GUjCINMcrUNEaR8vL7m5Uq
	abJmazaXn1fM6ZM1HzC5kdlKwX6z6JOfG5tJM/gr1gKEFKRTYbAjgFlALCWmmwGMWKpIvvE0
	7Jq/HsOzBD4as5D8UAjA0JEKwBeXAPTUHSf4og1A29wFbFkh6WTYfuZXsMxxdDo8eao5quO0
	UwDPPezHlxsSWg7LmtwrQwoYaLGv8KvQXTEbzSboBHjnxvcCC6AoEb0ddh5T8GG3cXjq2I1o
	mJBOgvcbJgTLDOhn4GTbQpRxeiMc9zdi/A40bOoZxnneAO/8GVnZTQ5/anYTPD8PyxuDBO8m
	QZtrjuRZBlvsM1FXRK+Hg9/4iUoQb10VYV2lWFcp1lWKDRDtII4zGQp0BQYlY9AWGEyFOmZf
	UYEDLF2gcyDcfRa03Q0xHoBRwAMghUvjRMGvhDqxKFt78FNOX7RXb8rnDB6gWvqXKjx+w76i
	pRMuNO5VqOUqRao6Ta5KU6dIN4rIa8M5YlqnNXIfcdx+Tv+/h1HCeDPmFC/c3NmP1fR2Hqp9
	/EPOeXdpuiZlh2x2zbbdhrreVs2OI4tZb+mwzp3Zki31551XWrftqaghLnY37JYNPqVZHCh5
	bd5boyzdXDzt87rWqS3Gw70zfZuq8v1fh7JCvrGJQ3ZYcvnuLfHg/ERZpnO6WM1lvejMrEQJ
	73z37mR4/IDthfLHXkrfZf6tT0AUJ/qnmSb3vdOyg7jNXh4rORtwJO4iwwsNa9d/nPFIbcp4
	g2h9u3n0ySz70ETHouR1/KpmYI9K4vJ/iBXnza+5qDu65Z+r2w8E60fEqhNPlHRpLHXhL04I
	byclCEfInMqGySEXg4iRasAcRvbjf8hvPZAShlytIhHXG7T/AfIBTv4KBAAA
X-CMS-MailID: 20241014070214eucas1p190fe5b4e645abd0198787349ba61f845
X-Msg-Generator: CA
X-RootMTR: 20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed
References: <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp>
	<20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp>
	<CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com>
	<20241010070736.de32zgad4qmfohhe@ArmHalley.local>
	<20241010091333.GB9287@lst.de>
	<20241010115914.eokdnq2cmcvwoeis@ArmHalley.local>
	<20241011090224.GC4039@lst.de>
	<5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk>
	<20241014062125.GA21033@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_000219_894247_40044C4A 
X-CRM114-Status: GOOD (  20.75  )
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

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, October 14, 2024 8:21 AM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>; Javier Gonzalez <javier.gonz@samsung.=
com>;
> Keith Busch <kbusch@kernel.org>; Martin K. Petersen
> <martin.petersen@oracle.com>; Kanchan Joshi <joshi.k@samsung.com>;
> hare@suse.de; sagi@grimberg.me; brauner@kernel.org; viro@zeniv.linux.org.=
uk;
> jack@suse.cz; jaegeuk@kernel.org; bcrl@kvack.org; dhowells@redhat.com;
> bvanassche@acm.org; asml.silence@gmail.com; linux-nvme@lists.infradead.or=
g;
> linux-fsdevel@vger.kernel.org; io-uring@vger.kernel.org; linux-
> block@vger.kernel.org; linux-aio@kvack.org; gost.dev@samsung.com;
> vishak.g@samsung.com
> Subject: Re: [PATCH v7 0/3] FDP and per-io hints
>=20
> On Fri, Oct 11, 2024 at 11:08:26AM -0600, Jens Axboe wrote:
> >
> > I think that last argument is a straw man - for any kind of interface
> > like this, we've ALWAYS just had the rule that any per-whatever
> > overrides the generic setting.
>=20
> And exactly that is the problem.  For file systems we can't support
> that sanely.  So IFF you absolutely want the per-I/O hints we need
> an opt in by the file operations.  I've said that at least twice
> in this discussion before, but as everyone likes to have political
> discussions instead of technical ones no one replied to that.

Is it a way forward to add this in a new spin of the series - keeping the=20
temperature mapping on the NVMe side?

If not, what would be acceptable for a first version, before getting into a=
dding
a new interface to expose agnostic hints?


