Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09389C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 20:26:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9722A2084D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 20:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vRTsPHpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9722A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gP8tKYH+eFAYV/0OqcKByyuwqAotp6D83Gr/tasTjYU=; b=vRTsPHpaSeAKfVebifbs+Rjqx
	2nKPJhbQDdAgO+/kFb9UYekZ+kFM86UjizwJTxqXPrvFFiix7bvYa0TD33RhosyQZ4dvTjdyg/gnP
	q+IWP1JJr3gfeyI+ni/9U8K2JX3NWTM/XrRuW9HbpV4tvt8yxpEXAKIkbnByMVHqtDGslFjtbvfQj
	Sw4EnB3WzmDr4NnvHt4AaqQMK09EdE2WQVcIIZEwr/ydRFvXThaRPJdEHd6vngMPX/MSrrtvBig8Z
	nsRtRG0rBOfvLyuV9iD0ZQknJWYWDCoVXeLlG8PHhPc7u1OFtHxYMkD5Fyd4SZ6HyZeP6fq6AIW1K
	549GY+tig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEIIG-0003EK-2o; Fri, 04 Sep 2020 20:26:44 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEIID-0003Dw-7z
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 20:26:41 +0000
Received: by mail-pg1-f194.google.com with SMTP id h12so4890582pgm.7
 for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2020 13:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EyykpYnQucC1KSDDEpiF0Q+WVJ9Lo5+MQZtWeAev+/U=;
 b=M/1TWcUTfLnsi498Hg6ZnCEd95sRtcTfR03RKS7YzT3qyEiaSiva4LjsISUHUd0dLb
 5JRmhgnE/QxI81apI/GCFY+4mRZrI/iSvEKEUBhU54LT5ghI5qunCujWnmcNhrW5cdFb
 W7Hl/IqmIkNmLUKakIga4yIkOXdTmujkQUR/aTsCEXeAVQQHRF0DkZIxetzu+QiKRq8l
 4ywmCc6W0sII8JuPZ8Yo6rikVnn4Ok42doBLkYGJDA23SY4Iaqo4ATzu6mwaCL3+w2Jh
 ZJTy7W0c5t9VZD+vOqPFIgSaT9wrdFEVpu7bWwdBzzjY8A9V+UzDeU7QmwYqVOJrBiY9
 2dsg==
X-Gm-Message-State: AOAM533lQT5bAHTjwCzN9PFPJoE4dusfI1kUx2WcjHOBpXvkxU4RU9va
 QA2w/YMxb3sF8gyrLH0aBI4qaV6a1QA=
X-Google-Smtp-Source: ABdhPJzUnpmBQpD/hdW6YabA0FlHPbzS2sYUQ058W3SPWYyLm0EoX8+OUOb7Pm+ToBpUqm8LAXqWeQ==
X-Received: by 2002:a63:cc16:: with SMTP id x22mr8260511pgf.414.1599251199847; 
 Fri, 04 Sep 2020 13:26:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:313b:8ce3:bdc0:816?
 ([2601:647:4802:9070:313b:8ce3:bdc0:816])
 by smtp.gmail.com with ESMTPSA id 131sm6967582pgh.67.2020.09.04.13.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 13:26:38 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
From: Sagi Grimberg <sagi@grimberg.me>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
 <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
 <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
 <9a1bd3fb-203b-8a33-76b9-cb373d02744d@grimberg.me>
Message-ID: <c24eeef2-e235-f095-0a34-8b62fe917e5a@grimberg.me>
Date: Fri, 4 Sep 2020 13:26:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a1bd3fb-203b-8a33-76b9-cb373d02744d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_162641_317975_167750AC 
X-CRM114-Status: GOOD (  20.99  )
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

Cj4+Pj4+IFNvIHdlIGVpdGhlciBrZWVwIHRoaXMgZXhjZXB0aW9uIGZvciBhZG1pbiBjb21tYW5k
cywgb3Igd2UgYWxzbyBsZXQKPj4+Pj4gdGhlbSB0aHJvdWdoIGFzIGl0IHNlZW1zIHRvIGJlIHNh
ZmUgd2l0aCB0aGUgY3VycmVudCBjb2RlIChmcm9tIHRoZQo+Pj4+PiByZXNldCBmb3J3YXJkLXBy
b2dyZXNzIHBlcnNwZWN0aXZlKS4KPj4+Pj4KPj4+Pj4gSSB2b3RlIHRvIHJlbW92ZSB0aGlzIGV4
Y2VwdGlvbiBhbHRvZ2V0aGVyLi4uCj4+Pj4KPj4+PiBUbyBtZSB0aGUgcmlnaHQgYW5zd2VyIHdv
dWxkIGJlIHRvIHJlamVjdCB1c2VyIGNvbW1hbmRzIG9uIHRoZSBhZG1pbgo+Pj4+IG9yIEkvTyBx
dWV1ZSBmb3IgdGhlIG5vdCBsaXZlIGNvbnRyb2xsZXIgYXMgdGhlIGNhbGxlcnMgbmVlZCB0byBo
YW5kbGUKPj4+PiBpdC7CoCBUaGF0IHNlZW1zIHRvIG1ha2UgbW9yZSBzZW5zZSB0byBtZSB0aGFu
IGEgc3BlY2lhbCBhZG1pbiBxdWV1ZQo+Pj4+IGV4Y2VwdGlvbi4KPj4+Cj4+PiBTbyB5b3Ugc2F5
IHRoYXQgd2Ugc2hvdWxkIG5ldmVyIHJldHVybiBCTEtfU1RTX1JFU09VUkNFIGJ1dCByYXRoZXIg
ZmFpbAo+Pj4gYWxsIHJlcXVlc3RzPyByZWdhcmRsZXNzIGZvciBtdWx0aXBhdGggb3Igbm90Pwo+
Pgo+PiBIb3cgYWJvdXQgd2Uga2VlcCB0aGUgZXhjZXB0aW9uIGZvciBub3cuIEFzIEkgbWVudGlv
bmVkIGVhcmxpZXIsIEkgCj4+IGhhdmUgYW4gaW9jdGwgcmV0cnkgcGF0Y2ggY29taW5nIGZvciBu
dm1lLWNsaSBhbmQgaWYgd2UgYWdyZWUgd2l0aCAKPj4gd2hhdCBpdCBkb2VzIHRoZW4gd2UgY2Fu
IHB1dCBpbiB0aGUgcmVqZWN0IGFuZCByZW1vdmUgdGhlIGV4Y2VwdGlvbi4KPiAKPiBJIGhvbmVz
dGx5IGRvbid0IHRoaW5rIHdlIHNob3VsZCBmYWlsIHVzZXIgSS9PIGNvbW1hbmRzLCB0aGVyZSBp
cyBubwo+IGZvciB1cyByZWFzb24gdG8gZG8gdGhhdC4KPiBJIGFsc28gZG9uJ3QgdGhpbmsgd2Ug
c2hvdWxkIGZhaWwgdXNlciBhZG1pbiBjb21tYW5kcyBlaXRoZXIsIGF0IGxlYXN0Cj4gbm90IGlu
IG52bWZfY2hlY2tfcmVhZHkuCgpHdXlzLCB3ZSBuZWVkIHRvIHJlc29sdmUgdGhpcyBvbmUsIHRo
aXMgaXMgbmVlZGVkIHRvIHByZXZlbnQgZnJlZXplCmR1cmluZyByZXNldCBmcm9tIGhhbmdpbmcu
CgpBcyBJIHNhaWQsIGFueSBJL08gdGhhdCB3aWxsIHVzZSB0aGUgbnMtPnF1ZXVlIHNob3VsZG4n
dCBiZSBkZW5pZWQgaGVyZQpiZWNhdXNlIGl0IHRha2VzIHRoZSBxX3VzYWdlX2NvdW50ZXIgYW5k
IHdpbGwgcHJldmVudCBhIGZyZWV6ZSAodGhpcyBpcwp0cnVlIGZvciBib3RoIGZzIG9yIHVzZXIg
SS9PIGNvbW1hbmRzKS4KCkkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIGFsbG93IHRoZSBhZG1pbiBv
bmVzIGFzIHdlbGwgYW5kIGRlbnkgdGhlbQpzb21ld2hlcmUgZWxzZSBpZiB3ZSB3YW50IHRvLCBi
dXQgSSdtIGZpbmUgd2l0aCBrZWVwaW5nIHRoaXMgZXhjZXB0aW9uCm5vdyBiZWNhdXNlIG5vIG9u
ZSBpcyBleHBlY3RlZCB0byBmcmVlemUgdGhlIGFkbWluIHF1ZXVlLgoKTGV0IG1lIGtub3cgd2hh
dCB5b3UgdGhpbmsuIEkgd2FudCBpdCB0byBnbyBpbnRvIGFuIHJjIHNvb24uCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
