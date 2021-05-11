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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6FC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:26:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425F16186A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425F16186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yH3siX6DYCXgw9YItF110nJbNnD2iVHdaggk6ui3Xzs=; b=XCE8Z/yRby4yXE+RaDHa3d17q
	Ruz1Owu9ZgT/pqkBqgF8iKVb00V/3pMbMBoBPEIPCiv6IFchTUuNLfJavp1u+jvGWOqLR3CGhR7ws
	ztxzpX48St5j2HkMP4yDF/plkC+RsujK/fwrnzDXtsSmdRPbTj+waoyXG8HBfUhY4bNe2SL6ATUmg
	/dP9ObGnr4kB5yEygA1UkqIrh9Xl7r4CTdmGB8PHqspymJcV2urw9hsRkagnfNiQ6ssFvoS+xSq+r
	Yhso7EPQxmSeJjK8QeLhDDTkPHBfSZH0PUzeVHdtfDTCHtDtTa74HhIEBpAxqPq0x1iyHV7RCSlkt
	4jb4aCsVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVDC-000jXJ-8a; Tue, 11 May 2021 16:26:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgV0K-000gmW-J3
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=BHBUlVYkvN7U/TbnhdmSfxdbBO7hmMx8+ZQaSS91pAY=; b=HyBbLqmNsTumZyMjlIJDM+BMfK
 C3bF8P3RdMrP2Wi5nRFb/g+b9mObCm7GbaZ5fAmof78c4yEkxXsSBQLjjDyoyHs8WIuUmp3jo5n9j
 3ptsim8R47EjB2MQS9nmMw1HPaFO4I2K4M+BSogHjJv/rJq5KUHGchUf1eUwsu3EoUQwx7eBs7hEd
 VnJeZXfO1d1BwsX5VJr+JaMGMCL3zmjjVXbV23evz3i1UYJ+vdqtcqwY5/yOPiX9j+dI1IiClLkWY
 4AiFw+4dkkd76DuXL78VqQOdQ2KvueXnS9VVxQr7kal7qlu4D4+l7TSEFXSMmUwe9lMhKqp1SiU2z
 teCMGU9A==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgV0G-009kVv-I6
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:13:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=BHBUlVYkvN7U/TbnhdmSfxdbBO7hmMx8+ZQaSS91pAY=; b=rsu7y4L6BqjnqY43bR2EjC+q8w
 I21N4GuEIsZtEN66HoQVR0eBUqXn9sLnhmeyjs1LmpX8ONK+4bR40It7S3HEyHUIadkFTRMjL6PnS
 bB0n5Fr7Zjp0fYF0PszR86jiQekrG0/YiMxjzKlvZ/EcoIT5WUU+u4BdzM71EtarOlouiAJGtNWbC
 OG0YRsSDn0akFPUGxxgbghzFEP500GKyJxOfhhP+VXZH6y4SdBhM2JjpjA9kGzUYu84S0WPnK8dl7
 8QQukFL6DMVaPGaBHKFNGJzPQm7aOqvldJK3cdI6OmASeQ1CBV71z6pmz8w0UZUeslplJDlf0fzGw
 VvW5QwDQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lgUzy-0006Xk-Lw; Tue, 11 May 2021 10:12:43 -0600
To: Don Dutile <ddutile@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
Date: Tue, 11 May 2021 10:12:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, robin.murphy@arm.com,
 ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com,
 dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com,
 andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_091300_643467_D29FD9D7 
X-CRM114-Status: GOOD (  21.46  )
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

CgpPbiAyMDIxLTA1LTExIDEwOjA1IGEubS4sIERvbiBEdXRpbGUgd3JvdGU6Cj4gT24gNS8xLzIx
IDExOjU4IFBNLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4+IE9uIDQvOC8yMSAxMDowMSBBTSwgTG9n
YW4gR3VudGhvcnBlIHdyb3RlOgo+Pj4gSW4gb3JkZXIgdG8gY2FsbCB1cHN0cmVhbV9icmlkZ2Vf
ZGlzdGFuY2Vfd2FybigpIGZyb20gYSBkbWFfbWFwIGZ1bmN0aW9uLAo+Pj4gaXQgbXVzdCBub3Qg
c2xlZXAuIFRoZSBvbmx5IHJlYXNvbiBpdCBkb2VzIHNsZWVwIGlzIHRvIGFsbG9jYXRlIHRoZSBz
ZXFidWYKPj4+IHRvIHByaW50IHdoaWNoIGRldmljZXMgYXJlIHdpdGhpbiB0aGUgQUNTIHBhdGgu
Cj4+Pgo+Pj4gU3dpdGNoIHRoZSBrbWFsbG9jIGNhbGwgdG8gdXNlIGEgcGFzc2VkIGluIGdmcF9t
YXNrIGFuZCBkb24ndCBwcmludCB0aGF0Cj4+PiBtZXNzYWdlIGlmIHRoZSBidWZmZXIgZmFpbHMg
dG8gYmUgYWxsb2NhdGVkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8
bG9nYW5nQGRlbHRhdGVlLmNvbT4KPj4+IEFja2VkLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3BjaS9wMnBkbWEuYyB8IDIxICsr
KysrKysrKysrLS0tLS0tLS0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBk
bWEuYyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+PiBpbmRleCAxOTYzODI2MzAzNjMuLmJkODk0
MzdmYWYwNiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+PiArKysgYi9k
cml2ZXJzL3BjaS9wMnBkbWEuYwo+Pj4gQEAgLTI2Nyw3ICsyNjcsNyBAQCBzdGF0aWMgaW50IHBj
aV9icmlkZ2VfaGFzX2Fjc19yZWRpcihzdHJ1Y3QgcGNpX2RldiAqcGRldikKPj4+IMKgIMKgIHN0
YXRpYyB2b2lkIHNlcV9idWZfcHJpbnRfYnVzX2RldmZuKHN0cnVjdCBzZXFfYnVmICpidWYsIHN0
cnVjdCBwY2lfZGV2ICpwZGV2KQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCBpZiAoIWJ1ZikKPj4+ICvC
oMKgwqAgaWYgKCFidWYgfHwgIWJ1Zi0+YnVmZmVyKQo+Pgo+PiBUaGlzIGlzIG5vdCBncmVhdCwg
c29ydCBvZiBmcm9tIGFuIG92ZXJhbGwgZGVzaWduIHBvaW50IG9mIHZpZXcsIGV2ZW4gdGhvdWdo
Cj4+IGl0IG1ha2VzIHRoZSByZXN0IG9mIHRoZSBwYXRjaCB3b3JrLiBTZWUgYmVsb3cgZm9yIG90
aGVyIGlkZWFzLCB0aGF0IHdpbGwKPj4gYXZvaWQgdGhlIG5lZWQgZm9yIHRoaXMgc29ydCBvZiBv
ZGQgcG9pbnQgZml4Lgo+Pgo+ICsxLgo+IEluIGZhY3QsIEkgZGlkbid0IHNlZSBob3cgdGhlIGtt
YWxsb2Mgd2FzIGNoYW5nZWQuLi4geW91IHJlZmFjdG9yZWQgdGhlIGNvZGUgdG8gcGFzcy1pbiB0
aGUKPiBHRlBfS0VSTkVMIHRoYXQgd2FzIG9yaWdpbmFsbHkgaGFyZC1jb2RlZCBpbnRvIHVwc3Ry
ZWFtX2JyaWRnZV9kaXN0YW5jZV93YXJuKCk7Cj4gSSBkb24ndCBzZWUgaG93IHRoYXQgYXZvaWRl
ZCB0aGUga21hbGxvYygpIGNhbGwuCj4gaW4gZmFjdCwgSSBhbHNvIHNlZSB5b3UgbG9zdCBhIGZh
aWxlZCBrbWFsbG9jKCkgY2hlY2ssIHNvIGl0IHNlZW1zIHRvIGhhdmUgdGFrZW4gYSBzdGVwIGJh
Y2suCgpJJ3ZlIGNoYW5nZWQgdGhpcyBpbiB2MiB0byBqdXN0IHVzZSBzb21lIG1lbW9yeSBhbGxv
Y2F0ZWQgb24gdGhlIHN0YWNrLgpBdm9pZHMgdGhpcyBhcmd1bWVudCBhbGwgdG9nZXRoZXIuCgpM
b2dhbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
