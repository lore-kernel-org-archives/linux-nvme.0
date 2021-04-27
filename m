Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12572C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:33:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669956100B
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669956100B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=86WZkb7XpWVX9N4pX1hJ3uRc4oAAWHmZlpw38s9vTL4=; b=PT1H5DLcqYfgK/AO/JFM/xeKX
	rpAxKC+yDPDC5b8bmyPoTX819E1Y5+Dl5TZ+LuWATq+bCa2+XHcu6x+UAMvoCahJwlT1s1/M8NCYN
	g+jZh0L4K4PxchgYpCN+CmXB7l4Vu28si9uO2cLhY8eTmedrP4sNL/Mx03R1N7SNiWdAobqjegoNV
	MpusA25LSdUdfYMzEcPokXY5u1q+q2qQrOYZlphXimmaht85i4ER6EGCRQIh7sMYKs2zdeHIBvz6r
	qcpvwheW/jwxR8wpuAe7TVCy6n5qLQJ0Z5mdBjH2983sKRQVn8qR8FP1Z4ITyrPkzq6jOhq75t/Im
	niJsKo8wg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbK5g-001EJa-O2; Tue, 27 Apr 2021 09:33:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbK5f-001EJL-1C
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 09:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=L8OGHipiR4DtzdDcgXfnoTCAjp1RUxdQTIB91yI/wJ8=; b=SEKXPxob5wv081L+hSqLKgTz5V
 hsSqJb9u5MphNw5EN87Ng1sApcA81UH6JYZ3htqe+Knp4mYVnp/U96+V7DXVynWlx0CaddTxH6zdM
 oVsR/IIxEdk4IffNcZQwws3q42Pt64cHkjvdA/ZCkOc5a3MsQpBQCl10bCYqcDCiiTVKFirNMWa1r
 bcBmZk8FsXIuu5Jm462TZmRiamfINgXf0bdoThRyAPfA8ACV6PclVuoDkf3Fb85uho8vC9/CSE/os
 H87WdCrwKhogzVX036mqWKLFpZMHXpXI2sjDRiVee3nJ6SXobP9sdy3bHV9uDetOI8YOm1q+DwStW
 9kXaW6Zw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbK5c-00GaKw-AA
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 09:33:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 44760B13E;
 Tue, 27 Apr 2021 09:33:05 +0000 (UTC)
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chao Leng <lengchao@huawei.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
References: <20210427085246.13728-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
Date: Tue, 27 Apr 2021 11:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210427085246.13728-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_023308_521776_8E9FE2D2 
X-CRM114-Status: GOOD (  25.69  )
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

T24gNC8yNy8yMSAxMDo1MiBBTSwgbXdpbGNrQHN1c2UuY29tIHdyb3RlOgo+IEZyb206IE1hcnRp
biBXaWxjayA8bXdpbGNrQHN1c2UuY29tPgo+IAo+IFdlIGhhdmUgb2JzZXJ2ZWQgYSBmZXcgY3Jh
c2hlcyBydW5fdGltZXJfc29mdGlycSgpLCB3aGVyZSBhIGJyb2tlbgo+IHRpbWVyX2xpc3Qgc3Ry
dWN0IGJlbG9uZ2luZyB0byBhbiBhbmF0dF90aW1lciB3YXMgZW5jb3VudGVyZWQuIFRoZSBicm9r
ZW4KPiBzdHJ1Y3R1cmVzIGxvb2sgbGlrZSB0aGlzLCBhbmQgd2Ugc2VlIGFjdHVhbGx5IG11bHRp
cGxlIG9uZXMgYXR0YWNoZWQgdG8KPiB0aGUgc2FtZSB0aW1lciBiYXNlOgo+IAo+IGNyYXNoPiBz
dHJ1Y3QgdGltZXJfbGlzdCAweGZmZmY5MjQ3MWJjZmRjOTAKPiBzdHJ1Y3QgdGltZXJfbGlzdCB7
Cj4gICBlbnRyeSA9IHsKPiAgICAgbmV4dCA9IDB4ZGVhZDAwMDAwMDAwMDEyMiwgIC8vIExJU1Rf
UE9JU09OMgo+ICAgICBwcHJldiA9IDB4MAo+ICAgfSwKPiAgIGV4cGlyZXMgPSA0Mjk2MDIyOTMz
LAo+ICAgZnVuY3Rpb24gPSAweGZmZmZmZmZmYzA2ZGU1ZTAgPG52bWVfYW5hdHRfdGltZW91dD4s
Cj4gICBmbGFncyA9IDIwCj4gfQo+IAo+IElmIHN1Y2ggYSB0aW1lciBpcyBlbmNvdW50ZXJlZCBp
biBydW5fdGltZXJfc29mdGlycSgpLCB0aGUga2VybmVsCj4gY3Jhc2hlcy4gVGhlIHRlc3Qgc2Nl
bmFyaW8gd2FzIGFuIEkvTyBsb2FkIHRlc3Qgd2l0aCBsb3RzIG9mIE5WTWUKPiBjb250cm9sbGVy
cywgc29tZSBvZiB3aGljaCB3ZXJlIHJlbW92ZWQgYW5kIHJlLWFkZGVkIG9uIHRoZSBzdG9yYWdl
IHNpZGUuCj4gCj4gSSB0aGluayB0aGlzIG1heSBoYXBwZW4gaWYgdGhlIHJkbWEgcmVjb3Zlcnlf
d29yayBzdGFydHMsIGluIHRoaXMgY2FsbAo+IGNoYWluOgo+IAo+IG52bWVfcmRtYV9lcnJvcl9y
ZWNvdmVyeV93b3JrKCkKPiAgIC8qIHRoaXMgc3RvcHMgYWxsIHNvcnRzIG9mIGFjdGl2aXR5IGZv
ciB0aGUgY29udHJvbGxlciwgYnV0IG5vdAo+ICAgICAgdGhlIG11bHRpcGF0aC1yZWxhdGVkIHdv
cmsgcXVldWUgYW5kIHRpbWVyICovCj4gICBudm1lX3JkbWFfcmVjb25uZWN0X29yX3JlbW92ZShj
dHJsKQo+ICAgICA9PiBraWNrcyByZWNvbm5lY3Rfd29yawo+IAo+IHdvcmsgcXVldWU6IHJlY29u
bmVjdF93b3JrCj4gCj4gbnZtZV9yZG1hX3JlY29ubmVjdF9jdHJsX3dvcmsoKQo+ICAgbnZtZV9y
ZG1hX3NldHVwX2N0cmwoKQo+ICAgICBudm1lX3JkbWFfY29uZmlndXJlX2FkbWluX3F1ZXVlKCkK
PiAgICAgICAgbnZtZV9pbml0X2lkZW50aWZ5KCkKPiAgICAgICAgICAgbnZtZV9tcGF0aF9pbml0
KCkKPiAJICAgICAjIHRoaXMgc2V0cyBzb21lIGZpZWxkcyBvZiB0aGUgdGltZXJfbGlzdCB3aXRo
b3V0IHRha2luZyBhIGxvY2sKPiAgICAgICAgICAgICAgdGltZXJfc2V0dXAoKQo+ICAgICAgICAg
ICAgICBudm1lX3JlYWRfYW5hX2xvZygpCj4gCSAgICAgICAgIG1vZF90aW1lcigpIG9yIGRlbF90
aW1lcl9zeW5jKCkKPiAKPiBTaW1pbGFyIGZvciBUQ1AuIFRoZSBpZGVhIGZvciB0aGUgcGF0Y2gg
aXMgYmFzZWQgb24gdGhlIG9ic2VydmF0aW9uIHRoYXQKPiBudm1lX3JkbWFfcmVzZXRfY3RybF93
b3JrKCkgY2FsbHMgbnZtZV9zdG9wX2N0cmwoKS0+bnZtZV9tcGF0aF9zdG9wKCksCj4gd2hlcmVh
cyBudm1lX3JkbWFfZXJyb3JfcmVjb3Zlcnlfd29yaygpIHN0b3BzIG9ubHkgdGhlIGtlZXBhbGl2
ZSB0aW1lciwgYnV0Cj4gbm90IHRoZSBhbmF0dCB0aW1lci4KPiAKPiBJIGFkbWl0IHRoYXQgdGhl
IHJvb3QgY2F1c2UgYW5hbHlzaXMgaXNuJ3Qgcm9jayBzb2xpZCB5ZXQuIEluIHBhcnRpY3VsYXIs
IEkKPiBjYW4ndCBleHBsYWluIHdoeSB3ZSBzZWUgTElTVF9QT0lTT04yIGluIHRoZSAibmV4dCIg
cG9pbnRlciwgd2hpY2ggd291bGQKPiBpbmRpY2F0ZSB0aGF0IHRoZSB0aW1lciBoYXMgYmVlbiBk
ZXRhY2hlZCBiZWZvcmU7IHlldCB3ZSBmaW5kIGl0IGxpbmtlZCB0bwo+IHRoZSB0aW1lciBiYXNl
IHdoZW4gdGhlIGNyYXNoIG9jY3Vycy4KPiAKPiBPVE9ILCB0aGUgYW5hdHRfdGltZXIgaXMgb25s
eSB0b3VjaGVkIGluIG52bWVfbXBhdGhfaW5pdCgpIChzZWUgYWJvdmUpIGFuZAo+IG52bWVfbXBh
dGhfc3RvcCgpLCBzbyB0aGUgaHlwb3RoZXNpcyB0aGF0IG1vZGlmeWluZyBhY3RpdmUgdGltZXJz
IG1heSBjYXVzZQo+IHRoZSBpc3N1ZSBpc24ndCB0b3RhbGx5IG91dCBvZiBzaWdodC4gSSBzdXNw
ZWN0IHRoYXQgdGhlIExJU1RfUE9JU09OMiBtYXkKPiBjb21lIHRvIHBhc3MgaW4gbXVsdGlwbGUg
c3RlcHMuCj4gCj4gSWYgYW55b25lIGhhcyBiZXR0ZXIgaWRlYXMsIHBsZWFzZSBhZHZpc2UuIFRo
ZSBpc3N1ZSBvY2N1cnMgdmVyeQo+IHNwb3JhZGljYWxseTsgdmVyaWZ5aW5nIHRoaXMgYnkgdGVz
dGluZyB3aWxsIGJlIGRpZmZpY3VsdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gV2lsY2sg
PG13aWxja0BzdXNlLmNvbT4KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmlt
YmVyZy5tZT4KPiBSZXZpZXdlZC1ieTogQ2hhbyBMZW5nIDxsZW5nY2hhb0BodWF3ZWkuY29tPgo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gCkFzIGluZGljYXRlZCBpbiBteSBwcmV2aW91
cyBtYWlsLCBwbGVhc2UgY2hhbmdlIHRoZSBkZXNjcmlwdGlvbi4gV2UgaGF2ZQpzaW5jZSBlc3Rh
Ymxpc2hlZCBhIGFjdHVhbCByZWFzb24gKGR1cGxpY2F0ZSBjYWxscyB0byBhZGRfdGltZXIoKSks
IHNvCnBsZWFzZSBsaXN0IGl0IGhlcmUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJ
CSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
