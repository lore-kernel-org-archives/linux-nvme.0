Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8B7C352A1
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Dec 2022 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eoSuSWluSKCZdpWWhpUui2chIUEP7LoYoFOk3yrqMw=; b=g6z3YS1S/u+1joQTDmEzsqTVKt
	OdYYnIV0m6bURilVt8U9UGVBG2FzCMlgJZxChbxgR5mTt3NWRQt5eUF07RPoitROesRZl9A1XpdMZ
	X4KCd1pog3l6cZwCb9Zibae3o+gIInFvumiZw7aECI1g9b0y6dZerOfMSUz3+GjHbUsOVVmdBzhNQ
	bs/5uWFYhsC1+LOQCYkbk6loiJXidJNBg/R1xeZfdndVAXZH9erJuFKojMXbnuMlVKRV2lnOnyXNO
	dSiJqqniuIRxZ9TorhrUpoV6RcwKfbod42TxWOyZp5En6vkQuk8+tD4sYeDLCTl2UcTL1n9+enoAn
	Eaevdy2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1UcM-003vLg-6B; Sat, 03 Dec 2022 15:39:54 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p19uu-000N2E-GU
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 17:33:42 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 09:33:33 -0800
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::f5ad:7ba5:d6cc:6f21%3]) with mapi id 15.01.2375.034; Fri, 2 Dec 2022
 09:33:33 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
CC: Matthew Wilcox <willy@infradead.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org"
	<linux-raid@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "javier@javigon.com" <javier@javigon.com>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "dongli.zhang@oracle.com"
	<dongli.zhang@oracle.com>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>,
	"danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "jinpu.wang@cloud.ionos.com"
	<jinpu.wang@cloud.ionos.com>
Subject: RE: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHN/dRfjWV95kG4kItzDx62xa1xpq+AgOihlACAAJ5aAIAAwrsAgACBBAD//5Rf8A==
Date: Fri, 2 Dec 2022 17:33:33 +0000
Message-ID: <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
 <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_093340_566662_A8B222E4 
X-CRM114-Status: GOOD (  15.56  )
X-Mailman-Approved-At: Sat, 03 Dec 2022 07:39:50 -0800
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

> From: Keith Busch
> On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
> > On 12/1/22 20:39, Matthew Wilcox wrote:
> > > On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> > > > So nobody can get away with a lie.
> > >
> > > And yet devices do exist which lie.  I'm not surprised that vendors
> > > vehemently claim that they don't, or "nobody would get away with it".
> > > But, of course, they do.  And there's no way for us to find out if
> > > they're lying!

My guess, if true, is it's rationalized with the device is already
doing patrols in the background - why verify when it's already
been recently patrolled?
=20
> > >
> > But we'll never be able to figure that out unless we try.
> >
> > Once we've tried we will have proof either way.
>=20
> As long as the protocols don't provide proof-of-work, trying this
> doesn't really prove anything with respect to this concern.

I'm out of my depth here, but isn't VERIFY tightly related to PI and
at the heart of detecting SAN bit-rot? The proof of work can be via
end-to-end data protection. VERIFY has to actually read to detect bad
host generated PI guard/tags.  I'm assuming the PI checks can be
disabled for WRITE and enabled for VERIFY as the test.


