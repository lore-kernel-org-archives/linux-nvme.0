Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408FC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:59:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C6F611BD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C6F611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+C+vqjWEAMM3cNWbS2LctkVYOS1t2sopmHpcohCSl14=; b=CyuugiCuvw8uEuiO+a6RGPQI3
	XXCdP6Jf5iC6mtHb2t2mRIQWSOYoPvuTug8jz/+l6orY5r04u7eU8JOR8kbJGEHSbJYVP4N3796Lg
	eWzh78RrJWmxQ2PqeI1UBC4+sIoGA6fjG4oeQck858F5rI4uubLaIWbrxP6gOAdVQUGDa3o2Wy6uD
	274woZzndB6emhcK4eTpjoHUYSFWJeQP8dDNdyF8ne3F9HJ8VoodHZlzYa1HKPLmvnBFQePBS2ma/
	EWXhFB9EOJtOcOIUOVrrytbAov0rZJ8hrJT1f0yTy41mmk9Yz6Fo+gAHGNEkrQajT5PRv9rbDnAOq
	T2UttzBzw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lithO-00HETt-BB; Tue, 18 May 2021 06:59:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lithG-00HET9-Vy
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 06:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=35jxUP4xXIWZsYpF3fXPHKzNQzqay5mauyq3q+rrSW4=; b=qtPLPar4iMRDSg2QJrMSSzveK7
 NW9l2W1ndZQttVQ/zc9dn1aWfoydVkiuz0AqE3kN6HCNzREc29jc99Gas5vxj2O95ciz+pxAY4SY3
 owm6kWGl1aHpEOX3O+CxvYdtPXwpvFh/O++Oeq+GbJpgg6kwDT9+9UqjVwAWvf+h1yTeAPFN+EaJs
 x3M2dkj+fn4Gv4pYGVUcD3pCGfQP743SCwjLWUhQ/U+9TWEzOLi85ItJ1vxIyduFKPCB3w2ViboOC
 JZTZrhNsAnis/g7gmHRtDpMoEECVwduN/rDr3iABhc24MqJIdt7SKpy98fxdI7AuSrXYegM4usxZB
 kQYJ19JQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lith9-00EO0H-Vs
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 06:59:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 96225AD12;
 Tue, 18 May 2021 06:59:10 +0000 (UTC)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
Date: Tue, 18 May 2021 08:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_235912_338445_7F1B5866 
X-CRM114-Status: GOOD (  23.06  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xNy8yMSA3OjQ5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBXaGVuIGZhc3Rf
aW9fZmFpbF90bW8gaXMgc2V0IEkvTyB3aWxsIGJlIGFib3J0ZWQgd2hpbGUgcmVjb3ZlcnkgaXMK
Pj4gc3RpbGwgb25nb2luZy4gVGhpcyBjYXVzZXMgTUQgdG8gc2V0IHRoZSBuYW1lc3BhY2UgdG8g
ZmFpbGVkLCBhbmQKPj4gbm8gZnV0aGVyIEkvTyB3aWxsIGJlIHN1Ym1pdHRlZCB0byB0aGF0IG5h
bWVzcGFjZS4KPj4KPj4gSG93ZXZlciwgb25jZSB0aGUgcmVjb3Zlcnkgc3VjY2VlZHMgYW5kIHRo
ZSBuYW1lc3BhY2UgYmVjb21lcwo+PiBvcGVyYXRpb25hbCBhZ2FpbiB0aGUgTlZNZSBzdWJzeXN0
ZW0gZG9lc24ndCBzZW5kIGEgbm90aWZpY2F0aW9uLAo+PiBzbyBNRCBjYW5ub3QgYXV0b21hdGlj
YWxseSByZWluc3RhdGUgb3BlcmF0aW9uIGFuZCByZXF1aXJlcwo+PiBtYW51YWwgaW50ZXJhY3Rp
b24uCj4+Cj4+IFRoaXMgcGF0Y2ggd2lsbCBzZW5kIGEgS09CSl9DSEFOR0UgdWV2ZW50IHBlciBt
dWx0aXBhdGhlZCBuYW1lc3BhY2UKPj4gb25jZSB0aGUgdW5kZXJseWluZyBjb250cm9sbGVyIHRy
YW5zaXRpb25zIHRvIExJVkUsIGFsbG93aW5nIGFuIGF1dG9tYXRpYwo+PiBNRCByZWFzc2VtYmx5
IHdpdGggdGhlc2UgdWRldiBydWxlczoKPj4KPj4gL2V0Yy91ZGV2L3J1bGVzLmQvNjUtbWQtYXV0
by1yZS1hZGQucnVsZXM6Cj4+IFNVQlNZU1RFTSE9ImJsb2NrIiwgR09UTz0ibWRfZW5kIgo+Pgo+
PiBBQ1RJT04hPSJjaGFuZ2UiLCBHT1RPPSJtZF9lbmQiCj4+IEVOVntJRF9GU19UWVBFfSE9Imxp
bnV4X3JhaWRfbWVtYmVyIiwgR09UTz0ibWRfZW5kIgo+PiBQUk9HUkFNPSIvc2Jpbi9tZF9yYWlk
X2F1dG9fcmVhZGQuc2ggJGRldm5vZGUiCj4+IExBQkVMPSJtZF9lbmQiCj4+Cj4+IC9zYmluL21k
X3JhaWRfYXV0b19yZWFkZC5zaDoKPj4KPj4gTURBRE09L3NiaW4vbWRhZG0KPj4gREVWTkFNRT0k
MQo+Pgo+PiBleHBvcnQgJCgke01EQURNfSAtLWV4YW1pbmUgLS1leHBvcnQgJHtERVZOQU1FfSkK
Pj4KPj4gaWYgWyAteiAiJHtNRF9VVUlEfSIgXTsgdGhlbgo+PiDCoMKgwqDCoCBleGl0IDEKPj4g
ZmkKPj4KPj4gVVVJRF9MSU5LPSQocmVhZGxpbmsgL2Rldi9kaXNrL2J5LWlkL21kLXV1aWQtJHtN
RF9VVUlEfSkKPj4gTURfREVWTkFNRT0ke1VVSURfTElOSyMjKi99Cj4+IGV4cG9ydCAkKCR7TURB
RE19IC0tZGV0YWlsIC0tZXhwb3J0IC9kZXYvJHtNRF9ERVZOQU1FfSkKPj4gaWYgWyAteiAiJHtN
RF9NRVRBREFUQX0iIF0gOyB0aGVuCj4+IMKgwqDCoMKgIGV4aXQgMQo+PiBmaQo+PiBpZiBbICQo
Y2F0IC9zeXMvYmxvY2svJHtNRF9ERVZOQU1FfS9tZC9kZWdyYWRlZCkgIT0gMSBdOyB0aGVuCj4+
IMKgwqDCoMKgIGVjaG8gIiR7TURfREVWTkFNRX06IGFycmF5IG5vdCBkZWdyYWRlZCwgbm90aGlu
ZyB0byBkbyIKPj4gwqDCoMKgwqAgZXhpdCAwCj4+IGZpCj4+IE1EX1NUQVRFPSQoY2F0IC9zeXMv
YmxvY2svJHtNRF9ERVZOQU1FfS9tZC9hcnJheV9zdGF0ZSkKPj4gaWYgWyAke01EX1NUQVRFfSAh
PSAiY2xlYW4iIF0gOyB0aGVuCj4+IMKgwqDCoMKgIGVjaG8gIiR7TURfREVWTkFNRX06IGFycmF5
IHN0YXRlICR7TURfU1RBVEV9LCBjYW5ub3QgcmUtYWRkIgo+PiDCoMKgwqDCoCBleGl0IDEKPj4g
ZmkKPj4gTURfVkFSTkFNRT0iTURfREVWSUNFX2Rldl8ke0RFVk5BTUUjIyovfV9ST0xFIgo+PiBp
ZiBbICR7IU1EX1ZBUk5BTUV9ID0gInNwYXJlIiBdIDsgdGhlbgo+PiDCoMKgwqDCoCAke01EQURN
fSAtLW1hbmFnZSAvZGV2LyR7TURfREVWTkFNRX0gLS1yZS1hZGQgJHtERVZOQU1FfQo+PiBmaQo+
IAo+IElzIHRoaXMgYXV0by1yZWFkZCBzdHVmZiBnb2luZyB0byB1dGlsLWxpbnV4Pwo+IAo+Pgo+
PiBDaGFuZ2VzIHRvIHYyOgo+PiAtIEFkZCB1ZGV2IHJ1bGVzIGV4YW1wbGUgdG8gZGVzY3JpcHRp
b24KPj4gQ2hhbmdlcyB0byB2MToKPj4gLSB1c2UgZGlza191ZXZlbnQoKSBhcyBzdWdnZXN0ZWQg
YnkgaGNoCj4gCj4gVGhpcyBiZWxvbmdzIGFmdGVyIHRoZSAnLS0tJyBzZXBhcmF0b3IuLgo+IAo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgNyArKysrKy0tCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyAKPj4gYi9kcml2ZXJzL252bWUv
aG9zdC9tdWx0aXBhdGguYwo+PiBpbmRleCAwNTUxNzk2NTE3ZTYuLmVjYzk5YmQ1ZjhhZCAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4gKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4gQEAgLTEwMCw4ICsxMDAsMTEgQEAgdm9pZCBudm1l
X2tpY2tfcmVxdWV1ZV9saXN0cyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+PiDCoMKgwqDCoMKg
IGRvd25fcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+IMKgwqDCoMKgwqAgbGlzdF9m
b3JfZWFjaF9lbnRyeShucywgJmN0cmwtPm5hbWVzcGFjZXMsIGxpc3QpIHsKPj4gLcKgwqDCoMKg
wqDCoMKgIGlmIChucy0+aGVhZC0+ZGlzaykKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2Js
b2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVxdWV1ZV93b3JrKTsKPj4gK8KgwqDCoMKg
wqDCoMKgIGlmICghbnMtPmhlYWQtPmRpc2spCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnRpbnVlOwo+PiArwqDCoMKgwqDCoMKgwqAga2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVh
ZC0+cmVxdWV1ZV93b3JrKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChjdHJsLT5zdGF0ZSA9PSBO
Vk1FX0NUUkxfTElWRSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGlza191ZXZlbnQobnMt
PmhlYWQtPmRpc2ssIEtPQkpfQ0hBTkdFKTsKPj4gwqDCoMKgwqDCoCB9Cj4gCj4gSSBhc2tlZCB0
aGlzIG9uIHYxLCBpcyB0aGlzIG9ubHkgbmVlZGVkIGZvciBtcGF0aCBkZXZpY2VzPwoKWWVzOyB3
ZSBuZWVkIHRvIHNlbmQgdGhlIEtPQkpfQ0hBTkdFIGV2ZW50IG9uIHRoZSBtcGF0aCBkZXZpY2Ug
YXMgaXQncyAKbm90IGJhY2tlZCBieSBoYXJkd2FyZS4gVGhlIG9ubHkgbm9uLW11bHRpcGF0aGVk
IGRldmljZXMgSSd2ZSBzZWVuIHNvIApmYXIgYXJlIFBDSSBkZXZpY2VzIHdoZXJlIGV2ZW50cyBh
cmUgZ2VuZXJhdGVkIGJ5IHRoZSBQQ0kgZGV2aWNlIGl0c2VsZi4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
