Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4FC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 14:12:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2077320702
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvScg/4y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="KMgnFMxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2077320702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y+lHk2ffP7nGwOtAroQRc1o10gRwN4vjzQaognIGHzo=; b=lvScg/4yuY5KfUHjY7Or3hTMO
	b76RqlH+cT1wKH/AOCEi0yh4EdsJT1N49dQ6CzBfQhHuHbALpmtsN6XKhwUfrPNF510ZAG47XCg2W
	DOxDOtz+DYbO5HZRfalML0E9Mh49RM6ddZETsl2r9BQXWLOFY4dT3WOATwZ0nQl/IWG3eioxX6dyQ
	y9fR9BjCvjd8u2WSKZfUwtE+ULnd6MiAgliwEVUXdI5pBRsQsHNgW0m+ZjcX2J25DjYw96+yGt2pa
	7WgnNXR+IEXVetqjlZFQ7luAdoOpv+kA65/MxKVhaH/VHbdjo07it9cb6O8oqmHsWqo3eBGBFPVkW
	ABYEmKafQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joSc6-0001tj-43; Thu, 25 Jun 2020 14:12:26 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joSc3-0001t2-Ep
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 14:12:24 +0000
Received: by mail-ej1-x641.google.com with SMTP id w6so6092606ejq.6
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+nMSMJQyXiE0FGbsQZwYsm4NFtgtlfZJ3JVTvDS4SSY=;
 b=KMgnFMxPBn1sGRdOuz8OvBu75FpD4WqvG0wi8Tf8bGAGM+NAlIP1X2kGtmQ1jGzpm5
 ogKTBT5A6eegg3i7/WJWua9PPWYOqaM2/PEjiqhRft+DLz8uDFaehSUgqR1S0uSdlgia
 UDPCviP5pZGAekVaQUv466tJ7EfHCtUAaT2n70ktxASnqkykXuFLInTkbqbXNFaUOjSX
 89WHlSN1p2lcvR1DAHrPkQ/VmjWK0GbSiNcSnufd4U7qwLrDhADAoO+3jqWhOMR9uCie
 KTJCTlpwHkDDYXraMp99J8gIl6prQv4q/MqUkLyjvXKZqFZdwSjTow4ChIsZyEElZNbQ
 w5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+nMSMJQyXiE0FGbsQZwYsm4NFtgtlfZJ3JVTvDS4SSY=;
 b=ANnN69w2Z/0LkOgwtOaOmzOaXnw1lQ7QXKhC5ilCJAvU7Y/zVzI3tkd5hziBTHu47E
 1orPQ1SkL5Ue1A9WEALnnCvzQ84DihlcOyfwTlt6rg4xPz8AJfYe5QcUeg9az4j49HDG
 agqb/7l97E87MoUZgIev8PEVK4AIm3qrBzyrDhrR4JZSPMIiSM0X6Ei90USAo9r6d+7n
 mBB9TEahVadjse4q4vegiM6eW0LMQifdeaVV71DEZu4TQX0W476sMtVQnZZxpX0EVdy5
 AIWqkd9G57b7X940luvpqmriMlqkvqldBky59F5WdYkxV0yywlVTp+el6XxgiXlw2U9j
 iCHA==
X-Gm-Message-State: AOAM533eUtlPu0L9fF5ocnT1DLQXoZWF2B+dVuEWH/FJBGS3YgNX3cpi
 rzt5S+hmlKv1jKfOKTN+RWB8Ag==
X-Google-Smtp-Source: ABdhPJxCB4Rza2JDytyHAFa7yyQZEBHzr/3VlxA+k8lx7JXqsIRk4YRul7SSEzSH97M7xSnPsv7HiA==
X-Received: by 2002:a17:906:27c9:: with SMTP id
 k9mr24206720ejc.74.1593094342363; 
 Thu, 25 Jun 2020 07:12:22 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id e20sm16855953ejh.22.2020.06.25.07.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 07:12:21 -0700 (PDT)
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 linux-nvme@lists.infradead.org
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
Date: Thu, 25 Jun 2020 16:12:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-4-javier@javigon.com>
Content-Language: en-US
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
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUvMDYvMjAyMCAxNC4yMSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBGcm9tOiBKYXZp
ZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPgo+IEFkZCBzdXBwb3J0IGZv
ciBvZmZsaW5lIHRyYW5zaXRpb24gb24gdGhlIHpvbmVkIGJsb2NrIGRldmljZSB1c2luZyB0aGUK
PiBuZXcgem9uZSBtYW5hZ2VtZW50IElPQ1RMCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29u
esOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1
bWFyIFMgPHNlbHZha3VtYS5zMUBzYW1zdW5nLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFu
IEpvc2hpIDxqb3NoaS5rQHNhbXN1bmcuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0
dHkgPG5qLnNoZXR0eUBzYW1zdW5nLmNvbT4KPiAtLS0KPiAgIGJsb2NrL2Jsay1jb3JlLmMgICAg
ICAgICAgICAgIHwgMiArKwo+ICAgYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgfCAzICsr
Kwo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgfCAzICsrKwo+ICAgaW5jbHVkZS9s
aW51eC9ibGtfdHlwZXMuaCAgICAgfCAzICsrKwo+ICAgaW5jbHVkZS9saW51eC9ibGtkZXYuaCAg
ICAgICAgfCAxIC0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIHwgMSArCj4gICA2
IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9ibG9jay9ibGstY29yZS5jIGIvYmxvY2svYmxrLWNvcmUuYwo+IGluZGV4IDAzMjUy
YWY4YzgyYy4uNTg5Y2JkYWNjNWVjIDEwMDY0NAo+IC0tLSBhL2Jsb2NrL2Jsay1jb3JlLmMKPiAr
KysgYi9ibG9jay9ibGstY29yZS5jCj4gQEAgLTE0MCw2ICsxNDAsNyBAQCBzdGF0aWMgY29uc3Qg
Y2hhciAqY29uc3QgYmxrX29wX25hbWVbXSA9IHsKPiAgIAlSRVFfT1BfTkFNRShaT05FX0NMT1NF
KSwKPiAgIAlSRVFfT1BfTkFNRShaT05FX0ZJTklTSCksCj4gICAJUkVRX09QX05BTUUoWk9ORV9B
UFBFTkQpLAo+ICsJUkVRX09QX05BTUUoWk9ORV9PRkZMSU5FKSwKPiAgIAlSRVFfT1BfTkFNRShX
UklURV9TQU1FKSwKPiAgIAlSRVFfT1BfTkFNRShXUklURV9aRVJPRVMpLAo+ICAgCVJFUV9PUF9O
QU1FKFNDU0lfSU4pLAo+IEBAIC0xMDMwLDYgKzEwMzEsNyBAQCBnZW5lcmljX21ha2VfcmVxdWVz
dF9jaGVja3Moc3RydWN0IGJpbyAqYmlvKQo+ICAgCWNhc2UgUkVRX09QX1pPTkVfT1BFTjoKPiAg
IAljYXNlIFJFUV9PUF9aT05FX0NMT1NFOgo+ICAgCWNhc2UgUkVRX09QX1pPTkVfRklOSVNIOgo+
ICsJY2FzZSBSRVFfT1BfWk9ORV9PRkZMSU5FOgo+ICAgCQlpZiAoIWJsa19xdWV1ZV9pc196b25l
ZChxKSkKPiAgIAkJCWdvdG8gbm90X3N1cHBvcnRlZDsKPiAgIAkJYnJlYWs7Cj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVkLmMKPiBpbmRleCAyOTE5NDM4
OGExYmIuLjcwNGZjMTU4MTNkMSAxMDA2NDQKPiAtLS0gYS9ibG9jay9ibGstem9uZWQuYwo+ICsr
KyBiL2Jsb2NrL2Jsay16b25lZC5jCj4gQEAgLTQxNiw2ICs0MTYsOSBAQCBpbnQgYmxrZGV2X3pv
bmVfbWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCj4g
ICAJY2FzZSBCTEtfWk9ORV9NR01UX1JFU0VUOgo+ICAgCQlvcCA9IFJFUV9PUF9aT05FX1JFU0VU
Owo+ICAgCQlicmVhazsKPiArCWNhc2UgQkxLX1pPTkVfTUdNVF9PRkZMSU5FOgo+ICsJCW9wID0g
UkVRX09QX1pPTkVfT0ZGTElORTsKPiArCQlicmVhazsKPiAgIAlkZWZhdWx0Ogo+ICAgCQlyZXR1
cm4gLUVOT1RUWTsKPiAgIAl9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IGYxMjE1NTIzNzkyYi4uNWI5NWM4
MWQyYTJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC03NzYsNiArNzc2LDkgQEAgYmxrX3N0YXR1c190
IG52bWVfc2V0dXBfY21kKHN0cnVjdCBudm1lX25zICpucywgc3RydWN0IHJlcXVlc3QgKnJlcSwK
PiAgIAljYXNlIFJFUV9PUF9aT05FX0ZJTklTSDoKPiAgIAkJcmV0ID0gbnZtZV9zZXR1cF96b25l
X21nbXRfc2VuZChucywgcmVxLCBjbWQsIE5WTUVfWk9ORV9GSU5JU0gpOwo+ICAgCQlicmVhazsK
PiArCWNhc2UgUkVRX09QX1pPTkVfT0ZGTElORToKPiArCQlyZXQgPSBudm1lX3NldHVwX3pvbmVf
bWdtdF9zZW5kKG5zLCByZXEsIGNtZCwgTlZNRV9aT05FX09GRkxJTkUpOwo+ICsJCWJyZWFrOwo+
ICAgCWNhc2UgUkVRX09QX1dSSVRFX1pFUk9FUzoKPiAgIAkJcmV0ID0gbnZtZV9zZXR1cF93cml0
ZV96ZXJvZXMobnMsIHJlcSwgY21kKTsKPiAgIAkJYnJlYWs7Cj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvYmxrX3R5cGVzLmggYi9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oCj4gaW5kZXgg
MTZiNTdmYjJiOTljLi5iMzkyMTI2M2MzZGQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9i
bGtfdHlwZXMuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPiBAQCAtMzE2LDYg
KzMxNiw4IEBAIGVudW0gcmVxX29wZiB7Cj4gICAJUkVRX09QX1pPTkVfRklOSVNICT0gMTIsCj4g
ICAJLyogd3JpdGUgZGF0YSBhdCB0aGUgY3VycmVudCB6b25lIHdyaXRlIHBvaW50ZXIgKi8KPiAg
IAlSRVFfT1BfWk9ORV9BUFBFTkQJPSAxMywKPiArCS8qIFRyYW5zaXRpb24gYSB6b25lIHRvIG9m
ZmxpbmUgKi8KPiArCVJFUV9PUF9aT05FX09GRkxJTkUJPSAxNCwKPiAgIAo+ICAgCS8qIFNDU0kg
cGFzc3Rocm91Z2ggdXNpbmcgc3RydWN0IHNjc2lfcmVxdWVzdCAqLwo+ICAgCVJFUV9PUF9TQ1NJ
X0lOCQk9IDMyLAo+IEBAIC00NTYsNiArNDU4LDcgQEAgc3RhdGljIGlubGluZSBib29sIG9wX2lz
X3pvbmVfbWdtdChlbnVtIHJlcV9vcGYgb3ApCj4gICAJY2FzZSBSRVFfT1BfWk9ORV9PUEVOOgo+
ICAgCWNhc2UgUkVRX09QX1pPTkVfQ0xPU0U6Cj4gICAJY2FzZSBSRVFfT1BfWk9ORV9GSU5JU0g6
Cj4gKwljYXNlIFJFUV9PUF9aT05FX09GRkxJTkU6Cj4gICAJCXJldHVybiB0cnVlOwo+ICAgCWRl
ZmF1bHQ6Cj4gICAJCXJldHVybiBmYWxzZTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9i
bGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPiBpbmRleCBiZDg1MjFmOTRkYzQuLjgz
MDhkOGEzNzIwYiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCj4gKysrIGIv
aW5jbHVkZS9saW51eC9ibGtkZXYuaAo+IEBAIC0zNzIsNyArMzcyLDYgQEAgZXh0ZXJuIGludCBi
bGtkZXZfem9uZV9vcHNfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBt
b2RlLAo+ICAgCQkJCSAgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpOwo+ICAg
ZXh0ZXJuIGludCBibGtkZXZfem9uZV9tZ210X2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJk
ZXYsIGZtb2RlX3QgbW9kZSwKPiAgIAkJCQkgIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxv
bmcgYXJnKTsKPiAtCj4gICAjZWxzZSAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAqLwo+ICAgCj4g
ICBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBibGtkZXZfbnJfem9uZXMoc3RydWN0IGdlbmRp
c2sgKmRpc2spCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIGIv
aW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPiBpbmRleCBhOGM4OWZlNThmOTcuLmQwOTc4
ZWUxMGZjNyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+ICsr
KyBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCj4gQEAgLTE1NSw2ICsxNTUsNyBAQCBl
bnVtIGJsa196b25lX2FjdGlvbiB7Cj4gICAJQkxLX1pPTkVfTUdNVF9GSU5JU0gJPSAweDIsCj4g
ICAJQkxLX1pPTkVfTUdNVF9PUEVOCT0gMHgzLAo+ICAgCUJMS19aT05FX01HTVRfUkVTRVQJPSAw
eDQsCj4gKwlCTEtfWk9ORV9NR01UX09GRkxJTkUJPSAweDUsCj4gICB9Owo+ICAgCj4gICAvKioK
CkkgYW0gbm90IHN1cmUgdGhpcyBtYWtlcyBzZW5zZSB0byBleHBvc2UgdGhyb3VnaCB0aGUga2Vy
bmVsIHpvbmUgYXBpLiAKT25lIG9mIHRoZSBnb2FscyBvZiB0aGUga2VybmVsIHpvbmUgQVBJIGlz
IHRvIGJlIGEgbGF5ZXIgdGhhdCBwcm92aWRlcyAKYW4gdW5pZmllZCB6b25lIG1vZGVsIGFjcm9z
cyBTTVIgSEREcyBhbmQgWk5TIFNTRHMuIFRoZSBvZmZsaW5lIHpvbmUgCm9wZXJhdGlvbiwgYXMg
ZGVmaW5lZCBpbiB0aGUgWk5TIHNwZWNpZmljYXRpb24sIGRvZXMgbm90IGhhdmUgYW4gCmVxdWl2
YWxlbnQgaW4gU01SIEhERHMgKFpBQy9aQkMpLgoKVGhpcyBpcyBkaWZmZXJlbnQgZnJvbSB0aGUg
Wm9uZSBDYXBhY2l0eSBjaGFuZ2UsIHdoZXJlIHRoZSB6b25lIGNhcGFjaXR5IApzaW1wbHkgd2Fz
IHpvbmUgc2l6ZSBmb3IgU01SIEhERHMuIE1ha2luZyBpdCBlYXN5IHRvIHN1cHBvcnQuIFRoYXQg
aXMgCm5vdCB0aGUgc2FtZSBmb3IgWkFDL1pCQywgdGhhdCBkb2VzIG5vdCBvZmZlciB0aGUgb2Zm
bGluZSBvcGVyYXRpb24gdG8gCnRyYW5zaXRpb24gem9uZXMgaW4gcmVhZCBvbmx5IHN0YXRlIHRv
IG9mZmxpbmUgc3RhdGUuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
