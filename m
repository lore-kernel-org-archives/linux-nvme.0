Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D6C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:38:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89BE6120E
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89BE6120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YYZjsRt2V+6BdW8ImsUAYCtPuqTLthG8iySY6sfcFsM=; b=ASA6mpj6aUHFZyA5sDFT7ogiX
	OG74Yyp1wZ8I4Q1j68k+10nM2pNsqHYtkVjA7zWxCDxlM79cT7DvhkCYDrBgakejhfoH0i1ER4yD8
	NJi787yStuXaWdz3igcn1YXAlcQzTHPVR67++DOmh/Ybs6QjNjog1IVL2N3rDP9uDn03kRQ4LFQls
	G6tfaz7hY7tIdCTVYv15s+pOIL2SGcU9Cu66rQ4NNKTzH7UwAu7aBvsGxw0a0hF8nqjIlIHLb91Sk
	iSlNeyjEGhsVMFha8phINnqaTpUDRD5+5eVTbs7yqc2YOmiRajO8oZmtl5Io8ZoWDsWFIws2vsybZ
	0AH/DULEw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAQD-00Bgob-DD; Sun, 02 May 2021 11:38:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAQ9-00Bgo4-Bv
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=DGPNeomtV+7s0NbW2DKBT/248pBe+rTAUU//zu9GHyI=; b=fsYYJRIuJRL/tw58H2yMYlLAZE
 dBoX3WvDL3A133xm5rHZFcyZJQRi5AwXYX+MKkPwpM+SJBuspy0VsN9ih6CwJXrwHra06xDn9j0xI
 hv+ID6Yb7/JzA6GEQa8u6il5m3fmYvtdKrJ6Vo549/GncdGNFHBHklQlyTy7tC8Tc9T8c3UsfoMXi
 kQNe4jvu+C4ItmCiGmSzexNKfcPjLKtlWRG5+qH2mtJ+xMa7Q9paEVAU/sOuWNPm6hsA8o5U5Gj+G
 DB2j+oxj6NI9ApEZlpuGYHMVwmEMjL2GfMbVKSLxjEZinhgSc8oIa3zIcIuaZeNWaw9usNfSGp6jD
 Zo6bcyLA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAQ6-002VOT-Mh
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:37:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DBAA0AE00;
 Sun,  2 May 2021 11:37:50 +0000 (UTC)
Subject: Re: [RFC PATCH v4 20/27] qedn: Add connection-level slowpath
 functionality
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-21-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <95009c8e-330f-fd99-781c-cb2b80263ba2@suse.de>
Date: Sun, 2 May 2021 13:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-21-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_043754_903014_85C9B761 
X-CRM114-Status: GOOD (  15.55  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IFByYWJoYWthciBL
dXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IAo+IFRoaXMgcGF0Y2ggd2lsbCBwcmVz
ZW50IHRoZSBjb25uZWN0aW9uIChxdWV1ZSkgbGV2ZWwgc2xvd3BhdGgKPiBpbXBsZW1lbnRhdGlv
biByZWxldmFudCBmb3IgY3JlYXRlX3F1ZXVlIGZsb3cuCj4gCj4gVGhlIGludGVybmFsIGltcGxl
bWVudGF0aW9uOgo+IC0gQWRkIHBlciBjb250cm9sbGVyIHNsb3dwYXRoIHdvcmtxZXVldWUgdmlh
IHByZV9zZXR1cF9jdHJsCj4gCj4gLSBxZWRuX21haW4uYzoKPiAgICBJbmNsdWRlcyBxZWRuJ3Mg
aW1wbGVtZW50YXRpb24gb2YgdGhlIGNyZWF0ZV9xdWV1ZSBvcC4KPiAKPiAtIHFlZG5fY29ubi5j
IHdpbGwgaW5jbHVkZSBtYWluIHNsb3dwYXRoIGNvbm5lY3Rpb24gbGV2ZWwgZnVuY3Rpb25zLAo+
ICAgIGluY2x1ZGluZzoKPiAgICAgIDEuIFBlci1xdWV1ZSByZXNvdXJjZXMgYWxsb2NhdGlvbi4K
PiAgICAgIDIuIENyZWF0aW5nIGEgbmV3IGNvbm5lY3Rpb24uCj4gICAgICAzLiBPZmZsb2FkaW5n
IHRoZSBjb25uZWN0aW9uIHRvIHRoZSBGVyBmb3IgVENQIGhhbmRzaGFrZS4KPiAgICAgIDQuIERl
c3Ryb3kgb2YgYSBjb25uZWN0aW9uLgo+ICAgICAgNS4gU3VwcG9ydCBvZiBkZWxldGUgYW5kIGZy
ZWUgY29udHJvbGxlci4KPiAgICAgIDYuIFRDUCBwb3J0IG1hbmFnZW1lbnQgdmlhIHFlZF9mZXRj
aF90Y3BfcG9ydCwgcWVkX3JldHVybl90Y3BfcG9ydAo+IAo+IEFja2VkLWJ5OiBJZ29yIFJ1c3Nr
aWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogUHJhYmhha2FyIEt1
c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogT21rYXIgS3Vs
a2FybmkgPG9rdWxrYXJuaUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2Fs
ZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlv
ciA8YWVsaW9yQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYWkgTWFsaW4gPHNtYWxp
bkBtYXJ2ZWxsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ody9xZWRuL01ha2VmaWxlICAg
IHwgICA1ICstCj4gICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuLmggICAgICB8IDE3MyArKysr
KysrKysrLQo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9jb25uLmMgfCA1MDggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9t
YWluLmMgfCAyMDggKysrKysrKysrKysrLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA4ODMgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9u
dm1lL2h3L3FlZG4vcWVkbl9jb25uLmMKPiAKClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAg
ICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
