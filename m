Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AACC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E12761353
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E12761353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2LuPOKaEJ+gXuzFy6wyxfCiIiCFh7LJE7X81NZY6Bw8=; b=Fyhv5oBoktVvam
	Nd8cmZQXFrdGUJNn7Sr24F5tX/z3vWhLuoWSvhPBS2EzzTHJ0H/J+7Sp5nvAcKTNRHQ5ogKWIBDa9
	SZlHKxMchnLeUgfaBu3b96HuP8Dg8sM/Anhz8hsLQ3jPBKe7/u+Atnc1s4SWd7lv5zPL4KolusBER
	PtVoIfTEm5PIkq0B/nMfobFmPDdn92g5oOS52F2dCc7uw4oTaEV0DVeLkuPbTGcNXigAx+FFKWSvo
	tMcgPTBRqQ/0BgMfqfChkqz52Zp0KQ5ewHnwf0LBZrb2wW9i8Tq++8OyM3m4c+IUlbpKNLhQjNbdl
	WrXhY0yjqS+ohavqBXvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVgw1-00CN8R-4l; Wed, 29 Sep 2021 21:16:13 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVgvy-00CN7T-Ms
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 21:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=RfrWfjCRN+UowtRVbNA3b2L6enFhSnjdcCuQt0d3QdI=; b=sx8iDLgZqm9oV/jPtvYl6hWxOJ
 izKJEIZpDyBIKLWz8FDerUW5k2MT7pPtfUTyZiEU6bE7HoV7pneW/CZR2zMIxsytGbyq8vFegsKGv
 49LSCi3qE6cFcuu3ANDMzF0wHUfqas6dQodjbfxt/8zHWnBhP9N8kOEENBNUjLrsTXNl90Sahn8H0
 HAUhhk1jLu1tfiA5AYOXEg4lkZh0pmHiPlunotwWT39n20HVUlZzMB6xXhNwz+2qZPfnc/8Ia0J5E
 FZIAlxHcWmAecE99N9j4B2rg3AG9XIO/VHcG1DdeZNocY4lVPpt+WxirDMZKAHuss1OBzFQ0yFB23
 svZcaJZQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVgvW-0006Bq-H1; Wed, 29 Sep 2021 15:15:43 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
 <20210928183219.GJ3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3f3abc6b-0a80-dbb6-f9dc-8a4cc33c975c@deltatee.com>
Date: Wed, 29 Sep 2021 15:15:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928183219.GJ3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_141610_771593_5C3DCEA8 
X-CRM114-Status: GOOD (  24.47  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLTA5LTI4IDEyOjMyIHAubS4sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBU
aHUsIFNlcCAxNiwgMjAyMSBhdCAwNTo0MDo0MVBNIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3Jv
dGU6Cj4+ICBjb25maWcgUENJX1AyUERNQQo+PiAgCWJvb2wgIlBDSSBwZWVyLXRvLXBlZXIgdHJh
bnNmZXIgc3VwcG9ydCIKPj4gLQlkZXBlbmRzIG9uIFpPTkVfREVWSUNFCj4+ICsJZGVwZW5kcyBv
biBaT05FX0RFVklDRSAmJiA2NEJJVAo+IAo+IFBlcmhhcHMgYSBjb21tZW50IHRvIGV4cGxhaW4g
d2hhdCB0aGUgNjRiaXQgaXMgZG9pbmc/CgpBZGRlZC4KCj4+ICAJc2VsZWN0IEdFTkVSSUNfQUxM
T0NBVE9SCj4+ICAJaGVscAo+PiAgCSAgRW5hYmxl0ZUgZHJpdmVycyB0byBkbyBQQ0kgcGVlci10
by1wZWVyIHRyYW5zYWN0aW9ucyB0byBhbmQgZnJvbQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9zY2F0dGVybGlzdC5oIGIvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCj4+IGluZGV4
IDI2Njc1NGE1NTMyNy4uZTYyYjFjZjYzODZmIDEwMDY0NAo+PiArKysgYi9pbmNsdWRlL2xpbnV4
L3NjYXR0ZXJsaXN0LmgKPj4gQEAgLTY0LDYgKzY0LDIxIEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFi
bGUgewo+PiAgI2RlZmluZSBTR19DSEFJTgkweDAxVUwKPj4gICNkZWZpbmUgU0dfRU5ECQkweDAy
VUwKPj4gIAo+PiArLyoKPj4gKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJpdCBpbiB0aGUg
cGFnZV9saW5rIG9uIDY0Yml0IHN5c3RlbXMgd2hpY2gKPj4gKyAqIGlzIHVzZWQgYnkgZG1hX3Vu
bWFwX3NnKCkgdG8gZGV0ZXJtaW5lIGlmIHRoZSBkbWFfYWRkcmVzcyBpcyBhIFBDSQo+PiArICog
YnVzIGFkZHJlc3Mgd2hlbiBkb2luZyBQMlBETUEuCj4+ICsgKiBOb3RlOiBDT05GSUdfUENJX1Ay
UERNQSBkZXBlbmRzIG9uIENPTkZJR182NEJJVCBiZWNhdXNlIG9mIHRoaXMuCj4+ICsgKi8KPj4g
Kwo+PiArI2lmZGVmIENPTkZJR19QQ0lfUDJQRE1BCj4+ICsjZGVmaW5lIFNHX0RNQV9QQ0lfUDJQ
RE1BCTB4MDRVTAo+IAo+IEFkZCBhIAo+IAlzdGF0aWNfYXNzZXJ0KF9fYWxpZ25vZl9fKHZvaWQg
KikgPT0gOCk7Cj4gCj4gPwoKR29vZCBpZGVhLiBUaG91Z2gsIEkgdGhpbmsgeW91ciBsaW5lIGlz
bid0IHF1aXRlIGNvcnJlY3QuIEkndmUgYWRkZWQ6CgpzdGF0aWNfYXNzZXJ0KF9fYWxpZ25vZl9f
KHN0cnVjdCBwYWdlKSA+PSA4KTsKCj4+ICsjZGVmaW5lIHNnX2lzX2RtYV9wY2lfcDJwZG1hKHNn
KSAoKHNnKS0+cGFnZV9saW5rICYgU0dfRE1BX1BDSV9QMlBETUEpCj4gCj4gSSd2ZSBiZWVuIGVu
Y291cmFnaW5nIHBlb3BsZSB0byB1c2Ugc3RhdGljIGlubGluZXMgbW9yZS4uCgpJIGFsc28gcHJl
ZmVyIHN0YXRpYyBpbmxpbmVzLCBidXQgSSB1c3VhbGx5IGZvbGxvdyB0aGUgc3R5bGUgb2YgdGhl
IGNvZGUKSSdtIGNoYW5naW5nLiBJbiBhbnkgY2FzZSwgSSd2ZSBjaGFuZ2VkIHRvIHN0YXRpYyBp
bmxpbmVzIHNpbWlsYXIgdG8KeW91ciBleGFtcGxlLgoKPj4gIC8qKgo+PiAgICogc2dfYXNzaWdu
X3BhZ2UgLSBBc3NpZ24gYSBnaXZlbiBwYWdlIHRvIGFuIFNHIGVudHJ5Cj4+IEBAIC04NiwxMyAr
MTAzLDEzIEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFibGUgewo+PiAgICoqLwo+PiAgc3RhdGljIGlu
bGluZSB2b2lkIHNnX2Fzc2lnbl9wYWdlKHN0cnVjdCBzY2F0dGVybGlzdCAqc2csIHN0cnVjdCBw
YWdlICpwYWdlKQo+PiAgewo+PiAtCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2Vf
bGluayAmIChTR19DSEFJTiB8IFNHX0VORCk7Cj4+ICsJdW5zaWduZWQgbG9uZyBwYWdlX2xpbmsg
PSBzZy0+cGFnZV9saW5rICYgU0dfUEFHRV9MSU5LX01BU0s7Cj4gCj4gSSB0aGluayB0aGlzIHNo
b3VsZCBqdXN0IGJlICcmIFNHX0VORCcsIHNnX2Fzc2lnbl9wYWdlKCkgZG9lc24ndCBsb29rCj4g
bGlrZSBpdCBzaG91bGQgZXZlciBiZSB1c2VkIG9uIGEgc2dfY2hhaW4gZW50cnksIHNvIHRoaXMg
aXMganVzdAo+IHRyeWluZyB0byBwcmVzZXJ2ZSB0aGUgZW5kIHN0YW1wLgoKUGVyaGFwcywgYnV0
IEknbSBub3QgY29tZm9ydGFibGUgbWFraW5nIHRoYXQgY2hhbmdlIGluIHRoaXMgcGF0Y2ggb3IK
c2VyaWVzLiBUaG91Z2gsIEkndmUgcmV2ZXJ0ZWQgdGhpcyBzcGVjaWZpYyBjaGFuZ2UgaW4gbXkg
cGF0Y2ggc28Kc2dfYXNzaWduX3BhZ2UoKSB3aWxsIGNsZWFyIFNHX0RNQV9QQ0lfUDJQRE1BLgoK
TG9nYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
