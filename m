Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125BDC49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 16:53:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB020863
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 16:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DVoEDW03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3yRXAKWEUJyOZLTCVdywrQel2BRy7J/6YKKZr4OVWAo=; b=DVoEDW03mo8X/J
	7GrRiUaw/eY88+5Zp5PNzqRT/gaiLVwHwomOLxkGqA98/VAdxwacI7xrrGTfjP3L/U+ijArOnjtnV
	MpqRVUFM1G8QFbUC3eMdfXrjDf/+Jh9f03XaTyr+c6yursAie6k3O6S5wVyNtkFNPDbS9TetZIhOX
	AvsWTbVOHpnfr8hdaglAinD2mTPA/rrhz+iASojb3RaQ9B/RfpnC0DoQdJq+qw6EMp5UgCba1TPJo
	e/Jy0CIvwjdJ5D+3zzEllBCCpPbZGZ3/QHfaEpqnAcktRCQu/jS1cpwqoICNF2qY7WUoEr7cRGTxO
	gKQzmpHI7l7Lr8XBNa+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i85sN-0003Gh-0I; Wed, 11 Sep 2019 16:53:51 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i85sJ-0003Fa-DF
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 16:53:49 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1i85s8-00013U-0b; Wed, 11 Sep 2019 10:53:37 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-14-logang@deltatee.com>
 <92d61426-65a2-827c-936b-55f12f3d6afb@grimberg.me>
 <ca4ebcd9-fa5d-5ddf-c2a7-70318410dd97@deltatee.com>
 <7954e8a4-6026-2210-7192-94a4e483facf@grimberg.me>
 <b23c72b2-c9db-cb8e-5519-63eb195b7fd4@deltatee.com>
 <ca811aea-c4ae-10ee-15a5-2332d5a9e29a@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <19da6ca1-3cde-3f29-59ee-923c562e6487@deltatee.com>
Date: Wed, 11 Sep 2019 10:53:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca811aea-c4ae-10ee-15a5-2332d5a9e29a@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, kbusch@kernel.org,
 axboe@fb.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v8 13/13] nvmet-passthru: support block accounting
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_095348_004699_EDBC578C 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDE5LTA5LTA5IDU6MTUgcC5tLiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+Pj4+
IFN1cHBvcnQgYmxvY2sgZGlzayBhY2NvdW50aW5nIGJ5IHNldHRpbmcgdGhlIFJRRl9JT19TVEFU
IGZsYWcKPj4+Pj4+IGFuZCBnZW5kaXNrIGluIHRoZSByZXF1ZXN0Lgo+Pj4+Pj4KPj4+Pj4+IEFm
dGVyIHRoaXMgY2hhbmdlLCBJTyBjb3VudHMgd2lsbCBiZSByZWZsZWN0ZWQgY29ycmVjdGx5IGlu
Cj4+Pj4+PiAvcHJvYy9kaXNrc3RhdHMgZm9yIGRyaXZlcyBiZWluZyB1c2VkIGJ5IHBhc3N0aHJ1
Lgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRl
bHRhdGVlLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gwqDCoMKgIGRyaXZlcnMvbnZtZS90YXJnZXQv
aW8tY21kLXBhc3N0aHJ1LmMgfCA1ICsrKystCj4+Pj4+PiDCoMKgwqAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1wYXNzdGhydS5jCj4+Pj4+PiBiL2RyaXZlcnMv
bnZtZS90YXJnZXQvaW8tY21kLXBhc3N0aHJ1LmMKPj4+Pj4+IGluZGV4IDc1NTc5MjdhMzQ1MS4u
NjNmMTI3NTBhODBkIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1j
bWQtcGFzc3RocnUuYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtcGFz
c3RocnUuYwo+Pj4+Pj4gQEAgLTQxMCw2ICs0MTAsOSBAQCBzdGF0aWMgc3RydWN0IHJlcXVlc3QK
Pj4+Pj4+ICpudm1ldF9wYXNzdGhydV9ibGtfbWFrZV9yZXF1ZXN0KHN0cnVjdCBudm1ldF9yZXEg
KnJlcSwKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShJU19FUlIocnEpKSkKPj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJxOwo+Pj4+Pj4gwqDCoMKgICvCoMKg
wqAgaWYgKGJsa19xdWV1ZV9pb19zdGF0KHEpICYmIGNtZC0+Y29tbW9uLm9wY29kZSAhPQo+Pj4+
Pj4gbnZtZV9jbWRfZmx1c2gpCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcnEtPnJxX2ZsYWdzIHw9
IFJRRl9JT19TVEFUOwo+Pj4+Cj4+Pj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IQo+Pj4+Cj4+Pj4+
IERvZXMgZmx1c2ggaGFzIGRhdGEgYnl0ZXMgaW4gdGhlIHJlcXVlc3Q/IFdoeSB0aGUgc3BlY2lh
bCBjYXNpbmc/Cj4+Pj4KPj4+PiBXZWxsIGl0IHdhcyBzcGVjaWFsIGNhc2VkIGluIHRoZSB2YW5p
bGxhIGJsayBhY2NvdW50IGZsb3cuLi4gQnV0IEkKPj4+PiB0aGluawo+Pj4+IGl0J3MgcmVxdWly
ZWQgdG8gYmUgc3BlY2lhbCBjYXNlZCBzbyB0aGUgSU8gYW5kIGluX2ZsaWdodCBjb3VudHMgZG9u
J3QKPj4+PiBjb3VudCBmbHVzaGVzIChhcyB0aGV5IGRvIG5vdCBmb3IgcmVndWxhciBibG9jayBk
ZXZpY2UgdHJhZmZpYykuCj4+Pgo+Pj4gSSB0aGluayB0aGF0IHRoZSBhY2NvdW50aW5nIGV4Y2x1
ZGUgSS9PIHRoYXQgaXMgeWllbGRlZCBmcm9tIHRoZSBmbHVzaAo+Pj4gc2VxdWVuY2UuIERvbid0
IHRoaW5rIGl0cyByZWxldmFudCBoZXJlLi4uCj4+Cj4+IFdoYXQ/IFBlciBibGtfYWNjb3VudF9p
b19kb25lKCksIFJRRl9GTFVTSF9TRVEgd2lsbCBub3QgYmUgc2V0IGJ5IHVzIGZvcgo+PiBwYXNz
dGhydSBjb21tYW5kcyBhbmQgSSBkb24ndCB0aGluayBpdCdzIGFwcHJvcHJpYXRlIHRvIGRvIHNv
LiBUaHVzLCBpZgo+PiB3ZSBzZXQgUlFGX0lPX1NUQVQgZm9yIHBhc3N0aHJ1IGZsdXNoIGNvbW1h
bmRzLCB0aGV5IHdpbGwgYmUgY291bnRlZAo+PiB3aGljaCB3ZSBkbyBub3Qgd2FudC4KPiAKPiBI
YXZlIHlvdSBjb25zaWRlcmVkIHRvIGhhdmUgbnZtZXRfcGFzc3RocnVfYmxrX21ha2VfcmVxdWVz
dCBzZXQgUlFGX0ZVQQo+IGZvciBudm1lX2NtZF9mbHVzaD8gdGhpcyB3YXkgYmxrX2luc2VydF9m
bHVzaCB3aWxsIGJlIGNhbGxlZCBhbmQKPiBSUUZfRkxVU0hfU0VRIHdpbGwgYmUgc2V0IGFuZCB5
b3UgZG9uJ3QgbmVlZCB0byB3b3JyeSBhYm91dCB0aGlzCj4gc3BlY2lhbCBjYXNpbmcuLi4KCldl
bGwsIEkgaGF2ZW4ndCBkb25lIHRoYXQgbW9zdGx5IGJlY2F1c2UgSSdtIG5vdCBzdXJlIG9mIGFs
bCB0aGUgc2lkZQplZmZlY3RzIG9mIGRvaW5nIHNvLiBIb3dldmVyLCBJJ3ZlIHRyaWVkIGl0IGFu
ZCBldmVyeXRoaW5nIHNlZW1zIHRvCnN0aWxsIHdvcmssIHNvIEknbGwgbWFrZSB0aGF0IGNoYW5n
ZSBmb3Igdjkgd2hpY2ggSSdsbCBwcm9iYWJseSBzZW5kIG91dAphZnRlciB0aGUgbWVyZ2Ugd2lu
ZG93LgoKTG9nYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
