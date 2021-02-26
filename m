Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F16C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 07:11:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8F464EC8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 07:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8F464EC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zy0/YOsCQMSJdqBtdL9BWFX5d5hqERGzmR2DU4znPRc=; b=lKbbWkk6CD483+dL4VMVxvJd7
	NeHomXqbC3B03uQ9bokaKQIGTl82fsqjfYbNPtkmlNNheM+Yw4UocaCD9QzexL3LcF5aVuCXMiGL3
	et/hjH1tZPiZvT1UI10z4rmcRfsJPTNCs73j/pVbwAIl2y78vLD+vBfHz3FPGX7JGpNTdDk7xFn+9
	sOSRNAM5s+2XBm/lNffRmc1lBobsZl6tLOcC+24aizBt9/3RDkb1v9jMEx/1LuLEcp/5e+G8FE8fI
	AyvwdKaIHz6gZw3+C8BjWCo4rZqs7DOUcyDmFqfpF79mvZ4sxpRFPufmhhxM3y7WVLrDZIAY4TDRN
	einUppYfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFXGX-0006TU-Ud; Fri, 26 Feb 2021 07:10:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFXGW-0006SN-0N
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 07:10:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CF77FAAC5;
 Fri, 26 Feb 2021 07:10:18 +0000 (UTC)
Subject: Re: [PATCH 1/6] nvme: simplify error logic in nvme_validate_ns()
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-2-hare@suse.de>
 <17a30d58-6767-10a2-17b3-4fd62887109c@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <99ab19f7-0321-efcb-5e5d-8fb4c1e6aea9@suse.de>
Date: Fri, 26 Feb 2021 08:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <17a30d58-6767-10a2-17b3-4fd62887109c@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_021020_157858_2BC61DC2 
X-CRM114-Status: GOOD (  22.36  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNi8yMSAyOjEzIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8yLzI1
IDE4OjU1LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFdlIG9ubHkgc2hvdWxkIHJlbW92ZSBu
YW1lc3BhY2VzIHdoZW4gd2UgZ2V0IGZhdGFsIGVycm9yIGJhY2sgZnJvbQo+PiB0aGUgZGV2aWNl
IG9yIHdoZW4gdGhlIG5hbWVzcGFjZSBJRHMgaGF2ZSBjaGFuZ2VkLgo+PiBTbyBpbnN0ZWFkIG9m
IHBhaW5mdWxseSBtYXNraW5nIG91dCBlcnJvciBudW1iZXJzIHdoaWNoIG1pZ2h0IGluZGljYXRl
Cj4+IHRoYXQgdGhlIGVycm9yIHNob3VsZCBiZSBpZ25vcmVkIHdlIGNvdWxkIHVzZSBhbiBOVk1F
IHN0YXR1cyBjb2RlCj4+IHRvIGluZGljYXRlZCB3aGVuIHRoZSBuYW1lc3BhY2Ugc2hvdWxkIGJl
IHJlbW92ZWQuCj4+IFRoYXQgc2ltcGxpZmllcyB0aGUgZmluYWwgbG9naWMgYW5kIG1ha2VzIGl0
IGxlc3MgZXJyb3ItcHJvbmUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgNiAr
KystLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCBkNzdmM2YyNmQ4ZDMuLjEzZWQ3ZDNmYmJiMyAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYwo+PiBAQCAtNDAzNiw3ICs0MDM2LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9u
c19yZW1vdmVfYnlfbnNpZChzdHJ1Y3QgCj4+IG52bWVfY3RybCAqY3RybCwgdTMyIG5zaWQpCj4+
IMKgIHN0YXRpYyB2b2lkIG52bWVfdmFsaWRhdGVfbnMoc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1
Y3QgbnZtZV9uc19pZHMgCj4+ICppZHMpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbnZt
ZV9pZF9ucyAqaWQ7Cj4+IC3CoMKgwqAgaW50IHJldCA9IC1FTk9ERVY7Cj4+ICvCoMKgwqAgaW50
IHJldCA9IE5WTUVfU0NfSU5WQUxJRF9OUyB8IE5WTUVfU0NfRE5SOwo+PiDCoMKgwqDCoMKgIGlm
ICh0ZXN0X2JpdChOVk1FX05TX0RFQUQsICZucy0+ZmxhZ3MpKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBvdXQ7Cj4+IEBAIC00MDQ1LDcgKzQwNDUsNyBAQCBzdGF0aWMgdm9pZCBudm1lX3Zh
bGlkYXRlX25zKHN0cnVjdCBudm1lX25zICpucywgCj4+IHN0cnVjdCBudm1lX25zX2lkcyAqaWRz
KQo+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsK
Pj4gLcKgwqDCoCByZXQgPSAtRU5PREVWOwo+PiArwqDCoMKgIHJldCA9IE5WTUVfU0NfSU5WQUxJ
RF9OUyB8IE5WTUVfU0NfRE5SOwo+PiDCoMKgwqDCoMKgIGlmICghbnZtZV9uc19pZHNfZXF1YWwo
Jm5zLT5oZWFkLT5pZHMsIGlkcykpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIobnMt
PmN0cmwtPmRldmljZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImlkZW50aWZpZXJz
IGNoYW5nZWQgZm9yIG5zaWQgJWRcbiIsIG5zLT5oZWFkLT5uc19pZCk7Cj4+IEBAIC00MDYzLDcg
KzQwNjMsNyBAQCBzdGF0aWMgdm9pZCBudm1lX3ZhbGlkYXRlX25zKHN0cnVjdCBudm1lX25zICpu
cywgCj4+IHN0cnVjdCBudm1lX25zX2lkcyAqaWRzKQo+PiDCoMKgwqDCoMKgwqAgKgo+PiDCoMKg
wqDCoMKgwqAgKiBUT0RPOiB3ZSBzaG91bGQgcHJvYmFibHkgc2NoZWR1bGUgYSBkZWxheWVkIHJl
dHJ5IGhlcmUuCj4+IMKgwqDCoMKgwqDCoCAqLwo+PiAtwqDCoMKgIGlmIChyZXQgJiYgcmV0ICE9
IC1FTk9NRU0gJiYgIShyZXQgPiAwICYmICEocmV0ICYgTlZNRV9TQ19ETlIpKSkKPj4gK8KgwqDC
oCBpZiAocmV0ID4gMCAmJiAocmV0ICYgTlZNRV9TQ19ETlIpKQo+IG52bWVfaWRlbnRpZnlfbnMg
bWF5IHJldHVybiAtTk9ERVYuCj4gaWYgcmV0ID09IC1OT0RFViwgYWxzbyBuZWVkIHRvIHJlbW92
ZSBuYW1lc3BhY2VzLgoKWW91IGFyZSBjb3JyZWN0LiBXaWxsIGJlIHVwZGF0aW5nIHRoZSBwYXRj
aC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
