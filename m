Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 05:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD3E610A5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 05:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DD3E610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M06qwUdIIa8gMXuw5pzSt6Brxk/T7cYd+ez3iCF7Ut0=; b=OdRiHM4vzZK7NZMj+/LPxhPS+H
	YHqmNaH8YEVdYZ6l/7Av4PB1gFhiTZR1/jjVxw3QagHifU5zAtfd8h+qwlH0NMnzqegIn/ejumoeU
	YeFdYdLZMi6Osoc4v5iRElvefPVngNemBqXWDX3OOXgWN4I7p1d5EzfCvSeiUejHtuuOtTeKEMdm6
	cS+RDyAcUnfkP2RO3h5qA+AjLEvQQF006U74w5vaGbCQhBWAprrXniOqj9YEqElNybG+buKFm6Ne1
	1A33G7e/cxe6+PHCmis5jAkaziAQd4d52GlOMrv3UzhmQ9y7ah695vGQO0njM3UqySwdlIFzl7B1S
	cxHJdyYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV5qR-005fdh-EG; Tue, 28 Sep 2021 05:39:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV5qO-005fco-MM
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 05:39:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C7BD201BB;
 Tue, 28 Sep 2021 05:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632807595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13TnURwhS8h4t01lwoZLD/d/5oPL9agrfycanDfeTRQ=;
 b=PT9kgFrx9DkgIx21N+ey4rvrG+p5lgzclkflex7M8ulg7b/MPe/8YBUPSSqsTo2GTahbjJ
 Gey5RuOSF1hNpbYAFgKbf2oL0K4d67fdRAt+eRdY+iU4RsWpBKefK/X7oBdujgebC7iQbz
 cH9ujOHUnez6nwSvlDTdjkQYCRSdxBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632807595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13TnURwhS8h4t01lwoZLD/d/5oPL9agrfycanDfeTRQ=;
 b=VnyBApxFuoR87JCq7TgLnoYycKzbt1M/1osAF+bIrqg5sP1C+l/tWJFxYA8+084TxkpCY5
 Hr8IhCD3XymifdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB01913A98;
 Tue, 28 Sep 2021 05:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JO5JKKqqUmHUNQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 28 Sep 2021 05:39:54 +0000
Subject: Re: [PATCH v2 03/10] nvme-multipath: add error handling support for
 add_disk()
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk, colyli@suse.de,
 kent.overstreet@gmail.com, kbusch@kernel.org, sagi@grimberg.me,
 vishal.l.verma@intel.com, dan.j.williams@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, konrad.wilk@oracle.com, roger.pau@citrix.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org
Cc: xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927220039.1064193-1-mcgrof@kernel.org>
 <20210927220039.1064193-4-mcgrof@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <85d33b80-1d54-67ba-47f9-0298093b6d80@suse.de>
Date: Tue, 28 Sep 2021 07:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210927220039.1064193-4-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_223956_910702_1EFE545C 
X-CRM114-Status: GOOD (  25.01  )
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

T24gOS8yOC8yMSAxMjowMCBBTSwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToKPiBXZSBuZXZlciBj
aGVja2VkIGZvciBlcnJvcnMgb24gYWRkX2Rpc2soKSBhcyB0aGlzIGZ1bmN0aW9uCj4gcmV0dXJu
ZWQgdm9pZC4gTm93IHRoYXQgdGhpcyBpcyBmaXhlZCwgdXNlIHRoZSBzaGlueSBuZXcKPiBlcnJv
ciBoYW5kbGluZy4KPiAKPiBTaW5jZSB3ZSBub3cgY2FuIHRlbGwgZm9yIHN1cmUgd2hlbiBhIGRp
c2sgd2FzIGFkZGVkLCBtb3ZlCj4gc2V0dGluZyB0aGUgYml0IE5WTUVfTlNIRUFEX0RJU0tfTElW
RSBvbmx5IHdoZW4gd2UgZGlkCj4gYWRkIHRoZSBkaXNrIHN1Y2Nlc3NmdWxseS4KPiAKPiBOb3Ro
aW5nIHRvIGRvIGhlcmUgYXMgdGhlIGNsZWFudXAgaXMgZG9uZSBlbHNld2hlcmUuIFdlIHRha2UK
PiBjYXJlIGFuZCB1c2UgdGVzdF9hbmRfc2V0X2JpdCgpIGJlY2F1c2UgaXQgaXMgcHJvdGVjdHMg
YWdhaW5zdAo+IHR3byBudm1lIHBhdGhzIHNpbXVsdGFuZW91c2x5IGNhbGxpbmcgZGV2aWNlX2Fk
ZF9kaXNrKCkgb24gdGhlCj4gc2FtZSBuYW1lc3BhY2UgaGVhZC4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4KPiAtLS0KPiAgIGRyaXZlcnMv
bnZtZS9ob3N0L211bHRpcGF0aC5jIHwgMTMgKysrKysrKysrKystLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRo
LmMKPiBpbmRleCBlOGNjZGQzOThmNzguLjM1Y2FjZTRmM2Y1ZiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRp
cGF0aC5jCj4gQEAgLTQ5NiwxMyArNDk2LDIyIEBAIGludCBudm1lX21wYXRoX2FsbG9jX2Rpc2so
c3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkKPiAgIHN0
YXRpYyB2b2lkIG52bWVfbXBhdGhfc2V0X2xpdmUoc3RydWN0IG52bWVfbnMgKm5zKQo+ICAgewo+
ICAgCXN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQgPSBucy0+aGVhZDsKPiArCWludCByYzsKPiAg
IAo+ICAgCWlmICghaGVhZC0+ZGlzaykKPiAgIAkJcmV0dXJuOwo+ICAgCj4gKwkvKgo+ICsJICog
dGVzdF9hbmRfc2V0X2JpdCgpIGlzIHVzZWQgYmVjYXVzZSBpdCBpcyBwcm90ZWN0aW5nIGFnYWlu
c3QgdHdvIG52bWUKPiArCSAqIHBhdGhzIHNpbXVsdGFuZW91c2x5IGNhbGxpbmcgZGV2aWNlX2Fk
ZF9kaXNrKCkgb24gdGhlIHNhbWUgbmFtZXNwYWNlCj4gKwkgKiBoZWFkLgo+ICsJICovCj4gICAJ
aWYgKCF0ZXN0X2FuZF9zZXRfYml0KE5WTUVfTlNIRUFEX0RJU0tfTElWRSwgJmhlYWQtPmZsYWdz
KSkgewo+IC0JCWRldmljZV9hZGRfZGlzaygmaGVhZC0+c3Vic3lzLT5kZXYsIGhlYWQtPmRpc2ss
Cj4gLQkJCQludm1lX25zX2lkX2F0dHJfZ3JvdXBzKTsKPiArCQlyYyA9IGRldmljZV9hZGRfZGlz
aygmaGVhZC0+c3Vic3lzLT5kZXYsIGhlYWQtPmRpc2ssCj4gKwkJCQkgICAgIG52bWVfbnNfaWRf
YXR0cl9ncm91cHMpOwo+ICsJCWlmIChyYykKPiArCQkJcmV0dXJuOwo+ICsJCXNldF9iaXQoTlZN
RV9OU0hFQURfRElTS19MSVZFLCAmaGVhZC0+ZmxhZ3MpOwo+ICAgCQludm1lX2FkZF9uc19oZWFk
X2NkZXYoaGVhZCk7Cj4gICAJfQo+ICAgCj4gRXJybS4KU2V0dGluZyB0aGUgc2FtZSBiaXQgdHdp
Y2U/CkFuZCBzaG91bGRuJ3QgeW91IHVuc2V0IHRoZSBiaXQgaWYgJ2RldmljZV9hZGRfZGlzaygp
JyBmYWlscz8KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAg
ICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8
cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
