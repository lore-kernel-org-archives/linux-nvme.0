Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B7C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 08:14:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0660120656
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 08:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ErwGnfc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0660120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QT4uMk77HTfRzsY6g+lCtNFuvyeeq0Ick+4XPKfesYQ=; b=ErwGnfc66KQN4Rik+7630XezT
	HOK9RIw25XoWbpOQNlLQxMCJuATtuqsfy66hXnHOG83YANY6WElbG8KSsUUqZtOpVutf+QqaUq8ez
	K21WxTS36qYBVNrvP0TjQs7o0o3KZNCQz9Jpe7wd/kuJVhyyMev7OwFvpweBjYk8TQrBxsqA+470H
	l17Wno3d6qfWIXvS7zMZYxIR3dXhgKT5Zm4+HIZ2ozecRio8CmSCBI3B/9Hy+I3XAO7FFxsca2q3X
	Ewiapx7A9Eb/+LtRi7smdNTvyRsA9xs/V7me5SWQWhV9ti+n2QnQeCf30ve0pMVXRYhh6C0ABF++B
	zYN3dpmVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Kki-0003Oa-LI; Tue, 28 Jul 2020 08:14:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Kkf-0003NH-Gt
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 08:14:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D1D97AFE8;
 Tue, 28 Jul 2020 08:14:25 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
To: Christoph Hellwig <hch@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-3-hare@suse.de>
 <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
 <25b94bcf-1730-da16-6a1f-b68ffa4b8970@suse.de>
 <20200728080223.GA22321@lst.de>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <93ab83e5-2293-2b78-32dc-af08463f4a24@suse.de>
Date: Tue, 28 Jul 2020 10:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200728080223.GA22321@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_041421_769054_3E45C036 
X-CRM114-Status: GOOD (  29.12  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8yOC8yMCAxMDowMiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBK
dWwgMjgsIDIwMjAgYXQgMDg6MjU6MThBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
Pj4gTWF5YmUgaW5zdGVhZCBvZiB0aGUgZWFybHkgcmV0dXJuIHB1dCB0aGUgZm9sbG93aW5nIGNv
bmRpdGlvbiBvbiBlbHNlPwo+Pgo+PiBUaGF0IGRlcGVuZHMgb24gd2hldGhlciB3ZSB3YW50IHRv
IGhhdmUgYSBmYWxsYmFjayB0byBfX252bWVfZmluZF9wYXRoKCkgb3IgCj4+IG5vdC4gV2l0aCB5
b3VyIHN1Z2dlc3Rpb24gd2Ugd291bGQgbG9zZSB0aGF0OyBJJ2QgcmF0aGVyIGtlZXAgaXQuCj4g
Cj4gV2h5IHdvdWxkIHdlIHdhbnQgdG8gZmFsbCBiYWNrPyAgbnZtZV9yb3VuZF9yb2Jpbl9wYXRo
IG9ubHkKPiByZXR1cm5zIE5VTEwgaW4gY2FzZSB0aGVyZSBpcyBhIHNpbmdsZSBkaXNhYmxlZCBw
YXRoLCBpbiB3aGljaAo+IGNhc2UgX19udm1lX2ZpbmRfcGF0aCB3b24ndCBmaW5kIGFueXRoaW5n
IGVpdGhlci4gIEknZCBnbyBmb3Igc29tZXRoaW5nCj4gbGlrZSB0aGlzOgo+IAo+IC0tLQo+IEZy
b20gNGY1NzgzNjRhM2QxNTg5OGM3ZDcxNTMxNWEzMzcxYjJmNzFkYjQxNiBNb24gU2VwIDE3IDAw
OjAwOjAwIDIwMDEKPiBGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPiBEYXRl
OiBNb24sIDI3IEp1bCAyMDIwIDE4OjA4OjAzICswMjAwCj4gU3ViamVjdDogbnZtZS1tdWx0aXBh
dGg6IGRvIG5vdCBmYWxsIGJhY2sgdG8gX19udm1lX2ZpbmRfcGF0aCgpIGZvcgo+ICBub24tb3B0
aW1pemVkIHBhdGhzCj4gCj4gV2hlbiBudm1lX3JvdW5kX3JvYmluX3BhdGgoKSBmaW5kcyBhIHZh
bGlkIG5hbWVzcGFjZSB3ZSBzaG91bGQgYmUgdXNpbmcgaXQ7Cj4gZmFsbGluZyBiYWNrIHRvIF9f
bnZtZV9maW5kX3BhdGgoKSBmb3Igbm9uLW9wdGltaXplZCBwYXRocyB3aWxsIGNhdXNlIHRoZQo+
IHJlc3VsdCBmcm9tIG52bWVfcm91bmRfcm9iaW5fcGF0aCgpIHRvIGJlIGlnbm9yZWQgZm9yIG5v
bi1vcHRpbWl6ZWQgcGF0aHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdpbGNrIDxtd2ls
Y2tAc3VzZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2Uu
ZGU+Cj4gUmV2aWV3ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gIGRyaXZl
cnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgMTEgKysrKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGgu
Ywo+IGluZGV4IDkzYzcwZTE1OTFkZThmLi4zZGVkNTRkMmM5YzZhZCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211
bHRpcGF0aC5jCj4gQEAgLTI4MSwxMCArMjgxLDEzIEBAIGlubGluZSBzdHJ1Y3QgbnZtZV9ucyAq
bnZtZV9maW5kX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkKPiAgCXN0cnVjdCBudm1l
X25zICpuczsKPiAgCj4gIAlucyA9IHNyY3VfZGVyZWZlcmVuY2UoaGVhZC0+Y3VycmVudF9wYXRo
W25vZGVdLCAmaGVhZC0+c3JjdSk7Cj4gLQlpZiAoUkVBRF9PTkNFKGhlYWQtPnN1YnN5cy0+aW9w
b2xpY3kpID09IE5WTUVfSU9QT0xJQ1lfUlIgJiYgbnMpCj4gLQkJbnMgPSBudm1lX3JvdW5kX3Jv
YmluX3BhdGgoaGVhZCwgbm9kZSwgbnMpOwo+IC0JaWYgKHVubGlrZWx5KCFucyB8fCAhbnZtZV9w
YXRoX2lzX29wdGltaXplZChucykpKQo+IC0JCW5zID0gX19udm1lX2ZpbmRfcGF0aChoZWFkLCBu
b2RlKTsKPiArCWlmICh1bmxpa2VseSghbnMpKQo+ICsJCXJldHVybiBfX252bWVfZmluZF9wYXRo
KGhlYWQsIG5vZGUpOwo+ICsKPiArCWlmIChSRUFEX09OQ0UoaGVhZC0+c3Vic3lzLT5pb3BvbGlj
eSkgPT0gTlZNRV9JT1BPTElDWV9SUikKPiArCQlyZXR1cm4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRo
KGhlYWQsIG5vZGUsIG5zKTsKPiArCWlmICh1bmxpa2VseSghbnZtZV9wYXRoX2lzX29wdGltaXpl
ZChucykpKQo+ICsJCXJldHVybiBfX252bWVfZmluZF9wYXRoKGhlYWQsIG5vZGUpOwo+ICAJcmV0
dXJuIG5zOwo+ICB9Cj4gIAo+IAoKWWVzLCB0aGF0IHdvdWxkIHdvcmssIHRvby4KClNob3VsZCBJ
IHJlc2VuZD8KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAg
ICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
