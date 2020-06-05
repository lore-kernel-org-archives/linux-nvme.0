Return-Path: <SRS0=Oz+k=7S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73072C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 06:20:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C04B207F7
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2020 06:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kYj+IoCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C04B207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SXtIJbaM9ws3nDb5VFHuBmeJR7BjiG2ZfkcBfZ2C5lw=; b=kYj+IoCzw+XtFsKTErtufaJ+Z
	HWHUIRvA5TcLHYZ2IZD5cJfm2zI28iWyDtO8B9ZdBu3Vewlnd44nonLs54gEaeLNpZSGL+4NOn6jH
	5xH8XTiHQZKv7nUy/7bfE7RvimEEo8Mwrxk9xUvqq1aE3SNHd32C8POKjaC9GcjRB5oDyLKFNgn6i
	Yv1YEXqcU0Q+eFouW5SVQr7eS9PlnW+V5Wvj19zcegGjhnCDobNPIm2ohyw2BDkBbaAQDjuRN6JVp
	v3ucRGFZonpO9mtKn9eRpzr0vhHggHP8nhzrQDESWSUONiyuuxnxpN0ooyepuu1IU6NL9YXx95xrF
	kHKvXRldQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jh5ic-0003Wd-5m; Fri, 05 Jun 2020 06:20:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jh5iZ-0003Vv-98
 for linux-nvme@lists.infradead.org; Fri, 05 Jun 2020 06:20:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B4FEAACA0;
 Fri,  5 Jun 2020 06:20:38 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: check for NVME_CTRL_LIVE in nvme_report_ns_ids()
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200604115602.78446-1-hare@suse.de>
 <20200604115602.78446-2-hare@suse.de>
 <905b2aa9-3c82-fab5-ccb1-c68faa15ae11@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fad2f782-ae00-9fa7-3c3c-854148bb66c5@suse.de>
Date: Fri, 5 Jun 2020 08:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <905b2aa9-3c82-fab5-ccb1-c68faa15ae11@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_232039_619431_60813F61 
X-CRM114-Status: GOOD (  26.35  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <daniel.wagner@suse.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi80LzIwIDY6NTggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IFdoZW4gYSBjb250
cm9sbGVyIHJlc2V0IGhhcHBlbnMgZHVyaW5nIHNjYW5uaW5nIG52bWVfaWRlbnRpZnlfbnMoKQo+
PiB3aWxsIGJlIGFib3J0ZWQsIGJ1dCB0aGUgc3Vic2VxdWVudCBjYWxsIHRvIG52bWVfaWRlbnRp
ZnlfbnNfZGVzY3MoKQo+PiB3aWxsIHN0YWxsIGFzIGl0IHdpbGwgb25seSBiZSBjb21wbGV0ZWQg
b25jZSB0aGUgY29udHJvbGxlciByZWNvbm5lY3QKPj4gaXMgZmluaXNoZWQuCj4+IEJ1dCBhcyB0
aGUgcmVjb25uZWN0IHdhaXRzIGZvciBzY2FubmluZyB0byBjb21wbGV0ZSB0aGUgcGFydGljdWxh
cgo+PiBuYW1lc3BhY2Ugd2lsbCBkZWFkbG9jayBhbmQgbmV2ZXIgcmVjb25uZWN0ZWQgYWdhaW4u
Cj4+Cj4+IFJlcG9ydGVkLWJ5OiBNYXJ0aW4gR2VvcmdlIDxtYXJ0aW4uZ2VvcmdlQG5ldGFwcC5j
b20+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+PiAt
LS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgMiArLQo+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRl
eCA1Njk2NzFlMjY0YjUuLmI4MTE3ODc1MDVmNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtMTc5
Miw3ICsxNzkyLDcgQEAgc3RhdGljIGludCBudm1lX3JlcG9ydF9uc19pZHMoc3RydWN0IG52bWVf
Y3RybCAKPj4gKmN0cmwsIHVuc2lnbmVkIGludCBuc2lkLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
bWVtY3B5KGlkcy0+ZXVpNjQsIGlkLT5ldWk2NCwgc2l6ZW9mKGlkLT5ldWk2NCkpOwo+PiDCoMKg
wqDCoMKgIGlmIChjdHJsLT52cyA+PSBOVk1FX1ZTKDEsIDIsIDApKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgbWVtY3B5KGlkcy0+bmd1aWQsIGlkLT5uZ3VpZCwgc2l6ZW9mKGlkLT5uZ3VpZCkpOwo+
PiAtwqDCoMKgIGlmIChjdHJsLT52cyA+PSBOVk1FX1ZTKDEsIDMsIDApKQo+PiArwqDCoMKgIGlm
IChjdHJsLT52cyA+PSBOVk1FX1ZTKDEsIDMsIDApICYmIGN0cmwtPnN0YXRlID09IE5WTUVfQ1RS
TF9MSVZFKQo+IAo+IEknbSBzbGlnaHRseSBhbGxlcmdpYyB0byB0aGVzZSBzb3J0IG9mIHN0YXRl
IGNoZWNrcyBzbyB1bnRyaXZpYWxseSAKPiBwbGFjZWQuLi4KPiAKPiBIYW5uZXMsIGRpZCB5b3Ug
aGF2ZSB0aGUgYmVsb3cgYXBwbGllZCB3aGVuIHJlcHJvZHVjaW5nIHRoaXM/Cj4gLS0gCj4gY29t
bWl0IDU5YzdjM2NhYWFmODc1MGRmNGVjMzI1NTA4MmYxNWViNGUzNzE1MTQgKHRhZzogYmxvY2st
NS43LTIwMjAtMDUtMDkpCj4gQXV0aG9yOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1l
Pgo+IERhdGU6wqDCoCBXZWQgTWF5IDYgMTU6NDQ6MDIgMjAyMCAtMDcwMAo+IAo+ICDCoMKgwqAg
bnZtZTogZml4IHBvc3NpYmxlIGhhbmcgd2hlbiBucyBzY2FubmluZyBmYWlscyBkdXJpbmcgZXJy
b3IgcmVjb3ZlcnkKPiAKPiAgwqDCoMKgIFdoZW4gdGhlIGNvbnRyb2xsZXIgaXMgcmVjb25uZWN0
aW5nLCB0aGUgaG9zdCBmYWlscyBJL08gYW5kIGFkbWluCj4gIMKgwqDCoCBjb21tYW5kcyBhcyB0
aGUgaG9zdCBjYW5ub3QgcmVhY2ggdGhlIGNvbnRyb2xsZXIuIG5zIHNjYW5uaW5nIG1heQo+ICDC
oMKgwqAgcmV2YWxpZGF0ZSBuYW1lc3BhY2VzIGR1cmluZyB0aGF0IHBlcmlvZCBhbmQgaXQgaXMg
d3JvbmcgdG8gcmVtb3ZlCj4gIMKgwqDCoCBuYW1lc3BhY2VzIGR1ZSB0byB0aGVzZSBmYWlsdXJl
cyBhcyB3ZSBtYXkgaGFuZyAoc2VlIDIwNWRhMjQzNDMwMSkuCj4gCj4gIMKgwqDCoCBPbmUgY29t
bWFuZCB0aGF0IG1heSBmYWlsIGlzIG52bWVfaWRlbnRpZnlfbnNfZGVzY3MuIFNpbmNlIHdlIHJl
dHVybgo+ICDCoMKgwqAgc3VjY2VzcyBkdWUgdG8gaGF2aW5nIG5zIGlkZW50aWZ5IGRlc2NyaXB0
b3IgbGlzdCBvcHRpb25hbCwgd2UgCj4gY29udGludWUKPiAgwqDCoMKgIHRvIGNvbXBhcmUgbnMg
aWRlbnRpZmllcnMgaW4gbnZtZV9yZXZhbGlkYXRlX2Rpc2ssIG9idmlvdXNseSBmYWlsIGFuZAo+
ICDCoMKgwqAgcmV0dXJuIC1FTk9ERVYgdG8gbnZtZV92YWxpZGF0ZV9ucywgd2hpY2ggd2lsbCBy
ZW1vdmUgdGhlIG5hbWVzcGFjZS4KPiAKPiAgwqDCoMKgIEV4YWN0bHkgd2hhdCB3ZSBkb24ndCB3
YW50IHRvIGhhcHBlbi4KPiAKPiAgwqDCoMKgIEZpeGVzOiAyMjgwMmJmNzQyYzIgKCJudm1lOiBO
YW1lcGFjZSBpZGVudGlmaWNhdGlvbiBkZXNjcmlwdG9yIGxpc3QgCj4gaXMgb3B0aW9uYWwiKQo+
ICDCoMKgwqAgVGVzdGVkLWJ5OiBBbnRvbiBFaWRlbG1hbiA8YW50b25AbGlnaHRiaXRzbGFicy5j
b20+Cj4gIMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPgo+ICDCoMKgwqAgUmV2aWV3ZWQtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9y
Zz4KPiAgwqDCoMKgIFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
Pgo+ICDCoMKgwqAgU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgo+
IC0tIApBaC4gTm8sIGluZGVlZCBJIGhhdmVuJ3QuCihUaGUgam95cyBvZiBydW5uaW5nIGEgZG93
bnN0cmVhbSBrZXJuZWwpLgoKV2lsbCBiZSByZXRlc3Rpbmcgd2l0aCB0aGF0LgpUaGFua3MgZm9y
IHRoZSBwb2ludGVyLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
