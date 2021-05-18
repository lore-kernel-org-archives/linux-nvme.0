Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF7C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 19:05:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3926100C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 19:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3926100C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KRmgHuwf8sGn/8QaYxViU++IIRFUffONPX8afG+b8FE=; b=gWHHdcQwRpsV8t0AF7UgO3Q2S
	x73o/0tWuBDOlypQrjaarKmNTDjnH3LamK8eyT0dp2Q+dxq4YquDlNioGglbEaecgiN7tOtkXD8jd
	HDYzW4aoANK1O2AXR75+QjI0eNisPRDHVZG4b+mz/VexioQkJeq7nAiQZYs6+OTQPPFy/i84odIcc
	ZuLLljnTqCBFuHiwGH7vPHp3dkwUznnaHFnpDTwRmJQ6Wzi0UHm6W0l3wdbRvFxjFBksM2+2z/LJ3
	lv7Bq6UB8TIFx9u1WJ2vlSo7b9iPETjUbWmNvSAeGujr8bMqadfiCzoejivEeG5Gf6IkDSd7n1nyE
	+Sj8Znpxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj51F-001h4v-1h; Tue, 18 May 2021 19:04:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj518-001h3j-5p
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 19:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=VWqvfvummIDKdiQE3+3z9jYoBFCrTE4EPYctaLdzlMo=; b=aR0ZJ/fZTCBgD+a39QJUhv/xYL
 8cJ9STEkYVcdXGNBJnxT81y4GEB+3uKZCFJSJate3/2JdkN9OCBjP2y22oJLpbqQ15Y4GLMZHtm8L
 DymZAA9tZ7wzffcx1eg2Cc+DszRDx//PuAtWv6LXmg4mrXbesY7NuU312h0y6OqS/8Bi+ec0Pbmy+
 orRadvrcmbf3Ham2PG0iJEPoBYkR+zdQZDaOMDHCUONNDYBmkEAprTdo7spq4qlH5hSV/2jyfbjTC
 L7WH3+nGeptkSa8eChdfbm+drzVe8QsK2bb+ectv8IOPhAKHmitI6I+XdDOcu2qfmkkUqiwD+q+b8
 T7fejWwQ==;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj515-00Eu2c-Am
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 19:04:32 +0000
Received: by mail-wr1-f41.google.com with SMTP id i17so11374384wrq.11
 for <linux-nvme@lists.infradead.org>; Tue, 18 May 2021 12:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VWqvfvummIDKdiQE3+3z9jYoBFCrTE4EPYctaLdzlMo=;
 b=cFhIGsj5IysWbqOudx4HedtRoIj3KIEYKAACewoq7hZxdfTdssWqR6t6O91aghqgen
 v/9+mkps6zg5IxIrgK048RyEgEAuypjGi3gZRz2e1vG4CcObnMjLWv/E4UXrTAghO4N3
 CILKyIGuqClLJxLXaRfD4DcKPBFw5Q6kNSKhS8lMLTJpVYHzkWewQYytx9sUFOXHRalZ
 8yR+gb1F33G4u97/K5SpMnciHX/b3TV7E4I9qOWVWdRxQaK3rURqLa6ZeeHjaQ7JtNbN
 8547JnrQbBdMiowSq9GtuZyowY6LWCic69YTSN99rna0bN8r/0920z3bFKutVXVJh8Ak
 eoAw==
X-Gm-Message-State: AOAM530Qrj82mPjLuPiiRYuY4FJ23Dmo20mpuluFzJRszL4M4IhQCSas
 /o1VFzkm7ad26nRneb1WfWHZPm6xpio=
X-Google-Smtp-Source: ABdhPJxijp1PI6iU0j1iqYAEjU4EY9a3leX9kynfrWsmyOXcPkYyfaNUngpFyiWZiwnW5+zYvMdb3Q==
X-Received: by 2002:a05:6000:108f:: with SMTP id
 y15mr9090965wrw.115.1621364669036; 
 Tue, 18 May 2021 12:04:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f888:e3f1:214b:6edc?
 ([2601:647:4802:9070:f888:e3f1:214b:6edc])
 by smtp.gmail.com with ESMTPSA id a18sm3479756wmb.13.2021.05.18.12.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 12:04:28 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
 <deb1d103-8fc6-6f38-f9e9-d3a327ea5678@grimberg.me>
 <b7f6c507-d2a4-4231-737e-04e1c8a3df9e@suse.de>
 <d81323b2-a914-4dee-718a-39728d2e2039@grimberg.me>
 <799078b2-0409-53ea-c462-b074b69d8a57@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <79b986da-249d-8bdf-501e-b73ea38acbcb@grimberg.me>
Date: Tue, 18 May 2021 12:04:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <799078b2-0409-53ea-c462-b074b69d8a57@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_120431_390957_052A0CD0 
X-CRM114-Status: GOOD (  14.29  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4+
Pj4gYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4+Pj4+IGluZGV4IDA1NTE3OTY1
MTdlNi4uZWNjOTliZDVmOGFkIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L211bHRpcGF0aC5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMK
Pj4+Pj4+PiBAQCAtMTAwLDggKzEwMCwxMSBAQCB2b2lkIG52bWVfa2lja19yZXF1ZXVlX2xpc3Rz
KHN0cnVjdCBudm1lX2N0cmwKPj4+Pj4+PiAqY3RybCkKPj4+Pj4+PiAgwqDCoMKgwqDCoMKgIGRv
d25fcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoCBs
aXN0X2Zvcl9lYWNoX2VudHJ5KG5zLCAmY3RybC0+bmFtZXNwYWNlcywgbGlzdCkgewo+Pj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoCBpZiAobnMtPmhlYWQtPmRpc2spCj4+Pj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAga2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVxdWV1ZV93b3Jr
KTsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFucy0+aGVhZC0+ZGlzaykKPj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
a2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVxdWV1ZV93b3JrKTsKPj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgaWYgKGN0cmwtPnN0YXRlID09IE5WTUVfQ1RSTF9MSVZFKQo+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRpc2tfdWV2ZW50KG5zLT5oZWFkLT5kaXNrLCBLT0JK
X0NIQU5HRSk7Cj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoCB9Cj4+Pj4+Pgo+Pj4+Pj4gSSBhc2tlZCB0
aGlzIG9uIHYxLCBpcyB0aGlzIG9ubHkgbmVlZGVkIGZvciBtcGF0aCBkZXZpY2VzPwo+Pj4+Pgo+
Pj4+PiBZZXM7IHdlIG5lZWQgdG8gc2VuZCB0aGUgS09CSl9DSEFOR0UgZXZlbnQgb24gdGhlIG1w
YXRoIGRldmljZSBhcyBpdCdzCj4+Pj4+IG5vdCBiYWNrZWQgYnkgaGFyZHdhcmUuIFRoZSBvbmx5
IG5vbi1tdWx0aXBhdGhlZCBkZXZpY2VzIEkndmUgc2VlbiBzbwo+Pj4+PiBmYXIgYXJlIFBDSSBk
ZXZpY2VzIHdoZXJlIGV2ZW50cyBhcmUgZ2VuZXJhdGVkIGJ5IHRoZSBQQ0kgZGV2aWNlCj4+Pj4+
IGl0c2VsZi4KPj4+Pgo+Pj4+IEFuZCBmb3IgZmFicmljcz8KPj4+Cj4+PiBObyBldmVudHMgd2hh
dHNvZXZlci4KPj4+IEhlbmNlIHRoaXMgcGF0Y2guCj4+Cj4+IE5vbi1tdWx0aXBhdGggZmFicmlj
cyBJIG1lYW50Cj4gCj4gSSBrbm93LiBBcyBzYWlkLCBJJ3ZlIG5ldmVyIHNlZW4gdGhlbS4gRGlk
IHlvdT8KPiAKPiBJbiBmYWN0LCBJIHdvdWxkbid0IGJlIHN1cnByaXNlZCBpZiB0aGF0IHdvdWxk
IG9wZW4gYSBjb21wbGV0ZWx5Cj4gZGlmZmVyZW50IGNhbiBvZiB3b3Jtcy4KCkkndmUgc2VlbiBz
dWNoLCBidXQgSSdtIGZpbmUgd2l0aCBpZ25vcmluZyB0aGVtLi4uCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
