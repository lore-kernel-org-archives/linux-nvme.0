Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ED2C433E7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:26:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACFD21D7B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wc7DWSmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACFD21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bG/4G2xYgh6o2vH8M5vhga2xpkv20G1iwvZScCHy1Jw=; b=Wc7DWSmbEclOvltEbPiPhRztF
	HpDkdu2E9B4lOdkA4ov5RcKqj26HvPxWftY3r7KC7KSl6XYHSBGPpJkrSRk2KgiOG4aqEvbKO4ODB
	8nl0a/h8IosnoNK4V6gjJaEM4O0GIPbwLa3P+VqIk1BnfT0/HpkCnKmUZ3etB5nkCDNKyYBsjgkVx
	4GrwlVRtGuGPn3pi9vT7U6bVk57sKg74tWXlmlp3RnBOVcC0cVOMFXbWIyZwtK+qYA6b5yppwor/r
	i9g2dIni8dsa8gHo74gQm0ivUigT0Ac0MCncHvBwr+Y69rkuhXmV26vHth+I7Ck4WMzETmPJavbXj
	oDCsVddUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSVYB-0005dD-9h; Wed, 14 Oct 2020 01:25:55 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSVY8-0005c8-Ri
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 01:25:54 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 97C30B0AB24C55A98B78;
 Wed, 14 Oct 2020 09:25:44 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 09:25:44 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 14
 Oct 2020 09:25:43 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <0b5bfc44-d925-960d-b2a2-d0ba88b51111@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <dba6f24d-7d4f-a89e-047d-9d63837084dd@huawei.com>
Date: Wed, 14 Oct 2020 09:25:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0b5bfc44-d925-960d-b2a2-d0ba88b51111@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_212553_138717_0C2D79A4 
X-CRM114-Status: GOOD (  13.10  )
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
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzEwLzE0IDY6MzEsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4+Pj4gLS0g
Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9u
dm1lL2hvc3QvdGNwLmMKPj4+Pj4+PiBpbmRleCA2MjliMDI1Njg1ZDEuLjQ2NDI4ZmYwYjBmYyAx
MDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+Pj4+Pj4+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+Pj4+Pj4gQEAgLTIxNzUsNyArMjE3NSw3IEBAIHN0
YXRpYyB2b2lkIG52bWVfdGNwX2NvbXBsZXRlX3RpbWVkX291dChzdHJ1Y3QgcmVxdWVzdCAqcnEp
Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBmZW5jZSBvdGhlciBjb250ZXh0cyB0aGF0IG1h
eSBjb21wbGV0ZSB0aGUgY29tbWFuZCAqLwo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhf
bG9jaygmdG9fdGNwX2N0cmwoY3RybCktPnRlYXJkb3duX2xvY2spOwo+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqAgbnZtZV90Y3Bfc3RvcF9xdWV1ZShjdHJsLCBudm1lX3RjcF9xdWV1ZV9pZChyZXEt
PnF1ZXVlKSk7Cj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoCBpZiAoIWJsa19tcV9yZXF1ZXN0X2NvbXBs
ZXRlZChycSkpIHsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgIGlmIChibGtfbXFfcmVxdWVzdF9zdGFy
dGVkKHJxKSAmJiAhYmxrX21xX3JlcXVlc3RfY29tcGxldGVkKHJxKSkgewo+Pj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmVxKHJxKS0+c3RhdHVzID0gTlZNRV9T
Q19IT1NUX0FCT1JURURfQ01EOwo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3N5bmMocnEpOwo+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgfQo+Pj4gVGhpcyBtYXkganVzdCByZWR1Y2UgdGhlIHByb2JhYmlsaXR5LiBUaGUgY29u
Y3VycmVuY3kgb2YgdGltZW91dCBhbmQgdGVhcmRvd24gd2lsbCBjYXVzZSB0aGUgc2FtZSByZXF1
ZXN0Cj4+PiBiZSB0cmVhdGVkIHJlcGVhdGx5LCB0aGlzIGlzIG5vdCB3ZSBleHBlY3RlZC4KPj4K
Pj4gVGhhdCBpcyByaWdodCwgbm90IGxpa2UgU0NTSSwgTlZNRSBkb2Vzbid0IGFwcGx5IGF0b21p
YyByZXF1ZXN0IGNvbXBsZXRpb24sIHNvCj4+IHJlcXVlc3QgbWF5IGJlIGNvbXBsZXRlZC9mcmVl
ZCBmcm9tIGJvdGggdGltZW91dCAmIG52bWVfY2FuY2VsX3JlcXVlc3QoKS4KPj4KPj4gLnRlYXJk
b3duX2xvY2sgc3RpbGwgbWF5IGNvdmVyIHRoZSByYWNlIHdpdGggU2FnaSdzIHBhdGNoIGJlY2F1
c2UgdGVhcmRvd24KPj4gYWN0dWFsbHkgY2FuY2VscyByZXF1ZXN0cyBpbiBzeW5jIHN0eWxlLgo+
Pgo+Pj4gSW4gdGhlIHRlYXJkb3duIHByb2Nlc3MsIGFmdGVyIHF1aWVzY2VkIHF1ZXVlcyBkZWxl
dGUgdGhlIHRpbWVyIGFuZCBjYW5jZWwgdGhlIHRpbWVvdXQgd29yayBtYXliZSBhIGJldHRlciBv
cHRpb24uCj4+Cj4+IFNlZW1zIGJldHRlciBzb2x1dGlvbiwgZ2l2ZW4gaXQgaXMgYWxpZ25lZCB3
aXRoIE5WTUUgUENJJ3MgcmVzZXQKPj4gaGFuZGxpbmcuIG52bWVfc3luY19xdWV1ZXMoKSBtYXkg
YmUgY2FsbGVkIGluIG52bWVfdGNwX3RlYXJkb3duX2lvX3F1ZXVlcygpIHRvCj4+IGF2b2lkIHRo
aXMgcmFjZS4KPiAKPiBXZSBjYW4ndCBjYWxsIG52bWVfc3luY19xdWV1ZXMsIHRoYXQgZmx1c2hl
cyB0aGUgdGltZW91dCB3b3JrIHRoYXQgaXMKPiBzZXJpYWxpemluZyB3aXRoIHRoZSB0ZWFyZG93
biwgaXQgd2lsbCBkZWFkbG9jay4KeWVzLCB0aGUgdGVhcmRvd25fbG9jayBpcyBub3QgbmVlZGVk
IGlmIHdlIHN5bmNfcXVldWUuIFdlIGlzIHRlc3RpbmcgdGhlIHBhdGNoIHdpdGggbnZtZSBvdmVy
IHJvY2UuCj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
