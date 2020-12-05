Return-Path: <SRS0=fl3Q=FJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B6C433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Dec 2020 09:50:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0191022D2A
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Dec 2020 09:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0191022D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7z3n0etJphpRHxhbYnIGW1u3wQL8ahoBJu6RusEkUV4=; b=Z/VKHz2XilRbHeqPUC8/+szJd
	QhVvR54nIqWiTK1FrdFMb3dCLpFIQhi4BVPp2nb1N0w4WL6jteQIrGH5o2QDP/hn4Vb5ONjyfwZEO
	Mwjxp04RqxFt76lzQXKH5Vbp+gXXzKSxgcFVazUfrRzHvH7FkTwQ+gZ3TvQ7R37t/s4xViWypEC2N
	/8jRZq69R4aQahgkcDcIJ5l6igwtGWvlBrWxo2ltrLwGg1NKtWYEY9Q+eyBaUCookSS6qSR6xktSv
	tLu7yFSp9I3DJ7MN6yIoeoXwdMVfYF2MNF7LLRYBiCO2bXDcV4Veznu5VX9KXj3YffHeu/QcdNPOZ
	wzOUm1DlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klUDA-0003rE-47; Sat, 05 Dec 2020 09:50:40 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klUD4-0003qe-0T
 for linux-nvme@lists.infradead.org; Sat, 05 Dec 2020 09:50:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 44E02ACF9;
 Sat,  5 Dec 2020 09:50:32 +0000 (UTC)
Subject: Re: [PATCH] nvme: re-read ANA log on NS CHANGED AEN
To: Keith Busch <kbusch@kernel.org>
References: <20201204150310.30434-1-hare@suse.de>
 <20201204152011.GB8868@redsun51.ssa.fujisawa.hgst.com>
 <8930faf1-7af7-73c5-0a16-3869a6af1bcf@suse.de>
 <20201204173713.GC8868@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0c61fb59-d864-d305-16d9-c0321ea12663@suse.de>
Date: Sat, 5 Dec 2020 10:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204173713.GC8868@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201205_045034_173307_F39A7AF1 
X-CRM114-Status: GOOD (  23.01  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvNC8yMCA2OjM3IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIERlYyAwNCwg
MjAyMCBhdCAwNTozMjoyMVBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDEy
LzQvMjAgNDoyMCBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+PiBUaGUgc2NhbiB3b3JrIGNhbiBi
ZSBzdGFydGVkIGZyb20gb3RoZXIgY29udGV4dHMgdG9vLCBzbyB0aGVyZSBhcmUgc29tZQo+Pj4g
dW5mb3J0dW5hdGUgcmFjZXMgaGVyZSBpZiBvbmUgb2YgdGhvc2Ugb3RoZXIgY29udGV4dHMgY2xl
YXJzIGN0cmwtPmV2ZW50cwo+Pj4gYmVmb3JlIHRoZSBBTkEgd29yayBnZXRzIHRvIHNlZSBpdCwg
d2hpY2ggdGhlbiBnZXRzIHlvdSBiYWNrIHRvIGhhdmluZwo+Pj4gdW51c2FibGUgbmFtZXNwYWNl
cyB3aGVuIHRoYXQgc2NhbiB3b3JrIHVzZXMgYSBzdGFsZSBhbmEgbG9nLgo+Pj4KPj4gTWF5YmUg
dGhpcyBvbiB0b3A/Cj4gCj4gSXQgZG9lcyBzaHJpbmsgdGhlIHJhY2UsIGJ1dCBkb2Vzbid0IGVs
aW1pbmF0ZSBpdCBpZiBzY2FuIHdvcmsgc3RhcnRzCj4gYWZ0ZXIgdGhlIGJpdCBpcyBzZXQgaW4g
Y3RybC0+ZXZlbnRzLCBidXQgYmVmb3JlIHRoZSBhbmEgd29yayBpcyBxdWV1ZWQuCj4gCj4gSSd2
ZSBhbm90aGVyIHF1ZXN0aW9uLCB0aG91Z2guIFlvdSBtZW50aW9uZWQgdGhpcyBhcHByb2FjaCBm
b3IgcmVjb3ZlcnkKPiByZWFzb25zLiBXaGV0aGVyIHlvdSByZWFkIHRoZSBhbmEgbG9nIGhlcmUg
b3Igd2hlcmUgSSBzdWdnZXN0ZWQsIHRoZXJlJ3MKPiBubyByZWNvdmVyeSBvY2N1cmluZyBpZiB0
aGUgYW5hIGxvZyByZWFkIGZhaWxzOiB5b3VyIHBhdGNoIGp1c3QgcXVldWVzCj4gdGhlIHNjYW4g
d29yayB0aGF0IHdvbid0IGZpbmQgdGhlIG1hdGNoaW5nIGFuYSBncm91cCBpZCwgd2hpY2ggaXMg
dGhlCj4gc2FtZSByZXN1bHQgaWYgcmVmcmVzaGluZyB0aGUgYW5hIGxvZyBpbmxpbmUgd2l0aCB0
aGUgbmFtZXNwYWNlIHNjYW4KPiBhbHNvIGZhaWxzLiBJcyB0aGVpciBhIGRpZmZlcmVuY2UgSSdt
IG5vdCBzZWVpbmc/Cj4gCk15IHBvaW50IHdhcyB0aGF0IHdpdGggeW91ciBhcHByb2FjaCB3ZSdy
ZSBkb2luZyBJL08gaW4gdGhlIG1pZGRsZSBvZiBhIApub24tcmVjb3ZlcmFibGUgc2VjdGlvbi4K
V2hpbGUgdGhlIHJlc3VsdCBvZiB0aGUgYWN0dWFsIEkvTyBwcm9iYWJseSBkb24ndCBtYXR0ZXIg
bXVjaCAoYXMgeW91IApyaWdodGx5IHBvaW50ZWQgb3V0KSwgaXQncyB0aGUgc2lkZSBlZmZlY3Qg
b2YgYW4gSS9PIGVycm9yIHdoaWNoIEknbSAKd29ycmllZCBhYm91dC4KSWYgd2UgaGl0IGFuIEkv
TyBlcnJvciBpdCBtZWFucyB0aGF0IGVycm9yIHJlY292ZXJ5IF93aWxsXyBoYXZlIHN0YXJ0ZWQu
CldoaWNoIG1lYW5zIHRoYXQgd2UgY2Fubm90IHJlbHkgb24gdGhlIHJlbWFpbmluZyBwYXJ0IG9m
IHRoYXQgZnVuY3Rpb24gCnRvIGJlIGV4ZWN1dGVkIHByb3Blcmx5LCBhcyB0aGUgY29udHJvbGxl
ciBtaWdodCBoYXZlIGJlZW4gdG9ybiBkb3duIAphbHJlYWR5LiBTbyBteSB3b3JyeSBoZXJlIGlz
IHRoYXQgd2UncmUgbGVmdCB3aXRoIGEgaGFsZndheS1pbml0aWFsaXplZCAKYmxvY2sgZGV2aWNl
IGFuZCBoYXZlIG5vIHdheSB0byByZWNvdmVyIHRoYXQuCkluIHF1ZXVlZCBhcHByb2FjaCBJJ3Zl
IHN1Z2dlc3RlZCBhbiBJL08gZXJyb3Igb24gcmVhZGluZyB0aGUgQU5BIGxvZyAKd291bGQgY2F1
c2UgdGhlIHNjYW4gdG8gYmUgYWJvcnRlZCwgd2hpY2ggaXMgcGVyZmVjdGx5IGZpbmUgYXMgaXQn
bGwgYmUgCnJlZG9uZSBhdCB0aGUgZW5kIG9mIHRoZSBlcnJvciByZWNvdmVyeSBhbnl3YXkuCkF0
IHRoZSBleHBlbnNlIG9mIGFsd2F5cyBoYXZpbmcgdG8gcmVhZCB0aGUgQU5BIGxvZyBiZWZvcmUg
c2Nhbm5pbmcsIApJJ2xsIGFkbWl0LgpCdXQgbWF5YmUgdGhlcmUncyBhbm90aGVyIHdheSwgYnkg
bGlmdGluZyB0aGUgY2hlY2sgZm9yIHRoZSBBTkEgCmluZm9ybWF0aW9uIHByaW9yIHRvIHNldHRp
bmcgdXAgdGhlIGJsb2NrIGRldmljZSAuLi4gbGVtbWUgY2hlY2suCgpDaGVlcnMsCgpIYW5uZXMK
LS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJj
aGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVy
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
