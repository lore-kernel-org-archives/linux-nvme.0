Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C1FC28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 16:52:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11780208CA
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPgySiO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11780208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=03TqQqPOaAcuyj/TGdJdO+a0rA1GINm08ZOPsDMzBug=; b=lPgySiO5GhKDBNJhpOFiRLEs2
	ig2SR9RbDMdhrcIY2aVrt+HaJUAGSn3zuLtpdFaQgJ+pEu1QAxIP5YIvt0F5W+7IPLnjZeh/1p0Sd
	y4+aiAfS8ICRMcIDaz4OeC7a7gVl2Ioe81XXdNGrxL48L8+jBw598BjAKse7eFk5jcVrCCM/jRrxR
	4BAQFo2gpWl7PxE4UTU2w1CiKOA18vp7UPUvx6K059VyEjOL/+y/S1gpU5PWlUfx9WBcZWTu+I3tW
	5/3t3gF4FuM9q0rOfPekoBF63c4dwiFiu5XNfexTSHuMthtzRo1B23/BKI58f2HszY/GKvRUw4Zd6
	sami5kcFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWNHL-0001eo-0e; Wed, 06 May 2020 16:52:15 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWNHH-0001e4-Ju
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 16:52:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32E291FB;
 Wed,  6 May 2020 09:52:09 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7CE03F71F;
 Wed,  6 May 2020 09:52:07 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
 <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3453193c-424b-1e4c-16be-279088612c68@arm.com>
Date: Wed, 6 May 2020 17:52:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506163104.GD12919@willie-the-truck>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_095212_556486_EB30788E 
X-CRM114-Status: GOOD (  13.40  )
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

T24gMjAyMC0wNS0wNiA1OjMxIHBtLCBXaWxsIERlYWNvbiB3cm90ZToKPiBPbiBXZWQsIE1heSAw
NiwgMjAyMCBhdCAwNToyNjozNVBNICswMTAwLCBKb2huIEdhcnJ5IHdyb3RlOgo+PiArIGFybTY0
IGd1eXMgKFBsZWFzZSBub3RlIFdBUk4gYmVsb3csIGdlbmVyYXRlZCB3aGVuIHRlc3RpbmcgTlZN
ZSkKPj4KPj4gT24gMDYvMDUvMjAyMCAxNTozNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6PiBP
biBXZWQsIE1heSAwNiwgMjAyMCBhdAo+PiAwMjo0NDo1MFBNICswMTAwLCBKb2huIEdhcnJ5IHdy
b3RlOgo+Pj4+IEknZCByYXRoZXIgaGVhciB0aGUgbWFpbnRhaW5lcuKAmXMgb3BpbmlvbiBiZWZv
cmUgYm90aGVyaW5nIHRlc3RpbmcgdGhpcy4uLgo+Pj4KPj4+IEFzIHRoZSBvdGhlciBtYWludGFp
bmVyIC0gcGxlYXNlIGdpdmUgaXQgYSBzcGluLgo+Pgo+PiBvaywgc28gSSBoYXZlIHRlc3RlZCB3
aXRoIHRoZSBtb2RpZmljYXRpb24gZnJvbSBLZWl0aCAodG8gYXZvaWQgdGhlCj4+IFJFQURfT05D
RSgpKSwgYW5kIGl0J3Mgb2sgZm9yIHVzZV90aHJlYWRlZF9pbnRlcnJ1cHRzPTEuCj4+Cj4+IEhv
d2V2ZXIsIGZvciB1c2VfdGhyZWFkZWRfaW50ZXJydXB0cz0wLCBJIHNlZSBhIG5ldyBpc3N1ZToK
Pj4KPj4gWyAgMTIyLjUyNDI5MF0gV0FSTklORzogQ1BVOiA4NiBQSUQ6IDExNTcgYXQKPj4gZHJp
dmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS5jOjMwNAo+IAo+IFRoYXQgbWVhbnMgeW91J3JlIHRy
eWluZyB0byBtYXAgc29tZXRoaW5nIHRoYXQgaXMgYWxyZWFkeSBtYXBwZWQuCgouLi53aGljaCBp
cyBhIGJpdCBvZiBhbiBhY2hpZXZlbWVudCB3aXRoIHRoZSBETUEgQVBJLCBidXQgbW9zdCBsaWtl
bHkgCmltcGxpZXMgdGhhdCBhIHByaW9yIGRtYV91bm1hcCB3YXMgY2FsbGVkIHdpdGggdGhlIHdy
b25nIHNpemUsIHN1Y2ggdGhhdCAKd2Ugb25seSB1bm1hcHBlZCBwYXJ0IG9mIHRoZSBJT1ZBIHJl
Z2lvbiB0aGF0IGhhcyBub3cgYmVlbiByZXVzZWQuCgpKb2huLCBpZiB5b3UgY2FuIHJlcHJvZHVj
ZSB0aGlzIHNlbWktcmVsaWFibHksIHRyeSB0aHJvd2luZyAKRE1BX0FQSV9ERUJVRyBhdCBpdCBp
biB0aGUgZmlyc3QgaW5zdGFuY2UuCgpSb2Jpbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
