Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4872C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 18:44:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FFB64F4D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 18:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FFB64F4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1V4pw+x0qJacrdK2uKmdjTWlgSBazkJwV/mWuxUQJ04=; b=KoIlYHLdVrzM528pjuuml1Zsk
	/GnWnsunbTnAmSo+oNsq/CRlNreLYWmOA3nkFHlZjR7C7H0Vx7qBBOSX7rqAAeXVvfh3QWv+OCz7r
	6rzlIgCqAXXFC06KbgT3WQtFNYKCjpNJR1Nj2jIsrDWaHWa8zwAZqeZyJOWUXar/QmIbBGo/PZiXu
	U8fxv43jaitK48b+VTW/c0SFzuZTO1eBBUV/zB5RyiuFia9vJKlh4DqY+fmGFx9CeHbfDDQM2jKsC
	tbQBWKi0AqFNtwQwnpjZMjlKGYUYrVck3LZl3YIJTFm1hQ6mxhhndtmLyqpWh1wFNgB/z8BpJl1ku
	f4e3rfm7A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMb9L-003lI7-C7; Wed, 17 Mar 2021 18:44:08 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMb9H-003lHR-Ah
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 18:44:05 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so1823907pjg.5
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 11:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p/prN9wxvX0Xwr5+ihptZmBZSeUzR4ySvKvRcmfnDgs=;
 b=SxjUKaO/FduXjXB/b97K+L2KBj1zNHXkm/d00afE0H2j1ESAQQDYSncL4AmWKahZcg
 xPkLrqa4xxwjUdfJqPmOhOd8eFztyPTPn6iBcK77fDsj0o3DU+igVsMMvb9AxfXj5e8U
 FpSsH6CDBD/e+wyoI9WfBbAQ9WdRufhLAk9LqL5gvjjJXRSsQLT/6sgCYp1+1QJ9sHGl
 BtuYwEC4TtUAjVlwVuAzrJF8ZP1d3XcUPvT+WScgLDagWBmq6iMaS8ub0sGy0JtpATmr
 N55vDot0pDo7LbHCLeMGDjdDqxMO4ONHkqgNqyr6jTwMcdfwK4JkOZz5BlRCK8JKzpEG
 7EzQ==
X-Gm-Message-State: AOAM530q2vT0RhG4BVbAirr0GvxNqYHy4ONqEGYXAS5WuG/R6+1qJMeu
 uwBjloKfwJ5Ung0z9bxB1rQ=
X-Google-Smtp-Source: ABdhPJwN4nnlXZfm3SCgY9ws/RUK5ZRKrnwTyiwbma9weXtVxYXf7H/7XcsFxDZOhbr+pG5a9R+QXA==
X-Received: by 2002:a17:903:2286:b029:e6:6499:8c2d with SMTP id
 b6-20020a1709032286b02900e664998c2dmr5674968plh.17.1616006641281; 
 Wed, 17 Mar 2021 11:44:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dd5:ca84:dc28:de72?
 ([2601:647:4802:9070:3dd5:ca84:dc28:de72])
 by smtp.gmail.com with ESMTPSA id y9sm20878195pgc.9.2021.03.17.11.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 11:44:00 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
Date: Wed, 17 Mar 2021 11:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_184403_426510_BE6956C8 
X-CRM114-Status: GOOD (  19.25  )
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

Cj4+Pj4+IFdpbGwgaXQgd29yayBpZiBudm1lIG1wYXRoIHVzZWQgcmVxdWVzdCBOT1dBSVQgZmxh
ZyBmb3IgaXRzIAo+Pj4+PiBzdWJtaXRfYmlvKCkKPj4+Pj4gY2FsbCwgYW5kIGFkZCB0aGUgYmlv
IHRvIHRoZSByZXF1ZXVlX2xpc3QgaWYgYmxrX3F1ZXVlX2VudGVyKCkgCj4+Pj4+IGZhaWxzPyBJ
Cj4+Pj4+IHRoaW5rIHRoYXQgbG9va3MgbGlrZSBhbm90aGVyIHdheSB0byByZXNvbHZlIHRoZSBk
ZWFkbG9jaywgYnV0IHdlIG5lZWQKPj4+Pj4gdGhlIGJsb2NrIGxheWVyIHRvIHJldHVybiBhIGZh
aWxlZCBzdGF0dXMgdG8gdGhlIG9yaWdpbmFsIGNhbGxlci4KPj4KPj4gWWVzLCBJIHRoaW5rIEJM
S19NUV9SRVFfTk9XQUlUIG1ha2VzIHRvdGFsIHNlbnNlIGhlcmUuwqAgZG0tbXBhdGggYWxzbwo+
PiB1c2VzIGl0IGZvciBpdHMgcmVxdWVzdCBhbGxvY2F0aW9uIGZvciBzaW1pbGFyIHJlYXNvbnMu
Cj4+Cj4+Pj4KPj4+PiBCdXQgd2hvIHdvdWxkIGtpY2sgdGhlIHJlcXVldWUgbGlzdD8gYW5kIHRo
YXQgd291bGQgbWFrZSAKPj4+PiBuZWFyLXRhZy1leGhhdXN0IHBlcmZvcm1hbmNlIHN0aW5rLi4u
Cj4+Cj4+IFRoZSBtdWx0aXBhdGggY29kZSB3b3VsZCBoYXZlIHRvIGtpY2sgdGhlIGxpc3QuwqAg
V2UgY291bGQgYWxzbyB0cnkgdG8KPj4gc3BsaXQgaW50byB0d28gZmxhZ3MsIG9uZSB0aGF0IGFm
ZmVjdHMgYmxrX3F1ZXVlX2VudGVyIGFuZCBvbmUgdGhhdAo+PiBhZmZlY3RzIHRoZSB0YWcgYWxs
b2NhdGlvbi4KPj4KPj4+IG1vdmluZyBudm1lX3N0YXJ0X2ZyZWV6ZSBmcm9tIG52bWVfcmRtYV90
ZWFyZG93bl9pb19xdWV1ZXMgdG8gCj4+PiBudm1lX3JkbWFfY29uZmlndXJlX2lvX3F1ZXVlcyBj
YW4gZml4IGl0Lgo+Pj4gSXQgY2FuIGFsc28gYXZvaWQgSS9PIGhhbmcgbG9uZyB0aW1lIGlmIHJl
Y29ubmVjdGlvbiBmYWlsZWQuCj4+Cj4+IENhbiB5b3UgZXhwbGFpbiBob3cgd2UnZCBzdGlsbCBl
bnN1cmUgdGhhdCBubyBuZXcgY29tbWFuZHMgZ2V0IHF1ZXVlZAo+PiBkdXJpbmcgdGVhcmRvd24g
dXNpbmcgdGhhdCBzY2hlbWU/Cj4gMS4gdGVhciBkb3duIHdpbGwgY2FuY2VsIGFsbCBpbmZsaWdo
dCByZXF1ZXN0cywgYW5kIHRoZW4gbXVsdGlwYXRoIHdpbGwgCj4gY2xlYXIgdGhlIHBhdGguCj4g
Mi4gYW5kIHRoZW4gd2UgbWF5IGZyZWV6ZSB0aGUgY29udHJvbGVyLgo+IDMuIG52bWVfbnNfaGVh
ZF9zdWJtaXRfYmlvIGNhbiBub3QgZmluZCB0aGUgcmVjb25uZWN0aW9uIGNvbnRyb2xsZXIgYXMg
Cj4gdmFsaWQgcGF0aCwgc28gaXQgaXMgc2FmZS4KCkluIG5vbi1tcGF0aCAod2hpY2ggdW5mb3J0
dW5hdGVseSBpcyBhIHZhbGlkIHVzZS1jYXNlKSwgdGhlcmUgaXMgbm8KZmFpbG92ZXIsIGFuZCB3
ZSBjYW5ub3QgZnJlZXplIHRoZSBxdWV1ZSBhZnRlciB3ZSBzdG9wcGVkIChhbmQvb3IKc3RhcnRl
ZCkgdGhlIHF1ZXVlcyBiZWNhdXNlIHRoZW4gZmFpbF9ub25fcmVhZHlfY29tbWFuZCgpIGNvbnN0
YW50bHkgCnJldHVybiBCTEtfU1RTX1JFU09VUkNFIChqdXN0IGNhdXNpbmcgYSByZS1zdWJtaXNz
aW9uIG92ZXIgYW5kIG92ZXIKYWdhaW4pIGFuZCB0aGUgZnJlZXplIHdpbGwgbmV2ZXIgY29tcGxl
dGUgKHRoZSBjb21tYW5kcyBhcmUgc3RpbGwKaW5mbGlnaHQgZnJvbSB0aGUgcXVldWUtPmdfdXNh
Z2VfY291bnRlciBwZXJzcGVjdGl2ZSkuCgpTbyBJIHRoaW5rIHdlIHNob3VsZCBzdGlsbCBzdGFy
dCBxdWV1ZSBmcmVlemUgYmVmb3JlIHdlIHF1aWVzY2UKdGhlIHF1ZXVlcy4KCkkgc3RpbGwgZG9u
J3Qgc2VlIGhvdyB0aGUgbXBhdGggTk9XQUlUIHN1Z2dlc3Rpb24gd29ya3MgZWl0aGVyLi4uCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
