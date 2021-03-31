Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53716C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 15:30:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF18261019
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 15:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF18261019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zot0byHVw22ndRwMohLQbZK/HOZORYWu/WsdAUyYU5o=; b=ojsJDjaJMb+0G/v6DiRNDMM7s
	MVjRwe7Xw+GZFvlCj6X7gYivWn6s1CWQ0rhEfM97bwbjRa7m4fZ9xVgFKRUK8ecgRb7gCS6vMF/d0
	L18oEbxSx60+EVQHQ56+cUXhHX0BK0RK/9uBAY6kkEVOkVkycL/RcRHJ/BH1/oZdLMqCe2r2dmoL0
	lvMA316JdaVlRlO7USvgzlWhLbfuUvPJsybOB+5qxOhmd9xMmUzJBTcURscedhTs95/ZP1ZC91wcJ
	f1KLtlnpfJqd89s3K6YBpkAr+LXuHicU9FXP1xvvsYvixi3g+eGISvt6HdTXPGMWHNGE4SKhyWJE4
	jyh/X2oRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRcn2-006u6k-IA; Wed, 31 Mar 2021 15:29:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRcmz-006u5r-1B
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 15:29:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CC25AB166;
 Wed, 31 Mar 2021 15:29:46 +0000 (UTC)
Subject: Re: libnvme questions
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
 <15fdfa03-3adf-6877-e369-47429a5462a5@suse.de>
 <20210331145406.GB23886@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <44c4f2ea-dd3e-5a9c-f93e-d6de6ca7dd13@suse.de>
Date: Wed, 31 Mar 2021 17:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210331145406.GB23886@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_162949_244848_88F6470A 
X-CRM114-Status: GOOD (  18.59  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zMS8yMSA0OjU0IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBXZWQsIE1hciAzMSwg
MjAyMSBhdCAwNDoxNToyNFBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IEhpIEtl
aXRoLAo+Pgo+PiBPbiAzLzEwLzIxIDk6NDggUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+Pj4gT24g
V2VkLCBNYXIgMDMsIDIwMjEgYXQgMDM6MTQ6MDJQTSAtMDYwMCwgVG9ueSBBc2xlc29uIHdyb3Rl
Ogo+Pj4+IDEuIFRoZXJlIGlzIGludGVyZXN0IGluIHV0aWxpemluZyB0aGUgbGlibnZtZSBsaWJy
YXJ5IGZvciBzb21lIG90aGVyCj4+Pj4gcHJvamVjdHMsIHdoZW4gaXMgYW4gb2ZmaWNpYWwgcmVs
ZWFzZSBvZiB0aGUgbGlicmFyeSBwbGFubmVkPwo+Pj4+Cj4+Pj4gMi4gSXMgaXQgcGxhbm5lZCBm
b3IgbnZtZS1jbGkgdG8gdXRpbGl6ZSBsaWJudm1lPwo+Pj4KPj4+IFRoaXMgaXMgbXkgYmFkLCBJ
IGZlbGwgYmVoaW5kIHRoZSB0YXNrIGR1ZSB0byBtdXRsaXBsZSBjb25mbGljdHMgb2YKPj4+IHRp
bWUsIGJ1dCBJIGFtIGJhY2sgb24gdGhpcyByaWdodCBub3cuIFRoZSBwbGFuIGlzIHRvIHRhZyBu
dm1lLWNsaSB2MS4xNAo+Pj4gd2l0aGluIHRoZSBuZXh0IGZldyB3ZWVrcywgdGhlbiBtYWtlIHRo
ZSBzaGlmdCB0byBsaWJudm1lIGludGVncmF0aW9uCj4+PiBvbiBhICIyLjAiIHZlcnNpb24gZm9y
IGZ1dHVyZSB3b3JrIG9uIHRoZSBtYXN0ZXIgYnJhbmNoLiBUaGlzIHdvdWxkCj4+PiBjb2luY2lk
ZSB3aXRoIGFuIG9mZmljaWFsIGxpYm52bWUgc3RhYmxlIHJlbGVhc2UuCj4+Pgo+Pj4gSSBob25l
c3RseSBkbyBub3QgaGF2ZSBlbm91Z2ggZGV2aWNlcyB0byByZWdyZXNzaW9uIHRlc3QgYWxsIHRo
ZQo+Pj4gZmVhdHVyZXMsIHNvIEkgd2lsbCBjb250aW51ZSB0byBtYWludGFpbiBudm1lLWNsaSAx
LnggYnJhbmNoZXMgYXMgbG9uZwo+Pj4gYXMgbmVjZXNzYXJ5IHdoaWxlIGlyb25pbmcgb3V0IGFu
eSBpbnRlZ3JhdGlvbiBpc3N1ZXMuCj4+PiAgIAo+PiBBbnkgdXBkYXRlcyBoZXJlPwo+PiBXZSd2
ZSBnb3Qgc29tZSBjaGFuZ2VzL3Jld29ya3MgcGVuZGluZyAodGhlIG52bWUgbW9uaXRvciBzdHVm
ZiwgYW5kIGFsc28KPj4gYSBuZXcgY29uZmlndXJhdGlvbiBmaWxlIG1lY2hhbmlzbSB3aXRoIHVz
aW5nIGEganNvbiBjb25maWcgZmlsZSksIGFuZAo+PiBpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cg
d2hhdCB3b3VsZCBiZSB0aGUgYXBwcm9wcmlhdGUgYmFzZSBmb3IgYWxsIG9mIHRoaXMuCj4+Cj4+
IFdlIGNvdWxkIGdpdmUgeW91IGEgaGVscGluZyBoYW5kIGluIG1vdmluZyBudm1lLWNsaSBvdmVy
IHRvIG52bWVsaWIgaWYKPj4gdGhhdCdzIGFuIGlzc3VlIC4uLgo+IAo+IFRoYW5rIHlvdSwgeWVz
LCB0aGF0IHdvdWxkIGJlIGFwcHJlY2lhdGVkLiBJJ3ZlIHBvcnRlZCBpdCBhIGNvdXBsZQo+IHRp
bWVzLCBidXQgSSBrZWVwIGhhdmluZyB0byByZWJhc2UuIEl0J3Mgbm90IHRlcnJpYmx5IGRpZmZp
Y3VsdCwgYnV0IGl0Cj4gdGFrZXMgYSBsb3Qgb2YgdGltZS4uCj4gCkNhbiB5b3Ugc2VuZCBtZSB5
b3VyIGxhdGVzdCBhdHRlbXB0cz8KVGhhdCBzaG91bGQgYmUgYSBnb29kIHN0YXJ0aW5nIHBvaW50
LCBhbmQgcHJvYmFibHkgYXZvaWRzIHNvbWUgd29yayBvbiAKb3VyIHNpZGUgLi4uCgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6Rm
dHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
