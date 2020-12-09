Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21162C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:26:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA7A23B79
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA7A23B79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pv1zltUoTVS58tMVLfV0/VCRX+poeBKifS1Z1lJJhS4=; b=sBx9C+v6f/iU/sqWB1xWLlUsm
	WNHB54suribLMg8Xhs1fyp6BcVhC6ZZXo9c/i/VKehhQ1VzCgewXh6zfsQYcEc4noNwD1XuKQFseC
	f2VC9+W+IfoUmiop4wLN7DNL8GtFgbq6mOEyh4B+kVy5Wvl3gnNA0l2VWKCS4P/se8VtzOxY343M/
	E8JXzL/de0eeRDHjmitAb8MlbhWhHhv03xixr+s5Hp26yFnbOZYQ7a1iwIuKhpUOpNrMsInB3YTr5
	+D7Fk7dXjqljLb1srGglyOf6gmHSlmH8bSt16aiLvv3PNm+bxVuomO3x+rLagroEQMVVfTkWKJrqB
	FeYgkHLxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmtrl-0001uU-1W; Wed, 09 Dec 2020 07:26:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmtrh-0001tc-8p
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 07:26:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CA48CACC6;
 Wed,  9 Dec 2020 07:26:17 +0000 (UTC)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: Keith Busch <kbusch@kernel.org>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
References: <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB36241CA22888CE6A6C66A702F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209002002.GA28830@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <78cfce6b-8246-5701-c6e0-8a5678522e3d@suse.de>
Date: Wed, 9 Dec 2020 08:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209002002.GA28830@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_022621_572675_17ADBD97 
X-CRM114-Status: GOOD (  24.40  )
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

T24gMTIvOS8yMCAxOjIwIEFNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBXZWQsIERlYyAwOSwg
MjAyMCBhdCAxMjowNzowOEFNICswMDAwLCBLbmlnaHQsIEZyZWRlcmljayB3cm90ZToKPj4gSWYg
eW91IHdhbnQgdG8gbWFrZSB0aGF0IGEgdHJhbnNpdGlvbiwgdGhlbiBicmluZyBhIFRQQVIgdG8g
Y2hhbmdlIGl0Lgo+Pgo+PiBXaGVuIEFOQSBHcm91cHMgYXJlIGNyZWF0ZWQsIHRoZXkgYWxyZWFk
eSBoYXZlIGEgc3RhdGUuICBUaGVyZSBpcyBOTyB0cmFuc2l0aW9uOyB0aGVyZSBpcyBOTyBBRU4u
Cj4gCj4gVGhlIHJlcXVpcmVtZW50IGRvZXNuJ3QgZXZlbiBtZW50aW9uIHRoZSB3b3JkICJ0cmFu
c2l0aW9uIiwgc28gaXQncyBhCj4gbW9vdCBwb2ludC4gVGhlIHJlcXVpcmVtZW50IHNheXMgInVw
b24gZW50cnkiLiBXaGV0aGVyIHRoYXQgZW50cnkgb2NjdXJzCj4gYmVjYXVzZSBvZiBhIHRyYW5z
aXRpb24gdG8gaXQgb3IgYmVjYXVzZSBpdCBzcHJ1bmcgaW50byBleGlzdGVuY2UKPiBhbHJlYWR5
IGhhdmluZyBlbnRlcmVkIHRoYXQgc3RhdGUgaXMgbm90IGEgZGlzdGljaXRpb24gbWFkZSBpbiB0
aGUgc3BlYy4KPiBJZiB5b3Ugd2FudCB0aGF0IGRpc3RpY2l0aW9uIHRvIGJlIHdyaXR0ZW4gaW4g
c3BlYywgdGhlbiBmZWVsIGZyZWUgdG8KPiBicmluZyBhbiBFQ04gdG8gY2xhcmlmeSBpdC4KPiAK
V2hhdCBhcmUgeW91IGRpc2N1c3NpbmcgaGVyZT8KVGhlIG9yaWdpbmFsIHNpdHVhdGlvbiB3YXMg
dGhhdCBhIG5hbWVzcGFjZSB3YXMgY3JlYXRlZCB3aXRoaW4gYW4gCmV4aXN0aW5nIHN1YnN5c3Rl
bSBhbmQgZXhpc3RpbmcgQU5BIGdyb3VwcyBhbmQgbmFtZXNwYWNlcywgd2hlcmUgdGhlIG5ldyAK
bmFtZXNwYWNlIHdhcyBfbm90XyBwYXJ0IG9mIGFueSBvZiB0aGUgZXhpc3RpbmcgQU5BIGdyb3Vw
cy4KQW5kIHlvdSBhbHJlYWR5IGhhZCBhZ3JlZWQgdGhhdCBhIG5hbWVzcGFjZSBfY3JlYXRpb25f
ICh3aGljaCB0aGlzIG1vc3QgCmRlZmluaXRlbHkgaXMpIHNob3VsZCBub3Qgc2VuZCBBTkEgQUVO
cy4KClNvIHdoZXJlIGlzIHRoZSAndHJhbnNpdGlvbicgaGVyZT8gSXMgdGhpcyBkdWUgdG8gdGhl
IGZhY3QgdGhlIEFOQSBncm91cCAKY3JlYXRpb24gYW5kIG5hbWVzcGFjZSBjcmVhdGlvbiBtaWdo
dCBiZSB0d28gZGlzdGluY3QgZXZlbnRzPwoKQ2xlYXJseSwgdGhlIEFOQSBncm91cCBoYXMgdG8g
YmUgY3JlYXRlZCBhdCBvbmUgcG9pbnQuCkFuZCBuYW1lc3BhY2UgY3JlYXRpb24gbWlnaHQgYmUg
aGFwcGVuaW5nIGF0IGEgZGlmZmVyZW50IHRpbWUsIHRydWU7IGJ1dCAKdGhleSBtaWdodCBhbHNv
IGJlIGEgc2luZ2xlIGV2ZW50LgpJZiBpdCdzIGEgc2luZ2xlIGV2ZW50IHRoZW4gSSB0aGluayB3
ZSd2ZSBhbHJlYWR5IGFncmVlZCB0aGF0IEFOQSBjaGFuZ2UgCkFFTnMgd2lsbCBiZSBzdXBwcmVz
c2VkLgoKSSBkb24ndCB0aGluayBpdCdsbCBiZSBwb3NzaWJsZSB0byBjcmVhdGUgYW4gQU5BIGdy
b3VwIF9hZnRlcl8gY3JlYXRpbmcgCmEgbmFtZXNwYWNlLCBhcyB0aGUgZGVmaW5pdGlvbiBmb3Ig
dGhlIEFOQUdSUElEIGZpZWxkIGluIHRoZSAnbmFtZXNwYWNlIAppZGVudGlmeScgZGF0YSBzdHJ1
Y3R1cmUgc2F5czoKCiAgIFRoaXMgZmllbGQgaW5kaWNhdGVzIHRoZSBBTkEgR3JvdXAgSWRlbnRp
ZmllciBvZiB0aGUgQU5BIGdyb3VwCiAgKHJlZmVyIHRvIHNlY3Rpb24gOC4yMC4yKSBvZiB3aGlj
aCB0aGUgbmFtZXNwYWNlIGlzIGEgbWVtYmVyLgogIEVhY2ggbmFtZXNwYWNlIHRoYXQgaXMgYXR0
YWNoZWQgdG8gYSBjb250cm9sbGVyIHRoYXQgc3VwcG9ydHMKICBBc3ltbWV0cmljIE5hbWVzcGFj
ZSBBY2Nlc3MgUmVwb3J0aW5nIChyZWZlciB0byB0aGUgQ01JQyBmaWVsZCkKICBzaGFsbCByZXBv
cnQgYSB2YWxpZCBBTkFHUlBJRC4KCldoaWNoIHdvdWxkIHJlcXVpcmUgdXMgdG8gY3JlYXRlIHRo
ZSBBTkEgZ3JvdXAgcHJpb3IgdG8gdGhlIG5hbWVzcGFjZS4KQnV0IHRoZW4gd2UgY2Fubm90IHJl
cG9ydCB0aGUgZW1wdHkgQU5BIGdyb3VwIGFzIHBlciBkZWZpbml0aW9uIG9mIHRoZSAKQU5BIGxv
ZyBwYWdlOgoKICBOdW1iZXIgb2YgQU5BIEdyb3VwIERlc2NyaXB0b3JzOiBUaGlzIGZpZWxkIGlu
ZGljYXRlcyB0aGUgbnVtYmVyCiAgb2YgQU5BIEdyb3VwIERlc2NyaXB0b3JzIGF2YWlsYWJsZSBp
biB0aGUgbG9nIHBhZ2UuIFRoZSBsb2cgcGFnZQogIHNoYWxsIGNvbnRhaW4gb25lIEFOQSBHcm91
cCBEZXNjcmlwdG9yIGZvciBlYWNoIEFOQSBHcm91cCB0aGF0CiAgY29udGFpbnMgTmFtZXNwYWNl
cyB0aGF0IGFyZSBhdHRhY2hlZCB0byB0aGUgY29udHJvbGxlci4KClNvIGV2ZW4gaWYgeW91IGFy
ZSByaWdodCBhbmQgd2Ugd291bGQgaGF2ZSB0byBleHBlY3QgYW4gQU5BIEFFTiwgdGhlIGxvZyAK
cGFnZSB3b3VsZCBoYXZlIG5vIHdheSBvZiByZXBvcnRpbmcgaXQuIEFuZCB3ZSB3b3VsZCBlbmQg
dXAgaW4gZXhhY3RseSAKdGhlIHNhbWUgc2l0dWF0aW9uIGFzIHdlIGFyZSBub3csIG5hbWVseSBo
YXZpbmcgdG8gcmUtcmVhZCB0aGUgQU5BIGxvZyAKcGFnZSBhZnRlciBuYW1lc3BhY2UgY3JlYXRp
b24uCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVy
ZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
