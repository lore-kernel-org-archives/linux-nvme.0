Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB94C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 16:02:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18DA61078
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 16:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18DA61078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bmb+vduioT8mFvrj0g7/4hADwqKOYj4nagw3Q/tlYkQ=; b=IF1WpfQ15JBvGD7DqWp255F0b
	79QG//GGDjyJ/Sy1xTcWIygvrv2W137sVKgUx7WjATJFHN5j5y5vyBm98qwNVQHK5RoTLIs3ne6fL
	tLjjS+s0S8gQNexvfS7ONC4R8W3QPhYPr88PWQrkF5MvlK5cEta4gzgjrejiyTEoC1SaA4UE4Mgdy
	wJA5/bEyhFWYEhpHypEIjuF1A+x+jq+2DACC7CJ/sMCEf8/wgN8rUV/oM6LiiHkO4pridu6W/C5cx
	q4Wtf1f91WKNeCw4jm98Enw55Q/n4hFa/yF7U0m9YkYt5ZcHwrElMIJlHYUC9voQfOZbLYezXoz7i
	vTamjATiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1legSd-004jzy-CZ; Thu, 06 May 2021 16:02:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1legKg-004h69-Ch
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 15:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ClE+KHXDEnVIw77yMiDR9B9wwrmb2UImEGzf96Ral8k=; b=Sitrj1qXIoJ6/4Wa/gI9S2uie7
 n5o0ih0c1pVYz3Y5IbPe8DsEqgxtEvkqJoqY+pdSvYAxUCvEsIDDa1K4SPxQjIPgAfAKRQrylAoEi
 /fccy+WFO13Pij/mG+J1lGArWr8cTn2M9DB7GAA7oO/yPiWAMZP2lThHqiapkXAF+btbE0sEcGh6/
 CtzR7YG5iypO6hmh5bxpdcZ89jBEZxneIgEcGcmvxycTO1xi/+wtAdpISfCaEGR7z/QHuzRY9a9BB
 /2WtaUQQ9aO6vRP0nwifryDOglBGMYSykScaeBrE8iDy1+K31ZLQxTY6zsI7hm1fPVPvdZh3b1alV
 9jOij4oQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1legKd-006BNe-Lo
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 15:54:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DBA13B004;
 Thu,  6 May 2021 15:54:29 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
Date: Thu, 6 May 2021 17:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210506120855.GA1546@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_085431_875947_7F502F64 
X-CRM114-Status: GOOD (  18.10  )
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

T24gNS82LzIxIDI6MDggUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFRodSwgTWF5
IDA2LCAyMDIxIGF0IDAyOjQ3OjAwQU0gLTA3MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IFRo
YXQgaXMgbXkgYXNzdW1wdGlvbiBhcyB3ZWxsLCBhbmQgaXRzIGEgcHJvYmxlbSB0aGF0IGJ5IGRl
ZmF1bHQKPj4gYSBwY2kgZGV2aWNlIHVucGx1Z3Mgb3IgYSBmYWJyaWNzIGNvbnRyb2xsZXIgaXMg
bG9zdCBhbmQgcmVtb3ZlZAo+PiB0aGUgc3RhY2tlZCBtZHJhaWQgb24gdG9wIHN0b3BzIGZ1bmN0
aW9uaW5nLgo+Pgo+PiBJIHN0aWxsIHRoaW5rIHdlIGNhbiBmaXggdGhhdCBieSBjaGFuZ2luZyB0
aGUgc2VtYW50aWNzIG9mIGltcGxpY2l0Cj4+IHF1ZXVlX2lmX25vX3BhdGggYW5kIHJlc3RvcmUg
aXQgYXMgYW4gZXhwbGljaXQgb3B0LWluLgo+IAo+IFNvIGF0IHZlcnkgbGVhc3Qgd2UgbmVlZCB0
byBtYWtlIHN1cmUgd2UgaGF2ZSB0aGUgb3B0LWluIGF2YWlsYWJsZSBiZWZvcmUKPiBjaGFuZ2lu
ZyB0aGUgZGVmYXVsdHMuCj4gCgpCdXQgd2hhdCBfaXNfIHRoZSBkZWZhdWx0PwpQQ0kgYW5kIGZh
YnJpY3MgaGF2ZSBkaWZmZXJlbnQgZGVmYXVsdHM7IGZvciBQQ0kgdGhlIGRldmljZSBnb2VzIGF3
YXkgaWYgCnRoZSBsYXN0IHBhdGggKGllIHRoZSBjb250cm9sbGVyKSBnb2VzIGF3YXksIGZvciBm
YWJyaWNzIGl0IGRvZXNuJ3QgaWYgCnRoZSBkZXZpY2UgaXMgbW91bnRlZC4KCkRvIHdlIHdhbnQg
dG8ga2VlcCB0aGUgZGlmZmVyZW5jZSBpbiBiZWhhdmlvdXI/CgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0
ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
