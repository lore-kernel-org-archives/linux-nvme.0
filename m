Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F672C433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:59:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AEF64ECF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AEF64ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Si9aZAYF9ZPhvijp38Gi2UHLo7A7DqlqKIxkWjxHVEk=; b=Jon97bFOkNlgsOtV5Hru0fOe+
	r44ojd9Q9v2qnVdtYxR0eDS/+qa/7GQXNEf+n0yRvHWSeId7FC2zCjJXVOFPj74b/iah0e7lEL2+/
	PQgVk6s47DipieYYP4KU1c0YGxiGoes45iZdJjVBkxA6Yo6XdnR6p1G6GNDimVY06QPFnkwGJ/CL9
	kfmVzEZjI2fwh2J3SDtyXZWsc8KG+s6P1nstEHX/MLQfcW8fYA1cnldJ/MDpCOMiT9EuvB/FLpLcA
	hEiLCOvh+PzxCg8z4ZmmSfst6MXtjcMuKvX3Pf1NYwOzRq3hGU5sr9TzT33lT38oAzN5WSyFu9nGR
	8vXA/ejDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEp4i-0001zh-Kf; Wed, 24 Feb 2021 07:59:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEp4g-0001z6-FE
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 07:59:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3909AAE57;
 Wed, 24 Feb 2021 07:59:09 +0000 (UTC)
Subject: Re: [PATCH 0/2] nvme: sanitize KATO handling
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20210223120728.104699-1-hare@suse.de>
 <36e3bfd8-0c69-7540-c9f2-fd37070dc107@huawei.com>
 <06e3b90a-719e-9561-5c63-67dac0a782e1@suse.de>
 <1834a11c-c472-e14f-ece3-a96ec2ced044@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <aef64b6f-0e12-1f17-7eda-ec3a9db9cf1e@suse.de>
Date: Wed, 24 Feb 2021 08:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1834a11c-c472-e14f-ece3-a96ec2ced044@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_025910_658892_95F770F8 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNC8yMSA4OjIwIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8yLzI0
IDE1OjA2LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDIvMjQvMjEgNzo0MiBBTSwgQ2hh
byBMZW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIxLzIvMjMgMjA6MDcsIEhhbm5lcyBSZWlu
ZWNrZSB3cm90ZToKPj4+PiBIaSBhbGwsCj4+Pj4KPj4+PiBvbmUgb2Ygb3VyIGN1c3RvbWVyIGhh
ZCBiZWVuIHJ1bm5pbmcgaW50byBhIGRlYWRsb2NrIHRyeWluZyB0byAKPj4+PiB0ZXJtaW5hdGUK
Pj4+PiBvdXRzdGFuZGluZyBLQVRPIGNvbW1hbmRzIGR1cmluZyByZXNldC4KPj4+PiBMb29raW5n
IGNsb3NlciBhdCBpdCwgSSBmb3VuZCB0aGF0IHdlIG5ldmVyIGFjdHVhbGx5IF90cmFja18gaWYg
YSBLQVRPCj4+Pj4gY29tbWFuZCBpcyBzdWJtaXR0ZWQsIHNvIHdlIG1pZ2h0IGhhcHBpbHkgYmUg
c2VuZGluZyBzZXZlcmFsIEtBVE8gCj4+Pj4gY29tbWFuZHMKPj4+PiB0byB0aGUgc2FtZSBjb250
cm9sbGVyIHNpbXVsdGFuZW91c2x5Lgo+Pj4gQ2FuIHlvdSBleHBsYWluIGhvdyBjYW4gc2VuZCBL
QVRPIGNvbW1hbmRzIHNpbXVsdGFuZW91c2x5Pwo+Pgo+PiBTdXJlLgo+PiBDYWxsIG52bWVfc3Rh
cnRfa2VlcF9hbGl2ZSgpIG9uIGEgZGVhZCBjb25uZWN0aW9uLgo+PiBKdXN0IF9hZnRlcl8gdGhl
IEtBVE8gcmVxdWVzdCBoYXMgYmVlbiBzZW50LAo+PiBjYWxsIG52bWVfc3RhcnRfa2VlcF9hbGl2
ZSgpIGFnYWluLgo+IENhbGwgbnZtZV9zdGFydF9rZWVwX2FsaXZlKCkgYWdhaW4/IHdoeT8KPiBO
b3cganVzdCBudm1lX3N0YXJ0X2N0cmwgY2FsbCBudm1lX3N0YXJ0X2tlZXBfYWxpdmUoKS4KPiBU
aGUga2Ffd29yayB3aWxsIGJlIGNhbmNlbGVkIHN5bmMgYmVmb3JlIHN0YXJ0IHJlY29ubmVjdGlv
bi4KPiBEaWQgSSBtaXNzIHNvbWV0aGluZz8KCk15IHBvaW50IHdhcyB0aGF0IHRoZXJlIF9jYW5f
IGJlIGEga2Ffd29yaygpIGVudHJ5IGV2ZW4gd2hlbiBhIEtBVE8gCmNvbW1hbmQgaXMgcnVubmlu
Zy4KCkFuZCB5ZXMsIHRoZSBrYV93b3JrIGVudHJ5IHdpbGwgYmUgY2FuY2VsbGVkLCBidXQgX2Jl
Zm9yZV8gdGhlIApvdXRzdGFuZGluZyBjb21tYW5kcyBhcmUgY2FuY2VsbGVkLgpBbmQgY2FuY2Vs
bGluZyB0aGUga2Ffd29yayBlbnRyeSBtaWdodCBjYXVzZSB0aGUgZnVuY3Rpb24gdG8gYmUgCmV4
ZWN1dGVkLCB3aGljaCBsZWFkcyB0byBhIGRlYWRsb2NrIGlmIGJsa19tcV9nZXRfcmVxdWVzdCgp
IGlzIGJsb2NrZWQKKGVnIGlmIHRoZSBxdWV1ZSBpcyBhbHJlYWR5IHN0b3BwZWQgZHVlIHRvIHJl
Y292ZXJ5KQoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAg
ICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xy
bmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
