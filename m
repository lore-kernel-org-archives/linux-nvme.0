Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E634DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9l3O63Yv+w/rovYKpm+RlRcb6iVQde4FL/aJwERW/o=; b=CmL0Eiir1OCS5D5djglxstNfOR
	dii+8cZVprLeS6sM5CK8vwtuVrpfBfhQ5ipn+n4VOM/j6M/ntm7VsmX382DCPBcDZEOf54ZanVEDe
	UNWspJOY25XahuJOsB7qilb0w5Xd9o3bSs6GTjekPee/XrhGV6Mc+MGvK1//35HV1OS0QTpkZBWdg
	EkrHWsfEBuNNugUJiWqmy36BDFiNE0O7iZsPqXgh6vPhp1fPJQzEdLHx5jfs3LT6SGIrfr0076LPF
	sKMCHnaOyDS6vE2jWVyEZ4QH34gxkK8E68pKItgYZ2ChiNTyXx6edodj52jvZzvzSfZScV4c6H5ey
	rclK2qDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofcPW-008lFV-OL; Tue, 04 Oct 2022 07:32:14 +0000
Received: from spam1.phison.com ([60.249.103.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofcPT-008lEf-P5
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 07:32:13 +0000
Received: from pps.filterd (phisonpps.phison.com [127.0.0.1])
	by phisonpps.phison.com (8.17.1.5/8.17.1.5) with ESMTP id 293Mloes066047
	for <linux-nvme@lists.infradead.org>; Tue, 4 Oct 2022 15:32:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phison.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPSPHISON20220831;
 bh=I9l3O63Yv+w/rovYKpm+RlRcb6iVQde4FL/aJwERW/o=;
 b=E7Y1/dNlTj+BGwLDZDrpL4l0CcUuqY5hhb9MWSiFTEC5hnqTH99azQltIcmV3j6m8Wf+
 R1y12W1O/BVBU6KIb+NdUkQXjoz27ZIiKolq3p1/TIeXePnsscqhDl7Ld2Uf3ckzOakq
 55/TyO/aEp/8fLHX2Nll70b9OZbK6t8Ppo3NyNf8gM50hz8Wb7eeM++Z5omX6OkloQuV
 kFXyJi+ly9pT0rZxghIRmPnfZUEIAFIoEyRC25nb/0dWorBsOr8pZ3G7YbAJmW3CU2Xl
 AQzLkMwUiyc7f8DWSlTfeBFmaUor79JS9k52OOQEwNHxqjw1HzIGB63/snwyMABMrg5r 1Q== 
Received: from spam1.phison.com ([192.168.10.11])
	by phisonpps.phison.com (PPS) with ESMTPS id 3jys94t44j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 04 Oct 2022 15:32:09 +0800
X-UUID: 631f3f4674a74635bd6098787a2fd206-20221004
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0f00a8e8-7156-4651-92b1-c9ebe0c9592c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:e558e907-1cee-4c38-b21b-a45f9682fdc0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 631f3f4674a74635bd6098787a2fd206-20221004
Received: from mail.phison.com [(192.168.1.113)] by spam1.phison.com
	(envelope-from <ritach_lin@phison.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 438133062; Tue, 04 Oct 2022 15:32:05 +0800
Received: from ExMBX2.phison.com (192.168.1.113) by ExMBX2.phison.com
 (192.168.1.113) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 4 Oct
 2022 15:32:04 +0800
Received: from ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7]) by
 ExMBX2.phison.com ([fe80::1518:aa7a:367f:18f7%23]) with mapi id
 15.00.1497.040; Tue, 4 Oct 2022 15:32:04 +0800
From: Rita Lin <ritach_lin@phison.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg
	<sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?gb2312?B?/FPqyax8?=
	<redd_huang@phison.com>,
        Tina Hsu <tina_hsu@phison.com>,
        =?gb2312?B?Vml0YSBIc3VlaCAo0abSwdm7KQ==?= <Vita.Hsueh@quantatw.com>,
        "Wang,
 Audrey" <audrey.wang@hp.com>
Subject: RE: nvme-pci: disable write zeros support on SSDs
Thread-Topic: nvme-pci: disable write zeros support on SSDs
Thread-Index: AQHY18LoTUA//5yehkSdjvmkP8qjP6391t/g
Date: Tue, 4 Oct 2022 07:32:03 +0000
Message-ID: <dec6956becf742ecadd95dcc9e7c98c8@ExMBX2.phison.com>
References: <20220922055231.GA27560@lst.de>
 <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com>
 <20220922142626.GB28397@lst.de>
 <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
 <20220923061130.GA15835@lst.de>
 <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
 <20220927070822.GA15262@lst.de>
 <3aeb692e9037462b9f9a23a60277b80c@ExMBX2.phison.com>
 <20220927072141.GA16372@lst.de>
 <1a5c4e8559d0495eb78479cd18fcbe95@ExMBX2.phison.com>
 <20221004072816.GA30470@lst.de>
In-Reply-To: <20221004072816.GA30470@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.3]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: jUr8KLDrXLwLfZi-AHBeK5V1DB3N5rPl
X-Proofpoint-GUID: jUr8KLDrXLwLfZi-AHBeK5V1DB3N5rPl
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=619 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_003212_105250_7C9C9F33 
X-CRM114-Status: GOOD (  16.92  )
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

VGhpcyB3YXMgdGhlIHByZXZpb3VzIGxpbmsgd2UgcmVjZWl2ZWQgYXMgYW4gZXhhbXBsZSBmcm9t
IG90aGVycy4NCmh0dHBzOi8vY2hyb21pdW0tcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20vYy9jaHJv
bWl1bW9zL3RoaXJkX3BhcnR5L2tlcm5lbC8rLzM1MjgxODANCldvdWxkIGxpa2UgdG8gdW5kZXJz
dGFuZCBpZiBvdXIgYXBwbGljYXRpb24gaGFzIHNvbWV0aGluZyBzaW1pbGFyLg0KDQpSaXRhIExp
bsHW3b3s0w0KKzg4Ni0zNy01ODYtODk2IEV4dC44MDA1MQ0Kcml0YWNoX2xpbkBwaGlzb24uY29t
DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdG9waCBIZWxsd2ln
IFttYWlsdG86aGNoQGxzdC5kZV0NClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgNCwgMjAyMiAzOjI4
IFBNDQpUbzogUml0YSBMaW4gPHJpdGFjaF9saW5AcGhpc29uLmNvbT4NCkNjOiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT47IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEpl
bnMgQXhib2UgPGF4Ym9lQGZiLmNvbT47IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+
OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IPxT6smsfCA8cmVkZF9odWFuZ0BwaGlzb24uY29tPjsgVGluYSBIc3UgPHRpbmFfaHN1
QHBoaXNvbi5jb20+OyBWaXRhIEhzdWVoICjRptLB2bspIDxWaXRhLkhzdWVoQHF1YW50YXR3LmNv
bT47IFdhbmcsIEF1ZHJleSA8YXVkcmV5LndhbmdAaHAuY29tPg0KU3ViamVjdDogUmU6IG52bWUt
cGNpOiBkaXNhYmxlIHdyaXRlIHplcm9zIHN1cHBvcnQgb24gU1NEcw0KDQpPbiBUdWUsIE9jdCAw
NCwgMjAyMiBhdCAwNzoyMDowMUFNICswMDAwLCBSaXRhIExpbiB3cm90ZToNCj4gSGkgQ2hyaXN0
b3BoDQo+DQo+IFdvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIHBhdGNoIG1vZGlmaWVkIGxpbmsg
b24gR2Vycml0IFNlcnZlciB0byB1cz8NCg0KSSBoYXZlIG5vIGlkZWEgV1RGIHlvdSdyZSBldmVu
IHRhbGtpbmcgYWJvdXQuDQoNCg0KVGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gQW55IHVuYXV0aG9y
aXplZCByZXZpZXcsIHVzZSBvciBkaXN0cmlidXRpb24gYnkgYW55b25lIG90aGVyIHRoYW4gdGhl
IGludGVuZGVkIHJlY2lwaWVudCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBz
ZW5kZXIsIGNvbXBsZXRlbHkgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMs
IGFuZCBkZXN0cm95IGFsbCBjb3BpZXMuIFlvdXIgY29vcGVyYXRpb24gd2lsbCBiZSBoaWdobHkg
YXBwcmVjaWF0ZWQuDQo=


