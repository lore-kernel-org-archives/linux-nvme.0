Return-Path: <SRS0=S/y/=OA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A84C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 07:42:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896E160EE3
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 07:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 896E160EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	CC:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CenPV4oS0ADMMteWxdeAyw2mrXoz6H4Pd1O7ceuhk2I=; b=4S4rj+SNEHI6U/aSZl3lzJD2Xp
	7acsO8WRUn4WsC15UxZF6iQ0/lwebmKHrSkACv3BYRhXarr8W1kDXQWTutBcaxpR0Snm2mRnNwBYQ
	yO3FwTV8FXsoPVc0bRrlR8NOahfE+3d6Zig8sPI2UnTpbyXz6ROG98mfDZ47WA+HXDkSthXy/W+gx
	yPb5dtj4AMYYYfABIJCyidDeHxL6j0ARch7LMI0xTjs2rJb+zhx6GR1w3kNQcpTdRYKLsPsxkanNM
	oHGj9DBt8ieWYEeeJ6DikWqkiNE5POrOYAqbG6bHaaP8HXDEqC8GKyNuwfSdIqGcWfoJ5VwOM5chE
	uk3j1/Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mObAv-00C78b-B7; Fri, 10 Sep 2021 07:42:17 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mObAq-00C774-Bs
 for linux-nvme@lists.infradead.org; Fri, 10 Sep 2021 07:42:15 +0000
Received: from dggeme770-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H5SQj4hj7zbmLR;
 Fri, 10 Sep 2021 15:38:05 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme770-chm.china.huawei.com
 (10.3.19.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 10
 Sep 2021 15:42:07 +0800
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
From: liruozhu <liruozhu@huawei.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@infradead.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com> <YToUji9WujpL9vnt@infradead.org>
 <90356fc2-837c-0ba2-5fcf-d9e9dcc06dba@nvidia.com>
 <3f68da69-6e34-7bfd-438e-96f8f17525ac@huawei.com>
Message-ID: <b34626bd-947d-acb5-e4bb-196607cb8244@huawei.com>
Date: Fri, 10 Sep 2021 15:42:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <3f68da69-6e34-7bfd-438e-96f8f17525ac@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme770-chm.china.huawei.com (10.3.19.116)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210910_004212_802018_09E64CD2 
X-CRM114-Status: GOOD (  27.49  )
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

SGkgTWF4LAoKSSBmZWVsIEkgbWF5IGhhdmUgbWlzdW5kZXJzdG9vZCB3aGF0IHlvdSBtZWFuLkkg
Z3Vlc3MgeW91IHdhbnQgdG8ga25vdyAKd2hhdCB0ZXN0cyBJIGhhdmUgZG9uZSBmb3IgcGF0Y2hl
ZCBjb2RlLCBub3Qgb3JpZ2luYWwgb25lLgoKQ3VycmVudGx5IEkgaGF2ZSB0ZXN0ZWQgdGhlIHJl
Z3Jlc3Npb24gc2NlbmVzLCBhcyBtZW50aW9uZWQgaW4gdGhlIApwcmV2aW91cyBlbWFpbC4KCkkg
d2lsbCB0ZXN0IGFsbCB0aGUgc2NlbmVzIHlvdSBhcmUgaW50ZXJlc3RlZCBpbiBhbmQgdGhlbiBm
ZWVkYmFjayB0byB5b3UuCgpUaGFua3MuCk9uIDIwMjEvOS8xMCAxMDo1MCwgbGlydW96aHUgd3Jv
dGU6Cj4gSGkgTWF4LAo+Cj4gWWVzLCBJIGRpZCBlbmNvdW50ZXIgdGhpcyBwcm9ibGVtLiBJIHBv
c3RlZCB0aGUgZGV0YWlsZWQgbG9nIGluIHRoZSAKPiBjb3ZlciBsZXR0ZXIgb2YgdGhpcyBwYXRj
aC4KPgo+IEkgdGVzdGVkIGl0IHdpdGggSHVhd2VpIHN0b3JhZ2UgYXJyYXksIGtpbGwgbnZtZSB0
YXJnZXQgcHJvY2Vzc2VzKHdlIAo+IHVzZSBzZWxmLWRldmVsb3BlZCB1c2VyIG1vZGUgbnZtZSB0
YXJnZXQpCj4gd2hpbGUgaW5qZWN0IFBDSUUgQUVSIGVycm9ycyBvbiBhcnJheSBIQkEgY2FyZCBy
ZXBlYXRlZGx5Lgo+Cj4gSeKAmW0gbm90IHN1cmUgaWYgdGhlcmUgaXMgYSB3YXkgdG8gZWFzaWx5
IHJlcHJvZHVjZSBpdCB1c2luZyBzdGFuZGFyZCAKPiBzZXJ2ZXIgd2l0aCBrZXJuZWwgdGFyZ2V0
Lgo+IEJ1dCBJIHN0aWxsIHRoaW5rIHRoYXQgdGhlIGhvc3Qgc2lkZSBzaG91bGQgdHJ5IHRvIGF2
b2lkIHRoaXMgCj4gcG9zc2liaWxpdHkgb2YgY3Jhc2hpbmcuCj4KPiBUaGFua3MuCj4KPiBPbiAy
MDIxLzkvMTAgMTozMiwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Pgo+PiBPbiA5LzkvMjAyMSA1OjA1
IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IFRoaXMgbG9va3MgcmVhc29uYWJsZSB0
byBtZS7CoCBTYWdpLCBNYXg6IGFueSBjb21tZW50cz8KPj4+Cj4+PiBPbiBNb24sIFNlcCAwNiwg
MjAyMSBhdCAxMTo1MTozNEFNICswODAwLCBSdW96aHUgTGkgd3JvdGU6Cj4+Pj4gV2Ugc2hvdWxk
IGFsd2F5cyBkZXN0cm95IGNtX2lkIGJlZm9yZSBkZXN0cm95IHFwIHRvIGF2b2lkIHRvIGdldCBj
bWEKPj4+PiBldmVudCBhZnRlciBxcCB3YXMgZGVzdHJveWVkLCB3aGljaCBtYXkgbGVhZCB0byB1
c2UgYWZ0ZXIgZnJlZS4KPj4KPj4gRG8geW91IHJlYWxseSBlbmNvdW50ZXIgdXNlLWFmdGVyLWZy
ZWUgPwo+Pgo+PiBJIHRoaW5rIHRoZSBjb2RlIGxvb2tzIGNvcnJlY3QgYnV0IGZyb20gZXhwZXJp
ZW5jZSB3aXRoIFJETUEtQ00gSSAKPj4gd291bGQgbGlrZSB0byBrbm93IHdoaWNoIHRlc3RzIGRp
ZCB5b3UgcnVuIHdpdGggdGhpcyBjb2RlID8KPj4KPj4gaW50ZXJlc3RpbmcgdGVzdHMgYXJlOiBw
b3J0IHRvZ2dsaW5nIHdpdGgvd2l0aG91dCBJTywgdW5sb2FkIAo+PiBtbHg1L290aGVyX3JkbWFf
aHcgZHJpdmVycyBkdXJpbmcgY29ubmVjdGlvbiBlc3RhYmxpc2htZW50IG9yIGR1cmluZyAKPj4g
SU8sIHJlYm9vdCB0YXJnZXQsIHJlYm9vdCB0YXJnZXQgZHVyaW5nIGNvbm5lY3Rpb24gZXN0YWJs
aXNobWVudCwgCj4+IHJlYm9vdCB0YXJnZXQgZHVyaW5nIElPLgo+Pgo+PiBUaGFua3MuCj4+Cj4+
Cj4+Pj4gSW4gUkRNQSBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgZXJyb3IgZmxvdywgZG9uJ3Qg
ZGVzdHJveSBxcCBpbiBjbQo+Pj4+IGV2ZW50IGhhbmRsZXIuSnVzdCByZXBvcnQgY21fZXJyb3Ig
dG8gdXBwZXIgbGV2ZWwsIHFwIHdpbGwgYmUgZGVzdHJveQo+Pj4+IGluIG52bWVfcmRtYV9hbGxv
Y19xdWV1ZSgpIGFmdGVyIGRlc3Ryb3kgY20gaWQuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBS
dW96aHUgTGkgPGxpcnVvemh1QGh1YXdlaS5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9u
dm1lL2hvc3QvcmRtYS5jIHwgMTYgKysrLS0tLS0tLS0tLS0tLQo+Pj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+
Pj4+IGluZGV4IGE2ODcwNGUzOTA4NC4uMDQyYzU5NGJjNTdlIDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEu
Ywo+Pj4+IEBAIC02NTYsOCArNjU2LDggQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX2ZyZWVfcXVl
dWUoc3RydWN0IAo+Pj4+IG52bWVfcmRtYV9xdWV1ZSAqcXVldWUpCj4+Pj4gwqDCoMKgwqDCoCBp
ZiAoIXRlc3RfYW5kX2NsZWFyX2JpdChOVk1FX1JETUFfUV9BTExPQ0FURUQsICZxdWV1ZS0+Zmxh
Z3MpKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+Pj4gwqAgLcKgwqDCoCBudm1l
X3JkbWFfZGVzdHJveV9xdWV1ZV9pYihxdWV1ZSk7Cj4+Pj4gwqDCoMKgwqDCoCByZG1hX2Rlc3Ry
b3lfaWQocXVldWUtPmNtX2lkKTsKPj4+PiArwqDCoMKgIG52bWVfcmRtYV9kZXN0cm95X3F1ZXVl
X2liKHF1ZXVlKTsKPj4+PiDCoMKgwqDCoMKgIG11dGV4X2Rlc3Ryb3koJnF1ZXVlLT5xdWV1ZV9s
b2NrKTsKPj4+PiDCoCB9Cj4+Pj4gwqAgQEAgLTE4MTUsMTQgKzE4MTUsMTAgQEAgc3RhdGljIGlu
dCAKPj4+PiBudm1lX3JkbWFfY29ubl9lc3RhYmxpc2hlZChzdHJ1Y3QgbnZtZV9yZG1hX3F1ZXVl
ICpxdWV1ZSkKPj4+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBxdWV1ZS0+cXVldWVfc2l6
ZTsgaSsrKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IG52bWVfcmRtYV9wb3N0X3Jl
Y3YocXVldWUsICZxdWV1ZS0+cnNwX3JpbmdbaV0pOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAocmV0KQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2Rlc3Ryb3lfcXVl
dWVfaWI7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+PiDCoMKg
wqDCoMKgIH0KPj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+IC0KPj4+PiAtb3V0X2Rl
c3Ryb3lfcXVldWVfaWI6Cj4+Pj4gLcKgwqDCoCBudm1lX3JkbWFfZGVzdHJveV9xdWV1ZV9pYihx
dWV1ZSk7Cj4+Pj4gLcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+IMKgIH0KPj4+PiDCoCDCoCBzdGF0
aWMgaW50IG52bWVfcmRtYV9jb25uX3JlamVjdGVkKHN0cnVjdCBudm1lX3JkbWFfcXVldWUgKnF1
ZXVlLAo+Pj4+IEBAIC0xOTE2LDE0ICsxOTEyLDEwIEBAIHN0YXRpYyBpbnQgbnZtZV9yZG1hX3Jv
dXRlX3Jlc29sdmVkKHN0cnVjdCAKPj4+PiBudm1lX3JkbWFfcXVldWUgKnF1ZXVlKQo+Pj4+IMKg
wqDCoMKgwqAgaWYgKHJldCkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGN0cmwt
PmN0cmwuZGV2aWNlLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZG1hX2Nvbm5l
Y3RfbG9ja2VkIGZhaWxlZCAoJWQpLlxuIiwgcmV0KTsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgZ290
byBvdXRfZGVzdHJveV9xdWV1ZV9pYjsKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsK
Pj4+PiDCoMKgwqDCoMKgIH0KPj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+IC0KPj4+
PiAtb3V0X2Rlc3Ryb3lfcXVldWVfaWI6Cj4+Pj4gLcKgwqDCoCBudm1lX3JkbWFfZGVzdHJveV9x
dWV1ZV9pYihxdWV1ZSk7Cj4+Pj4gLcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+IMKgIH0KPj4+PiDC
oCDCoCBzdGF0aWMgaW50IG52bWVfcmRtYV9jbV9oYW5kbGVyKHN0cnVjdCByZG1hX2NtX2lkICpj
bV9pZCwKPj4+PiBAQCAtMTk1NCw4ICsxOTQ2LDYgQEAgc3RhdGljIGludCBudm1lX3JkbWFfY21f
aGFuZGxlcihzdHJ1Y3QgCj4+Pj4gcmRtYV9jbV9pZCAqY21faWQsCj4+Pj4gwqDCoMKgwqDCoCBj
YXNlIFJETUFfQ01fRVZFTlRfUk9VVEVfRVJST1I6Cj4+Pj4gwqDCoMKgwqDCoCBjYXNlIFJETUFf
Q01fRVZFTlRfQ09OTkVDVF9FUlJPUjoKPj4+PiDCoMKgwqDCoMKgIGNhc2UgUkRNQV9DTV9FVkVO
VF9VTlJFQUNIQUJMRToKPj4+PiAtwqDCoMKgwqDCoMKgwqAgbnZtZV9yZG1hX2Rlc3Ryb3lfcXVl
dWVfaWIocXVldWUpOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBmYWxsdGhyb3VnaDsKPj4+PiDCoMKg
wqDCoMKgIGNhc2UgUkRNQV9DTV9FVkVOVF9BRERSX0VSUk9SOgo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBkZXZfZGJnKHF1ZXVlLT5jdHJsLT5jdHJsLmRldmljZSwKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAiQ00gZXJyb3IgZXZlbnQgJWRcbiIsIGV2LT5ldmVudCk7Cj4+Pj4gLS0g
Cj4+Pj4gMi4xNi40Cj4+Pj4KPj4+Pgo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+Pj4gTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKPj4+PiBMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUKPj4+IC0tLWVuZCBxdW90ZWQgdGV4dC0tLQo+
PiAuCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IExpbnV4LW52bWUgbWFpbGluZyBsaXN0Cj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
