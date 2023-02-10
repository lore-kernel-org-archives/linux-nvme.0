Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F16C636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 20:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+5NGYUa70KsfhnSuzKsbCdpiNVeMdOt3qHqYUi61iI=; b=Tbnhd/KV/2TTYMotLEL8k+1ZZW
	zoRQhlmBGVdOwIxdgNunXZSWGO8vmfcfKqjGV5ibGPM9dHMQQT1OiQruCf49JzwiCQl2WEAL62235
	ZOcIyg6DDR/9ZBZTyxiWobzs3exxkWkYMVH+0MCESeOkPe3GakkksaPAYsFgYUEH+TVMFmsy7CLL+
	7daVbffmF+ZoykmMpylwiMeHSGNaObiF+0Ol/50ZSWPdUqkPvWn0RSkuVNpuKUcfdb9H1yJOrRIGW
	TwHNsQkRbnKaUlF9RHXNdNUfsbwb84gdp8s5smut/0lNY/Ztt8t0VeL5d1ZvKanJI6orWAcnAu3mw
	sKX1lTgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQZg0-007HJO-3f; Fri, 10 Feb 2023 20:07:20 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQZfw-007HHK-UJ
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 20:07:18 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 12:07:09 -0800
Received: from SJSMAIL01.us.kioxia.com ([10.90.133.90]) by
 SJSMAIL01.us.kioxia.com ([10.90.133.90]) with mapi id 15.01.2375.034; Fri, 10
 Feb 2023 12:07:09 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: RE: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Thread-Index: AQHZPXpawtZ6JevJFESaC3bXWuk95a7IlJlA
Date: Fri, 10 Feb 2023 20:07:09 +0000
Message-ID: <65b5a06a163246e293a0452c03a59a2b@kioxia.com>
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_120716_990712_134C3815 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiBGcm9tIEthbmNoYW4gSm9zaGkNCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxMCwgMjAyMyAx
MDowMSBBTQ0KPiBUbzogbHNmLXBjQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IENjOiBs
aW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgaW8tDQo+IHVyaW5nQHZnZXIua2VybmVsLm9yZzsgYXhib2VAa2VybmVsLmRrOyBoY2hAbHN0
LmRlOyBrYnVzY2hAa2VybmVsLm9yZzsNCj4gbWluZy5sZWlAcmVkaGF0LmNvbTsgS2FuY2hhbiBK
b3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4NCj4gU3ViamVjdDogW0xTRi9NTS9CUEYgQVRURU5E
XVtMU0YvTU0vQlBGIFRvcGljXSBOb24tYmxvY2sgSU8NCj4gDQo+IGlzIGdldHRpbmcgbW9yZSBj
b21tb24gdGhhbiBpdCB1c2VkIHRvIGJlLg0KPiBOVk1lIGlzIG5vIGxvbmdlciB0aWVkIHRvIGJs
b2NrIHN0b3JhZ2UuIENvbW1hbmQgc2V0cyBpbiBOVk1lIDIuMCBzcGVjDQo+IG9wZW5lZCBhbiBl
eGNlbGxlbnQgd2F5IHRvIHByZXNlbnQgbm9uLWJsb2NrIGludGVyZmFjZXMgdG8gdGhlIEhvc3Qu
IFpOUw0KPiBhbmQgS1YgY2FtZSBhbG9uZyB3aXRoIGl0LCBhbmQgc29tZSBuZXcgY29tbWFuZCBz
ZXRzIGFyZSBlbWVyZ2luZy4NCg0KU29tZSBjb21tYW5kIHNldHMgcmVxdWlyZSBmZWF0dXJlcyBv
ZiBOVk1lIHRoZSBrZXJuZWwgZG9lc24ndCBzdXBwb3J0Ow0KZnVzZWQgYW5kIHNvbWUgQUVOcyBm
b3IgZXhhbXBsZS4gIEl0IHdvdWxkIGJlIHZlcnkgdXNlZnVsIHRvIHdvcmsgd2l0aA0Kbm9uLWJs
b2NrIGNvbW1hbmQgc2V0cyB3L28gbW9kaWZ5aW5nIHRoZSBOVk1lIGRyaXZlciwgaGF2aW5nIGEg
Y3VzdG9tDQpOVk1lIGRyaXZlciBwZXIgY29tbWFuZCBzZXQgb3IgcmVzb3J0aW5nIHRvIHVzaW5n
IHNwZGsuDQoNCg==

