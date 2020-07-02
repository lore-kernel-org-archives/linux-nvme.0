Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CB7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAFF20780
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQ+zDw3n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jcXYO2C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAFF20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jKku7/aPj0fNfkucp+Jn+pzlS3Fy9WqTTwajuUOSmao=; b=VQ+zDw3nVss0dwqTflaG8DbGA
	CEMFvMMjWUwD+GBJGvkssCA9mPP7OF2/NrrrDGWsPp4AwnHV57wx1AXA0ZA6tKpalH8mFOwqFGIZa
	MPBchn11hYHvJWORkJPRVdNHW20uOnfylyOZCG3VD4aMIxQ0Z1dgeIJB7R0fLQj7V8hmtxWrucYTF
	66jDyu+9Aa3y7Z3MmCw32IrjcL45Uclcdk15Q2pWcx1+w6tP1uS5Cno3SQPXkJC2MPGbM3VXAmL1N
	aVM45xUPL9bKes1RlA3nqXWyvuWjilFrJwk+DAmSnwgZNHpbLWTBpjuxJaGJvCB+4dryPtjdcgnjS
	4bOHNVjxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqwIa-000119-Cm; Thu, 02 Jul 2020 10:18:32 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqwIP-0000wd-LI
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 10:18:30 +0000
Received: by mail-ej1-x643.google.com with SMTP id dr13so28660706ejc.3
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=xbWDHuFi/asrt9wfewvCpHAZIXQkTs3SNUDtcY1u8hU=;
 b=jcXYO2C3KpOvz2vxbAF9UuZbvbe1p7N9wWO46hx2xV5iYz+16cf2tv5D0tdiFN35av
 cNjIfrHtOFD05lCWRB2p/K2kh968Jzhy4e3ttjGUPMABoxAUfIQH23QS7hhnogrQgfbv
 RxxPdsJmync1TQe6wv3YNdlkbFvhEV3XFR3xSGtv2wstx+aDlw5f5etM9ZBAjs2e6cl+
 KFkBE/uy8iAoFYXqqGSvRf2eGpBoLYvpSHM/L9HJptaSrhBBxiShXAO1zPqnAgiggRUn
 X13epM/lUnJTra/507kFIU9IZFLFJsRTDLMjJwxKcCFkR73REtWtyAa7i+5O/G4PVFtt
 oi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xbWDHuFi/asrt9wfewvCpHAZIXQkTs3SNUDtcY1u8hU=;
 b=fT55f+ji5sbydm+0LbMrwojnDcVUat/Ew/4m/Q77oeeAp5ZCTYNi5tPwvHkylNFu2r
 nImMwuAbjmJa+aGm1EFhstkvrBJzLhrWmTcJlJ+gVP34hI+91VBvrf4LNeRZc2+SJmsF
 YTrI67GJN4ZeNG/iQFQDRmYd6A5XwkYLTichvnaiC0OoPnA3NyUH4wm40pLYgWXR/162
 BvpEjPppqG8ITUM61Ndco83YHdYiC2QqWDrT9grUsrgEpTDGlKF4YWDzN0SSnBA8ocpa
 PzybXaO5lxNPvQaj7M/j2VlmcMcJJrEmAyqgJAjdSQImHP0ypw3OMdaJG4HEvAsUB0Jc
 G19g==
X-Gm-Message-State: AOAM531yBgtPonOhSN1YY1XGJAX7dJhoc9O++u47UqYTic/cld0T2Bg3
 540WP4N+nBXc6d3YFJyxeJqeaA==
X-Google-Smtp-Source: ABdhPJyT2g6O3CfkBUhFCbbksffwPXhxQC9QzTc0kfnvqAD2Rt0+u2BvJlNloBVXAkXCrroe0BR2zw==
X-Received: by 2002:a17:907:7244:: with SMTP id
 ds4mr17235363ejc.509.1593685100092; 
 Thu, 02 Jul 2020 03:18:20 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id a37sm9289788edf.86.2020.07.02.03.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:18:19 -0700 (PDT)
Date: Thu, 2 Jul 2020 12:18:18 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Message-ID: <20200702101818.letttarzs4pwi7os@mpHalley.local>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-2-javier@javigon.com>
 <CY4PR04MB37519E324412FC96FDE6BFC1E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37519E324412FC96FDE6BFC1E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_061821_899545_3A7561C1 
X-CRM114-Status: GOOD (  20.49  )
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
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "mb@lightnvm.io" <mb@lightnvm.io>,
 "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDIuMDcuMjAyMCAwOTo0NiwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA3LzAy
IDE4OjI1LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gQXMgdGhlIHpvbmVkIGJsb2NrIGRldmlj
ZSB3aWxsIGhhdmUgdG8gZGVhbCB3aXRoIGZlYXR1cmVzIHRoYXQgYXJlCj4+IG9wdGlvbmFsIGZv
ciB0aGUgYmFja2VuZCBkZXZpY2UsIGFkZCBhIGZsYWcgZmllbGQgdG8gaW5mb3JtIHRoZSBibG9j
awo+PiBsYXllciBhYm91dCBzdXBwb3J0ZWQgZmVhdHVyZXMuIFRoaXMgYnVpbGRzIG9uIHRvcCBv
Zgo+PiBibGtfem9uZV9yZXBvcnRfZmxhZ3MgYW5kIGV4dGVuZGVzIHRvIHRoZSB6b25lIHJlcG9y
dCBjb2RlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29u
ekBzYW1zdW5nLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEu
czFAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtA
c2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBz
YW1zdW5nLmNvbT4KPj4gLS0tCj4+ICBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgfCAz
ICsrLQo+PiAgZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwgMiArKwo+PiAgZHJpdmVy
cy9udm1lL2hvc3Qvem5zLmMgICAgICAgIHwgMSArCj4+ICBkcml2ZXJzL3Njc2kvc2QuYyAgICAg
ICAgICAgICAgfCAyICsrCj4+ICBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oICAgICAgICAgfCAzICsr
Kwo+PiAgNSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstem9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+
IGluZGV4IDgxMTUyYTI2MDM1NC4uMGYxNTZlOTZlNDhmIDEwMDY0NAo+PiAtLS0gYS9ibG9jay9i
bGstem9uZWQuYwo+PiArKysgYi9ibG9jay9ibGstem9uZWQuYwo+PiBAQCAtMzEyLDcgKzMxMiw4
IEBAIGludCBibGtkZXZfcmVwb3J0X3pvbmVzX2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJk
ZXYsIGZtb2RlX3QgbW9kZSwKPj4gIAkJcmV0dXJuIHJldDsKPj4KPj4gIAlyZXAubnJfem9uZXMg
PSByZXQ7Cj4+IC0JcmVwLmZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOwo+PiArCXJlcC5m
bGFncyA9IHEtPnpvbmVfZmxhZ3M7Cj4KPiphbGwqIHpvbmVkIGRldmljZXMgc3VwcG9ydCBjYXBh
Y2l0eS4gU28gd2h5IGNoYW5naW5nIHRoaXMgPwo+WW91IGFyZSBvbmx5IGZvcmNpbmcgYWRkaW5n
IHNldHRpbmcgdGhlIHF1ZXVlIGZsYWdzIGZvciBhbGwgZGV2aWNlIGRyaXZlcnMuIFRoYXQKPmlz
IG1vcmUgY29kZS4KPgo+PiArCj4KPldoaXRlIGxpbmUgY2hhbmdlCj4KPj4gIAlpZiAoY29weV90
b191c2VyKGFyZ3AsICZyZXAsIHNpemVvZihzdHJ1Y3QgYmxrX3pvbmVfcmVwb3J0KSkpCj4+ICAJ
CXJldHVybiAtRUZBVUxUOwo+PiAgCXJldHVybiAwOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bG9jay9udWxsX2Jsa196b25lZC5jIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCj4+
IGluZGV4IGIwNTgzMmViMjFiMi4uOTU3YzIxMDNmMjQwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2Jsb2NrL251bGxfYmxrX3pvbmVkLmMKPj4gKysrIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsa196
b25lZC5jCj4+IEBAIC03OCw2ICs3OCw4IEBAIGludCBudWxsX2luaXRfem9uZWRfZGV2KHN0cnVj
dCBudWxsYl9kZXZpY2UgKmRldiwgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCj4+ICAJfQo+Pgo+
PiAgCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKPj4gKwlxLT56b25lX2ZsYWdzID0g
QkxLX1pPTkVfUkVQX0NBUEFDSVRZOwo+PiArCj4KPldoaXRlIGxpbmUgY2hhbmdlCj4KPj4gIAli
bGtfcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19aT05FX1JFU0VUQUxMLCBxKTsKPj4gIAlibGtf
cXVldWVfcmVxdWlyZWRfZWxldmF0b3JfZmVhdHVyZXMocSwgRUxFVkFUT1JfRl9aQkRfU0VRX1dS
SVRFKTsKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jIGIvZHJpdmVy
cy9udm1lL2hvc3Qvem5zLmMKPj4gaW5kZXggYzA4ZjYyODFiNjE0Li5hZmU2MmRjMjdmZjcgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3pucy5jCj4+IEBAIC04MSw2ICs4MSw3IEBAIGludCBudm1lX3VwZGF0ZV96b25lX2lu
Zm8oc3RydWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCBudm1lX25zICpucywKPj4gIAl9Cj4+Cj4+
ICAJcS0+bGltaXRzLnpvbmVkID0gQkxLX1pPTkVEX0hNOwo+PiArCXEtPnpvbmVfZmxhZ3MgPSBC
TEtfWk9ORV9SRVBfQ0FQQUNJVFk7Cj4+ICAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdf
Wk9ORV9SRVNFVEFMTCwgcSk7Cj4+ICBmcmVlX2RhdGE6Cj4+ICAJa2ZyZWUoaWQpOwo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zY3NpL3NkLmMgYi9kcml2ZXJzL3Njc2kvc2QuYwo+PiBpbmRleCBk
OTBmZWZmZmUzMWIuLmI5YzkyMGJhY2UyOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9zY3NpL3Nk
LmMKPj4gKysrIGIvZHJpdmVycy9zY3NpL3NkLmMKPj4gQEAgLTI5NjcsNiArMjk2Nyw3IEBAIHN0
YXRpYyB2b2lkIHNkX3JlYWRfYmxvY2tfY2hhcmFjdGVyaXN0aWNzKHN0cnVjdCBzY3NpX2Rpc2sg
KnNka3ApCj4+ICAJaWYgKHNka3AtPmRldmljZS0+dHlwZSA9PSBUWVBFX1pCQykgewo+PiAgCQkv
KiBIb3N0LW1hbmFnZWQgKi8KPj4gIAkJcS0+bGltaXRzLnpvbmVkID0gQkxLX1pPTkVEX0hNOwo+
PiArCQlxLT56b25lX2ZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOwo+PiAgCX0gZWxzZSB7
Cj4+ICAJCXNka3AtPnpvbmVkID0gKGJ1ZmZlcls4XSA+PiA0KSAmIDM7Cj4+ICAJCWlmIChzZGtw
LT56b25lZCA9PSAxICYmICFkaXNrX2hhc19wYXJ0aXRpb25zKHNka3AtPmRpc2spKSB7Cj4+IEBA
IC0yOTgzLDYgKzI5ODQsNyBAQCBzdGF0aWMgdm9pZCBzZF9yZWFkX2Jsb2NrX2NoYXJhY3Rlcmlz
dGljcyhzdHJ1Y3Qgc2NzaV9kaXNrICpzZGtwKQo+PiAgCQkJCQkgICJEcml2ZS1tYW5hZ2VkIFNN
UiBkaXNrXG4iKTsKPj4gIAkJfQo+PiAgCX0KPj4gKwo+Cj5XaGl0ZSBsaW5lIGNoYW5nZQo+Cj4+
ICAJaWYgKGJsa19xdWV1ZV9pc196b25lZChxKSAmJiBzZGtwLT5maXJzdF9zY2FuKQo+PiAgCQlz
ZF9wcmludGsoS0VSTl9OT1RJQ0UsIHNka3AsICJIb3N0LSVzIHpvbmVkIGJsb2NrIGRldmljZVxu
IiwKPj4gIAkJICAgICAgcS0+bGltaXRzLnpvbmVkID09IEJMS19aT05FRF9ITSA/ICJtYW5hZ2Vk
IiA6ICJhd2FyZSIpOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2lu
Y2x1ZGUvbGludXgvYmxrZGV2LmgKPj4gaW5kZXggOGZkOTAwOTk4YjRlLi4zZjJlMzQyNWZhNTMg
MTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPj4gKysrIGIvaW5jbHVkZS9s
aW51eC9ibGtkZXYuaAo+PiBAQCAtNTEyLDEyICs1MTIsMTUgQEAgc3RydWN0IHJlcXVlc3RfcXVl
dWUgewo+PiAgCSAqIFN0YWNraW5nIGRyaXZlcnMgKGRldmljZSBtYXBwZXJzKSBtYXkgb3IgbWF5
IG5vdCBpbml0aWFsaXplCj4+ICAJICogdGhlc2UgZmllbGRzLgo+PiAgCSAqCj4+ICsJICogRmxh
Z3MgcmVwcmVzZW50IGZlYXR1cmVzIGFzIGRlc2NyaWJlZCBieSBibGtfem9uZV9yZXBvcnRfZmxh
Z3MgaW4gYmxrem9uZWQuaAo+PiArCSAqCj4+ICAJICogUmVhZHMgb2YgdGhpcyBpbmZvcm1hdGlv
biBtdXN0IGJlIHByb3RlY3RlZCB3aXRoIGJsa19xdWV1ZV9lbnRlcigpIC8KPj4gIAkgKiBibGtf
cXVldWVfZXhpdCgpLiBNb2RpZnlpbmcgdGhpcyBpbmZvcm1hdGlvbiBpcyBvbmx5IGFsbG93ZWQg
d2hpbGUKPj4gIAkgKiBubyByZXF1ZXN0cyBhcmUgYmVpbmcgcHJvY2Vzc2VkLiBTZWUgYWxzbyBi
bGtfbXFfZnJlZXplX3F1ZXVlKCkgYW5kCj4+ICAJICogYmxrX21xX3VuZnJlZXplX3F1ZXVlKCku
Cj4+ICAJICovCj4+ICAJdW5zaWduZWQgaW50CQlucl96b25lczsKPj4gKwl1bnNpZ25lZCBpbnQJ
CXpvbmVfZmxhZ3M7Cj4+ICAJdW5zaWduZWQgbG9uZwkJKmNvbnZfem9uZXNfYml0bWFwOwo+PiAg
CXVuc2lnbmVkIGxvbmcJCSpzZXFfem9uZXNfd2xvY2s7Cj4+ICAjZW5kaWYgLyogQ09ORklHX0JM
S19ERVZfWk9ORUQgKi8KPj4KPgo+QW5kIHlvdSBhcmUgc3RpbGwgYnJlYWtpbmcgZGV2aWNlIG1h
cHBlciB0YXJnZXRzIHJlcG9ydCB6b25lcyB3aXRoIHRoaXMgcGF0Y2guCgpZZXMuIEkgbWVudGlv
bmVkIGluIHRoZSB2ZXJzaW9uIGNoYW5nZXMgdGhhdCBJIG9ubHkgZml4ZWQgYSBiYWQgY29tbWl0
CndpdGggZGVidWcgY29kZS4gSSdsbCBhZGRyZXNzIHRoaXMgaW4gYSBuZXcgdmVyc2lvbiB3aGVu
IHRoZSB1c2Ugb2YgdGhlCmZlYXR1cmUgYml0IGlzIGNsYXJpZmllZCAoaS5lLiwga2VlcCBpdCB0
aGlzIHdheSBvciBtb3ZlIHRvIHN5c2ZzKS4KCkphdmllcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
