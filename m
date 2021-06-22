Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC6C2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 09:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FB661351
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 09:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FB661351
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q28p5fVA68bT1xaOq3pxfCU7dTBJR1SwgmVF3SNnt/s=; b=totW4SWHygbQg2Xzdg9swFX7bV
	aKlKbWIwJ0rIWoC06ZL11/iew2TYOE5AeG1vAwWw8NhnXkqsGlPxcgdoLYu8DMazEiPUVg2OcYA5L
	gVa6LUZXWaosuAPTgobShoHgjSRwzkIk7ZNc4DVwAYbNwbHONOcvA9Qt1Ov/8NDzciwuJSrryo+xA
	+Skh/6ziEuQvdzgPJCjbv+hKFWpnxhKDccUx/2XEgl3iCX1cfnbAz/3N5HmzFd4DQOnBcndRjY0JU
	uOCQoVUoXZjd3TkedCrl3N8yL055aet+IOOiLPe/kjsUVTvnVsJJM5tDzy0A7/wFjmRErTnGMQjJE
	ds1wIJmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvcJi-006LX6-SP; Tue, 22 Jun 2021 09:03:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvcJg-006LW3-4g
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 09:03:33 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7BAC21982;
 Tue, 22 Jun 2021 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624352608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7H+uCKTws56HZlm1KLvJ3KXoUNMeB+3C/fnpe1Obvo=;
 b=KI6s3VY7RZy29FEr7cqdy6G8oK6HjCq65NRAb5uYoWT6l4yWoK6W+xH+svtdnYk8mHjeg8
 5CFsxteQTJfczsjhmGbfZ73vWLnre/LmQuzbPKA0EsNll73DWYMBXVx8DGqjUqyzZj4iYA
 YRLAWnQTl1I5re1WuL5WXTES2wbt7NU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624352608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7H+uCKTws56HZlm1KLvJ3KXoUNMeB+3C/fnpe1Obvo=;
 b=fLXPsVRsRavZgsoP3DFU+OWCbpyI0I9IDjs+lFQjo7y7TpY3eDzOSyZWd3+sku0zXo0Xbg
 rLyezPoAk9f8FNCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id B1C24118DD;
 Tue, 22 Jun 2021 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624352608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7H+uCKTws56HZlm1KLvJ3KXoUNMeB+3C/fnpe1Obvo=;
 b=KI6s3VY7RZy29FEr7cqdy6G8oK6HjCq65NRAb5uYoWT6l4yWoK6W+xH+svtdnYk8mHjeg8
 5CFsxteQTJfczsjhmGbfZ73vWLnre/LmQuzbPKA0EsNll73DWYMBXVx8DGqjUqyzZj4iYA
 YRLAWnQTl1I5re1WuL5WXTES2wbt7NU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624352608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7H+uCKTws56HZlm1KLvJ3KXoUNMeB+3C/fnpe1Obvo=;
 b=fLXPsVRsRavZgsoP3DFU+OWCbpyI0I9IDjs+lFQjo7y7TpY3eDzOSyZWd3+sku0zXo0Xbg
 rLyezPoAk9f8FNCg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 3tEzK2Cn0WAFHgAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 22 Jun 2021 09:03:28 +0000
Subject: Re: [PATCHv7] nvme: fix refcounting imbalance when all paths are down
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210622070140.22488-1-hare@suse.de>
 <6679737f-1af8-bc9e-5af1-ce3fac5b4d01@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a5baf9d1-47af-7a9a-e08f-f75c12429413@suse.de>
Date: Tue, 22 Jun 2021 11:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <6679737f-1af8-bc9e-5af1-ce3fac5b4d01@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_020332_393978_E130CD00 
X-CRM114-Status: GOOD (  25.38  )
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

T24gNi8yMi8yMSAxMDo1MiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPiAKPiBPbiA2LzIy
LzIxIDEyOjAxIEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFdoZW4gdGhlIGxhc3QgcGF0
aCB0byBhIG5zX2hlYWQgZHJvcHMgdGhlIGN1cnJlbnQgY29kZQo+PiByZW1vdmVzIHRoZSBuc19o
ZWFkIGZyb20gdGhlIHN1YnN5c3RlbSBsaXN0LCBidXQgd2lsbCBvbmx5Cj4+IGRlbGV0ZSB0aGUg
ZGlzayBpdHNlbGYgaWYgdGhlIGxhc3QgcmVmZXJlbmNlIHRvIHRoZSBuc19oZWFkCj4+IGRyb3Bz
LiBUaGlzIGlzIGNhdXNpbmcgYW4gcmVmY291bnRpbmcgaW1iYWxhbmNlIGVnIHdoZW4KPj4gYXBw
bGljYXRpb25zIGhhdmUgYSByZWZlcmVuY2UgdG8gdGhlIGRpc2ssIGFzIHRoZW4gdGhleSdsbAo+
PiBuZXZlciBnZXQgbm90aWZpZWQgdGhhdCB0aGUgZGlzayBpcyBpbiBmYWN0IGRlYWQuCj4+IFdp
dGggdGhpcyBwYXRjaCB3ZSBhcmUgY2FsbGluZyAnZGVsX2dlbmRpc2snIGFuZCByZW1vdmUgaXQK
Pj4gZnJvbSB0aGUgbGlzdCBvZiBuc19oZWFkcyBhdCB0aGUgc2FtZSB0aW1lLCBlbnN1cmluZyB0
aGF0Cj4+IHRoZSBkaXNrIGNhbiBiZSBwcm9wZXJseSByZW1vdmVkIGFuZCBhcHBsaWNhdGlvbnMg
Z2V0IHRoZQo+PiBhcHByb3ByaWF0ZSBub3RpZmljYXRpb25zLgo+Pgo+PiBDaGFuZ2VzIHRvIHY2
Ogo+PiAtIE1vdmUgdGhlIGxpc3RfZGVsKCkgaW50byBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0
aCgpCj4+IC0gRHJvcCB0aGUgdGVzdHMgZm9yIEdFTkhEX0ZMX1VQCj4+IENoYW5nZXMgdG8gdjU6
Cj4+IC0gU3luY2hyb25pemUgYmV0d2VlbiBudm1lX2luaXRfbnNfaGVhZCgpIGFuZAo+PiBudm1l
X21wYXRoX2NoZWNrX2xhc3RfcGF0aCgpCj4+IC0gQ2hlY2sgZm9yIHJlbW92ZWQgZ2VuZGlzayBp
biBudm1lX25zX2hlYWRfc3VibWl0X2JpbygpCj4+IENoYW5nZXMgdG8gdjQ6Cj4+IC0gQ2FsbCBk
ZWxfZ2VuZGlzaygpIGluIG52bWVfbXBhdGhfY2hlY2tfbGFzdF9wYXRoKCkgdG8gYXZvaWQgZGVh
ZGxvY2sKPj4gQ2hhbmdlcyB0byB2MzoKPj4gLSBTaW1wbGlmeSBpZigpIGNsYXVzZSB0byBkZXRl
Y3QgZHVwbGljYXRlIG5hbWVzcGFjZXMKPj4gQ2hhbmdlcyB0byB2MjoKPj4gLSBEcm9wIG1lbWNw
eSgpIHN0YXRlbWVudAo+PiBDaGFuZ2VzIHRvIHYxOgo+PiAtIEFsd2F5cyBjaGVjayBOU0lEcyBh
ZnRlciByZWF0dGFjaAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVA
c3VzZS5kZT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuY8KgwqDCoMKgwqAg
fMKgIDYgKy0tLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKystLS0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9udm1lLmjC
oMKgwqDCoMKgIHwgMTEgKystLS0tLS0tLS0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNl
cnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCBjN2VmMGI2
Njg0YjUuLjEwNjMyMmRhZmU0NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtMzc5OSw4ICszNzk5
LDYgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9jdHJsCj4+ICpjdHJs
LCB1bnNpZ25lZCBuc2lkLAo+PiDCoMKgIG91dF91bmxpbmtfbnM6Cj4+IMKgwqDCoMKgwqAgbXV0
ZXhfbG9jaygmY3RybC0+c3Vic3lzLT5sb2NrKTsKPj4gwqDCoMKgwqDCoCBsaXN0X2RlbF9yY3Uo
Jm5zLT5zaWJsaW5ncyk7Cj4+IC3CoMKgwqAgaWYgKGxpc3RfZW1wdHkoJm5zLT5oZWFkLT5saXN0
KSkKPj4gLcKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsX2luaXQoJm5zLT5oZWFkLT5lbnRyeSk7Cj4+
IMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZjdHJsLT5zdWJzeXMtPmxvY2spOwo+PiDCoMKgwqDC
oMKgIG52bWVfcHV0X25zX2hlYWQobnMtPmhlYWQpOwo+PiDCoMKgIG91dF9mcmVlX3F1ZXVlOgo+
PiBAQCAtMzgyMSw4ICszODE5LDYgQEAgc3RhdGljIHZvaWQgbnZtZV9uc19yZW1vdmUoc3RydWN0
IG52bWVfbnMgKm5zKQo+PiDCoCDCoMKgwqDCoMKgIG11dGV4X2xvY2soJm5zLT5jdHJsLT5zdWJz
eXMtPmxvY2spOwo+PiDCoMKgwqDCoMKgIGxpc3RfZGVsX3JjdSgmbnMtPnNpYmxpbmdzKTsKPj4g
LcKgwqDCoCBpZiAobGlzdF9lbXB0eSgmbnMtPmhlYWQtPmxpc3QpKQo+PiAtwqDCoMKgwqDCoMKg
wqAgbGlzdF9kZWxfaW5pdCgmbnMtPmhlYWQtPmVudHJ5KTsKPj4gwqDCoMKgwqDCoCBtdXRleF91
bmxvY2soJm5zLT5jdHJsLT5zdWJzeXMtPmxvY2spOwo+PiDCoCDCoMKgwqDCoMKgIHN5bmNocm9u
aXplX3JjdSgpOyAvKiBndWFyYW50ZWUgbm90IGF2YWlsYWJsZSBpbiBoZWFkLT5saXN0ICovCj4+
IEBAIC0zODQyLDcgKzM4MzgsNyBAQCBzdGF0aWMgdm9pZCBudm1lX25zX3JlbW92ZShzdHJ1Y3Qg
bnZtZV9ucyAqbnMpCj4+IMKgwqDCoMKgwqAgbGlzdF9kZWxfaW5pdCgmbnMtPmxpc3QpOwo+PiDC
oMKgwqDCoMKgIHVwX3dyaXRlKCZucy0+Y3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+IMKgIC3C
oMKgwqAgbnZtZV9tcGF0aF9jaGVja19sYXN0X3BhdGgobnMpOwo+PiArwqDCoMKgIG52bWVfbXBh
dGhfY2hlY2tfbGFzdF9wYXRoKG5zLT5oZWFkKTsKPj4gwqDCoMKgwqDCoCBudm1lX3B1dF9ucyhu
cyk7Cj4+IMKgIH0KPj4gwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0
aC5jCj4+IGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4gaW5kZXggMjM1NzNmZTNm
YzdkLi5iZjlkZmFlZmE3N2QgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRp
cGF0aC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+IEBAIC03NzEs
MjAgKzc3MSwzOCBAQCB2b2lkIG52bWVfbXBhdGhfYWRkX2Rpc2soc3RydWN0IG52bWVfbnMgKm5z
LAo+PiBzdHJ1Y3QgbnZtZV9pZF9ucyAqaWQpCj4+IMKgICNlbmRpZgo+PiDCoCB9Cj4+IMKgIC12
b2lkIG52bWVfbXBhdGhfcmVtb3ZlX2Rpc2soc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkKPj4g
K3ZvaWQgbnZtZV9tcGF0aF9jaGVja19sYXN0X3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVh
ZCkKPj4gwqAgewo+PiArwqDCoMKgIGJvb2wgbGFzdF9wYXRoID0gZmFsc2U7Cj4+IMKgwqDCoMKg
wqAgaWYgKCFoZWFkLT5kaXNrKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiAtwqDC
oMKgIGlmIChoZWFkLT5kaXNrLT5mbGFncyAmIEdFTkhEX0ZMX1VQKSB7Cj4+IC3CoMKgwqDCoMKg
wqDCoCBudm1lX2NkZXZfZGVsKCZoZWFkLT5jZGV2LCAmaGVhZC0+Y2Rldl9kZXZpY2UpOwo+PiAt
wqDCoMKgwqDCoMKgwqAgZGVsX2dlbmRpc2soaGVhZC0+ZGlzayk7ID4gKwo+PiArwqDCoMKgIC8q
IFN5bmNocm9uaXplIHdpdGggbnZtZV9pbml0X25zX2hlYWQoKSAqLwo+PiArwqDCoMKgIG11dGV4
X2xvY2soJmhlYWQtPnN1YnN5cy0+bG9jayk7Cj4+ICvCoMKgwqAgaWYgKGxpc3RfZW1wdHkoJmhl
YWQtPmxpc3QpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2RlbF9pbml0KCZoZWFkLT5lbnRy
eSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBsYXN0X3BhdGggPSB0cnVlOwo+PiDCoMKgwqDCoMKgIH0K
PiAKPiBXaGF0IGhhcHBlbnMgbm93IGlmIENPTkZJR19OVk1FX01VTFRJUEFUSCBpcyBub3Qgc2V0
PyBJJ20gbm90IHN1cmUgdGhpcwo+IHNob3VsZCBiZSBkb25lIGhlcmUuLi4KCkkgZG9uJ3QgbWlu
ZCBfd2hlcmVfIHRoaXMgY29kZSBlbmRzIHVwLgpBcyBsb25nIGFzIHdlIGNhbiBhZ3JlZSB0aGF0
IHdlIHNob3VsZCBkbyBib3RoLCBsaXN0X2RlbF9pbml0KCkgYW5kCmRlbF9nZW5kaXNrKCkgYXQg
dGhlIHNhbWUgdGltZSB3aGVuIHdlIGZpbmQgdGhhdCB0aGUgbGFzdCBwYXRoIGlzIGRlYWQuCkRv
IHdlPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAg
ICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
