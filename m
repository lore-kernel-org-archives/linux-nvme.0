Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C905C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:51:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5225323731
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5225323731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Aq/2hN2HOn4Ju3AV1o/5h91uHRi86BaZHsyIO6OOdAM=; b=p3p/1rnAAlLg9ntM7l8Y8NMy3
	GRayVzYBajcUfFzsKkKp2WCuY7b5Ffs6KJP7vmbEqgctQi76cWYYobSW8DK62TCEoYlqytXJ/Up0r
	ua60moE4JS0Vz/MXsl1fYqHymwJZDRJ7lObq62qDG2fvGPT7wpGVYVuvHxvILMbzK97RuNBX9PzyE
	ztJeL3e7p7b7Y8CS3qB6WmFotEZt6Xor84nXcnGG8kFqY6o5jqX1ncnsV7v6wJCi3htkm78w82SWH
	r4oai5G3yOucpbdXd6gA2D11JK5ynAkYuHEPK9Yjw5HlsUAeFo4f2h/1rZeun3Ry6ap90zzGtaPFt
	1RuAOfOTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmInG-0003Q9-9T; Mon, 07 Dec 2020 15:51:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmInB-0003Oo-K5
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 15:51:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CEC3BAD3F;
 Mon,  7 Dec 2020 15:51:11 +0000 (UTC)
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20201205152901.56665-1-hare@suse.de>
 <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
 <20201207153443.GA6236@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2ecc3aa8-7b2a-77fa-642f-05cac1a602da@suse.de>
Date: Mon, 7 Dec 2020 16:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207153443.GA6236@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_105113_875788_E453DC62 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvNy8yMCA0OjM0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBNb24sIERl
YyAwNywgMjAyMCBhdCAwNzozMToyMUFNIC0wODAwLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4gT24g
U2F0LCBEZWMgMDUsIDIwMjAgYXQgMDQ6Mjk6MDFQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdy
b3RlOgo+Pj4gSWYgQU5BIGlzIGVuYWJsZWQgYnV0IG5vIEFOQSBncm91cCBkZXNjcmlwdG9yIGlz
IGZvdW5kIHdoZW4gY3JlYXRpbmcKPj4+IGEgbmV3IG5hbWVzcGFjZSB0aGUgQU5BIGxvZyBpcyBt
b3N0IGxpa2VseSBvdXQgb2YgZGF0ZSwgc28gdHJpZ2dlcgo+Pj4gYSByZS1yZWFkLiBUaGUgbmFt
ZXNwYWNlIHdpbGwgYmUgdGFnZ2VkIHdpdGggdGhlIE5TX0FOQV9QRU5ESU5HIGZsYWcKPj4+IHRv
IGV4Y2x1ZGUgaXQgZnJvbSBwYXRoIHNlbGVjdGlvbiB1bnRpbCB0aGUgQU5BIGxvZyBoYXMgYmVl
biByZS1yZWFkLgo+Pj4KPj4+IFJlcG9ydGVkLWJ5OiBNYXJ0aW4gR2VvcmdlIDxtYXJ0aW5nQG5l
dGFwcC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5k
ZT4KPj4KPj4gVGhpcyBsb29rcyBnb29kIHRvIG1lLgo+Pgo+PiBSZXZpZXdlZC1ieTogS2VpdGgg
QnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPgo+IAo+IEJ1dCBhcyBJIGp1c3Qgb3V0bGluZWQgaXQg
anVzdCBwYXBlcnMgb3ZlciBidWdneSBjb250cm9sbGVycy4gIEkgcmVhbGx5Cj4gZG9uJ3QgdGhp
bmsgd2Ugc2hvdWxkIGp1c3Qgc2lsZW50bHkgZG8gdGhhdC4KPiAKV2hhdCB3b3VsZCBiZSB0aGUg
ZG93bnNpZGUgb2YgdGFraW5nIHRoaXMgcGF0Y2g/ClBlcnNvbmFsbHksIEknZCByYXRoZXIgYmUg
bGVuaWVudCBhbmQgYWxsb3cgdG8gaW50ZXJvcGVyYXRlLi4uCgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0
ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
