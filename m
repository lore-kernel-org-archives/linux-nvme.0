Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C3C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:06:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90AA206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFj6D50H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FhAvyIgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90AA206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UOCwjCJggn7Vh0E9P0qvmnykgMRrEbB09dCsO0QotM0=; b=bFj6D50HxJpuLPwYbR9Q1gwiE
	TGx34CMA08Hf07esSO6loRXwmKIQt/4myakSHztlWbYmdweLFDW75FaImgCP3riimb4IGomlG32gq
	k82X3IJOHXya9dXH8frC7xKNzp662sJKZGkLyyo9CHJR5RSNjNLt4+MPefb+jTdpgUyD80ElnaUpH
	/HfqvvepV4GeEoIBpD52cSIGd7etpLwvvn+/aMG3JuUgp/URRIAG0shN407HEvuQ6MIq5mXSq5WmH
	ir7AesGktsoIrvnDllDT3ghVKFy54jTpiAB237fcvzVZj/U1SNJJ2/G4gl46iGYpir2IGwTsiy+xG
	84KnRUhEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jon7o-0004SM-J8; Fri, 26 Jun 2020 12:06:32 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolhZ-0007AB-M8
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:35:24 +0000
Received: by mail-wr1-x443.google.com with SMTP id a6so9002582wrm.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=eMRZSEPILJ/VgixGAVUR+OM7H5tl0QETRHZF7IXIBss=;
 b=FhAvyIgFjRuPlJkiK3zynyy98TyIiLkieNPIzKLj6sVRVCaIkK1GqSqNL4ONLMUyjW
 IYl5UNBe0qk4FT/pPZzopEy9FlUBS52cNShrn3piFyYmXfW3nqhHRm32D/RGvR7lweCj
 xBafkwtXaCVSfrEviUap6gjET/WgHp7aHJbNK+uGuMFQ5jAoo1bVpcZ7EK/0WOd8RU11
 WLuqb5af44g5sR8d/A64GcvxD4T9Vr6GCEV+Nnri8AGSkDs3HfLR4WLNRVH14h28zDKD
 C59IJ0/2H3xccbSrDTAYUydoXOe5jjl15FS39Hymo/UDDgcOXURsOwGpW3dfvMyu13P6
 g/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eMRZSEPILJ/VgixGAVUR+OM7H5tl0QETRHZF7IXIBss=;
 b=G+4Z84wdcAoLtzVT6QCAgT9brFnBUqrQ3sVIHGMsyYrW0GDOCGWqUL1sR0nQh16AAv
 VVQszUCfuHHYm4Kcr6plBjCfbDdRhaEMmDlXg8jwZOy7vTYXKijJ33yNeV/LnuOir3v4
 TAF/l9zoJtb+Km7OTjXbiDxWt0nuwe6BX6ywWjQC5ngFidPvjplZK2owf4mn4HEmpzI/
 DiecsyQrKbYpz6swyTmTbTJgFoF7gQ/zVjMi6dZJjmRzHjnh8z7yZUVv/irGEBpnyNU2
 do9OXk3rCEaCkA4jAf1Ntv4z6np/SSMdl5hlQRVKG5+4WxhmVMH2HLdJqd6MHrgEE1hW
 KKqw==
X-Gm-Message-State: AOAM530/VqgQc7/fKkkCaURCB9V2z/33CDdRUkLqQ++pgRx7a09f1ExS
 TEAUBGg9ui7iULJcFcPTeDVi8zqmawytLZPkJZo=
X-Google-Smtp-Source: ABdhPJy3fzGC9HvPjjRE+CSI1d1tpFMlrZVKYRIKUdR5Rb9H0Uv7AiDxCUL1l9DjRsN3Hw1Yn8lyaQ==
X-Received: by 2002:a17:906:6d15:: with SMTP id
 m21mr1344598ejr.209.1593156541214; 
 Fri, 26 Jun 2020 00:29:01 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id gu15sm2074049ejb.111.2020.06.26.00.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 00:29:00 -0700 (PDT)
Date: Fri, 26 Jun 2020 09:29:00 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626072900.rjigm3wiya4sdufv@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
 <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065546.v266c3zjv2gjoycs@mpHalley.localdomain>
 <CY4PR04MB3751A7165FC7F068C1ECBB5EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751A7165FC7F068C1ECBB5EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwNzowOSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI2
IDE1OjU1LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAyNi4wNi4yMDIwIDA2OjQ5LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMjYgMTU6MTMsIEphdmllciBHb256
w6FsZXogd3JvdGU6Cj4+Pj4gT24gMjYuMDYuMjAyMCAwMDowNCwgRGFtaWVuIExlIE1vYWwgd3Jv
dGU6Cj4+Pj4+IE9uIDIwMjAvMDYvMjYgNjo0OSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+Pj4+PiBP
biBUaHUsIEp1biAyNSwgMjAyMCBhdCAwMjoyMTo1MlBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6
IHdyb3RlOgo+Pj4+Pj4+ICBkcml2ZXJzL252bWUvaG9zdC96bnMuYyB8IDcgKysrKysrKwo+Pj4+
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMu
Ywo+Pj4+Pj4+IGluZGV4IDdkODM4MWZlNzY2NS4uZGU4MDY3ODhhMTg0IDEwMDY0NAo+Pj4+Pj4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3Qvem5zLmMKPj4+Pj4+PiBAQCAtMjM0LDYgKzIzNCwxMyBAQCBzdGF0aWMgaW50IG52bWVf
bnNfcmVwb3J0X3pvbmVzKHN0cnVjdCBudm1lX25zICpucywgc2VjdG9yX3Qgc2VjdG9yLAo+Pj4+
Pj4+ICAJCXNlY3RvciArPSBucy0+enN6ZSAqIG56Owo+Pj4+Pj4+ICAJfQo+Pj4+Pj4+Cj4+Pj4+
Pj4gKwlpZiAobnJfem9uZXMgPCAwICYmIHpvbmVfaWR4ICE9IG5zLT5ucl96b25lcykgewo+Pj4+
Pj4+ICsJCWRldl9lcnIobnMtPmN0cmwtPmRldmljZSwgImluY29uc2lzdGVudCB6b25lIGNvdW50
ICV1LyV1XG4iLAo+Pj4+Pj4+ICsJCQkJem9uZV9pZHgsIG5zLT5ucl96b25lcyk7Cj4+Pj4+Pj4g
KwkJcmV0ID0gLUVJTlZBTDsKPj4+Pj4+PiArCQlnb3RvIG91dF9mcmVlOwo+Pj4+Pj4+ICsJfQo+
Pj4+Pj4+ICsKPj4+Pj4+PiAgCXJldCA9IHpvbmVfaWR4Owo+Pj4+Pj4KPj4+Pj4+IG5yX3pvbmVz
IGlzIHVuc2lnbmVkLCBzbyBpdCdzIG5ldmVyIDwgMC4KPj4+Pj4+Cj4+Pj4+PiBUaGUgQVBJIHdl
J3JlIHByb3ZpZGluZyBkb2Vzbid0IHJlcXVpcmUgem9uZV9pZHggZXF1YWwgdGhlIG5hbWVzcGFj
ZSdzCj4+Pj4+PiBucl96b25lcyBhdCB0aGUgZW5kLCB0aG91Z2guIEEgc3Vic2V0IG9mIHRoZSB0
b3RhbCBudW1iZXIgb2Ygem9uZXMgY2FuCj4+Pj4+PiBiZSByZXF1ZXN0ZWQgaGVyZS4KPj4+Pj4+
Cj4+Pj4KPj4+PiBJIGRpZCBzZWUgbnJfem9uZXMgY29taW5nIHdpdGggLTE7IGd1ZXNzIGl0IGlz
IG15IGNvbXBpbGVyLgo+Pj4KPj4+IFNlZSBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oLiAtMSBpczoK
Pj4+Cj4+PiAjZGVmaW5lIEJMS19BTExfWk9ORVMgICgodW5zaWduZWQgaW50KS0xKQo+Pj4KPj4+
IFdoaWNoIGlzIGRvY3VtZW50ZWQgaW4gYmxvY2svYmxrLXpvbmVkLmM6Cj4+Pgo+Pj4gLyoqCj4+
PiAqIGJsa2Rldl9yZXBvcnRfem9uZXMgLSBHZXQgem9uZXMgaW5mb3JtYXRpb24KPj4+ICogQGJk
ZXY6ICAgICAgIFRhcmdldCBibG9jayBkZXZpY2UKPj4+ICogQHNlY3RvcjogICAgIFNlY3RvciBm
cm9tIHdoaWNoIHRvIHJlcG9ydCB6b25lcwo+Pj4gKiBAbnJfem9uZXM6ICAgTWF4aW11bSBudW1i
ZXIgb2Ygem9uZXMgdG8gcmVwb3J0Cj4+PiAqIEBjYjogICAgICAgICBDYWxsYmFjayBmdW5jdGlv
biBjYWxsZWQgZm9yIGVhY2ggcmVwb3J0ZWQgem9uZQo+Pj4gKiBAZGF0YTogICAgICAgUHJpdmF0
ZSBkYXRhIGZvciB0aGUgY2FsbGJhY2sKPj4+ICoKPj4+ICogRGVzY3JpcHRpb246Cj4+PiAqICAg
IEdldCB6b25lIGluZm9ybWF0aW9uIHN0YXJ0aW5nIGZyb20gdGhlIHpvbmUgY29udGFpbmluZyBA
c2VjdG9yIGZvciBhdCBtb3N0Cj4+PiAqICAgIEBucl96b25lcywgYW5kIGNhbGwgQGNiIGZvciBl
YWNoIHpvbmUgcmVwb3J0ZWQgYnkgdGhlIGRldmljZS4KPj4+ICogICAgVG8gcmVwb3J0IGFsbCB6
b25lcyBpbiBhIGRldmljZSBzdGFydGluZyBmcm9tIEBzZWN0b3IsIHRoZSBCTEtfQUxMX1pPTkVT
Cj4+PiAqICAgIGNvbnN0YW50IGNhbiBiZSBwYXNzZWQgdG8gQG5yX3pvbmVzLgo+Pj4gKiAgICBS
ZXR1cm5zIHRoZSBudW1iZXIgb2Ygem9uZXMgcmVwb3J0ZWQgYnkgdGhlIGRldmljZSwgb3IgYSBu
ZWdhdGl2ZSBlcnJubwo+Pj4gKiAgICB2YWx1ZSBpbiBjYXNlIG9mIGZhaWx1cmUuCj4+PiAqCj4+
PiAqICAgIE5vdGU6IFRoZSBjYWxsZXIgbXVzdCB1c2UgbWVtYWxsb2Nfbm9YWF9zYXZlL3Jlc3Rv
cmUoKSBjYWxscyB0byBjb250cm9sCj4+PiAqICAgIG1lbW9yeSBhbGxvY2F0aW9ucyBkb25lIHdp
dGhpbiB0aGlzIGZ1bmN0aW9uLgo+Pj4gKi8KPj4+IGludCBibGtkZXZfcmVwb3J0X3pvbmVzKHN0
cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIHNlY3Rvcl90IHNlY3RvciwKPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IG5yX3pvbmVzLCByZXBvcnRfem9uZXNfY2IgY2IsIHZv
aWQgKmRhdGEpCj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+IFllcywgYWJzb2x1dGVseS4gem9uZV9pZHgg
aXMgbm90IGFuIGFic29sdXRlIHpvbmUgbnVtYmVyLiBJdCBpcyB0aGUgaW5kZXggb2YgdGhlCj4+
Pj4+IHJlcG9ydGVkIHpvbmUgZGVzY3JpcHRvciBpbiB0aGUgY3VycmVudCByZXBvcnQgcmFuZ2Ug
cmVxdWVzdGVkIGJ5IHRoZSB1c2VyLAo+Pj4+PiB3aGljaCBpcyBub3QgbmVjZXNzYXJpbHkgZm9y
IHRoZSBlbnRpcmUgZHJpdmUgKGkuZS4sIHByb3ZpZGVkIG5yIHpvbmVzIGlzIGxlc3MKPj4+Pj4g
dGhhbiB0aGUgdG90YWwgbnVtYmVyIG9mIHpvbmVzIG9mIHRoZSBkaXNrIGFuZC9vciBzdGFydCBz
ZWN0b3IgaXMgPiAwKS4gU28KPj4+Pj4gem9uZV9pZHggaW5kaWNhdGVzIHRoZSBhY3R1YWwgbnVt
YmVyIG9mIHpvbmVzIHJlcG9ydGVkLCBpdCBpcyBub3QgdGhlIHRvdGFsCj4+Pj4KPj4+PiBJIHNl
ZS4gQXMgSSBjYW4gc2VlLCB3aGVuIG5yX3pvbmVzIGNvbWVzIHVuZGVmaW5lZCBJIGJlbGlldmVk
IHdlIGNvdWxkCj4+Pj4gYXNzdW1lIHRoYXQgem9uZV9pZHggaXMgYWJzb2x1dGUsIGJ1dCBJIGNh
biBiZSB3cm9uZy4KPj4+Cj4+PiBOby4gem9uZV9pZHggaXMgKmFsd2F5cyogdGhlIGluZGV4IG9m
IHRoZSB6b25lIGluIHRoZSBjdXJyZW50IHJlcG9ydC4gV2hhdGV2ZXIKPj4+IHRoYXQgcmVwb3J0
IGlzLCByZWdhcmRsZXNzIG9mIHRoZSByZXBvcnQgc3RhcnRpbmcgcG9pbnQgYW5kIG51bWJlciBv
ZiB6b25lcwo+Pj4gcmVxdWVzdGVkLiBFLmcuIEZvciBhIHNpbmdsZSB6b25lIHJlcG9ydCAobnJf
em9uZXMgPSAxKSwgeW91IHdpbGwgYWx3YXlzIHNlZQo+Pj4gem9uZV9pZHggPSAwLiBGb3IgYSBm
dWxsIHJlcG9ydCwgem9uZV9pZHggd2lsbCBjb3JyZXNwb25kIHRvIHRoZSB6b25lIG51bWJlci4K
Pj4+IFRoaXMgaXMgdXNlZCBmb3IgZXhhbXBsZSBpbiBibGtfcmV2YWxpZGF0ZV9kaXNrX3pvbmVz
KCkgdG8gaW5pdGlhbGl6ZSB0aGUgem9uZQo+Pj4gYml0bWFwcy4KPj4+Cj4+Pj4gRG9lcyBpdCBt
YWtlIHNlbnNlIHRvIHN1cHBvcnQgdGhpcyBjaGVjayB3aXRoIGFuIGFkZGl0aW9uYWwgY291bnRl
ciBhbmQKPj4+PiBhIGV4cGxpY2l0IG5yX3pvbmVzIGluaXRpYWxpemF0aW9uIHdoZW4gdW5kZWZp
bmVkIG9yIHlvdQo+Pj4+IHByZWZlciB0byBqdXN0IHJlbW92ZSBpdCBhcyBNYXRpYXMgc3VnZ2Vz
dGVkPwo+Pj4KPj4+IFRoZSBjaGVjayBpcyBub3QgbmVlZGVkIGF0IGFsbC4KPj4+Cj4+PiBJZiB0
aGUgZGV2aWNlIGlzIGJ1Z2d5IGFuZCByZXBvcnRzIG1vcmUgem9uZXMgdGhhbiB0aGUgZGV2aWNl
IGNhcGFjaXR5IG9yIGFueQo+Pj4gb3RoZXIgYnVncywgdGhlIGRyaXZlciBjYW4gY2F0Y2ggdGhh
dCB3aGVuIGl0IHByb2Nlc3NlcyB0aGUgcmVwb3J0Lgo+Pj4gYmxrX3JldmFsaWRhdGVfZGlza196
b25lcygpIGFsc28gaGFzIG1hbnkgY2hlY2tzLgo+Pgo+PiBJIGhhdmUgbWFuYWdlZCB0byBjcmVh
dGUgYSBRRU1VIFpOUyBkZXZpY2UgdGhhdCBnYXZlIG1lIGEgaGVhZGFjaGUgd2l0aAo+PiBhIGxp
dHRsZSBiaXQgb2YgZXh0cmEgY2FwYWNpdHkgdGhhdCB0cmlnZ2VyZWQgYW4gYWRkaXRpb25hbCB6
b25lIHJlcG9ydC4KPj4gVGhpcyB3YXMgdGhlIG1vdGl2YXRpb24gZm9yIHRoZSBwYXRjaC4KPgo+
VGhlIGRldmljZSBlbXVsYXRpb24gc291bmQgYnVnZ3kuLi4gSWYgdGhlIGNhcGFjaXR5IGlzIHdy
b25nLCB0aGVuIHRoZSByZXBvcnQKPndpbGwgYmUgdG9vIHNpbmNlIHpvbmVzIGFyZSBhbGwgc3Vw
cG9zZWQgdG8gYmUgc2VxdWVudGlhbCAobm8gaG9sZXMgYmV0d2Vlbgo+em9uZXMpIGFuZCB1cCB0
byB0aGUgZGlzayBjYXBhY2l0eSBvbmx5IChsYXN0IHpvbmUgc3RhcnQgKyBsZW4gPSBjYXBhY2l0
eSArIDEpCj4KPklmIG9uZSBvciB0aGUgb3RoZXIgaXMgd3JvbmcsIHRoaXMgc2hvdWxkIGJlIGVh
c3kgdG8gZGV0ZWN0LiBOb3JtYWxseSwKPmJsa19yZXZhbGlkYXRlX2Rpc2tfem9uZXMoKSBzaG91
bGQgYmUgYWJsZSB0byBjYXRjaCB0aGF0LgoKV2UgaGF2ZSB0aGUgY2FwYWJpbGl0eSB0byBzZWxl
Y3QgdGhlIHJlcG9ydGVkIGRldmljZSBjYXBhY2l0eSBtYW51YWxseQpmb3IgYSBudW1iZXIgb2Yg
cmVhc29ucy4gT25lIG9mIHRoZSBkaWZmZXJlbnQgdGVzdCBjb25maWd1cmF0aW9ucyBpbiBvdXIK
Q0kgZGlkIGdvIHRocm91Z2guCgpCdXQgaXQgaXMgT0ssIEkgd2lsbCByZW1vdmUgdGhlIGNoZWNr
IG9uIFYyLgoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
