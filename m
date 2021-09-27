Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B9C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAE161166
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CAE161166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUH70wjYOI0jkTzqlZEVjrPgunE8qy39YzmmKfjLGxw=; b=DM6hZqfD+58xJ0YM8JfZaKr6dR
	ST8o/iagH4SkNUSpE9pEinGkgaZNTpCNMpsaUJ/Zqs9ajYTp+Og9eDO8gfAG0srEio6J/euMCUjDx
	tmASqyUhA0K+jJqbUIVbYfhdzjF8RuC7q422syvLRrTMXXDNJ6UUm4mcndOwxDk+mID6ccKtt16RY
	U9S6GmKkfNfErAZfYfn1BK61zoRF8G1cQTPBgBt/ChpXug7eOq6LZLsbcBMQjWQ7DWLMIsT1CJufK
	OYRpwU+Iyls0xmO1F5GgQImVntCyt/6WPepgyZ91o0NaWQGyBQJaN6duQUXoWg2ZkEghbSvSHUEom
	mA+cQCFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUl1z-001oXd-Dj; Mon, 27 Sep 2021 07:26:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUl1w-001oWs-UZ
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 07:26:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3990D20092;
 Mon, 27 Sep 2021 07:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632727587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL4i4Gs+wKRW9H5FFq5ITwf4d7abfhTXN9PqX2OpPT4=;
 b=d/BUGuaCWN6LTrX0maJibNIZu/OmmqHxTj+psTgX8oJRjat4x+FjMSrmARfz2uGoy8mgmy
 yhg6VEJbXWz842E/hNABCVCW13KIxuitf03V8rOUVHlB17f+B9/3cmwRyAPS1ueNBWdWt0
 aI/EBjelss6VE31GpREIxfdcgE2ux54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632727587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL4i4Gs+wKRW9H5FFq5ITwf4d7abfhTXN9PqX2OpPT4=;
 b=s3PpZt2qUW3FZiSKhINJNbZ1M2FRP9fFIgXR3myVaBIOC/+tU/ckv142la7l/tkx05TJ4/
 gYR1V3y0GBe+olCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A84D13A1E;
 Mon, 27 Sep 2021 07:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ynDiBSNyUWEsLgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 27 Sep 2021 07:26:27 +0000
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
 <22a5f9bf-5fbc-a0d3-b188-c67706a77600@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e8e4a164-5803-5110-ab48-751def26b976@suse.de>
Date: Mon, 27 Sep 2021 09:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <22a5f9bf-5fbc-a0d3-b188-c67706a77600@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_002629_159038_4DFD19DA 
X-CRM114-Status: GOOD (  17.99  )
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

T24gOS8yNy8yMSAxMjowNCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gKy8qIEFzc3Vt
ZXMgdGhhdCB0aGUgY29udHJvbGxlciBpcyBpbiBzdGF0ZSBSRVNFVFRJTkcgKi8KPj4gK3N0YXRp
YyB2b2lkIG52bWVfZGhjaGFwX2F1dGhfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4+
ICt7Cj4+ICvCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9Cj4+ICvCoMKgwqDCoMKgwqDC
oCBjb250YWluZXJfb2Yod29yaywgc3RydWN0IG52bWVfY3RybCwgZGhjaGFwX2F1dGhfd29yayk7
Cj4+ICvCoMKgwqAgaW50IHJldCwgcTsKPj4gKwo+PiArwqDCoMKgIG52bWVfc3RvcF9xdWV1ZXMo
Y3RybCk7Cj4gCj4gIMKgwqDCoMKgYmxrX21xX3F1aWVzY2VfcXVldWUoY3RybC0+YWRtaW5fcSk7
Cj4gCj4+ICvCoMKgwqAgLyogQXV0aGVudGljYXRlIGFkbWluIHF1ZXVlIGZpcnN0ICovCj4+ICvC
oMKgwqAgcmV0ID0gbnZtZV9hdXRoX25lZ290aWF0ZShjdHJsLCBOVk1FX1FJRF9BTlkpOwo+PiAr
wqDCoMKgIGlmIChyZXQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGRldl93YXJuKGN0cmwtPmRldmlj
ZSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicWlkIDA6IGVycm9yICVkIHNldHRpbmcg
dXAgYXV0aGVudGljYXRpb25cbiIsIHJldCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsK
Pj4gK8KgwqDCoCB9Cj4+ICvCoMKgwqAgcmV0ID0gbnZtZV9hdXRoX3dhaXQoY3RybCwgTlZNRV9R
SURfQU5ZKTsKPj4gK8KgwqDCoCBpZiAocmV0KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZfd2Fy
bihjdHJsLT5kZXZpY2UsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInFpZCAwOiBhdXRo
ZW50aWNhdGlvbiBmYWlsZWRcbiIpOwo+PiArwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+ICvC
oMKgwqAgfQo+PiArwqDCoMKgIGRldl9pbmZvKGN0cmwtPmRldmljZSwgInFpZCAwOiBhdXRoZW50
aWNhdGVkXG4iKTsKPj4gKwo+PiArwqDCoMKgIGZvciAocSA9IDE7IHEgPCBjdHJsLT5xdWV1ZV9j
b3VudDsgcSsrKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBudm1lX2F1dGhfbmVnb3RpYXRl
KGN0cmwsIHEpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXZfd2FybihjdHJsLT5kZXZpY2UsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAicWlkICVkOiBlcnJvciAlZCBzZXR0aW5nIHVwIGF1dGhlbnRpY2F0aW9u
XG4iLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcSwgcmV0KTsKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvC
oMKgwqAgfQo+PiArb3V0Ogo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIEZhaWx1cmUgaXMg
YSBzb2Z0LXN0YXRlOyBjcmVkZW50aWFscyByZW1haW4gdmFsaWQgdW50aWwKPj4gK8KgwqDCoMKg
ICogdGhlIGNvbnRyb2xsZXIgdGVybWluYXRlcyB0aGUgY29ubmVjdGlvbi4KPj4gK8KgwqDCoMKg
ICovCj4+ICvCoMKgwqAgaWYgKG52bWVfY2hhbmdlX2N0cmxfc3RhdGUoY3RybCwgTlZNRV9DVFJM
X0xJVkUpKQo+PiArwqDCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoY3RybCk7Cj4gIMKg
wqDCoMKgwqDCoMKgIGJsa19tcV91bnF1aWVzY2VfcXVldWUoY3RybC0+YWRtaW5fcSk7Cj4gCj4+
ICt9CgpBY3R1YWxseSwgYWZ0ZXIgcmVjZW50IGRpc2N1c3Npb25zIG9uIHRoZSBmbWRzIGdyb3Vw
IHRoZXJlIHNob3VsZG4ndCBiZSAKYSByZXF1aXJlbWVudCB0byBzdG9wIHRoZSBxdWV1ZXMsIHNv
IEknbGwgYmUgZHJvcHBpbmcgdGhlIHN0b3Avc3RhcnQgCnF1ZXVlIHRoaW5ncy4KKEFuZCB0aGUg
Y2hhbmdlIGluIGNvbnRyb2xsZXIgc3RhdGUsIHRvbywgYXMgaXQgaXNuJ3QgcmVxdWlyZWQsIGVp
dGhlcikuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJu
YmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
