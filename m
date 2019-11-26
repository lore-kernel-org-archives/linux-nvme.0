Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A2C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:28:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A17C2071A
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JVaRNIuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A17C2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RhN9uA6b9/B7lBH0Q3ajYi2grCS48GvqGl4XfrO76l0=; b=JVaRNIuVVw+DmxYFVjgGDMiyR
	jZCwUR08qh9EMnvlSe0HaAK8upWTqj3a/T5dFNr46HXQNnuSw7Js295UIElH0NMpt0gdRjASh7JWv
	1azYxAP4DK7Sov9jvmPwNbDmGoZxZDseZfKthf57sdErpdoRCXPkxCGr2UVTbq+d3D7zfw/8wGjHU
	sHR4YBWB3CA4MS05jcUm6E3fMpo0tE1nHfSASATSia+2TgISYvuIgEFU6fCHaYBBgntbLPLXrwnrX
	7LpCeTf2xTb9ZA/79vIsi8dNn6zrmsTalDegCoh5QFkTgKD5wCgGeFSRokp6vaq61/HUsNQyBjVQG
	jtcA7zUrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZdhm-0003XJ-Ka; Tue, 26 Nov 2019 16:28:46 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZdhi-0003Wo-C0
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 16:28:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A69DFAE3F;
 Tue, 26 Nov 2019 16:28:40 +0000 (UTC)
Subject: Re: [PATCH] nvme: always treat DNR status as no-retryable
To: Christoph Hellwig <hch@lst.de>
References: <20191126133749.72267-1-hare@suse.de>
 <20191126162206.GB7562@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a372f5a8-9510-bb8a-9eb4-4777e5518857@suse.de>
Date: Tue, 26 Nov 2019 17:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126162206.GB7562@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_082843_580769_BE475F78 
X-CRM114-Status: GOOD (  17.99  )
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
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjYvMTkgNToyMiBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBO
b3YgMjYsIDIwMTkgYXQgMDI6Mzc6NDlQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
PiBJZiB0aGUgRE5SIGJpdCBpcyBzZXQgaW4gdGhlIGNvbW1hbmQgc3RhdHVzIHdlIHNob3VsZCBu
b3QgcmV0cnkKPj4gdGhlIGNvbW1hbmQsIGlycmVzcGVjdGl2ZSBvZiB3aGF0IHRoZSBhY3R1YWwg
c3RhdHVzIGlzLgo+PiBTbyBtYXAgaXQgZGlyZWN0bHkgdG8gQkxLX1NUU19UQVJHRVQgdG8gaW5m
b3JtIHVwcGVyIGxheWVycyB0bwo+PiBub3QgcmV0cnkgdGhlIGNvbW1hbmQsIG5vdCBldmVuIG9u
IGFub3RoZXIgcGF0aC4KPiAKPiBXZSd2ZSBiZWVuIHRoZXJlIGJlZm9yZSwgaGF2ZSB3ZT8gIFdo
YXQgaXMgeW91ciB1c2UgY2FzZS4gIEkuZS4KPiB3aGF0IHBhcnQgb2YgdGhlIGtlcm5lbCBpcyBy
ZXRyeWluZyB3aGF0IGNvbW1hbmQgdGhhdCB5b3UgZG9uJ3QKPiB3YW50IHRvIGJlIHJldHJpZWQ/
Cj4gCkVHIE5hbWVzcGFjZSBub3QgcmVhZHkuClNvbWUgTmV0QXBwIGFycmF5cyByZXR1cm4gIm5h
bWVzcGFjZSBub3QgcmVhZHkiIGZvciBlaXRoZXIgYSB0ZW1wb3JhcnkgCmlzc3VlIChlZyBkdXJp
bmcgYXJyYXkgZmFpbG92ZXIgb3Igd2hhdG5vdCksIGFuZCB0aGVuIHdpbGwgaGF2ZSB0aGUgRE5S
IApiaXQgbm90IHNldCAoYXMgeW91IGNhbiByZXRyeSwgYW5kIGV2ZW50dWFsbHkgdGhlIG5hbWVz
cGFjZSB3aWxsIGJlY29tZSAKcmVhZHkpLiBPciB0aGV5IHJldHVybiAnbmFtZXBhY2Ugbm90IHJl
YWR5JyBmb3IgY2FzZXMgd2hlcmUgdGhlIApuYW1lc3BhY2UgaGFzIGJlZW4gdW5tYXBwZWQsIGZv
ciB3aGljaCBpcyByZXRyeSBpcyBwb2ludGxlc3MsIGFuZCBoZW5jZSAKaGF2ZSB0aGUgRE5SIGJp
dCBzZXQuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAg
ICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIExJTlVYIEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBNYXJ5IEhp
Z2dpbnMsIFNyaSBSYXNpYWgKSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlz
dApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
