Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D93C4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 15:15:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE22422C9C
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 15:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE22422C9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4V3fF4KquMbYGqLI2ucLUsoqMgO5FDOzDwt+fXA42Ak=; b=DZpalaH8ifeUcS9V0wgLy1fbP
	Hv2zBya3SC8IT8NNYj4+hz21pMK3Lj9/6y7YraWws1fuEt0QBivULX44Ykt2P3HypFA0WjefsduT1
	LW4NZePqIgmM9yQf2OzISrLxoytUJoG1CfElqgdffy1qOMR8nDOmtsjyDwuxMx4oU9gUGnsBHm+Ob
	4LDIliX/i6ITK9rCLH0EiZYVVPPxLOWO4TF9ebJY5owjMtf5lVHlZ0nFC+RuLvYohR/AZUwif35LK
	Xvn+3Y1Vc6Wvb5hT4DGyO6sja3msZZZSDPnyRjLoHUfwJfmEzEjAezIQZfKadu+ZNj/jJPL2bZcjK
	MCRDFbQ9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knjAI-0001la-Ix; Fri, 11 Dec 2020 14:12:58 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knjAH-0001l2-29
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 14:12:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7D0D9AC10;
 Fri, 11 Dec 2020 14:12:54 +0000 (UTC)
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
To: Enzo Matsumiya <ematsumiya@suse.de>, linux-nvme@lists.infradead.org
References: <20201209213228.5044-1-ematsumiya@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
Date: Fri, 11 Dec 2020 15:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209213228.5044-1-ematsumiya@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_091257_227565_36E22837 
X-CRM114-Status: GOOD (  26.97  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvOS8yMCAxMDozMiBQTSwgRW56byBNYXRzdW1peWEgd3JvdGU6Cj4gRml4IGEgcG9zc2li
bGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdoZW4gdHJ5aW5nIHRvIHJlYWQKPiBod21vbiBz
eXNmcyBlbnRyaWVzIGFzc29jaWF0ZWQgdG8gTlZNZS1vRiBkZXZpY2VzIHRoYXQgd2VyZQo+IGhv
dC1yZW1vdmVkIG9yIGRpc2Nvbm5lY3RlZC4KPiAKPiBVbnJlZ2lzdGVyIHRoZSBOVk1lIGh3bW9u
IGRldmljZSB1cG9uIGNvbnRyb2xsZXIgdGVhcmRvd24KPiAobnZtZV9zdG9wX2N0cmwoKSkuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogRW56byBNYXRzdW1peWEgPGVtYXRzdW1peWFAc3VzZS5kZT4KPiAt
LS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAgfCAxICsKPiAgIGRyaXZlcnMvbnZtZS9o
b3N0L2h3bW9uLmMgfCA4ICsrKysrKysrCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggIHwg
MiArKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+
IGluZGV4IDlhMjcwZTQ5ZGYxNy4uYmVjYzgwYTBjM2I4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC00
MzQ0LDYgKzQzNDQsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChudm1lX2NvbXBsZXRlX2FzeW5jX2V2
ZW50KTsKPiAgIAo+ICAgdm9pZCBudm1lX3N0b3BfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
KQo+ICAgewo+ICsJbnZtZV9od21vbl9leGl0KGN0cmwpOwo+ICAgCW52bWVfbXBhdGhfc3RvcChj
dHJsKTsKPiAgIAludm1lX3N0b3Bfa2VlcF9hbGl2ZShjdHJsKTsKPiAgIAlmbHVzaF93b3JrKCZj
dHJsLT5hc3luY19ldmVudF93b3JrKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qv
aHdtb24uYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMKPiBpbmRleCA1NTJkYmMwNDU2N2Iu
LjdmNjJjY2E0YzU3NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9od21vbi5jCj4g
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvaHdtb24uYwo+IEBAIC03MSw2ICs3MSw5IEBAIHN0YXRp
YyBpbnQgbnZtZV9od21vbl9yZWFkKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBod21vbl9zZW5z
b3JfdHlwZXMgdHlwZSwKPiAgIAlpbnQgdGVtcDsKPiAgIAlpbnQgZXJyOwo+ICAgCj4gKwlpZiAo
ZGF0YS0+Y3RybC0+c3RhdGUgIT0gTlZNRV9DVFJMX0xJVkUpCj4gKwkJcmV0dXJuIC1FQUdBSU47
Cj4gKwo+ICAgCS8qCj4gICAJICogRmlyc3QgaGFuZGxlIGF0dHJpYnV0ZXMgd2hpY2ggZG9uJ3Qg
cmVxdWlyZSB1cyB0byByZWFkCj4gICAJICogdGhlIHNtYXJ0IGxvZy4KPiBAQCAtMjUzLDMgKzI1
Niw4IEBAIGludCBudm1lX2h3bW9uX2luaXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAgIAo+
ICAgCXJldHVybiAwOwo+ICAgfQo+ICsKPiArdm9pZCBudm1lX2h3bW9uX2V4aXQoc3RydWN0IG52
bWVfY3RybCAqY3RybCkKPiArewo+ICsJaHdtb25fZGV2aWNlX3VucmVnaXN0ZXIoY3RybC0+ZGV2
KTsKPiArfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJz
L252bWUvaG9zdC9udm1lLmgKPiBpbmRleCA1NjdmN2FkMThhOTEuLjYyMWU5YjE1NzVmNiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKPiArKysgYi9kcml2ZXJzL252bWUv
aG9zdC9udm1lLmgKPiBAQCAtODA3LDExICs4MDcsMTMgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qg
bnZtZV9ucyAqbnZtZV9nZXRfbnNfZnJvbV9kZXYoc3RydWN0IGRldmljZSAqZGV2KQo+ICAgCj4g
ICAjaWZkZWYgQ09ORklHX05WTUVfSFdNT04KPiAgIGludCBudm1lX2h3bW9uX2luaXQoc3RydWN0
IG52bWVfY3RybCAqY3RybCk7Cj4gK3ZvaWQgbnZtZV9od21vbl9leGl0KHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwpOwo+ICAgI2Vsc2UKPiAgIHN0YXRpYyBpbmxpbmUgaW50IG52bWVfaHdtb25faW5p
dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+ICAgewo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICtz
dGF0aWMgaW5saW5lIHZvaWQgbnZtZV9od21vbl9leGl0KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwp
IHsgfQo+ICAgI2VuZGlmCj4gICAKPiAgIHUzMiBudm1lX2NvbW1hbmRfZWZmZWN0cyhzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMsCj4gClNvbWV0aGluZydzIGZpc2h5
IGhlcmUuClRoZSBod21vbiBhdHRyaWJ1dGVzIHNob3VsZCBoYXZlIGJlZW4gY3JlYXRlZCBvbmx5
IG9uY2UgZm9yIHRoZSBsaWZldGltZSAKb2YgdGhlIGNvbnRyb2xsZXIgKGNyZWF0aW9uIGlzIHBy
b3RlY3RlZCBieSAnIWluaXRpYWxpemVkJykuCkFuZCB0aGUgaHdtb24gbGlmZXRpbWUgc2hvdWxk
J3ZlIGJlZW4gY29udHJvbGxlZCBieSB0aGUgbGlmZXRpbWUgb2YgdGhlIApjb250cm9sbGVyICh3
aGljaCB0byBteSBrbm93bGVkZ2Ugd2FzIHRoZSBpZGVhIGJlaGluZCB0aGUgZGV2bV8qIHRoaW5n
aWVzKS4KU28gd2h5IGRvIHdlIGhhdmUgdG8gZGVhbGxvY2F0ZSB0aGUgaHdtb24gYXR0cmlidXRl
cz8KQW5kIHdoeSBvbiByZXNldD8gQW5kIHdobydzIHJlLWNyZWF0aW5nIHRoZW0gYWZ0ZXIgcmVz
ZXQsIHNlZWluZyB0aGF0IAonaW5pdGlhbGl6ZWQnIHNob3VsZCBiZSB0cnVlPwpIbW0/CgpDaGVl
cnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2No
w6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
