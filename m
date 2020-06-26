Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814C6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4E5207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="COGhNyda";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FFEK8BOo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="DtaXE94V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4E5207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G9QuidW6+zIkk4bwX3SNuN8BrqI7rErXByT3VcJgAW4=; b=COGhNydatw5igR32nusfjSKZz
	xbm5cHx1xWqNYIpszhy3bT9HxbMqGF74xalHZHfmvjfeY/pyHL2a6HP8XYbiU9vi5Fy9zty48Xj50
	0saIJFXnaW9Z9dRjiD9b7P6YhL5BU/Fec79pXKyPBTuLNfIRnRCTdF15a6WIXIATS8RwIYHl4osf3
	JgRcBMj/hZTOQ4/dbp/kDJvgFnbdJ3LRgHH0vGlyhlGWbifq2aPpj4E/dxmCpkJIVMpN1GBjUKhlt
	ywrt/bE2Thl3ITxKtO2q2q44MbpGfAO7YZnBJqJ8iB8DK0ZRDnsHJjt0ueV06egdv/2fxlP5FAh5D
	AFfaKO5rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jond8-0002cT-Kq; Fri, 26 Jun 2020 12:38:54 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolIN-0001jR-Im
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=d31PpSzdyqjKwey15N5IKMpFdG+4vlPQzj0ZE0Mhabk=; b=FFEK8BOorLFQKZH1CHjHlnJUNB
 XXP5QKCY+NFjo0LVHBn0mg94uiHGt8q4eGtPB6VE//ohOhMaeO81jx2/ZlCofytOuEWT59Rk3Aj7Q
 pSiF33V8e6yWaJhGBEs702+MntvT1QnHmaBwZxm64Y29gG9OLnotWJFhRuwMIfi2ZktPz0kIAWxGY
 a9WT/WAE6FUap25NKIwBhHyyK4idi+v2nshysyyPHoV5D+QyUcam894KGgbTwCF8KjZJZhmtPWzpy
 I6ZQWnCSahdit0FN25vHJY69FHLYeWhfZUytDS8spKmPlBTb9xrxg6dVGlZ4EcTF5nyFSi7RepQn2
 oGAjtsSA==;
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolHG-0005ZV-G0
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:09:06 +0000
Received: by mail-ed1-x544.google.com with SMTP id e22so6457405edq.8
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=d31PpSzdyqjKwey15N5IKMpFdG+4vlPQzj0ZE0Mhabk=;
 b=DtaXE94Vz2GriaOfmgfyU24KSTsGYsYhe16nGRkyZ4Vt0Q7NOf7prCJyCX5nTwVho2
 s6MMFbJsaIEi9nMefDZdz76yW9pvGBYygSnr1E3c7AoXh60LuYDBZcLNlhZPw30Hl70d
 DMY+zkZncupMiqsV8tZ9ZxDzst6KRGkKH0bfJgSmhJDsDHFoBiVxSrJjyIt0g2dAJ+OK
 hUqk77PpAminKSPmVUrdVWHfzzVy10IojrUHZpeees/F0DJYgOL5KbJbgqM7uhgI6KyB
 POZ92YEOvf9TcKie8zOk80xyVgyk4DgXXzCgeb7D3nSc2lWLXy9gCBQYFi10iG/65CpK
 8h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=d31PpSzdyqjKwey15N5IKMpFdG+4vlPQzj0ZE0Mhabk=;
 b=pirxUyOHO08OmHXw7EnOlmY+0gBKn6dp6L/cIuaxJShXBJbF3Z3L0HNMP5wtrVtK9a
 lxpeQlwq4SIJKp8vVTX3dA8CYLz64QfMmoWSv1bXIa0LvCQg98T/t3ISchSjmoERcAgM
 tVx0VV96NlDhM5vfdBIxNE1MU0jyD+XHmZ7z12Cb5yNl0ZgL4LtZt+8sp9bcDMg5QxRy
 kJJ4WrUScYMtW3Pb36kxVX4WWweSjoZK/Ntf2R3/VRWKaOOoqOIiG1ONHqoX/oR4iJ21
 clybSz4+K6xJVwgoejxexgSlL2t69WmogoHmT2H1vlJKpEJ6ycrir0bEGAxxbgXvmAlM
 4VUA==
X-Gm-Message-State: AOAM530H1tM8OWE/W7LGlbHzM5/k0i4Uok1/AHa0o0vFU8q/HRRuOTk4
 uzniC6W5k32LuAG5G7jhYeTa1bOd8K3G1/R7
X-Google-Smtp-Source: ABdhPJx59lWENb/DyYuQHrZ3utvTYPC5G6bwIGS0eCgcvkCNm2mTPfpStObKCCaApZEWJfbF2ziT/w==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr1727405edr.16.1593151739548; 
 Thu, 25 Jun 2020 23:08:59 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id bc23sm2347762edb.90.2020.06.25.23.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:08:58 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:08:58 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_110813_418281_5CEF503C 
X-CRM114-Status: GOOD (  24.92  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwMTozNCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI1
IDIxOjIyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gQWRkIHN1cHBvcnQgZm9yIG9mZmxpbmUg
dHJhbnNpdGlvbiBvbiB0aGUgem9uZWQgYmxvY2sgZGV2aWNlIHVzaW5nIHRoZQo+PiBuZXcgem9u
ZSBtYW5hZ2VtZW50IElPQ1RMCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXog
PGphdmllci5nb256QHNhbXN1bmcuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMg
PHNlbHZha3VtYS5zMUBzYW1zdW5nLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBKb3No
aSA8am9zaGkua0BzYW1zdW5nLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogTml0ZXNoIFNoZXR0eSA8
bmouc2hldHR5QHNhbXN1bmcuY29tPgo+PiAtLS0KPj4gIGJsb2NrL2Jsay1jb3JlLmMgICAgICAg
ICAgICAgIHwgMiArKwo+PiAgYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgfCAzICsrKwo+
PiAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgfCAzICsrKwo+PiAgaW5jbHVkZS9saW51
eC9ibGtfdHlwZXMuaCAgICAgfCAzICsrKwo+PiAgaW5jbHVkZS9saW51eC9ibGtkZXYuaCAgICAg
ICAgfCAxIC0KPj4gIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIHwgMSArCj4+ICA2IGZp
bGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jCj4+IGluZGV4IDAzMjUy
YWY4YzgyYy4uNTg5Y2JkYWNjNWVjIDEwMDY0NAo+PiAtLS0gYS9ibG9jay9ibGstY29yZS5jCj4+
ICsrKyBiL2Jsb2NrL2Jsay1jb3JlLmMKPj4gQEAgLTE0MCw2ICsxNDAsNyBAQCBzdGF0aWMgY29u
c3QgY2hhciAqY29uc3QgYmxrX29wX25hbWVbXSA9IHsKPj4gIAlSRVFfT1BfTkFNRShaT05FX0NM
T1NFKSwKPj4gIAlSRVFfT1BfTkFNRShaT05FX0ZJTklTSCksCj4+ICAJUkVRX09QX05BTUUoWk9O
RV9BUFBFTkQpLAo+PiArCVJFUV9PUF9OQU1FKFpPTkVfT0ZGTElORSksCj4+ICAJUkVRX09QX05B
TUUoV1JJVEVfU0FNRSksCj4+ICAJUkVRX09QX05BTUUoV1JJVEVfWkVST0VTKSwKPj4gIAlSRVFf
T1BfTkFNRShTQ1NJX0lOKSwKPj4gQEAgLTEwMzAsNiArMTAzMSw3IEBAIGdlbmVyaWNfbWFrZV9y
ZXF1ZXN0X2NoZWNrcyhzdHJ1Y3QgYmlvICpiaW8pCj4+ICAJY2FzZSBSRVFfT1BfWk9ORV9PUEVO
Ogo+PiAgCWNhc2UgUkVRX09QX1pPTkVfQ0xPU0U6Cj4+ICAJY2FzZSBSRVFfT1BfWk9ORV9GSU5J
U0g6Cj4+ICsJY2FzZSBSRVFfT1BfWk9ORV9PRkZMSU5FOgo+PiAgCQlpZiAoIWJsa19xdWV1ZV9p
c196b25lZChxKSkKPj4gIAkJCWdvdG8gbm90X3N1cHBvcnRlZDsKPj4gIAkJYnJlYWs7Cj4+IGRp
ZmYgLS1naXQgYS9ibG9jay9ibGstem9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+IGluZGV4
IDI5MTk0Mzg4YTFiYi4uNzA0ZmMxNTgxM2QxIDEwMDY0NAo+PiAtLS0gYS9ibG9jay9ibGstem9u
ZWQuYwo+PiArKysgYi9ibG9jay9ibGstem9uZWQuYwo+PiBAQCAtNDE2LDYgKzQxNiw5IEBAIGlu
dCBibGtkZXZfem9uZV9tZ210X2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2Rl
X3QgbW9kZSwKPj4gIAljYXNlIEJMS19aT05FX01HTVRfUkVTRVQ6Cj4+ICAJCW9wID0gUkVRX09Q
X1pPTkVfUkVTRVQ7Cj4+ICAJCWJyZWFrOwo+PiArCWNhc2UgQkxLX1pPTkVfTUdNVF9PRkZMSU5F
Ogo+PiArCQlvcCA9IFJFUV9PUF9aT05FX09GRkxJTkU7Cj4+ICsJCWJyZWFrOwo+PiAgCWRlZmF1
bHQ6Cj4+ICAJCXJldHVybiAtRU5PVFRZOwo+PiAgCX0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCBmMTIx
NTUyMzc5MmIuLjViOTVjODFkMmEyZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtNzc2LDYgKzc3
Niw5IEBAIGJsa19zdGF0dXNfdCBudm1lX3NldHVwX2NtZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0
cnVjdCByZXF1ZXN0ICpyZXEsCj4+ICAJY2FzZSBSRVFfT1BfWk9ORV9GSU5JU0g6Cj4+ICAJCXJl
dCA9IG52bWVfc2V0dXBfem9uZV9tZ210X3NlbmQobnMsIHJlcSwgY21kLCBOVk1FX1pPTkVfRklO
SVNIKTsKPj4gIAkJYnJlYWs7Cj4+ICsJY2FzZSBSRVFfT1BfWk9ORV9PRkZMSU5FOgo+PiArCQly
ZXQgPSBudm1lX3NldHVwX3pvbmVfbWdtdF9zZW5kKG5zLCByZXEsIGNtZCwgTlZNRV9aT05FX09G
RkxJTkUpOwo+PiArCQlicmVhazsKPj4gIAljYXNlIFJFUV9PUF9XUklURV9aRVJPRVM6Cj4+ICAJ
CXJldCA9IG52bWVfc2V0dXBfd3JpdGVfemVyb2VzKG5zLCByZXEsIGNtZCk7Cj4+ICAJCWJyZWFr
Owo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCBiL2luY2x1ZGUvbGlu
dXgvYmxrX3R5cGVzLmgKPj4gaW5kZXggMTZiNTdmYjJiOTljLi5iMzkyMTI2M2MzZGQgMTAwNjQ0
Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPj4gKysrIGIvaW5jbHVkZS9saW51
eC9ibGtfdHlwZXMuaAo+PiBAQCAtMzE2LDYgKzMxNiw4IEBAIGVudW0gcmVxX29wZiB7Cj4+ICAJ
UkVRX09QX1pPTkVfRklOSVNICT0gMTIsCj4+ICAJLyogd3JpdGUgZGF0YSBhdCB0aGUgY3VycmVu
dCB6b25lIHdyaXRlIHBvaW50ZXIgKi8KPj4gIAlSRVFfT1BfWk9ORV9BUFBFTkQJPSAxMywKPj4g
KwkvKiBUcmFuc2l0aW9uIGEgem9uZSB0byBvZmZsaW5lICovCj4+ICsJUkVRX09QX1pPTkVfT0ZG
TElORQk9IDE0LAo+Pgo+PiAgCS8qIFNDU0kgcGFzc3Rocm91Z2ggdXNpbmcgc3RydWN0IHNjc2lf
cmVxdWVzdCAqLwo+PiAgCVJFUV9PUF9TQ1NJX0lOCQk9IDMyLAo+PiBAQCAtNDU2LDYgKzQ1OCw3
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBvcF9pc196b25lX21nbXQoZW51bSByZXFfb3BmIG9wKQo+
PiAgCWNhc2UgUkVRX09QX1pPTkVfT1BFTjoKPj4gIAljYXNlIFJFUV9PUF9aT05FX0NMT1NFOgo+
PiAgCWNhc2UgUkVRX09QX1pPTkVfRklOSVNIOgo+PiArCWNhc2UgUkVRX09QX1pPTkVfT0ZGTElO
RToKPj4gIAkJcmV0dXJuIHRydWU7Cj4+ICAJZGVmYXVsdDoKPj4gIAkJcmV0dXJuIGZhbHNlOwo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxr
ZGV2LmgKPj4gaW5kZXggYmQ4NTIxZjk0ZGM0Li44MzA4ZDhhMzcyMGIgMTAwNjQ0Cj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAo+
PiBAQCAtMzcyLDcgKzM3Miw2IEBAIGV4dGVybiBpbnQgYmxrZGV2X3pvbmVfb3BzX2lvY3RsKHN0
cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4gIAkJCQkgIHVuc2lnbmVk
IGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKTsKPj4gIGV4dGVybiBpbnQgYmxrZGV2X3pvbmVf
bWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCj4+ICAJ
CQkJICB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7Cj4+IC0KPj4gICNlbHNl
IC8qIENPTkZJR19CTEtfREVWX1pPTkVEICovCj4+Cj4+ICBzdGF0aWMgaW5saW5lIHVuc2lnbmVk
IGludCBibGtkZXZfbnJfem9uZXMoc3RydWN0IGdlbmRpc2sgKmRpc2spCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6
b25lZC5oCj4+IGluZGV4IGE4Yzg5ZmU1OGY5Ny4uZDA5NzhlZTEwZmM3IDEwMDY0NAo+PiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvYmxrem9uZWQuaAo+PiBAQCAtMTU1LDYgKzE1NSw3IEBAIGVudW0gYmxrX3pvbmVfYWN0aW9u
IHsKPj4gIAlCTEtfWk9ORV9NR01UX0ZJTklTSAk9IDB4MiwKPj4gIAlCTEtfWk9ORV9NR01UX09Q
RU4JPSAweDMsCj4+ICAJQkxLX1pPTkVfTUdNVF9SRVNFVAk9IDB4NCwKPj4gKwlCTEtfWk9ORV9N
R01UX09GRkxJTkUJPSAweDUsCj4+ICB9Owo+Pgo+PiAgLyoqCj4+Cj4KPkFzIG1lbnRpb25lZCBp
biBwcmV2aW91cyBlbWFpbCwgdGhlIHVzZWZ1bG5lc3Mgb2YgdGhpcyBpcyBkdWJpb3VzLiBQbGVh
c2UKPmVsYWJvcmF0ZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIFN1cmUgTlZNZSBaTlMgZGVmaW5l
cyB0aGlzIGFuZCB3ZSBjYW4gc3VwcG9ydAo+aXQuIEJ1dCB3aXRob3V0IGEgZ29vZCB1c2UgY2Fz
ZSwgd2hhdCBpcyB0aGUgcG9pbnQgPwoKVXNlIGNhc2UgaXMgdG8gdHJhbnNpdGlvbiB6b25lcyBp
biByZWFkLW9ubHkgc3RhdGUgdG8gb2ZmbGluZSB3aGVuIHdlCmFyZSBkb25lIG1vdmluZyB2YWxp
ZCBkYXRhLiBJdCBpcyBlYXNpZXIgdG8gZXhwbGljaXRseSBtYW5hZ2luZyB6b25lcwp0aGF0IGFy
ZSBub3QgdXNhYmxlIGJ5IGhhdmluZyBhbGwgdW5kZXIgdGhlIG9mZmxpbmUgc3RhdGUuCgo+Cj5z
Y3NpIFNEIGRyaXZlciB3aWxsIHJldHVybiBCTEtfU1RTX05PVFNVUFAgaWYgdGhpcyBvZmZsaW5p
bmcgaXMgc2VudCB0byBhCj5aQkMvWkFDIGRyaXZlLiBOb3QgbmljZS4gSGF2aW5nIGEgc3lzZnMg
YXR0cmlidXRlICJtYXhfb2ZmbGluZV96b25lX3NlY3RvcnMiIG9yCj50aGUgbGlrZSB0byBpbmRp
Y2F0ZSBzdXBwb3J0IGJ5IHRoZSBkZXZpY2Ugb3Igbm90IHdvdWxkIGJlIG5pY2VyLgoKV2UgY2Fu
IGRvIHRoYXQuCgo+Cj5Eb2VzIG9mZmxpbmcgQUxMIHpvbmVzIG1ha2UgYW55IHNlbnNlID8gQmVj
YXVzZSB0aGlzIHBhdGNoIGRvZXMgbm90IHByZXZlbnQgdGhlCj51c2Ugb2YgdGhlIFJFUV9aT05F
X0FMTCBmbGFncyBpbnRyb2R1Y2VkIGluIHBhdGNoIDIuIFByb2JhYmx5IG5vdCBhIGdvb2QgaWRl
YSB0bwo+YWxsb3cgb2ZmbGluaW5nIGFsbCB6b25lcywgbm8gPwoKQUZBSUsgdGhlIHRyYW5zaXRp
b24gdG8gb2ZmbGluZSBpcyBvbmx5IHZhbGlkIHdoZW4gY29taW5nIGZyb20gYQpyZWFkLW9ubHkg
c3RhdGUuIEkgZGlkIHRoaW5rIG9mIGFkZGluZyBhIGNoZWNrLCBidXQgSSBjYW4gc2VlIHRoYXQg
b3RoZXIKdHJhbnNpdGlvbnMgZ28gZGlyZWN0bHkgdG8gdGhlIGRyaXZlciBhbmQgdGhlbiB0aGUg
ZGV2aWNlLCBzbyBJIGRlY2lkZWQKdG8gZm9sbG93IHRoZSBzYW1lIG1vZGVsLiBJZiB5b3UgdGhp
bmsgaXQgaXMgYmV0dGVyLCB3ZSBjYW4gYWRkIHRoZQpjaGVjay4KCkphdmllcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
