Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA507C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 07:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QPE6Z2C7bDKI1w/an0gLLTE3rvrHgBAFGfBjPI2dPr0=; b=yWMbiSVOB5g6Sy3OXqgCwEYY3p
	HQqOdZ/oFa4eE92Ddsd8qJgkGb+lzuVVApQPBFoS4j5F5X/kHiFDFCykkd6Pe0efFuXsTcdUXGpyH
	v4Ze4Nt2EdYZ5HjQ5Pt+TLMCLM6NDfh83gkRCnTL4Wh8kvSV3x+QG+65BJhmwyUGeNmCiXY4ifZso
	rGaRSbtI5HKNrIhsR/pMkz1ZzkvqBbC3TmcFY61YHEt5AHrKi1743KgSO6So09Le6PXDIMzOyfgg8
	XtLSqb6y+w8ptaXNOSEXAzkF1rpWliYXhUem8S61eLz6Lv6ySpPn1XprIx8DVk+zEBjNILe7LsE/P
	dQdEfhww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQSl-00F46I-RU; Sun, 09 Oct 2022 07:11:03 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohIA1-00ENDD-TJ
	for linux-nvme@lists.infradead.org; Sat, 08 Oct 2022 22:19:11 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-vsudmffZOXKo2YB6dC4dtQ-1; Sat, 08 Oct 2022 23:18:48 +0100
X-MC-Unique: vsudmffZOXKo2YB6dC4dtQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sat, 8 Oct
 2022 23:18:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Sat, 8 Oct 2022 23:18:45 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Jason A. Donenfeld'" <Jason@zx2c4.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
CC: Andreas Noever <andreas.noever@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "Catalin
 Marinas" <catalin.marinas@arm.com>, =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?=
	<christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Borkmann
	<daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Florian Westphal <fw@strlen.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller
	<deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen
	<chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski
	<kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara
	<jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe
	<axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet
	<corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh
	<kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver
	<elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>,
	"Paolo Abeni" <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"Richard Weinberger" <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
	"Theodore Ts'o" <tytso@mit.edu>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, "Thomas Gleixner" <tglx@linutronix.de>, Thomas
 Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon
	<will@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?=
	<toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara
	<jack@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v4 4/6] treewide: use get_random_u32() when possible
Thread-Topic: [PATCH v4 4/6] treewide: use get_random_u32() when possible
Thread-Index: AQHY2ncqUPYFdmCx0kGKfFsfF+6dcq4FEdQw
Date: Sat, 8 Oct 2022 22:18:45 +0000
Message-ID: <f1ca1b53bc104065a83da60161a4c7b6@AcuMS.aculab.com>
References: <20221007180107.216067-1-Jason@zx2c4.com>
 <20221007180107.216067-5-Jason@zx2c4.com>
In-Reply-To: <20221007180107.216067-5-Jason@zx2c4.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221008_151910_215106_7BD8AB7B 
X-CRM114-Status: GOOD (  14.03  )
X-Mailman-Approved-At: Sat, 08 Oct 2022 23:55:42 -0700
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDA3IE9jdG9iZXIgMjAyMiAxOTowMQ0K
PiANCj4gVGhlIHByYW5kb21fdTMyKCkgZnVuY3Rpb24gaGFzIGJlZW4gYSBkZXByZWNhdGVkIGlu
bGluZSB3cmFwcGVyIGFyb3VuZA0KPiBnZXRfcmFuZG9tX3UzMigpIGZvciBzZXZlcmFsIHJlbGVh
c2VzIG5vdywgYW5kIGNvbXBpbGVzIGRvd24gdG8gdGhlDQo+IGV4YWN0IHNhbWUgY29kZS4gUmVw
bGFjZSB0aGUgZGVwcmVjYXRlZCB3cmFwcGVyIHdpdGggYSBkaXJlY3QgY2FsbCB0bw0KPiB0aGUg
cmVhbCBmdW5jdGlvbi4gVGhlIHNhbWUgYWxzbyBhcHBsaWVzIHRvIGdldF9yYW5kb21faW50KCks
IHdoaWNoIGlzDQo+IGp1c3QgYSB3cmFwcGVyIGFyb3VuZCBnZXRfcmFuZG9tX3UzMigpLg0KPiAN
Ci4uLg0KPiBkaWZmIC0tZ2l0IGEvbmV0LzgwMi9nYXJwLmMgYi9uZXQvODAyL2dhcnAuYw0KPiBp
bmRleCBmNjAxMmY4ZTU5ZjAuLmMxYmI2N2UyNTQzMCAxMDA2NDQNCj4gLS0tIGEvbmV0LzgwMi9n
YXJwLmMNCj4gKysrIGIvbmV0LzgwMi9nYXJwLmMNCj4gQEAgLTQwNyw3ICs0MDcsNyBAQCBzdGF0
aWMgdm9pZCBnYXJwX2pvaW5fdGltZXJfYXJtKHN0cnVjdCBnYXJwX2FwcGxpY2FudCAqYXBwKQ0K
PiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgZGVsYXk7DQo+IA0KPiAtCWRlbGF5ID0gKHU2NCltc2Vj
c190b19qaWZmaWVzKGdhcnBfam9pbl90aW1lKSAqIHByYW5kb21fdTMyKCkgPj4gMzI7DQo+ICsJ
ZGVsYXkgPSAodTY0KW1zZWNzX3RvX2ppZmZpZXMoZ2FycF9qb2luX3RpbWUpICogZ2V0X3JhbmRv
bV91MzIoKSA+PiAzMjsNCj4gIAltb2RfdGltZXIoJmFwcC0+am9pbl90aW1lciwgamlmZmllcyAr
IGRlbGF5KTsNCj4gIH0NCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvODAyL21ycC5jIGIvbmV0Lzgw
Mi9tcnAuYw0KPiBpbmRleCAzNWUwNGNjNTM5MGMuLjNlOWZlOWY1ZDliZiAxMDA2NDQNCj4gLS0t
IGEvbmV0LzgwMi9tcnAuYw0KPiArKysgYi9uZXQvODAyL21ycC5jDQo+IEBAIC01OTIsNyArNTky
LDcgQEAgc3RhdGljIHZvaWQgbXJwX2pvaW5fdGltZXJfYXJtKHN0cnVjdCBtcnBfYXBwbGljYW50
ICphcHApDQo+ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBkZWxheTsNCj4gDQo+IC0JZGVsYXkgPSAo
dTY0KW1zZWNzX3RvX2ppZmZpZXMobXJwX2pvaW5fdGltZSkgKiBwcmFuZG9tX3UzMigpID4+IDMy
Ow0KPiArCWRlbGF5ID0gKHU2NCltc2Vjc190b19qaWZmaWVzKG1ycF9qb2luX3RpbWUpICogZ2V0
X3JhbmRvbV91MzIoKSA+PiAzMjsNCj4gIAltb2RfdGltZXIoJmFwcC0+am9pbl90aW1lciwgamlm
ZmllcyArIGRlbGF5KTsNCj4gIH0NCj4gDQoNCkFyZW4ndCB0aG9zZToNCglkZWxheSA9IHByYW5k
b21fdTMyX21heChtc2Vjc190b19qaWZmaWVzKHh4eF9qb2luX3RpbWUpKTsNCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==


