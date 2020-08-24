Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B28DC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:02:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267692072D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JX1AGh1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267692072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KLDy9lfQEBQdYNyQXAZGc5E3a50nlhyyggye00YtNp4=; b=JX1AGh1EyxBVXiENngmiQT6uJ
	3OBXEC1Xvf51Qt6MKtjTn47/LRa5JSo0t+LEaxeHQ/MXKtfjRsRh3X+Ol96u3dKPKsMbsM0nKZeNf
	SuenVFol1KFLLB3LGchIMEBsYOmr22S5F7KeRMzkT6629fB/phkGRzgZjxgpwW0ii6CB9sHVrmUK2
	gv600pjTJ/pkM9P11+gt+6Xy/4YLtJoWF5nnMW6LiDjbIFRTgAQT0gJwfMFoylNqDnOA/sdMGWbxq
	BZm4tb0BMwEveGpNtDklL/idJyHDdbMTuU20JX0Y8kjCnnJXBXwRtYPALUe1+5+VEBT6A/d4VsN2g
	1g+0RaO0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kA7RL-0002bc-JD; Mon, 24 Aug 2020 08:02:51 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA7RI-0002aI-5i
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 08:02:49 +0000
Received: by mail-pf1-f196.google.com with SMTP id u20so4424519pfn.0
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 01:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u5ca2zMzXa9+SBEBF4gB5brEqW8L2Nxl8kv4oWx4+/c=;
 b=byW0l9oycqgE5DZbR1AaKPbSAkHsrk2WZFHmquGOwSn+uYTBzaxcXTDpsx/r8Z8y7O
 Srh0IxkRtFmFI/7xC1+4zID+DdwhRKoQj7VEvuq914PK7AQRST5UF8LoEk91g43lsfy9
 Y3XLbZPT56+/UOyOY4NHu0rJPAgm0WFFo8mUlvh97UTWFphyCzXz7+7tRuroyt6+B4Ah
 74jH9xnuIKt2E0fWuQFzyvOYwRSqoCZU0CUQupI3kaUDCYNSPTUEDcmE85CTdJX9MEQl
 XgyTv4fdoVkv1TKeGCZsr8gRHE9IHvCzO73tP2W9fejEMQ8AbO3Fekeh/qJ5iLEw6q3L
 1lnQ==
X-Gm-Message-State: AOAM531V4UTozL5EwGyPjb8oHkBazDu/HAESQ/Sg1lMeNDJr44iJT1p4
 xaTs5Ing2STIdPhx56nSHlLSoE27kDSzLw==
X-Google-Smtp-Source: ABdhPJx1NLP1aJveM9a5yauO4m/4PgZXi113eTpDuXx0mEl0LPPgCBTq01jma5EkNXX2eaBNuJ5Mgg==
X-Received: by 2002:a63:5a0f:: with SMTP id o15mr2724211pgb.187.1598256162280; 
 Mon, 24 Aug 2020 01:02:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id u62sm10492566pfb.4.2020.08.24.01.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 01:02:41 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
Date: Mon, 24 Aug 2020 01:02:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821062217.GC28559@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_040248_348885_3B9A13DC 
X-CRM114-Status: GOOD (  19.44  )
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

Cj4+IEkgc3RpbGwgZGlzbGlrZSBhbnkgcmFuZG9tIGlvY3RscyBjb21pbmcgaW4gd2hpbGUgd2Un
cmUgc3RpbGwgaW5pdGlhbGl6aW5nCj4+IHRoZSBjb250cm9sbGVyLgo+IAo+IEFncmVlZC4KPiAK
Pj4gIMKgIExvb2tpbmcgYXQgdGhlIGZsb3cgLSBJIHdvdWxkbid0IHdhbnQgdGhlbSB0byBiZSBh
bGxvd2VkCj4+IHVudGlsIGFmdGVyIG52bWVfaW5pdF9pZGVudGlmeSgpIGlzIGNvbXBsZXRlLiBF
c3BlY2lhbGx5IGlmIHRoZSBpb2N0bHMgYXJlCj4+IGRvaW5nIHN1YnN5c3RlbSBvciBjb250cm9s
bGVyIGR1bXBpbmcgb3IgdXNpbmcgY29tbWFuZHMgdGhhdCBzaG91bGQgYmUKPj4gY2FwcGVkIGJ5
IHZhbHVlcyBzZXQgYnkgbnZtZV9xdWV1ZV9saW1pdHMoKS7CoMKgIEJ1dCwgaWYgd2UncmUgZ29p
bmcgdG8KPj4gYWxsb3cgbnZtZV9pbml0X2lkZW50aWZ5IHRoZSBhZG1pbl9xIG5lZWRzIHRvIGJl
IHVucXVpZXNjZWQuCj4+Cj4+IFNvIEknbSBzdGlsbCB2b3RpbmcgZm9yIHRoZSBhZG1pbiBxdWV1
ZSBleGNlcHRpb24uCj4gCj4gQW5kIEkgcmVhbGx5IGRvbid0IGxpa2UgdGhlIGFkbWluIHF1ZXVl
IHNwZWNpYWwgY2FzZS4gIFdoYXQgaXMgdGhlCj4gYWR2YW50YWdlIG9mIGxldHRpbmcgdXNlciBz
cGFjZSBwYXNzdGhyb3VnaCBJL08gY29tbWFuZHMgaW4gYXQgdGhpcwo+IHBvaW50IGluIHRpbWU/
CgpJIGNoZWNrZWQgYWdhaW4sIGFuZCByZWdhcmRpbmcgdGhlIGNvbW1lbnQ6CgoiSSdtIHN0aWxs
IHJhdGhlciBib3RoZXJlZCB3aXRoIHRoZSBhZG1pbiBxdWV1ZSBleGNlcHRpb24uICBBbmQgZ2l2
ZW4gdGhhdAp0aGUgcV91c2FnZV9jb3VudGVyIHByb2JsZW0gc2hvdWxkIG9ubHkgcmVhbGx5IGJl
IGFuIGlzc3VlIGZvciBmaWxlIHN5c3RlbQpyZXF1ZXN0cywgYXMgcGFzc3Rocm91Z2ggcmVxdWVz
dHMgZG8gbm90IGF1dG9tYXRpY2FsbHkgZ2V0IHJldHJpZWQgd2h5CmNhbid0IHdlIGp1c3QgcmVq
ZWN0IGFsbCB1c2VyIGNvbW1hbmQgdG8gYmUgc3ltZXRyaWMgYW5kIHN0cmFpZ2h0IGZvcndhcmQ/
ClRoZSBjYWxsZXJzIGluIHVzZXJzcGFjZSBuZWVkIHRvIGJlIGFibGUgdG8gY29wZSB3aXRoIHJl
dHJ5YWJsZSBlcnJvcnMKYW55d2F5LiIKCmJsa19tcV9hbGxvY19yZXF1ZXN0IGNhbGxzIGJsa19x
dWV1ZV9lbnRlciwgd2hpY2ggbWVhbnMgdGhhdCBpZiB3ZSBkb24ndApsZXQgdGhlbSBpbiwgY29u
dHJvbGxlciByZXNldCBjYW4gaGFuZywganVzdCBsaWtlIGluIG5vcm1hbCBmcyBJL08uCgpTbyB3
ZSBlaXRoZXIga2VlcCB0aGlzIGV4Y2VwdGlvbiBmb3IgYWRtaW4gY29tbWFuZHMsIG9yIHdlIGFs
c28gbGV0CnRoZW0gdGhyb3VnaCBhcyBpdCBzZWVtcyB0byBiZSBzYWZlIHdpdGggdGhlIGN1cnJl
bnQgY29kZSAoZnJvbSB0aGUKcmVzZXQgZm9yd2FyZC1wcm9ncmVzcyBwZXJzcGVjdGl2ZSkuCgpJ
IHZvdGUgdG8gcmVtb3ZlIHRoaXMgZXhjZXB0aW9uIGFsdG9nZXRoZXIuLi4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
