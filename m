Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9FBC6FA8B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 03:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otF4rhrmcOYp7dLLn2R8+mZ4XcPCBxZj6r221pbzPLA=; b=piRvpgEinRORCtUMAzD1kRG2UA
	b2l2vzhhW+LWeNAH4Tx4qMhHYqp7IYQkCnoSss/5kQvNp4KroNXyAwSw1LVEf9BQZMWR92RaQ0Z+s
	B7JyVQEoV4YKXIStX1MoufIq/In6xQcCm6/9nMTOXLhjO8wuzgmc5nuGNEIEhKZ3/jl3978w1b4fJ
	qMRFaXOXQ7nAT1SbfkQfW1MK8lMyxW/iAkm6yY0WQd+8OAIdF4ySHKGrBu3KfMnBOV3JnwSiEInRa
	NBORk1TQ4b15T64WjS8ElZoTL7elerEfw+YcXEz2Nds30lT1V/xQ3eO8ceJrIxZ4tHV7jFEKt3l0Z
	MqpMcWMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obZDv-001i2j-8I; Fri, 23 Sep 2022 03:19:31 +0000
Received: from spam1.phison.com ([60.249.103.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obZDr-001hzD-SI
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 03:19:29 +0000
X-UUID: df5d27741db544aca526f1b9a8177122-20220923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e28a0c00-9859-410f-91b3-6104cc68d46c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:c91fc006-1cee-4c38-b21b-a45f9682fdc0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: df5d27741db544aca526f1b9a8177122-20220923
Received: from mail.phison.com [(192.168.1.112)] by spam1.phison.com
	(envelope-from <ritach_lin@phison.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 2047599724; Fri, 23 Sep 2022 11:18:54 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX1.phison.com
 (192.168.1.112) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 23 Sep
 2022 11:18:52 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Fri, 23 Sep 2022 11:18:52 +0800
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
Thread-Index: AQHYzo9mLRoycnw5e06F0MlERwYXUq3sWP0A
Date: Fri, 23 Sep 2022 03:18:52 +0000
Message-ID: <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
 <20220922053137.GA27191@lst.de>
 <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
 <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
In-Reply-To: <20220922142626.GB28397@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: multipart/mixed;
	boundary="_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_"
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_201928_245940_9CE215D9 
X-CRM114-Status: GOOD (  17.35  )
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

--_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

RGVhciBDaHJpc3RvcGgsDQoNCldlIGhhZCBpbmNsdWRlZCBzaWduZWQgb2ZmIGJ5IGluZm9ybWF0
aW9uIGluIHRoZSBwYXRjaC4NCldlIHdpbGwgdXNlIHBoaXNvbi5jb3JwLXBhcnRuZXIuZ29vZ2xl
LmNvbSBmb3IgdGhpcyBjYXNlLg0KVGhhbmsgeW91Lg0KDQpSaXRhIExpbsHW3b3s0w0KKzg4Ni0z
Ny01ODYtODk2IEV4dC44MDA1MQ0Kcml0YWNoX2xpbkBwaGlzb24uY29tDQoNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdG9waCBIZWxsd2lnIFttYWlsdG86aGNoQGxz
dC5kZV0NClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjIgMTA6MjYgUE0NClRvOiBS
aXRhIExpbiA8cml0YWNoX2xpbkBwaGlzb24uY29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVucyBBeGJvZSA8
YXhib2VAZmIuY29tPjsgU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IGxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg/FPq
yax8IDxyZWRkX2h1YW5nQHBoaXNvbi5jb20+OyBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNv
bT47IFZpdGEgSHN1ZWggKNGm0sHZuykgPFZpdGEuSHN1ZWhAcXVhbnRhdHcuY29tPjsgV2FuZywg
QXVkcmV5IDxhdWRyZXkud2FuZ0BocC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZS1wY2k6IGRpc2Fi
bGUgd3JpdGUgemVyb3Mgc3VwcG9ydCBvbiBTU0RzDQoNCkNhbiB5b3UgZ2l2ZSBtZSBhIFNpZ25l
ZC1vZmYtYnk6IGZvciB0aGlzIHBhdGNoIGFzIHdlbGw/DQoNCkFsc28gc2hvdWxkIHRoaXMgcmVh
bGx5IHVzZSB0aGUgcGhpc29uLmNvcnAtcGFydG5lci5nb29nbGUuY29tIG9yIHBoaXNvbi5jb20g
Zm9yIHRoZSBBdXRob3IgaWRlbnRpZmljYXRpb24/ICAoU2FtZSBmb3IgdGhlIHNpZ25vZmYpLg0K
DQoNCg0KVGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBh
bmQgbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVz
ZSBvciBkaXN0cmlidXRpb24gYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIsIGNvbXBsZXRl
bHkgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMsIGFuZCBkZXN0cm95IGFs
bCBjb3BpZXMuIFlvdXIgY29vcGVyYXRpb24gd2lsbCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQuDQo=

--_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_
Content-Type: application/octet-stream;
	name="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"
Content-Description: 0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch
Content-Disposition: attachment;
	filename="0001-PATCH-Add-Phison-E3C-E4C-Disable-Write-Zero.patch"; size=1421;
	creation-date="Fri, 23 Sep 2022 03:18:49 GMT";
	modification-date="Fri, 23 Sep 2022 03:18:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNWEzMmE4NWZmYTI2Y2JiZjA2NDlkMmI1NDU3ZjZlMTNlYzg1OTAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNvcnAtcGFydG5l
ci5nb29nbGUuY29tPgpEYXRlOiBUaHUsIDIyIFNlcCAyMDIyIDE0OjE2OjMwICswODAwClN1Ympl
Y3Q6IFtQQVRDSF0gW1BBVENIXSBBZGQgUGhpc29uIEUzQy9FNEMgRGlzYWJsZSBXcml0ZSBaZXJv
CgpFM0MvRTRDIFNTRHMgZG8gc3VwcG9ydCB3cml0ZSAwIGNvbW1hbmQgYW5kIHRoZSBmdW5jdGlv
biB3YXMgdGVzdGVkIHdpdGhvdXQgaXNzdWUuCkJ1dCBzaW5jZSB0aGVzZSBTU0RzIGFyZSBEUkFN
bGVzcyBwcm9kdWN0cywgdGhlIHdyaXRlIDAgY29tbWFuZCB3aWxsIHRha2UgYSBsb3QgbG9uZ2Vy
IHRvIGNvbXBsZXRlIHdoaWNoIGhhZCBpbXBhY3RlZCB0aGUgcHJvZHVjdCBwZXJmb3JtYW5jZS4K
RHVlIHRvIHRoZSBGVyBoYWQgYmVlbiBmcm96ZW4sIHdlIHdvdWxkIGxpa2UgdG8gY2hlY2sgaWYg
d2UgY291bGQgYXBwbHkgQ0wgZm9yIHRoZXNlIDIgcHJvZHVjdHMuCgpzaWduZWQtb2ZmLWJ5OiBU
aW5hIEhzdSA8dGluYV9oc3VAcGhpc29uLmNvcnAtcGFydG5lci5nb29nbGUuY29tPgotLS0KIGRy
aXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYwppbmRleCA5ODg2NGI4NTNlZWYuLjY3ZDMzMzVlOWNjOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMK
QEAgLTM0NzAsNiArMzQ3MCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQg
bnZtZV9pZF90YWJsZVtdID0gewogCXsgUENJX0RFVklDRSgweDE5ODcsIDB4NTAxNiksCS8qIFBo
aXNvbiBFMTYgKi8KIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5R
TiB8CiAJCQkJTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCisJeyBQQ0lfREVWSUNFKDB4MTk4Nywg
MHg1MDE5KSwgIC8qIHBoaXNvbiBFMTkgKi8KKwkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19E
SVNBQkxFX1dSSVRFX1pFUk9FUywgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxOTg3LCAweDUwMjEpLCAg
IC8qIFBoaXNvbiBFMjEgKi8KKwkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dS
SVRFX1pFUk9FUywgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxYjRiLCAweDEwOTIpLAkvKiBMZXhhciAy
NTYgR0IgU1NEICovCiAJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfTk9fTlNfREVTQ19MSVNU
IHwKIAkJCQlOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VCTlFOLCB9LAotLSAKMi4yNS4xCgo=

--_002_97217d166814421d9de587e84c328580ExMBX2phisoncom_--


