Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F5C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:01:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8933164E35
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933164E35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dnbEeUFTQA7US8Fva4fWmPs5Mh9Q2f2ZWZnlviXW2rA=; b=Lqesr9YrOcS3629e/d/o55uav
	CY93odP33cLdxgykUl0VwRiNvcY3HKAmMXIt52fULpLtQlHkyAZwqPRKEinl86KEExL9UkfLoGyiy
	2BLGrHp/Kr597ahHLR1cmHpNr423bLF+ouiiJNMAb3IN7J7xJ8ash9vxmCFxE/QtJQqVbfPCLb/3f
	S6JT0BW8kUKr0gIIg0TkHOjPme2Q4D01+qtGJ2BvVepHwFZvobehb3z9YRWGF6x64OLMPqACVI7iq
	dKM1BN6beL/6STlZ0kMsBoWVP9z2v1ETtgpylhG8zJ4KSGTrfvjHWMHQyCvZJXM4czHCS2pm8iD1O
	qoeG3PBHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YdU-0002rA-U8; Thu, 04 Feb 2021 07:01:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YdS-0002qH-Li
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:01:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A6044ABD5;
 Thu,  4 Feb 2021 07:01:01 +0000 (UTC)
Subject: Re: [PATCH 06/35] monitor: Create a log() macro.
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-7-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <580ae616-0b40-122a-670b-57558f0ece58@suse.de>
Date: Thu, 4 Feb 2021 08:01:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-7-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_020102_899683_1DDCF82F 
X-CRM114-Status: GOOD (  26.47  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNi8yMSA5OjMyIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gQXMgdGhpcyBpcyBhIGxvbmcgcnVubmluZyBw
cm9ncmFtLCB3ZSBuZWVkIHRvIG1ha2UgdGhlIGxvZyBvdXRwdXQKPiBjb25maWd1cmFibGUuIEZp
cnN0IHN0ZXA6IHJlcGxhY2UgZnByaW50ZigpIGJ5IGxvZygpLiBUaGUgbG9nIGxldmVsCj4gYW5k
IHByaW50aW5nIG9mIHRpbWUgc3RhbXBzIGNhbiBiZSBjb25maWd1cmVkIGF0IHJ1biB0aW1lIHVz
aW5nCj4gZ2xvYmFsIHZhcmlhYmxlcy4gVGhlc2Ugd2lsbCBsaXZlIGluIGZhYnJpY3MuYy4KPiAK
PiBBbGxvdyB0b2dnbGluZyBmdW5jdGlvbiBuYW1lIHByaW50aW5nIGF0IGJ1aWxkIHRpbWUuCj4g
UHJpbnRpbmcgdGhlIGZ1bmN0aW9uIG5hbWUgaXMgdXNlZnVsIGZvciBkZXZlbG9wbWVudCwgYnV0
IHBlcmhhcHMKPiBub3QgZGVzaXJlZCBmb3IgcHJvZHVjdGlvbi4KPiBQdXQgJyNkZWZpbmUgTE9H
X0ZVTkNOQU1FJyBiZWZvcmUgJyNpbmNsdWRlICJsb2cuaCInIHRvIHN3aXRjaCBpdCBvbi4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gV2lsY2sgPG13aWxja0BzdXNlLmNvbT4KPiAtLS0KPiAg
IGxvZy5oIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgbG9nLmgKPiAKPiBkaWZmIC0tZ2l0IGEvbG9nLmggYi9sb2cuaAo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0Cj4gaW5kZXggMDAwMDAwMC4uMjAxNzczMQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9s
b2cuaAo+IEBAIC0wLDAgKzEsNDQgQEAKPiArI2lmbmRlZiBfTE9HX0gKPiArI2RlZmluZSBfTE9H
X0gKPiArCj4gKyNpZm5kZWYgTUFYX0xPR0xFVkVMCj4gKyMgIGRlZmluZSBNQVhfTE9HTEVWRUwg
TE9HX0RFQlVHCj4gKyNlbmRpZgo+ICsjaWZuZGVmIERFRkFVTFRfTE9HTEVWRUwKPiArIyAgZGVm
aW5lIERFRkFVTFRfTE9HTEVWRUwgTE9HX05PVElDRQo+ICsjZW5kaWYKPiArCj4gKyNpZmRlZiBM
T0dfRlVOQ05BTUUKPiArI2RlZmluZSBfZnVuY19mbXQgIiVzOiAiCj4gKyNkZWZpbmUgX2Z1bmNf
YXJnIF9fZnVuY19fCj4gKyNlbHNlCj4gKyNkZWZpbmUgX2Z1bmNfZm10ICIlcyIKPiArI2RlZmlu
ZSBfZnVuY19hcmcgIiIKPiArI2VuZGlmCj4gKwo+ICtleHRlcm4gaW50IGxvZ19sZXZlbDsKPiAr
ZXh0ZXJuIGJvb2wgbG9nX3RpbWVzdGFtcDsKPiArI2RlZmluZSBfVElNRV9GTVQgIlslbGQuJTA2
bGRdICIKPiArI2RlZmluZSBsb2cobHZsLCBmb3JtYXQsIC4uLikgXAo+ICsJZG8gewkJCQkJCQkJ
XAo+ICsJCWludCBfX2x2bCA9IChsdmwpOwkJCQkJXAo+ICsJCQkJCQkJCQlcCj4gKwkJaWYgKF9f
bHZsIDw9IE1BWF9MT0dMRVZFTCAmJiBfX2x2bCA8PSBsb2dfbGV2ZWwpIHsJXAo+ICsJCQlpZiAo
bG9nX3RpbWVzdGFtcCkgewkJCQlcCj4gKwkJCQlzdHJ1Y3QgdGltZXNwZWMgX190czsJCQlcCj4g
KwkJCQkJCQkJCVwKPiArCQkJCWNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmX190cyk7
CVwKPiArCQkJCWZwcmludGYoc3RkZXJyLAkJCQlcCj4gKwkJCQkJX1RJTUVfRk1UIF9mdW5jX2Zt
dCBmb3JtYXQsCVwKPiArCQkJCQlfX3RzLnR2X3NlYywgX190cy50dl9uc2VjIC8gMTAwMCxcCj4g
KwkJCQkJX2Z1bmNfYXJnLAkJCVwKPiArCQkJCQkjI19fVkFfQVJHU19fKTsJCQlcCj4gKwkJCX0g
ZWxzZSB7CQkJCQlcCj4gKwkJCQlmcHJpbnRmKHN0ZGVyciwgX2Z1bmNfZm10IGZvcm1hdCwJXAo+
ICsJCQkJCV9mdW5jX2FyZywJCQlcCj4gKwkJCQkJIyNfX1ZBX0FSR1NfXyk7CQkJXAo+ICsJCQl9
OwkJCQkJCVwKPiArCQl9CQkJCQkJCVwKPiArCX0gd2hpbGUgKDApCj4gKwo+ICsjZW5kaWYgLyog
X0xPR19IICovCj4gClVyZ2guIExvbmcgbWFjcm9zIGFyZSBhbHdheXMgaG9ycmlibGUuCkNhbid0
IHlvdSBjb252ZXJ0IGl0IGludG8gYSBmdW5jdGlvbj8KCkl0IG1pZ2h0IGFsc28gYmUgYW4gaWRl
YSB0byBtb3ZlIHRoaXMgYXMgdGhlIGZpcnN0IGZ1bmN0aW9uLCBhcyBpdCdzCmFyZ3VhYmx5IGFu
IGV4dGVuc2lvbiB0byBleGlzdGluZyBmdW5jdGlvbmFsaXR5LCBhbmQgbm90IGRpcmVjdGx5IApy
ZWxhdGVkIHRvIHRoZSBtb25pdG9yLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2Uu
ZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNv
ZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJC
IDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJm
ZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
