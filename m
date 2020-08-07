Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E9CC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:36:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F856206B5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kyjTLeLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F856206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T5EV/YWm42DpST0ZgNEsoQFI6s7/gt1cLDPhB36fl5E=; b=kyjTLeLND8zjN5Xx8HtTsP2g4
	qpmoenj5jxJ31TyT6ZlosipAsNyXMt/trb9WkBoHD84dd3py+eTf0BktycaP30zI2HY95XvIkCZ/g
	moh/3hsczdiR+zsQBGZzBQoFgEMQRJBtak9OGpGkIwGQUM5l7eytrOOF280KXOCjxFK25diX7lZVS
	A523QNOugOevo3kBCvz4SDydLUAuuNEffeW9XqiPKJL7ehaBPKoJmzbgak0kOHyRCtQSt/K7wMPvX
	WgFqWAfXAMsozEV2E8LbjilHADLKwQe3nvx15V6K5EEJ08L7HcGld5RwKib44vBblIkhGr/2djOmK
	WchXjweuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3ynD-0003LN-1p; Fri, 07 Aug 2020 09:36:03 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3ynA-0003Kx-EZ
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:36:01 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8CA099167016936A645B;
 Fri,  7 Aug 2020 17:35:56 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0;
 Fri, 7 Aug 2020 17:35:55 +0800
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
 <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
 <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
 <20200807092457.GA2112310@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e6b4032e-a5c6-0038-33b8-04a15ae75a0e@huawei.com>
Date: Fri, 7 Aug 2020 17:35:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807092457.GA2112310@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_053600_723029_B5A9758F 
X-CRM114-Status: GOOD (  16.74  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 paulmck@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvNyAxNzoyNCwgTWluZyBMZWkgd3JvdGU6Cj4gT24gRnJpLCBBdWcgMDcsIDIw
MjAgYXQgMDU6MDQ6MzhQTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyMDIw
LzcvMjkgMTI6MzksIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pgo+Pj4+Pj4+IER5bmFtaWNhbGx5
IGFsbG9jYXRpbmcgZWFjaCBvbmUgaXMgcG9zc2libGUgYnV0IG5vdCB2ZXJ5IHNjYWxhYmxlLgo+
Pj4+Pj4+Cj4+Pj4+Pj4gVGhlIHF1ZXN0aW9uIGlzIGlmIHRoZXJlIGlzIHNvbWUgd2F5LCB3ZSBj
YW4gZG8gdGhpcyB3aXRoIG9uLXN0YWNrCj4+Pj4+Pj4gb3IgYSBzaW5nbGUgb24taGVhcCByY3Vf
aGVhZCBvciBlcXVpdmFsZW50IHRoYXQgY2FuIGFjaGlldmUgdGhlIHNhbWUKPj4+Pj4+PiBlZmZl
Y3QuCj4+Pj4+Pgo+Pj4+Pj4gSWYgdGhlIGhjdHggc3RydWN0dXJlcyBhcmUgZ3VhcmFudGVlZCB0
byBzdGF5IHB1dCwgeW91IGNvdWxkIGNvdW50Cj4+Pj4+PiB0aGVtIGFuZCB0aGVuIGRvIGEgc2lu
Z2xlIGFsbG9jYXRpb24gb2YgYW4gYXJyYXkgb2YgcmN1X2hlYWQgc3RydWN0dXJlcwo+Pj4+Pj4g
KG9yIHNvbWUgbGFyZ2VyIHN0cnVjdHVyZSBjb250YWluaW5nIGFuIHJjdV9oZWFkIHN0cnVjdHVy
ZSwgaWYgbmVlZGVkKS4KPj4+Pj4+IFlvdSBjb3VsZCB0aGVuIHNlcXVlbmNlIHRocm91Z2ggdGhp
cyBhcnJheSwgY29uc3VtaW5nIG9uZSByY3VfaGVhZCBwZXIKPj4+Pj4+IGhjdHggYXMgeW91IHBy
b2Nlc3NlZCBpdC7CoCBPbmNlIGFsbCB0aGUgY2FsbGJhY2tzIGhhZCBiZWVuIGludm9rZWQsCj4+
Pj4+PiBpdCB3b3VsZCBiZSBzYWZlIHRvIGZyZWUgdGhlIGFycmF5Lgo+Pj4+Pj4KPj4+Pj4+IFNv
dW5kcyB0b28gc2ltcGxlLCB0aG91Z2guwqAgU28gd2hhdCBhbSBJIG1pc3Npbmc/Cj4+Pj4+Cj4+
Pj4+IFdlIGRvbid0IHdhbnQgaGlnaGVyLW9yZGVyIGFsbG9jYXRpb25zLi4uCj4+Pj4KPj4+PiBT
bzoKPj4+Pgo+Pj4+ICDCoMKgICgxKSBXZSBkb24ndCB3YW50IHRvIGVtYmVkIHRoZSBzdHJ1Y3Qg
aW4gdGhlIGhjdHggYmVjYXVzZSB3ZSBhbGxvY2F0ZQo+Pj4+ICDCoMKgIHNvIG1hbnkgb2YgdGhl
bSB0aGF0IHRoaXMgaXMgbm9uLW5lZ2xpZ2FibGUgdG8gYWRkIGZvciBzb21ldGhpbmcgd2UKPj4+
PiAgwqDCoCB0eXBpY2FsbHkgbmV2ZXIgdXNlLgo+Pj4+Cj4+Pj4gIMKgwqAgKDIpIFdlIGRvbid0
IHdhbnQgdG8gYWxsb2NhdGUgZHluYW1pY2FsbHkgYmVjYXVzZSBpdCdzIHBvdGVudGlhbGx5Cj4+
Pj4gIMKgwqAgaHVnZS4KPj4+Pgo+Pj4+IEFzIGxvbmcgYXMgd2UncmUgdXNpbmcgc3JjdSBmb3Ig
YmxvY2tpbmcgaGN0eCdzLCBJIHRoaW5rIGl0J3MgInBpY2sgeW91cgo+Pj4+IHBvaXNvbiIuCj4+
Pj4KPj4+PiBBbHRlcm5hdGl2ZWx5LCBNaW5nJ3MgcGVyY3B1X3JlZiBwYXRjaCgqKSBtYXkgYmUg
d29ydGggYSBsb29rLgo+Pj4+Cj4+Pj4gIMKgICogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlz
dHMvbGludXgtYmxvY2svbXNnNTY5NzYuaHRtbDEKPj4+IEknbSBub3Qgb3Bwb3NlZCB0byBoYXZp
bmcgdGhpcy4gV2lsbCByZXF1aXJlIHNvbWUgbW9yZSB0ZXN0aW5nCj4+PiBhcyB0aGlzIGFmZmVj
dHMgcHJldHR5IG11Y2ggZXZlcnkgZHJpdmVyIG91dCB0aGVyZS4uCj4+Pgo+Pj4gSWYgd2UgYXJl
IGdvaW5nIHdpdGggYSBsaWdodHdlaWdodCBwZXJjcHVfcmVmLCBjYW4gd2UganVzdCBkbwo+Pj4g
aXQgYWxzbyBmb3Igbm9uLWJsb2NraW5nIGhjdHggYW5kIGhhdmUgYSBzaW5nbGUgY29kZS1wYXRo
Pwo+Pj4gLgo+PiBJIHRyaWVkIHRvIG9wdGltaXplIHRoZSBwYXRjaO+8jHN1cHBvcnQgZm9yIG5v
biBibG9ja2luZyBxdWV1ZSBhbmQKPj4gYmxvY2tpbmcgcXVldWUuCj4+IFNlZSBuZXh0IGVtYWls
Lgo+IAo+IFBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZyB0aHJlYWQ6Cj4gCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtYmxvY2svMDVmNzVlODktYjZmNy1kZTQ5LWViOWYtYTA4YWE0ZTBi
YTRmQGtlcm5lbC5kay8KPiAKPiBCb3RoIEtlaXRoIGFuZCBKZW5zIGRpZG4ndCB0aGluayBpdCBp
cyBhIGdvb2QgaWRlYS4KSWYgd2UgY2FuIHN1cHBvcnQgbm9uYmxvY2tpbmcgcXVldWUgYW5kIGJs
b2NraW5nIHF1ZXVlIHNpbXBsZWx5LCB0aGlzIG1heSBiZSBhIGdvb2QgY2hvaWNlLgpQbGVhc2Ug
cmV2aWV3IHRoZSBwYXRjaCBmaXJzdC4KPiAKPiAKPiAKPiBUaGFua3MsCj4gTWluZwo+IAo+IC4K
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
