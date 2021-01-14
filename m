Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F69C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:25:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72682310F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72682310F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PSrP8RIzAp4ibrE8x2LMRmJf0yvOVpag4HbPmFUsl2E=; b=lUbetez5jahwdL/6zxNO0lLGe
	16be9KkOtieR5pIvpzEBT7dWxsby+2uQIWnXALSTFpCvZgaNwFMY88Eh/KD//l/GrLkM7VcfHBcTX
	EJ23AEie9+l0YKtjIIAyu1re8ENo6xNXoeGlJzBxphEL3XtGivGV/RZ8DXV2DSeLR3NJMpO8OtUqM
	lBoVdmoWhg1k4GQI4rPg5F5F0jI+ultMqJ7OTjtcZOi4yfzF6x9aeEgCCZpoFZTnCuEnugtTm6VxT
	ns1x6dvCTdmn1yqqT9f3gQlVRD9b8cFuJqKJe5zLXE9TfmbORFekbCF4t/AGxoxWkOX3oVHs9gFbV
	q1QAtJGRQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0A7a-00069m-Rq; Thu, 14 Jan 2021 21:25:34 +0000
Received: from mail-oi1-f171.google.com ([209.85.167.171])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0A7Y-00069J-SX
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:25:33 +0000
Received: by mail-oi1-f171.google.com with SMTP id d189so7414829oig.11
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wQfZzkSVTsHcN34H+4B7fx0/39tNd164MXiCBd1US7M=;
 b=ODgyK9M74QRWjv6qdeREwmC3u9m8D8Zzw4zTUqATXm1m8/ZrXVf2CrLhi9m+gZowF4
 eLgoeh8AeTdEmWnfK9VU3hXvrLBaWsHArzQjWKCgCZ9YreBBhX/09nWpVJqbWM6cuPJG
 ASKTfTYRNgySv/aB9cKUmJTiI5k7t62UoKBiwS3dTaZJL+q2ahASRAmeFfGIjFXCUgfB
 Ffo8vShdZwVxnoJ3k0yfWUToP+BC/fZLEFFCOMLOAvQtihMdboAEVdwiFFSw1a0aoLJ9
 pfElpfJJ0mrd2x53yiZ+C0hHqJjanX/4FIBPtCXnwxY8NREPngzZYKPEOsJawGgq/2c+
 pj+w==
X-Gm-Message-State: AOAM5330YE2p+EYx/JKBIhIl15lZ60IG62Fyd+FkMsm3iQx6xJ00ywdH
 pWnIcXXwiKdzbbNz5jav8m0=
X-Google-Smtp-Source: ABdhPJwfhRlKIsA2gWEuDrLjv5IY1+pOKcBqWFqjbkr57zkpptbpG7tMV2DQjnpqXXu+G7rt9Yovhg==
X-Received: by 2002:a54:479a:: with SMTP id o26mr3783510oic.48.1610659531914; 
 Thu, 14 Jan 2021 13:25:31 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14?
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id s66sm1330357ooa.37.2021.01.14.13.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 13:25:31 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
Date: Thu, 14 Jan 2021 13:25:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_162532_939791_C71071F1 
X-CRM114-Status: GOOD (  23.37  )
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

Cj4+PiBXaGVuIGEgcmVxdWVzdCBpcyBxdWV1ZWQgZmFpbGVkLCBibGtfc3RhdHVzX3QgaXMgZGly
ZWN0bHkgcmV0dXJuZWQKPj4+IHRvIHRoZSBibGstbXEuIElmIGJsa19zdGF0dXNfdCBpcyBub3Qg
QkxLX1NUU19SRVNPVVJDRSwKPj4+IEJMS19TVFNfREVWX1JFU09VUkNFLCBCTEtfU1RTX1pPTkVf
UkVTT1VSQ0UsIGJsay1tcSBjYWxsCj4+PiBibGtfbXFfZW5kX3JlcXVlc3QgdG8gY29tcGxldGUg
dGhlIHJlcXVlc3Qgd2l0aCBCTEtfU1RTX0lPRVJSLgo+Pj4gSW4gdHdvIHNjZW5hcmlvcywgdGhl
IHJlcXVlc3Qgc2hvdWxkIGJlIHJldHJpZWQgYW5kIG1heSBzdWNjZWVkLgo+Pj4gRmlyc3QsIGlm
IHdvcmsgd2l0aCBudm1lIG11bHRpcGF0aCwgdGhlIHJlcXVlc3QgbWF5IGJlIHJldHJpZWQKPj4+
IHN1Y2Nlc3NmdWxseSBpbiBhbm90aGVyIHBhdGgsIGJlY2F1c2UgdGhlIGVycm9yIGlzIHByb2Jh
Ymx5IHJlbGF0ZWQgdG8KPj4+IHRoZSBwYXRoLiBTZWNvbmQsIGlmIHdvcmsgd2l0aG91dCBtdWx0
aXBhdGggc29mdHdhcmUsIHRoZSByZXF1ZXN0IG1heQo+Pj4gYmUgcmV0cmllZCBzdWNjZXNzZnVs
bHkgYWZ0ZXIgZXJyb3IgcmVjb3ZlcnkuCj4+PiBJZiB0aGUgcmVxdWVzdCBpcyBjb21wbGV0ZSB3
aXRoIEJMS19TVFNfSU9FUlIgaW4gCj4+PiBibGtfbXFfZGlzcGF0Y2hfcnFfbGlzdC4KPj4+IFRo
ZSBzdGF0ZSBvZiByZXF1ZXN0IG1heSBiZSBjaGFuZ2VkIHRvIE1RX1JRX0lOX0ZMSUdIVC4gSWYg
ZnJlZSB0aGUKPj4+IHJlcXVlc3QgYXN5bmNocm9ub3VzbHkgc3VjaCBhcyBpbiBudm1lX3N1Ym1p
dF91c2VyX2NtZCwgaW4gZXh0cmVtZQo+Pj4gc2NlbmFyaW8gdGhlIHJlcXVlc3Qgd2lsbCBiZSBy
ZXBlYXRlZCBmcmVlZCBpbiB0ZWFyIGRvd24uCj4+PiBJZiBhIG5vbi1yZXNvdXJjZSBlcnJvciBv
Y2N1cnMgaW4gcXVldWVfcnEsIHNob3VsZCBkaXJlY3RseSBjYWxsCj4+PiBudm1lX2NvbXBsZXRl
X3JxIHRvIGNvbXBsZXRlIHJlcXVlc3QgYW5kIHNldCB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0bwo+
Pj4gTVFfUlFfQ09NUExFVEUuIG52bWVfY29tcGxldGVfcnEgd2lsbCBkZWNpZGUgdG8gcmV0cnks
IGZhaWwgb3ZlciBvciBlbmQKPj4+IHRoZSByZXF1ZXN0Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6
IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9u
dm1lL2hvc3QvcmRtYS5jIHwgMiArLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0
L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4gaW5kZXggZGY5ZjZmNDU0OWYx
Li40YTg5YmY0NGVjZGMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4gQEAgLTIwOTMsNyArMjA5Myw3
IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9yZG1hX3F1ZXVlX3JxKHN0cnVjdCAKPj4+IGJs
a19tcV9od19jdHggKmhjdHgsCj4+PiDCoCB1bm1hcF9xZToKPj4+IMKgwqDCoMKgwqAgaWJfZG1h
X3VubWFwX3NpbmdsZShkZXYsIHJlcS0+c3FlLmRtYSwgc2l6ZW9mKHN0cnVjdCAKPj4+IG52bWVf
Y29tbWFuZCksCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERNQV9UT19E
RVZJQ0UpOwo+Pj4gLcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gK8KgwqDCoCByZXR1cm4gbnZtZV90
cnlfY29tcGxldGVfZmFpbGVkX3JlcShycSwgcmV0KTsKPj4KPj4gSSBkb24ndCB1bmRlcnN0YW5k
IHRoaXMuIFRoZXJlIGFyZSBlcnJvcnMgdGhhdCBtYXkgbm90IGJlIHJlbGF0ZWQgdG8KPj4gYW55
dGhpbmcgdGhhdCBpcyBwYXRoaW5nIHJlbGF0ZWQgKHN3IGJ1ZywgbWVtb3J5IGxlYWssIG1hcHBp
bmcgZXJyb3IsCj4+IGV0YywgZXRjKSB3aHkgc2hvdWxkIHdlIHJldHVybiB0aGlzIG9uZS1zaG90
IGVycm9yPwo+IEFsdGhvdWdoIGZhaWwgb3ZlciByZXRyeSBpcyBub3QgcmVxdWlyZWQsIGlmIHdl
IHJldHVybiB0aGUgZXJyb3IgdG8KPiBibGstbXEsIGEgbG93IHByb2JhYmlsaXR5IGNyYXNoIG1h
eSBoYXBwZW4uIGJlY2F1c2UgYmxrLW1xIGRvIG5vdCBzZXQKPiB0aGUgc3RhdGUgb2YgcmVxdWVz
dCB0byBNUV9SUV9DT01QTEVURSBiZWZvcmUgY29tcGxldGUgdGhlIHJlcXVlc3QsCj4gdGhlIHJl
cXVlc3QgbWF5IGJlIGZyZWVkIGFzeW5jaHJvbm91c2x5IHN1Y2ggYXMgaW4gbnZtZV9zdWJtaXRf
dXNlcl9jbWQuCj4gSWYgcmFjZSB3aXRoIGVycm9yIHJlY292ZXJ5LCByZXF1ZXN0IGRvdWJsZSBj
b21wbGV0aW9uIG1heSBoYXBwZW5zLgoKVGhlbiBmaXggdGhhdCwgZG9uJ3Qgd29yayBhcm91bmQg
aXQuCgo+IAo+IFNvIHdlIGNhbiBub3QgcmV0dXJuIHRoZSBlcnJvciB0byBibGstbXEgaWYgdGhl
IGJsa19zdGF0dXNfdCBpcyBub3QKPiBCTEtfU1RTX1JFU09VUkNFLCBCTEtfU1RTX0RFVl9SRVNP
VVJDRSwgQkxLX1NUU19aT05FX1JFU09VUkNFLgoKVGhpcyBpcyBub3Qgc29tZXRoaW5nIHdlIHNo
b3VsZCBiZSBoYW5kbGluZyBpbiBudm1lLiBibG9jayBkcml2ZXJzCnNob3VsZCBiZSBhYmxlIHRv
IGZhaWwgcXVldWVfcnEsIGFuZCB0aGlzIGFsbCBzaG91bGQgbGl2ZSBpbiB0aGUKYmxvY2sgbGF5
ZXIuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
