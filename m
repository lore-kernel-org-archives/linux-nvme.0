Return-Path: <SRS0=RvWm=BO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD30C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2020 01:50:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503602076C
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2020 01:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oQEdh56P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503602076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mvP5NZrWezXgSYympJlZafuyACXP47HXGQxkm+HEQLo=; b=oQEdh56PXWF0LtMad2PbvMU9Y
	XBp3NNlh5WbVyCFunME1+veCNRSUUUqScXp7Kpeq4Zx413+HXtCPhgqfIrObPn8JIPt2FiTuf+RwS
	9NRGJoDirzGsG8hGm0Dh3jhcGtkXUPgoJtD5fFGI8FcZu1J6fUq9oBMiEy2r8lOsuUYJRhFEjZ+6Z
	A4fgJtXPDLEh8vwf9RTod30QVLTQ5St6KDOzqXQRV5eP8mDopkM58NosL7kplFw/pN/xI+LcbMQKv
	t9fqwa8bzEvOrgZCkVSE462jaPnxD94rHQkGyvV651EdtOgcUxnyWel8siTgx9juKJicw68U2lTXY
	+Ai2wbBKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2m5c-0002Ms-TR; Tue, 04 Aug 2020 01:50:05 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2m5Y-0002MI-TW
 for linux-nvme@lists.infradead.org; Tue, 04 Aug 2020 01:50:02 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 41F96CAF5DA5F1CAC916;
 Tue,  4 Aug 2020 09:49:53 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 4 Aug 2020 09:49:50 +0800
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, James Smart
 <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
Date: Tue, 4 Aug 2020 09:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_215001_283621_00E8ECB7 
X-CRM114-Status: GOOD (  11.93  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvMyAyMzowMywgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+IEBAIC0xOTQ2
LDYgKzE5NDcsMjIgQEAgc3RhdGljIGludCBudm1lX3JkbWFfY21faGFuZGxlcihzdHJ1Y3QgcmRt
YV9jbV9pZCAqY21faWQsCj4+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gwqAgfQo+Pj4gK3N0
YXRpYyB2b2lkIG52bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQoc3RydWN0IHJlcXVlc3QgKnJx
KQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IG52bWVfcmRtYV9yZXF1ZXN0ICpyZXEgPSBibGtf
bXFfcnFfdG9fcGR1KHJxKTsKPj4+ICvCoMKgwqAgc3RydWN0IG52bWVfcmRtYV9xdWV1ZSAqcXVl
dWUgPSByZXEtPnF1ZXVlOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwg
PSBxdWV1ZS0+Y3RybDsKPj4+ICsKPj4+ICvCoMKgwqAgLyogZmVuY2Ugb3RoZXIgY29udGV4dHMg
dGhhdCBtYXkgY29tcGxldGUgdGhlIGNvbW1hbmQgKi8KPj4+ICvCoMKgwqAgZmx1c2hfd29yaygm
Y3RybC0+ZXJyX3dvcmspOwo+Pj4gK8KgwqDCoCBudm1lX3JkbWFfc3RvcF9xdWV1ZShxdWV1ZSk7
Cj4+IFRoZXJlIG1heWJlIGNvbmN1cnJlbnQgd2l0aCBlcnJvciByZWNvdmVyeSwgbWF5IGNhdXNl
IGFibm9ybWFsIGJlY2F1c2UKPj4gbnZtZV9yZG1hX3N0b3BfcXVldWUgd2lsbCByZXR1cm4gYnV0
IHRoZSBxdWV1ZSBpcyBub3Qgc3RvcGVkLAo+PiBtYXliZSBpcyBzdG9wcGluZyBieSB0aGUgZXJy
b3IgcmVjb3ZlcnkuCj4gCj4gZXJyX3dvcmsgZmx1c2ggdXNlZCB0byBmZW5jZSwgb25jZSB3ZSBk
aWQgcXVldWUgc3RvcCwgaXQgc2hvdWxkIGJlIHNhZmUKPiB0byBjb21wbGV0ZSB0aGUgY29tbWFu
ZCBmcm9tIHRoZSB0aW1lb3V0IGhhbmRsZXIuCgpGbHVzaCB3b3JrIGp1c3QgY2FuIGF2b2lkIHRy
aWdnZXIgZXJyb3IgcmVjb3ZlcnkgYnkgbnZtZV9yZG1hX3RpbWVvdXQgb3IKcmVkdWNlIGNvbmN1
cnJlbnQgcHJvYmFsaWJpdHkgdHJpZ2dlciBlcnJvciByZWNvdmVyeSBieSBvdGhlciBwcm9ncmVz
cywKYnV0IGNhbiBub3QgYXZvaWQuIGlmIG52bWVfcmRtYV9jbV9oYW5kbGVyIG9yIG90aGVyIHBy
b2dyZXNzIGNhbGwKbnZtZV9yZG1hX2Vycm9yX3JlY292ZXJ5LCBiZXR3ZWVuIGNoYW5nZSBzdGF0
ZSB0byBxdWV1ZV93b3JrIG1heQppbnRlcnJ1cHQgYnkgaGFyZCBpbnRlcnJ1cHQsIGFuZCB0aGVu
IHRpbWVvdXQgaGFwcGVuLCB0aHVzIGZsdXNoIHdvcmsKY2FuIG5vdCBhdm9pZCBjb25jdXJyZW50
LgpMaWtlIHRoaXM6CgpzdGF0aWMgdm9pZCBudm1lX3JkbWFfZXJyb3JfcmVjb3Zlcnkoc3RydWN0
IG52bWVfcmRtYV9jdHJsICpjdHJsKQp7CglpZiAoIW52bWVfY2hhbmdlX2N0cmxfc3RhdGUoJmN0
cmwtPmN0cmwsIE5WTUVfQ1RSTF9SRVNFVFRJTkcpKQoJCXJldHVybjsKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KbWF5IGludGVycnVwdCBieSBoYXJkIGludGVycnVwdCwgYW5kIHRo
ZW4gdGltZW91dCBwcm9ncmVzcyBmbHVzaCB3b3JrCmF0IHRoaXMgdGltZS4gVGh1cyBlcnJvciBy
ZWNvdmVyeSBhbmQgbnZtZV9yZG1hX2NvbXBsZXRlX3RpbWVkX291dCBtYXkKY29uY3VycmVudCB0
byBzdG9wIHF1ZXVlLiB3aWxsIGNhdXNlOiBlcnJvciByZWNvdmVyeSBtYXkgY2FuY2VsIHJlcXVl
c3QKb3IgbnZtZV9yZG1hX2NvbXBsZXRlX3RpbWVkX291dCBtYXkgY29tcGxldGUgcmVxdWVzdCwg
YnV0IHRoZSBxdWV1ZSBtYXkKbm90IGJlIHN0b3BlZC4gVGh1cyB3aWxsIGNhdXNlIGFibm9ybWFs
LgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoJcXVldWVfd29yayhudm1lX3Jlc2V0
X3dxLCAmY3RybC0+ZXJyX3dvcmspOwp9CgpBbm90aGVyLCBhbHRob3VnaCB0aGUgcHJvYmFiaWxp
dHkgb2Ygb2NjdXJyZW5jZSBpcyB2ZXJ5IGxvdywgcmVzZXQgd29yawphbmQgbnZtZV9yZG1hX2Nv
bXBsZXRlX3RpbWVkX291dCBtYXkgYWxzbyBjb25jdXJyZW50IHRvIHN0b3AgcXVldWUsIG1heQph
bHNvIGNhdXNlIGFibm9ybWFsLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
