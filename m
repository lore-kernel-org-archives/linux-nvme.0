Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4567EC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 09:06:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4C320790
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 09:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pe3jvuVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4C320790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IUG++1MvcTrc/4rhNxASJGqqjGuZFMqVZrZopNspLiE=; b=Pe3jvuVbJkZB58xCvasKTgh57
	RHJzAaxYjuaKXed0NCULD92wi7KfFQ9V+kYPr6qlfdfEp4L9y+4enlfCSZIrQGZB+xlukRGZvzcEM
	kkAc9KEKq4U0oZJWjlf98qCUHMQsaFFUZIWb1ZnJ4J3gu9nw9dfVR4NtpP+eQ7SmksEP3DbP0icaq
	HWl+E8MLO1sEbCVxR5YYRHlh0ZvgF4CUC3w3djT/XB8R20EOu7gMx+oJLmcQpFv1RxVbmjdVEC6KO
	wzT2iQn+t1VR86XEqAjhacAKui/HM5W5AtVcdmKfNnLypgoQQEtWJOCqqSlPlffMYGKHbIQEr51/t
	3JVTp+aYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kRtmq-0007tW-56; Mon, 12 Oct 2020 09:06:32 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kRtmo-0007sm-7W
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 09:06:31 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 6704141541879497BE93;
 Mon, 12 Oct 2020 17:06:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 12 Oct 2020 17:06:24 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 12
 Oct 2020 17:06:24 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Ming Lei <ming.lei@redhat.com>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
Date: Mon, 12 Oct 2020 17:06:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201012081306.GB556731@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_050630_537442_C2AE2648 
X-CRM114-Status: GOOD (  17.57  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzEwLzEyIDE2OjEzLCBNaW5nIExlaSB3cm90ZToKPiBPbiBNb24sIE9jdCAxMiwg
MjAyMCBhdCAxMTo1OToyMUFNICswODAwLCBDaGFvIExlbmcgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIw
MjAvMTAvMTAgMTQ6MDgsIFlpIFpoYW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAxMC8xMC8yMCAy
OjI5IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+PiBPbiAxMC85LzIwIDY6
NTUgQU0sIFlpIFpoYW5nIHdyb3RlOgo+Pj4+PiBIaSBTYWdpCj4+Pj4+Cj4+Pj4+IE9uIDEwLzkv
MjAgNDowOSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+Pj4+PiBIaSBTYWdpCj4+Pj4+Pj4K
Pj4+Pj4+PiBJIGFwcGxpZWQgdGhpcyBwYXRjaCBvbiBibG9jayBvcmlnaW4vZm9yLW5leHQgYW5k
IHN0aWxsIGNhbiByZXByb2R1Y2UgaXQuCj4+Pj4+Pgo+Pj4+Pj4gVGhhdCdzIHVuZXhwZWN0ZWQs
IGNhbiB5b3UgdHJ5IHRoaXMgcGF0Y2g/Cj4+Pj4+PiAtLSAKPj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+Pj4+PiBp
bmRleCA2MjliMDI1Njg1ZDEuLjQ2NDI4ZmYwYjBmYyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+
Pj4+Pj4gQEAgLTIxNzUsNyArMjE3NSw3IEBAIHN0YXRpYyB2b2lkIG52bWVfdGNwX2NvbXBsZXRl
X3RpbWVkX291dChzdHJ1Y3QgcmVxdWVzdCAqcnEpCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgLyog
ZmVuY2Ugb3RoZXIgY29udGV4dHMgdGhhdCBtYXkgY29tcGxldGUgdGhlIGNvbW1hbmQgKi8KPj4+
Pj4+ICDCoMKgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZ0b190Y3BfY3RybChjdHJsKS0+dGVhcmRv
d25fbG9jayk7Cj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgbnZtZV90Y3Bfc3RvcF9xdWV1ZShjdHJs
LCBudm1lX3RjcF9xdWV1ZV9pZChyZXEtPnF1ZXVlKSk7Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgIGlm
ICghYmxrX21xX3JlcXVlc3RfY29tcGxldGVkKHJxKSkgewo+Pj4+Pj4gK8KgwqDCoMKgwqDCoCBp
ZiAoYmxrX21xX3JlcXVlc3Rfc3RhcnRlZChycSkgJiYgIWJsa19tcV9yZXF1ZXN0X2NvbXBsZXRl
ZChycSkpIHsKPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZXEo
cnEpLT5zdGF0dXMgPSBOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQ7Cj4+Pj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3N5bmMocnEpOwo+
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIH0KPj4gVGhpcyBtYXkganVzdCByZWR1Y2UgdGhlIHByb2Jh
YmlsaXR5LiBUaGUgY29uY3VycmVuY3kgb2YgdGltZW91dCBhbmQgdGVhcmRvd24gd2lsbCBjYXVz
ZSB0aGUgc2FtZSByZXF1ZXN0Cj4+IGJlIHRyZWF0ZWQgcmVwZWF0bHksIHRoaXMgaXMgbm90IHdl
IGV4cGVjdGVkLgo+IAo+IFRoYXQgaXMgcmlnaHQsIG5vdCBsaWtlIFNDU0ksIE5WTUUgZG9lc24n
dCBhcHBseSBhdG9taWMgcmVxdWVzdCBjb21wbGV0aW9uLCBzbwo+IHJlcXVlc3QgbWF5IGJlIGNv
bXBsZXRlZC9mcmVlZCBmcm9tIGJvdGggdGltZW91dCAmIG52bWVfY2FuY2VsX3JlcXVlc3QoKS4K
PiAKPiAudGVhcmRvd25fbG9jayBzdGlsbCBtYXkgY292ZXIgdGhlIHJhY2Ugd2l0aCBTYWdpJ3Mg
cGF0Y2ggYmVjYXVzZSB0ZWFyZG93bgo+IGFjdHVhbGx5IGNhbmNlbHMgcmVxdWVzdHMgaW4gc3lu
YyBzdHlsZS4KSW4gZXh0cmVtZSBzY2VuYXJpb3MsIHRoZSByZXF1ZXN0IG1heSBiZSBhbHJlYWR5
IHJldHJ5IHN1Y2Nlc3MocnEgc3RhdGUgY2hhbmdlIHRvIGluZmxpZ2h0KS4KVGltZW91dCBwcm9j
ZXNzaW5nIG1heSB3cm9uZ2x5IHN0b3AgdGhlIHF1ZXVlIGFuZCBhYm9ydCB0aGUgcmVxdWVzdC4K
dGVhcmRvd25fbG9jayBzZXJpYWxpemUgdGhlIHByb2Nlc3Mgb2YgdGltZW91dCBhbmQgdGVhcmRv
d24sIGJ1dCBkbyBub3QgYXZvaWQgdGhlIHJhY2UuCkl0IG1pZ2h0IG5vdCBiZSBzYWZlLgo+IAo+
PiBJbiB0aGUgdGVhcmRvd24gcHJvY2VzcywgYWZ0ZXIgcXVpZXNjZWQgcXVldWVzIGRlbGV0ZSB0
aGUgdGltZXIgYW5kIGNhbmNlbCB0aGUgdGltZW91dCB3b3JrIG1heWJlIGEgYmV0dGVyIG9wdGlv
bi4KPiAKPiBTZWVtcyBiZXR0ZXIgc29sdXRpb24sIGdpdmVuIGl0IGlzIGFsaWduZWQgd2l0aCBO
Vk1FIFBDSSdzIHJlc2V0Cj4gaGFuZGxpbmcuIG52bWVfc3luY19xdWV1ZXMoKSBtYXkgYmUgY2Fs
bGVkIGluIG52bWVfdGNwX3RlYXJkb3duX2lvX3F1ZXVlcygpIHRvCj4gYXZvaWQgdGhpcyByYWNl
Lgo+IAo+IAo+IFRoYW5rcywKPiBNaW5nCj4gCj4gLgo+IAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
