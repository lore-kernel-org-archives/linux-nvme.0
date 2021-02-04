Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A71C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:06:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAE664E4D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAE664E4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5huBRWf13/kMi/ai4JZN1f1tvcaiM4oywHd748AhpgI=; b=w8uCQoAolQ0hfChrgsXx3vKJ7
	rqv3U551C6ir637hiJWTW4ZZ3d+JlZclLcoLcC1TzhhATt6iVianEhbNHvYoONUJXrCQlZww6RMM/
	VeLZ7iSFyqFfc+SEbe27+YtYAoqM5oqbB+pnIlbA7KY+oFaVZoi7jauqLKXwx+jz7pwrf0ZbWR61Z
	Pfuw5Oy13S6KHFQOfnR0/3XQYstfu5wGHwk8qOzY5Yi3pNwOFZLzv2TAk0+Nejmp8TMtXxj5eedDg
	b9+UxC9KeUsDAYgoZgiVEwb0kGfSLQQvVHC+bDGWP/rdOhMx1mIqXNxauBgem49uvjGJknxylaw9z
	68x01no8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YiC-0004Gv-8g; Thu, 04 Feb 2021 07:05:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Yi9-0004FN-3v
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:05:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 01583ABD5;
 Thu,  4 Feb 2021 07:05:52 +0000 (UTC)
Subject: Re: [PATCH 09/35] nvme_get_ctrl_attr(): constify "path" argument
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-10-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3240d983-2b54-b196-a801-b1c54059e486@suse.de>
Date: Thu, 4 Feb 2021 08:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-10-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_020553_639544_ABD6C5FC 
X-CRM114-Status: GOOD (  19.86  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNi8yMSA5OjMyIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdpbGNr
IDxtd2lsY2tAc3VzZS5jb20+Cj4gLS0tCj4gICBudm1lLXRvcG9sb2d5LmMgfCAyICstCj4gICBu
dm1lLmggICAgICAgICAgfCAyICstCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbnZtZS10b3BvbG9neS5jIGIvbnZt
ZS10b3BvbG9neS5jCj4gaW5kZXggNzEzNzFjNS4uZjYyNDQ2YiAxMDA2NDQKPiAtLS0gYS9udm1l
LXRvcG9sb2d5LmMKPiArKysgYi9udm1lLXRvcG9sb2d5LmMKPiBAQCAtNDUsNyArNDUsNyBAQCBj
bG9zZV9mZDoKPiAgIAlyZXR1cm4gc3Vic3lzbnFuOwo+ICAgfQo+ICAgCj4gLWNoYXIgKm52bWVf
Z2V0X2N0cmxfYXR0cihjaGFyICpwYXRoLCBjb25zdCBjaGFyICphdHRyKQo+ICtjaGFyICpudm1l
X2dldF9jdHJsX2F0dHIoY29uc3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqYXR0cikKPiAgIHsK
PiAgIAljaGFyICphdHRycGF0aCwgKnZhbHVlOwo+ICAgCXNzaXplX3QgcmV0Owo+IGRpZmYgLS1n
aXQgYS9udm1lLmggYi9udm1lLmgKPiBpbmRleCAzZmIxMDYwLi4zODJlNjI1IDEwMDY0NAo+IC0t
LSBhL252bWUuaAo+ICsrKyBiL252bWUuaAo+IEBAIC0xMDksNyArMTA5LDcgQEAgaW50IHNjYW5f
c3Vic3lzdGVtcyhzdHJ1Y3QgbnZtZV90b3BvbG9neSAqdCwgY29uc3QgY2hhciAqc3Vic3lzbnFu
LAo+ICAgCQkgICAgX191MzIgbnNfaW5zdGFuY2UsIGNoYXIgKmRldl9kaXIpOwo+ICAgdm9pZCBm
cmVlX3RvcG9sb2d5KHN0cnVjdCBudm1lX3RvcG9sb2d5ICp0KTsKPiAgIGNoYXIgKmdldF9udm1l
X3N1YnNucW4oY2hhciAqcGF0aCk7Cj4gLWNoYXIgKm52bWVfZ2V0X2N0cmxfYXR0cihjaGFyICpw
YXRoLCBjb25zdCBjaGFyICphdHRyKTsKPiArY2hhciAqbnZtZV9nZXRfY3RybF9hdHRyKGNvbnN0
IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKmF0dHIpOwo+ICAgCj4gICB2b2lkICpudm1lX2FsbG9j
KHNpemVfdCBsZW4sIGJvb2wgKmh1Z2UpOwo+ICAgdm9pZCBudm1lX2ZyZWUodm9pZCAqcCwgYm9v
bCBodWdlKTsKPiAKQ291bGQgYmUgbW92ZWQgcHJpb3IgdG8gdGhlIG1vbml0b3IgY29kZSBhcyBp
dCdzIHVucmVsYXRlZCB0byB0aGF0LgoKT3RoZXIgdGhhbiB0aGF0OgoKUmV2aWV3ZWQtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJl
QHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1l
bmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
