Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11637C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 06:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB16B206F1
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 06:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c/NKAiww";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="UT7SqyQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB16B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DkWvqQQb7oIshZVKY1UTNErM99WqriaAaUKCC483RAs=; b=c/NKAiww+xCZr4UYJKv2mVR4q
	4101aCnOpwSpHP9JmuLhuLWKa1pdgYk3Ci90MBPbfgo+luPTDkr/GKQZuxXWw2mx6sXjDjeqlWeof
	2KEisfmlYAX4BAM7Z9NEY9PsdYVjPPr8+UN8uWMLlfJsYeg3lgo2hctxtoDflHglRIO2K50xZv3I8
	Sxdml7ngmIO3TM6vf4ooMVfnfY8287PDaHFcFKXDx9+70qVAQWLYgBAJeHMgvpmBRCSs3VVxUlUbj
	3OQ5zitQiGUNC40wp8AArE58giY+/CRPsJIIPDOfqBNYsEvgimGs78MLsZvX8IE6V+VXPu4KT26d1
	W3TOxJysA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlROu-0004AT-L7; Wed, 17 Jun 2020 06:18:20 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlROr-00049e-8h
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 06:18:18 +0000
Received: by mail-ej1-x644.google.com with SMTP id f7so1002920ejq.6
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=OwY3Pi3Y2m/cslIRUdM6gQylau0fFLxBokRuP5QyBxU=;
 b=UT7SqyQqsRi6AB8xwZliU/sOeMTg8kTk2GGeTGd1rb6Z2TrusMlr0LiTeANXvWjB8J
 cmBJ7wlimAuZLlPOwkbPbBwj/5PLXM7loBtNSQrqgofcie+XSSdTZQTOCQE6dDT4zNpO
 RuABj0rXmrjdEMVAPZqZPeXBsA7+aXN3LSoz/hXeCuXoIZ7J5bWzhOtDokarUE0d3n8G
 iAE6WefjFz3EkXdtYO2EOZmrbNgRVRxh3uLf2u3Q4Kk5U9ZzRB+7s0JlbC6l+qyA4W1H
 fpt2vs72bKY0ZkGgrZXtk1wxhtF3WOAkXwuZJXvdKNZINBMZu0pADgdCi9JAQ1iFHiQt
 5OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OwY3Pi3Y2m/cslIRUdM6gQylau0fFLxBokRuP5QyBxU=;
 b=kWa3Mo7WNSGE0LtTrWho+Bj6fEMHBxYHKUnyWe/d+YcZcAAQqFwyMRY/mOTGutpABQ
 zoP3ybEITy9xtmlllq6h6z8kf9iznt6BNliyMVrTlfKNMrxrM2n2u5Ta9S/Y3POA/NS/
 Z0ql53XRdO8AJk6rvjYR8UQ6lYG6Ud5iKs8+1DOzKFiuCeIPM0B95fr+uhr3QbeGx9Yp
 urHiUwciDZTy5CJJV1gaR4WN8S5Uqsbzf5Y/yhJVtvNMuIUdRqYVlyvvDcnPBvN4RX1I
 lX3piq/6Gjk5dow6H11rKZEeIbXYwtfo7nE+ulcrtrzs6wPTQtbZOf1+OjmDzdWTBD8E
 gf3g==
X-Gm-Message-State: AOAM5305VO5F4+zrtRJTkB7Xnzn2UdTEFtv9CNrSoZyVS++WcYEvt3JA
 DlWJplSVRiVMKXSOZEjMlNugaw==
X-Google-Smtp-Source: ABdhPJzLtetu863KvnlKLBrTGSqRFO2yUqL8EGy9MwbEhuAgZkK2OfAGRND7zfsSiWrUmUqPJo+J0A==
X-Received: by 2002:a17:906:6dcd:: with SMTP id
 j13mr5769660ejt.131.1592374695799; 
 Tue, 16 Jun 2020 23:18:15 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id l8sm12717319ejz.52.2020.06.16.23.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 23:18:14 -0700 (PDT)
Date: Wed, 17 Jun 2020 08:18:14 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
References: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_231817_309553_C9E2B306 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTcuMDYuMjAyMCAwMDozOCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzE3
IDE6MTMsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+IE9uIDE2LjA2LjIwMjAgMDk6MDcsIEtl
aXRoIEJ1c2NoIHdyb3RlOgo+Pj4gT24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgMDU6NTU6MjZQTSAr
MDIwMCwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+PiBPbiAxNi4wNi4yMDIwIDA4OjQ4LCBL
ZWl0aCBCdXNjaCB3cm90ZToKPj4+Pj4gT24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgMDU6MDI6MTdQ
TSArMDIwMCwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+Pj4+IFRoaXMgZGVwZW5kcyB2ZXJ5
IG11Y2ggb24gaG93IHRoZSBGUyAvIGFwcGxpY2F0aW9uIGlzIG1hbmFnaW5nCj4+Pj4+PiBzdHJp
cHBpbmcuIEF0IHRoZSBtb21lbnQgb3VyIG1haW4gdXNlIGNhc2UgaXMgZW5hYmxpbmcgdXNlci1z
cGFjZQo+Pj4+Pj4gYXBwbGljYXRpb25zIHN1Ym1pdHRpbmcgSS9PcyB0byByYXcgWk5TIGRldmlj
ZXMgdGhyb3VnaCB0aGUga2VybmVsLgo+Pj4+Pj4KPj4+Pj4+IENhbiB3ZSBlbmFibGUgdGhpcyB1
c2UgY2FzZSB0byBzdGFydCB3aXRoPwo+Pj4+Pgo+Pj4+PiBJIHRoaW5rIHRoaXMgYWxyZWFkeSBw
cm92aWRlcyB0aGF0LiBZb3UgY2FuIHNldCB0aGUgbnNpZCB2YWx1ZSB0bwo+Pj4+PiB3aGF0ZXZl
ciB5b3Ugd2FudCBpbiB0aGUgcGFzc3Rocm91Z2ggaW50ZXJmYWNlLCBzbyBhIG5hbWVzcGFjZSBi
bG9jawo+Pj4+PiBkZXZpY2UgaXMgbm90IHJlcXVpcmVkIHRvIGlzc3VlIEkvTyB0byBhIFpOUyBu
YW1lc3BhY2UgZnJvbSB1c2VyIHNwYWNlLgo+Pj4+Cj4+Pj4gTW1tbW0uIFByb2JsZW0gbm93IGlz
IHRoYXQgdGhlIGNoZWNrIG9uIHRoZSBudm1lIGRyaXZlciBwcmV2ZW50cyB0aGUgWk5TCj4+Pj4g
bmFtZXNwYWNlIGZyb20gYmVpbmcgaW5pdGlhbGl6ZWQuIEFtIEkgbWlzc2luZyBzb21ldGhpbmc/
Cj4+Pgo+Pj4gSG0sIG9rYXksIGl0IG1heSBub3Qgd29yayBmb3IgeW91LiBXZSBuZWVkIHRoZSBk
cml2ZXIgdG8gY3JlYXRlIGF0IGxlYXN0Cj4+PiBvbmUgbmFtZXNwYWNlIHNvIHRoYXQgd2UgaGF2
ZSB0YWdzIGFuZCByZXF1ZXN0X3F1ZXVlLiBJZiB5b3UgaGF2ZSB0aGF0LAo+Pj4geW91IGNhbiBp
c3N1ZSBJTyB0byBhbnkgb3RoZXIgYXR0YWNoZWQgbmFtZXNwYWNlIHRocm91Z2ggdGhlIHBhc3N0
aHJvdWdoCj4+PiBpbnRlcmZhY2UsIGJ1dCB3ZSBjYW4ndCBhc3N1bWUgdGhlcmUgaXMgYW4gYXZh
aWxhYmxlIG5hbWVzcGFjZS4KPj4KPj4gVGhhdCBtYWtlcyBzZW5zZSBmb3Igbm93Lgo+Pgo+PiBU
aGUgbmV4dCBzdGVwIGZvciB1cyBpcyB0byBlbmFibGUgYSBwYXNzdGhyb3VnaCBvbiB1cmluZywg
bWFraW5nIHN1cmUKPj4gdGhhdCBJL09zIGRvIG5vdCBzcGxpdC4KPgo+UGFzc3Rocm91Z2ggYXMg
aW4gImFwcGxpY2F0aW9uIGlzc3VlcyBkaXJlY3RseSBOVk1lIGNvbW1hbmRzIiBsaWtlIGZvciBT
R19JTwo+d2l0aCBTQ1NJID8gT3IgZG8geW91IG1lYW4gcmF3IGJsb2NrIGRldmljZSBmaWxlIGFj
Y2Vzc2VzIGJ5IHRoZSBhcHBsaWNhdGlvbiwKPm1lYW5pbmcgdGhhdCB0aGUgSU8gZ29lcyB0aHJv
dWdoIHRoZSBibG9jayBJTyBzdGFjayBhcyBvcHBvc2VkIHRvIGRpcmVjdGx5IGdvaW5nCj50byB0
aGUgZHJpdmVyID8KPgo+Rm9yIHRoZSBsYXR0ZXIgY2FzZSwgSSBkbyBub3QgdGhpbmsgaXQgaXMg
cG9zc2libGUgdG8gZ3VhcmFudGVlIHRoYXQgYW4gSU8gd2lsbAo+bm90IGdldCBzcGxpdCB1bmxl
c3Mgd2UgYXJlIHRhbGtpbmcgYWJvdXQgc2luZ2xlIHBhZ2UgSU9zIChlLmcuIDRLIG9uIFg4Niku
IFNlZQo+YSBzb21ld2hhdCBzaW1pbGFyIHJlcXVlc3QgaGVyZSBhbmQgY29tbWVudHMgYWJvdXQg
aXQuCj4KPmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWJsb2NrL21zZzU1MDc5
Lmh0bWwKCkF0IHRoZSBtb21lbnQgd2UgYXJlIGRvaW5nIHRoZSBmb3JtZXIsIGJ1dCBpdCBsb29r
cyBsaWtlIGEgaGFjayB0byBtZSB0bwpnbyBkaXJlY3RseSB0byB0aGUgTlZNZSBkcml2ZXIuCgpJ
IHdhcyB0aGlua2luZyB0aGF0IHdlIGNvdWxkIGVuYWJsZSB0aGUgc2Vjb25kIHBhdGggYnkgbWFr
aW5nIHVzZSBvZgpjaHVua19zZWN0b3JzIGFuZCBsaW1pdCB0aGUgSS9PIHNpemUganVzdCBhcyB0
aGUgYXBwZW5kX21heF9pb19zaXplCmRvZXMuIElzIHRoaXMgdGhlIGNvbXBsZXRlIHdyb25nIHdh
eSBvZiBsb29raW5nIGF0IGl0PwoKVGhhbmtzLApKYXZpZXIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
