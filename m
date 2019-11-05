Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C02C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 15:45:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB9A2087E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 15:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QY68OD7w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dywZ6FpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB9A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V0R2HgK/7j9zJV+0cPrz6woYC1x5dAg/hPLotGMb1VE=; b=QY68OD7wm8knad
	Np9EyC2aYMa6Zu2ILJAfqoY8bQqoYGrJQX79hwBRY3I0WYvDPFdtWxS5xeV6R1+D3K+LP2ktk9mTj
	eLC6IBZxfFN0fb+F+oqPGi4TgxH/oeMG9NsDO+UMw91HMo1CDI1il4EtSRF4yci2LJH6bIp+NTwP/
	i7Lyk+gbCUPxQOsumdcPa6h7Iojd38NIKHLZMZkeEPvn3ZRgEgZmV2J3bkb5DNaKRAv+WsYDLKSYW
	nbfTZmZCHNifxIb2MCYGlHDvLXNh5FtHhb8YupqHTezTM9+Z9R4R/Tf9UYoKw5xAOH9cXf4rrIWwK
	ZkUh5rYUkkK+o1FDK5hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS116-0004Cl-OL; Tue, 05 Nov 2019 15:45:12 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS113-0003cB-6E
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 15:45:10 +0000
Received: by mail-lj1-x244.google.com with SMTP id 139so22436146ljf.1
 for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2019 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ay+h7c6u74y0NDeAAMw4e9/VcMJ072gLoBrrzIdrw+4=;
 b=dywZ6FpAkymA6khuADv5aozdmj+qm8Ih+0CsbdG53LZ53xAAFb6miFnpuZclfH19JD
 4uHXVPdmZFzYVJoOHJtboVneTqLMx5U8l0+uxQANTMH1Utw/MPrSQy9wvj3EbZ7ZPFBD
 I3Pk8IJcJCibzzyu3G+IrQQudXl0bWdcv+7oKscO3UI6zqbgU8CQZ4EFoEnJQKGbodL9
 vOVmdFAFpiKNoP9Ks/Ivl2orsTYcuwsThyvgDkqyJefqkumjNWscHUCJxxiV/7SKP0QF
 8h1rFJHbrRIL3bSanhznb31tea+zYasdGaxQDaC/5PwDPqzG5xJMVQuLnSOaWaPPTkZX
 P7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ay+h7c6u74y0NDeAAMw4e9/VcMJ072gLoBrrzIdrw+4=;
 b=W9wNxviRJ5pWqBSKk6M5yNAMyo9Kwk2uhTNDgIDbUwSA+0hTkD8PxvW4gIH87qb3SI
 3+gSIonwX2bOy3938LDwamtXlqZrtgLsL9AxjpovcoicOvIC9qhBko6Xksu/7witslmI
 CRMx5rYKabGhWc1edj1+5NvztgPZ6a4UqhuPJHt0lJzZyZLQsX20rCvoO1amNavp5/5d
 HfzJOFOj3E5B94cX4Nq3zFoLynhEY8zCH8jskin7ysQCvQs8Nwk9msWUMvTFs7iZeUMd
 mCvLUzUAXHeGKICk09Yy/4B/Ot3k9wUa7EIpsRSUFEs7LX7B4jB8u12bSoeu1ZVxydR6
 jVyw==
X-Gm-Message-State: APjAAAUFThX0POSFTVfLqReqzKcPUHLVAg80zu7Q4SNFB8bsc0OQmP+r
 aeWrN05lBtJNInx0A5xAaQuPP577XJdx0yPn//M=
X-Google-Smtp-Source: APXvYqwgP223ysQHD0U2ApItHEUOrYRG++kDvJ8HQF8nebhnlOaxv4s/qoh1vpev3gpdrwpDFsgYxc6JjaWYO9ujXrw=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr6656552ljj.93.1572968707730;
 Tue, 05 Nov 2019 07:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20191102145530.16104-1-linux@roeck-us.net>
 <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
In-Reply-To: <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 6 Nov 2019 00:44:56 +0900
Message-ID: <CAC5umyiJT300+MunDi4wwwAgSxiqx7_rersbNRvybcNoo3kGDg@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
To: Guenter Roeck <linux@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_074509_239795_62E18236 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyINuaXpSjmsLQpIDA6MzggQWtpbm9idSBNaXRhIDxha2lub2J1Lm1pdGFAZ21h
aWwuY29tPjoKPgo+IDIwMTnlubQxMeaciDLml6Uo5ZyfKSAyMzo1NSBHdWVudGVyIFJvZWNrIDxs
aW51eEByb2Vjay11cy5uZXQ+Ogo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUtaHdtb24uYyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUtaHdtb24uYwo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjhiNGI3ZjQzYmIwCj4gPiAtLS0g
L2Rldi9udWxsCj4gPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLWh3bW9uLmMKPiA+IEBA
IC0wLDAgKzEsMTgxIEBACj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAK
PiA+ICsvKgo+ID4gKyAqIE5WTSBFeHByZXNzIGhhcmR3YXJlIG1vbml0b3Jpbmcgc3VwcG9ydAo+
ID4gKyAqIENvcHlyaWdodCAoYykgMjAxOSwgR3VlbnRlciBSb2Vjawo+ID4gKyAqLwo+ID4gKwo+
ID4gKyNpbmNsdWRlIDxsaW51eC9od21vbi5oPgo+ID4gKyNpbmNsdWRlIDxhc20vdW5hbGlnbmVk
Lmg+Cj4gPiArCj4gPiArI2luY2x1ZGUgIm52bWUuaCIKPiA+ICsKPiA+ICtzdHJ1Y3QgbnZtZV9o
d21vbl9kYXRhIHsKPiA+ICsgICAgICAgc3RydWN0IG52bWVfY3RybCAqY3RybDsKPiA+ICsgICAg
ICAgc3RydWN0IG52bWVfc21hcnRfbG9nIGxvZzsKPiA+ICsgICAgICAgc3RydWN0IG11dGV4IHJl
YWRfbG9jazsKPiA+ICt9Owo+ID4gKwo+ID4gK3N0YXRpYyBpbnQgbnZtZV9od21vbl9nZXRfc21h
cnRfbG9nKHN0cnVjdCBudm1lX2h3bW9uX2RhdGEgKmRhdGEpCj4gPiArewo+ID4gKyAgICAgICBp
bnQgcmV0Owo+ID4gKwo+ID4gKyAgICAgICByZXQgPSBudm1lX2dldF9sb2coZGF0YS0+Y3RybCwg
TlZNRV9OU0lEX0FMTCwgTlZNRV9MT0dfU01BUlQsIDAsCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAmZGF0YS0+bG9nLCBzaXplb2YoZGF0YS0+bG9nKSwgMCk7Cj4gPiArCj4gPiArICAg
ICAgIHJldHVybiByZXQgPD0gMCA/IHJldCA6IC1FSU87Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRp
YyBpbnQgbnZtZV9od21vbl9yZWFkKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBod21vbl9zZW5z
b3JfdHlwZXMgdHlwZSwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBhdHRyLCBp
bnQgY2hhbm5lbCwgbG9uZyAqdmFsKQo+ID4gK3sKPiA+ICsgICAgICAgc3RydWN0IG52bWVfaHdt
b25fZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwo+ID4gKyAgICAgICBzdHJ1Y3Qg
bnZtZV9zbWFydF9sb2cgKmxvZyA9ICZkYXRhLT5sb2c7Cj4gPiArICAgICAgIGludCB0ZW1wOwo+
ID4gKyAgICAgICBpbnQgZXJyOwo+ID4gKwo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAgKiBG
aXJzdCBoYW5kbGUgYXR0cmlidXRlcyB3aGljaCBkb24ndCByZXF1aXJlIHVzIHRvIHJlYWQKPiA+
ICsgICAgICAgICogdGhlIHNtYXJ0IGxvZy4KPiA+ICsgICAgICAgICovCj4gPiArICAgICAgIHN3
aXRjaCAoYXR0cikgewo+ID4gKyAgICAgICBjYXNlIGh3bW9uX3RlbXBfbWF4Ogo+ID4gKyAgICAg
ICAgICAgICAgICp2YWwgPSAoZGF0YS0+Y3RybC0+d2N0ZW1wIC0gMjczKSAqIDEwMDA7Cj4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiArICAgICAgIGNhc2UgaHdtb25fdGVtcF9jcml0
Ogo+ID4gKyAgICAgICAgICAgICAgICp2YWwgPSAoZGF0YS0+Y3RybC0+Y2N0ZW1wIC0gMjczKSAq
IDEwMDA7Cj4KPiBUaGlzIGF0dHJpYnV0ZSBzaG91bGQgYmUgJ2h3bW9uX3RlbXBfbWF4X2FsYXJt
JyByYXRoZXIgdGhhbgo+ICdod21vbl90ZW1wX2NyaXRfYWxhcm0nPwoKT29wcywgSSBtaXNxdW90
ZWQgdGhlIGNvZGUuCgpUaGlzIGNvbW1lbnQgc2hvdWxkIGJlIGFkZHJlc3NlZCB0byB0aGUgY29k
ZSBiZWxvdzoKCisgICAgICAgY2FzZSBod21vbl90ZW1wX2NyaXRfYWxhcm06CisgICAgICAgICAg
ICAgICAqdmFsID0gISEobG9nLT5jcml0aWNhbF93YXJuaW5nICYgTlZNRV9TTUFSVF9DUklUX1RF
TVBFUkFUVVJFKTsKKyAgICAgICAgICAgICAgIGJyZWFrOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
