Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19AC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 13:34:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB5561208
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 13:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5561208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ughkoSjfu2nl4NJ01u062O/NcqCOx/MUPkUV7QCWNLE=; b=JvF1fbpK7OQU+Cq3r5+YE5w37
	XluAlW2Y/eBEPJpi5Ow7uhF3xo/clHW98kHSt7qxAIkSHzntura3j6KjMKnUdrbJaqu8JlZ5+iqgW
	57+D+jco3gMamvcUed19cgGM7ijsClSncOiy6zUQtbmNLuRIb0eJmBpIRIlQTSjjlPCxodD/ObaTW
	kLAoyoULrHA8zbKOyPAOnG7rDSDYIfaE7YyOJUs7FjP12GA2wo29lsB6rCaY8OzESQZSMLIsHcPCO
	7LiIYnUEZaiT1oldp5ZOCjGZiXyBUMJNcEFAme/v2VtJSXQZmN3GunL0pPi9MhxbT5N6GlnCSUHPy
	x8GEic4hQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldYhn-00Dx5X-Ko; Mon, 03 May 2021 13:33:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldYhi-00Dx5B-Gv
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 13:33:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=1vgsJKEFASSp/gtXc0RMDJGM+tcpU99iGiCsIt1JwME=; b=bY9hp5uNkq9hdN1ZXgtnOniqSt
 GfwGRRNysBEpzkq0meslOD1ulXtdYc+F+K/jOUdz/26Vr5PF3chfhUDJzWOgztKMLQDkxqKu60IOO
 UUUueQBV1Lv+dry5IgEqmdDZgm8C+PptOHxmt3XTVDQcQNWStPmvjStCFZytuvZwkQGOSn8WrXImx
 26Pzydvsh5Wl6I+4WsmsC+JGuEVL9Kwptud6KVxCcZT9Bj+XjxMlKVk0uFnkSUA00nCVR8hG/BZlP
 4sf60uGCEOM/a5lWWtWMCaBxO/9gJsfLpnBYI7IMXF2EqA0YJHv0q/F4bW2zruhtkKmw8SBYwnlQ3
 q9IMOeaw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldYhf-003613-Pi
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 13:33:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E04A9B118;
 Mon,  3 May 2021 13:33:32 +0000 (UTC)
Subject: Re: [PATCH] nvme-multipath: Reset bi_disk to ns head when failover
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210503125741.68117-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7ab943e0-5ac4-d370-0a15-3108f689e478@suse.de>
Date: Mon, 3 May 2021 15:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210503125741.68117-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_063339_999145_33EE694F 
X-CRM114-Status: GOOD (  21.28  )
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

T24gNS8zLzIxIDI6NTcgUE0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4gVGhlIHBhdGggY2FuIGJl
IHN0YWxlIHdoZW4gd2UgZmFpbG92ZXIuIElmIHdlIGRvbid0IHJlc2V0IHRoZSBiZGV2IHRvCj4g
dGhlIG5zIGhlYWQgYW5kIHRoZSBJL08gZmluYWxseSBjb21wbGV0ZXMgaW4gZW5kX2lvKCkgaXQg
d2lsbCB0cmlnZ2Vycwo+IGEgY3Jhc2guIEJ5IHJlc2V0dGluZyB0aGUgdG8gbnMgaGVhZCBkaXNr
IHNvIHRoYXQgdGhlIHN1Ym1pdCBwYXRoIGNhbgo+IG1hcCB0aGUgcmVxdWVzdCB0byBhbiBhY3Rp
dmUgcGF0aC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2Uu
ZGU+Cj4gLS0tCj4gCj4gVGhlIHBhdGNoIGlzIGFnYWluc3QgbnZtZS01LjEzLgo+IAo+IFsgNjU1
Mi4xNTUyNDRdIENhbGwgVHJhY2U6Cj4gWyA2NTUyLjE1NTI1MV0gIGJpb19lbmRpbysweDc0LzB4
MTIwCj4gWyA2NTUyLjE1NTI2MF0gIG52bWVfbnNfaGVhZF9zdWJtaXRfYmlvKzB4MzZmLzB4M2Uw
IFtudm1lX2NvcmVdCj4gWyA2NTUyLjE1NTI2Nl0gID8gX19zd2l0Y2hfdG9fYXNtKzB4MzQvMHg3
MAo+IFsgNjU1Mi4xNTUyNjldICA/IF9fc3dpdGNoX3RvX2FzbSsweDQwLzB4NzAKPiBbIDY1NTIu
MTU1MjcxXSAgc3VibWl0X2Jpb19ub2FjY3QrMHgxNzUvMHg0OTAKPiBbIDY1NTIuMTU1Mjc0XSAg
PyBfX3N3aXRjaF90b19hc20rMHgzNC8weDcwCj4gWyA2NTUyLjE1NTI3N10gID8gX19zd2l0Y2hf
dG9fYXNtKzB4MzQvMHg3MAo+IFsgNjU1Mi4xNTUyODRdICA/IG52bWVfcmVxdWV1ZV93b3JrKzB4
NWEvMHg3MCBbbnZtZV9jb3JlXQo+IFsgNjU1Mi4xNTUyOTBdICBudm1lX3JlcXVldWVfd29yaysw
eDVhLzB4NzAgW252bWVfY29yZV0KPiBbIDY1NTIuMTU1Mjk2XSAgcHJvY2Vzc19vbmVfd29yaysw
eDFmNC8weDNlMAo+IFsgNjU1Mi4xNTUyOTldICB3b3JrZXJfdGhyZWFkKzB4MmQvMHgzZTAKPiBb
IDY1NTIuMTU1MzAyXSAgPyBwcm9jZXNzX29uZV93b3JrKzB4M2UwLzB4M2UwCj4gWyA2NTUyLjE1
NTMwNV0gIGt0aHJlYWQrMHgxMGQvMHgxMzAKPiBbIDY1NTIuMTU1MzA3XSAgPyBrdGhyZWFkX3Bh
cmsrMHhhMC8weGEwCj4gWyA2NTUyLjE1NTMxMV0gIHJldF9mcm9tX2ZvcmsrMHgzNS8weDQwCj4g
Cj4gICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDYgKysrKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBpbmRleCAw
ZDBkZTM0MzNmMzcuLjBmYWYyNjdmYWE1OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9tdWx0aXBhdGguYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gQEAg
LTY5LDcgKzY5LDkgQEAgdm9pZCBudm1lX2ZhaWxvdmVyX3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVx
KQo+ICAgewo+ICAgCXN0cnVjdCBudm1lX25zICpucyA9IHJlcS0+cS0+cXVldWVkYXRhOwo+ICAg
CXUxNiBzdGF0dXMgPSBudm1lX3JlcShyZXEpLT5zdGF0dXMgJiAweDdmZjsKPiArCXN0cnVjdCBi
bG9ja19kZXZpY2UgKmJkZXY7Cj4gICAJdW5zaWduZWQgbG9uZyBmbGFnczsKPiArCXN0cnVjdCBi
aW8gKmJpbzsKPiAgIAo+ICAgCW52bWVfbXBhdGhfY2xlYXJfY3VycmVudF9wYXRoKG5zKTsKPiAg
IAo+IEBAIC04Myw5ICs4NSwxMyBAQCB2b2lkIG52bWVfZmFpbG92ZXJfcmVxKHN0cnVjdCByZXF1
ZXN0ICpyZXEpCj4gICAJCXF1ZXVlX3dvcmsobnZtZV93cSwgJm5zLT5jdHJsLT5hbmFfd29yayk7
Cj4gICAJfQo+ICAgCj4gKwliZGV2ID0gYmRnZXRfZGlzayhucy0+aGVhZC0+ZGlzaywgMCk7Cj4g
ICAJc3Bpbl9sb2NrX2lycXNhdmUoJm5zLT5oZWFkLT5yZXF1ZXVlX2xvY2ssIGZsYWdzKTsKPiAr
CWZvciAoYmlvID0gcmVxLT5iaW87IGJpbzsgYmlvID0gYmlvLT5iaV9uZXh0KQo+ICsJCWJpb19z
ZXRfZGV2KGJpbywgYmRldik7Cj4gICAJYmxrX3N0ZWFsX2Jpb3MoJm5zLT5oZWFkLT5yZXF1ZXVl
X2xpc3QsIHJlcSk7Cj4gICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbnMtPmhlYWQtPnJlcXVl
dWVfbG9jaywgZmxhZ3MpOwo+ICsJYmRwdXQoYmRldik7Cj4gICAKPiAgIAlibGtfbXFfZW5kX3Jl
cXVlc3QocmVxLCAwKTsKPiAgIAlrYmxvY2tkX3NjaGVkdWxlX3dvcmsoJm5zLT5oZWFkLT5yZXF1
ZXVlX3dvcmspOwo+IApNYXliZSBhIFdBUk5fT04oIWJkZXYpIGFmdGVyIGJkZ2V0X2Rpc2soKSwg
YnV0IG90aGVyd2lzZToKClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5k
ZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
