Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBBC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:08:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16CC207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="loKmXLJM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="vT2TcI/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16CC207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2nGw1xW8dcYYAYuHYFSp1wcxPFw7JvwXLIRvD0nsBS0=; b=loKmXLJMq1oAaXjJeUQ5nQGd7
	Tew5qX7zaOCLJCojOD5nznAQpImxYFqxYBeFG0bRE5LrPVv+HpVxTXjiP8AND/OX2OWHj933Acu7N
	BnTh64C7p0W7Vvq0R6F1LotXASHZ6hpU8Ww3LSyKQPqKQZ/LYrXoPdUv/xp1zNydK+92OWi5fhjkf
	4fZUs04ZDARRc6YQu8vR0lFFBpQxH0l98ni3m3BEwrlHyT+XW7AmhMPek2ECkYnIAFK3fLiGEIUpm
	4qu9bFo/xMcQ+DpChOnIqBj6Dk1UkYMrQgAa3PW2JReIXnsHjDePY6qNYv5tAIsRViYz/ya1RZ4h6
	uaPK0h9Lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomDE-0003Mo-Fz; Fri, 26 Jun 2020 11:08:04 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jol1S-0003Hl-QC
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:52:19 +0000
Received: by mail-lj1-x243.google.com with SMTP id s1so9688326ljo.0
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=gcyYYRRxnsmnQ0vr+PgDiQA9JXsYvr/X0elxlBynLDU=;
 b=vT2TcI/dWfhfDAGJjeRE4dYiKpiLpCM1uffhBe5idV/cndRjKZder8qs4KiabpccIx
 wVOsVbck/Cba0HuJ6usYqA0+Hf654yAgPXJqupYXo2TrRH14GntMnhSWVCzkGCj/Va0T
 0PPnAX5PrYSToP4JbsIF1XvDOCzfRm6TxZi9a2drxsnGR65UT0JkTDEtMgIIEmqXDyOS
 LHcyCkGrfLZgVh+ghtSq3N+XTisMbsNBJjSMioOK81JoIMFL7ZgsQx4Vj4QmMmMcH6wO
 lNtSjHE9skS3R6scCrsJ5HiOs3RW3/IIYl9RC6LtgJR9m/A1O3FFKUchXBfFMm5HGSJQ
 bVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gcyYYRRxnsmnQ0vr+PgDiQA9JXsYvr/X0elxlBynLDU=;
 b=EBjmggVGssy3ZxLGUBiN8ruhUmlPZSthLNu9hka6zDN8pOlmg9HNYaNsD+oBnEFFj6
 eAQTZ2jvMC9Ny7A05ScYje4Z4ebxPKJm9h6u6Gm5wL1WecaO29BucOKX3lO79ePVYtz2
 IvgzNmeTP30ObWmUsU21GxIdBQsT82gBmDOG3Fc4l+kK0Tsz/SEzyQ7gaekWUdmWyrfL
 BGwA8lVqw6Qtq82vYcaZKV2RAwklftTeDQwYuTD9Cl9n59gNu3wlY4Fr+DM7/t6SWXJu
 HxCFI5GzyEuU6T/aZg9OoMsD4pjCK6kOUqrcRSwQ+OX9teiMZN+jdcXOCiwl0WZoc6O/
 YPng==
X-Gm-Message-State: AOAM532roMGUwvnRnI/wcgplbZw9IBuB5q6A9ZX/ULI7vozt2neFxIKt
 Z9zzICrKEffQ9VOcppU0iDcgqf7060bLVeMo
X-Google-Smtp-Source: ABdhPJzgFLPm6nPb9gyUuSlf5Bc+3Z66qWM7aC8Y5erZaP/PUQbGcyN4sDBx07Evf/QnV74pGouNyQ==
X-Received: by 2002:a17:906:488:: with SMTP id
 f8mr1276306eja.215.1593154704080; 
 Thu, 25 Jun 2020 23:58:24 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id cb7sm8916464ejb.12.2020.06.25.23.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:58:23 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:58:22 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626065822.6psy3tp6vqmjwppa@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
 <CY4PR04MB37515EAB61CDB458DE5AFCA3E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37515EAB61CDB458DE5AFCA3E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
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

T24gMjYuMDYuMjAyMCAwNjo0MiwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI2
IDE1OjA5LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAyNi4wNi4yMDIwIDAxOjM0LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMjUgMjE6MjIsIEphdmllciBHb256
w6FsZXogd3JvdGU6Cj4+Pj4gRnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ft
c3VuZy5jb20+Cj4+Pj4KPj4+PiBBZGQgc3VwcG9ydCBmb3Igb2ZmbGluZSB0cmFuc2l0aW9uIG9u
IHRoZSB6b25lZCBibG9jayBkZXZpY2UgdXNpbmcgdGhlCj4+Pj4gbmV3IHpvbmUgbWFuYWdlbWVu
dCBJT0NUTAo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVy
LmdvbnpAc2Ftc3VuZy5jb20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2
YWt1bWEuczFAc2Ftc3VuZy5jb20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8
am9zaGkua0BzYW1zdW5nLmNvbT4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXRlc2ggU2hldHR5IDxu
ai5zaGV0dHlAc2Ftc3VuZy5jb20+Cj4+Pj4gLS0tCj4+Pj4gIGJsb2NrL2Jsay1jb3JlLmMgICAg
ICAgICAgICAgIHwgMiArKwo+Pj4+ICBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICB8IDMg
KysrCj4+Pj4gIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAgICAgIHwgMyArKysKPj4+PiAgaW5j
bHVkZS9saW51eC9ibGtfdHlwZXMuaCAgICAgfCAzICsrKwo+Pj4+ICBpbmNsdWRlL2xpbnV4L2Js
a2Rldi5oICAgICAgICB8IDEgLQo+Pj4+ICBpbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaCB8
IDEgKwo+Pj4+ICA2IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstY29yZS5jIGIvYmxvY2svYmxrLWNv
cmUuYwo+Pj4+IGluZGV4IDAzMjUyYWY4YzgyYy4uNTg5Y2JkYWNjNWVjIDEwMDY0NAo+Pj4+IC0t
LSBhL2Jsb2NrL2Jsay1jb3JlLmMKPj4+PiArKysgYi9ibG9jay9ibGstY29yZS5jCj4+Pj4gQEAg
LTE0MCw2ICsxNDAsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqY29uc3QgYmxrX29wX25hbWVbXSA9
IHsKPj4+PiAgCVJFUV9PUF9OQU1FKFpPTkVfQ0xPU0UpLAo+Pj4+ICAJUkVRX09QX05BTUUoWk9O
RV9GSU5JU0gpLAo+Pj4+ICAJUkVRX09QX05BTUUoWk9ORV9BUFBFTkQpLAo+Pj4+ICsJUkVRX09Q
X05BTUUoWk9ORV9PRkZMSU5FKSwKPj4+PiAgCVJFUV9PUF9OQU1FKFdSSVRFX1NBTUUpLAo+Pj4+
ICAJUkVRX09QX05BTUUoV1JJVEVfWkVST0VTKSwKPj4+PiAgCVJFUV9PUF9OQU1FKFNDU0lfSU4p
LAo+Pj4+IEBAIC0xMDMwLDYgKzEwMzEsNyBAQCBnZW5lcmljX21ha2VfcmVxdWVzdF9jaGVja3Mo
c3RydWN0IGJpbyAqYmlvKQo+Pj4+ICAJY2FzZSBSRVFfT1BfWk9ORV9PUEVOOgo+Pj4+ICAJY2Fz
ZSBSRVFfT1BfWk9ORV9DTE9TRToKPj4+PiAgCWNhc2UgUkVRX09QX1pPTkVfRklOSVNIOgo+Pj4+
ICsJY2FzZSBSRVFfT1BfWk9ORV9PRkZMSU5FOgo+Pj4+ICAJCWlmICghYmxrX3F1ZXVlX2lzX3pv
bmVkKHEpKQo+Pj4+ICAJCQlnb3RvIG5vdF9zdXBwb3J0ZWQ7Cj4+Pj4gIAkJYnJlYWs7Cj4+Pj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVkLmMKPj4+PiBp
bmRleCAyOTE5NDM4OGExYmIuLjcwNGZjMTU4MTNkMSAxMDA2NDQKPj4+PiAtLS0gYS9ibG9jay9i
bGstem9uZWQuYwo+Pj4+ICsrKyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+Pj4gQEAgLTQxNiw2ICs0
MTYsOSBAQCBpbnQgYmxrZGV2X3pvbmVfbWdtdF9pb2N0bChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpi
ZGV2LCBmbW9kZV90IG1vZGUsCj4+Pj4gIAljYXNlIEJMS19aT05FX01HTVRfUkVTRVQ6Cj4+Pj4g
IAkJb3AgPSBSRVFfT1BfWk9ORV9SRVNFVDsKPj4+PiAgCQlicmVhazsKPj4+PiArCWNhc2UgQkxL
X1pPTkVfTUdNVF9PRkZMSU5FOgo+Pj4+ICsJCW9wID0gUkVRX09QX1pPTkVfT0ZGTElORTsKPj4+
PiArCQlicmVhazsKPj4+PiAgCWRlZmF1bHQ6Cj4+Pj4gIAkJcmV0dXJuIC1FTk9UVFk7Cj4+Pj4g
IAl9Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+Pj4+IGluZGV4IGYxMjE1NTIzNzkyYi4uNWI5NWM4MWQyYTJkIDEw
MDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+Pj4+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+Pj4+IEBAIC03NzYsNiArNzc2LDkgQEAgYmxrX3N0YXR1c190
IG52bWVfc2V0dXBfY21kKHN0cnVjdCBudm1lX25zICpucywgc3RydWN0IHJlcXVlc3QgKnJlcSwK
Pj4+PiAgCWNhc2UgUkVRX09QX1pPTkVfRklOSVNIOgo+Pj4+ICAJCXJldCA9IG52bWVfc2V0dXBf
em9uZV9tZ210X3NlbmQobnMsIHJlcSwgY21kLCBOVk1FX1pPTkVfRklOSVNIKTsKPj4+PiAgCQli
cmVhazsKPj4+PiArCWNhc2UgUkVRX09QX1pPTkVfT0ZGTElORToKPj4+PiArCQlyZXQgPSBudm1l
X3NldHVwX3pvbmVfbWdtdF9zZW5kKG5zLCByZXEsIGNtZCwgTlZNRV9aT05FX09GRkxJTkUpOwo+
Pj4+ICsJCWJyZWFrOwo+Pj4+ICAJY2FzZSBSRVFfT1BfV1JJVEVfWkVST0VTOgo+Pj4+ICAJCXJl
dCA9IG52bWVfc2V0dXBfd3JpdGVfemVyb2VzKG5zLCByZXEsIGNtZCk7Cj4+Pj4gIAkJYnJlYWs7
Cj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmggYi9pbmNsdWRlL2xp
bnV4L2Jsa190eXBlcy5oCj4+Pj4gaW5kZXggMTZiNTdmYjJiOTljLi5iMzkyMTI2M2MzZGQgMTAw
NjQ0Cj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaAo+Pj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvYmxrX3R5cGVzLmgKPj4+PiBAQCAtMzE2LDYgKzMxNiw4IEBAIGVudW0gcmVxX29w
ZiB7Cj4+Pj4gIAlSRVFfT1BfWk9ORV9GSU5JU0gJPSAxMiwKPj4+PiAgCS8qIHdyaXRlIGRhdGEg
YXQgdGhlIGN1cnJlbnQgem9uZSB3cml0ZSBwb2ludGVyICovCj4+Pj4gIAlSRVFfT1BfWk9ORV9B
UFBFTkQJPSAxMywKPj4+PiArCS8qIFRyYW5zaXRpb24gYSB6b25lIHRvIG9mZmxpbmUgKi8KPj4+
PiArCVJFUV9PUF9aT05FX09GRkxJTkUJPSAxNCwKPj4+Pgo+Pj4+ICAJLyogU0NTSSBwYXNzdGhy
b3VnaCB1c2luZyBzdHJ1Y3Qgc2NzaV9yZXF1ZXN0ICovCj4+Pj4gIAlSRVFfT1BfU0NTSV9JTgkJ
PSAzMiwKPj4+PiBAQCAtNDU2LDYgKzQ1OCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBvcF9pc196
b25lX21nbXQoZW51bSByZXFfb3BmIG9wKQo+Pj4+ICAJY2FzZSBSRVFfT1BfWk9ORV9PUEVOOgo+
Pj4+ICAJY2FzZSBSRVFfT1BfWk9ORV9DTE9TRToKPj4+PiAgCWNhc2UgUkVRX09QX1pPTkVfRklO
SVNIOgo+Pj4+ICsJY2FzZSBSRVFfT1BfWk9ORV9PRkZMSU5FOgo+Pj4+ICAJCXJldHVybiB0cnVl
Owo+Pj4+ICAJZGVmYXVsdDoKPj4+PiAgCQlyZXR1cm4gZmFsc2U7Cj4+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvYmxrZGV2LmggYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCj4+Pj4gaW5k
ZXggYmQ4NTIxZjk0ZGM0Li44MzA4ZDhhMzcyMGIgMTAwNjQ0Cj4+Pj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9ibGtkZXYuaAo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPj4+PiBAQCAt
MzcyLDcgKzM3Miw2IEBAIGV4dGVybiBpbnQgYmxrZGV2X3pvbmVfb3BzX2lvY3RsKHN0cnVjdCBi
bG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKPj4+PiAgCQkJCSAgdW5zaWduZWQgaW50
IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpOwo+Pj4+ICBleHRlcm4gaW50IGJsa2Rldl96b25lX21n
bXRfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLAo+Pj4+ICAJ
CQkJICB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7Cj4+Pj4gLQo+Pj4+ICAj
ZWxzZSAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAqLwo+Pj4+Cj4+Pj4gIHN0YXRpYyBpbmxpbmUg
dW5zaWduZWQgaW50IGJsa2Rldl9ucl96b25lcyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaykKPj4+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmggYi9pbmNsdWRlL3VhcGkv
bGludXgvYmxrem9uZWQuaAo+Pj4+IGluZGV4IGE4Yzg5ZmU1OGY5Ny4uZDA5NzhlZTEwZmM3IDEw
MDY0NAo+Pj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCj4+Pj4gKysrIGIv
aW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPj4+PiBAQCAtMTU1LDYgKzE1NSw3IEBAIGVu
dW0gYmxrX3pvbmVfYWN0aW9uIHsKPj4+PiAgCUJMS19aT05FX01HTVRfRklOSVNICT0gMHgyLAo+
Pj4+ICAJQkxLX1pPTkVfTUdNVF9PUEVOCT0gMHgzLAo+Pj4+ICAJQkxLX1pPTkVfTUdNVF9SRVNF
VAk9IDB4NCwKPj4+PiArCUJMS19aT05FX01HTVRfT0ZGTElORQk9IDB4NSwKPj4+PiAgfTsKPj4+
Pgo+Pj4+ICAvKioKPj4+Pgo+Pj4KPj4+IEFzIG1lbnRpb25lZCBpbiBwcmV2aW91cyBlbWFpbCwg
dGhlIHVzZWZ1bG5lc3Mgb2YgdGhpcyBpcyBkdWJpb3VzLiBQbGVhc2UKPj4+IGVsYWJvcmF0ZSBp
biB0aGUgY29tbWl0IG1lc3NhZ2UuIFN1cmUgTlZNZSBaTlMgZGVmaW5lcyB0aGlzIGFuZCB3ZSBj
YW4gc3VwcG9ydAo+Pj4gaXQuIEJ1dCB3aXRob3V0IGEgZ29vZCB1c2UgY2FzZSwgd2hhdCBpcyB0
aGUgcG9pbnQgPwo+Pgo+PiBVc2UgY2FzZSBpcyB0byB0cmFuc2l0aW9uIHpvbmVzIGluIHJlYWQt
b25seSBzdGF0ZSB0byBvZmZsaW5lIHdoZW4gd2UKPj4gYXJlIGRvbmUgbW92aW5nIHZhbGlkIGRh
dGEuIEl0IGlzIGVhc2llciB0byBleHBsaWNpdGx5IG1hbmFnaW5nIHpvbmVzCj4+IHRoYXQgYXJl
IG5vdCB1c2FibGUgYnkgaGF2aW5nIGFsbCB1bmRlciB0aGUgb2ZmbGluZSBzdGF0ZS4KPgo+VGhl
biBhZGRpbmcgYSBzaW1wbGUgQkxLWk9ORU9GRkxJTkUgaW9jdGwsIHNpbWlsYXIgdG8gb3Blbiwg
Y2xvc2UsIGZpbmlzaCBhbmQKPnJlc2V0LCB3b3VsZCBiZSBlbm91Z2guIE5vIG5lZWQgZm9yIGFs
bCB0aGUgbmV3IHpvbmUgbWFuYWdlbWVudCBpb2N0bCB3aXRoIGZsYWdzCj5wbHVtYmluZy4KCk9r
LiBXZSBjYW4gYWRkIHRoYXQgdGhlbi4KCk5vdGUgdGhhdCB6b25lIG1hbmFnZW1lbnQgaXMgbm90
IG1vdGl2YXRlZCBieSB0aGlzIHVzZSBjYXNlIGF0IGFsbCwgYnV0Cml0IG1hZGUgc2Vuc2UgdG8g
aW1wbGVtZW50IGl0IGhlcmUgaW5zdGVhZCBvZiBhcyBhIG5ldyBCTEtaT05FT0ZGTElORQpJT0NU
TCBhcyBaQUMvWkJDIHVzZXJzIHdpbGwgbm90IGJlIGFibGUgdG8gdXNlIGl0IGVpdGhlciB3YXku
Cgo+Cj4+Cj4+Pgo+Pj4gc2NzaSBTRCBkcml2ZXIgd2lsbCByZXR1cm4gQkxLX1NUU19OT1RTVVBQ
IGlmIHRoaXMgb2ZmbGluaW5nIGlzIHNlbnQgdG8gYQo+Pj4gWkJDL1pBQyBkcml2ZS4gTm90IG5p
Y2UuIEhhdmluZyBhIHN5c2ZzIGF0dHJpYnV0ZSAibWF4X29mZmxpbmVfem9uZV9zZWN0b3JzIiBv
cgo+Pj4gdGhlIGxpa2UgdG8gaW5kaWNhdGUgc3VwcG9ydCBieSB0aGUgZGV2aWNlIG9yIG5vdCB3
b3VsZCBiZSBuaWNlci4KPj4KPj4gV2UgY2FuIGRvIHRoYXQuCj4+Cj4+Pgo+Pj4gRG9lcyBvZmZs
aW5nIEFMTCB6b25lcyBtYWtlIGFueSBzZW5zZSA/IEJlY2F1c2UgdGhpcyBwYXRjaCBkb2VzIG5v
dCBwcmV2ZW50IHRoZQo+Pj4gdXNlIG9mIHRoZSBSRVFfWk9ORV9BTEwgZmxhZ3MgaW50cm9kdWNl
ZCBpbiBwYXRjaCAyLiBQcm9iYWJseSBub3QgYSBnb29kIGlkZWEgdG8KPj4+IGFsbG93IG9mZmxp
bmluZyBhbGwgem9uZXMsIG5vID8KPj4KPj4gQUZBSUsgdGhlIHRyYW5zaXRpb24gdG8gb2ZmbGlu
ZSBpcyBvbmx5IHZhbGlkIHdoZW4gY29taW5nIGZyb20gYQo+PiByZWFkLW9ubHkgc3RhdGUuIEkg
ZGlkIHRoaW5rIG9mIGFkZGluZyBhIGNoZWNrLCBidXQgSSBjYW4gc2VlIHRoYXQgb3RoZXIKPj4g
dHJhbnNpdGlvbnMgZ28gZGlyZWN0bHkgdG8gdGhlIGRyaXZlciBhbmQgdGhlbiB0aGUgZGV2aWNl
LCBzbyBJIGRlY2lkZWQKPj4gdG8gZm9sbG93IHRoZSBzYW1lIG1vZGVsLiBJZiB5b3UgdGhpbmsg
aXQgaXMgYmV0dGVyLCB3ZSBjYW4gYWRkIHRoZQo+PiBjaGVjay4KPgo+TXkgcG9pbnQgd2FzIHRo
YXQgdGhlIFJFUV9aT05FX0FMTCBmbGFnIHdvdWxkIG1ha2Ugbm8gc2Vuc2UgZm9yIG9mZmxpbmlu
ZyB6b25lcwo+YnV0IHRoaXMgcGF0Y2ggZG9lcyBub3QgaGF2ZSBhbnl0aGluZyBjaGVja2luZyB0
aGF0LiBUaGVyZSBpcyBubyBwb2ludCBpbgo+c2VuZGluZyBhIGNvbW1hbmQgdGhhdCBpcyBrbm93
biB0byBiZSBpbmNvcnJlY3QgdG8gdGhlIGRyaXZlLi4uCgpJIHdpbGwgYWRkIHNvbWUgZXh0cmEg
Y2hlY2tzIHRoZW4gdG8gZmFpbCBlYXJseS4gSSBhc3N1bWUgdGhlc2Ugc2hvdWxkCmJlIGluIHRo
ZSBOVk1lIGRyaXZlciBhcyBpdCBpcyBOVk1lLXNwZWNpZmljLCByaWdodD8KCkphdmllcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
