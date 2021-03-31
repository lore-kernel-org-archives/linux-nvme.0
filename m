Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09AC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:15:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4EC60FDC
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4EC60FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YyVU1EDM/n6zdIW1N+C+0qHYoYRo1A7nvOki5K28F9A=; b=Z6e8rAuKKd9sEYoLb4z8w8l0J
	RsesLq5jPMGDztMCmYXv25qVwxgUsivZs47o/sB1dR1TVQ8Rsc6qwztRFGrz1XTSdYFTIobvZk2Zd
	JKiyq80/IZzKrCK1nYiOI/M42ssrsgxx7MdBJm++hggVzYx9zaB911UdaVvogrmdrj02W+PcBc8Pn
	Z1ezCZi3R0T8qYL8hDmyDmS+N2p518QBgKP9uhhsIpm/7/ssBko1j5H4cVjnklwxjMUu62kOMJ7Tj
	JsRB+3Q72uHuSW8dRbpvHroWOfTrxxyY4hC4QiV3y2UKY4s6OhebpHwrN4iY0NfVqBFOTFAD/I+gD
	Frt9QT/lQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRbd3-006kon-5E; Wed, 31 Mar 2021 14:15:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRbcz-006koC-7o
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 14:15:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AA785B2B9;
 Wed, 31 Mar 2021 14:15:24 +0000 (UTC)
Subject: Re: libnvme questions
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Tomas Bzatek <tbzatek@redhat.com>,
 Tony Asleson <tasleson@redhat.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <15fdfa03-3adf-6877-e369-47429a5462a5@suse.de>
Date: Wed, 31 Mar 2021 16:15:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_151525_334285_54A0782D 
X-CRM114-Status: GOOD (  15.99  )
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

SGkgS2VpdGgsCgpPbiAzLzEwLzIxIDk6NDggUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFdl
ZCwgTWFyIDAzLCAyMDIxIGF0IDAzOjE0OjAyUE0gLTA2MDAsIFRvbnkgQXNsZXNvbiB3cm90ZToK
Pj4gMS4gVGhlcmUgaXMgaW50ZXJlc3QgaW4gdXRpbGl6aW5nIHRoZSBsaWJudm1lIGxpYnJhcnkg
Zm9yIHNvbWUgb3RoZXIKPj4gcHJvamVjdHMsIHdoZW4gaXMgYW4gb2ZmaWNpYWwgcmVsZWFzZSBv
ZiB0aGUgbGlicmFyeSBwbGFubmVkPwo+Pgo+PiAyLiBJcyBpdCBwbGFubmVkIGZvciBudm1lLWNs
aSB0byB1dGlsaXplIGxpYm52bWU/Cj4gCj4gVGhpcyBpcyBteSBiYWQsIEkgZmVsbCBiZWhpbmQg
dGhlIHRhc2sgZHVlIHRvIG11dGxpcGxlIGNvbmZsaWN0cyBvZgo+IHRpbWUsIGJ1dCBJIGFtIGJh
Y2sgb24gdGhpcyByaWdodCBub3cuIFRoZSBwbGFuIGlzIHRvIHRhZyBudm1lLWNsaSB2MS4xNAo+
IHdpdGhpbiB0aGUgbmV4dCBmZXcgd2Vla3MsIHRoZW4gbWFrZSB0aGUgc2hpZnQgdG8gbGlibnZt
ZSBpbnRlZ3JhdGlvbgo+IG9uIGEgIjIuMCIgdmVyc2lvbiBmb3IgZnV0dXJlIHdvcmsgb24gdGhl
IG1hc3RlciBicmFuY2guIFRoaXMgd291bGQKPiBjb2luY2lkZSB3aXRoIGFuIG9mZmljaWFsIGxp
Ym52bWUgc3RhYmxlIHJlbGVhc2UuCj4gCj4gSSBob25lc3RseSBkbyBub3QgaGF2ZSBlbm91Z2gg
ZGV2aWNlcyB0byByZWdyZXNzaW9uIHRlc3QgYWxsIHRoZQo+IGZlYXR1cmVzLCBzbyBJIHdpbGwg
Y29udGludWUgdG8gbWFpbnRhaW4gbnZtZS1jbGkgMS54IGJyYW5jaGVzIGFzIGxvbmcKPiBhcyBu
ZWNlc3Nhcnkgd2hpbGUgaXJvbmluZyBvdXQgYW55IGludGVncmF0aW9uIGlzc3Vlcy4KPiAgCkFu
eSB1cGRhdGVzIGhlcmU/CldlJ3ZlIGdvdCBzb21lIGNoYW5nZXMvcmV3b3JrcyBwZW5kaW5nICh0
aGUgbnZtZSBtb25pdG9yIHN0dWZmLCBhbmQgYWxzbwphIG5ldyBjb25maWd1cmF0aW9uIGZpbGUg
bWVjaGFuaXNtIHdpdGggdXNpbmcgYSBqc29uIGNvbmZpZyBmaWxlKSwgYW5kCml0IHdvdWxkIGJl
IGdvb2QgdG8ga25vdyB3aGF0IHdvdWxkIGJlIHRoZSBhcHByb3ByaWF0ZSBiYXNlIGZvciBhbGwg
b2YgdGhpcy4KCldlIGNvdWxkIGdpdmUgeW91IGEgaGVscGluZyBoYW5kIGluIG1vdmluZyBudm1l
LWNsaSBvdmVyIHRvIG52bWVsaWIgaWYKdGhhdCdzIGFuIGlzc3VlIC4uLgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
