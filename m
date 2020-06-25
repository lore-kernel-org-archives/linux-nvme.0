Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:26:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8224207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pil/LJzZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="2Dofv6vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8224207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XIshcNPjB4Rvzw/qqLZ2XM+rx7uwi+XaN3ItZtfyNcY=; b=Pil/LJzZxMzzJ9qwDN9rIdAEs
	liHwpc5yP7MEQFlBG0t5zLyMj/EDKtU+fJVNogFmtHe42Xp4esm05wbi6Y/s5nkKyQdXgTU4dZAql
	XfvV6JT+0BrqwYQm3N05IovjjW3JmZhDPLOXpWseZMQJSXxyN8TjDrIadfddSfZ4vJ7ewl66jarbA
	I4w6MSIQJN1+g3nq1/0g11vuhavrvACKnejP5bPYJGx/msPZd76M5jIYcvXQLg2dCAcn2yw5YR013
	KY1gPp0namkhz8fZ0+i71OW2gM4Qvt2kGwj+1uT+EPJWD/goYzx/xIfJEh+S6rojgshbdHiBcRhYH
	9nTfXpxsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jonRE-0005aD-LP; Fri, 26 Jun 2020 12:26:36 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jon8X-0004oF-Jn
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 12:07:31 +0000
Received: by mail-lj1-x242.google.com with SMTP id n23so10074772ljh.7
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=JsbWESuf1N3EoSxpQZgH3zX47S1xeOHHGlAooXqMv5c=;
 b=2Dofv6vdZUXaXGt4BL/XKlYLgBWPPDqWMCD/jJ0/MuwoRnn64QfXgC4U8Vt0GwY4Re
 tpRg6lLShhmOfWXXqXrIHn0EDbNJqRz64ZPBWRTjQoaTfY2xN4SUAkOLu/0igOKTRInV
 GSUTxXu/DmX/IT5nDM6jzmQQeQvi7gSkAc4oSepbhXbF2S8jemEvYzZexq3CCnI20xgQ
 i8a8ykwK12SKKbJaYtZqg+rQ/Pv4WV4PdTrqDoVfGFbPHQJBR1XPo8wmIzA6XJeLrn6h
 dGJ6mCf9I5C1sX1MfDvjQKkCoyFLNh3pIgh5KtI57keqQ0LjIeWuPwW4MGzDn+y5QXSk
 aAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JsbWESuf1N3EoSxpQZgH3zX47S1xeOHHGlAooXqMv5c=;
 b=XosIJK3NTg7vkXl7I7+SWbN/pMjDOapaF38EvuCkcLxmDR+du7YeLGhWBg2R38B0vn
 qVcOrUIZ/Zf15otaO5kYNbSlhIH0gHMy36Cm0/ypwVLKQN1JC7dktxjOstQuDI4KvNVk
 urfbN8iVKb8hPm0y23gCzi8wWiU+A4sZBsnGTM0IdsEOGECrog1mGhaI+tmNV+pEl+m2
 JXT8QzfGOPgc26M7qgrf8bWmLlnDW1nZMw8kIzT8HvlAGAr0szNJRpyvvtHztNUBq9ZX
 4kWrilFHsQ13WYh2jWF2PuI5qBZMlVRjCRYL1Ni1WmgnUKzmnliZOpk27zpytwQDfJa7
 ckGA==
X-Gm-Message-State: AOAM5319Su6Cv+Ptp9/rqytskeAPZZGufVbtuacTsRa6ffnJU+X5roc0
 kkOzxHEVjoue7MgLvnBjBNjnE6A4lcSLu5dl
X-Google-Smtp-Source: ABdhPJzndQl8a0mNwfza261jUGvbdOcKP4odLtPhY4wiohTt5qGbf24Venw0BU1jvsJyrjMZT4rVpQ==
X-Received: by 2002:a17:907:7294:: with SMTP id
 dt20mr30389411ejc.355.1593114517072; 
 Thu, 25 Jun 2020 12:48:37 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id d11sm18472502edy.79.2020.06.25.12.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 12:48:36 -0700 (PDT)
Date: Thu, 25 Jun 2020 21:48:35 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUuMDYuMjAyMCAxNjoxMiwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDI1LzA2LzIw
MjAgMTQuMjEsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+RnJvbTogSmF2aWVyIEdvbnrDoWxl
eiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4+Cj4+QWRkIHN1cHBvcnQgZm9yIG9mZmxpbmUg
dHJhbnNpdGlvbiBvbiB0aGUgem9uZWQgYmxvY2sgZGV2aWNlIHVzaW5nIHRoZQo+Pm5ldyB6b25l
IG1hbmFnZW1lbnQgSU9DVEwKPj4KPj5TaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxq
YXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj5TaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMgPHNl
bHZha3VtYS5zMUBzYW1zdW5nLmNvbT4KPj5TaWduZWQtb2ZmLWJ5OiBLYW5jaGFuIEpvc2hpIDxq
b3NoaS5rQHNhbXN1bmcuY29tPgo+PlNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNo
ZXR0eUBzYW1zdW5nLmNvbT4KPj4tLS0KPj4gIGJsb2NrL2Jsay1jb3JlLmMgICAgICAgICAgICAg
IHwgMiArKwo+PiAgYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgfCAzICsrKwo+PiAgZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgfCAzICsrKwo+PiAgaW5jbHVkZS9saW51eC9ibGtf
dHlwZXMuaCAgICAgfCAzICsrKwo+PiAgaW5jbHVkZS9saW51eC9ibGtkZXYuaCAgICAgICAgfCAx
IC0KPj4gIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIHwgMSArCj4+ICA2IGZpbGVzIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj5kaWZmIC0tZ2l0IGEv
YmxvY2svYmxrLWNvcmUuYyBiL2Jsb2NrL2Jsay1jb3JlLmMKPj5pbmRleCAwMzI1MmFmOGM4MmMu
LjU4OWNiZGFjYzVlYyAxMDA2NDQKPj4tLS0gYS9ibG9jay9ibGstY29yZS5jCj4+KysrIGIvYmxv
Y2svYmxrLWNvcmUuYwo+PkBAIC0xNDAsNiArMTQwLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmNv
bnN0IGJsa19vcF9uYW1lW10gPSB7Cj4+ICAJUkVRX09QX05BTUUoWk9ORV9DTE9TRSksCj4+ICAJ
UkVRX09QX05BTUUoWk9ORV9GSU5JU0gpLAo+PiAgCVJFUV9PUF9OQU1FKFpPTkVfQVBQRU5EKSwK
Pj4rCVJFUV9PUF9OQU1FKFpPTkVfT0ZGTElORSksCj4+ICAJUkVRX09QX05BTUUoV1JJVEVfU0FN
RSksCj4+ICAJUkVRX09QX05BTUUoV1JJVEVfWkVST0VTKSwKPj4gIAlSRVFfT1BfTkFNRShTQ1NJ
X0lOKSwKPj5AQCAtMTAzMCw2ICsxMDMxLDcgQEAgZ2VuZXJpY19tYWtlX3JlcXVlc3RfY2hlY2tz
KHN0cnVjdCBiaW8gKmJpbykKPj4gIAljYXNlIFJFUV9PUF9aT05FX09QRU46Cj4+ICAJY2FzZSBS
RVFfT1BfWk9ORV9DTE9TRToKPj4gIAljYXNlIFJFUV9PUF9aT05FX0ZJTklTSDoKPj4rCWNhc2Ug
UkVRX09QX1pPTkVfT0ZGTElORToKPj4gIAkJaWYgKCFibGtfcXVldWVfaXNfem9uZWQocSkpCj4+
ICAJCQlnb3RvIG5vdF9zdXBwb3J0ZWQ7Cj4+ICAJCWJyZWFrOwo+PmRpZmYgLS1naXQgYS9ibG9j
ay9ibGstem9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+aW5kZXggMjkxOTQzODhhMWJiLi43
MDRmYzE1ODEzZDEgMTAwNjQ0Cj4+LS0tIGEvYmxvY2svYmxrLXpvbmVkLmMKPj4rKysgYi9ibG9j
ay9ibGstem9uZWQuYwo+PkBAIC00MTYsNiArNDE2LDkgQEAgaW50IGJsa2Rldl96b25lX21nbXRf
aW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLAo+PiAgCWNhc2Ug
QkxLX1pPTkVfTUdNVF9SRVNFVDoKPj4gIAkJb3AgPSBSRVFfT1BfWk9ORV9SRVNFVDsKPj4gIAkJ
YnJlYWs7Cj4+KwljYXNlIEJMS19aT05FX01HTVRfT0ZGTElORToKPj4rCQlvcCA9IFJFUV9PUF9a
T05FX09GRkxJTkU7Cj4+KwkJYnJlYWs7Cj4+ICAJZGVmYXVsdDoKPj4gIAkJcmV0dXJuIC1FTk9U
VFk7Cj4+ICAJfQo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPj5pbmRleCBmMTIxNTUyMzc5MmIuLjViOTVjODFkMmEyZCAx
MDA2NDQKPj4tLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4rKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKPj5AQCAtNzc2LDYgKzc3Niw5IEBAIGJsa19zdGF0dXNfdCBudm1lX3Nl
dHVwX2NtZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCByZXF1ZXN0ICpyZXEsCj4+ICAJY2Fz
ZSBSRVFfT1BfWk9ORV9GSU5JU0g6Cj4+ICAJCXJldCA9IG52bWVfc2V0dXBfem9uZV9tZ210X3Nl
bmQobnMsIHJlcSwgY21kLCBOVk1FX1pPTkVfRklOSVNIKTsKPj4gIAkJYnJlYWs7Cj4+KwljYXNl
IFJFUV9PUF9aT05FX09GRkxJTkU6Cj4+KwkJcmV0ID0gbnZtZV9zZXR1cF96b25lX21nbXRfc2Vu
ZChucywgcmVxLCBjbWQsIE5WTUVfWk9ORV9PRkZMSU5FKTsKPj4rCQlicmVhazsKPj4gIAljYXNl
IFJFUV9PUF9XUklURV9aRVJPRVM6Cj4+ICAJCXJldCA9IG52bWVfc2V0dXBfd3JpdGVfemVyb2Vz
KG5zLCByZXEsIGNtZCk7Cj4+ICAJCWJyZWFrOwo+PmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2Jsa190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaAo+PmluZGV4IDE2YjU3ZmIy
Yjk5Yy4uYjM5MjEyNjNjM2RkIDEwMDY0NAo+Pi0tLSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVz
LmgKPj4rKysgYi9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oCj4+QEAgLTMxNiw2ICszMTYsOCBA
QCBlbnVtIHJlcV9vcGYgewo+PiAgCVJFUV9PUF9aT05FX0ZJTklTSAk9IDEyLAo+PiAgCS8qIHdy
aXRlIGRhdGEgYXQgdGhlIGN1cnJlbnQgem9uZSB3cml0ZSBwb2ludGVyICovCj4+ICAJUkVRX09Q
X1pPTkVfQVBQRU5ECT0gMTMsCj4+KwkvKiBUcmFuc2l0aW9uIGEgem9uZSB0byBvZmZsaW5lICov
Cj4+KwlSRVFfT1BfWk9ORV9PRkZMSU5FCT0gMTQsCj4+ICAJLyogU0NTSSBwYXNzdGhyb3VnaCB1
c2luZyBzdHJ1Y3Qgc2NzaV9yZXF1ZXN0ICovCj4+ICAJUkVRX09QX1NDU0lfSU4JCT0gMzIsCj4+
QEAgLTQ1Niw2ICs0NTgsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgb3BfaXNfem9uZV9tZ210KGVu
dW0gcmVxX29wZiBvcCkKPj4gIAljYXNlIFJFUV9PUF9aT05FX09QRU46Cj4+ICAJY2FzZSBSRVFf
T1BfWk9ORV9DTE9TRToKPj4gIAljYXNlIFJFUV9PUF9aT05FX0ZJTklTSDoKPj4rCWNhc2UgUkVR
X09QX1pPTkVfT0ZGTElORToKPj4gIAkJcmV0dXJuIHRydWU7Cj4+ICAJZGVmYXVsdDoKPj4gIAkJ
cmV0dXJuIGZhbHNlOwo+PmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5j
bHVkZS9saW51eC9ibGtkZXYuaAo+PmluZGV4IGJkODUyMWY5NGRjNC4uODMwOGQ4YTM3MjBiIDEw
MDY0NAo+Pi0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPj4rKysgYi9pbmNsdWRlL2xpbnV4
L2Jsa2Rldi5oCj4+QEAgLTM3Miw3ICszNzIsNiBAQCBleHRlcm4gaW50IGJsa2Rldl96b25lX29w
c19pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCj4+ICAJCQkJ
ICB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7Cj4+ICBleHRlcm4gaW50IGJs
a2Rldl96b25lX21nbXRfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBt
b2RlLAo+PiAgCQkJCSAgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpOwo+Pi0K
Pj4gICNlbHNlIC8qIENPTkZJR19CTEtfREVWX1pPTkVEICovCj4+ICBzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGludCBibGtkZXZfbnJfem9uZXMoc3RydWN0IGdlbmRpc2sgKmRpc2spCj4+ZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4
L2Jsa3pvbmVkLmgKPj5pbmRleCBhOGM4OWZlNThmOTcuLmQwOTc4ZWUxMGZjNyAxMDA2NDQKPj4t
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+PisrKyBiL2luY2x1ZGUvdWFwaS9s
aW51eC9ibGt6b25lZC5oCj4+QEAgLTE1NSw2ICsxNTUsNyBAQCBlbnVtIGJsa196b25lX2FjdGlv
biB7Cj4+ICAJQkxLX1pPTkVfTUdNVF9GSU5JU0gJPSAweDIsCj4+ICAJQkxLX1pPTkVfTUdNVF9P
UEVOCT0gMHgzLAo+PiAgCUJMS19aT05FX01HTVRfUkVTRVQJPSAweDQsCj4+KwlCTEtfWk9ORV9N
R01UX09GRkxJTkUJPSAweDUsCj4+ICB9Owo+PiAgLyoqCj4KPkkgYW0gbm90IHN1cmUgdGhpcyBt
YWtlcyBzZW5zZSB0byBleHBvc2UgdGhyb3VnaCB0aGUga2VybmVsIHpvbmUgYXBpLiAKPk9uZSBv
ZiB0aGUgZ29hbHMgb2YgdGhlIGtlcm5lbCB6b25lIEFQSSBpcyB0byBiZSBhIGxheWVyIHRoYXQg
cHJvdmlkZXMgCj5hbiB1bmlmaWVkIHpvbmUgbW9kZWwgYWNyb3NzIFNNUiBIRERzIGFuZCBaTlMg
U1NEcy4gVGhlIG9mZmxpbmUgem9uZSAKPm9wZXJhdGlvbiwgYXMgZGVmaW5lZCBpbiB0aGUgWk5T
IHNwZWNpZmljYXRpb24sIGRvZXMgbm90IGhhdmUgYW4gCj5lcXVpdmFsZW50IGluIFNNUiBIRERz
IChaQUMvWkJDKS4KPgo+VGhpcyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgWm9uZSBDYXBhY2l0eSBj
aGFuZ2UsIHdoZXJlIHRoZSB6b25lIAo+Y2FwYWNpdHkgc2ltcGx5IHdhcyB6b25lIHNpemUgZm9y
IFNNUiBIRERzLiBNYWtpbmcgaXQgZWFzeSB0byBzdXBwb3J0LiAKPlRoYXQgaXMgbm90IHRoZSBz
YW1lIGZvciBaQUMvWkJDLCB0aGF0IGRvZXMgbm90IG9mZmVyIHRoZSBvZmZsaW5lIAo+b3BlcmF0
aW9uIHRvIHRyYW5zaXRpb24gem9uZXMgaW4gcmVhZCBvbmx5IHN0YXRlIHRvIG9mZmxpbmUgc3Rh
dGUuCgpJIGFncmVlIHRoYXQgYW4gdW5pZmllZCBpbnRlcmZhY2UgaXMgZGVzaXJhYmxlLiBIb3dl
dmVyLCB0aGUgdHJ1dGggaXMKdGhhdCBaQUMvWkJDIGFyZSBkaWZmZXJlbnQsIGFuZCB3aWxsIGRp
ZmZlciBtb3JlIGFuZCBtb3JlIGFuZCB0aW1lIGdvZXMKYnkuIFdlIGNhbiBkZWFsIHdpdGggdGhl
IGRpZmZlcmVuY2VzIGF0IHRoZSBkcml2ZXIgbGV2ZWwgb3Igd2l0aCBjaGVja3MKYXQgdGhlIEFQ
SSBsZXZlbCwgYnV0IGxpbWl0aW5nIFpOUyB3aXRoIFpBQy9aQkMgaXMgYSBoYXJkIGNvbnN0cmFp
bnQuCgpOb3RlIHRvbyB0aGF0IEkgY2hvc2UgdG8gb25seSBzdXBwb3J0IHRoaXMgcGFydGljdWxh
ciB0cmFuc2l0aW9uIG9uIHRoZQpuZXcgbWFuYWdlbWVudCBJT0NUTCB0byBhdm9pZCBjb25mdXNp
b24gZm9yIGV4aXN0aW5nIFpBQy9aQkMgdXNlcnMuCgpJdCB3b3VsZCBiZSBnb29kIHRvIGNsYXJp
Znkgd2hhdCBpcyB0aGUgcGxhbiBmb3Iga2VybmVsIEFQSXMgbW92aW5nCmZvcndhcmQsIGFzIEkg
YmVsaWV2ZSB0aGVyZSBpcyBhIGdlbmVyYWwgZGVzaXJlIHRvIHN1cHBvcnQgbmV3IFpOUwpmZWF0
dXJlcywgd2hpY2ggd2lsbCBub3QgbmVjZXNzYXJpbHkgYmUgcmVwbGljYXRlZCBpbiBTTVIgZHJp
dmVzLgoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
