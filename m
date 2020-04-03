Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B99C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:13:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FF220737
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMkKV2Sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FF220737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GmCq0wmJuKoghUciJKPK5xnuCodSgjxzlJLX8AVBKeE=; b=OMkKV2Sb600DKcQfVTNhtkxS4
	tnZKo6eF08HcIH/xhHerjyvT1nKi15xgjdANX1sAx2/FcPoYMig6e+O/r/g2lEgvcrd/NtgtO8tkv
	fkOueFa7gPGf+Ke+1Dg3CkKzPc1NS3pnDoju50Or7MnCDc1wMhK4EbyMGTNdz1vLolyRolYX6Wc1N
	BGdjbUYHpmw+rhW3SycMRavMkfL/2xxz9lIaHT0jKGp5EVNMq0AyBSsvkv5V0a2L9wPxjONdJQVtR
	Cx2ljLxpr+EHi20AKKBzxeiLb4XMj5GKeatklu+yHgcr6ou8m7JYzT7NU+VhbzYJvyptq/H0wwq/t
	Q90wbWObw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKFaR-0008O5-Mr; Fri, 03 Apr 2020 06:13:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKFa6-00082j-T7
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 06:13:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ED0FEAD5C;
 Fri,  3 Apr 2020 06:13:27 +0000 (UTC)
Subject: Re: [PATCH] nvme: fix deadlock caused by ana update wrong locking
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200402161813.16244-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <adbfccb9-0a33-1f15-c221-84a14fb28f75@suse.de>
Date: Fri, 3 Apr 2020 08:13:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402161813.16244-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_231331_103153_4EF942A5 
X-CRM114-Status: GOOD (  23.40  )
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

T24gNC8yLzIwIDY6MTggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gVGhlIGRlYWRsb2NrIGNv
bWJpbmVzIDQgZmxvd3MgaW4gcGFyYWxsZWw6Cj4gLSBucyBzY2FubmluZyAodHJpZ2dlcmVkIGZy
b20gcmVjb25uZWN0KQo+IC0gcmVxdWVzdCB0aW1lb3V0Cj4gLSBBTkEgdXBkYXRlICh0cmlnZ2Vy
ZWQgZnJvbSByZWNvbm5lY3QpCj4gLSBJL08gY29taW5nIGludG8gdGhlIG1wYXRoIGRldmljZQo+
IAo+ICgxKSBucyBzY2FubmluZyB0cmlnZ2VycyBkaXNrIHJldmFsaWRhdGlvbiAtPiB1cGRhdGUg
ZGlzayBpbmZvIC0+Cj4gICAgICBmcmVlemUgcXVldWUgLT4gYnV0IGJsb2NrZWQsIGR1ZSB0byAo
MikKPiAKPiAoMikgdGltZW91dCBoYW5kbGVyIHJlZmVyZW5jZSB0aGUgZ191c2FnZV9jb3VudGVy
IC0gPiBidXQgYmxvY2tzIGluCj4gICAgICB0aGUgdHJhbnNwb3J0IC50aW1lb3V0KCkgaGFuZGxl
ciwgZHVlIHRvICgzKQo+IAo+ICgzKSB0aGUgdHJhbnNwb3J0IHRpbWVvdXQgaGFuZGxlciAoaW5k
aXJlY3RseSkgY2FsbHMgbnZtZV9zdG9wX3F1ZXVlKCkgLT4KPiAgICAgIHdoaWNoIHRha2VzIHRo
ZSAoZG93bl9yZWFkKSBuYW1lc3BhY2VzX3J3c2VtIC0gPiBidXQgYmxvY2tzLCBkdWUgdG8gKDQp
Cj4gCj4gKDQpIEFOQSB1cGRhdGUgdGFrZXMgdGhlIChkb3duX3dyaXRlKSBuYW1lc3BhY2VzX3J3
c2VtIC0+IGNhbGxzCj4gICAgICBudm1lX21wYXRoX3NldF9saXZlKCkgLT4gd2hpY2ggc3luY2hy
b25pemUgdGhlIG5zX2hlYWQgc3JjdQo+ICAgICAgKHNlZSBjb21taXQgNTA0ZGIwODdhYWNjKSAt
PiBidXQgYmxvY2tzLCBkdWUgdG8gKDUpCj4gCj4gKDUpIEkvTyBjYW1lIGludG8gbnZtZV9tcGF0
aF9tYWtlX3JlcXVlc3QgLT4gdG9vayBzcmN1X3JlYWRfbG9jayAtPgo+ICAgICAgZGlyZWN0X21h
a2VfcmVxdWVzdCA+IGJsa19xdWV1ZV9lbnRlciAtPiBidXQgYmxvY2tlZCwgZHVlIHRvICgxKQo+
IAo+ID09PiB0aGUgcmVxdWVzdCBxdWV1ZSBpcyB1bmRlciBmcmVlemUgLT4gZGVhZGxvY2suCj4g
Cj4gVGhlIGZpeCBpcyBtYWtpbmcgQU5BIHVwZGF0ZSB0YWtlIGEgcmVhZCBsb2NrIGFzIHRoZSBu
YW1lc3BhY2VzIGxpc3QKPiBpcyBub3QgbWFuaXB1bGF0ZWQsIGl0IGlzIGp1c3QgdGhlIG5zIGFu
ZCBucy0+aGVhZCAod2hpY2ggaXMgcHJvdGVjdGVkCj4gd2l0aCB0aGUgbnMtPmhlYWQgbG9jay4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IC0t
LQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlw
YXRoLmMKPiBpbmRleCA2MWJmODc1OTI1NzAuLjU0NjAzYmQzZTAyZCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211
bHRpcGF0aC5jCj4gQEAgLTUxMCw3ICs1MTAsNyBAQCBzdGF0aWMgaW50IG52bWVfdXBkYXRlX2Fu
YV9zdGF0ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLAo+ICAgCWlmICghbnJfbnNpZHMpCj4gICAJ
CXJldHVybiAwOwo+ICAgCj4gLQlkb3duX3dyaXRlKCZjdHJsLT5uYW1lc3BhY2VzX3J3c2VtKTsK
PiArCWRvd25fcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4gICAJbGlzdF9mb3JfZWFj
aF9lbnRyeShucywgJmN0cmwtPm5hbWVzcGFjZXMsIGxpc3QpIHsKPiAgIAkJdW5zaWduZWQgbnNp
ZCA9IGxlMzJfdG9fY3B1KGRlc2MtPm5zaWRzW25dKTsKPiAgIAo+IEBAIC01MjEsNyArNTIxLDcg
QEAgc3RhdGljIGludCBudm1lX3VwZGF0ZV9hbmFfc3RhdGUoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwKPiAgIAkJaWYgKCsrbiA9PSBucl9uc2lkcykKPiAgIAkJCWJyZWFrOwo+ICAgCX0KPiAtCXVw
X3dyaXRlKCZjdHJsLT5uYW1lc3BhY2VzX3J3c2VtKTsKPiArCXVwX3JlYWQoJmN0cmwtPm5hbWVz
cGFjZXNfcndzZW0pOwo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gClJldmlld2VkLWJ5OiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhh
bm5lcyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
