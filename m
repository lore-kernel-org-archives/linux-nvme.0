Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D2C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 05:36:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20270206DB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 05:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1+YzwztZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20270206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b3hmkusZCZ2cgRyGi1kpAc5fM3zpjEnhhWrayQxtONg=; b=1+YzwztZEbpGxEckIhmS2J87m
	d9lTefBFknVJGLg5WjMjAocA+nATBKCOdK/lvIxm6GxCXQcPfEt8wL2C/jrWu/KUTIlYWcD+LRMhm
	ppKSW2DWqqfw59phv1t7Eetjogg+DM9lAzD4IqrGOTplUOPnzzd3ltc7OweZvYoDNUMXhRbvaFWpr
	qccoH2KB/BPhPb1YVv0lM8+n65cT/scfZc8pYZIhbipYjOapGaDRMfnhMuyfp6iQdHtqpwtBB8jNF
	uNFZddnxiNnDNbrSRLIkZprQUqH0tuAHrBrECC5mV5ygxoDpUKChPpkGKtRqT3Cy+CfBLZeknmnAK
	1TNhbNRcA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNUn8-0002UR-7L; Wed, 30 Sep 2020 05:36:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNUmo-0002Oz-It
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 05:36:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F2AC2AC3C;
 Wed, 30 Sep 2020 05:36:15 +0000 (UTC)
Subject: Re: [RFC] nvme-mpath: delete disk after last connection
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200925213819.224198-1-kbusch@kernel.org>
 <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
 <20200927060709.GA24024@lst.de>
 <20200928141106.GA227320@dhcp-10-100-145-180.wdl.wdc.com>
 <4af645fe-f513-22b5-2d28-3e8890cc8776@grimberg.me>
 <20200929180849.GB12546@lst.de>
 <3d2541d7-88b0-1e5b-89c0-13f101f10243@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3bd44c2e-ded8-80b8-e2c1-ecac25308123@suse.de>
Date: Wed, 30 Sep 2020 07:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3d2541d7-88b0-1e5b-89c0-13f101f10243@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_013618_759250_BBEAD820 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8yOS8yMCA4OjE2IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4gU29tZXRoaW5n
IGhlcmUgaXMgbm90IGNsZWFyIHRvIG1lLCB3ZSBhcmUgbm90IHJlYWxseSB0YWxraW5nIGFib3V0
ICJhbGwKPj4+IHBhdGhzIGRvd24iIGJ1dCByYXRoZXIgImFsbCBwYXRocyBsb3N0Iiwgd2hpY2gg
c2hvdWxkIHRha2UgdGhlIGdlbmRpc2sKPj4+IGRvd24gQUZBSUsuCj4+Pgo+Pj4gS2VpdGgsIHNo
b3VsZG4ndCB3ZSBtb2RpZnkgdGhlIGdlbmRpc2sgcmVmZXJlbmNlIG1hbmlwdWxhdGlvbiBpbgo+
Pj4gbnZtZV9tcGF0aF9yZW1vdmVfZGlzayBpbnN0ZWFkIG9mIG1vdmluZyBpdCB0byB0aGUgY2Fs
bCBzaXRlcz8KPj4+Cj4+PiBJJ20gc3RpbGwgdW5zdXJlIHdoeSB3ZSBuZWVkIGEgdGltZXIgZm9y
IHRoaXMuIElmIGEgcGF0aCBpcyByZW1vdmVkCj4+PiAoZS5nLiBkaXNjb25uZWN0ZWQsIHdlIHNo
b3VsZG4ndCBrZWVwIHRoZSBnZW5kaXNrIHVwKS4KPj4KPj4gVHJ1ZS7CoCBBbmQgSSBndWVzcyB0
aGUgcmlnaHQgcGxhY2UgdG8gZGVhbCB3aXRoIHRpbWVycyBpcyBvbiBob3cgbG9uZwo+PiB3ZSBh
cmUgZ29pbmcgdG8ga2VlcCByZXRyeWluZyAob3IgYXQgbGVhc3QgdGhlIHVuZGVybHlpbmcgZGlz
a3MgYWxpdmUpLgo+IAo+IFdoaWNoIGlzIG9ydGhvZ29uYWwgdG8gdGhpcyBzcGVjaWZpYyBwYXRj
aCByaWdodD8KPiAKPiBBcyBmb3IgdGltZXJzLCBJIHdvdWxkbid0IHdhbnQgdG8gaW50cm9kdWNl
IGEgbW9kcGFyYW0gZm9yIHRoYXQuIFBlcmhhcHMKPiB0aGUgY29ycmVjdCB3YXkgdG8gZG8gdGhp
cyBpcyB3aXRoIHdoYXQgVmljdG9yIHN1Z2dlc3RlZCB3aGVyZSBtcGF0aAo+IGZhc3RmYWlsIGlz
IHJlYWxseSB0aGUgbG9uZ2VzdCBjb250cm9sbGVyIGZhc3RmYWlsLi4uCgpZZXMuIElmIHdlJ3Jl
IHRhbGtpbmcgdGltZXJzIHdlIHNob3VsZCBiZSBsb29raW5nIGEgZmFzdGZhaWwsIGFzIHRoaXMg
aXMgCnJlYWxseSB3aGF0IHdlIHdhbnQgaGVyZS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhh
bm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFy
ZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
