Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097DDC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:26:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0D9207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mCG5aiIQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NLLP+qDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0D9207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V8B6LVDv8o/lYnC82KMxqC7eW7ahG7I5JB0DccOmk+M=; b=mCG5aiIQ5SpGmXlcel01z50CI
	E7iPXmOXcEWr8xnnoeOEX1yzPVR3G45SzQ93Ss/f0DCtKxm5wgxemNtzfm3g7YxeV9v/Fn3AKOc0R
	JpMSrdZIbCwrJ29MgU4GpM6kE5Ykzt1JZFk2yZzfgWNNw/a23BFghEKv/qXizMvgEFCmOPh+i77dO
	u/yM5PQoYHNIwJy9+oUkAII65bM3iIl6CYqF/7mdKR5Fup2ev0v05Rx54mnizBjcuS1VqqPqm7YPC
	arwIYWULwUuVW+2284yPCm4+lJOmJBHussToe0YkPaC20rHxFgQOQ1ZWjgvfASZLxIkvOxB+pjcZA
	6872ApsmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsG6-0005L4-GJ; Mon, 31 Aug 2020 22:26:38 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsG2-0005Jw-CA
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:26:36 +0000
Received: by mail-pg1-x541.google.com with SMTP id v15so1521300pgh.6
 for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2020 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AHy1YAS6RlDoUT2N+3NJGboSTZ+DcvCQzUBr7zdupzo=;
 b=NLLP+qDnBsVG5Q31LNRllvP81qOS6ZT1nEh4uMMhTNXvzgUh4BBqGVVGxYHdv/jThk
 FbQkBnhNF/5Let0TU9x5hV/r3EcRmAxnlG9k/ybOXvESLxHwMqVRwKbJI7YHOsM98cF0
 BzxdpjgykKFONfwjf6256DdvgWDvrectKcVzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AHy1YAS6RlDoUT2N+3NJGboSTZ+DcvCQzUBr7zdupzo=;
 b=OfN9cER/ItnC1Lu3n4iby9g0Yst9NZiS6rw5+HGeO4rOXh3OmtmnlS1hvH5c1spGOg
 7lD4/wCkcKSqYcddIsvr7kPk1Bv3gv25V+jae+V3t5M7QtyCiktlSp+toJQpYmXIW9g+
 Cr2S3J7fYAlC3gOZABoYqW1wmih67SUoSHCcWyGI7Ydz5KZ7nklWjMjgk93v0ZkeR7oW
 saLwyo9qOdTM6uNBlxqMYG4EMQ0ELz1kId8HbC/PBxaaSswNfKoLX5v0ao8i9HJMz3Qs
 dyeyWT51r0kHlWBC0fcMTxTYkAVuahRGqIXrXtRnJ+ViRP2MOvFd4PnuANtAM/9mAXC2
 C2Vw==
X-Gm-Message-State: AOAM530tP4GSQakC6wQJEQ0MiglEx2H2X6PqE78nTma2Pv9Xsv8MGvaQ
 psI9CZuvTsm22ZTrAD1E6LcTiw==
X-Google-Smtp-Source: ABdhPJz0W8SN3s8UNhDlUaFJJNAYHIq/dDMZ/K6Sx0zTNMY17KmgTKYyfyLimSf6cVGgyanwbW+lEA==
X-Received: by 2002:a63:4b61:: with SMTP id k33mr2809010pgl.195.1598912791532; 
 Mon, 31 Aug 2020 15:26:31 -0700 (PDT)
Received: from [10.230.128.89] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id r2sm4466288pga.94.2020.08.31.15.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 15:26:30 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
 <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
 <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <7f43e9db-974a-5e98-76a6-ed2f3bd0dc92@broadcom.com>
Date: Mon, 31 Aug 2020 15:26:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182634_605912_4B45429D 
X-CRM114-Status: GOOD (  20.90  )
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
Cc: Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8yOC8yMDIwIDQ6NTkgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+IFRoaXMgaXMg
aW5kZWVkIGEgcmVncmVzc2lvbi4KPj4+Cj4+PiBQZXJoYXBzIHdlIHNob3VsZCBhbHNvIHJldmVy
dDoKPj4+IDEyYTBiNjYyMjEwNyAoIm52bWU6IGRvbid0IGhvbGQgbnZtZl90cmFuc3BvcnRzX3J3
c2VtIGZvciBtb3JlIHRoYW4gCj4+PiB0cmFuc3BvcnQgbG9va3VwcyIpCj4+Pgo+Pj4gV2hpY2gg
aW5oZXJlbnRseSBjYXVzZWQgdGhpcyBieSByZW1vdmluZyB0aGUgc2VyaWFsaXphdGlvbiBvZgo+
Pj4gLmNyZWF0ZV9jdHJsKCkuLi4KPj4KPj4gbm8sIEkgYmVsaWV2ZSB0aGUgcGF0Y2ggb24gdGhl
IHNlbWFwaG9yZSBpcyBjb3JyZWN0LiBPdGhlcndpc2UgLSAKPj4gdGhpbmdzIGNhbiBiZSBibG9j
a2VkIGEgbG9uZyB0aW1lLi4gYSBtaW51dGUgKDEgY21kIHRpbWVvdXQpIG9yIGV2ZW4gCj4+IG11
bHRpcGxlIG1pbnV0ZXMgaW4gdGhlIGNhc2Ugd2hlcmUgYSBjb21tYW5kIGZhaWx1cmUgaW4gY29y
ZSBsYXllcnMgCj4+IGVmZmVjdGl2ZWx5IGdldHMgaWdub3JlZCBhbmQgdGh1cyBkb2Vzbid0IGNh
dXNlIHRoZSBlcnJvciBwYXRoIGluIHRoZSAKPj4gdHJhbnNwb3J0LiBUaGVyZSBjYW4gYmUgbXVs
dGlwbGUgL2Rldi9udm1lLWZhYnJpY3MgY29tbWFuZHMgc3RhY2tlZCAKPj4gdXAgdGhhdCBjYW4g
bWFrZSB0aGUgZGVsYXlzIGxvb2sgbXVjaCBsb25nZXIgdG8gdGhlIGxhc3QgZ3V5Lgo+Pgo+PiBh
cyBmYXIgYXMgY3JlYXRpb24gdnMgdGVhcmRvd24uLi4geWVhaCwgbm90IGZ1biwgYnV0IHRoZXJl
IGFyZSBvdGhlciAKPj4gd2F5cyB0byBkZWFsIHdpdGggaXQuIEZDOiBJIGdvdCByaWQgb2YgdGhl
IHNlcGFyYXRlIGNyZWF0ZS9yZWNvbm5lY3QgCj4+IHRocmVhZHMgYSB3aGlsZSBhZ28gdGh1cyB0
aGUgcmV0dXJuLWNvbnRyb2wtd2hpbGUtcmVjb25uZWN0aW5nIAo+PiBiZWhhdmlvciwgc28gSSd2
ZSBoYWQgdG8gZGVhbCB3aXRoIGl0LsKgIEl0J3Mgb25lIGFyZWEgaXQnZCBiZSBuaWNlIHRvIAo+
PiBzZWUgc29tZSBjb252ZXJnZW5jZSBpbiBpbXBsZW1lbnRhdGlvbiBhZ2FpbiBiZXR3ZWVuIHRy
YW5zcG9ydHMuCj4KPiBEb2Vzbid0IGZjIGhhdmUgYSBidWcgdGhlcmU/IGluIGNyZWF0ZV9jdHJs
IGFmdGVyIGZsdXNoaW5nIHRoZQo+IGNvbm5lY3Rfd29yaywgd2hhdCBpcyB0ZWxsaW5nIGl0IGlm
IGRlbGV0ZSBpcyBydW5uaW5nIGluIHdpdGggaXQKPiAob3IgdGhhdCBpdCBhbHJlYWR5IHJhbi4u
LikKCkkgZ3Vlc3MgSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhlIGJ1ZyBpcyB5b3UgYXJlIHRo
aW5raW5nIGFib3V0LiBNYXliZSAKdGhlcmUncyBhIHNob3J0IHBlcmlvZCB0aGF0IHRoZSBjdHJs
IHB0ciBpcyBwZXJoYXBzIGZyZWVkLCB0aHVzIHRoZSAKcG9pbnRlciBzaG91bGRuJ3QgYmUgdXNl
ZCAtIGJ1dCBJIGRvbid0IHNlZSBpdCBhcyBhbG1vc3QgZXZlcnl0aGluZyBpcyAKc2ltcGx5IGxv
b2tpbmcgYXTCoCB0aGUgdmFsdWUgb2YgdGhlIHBvaW50ZXIsIG5vdCBkZXJlZmVyZW5jaW5nIGl0
LgoKSSBkbyBoYXZlIGEgYnVnIG9yIHR3b8KgIHdpdGggZGVsZXRlIGFzc29jaWF0aW9uIGZpZ2h0
aW5nIHdpdGggCmNyZWF0ZV9hc3NvY2lhdGlvbiAtIGJ1dCBpdCdzIG1haW5seSBkdWUgdG8gbnZt
ZV9mY19lcnJvcl9yZWNvdmVyeSBub3QgCnRoZSBkZWxldGUgcm91dGluZS4gSSd2ZSByZXdvcmtl
ZCB0aGlzIGFyZWEgYWZ0ZXIgc2VlaW5nIHlvdXIgb3RoZXIgCnBhdGNoZXMgYW5kIHdpbGwgYmUg
cG9zdGluZyBhZnRlciBzb21lIG1vcmUgdGVzdGluZy7CoCBCdXQgbm8gcmVhc29uIGZvciAKc3lu
Y2hyb25pemluZyBhbGwgY3RybCBjcmVhdGVzLgoKLS0gamFtZXMKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
