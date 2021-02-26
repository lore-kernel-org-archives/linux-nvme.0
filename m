Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F92C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 16:42:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE66B64F14
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 16:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE66B64F14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1NqYCEZQQKKtRsGe982cn7+w8G0R21Kxnyg/h4TgxJs=; b=0JCqBT/BKE/DXg2V+w00r4n8O
	EM8zTuMNC6OPY3DwxWsqUjYSLxTd/97LQyXN6lPDvDSLBmoNmnR/b5VKvpdHaXgZxoqry5ushTX3c
	ING/Q6F7UYlSsFsCeh8kcu+wwdb3Vd2KAPcRhFeGlwNFJVT8WDljYRMJojeyq6CWV8PEfJ8pqswvS
	oPTagIDSv/HHvm8NUHYJNdyU6RuKm1IbtQnouCdngP4Zl57ipxmgbghLzivKWt+TCpSsuox+xf70d
	z9nDNa9Bq+DIR+pW4VYos9AQNkHZbgw+ii3rWFpDZ9G1UHb+Fpcbv9/BmORufhmK61WxPwACZoqwC
	tX7I6q7oQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFgCZ-0004bs-U8; Fri, 26 Feb 2021 16:42:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFgCX-0004bJ-3f
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 16:42:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 02C2CAE91;
 Fri, 26 Feb 2021 16:42:47 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Keith Busch <kbusch@kernel.org>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
Date: Fri, 26 Feb 2021 17:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_114249_270946_E618D445 
X-CRM114-Status: GOOD (  24.01  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNi8yMSA1OjEzIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIEZlYiAyNiwg
MjAyMSBhdCAwMTo1NDowMFBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDIv
MjYvMjEgMTozNSBQTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPj4+IE9uIE1vbiwgRmViIDE1LCAy
MDIxIGF0IDAxOjI5OjQ1UE0gLTA4MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pj4gV2VsbCwg
SSB0aGluayB3ZSBzaG91bGQgcHJvYmFibHkgZmlndXJlIG91dCB3aHkgdGhhdCBpcyBoYXBwZW5p
bmcgZmlyc3QuCj4+Pgo+Pj4gSSBnb3QgbXkgaGFuZHMgb24gYSB0Y3BkdW1wIHRyYWNlLiBJJ3Zl
IHRyaW1tZWQgaXQgdG8gdGhpczoKPj4+ClsgLi4gXQo+Pj4gTlZNIEV4cHJlc3MgRmFicmljcyBU
Q1AKPj4+ICAgICAgIFBkdSBUeXBlOiBDYXBzdWxlUmVzcG9uc2UgKDUpCj4+PiAgICAgICBQZHUg
U3BlY2lmaWMgRmxhZ3M6IDB4MDAKPj4+ICAgICAgICAgICAuLi4uIC4uLjAgPSBQRFUgSGVhZGVy
IERpZ2VzdDogTm90IHNldAo+Pj4gICAgICAgICAgIC4uLi4gLi4wLiA9IFBEVSBEYXRhIERpZ2Vz
dDogTm90IHNldAo+Pj4gICAgICAgICAgIC4uLi4gLjAuLiA9IFBEVSBEYXRhIExhc3Q6IE5vdCBz
ZXQKPj4+ICAgICAgICAgICAuLi4uIDAuLi4gPSBQRFUgRGF0YSBTdWNjZXNzOiBOb3Qgc2V0Cj4+
PiAgICAgICBQZHUgSGVhZGVyIExlbmd0aDogMjQKPj4+ICAgICAgIFBkdSBEYXRhIE9mZnNldDog
MAo+Pj4gICAgICAgUGFja2V0IExlbmd0aDogMjQKPj4+ICAgICAgIFVua25vd24gRGF0YTogMDIw
MDA0MDAwMDAwMDAwMDFiMDAwMDAwMWYwMDAwMDAKPj4+Cj4+PiAwMDAwICAwMCAwMCAwYyA5ZiBm
NSBhOCBiNCA5NiA5MSA0MSAxNiBjMCAwOCAwMCA0NSAwMCAgIC4uLi4uLi4uLkEuLi4uRS4KPj4+
IDAwMTAgIDAwIDRjIDAwIDAwIDQwIDAwIDQwIDA2IDAwIDAwIDBhIGU0IDI2IGFmIDBhIGU0ICAg
LkwuLkAuQC4uLi4uJi4uLgo+Pj4gMDAyMCAgYzIgMWUgMTEgNDQgODggNGYgYjggNTggOTAgZWMg
OGUgMWIgMzIgZWQgODAgMTggICAuLi5ELk8uWC4uLi4yLi4uCj4+PiAwMDMwICAwMSAwMSBmZSBk
MyAwMCAwMCAwMSAwMSAwOCAwYSBlNiBlZCBhYyBiZSBkNiBhMyAgIC4uLi4uLi4uLi4uLi4uLi4K
Pj4+IDAwNDAgIDVkIDBjIDA1IDAwIDE4IDAwIDE4IDAwIDAwIDAwIDAyIDAwIDA0IDAwIDAwIDAw
ICAgXS4uLi4uLi4uLi4uLi4uLgo+Pj4gMDA1MCAgMDAgMDAgMWIgMDAgMDAgMDAgMWYgMDAgMDAg
MDAgICAgICAgICAgICAgICAgICAgICAuLi4uLi4uLi4uCj4+Pgo+PiBBcyBJIHN1c3BlY3RlZCwg
d2UgZGlkIHJlY2VpdmUgYW4gaW52YWxpZCBmcmFtZS4KPj4gRGF0YSBkaWdlc3Qgd291bGQgaGF2
ZSBzYXZlZCB1cywgYnV0IHRoZW4gaXQncyBub3QgZW5hYmxlZC4KPj4KPj4gU28gd2UgZG8gbmVl
ZCB0byBjaGVjayBpZiB0aGUgcmVxdWVzdCBpcyB2YWxpZCBiZWZvcmUgcHJvY2Vzc2luZyBpdC4K
PiAKPiBUaGF0J3MganVzdCBhZGRyZXNzaW5nIGEgc3ltcHRvbS4gWW91IGNhbid0IGZ1bGx5IHZl
cmlmeSB0aGUgcmVxdWVzdCBpcwo+IHZhbGlkIHRoaXMgd2F5IGJlY2F1c2UgdGhlIGhvc3QgY291
bGQgaGF2ZSBzdGFydGVkIHRoZSBzYW1lIGNvbW1hbmQgSUQKPiB0aGUgdmVyeSBtb21lbnQgYmVm
b3JlIHRoZSBjb2RlIGNoZWNrcyBpdCwgaW5jb3JyZWN0bHkgY29tcGxldGluZyBhbgo+IGluLWZs
aWdodCBjb21tYW5kIGFuZCBnZXR0aW5nIGRhdGEgY29ycnVwdGlvbi4KPiAKT2gsIEkgYW0gZnVs
bHkgYXdhcmUuCgpCYWQgZnJhbWVzIGFyZSBqdXN0IHRoYXQsIGJhZCBmcmFtZXMuCldlIGNhbiBv
bmx5IGZ1bGx5IHZhbGlkYXRlIHRoYXQgd2hlbiBkaWdlc3RzIGFyZSBlbmFibGVkLCBidXQgSSBn
YXRoZXIgCnRoYXQgY29udHJvbGxlcnMgc2VuZGluZyBvdXQgYmFkIGZyYW1lcyB3b3VsZG4ndCB3
YW50IHRvIGVuYWJsZSBkaWdlc3RzLCAKZWl0aGVyLiBTbyByZWx5aW5nIG9uIHRoYXQgaXMgcG9z
c2libHkgbm90IGFuIG9wdGlvbi4KClNvIHJlYWxseSB3aGF0IEknbSB0cnlpbmcgdG8gYXZvaWQg
aXMgdGhlIGhvc3QgY3Jhc2hpbmcgb24gYSBiYWQgZnJhbWUuClRoYXQga2luZCBvZiB0aGluZyBh
bHdheXMgcmVzb25hdGVzIGJhZCB3aXRoIGN1c3RvbWVycy4KQW5kIHRyaXBwaW5nIG92ZXIgYW4g
dW5pbml0aWFsaXplZCBjb21tYW5kIGlzIGp1c3QgdG9vIHN0dXBpZCBJTU8uCgpDaGVlcnMsCgpI
YW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3Jh
Z2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNm
w7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
