Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE62C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:36:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2357964DF5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2357964DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1eramvhYCsw06F1xjmDrpOttUmjB08v7sFoZcC+xfw0=; b=z7DLMf+xYobT5vE5hifjcYWA5
	3Sa/dlzE3MgrXRMdXeETuGHVbo4AGQiqrfrcSeZGY7r7ORYk8BQzRvsg24qqPuXI48f4KtA8hzR+3
	9Subr3CXDVVXPiQjQ0Mh8I6Swwgzsgfjx+iRCvA2Vp52aT6RiHN4Y0iNnUywyPG4lBKIvy7G2739S
	NcxmzqB7CEuWVxzh51tDeMmLlf90OYarfnr+0p8s+P62D2nhCUumFaqjmShuavAwdkpJnP/WPUp2x
	Egp3rheZW8WuzjJqD+W17cKk4ByA/XAI35CykR+5Od/X3kJgcCigwlzf6yO5P3FhXDZJJy19BiOeh
	KNzQqSk7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5KZz-0001qt-FJ; Fri, 29 Jan 2021 03:36:15 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5KZw-0001qG-UA
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:36:14 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRjdf47cvzR8Ny;
 Fri, 29 Jan 2021 11:35:02 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:36:09 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:36:08 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <dbc39e56-b2bd-a82e-499a-5032c9716855@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a3c64c60-13f3-1b99-47bc-05ebfefed343@huawei.com>
Date: Fri, 29 Jan 2021 11:36:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <dbc39e56-b2bd-a82e-499a-5032c9716855@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_223613_238530_6D69A631 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Jens
 Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMjkgMTE6MzAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4+IFlvdSBj
YW4ndCBzZWUgZXhhY3RseSB3aGVyZSBpdCBkaWVzIGJ1dCBJIGZvbGxvd2VkIHRoZSBhc3NlbWJs
eSB0bwo+Pj4+PiBudm1lX3JvdW5kX3JvYmluX3BhdGgoKS4gTWF5YmUgaXQncyBub3QgdGhlIGlu
aXRpYWwgbnZtZV9uZXh0X25zKGhlYWQsCj4+Pj4+IG9sZCkgd2hpY2ggcmV0dXJucyBOVUxMIGJ1
dCBudm1lX25leHRfbnMoKSBpcyByZXR1cm5pbmcgTlVMTCBldmVudHVhbGx5Cj4+Pj4+IChsaXN0
X25leHRfb3JfbnVsbF9yY3UoKSkuCj4+Pj4gU28gdGhlcmUgaXMgb3RoZXIgYnVnIGNhdXNlIG52
bWVfbmV4dF9ucyBhYm9ybWFsLgo+Pj4+IEkgcmV2aWV3IHRoZSBjb2RlIGFib3V0IGhlYWQtPmxp
c3QgYW5kIGhlYWQtPmN1cnJlbnRfcGF0aCwgSSBmaW5kIDIgYnVncwo+Pj4+IG1heSBjYXVzZSB0
aGUgYnVnOgo+Pj4+IEZpcnN0LCBJIGFscmVhZHkgc2VuZCB0aGUgcGF0Y2guIHNlZToKPj4+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjEwMTI4MDMzMzUxLjIyMTE2LTEt
bGVuZ2NoYW9AaHVhd2VpLmNvbS8KPj4+PiBTZWNvbmQsIGluIG52bWVfbnNfcmVtb3ZlLCBsaXN0
X2RlbF9yY3UgaXMgYmVmb3JlCj4+Pj4gbnZtZV9tcGF0aF9jbGVhcl9jdXJyZW50X3BhdGguIFRo
aXMgbWF5IGNhdXNlICJvbGQiIGlzIGRlbGV0ZWQgZnJvbSB0aGUKPj4+PiAiaGVhZCIsIGJ1dCBz
dGlsbCB1c2UgIm9sZCIuIEknbSBub3Qgc3VyZSB0aGVyZSdzIGFueSBvdGhlcgo+Pj4+IGNvbnNp
ZGVyYXRpb24gaGVyZSwgSSB3aWxsIGNoZWNrIGl0IGFuZCB0cnkgdG8gZml4IGl0Lgo+Pj4KPj4+
IFRoZSByZWFzb24gd2h5IHdlIGZpcnN0IHJlbW92ZSBmcm9tIGhlYWQtPmxpc3QgYW5kIG9ubHkg
dGhlbiBjbGVhcgo+Pj4gY3VycmVudF9wYXRoIGlzIGJlY2F1c2UgdGhlIG90aGVyIHdheSBhcm91
bmQgdGhlcmUgaXMgbm8gd2F5Cj4+PiB0byBndWFyYW50ZWUgdGhhdCB0aGF0IHRoZSBucyB3b24n
dCBiZSBhc3NpZ25lZCBhcyBjdXJyZW50X3BhdGgKPj4+IGFnYWluIChiZWNhdXNlIGl0IGlzIGlu
IGhlYWQtPmxpc3QpLgo+PiBvaywgSSBzZWUuCj4+Pgo+Pj4gbnZtZV9uc19yZW1vdmUgZmVuY2Vz
IGNvbnRpbnVlIG9mIGRlbGV0aW9uIG9mIHRoZSBucyBieSBzeW5jaHJvbml6aW5nCj4+PiB0aGUg
c3JjdSBzdWNoIHRoYXQgZm9yIHN1cmUgdGhlIGN1cnJlbnRfcGF0aCBjbGVhcmFuY2UgaXMgdmlz
aWJsZS4KPj4gVGhlIGxpc3Qgd2lsbCBiZSBsaWtlIHRoaXM6Cj4+IGhlYWQtPm5leHQgPSBuczE7
Cj4+IG5zMS0+bmV4dCA9IGhlYWQ7Cj4+IG9sZC0+bmV4dCA9IG5zMTsKPj4gVGhpcyBtYXkgY2F1
c2UgaW5maW5pdGUgbG9vcCBpbiBudm1lX3JvdW5kX3JvYmluX3BhdGguCj4+IGZvciAobnMgPSBu
dm1lX25leHRfbnMoaGVhZCwgb2xkKTsKPj4gwqDCoMKgwqDCoG5zICE9IG9sZDsKPj4gwqDCoMKg
wqDCoG5zID0gbnZtZV9uZXh0X25zKGhlYWQsIG5zKSkKPj4gVGhlIG5zIHdpbGwgYWx3YXlzIGJl
IG5zMSwgYW5kIHRoZW4gaW5maW5pdGUgbG9vcC4KPiAKPiBXaG8gaXMgYmVpbmcgcmVtb3ZlZD8g
SSdtIG5vdCBmb2xsb3dpbmcKVGhlICJvbGQiIGlzIGJlaW5nIHJlbW92ZWQgcGF0aC4KRGFuaWVs
IFdhZ25lciByZXBvcnQgY3Jhc2ggbGlrZSB0aGlzOgpoZWFkLT5uZXh0ID0gaGVhZDsKb2xkLT5u
ZXh0ID0gaGVhZDsKU28gbnZtZV9uZXh0X25zKGhlYWQsIG9sZCkgd2lsbCByZXR1cm4gTlVMTCwg
YW5kIHRoZW4gY3Jhc2guCkFsdGhvdWdoIGNoZWNrIG5zIGNhbiBhdm9pZCBjcmFzaCwgYnV0IGNh
biBub3QgYXZvaWQgaW5maW5pdGUgbG9vcC4KClNpbWlsYXIgcmVhc29uLCBUaGUgbGlzdCB3aWxs
IGJlIGxpa2UgdGhpczoKaGVhZC0+bmV4dCA9IG5zMTsKbnMxLT5uZXh0ID0gaGVhZDsKb2xkLT5u
ZXh0ID0gbnMxOwpuczEgaXMgb3RoZXIgcGF0aC4KCj4gLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
