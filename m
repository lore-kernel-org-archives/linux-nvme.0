Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F3CC6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 06:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7Zg4WfQgTO9t7BU1e8OVrW64EFtAfAbPlubEtZKdpk=; b=Gmfc+I1HdQBYP8VFu0jvfdS54s
	scseP8EDo6Y45uilispOIpx6ZWJIyS0QLEJ+FEstkDNw0IGsTP3xcdxlRKhE5c0n8MbJgkdrykao7
	J20CnkO0WkRGMfzYowAzmkB60uzA48V5QytUgvtr/s+UCV/4dAeah/iz20zmB8Rj9H2Ojiy/2en+L
	9epBGdAEqYW9NnoZuW/OGgz9YKk6Xn/7Sv2QGAhylgbu7eTkgQJ80WkF+L9dRoNfS7rqDvVffkkqH
	0nXtMeKis2WKpBBFJadBi0p8ld/sB9e+/pCJD0MP5eUkY0L9AxVDC+veBIK221B18euEVzxCEo0C8
	kCg/cZyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obbyy-002QJ2-MM; Fri, 23 Sep 2022 06:16:16 +0000
Received: from spam1.phison.com ([60.249.103.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obbyu-002QHS-Rf
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 06:16:14 +0000
X-UUID: 2c322588028743f6a294428bfaff513f-20220923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3994f220-7937-4cd3-919b-7a0981c8dcd8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:7ed4f9e3-87f9-4bb0-97b6-34957dc0fbbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2c322588028743f6a294428bfaff513f-20220923
Received: from mail.phison.com [(192.168.1.113)] by spam1.phison.com
	(envelope-from <ritach_lin@phison.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 100404508; Fri, 23 Sep 2022 14:16:03 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX2.phison.com
 (192.168.1.113) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 23 Sep
 2022 14:16:02 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Fri, 23 Sep 2022 14:16:02 +0800
From: Rita Lin <ritach_lin@phison.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?gb2312?B?/FPqyax8?=
	<redd_huang@phison.com>, Tina Hsu <tina_hsu@phison.com>,
	=?gb2312?B?Vml0YSBIc3VlaCAo0abSwdm7KQ==?= <Vita.Hsueh@quantatw.com>, "Wang,
 Audrey" <audrey.wang@hp.com>
Subject: RE: nvme-pci: disable write zeros support on SSDs
Thread-Topic: nvme-pci: disable write zeros support on SSDs
Thread-Index: AQHYzxNtQi5UhZQ6SUWSK6rbmXfzH63siVcw
Date: Fri, 23 Sep 2022 06:16:01 +0000
Message-ID: <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
 <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
 <20220923061130.GA15835@lst.de>
In-Reply-To: <20220923061130.GA15835@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_231613_216068_E3574479 
X-CRM114-Status: UNSURE (   8.27  )
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

RGVhciBDaHJpc3RvcGgsDQoNClRoZSBzaWduZWQgb2ZmIGluZm9ybWF0aW9uIHdhcyBwdXQgaW4g
bGluZSAxMCBpbiBwcmV2aW91cyBwYXRjaC4NCkkgd2FzIG5vdCBhYmxlIHRvIGF0dGFjaCBhbiBp
bWFnZSB0byBpZGVudGlmeSB0aGUgbG9jYXRpb24gdG8geW91Lg0KDQpSaXRhIExpbsHW3b3s0w0K
Kzg4Ni0zNy01ODYtODk2IEV4dC44MDA1MQ0Kcml0YWNoX2xpbkBwaGlzb24uY29tDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdG9waCBIZWxsd2lnIFttYWlsdG86
aGNoQGxzdC5kZV0NClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIzLCAyMDIyIDI6MTIgUE0NClRv
OiBSaXRhIExpbiA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVucyBBeGJv
ZSA8YXhib2VAZmIuY29tPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IGxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
/FPqyax8IDxyZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29u
LmNvbT47IFZpdGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29tPjsgV2Fu
ZywgQXVkcmV5IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1wY2k6IGRp
c2FibGUgd3JpdGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNCk9uIEZyaSwgU2VwIDIzLCAyMDIy
IGF0IDAzOjE4OjUyQU0gKzAwMDAsIFJpdGEgTGluIHdyb3RlOg0KPiBEZWFyIENocmlzdG9waCwN
Cj4NCj4gV2UgaGFkIGluY2x1ZGVkIHNpZ25lZCBvZmYgYnkgaW5mb3JtYXRpb24gaW4gdGhlIHBh
dGNoLg0KDQpJJ3ZlIG5vdCBhY3R1YWxseSBmb3VuZCBhIHNpZ25vZmYgaW4gZWl0aGVyIHZlcnNp
b24gb2YgdGhlIHBhdGNoLg0KDQoNClRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGFy
ZSBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIEFueSB1bmF1dGhv
cml6ZWQgcmV2aWV3LCB1c2Ugb3IgZGlzdHJpYnV0aW9uIGJ5IGFueW9uZSBvdGhlciB0aGFuIHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUg
c2VuZGVyLCBjb21wbGV0ZWx5IGRlbGV0ZSB0aGUgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRz
LCBhbmQgZGVzdHJveSBhbGwgY29waWVzLiBZb3VyIGNvb3BlcmF0aW9uIHdpbGwgYmUgaGlnaGx5
IGFwcHJlY2lhdGVkLg0K


