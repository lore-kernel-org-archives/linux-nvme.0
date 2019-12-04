Return-Path: <SRS0=IJIS=Z2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C7AC43603
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 13:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C7A2077B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZiJpoA6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C7A2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wuTY7J3vgasmZedTW2o9r8Hf57peWJxdPZ/BWR/k49Y=; b=ZiJpoA6Igq68Lq9GSSURTP5qoP
	V+gXgYVLbOtaXm3oTVxUHPnSoDvU/G2HNPioa+p4cZ8QkF9UnZtEBLI47b2emr71MVN8fRNOOQ+U5
	C1i+Io4j6Yf+2N2eJRl3FLlD9nH5nJ6qFL0jnpx7FH50oJTiuhq7ddfvKGPvhz1gVtgIsJOd20u7Y
	/mX9Mq48vCzUqdwB7crZj9wepUzUsHvJzUDkQ98Bn1hNBHo1TSAEjklKRKdbP2oODhBOtev+tCj9n
	HgrZm7Zw2Gs0fZd0oi6IeYdRyEt1WhSc7p3sA7spn33cXEARhi8qHJ2+0JuGMglBQuto43TWeTauV
	SkufqJiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icUfW-00068o-FI; Wed, 04 Dec 2019 13:26:14 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icUfT-000610-1M
 for linux-nvme@lists.infradead.org; Wed, 04 Dec 2019 13:26:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 63890B133
 for <linux-nvme@lists.infradead.org>; Wed,  4 Dec 2019 13:26:07 +0000 (UTC)
Subject: Re: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
To: linux-nvme@lists.infradead.org
References: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
 <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
 <20191203210015.GA2691@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <04835a2e-1769-36c9-63b8-173f247c862b@suse.de>
Date: Wed, 4 Dec 2019 14:26:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191203210015.GA2691@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191204_052611_368693_CDF83906 
X-CRM114-Status: GOOD (  25.32  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvMy8xOSAxMDowMCBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gVHVlLCBEZWMgMDMs
IDIwMTkgYXQgMDU6Mzg6MDRQTSArMDAwMCwgTWVuZWdoaW5pLCBKb2huIHdyb3RlOgo+PiBUaGlz
IGlzIGFuIHVwZGF0ZSB0byBzYXkgdGhhdCBJJ3ZlIHRlc3RlZCB0aGlzIHBhdGNoIGFuZCBpdCB3
b3JrcyBhcyBleHBlY3RlZC4gCj4+Cj4+IFdoZW4gdGhlIGNvbnRyb2xsZXIgcmV0dXJucyBhIENv
bW1hbmQgSW50ZXJydXB0ZWQgc3RhdHVzIHRoZSByZXF1ZXN0IGlzIGF2b2lkcyBudm1lX2ZhaWxv
dmVyX3JlcSgpCj4+IGFuZCBnb2VzIGRvd24gdGhlIG52bWVfcmV0cnlfcmVxKCkgcGF0aCB3aGVy
ZSB0aGUgQ1JEIGlzIGltcGxlbWVudGVkIGFuZCB0aGUgY29tbWFuZCBpcyAKPj4gcmV0cmllZCBh
ZnRlciBhIGRlbGF5Lgo+Pgo+PiBJZiB0aGUgY29udHJvbGxlcnMgcmV0dXJucyBDb21tYW5kIElu
dGVycnVwdGVkIHRvbyBtYW55IHRpbWVzLCBhbmQgbnZtZV9yZXEocmVxKS0+cmV0cmllcwo+PiBy
dW5zIGRvd24sIHRoaXMgcmVzdWx0cyBpbiBhIGRldmljZSByZXNvdXJjZSBlcnJvciByZXR1cm5l
ZCB0byB0aGUgYmxvY2sgbGF5ZXIuICBCdXQgSSB0aGluayB3ZSdsbAo+PiBoYXZlIHRoaXMgcHJv
YmxlbSB3aXRoIGFueSBlcnJvci4gIAo+IAo+IFdoeSBpcyB0aGUgY29udHJvbGxlciByZXR1cm5p
bmcgdGhlIHNhbWUgZXJyb3Igc28gbWFueSB0aW1lcz8gQXJlIHdlCj4gbm90IHdhaXRpbmcgdGhl
IHJlcXVlc3RlZCBkZWxheSB0aW1lZD8gSWYgc28sIHRoZSBjb250cm9sbGVyIHRvbGQgdXMKPiBy
ZXRyeWluZyBzaG91bGQgYmUgc3VjY2Vzc2Z1bC4KPiAKPiBJdCBpcyBwb3NzaWJsZSB3ZSBraWNr
IHRoZSByZXF1ZXVlIGxpc3QgZWFybHkgaWYgb25lIGNvbW1hbmQgZXJyb3IKPiBoYXMgYSB2YWxp
ZCBDUkQsIGJ1dCBhIHN1YnNlcXVlbnQgcmV0cnlhYmxlIGNvbW1hbmQgZG9lcyBub3QuIElzIHRo
YXQKPiB3aGF0J3MgaGFwcGVuaW5nPwo+IApOby4gVGhlIHByb2JsZW0gaXMgdGhhdCBDUkQgbmVl
ZHMgdG8gYmUgb2JzZXJ2ZWQgX2luIGFsbCBjYXNlc18gd2hlbmV2ZXIKd2UgZ2V0IGEgQ09NTUFO
RCBJTlRFUlJVUFRFRCBzdGF0dXMuCkN1cnJlbnRseSB3ZSdyZSBvbmx5IG9ic2VydmluZyBDUkQg
d2hlbiBtdWx0aXBhdGhpbmcgaXMgX25vdF8gYWN0aXZlLAp3aGljaCBpcyB3cm9uZy4KCkFuZCB0
aGlzIGlzIHdoYXQgdGhlIHBhdGNoIGlzIHRyeWluZyB0byBhY2hpZXZlLgoKPiBJJ20ganVzdCBj
b25jZXJuZWQgYmVjYXVzZSBpZiB3ZSBqdXN0IHNraXAgY291bnRpbmcgdGhlIHJldHJ5LCBhIGJy
b2tlbgo+IGRldmljZSBjb3VsZCBoYXZlIHRoZSBkcml2ZXIgcmV0cnkgdGhlIHNhbWUgY29tbWFu
ZCBpbmRlZmluaXRlbHksIHdoaWNoCj4gb2Z0ZW4gbGVhdmVzIGEgdGFzayBpbiBhbiB1bmludGVy
cnVwdGlibGUgc2xlZXAgc3RhdGUgZm9yZXZlci4KPiAKT2gsIGJ1dCB3ZSdyZSBub3Qgc2tpcHBp
bmcgdGhlIHJldHJpZXM7IGluIGZhY3Qgd2UgZG8gX2VuYWJsZV8gcmV0cnkKY291bnRpbmcgd2l0
aCB0aGlzIHBhdGNoIGFzIHdlJ3JlIHNraXBwaW5nIHRoZSBudm1lX2ZhaWxvdmVyX3JlcSgpCmJy
YW5jaCBhbmQgbW92aW5nIHRvIG52bWVfcmV0cnlfcmVxKCkuCgo+PiAgICAgZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiAg
ICAgaW5kZXggOTY5NjQwNGE2MTgyLi4yNGRjOWVkMWExMWIgMTAwNjQ0Cj4+ICAgICAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gICAgICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYwo+PiAgICAgQEAgLTIzMCw2ICsyMzAsOCBAQCBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVf
ZXJyb3Jfc3RhdHVzKHUxNiBzdGF0dXMpCj4+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEJM
S19TVFNfTkVYVVM7Cj4+ICAgICAgICAgICAgIGNhc2UgTlZNRV9TQ19IT1NUX1BBVEhfRVJST1I6
Cj4+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEJMS19TVFNfVFJBTlNQT1JUOwo+PiAgICAg
KyAgICAgICBjYXNlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEOgo+PiAgICAgKyAgICAgICAgICAg
ICAgIHJldHVybiBCTEtfU1RTX0RFVl9SRVNPVVJDRTsKPiAKPiBKdXN0IGZvciB0aGUgc2FrZSBv
ZiBrZWVwaW5nIHRoaXMgY2hhbmdlIGlzbG90ZWQgdG8gbnZtZSwgcGVyaGFwcyB1c2UgYW4KPiBl
eGlzdGluZyBibGtfc3RhdHVzX3QgdmFsdWUgdGhhdCBhbHJlYWR5IG1hcHMgdG8gbm90IHBhdGgg
ZXJyb3IsIGxpa2UKPiBCTEtfU1RTX1RBUkdFVC4KPiAKSSBkb24ndCBtaW5kOyB3aGljaGV2ZXIg
d29ya3MgZm9yIHlvdS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJ
ICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlCQkJICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
