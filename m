Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9898FC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:32:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6438220809
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NfEDRWhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6438220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OOj2kgRBgiLINmbw5UsiY1iT4x724dKy8xpjBHoIYPs=; b=NfEDRWhfWZqG4O/OPtVJ5txIO
	6njEy072SWOKPqo5yOjS7QBp5pCnn7HIBIOjL9e9mFGQsCby2wAwp2xZh2HGnOdHPY/5xdRh/qd4E
	te060f6kQ6JM8YFLYAWFr5rZm22QW2vsrIlHe+eEXuscXg3Bo45rv8fHkcKdX25ijgPLVgdRwsmMd
	OlsS9lWVy1Dd/UbIdmClHOgxXvhKjFHaAB7Cq3kccrs4qzP0lONa+8EsULoB3xRa7YV8TRDkHrSmY
	k9O4KnAsHQARpZvJi3NOlqiH0VAYq3Lua9rY/Q1VucHd4wBEPMdzugCz5pFJuxGkUFN8P+q85708l
	PCGbY7sog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0CbD-0002n0-HI; Mon, 27 Jul 2020 23:32:03 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0CbB-0002ma-CN
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 23:32:02 +0000
Received: by mail-pl1-f193.google.com with SMTP id q17so8954637pls.9
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 16:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4ZFZ3Ol0ma3SUgCnPKYDs9CJBLfKuhnBqgLqGP32q0=;
 b=AbV6YNT4oSP5caAst9tMd6943d4B0DPng0C1jPeS99ydAX/fDybrKBH/nEKtAPfS9z
 YtasUbwcgiH6bmkpWyzNvCxI6eJppicrmaEgCBcL4DADjnZKNscGviKWY9Msn4aLHiQH
 q3FGAocIiXsX/bjNJK3lVHHMciPvT7i4x6/r37wkXTpljGkUXBN/YQN80X3woAmJ0RoB
 jtDrGJSlV8ARCUQIU8rdf3mxrE2sj+XEFart8uaH+9c8ByJU+Hw5QglgJ+hVvX4sSqbi
 sAzkgN4fDdYcQbh5NZcFWTBJ9dlIdb3KRCtC/lAQlmrVMOW+uYu4TBpvkXTRzMVRl2Dc
 pr1Q==
X-Gm-Message-State: AOAM533t608UuCVF9mOk+BueqEnK+T6Ss0GOppro3B2b2zRNYs6cbTnN
 5PEYTn1DaDP/a5q0nicGaL8=
X-Google-Smtp-Source: ABdhPJxmCDex13IjBHyKv8RvC3UoXmbG6YbrCtH279uB3u2L5OJ6d+BEJf0tdGNu24D2cK/YZn4qAg==
X-Received: by 2002:a17:90a:23af:: with SMTP id
 g44mr1468451pje.43.1595892720316; 
 Mon, 27 Jul 2020 16:32:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id gn5sm682084pjb.23.2020.07.27.16.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 16:31:59 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix deadlock when delete ctrl due to reconnect
 fail
From: Sagi Grimberg <sagi@grimberg.me>
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200727080926.30776-1-lengchao@huawei.com>
 <e477f1b3-f351-1aa3-6132-d7e729db11b9@grimberg.me>
Message-ID: <c129a034-ca6f-7323-91d4-8a899ede7777@grimberg.me>
Date: Mon, 27 Jul 2020 16:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e477f1b3-f351-1aa3-6132-d7e729db11b9@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_193201_772686_6C05EF22 
X-CRM114-Status: GOOD (  14.84  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9yZG1hLmMKPj4gaW5kZXggZjhmODU2ZGMwYzY3Li5iMzgxZTJjZGU1MGEgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9yZG1hLmMKPj4gQEAgLTk4OSw4ICs5ODksNyBAQCBzdGF0aWMgdm9pZCBudm1lX3JkbWFfdGVh
cmRvd25faW9fcXVldWVzKHN0cnVjdCAKPj4gbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9jYW5jZWxfcmVxdWVzdCwgJmN0cmwt
PmN0cmwpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfbXFfdGFnc2V0X3dhaXRf
Y29tcGxldGVkX3JlcXVlc3QoY3RybC0+Y3RybC50YWdzZXQpOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJlbW92ZSkKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoJmN0cmwtPmN0cmwpOwo+PiArwqDCoMKgwqDCoMKgwqAg
bnZtZV9zdGFydF9xdWV1ZXMoJmN0cmwtPmN0cmwpOwo+IAo+IFRoaXMgd2lsbCBmYWlsIEkvTyBk
dXJpbmcgY29udHJvbGxlciByZXNldCwgc28gbmFrIG9uIHRoaXMuCgpDYW4geW91IHRyeSB0aGlz
OgotLQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvcmRtYS5jCmluZGV4IGQ1ODIzMTYzNmQxMS4uOTZjMGQ2NjRmZTliIDEwMDY0NAotLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5j
CkBAIC0xMTQ5LDYgKzExNDksMTEgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3JlY29ubmVjdF9j
dHJsX3dvcmsoc3RydWN0IAp3b3JrX3N0cnVjdCAqd29yaykKICAgICAgICAgcmV0dXJuOwoKICBy
ZXF1ZXVlOgorICAgICAgIC8qCisgICAgICAgICogbWFrZSBzdXJlIHF1ZXVlcyBhcmUgbm90IHF1
aWVzY2VkIGR1ZSB0byBhIHJlY29ubmVjdAorICAgICAgICAqIHNlcXVlbmNlIHRoYXQgZmFpbGVk
IGFmdGVyIGNyZWF0aW5nIHNvbWUgSS9PIHF1ZXVlcworICAgICAgICAqLworICAgICAgIG52bWVf
c3RhcnRfcXVldWVzKGN0cmwpOwogICAgICAgICBkZXZfaW5mbyhjdHJsLT5jdHJsLmRldmljZSwg
IkZhaWxlZCByZWNvbm5lY3QgYXR0ZW1wdCAlZFxuIiwKICAgICAgICAgICAgICAgICAgICAgICAg
IGN0cmwtPmN0cmwubnJfcmVjb25uZWN0cyk7CiAgICAgICAgIG52bWVfcmRtYV9yZWNvbm5lY3Rf
b3JfcmVtb3ZlKGN0cmwpOwotLQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
