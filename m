Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B0FC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:08:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD61160C41
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD61160C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k18g+xzOtPfPEy6IjzdqxTtlgThhELQB1XQ7vFOcQPs=; b=Nqyn45mt4JSe3tNpxDjPpeDCD
	tk39KGB/r7AU7IytHbmNr5rUqUqqisIFbmgMbOTZFYjB0M5mLCqtUs/hKW8st5bknb7bEvf+OitVQ
	Ss8Evd48a6dZEOUDxnUZJ7hEzEOJA5w5Zf+r2BQfEYyiTn+IA1wQCk1GxbnI9Ji15BkE8ErY8vLJS
	381vwbQFekozqbXd0opfRhHyAcNmlmZk3z/lpk7OszH5Lhm0NTIi/qZ/iLZiOkRqRA7Cn9DYACmp9
	UfJBH256GKo2BbjfJA1UR8jtpjqSzPPkgbxf+Y7CRlR0xYH47pQbwzm5fz8Hin+s1twjDTT1QoeOp
	c5WCueGkg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgUvk-000fn2-Bo; Tue, 11 May 2021 16:08:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUuy-000fgH-Oi
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=7EwSkK3tCLzSwRdZ/4L1eSG5xJr+ckvT0VIiRU+l0cU=; b=POnP6lJyhAtUbGK3+scvciKUF+
 r+76aicKvDMBLriq5feYZ+ZtcvP0CGM/0tU5Q73PuyE+bJTxk2vPYVm8ZaY0EBDH30a8JsCxmI4Bn
 JcWeU3EevWkblQd/EpWsVLLqSeJw0p0zwTBfUszNN6J4jb06ANZXGck2Yr93Z9gX8LCmxP9Q0x/bq
 9yDb0p4MPIUwruNtuni6vmANhr751rp3h9EICmdqSqmOzuYAVd22uW4DOfaEJmYE+wOxUl9GWz/0N
 oG8QPzohdI5vHwvlM3KeQVz6hhgxuTKQ2wUUAf98wrutKDYCKueWlgIUxnXvdy4ZubF62iTRBuhUz
 KPJ+0lOQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUuv-009jz7-Ss
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EwSkK3tCLzSwRdZ/4L1eSG5xJr+ckvT0VIiRU+l0cU=;
 b=hRd79yFh18SL4fY6nGPpwxlkRi3deH4NMiN2HTPbEYD/hGDsbc8mBFT+3T5UsEAgG3Fjiv
 8WziHSH3qgVbPR8v13r/+hG58UvrYaPaSOwXhcmpLxdHqndUtdw9gTC7z0iwXxu3EJs7BC
 gfCz/9TZHGy5jP64Ql5O+ZMo5wOX6rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-FaCNBf4dPAaCfsJb1OSVVQ-1; Tue, 11 May 2021 12:05:57 -0400
X-MC-Unique: FaCNBf4dPAaCfsJb1OSVVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B92A21854E27;
 Tue, 11 May 2021 16:05:52 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 717785D9F2;
 Tue, 11 May 2021 16:05:50 +0000 (UTC)
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
To: John Hubbard <jhubbard@nvidia.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <87a2b8e9-f0ef-ec23-8427-3022a86b0ec5@redhat.com>
Date: Tue, 11 May 2021 12:05:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_090730_121390_808C3BB6 
X-CRM114-Status: GOOD (  28.02  )
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

T24gNS8yLzIxIDM6NTggUE0sIEpvaG4gSHViYmFyZCB3cm90ZToKPiBPbiA0LzgvMjEgMTA6MDEg
QU0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4gQXR0ZW1wdCB0byBmaW5kIHRoZSBtYXBwaW5n
IHR5cGUgZm9yIFAyUERNQSBwYWdlcyBvbiB0aGUgZmlyc3QKPj4gRE1BIG1hcCBhdHRlbXB0IGlm
IGl0IGhhcyBub3QgYmVlbiBkb25lIGFoZWFkIG9mIHRpbWUuCj4+Cj4+IFByZXZpb3VzbHksIHRo
ZSBtYXBwaW5nIHR5cGUgd2FzIGV4cGVjdGVkIHRvIGJlIGNhbGN1bGF0ZWQgYWhlYWQgb2YKPj4g
dGltZSwgYnV0IGlmIHBhZ2VzIGFyZSB0byBjb21lIGZyb20gdXNlcnNwYWNlIHRoZW4gdGhlcmUn
cyBubwo+PiB3YXkgdG8gZW5zdXJlIHRoZSBwYXRoIHdhcyBjaGVja2VkIGFoZWFkIG9mIHRpbWUu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNv
bT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvcGNpL3AycGRtYS5jIHwgMTIgKysrKysrKysrLS0tCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBkbWEuYyBiL2RyaXZlcnMvcGNpL3AycGRtYS5j
Cj4+IGluZGV4IDQ3M2EwODk0MGZiYy4uMjU3NGEwNjJhMjU1IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL3BjaS9wMnBkbWEuYwo+PiArKysgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+PiBAQCAtODI1
LDExICs4MjUsMTggQEAgRVhQT1JUX1NZTUJPTF9HUEwocGNpX3AycG1lbV9wdWJsaXNoKTsKPj4g
wqAgc3RhdGljIGVudW0gcGNpX3AycGRtYV9tYXBfdHlwZSBwY2lfcDJwZG1hX21hcF90eXBlKHN0
cnVjdCBwY2lfZGV2ICpwcm92aWRlciwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqY2xpZW50KQo+PiDC
oCB7Cj4+ICvCoMKgwqAgZW51bSBwY2lfcDJwZG1hX21hcF90eXBlIHJldDsKPj4gKwo+PiDCoMKg
wqDCoMKgIGlmICghcHJvdmlkZXItPnAycGRtYSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBQQ0lfUDJQRE1BX01BUF9OT1RfU1VQUE9SVEVEOwo+PiDCoCAtwqDCoMKgIHJldHVybiB4YV90
b192YWx1ZSh4YV9sb2FkKCZwcm92aWRlci0+cDJwZG1hLT5tYXBfdHlwZXMsCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFwX3R5cGVzX2lkeChjbGllbnQpKSk7Cj4+
ICvCoMKgwqAgcmV0ID0geGFfdG9fdmFsdWUoeGFfbG9hZCgmcHJvdmlkZXItPnAycGRtYS0+bWFw
X3R5cGVzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXBfdHlwZXNf
aWR4KGNsaWVudCkpKTsKPj4gK8KgwqDCoCBpZiAocmV0ICE9IFBDSV9QMlBETUFfTUFQX1VOS05P
V04pCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiArCj4+ICvCoMKgwqAgcmV0dXJu
IHVwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZV93YXJuKHByb3ZpZGVyLCBjbGllbnQsIE5VTEwsCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0FU
T01JQyk7Cj4KPiBSZXR1cm5pbmcgYSAiYnJpZGdlIGRpc3RhbmNlIiBmcm9tIGEgImdldCBtYXAg
dHlwZSIgcm91dGluZSBpcyBqYXJyaW5nLAo+IGFuZCBJIHRoaW5rIGl0IGlzIGJlY2F1c2Ugb2Yg
YSBwcmUtZXhpc3RpbmcgcHJvYmxlbTogdGhlIGFib3ZlIGZ1bmN0aW9uCj4gaXMgc2V2ZXJlbHkg
bWlzbmFtZWQuIExldCdzIHRyeSByZW5hbWluZyBpdCAoYW5kIHRoZSBvdGhlciBvbmUpIHRvCj4g
YXBwcm94aW1hdGVseToKPgo+IMKgwqDCoCB1cHN0cmVhbV9icmlkZ2VfbWFwX3R5cGVfd2Fybigp
Cj4gwqDCoMKgIHVwc3RyZWFtX2JyaWRnZV9tYXBfdHlwZSgpCj4KPiAuLi5hbmQgdGhhdCBzaG91
bGQgZml4IHRoYXQuIFdlbGwsIHRoYXQsIHBsdXMgdHdlYWtpbmcgdGhlIGtlcm5lbCBkb2MKPiBj
b21tZW50cywgd2hpY2ggYXJlIGFsc28gY29uZnVzZWQuIEkgdGhpbmsgc29tZW9uZSBzdGFydGVk
IG9mZiB0aGlua2luZwo+IGFib3V0IGRpc3RhbmNlcyB0aHJvdWdoIFBDSWUsIGJ1dCBpbiB0aGUg
ZW5kLCB0aGUgcm91dGluZSBib2lscyBkb3duIHRvCj4ganVzdCBhIGZldyBzaXR1YXRpb25zIHRo
YXQgYXJlIG5vdCBkaXN0YW5jZXMgYXQgYWxsLgo+CisxLiBkaWRuJ3QgbGlrZSB0aGUgJ2Rpc3Rh
bmNlJyBjaGVja8KgIGZvciBhICdjb25uZWN0aW9uIGNoZWNrIiBpbiB0aGUgYmVnaW5uaW5nLCBh
bmQgbG9va3MgbGlrZSB0aGlzIGlzIHRoZSB0aW1lIHRvIGNsZWFuIGl0IG91dC4KOikKCj4gQWxz
bywgdGhlIGFib3ZlIHdpbGwgcmVhZCBhIGxpdHRsZSBiZXR0ZXIgaWYgaXQgaXMgd3JpdHRlbiBs
aWtlIHRoaXM6Cj4KPiDCoMKgwqDCoHJldCA9IHhhX3RvX3ZhbHVlKHhhX2xvYWQoJnByb3ZpZGVy
LT5wMnBkbWEtPm1hcF90eXBlcywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1hcF90eXBlc19pZHgoY2xpZW50KSkpOwo+Cj4gwqDCoMKgwqBpZiAocmV0ID09IFBDSV9QMlBE
TUFfTUFQX1VOS05PV04pCj4gwqDCoMKgwqDCoMKgwqAgcmV0ID0gdXBzdHJlYW1fYnJpZGdlX21h
cF90eXBlX3dhcm4ocHJvdmlkZXIsIGNsaWVudCwgTlVMTCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0FUT01JQyk7Cj4KPiDCoMKg
wqDCoHJldHVybiByZXQ7Cj4KPgo+PiDCoCB9Cj4+IMKgIMKgIHN0YXRpYyBpbnQgX19wY2lfcDJw
ZG1hX21hcF9zZyhzdHJ1Y3QgcGNpX3AycGRtYV9wYWdlbWFwICpwMnBfcGdtYXAsCj4+IEBAIC04
NzcsNyArODg0LDYgQEAgaW50IHBjaV9wMnBkbWFfbWFwX3NnX2F0dHJzKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPj4gwqDCoMKgwqDCoCBjYXNlIFBDSV9QMlBE
TUFfTUFQX0JVU19BRERSOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIF9fcGNpX3AycGRt
YV9tYXBfc2cocDJwX3BnbWFwLCBkZXYsIHNnLCBuZW50cyk7Cj4+IMKgwqDCoMKgwqAgZGVmYXVs
dDoKPj4gLcKgwqDCoMKgwqDCoMKgIFdBUk5fT05fT05DRSgxKTsKPgo+IFdoeT8gT3IgYXQgbGVh
c3QsIHdoeSwgaW4gdGhpcyBwYXRjaD8gSXQgbG9va3MgbGlrZSBhbiBhY2NpZGVudGFsCj4gbGVm
dG92ZXIgZnJvbSBzb21ldGhpbmcsIHNlZWluZyBhcyBob3cgaXQgaXMgbm90IGRpcmVjdGx5IHJl
bGF0ZWQgdG8gdGhlCj4gcGF0Y2gsIGFuZCBpcyBub3QgbWVudGlvbmVkIGF0IGFsbC4KPgo+Cj4g
dGhhbmtzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
