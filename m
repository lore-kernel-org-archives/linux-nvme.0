Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C25C38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 16:27:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF192083B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MvTFE/ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF192083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pi0uHAimSHpotAMMXls92ihwh5Jfw4G5Cy7Jyd7fZFQ=; b=MvTFE/owwMQSVJKaQO9bwGYGZ
	RaEv3Crv4eORYIDAYufCwHV2BNiYM609E2A+Anedi5bcpBZzhFqo+3T88dMj5eILQFlvCTb51Gn+k
	Pu1qWVfYQDUnhCoD0FAkgRTXq4ZGMtvHgeKM0HdVGw1udUjHeScwALyvz3ikmd/Ml6T4I5p2UP5EL
	byb/G4SSTOm+EJv1DW7I5ORcpesGOnbNwcHr7PvUct2UfKewckMGQ7cm3tefob9Xj6z8SSbKIwZBa
	VruymaQPnqZfHCcR4fKPj6Br0/k4dlsHBvHmvqDL10Bi4vBk9ugEaOx24c/DqGuj7sC9ZGHegFmoi
	B7JPF6Txw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWjMW-0004A7-GT; Thu, 07 May 2020 16:27:04 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWjMU-00049G-1s
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 16:27:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AC011FB;
 Thu,  7 May 2020 09:27:01 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14243F71F;
 Thu,  7 May 2020 09:26:59 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: Keith Busch <kbusch@kernel.org>, John Garry <john.garry@huawei.com>
References: <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
 <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
 <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
 <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
 <20200507142352.GA2621422@dhcp-10-100-145-180.wdl.wdc.com>
 <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
 <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9e04eebc-a55b-ac7e-3cb3-9c65f084ee6c@arm.com>
Date: Thu, 7 May 2020 17:26:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_092702_186940_BD8FA7CE 
X-CRM114-Status: GOOD (  19.42  )
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
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC0wNS0wNyA0OjM1IHBtLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUaHUsIE1heSAw
NywgMjAyMCBhdCAwNDoxMToyM1BNICswMTAwLCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBPbiAwNy8w
NS8yMDIwIDE1OjIzLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+IE9uIFRodSwgTWF5IDA3LCAyMDIw
IGF0IDAyOjU1OjM3UE0gKzAxMDAsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+Pj4gT24gMDcvMDUvMjAy
MCAxMjowNCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+Pj4gW8KgIDE3Ny4xMzI4MTBdIERNQS1B
UEk6IG52bWUgMDAwMDo4NTowMC4wOiBkZXZpY2UgZHJpdmVyIHRyaWVzIHRvCj4+Pj4+PiBmcmVl
IERNQSBtZW1vcgo+Pj4+Pj4geSBpdCBoYXMgbm90IGFsbG9jYXRlZCBbZGV2aWNlIGFkZHJlc3M9
MHgwMDAwMDAwMGVmMzcxMDAwXQo+Pj4+Pj4gW3NpemU9NDA5NiBieXRlc10KPj4+Pj4gWy4uLl0K
Pj4+Pj4+IFvCoCAxNzcuMjc2MzIyXcKgIGRlYnVnX2RtYV91bm1hcF9wYWdlKzB4NmMvMHg3OAo+
Pj4+Pj4gW8KgIDE3Ny4yODA0ODddwqAgbnZtZV91bm1hcF9kYXRhKzB4N2MvMHgyM2MKPj4+Pj4+
IFvCoCAxNzcuMjg0MzA1XcKgIG52bWVfcGNpX2NvbXBsZXRlX3JxKzB4MjgvMHg1OAo+Pj4+Pgo+
Pj4+PiBPSywgc28gdGhlcmUncyBjbGVhcmx5IHNvbWV0aGluZyBhbWlzcyB0aGVyZS4gSSB3b3Vs
ZCBoYXZlIHN1Z2dlc3RlZAo+Pj4+PiBuZXh0IHN0aWNraW5nIHRoZSBTTU1VIGluIHBhc3N0aHJv
dWdoIHRvIGhlbHAgZm9jdXMgb24gdGhlIERNQSBBUEkKPj4+Pj4gZGVidWdnaW5nLCBidXQgc2lu
Y2UgdGhhdCAiRE1BIGFkZHJlc3MiIGxvb2tzIHN1c3BpY2lvdXNseSBsaWtlIGEKPj4+Pj4gcGh5
c2ljYWwgYWRkcmVzcyByYXRoZXIgdGhhbiBhbiBJT1ZBLCBJIHN1c3BlY3QgdGhhdCB0aGluZ3Mg
bWlnaHQKPj4+Pj4gc3VkZGVubHkgYXBwZWFyIHRvIGJlIHdvcmtpbmcgZmluZSBpZiB5b3UgZG8u
Li4KPj4+Pgo+Pj4+IE9LLCBzZWVtcyBzZW5zaWJsZS4gSG93ZXZlciBpdCBsb29rcyBsaWtlIHRo
aXMgZ3V5IHRyaWdnZXJzIHRoZSBpc3N1ZToKPj4+Pgo+Pj4+IDMyNGI0OTRjMjg2MiBudm1lLXBj
aTogUmVtb3ZlIHR3by1wYXNzIGNvbXBsZXRpb25zCj4+Pj4KPj4+PiBXaXRoIGNhcnJ5aW5nIHRo
ZSByZXZlcnQgb2YgJHN1YmplY3QsIGl0J3MgYSBxdWljayBiaXNlY3QgdG8gdGhhdCBwYXRjaC4K
Pj4+Cj4+PiBUaGF0J3Mgd2VpcmQuCj4+Cj4+IE9yIG1heWJlIGV4YWNlcmJhdGluZyBzb21lIG90
aGVyIGZhdWx0Pwo+Pgo+PiAgIERvIHlvdSBzZWUgdGhpcyB3aXRoIGRpZmZlcmVudCBudm1lIGNv
bnRyb2xsZXJzPwo+Pgo+PiBJIG9ubHkgaGF2ZSAzeCwgYW5kIHRoZXkgYXJlIGFsbCBFUzMwMDAg
VjMgTlZNZSBQQ0llIFNTRAo+Pgo+Pj4gRG9lcyB5b3VyCj4+PiBjb250cm9sbGVyIHdyaXRlIHRo
ZSBwaGFzZSBiaXQgYmVmb3JlIHdyaXRpbmcgdGhlIGNvbW1hbmQgaWQgaW4gdGhlIGNxZT8KPj4K
Pj4gSSBkb24ndCBrbm93LiBJcyB0aGF0IHNvcnQgb2YgaW5mbyBhdmFpbGFibGUgZnJvbSBudm1l
LWNsaT8KPiAKPiBObywgdGhlIG9ubHkgd2F5IHRvIDEwMCUgY29uZmlybSBpcyB3aXRoIGJ1cyBw
cm90b2NvbCBhbmFseXplcnMuIEl0J3MKPiBhIHByb3RvY29sIHZpb2xhdGlvbiBpZiBhIGNvbnRy
b2xsZXIgd2FzIGJlaGF2aW5nIHRoYXQgd2F5LiBXZSd2ZSBzZWVuCj4gZGV2aWNlcyBicm9rZW4g
bGlrZSB0aGF0IGJlZm9yZSwgdGhvdWdoIGl0J3MgYmVlbiBhIHdoaWxlIHNpbmNlIEkndmUKPiBz
ZWVuIHN1Y2ggYmVodmFpb3IuCj4gCj4+IFsgIDg4NS4zNDQ1NzVdIFdBUk5JTkc6IENQVTogNDEg
UElEOiA0NTY1IGF0IGJsb2NrL2Jsay1tcS5jOjY2NSAgYmxrX21xX3N0YXJ0X3JlcXVlc3QrMHhj
NC8weGNjCj4gCj4gVGhpcyB3YXJuaW5nIGFwcGVhcnMgdG8gc3VwcG9ydCBteSBzdXNwaWNpb246
IHRoZSBjb21wbGV0aW9uIHNpZGUgaXMKPiBvYnNlcnZpbmcgYSBuZXcgcGhhc2Ugd2l0aCBhIHN0
YWxlIGNvbW1hbmQgaWQsIGFuZCB0aGF0IGNvbW1hbmQgaWQgd2FzCj4gcmVhbGxvY2F0ZWQgYXMg
YSBuZXcgcmVxdWVzdCB0aGF0IHdlJ3JlIHN0aWxsIGNvbnN0cnVjdGluZyBhdCB0aGUgdGltZQo+
IHRoZSBkb3VibGUtY29tcGxldGlvbiBvY2N1cmVkLgo+IAo+IEhvc3Qgc29mdHdhcmUgaXMgc3Vw
cG9zZWQgdG8gYmUgZ3VhcmFudGVlZCB0aGUgZW50aXJlIENRRSBpcyB3cml0dGVuCj4gb25jZSB3
ZSBzZWUgYW4gdXBkYXRlZCBwaGFzZSwgcGVyIHNwZWM6ICJJZiBhIENvbXBsZXRpb24gUXVldWUK
PiBFbnRyeSBpcyBjb25zdHJ1Y3RlZCB2aWEgbXVsdGlwbGUgd3JpdGVzLCB0aGUgUGhhc2UgVGFn
IGJpdCBzaGFsbCBiZQo+IHVwZGF0ZWQgaW4gdGhlIGxhc3Qgd3JpdGUgb2YgdGhhdCBDb21wbGV0
aW9uIFF1ZXVlIEVudHJ5LiIKCkhtbSwgdGhhdCBtYWtlcyBtZSB3b25kZXIgaWYgdGhlcmUgbWln
aHQgYmUgc29tZSBpbnRlcmFjdGlvbiB3aXRoIHRoZSAKQXJtIG1lbW9yeSBtb2RlbCBoZXJlIC0g
aWYgdGhlcmUgYXJlIHN0cmljdCBvcmRlcmluZyByZXF1aXJlbWVudHMgZm9yIAp0aGluZ3MgaW4g
bWVtb3J5IGJlaW5nIG9ic2VydmVkLCBjb3VsZCB3ZSBiZSBtaXNzaW5nIGFwcHJvcHJpYXRlIApi
YXJyaWVycyBiZXR3ZWVuIHJlYWRzL3dyaXRlcyBvZiB0aGUgdmFyaW91cyBmaWVsZHM/CgpSb2Jp
bi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
