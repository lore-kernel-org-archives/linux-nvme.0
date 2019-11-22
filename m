Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C391EC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 17:01:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931EB20714
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5levrgR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Kqdw16Jd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="lN1EIWy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931EB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6IOVzTsOvO10UDwl61SB6GG1p4uasqZFSDInitbvc0=; b=m5levrgROxqZTs
	W3xWudg58tlAz1bR5vCgkK/RwZViIkCn2UYoSoFMUA4NqtNJilqGUAkX3Xc9mDsGc1d1ch9uy67X4
	G3XBs0kZRfdApxVqiR7Ql6vXfCTANJwE+w4OBVLP5GY38QLTy8V4/ttjAluLyZwf4TXEA4S72RzJw
	pg7q7nlPhNPusFikWoNRum8lIwUuJak1LjDVIjAkHPd3TxI4VUdYLqdP2ieW7YUFwb+RVEv0MFWhW
	5RUpTsGkxOfm0lbCyocqSU78fTZID705iFnNkUaWVgvIaWyZeIGUMf9D5oQbYgkMdvQo9FXcYNYVN
	2uRnNpkn9gcKA2IHYxIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYCJU-0003M6-5n; Fri, 22 Nov 2019 17:01:44 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYCJR-0003LP-Fo
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 17:01:43 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAMH0AKM008869; Fri, 22 Nov 2019 09:01:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=F54UJMA+1B/HkDqFF6rmIrl//QUsPQ+GqnrnU/c4Sp4=;
 b=Kqdw16Jd5lIrQEOkNl89YnRVJC4ByECvteJ5KNxV8iLClneBrdqfder481ZcWMFjOl9/
 +5xDjBn998W2jsxl8a0+foklESKb9UoBu+zvJzmZ90fILcL+XeP6qKxcPwK9PlQjcQ9+
 hWhxBrjqL+/O5FR6qpDsLaRqicE0G4mCuAtlVhW9IlV2sQP8ivPmYvJ4mHduPvadduCn
 pqYcSpxQQ0ujcE05q2pY4GZvqMLiU76Uw0wogSjqPfIhkcrkDOJfy/7HART0cw1MvH1M
 qGKFecFmdoHG2uIopnOFgtxafbROF/Po06brMRRGmEQ0viL418NT/cUcB3KYowPTwkUc vg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 2wearf2646-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 22 Nov 2019 09:01:37 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 22 Nov
 2019 09:01:36 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Nov 2019 09:01:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyQmy7J7qgb5fSlS+WmikOpKkOETWXyTaov7U9uUqhb+X5PSawfeNOWzcn4mCJVzyjRBmpUXu2Dq9a3f374T/jztPAgvnoX+Qq11ifZPkX11mqSqmqInC6Hioi4jLCJrVSgAuYQlRNsNTZpqo3ZtNcP/lw/RznsPlVU0KNnlai6sHEknOSYkjr2cis770jvf7n1iwSFf5KLi4HSdcV8jO5GtaAIcd1EzK5LJ1D5nAiZjb92ZSnRHWn+KWV6jaeUfLw3TWwgEiuXfl5TMlGc+t7r+h1VXg+YlH9bGU58FjT4Sd1i1WwreexHmlxeVi86zX/RUZziNWACf4E/PD24VDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F54UJMA+1B/HkDqFF6rmIrl//QUsPQ+GqnrnU/c4Sp4=;
 b=GxQw7w3oBsLLvFltrFtl0MGsgM7qLgBPv/eXHtk/JV2KjAdaLilC3oMiG+Ad27sUF4OrzAKjBAvsVUmxG1uSkAEkdDhYKXnKuwmI6ulz1n0Cd6XSo+rIAgDYxGt6eomNawTTQIoUC4rXhLqw4uXoTEZqZExfstcjSWSUjoxWEhL5qTarWi1nh+U+QzQviPSQX/+BUm3tm36iH+iiv2/hcppczTYuOJmxfoou5gaghSdAh/cCFEcD38l6m3Fow9f8Ys5FT6W8mjmeALKRIG59Hx3+TyqA0WPy3b8oEhx1VVrb82NjC3Q4uSGg+mepgpSHoM+rI4M5ZENOM+x7CLiHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F54UJMA+1B/HkDqFF6rmIrl//QUsPQ+GqnrnU/c4Sp4=;
 b=lN1EIWy6NbXZumsnpDGoFlUpUqdY/55Zs8jTucmB69UktQAuDQtoavj3Ci6RVqxt7kSA61VJIwA9reyDRRXtfwrorrjvyP0pffM6sRG8RI+kN0Wsm+BUq1Eb9RFfkeKjuwrStYUOQeE+/1GTwjlaEipTUvMtYtcIlwLzAuw/OVA=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB3278.namprd18.prod.outlook.com (10.255.237.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 22 Nov 2019 17:01:34 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::1435:34ad:dbff:5089]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::1435:34ad:dbff:5089%7]) with mapi id 15.20.2451.031; Fri, 22 Nov 2019
 17:01:33 +0000
From: Himanshu Madhani <hmadhani@marvell.com>
To: James Smart <jsmart2021@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fc: fix double-free scenarios on hw queues
Thread-Topic: [PATCH] nvme-fc: fix double-free scenarios on hw queues
Thread-Index: AQHVoJV+dbncCIcBNEuIdnsligX6vKeXBzuA
Date: Fri, 22 Nov 2019 17:01:33 +0000
Message-ID: <D54CF1B3-4161-4F1F-8134-31EAA84D6BD1@marvell.com>
References: <20191121175937.19615-1-jsmart2021@gmail.com>
In-Reply-To: <20191121175937.19615-1-jsmart2021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
x-originating-ip: [2600:1700:211:eb30:e5e4:c939:a3a3:4c5b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4076561-99f0-4285-4aa3-08d76f6da104
x-ms-traffictypediagnostic: MN2PR18MB3278:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB327895E9FF0A780FCA1D59B3D6490@MN2PR18MB3278.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(14454004)(186003)(71200400001)(64756008)(33656002)(66446008)(7736002)(76176011)(76116006)(256004)(229853002)(305945005)(58126008)(966005)(71190400001)(6116002)(110136005)(316002)(81156014)(14444005)(2501003)(86362001)(5660300002)(6246003)(6512007)(36756003)(91956017)(446003)(66946007)(11346002)(66476007)(8676002)(2906002)(6506007)(66556008)(81166006)(99286004)(25786009)(6436002)(102836004)(478600001)(8936002)(46003)(6486002)(6306002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR18MB3278;
 H:MN2PR18MB2719.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLCGVs6cb9T7clqPfvx3KxTE6sytVkTMHoNIJbVgnBmJ9qTS+Ez9Yoexh33jH2S2nTyKWAOrEOIO0ify6IJrV4kI5KVv9VNmZeb/vqSBkSR886/+RxHsLSbVjEuRuj2JtzFre64O0mpVZ1nVrKCH468UXy4dLwKNLHBqmweugifva6egb86ps2IpBIMU8O+/D9T9yp/Kz9R1L92CSC73+pqdSqHnMaz9rd0Jf2eqX89FX3C5WO0KmSCIaovSgsFnPuAqcr4jxd6diK9irzURarrK29KzPSn+c115188GvoI2D8HBBd7dK8WOU8MHshK5YFlMtmiyFinJP4zAbAjt8gQ1vTljsA7ZC1KaCqDecdZ3jhCNLPBBV7VqYToTvJ6ZuYS+yaTWEi70cqMJR2t/inGPm/8sfgA33zNt4f3iYqgjCfG3GNFEqdtO2GGA6cTHoIHyx4i278IUkaH3hM605WtE5vgws1xvc4KQpOMm8sE=
x-ms-exchange-transport-forked: True
Content-ID: <05DC6C5F43FCA944A7A030870559D367@namprd18.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4076561-99f0-4285-4aa3-08d76f6da104
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 17:01:33.8386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRT6ACbM2LFBOCR8VaZWqGEy9iYp6krc+O8nXIyzAPYXJF6Z7gBPaRCCteUQAJ6B1X9jNaOzT2ZkbDEiVWcJaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3278
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_03:2019-11-21,2019-11-22 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_090141_653657_ECE4CB93 
X-CRM114-Status: GOOD (  22.69  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQoNCu+7v09uIDExLzIxLzE5LCAxMjowMCBQTSwgIkxpbnV4LW52bWUgb24gYmVoYWxmIG9mIEph
bWVzIFNtYXJ0IiA8bGludXgtbnZtZS1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmcgb24gYmVo
YWxmIG9mIGpzbWFydDIwMjFAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIElmIGFuIGVycm9yIG9j
Y3VycyBvbiBvbmUgb2YgdGhlIGlvcyB1c2VkIGZvciBjcmVhdGluZyBhbg0KICAgIGFzc29jaWF0
aW9uLCB0aGUgY3JlYXRpbmcgcm91dGluZSBoYXMgZXJyb3IgcGF0aHMgdGhhdCBhcmUNCiAgICBp
bnZva2VkIGJ5IHRoZSBjb21tYW5kIGZhaWx1cmUgYW5kIHRoZSBlcnJvciBwYXRocyB3aWxsIGZy
ZWUNCiAgICB1cCB0aGUgY29udHJvbGxlciByZXNvdXJjZXMgY3JlYXRlZCB0byB0aGF0IHBvaW50
Lg0KICAgIA0KICAgIEJ1dC4uLiB0aGUgaW8gd2FzIHVsdGltYXRlbHkgZGV0ZXJtaW5lZCBieSBh
biBhc3luY2hyb25vdXMNCiAgICBjb21wbGV0aW9uIHJvdXRpbmUgdGhhdCBkZXRlY3RlZCB0aGUg
ZXJyb3IgYW5kIHdoaWNoDQogICAgdW5jb25kaXRpb25hbGx5IGludm9rZXMgdGhlIGVycm9yX3Jl
Y292ZXJ5IHBhdGggd2hpY2ggY2FsbHMNCiAgICBkZWxldGVfYXNzb2NpYXRpb24uIERlbGV0ZSBh
c3NvY2lhdGlvbiBkZWxldGVzIGFsbCBvdXRzdGFuZGluZw0KICAgIGlvIHRoZW4gdGVhcnMgZG93
biB0aGUgY29udHJvbGxlciByZXNvdXJjZXMuIFNvIHRoZQ0KICAgIGNyZWF0ZV9hc3NvY2lhdGlv
biB0aHJlYWQgY2FuIGJlIHJ1bm5pbmcgaW4gcGFyYWxsZWwgd2l0aA0KICAgIHRoZSBlcnJvcl9y
ZWNvdmVyeSB0aHJlYWQuIFdoYXQgd2FzIHNlZW4gd2FzIHRoZSBMTEREIHJlY2VpdmVkDQogICAg
YSBjYWxsIHRvIGRlbGV0ZSBhIHF1ZXVlLCBjYXVzaW5nIHRoZSBMTEREIHRvIGRvIGEgZnJlZSBv
ZiBhDQogICAgcmVzb3VyY2UsIHRoZW4gdGhlIHRyYW5zcG9ydCBjYWxsZWQgdGhlIGRlbGV0ZSBx
dWV1ZSBhZ2Fpbg0KICAgIGNhdXNpbmcgdGhlIGRyaXZlciB0byByZXBlYXQgdGhlIGZyZWUgY2Fs
bC4gVGhlIHNlY29uZCBmcmVlDQogICAgcm91dGluZSBjb3JydXB0ZWQgdGhlIGFsbG9jYXRvci4g
VGhlIHRyYW5zcG9ydCBzaG91bGRuJ3QgYmUNCiAgICBtYWtpbmcgdGhlIGR1cGxpY2F0ZSBjYWxs
LCBhbmQgdGhlIGRlbGV0ZSBxdWV1ZSBpcyBqdXN0IG9uZQ0KICAgIG9mIHRoZSByZXNvdXJjZXMg
YmVpbmcgZnJlZWQuDQogICAgDQogICAgVG8gZml4LCBpdCBpcyByZWFsaXplZCB0aGF0IHRoZSBj
cmVhdGVfYXNzb2NpYXRpb24gcGF0aCBpcw0KICAgIGNvbXBsZXRlbHkgc2VyaWFsaXplZCB3aXRo
IG9uZSBjb21tYW5kIGF0IGEgdGltZS4gU28gdGhlDQogICAgZmFpbGVkIGlvIGNvbXBsZXRpb24g
d2lsbCBhbHdheXMgYmUgc2VlbiBieSB0aGUgY3JlYXRlX2Fzc29jaWF0aW9uDQogICAgcGF0aCBh
bmQgYXMgb2YgdGhlIGZhaWx1cmUsIHRoZXJlIGFyZSBubyBpb3MgdG8gdGVybWluYXRlIGFuZCB0
aGVyZQ0KICAgIGlzIG5vIHJlYXNvbiB0byBiZSBtYW5pcHVsYXRpbmcgcXVldWUgZnJlZXplIHN0
YXRlcywgZXRjLg0KICAgIFRoZSBzZXJpYWxpemVkIGNvbmRpdGlvbiBzdGF5cyB0cnVlIHVudGls
IHRoZSBjb250cm9sbGVyIGlzDQogICAgdHJhbnNpdGlvbmVkIHRvIHRoZSBMSVZFIHN0YXRlLiBU
aHVzIHRoZSBmaXggaXMgdG8gY2hhbmdlIHRoZQ0KICAgIGVycm9yIHJlY292ZXJ5IHBhdGggdG8g
Y2hlY2sgdGhlIGNvbnRyb2xsZXIgc3RhdGUgYW5kIG9ubHkNCiAgICBpbnZva2UgdGhlIHRlYXJk
b3duIHBhdGggaWYgbm90IGFscmVhZHkgaW4gdGhlIENPTk5FQ1RJTkcgc3RhdGUuDQogICAgDQog
ICAgU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPg0KICAg
IC0tLQ0KICAgICBkcml2ZXJzL252bWUvaG9zdC9mYy5jIHwgMTggKysrKysrKysrKysrKysrLS0t
DQogICAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
ICAgIA0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYy5jIGIvZHJpdmVycy9u
dm1lL2hvc3QvZmMuYw0KICAgIGluZGV4IDY3OWE3MjFhZTIyOS4uMmFjYjg1MGJmOWY0IDEwMDY0
NA0KICAgIC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMNCiAgICArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9mYy5jDQogICAgQEAgLTI5MTAsMTAgKzI5MTAsMjIgQEAgbnZtZV9mY19yZWNvbm5l
Y3Rfb3JfZGVsZXRlKHN0cnVjdCBudm1lX2ZjX2N0cmwgKmN0cmwsIGludCBzdGF0dXMpDQogICAg
IHN0YXRpYyB2b2lkDQogICAgIF9fbnZtZV9mY190ZXJtaW5hdGVfaW8oc3RydWN0IG52bWVfZmNf
Y3RybCAqY3RybCkNCiAgICAgew0KICAgIC0JbnZtZV9zdG9wX2tlZXBfYWxpdmUoJmN0cmwtPmN0
cmwpOw0KICAgICsJLyoNCiAgICArCSAqIGlmIHN0YXRlIGlzIGNvbm5lY3RpbmcgLSB0aGUgZXJy
b3Igb2NjdXJyZWQgYXMgcGFydCBvZiBhDQogICAgKwkgKiByZWNvbm5lY3QgYXR0ZW1wdC4gVGhl
IGNyZWF0ZV9hc3NvY2lhdGlvbiBlcnJvciBwYXRocyB3aWxsDQogICAgKwkgKiBjbGVhbiB1cCBh
bnkgb3V0c3RhbmRpbmcgaW8uDQogICAgKwkgKg0KICAgICsJICogaWYgaXQncyBhIGRpZmZlcmVu
dCBzdGF0ZSAtIGVuc3VyZSBhbGwgcGVuZGluZyBpbyBpcw0KICAgICsJICogdGVybWluYXRlZC4g
R2l2ZW4gdGhpcyBjYW4gZGVsYXkgd2hpbGUgd2FpdGluZyBmb3IgdGhlDQogICAgKwkgKiBhYm9y
dGVkIGlvIHRvIHJldHVybiwgd2UgcmVjaGVjayBhZGFwdGVyIHN0YXRlIGJlbG93DQogICAgKwkg
KiBiZWZvcmUgY2hhbmdpbmcgc3RhdGUuDQogICAgKwkgKi8NCiAgICArCWlmIChjdHJsLT5jdHJs
LnN0YXRlICE9IE5WTUVfQ1RSTF9DT05ORUNUSU5HKSB7DQogICAgKwkJbnZtZV9zdG9wX2tlZXBf
YWxpdmUoJmN0cmwtPmN0cmwpOw0KICAgICANCiAgICAtCS8qIHdpbGwgYmxvY2sgd2lsbCB3YWl0
aW5nIGZvciBpbyB0byB0ZXJtaW5hdGUgKi8NCiAgICAtCW52bWVfZmNfZGVsZXRlX2Fzc29jaWF0
aW9uKGN0cmwpOw0KICAgICsJCS8qIHdpbGwgYmxvY2sgd2lsbCB3YWl0aW5nIGZvciBpbyB0byB0
ZXJtaW5hdGUgKi8NCiAgICArCQludm1lX2ZjX2RlbGV0ZV9hc3NvY2lhdGlvbihjdHJsKTsNCiAg
ICArCX0NCiAgICAgDQogICAgIAlpZiAoY3RybC0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfQ09O
TkVDVElORyAmJg0KICAgICAJICAgICFudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJs
LCBOVk1FX0NUUkxfQ09OTkVDVElORykpDQogICAgLS0gDQogICAgMi4xMy43DQogICAgDQpSZXZp
ZXdlZC1ieTogSGltYW5zaHUgTWFkaGFuaSA8aG1hZGhhbmlAbWFydmVsbC5jb20+DQogICAgDQog
ICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiAgICBM
aW51eC1udm1lIG1haWxpbmcgbGlzdA0KICAgIExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLTNB
X19saXN0cy5pbmZyYWRlYWQub3JnX21haWxtYW5fbGlzdGluZm9fbGludXgtMkRudm1lJmQ9RHdJ
Q0FnJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPWxhbnVBRFVpejJ5bnVMekdBUWtKUFRLRE5v
ZDhVTWg1VmkxMTdSN0RnUzQmbT1WazJBX09LNk94d1IxeHFHc1pyajZzbkczZ0ZBR25xbWJCdUht
OXBpX0U4JnM9d0Zxa3M2NU1NX1hTeGVFY19Qc1lURWxJMWVmVURUbWtXZV9wWDNwVEdaVSZlPSAN
CiAgICANCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
