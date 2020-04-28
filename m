Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E9C83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 07:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7421206B9
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 07:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pd+1kiE2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="hO81LZGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7421206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nkIJbNN3Nt3ebCqkii56uOliaAt7wjxIIlxNJEkT9Jw=; b=Pd+1kiE2+IErUlPOL0wGmq1Jh
	5e0EFVVeY9owwFP/fac5JLnj7qMaDAjIMwsze1Q3PnuEm8z6dhloqxo1OvL9gNGiI/+hOLYmrMR1b
	KXbjMNQEQRUF/Sm7GuJliN4i+txv+YGHEnf4pQjE/yy1rK8EFqRLQoaGch7K3GvJ8Vuwonpj0e7bz
	cZmL+96wfuAv3gnkEUzP+kcKlnvUduTvqqmlilc2DWt+poZkJRFMiHYg7NcXkVCWVlAS/WqffwPOV
	xW+yev8moDel59fy/tTTca/PCSyzDt98Fim/+PNcBEPZZ2wSEpA68HoGBfmN5fwOMxjkiCQJRdCcF
	9J2XRZmaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTKKY-0003Kj-Dq; Tue, 28 Apr 2020 07:06:58 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTKKU-0003K9-L4
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 07:06:56 +0000
Received: by mail-wm1-x343.google.com with SMTP id h4so1444894wmb.4
 for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2020 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=5xMxzq1+6fPKftxXFu1ru4KGONd/NB7Kh51Ynpspd1U=;
 b=hO81LZGWWo8vQjLiiioyCkIRbDV6DOkETpCDAwqQdX+A5qxIQgwr1HYewNk54bxA7U
 VUidLvM9h71FNcWZnNJYZ3yOumKakvofrrqMoUqQuNJ7S80BnFrt1MtCsxiIHLBGb4cO
 /TddRb91i9lTxuviX7DN+kD+9PvS58iLrlpFqIYwBT7Q93N0FCiNKQFEmUhyq2+dHicN
 ZNjbd84dQDNMQQUw9JGt9oqx+VP7v1BvscRU593V9qpLgb9ryM4WUBikbEQEXkJ4GqT4
 qC6/5rkcMwZBBZ0ve117vQ1OEL6fiBT3fkqtDQQFh32D6t2ccFohocb83Vh/DdeY6Wzv
 eqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5xMxzq1+6fPKftxXFu1ru4KGONd/NB7Kh51Ynpspd1U=;
 b=D6qIhN9F9NM/CKyXQm0fMz+G57N/cfkwR9kcHRkawfmw9JuolblkrcdKmBlY3LNzmC
 HRfPsYAg2ULbKIq6s24SZY65Ie/qSMcqHDC0Hq9cO4ScnmVIiU7PKRu46Gj/dA8jmjvz
 FkwScKmrMDVQidgW2gmkwBHNhKVKq+g8whl4dviju6FIWhtTvKR/ykLjecU/pK6gOXvc
 P0vBBeAgTBK3y6gE43S6J4lgjgxeRVsNNn9olpjzohnr0J38clCFL+hKoX9EsaAF9xAM
 mZqLbRUhFU0JB6btVXKqbSggH4n+MBpTgeoH5++FWSuWpLUWAOGoeKaogKRgkGBKOt+O
 tMWQ==
X-Gm-Message-State: AGi0PuZIvGw3WX+aHzjSr3WZ3pMfLGFF7q8ymcqct6nubkPlgTawLKII
 uSPw9wpKn501ZI2Hc5Xq/yU7Qg==
X-Google-Smtp-Source: APiQypLJlkHPjon8EswejZeDOa29Qh08hz2eo34BgU9hmyxGa6xTEGyLyDc2U6KDsMGt3wkaBlFeFw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr2697226wmg.147.1588057612762; 
 Tue, 28 Apr 2020 00:06:52 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
 by smtp.gmail.com with ESMTPSA id l9sm23897081wrq.83.2020.04.28.00.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 00:06:52 -0700 (PDT)
Date: Tue, 28 Apr 2020 09:06:51 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200428070651.qbsyivvaakflipr4@mpHalley.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
 <20200427182245.GA547726@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427182245.GA547726@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_000654_751080_244357CF 
X-CRM114-Status: GOOD (  23.13  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Igor Konopko <igor.j.konopko@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjcuMDQuMjAyMCAxODoyMiwgTmlrbGFzIENhc3NlbCB3cm90ZToKPk9uIE1vbiwgQXByIDI3
LCAyMDIwIGF0IDA4OjAzOjExUE0gKzAyMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+IE9u
IDI3LjA0LjIwMjAgMTQ6MzQsIE5pa2xhcyBDYXNzZWwgd3JvdGU6Cj4+ID4gV2hlbiBqdW1waW5n
IHRvIHRoZSBvdXRfcHV0X2Rpc2sgbGFiZWwsIHdlIHdpbGwgY2FsbCBwdXRfZGlzaygpLCB3aGlj
aCB3aWxsCj4+ID4gdHJpZ2dlciBhIGNhbGwgdG8gZGlza19yZWxlYXNlKCksIHdoaWNoIGNhbGxz
IGJsa19wdXRfcXVldWUoKS4KPj4gPgo+PiA+IExhdGVyIGluIHRoZSBjbGVhbnVwIGNvZGUsIHdl
IGRvIGJsa19jbGVhbnVwX3F1ZXVlKCksIHdoaWNoIHdpbGwgYWxzbyBjYWxsCj4+ID4gYmxrX3B1
dF9xdWV1ZSgpLgo+PiA+Cj4+ID4gUHV0dGluZyB0aGUgcXVldWUgdHdpY2UgaXMgaW5jb3JyZWN0
LCBhbmQgd2lsbCBnZW5lcmF0ZSBhIEtBU0FOIHNwbGF0Lgo+PiA+Cj4+ID4gU2V0IHRoZSBkaXNr
LT5xdWV1ZSBwb2ludGVyIHRvIE5VTEwsIGJlZm9yZSBjYWxsaW5nIHB1dF9kaXNrKCksIHNvIHRo
YXQgdGhlCj4+ID4gZmlyc3QgY2FsbCB0byBibGtfcHV0X3F1ZXVlKCkgd2lsbCBub3QgZnJlZSB0
aGUgcXVldWUuCj4+ID4KPj4gPiBUaGUgc2Vjb25kIGNhbGwgdG8gYmxrX3B1dF9xdWV1ZSgpIHVz
ZXMgYW5vdGhlciBwb2ludGVyIHRvIHRoZSBzYW1lIHF1ZXVlLAo+PiA+IHNvIHRoaXMgY2FsbCB3
aWxsIHN0aWxsIGZyZWUgdGhlIHF1ZXVlLgo+PiA+Cj4+ID4gRml4ZXM6IDg1MTM2YzAxMDI4NSAo
ImxpZ2h0bnZtOiBzaW1wbGlmeSBnZW9tZXRyeSBlbnVtZXJhdGlvbiIpCj4+ID4gU2lnbmVkLW9m
Zi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPgo+PiA+IC0tLQo+PiA+
IGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDIgKysKPj4gPiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCj4+ID4KPj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+ID4gaW5kZXggOTFjMWJkNjU5OTQ3Li5m
MmFkZWE5NmIwNGMgMTAwNjQ0Cj4+ID4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+
ID4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+ID4gQEAgLTM2NDIsNiArMzY0Miw4
IEBAIHN0YXRpYyB2b2lkIG52bWVfYWxsb2NfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwgdW5z
aWduZWQgbnNpZCkKPj4gPgo+PiA+ICAgICAgIHJldHVybjsKPj4gPiAgb3V0X3B1dF9kaXNrOgo+
PiA+ICsgICAgICAvKiBwcmV2ZW50IGRvdWJsZSBxdWV1ZSBjbGVhbnVwICovCj4+ID4gKyAgICAg
IG5zLT5kaXNrLT5xdWV1ZSA9IE5VTEw7Cj4+ID4gICAgICAgcHV0X2Rpc2sobnMtPmRpc2spOwo+
PiA+ICBvdXRfdW5saW5rX25zOgo+PiA+ICAgICAgIG11dGV4X2xvY2soJmN0cmwtPnN1YnN5cy0+
bG9jayk7Cj4+ID4gLS0KPj4gPiAyLjI1LjMKPj4gPgo+PiBXaGF0IGFib3V0IGRlbGF5aW5nIHRo
ZSBhc3NpZ25tZW50IG9mIG5zLT5kaXNrPwo+Pgo+PiBkaWZmIC0tZ2l0IGkvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jIHcvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IGluZGV4IGE0ZDhjOTBl
ZTdjYy4uNmRhNGE5Y2VkOTQ1IDEwMDY0NAo+PiAtLS0gaS9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPj4gKysrIHcvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IEBAIC0zNTQxLDcgKzM1NDEs
NiBAQCBzdGF0aWMgaW50IG52bWVfYWxsb2NfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwgdW5z
aWduZWQgbnNpZCkKPj4gICAgICAgICBkaXNrLT5xdWV1ZSA9IG5zLT5xdWV1ZTsKPj4gICAgICAg
ICBkaXNrLT5mbGFncyA9IGZsYWdzOwo+PiAgICAgICAgIG1lbWNweShkaXNrLT5kaXNrX25hbWUs
IGRpc2tfbmFtZSwgRElTS19OQU1FX0xFTik7Cj4+IC0gICAgICAgbnMtPmRpc2sgPSBkaXNrOwo+
Pgo+PiAgICAgICAgIF9fbnZtZV9yZXZhbGlkYXRlX2Rpc2soZGlzaywgaWQpOwo+Pgo+PiBAQCAt
MzU1Myw2ICszNTUyLDggQEAgc3RhdGljIGludCBudm1lX2FsbG9jX25zKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwsIHVuc2lnbmVkIG5zaWQpCj4+ICAgICAgICAgICAgICAgICB9Cj4+ICAgICAgICAg
fQo+Pgo+PiArICAgICAgIG5zLT5kaXNrID0gZGlzazsKPj4gKwo+Cj5IZWxsbyBKYXZpZXIhCj4K
Pgo+VGhlIG9ubHkgY2FzZSB3aGVyZSB3ZSBqdW1wIHRvIHRoZSBvdXRfcHV0X2Rpc2sgbGFiZWws
IGlzIGlmIHRoZQo+bnZtZV9udm1fcmVnaXN0ZXIoKSBjYWxsIGZhaWxlZC4KPgo+SW4gdGhhdCBj
YXNlLCB3ZSB3YW50IHRvIHVuZG8gdGhlIGFsbG9jX2Rpc2tfbm9kZSgpIG9wZXJhdGlvbiwgaS5l
LiwKPmRlY3JlYXNlIHRoZSByZWZjb3VudC4KPgo+SWYgd2UgZG9uJ3Qgc2V0ICJucy0+ZGlzayA9
IGRpc2s7IiBiZWZvcmUgdGhlIGNhbGwgdG8gbnZtZV9udm1fcmVnaXN0ZXIoKSwKPnRoZW4sIGlm
IHJlZ2lzdGVyIGZhaWxzLCBhbmQgd2UganVtcCB0byB0aGUgcHV0X2Rpc2sobnMtPmRpc2spIGxh
YmVsLAo+bnMtPmRpc2sgd2lsbCBiZSBOVUxMLCBzbyB0aGUgcmVjb3VudCB3aWxsIG5vdCBiZSBk
ZWNyZWFzZWQsIHNvIEkgYXNzdW1lCj50aGF0IHRoaXMgbWVtb3J5IHdvdWxkIHRoZW4gYmUgYSBt
ZW1vcnkgbGVhay4KPgo+Cj5JIHRoaW5rIHRoYXQgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgYmxv
Y2sgZnVuY3Rpb25zIGFyZSBhIGJpdCBtZXNzeS4KPk1vc3QgZHJpdmVycyBzZWVtIHRvIGRvIGJs
a19jbGVhbnVwX3F1ZXVlKCkgZmlyc3QgYW5kIHRoZW4gZG8gcHV0X2Rpc2soKSwKPmJ1dCBzb21l
IGRyaXZlcnMgZG8gaXQgaW4gdGhlIG9wcG9zaXRlIHdheSwgc28gSSB0aGluayB0aGF0IHdlIG1p
Z2h0IGhhdmUKPnNvbWUgbW9yZSB1c2UtYWZ0ZXItZnJlZSBidWdzIGluIHNvbWUgb2YgdGhlc2Ug
ZHJpdmVycyB0aGF0IGRvIGl0IGluIHRoZQo+b3Bwb3NpdGUgd2F5Lgo+CgpIaSBOaWtsYXMsCgpZ
ZXMsIHRoZSBvdXRfcHV0X2Rpc2sgbGFiZWwgd2FzIGludHJvZHVjZWQgYXQgdGhlIHNhbWUgdGlt
ZSBhcyB0aGUKTGlnaHROVk0gZW50cnkgcG9pbnQuIFdlIGNhbiBkbyBhIGJldHRlciBqb2IgYXQg
c2VwYXJhdGluZyB0aGUgY2xlYW51cApmdW5jdGlvbnMsIGJ1dCBhcyBmYXIgYXMgSSBjYW4gc2Vl
IG5zLT5kaXNrIGlzIG5vdCB1c2VkIGluIHRoZSBMaWdodE5WTQppbml0aWFsaXphdGlvbiwgc28g
ZGVsYXlpbmcgdGhlIGluaXRpYWxpemF0aW9uIHNob3VsZCBiZSBvay4gUGFydCBvZgp0aGlzIHNo
b3VsZCBiZSBhbHNvIGNoYW5naW5nIHRoZSBvdXRfcHV0X2Rpc2sgdG8gcHV0X2Rpc2soZGlzayku
CgpOb3RlIHRoYXQgaW5pdGlhbGl6aW5nIG90aGVyIG5hbWVzcGFjZSB0eXBlcyBoZXJlIGRvIG5v
dCByZXF1aXJlCm5zLT5kaXNrIGVpdGhlciwgc28gZGVsYXlpbmcgaW5pdGlhbGl6YXRpb24gc2hv
dWxkIGJlIG9rLiBXZSBoYXZlIGJlZW4KcnVubmluZyB3aXRoIHRoaXMgcGF0Y2ggbG9jYWxseSBm
b3Igc29tZSB0aW1lLgoKVGhpcyBzYWlkLCB0aGlzIGlzIGFuIGFsdGVybmF0aXZlIGFzIHlvdXIg
Zml4IHdvcmtzLgoKSmF2aWVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
