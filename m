Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68F3C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 08:49:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFC0610FB
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 08:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFC0610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3BDIuBPcPm9XbSZdxUtG4vw7AK/VayoVgeFJBeu/wec=; b=St6lPhngtX4T92TGYNgIg28O/
	BoTwvjsI/VOiI74RRmsMc0unSIddTSlIpBCe3A69JNaLCB5Pz7ibqncl9Vqmr7RqOADP8DR+p6j5Y
	UgJKK83vCWu0BdGO3NgHtn+jN5ykFWi2+79lywr8l2btB/tl0NWSmINV+ENUfzVjslfEmWDwafQ+M
	PZzRnmrUyYKcsFmIFdg0hA996SJDzQn9GB+qfhqkJ5xJZqdri6uSYbPJ6gbVqocvC/sTB0tQbTFBo
	okecuoYsk1Mo8388WRvV7DaniEnGTKTEvule0C7tU0tFBuXCKZ/m3IYOZDoaEHAuLwB2Tq1ttHic5
	oGISWhnLg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leZgU-003iOn-2K; Thu, 06 May 2021 08:48:38 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leZgP-003iOZ-Vy
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 08:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=qec5gqeWF6Y4WIRKUSRdhCUKlC93FR7JLjClzkor0dg=; b=yhNBX+pPlRI+FhABhj2vRmFNku
 TgiZrf+My1z8v5qdaOqirN/al2M2/00h/SpFb/uBr6v+XypiiBIX8LfrpnTU9xJTHds2MRoHh30dG
 yHAZM57aFEMsJqgkoJO+eDHq+D4JScxBhb6KU4j6WcenF5dKiXYU7qBNgqgKVaWK9NE0x7bsVtbL9
 80sXcF1NIOtDwsK4wGf6kJXIAEc69CR+YRZEencB8e5aXsF0p75X43DoIaAN+oOv/Rq4nFFnsq8/I
 9V4NeRREMLsYZVIxWcj55vsM9vKilgQ2ARnUQV8zRyjkLNBZC7cM4QJydAEuFpd2Gxk+MwuBpJCIU
 K+q8DtLA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leZgN-005sib-9N
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 08:48:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EC72EAC47;
 Thu,  6 May 2021 08:48:29 +0000 (UTC)
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210505103305.107475-1-hare@suse.de>
 <20210506073740.GB14615@lst.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH] nvme: generate uevent once a multipath namespace is
 operational again
Message-ID: <f5423135-66c2-293b-3743-a5fb0ceb2be2@suse.de>
Date: Thu, 6 May 2021 10:48:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210506073740.GB14615@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_014831_497455_A892F170 
X-CRM114-Status: GOOD (  20.63  )
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

T24gNS82LzIxIDk6MzcgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwgTWF5
IDA1LCAyMDIxIGF0IDEyOjMzOjA1UE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4g
SW4gYW4gYWxsIHBhdGhzIGRvd24gc2NlbmFyaW8gSS9PIHdpbGwgYmUgcmVxdWV1ZWQgb3IgYWJv
cnRlZCwgc28gbm8KPj4gZnVydGhlciBJL08gd2lsbCBiZSBvbmdvaW5nIG9uIHRoaXMgbmFtZXNw
YWNlLgo+PiBUaGlzIGxlYXZlcyB1cHBlciBsYXllcnMgbGlrZSBNRCB1bmFibGUgdG8gZGV0ZXJt
aW5lIGlmIHRoZSBuYW1lc3BhY2UKPj4gYmVjb21lcyBvcGVyYXRpb25hbCBhZ2FpbiBhZnRlciBh
IHN1Y2Nlc3NmdWwgY29udHJvbGxlciByZXNldC4KPj4gVGhpcyBwYXRjaCB3aWxsIHNlbmQgYW4g
dWV2ZW50IHBlciBtdWx0aXBhdGhlZCBuYW1lc3BhY2Ugb25jZSB0aGUKPj4gdW5kZXJseWluZyBj
b250cm9sbGVyIGlzIExJVkUsIGFsbG93aW5nIE1EIHRvIHN0YXJ0IHJlc3luYy4KPiAKPiBEbyB3
ZSBoYXZlIGFueSBkb2N1bWVudGF0aW9uIG9yIG90aGVyIGV4YW1wZXMgZm9yIHRoaXMgS09CSl9D
SEFOR0VECj4gbWFnaWM/ICBJJ3ZlIHNlZW4gaXQgaW4gYSBmZXcgcGxhY2VzLCBidXQgaXQgYWx3
YXlzIHNlZW1lZCByYXRoZXIKPiBjYXJnbyBjdWx0IHRvIG1lLiAgSWYgeW91IGhhdmUgYSBtb3Jl
IGluc2lnaHRzIGFueSBjaGFuY2UgeW91IGNvdWxkCj4gZG9jdW1lbnQgaXQ/Cj4gCkl0J3MgcHJl
Y2lzZWx5IGNhcmdvIGN1bHQsIGJ1dCBkZWZpbml0ZWx5IG5vdCB3ZWxsIGRvY3VtZW50ZWQuCgpD
dXJyZW50bHkgdGhlcmUgaXMgYW4gYW1iaWd1aXR5IGJldHdlZW4gJ0tPQkpfQUREJyBhbmQgJ0tP
QkpfQ0hBTkdFRCc7CnNvbWUgZGV2aWNlcyB3aWxsIG9ubHkgc2VuZCBLT0JKX0FERCwgb3RoZXIg
KG1vc3Qgbm90YWJseSBTLzM5MCBEQVNEcwphbmQgZGV2aWNlLW1hcHBlciBkZXZpY2VzKSB3aWxs
IHNlbmQgS09CSl9DSEFOR0VEIHRvIGluZGljYXRlIHRoYXQgdGhpcwpkZXZpY2UgaXMgbm93IGxp
dmUgYW5kIHJlYWR5IGZvciB1c2UuClNhZGx5IHRoZXJlIGlzIG5vIGluZGljYXRvciB0ZWxsaW5n
IHlvdSBpZiB0aGF0IHBhcnRpY3VsYXIgZGV2aWNlCmltcGxlbWVudHMgS09CSl9DSEFOR0VEIGF0
IGFsbCwgc28gb25lIHJlYWxseSBoYXMgdG8ga25vdyB3aGF0IHRvIGxvb2sKb3V0IGZvci4KQnV0
IHRoZSBnZW5lcmFsIHJ1bGUgaXMgdGhhdCAnS09CSl9DSEFOR0VEJyBpbmRpY2F0ZXMgdGhhdCBh
IGRldmljZSBpcwpub3QgcmVhZHkgZm9yIHVzZTsgS09CSl9BREQgaW5kaWNhdGVzIHRoYXQgYSBk
ZXZpY2UgaGFzIGJlZW4gYWRkZWQgdG8KdGhlIHN5c3RlbSBhbmQgX21pZ2h0XyBpbmRpY2F0ZSB0
aGF0IHRoZSBkZXZpY2UgaXMgcmVhZHkgdG8gdXNlLgoKPj4gKwkJaWYgKGN0cmwtPnN0YXRlID09
IE5WTUVfQ1RSTF9MSVZFKQo+PiArCQkJa29iamVjdF91ZXZlbnQoJmRpc2tfdG9fZGV2KG5zLT5o
ZWFkLT5kaXNrKS0+a29iaiwKPj4gKwkJCQkgICAgICAgS09CSl9DSEFOR0UpOwo+IAo+IEFsc28g
dGhpcyBzaG91bGQgcHJvYmFibHkgdXNlIGRpc2tfdWV2ZW50IHRvIGFsc28gbm90aWZ5IHBhcnRp
dGlvbnMuCj4gTWF5YmUgYWxzbyBmb3Igb3RoZXIgZXhpc3RpbmcgY2FsbGVycy4KPiAKSW5kZWVk
LCB5b3UgYXJlIGNvcnJlY3QuIFdpbGwgYmUgZml4aW5nIGl0LgoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTD
tnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
