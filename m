Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392FC4741F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:22:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF2020719
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gfDFbUWx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="rzD1v0/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF2020719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:References:Message-Id:Date:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pbdz+i68NDEQeZT71J6++y2MIyW/C2G/jPinfOhIrfs=; b=gfDFbUWxYM1jXpKfErhPcZori
	fdQxvtrM5GU44GdaoXzg5y9SnOmAaMnWMSISHhPRAzStkYffVMHeOonxyGfFACJJ+nmwD9a1bMUqe
	hds7rHsms/mRWOb2zXdr3tXaMKpoAt+5TiWyHqkhEZV68pr+aC2luw6zIR9Jhe301RbK/7o5x5BSw
	kT6q9FmevW07MUmnXPm4Mbt1Ymat5jxPlXKLx+z1IjS9/RjjQnllvVCu3FL+YFnfKz3PnvvXfXSt+
	oc10vpBjVPzvlOHdxUIk3heH/X2rZOfZnpF72kmsiLxMIyKXqo2O9IKwx73vzcW6HugBviLecbCHz
	+7WoG8hJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb2cw-0003vh-Qc; Fri, 06 Nov 2020 14:22:06 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb2ct-0003ux-VG
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 14:22:04 +0000
Received: by mail-lj1-x243.google.com with SMTP id l10so1552991lji.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=jqG0hrKmGlo514JQJQCOny84aPmId67veaaqw3tzZUw=;
 b=rzD1v0/dkvhBfGd3GzlELnU/N4vWkcjupZ9gCbarCgeBRc7dT1B9kcpJRrsuAViLkw
 9+iDEim8U5tst8yqUmzyRtGFMJ7D2sx9CwKN10RXhx/V1WGv4wWCNB1BiYXZQ5JK3zo2
 1Sajd8jYYJnHdDMTSeMPt+pdcw9Yk+Mhi3Au2mwgsdyCB7x2TA8yOXFTg7nSkwFPk0jD
 P0Mb1LswL9e4Cdf+M304lLMO9SPX4tsB0VGYYlU4VcMZZQrZoqOFDEDjJubLmyxzuAc5
 h1z06OHN5SFGgQzje89AsuudNJwYNcs+ojh+/hG0HXvNB3FtduBBodyKWxsCTK6/5Uft
 AqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=jqG0hrKmGlo514JQJQCOny84aPmId67veaaqw3tzZUw=;
 b=STHBLXdNHJfui/89IJ0MVFInAt5YT9QNLJc88/9H5jOGZyq7IrmVo7rGdiMITyksjg
 bNyBHIb/FeJKs46iFTAfNYbjYI0HCLaEScmqFN62qclxDSgyYQeRxgYV70CHoMBTrnDd
 9YRZhGK77/fu6b5Tpjw9gudDDZGxWF1afM1PIK6CrOMl9gYrejYsaCLmVl1V3gwAh58j
 7LJ9lSPhIy5TiDNcjVZvns1oeL2c7yX226zyJTaX9MHp9VwmuVEnQysz6s+M1bWjN+hq
 FqFQmviNILr9wQf9xf9MhX7acHZYjrH+Ng6cnVjqvya/ZL6WDjNX22C6qz29tF6+mGni
 UMCg==
X-Gm-Message-State: AOAM531cayY6RWGZ26U8m3wYYsmUXwibpFRlLd3R725eAoJz8cBQ7umC
 vVyrp8GsGt/PSxOA8Qu/o3HKhoaxU0Jh1pR3
X-Google-Smtp-Source: ABdhPJyjuuBNSG4p3jDrXJ8X24jmGIbior8qmhO4xpP7Z8t6C/zyHt+VZKAQIM6sN+xyGCyN3ZRtdg==
X-Received: by 2002:a2e:874a:: with SMTP id q10mr917611ljj.446.1604672521925; 
 Fri, 06 Nov 2020 06:22:01 -0800 (PST)
Received: from ?IPv6:2a02:aa7:460f:ff9e:4554:dd33:6596:f69f?
 ([2a02:aa7:460f:ff9e:4554:dd33:6596:f69f])
 by smtp.gmail.com with ESMTPSA id l8sm184843lfc.50.2020.11.06.06.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:22:01 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme: enable ro namespace for ZNS without append
Date: Fri, 6 Nov 2020 15:22:00 +0100
Message-Id: <36113018-83A0-4804-A077-F8C25FF3E913@javigon.com>
References: <20201106141428.GA23884@lst.de>
In-Reply-To: <20201106141428.GA23884@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (18A8395)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_092204_156967_8721F93E 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: axboe@kernel.dk, niklas.cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIDYgTm92IDIwMjAsIGF0IDE1LjE0LCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4gd3JvdGU6Cj4gCj4g77u/Cj4+IAo+PiArI2lmZGVmIENPTkZJR19CTEtfREVWX1pPTkVECj4+
ICsgICAgaWYgKGJsa19xdWV1ZV9pc196b25lZChkaXNrLT5xdWV1ZSkgJiYgIW5zLT56b25lZF9u
c19zdXBwKQo+PiArICAgICAgICBzZXRfZGlza19ybyhkaXNrLCB0cnVlKTsKPj4gKyNlbmRpZgo+
IAo+IEkgdGhpbmsgd2UgY2FuIHNpbXBsaWZ5IHRoaXMgYXQgYml0LiAgQWRkIGEgbmV3IE5WTUVf
TlNfRk9SQ0VfUk8gZmxhZwo+IHRvIG5zLT5mbGFncywgc2V0IGl0IGluIG52bWVfdXBkYXRlX3pv
bmVfaW5mbywgYW5kIGp1c3QgcXVlcnkgaXQgaGVyZQo+IHdpdGhvdXQgYW55IGlmZGVmcy4KPiAK
Pj4gICAgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBkaXNrLT5xdWV1ZTsKPj4gICAgc3RydWN0
IG52bWVfY29tbWFuZCBjID0geyB9Owo+PiAgICBzdHJ1Y3QgbnZtZV9pZF9uc196bnMgKmlkOwo+
PiArICAgIGJvb2wgem9uZWRfbnNfc3VwcCA9IHRydWU7Cj4+ICAgIGludCBzdGF0dXM7Cj4+IAo+
PiAgICAvKiBEcml2ZXIgcmVxdWlyZXMgem9uZSBhcHBlbmQgc3VwcG9ydCAqLwo+PiAgICBpZiAo
IShsZTMyX3RvX2NwdShsb2ctPmlvY3NbbnZtZV9jbWRfem9uZV9hcHBlbmRdKSAmCj4+ICAgICAg
ICAgICAgTlZNRV9DTURfRUZGRUNUU19DU1VQUCkpIHsKPj4gKyAgICAgICAgem9uZWRfbnNfc3Vw
cCA9IGZhbHNlOwo+PiAgICAgICAgZGV2X3dhcm4obnMtPmN0cmwtPmRldmljZSwKPj4gICAgICAg
ICAgICAiYXBwZW5kIG5vdCBzdXBwb3J0ZWQgZm9yIHpvbmVkIG5hbWVzcGFjZTolZFxuIiwKPj4g
ICAgICAgICAgICBucy0+aGVhZC0+bnNfaWQpOwo+PiArICAgIH0gZWxzZSB7Cj4+ICsgICAgICAg
IC8qIExhemlseSBxdWVyeSBjb250cm9sbGVyIGFwcGVuZCBsaW1pdCBmb3IgdGhlIGZpcnN0Cj4+
ICsgICAgICAgICAqIHpvbmVkIG5hbWVzcGFjZQo+PiArICAgICAgICAgKi8KPj4gKyAgICAgICAg
aWYgKCFucy0+Y3RybC0+bWF4X3pvbmVfYXBwZW5kKSB7Cj4+ICsgICAgICAgICAgICBzdGF0dXMg
PSBudm1lX3NldF9tYXhfYXBwZW5kKG5zLT5jdHJsKTsKPj4gKyAgICAgICAgICAgIGlmIChzdGF0
dXMpCj4+ICsgICAgICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsKPj4gKyAgICAgICAgfQo+IAo+
IFdoaWxlIHlvdSdyZSBhdCBpdDogIG15IGludmVyc2UgdGhlIHBvbGFyaXR5IG9mIHRoZSBpZiBj
aGVjayBhcyB0aGF0IHJlYWRzIGp1c3QKPiBhIGxpdHRsZSBtb3JlIG5hdHVyYWwsIGFuZCBtYXli
ZSBtZW50aW9uIGluIHRoZSB3YXJuaW5nIHRoYXQgdGhlIG5hbWVzcGFjZSBpcwo+IGZvcmNlZCB0
byByZWFkLW9ubHkgbW9kZT8KPiAKPiBPdGhlcndpc2UgdGhpcyBsb29rcyBnb29kLgoKVGhhbmtz
LiBJ4oCZbGwgc2VuZCBhIFYyLiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
