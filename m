Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrT/Rf4GLqIy5Nspvhqy9FIotKPi6RETFRNj2doAAj4=; b=AlzCr1BBo8j24YrcXBd2n4L4i/
	+GNXDfZvJn/k7nQnteBaVnMNoWzftfbL2/IQHnJVUAnnCgbKgpsQDGHA1TcSZZ9KHJMSLkrk3f8Rr
	0neAmcTOui3+cQhy32LBBrTx+OnKAGZBD2tBMkC6cMzMVLDGnuybU40spzXcaorPAD/VquIUOMmso
	nl+B5kTA4fdbDSFscofepqu9LFv9yvOTgHp8aP1S0HvP2rdTmzuWYz2J4qZ8eNJtRrRja2RaMWOZQ
	NScO377BitCzamDVog47VU9yYWzNTvvoYnYW6CCzfxsxiKByoeG10Ot9EKeg8cBLVUJRoQNLZRAlX
	ke/fHWmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n03HG-00Air4-O1; Wed, 22 Dec 2021 15:11:38 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n03HD-00AiqG-58
 for linux-nvme@lists.infradead.org; Wed, 22 Dec 2021 15:11:36 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 22 Dec 2021 07:11:33 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::4822:8b9:76de:8b6]) by
 SJSMAIL01.us.kioxia.com ([fe80::4822:8b9:76de:8b6%3]) with mapi id
 15.01.2176.014; Wed, 22 Dec 2021 07:11:33 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "javier@javigon.com" <javier@javigon.com>, "anuj20.g@samsung.com"
 <anuj20.g@samsung.com>, "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>
Subject: RE: [RFC 02/13] nvme: wire-up support for async-passthru on
Thread-Topic: [RFC 02/13] nvme: wire-up support for async-passthru on
Thread-Index: Adf2q4Y1jNlE3svCRZSHuwnlq+XxWAAocZcAAAIa2KA=
Date: Wed, 22 Dec 2021 15:11:33 +0000
Message-ID: <1ef1f30f1b52498ba10c727a69f7612b@kioxia.com>
References: <2da62822fd56414d9893b89e160ed05c@kioxia.com>
 <20211222080220.GA21346@lst.de>
In-Reply-To: <20211222080220.GA21346@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.90.53.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_071135_240054_27254DCF 
X-CRM114-Status: GOOD (  11.22  )
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

> From: hch@lst.de <hch@lst.de>
> Sent: Wednesday, December 22, 2021 12:02 AM
>=20
> On Tue, Dec 21, 2021 at 09:16:27PM +0000, Clay Mayers wrote:
> > Message-ID: <20211220141734.12206-3-joshi.k@samsung.com>
> >
> > On 12/20/21 19:47:23 +0530, Kanchan Joshi wrote:
> > > Introduce handlers for fops->async_cmd(), implementing async
> > > passthru on char device (including the multipath one).
> > > The handlers supports NVME_IOCTL_IO64_CMD.
> > >
> > I commented on these two issues below in more detail at
> > https://github.com/joshkan/nvme-uring-pt/issues
>=20
> If you want people to read your comments send them here and not on some
> random website no one is reading.

Of course.  That's the site this patch was staged on before being submitted
here.  The comments there precede the posting here.


