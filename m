Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A79C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:55:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417FE6128B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417FE6128B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yL07i903y87qyGqTEMP37DYHBIXe1XusjpADy+073t4=; b=Yk7qX86oUQMr8LrPMCZzt1Bi3F
	ofFYhuvPOUPoYiNokMbP+pC3amLwDSLTH/g6rxtEdaVxigC5HE00MaBSpKVFg5qZCUfBsGQmcqYz2
	fmgB5cipvr8gawhWFD4xMGyxmCpM+GQ/kPwLSOiYy0BtYP+aIqyfTOChp153O9ehFUbX4pce6vDLU
	Nw4YJuxvprZEXl0H4wK3K32X1lUAmA7qLYIluYC3o6ahVfd2bzRv/fqCEUPhFU13XFgYo8mmz8eay
	E/Aisjh08m2Rs2S/8sX92HY3CulY7glIXQNQeR195VputK3mFWx1kWH/0EK+gi1orKdcof4rehokx
	HXeUTaEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llpKG-00Cer5-7c; Wed, 26 May 2021 08:55:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpDS-00CbRa-EQ
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:48:42 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9724E218C1;
 Wed, 26 May 2021 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622018916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31ykjgg4+EiNeuM6bZyQmBjBqIMZDpBN9ATx6ONO8QQ=;
 b=AU+BzmmrrcRWrB4kv9r+Pwa5UyY+gzqxfksJz0V/3RoVoTuj/ei0AyzkBrXatJwVqxEdKQ
 PBbrY9JpELU7wgblEkUW6qDISXzIQ1tC2S5HK5irCsgU/4MJJ2l6lQSfMUd9aKT+5/TNGD
 4jpZ53WXjZlazXwM2SMmjDJnvrB3JqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622018916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31ykjgg4+EiNeuM6bZyQmBjBqIMZDpBN9ATx6ONO8QQ=;
 b=cgVJCShKuPYV06z0NSletPDaoxoqQlQIDYX+i95D0h5RjAWhbIYQELa59UxiF5DhKbTjF5
 kIzdZkBO+TwazlBg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 7A87011C9B;
 Wed, 26 May 2021 08:48:36 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
To: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
 <57030aa5-976c-8d0c-b6ee-7c69fb5f807c@nvidia.com>
 <20210526003900.GA3704949@dhcp-10-100-145-180.wdc.com>
 <BYAPR04MB4965873E107F598F6BD95B1386249@BYAPR04MB4965.namprd04.prod.outlook.com>
 <2426b42f-b345-2689-3bd8-8a24d6670ac2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <9014aebc-ebba-8f14-0d72-4bffdc63ee47@suse.de>
Date: Wed, 26 May 2021 10:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <2426b42f-b345-2689-3bd8-8a24d6670ac2@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_014838_716861_4D4D1516 
X-CRM114-Status: GOOD (  28.07  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8yNi8yMSAxMDo0MSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBUaGUgYmFk
IGNvbnRyb2xsZXIgc2hvdWxkIGJlIGZpeGVkLgo+Pj4+Cj4+Pj4gSW4gdGhlIHBhc3QsIEkndmUg
c2VudCBwYXRjaGVzIHRoYXQgY2hlY2sgdGhhdCBzcWlkIG1hdGNoIGluIG52bWUKPj4+PiBjcWUg
dG8KPj4+PiBwcm90ZWN0IGZhdWx0eSBkcml2ZXMgdGhhdCBtaWdodCBzZW5kCj4+Pj4gdGhlIGNv
bXBsZXRpb24gb24gYSB3cm9uZyBtc2l4Lgo+Pj4+Cj4+Pj4gTXkgcGF0Y2ggd2Fzbid0IGFjY2Vw
dGVkIHNpbmNlIGl0IGFkZGVkIGFuIGFkZGl0aW9uYWwgImlmIiBpbiB0aGUKPj4+PiBmYXN0IHBh
dGguCj4+Pj4KPj4+PiBOb3cgd2UncmUgYWRkaW5nIG11Y2ggbW9yZSBvcGVyYXRpb24gaW4gdGhl
IGZhc3QgcGF0aCBiZWNhdXNlIG9mCj4+Pj4gYnVnZ3kgY3RybAo+Pj4+ID8KPj4+IEkgc2hhcmVk
IHRoZSBzYW1lIHBlcmZvcm1hbmNlIGNvbmNlcm4gb24gdjEgb24gdGhpcyBzZXJpZXMuIEkgaGF2
ZW4ndAo+Pj4gYmVlbiBhYmxlIHRvIHRlc3QgdGhpcyBvbmUgeWV0IChvbmx5IGhhdmUgZW11bGF0
aW9uIGZvciB0d28gbW9yZSB3ZWVrcykuCj4+Pgo+Pj4gSGFubmVzIHNheXMgdGhlIGJ1ZyB0aGlz
IGNhdGNoZXMgaGFwcGVucyBmcmVxdWVudGx5IGVub3VnaCBvbiBUQ1AuIElmIHdlCj4+PiBkb24n
dCBjYXRjaCBpdCwgd2UgZ2V0IGtlcm5lbCBwYW5pYyBvciBjb3JydXB0aW9uLCBzbyB3ZSBkZWZp
bnRlbHkKPj4+IG5lZWQgdG8KPj4+IGRvIHNvbWV0aGluZy4gU2FnaSBjb3JyZWN0bHkgbm90ZWQg
dGhpcyB0eXBlIG9mIGJ1ZyBpcyBub3QgdW5pcXVlIHRvIFRDUAo+Pj4gKG9yIGV2ZW4gTlZNZSwg
Zm9yIHRoYXQgbWF0dGVyKSwgYnV0IGlmIHRoZXJlIGlzIGEgcGVyZm9ybWFuY2UgaW1wYWN0IG9u
Cj4+PiBQQ0ksIGFuZCBubyBvbmUgc28gZmFyIHJlcG9ydHMgc3VjaCBhbiBpc3N1ZSwgSSB3b3Vs
ZCBzdGlsbCByZWNvbW1lbmQKPj4+IHRoaXMgdHlwZSBvZiBtaXRpZ2F0aW9uIGJlIGlzb2xhdGVk
IHRvIHRyYW5zcG9ydHMgdGhhdCBhY3R1YWxseSBvYnNlcnZlCj4+PiBpbnZhbGlkIENRRXMuCj4+
PiDCoCAKPj4KPj4gUGxlYXNlIGRvIHRoYXQgaWYgcG9zc2libGUuCj4gCj4gSSBkaXNhZ3JlZSB3
aXRoIHRoYXQuIFRoZSBvcmlnaW5hbCByZXBvcnQgd2FzIGFib3V0IFRDUCwgYnV0IHRoYXQgaXMK
PiBwdXJlIGNvaW5jaWRlbmNlIGFzIGZhciBhcyBJJ20gY29uY2VybmVkLCBhcyBJIGluZGljYXRl
ZCBiZWZvcmUgdGhlcmUKPiBpcyBub3RoaW5nIFRDUCBzcGVjaWZpYyBhYm91dCB0aGlzLgo+IAo+
IFRvZGF5IHdlIGRvbid0IHByb3RlY3QgYWdhaW5zdCBzdWNoIGEgc2NlbmFyaW8uIEkgb3JpZ2lu
YWxseSBkaXNtaXNzZWQKPiB0aGlzIGlzc3VlIGFzIHdlIHNob3VsZCBwcm9iYWJseSBhZGRyZXNz
IHRoZSBhIGJ1Z2d5IGNvbnRyb2xsZXIsIGJ1dCBhbgo+IGFyZ3VtZW50IHdhcyBtYWRlIHRoYXQg
YSBidWdneSBjb250cm9sbGVyIHNob3VsZCBub3QgYmUgYWJsZSB0byBjcmFzaAo+IHRoZSBrZXJu
ZWwgYW5kIHdlIHNob3VsZCBoYXZlIGEgc2FmZS1ndWFyZCBmb3IgaXQsIHdoaWNoIGlzIGEgdmFs
aWQKPiBhcmd1bWVudCwgYnV0IHRoaXMgaXMgbm90IHRoZSB3b3JzdCB0aGF0IGNhbiBoYXBwZW4s
IHRoaXMgY291bGQgaGF2ZQo+IGNhdXNlZCBhIHNpbGVudCBkYXRhIGNvcnJ1cHRpb24gd2l0aCBh
IHNsaWdodGx5IGRpZmZlcmVudCB0aW1pbmcuIFNvCj4gaXQgc2VlbXMgYWJzb2x1dGVseSBhcHBy
b3ByaWF0ZSB0byBtZSBjb25zaWRlcmluZyB0aGUgcG9zc2libGUKPiBjb25zZXF1ZW5jZXMuCj4g
Cj4gVGhlIHdheSBJIHNlZSBpdCwgd2Ugc2hvdWxkIGRlY2lkZSB3aGVyZSB3ZSBzdGFuZCBoZXJl
LCBlaXRoZXIgd2UKPiBjb250aW51ZSB0byBpZ25vcmUgdGhpcyBwb3NzaWJsZSBwYW5pYy9kYXRh
LWNvcnJ1cHRpb24gKHdoaWNoIEkKPiBwZXJzb25hbGx5IHRoaW5rIHdvdWxkIGJlIHdyb25nKSwg
b3Igd2UgYWRkcmVzcyBpdCwgYW5kIGlmIHdlIGRvLAo+IHdlIHNob3VsZCBkbyBpdCBpbiB0aGUg
Y29ycmVjdCBwbGFjZSwgbm90IGxpbWl0IGl0IHRvIHRoZSBvYnNlcnZlZAo+IGNvbXBvbmVudC4K
PiAKSSBhbSBwZXJmZWN0bHkgZmluZSB3aXRoIGV4dGVuZGluZyB0aGlzIHRvIGFsbCB0cmFuc3Bv
cnRzOyB0aGUgcHJpbWUKcmVhc29uIHdoeSB3ZSBoYXZlbid0IHNlZW4gaXQgaXMgYmVjYXVzZSBv
dGhlciB0cmFuc3BvcnRzIGxpa2UgUkRNQSBvcgpGQyBhcmUgd2F5IG1vcmUgZW5jYXBzdWxhdGVk
LCBtYWtpbmcgaXQgaGFyZGVyIHRvIHJlY2VpdmUgaW52YWxpZCBwYWNrZXRzLgooTG9zc2xlc3Mg
ZmFicmljcyBhbmQgYWxsIHRoYXQpLgpUQ1AgaXMgZmFyIG1vcmUgbG9vc2VseSBzdHJ1Y3R1cmVk
LCBhbGxvd2luZyBmb3IgaW52YWxpZCBwYWNrZXRzIGFyZQptb3JlIGVhc2lseS4KQnV0IHJlYWxs
eSB0aGlzIGlzc3VlIGlzIHByZXNlbnQgaW4gYWxsIHRyYW5zcG9ydHMsIHNvIHdlIHNob3VsZCBi
ZQphZGRyZXNzaW5nIGl0IG9uIGEgZ2VuZXJhbCBsZXZlbC4KKEFuZCBpdCdzIG9ubHkgYSBtYXR0
ZXIgb2YgdGltZSB1bnRpbCBzb21lb25lIGJ1aWxkcyBjaGVhcG8gTlZNZS1wY2kKZGV2aWNlcyBo
YXZpbmcgc2ltaWxhciBpc3N1ZXMgOi0pCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJ
CSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
