Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FA5C4CECE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 15:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393D120663
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 15:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YyxG820/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393D120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fFgt4ZXCYpp4PUYSi5zeQ/Xbn7xbudok61XVwP5EwZ0=; b=YyxG820/dErrtH2z3pO3+Kl8i
	Nc+0AWwrF5KStLo+i91lBJo4ytkKqV9oIJKysynfwTnzxZfsm2uIY3GfD/nCIsKjlH0b+k045BIW0
	/aJDrdTsMAQqdRCWC6zaqczv2FXmLvUdZSCNUA2U/auX3VoOu/d82EfnBkATyi54KSWh9fKkypEUA
	T+r7CftN/8R+gnIw0NJoP/4wVIBGJoLmL/IL4HO7KdrgGv59L+d+Y+FRAByMpi6fHnGAKhrbhr/Qx
	6lfnN+GhbMsGtSv4xAFN50eoV5WeVDR5JTC5g7Ik7Jt88Ci38jA4UQKBzsPwWzZ8y9SQxHdjKoIZH
	ru1X2K+qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEEJC-0003ts-Fr; Tue, 17 Mar 2020 15:39:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEEJ9-0003so-3d
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 15:39:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BAE2EACB5;
 Tue, 17 Mar 2020 15:39:03 +0000 (UTC)
Subject: Re: [PATCH] nvme: stop mad sqsize increasing and decreasing
To: Christoph Hellwig <hch@lst.de>
References: <20200313124410.39193-1-hare@suse.de>
 <20200317124919.GD12316@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d4a5862e-ca27-a07e-75f0-1a9c470daea4@suse.de>
Date: Tue, 17 Mar 2020 16:38:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317124919.GD12316@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_083907_295012_C2A145F4 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xNy8yMCAxOjQ5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmksIE1h
ciAxMywgMjAyMCBhdCAwMTo0NDoxMFBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IFRoZSBOVk1lIHNwZWMgb25seSBzdGF0ZXM6Cj4+Cj4+ICJPbmUgc2xvdCBpbiBlYWNoIHF1ZXVl
IGlzIG5vdCBhdmFpbGFibGUgZm9yIHVzZSBkdWUgdG8gSGVhZCBhbmQKPj4gVGFpbCBlbnRyeSBw
b2ludGVyIGRlZmluaXRpb24uIgo+Pgo+PiBJdCBkb2VzIG5vdCBzYXkgdGhhdCB0aGUgYWN0dWFs
IHF1ZXVlIHNpemUgbmVlZHMgdG8gZGVjcmVtZW50ZWQKPj4gYnkgb25lLCBpdCBqdXN0IG1lYW5z
IHRoYXQgd2UnbGwgaGF2ZSB0byBsZWF2ZSBvbmUgc2xvdCBmcmVlLgo+PiBTbyBraWxsIHRoZSBt
YWQgZGVjcmVhc2luZyBhbmQgaW5jcmVhc2luZyBvZiBzcXNpemUsIGxlYXZlIGl0Cj4+IGF0IHRo
ZSBzcGVjaWZpZWQgc2l6ZSwgYW5kIG9ubHkgZGVjcmVtZW50IHRoZSB0YWdzZXQgYnkgb25lIHRv
Cj4+IGVuc3VyZSB3ZSBsZWF2ZSBvbmUgc2xvdCBmcmVlLgo+IAo+IE5vdCBzdXJlIHdoYXQgaXMg
bWFkIGhlcmUuICBBbGwgdGhlICpxc2l6ZSB2YWx1ZXMgYXJlIDBzIGJhc2VkCj4gdmFsdWVzIG9u
IHRoZSB3aXJlLCBzbyB0aGUgb24gdGhlIHdpcmUgdmFsdWUgbmVlZCB0byBiZSBvbmUKPiBsb3dl
ciB0aGFuIHRoZSBwcm9wZXIgdmFsdWUuCj4gCj4gTWF5YmUgd2UgbmVlZCB0bzBzYiAvIGZyb20w
c2IgaGVscGVycyB0byBkb2N1bWVudCB0aGVzZSBhbm5veWluZwo+IHRoaW5ncyBhIGxpdHRsZSBi
ZXR0ZXI/ICAoJSNeI1lAJCBOVk1lIGRlc2lnbmVycyBmb3IgYnVyZGVuaW5nCj4gdXMgd2l0aCB0
aGlzIGJ1bGxzaGl0Li4pCj4gClllcywgdGhhdCBpcyBhIGdvb2QgcG9pbnQuCldpbGwgYmUgZG9p
bmcgc28gZm9yIHRoZSBuZXh0IHVwZGF0ZS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5l
cyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1l
bmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
