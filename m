Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36484C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:54:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1803611CB
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1803611CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VgjBbZdddjznRoFNbE0dAOdp6BUUHqG8cwzhF3NoWHI=; b=aTSsxGrmRlOfc07fXLelrcfRS
	IlXJfZOBww1KE9KiN3RmsWj61fdVHJ4OrHanf8l3KuCqBvydtAeIp1EBHFpYikJ7KZmsjqc12CUB5
	PTXJcZVYNqOPv7SLxNyYj6k4/nqiuRyblFZlyk8PihS8XH08t4rtNsI9bvnHrOGOjhKPs7yhDYEWN
	oi5xEoboD9PYaZ0aj5pvEPSvflPMrE5aA658rxHIAZHSpgO0x3wNsoBVjWcvOSFRf6x04x+ZfF5sT
	pjLPSM12JkhaH2Ls/hWsfiYvfYt9g0Doql0lKFRMQu/qmdYEpHIzxr0hFqaDs9+3xOKnFM7XW5jtK
	10nrkcP1w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le17g-00GxPM-Fg; Tue, 04 May 2021 19:54:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le17d-00GxOz-Da
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 19:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=/zELKshvdMa3mdEUTH1Un7i6bHYM09D5eo7lljyB9KE=; b=0FKx2vTnuJCvdU0iSkmB+ySVq7
 aLRiIcztOZ7RAZ4386CrUK4LB7CAdD7Dy5otb2tY4A2Ogf3hOhajwkqofAi4dHRQOOjE32Gax94cb
 TgoeLeAYN8BupLKE/ghJMGStBGvz2xasjiKta3WyceOZmsr6SzOOOODfPMz1NCRNlw4m/jKmHREnv
 9wjxocDopj4LzHvMQZHFKkxozplv7aIWMikh4zgk0oA/OpY8cohwdsXKksuiGAE0kD7KgJKi6sLju
 7M1WniCVeA4I7Wgwo6yph1KxAHIIan7GEMUjhrAE7Q17WvGKbFli47ugMdcej3Q9m1zvb4/W6rnY8
 22o8Jjiw==;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le17a-004EPn-H2
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 19:54:20 +0000
Received: by mail-pf1-f178.google.com with SMTP id v191so68961pfc.8
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 12:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/zELKshvdMa3mdEUTH1Un7i6bHYM09D5eo7lljyB9KE=;
 b=BPPdTPNMZcebBxwCPrqslL6IxDt9nCtnU+LgWQow7erSoE5dKIXqDF0h9qwfJcfTFK
 BH2V9azBK0ufv6/dfZKp2RfWHRcX0WIK7klJ565XBf19SbAxBowF+zRWKjMIB5KgvXxh
 9OJYTMxeSiiEbJLmdKxC3KQSzRLZjzPg88kZrG7l2l82F9EbgZ0LQwFwKmsEe5OuqHsi
 khT4rnyILAXm6QOsGo87GRxu2g8Jg9LVIiqfhThbKdZQlL2YismDXpOgLLBuYev/IXEB
 1+QsSV/PTOeGWDXqGPJIEXkQxrMFU9ZbC3uaj41X/yKjLdLwvelztz5mSZQGIiMXW2NP
 9+Gw==
X-Gm-Message-State: AOAM531mZeD8gBM75UmH3nR1c4FHYn0/FX1oOQa7WGkJ823OHaO/GU5X
 qCedDTbFPfykESH1gZeKWPs=
X-Google-Smtp-Source: ABdhPJz+eFQDn4V3DALCWddmEa23mif9VopMAT4Ga5xW3stY7h+jBJaAfryO2RTwcqHLq5tuQb7b6w==
X-Received: by 2002:a65:4281:: with SMTP id j1mr24445034pgp.348.1620158056740; 
 Tue, 04 May 2021 12:54:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dee:5152:2348:42c1?
 ([2601:647:4802:9070:dee:5152:2348:42c1])
 by smtp.gmail.com with ESMTPSA id j20sm4131943pgk.74.2021.05.04.12.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 12:54:16 -0700 (PDT)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
Date: Tue, 4 May 2021 12:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_125418_587659_26B9C892 
X-CRM114-Status: GOOD (  19.49  )
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

Cj4+IEFzIHN0YXRlZCBpbiB0aGUgdjMgcmV2aWV3IHRoaXMgaXMgYW4gaW5jb21wYXRpYmxlIGNo
YW5nZS7CoCBXZSdsbCBuZWVkCj4+IHRoZSBxdWV1ZV9pZl9ub19wYXRoIGF0dHJpYnV0ZSBmaXJz
dCwgYW5kIGRlZmF1bHQgaXQgdG8gb24gdG8ga2VlcAo+PiBjb21wYXRhYmlsaXR5Lgo+Pgo+IAo+
IFRoYXQgaXMgd2hhdCBJIHRyaWVkIHRoZSBsYXN0IHRpbWUsIGJ1dCB0aGUgZGlyZWN0aW9uIEkg
Z290IHdhcyB0byB0cmVhdCAKPiBib3RoLCBOVk1lLVBDSSBhbmQgTlZNZS1vRiBpZGVudGljYWxs
eToKPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8zNGU1YzE3OC04YmM0LTY4
ZDMtODM3NC1mYmMxYjQ1MWI2ZThAZ3JpbWJlcmcubWUvKSAKClllcywgSSdtIG5vdCBzdXJlIEkg
dW5kZXJzdGFuZCB5b3VyIGNvbW1lbnQgQ2hyaXN0b3BoLiBUaGlzIGFkZHJlc3NlcyBhbgppc3N1
ZSB3aXRoIG1kcmFpZCB3aGVyZSBob3QgdW5wbHVnK3JlcGx1ZyBkb2VzIG5vdCByZXN0b3JlIHRo
ZSBkZXZpY2UgdG8KdGhlIHJhaWQgZ3JvdXAgKHBjaSBhbmQgZmFicmljcyBhbGlrZSksIHdoZXJl
IGJlZm9yZSBtdWx0aXBhdGggdGhpcyB1c2VkCnRvIHdvcmsuCgpxdWV1ZV9pZl9ub19wYXRoIGlz
IGEgZG0tbXVsdGlwYXRoIGZlYXR1cmUgc28gSSdtIG5vdCBlbnRpcmVseSBjbGVhcgp3aGF0IGlz
IHRoZSBjb25jZXJuPyBtZHJhaWQgb24gbnZtZSAocGNpL2ZhYnJpY3MpIHVzZWQgdG8gd29yayBh
IGNlcnRhaW4Kd2F5LCB3aXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YgbnZtZS1tcGF0aCB0aGUgYmVo
YXZpb3Igd2FzIGJyb2tlbiAoYXMgZmFyCmFzIEkgdW5kZXJzdGFuZCBmcm9tIEhhbm5lcykuCgpN
eSB0aGlua2luZyBpcyB0aGF0IGlmIHdlIHdhbnQgcXVldWVfaWZfbm9fcGF0aCBmdW5jdGlvbmFs
aXR5IGluIG52bWUKbXBhdGggd2Ugc2hvdWxkIGhhdmUgaXQgZXhwbGljaXRseSBzdGF0ZWQgcHJv
cGVybHkgc3VjaCB0aGF0IHBlb3BsZQp0aGF0IGFjdHVhbGx5IG5lZWQgaXQgd2lsbCB1c2UgaXQg
YW5kIGhhdmUgbWRyYWlkIGZ1bmN0aW9uIGNvcnJlY3RseQphZ2Fpbi4gQWxzbywgcXVldWVfaWZf
bm9fcGF0aCBhcHBsaWVzIHJlYWxseSBpZiBhbGwgdGhlIHBhdGhzIGFyZQpnb25lIGluIHRoZSBz
ZW5zZSB0aGV5IGFyZSBjb21wbGV0ZWx5IHJlbW92ZWQsIGFuZCBkb2Vzbid0IGFwcGx5CnRvIGNv
bnRyb2xsZXIgcmVzZXQvcmVjb25uZWN0LgoKSSBhZ3JlZSB3ZSBzaG91bGQgcHJvYmFibHkgaGF2
ZSBxdWV1ZV9pZl9ub19wYXRoIGF0dHJpYnV0ZSBvbiB0aGUKbXBhdGggZGV2aWNlLCBidXQgaXQg
ZG9lc24ndCBzb3VuZCByaWdodCB0byBkZWZhdWx0IGl0IHRvIHRydWUgZ2l2ZW4KdGhhdCBpdCBi
cmVha3MgbWRyYWlkIHN0YWNraW5nIG9uIHRvcCBvZiBpdC4uCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
