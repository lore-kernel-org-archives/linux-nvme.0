Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E95C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:14:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D30864E27
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D30864E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u/lkNXlpHUNrgM8FbUw52eKcJqAs+y9Krgf4og/XAf4=; b=oYKa3vl/0gM02syqgEJtwDcNZ
	v8c+mdjZUzPoJd7YSHckgVJ+/QcdwKY0IKixBEp0qi8dNkTkhmFk3G6IHw9iF5OzX4QflY+jDACQA
	VfCl6AP221ki1ag8ZbxiM0S1ruShEjC5WiDjsl2O0IlRgl8JGVAh/iUkm1yKZJbIaAgzLI2Yddk9G
	EZkFOgUD7YmFAnF6faxhU2WvDMlUP3ZHY3yw7nT+by9SxBTxpM0uPGIvRm7sQvcEqsqhSCmicLwOA
	US6QPAhPZR0RUE2bbEI6xaWXfaQb6iTOkiMa7k+bFP3U4ysZgvsrHYwmh/8HqS43vEgfPNFc6EL9y
	c/rkCrIYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YqK-0005Q1-5f; Thu, 04 Feb 2021 07:14:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YqH-0005PS-TI
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:14:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D6432AC97;
 Thu,  4 Feb 2021 07:14:16 +0000 (UTC)
Subject: Re: [PATCH 12/35] monitor: add helpers for __attribute__((cleanup))
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-13-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <66d73520-5022-9d6b-a27e-4da02c42ea94@suse.de>
Date: Thu, 4 Feb 2021 08:14:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-13-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_021418_070157_76E4381F 
X-CRM114-Status: GOOD (  22.61  )
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

T24gMS8yNi8yMSA5OjMzIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gX19hdHRyaWJ1dGVfXygoY2xlYW51cCkpIGlz
IHZlcnkgaGVscGZ1bCBidXQgdWdseS4gVHJ5IHRvIGF2b2lkCj4gZGVmaW5pbmcgbG90cyBvZiBj
bGVhbnVwIGZ1bmN0aW9ucyB3aXRoIHRoZXNlIG1hY3Jvcy4KPiAKPiBVc2FnZTogdG8gZGVjbGFy
ZSBhbiBhdXRvLWNsZWFudXAgdmFyaWFibGUgb2YgdHlwZSAoc29tZV90eXBlICopLAo+IHdyaXRl
Cj4gCj4gQ0xFQU5VUF9GVU5DKHNvbWVfdHlwZSkKPiAKPiB2b2lkIHNvbWVfZnVuYyh2b2lkKQo+
IHsKPiAgICAgICAgICBDTEVBTlVQKHNvbWVfdHlwZSwgdmFybmFtZSkgPSBOVUxMOwo+IAkuLi4K
PiB9Cj4gCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4g
LS0tCj4gICBjb21tb24uaCB8IDEyICsrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvY29tbW9uLmggYi9jb21tb24uaAo+IGlu
ZGV4IDFjMjE0YTQuLjkzODZlYzUgMTAwNjQ0Cj4gLS0tIGEvY29tbW9uLmgKPiArKysgYi9jb21t
b24uaAo+IEBAIC0xMiw0ICsxMiwxNiBAQAo+ICAgI2RlZmluZSBfX3N0cmluZ2lmeV8xKHguLi4p
ICN4Cj4gICAjZGVmaW5lIF9fc3RyaW5naWZ5KHguLi4pICBfX3N0cmluZ2lmeV8xKHgpCj4gICAK
PiArI2RlZmluZSBDTEVBTlVQX0ZVTkModHlwZSkgXAo+ICtzdGF0aWMgdm9pZCBfX2NsZWFudXBf
ICMjIHR5cGUgIyNfcCh0eXBlICoqIF9fcCkgXAo+ICt7CQkJCQkJIFwKPiArCWlmICgqX19wKSB7
CQkJCSBcCj4gKwkJZnJlZSgqX19wKTsJCQkgXAo+ICsJCSpfX3AgPSBOVUxMOwkJCSBcCj4gKwl9
CQkJCQkgXAo+ICt9Cj4gKwo+ICsjZGVmaW5lIENMRUFOVVAoX190LCBfX3YpIFwKPiArCV9fdCAq
X192IF9fYXR0cmlidXRlX18oKGNsZWFudXAoX19jbGVhbnVwXyAjIyBfX3QgIyMgX3ApKSkKPiAr
Cj4gICAjZW5kaWYKPiAKQW5kIHRoaXMgaXMgdXNlZCB3aGVyZT8KCkNhbid0IHlvdSBtZXJnZSBp
dCB3aXRoIHRoZSBwYXRjaCB1c2lnIHRoZSBfX2NsZWFudXAgZnVuY3Rpb25hbGl0eT8KCkNoZWVy
cywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwg
U3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVs
ZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jD
pGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
