Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB1DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zKlYbjeLuB7bA0pn24cz/1rON10LIqEFb6OUBcULHAE=; b=hRT4zjS5F/0qR/6+l7oPoC2yih
	z+CbLluII+aMTOyKeIZZeT3OF7lB9Xm041ktT8nUAMFS2skyz1BPcH1X2h7GguslMs3Z+ILphZ7AA
	Y4jf88WhcMYF2PZh4r/66BckEzJO+629h/f+YKgQGHHblccMZFXcYzrA8WNQNF432b2U/2m8P+SQv
	xDsgynJkDLCztmwGudczEF4i9Nfv1P9ywOmPUuOcnjA+c00ZVoiFmSk3H5Swnxz9Vvcc+Nh55KwvC
	SU7qcFvap34JRKEcDnG6G5TA86RDXIzIFWnLiM0Kvac0sCkkG5chRdCM+63XKQ5PMRC76ePtYHsX4
	XbQ1fzGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogqvS-009sBQ-KQ; Fri, 07 Oct 2022 17:14:18 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogjRk-008FLS-2T
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 09:15:09 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-165-SM2il4aTNXS-NQtWmWJl3A-1; Fri, 07 Oct 2022 10:14:58 +0100
X-MC-Unique: SM2il4aTNXS-NQtWmWJl3A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 7 Oct
 2022 10:14:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 7 Oct 2022 10:14:54 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever
	<andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= <christoph.boehmwalder@linbit.com>,
	Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, "Dave
 Airlie" <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu
	<herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, "Hugh
 Dickins" <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J .
 Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg
	<johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, "Jozsef
 Kadlecsik" <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook
	<keescook@chromium.org>, Marco Elver <elver@google.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Pablo
 Neira Ayuso" <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Richard Weinberger <richard@nod.at>,
	"Russell King" <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson
	<ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui
	<kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov
	<yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
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
	<toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Subject: RE: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Thread-Topic: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Thread-Index: AQHY2asa0LDp17FxT0u8eu+L+6kCF64CocNw
Date: Fri, 7 Oct 2022 09:14:54 +0000
Message-ID: <e0c127f9e80146c19fab9f987bb2f588@AcuMS.aculab.com>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
 <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
 <f10fcfbf-2da6-cf2d-6027-fbf8b52803e9@csgroup.eu>
 <6396875c-146a-acf5-dd9e-7f93ba1b4bc3@csgroup.eu>
In-Reply-To: <6396875c-146a-acf5-dd9e-7f93ba1b4bc3@csgroup.eu>
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
X-CRM114-CacheID: sfid-20221007_021508_386315_64E31C4B 
X-CRM114-Status: GOOD (  14.41  )
X-Mailman-Approved-At: Fri, 07 Oct 2022 10:14:12 -0700
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwNiBPY3RvYmVyIDIwMjIgMTg6NDMNCi4u
Lg0KPiBCdXQgdGFraW5nIGludG8gYWNjb3VudCB0aGF0IHNwIG11c3QgcmVtYWluIDE2IGJ5dGVz
IGFsaWduZWQsIHdvdWxkIGl0DQo+IGJlIGJldHRlciB0byBkbyBzb21ldGhpbmcgbGlrZSA/DQo+
IA0KPiAJc3AgLT0gcHJhbmRvbV91MzJfbWF4KFBBR0VfU0laRSA+PiA0KSA8PCA0Ow0KDQpUaGF0
IG1ha2VzIG1lIHRoaW5rLi4uDQpJZiBwcmFuZG9tX3UzMl9tYXgoKSBpcyBwYXNzZWQgYSAoY29u
c3RhbnQpIHBvd2VyIG9mIDIgaXQgZG9lc24ndA0KbmVlZCB0byBkbyB0aGUgbXVsdGlwbHksIGl0
IGNhbiBqdXN0IGRvIGEgc2hpZnQgcmlnaHQuDQoNCkRvZXNuJ3QgaXQgYWxzbyBhbHdheXMgZ2V0
IGEgMzJiaXQgcmFuZG9tIHZhbHVlPw0KU28gYWN0dWFsbHkgZ2V0X3JhbmRvbV91MzIoKSAmIFBB
R0VfTUFTSyAmIH4weGYgaXMgZmFzdGVyIQ0KDQpXaGVuIFBBR0VfU0laRSBpcyA0aywgUEFHRV9T
SVpFID4+IDQgaXMgMjU2IHNvIGl0IGNvdWxkIHVzZToNCglnZXRfcmFtZG9tX3U4KCkgPDwgNA0K
DQpZb3UgYWxzbyBzZWVtIHRvIGhhdmUgcmVtb3ZlZCBwcmFuZG9tX3UzMigpIGluIGZhdm91ciBv
Zg0KZ2V0X3JhbmRvbV91MzIoKSBidXQgaGF2ZSBhZGRlZCBtb3JlIHByYW5kb21feHh4eCgpIGZ1
bmN0aW9ucy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


