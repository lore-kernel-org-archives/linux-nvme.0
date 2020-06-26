Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59FC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7853020724
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wA83hxdr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCrzhSHz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="PCtR5uzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7853020724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/49wJ3jfrJbHUMEMjSDHgFDHLjz8ED2pKQGg+ZvdywQ=; b=wA83hxdrA9xFeqO98fH35otO+
	khp6tQ9ZzfLy14ejnzON3lcD0Kg1JgYNIgsd60j/r3mvRQ3V0s/wKK41h03PsaUWAF2IId7AP0+Dk
	W2q47sqQttdCLO9NIDcJYKdlgNxKHSDqydfBwYBfOu1dsK6HaWE85MxVg3bhRDO8qtkwJdjReZn3O
	pNRawJ2Z5vn+hjypt1+AqXuiKdGkMOJyoLvLQvBnfvrpoho2TlNNuVUMe8/NPHaKHLHoIJDaqUlT+
	qACFaBQYeZqAJQ7bBPj+N/pF1R87tA+2GzuWPhT//4N/5g9NOh0vER0vKwcsCmTnoI6Xb3MJx26CO
	3HVR+J6MA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomUn-0002Nz-LQ; Fri, 26 Jun 2020 11:26:13 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolEu-0000h7-4N
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=tGyvC7aD/nKPwlz3EkMHVqwcl4yrJwWIm4ok1mb5AU0=; b=uCrzhSHz+uRHHcjezXH/qfw04G
 20VQn9V/mBZmG644L9l41go/dKNXvr692kwnN2DSx543x/5/ItteOsIYhbtgQwIcFwOHasCtwbVHR
 4LEp7f6wcx1e1UbUayItMcb1Y4o0HrWzaIWJlykjIhhmxY7mgtJwa9zHZs26SRTvlWNkBKpE2CqhD
 bsZwINuzGXhPI8zhkJeOjiG2cM3R1GYfT/0FFQMr3PE0D5jvNrIsvq9w8af3j5RGAupwkmuOm4Sjm
 RJK5ZbGWYIqyyvDyHb0VqFwQ/urA/9hvfgpQirtaCrNh98uh+MHPIvhMcqXswbT2VnXdfeguCOM+2
 9AXxSraA==;
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokv9-0006Ak-7w
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:45:35 +0000
Received: by mail-lj1-x243.google.com with SMTP id h19so9601194ljg.13
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=tGyvC7aD/nKPwlz3EkMHVqwcl4yrJwWIm4ok1mb5AU0=;
 b=PCtR5uzRaA4teCUGfCpfb3i5VeKwWwDiJt+qVZpSOjwhEzDzFIkavujreygaMCBzMi
 mlDvtLFE5+jya+WIDAYrFu5wDlYBFJ9gNNpCcTACfUa8YnTPvF62sDxakZ/+IClKQbdT
 gVFrwYRHgyTW3j6krotL/LkQ/kaLUfZIcEjMAM9q1KcLmZUaqw8031iEt6IXizW5ZnZi
 5xQ55TEG6y5lU10HfJiVGfhY8+jFOkso/eEAtHN72O0+iDrqC6t8dF96KNXcbn4tU40A
 shy0Nz1/HauGvGIVRuRhyFl0XNioB04xj+5VbN4w8H3lzo2b/ysDICH5ro/ldg/W9mmc
 opqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=tGyvC7aD/nKPwlz3EkMHVqwcl4yrJwWIm4ok1mb5AU0=;
 b=RltxvrzjDcI0SdkehdK5mVMKbxMwOCXXLRsijUztPKAUFIoo16mSRBbwsSG9IYS01+
 oUnNSwainHX86zyzvWKIqiWpM3JHEMfWVw6bGA85ZobhKMxVSkx4lXz3j5mbJczAXpJB
 +I5qTjAgWJu6L0CPzepFbIdZygLS6GZcLb+aSk+59HLfj2IW4gTAKp3hSf05gI7r+m7G
 zvTT4X+xxCUu9llG2FkmnpBzQOtzVqz0CBbIYdaj3qx/hpX0P4I6Naa4kjLYWiy2rVS7
 W/BCHxFYo1YCqnF2yinE0/HIfiy9eZHcbMijh+ZndFW4VSFR2+lFLQ1cVIomg98Zz9iy
 fsbg==
X-Gm-Message-State: AOAM5316rxi99zAEV7OMSwA+SIL8V5X9NPhSImRZCg0HmxSlhkl4HsAl
 XhwXhH6xXdrS5tsIeQZ+Mh/zBpa8QQv60OEk
X-Google-Smtp-Source: ABdhPJxHO0g8pV5on8q+mYSasErJil68s5nGRDswzUD8GkRN4rk5PEuDbjcC72kpRVNIX+otnuqHHw==
X-Received: by 2002:aa7:d446:: with SMTP id q6mr1936003edr.218.1593154179222; 
 Thu, 25 Jun 2020 23:49:39 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id t21sm13046960ejr.68.2020.06.25.23.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:49:38 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:49:38 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200626064938.wuwofgh64qef5ygu@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060332.erje6ohzmhxzfaj4@mpHalley.localdomain>
 <CY4PR04MB3751CFFB03844247C3177071E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751CFFB03844247C3177071E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_104519_581505_73DBD837 
X-CRM114-Status: GOOD (  12.53  )
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

T24gMjYuMDYuMjAyMCAwNjozOCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI2
IDE1OjAzLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAyNi4wNi4yMDIwIDAxOjQ1LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMjUgMjE6MjIsIEphdmllciBHb256
w6FsZXogd3JvdGU6Cj4+Pj4gRnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ft
c3VuZy5jb20+Cj4+Pj4KPj4+PiBBZGQgem9uZSBhdHRyaWJ1dGVzIGZpZWxkIHRvIHRoZSBibGtf
em9uZSBzdHJ1Y3R1cmUuIFVzZSBaTlMgYXR0cmlidXRlcwo+Pj4+IGFzIGJhc2UgZm9yIHpvbmVk
IGJsb2NrIGRldmljZXMgaW4gZ2VuZXJhbC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphdmll
ciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6
IFNlbHZhS3VtYXIgUyA8c2VsdmFrdW1hLnMxQHNhbXN1bmcuY29tPgo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtAc2Ftc3VuZy5jb20+Cj4+Pj4gU2lnbmVkLW9mZi1i
eTogTml0ZXNoIFNoZXR0eSA8bmouc2hldHR5QHNhbXN1bmcuY29tPgo+Pj4+IC0tLQo+Pj4+ICBk
cml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICB8ICAxICsKPj4+PiAgaW5jbHVkZS91YXBpL2xp
bnV4L2Jsa3pvbmVkLmggfCAxMyArKysrKysrKysrKystCj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3pucy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKPj4+PiBpbmRl
eCAyNThkMDM2MTBjYzAuLjdkODM4MWZlNzY2NSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC96bnMuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+Pj4gQEAg
LTE5NSw2ICsxOTUsNyBAQCBzdGF0aWMgaW50IG52bWVfem9uZV9wYXJzZV9lbnRyeShzdHJ1Y3Qg
bnZtZV9ucyAqbnMsCj4+Pj4gIAl6b25lLmNhcGFjaXR5ID0gbnZtZV9sYmFfdG9fc2VjdChucywg
bGU2NF90b19jcHUoZW50cnktPnpjYXApKTsKPj4+PiAgCXpvbmUuc3RhcnQgPSBudm1lX2xiYV90
b19zZWN0KG5zLCBsZTY0X3RvX2NwdShlbnRyeS0+enNsYmEpKTsKPj4+PiAgCXpvbmUud3AgPSBu
dm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShlbnRyeS0+d3ApKTsKPj4+PiArCXpvbmUu
YXR0ciA9IGVudHJ5LT56YTsKPj4+Pgo+Pj4+ICAJcmV0dXJuIGNiKCZ6b25lLCBpZHgsIGRhdGEp
Owo+Pj4+ICB9Cj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5o
IGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPj4+PiBpbmRleCAwYzQ5YTRiMmNlNWQu
LjJlNDNhMDBlMzQyNSAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9u
ZWQuaAo+Pj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCj4+Pj4gQEAgLTgy
LDYgKzgyLDE2IEBAIGVudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIHsKPj4+PiAgCUJMS19aT05F
X1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAo+Pj4+ICB9Owo+Pj4+Cj4+Pj4gKy8qKgo+Pj4+ICsg
KiBab25lIEF0dHJpYnV0ZXMKPj4+Cj4+PiBUaGlzIGlzIGEgdXNlciBpbnRlcmZhY2UgZmlsZS4g
UGxlYXNlIGRvY3VtZW50IHRoZSBtZWFuaW5nIG9mIGVhY2ggYXR0cmlidXRlLgo+Pj4KPj4KPj4g
U3VyZS4KPj4KPj4+PiArICovCj4+Pj4gK2VudW0gYmxrX3pvbmVfYXR0ciB7Cj4+Pj4gKwlCTEtf
Wk9ORV9BVFRSX1pGQwk9IDEgPDwgMCwKPj4+PiArCUJMS19aT05FX0FUVFJfRlpSCT0gMSA8PCAx
LAo+Pj4+ICsJQkxLX1pPTkVfQVRUUl9SWlIJPSAxIDw8IDIsCj4+Pj4gKwlCTEtfWk9ORV9BVFRS
X1pERVYJPSAxIDw8IDcsCj4+PiBUaGVzZSBhcmUgWk5TIHNwZWNpZmljLCByaWdodCA/IEludGVn
cmF0aW5nIHRoZSAyIFpCQy9aQUMgYXR0cmlidXRlcyBpbiB0aGlzCj4+PiBsaXN0IHdvdWxkIGJl
IG5pY2UsIG5hbWVseSBub25fc2VxIGFuZCByZXNldC4gVGhhdCB3aWxsIGltcGx5IHBhdGNoaW5n
IHNkLmMuCj4+Pgo+Pgo+PiBPZiBjb3Vyc2UuIEkgd2lsbCBsb29rIGF0IG5vbl9zZXEgYW5kIHJl
c2V0LiBBbnkgb3RoZXIgdGhhdCBzaG91bGQgZ28KPj4gaW4gaGVyZT8KPgo+U2VlIFpCQyBzcGVj
cy4gVGhlc2UgYXJlIHRoZSBvbmx5IDIgem9uZSBhdHRyaWJ1dGVzIGRlZmluZWQuCgpHb29kLiBX
ZSB3aWxsIGFkZCB0aGlzIGluIFYyLgoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
