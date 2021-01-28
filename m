Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:23:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E5F64DD6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E5F64DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gq2Hy47Uz6XEo1mATlU02VqQxZRfZQSgI3qABl+nWy4=; b=ju54kPK46MOj7MlcVaGpVyQhU
	s+UXiK5o5gV35PHGusfhdJ8ptb7at4Un32i8lSvo8PcIu15hs390gnSYEeHc2n+KWXjLl28Ic7kut
	YE0IpBE8KhBbeGZvep+oV5CEO9fHymZPpx5+lStsoazoqv91F73WenUEldmyYxdkthrMpWlVRiIp1
	Kj0Lqyt+Q3p+t2+4zKUJn6vtzN98QzOG9DB6332lknFm39h7ee0CqCKbH8RD4Hd3bIbIDab0wrF4P
	tftMmU6G6ci+p+8REyZxXUnkuRs9qexv9RtQ5qlN11wZXWDf/6Cknzi+IH0vkG6+ddJFpE5CIhCoX
	bE7D77UbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53Wm-0001dh-Ng; Thu, 28 Jan 2021 09:23:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53Wk-0001cL-5m
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:23:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6CE71AE12;
 Thu, 28 Jan 2021 09:23:43 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8704038d-0b71-5c9c-2d2b-a9ff2166dbe4@suse.de>
Date: Thu, 28 Jan 2021 10:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_042346_348580_38A193F8 
X-CRM114-Status: GOOD (  19.07  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yOC8yMSAxMDoxOCBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjEvMS8y
OCAxNTo1OCwgRGFuaWVsIFdhZ25lciB3cm90ZToKPj4gT24gVGh1LCBKYW4gMjgsIDIwMjEgYXQg
MDk6MzE6MzBBTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRo
LmMKPj4+PiBAQCAtMjIxLDcgKzIyMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZV9ucyAKPj4+PiAq
bnZtZV9yb3VuZF9yb2Jpbl9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsCj4+Pj4gwqDC
oMKgwqDCoMKgIH0KPj4+PiDCoMKgwqDCoMKgwqAgZm9yIChucyA9IG52bWVfbmV4dF9ucyhoZWFk
LCBvbGQpOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgIG5zICE9IG9sZDsKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoCBucyAmJiBucyAhPSBvbGQ7Cj4+PiBudm1lX3JvdW5kX3JvYmluX3BhdGgganVzdCBi
ZSBjYWxsZWQgd2hlbiAhIm9sZCIuCj4+PiBudm1lX25leHRfbnMgc2hvdWxkIG5vdCByZXR1cm4g
TlVMTCB3aGVuICEib2xkIi4KPj4+IEl0IHNlZW1zIHVubmVjZXNzYXJ5IHRvIGFkZCBjaGVja2lu
ZyAibnMiLgo+Pgo+PiBUaGUgcHJvYmxlbSBpcyB3aGVuIHdlIGVudGVyIG52bWVfcm91bmRfcm9i
aW5fcGF0aCgpIGFuZCB0aGVyZSBpcyBubwo+PiBwYXRoIGF2YWlsYWJsZS4gSW4gdGhpcyBjYXNl
IHRoZSBpbml0aWFsaXphdGlvbiBucyA9IG52bWVfbmV4dF9ucyhoZWFkLAo+PiBvbGQpIGNvdWxk
IHJldHVybiBhIE5VTEwgcG9pbnRlci4ib2xkIiBzaG91bGQgbm90IGJlIE5VTEwsIHNvIHRoZXJl
IGlzIAo+PiBhdCBsZWFzdCBvbmUgcGF0aCB0aGF0IGlzICJvbGQiLgo+IEl0IGlzIGltcG9zc2li
bGUgdG8gcmV0dXJuIE5VTEwgZm9yIG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpLgoKTm8uIGxpc3Rf
bmV4dF9vcl9udWxsX3JjdSgpL2xpc3RfZmlyc3Rfb3JfbnVsbF9yY3UoKSB3aWxsIHJldHVybiBO
VUxMIAp3aGVuIHRoZW4gZW5kIG9mIHRoZSBsaXN0IGlzIHJlYWNoZWQuCgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2Ug
QXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5
MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUs
IDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xo
cmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
