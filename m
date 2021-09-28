Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B366C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 08:49:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0698061058
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 08:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0698061058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmm0cx16Zw4AHAOWUcjiflDEsD9E0+kFvTLXX4jQn3Y=; b=U2kDyZtu9bb4pp
	4ZgA4TskjESJsi9AeUilkGfOb1U7kn6H9eXIgN8msh56XoiocGq2SOdNhRYGPV6C0KwZAs2AQ05dG
	HN1pWa24r9AMR76biaQ9lq0ENTsWL3nMF8GT61ZIS8mh5uEgOudq0/9CMzn68fyxtYLUu/zbukWsc
	N3M9xSrgEyZLhuNxI7i1BNxLgyy9NJXijFsFd7HfV6eDbnR75pti3agTTI4LNUIYI+8tkpSOojWRj
	bJwSBFnG5Zi3RB4lOFZGfxrUlXvI51sp36IsPHDk+n07hGayyOzJ+gi8UWK7YmdHdTeSZGzvJWP+d
	OBluA52To+R5dh9WduGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV8nY-006KsA-5y; Tue, 28 Sep 2021 08:49:12 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV8nT-006KpG-La
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 08:49:10 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HJY7J2m4bz8tS2;
 Tue, 28 Sep 2021 16:48:12 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 16:49:03 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 16:49:02 +0800
Message-ID: <af6176ad-5f96-2b7e-e7e9-9694d0a0c1d4@huawei.com>
Date: Tue, 28 Sep 2021 16:49:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH V2 nvme-cli 1/2] initialize disk "access" variable
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "sunao.sun@huawei.com" <sunao.sun@huawei.com>, "jiangtao62@huawei.com"
 <jiangtao62@huawei.com>
References: <20210927014137.3756-1-chengjike.cheng@huawei.com>
 <20210927014137.3756-2-chengjike.cheng@huawei.com>
 <980ca996-f072-e8b7-b9d9-6e1b71b3c2cc@nvidia.com>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <980ca996-f072-e8b7-b9d9-6e1b71b3c2cc@nvidia.com>
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_014908_099439_2C7BF75A 
X-CRM114-Status: GOOD (  23.71  )
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

CuWcqCAyMDIxLzkvMjggMzozNCwgQ2hhaXRhbnlhIEt1bGthcm5pIOWGmemBkzoKPiBPbiA5LzI2
LzIxIDY6NDEgUE0sIGNoZW5namlrZSB3cm90ZToKPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4KPj4KPj4gV2hlbiBpdCBpcyBmYWls
ZWQgdG8gZ2V0IG52bWVfaWRfbnMgZGF0YSBmcm9tIE5WTWUgU3Vic3lzdGVtLCB0aGUgZmFpbHVy
ZSBtYXkgYmUgY2F1c2VkCj4+IGJ5IGEgbGluayBkaXNjb25uZWN0aW9uIG9yIGFuIGVycm9yIGNv
ZGUgcmV0dXJuZWQgYnkgdGhlIHN1YnN5c3RlbShzdWNoIGFzIE5WTUVfU0NfKikuCj4+IFRoZW4g
dGhlICJhY2Nlc3MiIG9mIGRpc2sgaXMgc2V0IHRvICJmYXVsdHkiKG90aGVyd2lzZSwgc2V0IHRo
ZSB2YWx1ZSB0byAibGl2ZSIpLgo+PiBTb21lIGRpc3BsYXlpbmcgY29udGVudCBvZiBmYXVsdCBk
ZXZpY2UgY2FuIGJlIG9idGFpbmVkIGZyb20gdGhlIGRpc2sgYXR0cmlidXRlIGZpbGVzLgo+Pgo+
IGNvbW1pdCBsb2cgaXMgb3Zlcmx5IGxvbmcgYW5kIHNvbWV3aGF0IG5lZWRzIGFuIGltcHJvdmVt
ZW50IGFib3V0IHdoYXQKPiBjb2RlIGNoYW5nZXMgd2UgYXJlIGRvaW5nLi4uIHNlZSBiZWxvdyBj
b21tZW50cy4uLgo+Cj4+IFNpZ25lZC1vZmYtYnk6IGNoZW5namlrZSA8Y2hlbmdqaWtlLmNoZW5n
QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiAgICBzcmMvbnZtZS9wcml2YXRlLmggfCAgMSArCj4+ICAg
IHNyYy9udm1lL3RyZWUuYyAgICB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0KPj4gICAgc3JjL252bWUvdHJlZS5oICAgIHwgIDggKysrKysrKwo+PiAg
ICAzIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9zcmMvbnZtZS9wcml2YXRlLmggYi9zcmMvbnZtZS9wcml2YXRlLmgKPj4g
aW5kZXggMmExNTFiZi4uMjU1YzFiMSAxMDA2NDQKPj4gLS0tIGEvc3JjL252bWUvcHJpdmF0ZS5o
Cj4+ICsrKyBiL3NyYy9udm1lL3ByaXZhdGUuaAo+PiBAQCAtMzcsNiArMzcsNyBAQCBzdHJ1Y3Qg
bnZtZV9ucyB7Cj4+ICAgICAgICAgICBfX3UzMiBuc2lkOwo+PiAgICAgICAgICAgY2hhciAqbmFt
ZTsKPj4gICAgICAgICAgIGNoYXIgKnN5c2ZzX2RpcjsKPj4gKyAgICAgICBjaGFyICphY2Nlc3M7
Cj4+Cj4+ICAgICAgICAgICBpbnQgbGJhX3NoaWZ0Owo+PiAgICAgICAgICAgaW50IGxiYV9zaXpl
Owo+PiBkaWZmIC0tZ2l0IGEvc3JjL252bWUvdHJlZS5jIGIvc3JjL252bWUvdHJlZS5jCj4+IGlu
ZGV4IDI5M2IwYzAuLmRlYTBmNDUgMTAwNjQ0Cj4+IC0tLSBhL3NyYy9udm1lL3RyZWUuYwo+PiAr
KysgYi9zcmMvbnZtZS90cmVlLmMKPj4gQEAgLTIyOSw5ICsyMjksMTEgQEAgbnZtZV9uc190IG52
bWVfc3Vic3lzdGVtX25leHRfbnMobnZtZV9zdWJzeXN0ZW1fdCBzLCBudm1lX25zX3QgbikKPj4g
ICAgc3RhdGljIHZvaWQgX19udm1lX2ZyZWVfbnMoc3RydWN0IG52bWVfbnMgKm4pCj4+ICAgIHsK
Pj4gICAgICAgICAgIGxpc3RfZGVsX2luaXQoJm4tPmVudHJ5KTsKPj4gLSAgICAgICBjbG9zZShu
LT5mZCk7Cj4+ICsgICAgICAgaWYgKG4tPmZkID4gMCkKPj4gKyAgICAgICAgICAgICAgIGNsb3Nl
KG4tPmZkKTsKPj4gICAgICAgICAgIGZyZWUobi0+bmFtZSk7Cj4+ICAgICAgICAgICBmcmVlKG4t
PnN5c2ZzX2Rpcik7Cj4+ICsgICAgICAgZnJlZShuLT5hY2Nlc3MpOwo+PiAgICAgICAgICAgZnJl
ZShuKTsKPj4gICAgfQo+Pgo+PiBAQCAtMTAyMyw5ICsxMDI1LDYgQEAgc3RhdGljIGludCBudm1l
X2NvbmZpZ3VyZV9jdHJsKG52bWVfY3RybF90IGMsIGNvbnN0IGNoYXIgKnBhdGgsCj4+ICAgICAg
ICAgICBjbG9zZWRpcihkKTsKPj4KPj4gICAgICAgICAgIGMtPmZkID0gbnZtZV9vcGVuKG5hbWUp
Owo+PiAtICAgICAgIGlmIChjLT5mZCA8IDApCj4+IC0gICAgICAgICAgICAgICByZXR1cm4gYy0+
ZmQ7Cj4+IC0KPj4gICAgICAgICAgIGMtPm5hbWUgPSBzdHJkdXAobmFtZSk7Cj4+ICAgICAgICAg
ICBjLT5zeXNmc19kaXIgPSAoY2hhciAqKXBhdGg7Cj4+ICAgICAgICAgICBjLT5maXJtd2FyZSA9
IG52bWVfZ2V0X2N0cmxfYXR0cihjLCAiZmlybXdhcmVfcmV2Iik7Cj4+IEBAIC0xMjc3LDYgKzEy
NzYsMTEgQEAgY29uc3QgY2hhciAqbnZtZV9uc19nZXRfbmFtZShudm1lX25zX3QgbikKPj4gICAg
ICAgICAgIHJldHVybiBuLT5uYW1lOwo+PiAgICB9Cj4+Cj4+ICtjb25zdCBjaGFyICpudm1lX25z
X2dldF9hY2Nlc3MobnZtZV9uc190IG4pCj4+ICt7Cj4+ICsgICAgICAgcmV0dXJuIG4tPmFjY2Vz
czsKPj4gK30KPj4gKwo+IHdoeSBpbnRyb2R1Y2UgYSBmdW5jdGlvbiB0aGF0IGlzIG5vdCB1c2Vk
IGluIHRoaXMgcGF0Y2ggPyBJcyB0aGlzIGEgcHJlcAo+IHBhdGNoIGlmIHNvIHBsZWFzZSB1cGRh
dGUgdGhlIGNvbW1pdCBsb2cgYWNjb3JkaW5nbHkuCj4KPj4gICAgY29uc3QgY2hhciAqbnZtZV9u
c19nZXRfbW9kZWwobnZtZV9uc190IG4pCj4+ICAgIHsKPj4gICAgICAgICAgIHJldHVybiBuLT5j
ID8gbi0+Yy0+bW9kZWwgOiBuLT5zLT5tb2RlbDsKPj4gQEAgLTE1MTUsNiArMTUxOSwzNyBAQCBm
cmVlX25zOgo+PiAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+ICAgIH0KPj4KPj4gK3N0YXRpYyBu
dm1lX25zX3QgbnZtZV9uc19nZXRfbG9jYWxfZGF0YShjb25zdCBjaGFyICpuYW1lLCBjb25zdCBj
aGFyICpwYXRoKQo+PiArewo+PiArICAgICAgIHN0cnVjdCBudm1lX25zICpuOwo+PiArICAgICAg
IGNoYXIgKm5zX2lkOwo+PiArCj4+ICsgICAgICAgbiA9IGNhbGxvYygxLCBzaXplb2YoKm4pKTsK
Pj4gKyAgICAgICBpZiAoIW4pIHsKPj4gKyAgICAgICAgICAgICAgIGVycm5vID0gRU5PTUVNOwo+
PiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+ICsgICAgICAgfQo+PiArICAgICAgIG1l
bXNldChuLCAwLCBzaXplb2Yoc3RydWN0IG52bWVfbnMpKTsKPj4gKwo+IHNldHRpbmcgdGhlIG1l
bW9yeSB0byB6ZXJvIHdoZW4gYWxsb2NhdGluZyBmcm9tIGNhbGxvYygpICA/Cj4KPj4gKyAgICAg
ICBuLT5uYW1lID0gc3RyZHVwKG5hbWUpOwo+PiArICAgICAgIG4tPmZkID0gLTE7Cj4+ICsgICAg
ICAgbnNfaWQgPSBudm1lX2dldF9hdHRyKHBhdGgsICJuc2lkIik7Cj4+ICsgICAgICAgaWYgKCFu
c19pZCkKPj4gKyAgICAgICAgICAgICAgIGdvdG8gZnJlZV9uczsKPiB0aGlzIGxhYmVsIGlzIHVz
ZWQgb25seSBvbmNlIGp1c3QgcmV0dXJuIGhlcmUgYW5kIHJlbW92ZSB0aGUgZ290byBsYWJlbC4K
Pgo+PiArICAgICAgIG4tPm5zaWQgPSBhdG9pKG5zX2lkKTsKPj4gKyAgICAgICBmcmVlKG5zX2lk
KTsKPj4gKwo+PiArICAgICAgIGxpc3RfaGVhZF9pbml0KCZuLT5wYXRocyk7Cj4+ICsgICAgICAg
bGlzdF9ub2RlX2luaXQoJm4tPmVudHJ5KTsKPj4gKwo+PiArICAgICAgIHJldHVybiBuOwo+PiAr
Cj4+ICtmcmVlX25zOgo+PiArICAgICAgIGZyZWUobi0+bmFtZSk7Cj4+ICsgICAgICAgZnJlZShu
KTsKPj4gKyAgICAgICByZXR1cm4gTlVMTDsKPiBhYm92ZSBlcnJvciBoYW5kbGluZyBjb2RlIHNo
b3VsZCBiZSBtb3ZlZCB0byBpZiAoIW5zX2lkKSAuLi4KPgo+PiArfQo+PiArCj4+ICAgIHN0YXRp
YyBzdHJ1Y3QgbnZtZV9ucyAqX19udm1lX3NjYW5fbmFtZXNwYWNlKGNvbnN0IGNoYXIgKnN5c2Zz
X2RpciwgY29uc3QgY2hhciAqbmFtZSkKPj4gICAgewo+PiAgICAgICAgICAgc3RydWN0IG52bWVf
bnMgKm47Cj4+IEBAIC0xNTI4LDkgKzE1NjMsMjEgQEAgc3RhdGljIHN0cnVjdCBudm1lX25zICpf
X252bWVfc2Nhbl9uYW1lc3BhY2UoY29uc3QgY2hhciAqc3lzZnNfZGlyLCBjb25zdCBjaGFyICoK
Pj4gICAgICAgICAgIH0KPj4KPj4gICAgICAgICAgIG4gPSBudm1lX25zX29wZW4obmFtZSk7Cj4+
IC0gICAgICAgaWYgKCFuKQo+PiArICAgICAgIGlmICghbikgewo+PiArICAgICAgICAgICAgICAg
biA9IG52bWVfbnNfZ2V0X2xvY2FsX2RhdGEobmFtZSwgcGF0aCk7Cj4+ICsgICAgICAgICAgICAg
ICBpZiAoIW4pCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9wYXRoOwo+PiAr
ICAgICAgICAgICAgICAgcmV0ID0gYXNwcmludGYoJm4tPmFjY2VzcywgIiVzIiwgImZhdWx0eSIp
Owo+PiArICAgICAgICAgICAgICAgaWYgKHJldCA8IDApCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZnJlZV9wYXRoOwo+PiArICAgICAgICAgICAgICAgZ290byBnZXRfYXR0cjsKPj4g
KyAgICAgICB9Cj4+ICsKPj4gKyAgICAgICByZXQgPSBhc3ByaW50Zigmbi0+YWNjZXNzLCAiJXMi
LCAibGl2ZSIpOwo+PiArICAgICAgIGlmIChyZXQgPCAwKQo+PiAgICAgICAgICAgICAgICAgICBn
b3RvIGZyZWVfcGF0aDsKPj4KPj4gK2dldF9hdHRyOgo+PiAgICAgICAgICAgbi0+c3lzZnNfZGly
ID0gcGF0aDsKPj4gICAgICAgICAgIHJldHVybiBuOwo+Pgo+PiBkaWZmIC0tZ2l0IGEvc3JjL252
bWUvdHJlZS5oIGIvc3JjL252bWUvdHJlZS5oCj4+IGluZGV4IDY4ZjVjYmYuLjdkM2QwNDkgMTAw
NjQ0Cj4+IC0tLSBhL3NyYy9udm1lL3RyZWUuaAo+PiArKysgYi9zcmMvbnZtZS90cmVlLmgKPj4g
QEAgLTQ1Miw2ICs0NTIsMTQgQEAgY29uc3QgY2hhciAqbnZtZV9uc19nZXRfc3lzZnNfZGlyKG52
bWVfbnNfdCBuKTsKPj4gICAgICovCj4+ICAgIGNvbnN0IGNoYXIgKm52bWVfbnNfZ2V0X25hbWUo
bnZtZV9uc190IG4pOwo+Pgo+PiArLyoqCj4+ICsgKiBudm1lX25zX2dldF9hY2Nlc3MoKSAtCj4+
ICsgKiBAbjoKPj4gKyAqCj4+ICsgKiBSZXR1cm46Cj4+ICsgKi8KPiBXcm9uZyBmdW5jdGlvbiBk
b2N1bWVudGF0aW9uIGNvbW1lbnQsIHlvdSBuZWVkIHRvIGJlIG1vcmUgZGVzY3JpcHRpdmUKPiB3
aHQgdGhlIGZ1bmN0aW9uIGlzIGRvaW5nLi4uCj4KPj4gK2NvbnN0IGNoYXIgKm52bWVfbnNfZ2V0
X2FjY2Vzcyhudm1lX25zX3Qgbik7Cj4+ICsKPj4gICAgLyoqCj4+ICAgICAqIG52bWVfbnNfZ2V0
X2Zpcm13YXJlKCkgLQo+PiAgICAgKiBAbjoKPj4gLS0KPj4gMi4yMS4wLndpbmRvd3MuMQo+PgpI
aSwgQ2hhaXRhbnlhCgpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMgdmVyeSBtdWNoLgpUaGlz
IHBhdGNoIGlzIGEgcHJlcCBwYXRjaCwgYW5kIHRoZSAibnZtZV9uc19nZXRfYWNjZXNzIiBmdW5j
dGlvbiBpcyAKdXNlZCBpbiB0aGUgbmV4dCBwYXRjaC4KSW4gYWRkaXRpb24sIEkgd2lsbCByZXNl
bmQgcGF0Y2ggVjMgYmFzZWQgb24geW91ciBjb21tZW50cy4KCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
