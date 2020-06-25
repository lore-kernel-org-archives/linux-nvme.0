Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A288C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:20:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A7A206A5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHerd6g8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="cZQEjZuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A7A206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Io8zkDDQFBWJjgCB0DjwRwNgwexaHcghcW+/A9zv5qM=; b=EHerd6g8351pets+IhS/FJgvT
	RxYvF1MvmCigmO3Z/L8wS+trnS4Y7HIqhEbyeSTlhtGO3pOO6P93oxEcG8uxrKNBx0hX+/51s5UjI
	q7frlpXrZDd5Gs0zfdwtjn56hItgTalYg2dW7n/0TF80ON7tFHpmRnfI2biScLXRFQATEmXDfaJSi
	mBIbxpS29GkoPz3jvoLAyJpLgeMMznWFOE+nDri7g3zfAyN0D1InZI7q4GLn+kDQQMbU7GDr5ZyYP
	CDTNhD9Z4JFyfPG+erMB/rz4pXOlJ9I18a3JK+jSMrQ1cZE4ut/hgKPbgEkTM1v98QveAF11TZAI0
	2T+EAyKrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joRnq-0000Nk-AW; Thu, 25 Jun 2020 13:20:30 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joRjk-0007as-Bp
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 13:16:20 +0000
Received: by mail-ej1-x643.google.com with SMTP id w16so5910536ejj.5
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XcQYPjqyDWtMi0rENYvAazue/kPTvu18ESw09VtA/BQ=;
 b=cZQEjZuvR5f7FgpcWi3eJOhWn+RuQzWHhsuVP3jAlRNmG5phKcNwo+FK/x8Jqaaw9J
 P81xfWDy6iA5U1jyM3ltNNuutAeJTfgzYugb9G43XSAXpAFupO43KXGK0Og/zdJTCpfs
 J4oO6gulRPfCK4CTcyVo45pohzgNyzmfldqY3BYmajDEZm2DU3ZjdCRLiTInDl6C8Pma
 lj61JNC4LSdLVFteSKGShTRPNZViSuvYwGt0uDdwMLxXtj2IkxFuR7RIM5Fu28rkRRc0
 6v6CzMoBY3kxzlSWag4yEx/WlHnPAX1djfHJygxGPPkehlNy/ztQoGlNWoesCIoMjm5c
 7HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XcQYPjqyDWtMi0rENYvAazue/kPTvu18ESw09VtA/BQ=;
 b=osJLYt4Z18To3ZAu8guDsYwoH/m1sXfKuCIxyvQflIWHciW/dv6tjhpIZ91QHRxX9Q
 BfZBjAqgmcSV0IaU9q1Yfi42rPioZaQvwPN4bpgK03xUIYXRPcNiNNLy4K7MkDULt3/K
 7PMFLRj4a0gdXE8rxPKaBru83Id0iXlDwAGEhVDXSAnvwToX/zdTpMlyXINTsUtuUzTi
 JQy6mY6sxexkt76oAQK7vUCFAiqozg/OApnak/cO+H/wWWiX0bgHn7yu9ixaXCKRashf
 G1p1P81pueFjALrJd5XHChWbpAAIW/KEabXecbIVbAtR1ODS8mvnxXkHgGJWLOM66bEk
 So1w==
X-Gm-Message-State: AOAM532lbqRQhNGLfe8n4zfekxHP2CqduTXDN4cd+rYOSFsvv4JDBz5Z
 kCy7tcdzRSg0eWEEtwTGETq4cQ==
X-Google-Smtp-Source: ABdhPJwIek7sLnxoju1+rcGjXPqwV/FQnxwJgYB9BILJ47lW0GF1ozwgl7ZsoLPjn8ycZZheLSOyVw==
X-Received: by 2002:a17:906:2c43:: with SMTP id
 f3mr5161913ejh.38.1593090974902; 
 Thu, 25 Jun 2020 06:16:14 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id p9sm11849637ejd.50.2020.06.25.06.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 06:16:14 -0700 (PDT)
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 linux-nvme@lists.infradead.org
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0cd0ad57-ec21-3d20-d74d-7e454614f06f@lightnvm.io>
Date: Thu, 25 Jun 2020 15:16:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-7-javier@javigon.com>
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
ZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPgo+IFNpbmNlIHRoZSBudW1i
ZXIgb2Ygem9uZXMgaXMgY2FsY3VsYXRlZCB0aHJvdWdoIHRoZSByZXBvcnRlZCBkZXZpY2UKPiBj
YXBhY2l0eSBhbmQgdGhlIFpOUyBzcGVjaWZpY2F0aW9uIGFsbG93cyB0byByZXBvcnQgdGhlIHRv
dGFsIG51bWJlciBvZgo+IHpvbmVzIGluIHRoZSBkZXZpY2UsIGFkZCBhbiBleHRyYSBjaGVjayB0
byBndWFyYW50ZWUgY29uc2lzdGVuY3kgYmV0d2Vlbgo+IHRoZSBkZXZpY2UgYW5kIHRoZSBrZXJu
ZWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1z
dW5nLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMgPHNlbHZha3VtYS5zMUBzYW1z
dW5nLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuIEpvc2hpIDxqb3NoaS5rQHNhbXN1bmcu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBzYW1zdW5nLmNv
bT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jIHwgNyArKysrKysrCj4gICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L2hvc3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+IGluZGV4IDdkODM4MWZlNzY2
NS4uZGU4MDY3ODhhMTg0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4g
KysrIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKPiBAQCAtMjM0LDYgKzIzNCwxMyBAQCBzdGF0
aWMgaW50IG52bWVfbnNfcmVwb3J0X3pvbmVzKHN0cnVjdCBudm1lX25zICpucywgc2VjdG9yX3Qg
c2VjdG9yLAo+ICAgCQlzZWN0b3IgKz0gbnMtPnpzemUgKiBuejsKPiAgIAl9Cj4gICAKPiArCWlm
IChucl96b25lcyA8IDAgJiYgem9uZV9pZHggIT0gbnMtPm5yX3pvbmVzKSB7Cj4gKwkJZGV2X2Vy
cihucy0+Y3RybC0+ZGV2aWNlLCAiaW5jb25zaXN0ZW50IHpvbmUgY291bnQgJXUvJXVcbiIsCj4g
KwkJCQl6b25lX2lkeCwgbnMtPm5yX3pvbmVzKTsKPiArCQlyZXQgPSAtRUlOVkFMOwo+ICsJCWdv
dG8gb3V0X2ZyZWU7Cj4gKwl9Cj4gKwo+ICAgCXJldCA9IHpvbmVfaWR4Owo+ICAgb3V0X2ZyZWU6
Cj4gICAJa3ZmcmVlKHJlcG9ydCk7CgpTb3VuZHMgbGlrZSBhIGNoZWNrIGZvciBhIGJyb2tlbiBp
bXBsZW1lbnRhdGlvbi4gRm9yIGltcGxlbWVudGF0aW9ucyBpbiAKdGhlIHdpbGQgdGhhdCBleGhp
Yml0cyB0aGlzIGJlaGF2aW9yLCBhIHF1aXJrIGNhbiBiZSBhZGRlZC4gVGhpcyBraW5kIG9mIApj
aGVjayBpcyBnZW5lcmFsbHkgbm90IG5lZWRlZC4gVGhpcyBjYW4gZWFzaWx5IGJlIGNoZWNrZWQg
YnkgaGF2aW5nIGEgCnRlc3QgY2FzZSBpbiBhIHZhbGlkYXRpb24gc3VpdGUuIFRoZSBrZXJuZWwg
c2hvdWxkIG5vdCBoYXZlIHRvIGNoZWNrIGZvciBpdC4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
