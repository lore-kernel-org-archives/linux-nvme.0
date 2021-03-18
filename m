Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604B7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:47:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C2564E83
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C2564E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wQQMw0qBRhnk7s7pCxLyR4UhoMAh02trjbVaclqQOUI=; b=NOiU+ek5wxC+V0XVF/zqplMwq
	LbFfWw2KIwCe/xkbqDW5HVOpUB1HruLeVjWtPKAhrvIEoxKFh5Kv+zuKD5wj2sGxWWLic6e0OefrZ
	D4JeBB6FC+Ugx9VjHOLHC7RPVicSY3trwlr9HiGFWvt7x1z/gSTs5z6u1OHUyVW4jJcz6JUcuB28l
	yIu2AquwOIFwNUW442Oyixp95sgpyT3+2qgQYW1hYYHNO0I2kiKqW7LEhDuSNrgopHQ0ciskjA5jE
	wgTw4w4qpF20LhAgqmsu8fXcjyS0mG9Jnk0B9h0ub5sW53laRmk3U9CqOBBOlKqf6SNXu3X9iVynH
	ZYxHW/QvQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMybm-005xJQ-Qa; Thu, 18 Mar 2021 19:47:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMybi-005xIn-5y
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 19:47:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C5A164E83;
 Thu, 18 Mar 2021 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616096815;
 bh=3tllyE5Rsh07RjagsXqRC76xF/aSKUJD61nCzHwz67k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VnbcwrZfISTgRcjl4IApe7t8vPDHaKnfREoZ6lLxJ9JZRzn/5v5DsVEK7ME040TUw
 tRwV/bGs4TtHkB36rHW4HhEM6ih3pd1E4+HQK2V0yCK4SDKhOaPDLNtIgB/8/PUVb4
 KQVdqibMlAdC/v0bY3/STU4sKHmF4g6ML0lGfEQUIlhZdExWmRfQozTGhm2Nc6NUuZ
 2NnFKXkG0V1ef4ZO43hvfrvx9KviDh7Rz3BRqj/sSXcP59+27fNKxcC9HWXiW68G4U
 o5Cfnp1jPnPu9kN03uG6KMkX8w25xuW2fZTvK/u19oD4nRnKmXH7RC98GU5JNEPTL0
 FexVftmNHdqQA==
Date: Thu, 18 Mar 2021 12:46:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_194658_607389_4DA4EF63 
X-CRM114-Status: GOOD (  26.65  )
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

T24gVGh1LCBNYXIgMTgsIDIwMjEgYXQgMDY6Mzk6MzdQTSArMDAwMCwgQWxhbiBBZGFtc29uIHdy
b3RlOgo+IAo+IAo+ID4gT24gTWFyIDE4LCAyMDIxLCBhdCA5OjUyIEFNLCBLZWl0aCBCdXNjaCA8
a2J1c2NoQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gCj4gPiBPbiBUaHUsIE1hciAxOCwgMjAyMSBh
dCAwNDoyODoyNFBNICswMDAwLCBBbGFuIEFkYW1zb24gd3JvdGU6Cj4gPj4gCj4gPj4gCj4gPj4+
IE9uIE1hciAxNywgMjAyMSwgYXQgOTozOCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+IHdyb3RlOgo+ID4+PiAKPiA+Pj4gT24gV2VkLCBNYXIgMTcsIDIwMjEgYXQgMDQ6NDY6MTRQ
TSAtMDQwMCwgQWxhbiBBZGFtc29uIHdyb3RlOgo+ID4+Pj4gVGhpcyBwYXRjaCBleHBvcnRzIHRo
ZSBOVk1lIENvbnRyb2xsZXIgQ1NUUyByZWdpc3RlciB2aWEgc3lzZnMuICBUaGlzCj4gPj4+PiBm
ZWF0dXJlIGNhbiBiZSB1c2VkIGJ5IHVzZXJsYW5kIGV4ZWN1dGFibGVzIHRoYXQgYWNjZXNzZWQg
Q1NUUyBhbmQKPiA+Pj4+IHBvc3NpYmx5IG90aGVyIHJlZ2lzdGVycyBieSBtYXBwaW5nIHRoZW0g
aW50byB1c2VyIHNwYWNlLiAgU2luY2UgdGhpcyBhYmlsaXR5Cj4gPj4+PiBtYXkgbm90IGFsd2F5
cyBhdmFpbGFibGUsIGV4cG9ydGluZyBjZXJ0YWluIHJlZ2lzdGVycyB2aWEgc3lzZnMgcHJvdmlk
ZXMKPiA+Pj4+IGEgc2FmZS9yZWFkLW9ubHkgd2F5IHRvIGFjY2VzcyByZWdpc3RlcnMgZnJvbSBv
dXRzaWRlIHRoZSBrZXJuZWwuCj4gPj4+IAo+ID4+PiBTbyB3aGF0IGlzIHRoaXMgYXBwbGljYXRp
b24gZG9pbmdzIHdpdGggaXQ/ICBTaG91bGQgd2UganVzdCBoYXZlIGEKPiA+Pj4gcmVhZHkgYXR0
cmlidXRlIGluc3RlYWQgb2YgZXhwb3J0aW5nIGEgcmF3IHJlZ2lzdGVyIGVuY29kaW5nPwo+ID4+
IAo+ID4+IAo+ID4+IFdhcyB1c2luZyBudm1lLWNsaSBzaG93LXJlZ3MgdG8gbWFuYWdlIG52bWUg
ZGV2aWNlcy4gVGhpcyBpcyBubyBsb25nZXIgYW4gb3B0aW9uLgo+ID4gCj4gPiBNb3N0IGRpc3Ry
aWJ1dGlvbnMgc2hpcCB3aXRoIGtlcm5lbCBDT05GSUdfSU9fU1RSSUNUX0RFVk1FTSB0aGVzZSBk
YXlzLAo+ID4gc28gdGhhdCB1c2VyIGNvbW1hbmQgd2lsbCB2ZXJ5IHJhcmVseSB3b3JrIG9uIFBD
SWUgdGFyZ2V0cyBhbnltb3JlLgo+ID4gCj4gPiBQZXJoYXBzIHdlIGNvdWxkIGludHJvZHVjZSBh
IGRyaXZlciBvcHRpb24gYWxsb3dpbmcgcmVhZC1vbmx5IG1tYXAgb24KPiA+IHRoaXMgbWVtb3J5
PyAgV2hpbGUgeW91J3JlIGN1cnJlbnRseSBhc2tpbmcgZm9yIGp1c3Qgb25lIHJlZ2lzdGVyCj4g
PiBhdHRyaWJ1dGUsIGl0IHdvdWxkIGJlIG5pY2UgaWYgd2UgY2FuIG1ha2UgYWxsIGZ1dHVyZSBy
ZXF1ZXN0cyBhdmFpbGFibGUKPiA+IHdpdGhvdXQgcGlsaW5nIG9uIG1vcmUgc3lzZnMgcHJvcGVy
dGllcy4KPiAKPiBUaGlzIGNvdWxkIGJlIGEgZ29vZCBzb2x1dGlvbiAoYWxvbmcgd2l0aCBhIG52
bWUtY2xpIGNoYW5nZSkuICBJ4oCZbGwgY29kZSB0aGlzIHVwLgoKSSBkb24ndCB0aGluayBpdCBz
aG91bGQgcmVxdWlyZSB1c2VyIHNwYWNlIG1vZGlmaWNhdGlvbnMuIEp1c3QgbW1hcCB0aGUKY3Vy
cmVudCByZXNvdXJjZSBhcy1pcyBidXQgbGV0IHRoZSBkcml2ZXIgYWxsb3cgcmVhZC1vbmx5IGlu
IHRoZQpwcmVjZW5zZSBvZiBDT05GSUdfSU9fU1RSSUNUX0RFVk1FTS4gVGhlIGJlbG93IGlzIGEg
cm91Z2ggaWRlYSBvZiB3aGF0IEkKaGFkIGluIG1pbmQgKGNvbXBpbGUgdGVzdGVkIG9ubHksIGFu
ZCBhIHByb3BlciBzb2x1dGlvbiBzaG91bGQgcmVzdHJpY3QKYWNjZXNzIHRvIGEgc3BlY2lmaWMg
YWRkcmVzcyByYW5nZSkKCi0tLQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwppbmRleCBkNDdiYjE4Yjk3NmEuLmM3MDk2NTEzNTI3
NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMKQEAgLTIzNjIsNiArMjM2Miw3IEBAIHN0YXRpYyBpbnQgbnZtZV9wY2lfZW5h
YmxlKHN0cnVjdCBudm1lX2RldiAqZGV2KQogCQlyZXR1cm4gcmVzdWx0OwogCiAJcGNpX3NldF9t
YXN0ZXIocGRldik7CisJcGRldi0+YWxsb3dfcm9fbW1hcCA9IHRydWU7CiAKIAlpZiAoZGV2LT5j
dHJsLnF1aXJrcyAmIE5WTUVfUVVJUktfRE1BX0FERFJFU1NfQklUU180OCkKIAkJZG1hX2FkZHJl
c3NfYml0cyA9IDQ4OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMgYi9kcml2
ZXJzL3BjaS9wY2ktc3lzZnMuYwppbmRleCBmOGFmZDU0Y2EzZTEuLmI5MmYyMTcyNDk3YyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMKKysrIGIvZHJpdmVycy9wY2kvcGNpLXN5
c2ZzLmMKQEAgLTEwMjgsNyArMTAyOCwxMCBAQCBzdGF0aWMgaW50IHBjaV9tbWFwX3Jlc291cmNl
KHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSAqYXR0ciwKIAlpZiAo
cmV0KQogCQlyZXR1cm4gcmV0OwogCi0JaWYgKHJlcy0+ZmxhZ3MgJiBJT1JFU09VUkNFX01FTSAm
JiBpb21lbV9pc19leGNsdXNpdmUocmVzLT5zdGFydCkpCisJaWYgKHJlcy0+ZmxhZ3MgJiBJT1JF
U09VUkNFX01FTSAmJiBpb21lbV9pc19leGNsdXNpdmUocmVzLT5zdGFydCkgJiYKKwkgICAgIShw
ZGV2LT5hbGxvd19yb19tbWFwICYmCisJCQkhKCh2bWEtPnZtX2ZsYWdzICYgVk1fU0hBUkVEKSB8
fAorCQkJICAodm1hLT52bV9mbGFncyAmIFZNX01BWVdSSVRFKSkpKQogCQlyZXR1cm4gLUVJTlZB
TDsKIAogCWlmICghcGNpX21tYXBfZml0cyhwZGV2LCBiYXIsIHZtYSwgUENJX01NQVBfU1lTRlMp
KQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgK
aW5kZXggODZjNzk5Yzk3Yjc3Li5jYTE1OThmYTQ2ZDUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvcGNpLmgKKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtMzc5LDYgKzM3OSw3IEBAIHN0
cnVjdCBwY2lfZGV2IHsKIAkJCQkJCSAgICAgIHVzZXIgc3lzZnMgKi8KIAl1bnNpZ25lZCBpbnQJ
Y2xlYXJfcmV0cmFpbl9saW5rOjE7CS8qIE5lZWQgdG8gY2xlYXIgUmV0cmFpbiBMaW5rCiAJCQkJ
CQkgICBiaXQgbWFudWFsbHkgKi8KKwl1bnNpZ25lZCBpbnQJYWxsb3dfcm9fbW1hcDsJLyogYWxs
b3cgcmVhZCBvbmx5IGV2ZW4gaWYgQ09ORklHX0lPX1NUUklDVF9ERVZNRU0gKi8KIAl1bnNpZ25l
ZCBpbnQJZDNob3RfZGVsYXk7CS8qIEQzaG90LT5EMCB0cmFuc2l0aW9uIHRpbWUgaW4gbXMgKi8K
IAl1bnNpZ25lZCBpbnQJZDNjb2xkX2RlbGF5OwkvKiBEM2NvbGQtPkQwIHRyYW5zaXRpb24gdGlt
ZSBpbiBtcyAqLwogCi0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
