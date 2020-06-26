Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A0C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46302078D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="svk8jecv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="rrseKeWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46302078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wyLjUELbgu9RTIT+v2YpiErCxTDmzK+qSav1XkyoJfE=; b=svk8jecvE3Dg0bJDDgDzeybuu
	sb2Fn03zQWTx86H7ipL11StUFAv8Vgj7NhdWoSlzHDJ54wK8UGPiIpM4a1HL+nEXyvCz5uz0Y/zmY
	wNqLpHpAk9E2ZVvMCkVSaURiIRp6L+dm9j3NJyNMSaGqRdzUY2eS7BDos0yj/cyuaYcACZTIGQhZx
	LUUWIeJdlwfK8nqJcyyYZK5e5WzIm7iz9GyKNlxnm6c5zdCJd96l/2NoZC02nvZyFgkKfjvLWQBSO
	5RQCgXd+FZfzQZFhld0HzWMMwEtuaprxBOvTgsbOxTtHfYoKL5088rCSHllngbosxyP5KFKaWaM5N
	+ZrF+AoUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jondG-0002f0-L1; Fri, 26 Jun 2020 12:39:02 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolJd-0004Eb-Ls
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:10:38 +0000
Received: by mail-lj1-x244.google.com with SMTP id t25so5149148lji.12
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6Wa0nRrjgIPv+dA7seaYMqfaMdZ9JAfOV0yYw+e/zWI=;
 b=rrseKeWU4AqvZ9E+Mo151/SvU12F+aJUs4CINTxnd9eGX+9PY7syCuPfo1cGFbicgK
 E/3xJknpU3WG7ijqqtWS23SFmcZojho/Qv7dwgJha3tS+qX3YjVsm68t/pzWhxYd6HfG
 1cs9Jgff2ZLZH5X0vTR8tI3ikBqFUxYDFfANsUt2ewOs7rSPmalQemoOqE0XNq90ftwR
 PwaHXu5wKvj6JmITN+oGq8T4vv+yA1USTs2OGKb5BH2O3kgfuFiLe6NjXlUUOP3ogc97
 xE7K7xpdOeDliXnl3/oIf5MxrdS8zjUQT7zGXMsuwGWGA9zbCcOXh/wlNgjqEkZzQd9b
 273A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6Wa0nRrjgIPv+dA7seaYMqfaMdZ9JAfOV0yYw+e/zWI=;
 b=GUf+qJDt3EvQ5HNcuYEdjOePZHVJQwpomnrVPsnw1kxAfFQYl7NhtK7VonXB6Gd155
 55kYmIBaM+neE0XKdmt6F89IDSjyyoOzMWbH91eDC8tGiwZfVffXFsGbXb1fO8XaE8jO
 ThBvdjNqYe0gPzJUPGkJhD1ewViM8eMu/LwwjXQ7F/uHRnZOvO4i1Q8FoabimyPtAPjr
 xLJWagdOr2bOAUZMujOVFBqGO98w/CZAcs5UAjtwyVwwE1CjxvR5fGnoUHBOymjeuw6x
 Xm3JnN5e5yb+tMXuXogLs4KIE5G2DiDp8Yjng9IVi46tJl2CIN1PBhOsMxdRXIjFInIP
 I7Iw==
X-Gm-Message-State: AOAM531y7R20guksYnqBCVHRJnHWx9lhjLCicNrProFwtqcXRlZ8V9us
 PJMZlpbz97EsnptVBQs1pftnLdc5oPQbY8qd
X-Google-Smtp-Source: ABdhPJzYUtnkQQ7HWNe4Y4eBtjVkFxzMKZ23QI6QGlCbGm88ukdkCaLBHsudMb0qSETQjkDVT4MR6Q==
X-Received: by 2002:a17:906:57c6:: with SMTP id
 u6mr1160147ejr.194.1593151413616; 
 Thu, 25 Jun 2020 23:03:33 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id d5sm2734496eds.40.2020.06.25.23.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:03:32 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:03:32 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200626060332.erje6ohzmhxzfaj4@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
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

T24gMjYuMDYuMjAyMCAwMTo0NSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI1
IDIxOjIyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gQWRkIHpvbmUgYXR0cmlidXRlcyBmaWVs
ZCB0byB0aGUgYmxrX3pvbmUgc3RydWN0dXJlLiBVc2UgWk5TIGF0dHJpYnV0ZXMKPj4gYXMgYmFz
ZSBmb3Igem9uZWQgYmxvY2sgZGV2aWNlcyBpbiBnZW5lcmFsLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4gU2lnbmVkLW9m
Zi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYt
Ynk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBzYW1zdW5nLmNvbT4KPj4gLS0tCj4+ICBkcml2
ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICB8ICAxICsKPj4gIGluY2x1ZGUvdWFwaS9saW51eC9i
bGt6b25lZC5oIHwgMTMgKysrKysrKysrKysrLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
aG9zdC96bnMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+IGluZGV4IDI1OGQwMzYxMGNj
MC4uN2Q4MzgxZmU3NjY1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+PiBAQCAtMTk1LDYgKzE5NSw3IEBAIHN0
YXRpYyBpbnQgbnZtZV96b25lX3BhcnNlX2VudHJ5KHN0cnVjdCBudm1lX25zICpucywKPj4gIAl6
b25lLmNhcGFjaXR5ID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2NF90b19jcHUoZW50cnktPnpj
YXApKTsKPj4gIAl6b25lLnN0YXJ0ID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2NF90b19jcHUo
ZW50cnktPnpzbGJhKSk7Cj4+ICAJem9uZS53cCA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRf
dG9fY3B1KGVudHJ5LT53cCkpOwo+PiArCXpvbmUuYXR0ciA9IGVudHJ5LT56YTsKPj4KPj4gIAly
ZXR1cm4gY2IoJnpvbmUsIGlkeCwgZGF0YSk7Cj4+ICB9Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgvYmxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCj4+
IGluZGV4IDBjNDlhNGIyY2U1ZC4uMmU0M2EwMGUzNDI1IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRl
L3VhcGkvbGludXgvYmxrem9uZWQuaAo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9u
ZWQuaAo+PiBAQCAtODIsNiArODIsMTYgQEAgZW51bSBibGtfem9uZV9yZXBvcnRfZmxhZ3Mgewo+
PiAgCUJMS19aT05FX1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAo+PiAgfTsKPj4KPj4gKy8qKgo+
PiArICogWm9uZSBBdHRyaWJ1dGVzCj4KPlRoaXMgaXMgYSB1c2VyIGludGVyZmFjZSBmaWxlLiBQ
bGVhc2UgZG9jdW1lbnQgdGhlIG1lYW5pbmcgb2YgZWFjaCBhdHRyaWJ1dGUuCj4KClN1cmUuCgo+
PiArICovCj4+ICtlbnVtIGJsa196b25lX2F0dHIgewo+PiArCUJMS19aT05FX0FUVFJfWkZDCT0g
MSA8PCAwLAo+PiArCUJMS19aT05FX0FUVFJfRlpSCT0gMSA8PCAxLAo+PiArCUJMS19aT05FX0FU
VFJfUlpSCT0gMSA8PCAyLAo+PiArCUJMS19aT05FX0FUVFJfWkRFVgk9IDEgPDwgNywKPlRoZXNl
IGFyZSBaTlMgc3BlY2lmaWMsIHJpZ2h0ID8gSW50ZWdyYXRpbmcgdGhlIDIgWkJDL1pBQyBhdHRy
aWJ1dGVzIGluIHRoaXMKPmxpc3Qgd291bGQgYmUgbmljZSwgbmFtZWx5IG5vbl9zZXEgYW5kIHJl
c2V0LiBUaGF0IHdpbGwgaW1wbHkgcGF0Y2hpbmcgc2QuYy4KPgoKT2YgY291cnNlLiBJIHdpbGwg
bG9vayBhdCBub25fc2VxIGFuZCByZXNldC4gQW55IG90aGVyIHRoYXQgc2hvdWxkIGdvCmluIGhl
cmU/Cgo+PiArfTsKPj4gKwo+PiAgLyoqCj4+ICAgKiBzdHJ1Y3QgYmxrX3pvbmUgLSBab25lIGRl
c2NyaXB0b3IgZm9yIEJMS1JFUE9SVFpPTkUgaW9jdGwuCj4+ICAgKgo+PiBAQCAtMTA4LDcgKzEx
OCw4IEBAIHN0cnVjdCBibGtfem9uZSB7Cj4+ICAJX191OAljb25kOwkJLyogWm9uZSBjb25kaXRp
b24gKi8KPj4gIAlfX3U4CW5vbl9zZXE7CS8qIE5vbi1zZXF1ZW50aWFsIHdyaXRlIHJlc291cmNl
cyBhY3RpdmUgKi8KPj4gIAlfX3U4CXJlc2V0OwkJLyogUmVzZXQgd3JpdGUgcG9pbnRlciByZWNv
bW1lbmRlZCAqLwo+PiAtCV9fdTgJcmVzdls0XTsKPj4gKwlfX3U4CWF0dHI7CQkvKiBab25lIGF0
dHJpYnV0ZXMgKi8KPj4gKwlfX3U4CXJlc3ZbM107Cj4+ICAJX191NjQJY2FwYWNpdHk7CS8qIFpv
bmUgY2FwYWNpdHkgaW4gbnVtYmVyIG9mIHNlY3RvcnMgKi8KPj4gIAlfX3U4CXJlc2VydmVkWzI0
XTsKPj4gIH07Cj4+Cj4KPllvdSBhcmUgbWlzc2luZyBhIEJMS19aT05FX1JFUF9BVFRSIHJlcG9y
dCBmbGFnIHRvIGluZGljYXRlIHRvIHRoZSB1c2VyIHRoYXQgdGhlCj5hdHRyIGZpZWxkIGlzIHBy
ZXNlbnQsIHVzZWQgYW5kIHZhbGlkLgo+Cj5lbnVtIGJsa196b25lX3JlcG9ydF9mbGFncyB7Cj4g
CUJMS19aT05FX1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAo+KwlCTEtfWk9ORV9SRVBfQVRUUgk9
ICgxIDw8IDEpLAo+IH07Cj4KPmlzIEkgdGhpbmsgbmVlZGVkLgoKR29vZCBwb2ludC4gSSB3aWxs
IGFkZCB0aGF0IG9uIGEgVjIuCgpKYXZpZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
