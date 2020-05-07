Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2319C38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 11:04:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2C220736
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 11:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L7BvB8Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2C220736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dXJTXcnxJn//k+wHuq5/UsphwFwUjlJeFfSWuCD5QwM=; b=L7BvB8Q4o1DYUlXQwrnGfzmEJ
	c6wCErD2tETyKg89CmbnJ27jJ8hBX/dOK77pUGJ8/rLYPKggENSI74F6XpdZemD/nFtqV6w+106HW
	I2Wpswtkg7GPNuwkAql07+BvSVCJW3MbwR71+qesYUDUNvg7VWdbJJvHc7gdVzG/eUqw7pozJwCgY
	pFKnFCcfX8s88Xg/96MyZpcotF+awqocniKme86n2FjVo2bebwe01gVeGU9qseEU3d5How0U4hoJa
	fTzcmk8EBxBoxZSEIcD3eRLdY/8jQT1W3xMi0MKLwhFYzhA9ulXsCAbEqXvC9EO+g1fLU6bc0S+SD
	uwmtYGtAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWeKA-00005M-Mx; Thu, 07 May 2020 11:04:18 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWeK7-00004r-Ol
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 11:04:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F247D1FB;
 Thu,  7 May 2020 04:04:11 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50023F68F;
 Thu,  7 May 2020 04:04:10 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
 <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
 <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
Date: Thu, 7 May 2020 12:04:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_040415_846949_989937D7 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Alexey Dobriyan <adobriyan@gmail.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC0wNS0wNyA5OjE4IGFtLCBKb2huIEdhcnJ5IHdyb3RlOgo+IE9uIDA2LzA1LzIwMjAg
MTg6MDIsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+Cj4+Pgo+Pj4gLi4ud2hpY2ggaXMgYSBiaXQgb2Yg
YW4gYWNoaWV2ZW1lbnQgd2l0aCB0aGUgRE1BIEFQSSwgYnV0IG1vc3QgbGlrZWx5IAo+Pj4gaW1w
bGllcyB0aGF0IGEgcHJpb3IgZG1hX3VubWFwIHdhcyBjYWxsZWQgd2l0aCB0aGUgd3Jvbmcgc2l6
ZSwgc3VjaCAKPj4+IHRoYXQgd2Ugb25seSB1bm1hcHBlZCBwYXJ0IG9mIHRoZSBJT1ZBIHJlZ2lv
biB0aGF0IGhhcyBub3cgYmVlbiByZXVzZWQuCj4gCj4gCj4gU28gSSBxdWlja2x5IGNhcHR1cmVk
IHRoaXMsIGFuZCBJIGNhbiBsb29rIGZ1cnRoZXIgd2hlbiBJIGdldCBhY2Nlc3MgdG8gCj4gdGhl
IEhXIGFnYWluIGxhdGVyIHRvZGF5OgpbLi4uXQo+IFvCoCAxNzcuMTMyODEwXSBETUEtQVBJOiBu
dm1lIDAwMDA6ODU6MDAuMDogZGV2aWNlIGRyaXZlciB0cmllcyB0byBmcmVlIAo+IERNQSBtZW1v
cgo+IHkgaXQgaGFzIG5vdCBhbGxvY2F0ZWQgW2RldmljZSBhZGRyZXNzPTB4MDAwMDAwMDBlZjM3
MTAwMF0gW3NpemU9NDA5NiAKPiBieXRlc10KWy4uLl0KPiBbwqAgMTc3LjI3NjMyMl3CoCBkZWJ1
Z19kbWFfdW5tYXBfcGFnZSsweDZjLzB4NzgKPiBbwqAgMTc3LjI4MDQ4N13CoCBudm1lX3VubWFw
X2RhdGErMHg3Yy8weDIzYwo+IFvCoCAxNzcuMjg0MzA1XcKgIG52bWVfcGNpX2NvbXBsZXRlX3Jx
KzB4MjgvMHg1OAoKT0ssIHNvIHRoZXJlJ3MgY2xlYXJseSBzb21ldGhpbmcgYW1pc3MgdGhlcmUu
IEkgd291bGQgaGF2ZSBzdWdnZXN0ZWQgCm5leHQgc3RpY2tpbmcgdGhlIFNNTVUgaW4gcGFzc3Ro
cm91Z2ggdG8gaGVscCBmb2N1cyBvbiB0aGUgRE1BIEFQSSAKZGVidWdnaW5nLCBidXQgc2luY2Ug
dGhhdCAiRE1BIGFkZHJlc3MiIGxvb2tzIHN1c3BpY2lvdXNseSBsaWtlIGEgCnBoeXNpY2FsIGFk
ZHJlc3MgcmF0aGVyIHRoYW4gYW4gSU9WQSwgSSBzdXNwZWN0IHRoYXQgdGhpbmdzIG1pZ2h0IApz
dWRkZW5seSBhcHBlYXIgdG8gYmUgd29ya2luZyBmaW5lIGlmIHlvdSBkby4uLgoKUm9iaW4uCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
