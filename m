Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:17:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EFD60F12
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11EFD60F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVFJWePBbKbOFwGqikzu97XDfbqVSmif/kAR+y2+Ly4=; b=PH9WG276xT8zOr2/pxGd6XqyzZ
	J9QjLfhwekhcOaC6Ojhn4UDbs3s4WRSHTskSRelAkjncoe+NwZLarXThtidj8VnIKS1W6ft155KNK
	75d5+/kcrkxF3qjj0l63PVBosjRD4AYufxs+R6POUsUVN+cyrcIYWRRxjmDW2RvtFa5Okq+cEDLOq
	cCP9Xpu9UxwYxQi+WtDsmsTifl35kQZGgOVvVpo9l256BLJJUBpqkk8xj9m/WGiY4WC2db6o7miEN
	Ig9wuYWWrS74OMjJCfTUcXV84blI4rGP4gzhQxZaai3WOrKqhmx7CtRJtWejfsutkko0Lox/2MPxF
	TiB3zVrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUktI-001nUy-BK; Mon, 27 Sep 2021 07:17:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUktE-001nUd-E8
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 07:17:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E115922058;
 Mon, 27 Sep 2021 07:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632727046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/GMz928x71k3S15cD6NWXuYsLoo+RbAj5cZ0TtkniI=;
 b=Eg6TLO7h6N0GcUS8qqstaOVORnQnIqDAj7b9rETaeYpJdTvIcNh9dyM2OceA3XOOtMyln9
 APBOxU7r+85MI1P085AbhzY/QhGixQqeKHs+Wdk1cQ1ibVOJHrRZdu3z/YKo+QlcV8u/hD
 qcGdsuwXwtkJWl+TbWcWhohgiCfbjes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632727046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/GMz928x71k3S15cD6NWXuYsLoo+RbAj5cZ0TtkniI=;
 b=DtVN6EzTIn+6FlNxZT4WRPX8j1NwxS8h9Y2DxA5+i++oKrbN1U4Dzqkk5YiiPpmXvDACP/
 SJZzNpnBp6IdINDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B52A413A1E;
 Mon, 27 Sep 2021 07:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TOFqKwZwUWEZKgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 27 Sep 2021 07:17:26 +0000
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
 <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
 <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
Message-ID: <a2596777-25b2-f633-4b00-18b1a319c5c2@suse.de>
Date: Mon, 27 Sep 2021 09:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_001728_676576_534DFFE9 
X-CRM114-Status: GOOD (  31.38  )
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

T24gOS8yNy8yMSA4OjQwIEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4gT24gOS8yNy8yMSAx
Mjo1MSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4KPj4+ICt2b2lkIG52bWV0X2V4ZWN1dGVf
YXV0aF9zZW5kKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVj
dCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsKPj4+ICvCoMKgwqAgc3RydWN0IG52
bWZfYXV0aF9kaGNoYXBfc3VjY2VzczJfZGF0YSAqZGF0YTsKPj4+ICvCoMKgwqAgdm9pZCAqZDsK
Pj4+ICvCoMKgwqAgdTMyIHRsOwo+Pj4gK8KgwqDCoCB1MTYgc3RhdHVzID0gMDsKPj4+ICsKPj4+
ICvCoMKgwqAgaWYgKHJlcS0+Y21kLT5hdXRoX3NlbmQuc2VjcCAhPSAKPj4+IE5WTUVfQVVUSF9E
SENIQVBfUFJPVE9DT0xfSURFTlRJRklFUikgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0YXR1cyA9
IE5WTUVfU0NfSU5WQUxJRF9GSUVMRCB8IE5WTUVfU0NfRE5SOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJlcS0+ZXJyb3JfbG9jID0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldG9mKHN0
cnVjdCBudm1mX2F1dGhfc2VuZF9jb21tYW5kLCBzZWNwKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBn
b3RvIGRvbmU7Cj4+PiArwqDCoMKgIH0KPj4+ICvCoMKgwqAgaWYgKHJlcS0+Y21kLT5hdXRoX3Nl
bmQuc3BzcDAgIT0gMHgwMSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IE5WTUVfU0Nf
SU5WQUxJRF9GSUVMRCB8IE5WTUVfU0NfRE5SOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlcS0+ZXJy
b3JfbG9jID0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldG9mKHN0cnVjdCBudm1m
X2F1dGhfc2VuZF9jb21tYW5kLCBzcHNwMCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZ290byBkb25l
Owo+Pj4gK8KgwqDCoCB9Cj4+PiArwqDCoMKgIGlmIChyZXEtPmNtZC0+YXV0aF9zZW5kLnNwc3Ax
ICE9IDB4MDEpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBOVk1FX1NDX0lOVkFMSURf
RklFTEQgfCBOVk1FX1NDX0ROUjsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXEtPmVycm9yX2xvYyA9
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXRvZihzdHJ1Y3QgbnZtZl9hdXRoX3Nl
bmRfY29tbWFuZCwgc3BzcDEpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZTsKPj4+ICvC
oMKgwqAgfQo+Pj4gK8KgwqDCoCB0bCA9IGxlMzJfdG9fY3B1KHJlcS0+Y21kLT5hdXRoX3NlbmQu
dGwpOwo+Pj4gK8KgwqDCoCBpZiAoIXRsKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0g
TlZNRV9TQ19JTlZBTElEX0ZJRUxEIHwgTlZNRV9TQ19ETlI7Cj4+PiArwqDCoMKgwqDCoMKgwqAg
cmVxLT5lcnJvcl9sb2MgPQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0b2Yoc3Ry
dWN0IG52bWZfYXV0aF9zZW5kX2NvbW1hbmQsIHRsKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBnb3Rv
IGRvbmU7Cj4+PiArwqDCoMKgIH0KPj4+ICvCoMKgwqAgaWYgKCFudm1ldF9jaGVja190cmFuc2Zl
cl9sZW4ocmVxLCB0bCkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBwcl9kZWJ1ZygiJXM6IHRyYW5z
ZmVyIGxlbmd0aCBtaXNtYXRjaCAoJXUpXG4iLCBfX2Z1bmNfXywgdGwpOwo+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybjsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoCBkID0ga21hbGxv
Yyh0bCwgR0ZQX0tFUk5FTCk7Cj4+PiArwqDCoMKgIGlmICghZCkgewo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHN0YXR1cyA9IE5WTUVfU0NfSU5URVJOQUw7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZ290byBk
b25lOwo+Pj4gK8KgwqDCoCB9Cj4+PiArCj4+PiArwqDCoMKgIHN0YXR1cyA9IG52bWV0X2NvcHlf
ZnJvbV9zZ2wocmVxLCAwLCBkLCB0bCk7Cj4+PiArwqDCoMKgIGlmIChzdGF0dXMpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBrZnJlZShkKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4+
PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgZGF0YSA9IGQ7Cj4+PiArwqDCoMKgIHByX2Rl
YnVnKCIlczogY3RybCAlZCBxaWQgJWQgdHlwZSAlZCBpZCAlZCBzdGVwICV4XG4iLCBfX2Z1bmNf
XywKPj4+ICvCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPmNudGxpZCwgcmVxLT5zcS0+cWlkLCBkYXRh
LT5hdXRoX3R5cGUsIGRhdGEtPmF1dGhfaWQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoCByZXEtPnNx
LT5kaGNoYXBfc3RlcCk7Cj4+PiArwqDCoMKgIGlmIChkYXRhLT5hdXRoX3R5cGUgIT0gTlZNRV9B
VVRIX0NPTU1PTl9NRVNTQUdFUyAmJgo+Pj4gK8KgwqDCoMKgwqDCoMKgIGRhdGEtPmF1dGhfdHlw
ZSAhPSBOVk1FX0FVVEhfREhDSEFQX01FU1NBR0VTKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8g
ZG9uZV9mYWlsdXJlMTsKPj4+ICvCoMKgwqAgaWYgKGRhdGEtPmF1dGhfdHlwZSA9PSBOVk1FX0FV
VEhfQ09NTU9OX01FU1NBR0VTKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGRhdGEtPmF1dGhf
aWQgPT0gTlZNRV9BVVRIX0RIQ0hBUF9NRVNTQUdFX05FR09USUFURSkgewo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyogUmVzdGFydCBuZWdvdGlhdGlvbiAqLwo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcHJfZGVidWcoIiVzOiBjdHJsICVkIHFpZCAlZCByZXNldCBuZWdvdGlhdGlv
blxuIiwgCj4+PiBfX2Z1bmNfXywKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjdHJsLT5jbnRsaWQsIHJlcS0+c3EtPnFpZCk7Cj4+Cj4+IFRoaXMgaXMgdGhlIHBvaW50IHdo
ZXJlIHlvdSBuZWVkIHRvIHJlc2V0IGFsc28gYXV0aCBjb25maWcgYXMgdGhpcyBtYXkKPj4gaGF2
ZSBjaGFuZ2VkIGFuZCB0aGUgaG9zdCB3aWxsIG5vdCBjcmVhdGUgYSBuZXcgY29udHJvbGxlciBi
dXQgcmF0aGVyCj4+IHJlLWF1dGhlbnRpY2F0ZSBvbiB0aGUgZXhpc3RpbmcgY29udHJvbGxlci4K
Pj4KPj4gaS5lLgo+Pgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCFyZXEtPnNxLT5xaWQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1ldF9kZXN0cm95X2F1dGgoY3Ry
bCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKG52bWV0X3NldHVwX2F1dGgoY3RybCkgPCAwKSB7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHByX2VycigiRmFpbGVkIHRvIHNldHVwIAo+PiByZS1hdXRoZW50aWNhdGlv
blxuIik7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZV9mYWlsdXJlMTsKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+
Cj4+Cj4+Cj4gCj4gTm90IHN1cmUuIFdlIGhhdmUgdHdvIHBhdGhzIGhvdyByZS1hdXRoZW50aWNh
dGlvbiBjYW4gYmUgdHJpZ2dlcmVkLgo+IFRoZSBvbmUgaXMgZnJvbSB0aGUgaG9zdCwgd2hpY2gg
c2VuZHMgYSAnbmVnb3RpYXRlJyBjb21tYW5kIHRvIHRoZSAKPiBjb250cm9sbGVyIChpZSB0aGlz
IHBhdGgpLsKgIFRoZW4gbm90aGluZyBvbiB0aGUgY29udHJvbGxlciBoYXMgY2hhbmdlZCwgCj4g
YW5kIHdlIGp1c3QgbmVlZCB0byBlbnN1cmUgdGhhdCB3ZSByZXN0YXJ0IG5lZ290aWF0aW9uLgo+
IElFIHdlIHNob3VsZCBfbm90XyByZXNldCB0aGUgYXV0aGVudGljYXRpb24gKGFzIHRoYXQgd291
bGQgYWxzbyByZW1vdmUgCj4gdGhlIGNvbnRyb2xsZXIga2V5cywgd2hpY2ggaGF2ZW4ndCBjaGFu
Z2VkKS4gV2Ugc2hvdWxkIGp1c3QgZW5zdXJlIHRoYXQgCj4gYWxsIGVwaGVtZXJhbCBkYXRhIGlz
IHJlZ2VuZXJhdGVkLiBCdXQgdGhhdCBzaG91bGQgYmUgaGFuZGxlZCBpbi1saW5lLCAKPiBhbmQg
SSBfdGhpbmtfIEkgaGF2ZSBjb3ZlcmVkIGFsbCBvZiB0aGF0Lgo+IFRoZSBvdGhlciBwYXRoIHRv
IHRyaWdnZXIgcmUtYXV0aGVudGljYXRpb24gaXMgd2hlbiBjaGFuZ2luZyB2YWx1ZXMgb24gCj4g
dGhlIGNvbnRyb2xsZXIgdmlhIGNvbmZpZ2ZzLiBUaGVuIHN1cmUgd2UgbmVlZCB0byByZXNldCB0
aGUgY29udHJvbGxlciAKPiBkYXRhLCBhbmQgdHJpZ2dlciByZWF1dGhlbnRpY2F0aW9uLgo+IEFu
ZCB0aGVyZSBJIGRvIGFncmVlLCB0aGF0IHBhdGggaXNuJ3QgZnVsbHkgaW1wbGVtZW50ZWQgLyB0
ZXN0ZWQuCj4gQnV0IHNob3VsZCBiZSBzdGFydGVkIHdoZW5ldmVyIHRoZSBjb25maWdmcyB2YWx1
ZXMgY2hhbmdlLgo+IApBY3R1YWxseSwgaGF2aW5nIHJlLXJlYWQgdGhlIHNwZWMgSSdtIG5vdCBz
dXJlIGlmIHRoZSBzZWNvbmQgcGF0aCBpcyAKY29ycmVjdC4KQXMgcGVyIHNwZWMgb25seSB0aGUg
X2hvc3RfIGNhbiB0cmlnZ2VyIHJlLWF1dGhlbnRpY2F0aW9uLiBUaGVyZSBpcyBubyAKcHJvdmlz
aW9uIGZvciB0aGUgY29udHJvbGxlciB0byB0cmlnZ2VyIHJlLWF1dGhlbnRpY2F0aW9uLCBhbmQg
Z2l2ZW4gCnRoYXQgcmUtYXV0aCBpcyBhIHNvZnQtc3RhdGUgYW55d2F5IChpZSB0aGUgY3VycmVu
dCBhdXRoZW50aWNhdGlvbiBzdGF5cyAKdmFsaWQgdW50aWwgcmUtYXV0aCBlbnRlcnMgYSBmaW5h
bCBzdGF0ZSkgSSBfdGhpbmtfIHdlIHNob3VsZCBiZSBnb29kIAp3aXRoIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uLCB3aGVyZSB3ZSBjYW4gY2hhbmdlIHRoZSBjb250cm9sbGVyIGtleXMKdmlh
IGNvbmZpZ2ZzLCBidXQgdGhleSB3aWxsIG9ubHkgYmVjb21lIGFjdGl2ZSBvbmNlIHRoZSBob3N0
IHRyaWdnZXJzCnJlLWF1dGhlbnRpY2F0aW9uLgoKQW5kIGluZGVlZCwgdGhhdCdzIHRoZSBvbmx5
IHdheSBob3cgaXQgY291bGQgd29yaywgb3RoZXJ3aXNlIGl0J2xsIGJlIAp0cmlja3kgdG8gY2hh
bmdlIGtleXMgaW4gYSBydW5uaW5nIGNvbm5lY3Rpb24uCklmIHdlIHdlcmUgdG8gZm9yY2UgcmVu
ZWdvdGlhdGlvbiB3aGVuIGNoYW5naW5nIGNvbnRyb2xsZXIga2V5cyB3ZSB3b3VsZCAKaW1tZWRp
YXRlbHkgZmFpbCB0aGUgY29ubmVjdGlvbiwgYXMgd2UgY2Fubm90IGd1YXJhbnRlZSB0aGF0IGNv
bnRyb2xsZXIgCl9hbmRfIGhvc3Qga2V5cyBhcmUgY2hhbmdlZCBhdCB0aGUgc2FtZSB0aW1lLgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
