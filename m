Return-Path: <SRS0=CCYl=OH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E446C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Sep 2021 05:39:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217D1610A6
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Sep 2021 05:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 217D1610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=et4M7PQL39odp8IvjF0aeCAUIY+QgDUlvRBy3s8/iOY=; b=5A8pjCy5yAqYLF8rVPYGg+XQwq
	b3zGODha7nSujI7uUBMiKjaeI2+H7JN7VrV/ATHvRnHhrkX//1NqqtzkiANaTTfTML5ZdvPT+Evs1
	n7p+KEc6YTbimoTKkQxuTT1nEx75aJbKhjD9/neO4NkYU6cJmsHjwFiNwnPBa3OdzOhz1aR9RUaZI
	lwr/lSK8rZWI4+V8wQog4UBQ38DwWq+gvxm0hG3YpOggoeAQSLcKMeYvofDdyi+RyUcQOMCDRu3NT
	wxQ7kZi6flembhUoRRl+N+MgWokxaqdC0O4EKT2risbXfGXuBfNTdtdHMznsSt+iFaMKmJwihwbhd
	grpXdhEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR6az-00DEvU-R3; Fri, 17 Sep 2021 05:39:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR6ax-00DEux-Ct
 for linux-nvme@lists.infradead.org; Fri, 17 Sep 2021 05:39:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA6EF223D6;
 Fri, 17 Sep 2021 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631857167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zwpvkk7fUN97D6tfIfLdNxYQn4+G07i9NKDiltPKe9I=;
 b=ucgVEW5ZnU4o6ESHSC5QHhqElCBH6fPmtJjcUKBerAWGTfW+uvPTiacJbKUbqFOtzhHfgC
 4W7UKbw2oihiFGp8jXmDZO0PZ9dkE1UPrQzrP+7YBDedPE/sWDKrtyU9piLYcWebyutmBA
 U7zyfxFmH92l7wVg9NbbzS/5rZNC838=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631857167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zwpvkk7fUN97D6tfIfLdNxYQn4+G07i9NKDiltPKe9I=;
 b=bGYgikJf626dVI5r9OkLInm6EJ5OeMLufAYtCSY8vPGeH8tQF/VJEI+XoOtpUyRxvre3Ir
 TjPpwSRTw/GbshBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5928113A67;
 Fri, 17 Sep 2021 05:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GUjSEA8qRGGNZwAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 17 Sep 2021 05:39:27 +0000
Subject: Re: [PATCH 05/12] nvme: add definitions for NVMe In-Band
 authentication
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-6-hare@suse.de>
 <01a48055-c292-5383-efff-6d1ef86d404f@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <779cc530-534e-8b2c-f82d-3675ab685673@suse.de>
Date: Fri, 17 Sep 2021 07:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <01a48055-c292-5383-efff-6d1ef86d404f@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_223931_634770_844DD1CA 
X-CRM114-Status: GOOD (  16.29  )
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

T24gOS8xNi8yMSA3OjA0IFBNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6Cj4gT24gOS85LzIx
IDExOjQzIFBNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5l
cyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+PiAtLS0KPj4gICAgaW5jbHVkZS9saW51eC9udm1l
LmggfCAxODYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMTg1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPiAK
PiBQcm9iYWJseSB3b3J0aCBtZW50aW9uaW5nIGEgVFAgbmFtZSBoZXJlIHNvIHdlIGNhbiByZWZl
ciBsYXRlciwKPiBpbnN0ZWFkIG9mIGVtcHR5IGNvbW1pdCBtZXNzYWdlID8KPiAKSGFkIGJlZW4g
dGhpbmtpbmcgYWJvdXQgaXQsIGJ1dCB0aGVuIGRlY2lkZWQgYWdhaW5zdCBpdC4gT25jZSB0aGUg
VFBBUgppcyBmb2xkZWQgaW50byB0aGUgbWFpbiBzcGVjIGl0J3MgZ2V0dGluZyByZWFsbHkgaGFy
ZCB0byBmaWd1cmUgb3V0IApleGFjdGx5IHdoYXQgaW5kaXZpZHVhbCBUUEFScyB3ZXJlIHJlZmVy
cmluZyB0bywgc28gSSBwcmVmZXIgdG8gc3RpY2sKd2l0aCAnSW4tQmFuZCBhdXRoZW50aWNhdGlv
bicgaW5zdGVhZCBvZiB0aGUgVFBBUiBudW1iZXIuCkJ1dCBJIGNhbiBhZGQgdGhhdCB0byB0aGUg
Y29tbWl0IG1lc3NhZ2UsIHN1cmUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5k
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
