Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C1C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:55:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2155364EF4
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2155364EF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z2ZJP6SJTlZl9y+GiJvM6t90LbUs2QEi1lAlDmE1Pkw=; b=HzWYAjXI7HJzZZ+y7Sw+gfarK
	q71u1Ih1eLCn/EsDD6VdxbPS6XPQEl6tljiF5NZRuLz2BUfRcM3aVgf9dLcQhcz2FXwGtKWK3tqBA
	wDQEc7tYad2cHLinnCXs3rrHh3KLjDaBGOjAQzx4vNUVZy3leSOHG9KriN5ZeaJRgKfwM3qC83ptu
	3fA/P8k6QCRmmzp7ykxIYlTQ4+bALg3sawY2bO2wKInNiDXbP+X7exaYWua9qkJfsWK8WiETQzIht
	FXomM8flMiFX3p5DKcWyvMA3BTZ686z5nouHS9qfOzyYP784TAeov0kAoUu9VaXvgGQX46cMyOgOb
	EgiULHA3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHYWO-006V4e-VT; Wed, 03 Mar 2021 20:55:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT7J-005JNM-Sa
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=HvqmIAPJ/ui0s35CATfn4dnj2oC6D/3nSVp5EmoMS6Y=; b=k6/ylW9g9BK4NCfhHjOAtdJOu/
 ATXpm9WYLwwOxByNKCKA40U2RuRHseuYWxjGVSsnsVdQ8VS0oDCzhMBN5kJhvirnD0YvwAdr+ymNQ
 dCgn1PIwPT4OLXVTUK2ErjRJnJKELRk/eS/3xGG0YHoV8pSJSFbtAOfIMAUXyvsc4xZ/43EBnxuE6
 ROJ8hTyS40G5XXuWsC7LigarMiEGqIYqMKGoyiPadMFXExSDflMqv0izoCD9d3e5zPIWbc9Yv2MXN
 x9YaLNdZ2I2s82EvmOSoOgV1J28TNi3tVkCMiCnklruyks7vcw0pz/Djnbvuu8mljEtlViEQku/13
 FCAWaPUQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHM8z-001hwH-BS
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 07:42:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0E53DAE85;
 Wed,  3 Mar 2021 07:41:59 +0000 (UTC)
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
To: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
 <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
 <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
 <399fd796-64c2-7d25-b0d8-0f445c4bb2dd@huawei.com>
 <20210303031416.GD22346@redsun51.ssa.fujisawa.hgst.com>
 <1fc0b92d-0726-9309-42ce-3e64858cd3aa@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9b055c28-62e9-1de1-b30b-207c39178c36@suse.de>
Date: Wed, 3 Mar 2021 08:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1fc0b92d-0726-9309-42ce-3e64858cd3aa@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_074205_856589_BB57C9DA 
X-CRM114-Status: GOOD (  15.92  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zLzIxIDQ6MzkgQU0sIENoYW8gTGVuZyB3cm90ZToKPiAKPiAKPiBPbiAyMDIxLzMvMyAx
MToxNCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+IE9uIFdlZCwgTWFyIDAzLCAyMDIxIGF0IDEwOjI3
OjAxQU0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4+IE9uIDIwMjEvMy8zIDI6MjQsIEtlaXRo
IEJ1c2NoIHdyb3RlOgo+Pj4+IFdlIGNhbiBjb250aW51ZSB0byBhZG1pbmlzdHJhdGUgYSBjb250
cm9sbGVyIHRoYXQgZGlkbid0IGNyZWF0ZSBJTwo+Pj4+IHF1ZXVlcywgYnV0IHRoZSBjb250cm9s
bGVyIG11c3QgcHJvdmlkZSBhIHJlc3BvbnNlIHRvIGFsbCBjb21tYW5kcy4gSWYKPj4+PiBpdCBk
b2Vzbid0LCB0aGUgY29udHJvbGxlciB3aWxsIGVpdGhlciBiZSByZXNldCBvciBhYmFuZG9uZWQu
IFRoaXMKPj4+PiBzaG91bGQgYmUgdGhlIHNhbWUgYmVoYXZpb3IgZm9yIGFueSB0cmFuc3BvcnQs
IHRob3VnaDsgdGhlcmUncyBub3RoaW5nCj4+Pj4gc3BlY2lhbCBhYm91dCBQQ0llIGZvciB0aGF0
Lgo+Pj4gVGhvdWdoIEkgZG9uJ3Qgc2VlIGFueSB1c2VmdWwgc2NlbmFyaW9zIGZvciBudm1lIG92
ZXIgZmFicmljIG5vdywKPj4+IFJlc2VydmVkIGZvciBmdXR1cmUgcG9zc2liaWxpdGllcyBtYXkg
YmUgYSBiZXR0ZXIgY2hvaWNlLgo+Pgo+PiBUaGUgYWRtaW4gcXVldWUgbWF5IGJlIHRoZSBvbmx5
IHdheSBmb3IgYSB1c2VyIHRvIHJldHJpZXZlIHVzZWZ1bAo+PiBpbmZvcm1hdGlvbiBvbiB0aGUg
bWFsZnVuY3Rpb25pbmcgY29udHJvbGxlci4gVGhlIHRlbGVtZXRyeSBsb2cgaXNuJ3QKPj4gdW5p
cXVlIHRvIFBDSWUuCj4gVXNlciBjYW4gYWxzbyBkaXJlY3RseSB2aXNpdCB0YXJnZXQgdG8gZ2V0
IHRoZXNlIGluZm9ybWF0aW9uIGZvcgo+IG52bWUgb3ZlciBmYWJyaWNzLgoKTm90IG5lY2Vzc2Fy
aWx5LiBUaGVyZSBpcyBubyByZXF1aXJlbWVudCB0aGF0IHRoZSBzdG9yYWdlIGFkbWluIGlzCmlk
ZW50aWNhbCB0byB0aGUgaG9zdCBhZG1pbjsgaW4gZmFjdCwgaW4gbGFyZ2VyIGluc3RhbGxhdGlv
bnMgYm90aCByb2xlcwphcmUgc3RyaWN0bHkgc2VwYXJhdGVkLgoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7D
vHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
