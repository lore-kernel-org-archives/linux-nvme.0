Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D1C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 16:47:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A076C64F4E
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 16:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A076C64F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0T1KG1TL7v7T3kbr2y/8Q1HC48Y03OPMXnBV9G2ggbo=; b=s4RiheQQ9nZFcoDssOQ/ibMw/
	pUt5QP9LjHEwgfgev2CLoRM1ZjWXb0l1TtT3lbKkBc9WwJZqBjSL3Hk+qviN9il+azVXHRS0CjOZV
	EFOLdWRCl2KP5u+QKt2HxYUXNMa10Y4+GIS0gN5mFo50r+vjsagAD9O4b4aopXfXdnKg/wfr9gXRT
	9okyab7rMn7w/vYlv0XpIV1IE1i3cs4YM5s9Dgdal7FrTvyueiU5l6BRZgyCbsiQM3eM105F75TDl
	68d3t6v5nhg+HNcZMcEPJ+ZFe96+0ezukTWwNc0/29n+mCJh6Nq5B9YvkfiFoUJ49gea8Glb3S/jT
	WTN50JCQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGlh9-0003ul-Um; Mon, 01 Mar 2021 16:46:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGlh6-0003uL-VK
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 16:46:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B41CEAFA7;
 Mon,  1 Mar 2021 16:46:48 +0000 (UTC)
Subject: Re: [PATCH] nvme: add 'kato' sysfs attribute
To: "George, Martin" <Martin.George@netapp.com>,
 "keith.busch@wdc.com" <keith.busch@wdc.com>
References: <20210226075251.108025-1-hare@suse.de>
 <07b463679c97dd9e352530cfb5751c3e9a247f2b.camel@netapp.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c8336975-2051-2e44-afd7-9e3dc08ef526@suse.de>
Date: Mon, 1 Mar 2021 17:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <07b463679c97dd9e352530cfb5751c3e9a247f2b.camel@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_114653_541444_23B5897B 
X-CRM114-Status: GOOD (  23.08  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xLzIxIDQ6MzkgUE0sIEdlb3JnZSwgTWFydGluIHdyb3RlOgo+IE9uIEZyaSwgMjAyMS0w
Mi0yNiBhdCAwODo1MiArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBBZGQgYSAna2F0
bycgY29udHJvbGxlciBzeXNmcyBhdHRyaWJ1dGUgdG8gZGlzcGxheSB0aGUgY3VycmVudAo+PiBr
ZWVwLWFsaXZlIHRpbWVvdXQgdmFsdWUgKGlmIGFueSkuIFRoaXMgYWxsb3dzIHVzZXJzcGFjZSB0
byBpZGVudGlmeQo+PiBwZXJzaXN0ZW50IGRpc2NvdmVyeSBjb250cm9sbGVycywgYXMgdGhlc2Ug
d2lsbCBoYXZlIGEgbm9uLXplcm8KPj4gS0FUTyB2YWx1ZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYyB8IDIgKysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKPj4gaW5kZXggMWQ1ZmM4YTZmZDM3Li45YWQyMzQ3MmFjMTUgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPj4gQEAgLTM1NDcsNiArMzU0Nyw3IEBAIG52bWVfc2hvd19pbnRfZnVuY3Rpb24o
Y250bGlkKTsKPj4gICBudm1lX3Nob3dfaW50X2Z1bmN0aW9uKG51bWFfbm9kZSk7Cj4+ICAgbnZt
ZV9zaG93X2ludF9mdW5jdGlvbihxdWV1ZV9jb3VudCk7Cj4+ICAgbnZtZV9zaG93X2ludF9mdW5j
dGlvbihzcXNpemUpOwo+PiArbnZtZV9zaG93X2ludF9mdW5jdGlvbihrYXRvKTsKPj4KPj4gICBz
dGF0aWMgc3NpemVfdCBudm1lX3N5c2ZzX2RlbGV0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjb25zdAo+PiBjaGFyICpidWYsCj4+IEBAIC0zNzQ5LDYgKzM3NTAsNyBAQCBzdGF0aWMg
c3RydWN0IGF0dHJpYnV0ZSAqbnZtZV9kZXZfYXR0cnNbXSA9IHsKPj4gICAgICAgICAgJmRldl9h
dHRyX2N0cmxfbG9zc190bW8uYXR0ciwKPj4gICAgICAgICAgJmRldl9hdHRyX2Zhc3RfaW9fZmFp
bF90bW8uYXR0ciwKPj4gICAgICAgICAgJmRldl9hdHRyX3JlY29ubmVjdF9kZWxheS5hdHRyLAo+
PiArICAgICAgICZkZXZfYXR0cl9rYXRvLmF0dHIsCj4+ICAgICAgICAgIE5VTEwKPj4gICB9Owo+
Pgo+IAo+IFRoaXMgaXMgaGVscGZ1bCBpbmRlZWQuIEJ1dCBsb29rcyBsaWtlIHRoZSBhY3R1YWwg
a2F0byB2YWx1ZSBzZW50IGRvd24KPiB0aGUgd2lyZSBpcyBjdHJsLT5rYXRvICsgTlZNRV9LQVRP
X0dSQUNFLiBXb25kZXJpbmcgaWYgdGhhdCBtYXkgZW5kIHVwCj4gY29uZnVzaW5nIHRoZSBlbmQg
dXNlci4KPiAKRm9yIHRoYXQgSSBoYWQgYW5vdGhlciBwYXRjaCBzZW50LCAnbnZtZTogc2FuaXRp
emUgS0FUTyBzZXR0aW5nJy4KTWlnaHQgYmUgYW4gaWRlYSB0byByb2xsIHRoaXMgb25lIGludG8g
dGhhdCBzZXQgdG8gbWFrZSBpdCBjbGVhci4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5l
cyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBz
dXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJn
CkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5k
w7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
