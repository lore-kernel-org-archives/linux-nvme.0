Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C84C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:49:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5448C60FE7
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5448C60FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=st+6STP49tM4onhvjnmwLqmjKvndw5RNpShnAV0RB/4=; b=ktsDel+AtPoZSc9vSWH9AzUzv
	OSv5om4vYdkCpOVO4X+r04VhIVsJcpUKO/3PA3+KRUmJsXMYs65ZyVq40k6aHKhbDBOVLjEtWAsNq
	ND/t0+bnVKZ8bZQJr4jxRjF/MiHF0xz60G5V8G2RU0KH9uw8Wm8GgliDuTrdZyOvedJ5oF33MMGMZ
	cqDoSWwoKzayvN6twHtWYHBjUhouaem3HgCk2XAI7VMTW4ico73R/51yp+Xh/gOai8zeuFsKspIdD
	AWvlq1KGPWaclMvfnOYd3hkTHv8mWI37+kc5iFbFxCT51ij5zU5Nov0bIhvRZUkXPBHNPI0WKObH5
	8q1CcOXJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liuTW-00HRa5-BY; Tue, 18 May 2021 07:49:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liuTT-00HRZM-9Y
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 07:49:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=hjYyU7M4Ff87MgNKnqgTWnXVnUhrHRLHS/TagESo6gk=; b=UierHxEi0JZ4XRV73ddiN95Uuh
 f1r5slaHM6nbfszEOlXu3XCooc96ay2SwqegLLO9dw3R29rc9o4dj3ghM0df+rwBxnw8xcO/gnRIV
 wTHRkeBDB2qE5JgDO7MhvOzDAEcJheHitqMR1z0VsRzu0is7nW6mo/uByWMo4tHgwliM3/hjJ/RS8
 H4va3Ar555nFD74RiruVBOUD5j12xYHeNRe7wBX9v7pjTbTqEGwMmHPVauGvbaZrAOubQwYKPE+tx
 CPg+09VCVQxh+jCbcIA2Kmw9DGXmDoxhzvHxtK5xdQvGKvboClL7x/c8SeDREboplu/y0chggRCiL
 SHW4+Kvg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liuTQ-00EQep-Bh
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 07:49:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7F91FB17F;
 Tue, 18 May 2021 07:49:02 +0000 (UTC)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de> <20210518070544.GA8521@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <053d4cda-e0dc-8384-faf4-007b17425c5b@suse.de>
Date: Tue, 18 May 2021 09:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210518070544.GA8521@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_004904_571784_2A173570 
X-CRM114-Status: GOOD (  20.39  )
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

T24gNS8xOC8yMSA5OjA1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUdWUsIE1h
eSAxOCwgMjAyMSBhdCAwODo1OTowOUFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
PiBJIGFza2VkIHRoaXMgb24gdjEsIGlzIHRoaXMgb25seSBuZWVkZWQgZm9yIG1wYXRoIGRldmlj
ZXM/Cj4+Cj4+IFllczsgd2UgbmVlZCB0byBzZW5kIHRoZSBLT0JKX0NIQU5HRSBldmVudCBvbiB0
aGUgbXBhdGggZGV2aWNlIGFzIGl0J3Mgbm90Cj4+IGJhY2tlZCBieSBoYXJkd2FyZS4gVGhlIG9u
bHkgbm9uLW11bHRpcGF0aGVkIGRldmljZXMgSSd2ZSBzZWVuIHNvIGZhciBhcmUKPj4gUENJIGRl
dmljZXMgd2hlcmUgZXZlbnRzIGFyZSBnZW5lcmF0ZWQgYnkgdGhlIFBDSSBkZXZpY2UgaXRzZWxm
Lgo+IAo+IFdoaWNoIHJlYWxseSBnb2VzIGJhY2sgdG8gbXkgcmVwZWF0ZWQgcmVxdWVzdCB0byBh
ZGQgYSBjb21tZW50IHRvIHRoZQo+IGNvZGUgdG8gZG9jdW1lbnQgd2h5IHdlIG5lZWQgdGhpcyB1
ZXZlbnQuICBJdCBzdXJlbHkgbG9va3Mgb3V0IG9mIHBsYWNlCj4gYW5kIGl0IHNlZW1zIEhhbm5l
cyBjYW4gdGVsbCBhIHN0b3J5IG9mIHdoeSBpdCBpcyByZXF1aXJlZC4gIEknZCByZWFsbHkKPiBs
aWtlIHRvIHNlZSB0aGF0IHN0b3J5IG5leHQgdG8gdGhlIGNhbGwuCj4gClRoZSBpc3N1ZSBoZXJl
IGlzIHRoYXQgTUQgUkFJRCB3aWxsIGRldGVjdCBhbiBJL08gZmFpbHVyZSBvbmNlIHRoZSBsYXN0
IApwYXRoIGRyb3BzIGFuZCBmYWlsIHRoZSBuYW1lc3BhY2UsIGJ1dCB3aWxsIGNvbnRpbnVlIHRv
IHdvcmsgaW4gZGVncmFkZWQgCm1vZGUuCkJ1dCB1cG9uIHJlY29ubmVjdCB0aGUgbmFtZXNwYWNl
IHdpbGwgc3RheSBmYWlsZWQsIGFuZCBNRCBSQUlEIHdpbGwgCmNvbnRpbnVlIHRvIG9wZXJhdGUg
aW4gZGVncmFkZWQgbW9kZSBldmVuIHRob3VnaCB0aGUgcGF0aCBpdCBhdmFpbGFibGUgCmFnYWlu
LgpBbmQgd2l0aG91dCB0aGlzIHBhdGNoIHRoZXJlIGlzIG5vIHByb2dyYW1tYXRpYyB3YXkgb24g
aG93IE1EIFJBSUQgY291bGQgCnJlLWFzc2VtYmxlIHRoZSBkZWdyYWRlZCBhcnJheSBhcyB0aGVy
ZSBpcyBubyBpbmRpY2F0b3IgdGhhdCB0aGUgCm5hbWVzcGFjZSBpcyB1c2FibGUgYWdhaW4uCgpJ
cyB0aGlzIHRoZSBpbmZvcm1hdGlvbiB5b3UgYXJlIGxvb2tpbmcgZm9yPwoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
