Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B49C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 03:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUuC8gmccFu/nKM8R+kjHIWL8qoOP89qIn1cnxzJqQk=; b=TzfG2VLRxMzhQV6BCOjo8kpT5Y
	6X+p87asOt8E2DfKyhDmKCUKhFX3uPc1mfs9A1TMqZYKMDWNvkw0U/8vn8Gz1bEF4yU/gpbt2qcN5
	2UXP18eDlmEVzhXzE2XiRsYzNacGgWTLMploNIizsdSxRzjR0wHomypFw1v3EU9//elBhcXcyTq7A
	cnirfCMU0Jx3yyHFRNyWkLvMDDnmP/GzFoLUv6k4n6kA5N3MLnm2x6Gv/3ohvAT7ybiSsaEiVcuJi
	1F52XJuxjl4MWEGn2axDXaV5e7Pan8Be4xfsgnq1diXiZiM7t7lmvqJLTiMuz7Mc6uJ0phm5WUH3b
	QnWg7L1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Bbd-006xTc-0b;
	Wed, 29 Nov 2023 03:51:21 +0000
Received: from exvmail3.hynix.com ([166.125.252.90] helo=invmail3.skhynix.com)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8BbY-006xSA-0Q
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 03:51:19 +0000
X-AuditID: a67dfc59-bd5ff7000001c92b-ec-6566b52f734f
Received: from hymail23.hynixad.com (10.156.135.53) by hymail15.hynixad.com
 (10.156.135.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.42; Wed, 29 Nov
 2023 12:51:11 +0900
Received: from hymail23.hynixad.com ([10.156.135.53]) by hymail23.hynixad.com
 ([10.156.135.53]) with mapi id 15.02.0986.042; Wed, 29 Nov 2023 12:51:11
 +0900
From: "hardaway.tseng@sk.com" <hardaway.tseng@sk.com>
To: Keith Busch <kbusch@kernel.org>, =?utf-8?B?SmltIExpbiDmnpflv5fono0=?=
	<jim.lin@siliconmotion.com>, =?utf-8?B?RGF2aWQgWWVoIOiRieWvsOiejQ==?=
	<david.yeh@siliconmotion.com>
CC: Jim.Lin <jim.chihjung.lin@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q0ogQ2hlbiDpmbPnvqTlgpE=?= <cj.chen@siliconmotion.com>,
	"sangan.han@sk.com" <sangan.han@sk.com>, "ives.lu@sk.com" <ives.lu@sk.com>
Subject: RE: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Thread-Topic: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Thread-Index: AQHaIabItSYv0AoU6E61/0TaLKTrOLCOdLOAgAHxkXD//3BOAIAAn7Ag
Date: Wed, 29 Nov 2023 03:51:11 +0000
Message-ID: <c03b56fe9d984ad398355088667cc91a@sk.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
 <SEYPR01MB4341EFAA7D4B563BFF903B45FDBCA@SEYPR01MB4341.apcprd01.prod.exchangelabs.com>
 <71aae1b4cb0441d0940a5e536f4ffce0@sk.com>
 <ZWaBULOgInxbp6JQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZWaBULOgInxbp6JQ@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: zh-TW, en-US, ko-KR
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.8.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXC9ZZnka7+1rRUgz/bdC1W3+1ns/jxZy+L
	xZedl9ksVq4+ymRx+eIqFosr93+zWkw6dI3RYv6yp+wW616/Z3Hg9Ng56y67x/l7G1k8Lp8t
	9di0qpPNY/OSeo/dNxvYPJ7ff8oWwB7FZZOSmpNZllqkb5fAlXH9SxNbwTGxikcretgbGP+I
	djFycEgImEjM/ZzdxcjFISTwmlFi95ZzzBDOAkaJq4cXs3YxcnKwCZhKdGx+xgKSEBHYyCgx
	8cAHdpAEs8BKZokVPWUgtrCAm8TPE78ZQWwRAXeJxrdtzBC2m8SSw4/B4iwCqhIb9u4AG8oL
	NPTy5zY2iG3fGSVunf0CNpRTwF5iy6ltLCA2o4CKxPvDzxkhlolLnLvYClYjISAgsWTPeWYI
	W1Ti5eN/rBC2gsSLV1uZQF5jFtCUWL9LH6JVUWJK90N2iL2CEidnPmGBKJeUOLjiBssERrFZ
	SDbMQuiehaR7FpLuBYwsqxhFMvPKchMzc4z1irMzKvMyK/SS83M3MQIjdlntn8gdjN8uBB9i
	FOBgVOLhdbiWmirEmlhWXJl7iFGCg1lJhFfvY3KqEG9KYmVValF+fFFpTmrxIUZpDhYlcV6j
	b+UpQgLpiSWp2ampBalFMFkmDk6pBsba6MLJFjUtAas4Qt47Plw4XyVx/Y3MNavLWJYxZwh2
	vr/K7bPz98fp+dv+nG65+lPm+amM6QHK8hculGvEGhzocUx6ePqrc4W3sA5XTXCPQvatHfqV
	5z5cZf/JmXRHOljw97bE3uhwCyuj8zZnYh3y/Y4snvk/Tu/V5w+rKucUM124Jnee77oSS3FG
	oqEWc1FxIgDfvO631AIAAA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_195116_300149_8A80DE45 
X-CRM114-Status: GOOD (  11.69  )
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

SGkgS2VpdGgsDQoNClRoYW5rcyBmb3IgaGVhZCB1cCBDaHJpc3RvcGgncyBxdWVzdGlvbnMhDQpP
dXIgdGVhbSB3aWxsIGhlbHAgdXMgdG8gYW5zd2VyIHRoZW0uDQoNCkhpIEppbSBhbmQgRGF2aWQs
DQpUaGFua3MgZm9yIHlvdXIgc3VwcG9ydCENCg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KSGFyZGF3
YXkuDQoNCg0KSGFyZGF3YXkgVHNlbmcvIFNyLiBNYW5hZ2VyIHwgU04tRkFRRSB8IFNLIGh5bml4
IFNlbWljb25kdWN0b3IgVGFpd2FuDQpBZGRyZXNzOiAxMEYuIE5vLiAzMDgsIFpoaWZ1IFJkLiwg
WmhvbmdzaGFuIERpc3QuLCBUYWlwZWkgQ2l0eSAxMDQ2NiwgVGFpd2FuDQpPZmZpY2UgOiArODg2
LTItMzUxOC0yMzEzLyBGYXg6ICs4ODYtMi0zNTE4LTIzNjYvIE1vYmlsZTogKzg4Ni05MTktODAz
LTQ1OA0KRW1haWw6IGhhcmRhd2F5LnRzZW5nQHNrLmNvbQ0KDQpTSyBoeW5peCBDb25maWRlbnRp
YWwNCuKAnFRoaXMgZS1tYWlsIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQvb3IgcHJpdmls
ZWdlZCBpbmZvcm1hdGlvbi4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudChv
ciBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yKSwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IHRoaXMgZS1tYWlsLiBBbnkgdW5hdXRob3Jp
emVkIGNvcHlpbmcsIGRpc2Nsb3N1cmUgb3IgZGlzdHJpYnV0aW9uIG9mIHRoZSBtYXRlcmlhbCBp
biB0aGlzIGUtbWFpbCBpcyBzdHJpY3RseSBmb3JiaWRkZW4u4oCdDQoNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4gDQpT
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI5LCAyMDIzIDg6MTAgQU0NClRvOiBIYXJkYXdheSAo
U2hpaCBIdW5nKSBUc2VuZyBTS0hZVCA8aGFyZGF3YXkudHNlbmdAc2suY29tPg0KQ2M6IEppbSBM
aW4g5p6X5b+X6J6NIDxqaW0ubGluQHNpbGljb25tb3Rpb24uY29tPjsgSmltLkxpbiA8amltLmNo
aWhqdW5nLmxpbkBnbWFpbC5jb20+OyBheGJvZUBrZXJuZWwuZGs7IGhjaEBsc3QuZGU7IHNhZ2lA
Z3JpbWJlcmcubWU7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgQ0ogQ2hlbiDpmbPnvqTlgpEgPGNqLmNoZW5Ac2lsaWNvbm1vdGlv
bi5jb20+OyBEYXZpZCBZZWgg6JGJ5a+w6J6NIDxkYXZpZC55ZWhAc2lsaWNvbm1vdGlvbi5jb20+
OyDtlZzsg4HslYgoSEFOIFNBTkdBTikg64yA66eM67KV7J24IDxzYW5nYW4uaGFuQHNrLmNvbT47
IEl2ZXMoSHN1ZWggSHNpZW4pIEx1IFNLSFlUIDxpdmVzLmx1QHNrLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIG52bWUtcGNpOiBkaXNhYmxlIHdyaXRlIHplcm9lcyBmb3IgU0sgSHluaXggQkM5
MDENCg0KT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMTE6NTE6NDJQTSArMDAwMCwgaGFyZGF3YXku
dHNlbmdAc2suY29tIHdyb3RlOg0KPiBIaSBLZWl0aCwgSmltIGFuZCB0ZWFtLA0KPiANCj4gVGhh
bmtzIGZvciBlZmZvcnRzIQ0KPiANCj4gVGhpcyBpcyBIYXJkYXdheSBmcm9tIFNLIGh5bml4LCB0
aGlzIHNvZnR3YXJlIGNoYW5nZSBoYXMgYmVlbiB0ZXN0ZWQgYW5kIHZlcmlmaWVkIGJ5IE9ETSBD
b21wYWwsIHRoZSB0ZXN0aW5nIHJlc3VsdCBpcyBwYXNzLCB0aGVyZWZvcmUsIHdlIHdvdWxkIGxp
a2UgdG8gYXBwbHkgdGhpcyB1cGRhdGUuDQoNCkdyZWF0LCB0aGFua3MgZm9yIGNvbmZpcm1pbmcu
IEkndmUgZ290IHRoaXMgcXVldWVkIHVwIGludGVybmFsbHksIGJ1dCB3YW50IHRvIGNoZWNrIGlm
IENocmlzdG9waCdzIHF1ZXN0aW9uIGNvdWxkIGxlYWQgdG8gYSBiZXR0ZXIgb3V0Y29tZSBmb3Ig
ZXZlcnlvbmUuIEZvciByZWZlcmVuY2UsIGFza2VkIGhlcmU6DQoNCiAgaHR0cHM6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMjMtTm92ZW1iZXIvMDQzMjk4Lmh0
bWwNCg0KSWYgeW91IHdlcmUgYWxyZWFkeSB0ZXN0aW5nIGNsb3NlIHRvIHVwc3RyZWFtLCA2LjIg
b3IgbmV3ZXIsIHRoZW4gdGhpcyBwYXRjaCBpcyBhbHJlYWR5IHRoZSBiZXN0IG9wdGlvbi4NCg==

