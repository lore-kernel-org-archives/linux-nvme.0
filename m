Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134AC432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:32:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361292071A
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NJLGG39c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361292071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=weN/hmF4TwWfLWZvj489C3w/P5UeOK1bbxIRSn7DGgg=; b=NJLGG39cbwQ93ZpB/S9cMlerJ
	reaamuRUZkyh3OgkTUtUE9pM6HojTP8Nd/b0nDEPFwr5TkYGnlRELiHfE5lN18q6QB7eG/nNOHOVo
	YWaqpjBu24IISFXYCBmx2XRiEZq3EXILTwSIGKKfPd/xi8EhZNt5RS+dlAx7HlNKIMDBRl8W4UD2H
	VXX5R5GPSMS2O2wnadwaXLk0+BAL89ugqNdDm5yQhUEddlUwz4rgv10H7noJoapHpAvlBnZUv7Zln
	pURxTTl8T0V3Xn+CjTKwrmRe1jkrIIKs+jcedvjKGm4gSVuiUzxt8efbP+W/vpwj/drbZXoHnc3ft
	wGRTPtqAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZdlW-0005La-95; Tue, 26 Nov 2019 16:32:38 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZdlT-0005Kl-39
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 16:32:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B9723B3EB;
 Tue, 26 Nov 2019 16:32:33 +0000 (UTC)
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
To: Keith Busch <kbusch@kernel.org>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <90bb47cc-8a4b-1ddb-be6c-d237bfbe88f8@suse.de>
Date: Tue, 26 Nov 2019 17:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_083235_426957_6A793576 
X-CRM114-Status: GOOD (  23.18  )
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
Cc: Jen Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, John Meneghini <johnm@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjYvMTkgNTowNSBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gW2NjJ2luZyBsaW51eC1i
bG9jaywgSmVuc10KPiAKPiBPbiBUdWUsIE5vdiAyNiwgMjAxOSBhdCAwMjozNjo1MFBNICswMTAw
LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggZml4ZXMgYSBidWcgaW4gbnZt
ZV9jb21wbGV0ZV9ycSBsb2dpYyBpbnRyb2R1Y2VkIGJ5Cj4+IEVuaGFuY2VkIENvbW1hbmQgUmV0
cnkgY29kZS4gQWNjb3JkaW5nIHRvIFRQLTQwMzMgdGhlIGNvbnRyb2xsZXIKPj4gb25seSBzZXRz
IENEUiB3aGVuIHRoZSBDb21tYW5kIEludGVycnVwdGVkIHN0YXR1cyBpcyByZXR1cm5lZC4KPj4g
VGhlIGN1cnJlbnQgY29kZSBpbnRlcnByZXRzIENvbW1hbmQgSW50ZXJydXB0ZWQgc3RhdHVzIGFz
IGEKPj4gQkxLX1NUU19JT0VSUiwgd2hpY2ggcmVzdWx0cyBpbiBhIGNvbnRyb2xsZXIgcmVzZXQg
aWYKPj4gUkVRX05WTUVfTVBBVEggaXMgc2V0Lgo+IAo+IEkgc2VlIHRoYXQgQ29tbWFuZCBJbnRl
cnJ1cHRlZCBzdGF0dXMgcmVxdWlyZXMgQUNSRSBlbmFibGVkLCBidXQgSSBkb24ndAo+IHNlZSB0
aGUgVFAgc2F5aW5nIHRoYXQgdGhlIENRRSBDUkQgZmllbGRzIGFyZSB1c2VkIG9ubHkgd2l0aCB0
aGF0IHN0YXR1cwo+IGNvZGUuIEknbSBwcmV0dHkgc3VyZSBJJ3ZlIHNlZW4gaXQgdXNlZCBmb3Ig
TmFtZXNwYWNlIE5vdCBSZWFkeSBzdGF0dXMKPiBhcyB3ZWxsLiBUaGF0IHdvdWxkIGFsc28gZmFp
bCBNUEFUSCBmb3IgdGhlIHNhbWUgcmVhc29uIGFzIHRoaXMgbmV3Cj4gc3RhdHVzLi4uCj4gCk5v
LCB0cnVlLCBDUkQgaXMgbm90IGRpcmVjdGx5IHJlbGF0ZWQgdG8gJ2NvbW1hbmQgaW50ZXJydXB0
ZWQnLgpBY2NvcmRpbmcgdG8gdGhlIHBvd2VycyB0aGF0IGJlIENSRCBldmFsdWF0aW9uIGlzIGRl
cGVuZGluZyBvbiB0aGUgQUNSRSAKc2V0dGluZyAoYW5kIGhlbmNlIHNob3VsZCBiZSBldmFsdWF0
ZWQgd2hlbmV2ZXIgYSBjb21tYW5kIG5lZWRzIHRvIGJlIApyZXRyaWVkKSwgYnV0ICdjb21tYW5k
IGludGVycnVwdGVkJyB3aWxsIG9ubHkgYmUgcmV0dXJuZWQgaWYgQUNSRSBpcyAKZW5hYmxlZC4K
Q29uc2VxdWVudGx5LCB3aGVuZXZlciB5b3UgZ2V0IGEgJ2NvbW1hbmQgaW50ZXJydXB0ZWQnIHlv
dSBuZWVkIHRvIGNoZWNrIAp0aGUgQ1JEIHNldHRpbmcgdG8gZmlndXJlIG91dCB0aGUgZGVsYXku
Cgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4+IGluZGV4IDEwOGY2MGI0NjgwNC4uNzUyYTQwZGFmMmIzIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jCj4+IEBAIC0yMDEsNiArMjAxLDggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1l
X2Vycm9yX3N0YXR1cyh1MTYgc3RhdHVzKQo+PiAgIAlzd2l0Y2ggKHN0YXR1cyAmIDB4N2ZmKSB7
Cj4+ICAgCWNhc2UgTlZNRV9TQ19TVUNDRVNTOgo+PiAgIAkJcmV0dXJuIEJMS19TVFNfT0s7Cj4+
ICsJY2FzZSBOVk1FX1NDX0NPTU1BTkRfSU5URVJSVVBURUQ6Cj4+ICsJCXJldHVybiBCTEtfU1RT
X1JFU09VUkNFOwo+PiAgIAljYXNlIE5WTUVfU0NfQ0FQX0VYQ0VFREVEOgo+PiAgIAkJcmV0dXJu
IEJMS19TVFNfTk9TUEM7Cj4+ICAgCWNhc2UgTlZNRV9TQ19MQkFfUkFOR0U6Cj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMu
aAo+PiBpbmRleCBkNjg4Yjk2ZDFkNjMuLjNhMGQ4NDUyODMyNSAxMDA2NDQKPj4gLS0tIGEvaW5j
bHVkZS9saW51eC9ibGtfdHlwZXMuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5o
Cj4+IEBAIC04NCw2ICs4NCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBibGtfcGF0aF9lcnJvcihi
bGtfc3RhdHVzX3QgZXJyb3IpCj4+ICAgCWNhc2UgQkxLX1NUU19ORVhVUzoKPj4gICAJY2FzZSBC
TEtfU1RTX01FRElVTToKPj4gICAJY2FzZSBCTEtfU1RTX1BST1RFQ1RJT046Cj4+ICsJY2FzZSBC
TEtfU1RTX1JFU09VUkNFOgo+PiAgIAkJcmV0dXJuIGZhbHNlOwo+PiAgIAl9Cj4gCj4gSSBhZ3Jl
ZSB3ZSBuZWVkIHRvIG1ha2UgdGhpcyBzdGF0dXMgYSBub24tcGF0aCBlcnJvciwgYnV0IHdlIGF0
IGxlYXN0Cj4gbmVlZCBhbiBBY2sgZnJvbSBKZW5zIG9yIGhhdmUgdGhpcyBwYXRjaCBnbyB0aHJv
dWdoIGxpbnV4LWJsb2NrIGlmIHdlJ3JlCj4gY2hhbmdpbmcgQkxLX1NUU19SRVNPVVJDRSB0byBt
ZWFuIGEgbm9uLXBhdGggZXJyb3IuCj4gCkFsdGVybmF0aXZlbHkgd2UgY2FuIGRlZmluZSBhIG5l
dyByZXR1cm4gdmFsdWUsIGlmIHdlIHNob3VsZG4ndCByZS11c2UgCmV4aXN0aW5nIG9uZXMuIEVp
dGhlciB3YXkgSSdtIGZpbmUgd2l0aC4KCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L252
bWUuaCBiL2luY2x1ZGUvbGludXgvbnZtZS5oCj4+IGluZGV4IGY2MWQ2OTA2ZTU5ZC4uNmIyMWYz
ODg4Y2FkIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L252bWUuaAo+PiArKysgYi9pbmNs
dWRlL2xpbnV4L252bWUuaAo+PiBAQCAtMTI5Miw2ICsxMjkyLDggQEAgZW51bSB7Cj4+ICAgCj4+
ICAgCU5WTUVfU0NfTlNfV1JJVEVfUFJPVEVDVEVECT0gMHgyMCwKPj4gICAKPj4gKwlOVk1FX1ND
X0NPTU1BTkRfSU5URVJSVVBURUQJPSAweDIxLAo+IAo+IFRoaXMgY29tbWFuZCBzdGF0dXMgd2Fz
IGFjdHVhbGx5IGFscmVhZHkgZGVmaW5lZCBpbiBjb21taXQKPiA0OGM5ZTg1YjIzNDY0LCB0aG91
Z2ggd2l0aCBhIHNsaWdodGx5IGRpZmZlcmVudCBuYW1lLgo+IApBaC4gV2lsbCBiZSBtb2RpZnlp
bmcgdGhlIHBhdGNoIHRoZW4uCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIExJTlVY
IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpHRjogRmVsaXggSW1lbmTDtnJm
ZmVyLCBNYXJ5IEhpZ2dpbnMsIFNyaSBSYXNpYWgKSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
