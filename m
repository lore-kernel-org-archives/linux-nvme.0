Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3EC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:07:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C263C64EC3
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C263C64EC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HVM1a91x1b2hBcs5W6wa2OL0JWlTez4h23s0IvkYpf0=; b=IzSx7jhkUagpV/ISeADknz1CB
	RjpyogtPndd6sEM5Pst3wZOxyA1ws2rZr3rLc/dh911wjx9FkEEhEXTZJnS1lJjUO6GuldM9DXihN
	EFW9JsBlWSSQc1LkLneTHelA5nzFB/9cYfC6B87uMaKY1R9fPl1WszjWSPM8ghYLnOQ9BaQijNWAR
	ejUf5iJqpLEEcFTOJQ6SqFZU2W9aWkFTSL0tovtkvsvfVLj7VyUoN3yfPqsifpVv1F9WbSMc1b8Kn
	tK+vbIgKnOXhk5p5luYEkpvyd3p1pHUwTf+FlquMxhbqfqcvMh/XWNIF7zo/3YxuqjRrbH45+dq5q
	XjdQ4nI0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEoGJ-0006Lg-HI; Wed, 24 Feb 2021 07:07:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEoGD-0006L7-Tf
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 07:07:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C00CBAEB3;
 Wed, 24 Feb 2021 07:06:59 +0000 (UTC)
Subject: Re: [PATCH 0/2] nvme: sanitize KATO handling
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20210223120728.104699-1-hare@suse.de>
 <36e3bfd8-0c69-7540-c9f2-fd37070dc107@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <06e3b90a-719e-9561-5c63-67dac0a782e1@suse.de>
Date: Wed, 24 Feb 2021 08:06:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <36e3bfd8-0c69-7540-c9f2-fd37070dc107@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_020702_100814_52808360 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNC8yMSA3OjQyIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8yLzIz
IDIwOjA3LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IEhpIGFsbCwKPj4KPj4gb25lIG9mIG91
ciBjdXN0b21lciBoYWQgYmVlbiBydW5uaW5nIGludG8gYSBkZWFkbG9jayB0cnlpbmcgdG8gdGVy
bWluYXRlCj4+IG91dHN0YW5kaW5nIEtBVE8gY29tbWFuZHMgZHVyaW5nIHJlc2V0Lgo+PiBMb29r
aW5nIGNsb3NlciBhdCBpdCwgSSBmb3VuZCB0aGF0IHdlIG5ldmVyIGFjdHVhbGx5IF90cmFja18g
aWYgYSBLQVRPCj4+IGNvbW1hbmQgaXMgc3VibWl0dGVkLCBzbyB3ZSBtaWdodCBoYXBwaWx5IGJl
IHNlbmRpbmcgc2V2ZXJhbCBLQVRPIAo+PiBjb21tYW5kcwo+PiB0byB0aGUgc2FtZSBjb250cm9s
bGVyIHNpbXVsdGFuZW91c2x5Lgo+IENhbiB5b3UgZXhwbGFpbiBob3cgY2FuIHNlbmQgS0FUTyBj
b21tYW5kcyBzaW11bHRhbmVvdXNseT8KClN1cmUuCkNhbGwgbnZtZV9zdGFydF9rZWVwX2FsaXZl
KCkgb24gYSBkZWFkIGNvbm5lY3Rpb24uCkp1c3QgX2FmdGVyXyB0aGUgS0FUTyByZXF1ZXN0IGhh
cyBiZWVuIHNlbnQsCmNhbGwgbnZtZV9zdGFydF9rZWVwX2FsaXZlKCkgYWdhaW4uCgpZb3Ugbm93
IGhhdmUgYW4gZXhwaXJlZCBLQVRPIGNvbW1hbmQsIGFuZCB0aGUgbmV3IEtBVE8gY29tbWFuZCwg
Ym90aCBhcmUgCmFjdGl2ZSBhbmQgc2VudCB0byB0aGUgY29udHJvbGxlci4KCkNoZWVycywKCkhh
bm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFn
ZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5
IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bD
vGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
