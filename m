Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E90C4740A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 11:18:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2002086D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hUOkWPyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2002086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eJi77DWdvUsptBzwUeCkJHyex0OlU7qhtPLgfCGKM3o=; b=hUOkWPytqxQhkl
	6WFDk0QqvMrOWON0vkBjkEacfz3rpVjSpqwPKaqxCbC0Wu9BMCxICjzJ0Sz1DuW5X1qaV4S3HNDIi
	yiJA9JScu5cSbWXa9sG1lLoSAShB4twFJT4gzZsGWqo4HLZS3+ljwwnjPY7bfNOr6L+983EVBZf6c
	puINwX4N8Lh46A+DILwgoiQJpO/6iEajYU8TBcPxa/d27I189WfWRiXJmLA7EYUFqE3kARBZ407n9
	9JjPYel823+S3tjXLp3edV7IJAsh1DYu44RNwMP7Fv2XquUqxCEoS++2UqVGdz8bKX7DmnSqEO/ij
	4qnS41hB6qUf6PKCfkWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7HhC-0002SL-BW; Mon, 09 Sep 2019 11:18:58 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7Hh9-0002Rc-TO
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 11:18:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 97C46ACD9;
 Mon,  9 Sep 2019 11:18:54 +0000 (UTC)
Subject: Re: [PATCH v4 3/4] nvme: add uevent variables for controller devices
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <a9f79b2d-f649-a0c7-ee0a-38744fb5e5cf@suse.de>
Date: Mon, 9 Sep 2019 13:18:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190904215954.15423-4-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_041856_247231_C65DEA28 
X-CRM114-Status: GOOD (  21.19  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS80LzE5IDExOjU5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IFdoZW4gd2Ugc2VuZCB1
ZXZlbnRzIHRvIHVzZXJzcGFjZSwgYWRkIGNvbnRyb2xsZXIgc3BlY2lmaWMKPiBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMgdG8gdW5pcXVseSBpZGVudGlmeSB0aGUgY29udHJvbGxlciBiZXlvbmQKPiBp
dHMgZGV2aWNlIG5hbWUuCj4gCj4gVGhpcyB3aWxsIGJlIHVzZWZ1bCB0byBhZGRyZXNzIGRpc2Nv
dmVyeSBsb2cgY2hhbmdlIGV2ZW50cyBieQo+IGFjdHVhbGx5IHZlcmlmeWluZyB0aGF0IHRoZSBk
aXNjb3ZlcnkgY29udHJvbGxlciBpcyBpbmRlZWQgdGhlCj4gc2FtZSBhcyB0aGUgZGV2aWNlIHRo
YXQgZ2VuZXJhdGVkIHRoZSBldmVudC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJn
IDxzYWdpQGdyaW1iZXJnLm1lPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAy
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IGZjY2YyOGQ3N2MwMy4uN2ExZGY5NWVjODQw
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+IEBAIC0zNjMwLDYgKzM2MzAsMzMgQEAgdm9pZCBudm1lX3JlbW92
ZV9uYW1lc3BhY2VzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gIH0KPiAgRVhQT1JUX1NZTUJP
TF9HUEwobnZtZV9yZW1vdmVfbmFtZXNwYWNlcyk7Cj4gIAo+ICtzdGF0aWMgaW50IG52bWVfY2xh
c3NfdWV2ZW50KHN0cnVjdCBkZXZpY2UgKmQsIHN0cnVjdCBrb2JqX3VldmVudF9lbnYgKmVudikK
PiArewo+ICsJc3RydWN0IG52bWVfY3RybCAqY3RybCA9Cj4gKwkJY29udGFpbmVyX29mKGQsIHN0
cnVjdCBudm1lX2N0cmwsIGN0cmxfZGV2aWNlKTsKPiArCXN0cnVjdCBudm1mX2N0cmxfb3B0aW9u
cyAqb3B0cyA9IGN0cmwtPm9wdHM7Cj4gKwlpbnQgcmV0Owo+ICsKPiArCXJldCA9IGFkZF91ZXZl
bnRfdmFyKGVudiwgIk5WTUVfVFJUWVBFPSVzIiwgY3RybC0+b3BzLT5uYW1lKTsKPiArCWlmIChy
ZXQpCj4gKwkJcmV0dXJuIHJldDsKPiArCj4gKwlpZiAob3B0cykgewo+ICsJCXJldCA9IGFkZF91
ZXZlbnRfdmFyKGVudiwgIk5WTUVfVFJBRERSPSVzIiwgb3B0cy0+dHJhZGRyKTsKPiArCQlpZiAo
cmV0KQo+ICsJCQlyZXR1cm4gcmV0Owo+ICsKPiArCQlyZXQgPSBhZGRfdWV2ZW50X3ZhcihlbnYs
ICJOVk1FX1RSU1ZDSUQ9JXMiLAo+ICsJCQkob3B0cyAmJiBvcHRzLT50cnN2Y2lkKSA/IG9wdHMt
PnRyc3ZjaWQgOiAibm9uZSIpOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVybiByZXQ7Cj4gKwo+
ICsJCXJldCA9IGFkZF91ZXZlbnRfdmFyKGVudiwgIk5WTUVfSE9TVF9UUkFERFI9JXMiLAo+ICsJ
CQkob3B0cyAmJiBvcHRzLT5ob3N0X3RyYWRkcikgPyBvcHRzLT5ob3N0X3RyYWRkciA6ICJub25l
Iik7Cj4gKwl9Cj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICBzdGF0aWMgdm9pZCBudm1lX2Fl
bl91ZXZlbnQoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAgewo+ICAJY2hhciAqZW52cFsyXSA9
IHsgTlVMTCwgTlVMTCB9Owo+IEBAIC00MDYzLDYgKzQwOTAsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCBudm1lX2NvcmVfaW5pdCh2b2lkKQo+ICAJCXJlc3VsdCA9IFBUUl9FUlIobnZtZV9jbGFzcyk7
Cj4gIAkJZ290byB1bnJlZ2lzdGVyX2NocmRldjsKPiAgCX0KPiArCW52bWVfY2xhc3MtPmRldl91
ZXZlbnQgPSBudm1lX2NsYXNzX3VldmVudCwKPiAgCj4gIAludm1lX3N1YnN5c19jbGFzcyA9IGNs
YXNzX2NyZWF0ZShUSElTX01PRFVMRSwgIm52bWUtc3Vic3lzdGVtIik7Cj4gIAlpZiAoSVNfRVJS
KG52bWVfc3Vic3lzX2NsYXNzKSkgewo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuY29tPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkg
ICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUJCQkgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJt
YW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMjQ3MTY1IChBRyBN
w7xuY2hlbiksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
