Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E7FC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 10:07:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3862E2223C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 10:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tIuTnUmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3862E2223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uCTfrAENWRLKk4C0xCIFKD7FNUVnCbx9zWplTckBF2c=; b=tIuTnUmYwBtX6PbSdVdGvxys6
	QXkGrIUM3m8r63Daj6FDGc5G6KuU9qe+NAIxSNLWcznoHH4HzLhO3qhiWYOAzXMhKITok8h/lu8Rx
	oE6z4vcK+BzGCeezG39br9XrXVKpvQDaz7UqTw3qeC77AjjBczKtQkjOlK+YKDtm5KQC8K5OH41e0
	pAaSdALvnuok6wm3tivX7U2GYJKSqR5+EOGZxyP+1skYDrOGpq7DbkD+uCdxgFFmWVcs34Ts8Zq5/
	tLo+apMk+5hBO3cC/IQEnGuGTonPhbUE9Pey6+PqxBL4L8IrEfCdAJ9KfY8FMx8TsJw6bl5jidLzO
	L9pcQ/Hcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUS4x-0001WB-9S; Mon, 19 Oct 2020 10:07:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUS4v-0001VJ-Cd
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 10:07:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 47E9BAC23
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 10:07:44 +0000 (UTC)
Subject: Re: [PATCH] nvme-fc: shorten reconnect delay if possible for FC
To: linux-nvme@lists.infradead.org
References: <20201016212928.49429-1-james.smart@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c59178ea-da88-3d07-3e16-c6e15b5e2028@suse.de>
Date: Mon, 19 Oct 2020 12:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016212928.49429-1-james.smart@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_060745_567687_EA08C2C0 
X-CRM114-Status: GOOD (  21.36  )
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

T24gMTAvMTYvMjAgMTE6MjkgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IFdlJ3ZlIGhhZCBzZXZl
cmFsIGNvbXBsYWludHMgYWJvdXQgYSAxMHMgcmVjb25uZWN0IGRlbGF5ICh0aGUgZGVmYXVsdCkK
PiB3aGVuIHRoZXJlIHdhcyBhbiBlcnJvciB3aGlsZSB0aGVyZSBpcyBjb25uZWN0aXZpdHkgdG8g
YSBzdWJzeXN0ZW0uCj4gVGhlIG1heF9yZWNvbm5lY3RzIGFuZCByZWNvbm5lY3RfZGVsYXkgYXJl
IHNldCBpbiBjb21tb24gY29kZSBwcmlvciB0bwo+IGNhbGxpbmcgdGhlIHRyYW5zcG9ydCB0byBj
cmVhdGUgdGhlIGNvbnRyb2xsZXIuCj4gCj4gVGhpcyBjaGFuZ2UgY2hlY2tzIGlmIHRoZSBkZWZh
dWx0IHJlY29ubmVjdCBkZWxheSBpcyBiZWluZyB1c2VkLCBhbmQgaWYKPiBzbywgaXQgYWRqdXN0
cyBpdCB0byBhIHNob3J0ZXIgcGVyaW9kICgycykgZm9yIHRoZSBudm1lLWZjIHRyYW5zcG9ydC4K
PiBJdCBkb2VzIHNvIGJ5IGNhbGN1bGF0aW5nIHRoZSBjb250cm9sbGVyIGxvc3MgdG1vIHdpbmRv
dywgY2hhbmdpbmcgdGhlCj4gdmFsdWUgb2YgdGhlIHJlY29ubmVjdCBkZWxheSwgYW5kIHRoZW4g
cmVjYWxjdWxhdGluZyB0aGUgbWF4aW11bSBudW1iZXIKPiBvZiByZWNvbm5lY3QgYXR0ZW1wdHMg
YWxsb3dlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8amFtZXMuc21hcnRAYnJv
YWRjb20uY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvZmMuYyB8IDE5ICsrKysrKysr
KysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZQoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
