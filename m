Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4BDD16272
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6MxMARZ/fd8PmMdfu49JsoNqWc/GHuLb3BoVceTtYU=; b=0rbyLJSOhqm4vzPouboLIT7IFv
	+1OYRCLGiCTfry+I9QtJJKDYsIMYkTO3StrbEPuqmoKSmRA40MZmStZkqlRDgNA6L4itSvxZOvRlJ
	dj+5I9Z9s4rsRQEChSJIV1Acxv1zdpWKxN+cFLQ/F1rz2BlJLwx97C6Vi601F7ll3lbRD3+Iqge4b
	vjwvbrK6RaKR+ncLDBas0e0UzqiuhvTZwGS/eyd60dckvSKioAIHW8UQwpZlZDdIO26z3i0Ph94xS
	NKGHcGcz6doaeAs7sB0uQmnX7rjAU28HeyM0ZqyTyCKpzI0XLH72nskPobHeqUc5f4sB8JB/y0NMD
	pOvZa4Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Xx6-00000006xWh-3gY3;
	Tue, 15 Oct 2024 03:10:28 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Xun-00000006xIL-20CP
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 03:08:07 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241015030801euoutp01e8e343c6443857f884065de1123e66ba~_gX0_Nb5n1556015560euoutp01z
	for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2024 03:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241015030801euoutp01e8e343c6443857f884065de1123e66ba~_gX0_Nb5n1556015560euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728961681;
	bh=V6MxMARZ/fd8PmMdfu49JsoNqWc/GHuLb3BoVceTtYU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=to4hCVDnsyq8MM9lV5L4fZFP9lxtzcRin50XfZGnREdRShZbaGJMp9p7xN3jBk4C/
	 59u5nCDiKRJv0UatL0XiJg1oX9YI8G88QsrnnQuOuDbQeYDOkUMMAGcRtb8tt9sEte
	 nVcaYwHQ7mg7qJDY8dbnXticWuN9FUkxeAARXbzg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241015030801eucas1p27c948a33fa3c21d627da897266683415~_gX0dt1TQ2989529895eucas1p2d;
	Tue, 15 Oct 2024 03:08:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 3C.3E.09624.19CDD076; Tue, 15
	Oct 2024 04:08:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241015030800eucas1p1e2584459613eaa885539d58f9c8ec4b8~_gXzXS0mL1042710427eucas1p1k;
	Tue, 15 Oct 2024 03:08:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241015030800eusmtrp25976737c3a3da77806b8aaf3ab1decfb~_gXzWjKpz0951909519eusmtrp2t;
	Tue, 15 Oct 2024 03:08:00 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-95-670ddc91e98a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.6F.14621.F8CDD076; Tue, 15
	Oct 2024 04:08:00 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241015030759eusmtip2b042992190a2a3ca6745c77ee402d385~_gXzK2Mrz3239132391eusmtip2j;
	Tue, 15 Oct 2024 03:07:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 15 Oct 2024 04:07:59 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 15 Oct
	2024 04:07:58 +0100
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi
	<joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz"
	<jack@suse.cz>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "bcrl@kvack.org"
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
Thread-Index: AQHbG7xJFahlOOmkRUWBz3B/P2gFpLKBuCIAgAQCOYCAABtsUP///IcAgAAiAcCAACIYAIABC7FQ
Date: Tue, 15 Oct 2024 03:07:57 +0000
Message-ID: <c0675721048d4b0a9a654e2e1669ad60@CAMSVWEXC02.scsc.local>
In-Reply-To: <20241014115052.GA32302@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.22]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGOfdebi8dxUtReoLbiE3IEmEFDI7jImxZxN1FZSbbJCMqNnJT
	iKWQFizzY3QwFAFlq4KzMKFOi4WArjL5xlCGDEUNqeKKVmSUyYqDQl0WLcIotyz893s/nvO8
	75tD4cJjZAiVrshmlQqpXEzyies3X9599/vHAlnUObc/qqq7DlC9rYxExfNNBJrsmQWowvkS
	R1P5bgJ1XNBiyFjfi6GpwrsEqjxbgCH7FR2OtOYhgM5U5APUORyOOjr7CVRtGOeh2r55DDVO
	ThPo3us+3w+DGMv9bUyrzsZj7j35mWAsd3IYU90JkjHNannMtYt5TLtVQzIz48MEM931gGQG
	an5dzN8+zLhMbzMm+9/YzoBk/uZUVp5+kFVGxu/jpw06Ps9yr8otbCnjaUC9fzHwoyAdA38f
	7eUVAz4lpC8DmN/Z4MsFLwAsnzCRXOAC0Nr1kLcscdlmcK5QC+DVljnf/7smDBpvMACg02on
	PBIhbQTw35lcD5N0JKxrvgU8vJoWw3HHHeAR4PQQD3aXDmCeQhAdBQsudnmbouGUQe/lZKgx
	ji8xQYfBVlMp6WEBnQAbftLiHvajI+B5W+MSA/ot+Ifx1dLcOC2Cw/ZqjNshEF6o7MA5Dobz
	baMkx1Hwl0tdBMfr4KnqaYLTRsCa9lmS43Bo0E/inG8g7D/nWZK/2N/Ph9dKGrxH2gLPzp33
	PhoEHX1N3vybcKF1eYjDUNP/G/YdWK9bMZ9uhZ9uhZ9uhV8NIOqAiM1RZchYVbSCVUtU0gxV
	jkIm2Z+ZYQKLX/X2fN9sC/jRMSMxA4wCZgApXLxaoC0WyISCVOlXh1hlZooyR86qzGAtRYhF
	grDUUFZIy6TZ7AGWzWKVy1WM8gvRYDGDceWyFskRufrF14+cuZu/tMZuGwkP7zaQlrkbRT9Q
	TEy3a7f7TPYjdV6Y4Z245nb8yPE/ZfGKocyC2FfPUxKjsQT/wWP6rZ9Onf4scDRhQ8le88ba
	piLLITygNGRUXBl8ac1HVek7ch8bB65m/LXjRlJFXtLJHkf2lpDETfh97Z735SdHfAxtC5iP
	69Q3jt6x7RL18zcCdn4c5/RTuj94DWxJESlrpcEHiaInX2Bbs8qePbPjw43J5SXv8dsSHnbG
	X0kTHQ0NFVkcRxv5iTrdJy61uXmsZ2Pygl5/wmq82e6jaf628OnuDf+YV3XzMPtTZ1S1duT4
	xGRV5K5NTbHsmJhQpUmj1+NKlfQ/z41RExkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVy+t/xe7oT7vCmGyzewGwxZ9U2RovVd/vZ
	LLr+bWGxeH34E6PFtA8/mS3eNf1msdizaBKTxcrVR5ks3rWeY7GYPb2ZyeLJ+lnMFpMOXWO0
	mDKtidFi7y1tiz17T7JYzF/2lN1i+fF/TBbrXr9nsTj/9zirg7DH5SveHjtn3WX3OH9vI4vH
	5bOlHptWdbJ5bPo0id1j85J6j903G9g8Pj69xeLxft9VNo8zC44AxU9Xe3zeJOex6clbpgC+
	KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mi69C
	Cn7zV7Tu6GdvYFzN08XIySEhYCLx+e5H5i5GLg4hgaWMEse/XWaHSMhIbPxylRXCFpb4c62L
	DaLoI6PExCl/WSCcM4wSbT/WMkE4Kxklfp2dxAzSwiagL7Fq+ylGEFtEQEni6auzjCBFzAJX
	2CWaFz0HSwgLGEg0L9kHVWQo8W7ZQig7SqJh5VMwm0VAVWLnph42EJtXwFVi7eJJUMfOYJF4
	sHAuWIJTQEdi3t11YJsZBWQlHq38BfYEs4C4xK0n85kgnhCQWLLnPDOELSrx8vE/qOcMJLYu
	3ccCYStK9M1/zwLRqyOxYPcnNghbW2LZwtfMEEcISpyc+YRlAqPULCQrZiFpmYWkZRaSlgWM
	LKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECU+C2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIryT
	unjThXhTEiurUovy44tKc1KLDzGaAgNmIrOUaHI+MAnnlcQbmhmYGpqYWRqYWpoZK4nzul0+
	nyYkkJ5YkpqdmlqQWgTTx8TBKdXAlJEa8n/TTDN3ztr3+n8Yb2+Y7r362rfklBuuHl/57TNv
	Gh4yOvx9Rgnz0uKTtqLGC+rzcs+ezXm4XU6F78L0hklBxZOn35jVzGnzu7KCxXix2PX5ORsS
	uHM7b2w69fywczqXiqr2Md7N9yWEKo6FPEpqVGrhYSrsjsi6q1TiG/DTO0dq/U3m+HcJp5Y5
	7oy6GaPxzF9zdezHRbMvzn3Q2ct7VP0/X7TfQ6vqeXP2+/MkM12qqTj082HWBmOXuJNXnq3u
	W3g47G9MqhK3+3oW8b9bm7zsTZYdWjLravfdp/Ylnrdz4nc9ujLX32QOn4iuneLKnVtP/fMv
	2Xz34OVJqY/6mLtUa8QvLM780/rMS4mlOCPRUIu5qDgRABIoUg4KBAAA
X-CMS-MailID: 20241015030800eucas1p1e2584459613eaa885539d58f9c8ec4b8
X-Msg-Generator: CA
X-RootMTR: 20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed
References: <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com>
	<20241010070736.de32zgad4qmfohhe@ArmHalley.local>
	<20241010091333.GB9287@lst.de>
	<20241010115914.eokdnq2cmcvwoeis@ArmHalley.local>
	<20241011090224.GC4039@lst.de>
	<5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk>
	<20241014062125.GA21033@lst.de>
	<34d3ad68068f4f87bf0a61ea8fb8f217@CAMSVWEXC02.scsc.local>
	<20241014074708.GA22575@lst.de>
	<9e3792eebf7f427db7c466374972fb99@CAMSVWEXC02.scsc.local>
	<20241014115052.GA32302@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_200805_941620_6E69E77F 
X-CRM114-Status: GOOD (  30.08  )
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

> On Mon, Oct 14, 2024 at 09:08:24AM +0000, Javier Gonzalez wrote:
> > > Especially as it directly undermindes any file system work to actuall=
y make use
> of it.
> >
> > I do not think it does. If a FS wants to use the temperatures, then the=
y
> > would be able to leverage FDP besides SCSI.
>=20
> What do you mean with that?  This is a bit too much whitepaper vocabularl=
y.
>=20
> We have code in XFS that can make use of the temperature hint.  But to
> make them work it actually needs to do real stream separation on the
> device.  I.e. the file system consumes the temperature hints.

The device can guarantee the stream separation without knowing the temperat=
ure.

> > And if we come up with a better interface later on, we can make the cha=
nges
> then.
> > I really do not see the issue. If we were adding a temperature abstract=
ion now, I
> would agree with
> > You that we would need to cover the use-case you mention for FSs from t=
he
> beginning, but this
> > Is already here. Seems like a fair compromise to support current users.
>=20
> Again, I think the temperature hints at the syscall level aren't all
> bad.  There's definitively a few things I'd like to do better in hindsigh=
t,
> but that's not the point.  The problem is trying to turn them into
> stream separation all the way down in the driver, which is fundamentally
> broken.
>=20
> >   - How do we convince VFS folks to give us more space for hints at thi=
s point?
>=20
> What space from VFS folks do you need for hints?  And why does it
> matter?

We need space in the inode to store the hint ID.

Look, this feels like going in circles. All this gaslighting is what makes =
it difficult to=20
push patches when you just do not like the feature. It is the 3rd time I pr=
opose you=20
a way forward and you simply cannot provide any specific technical feedback=
 - in the=20
past email I posted several questions about the interface you seem to be ta=
lking=20
about and you explicitly omit that.



