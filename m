Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C82C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 01:36:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940492075E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PD9VE2My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940492075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F/I9ljZSo7ZwaNpiXoKZtsN3p/3x1Y7+HZkPbfULeN8=; b=PD9VE2MyAJo8bzRvxbtODSRH1
	lq8jDdaF4XSPD/ffsS9aJeQeGRU9peofWf/SLpPcQuL+JkcRzdA5Dv9jYnekB9sv4UcCyvbiD/X/6
	hc5pR6lEfr2W5VPzJvk81mQsvsalLRZ7CpkPVjYvT3ODe8WBEhHjekXH0FS5lpAwJjMbN9/Eo3NOL
	0au0+3IeNjXjlT2mXffw3+JHEQmOxdu2ce8T5p59rxQ9tcpbeyu6LVda1ImexSd+NVCcB8gvE62tt
	OXUid/m9MTHJXB+MUKbwq+gbXpHK4MS/KecucdeUco7C2ESy5geC/UFoy+ukjRZoZyhROeVJ6ehsl
	//VwZ4X1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8vyY-0007JD-PZ; Fri, 21 Aug 2020 01:36:14 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8vyV-0007IH-P0
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 01:36:13 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 397FD12346B85F17258D;
 Fri, 21 Aug 2020 09:36:03 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Fri, 21 Aug 2020 09:36:02 +0800
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
 <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e84fed3d-1cb6-a548-9917-7d7dd884d0f9@huawei.com>
Date: Fri, 21 Aug 2020 09:36:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_213612_133923_06BBD729 
X-CRM114-Status: GOOD (  19.05  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvMjAgMjM6NDQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+PiBXZSByZWFs
bHkgbmVlZCB0byB0YWtlIGEgc3RlcCBiYWNrIGhlcmUsIEkgcmVhbGx5IGRvbid0IGxpa2UgaG93
Cj4+PiB3ZSBhcmUgZ3Jvd2luZyBpbXBsaWNpdCBhc3N1bXB0aW9ucyBvbiBob3cgc3RhdHVzZXMg
YXJlIGludGVycHJldGVkLgo+Pj4KPj4+IFdoeSBkb24ndCB3ZSByZW1vdmUgdGhlIC1FTk9ERVYg
ZXJyb3IgcHJvcGFnYXRpb24gYmFjayBhbmQgaW5zdGVhZAo+Pj4gdGFrZSBjYXJlIG9mIGl0IGlu
IHRoZSBzcGVjaWZpYyBjYWxsLXNpdGVzIHdoZXJlIHdlIHdhbnQgdG8gaWdub3JlCj4+PiBlcnJv
cnMgd2l0aCBwcm9wZXIgcXVpcmtzPwo+Pgo+PiBTbyB0aGUgb25lIHRoaW5nIEknbSBub3QgZXZl
biBzdXJlIGFib3V0IGlzIGlmIGp1c3QgaWdub3JpbmcgdGhlCj4+IGVycm9ycyB3YXMgYSBnb29k
IGlkZWEgdG8gc3RhcnQgd2l0aC7CoCBUaGV5IG9idmlvdXNseSBhcmUgaWYgd2UganVzdAo+PiBk
aWQgYSByZXNjYW4gYW5kIGRpZCBydW4gaW50byBhbiBlcnJvciB3aGlsZSByZXNjYW5uaW5nIGEg
bmFtZXNwYWNlCj4+IHRoYXQgZGlkbid0IGNoYW5nZS7CoCBCdXQgd2hhdCBpZiBpdCBhY3R1YWxs
eSBkaWQgY2hhbmdlPwo+IAo+IFJpZ2h0LCB3ZSBkb24ndCBrbm93LCBzbyBpZiB3ZSBmYWlsZWQg
d2l0aG91dCBETlIsIHdlIGFzc3VtZSB0aGF0Cj4gd2Ugd2lsbCByZXRyeSBhZ2FpbiBhbmQgaWdu
b3JlIHRoZSBlcnJvci4gVGhlIGFzc3VtcHRpb24gaXMgdGhhdAo+IHdlIHdpbGwgcmV0cnkgd2hl
biB3ZSB3aWxsIHJlY29ubmVjdCBhcyB3ZSBkb24ndCBoYXZlIGEgcmV0cnkgbWVjaGFuaXNtCj4g
Zm9yIHRoZXNlIHJlcXVlc3RzLgpFeGNlcHQgRE5SIG9yIEVOT0RFViwgd2UgY2FuIG5vdCBrbm93
IG5hbWVzcGFjZSBjaGFuZ2Ugb3Igbm90LiBUaGlzIGlzCmEgbG93LXByb2JhYmlsaXR5IGV2ZW50
LiBJbiBhY2NvcmRhbmNlIHdpdGggdGhlIHByaW5jaXBsZSBvZiBtaW5vcgppbmZsdWVuY2UgYW5k
IG5vIHN1c3BpY2lvbiwgd2UgYXNzdW1lIG5hbWVzcGFjZSBub3QgY2hhbmdlLCBtYXliZQphIGdv
b2QgY2hvaWNlLiBJZiB0aGUgbmFtZXNwYWNlIGlzIGNoYW5nZWQsIHRoZSBjb3JyZXNwb25kaW5n
IHByb2Nlc3NpbmcKaXMgcGVyZm9ybWVkIGR1cmluZyB0aGUgYWNjZXNzLCB3aGljaCBkb2VzIG5v
dCBjYXVzZSBhbnkgcHJvYmxlbS4KPiAKPj4gU28gSSB0aGluayBhIGxvZ2ljIGxpa2UgaW4gdGhp
cyBwYXRjaCBraW5kYSBtYWtlcyBzZW5zZSwgYnV0IEkgdGhpbmsKPj4gd2UgYWxzbyBuZWVkIHRv
IHJldHJ5IGFuZCBzY2FuIGFnYWluIG9uIHRoZXNlIGtpbmRzIG9mIGVycm9ycy4KPiAKPiBTbyB5
b3UgYXJlIE9LIHdpdGgga2VlcGluZyBudm1lX3N1Ym1pdF9zeW5jX2NtZCByZXR1cm5pbmcgLUVO
T0RFViBmb3IKPiBjYW5jZWxsZWQgcmVxdWVzdHMgYW5kIGhhdmUgdGhlIHNjYW4gZmxvdyBhc3N1
bWUgdGhhdCB0aGVzZSBhcmUKPiBjYW5jZWxsZWQgcmVxdWVzdHM/Cj4gCj4gQXQgdGhlIHZlcnkg
bGVhc3Qgd2UgbmVlZCBhIGdvb2QgY29tbWVudCB0byBzYXkgd2hhdCBpcyBnb2luZyBvbiB0aGVy
ZS4KPiAKPiAgwqAgQnR3LAo+PiBkaWQgeW91IGV2ZXIgYWN0dWFsbHkgc2VlIC1FTk9NRU0gaW4g
cHJhY3RpY2U/wqAgV2l0aCB0aGUgc21hbGwKPj4gYWxsb2NhdGlvbnMgdGhhdCB3ZSBkbyBpdCBy
ZWFsbHkgc2hvdWxkIG5vdCBoYXBwZW4gbm9ybWFsbHksIHNvCj4+IHNwZWNpYWwgY2FzaW5nIGZv
ciBpdCBhbHdheXMgZmVsdCBhIGxpdHRsZSBzdHJhbmdlLgpBZ3JlZS4KTm90IG9ubHkgRU5PTUVN
LCBJZiB3ZSBkbyBub3Qga25vdyBuYW1lc3BhY2UgY2hhbmdlIG9yIG5vdCwgYXNzdW1lCm5hbWVz
cGFjZSBub3QgY2hhbmdlIG1heWJlIGEgZ29vZCBjaG9pY2UuCj4gCj4gTmV2ZXIgc2VlbiBpdCwg
aXQncyB0aGVyZSBqdXN0IGJlY2F1c2Ugd2UgaGF2ZSBhbGxvY2F0aW9ucyBpbiB0aGUgcGF0aC4K
PiAKPj4gRllJLCBJJ3ZlIHN0YXJ0ZWQgcmViYXNpbmcgdmFyaW91cyBiaXRzIG9mIHdvcmsgSSd2
ZSBkb25lIHRvIHN0YXJ0Cj4+IHVudGFuZ2xpbmcgdGhlIG1lc3MuwqAgSGVyZSBpcyBteSBjdXJy
ZW50IFdJUCwgd2hpY2ggaW4gdGhpcyBmb3JtCj4+IGlzIGNvbXBsZXRlbHkgdW50ZXN0ZWQ6Cj4+
Cj4+IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQvc2hvcnRsb2cv
cmVmcy9oZWFkcy9udm1lLXNjYW5uaW5nLWNsZWFudXAKPiAKPiBUaGlzIGRvZXMgbm90IHlldCBj
b250YWluIHNvcnRpbmcgb3V0IHdoYXQgaXMgZGlzY3Vzc2VkIGhlcmUgY29ycmVjdD8KPiAuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
