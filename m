Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0F1C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 02:32:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B0D61163
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 02:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B0D61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uhJ0rEIGUKYEiaKHmrvpJ9TUP8P1qhG7fBxo+nQL6oQ=; b=kFNJ2ZsNnhMxEw9pOXZ23o7qK
	hR0uKB5hMd8TE3bAk/RTRg0/VEaw10HostCQnCfB8pMDqPCn6L403tuj2/hMmdXwU7mqEUSLgBLa9
	fu5NE5rsbrsaR79PfOx8FlJUEQ5dnwoMPg9BC79sxZIdYrbvh0NN35mqYkAHw5hBUl2LKcNBNn9U2
	Vnsamo0Cx2nSUQUFwOkViFuT8Qath0bz4qJJHpwxrgpZ1oUrIGDbkLv3ZTrgXOZZkKJscmsMSPHnY
	yVgr7aSSuGcJFeJTq2l0cor22onAvActcq8SfkVrRfdZdzgKoieMFuo0wK/zcvj/qw1ZafnvKevWl
	t0ydj4jBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lar25-006iKU-WC; Mon, 26 Apr 2021 02:31:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lar23-006iJB-Ap
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 02:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=UWadgxZDLs9RD+ip+Me4Z/9isaw4q1BQ+MRnRZOba5A=; b=UiScg2GXte8qNgOgfY/MQXLI9j
 rwR/vCXdatJSKi/tf66MgkTdDehD9Fopk+VJ5Wi14NvBL/1gDAsmiDdaBNOhOCN9eRvvzN+sx/Ihl
 E9mwSyVDr8ODedtmdXvXhkPT06/cmtLcicup9hKbOBq9yLnqqppFvgxp/hC8iiEdpZTfirDXjlqqE
 YfVKbLqacXH3IlGxHWl2nmVqYoPxtvemOW1xptpiRE2YBHcZ4iotu1S0EOqKfvh0DTDoCTqVfieJW
 L2IvubrMsFiB680iZu0Q6dpjaG9wu9/d6dXO78ocJ2N37PhXxyrgCakAJjipX9dbdNXzXuZURXDZ0
 eLsBudOg==;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lar1x-00Fh3w-Kg
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 02:31:27 +0000
Received: from dggeml714-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FT83C74z8zYdW3;
 Mon, 26 Apr 2021 10:28:55 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml714-chm.china.huawei.com (10.3.17.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Apr 2021 10:31:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 10:31:10 +0800
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
To: Hannes Reinecke <hare@suse.de>, <mwilck@suse.com>, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig
 <hch@lst.de>
CC: Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210423133835.25479-1-mwilck@suse.com>
 <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <9c65df32-bbf5-68b3-566e-3b79f7e6f893@huawei.com>
Date: Mon, 26 Apr 2021 10:31:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <65167282-84e7-d08b-f97d-edb0d1372a49@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_193125_902041_73E2046C 
X-CRM114-Status: GOOD (  16.05  )
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

CgpPbiAyMDIxLzQvMjUgMTk6MzQsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzIzLzIx
IDM6MzggUE0sIG13aWxja0BzdXNlLmNvbSB3cm90ZToKPj4gRnJvbTogTWFydGluIFdpbGNrIDxt
d2lsY2tAc3VzZS5jb20+Cj4+Cj4+IFdlIGhhdmUgb2JzZXJ2ZWQgYSBmZXcgY3Jhc2hlcyBydW5f
dGltZXJfc29mdGlycSgpLCB3aGVyZSBhIGJyb2tlbgo+PiB0aW1lcl9saXN0IHN0cnVjdCBiZWxv
bmdpbmcgdG8gYW4gYW5hdHRfdGltZXIgd2FzIGVuY291bnRlcmVkLiBUaGUgYnJva2VuCj4+IHN0
cnVjdHVyZXMgbG9vayBsaWtlIHRoaXMsIGFuZCB3ZSBzZWUgYWN0dWFsbHkgbXVsdGlwbGUgb25l
cyBhdHRhY2hlZCB0bwo+PiB0aGUgc2FtZSB0aW1lciBiYXNlOgo+Pgo+PiBjcmFzaD4gc3RydWN0
IHRpbWVyX2xpc3QgMHhmZmZmOTI0NzFiY2ZkYzkwCj4+IHN0cnVjdCB0aW1lcl9saXN0IHsKPj4g
wqDCoCBlbnRyeSA9IHsKPj4gwqDCoMKgwqAgbmV4dCA9IDB4ZGVhZDAwMDAwMDAwMDEyMizCoCAv
LyBMSVNUX1BPSVNPTjIKPj4gwqDCoMKgwqAgcHByZXYgPSAweDAKPj4gwqDCoCB9LAo+PiDCoMKg
IGV4cGlyZXMgPSA0Mjk2MDIyOTMzLAo+PiDCoMKgIGZ1bmN0aW9uID0gMHhmZmZmZmZmZmMwNmRl
NWUwIDxudm1lX2FuYXR0X3RpbWVvdXQ+LAo+PiDCoMKgIGZsYWdzID0gMjAKPj4gfQo+Pgo+PiBJ
ZiBzdWNoIGEgdGltZXIgaXMgZW5jb3VudGVyZWQgaW4gcnVuX3RpbWVyX3NvZnRpcnEoKSwgdGhl
IGtlcm5lbAo+PiBjcmFzaGVzLiBUaGUgdGVzdCBzY2VuYXJpbyB3YXMgYW4gSS9PIGxvYWQgdGVz
dCB3aXRoIGxvdHMgb2YgTlZNZQo+PiBjb250cm9sbGVycywgc29tZSBvZiB3aGljaCB3ZXJlIHJl
bW92ZWQgYW5kIHJlLWFkZGVkIG9uIHRoZSBzdG9yYWdlIHNpZGUuCj4+Cj4gLi4uCj4gCj4gQnV0
IGlzbid0IHRoaXMgdGhlIHJlc3VsdCBvZiBkZXRhY2hfdGltZXIoKT8gSUUgdGhpcyBzdXNwaWNp
b3VzbHkgbG9va3MgbGlrZSBwZXJmZWN0bHkgbm9ybWFsIG9wZXJhdGlvbjsgaXMgeW91IGxvb2sg
YXQgZXhwaXJlX3RpbWVycygpIHdlJ3JlIGZpcnN0IGNhbGxpbmcgJ2RldGFjaF90aW1lcigpJyBi
ZWZvcmUgY2FsbGluZyB0aGUgdGltZXIgZnVuY3Rpb24sIGllIGV2ZXJ5IGNyYXNoIGluIHRoZSB0
aW1lciBmdW5jdGlvbiB3b3VsZCBoYXZlIHRoaXMgc2lnbmF0dXJlLgo+IEFuZCwgaW5jaWRlbnRh
bGx5LCBzbyB3b3VsZCBhbnkgdGltZXIgZnVuY3Rpb24gd2hpY2ggZG9lcyBub3QgY3Jhc2guCj4g
Cj4gU29ycnkgdG8ga2lsbCB5b3VyIGFuYWx5c2lzIC4uLgo+IAo+IFRoaXMgZG9lc24ndCBtZWFu
IHRoYXQgdGhlIHBhdGNoIGlzbid0IHZhbGlkIChpbiB0aGUgc2Vuc2UgdGhhdCBpdCByZXNvbHZl
IHRoZSBpc3N1ZSksIGJ1dCB3ZSBkZWZpbml0ZWx5IHdpbGwgbmVlZCB0byB3b3JrIG9uIHJvb3Qg
Y2F1c2UgYW5hbHlzaXMuClRoZSBwcm9jZXNzIG1heWJlOjEuYW5hX3dvcmsgYWRkIHRoZSB0aW1l
cjsyLmVycm9yIHJlY292ZXJ5IG9jY3VycywKaW4gcmVjb25uZWN0aW5nLCByZWluaXRpYWxpemUg
dGhlIHRpbWVyIGFuZCBjYWxsIG52bWVfcmVhZF9hbmFfbG9nLApudm1lX3JlYWRfYW5hX2xvZyBt
YXkgYWRkIHRoZSB0aW1lciBhZ2Fpbi4KVGhlIHNhbWUgdGltZXIgaXMgYWRkZWQgdHdpY2UsIGNy
YXNoIHdpbGwgaGFwcGVucyBsYXRlci4KCkluZGVlZCBhbmFfbG9nX2J1ZiBoYXMgdGhlIHNpbWls
YXIgYnVnLCBpdCdzIGJlZW4gZW5jb3VudGVyZWQgaW4gb3VyIHRlc3RpbmcuClRvIGZpeCB0aGlz
IGJ1ZywgSSBhbHNvIG1ha2UgdGhlIHNhbWUgcGF0Y2ggYW5kIHRlc3RlZCBmb3IgbW9yZSB0aGFu
IDIgd2Vla3MuCgpUaGlzIHBhdGNoIGNhbiBmaXggdGhlIGJvdGggYnVncy4KPiAKPiBDaGVlcmEs
Cj4gCj4gSGFubmVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
