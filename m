Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C9C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 07:45:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62C864E00
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 07:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62C864E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=76ix4Qxhl49Is+lZL7IN5v2BVh4jslUcpxR3JDxbEpM=; b=xoUCLWzvCJPW7hXOssNYwyINK
	QPof6MbTClVY0Gj46PyRfRTdTz2Mlrsfm69gRzDZVwiC3pJd3dgnORrmZ2csHoJfdKxO4VPY5ocm6
	youY7tGKdqTQuSpNHMIt5SjqJxVd6GqTrvQQ9j6BK1XcnyPtiEAZvNWDXEtGsUwVNBsgXfnSIfSPz
	fewK3VMhyre/doOZJp5begSPTTdCRyRhjpA0FoyCBVyt7CUNQ390ROD2iRFBvBvseSZPxygHwt2Cm
	MHBq0M4IBnLmH82RCKP8IJH3YhhgdDIVkcmPUrk6+f0729/2GvkrNEkBuXdsPPl86OqfKJYCAPuIv
	5jaEZUVHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5OTY-0006Ga-6c; Fri, 29 Jan 2021 07:45:52 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5OTT-0006F0-Ex
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 07:45:49 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRq8X58mtz13bbl;
 Fri, 29 Jan 2021 15:43:40 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 15:45:40 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 15:45:40 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, "Daniel
 Wagner" <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
Date: Fri, 29 Jan 2021 15:45:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_024549_035376_98F340B7 
X-CRM114-Status: GOOD (  14.33  )
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

CgpPbiAyMDIxLzEvMjkgMTU6MDYsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAxLzI5LzIx
IDQ6MDcgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS8xLzI5IDk6NDIsIFNh
Z2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pgo+Pj4+PiBZb3UgY2FuJ3Qgc2VlIGV4YWN0bHkgd2hlcmUg
aXQgZGllcyBidXQgSSBmb2xsb3dlZCB0aGUgYXNzZW1ibHkgdG8KPj4+Pj4gbnZtZV9yb3VuZF9y
b2Jpbl9wYXRoKCkuIE1heWJlIGl0J3Mgbm90IHRoZSBpbml0aWFsIG52bWVfbmV4dF9ucyhoZWFk
LAo+Pj4+PiBvbGQpIHdoaWNoIHJldHVybnMgTlVMTCBidXQgbnZtZV9uZXh0X25zKCkgaXMgcmV0
dXJuaW5nIE5VTEwgZXZlbnR1YWxseQo+Pj4+PiAobGlzdF9uZXh0X29yX251bGxfcmN1KCkpLgo+
Pj4+IFNvIHRoZXJlIGlzIG90aGVyIGJ1ZyBjYXVzZSBudm1lX25leHRfbnMgYWJvcm1hbC4KPj4+
PiBJIHJldmlldyB0aGUgY29kZSBhYm91dCBoZWFkLT5saXN0IGFuZCBoZWFkLT5jdXJyZW50X3Bh
dGgsIEkgZmluZCAyIGJ1Z3MKPj4+PiBtYXkgY2F1c2UgdGhlIGJ1ZzoKPj4+PiBGaXJzdCwgSSBh
bHJlYWR5IHNlbmQgdGhlIHBhdGNoLiBzZWU6Cj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbnZtZS8yMDIxMDEyODAzMzM1MS4yMjExNi0xLWxlbmdjaGFvQGh1YXdlaS5jb20vCj4+
Pj4gU2Vjb25kLCBpbiBudm1lX25zX3JlbW92ZSwgbGlzdF9kZWxfcmN1IGlzIGJlZm9yZQo+Pj4+
IG52bWVfbXBhdGhfY2xlYXJfY3VycmVudF9wYXRoLiBUaGlzIG1heSBjYXVzZSAib2xkIiBpcyBk
ZWxldGVkIGZyb20gdGhlCj4+Pj4gImhlYWQiLCBidXQgc3RpbGwgdXNlICJvbGQiLiBJJ20gbm90
IHN1cmUgdGhlcmUncyBhbnkgb3RoZXIKPj4+PiBjb25zaWRlcmF0aW9uIGhlcmUsIEkgd2lsbCBj
aGVjayBpdCBhbmQgdHJ5IHRvIGZpeCBpdC4KPj4+Cj4+PiBUaGUgcmVhc29uIHdoeSB3ZSBmaXJz
dCByZW1vdmUgZnJvbSBoZWFkLT5saXN0IGFuZCBvbmx5IHRoZW4gY2xlYXIKPj4+IGN1cnJlbnRf
cGF0aCBpcyBiZWNhdXNlIHRoZSBvdGhlciB3YXkgYXJvdW5kIHRoZXJlIGlzIG5vIHdheQo+Pj4g
dG8gZ3VhcmFudGVlIHRoYXQgdGhhdCB0aGUgbnMgd29uJ3QgYmUgYXNzaWduZWQgYXMgY3VycmVu
dF9wYXRoCj4+PiBhZ2FpbiAoYmVjYXVzZSBpdCBpcyBpbiBoZWFkLT5saXN0KS4KPj4gb2ssIEkg
c2VlLgo+Pj4KPj4+IG52bWVfbnNfcmVtb3ZlIGZlbmNlcyBjb250aW51ZSBvZiBkZWxldGlvbiBv
ZiB0aGUgbnMgYnkgc3luY2hyb25pemluZwo+Pj4gdGhlIHNyY3Ugc3VjaCB0aGF0IGZvciBzdXJl
IHRoZSBjdXJyZW50X3BhdGggY2xlYXJhbmNlIGlzIHZpc2libGUuCj4+IFRoZSBsaXN0IHdpbGwg
YmUgbGlrZSB0aGlzOgo+PiBoZWFkLT5uZXh0ID0gbnMxOwo+PiBuczEtPm5leHQgPSBoZWFkOwo+
PiBvbGQtPm5leHQgPSBuczE7Cj4gCj4gV2hlcmUgZG9lcyAnb2xkJyBwb2ludGluZyB0bz8KPiAK
Pj4gVGhpcyBtYXkgY2F1c2UgaW5maW5pdGUgbG9vcCBpbiBudm1lX3JvdW5kX3JvYmluX3BhdGgu
Cj4+IGZvciAobnMgPSBudm1lX25leHRfbnMoaGVhZCwgb2xkKTsKPj4gwqDCoMKgwqDCoG5zICE9
IG9sZDsKPj4gwqDCoMKgwqDCoG5zID0gbnZtZV9uZXh0X25zKGhlYWQsIG5zKSkKPj4gVGhlIG5z
IHdpbGwgYWx3YXlzIGJlIG5zMSwgYW5kIHRoZW4gaW5maW5pdGUgbG9vcC4KPiAKPiBOby4gbnZt
ZV9uZXh0X25zKCkgd2lsbCByZXR1cm4gTlVMTC4KSWYgdGhlcmUgaXMganVzdCBvbmUgcGF0aCh0
aGUgIm9sZCIpIGFuZCB0aGUgIm9sZCIgaXMgZGVsZXRlZCwKbnZtZV9uZXh0X25zKCkgd2lsbCBy
ZXR1cm4gTlVMTC4KVGhlIGxpc3QgbGlrZSB0aGlzOgpoZWFkLT5uZXh0ID0gaGVhZDsKb2xkLT5u
ZXh0ID0gaGVhZDsKSWYgdGhlcmUgaXMgdHdvIG9yIG1vcmUgcGF0aCBhbmQgdGhlICJvbGQiIGlz
IGRlbGV0ZWQsCiJmb3IiIHdpbGwgYmUgaW5maW5pdGUgbG9vcC4gYmVjYXVzZSBudm1lX25leHRf
bnMoKSB3aWxsIHJldHVybgp0aGUgcGF0aCB3aGljaCBpbiB0aGUgbGlzdCBleGNlcHQgdGhlICJv
bGQiLCBjaGVjayBjb25kaXRpb24gd2lsbApiZSB0cnVlIGZvciBldmVyLgpGb3IgZXhhbXBsZSwg
dGhlcmUgaXMgdHdvIHBhdGg6IG9uZSBpcyB0aGUgIm9sZCIsIGFub3RoZXIgaXMgIm5zMSIuClRo
ZSBsaXN0IGxpa2UgdGhpczoKaGVhZC0+bmV4dCA9IG5zMTsKbnMxLT5uZXh0ID0gaGVhZDsKb2xk
LT5uZXh0ID0gbnMxOwpudm1lX25leHRfbnMoaGVhZCwgb2xkKSB3aWxsIHJldHVybiBuczE7ClRo
ZW4gbnZtZV9uZXh0X25zKGhlYWQsIG5zMSkgd2lsbCByZXR1cm4gbnMxOwpBbmQgdGhlbiBpbmZp
bml0ZSBsb29wLgo+IAo+IENoZWVycywKPiAKPiBIYW5uZXMKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
