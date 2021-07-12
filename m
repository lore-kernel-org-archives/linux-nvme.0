Return-Path: <SRS0=IqcX=ME=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC78C07E99
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 13:24:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B80B60FE9
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 13:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B80B60FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yf3QIDbdytA5QmffxDxjXW8hY/FHkTaSZV77+r2Ldmg=; b=G1lZdi8McK/7iZddXpEoDKcC94
	8pGxKKvN/F8RDh7bMPD0asW6YQagdMHvTfsUniQtx9EgrQcYpan0xG/X+yfq7cNrwJc+z3vKDLT1n
	VyZJG22G2X12+ZCZN5+5fhbdAyAHgYb+OCu8u3Y84trsKCLrb4VGBUscM8Ja0e3J6cmmQ6p9PNVlv
	6iQbU0P/FtAYd4noP1W9Vp2RF2tSqnbxExab0vYGiKIm4H7WIi1d5j+hAsGOLhha8v39ZRYTJ7QST
	sujm4NOSOShadB43Uxe3CYron2mYfOoVKlhqOA/nkCnhqy/s45agDYTGFlbe/lN3CLWjuFlL87Ksp
	9K0BQMmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2vvC-007O19-Gy; Mon, 12 Jul 2021 13:24:30 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2vuy-007O0P-0Y
 for linux-nvme@lists.infradead.org; Mon, 12 Jul 2021 13:24:18 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GNkq55C33zXs7H;
 Mon, 12 Jul 2021 21:18:25 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 21:24:01 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 12 Jul 2021 21:24:00 +0800
Subject: Re: [PATCH] nvme-pci: Don't WARN_ON in nvme_reset_work if ctrl.state
 is not RESETTING
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <rakesh@tuxera.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <yukuai3@huawei.com>
References: <20210705133829.349660-1-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2563e82f-6e0a-4c54-9ca8-afd7b7754246@huawei.com>
Date: Mon, 12 Jul 2021 21:24:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210705133829.349660-1-chengzhihao1@huawei.com>
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210712_062416_612011_5C127DC7 
X-CRM114-Status: GOOD (  16.76  )
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

1NogMjAyMS83LzUgMjE6MzgsIFpoaWhhbyBDaGVuZyDQtLXAOgo+IEZvbGxvd2xpbmcgcHJvY2Vz
czoKPiBudm1lX3Byb2JlCj4gICAgbnZtZV9yZXNldF9jdHJsCj4gICAgICBudm1lX2NoYW5nZV9j
dHJsX3N0YXRlKGN0cmwsIE5WTUVfQ1RSTF9SRVNFVFRJTkcpCj4gICAgICBxdWV1ZV93b3JrKG52
bWVfcmVzZXRfd3EsICZjdHJsLT5yZXNldF93b3JrKQo+Cj4gLS0tLS0tLS0tLS0tLS0+CW52bWVf
cmVtb3ZlCj4gCQkgIG52bWVfY2hhbmdlX2N0cmxfc3RhdGUoJmRldi0+Y3RybCwgTlZNRV9DVFJM
X0RFTEVUSU5HKQo+IHdvcmtlcl90aHJlYWQKPiAgICBwcm9jZXNzX29uZV93b3JrCj4gICAgICBu
dm1lX3Jlc2V0X3dvcmsKPiAgICAgIFdBUk5fT04oZGV2LT5jdHJsLnN0YXRlICE9IE5WTUVfQ1RS
TF9SRVNFVFRJTkcpCj4KPiAsIHdoaWNoIHdpbGwgdHJpZ2dlciBXQVJOX09OIGluIG52bWVfcmVz
ZXRfd29yaygpOgo+IFsgIDEyNy41MzQyOThdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDEzOSBhdCBk
cml2ZXJzL252bWUvaG9zdC9wY2kuYzoyNTk0Cj4gWyAgMTI3LjUzNjE2MV0gQ1BVOiAwIFBJRDog
MTM5IENvbW06IGt3b3JrZXIvdTg6NyBOb3QgdGFpbnRlZCA1LjEzLjAKPiBbICAxMjcuNTUyNTE4
XSBDYWxsIFRyYWNlOgo+IFsgIDEyNy41NTI4NDBdICA/IGt2bV9zY2hlZF9jbG9ja19yZWFkKzB4
MjUvMHg0MAo+IFsgIDEyNy41NTM5MzZdICA/IG5hdGl2ZV9zZW5kX2NhbGxfZnVuY19zaW5nbGVf
aXBpKzB4MWMvMHgzMAo+IFsgIDEyNy41NTUxMTddICA/IHNlbmRfY2FsbF9mdW5jdGlvbl9zaW5n
bGVfaXBpKzB4OWIvMHgxMzAKPiBbICAxMjcuNTU2MjYzXSAgPyBfX3NtcF9jYWxsX3NpbmdsZV9x
dWV1ZSsweDQ4LzB4NjAKPiBbICAxMjcuNTU3Mjc4XSAgPyB0dHd1X3F1ZXVlX3dha2VsaXN0KzB4
ZmEvMHgxYzAKPiBbICAxMjcuNTU4MjMxXSAgPyB0cnlfdG9fd2FrZV91cCsweDI2NS8weDlkMAo+
IFsgIDEyNy41NTkxMjBdICA/IGV4dDRfZW5kX2lvX3Jzdl93b3JrKzB4MTYwLzB4MjkwCj4gWyAg
MTI3LjU2MDExOF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgyOGMvMHg2NDAKPiBbICAxMjcuNTYxMDAy
XSAgd29ya2VyX3RocmVhZCsweDM5YS8weDcwMAo+IFsgIDEyNy41NjE4MzNdICA/IHJlc2N1ZXJf
dGhyZWFkKzB4NTgwLzB4NTgwCj4gWyAgMTI3LjU2MjcxNF0gIGt0aHJlYWQrMHgxOGMvMHgxZTAK
PiBbICAxMjcuNTYzNDQ0XSAgPyBzZXRfa3RocmVhZF9zdHJ1Y3QrMHg3MC8weDcwCj4gWyAgMTI3
LjU2NDM0N10gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwCj4KPiBUaGUgcHJlY2VkaW5nIHByb2Js
ZW0gY2FuIGJlIGVhc2lseSByZXByb2R1Y2VkIGJ5IGV4ZWN1dGluZyBmb2xsb3dpbmcKPiBzY3Jp
cHQgKGJhc2VkIG9uIGJsa3Rlc3RzIHN1aXRlKToKPiB0ZXN0KCkgewo+ICAgIHBkZXY9IiQoX2dl
dF9wY2lfZGV2X2Zyb21fYmxrZGV2KSIKPiAgICBzeXNmcz0iL3N5cy9idXMvcGNpL2RldmljZXMv
JHtwZGV2fSIKPiAgICBmb3IgKChpID0gMDsgaSA8IDEwOyBpKyspKTsgZG8KPiAgICAgIGVjaG8g
MSA+ICIkc3lzZnMvcmVtb3ZlIgo+ICAgICAgZWNobyAxID4gL3N5cy9idXMvcGNpL3Jlc2Nhbgo+
ICAgIGRvbmUKPiB9Cj4KPiBTaW5jZSB0aGUgZGV2aWNlIGN0cmwgY291bGQgYmUgdXBkYXRlZCBh
cyBhbiBub24tUkVTRVRUSU5HIHN0YXRlIGJ5Cj4gcmVwZWF0aW5nIHByb2JlL3JlbW92ZSBpbiB1
c2Vyc3BhY2UgKHdoaWNoIGlzIGEgbm9ybWFsIHNpdHVhdGlvbiksIHdlCj4gY2FuIHJlcGxhY2Ug
c3RhY2sgZHVtcGluZyBXQVJOX09OIHdpdGggYSB3YXJubmluZyBtZXNzYWdlLgo+Cj4gRml4ZXM6
IDgyYjA1N2NhZWZhZmYgKCJudm1lLXBjaTogZml4IG11bHRpcGxlIGN0cmwgcmVtb3ZhbCBzY2hl
ZHVsaW4iKQo+IFNpZ25lZC1vZmYtYnk6IFpoaWhhbyBDaGVuZyA8Y2hlbmd6aGloYW8xQGh1YXdl
aS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9wY2kuYyB8IDQgKysrLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKPiBp
bmRleCBhMjliMTcwNzAxZmMuLjk2NmE0Yzg0ZTY5OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCj4gQEAgLTI1OTEs
NyArMjU5MSw5IEBAIHN0YXRpYyB2b2lkIG52bWVfcmVzZXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCj4gICAJYm9vbCB3YXNfc3VzcGVuZCA9ICEhKGRldi0+Y3RybC5jdHJsX2NvbmZp
ZyAmIE5WTUVfQ0NfU0hOX05PUk1BTCk7Cj4gICAJaW50IHJlc3VsdDsKPiAgIAo+IC0JaWYgKFdB
Uk5fT04oZGV2LT5jdHJsLnN0YXRlICE9IE5WTUVfQ1RSTF9SRVNFVFRJTkcpKSB7Cj4gKwlpZiAo
ZGV2LT5jdHJsLnN0YXRlICE9IE5WTUVfQ1RSTF9SRVNFVFRJTkcpIHsKPiArCQlkZXZfd2Fybihk
ZXYtPmN0cmwuZGV2aWNlLCAiY3RybCBzdGF0ZSAlZCBpcyBub3QgUkVTRVRUSU5HXG4iLAo+ICsJ
CQkgZGV2LT5jdHJsLnN0YXRlKTsKPiAgIAkJcmVzdWx0ID0gLUVOT0RFVjsKPiAgIAkJZ290byBv
dXQ7Cj4gICAJfQoKZnJpZW5kbHkgcGluZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
