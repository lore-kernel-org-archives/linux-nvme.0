Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB78C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:07:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FB061154
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FB061154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4Ehx08S/4QcyuqSS2L810MnQS9QU+L+lCqm7LwuEC40=; b=IDFe5+q0VjUfjDsdROAcZsjy2
	ojxfepxG8z1Z+wMtdOO5CuxbzCxY9se94Lzi5L/8bJBNy40y6Emg/ChhNBoVoPaugqkE9jIm07Td8
	X5NHR5P7gt2h4F8PncB+FRQQvW4i9RL7FWy18qqQrItujOsKyRmhf8usG5Xz5uhtxI1GjzMRxZCSN
	eRgxAzE0sODmcuG0NGkj6VgaR8U4mlJfJH7eMh2ZXQiJVDQrrp8myFavX7SmRUVvsHgo417vik2R8
	dIBMhortBEeGqB5QN2A5Vmn3lMNoODGHh7tvLG5n4f8qgMG5QlNWSNtz4noOt57PCmNC/xfn85zSS
	sKAOJ6aJA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgUuX-000fcO-3Q; Tue, 11 May 2021 16:07:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUuU-000fbx-Bt
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=te4j0CaO/GGwAePTvy9qf9MhnS54BQnLL/PFFRuQ1v8=; b=ccKc7C86XppPxob513+VUmUTku
 5nGu/a5ltZiSDL3ToC0m9f9vuIdlDYBLp8iVgnB1+kwWQN06eFS48hx15E43Da/SEau+QyuRhicdm
 ygkeUuQ18nDLOkK1y0IaOj6DUnbZaAXHKvXT6bNac85EWRRPJJKI6vWxkrKPNSDdMtE7O2TlGZP7/
 XqPa+ZPELGMzHq7c29BBMtLDR5G0tj4AjqK1K4YpIPZPDkOBB77xU9eE6djrd6k7L2DwiUMVOmFSG
 HeXk2rxrrCrrdifxcq64a6/Zumyg74lTbdj9QWr0mJy0k8KW3mDQff7PNqAyBTEc/wvZ5PEluJlku
 du197wUQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUuR-009jwf-CY
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te4j0CaO/GGwAePTvy9qf9MhnS54BQnLL/PFFRuQ1v8=;
 b=b442ovRp0CspgXVc954RuL2ZlwnTz4r1cuhOr/f8lBL1uoNYSBTUop0DLQskepX68rfy4m
 7V2dPiFRcaC0z6CnEAsbOLMy8s9TCyCn29WNPBQxDMO4+do2c9BbP/BhrlAgBCbWr8RR2F
 Uv02n8t/WMA7MvSQcnFKExuwc8rabvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-36MVrBJfO1-KLhYh32wKtA-1; Tue, 11 May 2021 12:05:25 -0400
X-MC-Unique: 36MVrBJfO1-KLhYh32wKtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2629D805F03;
 Tue, 11 May 2021 16:05:22 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 895785D9F2;
 Tue, 11 May 2021 16:05:17 +0000 (UTC)
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <cc7eab6b-2189-7b6a-d119-d653211cd1fb@redhat.com>
Date: Tue, 11 May 2021 12:05:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_090659_646296_366A4BE5 
X-CRM114-Status: GOOD (  32.79  )
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

T24gNC84LzIxIDE6MDEgUE0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPiBIaSwKPgo+IFRoaXMg
cGF0Y2hzZXQgY29udGludWVzIG15IHdvcmsgdG8gdG8gYWRkIFAyUERNQSBzdXBwb3J0IHRvIHRo
ZSBjb21tb24KPiBkbWEgbWFwIG9wZXJhdGlvbnMuIFRoaXMgYWxsb3dzIGZvciBjcmVhdGluZyBT
R0xzIHRoYXQgaGF2ZSBib3RoIFAyUERNQQo+IGFuZCByZWd1bGFyIHBhZ2VzIHdoaWNoIGlzIGEg
bmVjZXNzYXJ5IHN0ZXAgdG8gYWxsb3dpbmcgUDJQRE1BIHBhZ2VzIGluCj4gdXNlcnNwYWNlLgo+
Cj4gVGhlIGVhcmxpZXIgUkZDWzFdIGdlbmVyYXRlZCBhIGxvdCBvZiBncmVhdCBmZWVkYmFjayBh
bmQgSSBoZWFyZCBubyBzaG93Cj4gc3RvcHBpbmcgb2JqZWN0aW9ucy4gVGh1cywgSSd2ZSBpbmNv
cnBvcmF0ZWQgYWxsIHRoZSBmZWVkYmFjayBhbmQgaGF2ZQo+IGRlY2lkZWQgdG8gcG9zdCB0aGlz
IGFzIGEgcHJvcGVyIHBhdGNoIHNlcmllcyB3aXRoIGhvcGVzIG9mIGV2ZW50dWFsbHkKPiBnZXR0
aW5nIGl0IGluIG1haW5saW5lLgo+Cj4gSSdtIGhhcHB5IHRvIGRvIGEgZmV3IG1vcmUgcGFzc2Vz
IGlmIGFueW9uZSBoYXMgYW55IGZ1cnRoZXIgZmVlZGJhY2sKPiBvciBiZXR0ZXIgaWRlYXMuCj4K
PiBUaGlzIHNlcmllcyBpcyBiYXNlZCBvbiB2NS4xMi1yYzYgYW5kIGEgZ2l0IGJyYW5jaCBjYW4g
YmUgZm91bmQgaGVyZToKPgo+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zYmF0ZXMxMzAyNzIvbGlu
dXgtcDJwbWVtLyAgcDJwZG1hX21hcF9vcHNfdjEKPgo+IFRoYW5rcywKPgo+IExvZ2FuCj4KPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyMTAzMTEyMzMxNDIuNzkw
MC0xLWxvZ2FuZ0BkZWx0YXRlZS5jb20vCj4KPgo+IENoYW5nZXMgc2luY2UgdGhlIFJGQzoKPiAg
ICogQWRkZWQgY29tbWVudCBhbmQgZml4ZWQgdXAgdGhlIHBjaV9nZXRfc2xvdCBwYXRjaC4gKHBl
ciBCam9ybikKPiAgICogRml4ZWQgZ2xhcmluZyBzZ19waHlzKCkgZG91YmxlIG9mZnNldCBidWcu
IChwZXIgUm9iaW4pCj4gICAqIENyZWF0ZWQgYSBuZXcgbWFwIG9wZXJhdGlvbiAoZG1hX21hcF9z
Z19wMnBkbWEoKSkgd2l0aCBhIG5ldyBjYWxsaW5nCj4gICAgIGNvbnZlbnRpb24gaW5zdGVhZCBv
ZiBtb2RpZnlpbmcgdGhlIGNhbGxpbmcgY29udmVudGlvbiBvZgo+ICAgICBkbWFfbWFwX3NnKCku
IChwZXIgUm9iaW4pCj4gICAqIEludGVncmF0ZWQgdGhlIHR3byBzaW1pbGFyIHBjaV9wMnBkbWFf
ZG1hX21hcF90eXBlKCkgYW5kCj4gICAgIHBjaV9wMnBkbWFfbWFwX3R5cGUoKSBmdW5jdGlvbnMg
aW50byBvbmUgKHBlciBJcmEpCj4gICAqIFJld29ya2VkIHNvbWUgb2YgdGhlIGxvZ2ljIGluIHRo
ZSBtYXBfc2coKSBpbXBsZW1lbnRhdGlvbnMgaW50bwo+ICAgICBoZWxwZXJzIGluIHRoZSBwMnBk
bWEgY29kZS4gKHBlciBDaHJpc3RvcGgpCj4gICAqIERyb3BwZWQgYSBidW5jaCBvZiB1bm5lY2Vz
c2FyeSBzeW1ib2wgZXhwb3J0cyAocGVyIENocmlzdG9waCkKPiAgICogRXhwYW5kZWQgdGhlIGNv
ZGUgaW4gZG1hX3BjaV9wMnBkbWFfc3VwcG9ydGVkKCkgZm9yIGNsYXJpdHkuIChwZXIKPiAgICAg
SXJhIGFuZCBDaHJpc3RvcGgpCj4gICAqIEZpbmlzaGVkIG9mZiB1c2luZyB0aGUgbmV3IGRtYV9t
YXBfc2dfcDJwZG1hKCkgY2FsbCBpbiByZG1hX3J3Cj4gICAgIGFuZCByZW1vdmVkIHRoZSBvbGQg
cGNpX3AycGRtYV9bdW5dbWFwX3NnKCkuIChwZXIgSmFzb24pCj4KPiAtLQo+Cj4gTG9nYW4gR3Vu
dGhvcnBlICgxNik6Cj4gICAgUENJL1AyUERNQTogUGFzcyBnZnBfbWFzayBmbGFncyB0byB1cHN0
cmVhbV9icmlkZ2VfZGlzdGFuY2Vfd2FybigpCj4gICAgUENJL1AyUERNQTogQXZvaWQgcGNpX2dl
dF9zbG90KCkgd2hpY2ggc2xlZXBzCj4gICAgUENJL1AyUERNQTogQXR0ZW1wdCB0byBzZXQgbWFw
X3R5cGUgaWYgaXQgaGFzIG5vdCBiZWVuIHNldAo+ICAgIFBDSS9QMlBETUE6IFJlZmFjdG9yIHBj
aV9wMnBkbWFfbWFwX3R5cGUoKSB0byB0YWtlIHBhZ21hcCBhbmQgZGV2aWNlCj4gICAgZG1hLW1h
cHBpbmc6IEludHJvZHVjZSBkbWFfbWFwX3NnX3AycGRtYSgpCj4gICAgbGliL3NjYXR0ZXJsaXN0
OiBBZGQgZmxhZyBmb3IgaW5kaWNhdGluZyBQMlBETUEgc2VnbWVudHMgaW4gYW4gU0dMCj4gICAg
UENJL1AyUERNQTogTWFrZSBwY2lfcDJwZG1hX21hcF90eXBlKCkgbm9uLXN0YXRpYwo+ICAgIFBD
SS9QMlBETUE6IEludHJvZHVjZSBoZWxwZXJzIGZvciBkbWFfbWFwX3NnIGltcGxlbWVudGF0aW9u
cwo+ICAgIGRtYS1kaXJlY3Q6IFN1cHBvcnQgUENJIFAyUERNQSBwYWdlcyBpbiBkbWEtZGlyZWN0
IG1hcF9zZwo+ICAgIGRtYS1tYXBwaW5nOiBBZGQgZmxhZ3MgdG8gZG1hX21hcF9vcHMgdG8gaW5k
aWNhdGUgUENJIFAyUERNQSBzdXBwb3J0Cj4gICAgaW9tbXUvZG1hOiBTdXBwb3J0IFBDSSBQMlBE
TUEgcGFnZXMgaW4gZG1hLWlvbW11IG1hcF9zZwo+ICAgIG52bWUtcGNpOiBDaGVjayBETUEgb3Bz
IHdoZW4gaW5kaWNhdGluZyBzdXBwb3J0IGZvciBQQ0kgUDJQRE1BCj4gICAgbnZtZS1wY2k6IENv
bnZlcnQgdG8gdXNpbmcgZG1hX21hcF9zZ19wMnBkbWEgZm9yIHAycGRtYSBwYWdlcwo+ICAgIG52
bWUtcmRtYTogRW5zdXJlIGRtYSBzdXBwb3J0IHdoZW4gdXNpbmcgcDJwZG1hCj4gICAgUkRNQS9y
dzogdXNlIGRtYV9tYXBfc2dfcDJwZG1hKCkKPiAgICBQQ0kvUDJQRE1BOiBSZW1vdmUgcGNpX3Ay
cGRtYV9bdW5dbWFwX3NnKCkKPgo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcncuYyB8ICA1
MCArKystLS0tLS0tCj4gICBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jICAgIHwgIDY2ICsrKysr
KysrKystLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICB8ICAgMyArLQo+ICAgZHJp
dmVycy9udm1lL2hvc3QvbnZtZS5oICAgICB8ICAgMiArLQo+ICAgZHJpdmVycy9udm1lL2hvc3Qv
cGNpLmMgICAgICB8ICAzOSArKysrLS0tLQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMg
ICB8ICAgMyArLQo+ICAgZHJpdmVycy9wY2kvS2NvbmZpZyAgICAgICAgICB8ICAgMiArLQo+ICAg
ZHJpdmVycy9wY2kvcDJwZG1hLmMgICAgICAgICB8IDE4OCArKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLQo+ICAgaW5jbHVkZS9saW51eC9kbWEtbWFwLW9wcy5oICB8ICAgMyArCj4g
ICBpbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmggIHwgIDIwICsrKysKPiAgIGluY2x1ZGUvbGlu
dXgvcGNpLXAycGRtYS5oICAgfCAgNTMgKysrKysrLS0tLQo+ICAgaW5jbHVkZS9saW51eC9zY2F0
dGVybGlzdC5oICB8ICA0OSArKysrKysrKy0KPiAgIGluY2x1ZGUvcmRtYS9pYl92ZXJicy5oICAg
ICAgfCAgMzIgKysrKysrCj4gICBrZXJuZWwvZG1hL2RpcmVjdC5jICAgICAgICAgIHwgIDI1ICsr
KystCj4gICBrZXJuZWwvZG1hL21hcHBpbmcuYyAgICAgICAgIHwgIDcwICsrKysrKysrKysrLS0K
PiAgIDE1IGZpbGVzIGNoYW5nZWQsIDQxNiBpbnNlcnRpb25zKCspLCAxODkgZGVsZXRpb25zKC0p
Cj4KPgo+IGJhc2UtY29tbWl0OiBlNDlkMDMzYmRkZjViNTY1MDQ0ZTJhYmU0MjQxMzUzOTU5YmM5
MTIwCj4gLS0KPiAyLjIwLjEKPgpBcG9sb2dpZXMgaW4gdGhlIGRlbGF5IHRvIHByb3ZpZGUgZmVl
ZGJhY2s7IGNsaW1iaW5nIG91dCBvZiBzZXZlcmFsIGRlZXAgdHJlbmNoZXMgYXQgdGhlIG1vdGhl
ciBzaGlwIDotLwoKUmVwbHlpbmcgdG8gc29tZSBkaXJlY3RseSwgYW5kIGluZGlyZWN0bHkgKG1v
c3RseSB0aHJvdWdoIEpvaEgncyByZXBseSdzKS4KCkdlbmVyYWwgY29tbWVudHM6CjEpIG5pdHMg
aW4gMSwyLDMsNTsKIMKgwqAgNDogSSBhZ3JlZSB3L0pvaG5IICYgSmFzb25HIC0tIHNlZW1zIGxp
a2UgaXQgbmVlZHMgYSBkZXZpY2UtbGF5ZXIgdGhhdCBnZXRzIHRvIGEgYnVzLWxheWVyLCBidXQg
SSdtIHdlYXJpbmcgbXkgJ2Jyb2FkZXIgdGhlbiBQQ0knIGhhdCBpbiB0aGlzIHJldmlldzsgSSBz
ZWUgYSAoY2xhc3NpYykgQ2hyaXN0b3BoSCByZWZhY3RvcmluZyBhbmQgY2xlYW51cCBpbiB0aGlz
IGFyZWEsIGFuZCB3b25kZXJpbmcgaWYgd2Ugb3VnaHQgdG8gY2xlYW4gaXQgdXAgbm93LCBzaW5j
ZSBDSCBoYXMgZG9uZSBzbyBtdWNoIHRvIGNsZWFuIGl0IHVwIGFuZCBtYWtlIHRoZSBkbWEtbWFw
cGluZyBzeXN0ZW0gc28gbXVjaCBlYXNpZXIgdG8gYWRkL21vZGlmeS9yZXZpZXcgZHVlIHRvIHRo
ZSBicm9hZCBhcmNoICgmIGJ1cykgY2xlYW51cCB0aGF0IGhhcyBiZWVuIGRvbmUuwqAgSWYgdGhh
dCBkZWxheXMgaXQgdG9vIG11Y2gsIHRoZW4gYWRkIGEgVE9ETyB0byBkbyBzby4KMikgNjogeWVz
ISBsZXQncyBub3Qgd29ycnkgb3IgZXZlbiBib3RoIHN1cHBvcnRpbmcgMzItYml0IGFueXRoaW5n
IHdydCBwMnBkbWEuCjMpIDc6bml0CjQpIDg6IG9rOwo1KSA5OiBkaXR0byB0byBKb2huSCdzIGZl
ZWRiYWNrIG9uIGFkZGVkIC8gY2xlYXJlciBjb21tZW50ICYgY29kZSBmbG93IChpZi1lbHNlKS4K
NikgMTA6IG5pdHM7IHE6IHNob3VsZCBwMnBkbWEgbWFwcGluZyBnbyB0aHJvdWdoIGRtYS1vcHMg
c28gaXQgaXMgZ2VuZXJhbGl6ZWQgZm9yIGZ1dHVyZSBpbnRlcmNvbm5lY3RzIChDWEwsIEdlblop
Pwo3KSAxMTogSXQgc2F5cyBpdCBpcyBzdXBwb3J0aW5nIHAycGRtYSBpbiBkbWEtaW9tbXUncyBt
YXBfc2csIGJ1dCBpdCBzZWVtcyBsaWtlIGl0IGlzIGp1c3QgbGV2ZXJhZ2luZyBzaGFyZWQgY29k
ZSBhbmQgc2hvcnQtY2lyY3VpdGluZyBJT01NVSB1c2UuCjgpIDEyLTE0OiBkaWRuJ3QgcmV2aWV3
OyBsZXR0aW5nIHRoZSBibG9jay9udm1lL2RpcmVjdC1pbyBmb2xrcyBjb3ZlciB0aGlzIHNwYWNl
CjkpIDE1OiBMb29raW5nIHRvIEphc29uRyB0byBzYW5pdGl6ZQoxMCkgMTY6IGNsZWFudXA7IGEt
b2suCgotIERvbkQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
