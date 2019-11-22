Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A412C432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 17:10:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9B020714
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fVA11O/z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OwG8lGq1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="O8zj99BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H1E2CG5hMKAG6pW4VgdtyFYNDs3U8pc/DDwXTvkYP70=; b=fVA11O/zfEU4iO
	4r1Fa5aL3BB031qY/dY8z2bwxotnxLx/KWoxN6U6gCqlmyCzelqXFOVW+WwG7ofDFYW3OTxt0uZZC
	B70zLKc/H79qWuXZg5UBaE7sSf8eQ9O9iYfIl0UNNCTVtF5QpsGVAUNrFZUOziPc1D7BLNDtHUDCW
	MCauUNXEant+9t34YvYsFhC2hV+sGA8ZOwWtHbxhe00QxishoFnnVC//Vgwg9BxSfu68Sy/FRE13M
	XfC7dr5LioD/zP+PK0EskKrWLH8OFT//gE9PUuKKrwx6Z9kClnA1/z8Xd4bl2LPQxranaL2pGo1xY
	Dku+3LvYIidly6JDzBPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYCRp-0007Jd-OP; Fri, 22 Nov 2019 17:10:21 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYCRV-0005uS-0J
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 17:10:04 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAMHA0od027146; Fri, 22 Nov 2019 09:10:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=DrceGPBH3r2xF+hiB+elTn5uDK9XY9B6x158tHig6kM=;
 b=OwG8lGq12lN8zrEuhXHSKc+1AxO+nBSL4xC4lpt9I7R11l1rJtp7uZ/c9NzMiIt5mO+R
 Jw5fj5D6uWAf7eqDOcvFAD9Jgyl4P3YWAhjT0grkEU2MQcEmRsz6kQBvhdJXondzHaJ3
 mDX0gM/+42p7r8mIiHujDPwcwzdisvdR+Ceg4txSYnWptqCOFKjn5Objm8NKDDNBDNNV
 BwzDExDw1Kt1mTQkqmDm8c1hfRZCK18oQHSkYtFWMXqOjbzubU58DlwGBoOjWM5E4455
 CssARB/mQpQEQT1J3ZjW1lwUPCfL7i5D4t3mybb150yp9zG5DL3Zcw1fzjah8qNBk4Oc pQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 2wearf27bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 22 Nov 2019 09:09:59 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 22 Nov
 2019 09:09:56 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Nov 2019 09:09:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvu7+An4Tyu/ao1KuxsYIqe/BkgRfTDqk0VyWu0DCFSS2Ubwi5AU/7S9H5eZIEv97FYJDwJdPPtTioDlGL8kdvaCX75aDLHa8pZxElnLcI5c580E7WGJvXbidhYJUin0Gj9tbVr6AfZ1nDeOh5XCasR2tSe+K8s7uUEad+m+44rCXZlfcBr7A6R32Yry3NBym69u+qbsMFN8Vb3W3SbFY1IJWf46Frt0ERGAnKMwSlbm5bIOW003dWafeuWQJC5kZzQG+MRr1UqgHBbH4UUhxBUsYF3fM7CkcmJZqfv5GbHYtxDCXs4THuu8gaGh1Lq83/HHBvSn3bssl/SoOe7JMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrceGPBH3r2xF+hiB+elTn5uDK9XY9B6x158tHig6kM=;
 b=GbGeHCx8+KUiSlehqZyumCJxUvoJ0fBNoe6s94ZMqgaBy3+jseT1v78dAi3PZBeoPTic+VtU9N44gXCaGSQULYsW6QS1QRRr5HJbRWWiye+h9/WE9PHtVLvm9jlIIvFySQM5ZYak6NqANjGcTQLXh7vFFGet8MZEgq3KhJd+ekBbJMHoQYIJxQbFlVHcNjhmcv7ojVT+C+MSd0cwvz+vWEjeDLE/iEHwukjTYStrAO2KXMq1EnZ00zgItYHK1sGZ4l2xTadxhI6tD69gt1uLL37K3VXZMKNuV+7HHSOMUIpSgexc9PR2pWgZjwSl2ihlN19+YZd7kaWS86jnKIASpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrceGPBH3r2xF+hiB+elTn5uDK9XY9B6x158tHig6kM=;
 b=O8zj99BEmBxLzTUbgA4JzpETwZHYJWsaB8MmSkj5Sw4kD1S8vKKb6GKUkMs9XMx1VRFu0wbEowFnqXEysUzTUK1mKwbXE1Tcb/ETOzLlCEwNzrcfmak3ShNXLKnDu0RJs27YmHfqUB5mUuIcGms3sPH27l6BtXDG72J8NgFRIYU=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB3231.namprd18.prod.outlook.com (10.255.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 22 Nov 2019 17:09:52 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::1435:34ad:dbff:5089]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::1435:34ad:dbff:5089%7]) with mapi id 15.20.2451.031; Fri, 22 Nov 2019
 17:09:52 +0000
From: Himanshu Madhani <hmadhani@marvell.com>
To: James Smart <jsmart2021@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme_fc : add module to ops template to allow module
 references
Thread-Topic: [PATCH] nvme_fc : add module to ops template to allow module
 references
Thread-Index: AQHVm0FyXnS+DVMgA0qDp4jd0+HtjKeXFDWA
Date: Fri, 22 Nov 2019 17:09:52 +0000
Message-ID: <2FAEDDBD-5C25-4C2D-8914-3EB697C27A5F@marvell.com>
References: <20191114231526.21807-1-jsmart2021@gmail.com>
In-Reply-To: <20191114231526.21807-1-jsmart2021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
x-originating-ip: [2600:1700:211:eb30:e5e4:c939:a3a3:4c5b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4d4d0b4-3078-4e24-2823-08d76f6eca31
x-ms-traffictypediagnostic: MN2PR18MB3231:
x-microsoft-antispam-prvs: <MN2PR18MB3231C07D839A0BAAE705BD1AD6490@MN2PR18MB3231.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39850400004)(346002)(366004)(136003)(199004)(189003)(966005)(81166006)(76176011)(110136005)(14454004)(186003)(6506007)(66946007)(2616005)(71190400001)(66556008)(305945005)(66476007)(71200400001)(2501003)(6512007)(6306002)(33656002)(316002)(11346002)(99286004)(58126008)(5660300002)(46003)(64756008)(8936002)(6116002)(446003)(91956017)(76116006)(102836004)(66446008)(86362001)(6486002)(256004)(6436002)(478600001)(8676002)(14444005)(6246003)(81156014)(229853002)(2906002)(7736002)(25786009)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR18MB3231;
 H:MN2PR18MB2719.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iXv0ThH1LqY8cheRz1YZLMb+WgluUQ7i81E3FYRw+/W0EAKxaMbr5clJbh0/WQpidEpgOaOPIvRwDKk8v89NFfg/zWqg9X7ARIl6LAggIlHM6qkhX8chToM5DILcfBfbiwtJffj19R3itI7YZLJP5bMM/NRqZJooQRDzxg9GPQ32ZZm+RnEpqCXZY+k2PipxxZwSvwimu4a2neTEUpHOxmzFyL2Jg79QfhdRXJ+mE19PZq09/v5jtEqnMGwCs1lC/JKQt4qNFxB4ScmKBiYOsvP4yWBXG5nqd9+G0uKPD0R3sDsMddXEFp+PiUSdCCn4Q0TP61zl3jn7OlHOP1ZmcRb9/OAnSNZwmDJand6tFYSQL5/d9MF7ZKgxtDrEQDPgjURJXosGJCh6eSzYzIjpqYc8PXch2DzVvZxnfjh7e77J+Yl3BW3S4+IyLxyCRE2
x-ms-exchange-transport-forked: True
Content-ID: <E2373C9E0F6EEE43A1FB7749325EDBEA@namprd18.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d4d0b4-3078-4e24-2823-08d76f6eca31
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 17:09:52.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBP3qXUdvY7vhsHw1Sci0bNdhLBiuKlHy25uvsx5nDl/VH3w+kthA7iFI6kI5xArtjgUMP2T0o8mb5WaesA8bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3231
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_03:2019-11-21,2019-11-22 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_091001_309750_E94C1D3C 
X-CRM114-Status: GOOD (  19.85  )
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

DQoNCu+7v09uIDExLzE0LzE5LCA1OjE1IFBNLCAiTGludXgtbnZtZSBvbiBiZWhhbGYgb2YgSmFt
ZXMgU21hcnQiIDxsaW51eC1udm1lLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZyBvbiBiZWhh
bGYgb2YganNtYXJ0MjAyMUBnbWFpbC5jb20+IHdyb3RlOg0KDQogICAgSW4gbnZtZS1mYzogaXQn
cyBwb3NzaWJsZSB0byBoYXZlIGNvbm5lY3RlZCBhY3RpdmUgY29udHJvbGxlcnMNCiAgICBhbmQg
YXMgbm8gcmVmZXJlbmNlcyBhcmUgdGFrZW4gb24gdGhlIExMREQsIHRoZSBMTEREIGNhbiBiZQ0K
ICAgIHVubG9hZGVkLiAgVGhlIGNvbnRyb2xsZXIgd291bGQgZW50ZXIgYSByZWNvbm5lY3Qgc3Rh
dGUgYW5kIGFzDQogICAgbG9uZyBhcyB0aGUgTExERCByZXN1bWVkIHdpdGhpbiB0aGUgcmVjb25u
ZWN0IHRpbWVvdXQsIHRoZQ0KICAgIGNvbnRyb2xsZXIgd291bGQgcmVzdW1lLiAgQnV0IGlmIGEg
bmFtZXNwYWNlIG9uIHRoZSBjb250cm9sbGVyDQogICAgaXMgdGhlIHJvb3QgZGV2aWNlLCBhbGxv
d2luZyB0aGUgZHJpdmVyIHRvIHVubG9hZCBjYW4gYmUgcHJvYmxlbWF0aWMuDQogICAgVG8gcmVs
b2FkIHRoZSBkcml2ZXIsIGl0IG1heSByZXF1aXJlIG5ldyBpbyB0byB0aGUgYm9vdCBkZXZpY2Us
DQogICAgYW5kIGFzIGl0J3Mgbm8gbG9uZ2VyIGNvbm5lY3RlZCB3ZSBnZXQgaW50byBhIGNhdGNo
LTIyIHRoYXQNCiAgICBldmVudHVhbGx5IGZhaWxzLCBhbmQgdGhlIHN5c3RlbSBsb2NrcyB1cC4N
CiAgICANCiAgICBGaXggdGhpcyBpc3N1ZSBieSB0YWtpbmcgYSBtb2R1bGUgcmVmZXJlbmNlIGZv
ciBldmVyeSBjb25uZWN0ZWQNCiAgICBjb250cm9sbGVyICh3aGljaCBpcyB3aGF0IHRoZSBjb3Jl
IGxheWVyIGRpZCB0byB0aGUgdHJhbnNwb3J0DQogICAgbW9kdWxlKS4gUmVmZXJlbmNlIGlzIGNs
ZWFyZWQgd2hlbiB0aGUgY29udHJvbGxlciBpcyByZW1vdmVkLg0KICAgIA0KICAgIFNpZ25lZC1v
ZmYtYnk6IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4NCiAgICAtLS0NCiAgICAg
ZHJpdmVycy9udm1lL2hvc3QvZmMuYyAgICAgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQogICAg
IGRyaXZlcnMvbnZtZS90YXJnZXQvZmNsb29wLmMgICAgfCAgMSArDQogICAgIGRyaXZlcnMvc2Nz
aS9scGZjL2xwZmNfbnZtZS5jICAgfCAgMiArKw0KICAgICBkcml2ZXJzL3Njc2kvcWxhMnh4eC9x
bGFfbnZtZS5jIHwgIDEgKw0KICAgICBpbmNsdWRlL2xpbnV4L252bWUtZmMtZHJpdmVyLmggIHwg
IDQgKysrKw0KICAgICA1IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9mYy5jDQogICAgaW5kZXggNjc5YTcyMWFlMjI5Li40MGY5MjQxYzU5
MmYgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYw0KICAgICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZjLmMNCiAgICBAQCAtMzQyLDcgKzM0Miw4IEBAIG52bWVfZmNfcmVn
aXN0ZXJfbG9jYWxwb3J0KHN0cnVjdCBudm1lX2ZjX3BvcnRfaW5mbyAqcGluZm8sDQogICAgIAkg
ICAgIXRlbXBsYXRlLT5sc19yZXEgfHwgIXRlbXBsYXRlLT5mY3BfaW8gfHwNCiAgICAgCSAgICAh
dGVtcGxhdGUtPmxzX2Fib3J0IHx8ICF0ZW1wbGF0ZS0+ZmNwX2Fib3J0IHx8DQogICAgIAkgICAg
IXRlbXBsYXRlLT5tYXhfaHdfcXVldWVzIHx8ICF0ZW1wbGF0ZS0+bWF4X3NnbF9zZWdtZW50cyB8
fA0KICAgIC0JICAgICF0ZW1wbGF0ZS0+bWF4X2RpZl9zZ2xfc2VnbWVudHMgfHwgIXRlbXBsYXRl
LT5kbWFfYm91bmRhcnkpIHsNCiAgICArCSAgICAhdGVtcGxhdGUtPm1heF9kaWZfc2dsX3NlZ21l
bnRzIHx8ICF0ZW1wbGF0ZS0+ZG1hX2JvdW5kYXJ5IHx8DQogICAgKwkgICAgIXRlbXBsYXRlLT5t
b2R1bGUpIHsNCiAgICAgCQlyZXQgPSAtRUlOVkFMOw0KICAgICAJCWdvdG8gb3V0X3JlZ2hvc3Rf
ZmFpbGVkOw0KICAgICAJfQ0KICAgIEBAIC0yMDE1LDYgKzIwMTYsNyBAQCBudm1lX2ZjX2N0cmxf
ZnJlZShzdHJ1Y3Qga3JlZiAqcmVmKQ0KICAgICB7DQogICAgIAlzdHJ1Y3QgbnZtZV9mY19jdHJs
ICpjdHJsID0NCiAgICAgCQljb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgbnZtZV9mY19jdHJsLCBy
ZWYpOw0KICAgICsJc3RydWN0IG52bWVfZmNfbHBvcnQgKmxwb3J0ID0gY3RybC0+bHBvcnQ7DQog
ICAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KICAgICANCiAgICAgCWlmIChjdHJsLT5jdHJsLnRh
Z3NldCkgew0KICAgIEBAIC0yMDQxLDYgKzIwNDMsNyBAQCBudm1lX2ZjX2N0cmxfZnJlZShzdHJ1
Y3Qga3JlZiAqcmVmKQ0KICAgICAJaWYgKGN0cmwtPmN0cmwub3B0cykNCiAgICAgCQludm1mX2Zy
ZWVfb3B0aW9ucyhjdHJsLT5jdHJsLm9wdHMpOw0KICAgICAJa2ZyZWUoY3RybCk7DQogICAgKwlt
b2R1bGVfcHV0KGxwb3J0LT5vcHMtPm1vZHVsZSk7DQogICAgIH0NCiAgICAgDQogICAgIHN0YXRp
YyB2b2lkDQogICAgQEAgLTMwNTksMTAgKzMwNjIsMTUgQEAgbnZtZV9mY19pbml0X2N0cmwoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbnZtZl9jdHJsX29wdGlvbnMgKm9wdHMsDQogICAgIAkJ
Z290byBvdXRfZmFpbDsNCiAgICAgCX0NCiAgICAgDQogICAgKwlpZiAoIXRyeV9tb2R1bGVfZ2V0
KGxwb3J0LT5vcHMtPm1vZHVsZSkpIHsNCiAgICArCQlyZXQgPSAtRVVOQVRDSDsNCiAgICArCQln
b3RvIG91dF9mcmVlX2N0cmw7DQogICAgKwl9DQogICAgKw0KICAgICAJaWR4ID0gaWRhX3NpbXBs
ZV9nZXQoJm52bWVfZmNfY3RybF9jbnQsIDAsIDAsIEdGUF9LRVJORUwpOw0KICAgICAJaWYgKGlk
eCA8IDApIHsNCiAgICAgCQlyZXQgPSAtRU5PU1BDOw0KICAgIC0JCWdvdG8gb3V0X2ZyZWVfY3Ry
bDsNCiAgICArCQlnb3RvIG91dF9tb2RfcHV0Ow0KICAgICAJfQ0KICAgICANCiAgICAgCWN0cmwt
PmN0cmwub3B0cyA9IG9wdHM7DQogICAgQEAgLTMyMTUsNiArMzIyMyw4IEBAIG52bWVfZmNfaW5p
dF9jdHJsKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG52bWZfY3RybF9vcHRpb25zICpvcHRz
LA0KICAgICBvdXRfZnJlZV9pZGE6DQogICAgIAlwdXRfZGV2aWNlKGN0cmwtPmRldik7DQogICAg
IAlpZGFfc2ltcGxlX3JlbW92ZSgmbnZtZV9mY19jdHJsX2NudCwgY3RybC0+Y251bSk7DQogICAg
K291dF9tb2RfcHV0Og0KICAgICsJbW9kdWxlX3B1dChscG9ydC0+b3BzLT5tb2R1bGUpOw0KICAg
ICBvdXRfZnJlZV9jdHJsOg0KICAgICAJa2ZyZWUoY3RybCk7DQogICAgIG91dF9mYWlsOg0KICAg
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjbG9vcC5jIGIvZHJpdmVycy9udm1l
L3RhcmdldC9mY2xvb3AuYw0KICAgIGluZGV4IGI1MGI1M2RiMzc0Ni4uMWM1MGFmNjIxOWYzIDEw
MDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZmNsb29wLmMNCiAgICArKysgYi9k
cml2ZXJzL252bWUvdGFyZ2V0L2ZjbG9vcC5jDQogICAgQEAgLTg1MCw2ICs4NTAsNyBAQCBmY2xv
b3BfdGFyZ2V0cG9ydF9kZWxldGUoc3RydWN0IG52bWV0X2ZjX3RhcmdldF9wb3J0ICp0YXJnZXRw
b3J0KQ0KICAgICAjZGVmaW5lIEZDTE9PUF9ETUFCT1VORF80RwkJMHhGRkZGRkZGRg0KICAgICAN
CiAgICAgc3RhdGljIHN0cnVjdCBudm1lX2ZjX3BvcnRfdGVtcGxhdGUgZmN0ZW1wbGF0ZSA9IHsN
CiAgICArCS5tb2R1bGUJCQk9IFRISVNfTU9EVUxFLA0KICAgICAJLmxvY2FscG9ydF9kZWxldGUJ
PSBmY2xvb3BfbG9jYWxwb3J0X2RlbGV0ZSwNCiAgICAgCS5yZW1vdGVwb3J0X2RlbGV0ZQk9IGZj
bG9vcF9yZW1vdGVwb3J0X2RlbGV0ZSwNCiAgICAgCS5jcmVhdGVfcXVldWUJCT0gZmNsb29wX2Ny
ZWF0ZV9xdWV1ZSwNCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19udm1l
LmMgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX252bWUuYw0KICAgIGluZGV4IGEyMjdlMzZjYmRj
Mi4uOGUwZjAzZWYzNDZiIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNf
bnZtZS5jDQogICAgKysrIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19udm1lLmMNCiAgICBAQCAt
MTk3Niw2ICsxOTc2LDggQEAgbHBmY19udm1lX2ZjcF9hYm9ydChzdHJ1Y3QgbnZtZV9mY19sb2Nh
bF9wb3J0ICpwbnZtZV9scG9ydCwNCiAgICAgDQogICAgIC8qIERlY2xhcmUgYW5kIGluaXRpYWxp
emF0aW9uIGFuIGluc3RhbmNlIG9mIHRoZSBGQyBOVk1FIHRlbXBsYXRlLiAqLw0KICAgICBzdGF0
aWMgc3RydWN0IG52bWVfZmNfcG9ydF90ZW1wbGF0ZSBscGZjX252bWVfdGVtcGxhdGUgPSB7DQog
ICAgKwkubW9kdWxlCT0gVEhJU19NT0RVTEUsDQogICAgKw0KICAgICAJLyogaW5pdGlhdG9yLWJh
c2VkIGZ1bmN0aW9ucyAqLw0KICAgICAJLmxvY2FscG9ydF9kZWxldGUgID0gbHBmY19udm1lX2xv
Y2FscG9ydF9kZWxldGUsDQogICAgIAkucmVtb3RlcG9ydF9kZWxldGUgPSBscGZjX252bWVfcmVt
b3RlcG9ydF9kZWxldGUsDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV9udm1lLmMgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5jDQogICAgaW5kZXggNmNj
MTllMDYwYWZjLi42ZTRkNzEzMDI1MzQgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9zY3NpL3Fs
YTJ4eHgvcWxhX252bWUuYw0KICAgICsrKyBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9udm1l
LmMNCiAgICBAQCAtNjEwLDYgKzYxMCw3IEBAIHN0YXRpYyB2b2lkIHFsYV9udm1lX3JlbW90ZXBv
cnRfZGVsZXRlKHN0cnVjdCBudm1lX2ZjX3JlbW90ZV9wb3J0ICpycG9ydCkNCiAgICAgfQ0KICAg
ICANCiAgICAgc3RhdGljIHN0cnVjdCBudm1lX2ZjX3BvcnRfdGVtcGxhdGUgcWxhX252bWVfZmNf
dHJhbnNwb3J0ID0gew0KICAgICsJLm1vZHVsZQk9IFRISVNfTU9EVUxFLA0KICAgICAJLmxvY2Fs
cG9ydF9kZWxldGUgPSBxbGFfbnZtZV9sb2NhbHBvcnRfZGVsZXRlLA0KICAgICAJLnJlbW90ZXBv
cnRfZGVsZXRlID0gcWxhX252bWVfcmVtb3RlcG9ydF9kZWxldGUsDQogICAgIAkuY3JlYXRlX3F1
ZXVlICAgPSBxbGFfbnZtZV9hbGxvY19xdWV1ZSwNCiAgICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9udm1lLWZjLWRyaXZlci5oIGIvaW5jbHVkZS9saW51eC9udm1lLWZjLWRyaXZlci5oDQog
ICAgaW5kZXggMTBmODE2MjliOWNlLi42ZDBkNzBmMzIxOWMgMTAwNjQ0DQogICAgLS0tIGEvaW5j
bHVkZS9saW51eC9udm1lLWZjLWRyaXZlci5oDQogICAgKysrIGIvaW5jbHVkZS9saW51eC9udm1l
LWZjLWRyaXZlci5oDQogICAgQEAgLTI3MCw2ICsyNzAsOCBAQCBzdHJ1Y3QgbnZtZV9mY19yZW1v
dGVfcG9ydCB7DQogICAgICAqDQogICAgICAqIEhvc3QvSW5pdGlhdG9yIFRyYW5zcG9ydCBFbnRy
eXBvaW50cy9QYXJhbWV0ZXJzOg0KICAgICAgKg0KICAgICsgKiBAbW9kdWxlOiAgVGhlIExMREQg
bW9kdWxlIHVzaW5nIHRoZSBpbnRlcmZhY2UNCiAgICArICoNCiAgICAgICogQGxvY2FscG9ydF9k
ZWxldGU6ICBUaGUgTExERCBpbml0aWF0ZXMgZGVsZXRpb24gb2YgYSBsb2NhbHBvcnQgdmlhDQog
ICAgICAqICAgICAgIG52bWVfZmNfZGVyZWdpc3Rlcl9sb2NhbHBvcnQoKS4gSG93ZXZlciwgdGhl
IHRlYXJkb3duIGlzDQogICAgICAqICAgICAgIGFzeW5jaHJvbm91cy4gVGhpcyByb3V0aW5lIGlz
IGNhbGxlZCB1cG9uIHRoZSBjb21wbGV0aW9uIG9mIHRoZQ0KICAgIEBAIC0zODMsNiArMzg1LDgg
QEAgc3RydWN0IG52bWVfZmNfcmVtb3RlX3BvcnQgew0KICAgICAgKiAgICAgICBWYWx1ZSBpcyBN
YW5kYXRvcnkuIEFsbG93ZWQgdG8gYmUgemVyby4NCiAgICAgICovDQogICAgIHN0cnVjdCBudm1l
X2ZjX3BvcnRfdGVtcGxhdGUgew0KICAgICsJc3RydWN0IG1vZHVsZQkqbW9kdWxlOw0KICAgICsN
CiAgICAgCS8qIGluaXRpYXRvci1iYXNlZCBmdW5jdGlvbnMgKi8NCiAgICAgCXZvaWQJKCpsb2Nh
bHBvcnRfZGVsZXRlKShzdHJ1Y3QgbnZtZV9mY19sb2NhbF9wb3J0ICopOw0KICAgICAJdm9pZAko
KnJlbW90ZXBvcnRfZGVsZXRlKShzdHJ1Y3QgbnZtZV9mY19yZW1vdGVfcG9ydCAqKTsNCiAgICAt
LSANCiAgICAyLjEzLjcNCiAgICANCiAgICANCkxvb2tzIEdvb2QuIA0KDQpBY2tlZC1ieTogSGlt
YW5zaHUgTWFkaGFuaSA8aG1hZGhhbmlAbWFydmVsbC5jb20+DQogICAgX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiAgICBMaW51eC1udm1lIG1haWxpbmcg
bGlzdA0KICAgIExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KICAgIGh0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLTNBX19saXN0cy5pbmZyYWRlYWQu
b3JnX21haWxtYW5fbGlzdGluZm9fbGludXgtMkRudm1lJmQ9RHdJQ0FnJmM9bktqV2VjMmI2UjBt
T3lQYXo3eHRmUSZyPWxhbnVBRFVpejJ5bnVMekdBUWtKUFRLRE5vZDhVTWg1VmkxMTdSN0RnUzQm
bT1HT0ttVkJhSW9xb0NTeVZPRldYLS1udHZpQVZnYUVJa2ZrLWpXN3h4SVc4JnM9THFPZDIxZTR0
R3UyZWl6ZjlFcnFnaDEwSHUyMjA1bHlBb0RwcFVSeHpKOCZlPSANCiAgICANCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
