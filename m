Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDEC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 15:25:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F25230FE
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 15:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F25230FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2bkS4MeWzb7T7IxaiRxg3kVt8zs26SLBSSuIUY7OXII=; b=i2Kflh+2AofmVPJOsk4PiPRFm
	uQUyTdORvkNcMCSgTfUPpGRYVaOyrR1d2tqsk+JTy1eLUVydoy9QSHuiRHDWQfr2opo7Aw4lq+r6r
	Rcn24DuuntsMjxWY3OASn0ZrK6ToN6UUvvhNcE8r4sxsy1swULiZSGbnXrqfUtqHTeb1+5cpxyI8I
	2O8Z+SmBcHjrAryt/9XUKRe8KcOYqIZWDgUI647G39yiNHAnBX5aSCCbobGMTh89VsZfMp9evZpL3
	A22hEwV2Nv3wJ0GTB6VY8K+AfngEgisn90k652y43uvWsGMVY1/vqPZ3cnBmnOC8sFIwYGJbbFDEg
	gvkidIunA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4QDV-0002Xw-QP; Tue, 26 Jan 2021 15:25:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4QDT-0002Wv-CF
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 15:25:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E1C21AAC6;
 Tue, 26 Jan 2021 15:25:12 +0000 (UTC)
Subject: Re: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
To: Keith Busch <kbusch@kernel.org>
References: <20210121095021.22807-1-hare@suse.de>
 <20210121201459.GA1727271@dhcp-10-100-145-180.wdc.com>
 <f374b032-cd26-4552-b613-228449f4971d@suse.de>
 <20210122164454.GA4392@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b27ba758-7635-4235-cb32-d485a01e59f5@suse.de>
Date: Tue, 26 Jan 2021 16:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122164454.GA4392@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_102515_577070_844F80B3 
X-CRM114-Status: GOOD (  22.60  )
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
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yMi8yMSA1OjQ0IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIEphbiAyMiwg
MjAyMSBhdCAwNTozNTozNVBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDEv
MjEvMjEgOToxNCBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+PiBPbiBUaHUsIEphbiAyMSwgMjAy
MSBhdCAxMDo1MDoyMUFNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+Pj4gSWYgdGhl
IGNhbGwgdG8gbnZtZV9zZXRfcXVldWVfY291bnQoKSBmYWlscyB3aXRoIGEgc3RhdHVzIHdlIHNo
b3VsZAo+Pj4+IG5vdCBpZ25vcmUgaXQgYnV0IHJhdGhlciBwYXNzIGl0IG9uIHRvIHRoZSBjYWxs
ZXIuCj4+Pj4gSXQncyB0aGVuIHVwIHRvIHRoZSB0cmFuc3BvcnQgdG8gZGVjaWRlIHdoZXRoZXIg
dG8gaWdub3JlIGl0Cj4+Pj4gKGxpa2UgUENJIGRvZXMpIG9yIHRvIHJlc2V0IHRoZSBjb25uZWN0
aW9uIChhcyB3b3VsZCBiZSBhcHByb3ByaWF0ZQo+Pj4+IGZvciBmYWJyaWNzKS4KPj4+Cj4+PiBJ
bnN0ZWFkIG9mIGNoZWNraW5nIHRoZSBlcnJvciwgd291bGRuJ3QgY2hlY2tpbmcgdGhlIG51bWJl
ciBvZiBjcmVhdGVkCj4+PiBxdWV1ZXMgYmUgc3VmZmljaWVudD8gV2hhdCBoYW5kbGluZyBkaWZm
ZXJlbmNlIGRvIHlvdSBleHBlY3QgdG8gb2NjdXIKPj4+IGJldHdlZW4gZ2V0dGluZyBhIHN1Y2Nl
c3Mgd2l0aCAwIHF1ZXVlcywgdnMgZ2V0dGluZyBhbiBlcnJvcj8KPj4+Cj4+IFRoZSBkaWZmZXJl
bmNlIGlzIHRoYXQgYW4gZXJyb3Igd2lsbCAocmUtKXN0YXJ0IHJlY292ZXJ5LCAwIHF1ZXVlcyB3
b24ndC4KPj4gQnV0IHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCBudm1lX3NldF9xdWV1ZV9jb3Vu
dCgpIGlzIGJlaW5nIGNhbGxlZCBkdXJpbmcKPj4gcmVjb25uZWN0aW9uLCBpZSBkdXJpbmcgdGhl
IHJlY292ZXJ5IHByb2Nlc3MgaXRzZWxmLgo+PiBBbmQgdGhpcyBjb21tYW5kIGlzIHJldHVybmVk
IHdpdGggYSB0aW1lb3V0LCB3aGljaCBpbiBhbnkgb3RoZXIgY2FzZSBpcwo+PiBiZWluZyB0cmVh
dGVkIGFzIGEgZmF0YWwgZXJyb3IuIFBsdXMgd2UgaGF2ZSBiZWVuIHNlbmRpbmcgdGhpcyBjb21t
YW5kIG9uCj4+IHRoZSBhZG1pbiBxdWV1ZSwgc28gYSB0aW1lb3V0IG9uIHRoZSBhZG1pbiBxdWV1
ZSBwcmV0dHkgbXVjaCBfaXNfICBhIGZhdGFsCj4+IGVycm9yLiBTbyB3ZSBzaG91bGQgYmUgdGVy
bWluYXRpbmcgdGhlIGN1cnJlbnQgcmVjb3ZlcnkgYW5kIHJlY29ubmVjdC4gTm9uZQo+PiBvZiB0
aGF0IHdpbGwgaGFwcGVuIGlmIHdlIHJldHVybiAnMCcgcXVldWVzLgo+IAo+IFlvdSBzaG91bGQg
YWxyZWFkeSBiZSBnZXR0aW5nIGFuIGVycm9yIHJldHVybiBzdGF0dXMgaWYgYSB0aW1lb3V0IG9j
Y3Vycwo+IGZvciBudm1lX3NldF9xdWV1ZV9jb3VudCgpLCBzcGVjaWZpY2FsbHkgLUVJTlRSLiBB
cmUgeW91IGdldHRpbmcgc3VjY2Vzcwo+IGZvciBzb21lIHJlYXNvbj8KPiAKLUVJTlRSICh3aGlj
aCB0cmFuc2xhdGVzIHRvICdudm1lX3JlcShyZXEpLT5mbGFncyAmIE5WTUVfUkVRX0NBTkNFTExF
RCcpIAp3aWxsIG9ubHkgZXZlciBiZSByZXR1cm5lZCBvbiBwY2k7IGZhYnJpY3MgZG9lc24ndCBz
ZXQgdGhpcyBmbGFnLCBzbyAKd2UncmUgbmV2ZXIgZ2V0dGluZyBhbiAtRUlOVFIuCgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6Rm
dHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
