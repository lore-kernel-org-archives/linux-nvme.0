Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EACC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:40:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A4E613E9
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A4E613E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0nlGUhf5KiLbpxGl8j+tDYp2UOd5Xr/Iikng1erXU/Y=; b=fHGv4ISgkIjKPWGiinRnepFuy
	sCdbSfbEsh7B2Xi/CzBvo4Q12E6h8J4pG9U/G1d/XfLzq9E85uZt4MkubHr9DILlNTKf3MfQ/yYjc
	nRb9WJ92gQTW6W1fdsrHjBETXV3+tPcaa/jO9IVkSJDu/BWdi+jOZ3U0BRPq6MxVqq8wxYhH87JPd
	BjHlwbMLGOq2NTTYNs0na+XRYGXwR6B9g6dxm5OVLdrD+jv4HSgNZ4MG72I/v8ygpiCxNIzWrRmHJ
	CqQh89aP8aAM7PyDEcR0YWi6A2Iss1SWBYwtli42DHztQAU74OHZUUWeFc8v6rxvJ6GJGGZaPbVT4
	Idfbm5EVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leOJx-002I6c-GK; Wed, 05 May 2021 20:40:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leOJv-002I6P-TL
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 20:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=1dhpzPlcuYR7KKb/A8jB+TRISEfFY+rYkotjnhQdxi4=; b=yep3gPz+gKP6itHCC32NR0FE6N
 lIXgH8mF+I3KTvJR0bofHeSLv1LZ6btLwuSjxw4fbDlhAxMl70Da+enmCum4NmuX4njb7OhBm792J
 gERaKDTaW8UK8bU2R7mwNU61T9GjmWakS3pSc9hpKSFE4G/Z3op2gc+fAF7fz0QMllu/Y+nKntAht
 4b2Xk+pGyaevzwDr30EEPJGok+MFUQ3VNxEGOnGxjctKG+X7hz2plRTL1IGoLyhvRIWCZZW/9ztQq
 yuIa0i8EwzjlHeYpLQSpplb+fj4eHLhYVepaefPFVw6sAlsTTffvr+y77BmbpCxJkgXXQlZR7mrnd
 ohj/3YcQ==;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leOJs-005Fkb-By
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 20:40:34 +0000
Received: by mail-pl1-f180.google.com with SMTP id v20so1768156plo.10
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 13:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1dhpzPlcuYR7KKb/A8jB+TRISEfFY+rYkotjnhQdxi4=;
 b=HqOoO8Nx4gVv9GfL6W9AXLIyMHc8uZ4WU6qALiZWyHbb8ePKpv552AdYz0y7noLqsI
 f2FCXg8IlAFKYi/j4csRzwRUHHmZx5i+3tLGb7Pfix7WfjkZqJ2KNl9HM45W+N5y6jIY
 imkNVgf+sOSGbTVnphoBVNKoM6x5v70GMHsbLWb66uCV8c3xdsrsXWQR3npXUMFnQPJJ
 Qf+9xw671Os8ZyIAmAqRNQ3GW2RGs2K0fYH6TbGVK0eADcF9nKQelx8DHT661r33bQPw
 3iVFzQdmlzbLzAqprIvG6raDIwQyl2rpHkD3/MuXSwjtlz7zECx+USGz8sBukuWOxJOW
 2XNw==
X-Gm-Message-State: AOAM533O9Pp1a7fy5LbCHNokl/Y7HNxLkXc4SasDu+72GwX/92Rah4y4
 27B4NsHbklzlUpPTOhcY5vE=
X-Google-Smtp-Source: ABdhPJwTZc6HPlEBj77VRuAN9nba8PXK5EH8HG5o4EyqEOlcgziUU9ZZs+s5XyhZIGtYGs8+Id4v0g==
X-Received: by 2002:a17:90a:a60b:: with SMTP id
 c11mr446316pjq.125.1620247231044; 
 Wed, 05 May 2021 13:40:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e504:8c1:c1db:d524?
 ([2601:647:4802:9070:e504:8c1:c1db:d524])
 by smtp.gmail.com with ESMTPSA id k8sm118034pfp.99.2021.05.05.13.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 13:40:30 -0700 (PDT)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210505152659.GB912679@dhcp-10-100-145-180.wdc.com>
 <6a43fe69-e73a-07f8-f050-8116add83074@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8a274c79-6db8-a21b-e60e-4e73a9d139b5@grimberg.me>
Date: Wed, 5 May 2021 13:40:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6a43fe69-e73a-07f8-f050-8116add83074@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_134032_429061_0E17D6C3 
X-CRM114-Status: GOOD (  24.25  )
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

Cj4+Pj4+IEFzIHN0YXRlZCBpbiB0aGUgdjMgcmV2aWV3IHRoaXMgaXMgYW4gaW5jb21wYXRpYmxl
IGNoYW5nZS7CoCBXZSdsbCBuZWVkCj4+Pj4+IHRoZSBxdWV1ZV9pZl9ub19wYXRoIGF0dHJpYnV0
ZSBmaXJzdCwgYW5kIGRlZmF1bHQgaXQgdG8gb24gdG8ga2VlcAo+Pj4+PiBjb21wYXRhYmlsaXR5
Lgo+Pj4+Pgo+Pj4+Cj4+Pj4gVGhhdCBpcyB3aGF0IEkgdHJpZWQgdGhlIGxhc3QgdGltZSwgYnV0
IHRoZSBkaXJlY3Rpb24gSSBnb3Qgd2FzIHRvIHRyZWF0Cj4+Pj4gYm90aCwgTlZNZS1QQ0kgYW5k
IE5WTWUtb0YgaWRlbnRpY2FsbHk6Cj4+Pj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW52bWUvMzRlNWMxNzgtOGJjNC02OGQzLTgzNzQtZmJjMWI0NTFiNmU4QGdyaW1iZXJnLm1lLykK
Pj4+Cj4+PiBZZXMsIEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgeW91ciBjb21tZW50IENocmlz
dG9waC4gVGhpcyBhZGRyZXNzZXMgYW4KPj4+IGlzc3VlIHdpdGggbWRyYWlkIHdoZXJlIGhvdCB1
bnBsdWcrcmVwbHVnIGRvZXMgbm90IHJlc3RvcmUgdGhlIGRldmljZSB0bwo+Pj4gdGhlIHJhaWQg
Z3JvdXAgKHBjaSBhbmQgZmFicmljcyBhbGlrZSksIHdoZXJlIGJlZm9yZSBtdWx0aXBhdGggdGhp
cyB1c2VkCj4+PiB0byB3b3JrLgo+Pj4KPj4+IHF1ZXVlX2lmX25vX3BhdGggaXMgYSBkbS1tdWx0
aXBhdGggZmVhdHVyZSBzbyBJJ20gbm90IGVudGlyZWx5IGNsZWFyCj4+PiB3aGF0IGlzIHRoZSBj
b25jZXJuPyBtZHJhaWQgb24gbnZtZSAocGNpL2ZhYnJpY3MpIHVzZWQgdG8gd29yayBhIGNlcnRh
aW4KPj4+IHdheSwgd2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIG52bWUtbXBhdGggdGhlIGJlaGF2
aW9yIHdhcyBicm9rZW4gKGFzIGZhcgo+Pj4gYXMgSSB1bmRlcnN0YW5kIGZyb20gSGFubmVzKS4K
Pj4+Cj4+PiBNeSB0aGlua2luZyBpcyB0aGF0IGlmIHdlIHdhbnQgcXVldWVfaWZfbm9fcGF0aCBm
dW5jdGlvbmFsaXR5IGluIG52bWUKPj4+IG1wYXRoIHdlIHNob3VsZCBoYXZlIGl0IGV4cGxpY2l0
bHkgc3RhdGVkIHByb3Blcmx5IHN1Y2ggdGhhdCBwZW9wbGUKPj4+IHRoYXQgYWN0dWFsbHkgbmVl
ZCBpdCB3aWxsIHVzZSBpdCBhbmQgaGF2ZSBtZHJhaWQgZnVuY3Rpb24gY29ycmVjdGx5Cj4+PiBh
Z2Fpbi4gQWxzbywgcXVldWVfaWZfbm9fcGF0aCBhcHBsaWVzIHJlYWxseSBpZiBhbGwgdGhlIHBh
dGhzIGFyZQo+Pj4gZ29uZSBpbiB0aGUgc2Vuc2UgdGhleSBhcmUgY29tcGxldGVseSByZW1vdmVk
LCBhbmQgZG9lc24ndCBhcHBseQo+Pj4gdG8gY29udHJvbGxlciByZXNldC9yZWNvbm5lY3QuCj4+
Pgo+Pj4gSSBhZ3JlZSB3ZSBzaG91bGQgcHJvYmFibHkgaGF2ZSBxdWV1ZV9pZl9ub19wYXRoIGF0
dHJpYnV0ZSBvbiB0aGUKPj4+IG1wYXRoIGRldmljZSwgYnV0IGl0IGRvZXNuJ3Qgc291bmQgcmln
aHQgdG8gZGVmYXVsdCBpdCB0byB0cnVlIGdpdmVuCj4+PiB0aGF0IGl0IGJyZWFrcyBtZHJhaWQg
c3RhY2tpbmcgb24gdG9wIG9mIGl0Li4KPj4KPj4gSWYgeW91IHdhbnQgInF1ZXVlX2lmX25vX3Bh
dGgiIGJlaGF2aW9yLCBjYW4ndCB5b3UganVzdCBzZXQgcmVhbGx5IGhpZ2gKPj4gcmVjb25uZWN0
X2RlbGF5IGFuZCBjdHJsX2xvc3NfdG1vIHZhbHVlcz8gVGhhdCBwcmV2ZW50cyB0aGUgcGF0aCBm
cm9tCj4+IGJlaW5nIGRlbGV0ZWQgd2hpbGUgaXQgaXMgdW5yZWFjaGFibGUsIHRoZW4gcmVzdGFy
dCBJTyBvbiB0aGUgZXhpc3RpbmcKPj4gcGF0aCBvbmNlIGNvbm5lY3Rpb24gaXMgcmUtZXN0YWJs
aXNoZWQuCj4+Cj4gUHJlY2lzZWx5IG15IHRoaW5raW5nLgo+IFdlIF9jb3VsZF8gYWRkIGEgcXVl
dWVfaWZfbm9fcGF0aCBhdHRyaWJ1dGUsIGJ1dCB3ZSBjYW4gYWxzbyBhY2hpZXZlIHRoZQo+IHNh
bWUgYmVoYXZpb3VyIGJ5IHNldHRpbmcgdGhlIGN0cmxfbG9zc190bW8gdmFsdWUgdG8gaW5maW5p
dHkuCj4gUHJvdmlkZWQgd2UgY2FuIGNoYW5nZSBpdCBvbiB0aGUgZmx5LCB0aG91Z2g7IGJ1dCBp
dCBub3QgdGhhdCdzIGVhc2lseQo+IGZpeGVkLgo+IAo+IEluIGZhY3QsIHRoYXQncyB3aGF0IHdl
IHJlY29tbWVuZCB0byBvdXIgY3VzdG9tZXJzIHRvIGF2b2lkIHRoZSBidWcKPiBmaXhlZCBieSB0
aGlzIHBhdGNoLgoKWW91IGNhbiBjaGFuZ2UgY3RybF9sb3NzX3RtbyBvbiB0aGUgZmx5LiBIb3cg
ZG9lcyB0aGF0IGFkZHJlc3MgdGhlCmlzc3VlPyB0aGUgb3JpZ2luYWwgaXNzdWUgaXMgY3RybF9s
b3NzX3RtbyBleHBpcmVzIGZvciBmYWJyaWNzPyBvcgpwY2kgdW5wbHVnICh3aGljaCBjdHJsX2xv
c3NfdG1vIGRvZXMgbm90IGFwcGx5IHRvIGl0KT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
