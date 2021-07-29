Return-Path: <SRS0=T4Lt=MV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102EC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 08:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D1560524
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 08:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7D1560524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ORZlD6ppbHFy8mPBfAkRcoWaDwYHfK04Y/UNRrsw2VA=; b=5CuP3u2y999/3+oS0QP0xUkWW/
	XhiSsN1oKn19EfuMQU0QIf7QqQgnbYru5H18QAcgR9XlxsZePXQ6CW4hlZ6rdpzRQSlg66P0fwgQG
	q3rC5I5bsKpbv5v9FrcXE5rx5pZHoW/y5uH89BmNf9NhRXbl7uSZslu4zAA05rXtB4Twf+rItWmN0
	qcnxxh5J7JaNIT+0+jfF2WSlNlePYEgBIfTxIzohXvzhU8VIeIeLKz07tVI/stmCgymAsp96ZXrsv
	xotI8ne6gGaDtQn9IMhH3vx9nITY0foi2aAG9JyC/DNek0Z1oGihdKnpxvkNW4V+bVFGmfyyjfmaV
	tAIKbdmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m91RN-003WYQ-4y; Thu, 29 Jul 2021 08:30:53 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m91RK-003WXX-8F
 for linux-nvme@lists.infradead.org; Thu, 29 Jul 2021 08:30:52 +0000
Received: from dggeme718-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gb3VV4Ytyz1CQBD
 for <linux-nvme@lists.infradead.org>; Thu, 29 Jul 2021 16:24:50 +0800 (CST)
Received: from [10.169.46.19] (10.169.46.19) by dggeme718-chm.china.huawei.com
 (10.1.199.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 16:30:47 +0800
Subject: Re: [PATCH] nvme-rdma: Don't update queue count when failing to set
 io queues
From: liruozhu <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
References: <20210728094120.27041-1-liruozhu@huawei.com>
Message-ID: <c3e35494-5e6d-aac3-c7bb-2e8dea456509@huawei.com>
Date: Thu, 29 Jul 2021 16:30:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20210728094120.27041-1-liruozhu@huawei.com>
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme718-chm.china.huawei.com (10.1.199.114)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210729_013050_509736_6B0D1AE0 
X-CRM114-Status: GOOD (  18.38  )
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CkkgcmVhbGl6ZSB0aGF0IHRoZXJlIGlzIGEgcHJvYmxlbSB3aXRoIHRoaXMgbW9kaWZpY2F0aW9u
LCB3aGljaCBtYXkgCmNhdXNlIGN0cmwtPnF1ZXVlX2NvdW50IHRvIGJlIGluY29uc2lzdGVudCB3
aXRoIHRoZSBhY3R1YWwgbnVtYmVyIHdoZW4gCnRoZSBjb25uZWN0aW9uIGlzIGRlbGV0ZWQuCgpJ
IHdpbGwgcmVzZW5kIGEgcGF0Y2ggYW5kIHRyeSB0byBleHBsYWluIHRoZSBwcm9ibGVtIG1vcmUg
Y2xlYXJseS4KCtTaIDIwMjEvNy8yOCAxNzo0MSwgUnVvemh1IExpINC0tcA6Cj4gV2UgdXBkYXRl
IGN0cmwtPnF1ZXVlX2NvdW50IGFuZCBzY2hlZHVsZSBhbm90aGVyIHJlY29ubmVjdCB3aGVuIGlv
IHF1ZXVlCj4gY291bnQgaXMgemVyby5CdXQgd2Ugd2lsbCBuZXZlciB0cnkgdG8gY3JlYXRlIGFu
eSBpbyBxdWV1ZSBpbiBuZXh0IHJlY28tCj4gbm5lY3Rpb24sIGJlY2F1c2UgY3RybC0+cXVldWVf
Y291bnQgYWxyZWFkeSBzZXQgdG8gemVyby5XZSB3aWxsIGVuZCB1cAo+IGhhdmluZyBhbiBhZG1p
bi1vbmx5IHNlc3Npb24gaW4gTGl2ZSBzdGF0ZSwgd2hpY2ggaXMgZXhhY3RseSB3aGF0IHdlIHRy
eQo+IHRvIGF2b2lkIGluIHRoZSBvcmlnaW5hbCBwYXRjaC4KPiBVcGRhdGUgY3RybC0+cXVldWVf
Y291bnQgYWZ0ZXIgcXVldWVfY291bnQgemVybyBjaGVja2luZyB0byBmaXggaXQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBSdW96aHUgTGkgPGxpcnVvemh1QGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4gaW5kZXggN2Y2YjNhOTkxNTAx
Li4zYmQ5Y2JjODAyNDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4g
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4gQEAgLTczNSwxMyArNzM1LDEzIEBAIHN0
YXRpYyBpbnQgbnZtZV9yZG1hX2FsbG9jX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwg
KmN0cmwpCj4gICAJaWYgKHJldCkKPiAgIAkJcmV0dXJuIHJldDsKPiAgIAo+IC0JY3RybC0+Y3Ry
bC5xdWV1ZV9jb3VudCA9IG5yX2lvX3F1ZXVlcyArIDE7Cj4gLQlpZiAoY3RybC0+Y3RybC5xdWV1
ZV9jb3VudCA8IDIpIHsKPiArCWlmIChucl9pb19xdWV1ZXMgPT0gMCkgewo+ICAgCQlkZXZfZXJy
KGN0cmwtPmN0cmwuZGV2aWNlLAo+ICAgCQkJInVuYWJsZSB0byBzZXQgYW55IEkvTyBxdWV1ZXNc
biIpOwo+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiAgIAl9Cj4gICAKPiArCWN0cmwtPmN0cmwucXVl
dWVfY291bnQgPSBucl9pb19xdWV1ZXMgKyAxOwo+ICAgCWRldl9pbmZvKGN0cmwtPmN0cmwuZGV2
aWNlLAo+ICAgCQkiY3JlYXRpbmcgJWQgSS9PIHF1ZXVlcy5cbiIsIG5yX2lvX3F1ZXVlcyk7Cj4g
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
