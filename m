Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7FC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:05:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9825F2177B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o+W+ywNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9825F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H0YfB3f3JwhT0IIGUMVou+YLUa7aAk8ujH+9oTNewjI=; b=o+W+ywNL6an1ywPsJe8CmHQIy
	uH6dnttK2DnJnbgVq9jzWEHaRQ8+zZm/LL7snoY4UfYur9vnjyk3B+s+LmwiBR4UTfa3+8RMSgrHW
	Lpn1htWfs/r8mCJhxUBLrod5MZh03S9jsE3pv0dJqgmAPN2znAmFS4SkDnc7nnd3tpuXEXdaacqkE
	5Ak1q4GGhn0A3rZneWwSkf31QXu97WEwmyTTYJRV6pvyUVW+BdU2y8cHs1ianvMlqveeipR+kFkmy
	DC3JmbN7n9McjorG1ptsIy3wo+kw7ip5TpB6QFHntSlxpmlSBQgXGuVwX6vwk/d/MeBhEMSFgHBIQ
	voBgRR4vg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3yJJ-0008BJ-JQ; Fri, 07 Aug 2020 09:05:09 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yJG-00088P-LT
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:05:07 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7D33C9F3918C2CFFF1A8;
 Fri,  7 Aug 2020 17:04:42 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Fri, 7 Aug 2020 17:04:39 +0800
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
 <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
Date: Fri, 7 Aug 2020 17:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_050506_970030_A73220E1 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: Jens Axboe <axboe@kernel.dk>, paulmck@kernel.org,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzcvMjkgMTI6MzksIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4+IER5bmFt
aWNhbGx5IGFsbG9jYXRpbmcgZWFjaCBvbmUgaXMgcG9zc2libGUgYnV0IG5vdCB2ZXJ5IHNjYWxh
YmxlLgo+Pj4+Pgo+Pj4+PiBUaGUgcXVlc3Rpb24gaXMgaWYgdGhlcmUgaXMgc29tZSB3YXksIHdl
IGNhbiBkbyB0aGlzIHdpdGggb24tc3RhY2sKPj4+Pj4gb3IgYSBzaW5nbGUgb24taGVhcCByY3Vf
aGVhZCBvciBlcXVpdmFsZW50IHRoYXQgY2FuIGFjaGlldmUgdGhlIHNhbWUKPj4+Pj4gZWZmZWN0
Lgo+Pj4+Cj4+Pj4gSWYgdGhlIGhjdHggc3RydWN0dXJlcyBhcmUgZ3VhcmFudGVlZCB0byBzdGF5
IHB1dCwgeW91IGNvdWxkIGNvdW50Cj4+Pj4gdGhlbSBhbmQgdGhlbiBkbyBhIHNpbmdsZSBhbGxv
Y2F0aW9uIG9mIGFuIGFycmF5IG9mIHJjdV9oZWFkIHN0cnVjdHVyZXMKPj4+PiAob3Igc29tZSBs
YXJnZXIgc3RydWN0dXJlIGNvbnRhaW5pbmcgYW4gcmN1X2hlYWQgc3RydWN0dXJlLCBpZiBuZWVk
ZWQpLgo+Pj4+IFlvdSBjb3VsZCB0aGVuIHNlcXVlbmNlIHRocm91Z2ggdGhpcyBhcnJheSwgY29u
c3VtaW5nIG9uZSByY3VfaGVhZCBwZXIKPj4+PiBoY3R4IGFzIHlvdSBwcm9jZXNzZWQgaXQuwqAg
T25jZSBhbGwgdGhlIGNhbGxiYWNrcyBoYWQgYmVlbiBpbnZva2VkLAo+Pj4+IGl0IHdvdWxkIGJl
IHNhZmUgdG8gZnJlZSB0aGUgYXJyYXkuCj4+Pj4KPj4+PiBTb3VuZHMgdG9vIHNpbXBsZSwgdGhv
dWdoLsKgIFNvIHdoYXQgYW0gSSBtaXNzaW5nPwo+Pj4KPj4+IFdlIGRvbid0IHdhbnQgaGlnaGVy
LW9yZGVyIGFsbG9jYXRpb25zLi4uCj4+Cj4+IFNvOgo+Pgo+PiDCoMKgICgxKSBXZSBkb24ndCB3
YW50IHRvIGVtYmVkIHRoZSBzdHJ1Y3QgaW4gdGhlIGhjdHggYmVjYXVzZSB3ZSBhbGxvY2F0ZQo+
PiDCoMKgIHNvIG1hbnkgb2YgdGhlbSB0aGF0IHRoaXMgaXMgbm9uLW5lZ2xpZ2FibGUgdG8gYWRk
IGZvciBzb21ldGhpbmcgd2UKPj4gwqDCoCB0eXBpY2FsbHkgbmV2ZXIgdXNlLgo+Pgo+PiDCoMKg
ICgyKSBXZSBkb24ndCB3YW50IHRvIGFsbG9jYXRlIGR5bmFtaWNhbGx5IGJlY2F1c2UgaXQncyBw
b3RlbnRpYWxseQo+PiDCoMKgIGh1Z2UuCj4+Cj4+IEFzIGxvbmcgYXMgd2UncmUgdXNpbmcgc3Jj
dSBmb3IgYmxvY2tpbmcgaGN0eCdzLCBJIHRoaW5rIGl0J3MgInBpY2sgeW91cgo+PiBwb2lzb24i
Lgo+Pgo+PiBBbHRlcm5hdGl2ZWx5LCBNaW5nJ3MgcGVyY3B1X3JlZiBwYXRjaCgqKSBtYXkgYmUg
d29ydGggYSBsb29rLgo+Pgo+PiDCoCAqIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xp
bnV4LWJsb2NrL21zZzU2OTc2Lmh0bWwxCj4gSSdtIG5vdCBvcHBvc2VkIHRvIGhhdmluZyB0aGlz
LiBXaWxsIHJlcXVpcmUgc29tZSBtb3JlIHRlc3RpbmcKPiBhcyB0aGlzIGFmZmVjdHMgcHJldHR5
IG11Y2ggZXZlcnkgZHJpdmVyIG91dCB0aGVyZS4uCj4gCj4gSWYgd2UgYXJlIGdvaW5nIHdpdGgg
YSBsaWdodHdlaWdodCBwZXJjcHVfcmVmLCBjYW4gd2UganVzdCBkbwo+IGl0IGFsc28gZm9yIG5v
bi1ibG9ja2luZyBoY3R4IGFuZCBoYXZlIGEgc2luZ2xlIGNvZGUtcGF0aD8KPiAuCkkgdHJpZWQg
dG8gb3B0aW1pemUgdGhlIHBhdGNo77yMc3VwcG9ydCBmb3Igbm9uIGJsb2NraW5nIHF1ZXVlIGFu
ZApibG9ja2luZyBxdWV1ZS4KU2VlIG5leHQgZW1haWwuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
