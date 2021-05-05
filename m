Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 16:16:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033646121F
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 16:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033646121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FsP/lWi6W4IYAWRr4tZiOv243BqWQb8FHt3oS8uoPG4=; b=rQymvRAsNcAHT0a/tbiKqccxF
	b4Nu4Lcqn7Fe9HhsVEhgP1yC5VwJKsvIqbjN8sgGnKlUDgyafb1uGHAu+IAcOzbrkmaWWrFOqWlhP
	iobX16RU2yfVT8RudISIG+6LAssj4qGocMtOV6Mh9B00oiSq9tjVxdjDG9t+HikTXPbPqlHNA0n0e
	918SRVPbChRMmAcgL6EQQzpNc6AhWESwSqpmaGOT7v03lD9kFCJofif8/J0NHVIW/YJOTgP68cbzK
	hxBaRpAqN8fwLZJjXbxDALA/PUyEHnoeGSyswswHZZiTsxHb/uN12UfP2co1N7OCFNCzUaIQB4BMe
	p3TemH45A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leKBr-001chv-5P; Wed, 05 May 2021 16:15:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leKBn-001che-Hb
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 16:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Eyobt0la8AYEu57foFgvkrgktHt3D8zfUSOYs6vZgjw=; b=UFPYB5P0YLE6UjJ5gG7M2mTTO3
 84TEND2nQYdYEzb6oWyei8na7tmNMd+/DauAH5imYiTM0f1y5V8JnwyIT4O5AsSSp5k5rLwSkcTBR
 rNdso1AbTRUXGYDUcL/PCItGap1hh2O4EhOFfOFK+VBgDxulk6YgfmTeHI8BRPY8obGG5nfFjvv8g
 oDEPVuM0GwbKTSpKajk0zbZO6auesVBtLeVANXXQGTotP/Z5+u62ZGEy1eDN3BHdDruSEMZx34OcU
 NtXFBHEg2OxKnRoPmrekDnvwd+8zum/2R6avr56y3xWAamquJ5GzTOLpi056vSVUpPH/5leqW4FHA
 R7vYeVbw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leKBk-004vCz-F3
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 16:15:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 36E97B01D;
 Wed,  5 May 2021 16:15:48 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210505152659.GB912679@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <6a43fe69-e73a-07f8-f050-8116add83074@suse.de>
Date: Wed, 5 May 2021 18:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210505152659.GB912679@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_091552_669501_4FC61D41 
X-CRM114-Status: GOOD (  24.84  )
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

T24gNS81LzIxIDU6MjYgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFR1ZSwgTWF5IDA0LCAy
MDIxIGF0IDEyOjU0OjE0UE0gLTA3MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Cj4+Pj4gQXMg
c3RhdGVkIGluIHRoZSB2MyByZXZpZXcgdGhpcyBpcyBhbiBpbmNvbXBhdGlibGUgY2hhbmdlLsKg
IFdlJ2xsIG5lZWQKPj4+PiB0aGUgcXVldWVfaWZfbm9fcGF0aCBhdHRyaWJ1dGUgZmlyc3QsIGFu
ZCBkZWZhdWx0IGl0IHRvIG9uIHRvIGtlZXAKPj4+PiBjb21wYXRhYmlsaXR5Lgo+Pj4+Cj4+Pgo+
Pj4gVGhhdCBpcyB3aGF0IEkgdHJpZWQgdGhlIGxhc3QgdGltZSwgYnV0IHRoZSBkaXJlY3Rpb24g
SSBnb3Qgd2FzIHRvIHRyZWF0Cj4+PiBib3RoLCBOVk1lLVBDSSBhbmQgTlZNZS1vRiBpZGVudGlj
YWxseToKPj4+IChodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzM0ZTVjMTc4LThi
YzQtNjhkMy04Mzc0LWZiYzFiNDUxYjZlOEBncmltYmVyZy5tZS8pCj4+Cj4+IFllcywgSSdtIG5v
dCBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIGNvbW1lbnQgQ2hyaXN0b3BoLiBUaGlzIGFkZHJlc3Nl
cyBhbgo+PiBpc3N1ZSB3aXRoIG1kcmFpZCB3aGVyZSBob3QgdW5wbHVnK3JlcGx1ZyBkb2VzIG5v
dCByZXN0b3JlIHRoZSBkZXZpY2UgdG8KPj4gdGhlIHJhaWQgZ3JvdXAgKHBjaSBhbmQgZmFicmlj
cyBhbGlrZSksIHdoZXJlIGJlZm9yZSBtdWx0aXBhdGggdGhpcyB1c2VkCj4+IHRvIHdvcmsuCj4+
Cj4+IHF1ZXVlX2lmX25vX3BhdGggaXMgYSBkbS1tdWx0aXBhdGggZmVhdHVyZSBzbyBJJ20gbm90
IGVudGlyZWx5IGNsZWFyCj4+IHdoYXQgaXMgdGhlIGNvbmNlcm4/IG1kcmFpZCBvbiBudm1lIChw
Y2kvZmFicmljcykgdXNlZCB0byB3b3JrIGEgY2VydGFpbgo+PiB3YXksIHdpdGggdGhlIGludHJv
ZHVjdGlvbiBvZiBudm1lLW1wYXRoIHRoZSBiZWhhdmlvciB3YXMgYnJva2VuIChhcyBmYXIKPj4g
YXMgSSB1bmRlcnN0YW5kIGZyb20gSGFubmVzKS4KPj4KPj4gTXkgdGhpbmtpbmcgaXMgdGhhdCBp
ZiB3ZSB3YW50IHF1ZXVlX2lmX25vX3BhdGggZnVuY3Rpb25hbGl0eSBpbiBudm1lCj4+IG1wYXRo
IHdlIHNob3VsZCBoYXZlIGl0IGV4cGxpY2l0bHkgc3RhdGVkIHByb3Blcmx5IHN1Y2ggdGhhdCBw
ZW9wbGUKPj4gdGhhdCBhY3R1YWxseSBuZWVkIGl0IHdpbGwgdXNlIGl0IGFuZCBoYXZlIG1kcmFp
ZCBmdW5jdGlvbiBjb3JyZWN0bHkKPj4gYWdhaW4uIEFsc28sIHF1ZXVlX2lmX25vX3BhdGggYXBw
bGllcyByZWFsbHkgaWYgYWxsIHRoZSBwYXRocyBhcmUKPj4gZ29uZSBpbiB0aGUgc2Vuc2UgdGhl
eSBhcmUgY29tcGxldGVseSByZW1vdmVkLCBhbmQgZG9lc24ndCBhcHBseQo+PiB0byBjb250cm9s
bGVyIHJlc2V0L3JlY29ubmVjdC4KPj4KPj4gSSBhZ3JlZSB3ZSBzaG91bGQgcHJvYmFibHkgaGF2
ZSBxdWV1ZV9pZl9ub19wYXRoIGF0dHJpYnV0ZSBvbiB0aGUKPj4gbXBhdGggZGV2aWNlLCBidXQg
aXQgZG9lc24ndCBzb3VuZCByaWdodCB0byBkZWZhdWx0IGl0IHRvIHRydWUgZ2l2ZW4KPj4gdGhh
dCBpdCBicmVha3MgbWRyYWlkIHN0YWNraW5nIG9uIHRvcCBvZiBpdC4uCj4gCj4gSWYgeW91IHdh
bnQgInF1ZXVlX2lmX25vX3BhdGgiIGJlaGF2aW9yLCBjYW4ndCB5b3UganVzdCBzZXQgcmVhbGx5
IGhpZ2gKPiByZWNvbm5lY3RfZGVsYXkgYW5kIGN0cmxfbG9zc190bW8gdmFsdWVzPyBUaGF0IHBy
ZXZlbnRzIHRoZSBwYXRoIGZyb20KPiBiZWluZyBkZWxldGVkIHdoaWxlIGl0IGlzIHVucmVhY2hh
YmxlLCB0aGVuIHJlc3RhcnQgSU8gb24gdGhlIGV4aXN0aW5nCj4gcGF0aCBvbmNlIGNvbm5lY3Rp
b24gaXMgcmUtZXN0YWJsaXNoZWQuCj4gClByZWNpc2VseSBteSB0aGlua2luZy4KV2UgX2NvdWxk
XyBhZGQgYSBxdWV1ZV9pZl9ub19wYXRoIGF0dHJpYnV0ZSwgYnV0IHdlIGNhbiBhbHNvIGFjaGll
dmUgdGhlCnNhbWUgYmVoYXZpb3VyIGJ5IHNldHRpbmcgdGhlIGN0cmxfbG9zc190bW8gdmFsdWUg
dG8gaW5maW5pdHkuClByb3ZpZGVkIHdlIGNhbiBjaGFuZ2UgaXQgb24gdGhlIGZseSwgdGhvdWdo
OyBidXQgaXQgbm90IHRoYXQncyBlYXNpbHkKZml4ZWQuCgpJbiBmYWN0LCB0aGF0J3Mgd2hhdCB3
ZSByZWNvbW1lbmQgdG8gb3VyIGN1c3RvbWVycyB0byBhdm9pZCB0aGUgYnVnCmZpeGVkIGJ5IHRo
aXMgcGF0Y2guCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwg
OTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
