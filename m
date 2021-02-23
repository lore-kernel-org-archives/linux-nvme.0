Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B23C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 14:07:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CC764DE7
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 14:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CC764DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IOrNdP+EVgttG7BmQd2onOJZg2zt8CciplGbh1OhfT4=; b=MZgG62+xmKGYy98NgM2dBrNhU
	BLFSMVAH9g/fdjXFiqqZMcQLaoiIRlE/lT2z0/d50Mxa1+qpctYnJg8l8hYFOKLlL34AnFes1eXoT
	u/C3mR1+Eym3JEARVeN4CciGBt4f6fz2j/aVd3GgNpvDBeKeWgjuFxvhr0kbyUIddA1W64taA0v6S
	MCjkb5qUx9AQaAI3m6xt4UnEDmwODPrpSuTrglsFTy1Fxqge5CI8KHtjqt+HxpXSYpJdyv/FGltn6
	VdVe7Ac2NYDitsf8X4bixovZm9ophq3wpX79i0PWwozjFBc+qNb+90jBQcs7QjjL8vk1RYLbguRn9
	MKRMzRTtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEYLW-0001ss-2s; Tue, 23 Feb 2021 14:07:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEYLS-0001sY-Vu
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 14:07:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 55772ACD4;
 Tue, 23 Feb 2021 14:07:21 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
To: Minwoo Im <minwoo.im.dev@gmail.com>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-3-hare@suse.de>
 <20210223125656.GC2119@localhost.localdomain>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ebe8faf5-1caf-375a-b5b9-33520a801478@suse.de>
Date: Tue, 23 Feb 2021 15:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223125656.GC2119@localhost.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_090723_289232_92FAAB6B 
X-CRM114-Status: GOOD (  24.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yMy8yMSAxOjU2IFBNLCBNaW53b28gSW0gd3JvdGU6Cj4gT24gMjEtMDItMjMgMTI6NTk6
MjIsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gVGhlIG11bHRpcGF0aCBjb2RlIGN1cnJlbnRs
eSBkZWxldGVzIHRoZSBkaXNrIG9ubHkgYWZ0ZXIgYWxsIHJlZmVyZW5jZXMKPj4gdG8gaXQgYXJl
IGRyb3BwZWQgcmF0aGVyIHRoYW4gd2hlbiB0aGUgbGFzdCBwYXRoIHRvIHRoYXQgZGlzayBpcyBs
b3N0Lgo+PiBUaGlzIGhhcyBiZWVuIHJlcG9ydGVkIHRvIGNhdXNlIHByb2JsZW1zIHdpdGggc29t
ZSB1c2UgY2FzZXMgbGlrZSBNRCBSQUlELgo+Pgo+PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgYW4g
YWx0ZXJuYXRpdmUgYmVoYXZpb3VyIG9mIGRlbGV0aW5nIHRoZSBkaXNrIHdoZW4KPj4gdGhlIGxh
c3QgcGF0aCBpcyBnb25lLCBpZSB0aGUgc2FtZSBiZWhhdmlvdXIgYXMgbm9uLW11bHRpcGF0aGVk
IG52bWUKPj4gZGV2aWNlcy4gVGhlIG5ldyBiZWhhdmlvdXIgd2lsbCBiZSBzZWxlY3RlZCB3aXRo
IHRoZSAnZmFpbF9pZl9ub19wYXRoJwo+PiBhdHRyaWJ1dGUsIGFzIHJldHVybmluZyBpdCdzIGFy
Z3VhYmx5IHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkuCj4+Cj4+IFN1Z2dlc3RlZC1ieTogS2VpdGgg
QnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVj
a2UgPGhhcmVAc3VzZS5kZT4KPj4gLS0tCj4+ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAg
ICB8ICAxICsKPj4gIGRyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgIDMgKystCj4+ICBk
cml2ZXJzL252bWUvaG9zdC9udm1lLmggICAgICB8IDE3ICsrKysrKysrKysrKysrKy0tCj4+ICAz
IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKPj4gaW5kZXggMmZiM2VjYzBjNTNiLi5kNzE3YTYyODNkNmUgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPj4gQEAgLTU0Miw2ICs1NDIsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2ZyZWVfbnNfaGVhZChz
dHJ1Y3Qga3JlZiAqcmVmKQo+PiAgCQljb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgbnZtZV9uc19o
ZWFkLCByZWYpOwo+PiAgCj4+ICAJbnZtZV9tcGF0aF9yZW1vdmVfZGlzayhoZWFkKTsKPj4gKwlu
dm1lX21wYXRoX3B1dF9kaXNrKGhlYWQpOwo+PiAgCWlkYV9zaW1wbGVfcmVtb3ZlKCZoZWFkLT5z
dWJzeXMtPm5zX2lkYSwgaGVhZC0+aW5zdGFuY2UpOwo+PiAgCWNsZWFudXBfc3JjdV9zdHJ1Y3Qo
JmhlYWQtPnNyY3UpOwo+PiAgCW52bWVfcHV0X3N1YnN5c3RlbShoZWFkLT5zdWJzeXMpOwo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9tdWx0aXBhdGguYwo+PiBpbmRleCBkNTc3M2VhMTA1YjEuLmY5OTViODIzNDYyMiAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4gKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4gQEAgLTcyNCw2ICs3MjQsOCBAQCB2b2lkIG52bWVf
bXBhdGhfYWRkX2Rpc2soc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgbnZtZV9pZF9ucyAqaWQp
Cj4+ICAKPj4gIHZvaWQgbnZtZV9tcGF0aF9yZW1vdmVfZGlzayhzdHJ1Y3QgbnZtZV9uc19oZWFk
ICpoZWFkKQo+PiAgewo+PiArCWlmICh0ZXN0X2JpdChOVk1FX05TSEVBRF9GQUlMX0lGX05PX1BB
VEgsICZoZWFkLT5mbGFncykpCj4+ICsJCXJldHVybjsKPj4gIAlpZiAoIWhlYWQtPmRpc2spCj4+
ICAJCXJldHVybjsKPj4gIAlpZiAoaGVhZC0+ZGlzay0+ZmxhZ3MgJiBHRU5IRF9GTF9VUCkKPj4g
QEAgLTc0MSw3ICs3NDMsNiBAQCB2b2lkIG52bWVfbXBhdGhfcmVtb3ZlX2Rpc2soc3RydWN0IG52
bWVfbnNfaGVhZCAqaGVhZCkKPj4gIAkJICovCj4+ICAJCWhlYWQtPmRpc2stPnF1ZXVlID0gTlVM
TDsKPj4gIAl9Cj4+IC0JcHV0X2Rpc2soaGVhZC0+ZGlzayk7Cj4+ICB9Cj4+ICAKPj4gIGludCBu
dm1lX21wYXRoX2luaXQoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfaWRfY3Ry
bCAqaWQpCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJz
L252bWUvaG9zdC9udm1lLmgKPj4gaW5kZXggM2QyNTEzZjgxOTRkLi5lNmVmYTA4NWYwOGEgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9udm1lLmgKPj4gQEAgLTY4MSw4ICs2ODEsMTIgQEAgc3RhdGljIGlubGluZSB2b2lk
IG52bWVfbXBhdGhfY2hlY2tfbGFzdF9wYXRoKHN0cnVjdCBudm1lX25zICpucykKPj4gIHsKPj4g
IAlzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkID0gbnMtPmhlYWQ7Cj4+ICAKPj4gLQlpZiAoaGVh
ZC0+ZGlzayAmJiBsaXN0X2VtcHR5KCZoZWFkLT5saXN0KSkKPj4gLQkJa2Jsb2NrZF9zY2hlZHVs
ZV93b3JrKCZoZWFkLT5yZXF1ZXVlX3dvcmspOwo+PiArCWlmIChoZWFkLT5kaXNrICYmIGxpc3Rf
ZW1wdHkoJmhlYWQtPmxpc3QpKSB7Cj4+ICsJCWlmICh0ZXN0X2JpdChOVk1FX05TSEVBRF9GQUlM
X0lGX05PX1BBVEgsICZoZWFkLT5mbGFncykpCj4+ICsJCQludm1lX21wYXRoX3JlbW92ZV9kaXNr
KGhlYWQpOwo+IAo+IERvZXMgaXQgbmVlZCB0byBjYWxsIG52bWVfbXBhdGhfcmVtb3ZlX2Rpc2sg
aGVyZSA/ICBJdCBsb29rcyBsaWtlIGl0Cj4gcmV0dXJucyB3aXRoIG5vdGhpbmcgcmlnaHQgYXdh
eSBpZiBOVk1FX05TSEVBRF9GQUlMX0lGX05PX1BBVEggaXMgc2V0Lgo+IApBcmdsLiBZZXMsIHlv
dSBhcmUgY29ycmVjdC4KCkknbGwgYmUgcmV3b3JraW5nIHRoYXQgb25lLgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
