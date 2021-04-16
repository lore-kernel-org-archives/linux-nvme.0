Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68CEC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 13:52:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE9961152
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 13:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9961152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PgQafHA0sjefW7PRZIWwLDjydfdmuLZiDuDBn8p0Yrk=; b=aKDWMst75XLfrB5GW0/VF97Rn
	HQHYQejnYOvREI61fjo3q6uwr9u0eKqwuMOLSPXhwzneAd6h41VZdjTurScDrC6d553ftJL1YoB1K
	C6FWXlIAF1wJGsVWUk6N5/YfoHkUYbYvQXarwYRk4YbMdTNWEfbRUkdpyG5zK2c4fhs2nTYMsi34j
	IeUsYtAOop6gOiyLGsFC6yeYw4FgITpBtIvFb5IGhQX7nnsyV98C1tIb8Xd+9k2bAg2bA2NxeG4iA
	4zHR7u1yw0oIV/eOMcn0m7a9yefTDU4tL0PduUSm+ylmdUevILAhiH2rEW0m5DoI/BCjd9MY6hu6E
	Ss/LGJlaA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXOst-002JSS-1D; Fri, 16 Apr 2021 13:51:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXOsl-002JRk-9C
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 13:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=YWyDdEgQ2sBJHteYsh4BeV1jhnDp8w3720b+MJ0tZ38=; b=fsFr5l1oA6a17I8jO3XZQRpUCo
 hV4BkHCyFhRx5z0JO2q/NQWEoNWme6fQqvoI5cbjynO19y1Rb9fVwj9reLqlTYKbclEfzbzucNTQR
 GDOp6SAPfBBWmscEcNrdGbNzRxsYHcSIzKJBNtgn6A+cwy640e8szwB5+XF5+U3OgB3qhFMv/Naok
 hkPeKOQcaVsGw0f12xEQlBVcw4hLS4z2hqJEDwVBkue8Ef/RRFjx/i1HblMsATv68ltfj4/lYt5Gu
 luJ5f+dmjUubAHK8wsRxIxUxDcg1Zd0smvAr56wVtDHdzA3pYry3wqR6oBtoRd0Y0EGXL9Y1dlz7c
 ZiIBfFhg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXOsi-009PoH-Gm
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 13:51:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 88BDFB12D;
 Fri, 16 Apr 2021 13:51:34 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit
 is set
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-2-snitzer@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <afeb4a15-eed3-9544-439e-f69b9eff5ad7@suse.de>
Date: Fri, 16 Apr 2021 15:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231530.95464-2-snitzer@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_065136_723622_B3936024 
X-CRM114-Status: GOOD (  25.53  )
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

T24gNC8xNi8yMSAxOjE1IEFNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6Cj4gSWYgdGhlIEROUiBiaXQg
aXMgc2V0IHdlIHNob3VsZCBub3QgcmV0cnkgdGhlIGNvbW1hbmQuCj4gCj4gV2UgY2FyZSBhYm91
dCB0aGUgcmV0cnlhYmxlIHZzIG5vdCByZXRyeWFibGUgZGlzdGluY3Rpb24gYXQgdGhlIGJsb2Nr
Cj4gbGF5ZXIgc28gcHJvcGFnYXRlIHRoZSBlcXVpdmFsZW50IG9mIHRoZSBETlIgYml0IGJ5IGlu
dHJvZHVjaW5nCj4gQkxLX1NUU19ET19OT1RfUkVUUlkuIFVwZGF0ZSBibGtfcGF0aF9lcnJvcigp
IHRvIF9ub3RfIHJldHJ5IGlmIGl0Cj4gaXMgc2V0Lgo+IAo+IFRoaXMgY2hhbmdlIHJ1bnMgd2l0
aCB0aGUgc3VnZ2VzdGlvbiBtYWRlIGhlcmU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbnZtZS8yMDE5MDgxMzE3MDE0NC5HQTEwMjY5QGxzdC5kZS8KPiAKPiBTdWdnZXN0ZWQtYnk6
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgU25p
dHplciA8c25pdHplckByZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgIHwgMyArKysKPiAgaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCB8IDggKysrKysrKysKPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IDA4
OTZlMjE2NDJiZS4uNTQwZDZmZDhmZmVmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC0yMzcsNiArMjM3
LDkgQEAgc3RhdGljIHZvaWQgbnZtZV9kZWxldGVfY3RybF9zeW5jKHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwpCj4gIAo+ICBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVfZXJyb3Jfc3RhdHVzKHUxNiBz
dGF0dXMpCj4gIHsKPiArCWlmICh1bmxpa2VseShzdGF0dXMgJiBOVk1FX1NDX0ROUikpCj4gKwkJ
cmV0dXJuIEJMS19TVFNfRE9fTk9UX1JFVFJZOwo+ICsKPiAgCXN3aXRjaCAoc3RhdHVzICYgMHg3
ZmYpIHsKPiAgCWNhc2UgTlZNRV9TQ19TVUNDRVNTOgo+ICAJCXJldHVybiBCTEtfU1RTX09LOwo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9i
bGtfdHlwZXMuaAo+IGluZGV4IGRiMDI2YjZlYzE1YS4uMWNhNzI0OTQ4YzU2IDEwMDY0NAo+IC0t
LSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa190
eXBlcy5oCj4gQEAgLTE0Miw2ICsxNDIsMTMgQEAgdHlwZWRlZiB1OCBfX2JpdHdpc2UgYmxrX3N0
YXR1c190Owo+ICAgKi8KPiAgI2RlZmluZSBCTEtfU1RTX1pPTkVfQUNUSVZFX1JFU09VUkNFCSgo
X19mb3JjZSBibGtfc3RhdHVzX3QpMTYpCj4gIAo+ICsvKgo+ICsgKiBCTEtfU1RTX0RPX05PVF9S
RVRSWSBpcyByZXR1cm5lZCBmcm9tIHRoZSBkcml2ZXIgaW4gdGhlIGNvbXBsZXRpb24gcGF0aAo+
ICsgKiBpZiB0aGUgZGV2aWNlIHJldHVybnMgYSBzdGF0dXMgaW5kaWNhdGluZyB0aGF0IGlmIHRo
ZSBzYW1lIGNvbW1hbmQgaXMKPiArICogcmUtc3VibWl0dGVkIGl0IGlzIGV4cGVjdGVkIHRvIGZh
aWwuCj4gKyAqLwo+ICsjZGVmaW5lIEJMS19TVFNfRE9fTk9UX1JFVFJZCSgoX19mb3JjZSBibGtf
c3RhdHVzX3QpMTcpCj4gKwo+ICAvKioKPiAgICogYmxrX3BhdGhfZXJyb3IgLSByZXR1cm5zIHRy
dWUgaWYgZXJyb3IgbWF5IGJlIHBhdGggcmVsYXRlZAo+ICAgKiBAZXJyb3I6IHN0YXR1cyB0aGUg
cmVxdWVzdCB3YXMgY29tcGxldGVkIHdpdGgKPiBAQCAtMTU3LDYgKzE2NCw3IEBAIHR5cGVkZWYg
dTggX19iaXR3aXNlIGJsa19zdGF0dXNfdDsKPiAgc3RhdGljIGlubGluZSBib29sIGJsa19wYXRo
X2Vycm9yKGJsa19zdGF0dXNfdCBlcnJvcikKPiAgewo+ICAJc3dpdGNoIChlcnJvcikgewo+ICsJ
Y2FzZSBCTEtfU1RTX0RPX05PVF9SRVRSWToKPiAgCWNhc2UgQkxLX1NUU19OT1RTVVBQOgo+ICAJ
Y2FzZSBCTEtfU1RTX05PU1BDOgo+ICAJY2FzZSBCTEtfU1RTX1RBUkdFVDoKPiAKUmV2aWV3ZWQt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
