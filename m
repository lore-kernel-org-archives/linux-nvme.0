Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B14C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:25:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF2620791
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UCPl/n9o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hLm4yuYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="wjlyKHfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2620791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rd0tER8SH97MfkSk83dbXd0AoV40qLggnM0XZQ1ubqk=; b=UCPl/n9oU8QcpT7WU1pmsgyB7
	kR2Mi2irMkRcXH/LttvMEIXTykU5L/Z86k4mDTujCK+gOLUTUKlfr0/z7Zwrx0rzqnVFbR7np9yHN
	0OXRcUrsoRvhRNeUmv4eNaAXHOc1dgC1E6IX6hxhbD/AuwT3F77eUZnhBwkOAaURt5krcMhZxMYBg
	3CNC/b4YRsGtLQHIOxuT6qtXkR/2ETvfgbNPgbvSre7UVJCaIZ8X2xZL8z064ycpi05R7ZDF0sUL5
	jXUOFvS6WjKugWoHJDgFYSqSuyHXwJpFkYi56mBiYUZi0vEjcPy4PgrJsRWwMS2PaOiN34zgUeCBu
	VonGxhSRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomTb-0001qL-1N; Fri, 26 Jun 2020 11:24:59 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolEi-0000bm-NY
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=liOwZzMMqZUggalO/Lz6IGxFUJ8BgySWL76nB2HtWX0=; b=hLm4yuYil/BygzdGfCpynXRaBX
 P5Nqk2Lhxa7auqUUrDOeG1GWLCRdAqHxRKh2Dz/nZBoW6TJzLGsIGz4Qq82MY1WTqujkdWLgN0iXk
 eqbvFPcQa6uW62BAsNliVZouKvH2xzNWL+GqC0bqjxn35UoZPj6YvChHL2KqZuWa3of8RyAZ0hkqn
 f3SlI9Mo9GOvFERbnqr6SsiIFZF6t1ZOFXVSiXIjRTybztENQH+Q8iqCGlmrHzNcrCeYFIVKhcIwC
 GQ1AE83yhWwY6by6f3cFz07g7xsVyc0dZdnVLBCYzRFTPOZU1KLjaBVDVU2WD1gARFKCf49YFp5d2
 R5h/NZ3w==;
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokxD-0006Tt-Lg
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:47:46 +0000
Received: by mail-lj1-x243.google.com with SMTP id q19so9664592lji.2
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=liOwZzMMqZUggalO/Lz6IGxFUJ8BgySWL76nB2HtWX0=;
 b=wjlyKHfPYvQPJeLkTSWgrYeCxZU/Qq8z9rrL22++KnyShAXc2KZnR+pxj/DSVNVjjE
 DOzOCimisJCmisN4R4ffVvYMr7Hbt9WTC28y51Po+g4XqxrXb0uukDMitBe25OviipPQ
 pRbsRh/vqcOs0rOiUn9+d9tXFMEsOQTXh6gA1RtbviR6MuZ0Wd6zShtsHMUtCNWXWgsU
 byszuso5LOzjh3IHGK8ZEdm9SnK/ggvFcxGlRhUXk+YCNgPUGns3wj7i32RlwH1SEmoG
 u2Wii2NX+mfcAUk3jbRWuksPRyX878ZvnW4/21ICd/TnFvhXU7uaHNy5YT7Uw3fkYUtJ
 kuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=liOwZzMMqZUggalO/Lz6IGxFUJ8BgySWL76nB2HtWX0=;
 b=g5mCydXIsJIFik74RWXb6Hhk5AMQJjk03kjJS3eS3G8vYJ/eR6iBDlEMHuFKDQD1wq
 Hyrces3A0THZb3uPHYV98W1nKI3D5esMEm3kQIyN3L3w5bLOdYvPJY3LJF85TGNjk6eM
 zYgLfFCgxQPwwHcHh7GpiBYuwklTNxI1MMqSqafwqM+ZwLj4DxDgS9FLCtLfUEwJmesX
 9j/4udfTVWkAoVl9e5uEaXOPEGCMw721Ckvla6/5/HeC3GiVktJNpAtJ/0EU1ZJURxyw
 je7wbyc1HS01PjLK2it3mSw5GQtjBIUvLc/wYdJk62s3kMOpGemzo9Q+2FsHtEV9AuXp
 /N3g==
X-Gm-Message-State: AOAM532urs1N4HtPYx67Qb4su9CadHqvFc1vZezuNrdn5wV0lr15J/GY
 qVSrmot+J2rbAJFq+N03SDDMK/RkE1InxwX/
X-Google-Smtp-Source: ABdhPJxz3l9GB2Y/unyJL6AYdroyYULWO9zO0Lmp+hMnpt+PTXp5pDzv+4VhOqoUY7poxM6J6EyZLg==
X-Received: by 2002:a50:c90d:: with SMTP id o13mr1761616edh.338.1593151311775; 
 Thu, 25 Jun 2020 23:01:51 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id k23sm18360776ejo.120.2020.06.25.23.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:01:50 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:01:50 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Message-ID: <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_104727_975983_CC0A016D 
X-CRM114-Status: GOOD (  20.61  )
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

T24gMjYuMDYuMjAyMCAwMToxNywgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI1
IDIxOjIyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gVGhlIGN1cnJlbnQgSU9DVEwgaW50ZXJm
YWNlIGZvciB6b25lIG1hbmFnZW1lbnQgaXMgbGltaXRlZCBieSBzdHJ1Y3QKPj4gYmxrX3pvbmVf
cmFuZ2UsIHdoaWNoIGlzIHVuZm9ydHVuYXRlbHkgbm90IGV4dGVuc2libGUuIFNwZWNpYWxseSwg
dGhlCj4+IGxhY2sgb2YgZmxhZ3MgaXMgcHJvYmxlbWF0aWMgZm9yIFpOUyB6b25lZCBkZXZpY2Vz
Lgo+Pgo+PiBUaGlzIG5ldyBJT0NUTCBpcyBkZXNpZ25lZCB0byBiZSBhIHN1cGVyc2V0IG9mIHRo
ZSBjdXJyZW50IG9uZSwgd2l0aAo+PiBzdXBwb3J0IGZvciBmbGFncyBhbmQgYml0cyBmb3IgZXh0
ZW5zaWJpbGl0eS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVy
LmdvbnpAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFNlbHZhS3VtYXIgUyA8c2VsdmFr
dW1hLnMxQHNhbXN1bmcuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuIEpvc2hpIDxqb3No
aS5rQHNhbXN1bmcuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXRlc2ggU2hldHR5IDxuai5zaGV0
dHlAc2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiAgYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAg
fCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiAgYmxvY2svaW9jdGwu
YyAgICAgICAgICAgICAgICAgfCAgMiArKwo+PiAgaW5jbHVkZS9saW51eC9ibGtkZXYuaCAgICAg
ICAgfCAgOSArKysrKysKPj4gIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIHwgMzMgKysr
KysrKysrKysrKysrKysrKysrCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDk5IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxv
Y2svYmxrLXpvbmVkLmMKPj4gaW5kZXggODExNTJhMjYwMzU0Li5lODdjNjAwMDRkYzUgMTAwNjQ0
Cj4+IC0tLSBhL2Jsb2NrL2Jsay16b25lZC5jCj4+ICsrKyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+
IEBAIC0zMjIsNyArMzIyLDcgQEAgaW50IGJsa2Rldl9yZXBvcnRfem9uZXNfaW9jdGwoc3RydWN0
IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLAo+PiAgICogQkxLUkVTRVRaT05FLCBC
TEtPUEVOWk9ORSwgQkxLQ0xPU0VaT05FIGFuZCBCTEtGSU5JU0haT05FIGlvY3RsIHByb2Nlc3Np
bmcuCj4+ICAgKiBDYWxsZWQgZnJvbSBibGtkZXZfaW9jdGwuCj4+ICAgKi8KPj4gLWludCBibGtk
ZXZfem9uZV9tZ210X2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9k
ZSwKPj4gK2ludCBibGtkZXZfem9uZV9vcHNfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRl
diwgZm1vZGVfdCBtb2RlLAo+PiAgCQkJICAgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9u
ZyBhcmcpCj4+ICB7Cj4+ICAJdm9pZCBfX3VzZXIgKmFyZ3AgPSAodm9pZCBfX3VzZXIgKilhcmc7
Cj4+IEBAIC0zNzAsNiArMzcwLDYwIEBAIGludCBibGtkZXZfem9uZV9tZ210X2lvY3RsKHN0cnVj
dCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4gIAkJCQlHRlBfS0VSTkVMKTsK
Pj4gIH0KPj4KPj4gKy8qCj4+ICsgKiBab25lIG1hbmFnZW1lbnQgaW9jdGwgcHJvY2Vzc2luZy4g
RXh0ZW5zaW9uIG9mIGJsa2Rldl96b25lX29wc19pb2N0bCgpLCB3aXRoCj4+ICsgKiBibGtfem9u
ZV9tZ210IHN0cnVjdHVyZS4KPj4gKyAqCj4+ICsgKiBDYWxsZWQgZnJvbSBibGtkZXZfaW9jdGwu
Cj4+ICsgKi8KPj4gK2ludCBibGtkZXZfem9uZV9tZ210X2lvY3RsKHN0cnVjdCBibG9ja19kZXZp
Y2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4gKwkJCSAgIHVuc2lnbmVkIGludCBjbWQsIHVuc2ln
bmVkIGxvbmcgYXJnKQo+PiArewo+PiArCXZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191c2Vy
ICopYXJnOwo+PiArCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxOwo+PiArCXN0cnVjdCBibGtfem9u
ZV9tZ210IHptZ210Owo+PiArCWVudW0gcmVxX29wZiBvcDsKPj4gKwo+PiArCWlmICghYXJncCkK
Pj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gKwlxID0gYmRldl9nZXRfcXVldWUoYmRldik7
Cj4+ICsJaWYgKCFxKQo+PiArCQlyZXR1cm4gLUVOWElPOwo+PiArCj4+ICsJaWYgKCFibGtfcXVl
dWVfaXNfem9uZWQocSkpCj4+ICsJCXJldHVybiAtRU5PVFRZOwo+PiArCj4+ICsJaWYgKCFjYXBh
YmxlKENBUF9TWVNfQURNSU4pKQo+PiArCQlyZXR1cm4gLUVBQ0NFUzsKPj4gKwo+PiArCWlmICgh
KG1vZGUgJiBGTU9ERV9XUklURSkpCj4+ICsJCXJldHVybiAtRUJBREY7Cj4+ICsKPj4gKwlpZiAo
Y29weV9mcm9tX3VzZXIoJnptZ210LCBhcmdwLCBzaXplb2Yoc3RydWN0IGJsa196b25lX21nbXQp
KSkKPj4gKwkJcmV0dXJuIC1FRkFVTFQ7Cj4+ICsKPj4gKwlzd2l0Y2ggKHptZ210LmFjdGlvbikg
ewo+PiArCWNhc2UgQkxLX1pPTkVfTUdNVF9DTE9TRToKPj4gKwkJb3AgPSBSRVFfT1BfWk9ORV9D
TE9TRTsKPj4gKwkJYnJlYWs7Cj4+ICsJY2FzZSBCTEtfWk9ORV9NR01UX0ZJTklTSDoKPj4gKwkJ
b3AgPSBSRVFfT1BfWk9ORV9GSU5JU0g7Cj4+ICsJCWJyZWFrOwo+PiArCWNhc2UgQkxLX1pPTkVf
TUdNVF9PUEVOOgo+PiArCQlvcCA9IFJFUV9PUF9aT05FX09QRU47Cj4+ICsJCWJyZWFrOwo+PiAr
CWNhc2UgQkxLX1pPTkVfTUdNVF9SRVNFVDoKPj4gKwkJb3AgPSBSRVFfT1BfWk9ORV9SRVNFVDsK
Pj4gKwkJYnJlYWs7Cj4+ICsJZGVmYXVsdDoKPj4gKwkJcmV0dXJuIC1FTk9UVFk7Cj4+ICsJfQo+
PiArCj4+ICsJcmV0dXJuIGJsa2Rldl96b25lX21nbXQoYmRldiwgb3AsIHptZ210LnNlY3Rvciwg
em1nbXQubnJfc2VjdG9ycywKPj4gKwkJCQlHRlBfS0VSTkVMKTsKPj4gK30KPj4gKwo+PiAgc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBsb25nICpibGtfYWxsb2Nfem9uZV9iaXRtYXAoaW50IG5vZGUs
Cj4+ICAJCQkJCQkgICB1bnNpZ25lZCBpbnQgbnJfem9uZXMpCj4+ICB7Cj4+IGRpZmYgLS1naXQg
YS9ibG9jay9pb2N0bC5jIGIvYmxvY2svaW9jdGwuYwo+PiBpbmRleCBiZGIzYmJiMjUzZDkuLjBl
YTI5NzU0ZTdkZCAxMDA2NDQKPj4gLS0tIGEvYmxvY2svaW9jdGwuYwo+PiArKysgYi9ibG9jay9p
b2N0bC5jCj4+IEBAIC01MTQsNiArNTE0LDggQEAgc3RhdGljIGludCBibGtkZXZfY29tbW9uX2lv
Y3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4gIAljYXNlIEJM
S09QRU5aT05FOgo+PiAgCWNhc2UgQkxLQ0xPU0VaT05FOgo+PiAgCWNhc2UgQkxLRklOSVNIWk9O
RToKPj4gKwkJcmV0dXJuIGJsa2Rldl96b25lX29wc19pb2N0bChiZGV2LCBtb2RlLCBjbWQsIGFy
Zyk7Cj4+ICsJY2FzZSBCTEtNR01UWk9ORToKPj4gIAkJcmV0dXJuIGJsa2Rldl96b25lX21nbXRf
aW9jdGwoYmRldiwgbW9kZSwgY21kLCBhcmcpOwo+PiAgCWNhc2UgQkxLR0VUWk9ORVNaOgo+PiAg
CQlyZXR1cm4gcHV0X3VpbnQoYXJncCwgYmRldl96b25lX3NlY3RvcnMoYmRldikpOwo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgK
Pj4gaW5kZXggOGZkOTAwOTk4YjRlLi5iZDg1MjFmOTRkYzQgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1
ZGUvbGludXgvYmxrZGV2LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAo+PiBAQCAt
MzY4LDYgKzM2OCw4IEBAIGludCBibGtfcmV2YWxpZGF0ZV9kaXNrX3pvbmVzKHN0cnVjdCBnZW5k
aXNrICpkaXNrLAo+Pgo+PiAgZXh0ZXJuIGludCBibGtkZXZfcmVwb3J0X3pvbmVzX2lvY3RsKHN0
cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4gIAkJCQkgICAgIHVuc2ln
bmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKTsKPj4gK2V4dGVybiBpbnQgYmxrZGV2X3pv
bmVfb3BzX2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4g
KwkJCQkgIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKTsKPj4gIGV4dGVybiBp
bnQgYmxrZGV2X3pvbmVfbWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9k
ZV90IG1vZGUsCj4+ICAJCQkJICB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7
Cj4+Cj4+IEBAIC0zODUsNiArMzg3LDEzIEBAIHN0YXRpYyBpbmxpbmUgaW50IGJsa2Rldl9yZXBv
cnRfem9uZXNfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwKPj4gIAlyZXR1cm4gLUVO
T1RUWTsKPj4gIH0KPj4KPj4gKwo+PiArc3RhdGljIGlubGluZSBpbnQgYmxrZGV2X3pvbmVfb3Bz
X2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4gKwkJCQkJ
dW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpCj4+ICt7Cj4+ICsJcmV0dXJuIC1F
Tk9UVFk7Cj4+ICt9Cj4+ICsKPj4gIHN0YXRpYyBpbmxpbmUgaW50IGJsa2Rldl96b25lX21nbXRf
aW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwKPj4gIAkJCQkJIGZtb2RlX3QgbW9kZSwg
dW5zaWduZWQgaW50IGNtZCwKPj4gIAkJCQkJIHVuc2lnbmVkIGxvbmcgYXJnKQo+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmggYi9pbmNsdWRlL3VhcGkvbGludXgv
Ymxrem9uZWQuaAo+PiBpbmRleCA0MmMzMzY2Y2MyNWYuLjA3YjVmZGUyMWQ5ZiAxMDA2NDQKPj4g
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPj4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L2Jsa3pvbmVkLmgKPj4gQEAgLTE0Miw2ICsxNDIsMzggQEAgc3RydWN0IGJsa196b25l
X3JhbmdlIHsKPj4gIAlfX3U2NAkJbnJfc2VjdG9yczsKPj4gIH07Cj4+Cj4+ICsvKioKPj4gKyAq
IGVudW0gYmxrX3pvbmVfYWN0aW9uIC0gWm9uZSBzdGF0ZSB0cmFuc2l0aW9ucyBtYW5hZ2VkIGZy
b20gdXNlci1zcGFjZQo+PiArICoKPj4gKyAqIEBCTEtfWk9ORV9NR01UX0NMT1NFOiBUcmFuc2l0
aW9uIHRvIENsb3NlZCBzdGF0ZQo+PiArICogQEJMS19aT05FX01HTVRfRklOSVNIOiBUcmFuc2l0
aW9uIHRvIEZpbmlzaCBzdGF0ZQo+PiArICogQEJMS19aT05FX01HTVRfT1BFTjogVHJhbnNpdGlv
biB0byBPcGVuIHN0YXRlCj4+ICsgKiBAQkxLX1pPTkVfTUdNVF9SRVNFVDogVHJhbnNpdGlvbiB0
byBSZXNldCBzdGF0ZQo+PiArICovCj4+ICtlbnVtIGJsa196b25lX2FjdGlvbiB7Cj4+ICsJQkxL
X1pPTkVfTUdNVF9DTE9TRQk9IDB4MSwKPj4gKwlCTEtfWk9ORV9NR01UX0ZJTklTSAk9IDB4MiwK
Pj4gKwlCTEtfWk9ORV9NR01UX09QRU4JPSAweDMsCj4+ICsJQkxLX1pPTkVfTUdNVF9SRVNFVAk9
IDB4NCwKPj4gK307Cj4+ICsKPj4gKy8qKgo+PiArICogc3RydWN0IGJsa196b25lX21nbXQgLSBF
eHRlbmRlZCB6b25lZCBtYW5hZ2VtZW50Cj4+ICsgKgo+PiArICogQGFjdGlvbjogWm9uZSBhY3Rp
b24gYXMgaW4gZGVzY3JpYmVkIGluIGVudW0gYmxrX3pvbmVfYWN0aW9uCj4+ICsgKiBAZmxhZ3M6
IEZsYWdzIGZvciB0aGUgYWN0aW9uCj4+ICsgKiBAc2VjdG9yOiBTdGFydGluZyBzZWN0b3Igb2Yg
dGhlIGZpcnN0IHpvbmUgdG8gb3BlcmF0ZSBvbgo+PiArICogQG5yX3NlY3RvcnM6IFRvdGFsIG51
bWJlciBvZiBzZWN0b3JzIG9mIGFsbCB6b25lcyB0byBvcGVyYXRlIG9uCj4+ICsgKi8KPj4gK3N0
cnVjdCBibGtfem9uZV9tZ210IHsKPj4gKwlfX3U4CQlhY3Rpb247Cj4+ICsJX191OAkJcmVzdjNb
M107Cj4+ICsJX191MzIJCWZsYWdzOwo+PiArCV9fdTY0CQlzZWN0b3I7Cj4+ICsJX191NjQJCW5y
X3NlY3RvcnM7Cj4+ICsJX191NjQJCXJlc3YzMTsKPj4gK307Cj4+ICsKPj4gIC8qKgo+PiAgICog
Wm9uZWQgYmxvY2sgZGV2aWNlIGlvY3RsJ3M6Cj4+ICAgKgo+PiBAQCAtMTY2LDUgKzE5OCw2IEBA
IHN0cnVjdCBibGtfem9uZV9yYW5nZSB7Cj4+ICAjZGVmaW5lIEJMS09QRU5aT05FCV9JT1coMHgx
MiwgMTM0LCBzdHJ1Y3QgYmxrX3pvbmVfcmFuZ2UpCj4+ICAjZGVmaW5lIEJMS0NMT1NFWk9ORQlf
SU9XKDB4MTIsIDEzNSwgc3RydWN0IGJsa196b25lX3JhbmdlKQo+PiAgI2RlZmluZSBCTEtGSU5J
U0haT05FCV9JT1coMHgxMiwgMTM2LCBzdHJ1Y3QgYmxrX3pvbmVfcmFuZ2UpCj4+ICsjZGVmaW5l
IEJMS01HTVRaT05FCV9JT1IoMHgxMiwgMTM3LCBzdHJ1Y3QgYmxrX3pvbmVfbWdtdCkKPj4KPj4g
ICNlbmRpZiAvKiBfVUFQSV9CTEtaT05FRF9IICovCj4+Cj4KPldpdGhvdXQgZGVmaW5pbmcgd2hh
dCB0aGUgZmxhZ3MgY2FuIGJlLCBpdCBpcyBoYXJkIHRvIGp1ZGdlIHdoYXQgd2lsbCBjaGFuZ2UK
PmZyb20gdGhlIGN1cnJlbnQgZGlzdGluY3QgaW9jdGxzLgo+CgpUaGUgZmlyc3QgZmxhZyBpcyB0
aGUgb25lIHRvIHNlbGVjdCBhbGwuIERvd24gdGhlIGxpbmUgd2UgaGF2ZSBvdGhlcgptb2RpZmll
cnMgdGhhdCBtYWtlIHNlbnNlLCBidXQgaXQgaXMgdHJ1ZSB0aGF0IGl0IGlzIHB1YmxpYyB5ZXQu
CgpXb3VsZCB5b3UgbGlrZSB0byB3YWl0IHVudGlsIHRoZW4gb3IgaXMgaXQgYW4gb3B0aW9uIHRv
IHJldmlzZSB0aGUgSU9DVEwKbm93PwoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
