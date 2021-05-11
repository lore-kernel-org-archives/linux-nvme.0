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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095EFC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:40:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFBA6187E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFBA6187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vVscFvJYWCsu5ErJHekErpFaqNfYWjVFU0S1yyPNkCI=; b=DiBebdDBAB+ZOEJmjtmFhOFpX
	hqi+XDWfqoumWbFCD79TIzaa9nPvAXu0kfRc983bOeKMcbhsYPPdz+59vpExPvDYyEfCpGlrAhDb7
	Xq/EaDivrrKbDwmCJa4PveCPJT4ZhuoUauAQDpa4XhbEEHD1n9VPXtIJ0iKiHwtFKrCc/Tbt7A//F
	bNjOqpr9rJlcOAh8pineKqcQCk8Z8Pwx3fvzS+LJJmAa6HqFGxNHenNWLuSIwykAbiYKccQfzpVFc
	tyIwjA26bi1iAOEPUaJXzJZX8qS9fIyAoXSCd5LWocnSD/DfnIfiOvPI0CrhhOUVA0SRUpYlL3GJ8
	w2ZR0Laxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVQk-000mWz-KG; Tue, 11 May 2021 16:40:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVAZ-000iwF-2o
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:23:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=3M6tTHlyFNKQwbGOtrLH1dHnpAA9L/D3mvAYYkgV538=; b=gTIXFSYJ750bfgH95KS0oVbfNZ
 bP/+h7TMFuVYgS9MSnJtIEmsObZlDa+FYgxM+RPrF/yDK/xTuRMFgPZ4u1l1YeD6Oz44rf49Vsudi
 kvwx5Hsl9rYhu6EjV0RlRD13fpv1QZGJhLFoGo4vUVZrV6MDw4FVM8wn4UVKBH7rdrdvz2J1leYXo
 20ByMwICL/5W7jfrjZ06w+g9ISApL4kRfEXGwtcwIlmktGYnUyVWxOMXBF89nfeLHL8WtjjXFYDbR
 9bnB97qmzXsg/zIV7heQybzVUg0Ka0iU2tIuH6vZY60LjFaIy6XMRzQ4prf6za6iE/PS9tpxlFDRo
 h0dNvHlw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVAW-009lBZ-B1
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620750215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3M6tTHlyFNKQwbGOtrLH1dHnpAA9L/D3mvAYYkgV538=;
 b=FM9u6tvbnr1XG/bJM+0T7jmFjWv8pkv5AYKxIAJTnIU32q0TKbO40RdAd1925Ysmd7ED2A
 bK0jxBzhT42/qRxIjZDSRgOgZgKh598NmuhtK65bMpF5m0Fg46I8nf7v08yzbclYmLNrPA
 T2J9vB3llJqd1mITRpa2KaecbzG2oVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-e2fb4B8yPWyJlQzkc_nNww-1; Tue, 11 May 2021 12:23:16 -0400
X-MC-Unique: e2fb4B8yPWyJlQzkc_nNww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687B38015D0;
 Tue, 11 May 2021 16:23:13 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 968105DEAD;
 Tue, 11 May 2021 16:23:10 +0000 (UTC)
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
To: Logan Gunthorpe <logang@deltatee.com>, John Hubbard
 <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
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
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
 <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <c078b970-7531-8834-e26f-e653e7db4c20@redhat.com>
Date: Tue, 11 May 2021 12:23:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_092336_461666_A7D9D0F2 
X-CRM114-Status: GOOD (  24.06  )
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

T24gNS8xMS8yMSAxMjoxMiBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Cj4gT24gMjAyMS0w
NS0xMSAxMDowNSBhLm0uLCBEb24gRHV0aWxlIHdyb3RlOgo+PiBPbiA1LzEvMjEgMTE6NTggUE0s
IEpvaG4gSHViYmFyZCB3cm90ZToKPj4+IE9uIDQvOC8yMSAxMDowMSBBTSwgTG9nYW4gR3VudGhv
cnBlIHdyb3RlOgo+Pj4+IEluIG9yZGVyIHRvIGNhbGwgdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNl
X3dhcm4oKSBmcm9tIGEgZG1hX21hcCBmdW5jdGlvbiwKPj4+PiBpdCBtdXN0IG5vdCBzbGVlcC4g
VGhlIG9ubHkgcmVhc29uIGl0IGRvZXMgc2xlZXAgaXMgdG8gYWxsb2NhdGUgdGhlIHNlcWJ1Zgo+
Pj4+IHRvIHByaW50IHdoaWNoIGRldmljZXMgYXJlIHdpdGhpbiB0aGUgQUNTIHBhdGguCj4+Pj4K
Pj4+PiBTd2l0Y2ggdGhlIGttYWxsb2MgY2FsbCB0byB1c2UgYSBwYXNzZWQgaW4gZ2ZwX21hc2sg
YW5kIGRvbid0IHByaW50IHRoYXQKPj4+PiBtZXNzYWdlIGlmIHRoZSBidWZmZXIgZmFpbHMgdG8g
YmUgYWxsb2NhdGVkLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxs
b2dhbmdAZGVsdGF0ZWUuY29tPgo+Pj4+IEFja2VkLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPgo+Pj4+IC0tLQo+Pj4+ICDCoCBkcml2ZXJzL3BjaS9wMnBkbWEuYyB8IDIx
ICsrKysrKysrKysrLS0tLS0tLS0tLQo+Pj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvcDJwZG1hLmMgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+Pj4+IGluZGV4IDE5NjM4MjYzMDM2
My4uYmQ4OTQzN2ZhZjA2IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+
Pj4gKysrIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMKPj4+PiBAQCAtMjY3LDcgKzI2Nyw3IEBAIHN0
YXRpYyBpbnQgcGNpX2JyaWRnZV9oYXNfYWNzX3JlZGlyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+
Pj4+ICDCoCDCoCBzdGF0aWMgdm9pZCBzZXFfYnVmX3ByaW50X2J1c19kZXZmbihzdHJ1Y3Qgc2Vx
X2J1ZiAqYnVmLCBzdHJ1Y3QgcGNpX2RldiAqcGRldikKPj4+PiAgwqAgewo+Pj4+IC3CoMKgwqAg
aWYgKCFidWYpCj4+Pj4gK8KgwqDCoCBpZiAoIWJ1ZiB8fCAhYnVmLT5idWZmZXIpCj4+PiBUaGlz
IGlzIG5vdCBncmVhdCwgc29ydCBvZiBmcm9tIGFuIG92ZXJhbGwgZGVzaWduIHBvaW50IG9mIHZp
ZXcsIGV2ZW4gdGhvdWdoCj4+PiBpdCBtYWtlcyB0aGUgcmVzdCBvZiB0aGUgcGF0Y2ggd29yay4g
U2VlIGJlbG93IGZvciBvdGhlciBpZGVhcywgdGhhdCB3aWxsCj4+PiBhdm9pZCB0aGUgbmVlZCBm
b3IgdGhpcyBzb3J0IG9mIG9kZCBwb2ludCBmaXguCj4+Pgo+PiArMS4KPj4gSW4gZmFjdCwgSSBk
aWRuJ3Qgc2VlIGhvdyB0aGUga21hbGxvYyB3YXMgY2hhbmdlZC4uLiB5b3UgcmVmYWN0b3JlZCB0
aGUgY29kZSB0byBwYXNzLWluIHRoZQo+PiBHRlBfS0VSTkVMIHRoYXQgd2FzIG9yaWdpbmFsbHkg
aGFyZC1jb2RlZCBpbnRvIHVwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZV93YXJuKCk7Cj4+IEkgZG9u
J3Qgc2VlIGhvdyB0aGF0IGF2b2lkZWQgdGhlIGttYWxsb2MoKSBjYWxsLgo+PiBpbiBmYWN0LCBJ
IGFsc28gc2VlIHlvdSBsb3N0IGEgZmFpbGVkIGttYWxsb2MoKSBjaGVjaywgc28gaXQgc2VlbXMg
dG8gaGF2ZSB0YWtlbiBhIHN0ZXAgYmFjay4KPiBJJ3ZlIGNoYW5nZWQgdGhpcyBpbiB2MiB0byBq
dXN0IHVzZSBzb21lIG1lbW9yeSBhbGxvY2F0ZWQgb24gdGhlIHN0YWNrLgo+IEF2b2lkcyB0aGlz
IGFyZ3VtZW50IGFsbCB0b2dldGhlci4KPgo+IExvZ2FuCj4KTG9va2luZyBmd2QgdG8gdGhlIHYy
OyBhZ2FpbiwgbXkgYXBvbG9naWVzIGZvciB0aGUgZGVsYXksIGFuZCB0aGUgcmVkdW5kYW5jeSBp
dCdzIGFkZGluZyB0byB5b3VyIGZlZWRiYWNrIHJldmlldyAmIGNoYW5nZXMuCi1Eb24KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
