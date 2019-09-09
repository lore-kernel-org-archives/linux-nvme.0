Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D61C4740A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 15:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C874207FC
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 15:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xuv0UNs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C874207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RuPQXwdi2H+qcmqcmqZtKMsX5UtVo70Ttd4nC23CFDs=; b=Xuv0UNs4GZmMp9
	mQ9/WWTYJc5+x4m16g2BJTc+y8rHusJD2QN2BtI2yrn6ueeMV22RIbuzjmvV/YMRBIh0SA0n+mKhU
	1XeGOqwueHntlImW/76tVyiOcR2NQq+xVlziC1SqSvm5cv3nrGs8EJe8GyDQ0QItmKDID7j4WmMbz
	mxololDDLJMAtLaKG/w1roZ5K9gTldJpWbbn58eleYweEfdDNnM6nidhpFA5u6czO4c9XphJaktR/
	007ksPWRkpwtRfOXMAM2QkODvReATEefCLIlUOhaBevRkM3mmZJw3bLjHClVuCzYzmLJ9mTSuYvyp
	DP7lPqpYVhHEyhImiX8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7LJo-00067K-3V; Mon, 09 Sep 2019 15:11:04 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7LJk-000669-2T
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 15:11:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DBA01AE8B;
 Mon,  9 Sep 2019 15:10:57 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
 <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
 <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
 <c50cbc24-328f-35b7-5c74-c66a9bd76128@grimberg.me>
 <84338eac-c287-1826-4ac1-72cd17ee62cc@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <0a3fddcc-62fb-44f4-2be7-a1f9dbdbd1c8@suse.de>
Date: Mon, 9 Sep 2019 17:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <84338eac-c287-1826-4ac1-72cd17ee62cc@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_081100_405568_C62351D9 
X-CRM114-Status: GOOD (  25.97  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8zMS8xOSAxMjoyNCBBTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4gT24gOC8zMC8yMDE5IDI6
MDcgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Cj4+Pj4+Pj4gWWVzIHdlIGRvLCB1c2Vyc3Bh
Y2Ugc2hvdWxkIHVzZSBpdCB0byBvcmRlciBldmVudHMuwqAgRG9lcyB1ZGV2IG5vdAo+Pj4+Pj4+
IGhhbmRsZSB0aGF0IHByb3Blcmx5IHRvZGF5Pwo+Pj4+Pj4KPj4+Pj4+IFRoZSBwcm9ibGVtIGlz
IG5vdCBvcmRlcmluZyBvZiBldmVudHMsIGl0cyByZWFsbHkgYWJvdXQgdGhlIGZhY3QgdGhhdAo+
Pj4+Pj4gdGhlIGNoYXJkZXYgY2FuIGJlIHJlbW92ZWQgYW5kIHJlYWxsb2NhdGVkIGZvciBhIGRp
ZmZlcmVudCBjb250cm9sbGVyCj4+Pj4+PiAoY291bGQgYmUgYSBjb21wbGV0ZWx5IGRpZmZlcmVu
dCBkaXNjb3ZlcnkgY29udHJvbGxlcikgYnkgdGhlIHRpbWUKPj4+Pj4+IHRoYXQgdXNlcnNwYWNl
IGhhbmRsZXMgdGhlIGV2ZW50Lgo+Pj4+Pgo+Pj4+PiBUaGUgc2FtZSBpcyBnZW5lcmFsbHkgdHJ1
ZSBmb3IgbG90IG9mIGtlcm5lbCBkZXZpY2VzLsKgIFdlIGNvdWxkIHJlZHVjZQo+Pj4+PiB0aGUg
Y2hhbmNlIGJ5IHVzaW5nIHRoZSBpZHIgY3ljbGljIGFsbG9jYXRvci4KPj4+Pgo+Pj4+IFdlbGws
IGl0IHdhcyByYWlzZWQgYnkgSGFubmVzIGFuZCBKYW1lcywgc28gSSdsbCBhc2sgdGhlbSByZXNw
b25kIGhlcmUKPj4+PiBiZWNhdXNlIEkgZG9uJ3QgbWluZCBoYXZpbmcgaXQgdGhpcyB3YXkuIEkg
cGVyc29uYWxseSB0aGluayB0aGF0IHRoaXMKPj4+PiBpcyBhIGJldHRlciBhcHByb2FjaCB0aGFu
IGhhdmluZyBhIGN5Y2xpYyBpZHIgYWxsb2NhdG9yLiBJbiBnZW5lcmFsLCBJCj4+Pj4gZG9uJ3Qg
bmVjZXNzYXJpbHkgdGhpbmsgdGhhdCB0aGlzIGlzIGEgZ29vZCBpZGVhIHRvIGhhdmUgY3ljbGlj
Cj4+Pj4gY29udHJvbGxlciBlbnVtZXJhdGlvbnMgaWYgd2UgZG9uJ3QgYWJzb2x1dGVseSBoYXZl
IHRvLi4uCj4+Pgo+Pj4gV2UgaGl0IGl0IHJpZ2h0IGFuZCBsZWZ0IHdpdGhvdXQgdGhlIGN5Y2xp
YyBhbGxvY2F0b3IsIGJ1dCB0aGF0IHdvbid0Cj4+PiBuZWNlc3NhcmlseSByZW1vdmUgaXQuCj4+
Pgo+Pj4gUGVyaGFwcyB3ZSBzaG91bGQgaGF2ZSBoYWQgYSB1bmlxdWUgdG9rZW4gYXNzaWduZWQg
dG8gdGhlIGNvbnRyb2xsZXIsCj4+PiBhbmQgaGF2ZSB0aGUgZXZlbnQgcGFzcyB0aGUgbmFtZSBh
bmQgdGhlIHRva2VuLsKgIFRoZSBjbGkgd291bGQgdGhlbiwKPj4+IGlmIHRoZSB0b2tlbiBpcyBw
cmVzZW50LCB2YWxpZGF0ZSBpdCB2aWEgYW4gaW9jdGwgYmVmb3JlIHByb2NlZWRpbmcKPj4+IHdp
dGggb3RoZXIgaW9jdGxzLgo+Pj4KPj4+IFdoZXJlIGFsbCB0aGUgY29ubmVjdGlvbiBhcmd1bWVu
dHMgd2VyZSBhZGRlZCB3ZSBkdWUgdG8gdGhlIHJldXNlCj4+PiBpc3N1ZSBhbmQgdGhlbiBzb2x2
aW5nIHRoZSBxdWVzdGlvbiBvZiBob3cgdG8gdmVyaWZ5IGFuZC9vciBsb29rdXAKPj4+IHRoZSBk
ZXNpcmVkIGNvbnRyb2xsZXIsIGJ5IHVzaW5nIHRoZSBzaG90Z3VuIGFwcHJvYWNoIHJhdGhlciB0
aGFuCj4+PiBiZWluZyB2ZXJ5IHBvaW50ZWQsIHdoaWNoIGlzIHdoYXQgdGhlIG5hbWUvdG9rZW4g
d291bGQgZG8uCj4+Cj4+IFRoaXMgdW5pcXVlIHRva2VuIGlzOiB0cnR5cGU6dHJhZGRyOnRyc3Zj
aWQ6aG9zdC10cmFkZHIgLi4uCj4gCj4gd2VsbCB5ZXMgOinCoCB0aG91Z2ggcmF0aGVyIHZlcmJv
c2UuwqDCoCBUaGVyZSBpcyBzdGlsbCBhIG1pbnV0ZSB3aW5kb3cgYXMKPiB3ZSdyZSBjb21wYXJp
bmcgdmFsdWVzIGluIHN5c2ZzLCBwcmlvciB0byBvcGVuaW5nIHRoZSBkZXZpY2UsIHNvCj4gdGVj
aG5pY2FsbHkgc29tZXRoaW5nIGNvdWxkIGNoYW5nZSBpbiB0aGF0IHdpbmRvdyBiZXR3ZWVuIHdo
ZW4gd2UKPiBjaGVja2VkIHN5c2ZzIGFuZCB3aGVuIHdlIG9wZW4nZC7CoMKgIFdlIGNhbiBjZXJ0
YWluIGNoZWNrIGFmdGVyIHdlIG9wZW4KPiB0aGUgZGV2aWNlIHRvIHNvbHZlIHRoYXQgaXNzdWUu
Cj4gCj4gVGhlcmUgaXMgc29tZSBlbGVnYW5jZSB0byBhIDMyLWJpdCB0b2tlbiBmb3IgdGhlIGNv
bnRyb2xsZXIgKGNhbiBiZSBhbgo+IGluY3JlbWVudGluZyB2YWx1ZSkgcGFzc2VkIGluIHRoZSBl
dmVudCBhbmQgdXNlZCB3aGVuIHNlcnZpY2luZyB0aGUKPiBldmVudCB0aGF0IGF2b2lkcyBhIGJ1
bmNoIG9mIHdvcmsuCj4gCj4gRG9pbmcgZWl0aGVyIG9mIHRoZXNlIHdvdWxkIGVsaW1pbmF0ZSB3
aGF0IEhhbm5lcyBsaWtlZCAtIGxvb2tpbmcgZm9yCj4gdGhlIGRpc2NvdmVyeSBjb250cm9sbGVy
IHdpdGggdGhvc2UgYXR0cmlidXRlcy4gQWx0aG91Z2gsIEkgZG9uJ3Qga25vdwo+IHRoYXQgbG9v
a2luZyBmb3IgaXQgaXMgYWxsIHRoYXQgbWVhbmluZ2Z1bC4KPiAKeWVhaCwgd2UgZG8gaGF2ZSB0
aGlzIGZ1bmRhbWVudGFsIHByb2JsZW0gd2l0aCB1ZXZlbnRzOyB0aGV5IGRvIHJlZmVyIHRvCmEg
Jy9kZXYvbnZtZVgnIGRldmljZSB3aXRoIHRob3NlIHBhcmFtZXRlcnMsIGJ1dCB0aGlzIGRldmlj
ZSBtaWdodCBiZQpsb25nIGdvbmUgKG9yIGhhdmUgYmVlbiByZWFsbG9jYXRlZCkgYnkgdGhlIHRp
bWUgdGhlIGV2ZW50IGlzIHByb2Nlc3NlZC4KCkZyb20gbXkgUE9WIHdlIGhhdmUgdHdvIGNob2lj
ZXMgaGVyZToKLSByZWx5IG9uIHRoZSB0cmFuc3BvcnQgb3B0aW9ucyB0byBmaW5kIGEgbWF0Y2hp
bmcgY29udHJvbGxlciAoaWdub3JpbmcKdGhlIGRldmljZSBuYW1lKSBhbmQgdXNlIHRoYXQgZm9y
IHNlbmRpbmcgb3V0IGRpc2NvdmVyeSByZXF1ZXN0cy4gSW4gdGhlCmVuZCwgaXQgc2hvdWxkbid0
IHJlYWxseSBtYXR0ZXIgZGV2aWNlIHdlJ3JlIHVzaW5nIGlmIHRoZSB0cmFuc3BvcnQKb3B0aW9u
cyBhcmUgaWRlbnRpY2FsLiBBbHRob3VnaCBJJ20gbm90IHN1cmUgZm9yIFJETUE7IGhlcmUgd2Ug
ZG9uJ3QKbmVjZXNzYXJpbHkgaGF2ZSBhIGhvc3QgdHJhbnNwb3J0IGFkZHJlc3MsIHNvIHdlIF9t
aWdodF8gc2VuZCB0aGUKZGlzY292ZXJ5IHZpYSB0aGUgd3JvbmcgY29udHJvbGxlciBpbiBhIENN
SUMgZW52aXJvbWVudC4KLSBNYXRjaCB0aGUgb3B0aW9ucyBpbiBudm1lLWNsaSwgYW5kIGp1c3Qg
ZGlzY2FyZCB0aGUgZXZlbnQgaWYgaXQKZG9lc24ndCBtYXRjaC4gV2hpY2ggaXMgc29tZSBhZGRp
dGlvbmFsIGNvZGluZyBpbiBudm1lLWNsaSBhbmQgbWlnaHQgcmFuCmFmb3VsIGlmIHdlIGV2ZXIg
bWlzcyBldmVudHMuCgpJJ2QgZ28gZm9yIHRoZSBzZWNvbmQgb3B0aW9uOyBhZnRlciBjb25zaWRl
cmluZyB0aGUgZmlyc3QgaW50cm9kdWNlcyBmYXIKdG9vIG1hbnkgY29uZGl0aW9ucyByZW5kZXJp
bmcgZGVidWdnaW5nIGltcHJhY3RpY2FsLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2Uu
ZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MjQ3MTY1IChBRyBNw7xuY2hlbiksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
