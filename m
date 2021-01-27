Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78EDC433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:35:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B0B20784
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B0B20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VrebRmsbfv5RS67gu0YMnBFbvAIC8KmUxCccJ1+Vuo4=; b=euQusiFgFpun/Jt0gf0bJkisO
	p8BjnfgIc6c1z2H2jg9S2e7e9RJUIb9pHTQYsjkQpEjGk4AlRBeYauMzyTnarE2h4kTNEDWxzuzKf
	MG/Oe+21dXGuxs+0Rac3BobJp0KCMVqHPaJV2lzvvapL5k5mxtQxuCr6Do1DQEcrfWF3CIJI0mA4a
	Zb1leQE9dIfDsPmhI9MqaTJ+LhtnUB7cOfNvwybGSWkrYqASw25wR+KiZ/vE1o8WYxQ7SVJ6ZCDeY
	Iu3jY/gtb7vSU2MypUDVMi57HJnfYaStzcJUCmFnC43o1ho+zZ0Ofxwz3eI2j0u+qDBIgdcvieSs+
	+q9tl0bEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4i9p-0000WJ-Eu; Wed, 27 Jan 2021 10:34:41 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4i9n-0000Ve-B6
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 10:34:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 42B47ACBA;
 Wed, 27 Jan 2021 10:34:38 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20210127103033.15318-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1563c0d6-cb24-0861-5a4a-a5aabfab7f9d@suse.de>
Date: Wed, 27 Jan 2021 11:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127103033.15318-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_053439_521963_BC858384 
X-CRM114-Status: GOOD (  23.65  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNy8yMSAxMTozMCBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBudm1lX3JvdW5kX3Jv
YmluX3BhdGgoKSBzaG91bGQgdGVzdCBpZiB0aGUgcmV0dXJuIG5zIHBvaW50ZXIgaXMKPiB2YWxp
ZC4gbnZtZV9uZXh0X25zKCkgd2lsbCByZXR1cm4gYSBOVUxMIHBvaW50ZXIgaWYgdGhlcmUgaXMg
bm8gcGF0aAo+IGxlZnQuCj4gCj4gRml4ZXM6IDc1YzEwZTczMjcyNCAoIm52bWUtbXVsdGlwYXRo
OiByb3VuZC1yb2JpbiBJL08gcG9saWN5IikKPiBDYzogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1
c2UuZGU+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPgo+
IC0tLQo+IHYyOgo+ICAgIC0gbW92ZWQgTlVMTCB0ZXN0IGludG8gdGhlIGlmIGNvbmRpdGlvbmFs
IHN0YXRlbWVudAo+ICAgIC0gYWRkZWQgRml4ZXMgdGFnCj4gCj4gICBkcml2ZXJzL252bWUvaG9z
dC9tdWx0aXBhdGguYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBh
dGguYyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gaW5kZXggOWFjNzYyYjI4ODEx
Li4yODJiN2E0ZWE5YTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRo
LmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+IEBAIC0yMjEsNyArMjIx
LDcgQEAgc3RhdGljIHN0cnVjdCBudm1lX25zICpudm1lX3JvdW5kX3JvYmluX3BhdGgoc3RydWN0
IG52bWVfbnNfaGVhZCAqaGVhZCwKPiAgIAl9Cj4gICAKPiAgIAlmb3IgKG5zID0gbnZtZV9uZXh0
X25zKGhlYWQsIG9sZCk7Cj4gLQkgICAgIG5zICE9IG9sZDsKPiArCSAgICAgbnMgJiYgbnMgIT0g
b2xkOwo+ICAgCSAgICAgbnMgPSBudm1lX25leHRfbnMoaGVhZCwgbnMpKSB7Cj4gICAJCWlmIChu
dm1lX3BhdGhfaXNfZGlzYWJsZWQobnMpKQo+ICAgCQkJY29udGludWU7Cj4gClJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
