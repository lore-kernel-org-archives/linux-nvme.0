Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8DDC48BC2
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:41:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B179560FE5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B179560FE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AXhpxX+xm7ixR+whvRKC6kT5/ZDBcRc84Q2AhKqEn/I=; b=PoOxh01ZB4pJ8Waoq5nVQaAuVn
	WWkW7x8kdtCDqaD1ngQzftIoKLdbH4SZgsrSjt7TviEUaRtoRNs1fVfBG7MGKqbOqsj10dMnBsQCZ
	BVF55t9/CqOgUw3/3Q85Cx8Tjp+ikhFxA72MgO9gKFfoko6o4y5dkLyXPXknmPWWE1keHNeIBO4d2
	1UGeSgnNo/2xhQ22fVKcgqF6iZGpVEDWT/dCa82PJpAy/Wh4cWw0tannTUJUgNkfMBgTQKH7h4lhT
	QPZo0oqRFEeCVvBkTdT6lxsoYnAqrWY5DPpfJRzaNos0Oe5N+lxfVBADELGWDvR5NemOXeXCuO6BI
	LUi5oGBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwAcs-00C1oX-Pt; Wed, 23 Jun 2021 21:41:38 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwAcp-00C1no-RU
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 21:41:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 p8-20020a7bcc880000b02901dbb595a9f1so2255633wma.2
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 14:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vtuy5yt1p+07K5q9tNefPRvHCpEo4eYs0hEpmsHr/Jc=;
 b=RO1u2mOactwFag5vhsAQKmglvXG/Cduw83ayWK3y8vg/BqflXpcg/JRjETJ0dydZdv
 3w3Dfr5+NRu6PEs28HoAqxliRF82RallXGh8S7P52QWOWT3zrKK14NWJj/3YLlAT4QFu
 O81njm/MRuK4rT7B+4ji63T/NPCmDqc7X/Wzk6HX2t2A0J9WUBxByz//H5CMtKTc7jke
 +yuzsPjVdOZ8/QN1Z8D61Rzy93S8z1lyouG89CdJdbvpkT5Tm2fpWnbKoNz3uRyq3WBx
 IwDHklOvZQzJbhF0eS9ZwV77B0n0w06r7zmuqUqdSlYfr/6V2cxHiS4I/6OuxArBpSLc
 6fWA==
X-Gm-Message-State: AOAM53240/TwTCdVyh83CBzy1mVhakkkepCBH1QVUOi9HlTFNvk5MM2u
 V6QfrlL+lZN14iUMaMUeGIQAzNkG/90=
X-Google-Smtp-Source: ABdhPJx9avnc9i7JibtIE26lZEyd+vf2O0ElACokNXiQjKKPjM16OtDBgL0eIYYb6EoWAKk5LobFzQ==
X-Received: by 2002:a05:600c:ad6:: with SMTP id
 c22mr186728wmr.145.1624484494263; 
 Wed, 23 Jun 2021 14:41:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d7a5:9de1:faa6:69b7?
 ([2601:647:4802:9070:d7a5:9de1:faa6:69b7])
 by smtp.gmail.com with ESMTPSA id 12sm4901773wmj.12.2021.06.23.14.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 14:41:33 -0700 (PDT)
Subject: Re: [PATCHv7] nvme: fix refcounting imbalance when all paths are down
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210622070140.22488-1-hare@suse.de>
 <6679737f-1af8-bc9e-5af1-ce3fac5b4d01@grimberg.me>
 <a5baf9d1-47af-7a9a-e08f-f75c12429413@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2d42c1ee-82c3-b53b-0fdc-baf9add01ec2@grimberg.me>
Date: Wed, 23 Jun 2021 14:41:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a5baf9d1-47af-7a9a-e08f-f75c12429413@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_144135_935700_DDA17FC2 
X-CRM114-Status: GOOD (  15.50  )
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

Cj4+PiArdm9pZCBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0aChzdHJ1Y3QgbnZtZV9uc19oZWFk
ICpoZWFkKQo+Pj4gIMKgIHsKPj4+ICvCoMKgwqAgYm9vbCBsYXN0X3BhdGggPSBmYWxzZTsKPj4+
ICDCoMKgwqDCoMKgIGlmICghaGVhZC0+ZGlzaykKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+Pj4gLcKgwqDCoCBpZiAoaGVhZC0+ZGlzay0+ZmxhZ3MgJiBHRU5IRF9GTF9VUCkgewo+
Pj4gLcKgwqDCoMKgwqDCoMKgIG52bWVfY2Rldl9kZWwoJmhlYWQtPmNkZXYsICZoZWFkLT5jZGV2
X2RldmljZSk7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgZGVsX2dlbmRpc2soaGVhZC0+ZGlzayk7ID4g
Kwo+Pj4gK8KgwqDCoCAvKiBTeW5jaHJvbml6ZSB3aXRoIG52bWVfaW5pdF9uc19oZWFkKCkgKi8K
Pj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmaGVhZC0+c3Vic3lzLT5sb2NrKTsKPj4+ICvCoMKgwqAg
aWYgKGxpc3RfZW1wdHkoJmhlYWQtPmxpc3QpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbGlzdF9k
ZWxfaW5pdCgmaGVhZC0+ZW50cnkpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGxhc3RfcGF0aCA9IHRy
dWU7Cj4+PiAgwqDCoMKgwqDCoCB9Cj4+Cj4+IFdoYXQgaGFwcGVucyBub3cgaWYgQ09ORklHX05W
TUVfTVVMVElQQVRIIGlzIG5vdCBzZXQ/IEknbSBub3Qgc3VyZSB0aGlzCj4+IHNob3VsZCBiZSBk
b25lIGhlcmUuLi4KPiAKPiBJIGRvbid0IG1pbmQgX3doZXJlXyB0aGlzIGNvZGUgZW5kcyB1cC4K
PiBBcyBsb25nIGFzIHdlIGNhbiBhZ3JlZSB0aGF0IHdlIHNob3VsZCBkbyBib3RoLCBsaXN0X2Rl
bF9pbml0KCkgYW5kCj4gZGVsX2dlbmRpc2soKSBhdCB0aGUgc2FtZSB0aW1lIHdoZW4gd2UgZmlu
ZCB0aGF0IHRoZSBsYXN0IHBhdGggaXMgZGVhZC4KPiBEbyB3ZT8KClllcywgYW5kIGluZGVwZW5k
ZW50bHkgZnJvbSB1c2VyL2ZzIHJlZmVyZW5jZXMuLi4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
