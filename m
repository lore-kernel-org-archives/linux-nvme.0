Return-Path: <SRS0=UA0h=2G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F0C43603
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 08:02:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85CB206CB
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 08:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g0F+K5oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85CB206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NcHTKea03E4aKfSplJ9bnvV9wz0ChYDPwnqEGICVjSQ=; b=g0F+K5oNJpThiWhZWk2t7EWkT
	PQBvhXG4KFnI6tuu56PDEDgFmtsbwW0HwZokOzM1waXnBN5oewFiYC5ZTOUR9CJ7tsb2ON5jOMJPu
	sUJ95kDBBxf+eoDvWFf5M2cjLIzjobxOHjWgu6aFfphSRbQfxra+iMCgZtUjUpkoSoMOfgzU8l/QH
	XxkcC+nhPs0u4ZAkHv92eUm8ZTdG8m6gedqH6W2WkSOXOLFN4uvWf29NXN+TaGLx1NhomOfvz9nOH
	NmqrorY4B6bVQYtzv0uG5b0NwepQXWT9YdolKxhFSm/RWG4lC+fu7nhwNMjsayeSUV4Mgdx6rl8CR
	2XCD6o9dA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iglKw-00034t-8D; Mon, 16 Dec 2019 08:02:38 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iglKr-00033X-Gg
 for linux-nvme@lists.infradead.org; Mon, 16 Dec 2019 08:02:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 003D2B1D4;
 Mon, 16 Dec 2019 08:02:29 +0000 (UTC)
Subject: Re: [PATCH] nvme: Translate more status codes to blk_status_t
To: Sagi Grimberg <sagi@grimberg.me>,
 "Meneghini, John" <John.Meneghini@netapp.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20191205195730.5774-1-kbusch@kernel.org>
 <93B95176-A634-4A62-A8BF-2C599E597979@netapp.com>
 <C041F01A-6577-4DC4-A992-6F040EC6C0C9@netapp.com>
 <18f741dd-2445-141e-ea2b-4185476da8d2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1db1bb81-f2e6-4ec2-ea43-b5e609be1a4e@suse.de>
Date: Mon, 16 Dec 2019 09:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <18f741dd-2445-141e-ea2b-4185476da8d2@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191216_000233_847295_DDB3EB0F 
X-CRM114-Status: GOOD (  19.02  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvMTMvMTkgMTA6MDIgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IMKgwqDCoMKg
IExldCBtZSB0ZXN0IHRoaXMgb3V0IGFuZCBJ4oCZbGwgc2VlIHdoYXQgaGFwcGVucy4KPj4gS2Vp
dGgsIEkndmUgdGVzdGVkIHRoaXMgb3V0LCB1c2luZyBDUkQgd2l0aCBib3RoIAo+PiBOVk1FX1ND
X0NNRF9JTlRFUlJVUFRFRCBhbmQgTlZNRV9TQ19OU19OT1RfUkVBRFkuCj4+Cj4+IEl0IHdvcmtz
IHdlbGwgZW5vdWdoLCBidXQgSSB0aGluayB0aGUgcHJvYmxlbSBnb2VzIGEgbGl0dGxlIGRlZXBl
ciAKPj4gdGhhbiB0aGlzLgo+Pgo+Pj4gVGhlc2UgYXJlIG5vdCBnZW5lcmljIElPIGVycm9ycyBh
bmQgc2hvdWxkIHVzZSBhIG5vbi1wYXRoCj4+PiDCoCBzcGVjaWZpYyBlcnJvciBzbyB0aGF0IGl0
IGNhbiB1c2UgdGhlIG5vbi1mYWlsb3ZlciByZXRyeSBwYXRoLgo+Pgo+PiBZZXMsIGFncmVlZC7C
oCBCdXQgd2UgaGF2ZSB0aGlzIHByb2JsZW0gd2l0aCBldmVyeS9hbnkgb3RoZXIgTlZNZSAKPj4g
c3RhdHVzIHRoYXQgZ2V0cyByZXR1cm5lZCBhcyB3ZWxsLgo+PiBJdCBkb2Vzbid0IG1ha2Ugc2Vu
c2UgdG8ganVzdCBrZWVwIG92ZXJsb2FkaW5nIHRoZSBoYWxmIGEgZG96ZW4gZXJyb3JzIAo+PiB5
b3UgaGF2ZSBpbiBibGtfcGF0aF9lcnJvcigpOwo+Pgo+PiBJIHRoaW5rIHRoZSByZWFsIHByb2Js
ZW0gaXMgaGVyZToKPj4KPj4gwqAgMjc2wqDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoc3Rh
dHVzICE9IEJMS19TVFNfT0sgJiYgCj4+IG52bWVfcmVxX25lZWRzX3JldHJ5KHJlcSkpKSB7Cj4+
IMKgIDI3N8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgocmVxLT5jbWRfZmxh
Z3MgJiBSRVFfTlZNRV9NUEFUSCkgJiYKPj4gwqAgMjc4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBibGtfcGF0aF9lcnJvcihzdGF0dXMpKSB7Cj4+IMKgIDI3OcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX2ZhaWxvdmVy
X3JlcShyZXEpOwo+PiDCoCAyODDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOwo+PiDCoCAyODHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4+ICJudm1lL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyIgbGluZSAyODEgb2YgNDI2
NyAtLTYlLS0gY29sIDMtMTcKPj4KPj4gSWYgd2UgYXJlIHJlYWxseSBub3QgYWxsb3dlZCB0byBj
aGFuZ2UgdGhlIGJsa19wYXRoX2Vycm9yKCkgcm91dGluZSAKPj4gYmVjYXVzZSBpdCdzIGEgcGFy
dCBvZgo+PiB0aGUgYmxvY2sgbGF5ZXIsIHRoZW4gd2h5IGRvIHdlIGhhdmUgaXQgc3R1Y2sgaW4g
dGhlIG1pZGRsZSBvZiBvdXIgCj4+IG11bHRpcGF0aGluZyBwb2xpY3kKPj4gbG9naWM/Cj4+Cj4+
IE1heWJlIHdlIHNob3VsZCBjcmVhdGUgYW4gbnZtZV9wYXRoX2Vycm9yKCkgZnVuY3Rpb24gdG8g
cmVwbGFjZSB0aGUgCj4+IGJsa19wYXRoX2Vycm9yKCkKPj4gZnVuY3Rpb24gaGVyZS4KPj4KPj4g
VGhlIG90aGVyIHByb2JsZW0gaXM6IHNldHRpbmcgUkVRX05WTUVfTVBBVEggY29tcGxldGVseSBj
aGFuZ2VzIHRoZSBlcnJvcgo+PiBlcnJvciBoYW5kbGluZyBsb2dpYy7CoCBJZiBteSBjb250cm9s
bGVyIGhhcyBhIHNpbmdsZSBwYXRoIGl0IGhhcHBpbHkgCj4+IHJldHVybnMgYWxsIGtpbmRzCj4+
IG9mIE5WTWUgZXJyb3JzIG5vdCBoYW5kbGVkIGJ5IHRoZSBudm1lX2Vycm9yX3N0YXR1cygpIHdo
aXRlIGxpc3QuwqAgVGhvc2UKPj4gZXJyb3JzIGFsbCBmYWxsIHRocm91Z2ggeW91ciByZXRyeSBs
b2dpYyBhbmQgZW5kIHVwIHJldHVybmluZyAgCj4+IEJMS19TVFNfSU9FUlIuCj4+Cj4+IEhvd2V2
ZXIsIGFzIHNvb24gYXMgd2UgYWRkIGFub3RoZXIgcGF0aCB0byB0aGF0IHNhbWUgY29udHJvbGxl
ciwgYW5kIAo+PiB0dXJuIG9uCj4+IFJFUV9OVk1FX01QQVRILCBhbGwgb2YgYSBzdWRkZW4gdGhl
IGNvbnRyb2xsZXIgZ2V0cyBhIHJlc2V0IGZvciByZXR1cm5pbmcKPj4gdGhlIHZlcnkgc2FtZSBl
cnJvcnMgdGhhdCBpdCByZXR1bmVkIGJlZm9yZS4KPiAKPiBJIGFncmVlIHdlIHNob3VsZCBsb3Nl
IHRoaXMgY29udHJvbGxlciByZXNldCBhbmQgb25seSBkbyB0aGlzIGZvcgo+IHNwZWNpZmljIGVy
cm9yIGNhc2VzIHdoZXJlIGl0cyBuZWVkZWQgKG5vdCB0aGlua2luZyBvZiBhbnkgZnJvbSB0aGUK
PiB0b3Agb2YgbXkgaGVhZCkuCj4gCj4+IEFuZCB0aGF0IGhhcHBlbnMgYmVmb3JlIGV2ZW4gYSBz
aW5nbGUgcmV0cnkgaXMgYXR0ZW1wdGVkIC0gdW5sZXNzIGl0J3MgCj4+IGFuIE5WTWUgcGF0aGlu
ZyBlcnJvci4KPj4KPj4gMTA1wqDCoMKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+PiAxMDbCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+PiAxMDfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogUmVzZXQgdGhlIGNvbnRyb2xsZXIgZm9yIGFueSBub24tQU5BIGVycm9y
IGFzIAo+PiB3ZSBkb24ndCBrbm93Cj4+IDEwOMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiB3aGF0IGNhdXNlZCB0aGUgZXJyb3IuCj4+IDEwOcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKi8KPj4gMTEwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bnZtZV9yZXNldF9jdHJsKG5zLT5jdHJsKTsKPj4gMTExwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7Cj4+IDExMsKgwqDCoMKgwqDCoMKgwqAgfQo+PiAibnZtZS9kcml2ZXJz
L252bWUvaG9zdC9tdWx0aXBhdGguYyIgbGluZSAxMTIgb2YgNzM5IC0tMTUlLS0gY29sIDEtOAo+
Pgo+PiBUaGlzIG1ha2VzIG5vIHNlbnNlLgo+IAo+IFNvIGxldHMgcmVtb3ZlIHRoaXMgcmVzZXQu
IEhhdmUgdGhlIHRyYW5zcG9ydCB0YWtlIGNhcmUgb2YgdGhpcywgb3IgZG8KPiBpdCBvbmx5IHdo
ZW4gaXQgaXMgY2xlYXJseSBuZWVkZWQuCgpZZXMsIHRoaXMgd291bGQgYmUgdGhlIGJlc3Qgb3B0
aW9uLgpJIG5ldmVyIGxpa2VkIHRoZSByZXNldCBoZXJlIGluIHRoZSBmaXJzdCBwbGFjZTsgSS9P
IGVycm9ycywgb2theSwgYnV0IApyZXNldCBkb2VzIGltcGx5IHRoYXQgc29tZXRoaW5nIHVucmVj
b3ZlcmFibGUgaGFwcGVuZWQuCldoaWNoIGNsZWFybHkgaXQgZGlkbid0IGFzIHRoZSBjb250cm9s
bGVyIGRpZCBwcm92aWRlIHVzIHdpdGggYSByZXBseSwgCmFuZCBpdCdzIGp1c3QgdXMgYmVpbmcg
dG9vIGRhZnQgdG8gdW5kZXJzdGFuZCBpdC4KClNvIEkgZG8gYWdyZWUgd2l0aCBTYWdpIGhlcmU7
IHdlIHNob3VsZCByZXN0cmljdCBjb250cm9sbGVyIHJlc2V0IHRvIApyZWFsIGNvbW11bmljYXRp
b24gZmFpbHVyZXMsIG5vdCBmYWlsZWQgZXJyb3IgaGFuZGxpbmcuCldlIGRpZCB0aGF0IGluIFND
U0ksIGFuZCBpdCB0dXJuZWQgb3V0IHRvIGJlIGEgbWVzcy4KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3Jr
aW5nCmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjog
RmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
