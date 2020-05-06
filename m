Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99393C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 17:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BF6206B9
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6RFQtrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BF6206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4t47MGnHM2qlsDdT5J4KpPRI31DWcyXCtNXQI4IiIMg=; b=O6RFQtrs/9/XjZ8CRPpPqNMJo
	XYbh30VNCPxVYLCEolmnLPU4Y/UYtDz4l24lXMu6KIxRJoBv3yxcGBVVvTjaF6uCHKRhrOZw8RnIf
	Is3tVaMH1HRyQqKEDsz3kMoBMtRJXjJAtWQXZdwlwWWSAfhMx+fZdn9j7D8wthUGL8yvWPQJNZaAU
	N353DMaNv6waWEGz8r9jmXd2oEkGd0eCdbRc+kLnDP+d6YZaavlAmKajckynJkCgWCG9gDvSl2OPh
	T6327AEG8lwnwkPL46QT6aAU4ieIziHe1gxncE7qwTsBU5pqksU7p8Q4VxjMgwpEIScogEey5tCtl
	uWSTWgZIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWNRu-0001CK-Ln; Wed, 06 May 2020 17:03:10 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWNRs-0001Bd-C3
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 17:03:09 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 101B8272CD872816816A;
 Wed,  6 May 2020 18:03:04 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.169) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 18:03:03 +0100
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
 <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
Date: Wed, 6 May 2020 18:02:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3453193c-424b-1e4c-16be-279088612c68@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.1.169]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_100308_557515_89BC5FDF 
X-CRM114-Status: GOOD (  13.48  )
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

T24gMDYvMDUvMjAyMCAxNzo1MiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDUtMDYg
NTozMSBwbSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+IE9uIFdlZCwgTWF5IDA2LCAyMDIwIGF0IDA1
OjI2OjM1UE0gKzAxMDAsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+PiArIGFybTY0IGd1eXMgKFBsZWFz
ZSBub3RlIFdBUk4gYmVsb3csIGdlbmVyYXRlZCB3aGVuIHRlc3RpbmcgTlZNZSkKPj4+Cj4+PiBP
biAwNi8wNS8yMDIwIDE1OjM1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZTo+IE9uIFdlZCwgTWF5
IDA2LCAyMDIwIGF0Cj4+PiAwMjo0NDo1MFBNICswMTAwLCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4+
PiBJJ2QgcmF0aGVyIGhlYXIgdGhlIG1haW50YWluZXLigJlzIG9waW5pb24gYmVmb3JlIGJvdGhl
cmluZyB0ZXN0aW5nIAo+Pj4+PiB0aGlzLi4uCj4+Pj4KPj4+PiBBcyB0aGUgb3RoZXIgbWFpbnRh
aW5lciAtIHBsZWFzZSBnaXZlIGl0IGEgc3Bpbi4KPj4+Cj4+PiBvaywgc28gSSBoYXZlIHRlc3Rl
ZCB3aXRoIHRoZSBtb2RpZmljYXRpb24gZnJvbSBLZWl0aCAodG8gYXZvaWQgdGhlCj4+PiBSRUFE
X09OQ0UoKSksIGFuZCBpdCdzIG9rIGZvciB1c2VfdGhyZWFkZWRfaW50ZXJydXB0cz0xLgo+Pj4K
Pj4+IEhvd2V2ZXIsIGZvciB1c2VfdGhyZWFkZWRfaW50ZXJydXB0cz0wLCBJIHNlZSBhIG5ldyBp
c3N1ZToKPj4+Cj4+PiBbwqAgMTIyLjUyNDI5MF0gV0FSTklORzogQ1BVOiA4NiBQSUQ6IDExNTcg
YXQKPj4+IGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYzozMDQKPj4KPj4gVGhhdCBtZWFu
cyB5b3UncmUgdHJ5aW5nIHRvIG1hcCBzb21ldGhpbmcgdGhhdCBpcyBhbHJlYWR5IG1hcHBlZC4K
ClRoYW5rcwoKU28gSSBqdXN0IGNvbmZpcm1lZCBpb21tdS5zdHJpY3Q9MCBoYXMgdGhlIHNhbWUg
aXNzdWUsIGFzIGV4cGVjdGVkLgoKPiAKPiAuLi53aGljaCBpcyBhIGJpdCBvZiBhbiBhY2hpZXZl
bWVudCB3aXRoIHRoZSBETUEgQVBJLCBidXQgbW9zdCBsaWtlbHkgCj4gaW1wbGllcyB0aGF0IGEg
cHJpb3IgZG1hX3VubWFwIHdhcyBjYWxsZWQgd2l0aCB0aGUgd3Jvbmcgc2l6ZSwgc3VjaCB0aGF0
IAo+IHdlIG9ubHkgdW5tYXBwZWQgcGFydCBvZiB0aGUgSU9WQSByZWdpb24gdGhhdCBoYXMgbm93
IGJlZW4gcmV1c2VkLgo+IAo+IEpvaG4sIGlmIHlvdSBjYW4gcmVwcm9kdWNlIHRoaXMgc2VtaS1y
ZWxpYWJseSwKClF1aXRlIHJlbGlhYmx5LgoKPiB0cnkgdGhyb3dpbmcgCj4gRE1BX0FQSV9ERUJV
RyBhdCBpdCBpbiB0aGUgZmlyc3QgaW5zdGFuY2UuCj4gCgpvaywgbGV0IG1lIGhhdmUgYSBsb29r
IGF0IHRoYXQuIEJUVywgY291bGQgSSByZXF1ZXN0IGNoYW5naW5nIHRoYXQgV0FSTiAKdG8gdGhl
IHJhdGVsaW1pdGVkIHZhcmlhbnQgOikKCkNoZWVycywKSm9obgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
