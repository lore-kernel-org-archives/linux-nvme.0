Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4DAC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 08:29:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187796103B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 08:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 187796103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=y0q5JHaSJfXiY2DJXVDvUUJicrZn4RBxCcuxX+3GO0k=; b=mRScpPTzVVyvEHNqLjgJTacKI6
	F/mPchb6J+9AKswuAwF4/XoRzVarQneWwIKlJ3s2LDs3ZFjs269/cSTUkeCEZ4QHZT0GbJ2QDkKKB
	yWbraCTr13Kguwp5CwT1PbE3JxqnNDHtpE81iS0fgETY009mqGfnwFCRfNPVIl+64cpuanKJGJaga
	711lLqIsEUTSgRq/GDfxbiv82W4WKXO79XQCZJZbG7Cwsb/Tl+F7hsRMxMreIyU6TCM1N43F4ldZL
	xESOfaO28rC4Zr+PJRhBR2QhG2oKwKfDyqSFFka8gFWZXX6e16hERmjb/He8k6X1hzYvGYnCaRv0r
	OW62EvQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUm0l-0021hh-CP; Mon, 27 Sep 2021 08:29:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUlze-00210c-NE
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 08:28:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 677E6200A6;
 Mon, 27 Sep 2021 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632731288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IzRpYwg8XT7vqE3k6YtV2nkJvw9ef0chxy96R0/2zc=;
 b=q2SeJiyoATb/nFqXahyThP6f+tYr9iVAVwI2c3lDR2PUY2S15S8/Ypm9Jxf5t1fXuZNdXu
 pUPAAn9LWXAm9iH+jFz/OBfZ4WWo7cMXOGzSSQFGuK9bT/dzFTB2VDIpzSLtLXlgktXY5/
 dtDoXTsunBz2yLUVDZc7eb+k6MRQ8zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632731288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IzRpYwg8XT7vqE3k6YtV2nkJvw9ef0chxy96R0/2zc=;
 b=8dGSvjyAhu/5S+MPWY4rT17aVeit96nwuD+ExfHdg0pUPjNnFkQiWgYe4olvYL0zoS0XBb
 qldZABuxJqXfJ0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A0F613A42;
 Mon, 27 Sep 2021 08:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jGylFZiAUWF8TQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 27 Sep 2021 08:28:08 +0000
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
 <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
 <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
 <a2596777-25b2-f633-4b00-18b1a319c5c2@suse.de>
 <32d8f860-9fdb-606c-62b7-ad89837d8e71@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2ccfb62a-d782-7bb2-4d41-6d1152851a4a@suse.de>
Date: Mon, 27 Sep 2021 10:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <32d8f860-9fdb-606c-62b7-ad89837d8e71@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_012810_951899_EBA6F327 
X-CRM114-Status: GOOD (  31.20  )
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

T24gOS8yNy8yMSA5OjU1IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+IAo+IE9uIDkvMjcv
MjEgMTA6MTcgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gOS8yNy8yMSA4OjQwIEFN
LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiA5LzI3LzIxIDEyOjUxIEFNLCBTYWdpIEdy
aW1iZXJnIHdyb3RlOgo+Pj4+Cj4+Pj4+ICt2b2lkIG52bWV0X2V4ZWN1dGVfYXV0aF9zZW5kKHN0
cnVjdCBudm1ldF9yZXEgKnJlcSkKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZXRf
Y3RybCAqY3RybCA9IHJlcS0+c3EtPmN0cmw7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IG52bWZfYXV0
aF9kaGNoYXBfc3VjY2VzczJfZGF0YSAqZGF0YTsKPj4+Pj4gK8KgwqDCoCB2b2lkICpkOwo+Pj4+
PiArwqDCoMKgIHUzMiB0bDsKPj4+Pj4gK8KgwqDCoCB1MTYgc3RhdHVzID0gMDsKPj4+Pj4gKwo+
Pj4+PiArwqDCoMKgIGlmIChyZXEtPmNtZC0+YXV0aF9zZW5kLnNlY3AgIT0KPj4+Pj4gTlZNRV9B
VVRIX0RIQ0hBUF9QUk9UT0NPTF9JREVOVElGSUVSKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBz
dGF0dXMgPSBOVk1FX1NDX0lOVkFMSURfRklFTEQgfCBOVk1FX1NDX0ROUjsKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJlcS0+ZXJyb3JfbG9jID0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
b2Zmc2V0b2Yoc3RydWN0IG52bWZfYXV0aF9zZW5kX2NvbW1hbmQsIHNlY3ApOwo+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgZ290byBkb25lOwo+Pj4+PiArwqDCoMKgIH0KPj4+Pj4gK8KgwqDCoCBpZiAo
cmVxLT5jbWQtPmF1dGhfc2VuZC5zcHNwMCAhPSAweDAxKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBzdGF0dXMgPSBOVk1FX1NDX0lOVkFMSURfRklFTEQgfCBOVk1FX1NDX0ROUjsKPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJlcS0+ZXJyb3JfbG9jID0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgb2Zmc2V0b2Yoc3RydWN0IG52bWZfYXV0aF9zZW5kX2NvbW1hbmQsIHNwc3AwKTsKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZTsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICvCoMKgwqAg
aWYgKHJlcS0+Y21kLT5hdXRoX3NlbmQuc3BzcDEgIT0gMHgwMSkgewo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgc3RhdHVzID0gTlZNRV9TQ19JTlZBTElEX0ZJRUxEIHwgTlZNRV9TQ19ETlI7Cj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCByZXEtPmVycm9yX2xvYyA9Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG9mZnNldG9mKHN0cnVjdCBudm1mX2F1dGhfc2VuZF9jb21tYW5kLCBzcHNwMSk7Cj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4+Pj4+ICvCoMKgwqAgfQo+Pj4+PiArwqDC
oMKgIHRsID0gbGUzMl90b19jcHUocmVxLT5jbWQtPmF1dGhfc2VuZC50bCk7Cj4+Pj4+ICvCoMKg
wqAgaWYgKCF0bCkgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gTlZNRV9TQ19JTlZB
TElEX0ZJRUxEIHwgTlZNRV9TQ19ETlI7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXEtPmVycm9y
X2xvYyA9Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldG9mKHN0cnVjdCBudm1m
X2F1dGhfc2VuZF9jb21tYW5kLCB0bCk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7
Cj4+Pj4+ICvCoMKgwqAgfQo+Pj4+PiArwqDCoMKgIGlmICghbnZtZXRfY2hlY2tfdHJhbnNmZXJf
bGVuKHJlcSwgdGwpKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwcl9kZWJ1ZygiJXM6IHRyYW5z
ZmVyIGxlbmd0aCBtaXNtYXRjaCAoJXUpXG4iLCBfX2Z1bmNfXywKPj4+Pj4gdGwpOwo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+PiArwqDCoMKgIH0KPj4+Pj4gKwo+Pj4+PiArwqDC
oMKgIGQgPSBrbWFsbG9jKHRsLCBHRlBfS0VSTkVMKTsKPj4+Pj4gK8KgwqDCoCBpZiAoIWQpIHsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IE5WTUVfU0NfSU5URVJOQUw7Cj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4+Pj4+ICvCoMKgwqAgfQo+Pj4+PiArCj4+Pj4+ICvC
oMKgwqAgc3RhdHVzID0gbnZtZXRfY29weV9mcm9tX3NnbChyZXEsIDAsIGQsIHRsKTsKPj4+Pj4g
K8KgwqDCoCBpZiAoc3RhdHVzKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBrZnJlZShkKTsKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZTsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICsKPj4+
Pj4gK8KgwqDCoCBkYXRhID0gZDsKPj4+Pj4gK8KgwqDCoCBwcl9kZWJ1ZygiJXM6IGN0cmwgJWQg
cWlkICVkIHR5cGUgJWQgaWQgJWQgc3RlcCAleFxuIiwgX19mdW5jX18sCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgIGN0cmwtPmNudGxpZCwgcmVxLT5zcS0+cWlkLCBkYXRhLT5hdXRoX3R5cGUsIGRh
dGEtPmF1dGhfaWQsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgIHJlcS0+c3EtPmRoY2hhcF9zdGVw
KTsKPj4+Pj4gK8KgwqDCoCBpZiAoZGF0YS0+YXV0aF90eXBlICE9IE5WTUVfQVVUSF9DT01NT05f
TUVTU0FHRVMgJiYKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRhdGEtPmF1dGhfdHlwZSAhPSBOVk1F
X0FVVEhfREhDSEFQX01FU1NBR0VTKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZ290byBkb25lX2Zh
aWx1cmUxOwo+Pj4+PiArwqDCoMKgIGlmIChkYXRhLT5hdXRoX3R5cGUgPT0gTlZNRV9BVVRIX0NP
TU1PTl9NRVNTQUdFUykgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGRhdGEtPmF1dGhfaWQg
PT0gTlZNRV9BVVRIX0RIQ0hBUF9NRVNTQUdFX05FR09USUFURSkgewo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBSZXN0YXJ0IG5lZ290aWF0aW9uICovCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHByX2RlYnVnKCIlczogY3RybCAlZCBxaWQgJWQgcmVzZXQgbmVnb3RpYXRp
b25cbiIsCj4+Pj4+IF9fZnVuY19fLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY3RybC0+Y250bGlkLCByZXEtPnNxLT5xaWQpOwo+Pj4+Cj4+Pj4gVGhpcyBpcyB0aGUg
cG9pbnQgd2hlcmUgeW91IG5lZWQgdG8gcmVzZXQgYWxzbyBhdXRoIGNvbmZpZyBhcyB0aGlzIG1h
eQo+Pj4+IGhhdmUgY2hhbmdlZCBhbmQgdGhlIGhvc3Qgd2lsbCBub3QgY3JlYXRlIGEgbmV3IGNv
bnRyb2xsZXIgYnV0IHJhdGhlcgo+Pj4+IHJlLWF1dGhlbnRpY2F0ZSBvbiB0aGUgZXhpc3Rpbmcg
Y29udHJvbGxlci4KPj4+Pgo+Pj4+IGkuZS4KPj4+Pgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJlcS0+c3EtPnFpZCkgewo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bnZtZXRfZGVzdHJveV9hdXRoKGN0cmwpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG52bWV0X3NldHVwX2F1dGgo
Y3RybCkgPCAwKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJGYWlsZWQgdG8g
c2V0dXAKPj4+PiByZS1hdXRoZW50aWNhdGlvblxuIik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBkb25lX2ZhaWx1cmUxOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4KPj4+Pgo+Pj4+Cj4+Pgo+Pj4gTm90
IHN1cmUuIFdlIGhhdmUgdHdvIHBhdGhzIGhvdyByZS1hdXRoZW50aWNhdGlvbiBjYW4gYmUgdHJp
Z2dlcmVkLgo+Pj4gVGhlIG9uZSBpcyBmcm9tIHRoZSBob3N0LCB3aGljaCBzZW5kcyBhICduZWdv
dGlhdGUnIGNvbW1hbmQgdG8gdGhlCj4+PiBjb250cm9sbGVyIChpZSB0aGlzIHBhdGgpLsKgIFRo
ZW4gbm90aGluZyBvbiB0aGUgY29udHJvbGxlciBoYXMKPj4+IGNoYW5nZWQsIGFuZCB3ZSBqdXN0
IG5lZWQgdG8gZW5zdXJlIHRoYXQgd2UgcmVzdGFydCBuZWdvdGlhdGlvbi4KPj4+IElFIHdlIHNo
b3VsZCBfbm90XyByZXNldCB0aGUgYXV0aGVudGljYXRpb24gKGFzIHRoYXQgd291bGQgYWxzbwo+
Pj4gcmVtb3ZlIHRoZSBjb250cm9sbGVyIGtleXMsIHdoaWNoIGhhdmVuJ3QgY2hhbmdlZCkuIFdl
IHNob3VsZCBqdXN0Cj4+PiBlbnN1cmUgdGhhdCBhbGwgZXBoZW1lcmFsIGRhdGEgaXMgcmVnZW5l
cmF0ZWQuIEJ1dCB0aGF0IHNob3VsZCBiZQo+Pj4gaGFuZGxlZCBpbi1saW5lLCBhbmQgSSBfdGhp
bmtfIEkgaGF2ZSBjb3ZlcmVkIGFsbCBvZiB0aGF0Lgo+Pj4gVGhlIG90aGVyIHBhdGggdG8gdHJp
Z2dlciByZS1hdXRoZW50aWNhdGlvbiBpcyB3aGVuIGNoYW5naW5nIHZhbHVlcwo+Pj4gb24gdGhl
IGNvbnRyb2xsZXIgdmlhIGNvbmZpZ2ZzLiBUaGVuIHN1cmUgd2UgbmVlZCB0byByZXNldCB0aGUK
Pj4+IGNvbnRyb2xsZXIgZGF0YSwgYW5kIHRyaWdnZXIgcmVhdXRoZW50aWNhdGlvbi4KPj4+IEFu
ZCB0aGVyZSBJIGRvIGFncmVlLCB0aGF0IHBhdGggaXNuJ3QgZnVsbHkgaW1wbGVtZW50ZWQgLyB0
ZXN0ZWQuCj4+PiBCdXQgc2hvdWxkIGJlIHN0YXJ0ZWQgd2hlbmV2ZXIgdGhlIGNvbmZpZ2ZzIHZh
bHVlcyBjaGFuZ2UuCj4+Pgo+PiBBY3R1YWxseSwgaGF2aW5nIHJlLXJlYWQgdGhlIHNwZWMgSSdt
IG5vdCBzdXJlIGlmIHRoZSBzZWNvbmQgcGF0aCBpcwo+PiBjb3JyZWN0Lgo+PiBBcyBwZXIgc3Bl
YyBvbmx5IHRoZSBfaG9zdF8gY2FuIHRyaWdnZXIgcmUtYXV0aGVudGljYXRpb24uIFRoZXJlIGlz
IG5vCj4+IHByb3Zpc2lvbiBmb3IgdGhlIGNvbnRyb2xsZXIgdG8gdHJpZ2dlciByZS1hdXRoZW50
aWNhdGlvbiwgYW5kIGdpdmVuCj4+IHRoYXQgcmUtYXV0aCBpcyBhIHNvZnQtc3RhdGUgYW55d2F5
IChpZSB0aGUgY3VycmVudCBhdXRoZW50aWNhdGlvbgo+PiBzdGF5cyB2YWxpZCB1bnRpbCByZS1h
dXRoIGVudGVycyBhIGZpbmFsIHN0YXRlKSBJIF90aGlua18gd2Ugc2hvdWxkIGJlCj4+IGdvb2Qg
d2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgd2hlcmUgd2UgY2FuIGNoYW5nZSB0aGUK
Pj4gY29udHJvbGxlciBrZXlzCj4+IHZpYSBjb25maWdmcywgYnV0IHRoZXkgd2lsbCBvbmx5IGJl
Y29tZSBhY3RpdmUgb25jZSB0aGUgaG9zdCB0cmlnZ2Vycwo+PiByZS1hdXRoZW50aWNhdGlvbi4K
PiAKPiBBZ3JlZSwgc28gdGhlIHByb3Bvc2VkIGFkZGl0aW9uIGlzIGdvb2Qgd2l0aCB5b3U/Cj4g
CldoeSB3b3VsZCB3ZSBuZWVkIGl0PwpJIGRvIGFncmVlIHRoZXJlJ3MgYSBiaXQgbWlzc2luZyBm
b3IgcmVtb3ZpbmcgdGhlIG9sZCBzaGFzaF90Zm0gaWYgdGhlcmUKaXMgYSBoYXNoLWlkIG1pc21h
dGNoLCBidXQgd2h5IHdvdWxkIHdlIG5lZWQgdG8gcmVzZXQgdGhlIGVudGlyZQphdXRoZW50aWNh
dGlvbj8KVGhlIGltcG9ydGFudCAoaWUgY3J5cHRvZ3JhcGhpY2FsbHkgcmVsZXZhbnQpIGJpdHMg
YXJlIGNsZWFyZWQgaW4KbnZtZXRfYXV0aF9zcV9mcmVlKCksIGFuZCB0aGV5IGFyZSBjbGVhcmVk
IGFmdGVyIGF1dGhlbnRpY2F0aW9uIGlzCmNvbXBsZXRlZC4KU28gd2h5IHdvdWxkIHdlIG5lZWQg
dG8gcmVzZXQga2V5cyBhbmQgVEZNcz8KCj4+IEFuZCBpbmRlZWQsIHRoYXQncyB0aGUgb25seSB3
YXkgaG93IGl0IGNvdWxkIHdvcmssIG90aGVyd2lzZSBpdCdsbCBiZQo+PiB0cmlja3kgdG8gY2hh
bmdlIGtleXMgaW4gYSBydW5uaW5nIGNvbm5lY3Rpb24uCj4+IElmIHdlIHdlcmUgdG8gZm9yY2Ug
cmVuZWdvdGlhdGlvbiB3aGVuIGNoYW5naW5nIGNvbnRyb2xsZXIga2V5cyB3ZQo+PiB3b3VsZCBp
bW1lZGlhdGVseSBmYWlsIHRoZSBjb25uZWN0aW9uLCBhcyB3ZSBjYW5ub3QgZ3VhcmFudGVlIHRo
YXQKPj4gY29udHJvbGxlciBfYW5kXyBob3N0IGtleXMgYXJlIGNoYW5nZWQgYXQgdGhlIHNhbWUg
dGltZS4KPiAKPiBFeGFjdGx5LCBjaGFuZ2luZyB0aGUgaG9zdGtleSBpbiB0aGUgY29udHJvbGxl
ciBtdXN0IG5vdCB0cmlnZ2VyCj4gcmUtYXV0aCwgdGhlIGhvc3Qgd2lsbCByZW1haW4gY29ubmVj
dGVkIGFuZCBvcGVyYXRpb25hbCBhcyBpdAo+IGF1dGhlbnRpY2F0ZWQgYmVmb3JlLiBBcyB0aGUg
aG9zdCByZS1hdXRoZW50aWNhdGVzIG9yIHJlY29ubmVjdAo+IGl0IG5lZWRzIHRvIGF1dGhlbnRp
Y2F0ZSBhZ2FpbnN0IHRoZSBuZXcga2V5LgoKUmlnaHQuIEknbGwgYmUgYWRkaW5nIGEgY29tbWVu
dCB0byB0aGUgY29uZmlnZnMgZnVuY3Rpb25zIHRvIHRoZSBlZmZlY3QuCgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJj
aGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7Zy
ZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
