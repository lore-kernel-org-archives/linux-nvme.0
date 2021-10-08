Return-Path: <SRS0=1aKD=O4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADEEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:24:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3383860F44
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3383860F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CoBwTQQTgQWaT4wB/WD8m5jnhKz0SKuzJquycAbFiE4=; b=2u18S/iDwEaudU
	TVoHXBlc6H9jIPxzyZ30DbxD3dfuSEqnGh2YBqNBljEfbLO3padU1FC8NU/29qi95ekY5QQVvF2Ih
	zxjZ8R7d3ENyp558dXLDcXLC3pidU9RQrZ6kSYqqcBc8MdwDnkwtpWV3GMr72uAxhzlVlyBw0t1MI
	BplObR59pf1PSjy+WadXuSs2GohXqmzuHeQp1R669P6HFZkGD7SoshP4d2HuKgwC2Flu+4/Td9nti
	qq87mafdn5JJ6m/QRmBM6rwDR2Z26UMbg42Krx7J7+QWjqUozpkP9CZICJsTiCuaGp7taIDY6tMMb
	4nNGLn7OuZX36BhxCAHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYoud-002gR3-U6; Fri, 08 Oct 2021 12:23:43 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYoua-002gPn-K7
 for linux-nvme@lists.infradead.org; Fri, 08 Oct 2021 12:23:42 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HQnPy4r2BzPjtw;
 Fri,  8 Oct 2021 20:22:30 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 20:23:32 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 20:23:31 +0800
Message-ID: <c4f3ca12-2f7c-8857-a2ec-feed87390b1a@huawei.com>
Date: Fri, 8 Oct 2021 20:23:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH V3 nvme-cli 1/2] initialize disk "access" variable
To: Sagi Grimberg <sagi@grimberg.me>, <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>, <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
References: <20210928085050.4141-1-chengjike.cheng@huawei.com>
 <20210928085050.4141-2-chengjike.cheng@huawei.com>
 <e916dbea-8796-5ed1-06f6-4d89c72f3b69@grimberg.me>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <e916dbea-8796-5ed1-06f6-4d89c72f3b69@grimberg.me>
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_052340_922607_BAFE1203 
X-CRM114-Status: GOOD (  14.65  )
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

CuWcqCAyMDIxLzkvMjkgNDo0NSwgU2FnaSBHcmltYmVyZyDlhpnpgZM6Cj4KPj4gKFRoaXMgaXMg
YSBwcmVwIHBhdGNoLCB3aGljaCBwcm92aWRlcyBmdW5jdGlvbnMgZm9yIHRoZSBuZXh0ICJwYXRj
aCAKPj4gMi8yIikKPj4gV2hlbiBpdCBpcyBmYWlsZWQgdG8gZ2V0IG52bWVfaWRfbnMgZGF0YSBm
cm9tIE5WTWUgU3Vic3lzdGVtLgo+Cj4gSWYgdGhlcmUgd2FzIGEgZmFpbHVyZSB0aGUgbnNpZCBz
aG91bGQgYmUgLTEsIGFuZCBhbGwgdGhlIHNpemUgaW5mbyAKPiBzaG91bGQgYmUgemVybywgdGhh
dCBpcyBlbm91Z2ggb2YgYW4gaW5kaWNhdGlvbiB0aGF0IHRoZSBucyBpcyAiZmF1bHR5Ii4KPgo+
IEFsc28gbGl2ZS9mYXVsdHkgaXMgbm90IGEgZ29vZCB0ZXJtaW5vbG9neSBmb3IgcGF0aCBhY2Nl
c3MuCj4gTWF5YmUgZnVsbC9wYXJ0aWFsIG9yIGNvbXBsZXRlL2luY29tcGxldGUuCj4KPiBJIHRo
b3VnaHQgdGhhdCB0aGlzIHdhcyBhYm91dCBzaG93aW5nIHRoZSBjb21wbGV0ZW5lc3Mgb2YgdGhl
Cj4gcGF0aCBhY2Nlc3MgZm9yIGEgZ2l2ZW4gbnMsIHJlZ2FyZGxlc3Mgb2YgZmFpbHVyZSBvZiBp
ZGVudGlmeS1ucy4uLgo+Cj4gTWVhbmluZyB0aGF0IGlmIEkgaGF2ZSBhIG5zIHdpdGggMiBwYXRo
cywgd2hlcmUgb25lIGlzIGxpdmUgYW5kIHRoZQo+IG90aGVyIGlzIGNvbm5lY3RpbmcvcmVzZXR0
aW5nIHRoZW4gIlBhdGggQWNjZXNzIiB3b3VsZCBiZSAiaW5jb21wbGV0ZSIKPiBvciAicGFydGlh
bCIuLiBBbHNvIGluIHRoZSBjYXNlIHdoZXJlIGFsbCBwYXRocyBhcmUgbGl2ZSwgYnV0IHNvbWUK
PiBoYXZlIEFOQSBzdGF0ZSAiaW5hY2Nlc3NpYmxlIiBvciAicGVyc2lzdGVudCBsb3NzIiB0aGVu
ICJQYXRoIEFjY2VzcyIKPiB3b3VsZCBiZSAicGFydGlhbCIgYW5kIG9ubHkgaWYgYWxsIHBhdGhz
IGFyZSAibGl2ZSIgYW5kIEFOQSBhY2Nlc3NpYmxlCj4gaS5lLiAib3B0aW1pemVkL25vbi1vcHRp
bWl6ZWQiIGl0IHdpbGwgc2hvdyAiZnVsbC9jb21wbGV0ZSIgUGF0aAo+IEFjY2Vzcy4uLgo+Cj4g
T3RoZXJ3aXNlLCBJIGRvbid0IHNlZSB0aGUgcG9pbnQgaW4gYWRkaW5nIHRoaXMgaW5mb3JtYXRp
b24gdG8KPiBudm1lIGxpc3Qgb3V0cHV0Lgo+IC4KCkhpLFNhZ2kgYW5kIENoYWl0YW55YQoKVGhh
bmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLgpJdCBpcyBhIGdvb2Qgc3VnZ2VzdGlvbiB0aGF0IHNl
dHRpbmcgbnNpZCB0byAiLTEiIGluZGljYXRlcyBhIGZhdWx0eSBkaXNrLAphbmQgSSByZXNlbmQg
cGF0Y2ggVjQgYmFzZWQgb24geW91ciBjb21tZW50cyBsYXRlci4KCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
