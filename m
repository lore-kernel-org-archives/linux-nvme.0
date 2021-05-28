Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098FC47089
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 01:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D066F6135C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 01:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D066F6135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ocuEr2y7lQYQOgLrw1NepBv2QHDClUbkV5ZFO2+Nms=; b=14C5vvCey9TSYRtHUStM3O+j4Z
	9MjS3eaPC60e2Eh9vjVnkYx073YiLNZSEtBCIawXRU595srDMSXXMakrJFgyn88uzCCINzs9ldNfd
	zGi0Esmz4s4h/ev+hBfLHgWWS/Kz74Cg9pRH8HvXPDKqxlMFsYd8an9A6uZDC8tLu/alkZXfUYeXo
	DG2ruKRvSUXKOyvboNRqPQkXThO0x5FiRSSC9rScEygvLGezFsGRRo2vWafpbFAGJx6Nh/Xsc3knK
	sXbYjv37V92U1UrnSVySX9iQu3H3BRq+kPNfol7ClYCR+MA2/VrS4SBwRh0GUAhP5ryf/y5ihFlZd
	e5j3XJjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmREO-00AvJC-Q2; Fri, 28 May 2021 01:24:08 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmR6f-00As61-6E
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 01:16:10 +0000
Received: by mail-pl1-f181.google.com with SMTP id v12so837050plo.10
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 18:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ztTEmQR+ho+6gYb0hQLJaRX7yVIIKWggbiQWXABcYgw=;
 b=iTimKUSJUliXiwdD6gZNZFra74ZpuQPNa63clLVF9tkWFxpvIAwn51w0XGUAGjwap+
 LkCDWTOO9ddqIaaEF7wZBKV1Ik5+0cRSgYMYtkoSHAKb9Y6h2I/j/Ervys+yut8LL1Xz
 absy+CX0QKUbQs5j0B4entgHMZVgaXPVnncMmA4uKx+33IJ7ktjwWuKbkM3vJ5QwqtMQ
 1uzzJHn2XAs0TiDlSl4lfG2HxH6u9yYJuQqrBH2gWybTrfFDDkgcO0Srl2oxZJwB1ddu
 2DYnQx9yt9hKsl9Bym48gUkK/aT+1EcfBKMxL2FI7b5C61HS0oiwvfOnapCveHFExh+S
 LQaQ==
X-Gm-Message-State: AOAM532whO/ucEGaI+eneJHhHmF9EX5OVazcVfHgk3TbJYjracRXmXCa
 t6XGZBY/GCBNn2gwmlKoTX8=
X-Google-Smtp-Source: ABdhPJzW4nqwPrmqZErlicRoO8rXx6JDxiJ9g2Wp/7WaVUtUPsxopTNDeRLkM89nGp3hkRBDcVHRcA==
X-Received: by 2002:a17:90b:d98:: with SMTP id
 bg24mr1492772pjb.112.1622164568191; 
 Thu, 27 May 2021 18:16:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95ba:990f:ef3a:82bb?
 ([2601:647:4802:9070:95ba:990f:ef3a:82bb])
 by smtp.gmail.com with ESMTPSA id o9sm3158984pfh.217.2021.05.27.18.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 18:16:06 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix in-casule data send for chained sgls
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
References: <20210527204016.379365-1-sagi@grimberg.me>
 <48f23b84-8a1e-e298-be91-0627c1112fd8@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9a6b5cd-1198-693c-4e90-3d5978a70b8e@grimberg.me>
Date: Thu, 27 May 2021 18:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <48f23b84-8a1e-e298-be91-0627c1112fd8@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_181609_272409_C5C6DAED 
X-CRM114-Status: GOOD (  16.18  )
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

Cj4gT24gMjAyMS81LzI4IDQ6NDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IFdlIGhhdmUgb25s
eSAyIGlubGluZSBzZyBlbnRyaWVzIGFuZCB3ZSBhbGxvdyA0IHNnIGVudHJpZXMgZm9yIHRoZSBz
ZW5kCj4+IHdyIHNnZS4gTGFyZ2VyIHNnbHMgZW50cmllcyB3aWxsIGJlIGNoYWluZWQuIEhvd2V2
ZXIgd2hlbiB3ZSBidWlsZAo+PiBpbi1jYXBzdWxlIHNlbmQgd3Igc2dlLCB3ZSBpdGVyYXRlIHdp
dGhvdXQgdGFraW5nIGludG8gYWNjb3VudCB0aGF0IHRoZQo+PiBzZ2wgbWF5IGJlIGNoYWluZWQg
YW5kIHN0aWxsIGZpdCBpbi1jYXBzdWxlICh3aGljaCBjYW4gaGFwcGVuIGlmIHRoZSBzZ2wKPj4g
aXMgYmlnZ2VyIHRoYW4gMiwgYnV0IGxvd2VyLWVxdWFsIHRvIDQpLgo+Pgo+PiBGaXggaW4tY2Fw
c3VsZSBkYXRhIG1hcHBpbmcgdG8gY29ycmVjdGx5IGl0ZXJhdGUgY2hhaW5lZCBzZ2xzLgo+Pgo+
PiBSZXBvcnRlZC1ieTogV2Fsa2VyLCBCZW5qYW1pbiA8YmVuamFtaW4ud2Fsa2VyQGludGVsLmNv
bT4KPj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyB8IDQgKystLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+
IGluZGV4IDhkMTA3YjIwMWYxNi4uZWQxYmYyMTRjNTQ0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9yZG1hLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+IEBA
IC0xMzIwLDE2ICsxMzIwLDE2IEBAIHN0YXRpYyBpbnQgbnZtZV9yZG1hX21hcF9zZ19pbmxpbmUo
c3RydWN0IAo+PiBudm1lX3JkbWFfcXVldWUgKnF1ZXVlLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50IGNvdW50KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IG52bWVfc2dsX2Rlc2MgKnNn
ID0gJmMtPmNvbW1vbi5kcHRyLnNnbDsKPj4gLcKgwqDCoCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNn
bCA9IHJlcS0+ZGF0YV9zZ2wuc2dfdGFibGUuc2dsOwo+IHNnbCBuZWVkIHRvIGJlIGRlZmluZWQu
CgpPYnZpb3VzbHksIHJ1c2hlZCBpdC4uLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
