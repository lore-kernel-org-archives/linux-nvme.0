Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBC1C11D0C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 19:39:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81435206F4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nNRuWMtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81435206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wmS47dg6M7T/+kLiYmDTcEKjzeXznVMwFnhLqog6Tos=; b=nNRuWMtm8m6geV3qNP3lGPkhi
	bk2sKc8gmEQKJT63vQ7LqkG2SJ2MEN+UMJeeM/bL/z3JkFgu1r9VOYHR6yXHkDVETSMOt08sQJrnX
	ITulUyHYBLl7MRVp+Rr6HmfJDFZg4TCEA+i5hw20UiWDz2YhT8LMShui3ty2/7apULATFiZlgbKfC
	Q5XsnWRooGRXpv50qht3l1SKA44THI6iY0JCohKnPZvOK5uQaUc9vlXlhgjfcyV6Wxq4H8IUjZyhM
	uKpWlH/kj+bK54CkHVTUJcnSFLRxjM+VPTT8hX3u0/xvDC/NuLkSZ3/f1ABXFcUpoC6l6oyDVMa51
	9PsH2lgCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4rfi-0001bF-7k; Thu, 20 Feb 2020 19:39:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4rff-0001aG-7C
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 19:39:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DC182AEAB;
 Thu, 20 Feb 2020 19:39:34 +0000 (UTC)
Subject: Re: [PATCH] nvme-multipath: do not reset on unknown status
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20200220145241.12982-1-kbusch@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <41cdc156-5dee-da37-8767-1c5132fadb79@suse.de>
Date: Thu, 20 Feb 2020 20:39:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220145241.12982-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_113939_555351_B58F2F02 
X-CRM114-Status: GOOD (  25.10  )
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
Cc: John Meneghini <johnm@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yMC8yMCAzOjUyIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBGcm9tOiBKb2huIE1lbmVn
aGluaSA8am9obm1AbmV0YXBwLmNvbT4KPiAKPiBUaGUgbnZtZSBtdWx0aXBhdGggZXJyb3IgaGFu
ZGxpbmcgZGVmYXVsdHMgdG8gY29udHJvbGxlciByZXNldCBpZiB0aGUKPiBlcnJvciBpcyB1bmtu
b3duLiBUaGVyZSBhcmUsIGhvd2V2ZXIsIG5vIGV4aXN0aW5nIG52bWUgc3RhdHVzIGNvZGVzIHRo
YXQKPiBpbmRpY2F0ZSBhIHJlc2V0IHNob3VsZCBiZSB1c2VkLCBhbmQgcmVzZXR0aW5nIGNhdXNl
cyB1bm5lY2Vzc2FyeQo+IGRpc3J1cHRpb24gdG8gdGhlIHJlc3Qgb2YgSU8uCj4gCj4gQ2hhbmdl
IG52bWUncyBlcnJvciBoYW5kbGluZyB0byBmaXJzdCBjaGVjayBpZiBmYWlsb3ZlciBzaG91bGQg
aGFwcGVuLgo+IElmIG5vdCwgbGV0IHRoZSBub3JtYWwgZXJyb3IgaGFuZGxpbmcgdGFrZSBvdmVy
IHJhdGhlciB0aGFuIHJlc2V0IHRoZQo+IGNvbnRyb2xsZXIuCj4gCj4gU2lnbmVkLW9mZi1ieTog
Sm9obiBNZW5lZ2hpbmkgPGpvaG5tQG5ldGFwcC5jb20+Cj4gW2NoYW5nZWxvZ10KPiBTaWduZWQt
b2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+Cj4gLS0tCj4gICBkcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgICAgICB8ICA0ICstLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L211
bHRpcGF0aC5jIHwgMjEgKysrKysrKysrLS0tLS0tLS0tLS0tCj4gICBkcml2ZXJzL252bWUvaG9z
dC9udm1lLmggICAgICB8ICA1ICsrKy0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDE3IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBpbmRleCA4NDkxNDIyM2M1Mzcu
LjBlZWYxZWY4YzY1OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMjkyLDEwICsyOTIsOCBAQCB2b2lk
IG52bWVfY29tcGxldGVfcnEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgIAo+ICAgCWlmICh1bmxp
a2VseShzdGF0dXMgIT0gQkxLX1NUU19PSyAmJiBudm1lX3JlcV9uZWVkc19yZXRyeShyZXEpKSkg
ewo+ICAgCQlpZiAoKHJlcS0+Y21kX2ZsYWdzICYgUkVRX05WTUVfTVBBVEgpICYmCj4gLQkJICAg
IGJsa19wYXRoX2Vycm9yKHN0YXR1cykpIHsKPiAtCQkJbnZtZV9mYWlsb3Zlcl9yZXEocmVxKTsK
PiArCQkgICAgbnZtZV9mYWlsb3Zlcl9yZXEocmVxKSkKPiAgIAkJCXJldHVybjsKPiAtCQl9Cj4g
ICAKPiAgIAkJaWYgKCFibGtfcXVldWVfZHlpbmcocmVxLT5xKSkgewo+ICAgCQkJbnZtZV9yZXRy
eV9yZXEocmVxKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+IGluZGV4IDc5N2MxODMzN2Q5Ni4uMTZk
ZjBiYWFlYjQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4g
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBAQCAtNjQsMTcgKzY0LDEyIEBA
IHZvaWQgbnZtZV9zZXRfZGlza19uYW1lKGNoYXIgKmRpc2tfbmFtZSwgc3RydWN0IG52bWVfbnMg
Km5zLAo+ICAgCX0KPiAgIH0KPiAgIAo+IC12b2lkIG52bWVfZmFpbG92ZXJfcmVxKHN0cnVjdCBy
ZXF1ZXN0ICpyZXEpCj4gK2Jvb2wgbnZtZV9mYWlsb3Zlcl9yZXEoc3RydWN0IHJlcXVlc3QgKnJl
cSkKPiAgIHsKPiAgIAlzdHJ1Y3QgbnZtZV9ucyAqbnMgPSByZXEtPnEtPnF1ZXVlZGF0YTsKPiAg
IAl1MTYgc3RhdHVzID0gbnZtZV9yZXEocmVxKS0+c3RhdHVzOwo+ICAgCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7Cj4gICAKPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZucy0+aGVhZC0+cmVxdWV1ZV9sb2Nr
LCBmbGFncyk7Cj4gLQlibGtfc3RlYWxfYmlvcygmbnMtPmhlYWQtPnJlcXVldWVfbGlzdCwgcmVx
KTsKPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm5zLT5oZWFkLT5yZXF1ZXVlX2xvY2ssIGZs
YWdzKTsKPiAtCWJsa19tcV9lbmRfcmVxdWVzdChyZXEsIDApOwo+IC0KPiAgIAlzd2l0Y2ggKHN0
YXR1cyAmIDB4N2ZmKSB7Cj4gICAJY2FzZSBOVk1FX1NDX0FOQV9UUkFOU0lUSU9OOgo+ICAgCWNh
c2UgTlZNRV9TQ19BTkFfSU5BQ0NFU1NJQkxFOgo+IEBAIC0xMDMsMTUgKzk4LDE3IEBAIHZvaWQg
bnZtZV9mYWlsb3Zlcl9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgIAkJbnZtZV9tcGF0aF9j
bGVhcl9jdXJyZW50X3BhdGgobnMpOwo+ICAgCQlicmVhazsKPiAgIAlkZWZhdWx0Ogo+IC0JCS8q
Cj4gLQkJICogUmVzZXQgdGhlIGNvbnRyb2xsZXIgZm9yIGFueSBub24tQU5BIGVycm9yIGFzIHdl
IGRvbid0IGtub3cKPiAtCQkgKiB3aGF0IGNhdXNlZCB0aGUgZXJyb3IuCj4gLQkJICovCj4gLQkJ
bnZtZV9yZXNldF9jdHJsKG5zLT5jdHJsKTsKPiAtCQlicmVhazsKPiArCQkvKiBUaGlzIHdhcyBh
IG5vbi1BTkEgZXJyb3Igc28gZm9sbG93IHRoZSBub3JtYWwgZXJyb3IgcGF0aC4gKi8KPiArCQly
ZXR1cm4gZmFsc2U7Cj4gICAJfQo+ICAgCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmbnMtPmhlYWQt
PnJlcXVldWVfbG9jaywgZmxhZ3MpOwo+ICsJYmxrX3N0ZWFsX2Jpb3MoJm5zLT5oZWFkLT5yZXF1
ZXVlX2xpc3QsIHJlcSk7Cj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZucy0+aGVhZC0+cmVx
dWV1ZV9sb2NrLCBmbGFncyk7Cj4gKwlibGtfbXFfZW5kX3JlcXVlc3QocmVxLCAwKTsKPiArCj4g
ICAJa2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVxdWV1ZV93b3JrKTsKPiArCXJl
dHVybiB0cnVlOwo+ICAgfQo+ICAgCj4gICB2b2lkIG52bWVfa2lja19yZXF1ZXVlX2xpc3RzKHN0
cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+IGluZGV4IDEwMjRmZWM3OTE0Yy4uZDgw
MGI5YTUxYzJjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+IEBAIC01NTAsNyArNTUwLDcgQEAgdm9pZCBudm1l
X21wYXRoX3dhaXRfZnJlZXplKHN0cnVjdCBudm1lX3N1YnN5c3RlbSAqc3Vic3lzKTsKPiAgIHZv
aWQgbnZtZV9tcGF0aF9zdGFydF9mcmVlemUoc3RydWN0IG52bWVfc3Vic3lzdGVtICpzdWJzeXMp
Owo+ICAgdm9pZCBudm1lX3NldF9kaXNrX25hbWUoY2hhciAqZGlza19uYW1lLCBzdHJ1Y3QgbnZt
ZV9ucyAqbnMsCj4gICAJCQlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBpbnQgKmZsYWdzKTsKPiAt
dm9pZCBudm1lX2ZhaWxvdmVyX3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKTsKPiArYm9vbCBudm1l
X2ZhaWxvdmVyX3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKTsKPiAgIHZvaWQgbnZtZV9raWNrX3Jl
cXVldWVfbGlzdHMoc3RydWN0IG52bWVfY3RybCAqY3RybCk7Cj4gICBpbnQgbnZtZV9tcGF0aF9h
bGxvY19kaXNrKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsc3RydWN0IG52bWVfbnNfaGVhZCAqaGVh
ZCk7Cj4gICB2b2lkIG52bWVfbXBhdGhfYWRkX2Rpc2soc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1
Y3QgbnZtZV9pZF9ucyAqaWQpOwo+IEBAIC01OTksOCArNTk5LDkgQEAgc3RhdGljIGlubGluZSB2
b2lkIG52bWVfc2V0X2Rpc2tfbmFtZShjaGFyICpkaXNrX25hbWUsIHN0cnVjdCBudm1lX25zICpu
cywKPiAgIAlzcHJpbnRmKGRpc2tfbmFtZSwgIm52bWUlZG4lZCIsIGN0cmwtPmluc3RhbmNlLCBu
cy0+aGVhZC0+aW5zdGFuY2UpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBudm1l
X2ZhaWxvdmVyX3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+ICtzdGF0aWMgaW5saW5lIGJvb2wg
bnZtZV9mYWlsb3Zlcl9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgIHsKPiArCXJldHVybiBm
YWxzZTsKPiAgIH0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2tpY2tfcmVxdWV1ZV9saXN0
cyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+ICAgewo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2Uu
ZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhS
QiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7Zy
ZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
