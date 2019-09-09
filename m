Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14BCC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 11:18:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7362086D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fzHQTFbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BqHSEG7gycoxeLOCB+iF19Hm2TA0QVNN3KJ/WqNtpIo=; b=fzHQTFbY/klzxS
	dU4DyaSHasdFwWPhJm2Bm0xY7L3LvKhITa9sAtQHX+EIhPuEQ74k0YMWZui28C161pgS61QLXh8gJ
	6hYkHfJlONHNkAH05fnrlSckJKKw6xHahIUtxGKEY1rjibk7V9LxKUucM3jNBNw7J/IslCSVofu6P
	+sngFho/Uo1jwczIw3IFOo97sgnT04p7DslgHh6dtc5gLZUAg0npAdRu6U5GfL5JhhS3E326DJ5sP
	cAQmxDX9IhWfKAVyqp5vP36AZ6jObb8E+UAzLoDogECAWuzpTZukah3U3Jrq7st/ZkNDHWSFhxD1P
	Jpo3uVW5NG9qYNGvGeyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7HgD-0001v2-5Q; Mon, 09 Sep 2019 11:17:57 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7HgA-0001uT-7b
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 11:17:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 90493B664;
 Mon,  9 Sep 2019 11:17:51 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] nvme: enable aen regardless of the presence of I/O
 queues
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <12ccd74c-fc67-b8cd-cfba-0525be9dc80e@suse.de>
Date: Mon, 9 Sep 2019 13:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190904215954.15423-3-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_041754_567593_EAB1C2B6 
X-CRM114-Status: GOOD (  20.54  )
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

T24gOS80LzE5IDExOjU5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IEFFTnMgaW4gZ2VuZXJh
bCBhcmUgbm90IHJlbGF0ZWQgdG8gdGhlIHByZXNlbmNlIG9mIEkvTyBxdWV1ZXMsCj4gc28gZW5h
YmxlIHRoZW0gcmVnYXJkbGVzcy4gTm90ZSB0aGF0IHRoZSBvbmx5IGV4Y2VwdGlvbiBpcyB0aGF0
Cj4gZGlzY292ZXJ5IGNvbnRyb2xsZXIgd2lsbCBub3Qgc3VwcG9ydCBhbnkgb2YgdGhlIHJlcXVl
c3RlZCBBRU5zCj4gYW5kIG52bWVfZW5hYmxlX2FlbiB3aWxsIHJlc3BlY3QgdGhhdCBhbmQgcmV0
dXJuLCBzbyBpdCBpcyBzdGlsbAo+IHNhZmUgdG8gZW5hYmxlIHJlZ2FyZGxlc3MuCj4gCj4gTm90
ZSBpdCBpcyBzYWZlIHRvIGVuYWJsZSBBRU5zIGV2ZW4gYmVmb3JlIHRoZSBpbml0aWFsIG5hbWVz
cGFjZQo+IHNjYW5uaW5nIGFzIHdlIGhhdmUgdGhlIHNjYW4gb3BlcmF0aW9uIGluIGEgd29ya3F1
ZXVlIGNvbnRleHQuCj4gCj4gUmV2aWV3ZWQtYnk6IE1pbndvbyBJbSA8bWlud29vLmltLmRldkBn
bWFpbC5jb20+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+
IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gLS0tCj4g
IGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDYgKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IDE0YzBi
ZmI1NTYxNS4uZmNjZjI4ZDc3YzAzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC0xMjAxLDYgKzEyMDEs
OCBAQCBzdGF0aWMgdm9pZCBudm1lX2VuYWJsZV9hZW4oc3RydWN0IG52bWVfY3RybCAqY3RybCkK
PiAgCWlmIChzdGF0dXMpCj4gIAkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAiRmFpbGVkIHRvIGNv
bmZpZ3VyZSBBRU4gKGNmZyAleClcbiIsCj4gIAkJCSBzdXBwb3J0ZWRfYWVucyk7Cj4gKwo+ICsJ
cXVldWVfd29yayhudm1lX3dxLCAmY3RybC0+YXN5bmNfZXZlbnRfd29yayk7Cj4gIH0KPiAgCj4g
IHN0YXRpYyBpbnQgbnZtZV9zdWJtaXRfaW8oc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgbnZt
ZV91c2VyX2lvIF9fdXNlciAqdWlvKQo+IEBAIC0zNzgwLDEwICszNzgyLDEwIEBAIHZvaWQgbnZt
ZV9zdGFydF9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gIAlpZiAoY3RybC0+a2F0bykK
PiAgCQludm1lX3N0YXJ0X2tlZXBfYWxpdmUoY3RybCk7Cj4gIAo+ICsJbnZtZV9lbmFibGVfYWVu
KGN0cmwpOwo+ICsKPiAgCWlmIChjdHJsLT5xdWV1ZV9jb3VudCA+IDEpIHsKPiAgCQludm1lX3F1
ZXVlX3NjYW4oY3RybCk7Cj4gLQkJbnZtZV9lbmFibGVfYWVuKGN0cmwpOwo+IC0JCXF1ZXVlX3dv
cmsobnZtZV93cSwgJmN0cmwtPmFzeW5jX2V2ZW50X3dvcmspOwo+ICAJCW52bWVfc3RhcnRfcXVl
dWVzKGN0cmwpOwo+ICAJfQo+ICB9Cj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5jb20+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAg
ICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZQkJCSAgICAgICAg
ICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1h
bnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAyNDcxNjUgKEFHIE3D
vG5jaGVuKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
