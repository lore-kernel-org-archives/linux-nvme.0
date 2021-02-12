Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4906C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 12:47:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F1964E16
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 12:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F1964E16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pVgLKJ2jqcecdTCM3QDOjt6OzNyeRqZBH+/7Wdk5r4E=; b=LoULBvoyxn9b6QpnNOQ9ozOOW
	pUE7MDRPE9ou1fPfAbKOSsrwYXUFx537Q1IrZNl3yM7BDXLm5rZQBAmuI/5FkS0AoaKjUrHiJ6z/x
	8VKUA3jQw4eJvcJuRDZyhiEgXFAiTZiLM7ZCp5d2Jco6SF8jqedpZcukMuou+NahysR3BB9MIu+Bk
	K0P5swCe9Wh7sWp2VMksqIJONQlcpfmcR8DXjjbK/SH3M9ZT541POKaiQ5Oe9JHCQtk11SyHzVJUh
	CKN5DGlz600q5sniarHXC/eJPk6fgvdfY4eZOx6IZ/aMBgxZT9wzpmiCz86jIo4IaxgQOkkItcKVW
	iflwjGADA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAXql-0005M1-UB; Fri, 12 Feb 2021 12:47:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAXqg-0005Kv-IQ
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 12:47:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E648BAC69;
 Fri, 12 Feb 2021 12:46:59 +0000 (UTC)
Subject: Re: [PATCH] nvme/hwmon: Return error code when registration fails
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20210212093015.2846-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a58de23b-40c2-4534-cae0-36b1e42f2d45@suse.de>
Date: Fri, 12 Feb 2021 13:46:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212093015.2846-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_074702_740012_3C2144A3 
X-CRM114-Status: GOOD (  25.50  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xMi8yMSAxMDozMCBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBUaGUgaHdtb24gcG9p
bnRlciB3b250IGJlIE5VTEwgaWYgdGhlIHJlZ2lzdHJhdGlvbiBmYWlscy4gVGhvdWdoIHRoZQo+
IGV4aXQgY29kZSBwYXRoIHdpbGwgYXNzaWduIGl0IHRvIGN0cmwtPmh3bW9uX2RldmljZS4gTGF0
ZXIKPiBudm1lX2h3bW9uX2V4aXQoKSB3aWxsIHRyeSB0byBmcmVlIHRoZSBpbnZhbGlkIHBvaW50
ZXIuIEF2b2lkIHRoaXMgYnkKPiByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUgZnJvbSBod21vbl9k
ZXZpY2VfcmVnaXN0ZXJfd2l0aF9pbmZvKCkuCj4gCj4gRml4ZXM6IGVjNDIwY2RjZmFiNCAoIm52
bWUvaHdtb246IHJld29yayB0byBhdm9pZCBkZXZtIGFsbG9jYXRpb24iKQo+IENjOiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxk
d2FnbmVyQHN1c2UuZGU+Cj4gLS0tCj4gCj4gVGhpcyBwYXRjaCBpcyBhZ2FpbnN0IGxpbnV4LWJs
b2NrL2Zvci1uZXh0Lgo+IAo+ICAgZHJpdmVycy9udm1lL2hvc3QvaHdtb24uYyB8IDEgKwo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L2h3bW9uLmMgYi9kcml2ZXJzL252bWUvaG9zdC9od21vbi5jCj4gaW5kZXggOGY5
ZTk2OTg2NzgwLi4wYTU4NmQ3MTI5MjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
aHdtb24uYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMKPiBAQCAtMjQ4LDYgKzI0
OCw3IEBAIGludCBudm1lX2h3bW9uX2luaXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAgIAlp
ZiAoSVNfRVJSKGh3bW9uKSkgewo+ICAgCQlkZXZfd2FybihkZXYsICJGYWlsZWQgdG8gaW5zdGFu
dGlhdGUgaHdtb24gZGV2aWNlXG4iKTsKPiAgIAkJa2ZyZWUoZGF0YSk7Cj4gKwkJcmV0dXJuIFBU
Ul9FUlIoaHdtb24pOwo+ICAgCX0KPiAgIAljdHJsLT5od21vbl9kZXZpY2UgPSBod21vbjsKPiAg
IAlyZXR1cm4gMDsKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRl
PgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
