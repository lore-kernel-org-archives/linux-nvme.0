Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED1C433ED
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:29:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634D56101A
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634D56101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wh6WLomjd935SKfbZeyiYFMmu90oia3HGrKHuCjVf6Q=; b=b09wgjTAWZta8YGfwngx0dJ+/
	s/LhfwPgIl0iuTvPD1hJCtwWHz/Dq9qCYvu7NWfh8xb/p/2s6qfJ53T5iosJYMe6MlrU9hmpUNnNr
	iIQMj5hJr4Xqs+6tlIlFTsRmaCnOjC2U+3yO6J9PWBFexLslahuQJA0S3qn8Z4LWHlJl+P44Awd4k
	BiGnIiiDorwBlWUuP8pR3JY9w1Atzs2DJBKqHem67KGjTNenNWcm0qehPi27Zm+D6NeNE5AiIPY1W
	0B6ZAqzFLNS8p6x3ovVYDES6X05W61twLCwZZWunKiqz1qD+V3kbgidnEPAtxg5sYT4i7B+H07mcm
	OzDrJaqLg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAIE-00Bfwn-E6; Sun, 02 May 2021 11:29:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAI9-00BfwO-NC
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:29:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Emr2hbixsGecpXtZlrVTm605GRksalmoNMWhpME1TKU=; b=O3huONSpBqIwQR/yDyE89O07wE
 koh+IxWISaxCoNDWebpvpzVXWxsigbVflG3ZTVMvo8adGwuO+pbDin/KI/ukjRCt3x1WFh3s4x1Dm
 x+6TxVMkmNGNYhV+4u0Sv40enn7HPSnRmuyro4+6hZT/KB5EPkhurskcBAAFKDEbSo9N4A4h8Quef
 f90LH7jsjt9fugTeog5Qfzc3qVCSd0ChgxXJm4yGltikobNSH50jnFHOC50smiBfcVuSq/nR/aiUM
 G229qAvk4OBMLCFEJnIfVp8j1qS1M0Oq6nHSMB2o2WrBH/bxAD1jULTaDZMTVrM6YwttNiGfe/u+6
 fmQx62TQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAI6-002V3P-R9
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:29:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7C363AE38;
 Sun,  2 May 2021 11:29:37 +0000 (UTC)
Subject: Re: [RFC PATCH v4 18/27] qedn: Add qedn_claim_dev API support
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com,
 Nikolay Assa <nassa@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-19-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <049e436b-d166-ebdd-5442-f616e7007d0e@suse.de>
Date: Sun, 2 May 2021 13:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-19-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_042939_193490_6AE22E12 
X-CRM114-Status: GOOD (  24.49  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IE5pa29sYXkgQXNz
YSA8bmFzc2FAbWFydmVsbC5jb20+Cj4gCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBxZWRu
X2NsYWltX2RldigpIG5ldHdvcmsgc2VydmljZSB3aGljaCB0aGUKPiBvZmZsb2FkIGRldmljZSAo
cWVkbikgaXMgdXNpbmcgdGhyb3VnaCB0aGUgcGFpcmVkIG5ldC1kZXZpY2UgKHFlZGUpLgo+IHFl
ZG5fY2xhaW1fZGV2KCkgcmV0dXJucyB0cnVlIGlmIHRoZSBJUCBhZGRyKElQdjQgb3IgSVB2Nikg
b2YgdGhlIHRhcmdldAo+IHNlcnZlciBpcyByZWFjaGFibGUgdmlhIHRoZSBuZXQtZGV2aWNlIHdo
aWNoIGlzIHBhaXJlZCB3aXRoIHRoZQo+IG9mZmxvYWRlZCBkZXZpY2UuCj4gCj4gQWNrZWQtYnk6
IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBO
aWtvbGF5IEFzc2EgPG5hc3NhQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFByYWJoYWth
ciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE9ta2Fy
IEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFs
IEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZWwg
RWxpb3IgPGFlbGlvckBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxz
bWFsaW5AbWFydmVsbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuLmgg
ICAgICB8ICA0ICsrKwo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9tYWluLmMgfCA0MiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaHcvcWVkbi9xZWRuLmggYi9kcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuLmgKPiBpbmRleCBj
MWFjMTdlYWJjYjcuLjdlZmUyMzY2ZWI3YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaHcv
cWVkbi9xZWRuLmgKPiArKysgYi9kcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuLmgKPiBAQCAtOCw2
ICs4LDEwIEBACj4gICAKPiAgICNpbmNsdWRlIDxsaW51eC9xZWQvcWVkX2lmLmg+Cj4gICAjaW5j
bHVkZSA8bGludXgvcWVkL3FlZF9udm1ldGNwX2lmLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9xZWQv
cWVkX252bWV0Y3BfaXBfc2VydmljZXNfaWYuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3FlZC9xZWRf
Y2hhaW4uaD4KPiArI2luY2x1ZGUgPGxpbnV4L3FlZC9zdG9yYWdlX2NvbW1vbi5oPgo+ICsjaW5j
bHVkZSA8bGludXgvcWVkL252bWV0Y3BfY29tbW9uLmg+Cj4gICAKPiAgIC8qIERyaXZlciBpbmNs
dWRlcyAqLwo+ICAgI2luY2x1ZGUgIi4uLy4uL2hvc3QvdGNwLW9mZmxvYWQuaCIKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9tYWluLmMgYi9kcml2ZXJzL252bWUvaHcv
cWVkbi9xZWRuX21haW4uYwo+IGluZGV4IGUzZThlMzY3NmI3OS4uNTIwMDdkMzU2MjJkIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ody9xZWRuL3FlZG5fbWFpbi5jCj4gKysrIGIvZHJpdmVy
cy9udm1lL2h3L3FlZG4vcWVkbl9tYWluLmMKPiBAQCAtMjcsOSArMjcsNDcgQEAgc3RhdGljIGlu
dAo+ICAgcWVkbl9jbGFpbV9kZXYoc3RydWN0IG52bWVfdGNwX29mbGRfZGV2ICpkZXYsCj4gICAJ
ICAgICAgIHN0cnVjdCBudm1lX3RjcF9vZmxkX2N0cmxfY29uX3BhcmFtcyAqY29ubl9wYXJhbXMp
Cj4gICB7Cj4gLQkvKiBQbGFjZWhvbGRlciAtIHFlZG5fY2xhaW1fZGV2ICovCj4gKwlzdHJ1Y3Qg
cGNpX2RldiAqcWVkZV9wZGV2ID0gTlVMTDsKPiArCXN0cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0g
TlVMTDsKPiArCXUxNiB2bGFuX2lkID0gMDsKPiArCWludCByYyA9IDA7Cj4gICAKPiAtCXJldHVy
biAwOwo+ICsJLyogcWVkbiB1dGlsaXplcyBob3N0IG5ldHdvcmsgc3RhY2sgdGhyb3VnaCBwYWly
ZWQgcWVkZSBkZXZpY2UgZm9yCj4gKwkgKiBub24tb2ZmbG9hZCB0cmFmZmljLiBGaXJzdCB3ZSB2
ZXJpZnkgdGhlcmUgaXMgdmFsaWQgcm91dGUgdG8gcmVtb3RlCj4gKwkgKiBwZWVyLgo+ICsJICov
Cj4gKwlpZiAoY29ubl9wYXJhbXMtPnJlbW90ZV9pcF9hZGRyLnNzX2ZhbWlseSA9PSBBRl9JTkVU
KSB7Cj4gKwkJcmMgPSBxZWRfcm91dGVfaXB2NCgmY29ubl9wYXJhbXMtPmxvY2FsX2lwX2FkZHIs
Cj4gKwkJCQkgICAgJmNvbm5fcGFyYW1zLT5yZW1vdGVfaXBfYWRkciwKPiArCQkJCSAgICAmY29u
bl9wYXJhbXMtPnJlbW90ZV9tYWNfYWRkciwKPiArCQkJCSAgICAmbmRldik7Cj4gKwl9IGVsc2Ug
aWYgKGNvbm5fcGFyYW1zLT5yZW1vdGVfaXBfYWRkci5zc19mYW1pbHkgPT0gQUZfSU5FVDYpIHsK
PiArCQlyYyA9IHFlZF9yb3V0ZV9pcHY2KCZjb25uX3BhcmFtcy0+bG9jYWxfaXBfYWRkciwKPiAr
CQkJCSAgICAmY29ubl9wYXJhbXMtPnJlbW90ZV9pcF9hZGRyLAo+ICsJCQkJICAgICZjb25uX3Bh
cmFtcy0+cmVtb3RlX21hY19hZGRyLAo+ICsJCQkJICAgICZuZGV2KTsKPiArCX0gZWxzZSB7Cj4g
KwkJcHJfZXJyKCJhZGRyZXNzIGZhbWlseSAlZCBub3Qgc3VwcG9ydGVkXG4iLAo+ICsJCSAgICAg
ICBjb25uX3BhcmFtcy0+cmVtb3RlX2lwX2FkZHIuc3NfZmFtaWx5KTsKPiArCj4gKwkJcmV0dXJu
IGZhbHNlOwo+ICsJfQo+ICsKPiArCWlmIChyYykKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICsJ
cWVkX3ZsYW5fZ2V0X25kZXYoJm5kZXYsICZ2bGFuX2lkKTsKPiArCWNvbm5fcGFyYW1zLT52bGFu
X2lkID0gdmxhbl9pZDsKPiArCj4gKwkvKiByb3V0ZSBmb3VuZCB0aHJvdWdoIG5kZXYgLSB2YWxp
ZGF0ZSB0aGlzIGlzIHFlZGUqLwo+ICsJcWVkZV9wZGV2ID0gcWVkX3ZhbGlkYXRlX25kZXYobmRl
dik7Cj4gKwlpZiAoIXFlZGVfcGRldikKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICsJZGV2LT5x
ZWRlX3BkZXYgPSBxZWRlX3BkZXY7Cj4gKwlkZXYtPm5kZXYgPSBuZGV2Owo+ICsKPiArCXJldHVy
biB0cnVlOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW50IHFlZG5fY3JlYXRlX3F1ZXVlKHN0cnVj
dCBudm1lX3RjcF9vZmxkX3F1ZXVlICpxdWV1ZSwgaW50IHFpZCwKPiAKUmV2aWV3ZWQtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJl
QHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1l
bmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
