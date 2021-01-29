Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A71FC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 07:07:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1B960234
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 07:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1B960234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xIDG2ddipgjiUFeYqwSY8VYkS+8sAkONImKq7Q2G3+8=; b=AfluaJ1FgnwNqEbY8I6Ok+KgS
	EB0h2bfk09JYEucghX8TCYyYgx7z3zE6HX0Lrmft1qUwYK60VMyNzF2Ngve+l4IQS0Mkc+/taRQIu
	2CwrUPWDLzgHco7RInTfF78NTqyXCfcgRNksokH7sRl/adidwmX4GSVNJy7nbuU6t0U8tRwoCWjqf
	mTzxiz59B5s0mZLPnJwsaL7UGxhxBwoE8yHM7oCL4q6cORg4IQzilfC53Az9iqF1NJRa05OF7zgeV
	RrRMJP1hzujRs0hEaGNp69eMxszYiYYlyIAoEm8+qC0Wp8ik4FGIzaHmAAbZh1W+YdRGyvKwEb0ZJ
	HtILJoWgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Nry-00089O-Bx; Fri, 29 Jan 2021 07:07:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Nrw-00088u-Cw
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 07:07:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 25AADAD3E;
 Fri, 29 Jan 2021 07:06:59 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
Date: Fri, 29 Jan 2021 08:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_020700_551542_637E6AD1 
X-CRM114-Status: GOOD (  20.18  )
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
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yOS8yMSA0OjA3IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8xLzI5
IDk6NDIsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Cj4+Pj4gWW91IGNhbid0IHNlZSBleGFjdGx5
IHdoZXJlIGl0IGRpZXMgYnV0IEkgZm9sbG93ZWQgdGhlIGFzc2VtYmx5IHRvCj4+Pj4gbnZtZV9y
b3VuZF9yb2Jpbl9wYXRoKCkuIE1heWJlIGl0J3Mgbm90IHRoZSBpbml0aWFsIG52bWVfbmV4dF9u
cyhoZWFkLAo+Pj4+IG9sZCkgd2hpY2ggcmV0dXJucyBOVUxMIGJ1dCBudm1lX25leHRfbnMoKSBp
cyByZXR1cm5pbmcgTlVMTCBldmVudHVhbGx5Cj4+Pj4gKGxpc3RfbmV4dF9vcl9udWxsX3JjdSgp
KS4KPj4+IFNvIHRoZXJlIGlzIG90aGVyIGJ1ZyBjYXVzZSBudm1lX25leHRfbnMgYWJvcm1hbC4K
Pj4+IEkgcmV2aWV3IHRoZSBjb2RlIGFib3V0IGhlYWQtPmxpc3QgYW5kIGhlYWQtPmN1cnJlbnRf
cGF0aCwgSSBmaW5kIDIgYnVncwo+Pj4gbWF5IGNhdXNlIHRoZSBidWc6Cj4+PiBGaXJzdCwgSSBh
bHJlYWR5IHNlbmQgdGhlIHBhdGNoLiBzZWU6Cj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1udm1lLzIwMjEwMTI4MDMzMzUxLjIyMTE2LTEtbGVuZ2NoYW9AaHVhd2VpLmNvbS8gCj4+
Pgo+Pj4gU2Vjb25kLCBpbiBudm1lX25zX3JlbW92ZSwgbGlzdF9kZWxfcmN1IGlzIGJlZm9yZQo+
Pj4gbnZtZV9tcGF0aF9jbGVhcl9jdXJyZW50X3BhdGguIFRoaXMgbWF5IGNhdXNlICJvbGQiIGlz
IGRlbGV0ZWQgZnJvbSB0aGUKPj4+ICJoZWFkIiwgYnV0IHN0aWxsIHVzZSAib2xkIi4gSSdtIG5v
dCBzdXJlIHRoZXJlJ3MgYW55IG90aGVyCj4+PiBjb25zaWRlcmF0aW9uIGhlcmUsIEkgd2lsbCBj
aGVjayBpdCBhbmQgdHJ5IHRvIGZpeCBpdC4KPj4KPj4gVGhlIHJlYXNvbiB3aHkgd2UgZmlyc3Qg
cmVtb3ZlIGZyb20gaGVhZC0+bGlzdCBhbmQgb25seSB0aGVuIGNsZWFyCj4+IGN1cnJlbnRfcGF0
aCBpcyBiZWNhdXNlIHRoZSBvdGhlciB3YXkgYXJvdW5kIHRoZXJlIGlzIG5vIHdheQo+PiB0byBn
dWFyYW50ZWUgdGhhdCB0aGF0IHRoZSBucyB3b24ndCBiZSBhc3NpZ25lZCBhcyBjdXJyZW50X3Bh
dGgKPj4gYWdhaW4gKGJlY2F1c2UgaXQgaXMgaW4gaGVhZC0+bGlzdCkuCj4gb2ssIEkgc2VlLgo+
Pgo+PiBudm1lX25zX3JlbW92ZSBmZW5jZXMgY29udGludWUgb2YgZGVsZXRpb24gb2YgdGhlIG5z
IGJ5IHN5bmNocm9uaXppbmcKPj4gdGhlIHNyY3Ugc3VjaCB0aGF0IGZvciBzdXJlIHRoZSBjdXJy
ZW50X3BhdGggY2xlYXJhbmNlIGlzIHZpc2libGUuCj4gVGhlIGxpc3Qgd2lsbCBiZSBsaWtlIHRo
aXM6Cj4gaGVhZC0+bmV4dCA9IG5zMTsKPiBuczEtPm5leHQgPSBoZWFkOwo+IG9sZC0+bmV4dCA9
IG5zMTsKCldoZXJlIGRvZXMgJ29sZCcgcG9pbnRpbmcgdG8/Cgo+IFRoaXMgbWF5IGNhdXNlIGlu
ZmluaXRlIGxvb3AgaW4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRoLgo+IGZvciAobnMgPSBudm1lX25l
eHRfbnMoaGVhZCwgb2xkKTsKPiAgwqDCoMKgwqBucyAhPSBvbGQ7Cj4gIMKgwqDCoMKgbnMgPSBu
dm1lX25leHRfbnMoaGVhZCwgbnMpKQo+IFRoZSBucyB3aWxsIGFsd2F5cyBiZSBuczEsIGFuZCB0
aGVuIGluZmluaXRlIGxvb3AuCgpOby4gbnZtZV9uZXh0X25zKCkgd2lsbCByZXR1cm4gTlVMTC4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
