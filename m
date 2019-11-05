Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B5C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 18:10:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2274D21882
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 18:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwIGfYUj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0jcEC6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2274D21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uO3l0lLCAkVMH8T/JAOH9MrgOlzrPGdzF34LMIuseTQ=; b=rwIGfYUjTD/7Ci
	h1mFtXeMKsZfRHHGVqubNu3GbN3DZdGwkbCs2GXWoa2NQM2XRIG6nFkMYsUeGsiH9iPRGYFfI723+
	rKcZ3eFE9lZR6WnYdzludbiHvD9sBdLwm8dUbrn/kR/5azl4/UO+9uzbJKWT5Z2D2NorjXgmVLNRq
	meKd//r7PX8aKGslN703uFrVBTiSzQaDhGPiFs9ugV7b262aM/MIupJYPeYnLeQWnKC8Emo1CmNSm
	qLOkiYSF7i9vowfEly8Joo7Iyhqcp3c4ttRTVFXAZlWBnb7+EGAwjFSX+LB02XAVULlGs05sxmhD4
	IPwjU6SneWHJYfKqvSdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS3Hi-0005Is-20; Tue, 05 Nov 2019 18:10:30 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS3Hf-0005IC-9H
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 18:10:28 +0000
Received: by mail-pl1-x642.google.com with SMTP id w8so9851568plq.5
 for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2019 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=xgf/R13CTbGVKZNJzECasZDqFPajX8jIrP4cc+cKW80=;
 b=L0jcEC6SQD3mY4ac3RNnZmyTkHPxwfhGTToCGoRmcz/E+NU4dBYOlS4rHvp23TuHwW
 wOi1oGhz2chNwp3Kx3JHIMOk0BYM4Abu50vG4jO6GBypeeNHOZoSPPDQp9mS9pdRjTBC
 cq9Kq7vmSA6qwX0jUmpHh2NDiiUreUEYOaLxfCWZjFPjKOKscmkke74ryDyHi6Sl5KfA
 oHzQnQK1iJmsXyu99IoJzltlaQOBPRtboRQ1TKK2emnvaUbc/zieSX9UObIrvgyEyc0i
 CYpnLWA8WNxsSe4f57/iAvPK1jcvAO24yPOYlrjyFqFhEcl7L86LQBIBs19aLCBYPuPt
 wcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=xgf/R13CTbGVKZNJzECasZDqFPajX8jIrP4cc+cKW80=;
 b=Lrh1nqK+7RpPAJd7Qen+ovAZ/Rc57XH9SjcQ7PIntaD//VwXzCYtna+GVCycrpSHAl
 v2Whlm7umU5dRQva1/2NrMBvKQErwuI4ZocuMq2tsiUhXKI5cs8OROb7xJFmZ/J29c7K
 0YVxhLg3wayuO+ul8zxSit9t3GH0XCSLbUV9Nb62viemBvad25ESalCtALGJdbrmo1UA
 lckhzqmlYa53r2LXiebEfgklT23O1gEpDKZKefHUZp+PBc3LKUJKkKpUgFQSzRKf6On8
 TuFCngZ1d6FOvbY9irk4n6NlATxlGZuPdml0Vt6bANH7pZvZfK6ESvmZsbIDA9+tCrrh
 Zzag==
X-Gm-Message-State: APjAAAW0QlMItGvoxK0qjTkSbaCOBC7Y8j+nprC0ZtVObtpeEf7gpntg
 cxOa5+/ZFMBK0otFLeaj0a4=
X-Google-Smtp-Source: APXvYqyxs1xQj4ZFUNM7OCsA+7jN0O9lyTXVuaIFG0YagWGyt9o+u2FfRGxmjyAlDYitRpgHNOp5ug==
X-Received: by 2002:a17:902:bcc2:: with SMTP id
 o2mr35276811pls.281.1572977426163; 
 Tue, 05 Nov 2019 10:10:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 18sm20421819pfp.100.2019.11.05.10.10.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Nov 2019 10:10:25 -0800 (PST)
Date: Tue, 5 Nov 2019 10:10:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
Message-ID: <20191105181023.GA22468@roeck-us.net>
References: <20191102145530.16104-1-linux@roeck-us.net>
 <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
 <CAC5umyiJT300+MunDi4wwwAgSxiqx7_rersbNRvybcNoo3kGDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAC5umyiJT300+MunDi4wwwAgSxiqx7_rersbNRvybcNoo3kGDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_101027_354525_25AE040D 
X-CRM114-Status: GOOD (  16.13  )
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

T24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMTI6NDQ6NTZBTSArMDkwMCwgQWtpbm9idSBNaXRhIHdy
b3RlOgo+IDIwMTnlubQxMeaciDbml6Uo5rC0KSAwOjM4IEFraW5vYnUgTWl0YSA8YWtpbm9idS5t
aXRhQGdtYWlsLmNvbT46Cj4gPgo+ID4gMjAxOeW5tDEx5pyIMuaXpSjlnJ8pIDIzOjU1IEd1ZW50
ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD46Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9udm1lLWh3bW9uLmMgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLWh3bW9uLmMK
PiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4yOGI0
YjdmNDNiYjAKPiA+ID4gLS0tIC9kZXYvbnVsbAo+ID4gPiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLWh3bW9uLmMKPiA+ID4gQEAgLTAsMCArMSwxODEgQEAKPiA+ID4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gPiA+ICsvKgo+ID4gPiArICogTlZNIEV4cHJlc3Mg
aGFyZHdhcmUgbW9uaXRvcmluZyBzdXBwb3J0Cj4gPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTks
IEd1ZW50ZXIgUm9lY2sKPiA+ID4gKyAqLwo+ID4gPiArCj4gPiA+ICsjaW5jbHVkZSA8bGludXgv
aHdtb24uaD4KPiA+ID4gKyNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+Cj4gPiA+ICsKPiA+ID4g
KyNpbmNsdWRlICJudm1lLmgiCj4gPiA+ICsKPiA+ID4gK3N0cnVjdCBudm1lX2h3bW9uX2RhdGEg
ewo+ID4gPiArICAgICAgIHN0cnVjdCBudm1lX2N0cmwgKmN0cmw7Cj4gPiA+ICsgICAgICAgc3Ry
dWN0IG52bWVfc21hcnRfbG9nIGxvZzsKPiA+ID4gKyAgICAgICBzdHJ1Y3QgbXV0ZXggcmVhZF9s
b2NrOwo+ID4gPiArfTsKPiA+ID4gKwo+ID4gPiArc3RhdGljIGludCBudm1lX2h3bW9uX2dldF9z
bWFydF9sb2coc3RydWN0IG52bWVfaHdtb25fZGF0YSAqZGF0YSkKPiA+ID4gK3sKPiA+ID4gKyAg
ICAgICBpbnQgcmV0Owo+ID4gPiArCj4gPiA+ICsgICAgICAgcmV0ID0gbnZtZV9nZXRfbG9nKGRh
dGEtPmN0cmwsIE5WTUVfTlNJRF9BTEwsIE5WTUVfTE9HX1NNQVJULCAwLAo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAmZGF0YS0+bG9nLCBzaXplb2YoZGF0YS0+bG9nKSwgMCk7Cj4g
PiA+ICsKPiA+ID4gKyAgICAgICByZXR1cm4gcmV0IDw9IDAgPyByZXQgOiAtRUlPOwo+ID4gPiAr
fQo+ID4gPiArCj4gPiA+ICtzdGF0aWMgaW50IG52bWVfaHdtb25fcmVhZChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGVudW0gaHdtb25fc2Vuc29yX3R5cGVzIHR5cGUsCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgIHUzMiBhdHRyLCBpbnQgY2hhbm5lbCwgbG9uZyAqdmFsKQo+ID4gPiArewo+
ID4gPiArICAgICAgIHN0cnVjdCBudm1lX2h3bW9uX2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsKPiA+ID4gKyAgICAgICBzdHJ1Y3QgbnZtZV9zbWFydF9sb2cgKmxvZyA9ICZkYXRh
LT5sb2c7Cj4gPiA+ICsgICAgICAgaW50IHRlbXA7Cj4gPiA+ICsgICAgICAgaW50IGVycjsKPiA+
ID4gKwo+ID4gPiArICAgICAgIC8qCj4gPiA+ICsgICAgICAgICogRmlyc3QgaGFuZGxlIGF0dHJp
YnV0ZXMgd2hpY2ggZG9uJ3QgcmVxdWlyZSB1cyB0byByZWFkCj4gPiA+ICsgICAgICAgICogdGhl
IHNtYXJ0IGxvZy4KPiA+ID4gKyAgICAgICAgKi8KPiA+ID4gKyAgICAgICBzd2l0Y2ggKGF0dHIp
IHsKPiA+ID4gKyAgICAgICBjYXNlIGh3bW9uX3RlbXBfbWF4Ogo+ID4gPiArICAgICAgICAgICAg
ICAgKnZhbCA9IChkYXRhLT5jdHJsLT53Y3RlbXAgLSAyNzMpICogMTAwMDsKPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAwOwo+ID4gPiArICAgICAgIGNhc2UgaHdtb25fdGVtcF9jcml0Ogo+
ID4gPiArICAgICAgICAgICAgICAgKnZhbCA9IChkYXRhLT5jdHJsLT5jY3RlbXAgLSAyNzMpICog
MTAwMDsKPiA+Cj4gPiBUaGlzIGF0dHJpYnV0ZSBzaG91bGQgYmUgJ2h3bW9uX3RlbXBfbWF4X2Fs
YXJtJyByYXRoZXIgdGhhbgo+ID4gJ2h3bW9uX3RlbXBfY3JpdF9hbGFybSc/Cj4gCgpZZXMsIHlv
dSBhcmUgY29ycmVjdC4gQWN0dWFsbHksIHJlLXJlYWRpbmcgdGhlIHNwZWNpZmljYXRpb24sCnRo
ZSBiaXQgbWF5IGFsc28gYmUgc2V0IGZvciB1bmRlci10ZW1wZXJhdHVyZSBhbGFybXMsIHNvIEkn
bGwKdXNlIHRoZSBtb3JlIGdlbmVyaWMgaHdtb25fdGVtcF9hbGFybS4KClRoYW5rcywKR3VlbnRl
cgoKPiBPb3BzLCBJIG1pc3F1b3RlZCB0aGUgY29kZS4KPiAKPiBUaGlzIGNvbW1lbnQgc2hvdWxk
IGJlIGFkZHJlc3NlZCB0byB0aGUgY29kZSBiZWxvdzoKPiAKPiArICAgICAgIGNhc2UgaHdtb25f
dGVtcF9jcml0X2FsYXJtOgo+ICsgICAgICAgICAgICAgICAqdmFsID0gISEobG9nLT5jcml0aWNh
bF93YXJuaW5nICYgTlZNRV9TTUFSVF9DUklUX1RFTVBFUkFUVVJFKTsKPiArICAgICAgICAgICAg
ICAgYnJlYWs7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
