Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D51C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:58:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3CE2395C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3CE2395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v8OKx3H4mLSiZl09ounM7yggasbKcsReQSb09wntUIE=; b=EHekPfPeOYaQsHLIksXGFt8jF
	YqFVMy0dHEHLIkxpq7/+iCZPLZGlfVnl4LDVesQsbXiG1CZND97VvMcOvH00SamF04mU4/RixznQQ
	H+WlxUiBObEKtHF+pFnfzjWe11GeQ7F1QlUpBdplyLO6wIV9vIrh/GP1euEpT6xLqw2jfPdTyAjvK
	nCVJlKEo8CvZa02saj6xFyv0AOeFnI6ltTvXG6+7s9H/F6I44DHTr9rDyBFQXN/fztTtM4SoEQt8O
	xQ36deNXq7t76EwkhahrwqOu3H/sZZ+8tkE5hkLHJNzr6IFyB+PhY+AsoSAOLIXdUsZM/EWcFEvTU
	k2rEEN5pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzwa1-0000Lt-Qm; Thu, 14 Jan 2021 06:58:01 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzwZy-0000KR-LP
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 06:58:00 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DGZpQ56GJzW0fh;
 Thu, 14 Jan 2021 14:55:58 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:57:39 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:57:38 +0800
Subject: Re: [PATCH] nvme-rdma: avoid repeated request completion for
 concurrent nvme_rdma_timeout
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210106063635.7452-1-lengchao@huawei.com>
 <002e7d37-433c-f8fa-f460-bfb2447d6bc0@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5129b717-1f4e-f7ab-640c-7f84ae7eb966@huawei.com>
Date: Thu, 14 Jan 2021 14:57:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <002e7d37-433c-f8fa-f460-bfb2447d6bc0@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_015800_112246_22C4F3AA 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMTQgOToxMSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPiBPbiAxLzUvMjEg
MTA6MzYgUE0sIENoYW8gTGVuZyB3cm90ZToKPj4gQSBjcmFzaCBoYXBwZW5zIHdoZW4gaW5qZWN0
IGNvbXBsZXRpbmcgcmVxdWVzdCBsb25nIHRpbWUobmVhcmx5IDMwcykuCj4+IEVhY2ggbmFtZSBz
cGFjZSBoYXMgYSByZXF1ZXN0IHF1ZXVlLCB3aGVuIGluamVjdCBjb21wbGV0aW5nIHJlcXVlc3Qg
bG9uZwo+PiB0aW1lLCBtdWx0aSByZXF1ZXN0IHF1ZXVlcyBtYXkgaGFzIHRpbWUgb3V0IHJlcXVl
c3RzIGF0IHRoZSBzYW1lIHRpbWUsCj4+IG52bWVfcmRtYV90aW1lb3V0IHdpbGwgZXhlY3V0ZSBj
b25jdXJyZW50bHkuIE11bHRpIHJlcXVlc3RzIGluIGRpZmZlcmVudAo+PiByZXF1ZXN0IHF1ZXVl
cyBtYXkgYmUgcXVldWVkIGluIHRoZSBzYW1lIHJkbWEgcXVldWUsIG11bHRpCj4+IG52bWVfcmRt
YV90aW1lb3V0IG1heSBjYWxsIG52bWVfcmRtYV9zdG9wX3F1ZXVlIGF0IHRoZSBzYW1lIHRpbWUu
Cj4+IFRoZSBmaXJzdCBudm1lX3JkbWFfdGltZW91dCB3aWxsIGNsZWFyIE5WTUVfUkRNQV9RX0xJ
VkUgYW5kIGNvbnRpbnVlCj4+IHN0b3BwaW5nIHRoZSByZG1hIHF1ZXVlKGRyYWluIHFwKSwgYnV0
IHRoZSBvdGhlcnMgY2hlY2sgTlZNRV9SRE1BX1FfTElWRQo+PiBpcyBhbHJlYWR5IGNsZWFyZWQs
IGFuZCB0aGVuIGRpcmVjdGx5IGNvbXBsZXRlIHRoZSByZXF1ZXN0cywgYnV0IHRoZQo+PiByZG1h
IHF1ZXVlIG1heSBiZSBub3Qgc3RvcHBlZCBhbmQgdGhlIHJlcXVlc3QgbWF5IGJlIGFscmVhZHkg
Y29tcGxldGVkCj4+IGluIHFwIGFuZCB3YWl0IHRyZWF0ZWQsIHRoZSByZXF1ZXN0IHdpbGwgYmUg
cmVwZWF0ZWQgY29tcGxldGVkLgo+PiBBZGQgYSBtdWx0ZXggbG9jayB0byBzZXJpYWxpemUgbnZt
ZV9yZG1hX3N0b3BfcXVldWUuCj4gCj4gVGhpcyBsb29rcyByZWFzb25hYmxlIHRvIG1lLAo+IAo+
IE1pbmQgc2VuZGluZyBvbmUgZm9yIG52bWUtdGNwIGFzIHdlbGw/Cm9rLCBJIHdpbGwgc2VuZCBw
YXRjaCB2MiBsYXR0ZXIuCj4gCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2No
YW9AaHVhd2VpLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyB8IDE1
ICsrKysrKysrKysrLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEu
YyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBpbmRleCBkZjlmNmY0NTQ5ZjEuLmQ1YzY2
ZTNlZWI0YSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBAQCAtOTcsNiArOTcsNyBAQCBzdHJ1Y3QgbnZt
ZV9yZG1hX3F1ZXVlIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgY29tcGxldGlvbsKgwqDCoCBjbV9k
b25lOwo+PiDCoMKgwqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBpX3N1cHBvcnQ7
Cj4+IMKgwqDCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcV9zaXplOwo+PiArwqDC
oMKgIHN0cnVjdCBtdXRleMKgwqDCoMKgwqDCoMKgIHF1ZXVlX2xvY2s7Cj4+IMKgIH07Cj4+IMKg
IHN0cnVjdCBudm1lX3JkbWFfY3RybCB7Cj4+IEBAIC01NzksNiArNTgwLDcgQEAgc3RhdGljIGlu
dCBudm1lX3JkbWFfYWxsb2NfcXVldWUoc3RydWN0IG52bWVfcmRtYV9jdHJsICpjdHJsLAo+PiDC
oMKgwqDCoMKgIGludCByZXQ7Cj4+IMKgwqDCoMKgwqAgcXVldWUgPSAmY3RybC0+cXVldWVzW2lk
eF07Cj4+ICvCoMKgwqAgbXV0ZXhfaW5pdCgmcXVldWUtPnF1ZXVlX2xvY2spOwo+PiDCoMKgwqDC
oMKgIHF1ZXVlLT5jdHJsID0gY3RybDsKPj4gwqDCoMKgwqDCoCBpZiAoaWR4ICYmIGN0cmwtPmN0
cmwubWF4X2ludGVncml0eV9zZWdtZW50cykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHF1ZXVlLT5w
aV9zdXBwb3J0ID0gdHJ1ZTsKPj4gQEAgLTU5OCw3ICs2MDAsOCBAQCBzdGF0aWMgaW50IG52bWVf
cmRtYV9hbGxvY19xdWV1ZShzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKg
wqAgaWYgKElTX0VSUihxdWV1ZS0+Y21faWQpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZf
aW5mbyhjdHJsLT5jdHJsLmRldmljZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImZh
aWxlZCB0byBjcmVhdGUgQ00gSUQ6ICVsZFxuIiwgUFRSX0VSUihxdWV1ZS0+Y21faWQpKTsKPj4g
LcKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHF1ZXVlLT5jbV9pZCk7Cj4+ICvCoMKgwqDC
oMKgwqDCoCByZXQgPSBQVFJfRVJSKHF1ZXVlLT5jbV9pZCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBn
b3RvIG91dF9kZXN0cm95X211dGV4Owo+PiDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoCBpZiAo
Y3RybC0+Y3RybC5vcHRzLT5tYXNrICYgTlZNRl9PUFRfSE9TVF9UUkFERFIpCj4+IEBAIC02Mjgs
NiArNjMxLDggQEAgc3RhdGljIGludCBudm1lX3JkbWFfYWxsb2NfcXVldWUoc3RydWN0IG52bWVf
cmRtYV9jdHJsICpjdHJsLAo+PiDCoCBvdXRfZGVzdHJveV9jbV9pZDoKPj4gwqDCoMKgwqDCoCBy
ZG1hX2Rlc3Ryb3lfaWQocXVldWUtPmNtX2lkKTsKPj4gwqDCoMKgwqDCoCBudm1lX3JkbWFfZGVz
dHJveV9xdWV1ZV9pYihxdWV1ZSk7Cj4+ICtvdXRfZGVzdHJveV9tdXRleDoKPj4gK8KgwqDCoCBt
dXRleF9kZXN0cm95KCZxdWV1ZS0+cXVldWVfbG9jayk7Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJl
dDsKPj4gwqAgfQo+PiBAQCAtNjM5LDkgKzY0NCwxMCBAQCBzdGF0aWMgdm9pZCBfX252bWVfcmRt
YV9zdG9wX3F1ZXVlKHN0cnVjdCBudm1lX3JkbWFfcXVldWUgKnF1ZXVlKQo+PiDCoCBzdGF0aWMg
dm9pZCBudm1lX3JkbWFfc3RvcF9xdWV1ZShzdHJ1Y3QgbnZtZV9yZG1hX3F1ZXVlICpxdWV1ZSkK
Pj4gwqAgewo+PiAtwqDCoMKgIGlmICghdGVzdF9hbmRfY2xlYXJfYml0KE5WTUVfUkRNQV9RX0xJ
VkUsICZxdWV1ZS0+ZmxhZ3MpKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiAtwqDCoMKg
IF9fbnZtZV9yZG1hX3N0b3BfcXVldWUocXVldWUpOwo+PiArwqDCoMKgIG11dGV4X2xvY2soJnF1
ZXVlLT5xdWV1ZV9sb2NrKTsKPj4gK8KgwqDCoCBpZiAodGVzdF9hbmRfY2xlYXJfYml0KE5WTUVf
UkRNQV9RX0xJVkUsICZxdWV1ZS0+ZmxhZ3MpKQo+PiArwqDCoMKgwqDCoMKgwqAgX19udm1lX3Jk
bWFfc3RvcF9xdWV1ZShxdWV1ZSk7Cj4+ICvCoMKgwqAgbXV0ZXhfdW5sb2NrKCZxdWV1ZS0+cXVl
dWVfbG9jayk7Cj4+IMKgIH0KPj4gwqAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX2ZyZWVfcXVldWUo
c3RydWN0IG52bWVfcmRtYV9xdWV1ZSAqcXVldWUpCj4+IEBAIC02NDksNiArNjU1LDcgQEAgc3Rh
dGljIHZvaWQgbnZtZV9yZG1hX2ZyZWVfcXVldWUoc3RydWN0IG52bWVfcmRtYV9xdWV1ZSAqcXVl
dWUpCj4+IMKgwqDCoMKgwqAgaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoTlZNRV9SRE1BX1FfQUxM
T0NBVEVELCAmcXVldWUtPmZsYWdzKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4g
K8KgwqDCoCBtdXRleF9kZXN0cm95KCZxdWV1ZS0+cXVldWVfbG9jayk7Cj4+IMKgwqDCoMKgwqAg
bnZtZV9yZG1hX2Rlc3Ryb3lfcXVldWVfaWIocXVldWUpOwo+PiDCoMKgwqDCoMKgIHJkbWFfZGVz
dHJveV9pZChxdWV1ZS0+Y21faWQpOwo+PiDCoCB9Cj4+Cj4gLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
