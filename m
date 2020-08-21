Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE5C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 20:17:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68A120735
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 20:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fmquqhrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68A120735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jEgP8dxBqjpkfUr6e3ceZaM/NxMP9WmIcTGcGk4Mdck=; b=Fmquqhrb7TFHnsJVwDgaDOWjH
	SHmE74/tCRu4H4iV77LT2imWPgimu68ozrq0vJHWJ3Z4tPFDNPZJCot8EmNe6NZVVN/Awi80VdSTE
	piBMk7tRI4ONPOI8P2hvCPyPVcdflRNUu4bw5uNWqCeW3JDMui6gi+x97seIfmgJVZ8UvLO8cyHRx
	fdAcWqk+Y9aTp9JC25Ry2nU7m4CTYi9Hqom+TIBVF6h+SSTfwOxTVExJ+qGyzNuN/I1xctdsP7qmV
	nj9fvSjTEf6TuML8KQI86W6sOtordH5OIKYltxMI3dZp8qtB/U3BJeI0k3a2fFKAn5Fg1orjPeSs+
	642gLZSYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9DTh-0001Gt-Nu; Fri, 21 Aug 2020 20:17:33 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9DTf-0001GK-9K
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 20:17:32 +0000
Received: by mail-pl1-f193.google.com with SMTP id h2so1388818plr.0
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 13:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TvqfbIal1fhViLBt0TJDTBGBgyQJ/PvbcwMzTTzIF3Q=;
 b=T5KbZuLOYo1uRSmP3c4GBz6RGKIbvslHEh4U5+6fv0EZWlU8JRZSFveh24eY4rSOJu
 IMkTDNDom8SxyrLoASAZ/KXRO172tqTdsfWMU4smAIjStC+gRdrc7y8BIrGoKhEXqgC3
 L98Al64byn4C1//pF61lX0uDWoom8+J+ab4cwXos6NREbwunPZx0eId0QVeRHlmaUd/E
 nQY7RoUtkHwdQcrDlToxAL2B8baRrOrouJ9SFr+/4GmxY2SKUqF2EqcS2Vue4j/YVNP8
 SZvRgsApX+YmVmHxsWBwV0dZkO6JHzQFCCleKZin86GaoREb4KzRi2nTaJUCQmHeJDAd
 rNuQ==
X-Gm-Message-State: AOAM533Unhp9sha1GD4NstVEBqnj2pOS00ClAZ/z8/cI7DnM4TcZK93p
 rhlAYFQbT+X16APZqPB1f0E=
X-Google-Smtp-Source: ABdhPJw6iWLIY01PJTBPYf9ddwJiu0zY5IHMSZMFyaax6pEtVMSk+Tx6CkxF6BiShYabwNfo442YPg==
X-Received: by 2002:a17:90b:4c46:: with SMTP id
 np6mr3904034pjb.201.1598041049624; 
 Fri, 21 Aug 2020 13:17:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712?
 ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
 by smtp.gmail.com with ESMTPSA id a199sm3042782pfa.201.2020.08.21.13.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 13:17:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
References: <20200820035413.1790-1-lengchao@huawei.com>
 <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
 <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
 <20200821074910.GA30216@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ebfa21a4-57a1-f350-8fbc-92f35770dc93@grimberg.me>
Date: Fri, 21 Aug 2020 13:17:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821074910.GA30216@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_161731_360581_8797C4D5 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gLXN0YXRpYyB2b2lkIG52bWVfZW5hYmxlX2FlbihzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
KQo+Pj4+ICtzdGF0aWMgaW50IG52bWVfZW5hYmxlX2FlbihzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
KQo+Pj4+ICDCoCB7Cj4+Pj4gIMKgwqDCoMKgwqAgdTMyIHJlc3VsdCwgc3VwcG9ydGVkX2FlbnMg
PSBjdHJsLT5vYWVzICYgTlZNRV9BRU5fU1VQUE9SVEVEOwo+Pj4+ICDCoMKgwqDCoMKgIGludCBz
dGF0dXM7Cj4+Pj4gIMKgwqDCoMKgwqAgaWYgKCFzdXBwb3J0ZWRfYWVucykKPj4+PiAtwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiAgwqDC
oMKgwqDCoCBzdGF0dXMgPSBudm1lX3NldF9mZWF0dXJlcyhjdHJsLCBOVk1FX0ZFQVRfQVNZTkNf
RVZFTlQsIHN1cHBvcnRlZF9hZW5zLAo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBO
VUxMLCAwLCAmcmVzdWx0KTsKPj4+PiAtwqDCoMKgIGlmIChzdGF0dXMpCj4+Pj4gK8KgwqDCoCBp
ZiAoc3RhdHVzKSB7Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybihjdHJsLT5kZXZp
Y2UsICJGYWlsZWQgdG8gY29uZmlndXJlIEFFTiAoY2ZnICV4KVxuIiwKPj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdXBwb3J0ZWRfYWVucyk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChzdGF0dXMgPCAwKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzdGF0
dXM7Cj4+Pgo+Pj4gV2h5IGRvIHlvdSBuZWVkIHRvIGNoZWNrIHN0YXR1cyA8IDAsIHlvdSBuZWVk
IHRvIGZhaWwgaXQgcmVnYXJkbGVzcy4KPj4KPj4gYWdyZWUuCj4+IEp1c3Qgd2FudCB0byBrZWVw
IHRoZSBvbGQgbG9naWMuIEkgZ3Vlc3MgdGhlIG9sZCBsb2dpYzogaWYgc3VwcG9ydGVkX2FlbnMK
Pj4gaXMgdHJ1ZSwgdGhlIHJlc3VsdCBvZiBzZXQgZmVhdHVyZXMgY2FuIGlnbm9yZS4KPj4KPj4g
SWYgdGhlcmUgaXMgbm8gb2JqZWN0aW9uIHRvIGRvaW5nIHNvLCBJIHdpbGwgcmVzZW5kIHRoZSBw
YXRjaCBsYXRlci4KPiAKPiBJbiB0aGUgcGFzdCB3ZSd2ZSBkZWRpY2UgdG8gaWdub3JlIHJlYWwg
TlZNZSBlcnJvcnMgaW4gdmFyaW91cwo+IHNwb3RzIGFzIHRoZSBmdW5jdGlvbmFsaXR5IHdhc24n
dCBkZWVtZWQgY3JpdGljYWwuICBJIHRoaW5rIHRoYXQgaXMKPiBwcmV0dHkgc2xvcHB5IGFuZCB3
ZSBzaG91bGQgb25seSBkbyB0aGF0IHdoZXJlIHdlIHJlYWxseSBoYXZlIHRvLgoKQWdyZWVkLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
