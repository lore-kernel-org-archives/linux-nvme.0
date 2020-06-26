Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3CC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:55:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5A1204EC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r3Vw5B/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5A1204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4xE20THVUiM90IMc8wKD7SRemryJ589iGhogbvmntIA=; b=r3Vw5B/QynDV5p7M2lJUOTaOw
	4bcO2MhxE5eIJ9cBzHSCJMqj3y+MuYFHPfDW7fVDGpVeeXRinge0LdaaBK6Oj6vLXMgk9nWjo/N8q
	Jf6t8yRNpwTJ0AOu8nJ5RtKKOUR/C+VPP0ELLTnaNwcsKR/+Q2qdf5xw+oNGOWBJRWZ0nsruq+aVz
	nmIpEAdhHRI71bQyqCAoO/sr5HTeyrtNtMaVJSJ6sYy6Ktf3KVoj0hwshvUZ4kJaZKTvxOkdiE2l3
	pV5K/pveqJ2jVHzXSMCD7I1fvNzLCONKYXtCDhUhFDEMpNXVFfMiO7+/I5LtOTjFLsecJNNcWKvVs
	W9ZL/jDHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqhE-0005vr-AQ; Fri, 26 Jun 2020 15:55:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqhB-0005vW-Pf
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:55:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A95D3AF0F;
 Fri, 26 Jun 2020 15:55:16 +0000 (UTC)
Subject: Re: [PATCH v3 for-5.8-rc 3/5] nvme: don't protect ns mutation with
 ns->head->lock
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200624085312.35967-1-sagi@grimberg.me>
 <20200624085312.35967-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b9e5a68d-a363-ec84-cad4-3e0dba95c09b@suse.de>
Date: Fri, 26 Jun 2020 17:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624085312.35967-4-sagi@grimberg.me>
Content-Language: en-US
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8yNC8yMCAxMDo1MyBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBSaWdodCBub3cgbnMt
PmhlYWQtPmxvY2sgaXMgcHJvdGVjdGluZyBuYW1lc3BhY2UgbXV0YXRpb24KPiB3aGljaCBpcyB3
cm9uZyBhbmQgdW5uZWVkZWQuIE1vdmUgaXQgdG8gb25seSBwcm90ZWN0Cj4gYWdhaW5zdCBoZWFk
IG11dGF0aW9ucy4gV2hpbGUgd2UncmUgYXQgaXQsIHJlbW92ZSB1bm5lY2Vzc2FyeQo+IG5zLT5o
ZWFkIHJlZmVyZW5jZSBhcyB3ZSBhbHJlYWR5IGhhdmUgaGVhZCBwb2ludGVyLgo+IAo+IFRoZSBw
cm9ibGVtIHdpdGggdGhpcyBpcyB0aGF0IHRoZSBoZWFkLT5sb2NrIHNwYW5zCj4gbXBhdGggZGlz
ayBub2RlIEkvTyB0aGF0IG1heSBibG9jayB1bmRlciBzb21lIGNvbmRpdGlvbnMgKGlmCj4gZm9y
IGV4YW1wbGUgdGhlIGNvbnRyb2xsZXIgaXMgZGlzY29ubmVjdGluZyBvciB0aGUgcGF0aAo+IGJl
Y2FtZSBpbmFjY2Vzc2libGUpLCBUaGUgbG9ja2luZyBzY2hlbWUgZG9lcyBub3QgYWxsb3cgYW55
Cj4gb3RoZXIgcGF0aCB0byBlbmFibGUgaXRzZWxmLCBwcmV2ZW50aW5nIGJsb2NrZWQgSS9PIHRv
IGNvbXBsZXRlCj4gYW5kIGZvcndhcmQtcHJvZ3Jlc3MgZnJvbSB0aGVyZS4KPiAKPiBUaGlzIGlz
IGEgcHJlcGFyYXRpb24gcGF0Y2ggZm9yIHRoZSBmaXggaW4gYSBzdWJzZXF1ZW50IHBhdGNoCj4g
d2hlcmUgdGhlIGRpc2sgSS9PIHdpbGwgYWxzbyBiZSBkb25lIG91dHNpZGUgdGhlIGhlYWQtPmxv
Y2suCj4gCj4gRml4ZXM6IDBkMGI2NjBmMjE0ZCAoIm52bWU6IGFkZCBBTkEgc3VwcG9ydCIpCj4g
U2lnbmVkLW9mZi1ieTogQW50b24gRWlkZWxtYW4gPGFudG9uQGxpZ2h0Yml0c2xhYnMuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gLS0tCj4g
ICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDEyICsrKystLS0tLS0tLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2ZXJzL252bWUvaG9zdC9t
dWx0aXBhdGguYwo+IGluZGV4IDBlZjE4M2MxMTUzZS4uNWM0OGEzOGFlYmY4IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMKPiBAQCAtNDA5LDExICs0MDksMTAgQEAgc3RhdGljIHZvaWQgbnZtZV9t
cGF0aF9zZXRfbGl2ZShzdHJ1Y3QgbnZtZV9ucyAqbnMpCj4gICB7Cj4gICAJc3RydWN0IG52bWVf
bnNfaGVhZCAqaGVhZCA9IG5zLT5oZWFkOwo+ICAgCj4gLQlsb2NrZGVwX2Fzc2VydF9oZWxkKCZu
cy0+aGVhZC0+bG9jayk7Cj4gLQo+ICAgCWlmICghaGVhZC0+ZGlzaykKPiAgIAkJcmV0dXJuOwo+
ICAgCj4gKwltdXRleF9sb2NrKCZoZWFkLT5sb2NrKTsKPiAgIAlpZiAoIShoZWFkLT5kaXNrLT5m
bGFncyAmIEdFTkhEX0ZMX1VQKSkKPiAgIAkJZGV2aWNlX2FkZF9kaXNrKCZoZWFkLT5zdWJzeXMt
PmRldiwgaGVhZC0+ZGlzaywKPiAgIAkJCQludm1lX25zX2lkX2F0dHJfZ3JvdXBzKTsKPiBAQCAt
NDI2LDkgKzQyNSwxMCBAQCBzdGF0aWMgdm9pZCBudm1lX21wYXRoX3NldF9saXZlKHN0cnVjdCBu
dm1lX25zICpucykKPiAgIAkJCV9fbnZtZV9maW5kX3BhdGgoaGVhZCwgbm9kZSk7Cj4gICAJCXNy
Y3VfcmVhZF91bmxvY2soJmhlYWQtPnNyY3UsIHNyY3VfaWR4KTsKPiAgIAl9Cj4gKwltdXRleF91
bmxvY2soJmhlYWQtPmxvY2spOwo+ICAgCj4gLQlzeW5jaHJvbml6ZV9zcmN1KCZucy0+aGVhZC0+
c3JjdSk7Cj4gLQlrYmxvY2tkX3NjaGVkdWxlX3dvcmsoJm5zLT5oZWFkLT5yZXF1ZXVlX3dvcmsp
Owo+ICsJc3luY2hyb25pemVfc3JjdSgmaGVhZC0+c3JjdSk7Cj4gKwlrYmxvY2tkX3NjaGVkdWxl
X3dvcmsoJmhlYWQtPnJlcXVldWVfd29yayk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQgbnZt
ZV9wYXJzZV9hbmFfbG9nKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHZvaWQgKmRhdGEsCj4gQEAg
LTQ4MywxNCArNDgzLDEyIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBudm1lX3N0YXRlX2lzX2xpdmUo
ZW51bSBudm1lX2FuYV9zdGF0ZSBzdGF0ZSkKPiAgIHN0YXRpYyB2b2lkIG52bWVfdXBkYXRlX25z
X2FuYV9zdGF0ZShzdHJ1Y3QgbnZtZV9hbmFfZ3JvdXBfZGVzYyAqZGVzYywKPiAgIAkJc3RydWN0
IG52bWVfbnMgKm5zKQo+ICAgewo+IC0JbXV0ZXhfbG9jaygmbnMtPmhlYWQtPmxvY2spOwo+ICAg
CW5zLT5hbmFfZ3JwaWQgPSBsZTMyX3RvX2NwdShkZXNjLT5ncnBpZCk7Cj4gICAJbnMtPmFuYV9z
dGF0ZSA9IGRlc2MtPnN0YXRlOwo+ICAgCWNsZWFyX2JpdChOVk1FX05TX0FOQV9QRU5ESU5HLCAm
bnMtPmZsYWdzKTsKPiAgIAo+ICAgCWlmIChudm1lX3N0YXRlX2lzX2xpdmUobnMtPmFuYV9zdGF0
ZSkpCj4gICAJCW52bWVfbXBhdGhfc2V0X2xpdmUobnMpOwo+IC0JbXV0ZXhfdW5sb2NrKCZucy0+
aGVhZC0+bG9jayk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQgbnZtZV91cGRhdGVfYW5hX3N0
YXRlKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4gQEAgLTY2OSwxMCArNjY3LDggQEAgdm9pZCBu
dm1lX21wYXRoX2FkZF9kaXNrKHN0cnVjdCBudm1lX25zICpucywgc3RydWN0IG52bWVfaWRfbnMg
KmlkKQo+ICAgCQkJbnZtZV91cGRhdGVfbnNfYW5hX3N0YXRlKCZkZXNjLCBucyk7Cj4gICAJCX0K
PiAgIAl9IGVsc2Ugewo+IC0JCW11dGV4X2xvY2soJm5zLT5oZWFkLT5sb2NrKTsKPiAgIAkJbnMt
PmFuYV9zdGF0ZSA9IE5WTUVfQU5BX09QVElNSVpFRDsKPiAgIAkJbnZtZV9tcGF0aF9zZXRfbGl2
ZShucyk7Cj4gLQkJbXV0ZXhfdW5sb2NrKCZucy0+aGVhZC0+bG9jayk7Cj4gICAJfQo+ICAgCj4g
ICAJaWYgKGJkaV9jYXBfc3RhYmxlX3BhZ2VzX3JlcXVpcmVkKG5zLT5xdWV1ZS0+YmFja2luZ19k
ZXZfaW5mbykpIHsKPiAKQnV0IHdoYXQgcHJvdmlkZXMgc3luY2hyb25penNhdGlvbiBvZiB0aGUg
dXBkYXRlZCBuYW1lc3BhY2UgdmFsdWVzPwpBbmQgaWYgaXQgZG9lc24ndCByZXF1aXJlIHN5bmNo
cm9uaXNhdGlvbiBpdCB3b3VsZCBuZWVkIHNvbWUgZXhwbGFuYXRpb24gCndoeSBub3QuCgpDaGVl
cnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICBUZWFtbGVhZCBT
dG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
