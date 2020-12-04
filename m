Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C4AC4361A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 14:41:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC9822571
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC9822571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+39d/Ig1AT7Hv3dB09xiyPoGnprCtQdRm7QTZ3O/VFw=; b=sZ7BinYQfe8HHXU1pYaExtIbN
	qak+5dyH7hadh7Kdw/iywTg7Qejmw3TPOZZIiR0I2NwmVi+lVkeZVWI7IezFpw9e5QGOqV6Sj+Nv0
	myIkoHpLknSCO5SVoHHIBaF+c1DSboOMnH+fK5N+IKyNWKOctNZN8hl0gho3ZeNelptzuiTWJyBXp
	IuAlm+wr0PSHIlkuh6p9o5A5wl9pI8KQXgyhUFOOF4nYxnv0VcDUI2MuQ5bRvBuvTqW/3TtfwSACG
	wLe8zVqhBoZ1Twz/g8zzobeUn7PNCk7SFFhYNb3tLDFMKj7qdR7vw1QYzQtnBtogltgrKu6YUTxlu
	60J4IQMRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klCGX-0006qg-My; Fri, 04 Dec 2020 14:40:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klCGU-0006pM-Qu
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 14:40:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D2C2AAECB;
 Fri,  4 Dec 2020 14:40:50 +0000 (UTC)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: "George, Martin" <Martin.George@netapp.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
 <f2afd4dc-dd4b-d7d0-7421-11daac94b61c@grimberg.me>
 <d50766c203d849fa97003ef9585af47f059dc42c.camel@netapp.com>
 <20201123194337.GC2865091@dhcp-10-100-145-180.wdc.com>
 <acad8941fcf536a5db672b46f83115b723e9b721.camel@netapp.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1292bd00-fe1f-9838-d400-61ae3e3e1cc2@suse.de>
Date: Fri, 4 Dec 2020 15:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <acad8941fcf536a5db672b46f83115b723e9b721.camel@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_094055_033054_D73D6431 
X-CRM114-Status: GOOD (  22.21  )
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
Cc: "anton@lightbitslabs.com" <anton@lightbitslabs.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjYvMjAgNToxNiBQTSwgR2VvcmdlLCBNYXJ0aW4gd3JvdGU6Cj4gT24gTW9uLCAyMDIw
LTExLTIzIGF0IDExOjQzIC0wODAwLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4gT24gTW9uLCBOb3Yg
MjMsIDIwMjAgYXQgMDc6Mjk6MDVQTSArMDAwMCwgR2VvcmdlLCBNYXJ0aW4gd3JvdGU6Cj4+PiBP
biBNb24sIDIwMjAtMTEtMjMgYXQgMTE6MTYgLTA4MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+
Pj4gVGhpcyBsb29rcyBsaWtlIGEgZ29vZCBzaW1wbGUgc29sdXRpb24gdG8gbWUuLi4KPj4+Pgo+
Pj4+PiAtLS0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5j
Cj4+Pj4+IGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4+Pj4gaW5kZXggNzQ4OTZi
ZTQwYzE3Li4zMDBjZmY4YzYxNmQgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L211bHRpcGF0aC5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+
Pj4+IEBAIC02NjcsNiArNjY3LDggQEAgdm9pZCBudm1lX21wYXRoX2FkZF9kaXNrKHN0cnVjdCBu
dm1lX25zCj4+Pj4+ICpucywKPj4+Pj4gc3RydWN0IG52bWVfaWRfbnMgKmlkKQo+Pj4+PiAgICAg
ICAgICAgICAgICBpZiAoZGVzYy5zdGF0ZSkgewo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAg
IC8qIGZvdW5kIHRoZSBncm91cCBkZXNjOiB1cGRhdGUgKi8KPj4+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICBudm1lX3VwZGF0ZV9uc19hbmFfc3RhdGUoJmRlc2MsIG5zKTsKPj4+Pj4gKyAgICAg
ICAgICAgICB9IGVsc2Ugewo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgbnZtZV9yZWFkX2Fu
YV9sb2coY3RybCk7Cj4+Pgo+Pj4gU2hvdWxkbid0IHRoaXMgYmUgbnZtZV9yZWFkX2FuYV9sb2co
bnMtPmN0cmwpPwo+Pgo+PiBPb3BzLCBJIGp1c3QgZGlkIGEgcXVpY2sgY29weS1wYXN0ZS4gWW91
IGFyZSBjb3JyZWN0Lgo+IAo+IElmIHRoZXJlIGlzIG5vIGZ1cnRoZXIgZmVlZGJhY2ssIGNvdWxk
IHdlIG1vdmUgYWhlYWQgd2l0aCB0aGlzIGZpeD8gT3IKPiBkb2VzIGl0IG5lZWQgdG8gYmUgc2Vu
dCBhcyBhIHNlcGFyYXRlIHBhdGNoIGZpcnN0Pwo+IApJJ20gbm90IF90aGF0XyBoYXBweSB3aXRo
IHRoaXMgYXBwcm9hY2gsIGFzIHdlJ3JlIGRvaW5nIEkvTyBpbiB0aGUgCm1pZGRsZSBvZiBhbiB1
bnJlY292ZXJhYmxlIHNlY3Rpb247IGlmIHJlYWRpbmcgdGhlIEFOQSBsb2cgZmFpbHMgd2UgaGF2
ZSAKbm8gd2F5IHRvIHJlY292ZXIsIGFuZCBlbmQgdXAgd2l0aCBhIG5hbXNwYWNlIGluIGFuIHVu
ZGVmaW5lZCBzdGF0ZTsgCmFjdHVhbGx5IGl0IGxvb2tzIGFzIGlmIHRoZSBuYW1lc3BhY2Ugd2ls
bCB0aGVuIGJlIHByZXNlbnRlZCB0byB0aGUgT1MKd2l0aCBubyBBTkEgaW5mb3JtYXRpb24gd2hh
dHNvZXZlciwgYW5kIHdlIGNhbiBqdXN0IGhvcGUgdGhhdCBpdCdzIG5vdCAKcGFydCBvZiBhIG11
bHRpcGF0aGVkIG5hbWVzcGFjZSwgb3RoZXJ3aXNlIHdlJ3JlIHNjcmV3ZWQuCgpJJ2QgcmF0aGVy
IGhvb2sgaW4gdGhlIGFuYSBsb2cgcGFyc2luZyBpbnRvIHRoZSBBRU4gaGFuZGxpbmcgY29kZSwg
c3VjaCAKdGhhdCB3ZSdyZSByZS1yZWFkaW5nIHRoZSBBTkEgbG9nIGZvciBldmVyeSBOUyBDSEFO
R0VEIEFFTiBiZWZvcmUgCmNhbGxpbmcgbnZtZV9xdWV1ZV9zY2FuKCkuIFRoYXQgd2F5IHdlIGhh
dmUgYSBjbGVhciByZWNvdmVyeSBwYXRoIGFuZCAKd29uJ3QgbmVlZCB0byB3b3JyeSBhYm91dCBk
dXBsaWNhdGUgbmFtZXNwYWNlcy4KClBhdGNoIHRvIGZvbGxvdy4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
