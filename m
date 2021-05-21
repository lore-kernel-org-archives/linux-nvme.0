Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D7C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:49:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E4161002
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E4161002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJxYHBPNSZopDr/DvBA8oWEmvwuReglie5SDCGESbZk=; b=dzgiXmSSv6qAHAeCKd53buNmFC
	3rKQM7lod9ErJ/O8zf3Qr8xB4fHfUAovtuAvk5eESZ5mrdRGzp1FLyPTe7b5tBl2LffiNFY815g6X
	dIie+AkbQuqxAlo1PRI1pM8mwm+ewabw6eWs8LFpeqXbp8+oU+6dtWlZst/qhxtqHvR5kAG17bv7F
	S3L845XDW8HfrrvqXZB2xziZJPoeRTZIzfGjQ/3qGQL/aUxnmZeo0oZe+Ep1JeEtWKwZOrpRl7/Lu
	5J1EEgiu6bs+lwXK33xnVZv/iG8xP4//RfAknCr0f5I8+0ZJJ8Vv9uj32VDMuq9FNljjmeBCbNOD6
	FqGlvqNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkC4Z-0015sX-2h; Fri, 21 May 2021 20:48:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkC4S-0015ri-BZ
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:48:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=IYEDyJpzlH16NUFnVBr2x6MVcQHYA4/4FQXcDfsHuao=; b=2m3G4qr7VDOVAI69cymAFGLq+a
 3uQGNLtdvSjd6CBcwk5gJWNaVAGNsfD/NaeP5nm2/NGb9UljagR7SKmNVBmpaJsDbLDLbaGWPTzAx
 FMY+OlYBV95vSQ97jv++A8V0vqAt/6HS/XtNC4HK5/z8Ppj+BkkpYhvLhun2BLpn27j51XtjP/0Sp
 nt9RI+ZHM0jl46yRZV+NMsVCF+kQv+hT4Agj+zG1HMvwXP9OUvV0uho4NcnbDJFpwFDrnfPox0Wxm
 8jhZlOhxxVtsp8xAN+9h+nbI2jczxL6xxgnGE1rfb8hYvJUdazN6oVF7ZkI/p1QX1OvNT5TX/SCDB
 jO0xeCKA==;
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkC4P-00HQJq-P1
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:48:35 +0000
Received: by mail-pg1-x52a.google.com with SMTP id q15so15154456pgg.12
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IYEDyJpzlH16NUFnVBr2x6MVcQHYA4/4FQXcDfsHuao=;
 b=iB8tqSeRybGJ4WHFN/UUUtXHgvFJcHZZ4pnaB/GHOkeG5N+mghWCA7K57NjywEIix/
 5qYdxSWMb88M8opJwXzniauDpwDtAiaAG34IqdAPZqdyG4RYPm8G4+SMDiiGbiN6HUdD
 NG/8ey166DPF5asBu/29pN+N8TrcQ+jLCx7+xZQOklG684mES6m7j6dbXW/RThyyB/Pz
 TJ11qIG07XVLul/cfxzy9ekcWmJdfrNesae43qLTG71lXCFIJRz0ubntqUfYVuqRWJBt
 +YlMjtySDAD+VvoLysnWNaypwmKMfV7TsB9A6w1DPhq4Ut/pT9nJcv96CYh+D9pQulHO
 Q8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IYEDyJpzlH16NUFnVBr2x6MVcQHYA4/4FQXcDfsHuao=;
 b=N0p+YZIO1/kAFJW3uBmkyaZ6R8V94//bS2tqkO3YRnkMwAPGnJhfuj5n7/bGk1UQEK
 VjzAycdsYW68K6xjAaQOYRXmHTVWDRwORD3h3KuWY7PB2g03LOYKJ6W92VJOZ32LaxjI
 pWSOJBSSIfrPYqN2Jh6n2iVXqXlsiMkeSzpsoft5JB7ZX0NkP7yv66StUHK0ZYRTglZ3
 Nj5wi2lL0S6YgTlyws/uVPVqrupnEn8JcKxcWOxLQT/0oRjCcjtgLczpWi7ZvLTgsi62
 SNqUOj6zT0ADkCxFpuAS0E2HDftf4SkSWeQfw6ZVDbH+vstGO3gzPT4HMzIEVvE1k4uD
 R5Gw==
X-Gm-Message-State: AOAM533gFuqSgavH/5tKIYNo1PE2cFQJBwDhhR8plSZ/dz7LO42UVuLj
 zFwdIXzslbX0fNcto6/AuYCLRnjDeQY=
X-Google-Smtp-Source: ABdhPJwsjfJyfV3159kYzBekID4wzufWz1KLPgydUJwGe9YBltfY6AHKFtAFi++28DQJmR788gorKw==
X-Received: by 2002:a63:b907:: with SMTP id z7mr627764pge.112.1621630110866;
 Fri, 21 May 2021 13:48:30 -0700 (PDT)
Received: from [10.230.128.89] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id x184sm5400858pgb.36.2021.05.21.13.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 13:48:30 -0700 (PDT)
Subject: Re: [PATCH] nvme/fc: Short-circuit reconnect retries
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, James Smart
 <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20210521082300.146648-1-hare@suse.de>
 <4348b2a1-0861-0020-e873-0680812c4849@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <373a627a-2c14-32c8-935b-6aa60ba22272@gmail.com>
Date: Fri, 21 May 2021 13:48:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4348b2a1-0861-0020-e873-0680812c4849@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_134833_833886_E6E44227 
X-CRM114-Status: GOOD (  12.40  )
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

T24gNS8yMS8yMDIxIDE6MTcgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IMKgwqDCoMKg
wqAgaWYgKHJlY29uICYmIG52bWZfc2hvdWxkX3JlY29ubmVjdCgmY3RybC0+Y3RybCkpIHsKPj4g
QEAgLTMyODYsMTIgKzMyOTAsMTcgQEAgbnZtZV9mY19yZWNvbm5lY3Rfb3JfZGVsZXRlKHN0cnVj
dCAKPj4gbnZtZV9mY19jdHJsICpjdHJsLCBpbnQgc3RhdHVzKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcXVldWVfZGVsYXllZF93b3JrKG52bWVfd3EsICZjdHJsLT5jb25uZWN0X3dvcmssIHJlY29u
X2RlbGF5KTsKPj4gwqDCoMKgwqDCoCB9IGVsc2Ugewo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHBv
cnRwdHItPnBvcnRfc3RhdGUgPT0gRkNfT0JKU1RBVEVfT05MSU5FKQo+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXZfd2FybihjdHJsLT5jdHJsLmRldmljZSwKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAiTlZNRS1GQ3slZH06IE1heCByZWNvbm5lY3QgYXR0ZW1wdHMgKCVk
KSAiCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInJlYWNoZWQuXG4iLAo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPmNudW0sIGN0cmwtPmN0cmwubnJf
cmVjb25uZWN0cyk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBlbHNlCj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAocG9ydHB0ci0+cG9ydF9zdGF0ZSA9PSBGQ19PQkpTVEFURV9PTkxJTkUpIHsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0YXR1cyA+IDAgJiYgKHN0YXR1cyAmIE5WTUVfU0NfRE5S
KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybihjdHJsLT5jdHJs
LmRldmljZSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk5W
TUUtRkN7JWR9OiByZWNvbm5lY3QgZmFpbHVyZVxuIiwKPiAKPiBNYXliZSB3b3J0aCB0byBwcmlu
dCB0aGUgc3RhdHVzIGhlcmU/Cj4gCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2QsCj4gUmV2aWV3ZWQt
Ynk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gCgpBZ3JlZSB3aXRoIFNhZ2kg
dGhhdCB0aGUgcHJpbnQgc2hvdWxkIGhhdmUgdGhlIHN0YXR1cy4KClJldmlld2VkLWJ5OiAgSmFt
ZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgoKLS0gamFtZXMKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
