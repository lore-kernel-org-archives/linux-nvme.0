Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F091C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:56:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981C820776
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s01tO5yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981C820776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jO9BVeVpppF51K1tZigZk0X9jIObvTmqg6dweEfayC8=; b=s01tO5yrAOHc3LTFd2LaKReTC
	tvVU1O0MAAQYM19gQFdLfYpuHtYO9418ZxEo+KVW23VjhUCnd0UyUJwc1OuzMNjVZxZVmHGgup3Az
	mJR6/tAFF3TPrkpT4TaeGU28OHM+dPmkdsH2e/J9iWdbOJgZzuxAZOlrs3oRqvGuDNhY6j6itrRSb
	ajNcce3Lxm9UXNGZ4c1JbOaegjsbYWa9DgawYcjRJcYsSDQKv4UHU1fsKXVvbf8N4IZ0ocLcDeDQD
	hUvfL/PMzJNwNo+pVuD7KA5G0r4YJPiQeLz9/cp/tCyRrWNdRGKQaAMW9oNQgsE1e6DjWOtNnvZUe
	DpphTAu3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPP6G-00040H-KZ; Mon, 05 Oct 2020 11:56:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPP6D-0003zp-NJ
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 11:56:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4C4F6B32A;
 Mon,  5 Oct 2020 11:56:12 +0000 (UTC)
Subject: Re: [PATCH 3/3] nvme: add 'queue_if_no_path' sysfs attribute
To: Christoph Hellwig <hch@lst.de>
References: <20201005094256.49358-1-hare@suse.de>
 <20201005094256.49358-4-hare@suse.de> <20201005113818.GA27690@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <68f08802-e9f4-09cb-f293-bd7abfae7218@suse.de>
Date: Mon, 5 Oct 2020 13:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005113818.GA27690@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_075613_869529_8EE8A4CD 
X-CRM114-Status: GOOD (  17.06  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvNS8yMCAxOjM4IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPaCwgYW5kIHNo
b3VsZG4ndCB0aGUgYXR0cmlidXRlIGJlIHBlci1zdWJzeXN0ZW0sIHNpbWlsYXIgdG8gdGhlCj4g
aW9wb2xpY3kgb25lPwo+IApXZWxsLCBJJ3ZlIHRob3VnaHQgYWJvdXQgdGhhdCwgdG9vOyBidXQg
dGhlbiBmaWd1cmVkIHRoYXQgaXQncyBwcmV0dHkgCm11Y2ggYW4gYWRtaW4gY2hvaWNlLgpIZSBf
bWlnaHRfIHdhbnQgdG8gY2hvb3NlIGVpdGhlciBiZWhhdmlvdXIsIGRlcGVuZGluZyBvbiB0aGUg
dXNlLWNhc2UgCihyZWFkOiBNRCByYWlkIG9yIGNsdXN0ZXIgc2NlbmFyaW9zKS4gQnV0IHRoZXNl
IHVzZS1jYXNlcyBhcmUgcHJldHR5IAptdWNoIHBlciBuYW1lc3BhY2UsIHNvIEknbSBub3Qgc3Vy
ZSBpZiBwZXItc3Vic3lzdGVtIGlzIGEgZ29vZCBmaXQgaGVyZS4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
