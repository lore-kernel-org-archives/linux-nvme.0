Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7048AC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:06:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEB12072D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zbqD82tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEB12072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2o/XMSVbIqKMFVZN8pVRjEHfhoCnQXvs2c9JdYgCWeA=; b=zbqD82tutiGbi42k+/Wqy3ZOz
	ILJHxBnAu8qLJvOVwDDiyfiraEPuoovKMeDLViLXiUVUs4ELTJU8Mt/qR2ueNmcIvKGdEIt+WJisb
	UIqvnhqQsv8+iwMOYtdoT90439Ey27h6M5HdW6eAoW+pxQqoSIBes0B47rKfEDG6Bu2jch0Co4cIX
	ilhyFztIuMeaVSXOHC38CJ1n9iy3WtHHZBTpWl/ijCthJe9AUsmUOWZ3uriy3SCTkS4pchmEJi2jS
	6ffQtNESwGHW56Bu+O/kGXTlLQDjjk9a1GwL/IFvTmBZvVjcEszvAdz8rbnj3/NBqujfOB5wweMfe
	92e6N389A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kA7V8-0003DU-G7; Mon, 24 Aug 2020 08:06:46 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA7V6-0003Cv-49
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 08:06:45 +0000
Received: by mail-pj1-f67.google.com with SMTP id i13so3268045pjv.0
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 01:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kW+MA1hBX7U61RWAgFiphzglMIPtGy+f1EPxnrHsvY8=;
 b=cK1pXwyI3+e3TJhWVO+R1cSgrqkK3PQYo9HLg529Cd/T9ipAxkSML7AQL26goTaid5
 /nGEesdRu/gHLjbwpiatHtxJSe6WrZctIV+/ptuSynGs0gt54Cfc6as/2uqT/TSau0C+
 TEP0O9P7X+8u/43HSZamYOQ69vmUJAlnz3QPm1qMkJFEpQoBzhppmVfNbZbGsyS2UEir
 9iJ6iUm3eM6YXsAxPi9UXKI19RoS+VIflKosO7R1rrojT5tuR340LC926MK7c4LeX8pj
 qDjengrpDYDtn9jK8Asrdf/Pl1mX7AGo2bDpNOgDKljWpe+TfM0iv859yiXy12R3U8T4
 4NLQ==
X-Gm-Message-State: AOAM531Cq2Z2cCH5UqBnUK0Rt7r27YG1S5dStLqS7pbTEg9cs+jT0uj9
 0ef7CBP4xBWLed/Au52S7qDwR09CzatZ6g==
X-Google-Smtp-Source: ABdhPJzPyYS4PH/E35L2Npylo8nQmfdS6nCDzYwtUAhO7PuTgWvmYx1utcvBuj/XloyDFpuKuMob/w==
X-Received: by 2002:a17:902:9b8d:: with SMTP id
 y13mr3102261plp.279.1598256402513; 
 Mon, 24 Aug 2020 01:06:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id x17sm10161566pfn.160.2020.08.24.01.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 01:06:41 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <43d6ca66-0a42-0aff-ef22-8b3c08cf3bde@grimberg.me>
 <6540c183-9b93-1635-a3dd-c925bb94c47a@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bc216545-182d-eb00-0292-8348b05e39b1@grimberg.me>
Date: Mon, 24 Aug 2020 01:06:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6540c183-9b93-1635-a3dd-c925bb94c47a@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_040644_222534_28CF47B3 
X-CRM114-Status: GOOD (  19.36  )
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

Cj4+Pj4gSSBzdGlsbCBkaXNsaWtlIGFueSByYW5kb20gaW9jdGxzIGNvbWluZyBpbiB3aGlsZSB3
ZSdyZSBzdGlsbCAKPj4+PiBpbml0aWFsaXppbmcKPj4+PiB0aGUgY29udHJvbGxlci4KPj4+Cj4+
PiBBZ3JlZWQuCj4+Pgo+Pj4+IMKgwqAgTG9va2luZyBhdCB0aGUgZmxvdyAtIEkgd291bGRuJ3Qg
d2FudCB0aGVtIHRvIGJlIGFsbG93ZWQKPj4+PiB1bnRpbCBhZnRlciBudm1lX2luaXRfaWRlbnRp
ZnkoKSBpcyBjb21wbGV0ZS4gRXNwZWNpYWxseSBpZiB0aGUgCj4+Pj4gaW9jdGxzIGFyZQo+Pj4+
IGRvaW5nIHN1YnN5c3RlbSBvciBjb250cm9sbGVyIGR1bXBpbmcgb3IgdXNpbmcgY29tbWFuZHMg
dGhhdCBzaG91bGQgYmUKPj4+PiBjYXBwZWQgYnkgdmFsdWVzIHNldCBieSBudm1lX3F1ZXVlX2xp
bWl0cygpLsKgwqAgQnV0LCBpZiB3ZSdyZSBnb2luZyB0bwo+Pj4+IGFsbG93IG52bWVfaW5pdF9p
ZGVudGlmeSB0aGUgYWRtaW5fcSBuZWVkcyB0byBiZSB1bnF1aWVzY2VkLgo+Pj4+Cj4+Pj4gU28g
SSdtIHN0aWxsIHZvdGluZyBmb3IgdGhlIGFkbWluIHF1ZXVlIGV4Y2VwdGlvbi4KPj4+Cj4+PiBB
bmQgSSByZWFsbHkgZG9uJ3QgbGlrZSB0aGUgYWRtaW4gcXVldWUgc3BlY2lhbCBjYXNlLsKgIFdo
YXQgaXMgdGhlCj4+PiBhZHZhbnRhZ2Ugb2YgbGV0dGluZyB1c2VyIHNwYWNlIHBhc3N0aHJvdWdo
IEkvTyBjb21tYW5kcyBpbiBhdCB0aGlzCj4+PiBwb2ludCBpbiB0aW1lPwo+Pgo+PiBXZSBuZWVk
IHRvIHBhc3MgaW4gbm9ybWFsIEkvTyBjb21tYW5kcyBmb3Igc3VyZSBpbiBvcmRlciB0byBoYXZl
IGEKPj4gcm9idXN0IHJlc2V0IGFuZCBlcnJvciByZWNvdmVyeSAod2hhdCBpbiBnZW5lcmFsIHRo
ZSBwYXRjaHNldAo+PiBhZGRyZXNzZXMpLiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4g
RlMgSS9PIGNvbW1hbmRzIGFuZAo+PiBwYXNzdGhydSBJL08gY29tbWFuZHM/IEluIGZhY3QsIHVz
ZXIgcGFzc3RocnUgSS9PIGNvbW1hbmRzIHdpbGwgbmV2ZXIKPj4gZXhlY3V0ZSBiZWZvcmUgbnZt
ZV9pbml0X2lkZW50aWZ5KCkgYmVjYXVzZSB3ZSBhbHdheXMgc3RhcnQKPj4gdGhlIEkvTyBxdWV1
ZXMgYWZ0ZXIgdGhhdC4KPj4KPj4gTGV0J3MgbG9vayBhdCBwY2ksIGRvIHdlIGhhdmUgdGhlIHNh
bWUgZW5mb3JjZW1lbnQgZm9yIHBhc3N0aHJ1Cj4+IGNvbW1hbmRzPyBXaGF0J3Mgc3BlY2lhbCBh
Ym91dCBmYWJyaWNzIHRoYXQgd2UgbmVlZCB0byBkZW55Cj4+IHRoZXNlIGNvbW1hbmRzIGZyb20g
Z29pbmcgdGhyb3VnaD8KPiAKPiBzaG9ydCBhbnN3ZXIgLSB0aW1pbmcvbGF0ZW5jeSBhbmQgbXVj
aCBtdWNoIGxvd2VyIGNoYW5jZSBvZiBmYWlsdXJlLgoKU28gYXJlIHlvdSBzYXlpbmcgdGhlcmUg
aXMgYSBidWcgaW4gcGNpIHRoYXQgaXMgaGlkaW5nPwoKPiBJIGFsc28gZG9uJ3QgdGhpbmsgcGVv
cGxlIGFyZSBxdWVyeWluZyBwY2kgKGxvY2FsIGF0dGFjaGVkIGRyaXZlcnMpIGxpa2UgCj4gdGhl
eSBhcmUgZmFicmljIGF0dGFjaG1lbnRzLgoKTm90IHN1cmUgYWJvdXQgdGhhdCBhdCBhbGwsIEkn
ZCBldmVuIHNwZWN1bGF0ZSBpdCBpcyB0aGUgb3RoZXIgd2F5CmFyb3VuZC4uLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
