Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1380BC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:01:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3B2207FB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C7TGVBXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3B2207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OgQgE1xaQ7Gy0mcRcVHmqWUrG4SlglZFTOCkYd5mHsY=; b=C7TGVBXll1c9++KMSq6V9ShhJq
	5bv/GxJBCGizIR+Yes175LedXYzxnqu5NrbRnVx3SdoPfOZrOlfyYfhpFnXcDUyyJyjTAwm2qyo04
	kPdZBbEBbQXEuGNJy327bk/ar8fNF9I6zRktbt6aAzkb627p5juTEG5l7+FcNtmMI6qDxpljQ33NM
	m9DRMyIodzCHp8o26sluOw5gapOAAg4kGFphe5qeFh+2sd99AnFE5qMh53nghvGiXjiCCZ0NdJly/
	Aptu5dW7BPG7FATEHL5GGOmRESM6Snjyr7zodFbSrW75I7zleGKgntjut5GhDy0VC9GsSeoAC3h1J
	Ok+136iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb2ng-0005ZR-8U; Tue, 19 May 2020 14:00:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2nd-0005Yx-3c
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:00:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4DE58ABE2;
 Tue, 19 May 2020 14:00:52 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
Subject: RFC: FC-NVMe boot from SAN
To: James Smart <james.smart@broadcom.com>
Message-ID: <a3175c29-4fcc-ec4d-842b-d45645695ab0@suse.de>
Date: Tue, 19 May 2020 16:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_070053_441588_129FA9F7 
X-CRM114-Status: GOOD (  18.77  )
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
Cc: Robert Friend <rfriend@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgYWxsLAoKSSd2ZSBoYWQgZGlzY3Vzc2lvbnMgd2l0aCB2YXJpb3VzIHZlbmRvcnMgb24gaG93
IHdlIGNvdWxkIGVuYWJsZSBGQy1OVk1lIApib290IGZyb20gU0FOLiBSYXRpb25hbGUgaXMgdGhh
dCB0cmFkaXRpb25hbCBGQyBIQkFzIGhhdmUgaGFkIHRoZSAKY2FwYWJpbGl0aWVzIHRvIGJvb3Qg
ZnJvbSBTQU4sIHNvIGZvciBmZWF0dXJlIHBhcml0eSBhbmQgY3VzdG9tZXIgCnJlcXVlc3RzIEZD
LU5WTWUgSEJBcyB3b3VsZCBuZWVkIHRvIGJvb3QgZnJvbSBTQU4sIHRvby4KCldoaWxlIHRoaXMg
aXMgbm90IGEgdGVjaG5pY2FsIHByb2JsZW0gKGp1c3QgYWRkIG52bWUtY2xpIHRvIHRoZSBpbml0
cmQpLCAKdGhlIGFkbWluaXN0cmF0aXZlIHByb2JsZW0gb2YgY29ycmVjdGx5IHNldHRpbmcgdXAg
dGhlIE5WTWUgY29udHJvbGxlciAKcmVtYWlucyBvcGVuLgoKRm9yIHRoZSBpbml0aWFsIGRpc2Nv
dmVyeSBudm1lLWNsaSByZXF1aXJlcyBhIGhvc3QgTlFOIGFuZCBhIGhvc3QgSUQ7IAp0aGVzZSB2
YWx1ZXMgZGVmaW5lIHdoaWNoIG5hbWVzcGFjZXMgd2lsbCBiZSB2aXNpYmxlIGZyb20gdGhlIHRh
cmdldC4KV2hlbiBib290aW5nIGZyb20gU0FOIHdlIGhhdmUgdGhlIHByb2JsZW0gdGhhdCB0aGUg
TlZNZSBjb25uZWN0aW9ucyBuZWVkIAp0byBiZSBlc3RhYmxpc2hlZCBmcm9tIHR3byBkaXN0aW5j
dCBlbnZpcm9ubWVudHM6Ci0gVUVGSSBib290IGVudmlyb25tZW50IGZvciBjcmVhdGluZyB0aGUg
aW5pdGlhbCBjb25uZWN0aW9uIGFuZCBsb2FkIHRoZSAKa2VybmVsIC8gYm9vdGxvYWRlcgotIExp
bnV4IGRyYWN1dCwgZm9yIGNyZWF0aW5nIHRoZSBjb25uZWN0aW9uIGZvciB0aGUgcm9vdCBmcyBh
bmQgYm9vdCB0aGUgCnN5c3RlbS4KCkFzIGl0IHN0YW5kcyB0aGVyZSBjdXJyZW50bHkgaXMgbm8g
bWVjaGFuaXNtIHRvIHRyYW5zZmVyIHRoZSBOVk1lIApwYXJhbWV0ZXJzIGZyb20gb25lIGVudmly
b25tZW50IHRvIHRoZSBvdGhlci4gWWV0IHRoZXNlIHBhcmFtZW50ZXJzIG5lZWQgCnRvIGJlIGlk
ZW50aWNhbCAob3IgbmVlZCB0byByZXN1bHQgaW4gdGhlIHNhbWUgbmFtZXNwYWNlcyB0byBiZSB2
aXNpYmxlKQpmb3IgYSBzdWNjZXNzZnVsIGJvb3QgZnJvbSBTQU4uCgpUbyBmYWNpbGl0YXRlIHRo
aXMgaGVyZSdzIGEgcHJvcG9zYWwgaG93IHdlIGNvdWxkIGF0dGVtcHQgYm9vdCBmcm9tIFNBTjoK
ClN0ZXAgMSkgUmVxdWlyZSB0aGUgYWRtaW4gdG8gcHJvdmlkZSBpZGVudGljYWwgcGFyYW1ldGVy
cyBpbiBib3RoIAplbnZpcm9ubWVudHMuIFRoaXMgaXMgcHJldHR5IG9idmlvdXMsIGJ1dCB0aGVu
IGl0IHdvdWxkIHJlcXVpcmUgdGhlIAphZG1pbiB0byBlaXRoZXIgdXNlIHRoZSBwYXJhbWV0ZXJz
IGZyb20gdGhlIFVFRkkgYm9vdCBlbnZpcm9ubWVudCB0byAKY3JlYXRlIHRoZSAvZXRjL252bWUv
aG9zdG5xbiBhbmQgL2V0Yy9ob3N0aWQgb24gdGhlIExpbnV4IHNpZGUsIG9yIHVzZSAKdGhlIExp
bnV4IHBhcmFtZXRlcnMgdG8gaW5pdGlhbGl6ZSB0aGUgVUVGSSBib290IGVudmlyb21lbnQuCkFz
IEkgY2FuJ3QgbWFrZSBhbnkgYXNzdW1wdGlvbnMgYWJvdXQgdGhlIGNhcGFiaWxpdGllcyBvZiB0
aGUgVUVGSSBib290CmVudmlyb25tZW50IEkgY2Fubm90IG1ha2UgcmVjb21tZW5kYXRpb25zIGVp
dGhlciB3YXkuClRoaXMgc3RlcCBoYXMgdGhlIGFkdmFudGFnZSBvZiByZXF1aXJpbmcgbGl0dGxl
IHRvIG5vbmUgbW9kaWZpY2F0aW9ucwp0byB0aGUgZXhpc3RpbmcgdG9vbGluZywgYnV0IHRoZSBi
aWcgZGlzYWR2YW50YWdlIG9mIHBsYWNpbmcgdGhlIGJ1cmRlbgpvbiB0aGUgYWRtaW4uCgpTdGVw
IDIpIEFncmVlIG9uIGEgY29tbW9uIG1ldGhvZCBmb3IgZ2VuZXJhdGluZyB0aGUgTlZNZSBwYXJh
bWV0ZXJzLgpGb3IgbnZtZS1jbGkgd2UgYWxyZWFkeSB1c2UgdGhlIHN5c3RlbSBVVUlEIHRvIGdl
bmVyYXRlIAovZXRjL252bWUvaG9zdG5xbjsgd2UgY291bGQgc2ltaWxhcmx5IHVzZSB0aGUgc3lz
dGVtIFVVSUQgdG8gZ2VuZXJhdGUgCi9ldGMvbnZtZS9ob3N0aWQsIHRvby4gUmVjb21tZW5kYXRp
b24gdG8gdGhlIFVFRkkgYm9vdCBST00gdmVuZG9ycyB3b3VsZCBub3cKdG8gZm9sbG93IHN1aXQs
IHJlc3VsdGluZyBpbiBpZGVudGljYWwgcGFyYW1ldGVycyBpbiBib3RoIGVudmlyb21lbnRzLgpU
aGlzIGFnYWluIHJlcXVpcmVzIGJhc2ljYWxseSBubyBtb2RpZmljYXRpb25zIHRvIHRoZSBleGlz
dGluZyB0b29saW5nLApidXQgaGFzIHRoZSBkcmF3YmFjayB0aGF0IG9uZSBjYW5ub3QgZWFzaWx5
IGNoYW5nZSB0aGVzZSBwYXJhbWV0ZXJzLgoKU3RlcCAzKSBBZ3JlZSBvbiBhIHNldCBvZiBVRUZJ
IGJvb3QgdmFyaWFibGVzIHRvIHN0b3JlIHRoZSBwYXJhbWV0ZXJzClVFRkkgYWxyZWFkeSBoYXMg
YSBzZXQgb2YgdmFyaWFibGVzLCB3aGljaCB0byBteSBrbm93bGVkZ2UgY2FuIGJlIApjcmVhdGVk
IGJ5IHRoZSBVRUZJIGJvb3QgUk9NIGFuZCBhcmUgcGVyc2lzdGVudCBiZXR3ZWVuIGJvdGggCmVu
dmlyb25tZW50cywgcG9zc2libHkgZXZlbiBhY3Jvc3MgcmVib290cy4gUmVjb21tZW5kYXRpb24g
aXMgdG8KYWdyZWUgb24gYSBzZXQgb2YgVUVGSSB2YXJpYWJsZXMgd2hpY2ggYXJlIGFjY2Vzc2li
bGUgZnJvbSBib3RoIAplbnZpcm9ubWVudHMsIGFsbG93aW5nIHVzIHRvIHBhc3MgaW5mb3JtYXRp
b24gYmFjayBhbmQgZm9ydGguClRoaXMgb2J2aW91c2x5IHJlcXVpcmVzIHRoZSBtb3N0IGludGVy
YWN0aW9uLCBhbmQgYWxzbyBidXktaW4gZnJvbSB0aGUgClVFRkkgb3JnYW5pc2F0aW9uLCB0b28u
CgpIZW5jZSBJIHdvdWxkIHByb3Bvc2UgdGhpcyBhcyB0aGUgZmluYWwgc3RlcCBvbmNlIFN0ZXAg
MSkgYW5kIFN0ZXAgMikgCmhhdmUgYmVlbiBhZ3JlZWQgdXBvbi4KCkFzIHVzdWFsLCBmZWVkYmFj
ayBhbmQgY29tbWVudHMgYXJlIHdlbGNvbWUuCgpBbmQgaWYgeW91IGZpbmQgdGhhdCB0aGUgbGlu
dXggbnZtZSBtYWlsaW5nIGxpc3QgaXMgbm90IHRoZSBhcHByb3ByaWF0ZSAKdmVudWUgdG8gZGlz
Y3VzcyB0aGlzIHBsZWFzZSBwb2ludCBtZSB0aGUgYSBiZXR0ZXIgc3VpdGVkIG9uZS4KCkNoZWVy
cywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0
b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
