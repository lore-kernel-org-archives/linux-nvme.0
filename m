Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2193C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 16:02:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A5723433
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 16:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5723433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ngtyp4LRwbE/qHBBCEbu4TmyV/8hKav7EsBg9syXNDY=; b=UeecOL6BM09UsYOEyC/dhpGBm
	RGtkiJ3Dko/9Fu1Y2MRFXkMpOpYY5nE0NN7SQwcf+pTL4r4vIAsp4mh8bvKUnMDy5rNtBXTW8xNss
	hQqSLDt4IrymRE5tzlWt1Kssn5lfAORScr9uI9GaGKf8PoxA4rjIRAsA0x5xf/wlDR8y5VZi0Az+7
	v13qSqHBjjoKo2JocEVhdIPXqmJEuXVHn0+V68Sugmb4v++Hz/blvCbnzVzBlfTJ1EWlZ9wW2ND1H
	ieuBuvlX6XJX30NpglzHVJ+aE5cw4IYO3czxxspsaBIExO7LVlXgkSXb5NK0bjkXomVjbiqxmW0iU
	wuvq914Og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn1ut-0002bE-GB; Wed, 09 Dec 2020 16:02:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn1uq-0002ZV-JD
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 16:02:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A974EAC9A;
 Wed,  9 Dec 2020 16:02:06 +0000 (UTC)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: Keith Busch <kbusch@kernel.org>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
References: <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
Date: Wed, 9 Dec 2020 17:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_110208_779501_9D363580 
X-CRM114-Status: GOOD (  17.92  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvOS8yMCA0OjUzIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBXZWQsIERlYyAwOSwg
MjAyMCBhdCAwMzoyMDo1N1BNICswMDAwLCBLbmlnaHQsIEZyZWRlcmljayB3cm90ZToKPj4gV2hl
biBhIG5hbWVzcGFjZSBpcyBjcmVhdGVkIChhbmQgY29udGFpbmVkIGluIGFuIEFOQSBHcm91cCks
IHRoZSBhY3QKPj4gb2YgY3JlYXRpbmcgdGhhdCBuYW1lc3BhY2UgcmVzdWx0cyBpbiBhIGNoYW5n
ZSB0byB0aGUgQU5BIExvZyBwYWdlIC0KPj4gdGhlcmVmb3JlIEFFTi4KPiAKPiBUaGF0IGlzIHdy
b25nOiBjcmVhdGluZyBhIG5hbWVzcGFjZSBkb2Vzbid0IGRvIGFueXRoaW5nIHRvIHRoZSBBTkEg
bG9nLgo+IE9ubHkgYXR0YWNoZWQgbmFtZXNwYWNlcyBhcHBlYXIgaW4gdGhlIGxvZy4gQ3JlYXRp
bmcgYSBuYW1lc3BhY2UKPiBkb2Vzbid0IHJlc3VsdCBpbiBhdXRvbWF0aWNhbGx5IGF0dGFjaGlu
ZyBpdCB0byBhbnkgY29udHJvbGxlci4KPiAKPiBZb3UgYXJlIHRoaW5raW5nIG9mIE5hbWVzcGFj
ZSBBdHRhY2ggZnJvbSBzZWN0aW9uIDUuMTksIGFuZCB0aGUgc3BlYwo+IGRvZXNuJ3QgZGVmaW5l
IGFueSBzcGVjaWFsIGV4Y2VwdGlvbnMgZm9yIGV2ZW50cyByZXN1bHRpbmcgZnJvbSAqdGhhdCoK
PiBjb21tYW5kLCB3aGljaCBpcyBhbHNvIHRoZSBjb21tYW5kIHRoYXQgdHJpZ2dlcmVkIHRoaXMg
dGhyZWFkLgo+IApBY3R1YWxseSwgbm8sIHdlJ3JlIG5vdCB0aGlua2luZyBhYm91dCAnTmFtZXNw
YWNlIEF0dGFjaCcuClRoaXMgaXMgYSBub3JtYWwgbmFtZXNwYWNlIGNyZWF0aW9uIG9uIHRoZSBj
b250cm9sbGVyIHNpZGUuCgpJIGRvIGFncmVlIHRoYXQgJ05hbWVzcGFjZSBBdHRhY2gnIHdvdWxk
IGhhdmUgZGlmZmVyZW50IGNvbnN0cmFpbnMgYW5kIApydWxlcyB1bmRlciB3aGljaCBBRU5zIHdp
bGwgYmUgc2VudCwgYnV0IHRoaXMgaXMgbm90IHdoYXQgb3VyIGluaXRpYWwgCnVzZS1jYXNlIHdh
cyBhYm91dC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAg
ICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8
cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
