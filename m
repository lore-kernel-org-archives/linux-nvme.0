Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B155C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:39:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C25F64DEE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C25F64DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s97Rx7y/bMAbH2Pmt2PPfHYLfLI/hVsSqDVoROv03Iw=; b=d8mGL41p420qPN9R/uhSouf2W
	u69Wb3kpyfcBLtxdlr0Y0Gmg1aLYQ3B8j51/KmBw7LCKdtjxe9R/H7NF9EjLixJELpkEnass6pk53
	14IoV40sBnVu2wnRPdvBJp3KX/SeMVKVsJT3q0d9xrm6TWjDHq5duH0QgLm+52F8LstKYI6iw6nLp
	k6OYfp/XPYOaP854+8hapvGG/P2Hy8fenSslKOsPFdEnaGxy3SkNswWvTrdzDdTD5LPS9y5hj+J0n
	+rNsf11BeRjTPo3JZy9IYBgi0MB7Wbyv+I5PSmo9rKb0XdiAmHNpS+6JPdMxd5+DMhP/twqTV6Zvn
	y68w+f8TA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5KbR-0001xb-Il; Fri, 29 Jan 2021 03:37:45 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5KbL-0001wW-6C
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:37:43 +0000
Received: by mail-wm1-f46.google.com with SMTP id f16so5790993wmq.5
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 19:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+GUZp5hSfEjRyNkiPxvry5RPpSZTyVCM6nuEpV8Qk4s=;
 b=N6HWV67TpF6Nu1krEhedSoh/mqQ38DRXyVCgPAPtfWcnJWXZELgDpHKraVnoTeumE1
 9Eh5u4wYg1d0p+QhNJowMpFNCEipbRKI1iFqzz1em/e/StdJr/mSqsahufg3LCdY1dwY
 kSajEFobLscezXlc2j9eWSLal1wgsT7FeA6GmWdRvNXeZLSeNvr8bfTqvC6WkJLnZ9G9
 Df/EcyvteOA1yTQn0Eyf/aZ2r8xgSHeZcX4C0oAHjGvXbr0D8uYVFt/YuQtyNIimdWsQ
 1G2edw5IHFiduNRRWz6LONfMGCsGfHplthgpHcauSpUy/fWEkKLQocQqLeL8UyhgZTJ1
 eBCA==
X-Gm-Message-State: AOAM531btlCHqWd+3REaBLQwPANGOUwN0YXoVIQmXdDAMV1+4wSlJl10
 AvQ2RztzLRw1Nc1WI3JS/8k=
X-Google-Smtp-Source: ABdhPJxw4gqn0vyNpaRTkc697bKa9yxgvTtEMJ35xjfd/nEAxKx5vzFDdjxhd7jsAWteXbP4IGes1g==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr1882346wmj.148.1611891458226; 
 Thu, 28 Jan 2021 19:37:38 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id l11sm9461111wrt.23.2021.01.28.19.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 19:37:37 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
 <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
 <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a55689cc-0925-c3a3-b7bf-e155cc3d4fe9@grimberg.me>
Date: Thu, 28 Jan 2021 19:37:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_223739_253452_9633261A 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvcmRtYS5jCj4+PiBpbmRleCBiN2NlNGYyMjFkOTkuLjY2YjY5NzQ2MWJkOSAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvcmRtYS5jCj4+PiBAQCAtMjA4NCw4ICsyMDg0LDEzIEBAIHN0YXRpYyBibGtfc3RhdHVz
X3QgbnZtZV9yZG1hX3F1ZXVlX3JxKHN0cnVjdCAKPj4+IGJsa19tcV9od19jdHggKmhjdHgsCj4+
Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBudm1lX3JkbWFfcG9zdF9zZW5kKHF1ZXVlLCBz
cWUsIHJlcS0+c2dlLCByZXEtPm51bV9zZ2UsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxLT5tciA/ICZyZXEtPnJlZ193ci53ciA6IE5VTEwp
Owo+Pj4gLcKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoZXJyKSkKPj4+ICvCoMKgwqDCoMKgwqAg
aWYgKHVubGlrZWx5KGVycikpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChlcnIgPT0gLUVJTykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG52bWVfY29tcGxldGVfZmFpbGVkX3JxKHJxLCAKPj4+IE5WTUVfU0NfSE9TVF9Q
QVRIX0VSUk9SKTsKPj4KPj4gSSB3YXMgdGhpbmtpbmcgYWJvdXQ6Cj4+IC0tIAo+PiDCoMKgwqDC
oMKgwqDCoMKgIGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVxLT5zZ2Us
IHJlcS0+bnVtX3NnZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJlcS0+bXIgPyAmcmVxLT5yZWdfd3Iud3IgOiBOVUxMKTsKPj4gwqDCoMKgwqDC
oMKgwqDCoCBpZiAodW5saWtlbHkoZXJyKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoZXJyID09IC1FSU8pIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogRmFpbCB0aGUgcmV1cWVzdCBzbyB1cHBlciBsYXllciBj
YW4gCj4+IGZhaWxvdmVyIEkvTwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIGlmIGFub3RoZXIgcGF0aCBpcyBhdmFpbGFibGUKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+c3RhdHVzID0g
TlZNRV9TQ19IT1NUX1BBVEhfRVJST1I7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX3JkbWFfY29tcGxldGVfcnEocnEpOwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEJMS19TVFNf
T0s7TmVlZCB0byBkbyBjbGVhbi4gc28gY2FuIAo+PiBub3QgZGlyZWN0bHkgcmV0dXJuLgoKVGhl
IGNvbXBsZXRpb24gcGF0aCBjbGVhbnMgdXAgdGhvdWdoCgo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gZXJyX3VubWFwOwo+PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gLS0gCj4+IC4KPiAKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LW52bWUg
bWFpbGluZyBsaXN0Cj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
