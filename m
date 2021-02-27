Return-Path: <SRS0=5wgU=H5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1520C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Feb 2021 09:13:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7344564EB7
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Feb 2021 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7344564EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ELTS41jeEPG9u5dm5Vd/pxqIFNKHrpgk+OO2Qdh8YJs=; b=VDd58z9CEXp+ekMJet9plSusp
	SHahAkiIXPrHci/82XJKRAr5qCeK/OEypIEo9Xy9+hTTvsvCn9DZRVxYUJ+/JCunQ6PdlUQKMegxv
	kZ9aXEjfyxc3vjKcaSdyV6WJqRzqpT00Zss0A8IxtsWPKj7m3aYkyL0TDyigPFAL5M7G0IzLzl33o
	pT4kSIX+/0jyRnxkNQ+ElHkzsiUDc5575BqeuV79EcBD3MnAoTX82oDG9p/G+8r9hnXRH/9V/h8xv
	NDQ6f0Q1W8bSviQYbHmSocWmTvqpYYCHx5vMGmcKZXEH9obGM516cfHsrmyN4GhWvHyC1fboeiqUp
	u286l1ZRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFvej-0001hY-DO; Sat, 27 Feb 2021 09:12:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFveZ-0001h6-LL
 for linux-nvme@lists.infradead.org; Sat, 27 Feb 2021 09:12:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 45FA2AAC5
 for <linux-nvme@lists.infradead.org>; Sat, 27 Feb 2021 09:12:44 +0000 (UTC)
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
To: linux-nvme@lists.infradead.org
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
Date: Sat, 27 Feb 2021 10:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210227_041247_826549_883D5E77 
X-CRM114-Status: GOOD (  21.84  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNC8yMSA2OjU5IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8yLzI0
IDc6MjEsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+PiBPbiBUdWUsIEZlYiAyMywgMjAyMSBhdCAwMzoy
NjowMlBNICswODAwLCBDaGFvIExlbmcgd3JvdGU6Cj4+PiBBIGNyYXNoIGhhcHBlbnMgd2hlbiBz
ZXQgZmVhdHVyZShOVk1FX0ZFQVRfTlVNX1FVRVVFUykgdGltZW91dCBpbiBudm1lCj4+PiBvdmVy
IHJkbWEocm9jZSkgcmVjb25uZWN0aW9uLCB0aGUgcmVhc29uIGlzIHVzZSB0aGUgcXVldWUgd2hp
Y2ggaXMgbm90Cj4+PiBhbGxvY2VkLgo+Pj4KPj4+IElmIGl0IGlzIG5vdCBkaXNjb3ZlcnkgYW5k
IG5vIGlvIHF1ZXVlcywgdGhlIGNvbm5lY3Rpb24gc2hvdWxkIGZhaWwuCj4+Cj4+IElmIHlvdSdy
ZSBnZXR0aW5nIGEgdGltZW91dCwgd2UgbmVlZCB0byBxdWl0IGluaXRpYWxpemF0aW9uLiBIYW5u
ZXMKPj4gYXR0ZW1wdGVkIG1ha2luZyB0aGF0IHN0YXR1cyB2aXNpYmxlIGZvciBmYWJyaWNzIGhl
cmU6Cj4+Cj4+ICAgIAo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGlu
dXgtbnZtZS8yMDIxLUphbnVhcnkvMDIyMzUzLmh0bWwKPiBJIGtub3cgdGhlIHBhdGNoLiBJdCBj
YW4gbm90IHNvbHZlIHRoZSBzY2VuYXJpbzogdGFyZ2V0IG1heSBiZSBhbgo+IGF0dGFja2VyIG9y
IHRoZSB0YXJnZXQgYmVoYXZpb3IgaXMgaW5jb3JyZWN0Lgo+IElmIHRhcmdldCByZXR1cm4gMCBp
byBxdWV1ZXMgb3IgcmV0dXJuIG90aGVyIGVycm9yIGNvZGUsIHRoZSBjcmFzaCB3aWxsCj4gc3Rp
bGwgaGFwcGVuLiBXZSBzaG91bGQgbm90IGFsbG93IHRoaXMgdG8gaGFwcGVuLgpJJ20gZnVsbHkg
d2l0aCB5b3UgdGhhdCB3ZSBzaG91bGRuJ3QgY3Jhc2gsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lIGEg
dmFsdWUgCm9mICcwJyBmb3IgdGhlIG51bWJlciBvZiBJL08gcXVldWVzIGlzIGNvbnNpZGVyZWQg
dmFsaWQuClNvIHdlIHNob3VsZCBmaXggdGhlIGNvZGUgdG8gaGFuZGxlIHRoaXMgc2NlbmFyaW8s
IGFuZCBub3QgZGlzYWxsb3dpbmcgCnplcm8gSS9PIHF1ZXVlcy4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
