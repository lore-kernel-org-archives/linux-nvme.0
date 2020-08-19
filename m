Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F30C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:26:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA2E20738
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzpCRdZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA2E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=waIwmVYAQ59xrx5kjImROdRAnoP35JYyg4qrtdOvi6c=; b=XzpCRdZj21PUGJMKCtUT86s6n
	baUdKAM0WRdCJ5Uni70tqoeh872oyx99ed/iFb5+WN0w9sVBfffCEr0DO8TxSr91vDTrjZmOJemlN
	iMkmz2jToHwaiavO9sdRpY6oGeZHh5ro0msHN4JOfUo7I6DOiuRU3an6Pi6EdgbUM/nt58U7JohSk
	PFnXqnJUA0CVeZxvnAj7RHkn0brvhZ57ssHEYhkFxB+ukMuJgTUmLGmAygygFIn/mLXMHmXAE3r6r
	cVBDKsJQNxoUUyFL6O1FHPKpJqtNu35owmvwFxAEzpAV1TSDr8NBTgqayH3rrw5iYjIodkkPziLfi
	iwxtwfXnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Bw0-0004IO-Cl; Wed, 19 Aug 2020 00:26:32 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Bvw-0004I2-Sw
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 00:26:30 +0000
Received: by mail-pf1-f194.google.com with SMTP id y206so10760311pfb.10
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 17:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f6YwFzalBM92uepEP+mEoXol5SmZq+uMo7gIzPPYxug=;
 b=AhKvXsTR9xm7wXZT5QfyYCcppRc0ainFi0a3Jaz5cBMxD6JCRCZbDlE00XaaAmJNVB
 Ega3P3ks0IlSD550X82cjk46z3sDQj2jf/G4hoeM0W3+H/cc4MW4/RAlqlsz3110xcB/
 ygux8HvbISxKtdmlj1o9r1i/6xRSAhJepd4uI4HFqu5kgfDlw+lHv3Wj5RqZxZP/gwNo
 sEyvy4Ar9wkA8ftO9T3/cMfbGfFquik/5/S3U1sVODmNhduMC24purg6PM5mgoTHyeKU
 ynrcQzITjDD+lAMhblfytGfgjwlpD/8h6TclesFK4/rYqGwNQeCASA8P1VTpt0mkRKM6
 N00g==
X-Gm-Message-State: AOAM5307i+L9TUEQ6H0fDk2fKvKyuASCHWNtOovcow4Ily/SrVqlwJxM
 UojBGiQiEfbhy7Q7c53Ioa8=
X-Google-Smtp-Source: ABdhPJwInmxHtw85CvzOjlKZGds9Sfx8GT7fVyB6c3nE+laVLfjTNcUHQOITzOJxrMFrJmYarF6afQ==
X-Received: by 2002:a62:8881:: with SMTP id
 l123mr16501599pfd.186.1597796787757; 
 Tue, 18 Aug 2020 17:26:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bcd0:fda9:d34d:a3ab?
 ([2601:647:4802:9070:bcd0:fda9:d34d:a3ab])
 by smtp.gmail.com with ESMTPSA id b78sm26428469pfb.144.2020.08.18.17.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 17:26:26 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me> <20200814065230.GD1719@lst.de>
 <b42e1454-838b-6bd3-0448-97f45ee02ea5@grimberg.me>
 <88d4cda8-798a-15bb-9c72-9a382291adfb@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2e48d252-33db-2d6f-90cc-7aefe0f8324e@grimberg.me>
Date: Tue, 18 Aug 2020 17:26:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88d4cda8-798a-15bb-9c72-9a382291adfb@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_202629_150424_DA4617BC 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+Pj4gQEAgLTExODUsNiArMTE4
NSw3IEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9lcnJvcl9yZWNvdmVyeShzdHJ1Y3QgCj4+Pj4g
bnZtZV9yZG1hX2N0cmwgKmN0cmwpCj4+Pj4gwqDCoMKgwqDCoCBpZiAoIW52bWVfY2hhbmdlX2N0
cmxfc3RhdGUoJmN0cmwtPmN0cmwsIE5WTUVfQ1RSTF9SRVNFVFRJTkcpKQo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm47Cj4+Pj4gwqAgK8KgwqDCoCBkZXZfd2FybihjdHJsLT5jdHJsLmRl
dmljZSwgInN0YXJ0aW5nIGVycm9yIHJlY292ZXJ5XG4iKTsKPj4+Cj4+PiBTaG91bGQgdGhpcyBy
ZWFsbHkgYmUgYSB3YXJuaW5nP8KgIEknZCB0dXJuIHRoaXMgZG93biB0byBfaW5mby4KPj4KPj4g
SSBjYW4gZG8gdGhhdC4gYnV0IGdpdmVuIHRoYXQgdGhpcyBpcyBhIGZpeCwgSSdsbCB0byBkbyB0
aGF0Cj4+IGFzIGEgc2VwYXJhdGUgcGF0Y2guCj4gCj4gSSd2ZSBmb3VuZCB0aGUgaW1wYWN0cyBv
ZiB0aGUgZXJyb3JfcmVjb3ZlcnkvY3RybCByZXNldCBvbiBhYm9ydGluZyBpb3MgCj4gdG8gYmUg
YSBzaWduaWZpY2FudCBldmVudCwgYW5kIGFzIGl0IHNob3VsZCBiZSBoYXBwZW5pbmcgcmFyZWx5
LCBpdCB3YXMgCj4gbXVjaCBiZXR0ZXIgdG8gcHV0IGl0IGFzIGEgd2FybmluZyB0aGFuIGFzIGFu
IGluZm8uCgpXZSBhbHJlYWR5IGxvZyBhIHdhcm5pbmcgaW4gdGhlIHRpbWVvdXQgaGFuZGxlci4g
SSBjYW4ga2VlcCBpdCBhcyBpcywKcHJldHR5IGluZGlmZmVyZW50IGFib3V0IGl0LgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
