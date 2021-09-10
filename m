Return-Path: <SRS0=S/y/=OA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A3C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 02:51:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812C56113E
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 02:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 812C56113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PP/Q55bYhGDMh2s9qm6mv3Tja3OoM43zQKxDJBaenec=; b=Jf0vTh7ri7b+XKt2COI4NpGOrn
	W7kJpFYeeloAIX8+kev4fkfdy4Qil+q+UBgnau2i2XopQAj1Y+3+hNSlEVIx1FNjCQPXmzllCkVqA
	cuBXmCdCm+OkvgR3LLpAfo2Id9sAcwicarOqxVFyxoIc+V681DTUfPIoUCoHVTCOCGH6pXGUSliSh
	Y/o9xc5nus0PjSukaPLyesG7VImtZi0jw6vvnivNK7ld1EK9eiNbRF+kgHBVmdiplQeyCnBTvNUFk
	9WFMfqswjZv05F5iT4mYRsaLcJI0cY1ZbYBoW2PcwNt9jlQxB8hcjile+KKH5EwoD6ekptsJIw8IS
	+yXYWQ6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOWco-00BbIB-D8; Fri, 10 Sep 2021 02:50:46 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOWcj-00BbHg-E1
 for linux-nvme@lists.infradead.org; Fri, 10 Sep 2021 02:50:43 +0000
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5Kxs2G06z8yKg;
 Fri, 10 Sep 2021 10:46:09 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme768-chm.china.huawei.com
 (10.3.19.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 10
 Sep 2021 10:50:30 +0800
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com> <YToUji9WujpL9vnt@infradead.org>
 <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <3f68da69-6e34-7bfd-438e-96f8f17525ac@huawei.com>
Date: Fri, 10 Sep 2021 10:50:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_195041_842324_1DF6B720 
X-CRM114-Status: GOOD (  22.72  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgTWF4LAoKWWVzLCBJIGRpZCBlbmNvdW50ZXIgdGhpcyBwcm9ibGVtLiBJIHBvc3RlZCB0aGUg
ZGV0YWlsZWQgbG9nIGluIHRoZSBjb3ZlciBsZXR0ZXIgb2YgdGhpcyBwYXRjaC4KCkkgdGVzdGVk
IGl0IHdpdGggSHVhd2VpIHN0b3JhZ2UgYXJyYXksIGtpbGwgbnZtZSB0YXJnZXQgcHJvY2Vzc2Vz
KHdlIHVzZSBzZWxmLWRldmVsb3BlZCB1c2VyIG1vZGUgbnZtZSB0YXJnZXQpCndoaWxlIGluamVj
dCBQQ0lFIEFFUiBlcnJvcnMgb24gYXJyYXkgSEJBIGNhcmQgcmVwZWF0ZWRseS4KCknigJltIG5v
dCBzdXJlIGlmIHRoZXJlIGlzIGEgd2F5IHRvIGVhc2lseSByZXByb2R1Y2UgaXQgdXNpbmcgc3Rh
bmRhcmQgc2VydmVyIHdpdGgga2VybmVsIHRhcmdldC4KQnV0IEkgc3RpbGwgdGhpbmsgdGhhdCB0
aGUgaG9zdCBzaWRlIHNob3VsZCB0cnkgdG8gYXZvaWQgdGhpcyBwb3NzaWJpbGl0eSBvZiBjcmFz
aGluZy4KClRoYW5rcy4KCk9uIDIwMjEvOS8xMCAxOjMyLCBNYXggR3VydG92b3kgd3JvdGU6Cj4K
PiBPbiA5LzkvMjAyMSA1OjA1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gVGhpcyBs
b29rcyByZWFzb25hYmxlIHRvIG1lLsKgIFNhZ2ksIE1heDogYW55IGNvbW1lbnRzPwo+Pgo+PiBP
biBNb24sIFNlcCAwNiwgMjAyMSBhdCAxMTo1MTozNEFNICswODAwLCBSdW96aHUgTGkgd3JvdGU6
Cj4+PiBXZSBzaG91bGQgYWx3YXlzIGRlc3Ryb3kgY21faWQgYmVmb3JlIGRlc3Ryb3kgcXAgdG8g
YXZvaWQgdG8gZ2V0IGNtYQo+Pj4gZXZlbnQgYWZ0ZXIgcXAgd2FzIGRlc3Ryb3llZCwgd2hpY2gg
bWF5IGxlYWQgdG8gdXNlIGFmdGVyIGZyZWUuCj4KPiBEbyB5b3UgcmVhbGx5IGVuY291bnRlciB1
c2UtYWZ0ZXItZnJlZSA/Cj4KPiBJIHRoaW5rIHRoZSBjb2RlIGxvb2tzIGNvcnJlY3QgYnV0IGZy
b20gZXhwZXJpZW5jZSB3aXRoIFJETUEtQ00gSSAKPiB3b3VsZCBsaWtlIHRvIGtub3cgd2hpY2gg
dGVzdHMgZGlkIHlvdSBydW4gd2l0aCB0aGlzIGNvZGUgPwo+Cj4gaW50ZXJlc3RpbmcgdGVzdHMg
YXJlOiBwb3J0IHRvZ2dsaW5nIHdpdGgvd2l0aG91dCBJTywgdW5sb2FkIAo+IG1seDUvb3RoZXJf
cmRtYV9odyBkcml2ZXJzIGR1cmluZyBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgb3IgZHVyaW5n
IAo+IElPLCByZWJvb3QgdGFyZ2V0LCByZWJvb3QgdGFyZ2V0IGR1cmluZyBjb25uZWN0aW9uIGVz
dGFibGlzaG1lbnQsIAo+IHJlYm9vdCB0YXJnZXQgZHVyaW5nIElPLgo+Cj4gVGhhbmtzLgo+Cj4K
Pj4+IEluIFJETUEgY29ubmVjdGlvbiBlc3RhYmxpc2htZW50IGVycm9yIGZsb3csIGRvbid0IGRl
c3Ryb3kgcXAgaW4gY20KPj4+IGV2ZW50IGhhbmRsZXIuSnVzdCByZXBvcnQgY21fZXJyb3IgdG8g
dXBwZXIgbGV2ZWwsIHFwIHdpbGwgYmUgZGVzdHJveQo+Pj4gaW4gbnZtZV9yZG1hX2FsbG9jX3F1
ZXVlKCkgYWZ0ZXIgZGVzdHJveSBjbSBpZC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBSdW96aHUg
TGkgPGxpcnVvemh1QGh1YXdlaS5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0
L3JkbWEuYyB8IDE2ICsrKy0tLS0tLS0tLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4+IGluZGV4IGE2
ODcwNGUzOTA4NC4uMDQyYzU5NGJjNTdlIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvcmRtYS5jCj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4+IEBAIC02NTYs
OCArNjU2LDggQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX2ZyZWVfcXVldWUoc3RydWN0IAo+Pj4g
bnZtZV9yZG1hX3F1ZXVlICpxdWV1ZSkKPj4+IMKgwqDCoMKgwqAgaWYgKCF0ZXN0X2FuZF9jbGVh
cl9iaXQoTlZNRV9SRE1BX1FfQUxMT0NBVEVELCAmcXVldWUtPmZsYWdzKSkKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm47Cj4+PiDCoCAtwqDCoMKgIG52bWVfcmRtYV9kZXN0cm95X3F1ZXVl
X2liKHF1ZXVlKTsKPj4+IMKgwqDCoMKgwqAgcmRtYV9kZXN0cm95X2lkKHF1ZXVlLT5jbV9pZCk7
Cj4+PiArwqDCoMKgIG52bWVfcmRtYV9kZXN0cm95X3F1ZXVlX2liKHF1ZXVlKTsKPj4+IMKgwqDC
oMKgwqAgbXV0ZXhfZGVzdHJveSgmcXVldWUtPnF1ZXVlX2xvY2spOwo+Pj4gwqAgfQo+Pj4gwqAg
QEAgLTE4MTUsMTQgKzE4MTUsMTAgQEAgc3RhdGljIGludCAKPj4+IG52bWVfcmRtYV9jb25uX2Vz
dGFibGlzaGVkKHN0cnVjdCBudm1lX3JkbWFfcXVldWUgKnF1ZXVlKQo+Pj4gwqDCoMKgwqDCoCBm
b3IgKGkgPSAwOyBpIDwgcXVldWUtPnF1ZXVlX3NpemU7IGkrKykgewo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHJldCA9IG52bWVfcmRtYV9wb3N0X3JlY3YocXVldWUsICZxdWV1ZS0+cnNwX3Jpbmdb
aV0pOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBnb3RvIG91dF9kZXN0cm95X3F1ZXVlX2liOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqAgwqDCoMKgwqDCoCByZXR1
cm4gMDsKPj4+IC0KPj4+IC1vdXRfZGVzdHJveV9xdWV1ZV9pYjoKPj4+IC3CoMKgwqAgbnZtZV9y
ZG1hX2Rlc3Ryb3lfcXVldWVfaWIocXVldWUpOwo+Pj4gLcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4g
wqAgfQo+Pj4gwqAgwqAgc3RhdGljIGludCBudm1lX3JkbWFfY29ubl9yZWplY3RlZChzdHJ1Y3Qg
bnZtZV9yZG1hX3F1ZXVlICpxdWV1ZSwKPj4+IEBAIC0xOTE2LDE0ICsxOTEyLDEwIEBAIHN0YXRp
YyBpbnQgbnZtZV9yZG1hX3JvdXRlX3Jlc29sdmVkKHN0cnVjdCAKPj4+IG52bWVfcmRtYV9xdWV1
ZSAqcXVldWUpCj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfZXJyKGN0cmwtPmN0cmwuZGV2aWNlLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgInJkbWFfY29ubmVjdF9sb2NrZWQgZmFpbGVkICglZCkuXG4iLCByZXQpOwo+Pj4gLcKgwqDC
oMKgwqDCoMKgIGdvdG8gb3V0X2Rlc3Ryb3lfcXVldWVfaWI7Cj4+PiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJldDsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsK
Pj4+IC0KPj4+IC1vdXRfZGVzdHJveV9xdWV1ZV9pYjoKPj4+IC3CoMKgwqAgbnZtZV9yZG1hX2Rl
c3Ryb3lfcXVldWVfaWIocXVldWUpOwo+Pj4gLcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gwqAgfQo+
Pj4gwqAgwqAgc3RhdGljIGludCBudm1lX3JkbWFfY21faGFuZGxlcihzdHJ1Y3QgcmRtYV9jbV9p
ZCAqY21faWQsCj4+PiBAQCAtMTk1NCw4ICsxOTQ2LDYgQEAgc3RhdGljIGludCBudm1lX3JkbWFf
Y21faGFuZGxlcihzdHJ1Y3QgCj4+PiByZG1hX2NtX2lkICpjbV9pZCwKPj4+IMKgwqDCoMKgwqAg
Y2FzZSBSRE1BX0NNX0VWRU5UX1JPVVRFX0VSUk9SOgo+Pj4gwqDCoMKgwqDCoCBjYXNlIFJETUFf
Q01fRVZFTlRfQ09OTkVDVF9FUlJPUjoKPj4+IMKgwqDCoMKgwqAgY2FzZSBSRE1BX0NNX0VWRU5U
X1VOUkVBQ0hBQkxFOgo+Pj4gLcKgwqDCoMKgwqDCoMKgIG52bWVfcmRtYV9kZXN0cm95X3F1ZXVl
X2liKHF1ZXVlKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBmYWxsdGhyb3VnaDsKPj4+IMKgwqDCoMKg
wqAgY2FzZSBSRE1BX0NNX0VWRU5UX0FERFJfRVJST1I6Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGV2X2RiZyhxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiQ00gZXJyb3IgZXZlbnQgJWRcbiIsIGV2LT5ldmVudCk7Cj4+PiAtLSAKPj4+IDIu
MTYuNAo+Pj4KPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+Pj4gTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKPj4+IExpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwo+Pj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCj4+IC0tLWVuZCBxdW90ZWQgdGV4dC0tLQo+IC4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
