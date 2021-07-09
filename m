Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89993C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 12:34:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CDE613B0
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 12:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CDE613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ntElV4DoGI6lMieVYJCgUDWo7DiNFXlGEGmWFEGwcqM=; b=wkaoK1ry+1kgljIQ6QpwmES6XF
	xvhZyGf2DmCW2iPfy06y4rXwJBq+oDJ2COMqT7W85rxsZEs08Yd4qBRaS+sVoREpPWC/R4IZDQj4u
	Z/KGptdCk7baVqkKzU9/Tw/iIhOyRsmj6EVgbY6eRFJaXWBSGPX6K4Gv0ZETxlIl0pZ+gg+20bfWk
	QdiffbqsgSB/IHrd7jQ8/IVG0iOznQNlDGUEliq2mpdq+uruEdeMTXgWPW8QlEBqrAdco8Xw4nnsq
	Ivvvtppbt1Uht1Qfhzr11Up/eb1RQyUoreN3PXtjylbgtC7a62SDRysqRtASmzTqvPsKMDcebmiWh
	A4+RTR2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1piK-001kzS-8r; Fri, 09 Jul 2021 12:34:40 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1pi5-001kw2-OF; Fri, 09 Jul 2021 12:34:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AF14ED1;
 Fri,  9 Jul 2021 05:34:19 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E83543F5A1;
 Fri,  9 Jul 2021 05:34:17 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1789d6b2-8332-0f26-2c5e-40181d09ebd6@arm.com>
Date: Fri, 9 Jul 2021 13:34:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_053425_943705_B1EF6976 
X-CRM114-Status: GOOD (  22.93  )
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

T24gMjAyMS0wNy0wOSAxMjowNCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwOS8wNy8yMDIxIDEx
OjI2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IG4gMjAyMS0wNy0wOSAwOTozOCwgTWluZyBMZWkg
d3JvdGU6Cj4+PiBIZWxsbywKPj4+Cj4+PiBJIG9ic2VydmVkIHRoYXQgTlZNZSBwZXJmb3JtYW5j
ZSBpcyB2ZXJ5IGJhZCB3aGVuIHJ1bm5pbmcgZmlvIG9uIG9uZQo+Pj4gQ1BVKGFhcmNoNjQpIGlu
IHJlbW90ZSBudW1hIG5vZGUgY29tcGFyZWQgd2l0aCB0aGUgbnZtZSBwY2kgbnVtYSBub2RlLgo+
Pj4KPj4+IFBsZWFzZSBzZWUgdGhlIHRlc3QgcmVzdWx0WzFdIDMyN0sgdnMuIDM0LjlLLgo+Pj4K
Pj4+IExhdGVuY3kgdHJhY2Ugc2hvd3MgdGhhdCBvbmUgYmlnIGRpZmZlcmVuY2UgaXMgaW4gaW9t
bXVfZG1hX3VubWFwX3NnKCksCj4+PiAxMTExIG5zZWNzIHZzIDI1NDM3IG5zZWNzLgo+Pgo+PiBB
cmUgeW91IGFibGUgdG8gZGlnIGRvd24gZnVydGhlciBpbnRvIHRoYXQ/IGlvbW11X2RtYV91bm1h
cF9zZygpIAo+PiBpdHNlbGYgZG9lc24ndCBkbyBhbnl0aGluZyBwYXJ0aWN1bGFybHkgc3BlY2lh
bCwgc28gd2hhdGV2ZXIgbWFrZXMgYSAKPj4gZGlmZmVyZW5jZSBpcyBwcm9iYWJseSBoYXBwZW5p
bmcgYXQgYSBsb3dlciBsZXZlbCwgYW5kIEkgc3VzcGVjdCAKPj4gdGhlcmUncyBwcm9iYWJseSBh
biBTTU1VIGludm9sdmVkLiBJZiBmb3IgaW5zdGFuY2UgaXQgdHVybnMgb3V0IHRvIGdvIAo+PiBh
bGwgdGhlIHdheSBkb3duIHRvIF9fYXJtX3NtbXVfY21kcV9wb2xsX3VudGlsX2NvbnN1bWVkKCkg
YmVjYXVzZSAKPj4gcG9sbGluZyBNTUlPIGZyb20gdGhlIHdyb25nIG5vZGUgaXMgc2xvdywgdGhl
cmUncyB1bmxpa2VseSB0byBiZSBtdWNoIAo+PiB5b3UgY2FuIGRvIGFib3V0IHRoYXQgb3RoZXIg
dGhhbiB0aGUgZ2xvYmFsICJnbyBmYXN0ZXIiIGtub2JzIAo+PiAoaW9tbXUuc3RyaWN0IGFuZCBp
b21tdS5wYXNzdGhyb3VnaCkgd2l0aCB0aGVpciBhc3NvY2lhdGVkIGNvbXByb21pc2VzLgo+IAo+
IFRoZXJlIHdhcyBhbHNvIHRoZSBkaXNhYmxlX21zaXBvbGxpbmcgb3B0aW9uOgo+IAo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC90cmVlL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMjbjQy
IAo+IAo+IAo+IEJ1dCBJIGFtIG5vdCBzdXJlIGlmIHRoYXQgcGxhdGZvcm0gZXZlbiBzdXBwb3J0
cyBNU0kgcG9sbGluZyAob3IgaGFzIAo+IHNtbXUgdjMpLgoKSG1tLCBJIHN1cHBvc2UgaW4gcHJp
bmNpcGxlIHRoZSBNU0kgcG9sbGluZyBwYXRoIGNvdWxkIGxlYWQgdG8gYSBiaXQgb2YgCmNhY2hl
bGluZSBwaW5nLXBvbmcgd2l0aCB0aGUgU01NVSBmZXRjaGluZyBhbmQgd3JpdGluZyBiYWNrIHRv
IHRoZSBzeW5jIApjb21tYW5kLCBidXQgSSdkIHJhdGhlciBmaW5kIG91dCBtb3JlIGRldGFpbHMg
b2Ygd2hlcmUgZXhhY3RseSB0aGUgZXh0cmEgCnRpbWUgaXMgYmVpbmcgc3BlbnQgaW4gdGhpcyBw
YXJ0aWN1bGFyIHNpdHVhdGlvbiB0aGFuIHNwZWN1bGF0ZSBtdWNoIApmdXJ0aGVyLgoKPiBZb3Ug
Y291bGQgYWxzbyB0cnkgaW9tbXUuZm9yY2VkYWM9MSBjbWRsaW5lIG9wdGlvbi4gQnV0IEkgZG91
YnQgaXQgd2lsbCAKPiBoZWxwIHNpbmNlIHRoZSBpc3N1ZSB3YXMgbWVudGlvbmVkIHRvIGJlIE5V
TUEgcmVsYXRlZC4KClBsdXMgdGhhdCBzaG91bGRuJ3QgbWFrZSBhbnkgZGlmZmVyZW5jZSB0byB1
bm1hcHMgYW55d2F5LgoKPj4+IFsxXSBmaW8gdGVzdCAmIHJlc3VsdHMKPj4+Cj4+PiAxKSBmaW8g
dGVzdCByZXN1bHQ6Cj4+Pgo+Pj4gLSBydW4gZmlvIG9uIGxvY2FsIENQVQo+Pj4gdGFza3NldCAt
YyAwIH4vZ2l0L3Rvb2xzL3Rlc3QvbnZtZS9pb191cmluZyAxMCAxIC9kZXYvbnZtZTFuMSA0awo+
Pj4gKyBmaW8gLS1icz00ayAtLWlvZW5naW5lPWlvX3VyaW5nIC0tZml4ZWRidWZzIC0tcmVnaXN0
ZXJmaWxlcyAtLWhpcHJpIAo+Pj4gLS1pb2RlcHRoPTY0IC0taW9kZXB0aF9iYXRjaF9zdWJtaXQ9
MTYgCj4+PiAtLWlvZGVwdGhfYmF0Y2hfY29tcGxldGVfbWluPTE2IC0tZmlsZW5hbWU9L2Rldi9u
dm1lMW4xIC0tZGlyZWN0PTEgCj4+PiAtLXJ1bnRpbWU9MTAgLS1udW1qb2JzPTEgLS1ydz1yYW5k
cmVhZCAtLW5hbWU9dGVzdCAtLWdyb3VwX3JlcG9ydGluZwo+Pj4KPj4+IElPUFM6IDMyN0sKPj4+
IGF2ZyBsYXRlbmN5IG9mIGlvbW11X2RtYV91bm1hcF9zZygpOiAxMTExIG5zZWNzCj4+Pgo+Pj4K
Pj4+IC0gcnVuIGZpbyBvbiByZW1vdGUgQ1BVCj4+PiB0YXNrc2V0IC1jIDgwIH4vZ2l0L3Rvb2xz
L3Rlc3QvbnZtZS9pb191cmluZyAxMCAxIC9kZXYvbnZtZTFuMSA0awo+Pj4gKyBmaW8gLS1icz00
ayAtLWlvZW5naW5lPWlvX3VyaW5nIC0tZml4ZWRidWZzIC0tcmVnaXN0ZXJmaWxlcyAtLWhpcHJp
IAo+Pj4gLS1pb2RlcHRoPTY0IC0taW9kZXB0aF9iYXRjaF9zdWJtaXQ9MTYgCj4+PiAtLWlvZGVw
dGhfYmF0Y2hfY29tcGxldGVfbWluPTE2IC0tZmlsZW5hbWU9L2Rldi9udm1lMW4xIC0tZGlyZWN0
PTEgCj4+PiAtLXJ1bnRpbWU9MTAgLS1udW1qb2JzPTEgLS1ydz1yYW5kcmVhZCAtLW5hbWU9dGVz
dCAtLWdyb3VwX3JlcG9ydGluZwo+Pj4KPj4+IElPUFM6IDM0LjlLCj4+PiBhdmcgbGF0ZW5jeSBv
ZiBpb21tdV9kbWFfdW5tYXBfc2coKTogMjU0MzcgbnNlY3MKPj4+Cj4+PiAyKSBzeXN0ZW0gaW5m
bwo+Pj4gW3Jvb3RAYW1wZXJlLW10amFkZS0wNCB+XSMgbHNjcHUgfCBncmVwIE5VTUEKPj4+IE5V
TUEgbm9kZShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyCj4+PiBO
VU1BIG5vZGUwIENQVShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAtNzkKPj4+IE5V
TUEgbm9kZTEgQ1BVKHMpOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgODAtMTU5Cj4+Pgo+
Pj4gbHNwY2kgfCBncmVwIE5WTWUKPj4+IDAwMDM6MDE6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5
IGNvbnRyb2xsZXI6IFNhbXN1bmcgRWxlY3Ryb25pY3MgQ28gCj4+PiBMdGQgTlZNZSBTU0QgQ29u
dHJvbGxlciBTTTk4MS9QTTk4MS9QTTk4Mwo+Pj4KPj4+IFtyb290QGFtcGVyZS1tdGphZGUtMDQg
fl0jIGNhdCAKPj4+IC9zeXMvYmxvY2svbnZtZTFuMS9kZXZpY2UvZGV2aWNlL251bWFfbm9kZSAK
PiAKPiBTaW5jZSBpdCdzIGFtcGVyZSwgSSBndWVzcyBpdCdzIHNtbXUgdjMuCj4gCj4gQlRXLCBp
ZiB5b3UgcmVtZW1iZXIsIEkgZGlkIHJhaXNlIGEgcGVyZm9ybWFuY2UgaXNzdWUgb2Ygc21tdXYz
IHdpdGggCj4gTlZNZSBiZWZvcmU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9t
bXUvYjJhNmUyNmQtNmQwZC03ZjBkLWYyMjItNTg5ODEyZjcwMWQyQGh1YXdlaS5jb20vIAoKSXQg
ZG9lc24ndCBzZWVtIGxpa2UgdGhlIGJlc3QtY2FzZSB0aHJvdWdocHV0IGlzIG9mIGNvbmNlcm4g
aW4gdGhpcyBjYXNlIAp0aG91Z2gsIGFuZCBteSBodW5jaCBpcyB0aGF0IGEgfjIzeCBkaXNjcmVw
YW5jeSBpbiBTTU1VIHVubWFwIApwZXJmb3JtYW5jZSBkZXBlbmRpbmcgb24gbG9jYWxpdHkgcHJv
YmFibHkgaXNuJ3Qgc3BlY2lmaWMgdG8gTlZNZS4KClJvYmluLgoKPiBJIGRpZCBoYXZlIHRoaXMg
c2VyaWVzIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UgZm9yIHN5c3RlbXMgd2l0aCBsb3RzIG9mIAo+
IENQVXMsIGxpa2UgYWJvdmUsIGJ1dCBub3QgYWNjZXB0ZWQ6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtaW9tbXUvMTU5ODAxODA2Mi0xNzU2MDgtMS1naXQtc2VuZC1lbWFpbC1qb2hu
LmdhcnJ5QGh1YXdlaS5jb20vIAo+IAo+IAo+IFRoYW5rcywKPiBKb2huCj4gCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
