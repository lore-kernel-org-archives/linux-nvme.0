Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2C8C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 06:59:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0193664E35
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 06:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0193664E35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0770B8KORbtTiOrfqA+kLUVDH5881O4Yl9ECupjYVgI=; b=wRyii1FevycXIjJRyndJGo4aH
	EnMhfdGkgumFAYToyJl6YanmOvilPGobJNy6rICXDOjTkKiDxq7/UB6Eu9IHeKwGQxKDtE4nL5ukr
	1DofDtMYmpq607WOtZiaq7veV+rAV+SNAThpJ1YqeCNEXyVLBX39vLaLl8lfHWyD4x6bFM0Q7rWXD
	fIwqwJSkjk7QGqfbkMYgFWLordKnGQTamSEre47+9mX0IFS4kgTUOFmXlGEa8FziN7+vSzi5d0wbd
	IsBLUv9VrsA67gH4po3nMDW06UlK+7mpvm+3JKyzFP7Fr2/dr3LeMH6wuKqk8vki4h09IpgJXH2cn
	wAloLE9Og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YbN-0002WP-Ts; Thu, 04 Feb 2021 06:58:53 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YbL-0002UV-E6
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 06:58:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A2A25ABD5;
 Thu,  4 Feb 2021 06:58:48 +0000 (UTC)
Subject: Re: [PATCH 05/35] monitor: add uevent filters
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-6-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fa6ae95c-ce41-4af9-5c31-ba8e5fdfa956@suse.de>
Date: Thu, 4 Feb 2021 07:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-6-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_015851_631679_C021B4E2 
X-CRM114-Status: GOOD (  22.14  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNi8yMSA5OjMyIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdpbGNr
IDxtd2lsY2tAc3VzZS5jb20+Cj4gLS0tCj4gICBtb25pdG9yLmMgfCA0ICsrKysKPiAgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvbW9uaXRvci5jIGIv
bW9uaXRvci5jCj4gaW5kZXggNjNlMjZiYy4uYTZjODkwNSAxMDA2NDQKPiAtLS0gYS9tb25pdG9y
LmMKPiArKysgYi9tb25pdG9yLmMKPiBAQCAtNTgsNiArNTgsMTAgQEAgc3RhdGljIGludCBjcmVh
dGVfdWRldl9tb25pdG9yKHN0cnVjdCB1ZGV2X21vbml0b3IgKipwbW9uKQo+ICAgCWlmICghbW9u
KQo+ICAgCQlyZXR1cm4gZXJybm8gPyAtZXJybm8gOiAtRU5PTUVNOwo+ICAgCj4gKwkvKiBBZGQg
bWF0Y2ggZm9yIE5WTWUgY29udHJvbGxlciBkZXZpY2VzICovCj4gKwlyZXQgPSB1ZGV2X21vbml0
b3JfZmlsdGVyX2FkZF9tYXRjaF9zdWJzeXN0ZW1fZGV2dHlwZShtb24sICJudm1lIiwgTlVMTCk7
Cj4gKwkvKiBBZGQgbWF0Y2ggZm9yIGZjX3VkZXZfZGV2aWNlICovCj4gKwlyZXQgPSB1ZGV2X21v
bml0b3JfZmlsdGVyX2FkZF9tYXRjaF9zdWJzeXN0ZW1fZGV2dHlwZShtb24sICJmYyIsIE5VTEwp
Owo+ICAgCS8qCj4gICAJICogVGhpcyBmYWlscyBpbiB1bnByaXZpbGlnZWQgbW9kZS4gVXNlIHRo
ZSBzYW1lIHZhbHVlIGFzIHVkZXZkLgo+ICAgCSAqIFdlIG1heSBhYmxlIHRvIGRlY3JlYXNlIHRo
aXMgYnVmZmVyIHNpemUgbGF0ZXIuCj4gCkkgZ3Vlc3MgeW91IGNvdWxkIG1lcmdlIGFsbCB0aGVz
ZSBmaXZlIHBhdGNoZXMgdG9nZXRoZXI7IG5vIG5lZWQgdG8ga2VlcCAKdGhlbSBzZXBhcmF0ZS4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
