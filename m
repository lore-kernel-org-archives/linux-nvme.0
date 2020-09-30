Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B80DC4727E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 11:28:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46F720708
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 11:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XbG+W1d/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="UDu8Ps36";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="LLakZVXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46F720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p8XWYA7rVl/8sOZCsrQ9RZtlI4qMtAT4LN2xiCZNj6s=; b=XbG+W1d/3eTyPD6DrEsvwQ3Fk
	Exgy5QC/BUZdMb6cVsjeCOCHtTEXarm89qscFpLknHoSw6ooQfYaKPxB1d2kKz2wJwjaEl54ETsQo
	lmHxKLd6kyMpPmpQWUcwXowu0nYQNojOLYyCdFFTiEyZ1lG7P3LwlZ/HHO16ojbncjP3EVGhQg7U0
	f/NEiLbGx3XtM1U0otCPSkvuSFIsnFLThY53wKKbqO+vJuPBcvJXWgl9vVcrVygsbfuu7LzBPWsdY
	G3Gm39o6Ur1aOGhCv6Xv0XaUG9ZfFxKpnIcKs0pmMJZCo+gSdGbrdgcMpS4fwNNK1NUjpLOh/CUJu
	tFgKKkklw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNaHW-0003Ws-42; Wed, 30 Sep 2020 11:28:22 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNaHT-0003W8-8T
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 11:28:20 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08UBGdNI006218; Wed, 30 Sep 2020 07:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JHiZj7gq1YRqo4PFLjdlVmdf+7FXfSoXgbVh1AHVEUw=;
 b=UDu8Ps36T+f1AT7mL17hzf/lu8+5JB6LnJ7JRnMaULnnTK8cbD/qtHfEUrdd5HEj3LLb
 UMuk29+C1/ojTF3B8Vc1nyoC/AnMYfQURt9GfCZxyTkKBs9ef9vfxRvLwiYEuHv0gjOQ
 66D/2JPrERha/p6jiimdlrpCwWPGV8FHMR3dZoPYSS068swar/u2BlfJVTqGnBNG9Wr9
 H+NjkFEdjOG34kx1HSaqP0lSBgfBTAjJoJIqg7LbwzHqnvOw0p18uxKuTqPL7P5Sjcqx
 E8ZcI/ttQGk2vqr8IjnbKt09LQvSduKWoJGegac09qdO5X6Tm37ZsFLcKJ6twDa/S4w2 Cw== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 33t0sxn3bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 07:28:11 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08UBPJuu127988; Wed, 30 Sep 2020 07:28:10 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by mx0b-00154901.pphosted.com with ESMTP id 33vnwkapbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 07:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAKUKLzh5rZ2VSecKGrnmtg1faJfqvcb8BSoFBBVBzy0ZYvISjmd9sIOFXS2+n8Jm9fE56mrUawHAU0GjQ3GRUfbk9Ntskx/vBJ4pmbyE7Rky/yymdy8mmn5LKYBBsSZXFTufgqi/7QWsoqXHBShKjuzOANTjxjSVIuhFupQv/gR18KO+2WyxKxdqgcYpzx6Ql0prAj7EdlZotBhTD4FjXA1SssvjHk0lC868ApcDuhHm2uwjqzHC1z+ecM+9IaxN5Tm6R6jid9I6K1lyxHF2oPAhQ4s90N9HFgv498LBW44s4zlp4leIokYYVColk1YWlnPvCewHy4K5416AsA+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHiZj7gq1YRqo4PFLjdlVmdf+7FXfSoXgbVh1AHVEUw=;
 b=hMmR/VV57hCthX49QCIn32/MbueQBmn+Pr+/TRmXHjdjIw5QN2UtXT8ZwG+Ur+2DVTfx5tCOb5zvJz/IHs2qs5PIUGuVcPjNhMdpNrXsGJVK6N9TtNv3672s4qtj+hTUYUV12WzbRd5oKitgQ/WY0uLq/26vnt5iuquDPEW7A934H2ejVp8X14y7x7bqf/SNnc8hoAa9D8axVFxDuOtMnSPuh2o7U3evL8/09mKCPz5xTPYcDQz0HxawpLy42YMbfdVZhJYquHFCcQCEjJ8BCZoDrY9DvfexInNERLAmA8IH/dQn2R2VygVk3kXTIpjZlm0ru7m0m5DiMGKFay4XcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHiZj7gq1YRqo4PFLjdlVmdf+7FXfSoXgbVh1AHVEUw=;
 b=LLakZVXLPWZ+7hNJHFRVMV3gkxQ8QM3+fmrw1Wk1lKGp08U/82GDL6J2fA+hGxhwgUD/ppQqRdbRgdRywQKu5bbXsFw2oP0AluKQsHC0BN+yauKXRBzWhKdgqV24IwJUGkmK9gxh4Xf4NsFxjx2SZQuEPH/y/O+N5y88uG8TyRM=
Received: from BL0PR1901MB2067.namprd19.prod.outlook.com
 (2603:10b6:207:33::32) by BLAPR19MB4596.namprd19.prod.outlook.com
 (2603:10b6:208:297::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 11:28:08 +0000
Received: from BL0PR1901MB2067.namprd19.prod.outlook.com
 ([fe80::14f3:5b26:a46:beb6]) by BL0PR1901MB2067.namprd19.prod.outlook.com
 ([fe80::14f3:5b26:a46:beb6%5]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 11:28:08 +0000
From: "Anner, Ran" <Ran.Anner@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Topic: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Index: AdaWdvf+7tpUpYyWRD2wZy6V/04JWAAKtLKAAB62/8A=
Date: Wed, 30 Sep 2020 11:28:08 +0000
Message-ID: <BL0PR1901MB20671CF789D8C246AF911B4D91330@BL0PR1901MB2067.namprd19.prod.outlook.com>
References: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
 <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
In-Reply-To: <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Ran.Anner@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-30T11:28:05.6516527Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=353620e3-684f-40d4-ae7e-27c3df5807d7;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5fe8613-d547-47d6-6d40-08d86533e805
x-ms-traffictypediagnostic: BLAPR19MB4596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BLAPR19MB459676FDA52C92F7EDAC22E791330@BLAPR19MB4596.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/lfmX8gELXksEpn2cUQcXpX53lz5hpoUSLzPOXIusrMicQSD2CJ9d3CjGhMONwLtKoz8YBaefOUy/aU/47hB6Nz16dvkMO3gdZIzikyoxS/xKaMcbmi074OTCO1imShMk80Sxmt4VE3aIgv7zYkPXnvUFkFNgisJcPfN9HmzHoBwAGfmuiwWmObPQ+ZgjH2uYKSt16WWoSKU0UNKZ27V1kOIv/pEtFSgWAHKuJf0vW4SM8jP0TrRzmoEyiTHSbAL2ldMdJDgu4XZuZo2t4xUfHdaF5M+WUCIxtiPIFdkS5XfbT1odMo/r6F0jCTb5F00j1TKKp+QRRztmvt45TCaI5KiTENWJyW1LGKhf687iYBBnIX/HyXL5vdohI4e9ONujcmqaEzOTpGXsGenY6S8FVbgqSiZMEfUVE9npeTol84X2MVBmSJB6zSaiVn2+0xqfMbYp4in/mRpCN3HfmzFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2067.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(376002)(346002)(366004)(396003)(71200400001)(8676002)(66946007)(478600001)(66476007)(26005)(76116006)(186003)(33656002)(8936002)(5660300002)(64756008)(7696005)(6506007)(53546011)(786003)(54906003)(66446008)(66556008)(316002)(83380400001)(52536014)(966005)(86362001)(2906002)(107886003)(110136005)(55016002)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tp7Gt4WSzWGNnI0Dq7+EcKIA2x5JMjHlXl5lkDHf0HhxfoF9w78SDI2UR/Xh4imnpwReCxN/8w7TvzM0wpaH4vigU2PdGHrRW50S/3//7u3r2xBqswwdLSbyNqCidvdx/QT5+heaJhY/uHdQEYk/IWA5o7I6HyHEI2NhXLpgQwMPTrqobRzm6kIoPlzEGhBqCjn5ECLCFN4w7omVie01kdeBUhWAtHYa5lceSs8inwHqEwIOmZgLoCpAbw0AnGpRlZqsWapemaWx3pfDJcLCa48YDhb3tDqiqJ8Lqe0Bc15D9meBMRHbVHx1Q84bxcvgeA18ejKsHdz6ntT+S6tv5r/+tj6l0J2JugkiNxSe4N0hwv8l4sREF7P0OAcJSlXL+LrgZ7ydWbkESQ0/tWwbJgh/q20WALM7rcM8TSlzWzgoUvjd0eWxiX7CuJOgxBaNJQ4C5O1eybx4B2juP6NzSZiYw8VWBS3lRZ3eG6llgeNwwrg84QJXaBFCWs3cb04dkpvBalisQBcDjrxs5Er42slSf+pSHwqPkF/5YiCLJoXA6Fzwj3UmAfdkMnuSd4EzXWUxm2IAT3+whGHL9x9Qv3aaPnmJ1SQ+FjV23JroAytGz3irlCnrR+kjqwFp4PKM8C7G4jHkBVNwEhzQ3Acrhg==
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2067.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fe8613-d547-47d6-6d40-08d86533e805
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 11:28:08.1893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dWVQgF5soSJFigSHtXPKd0aGwCxNbs38qdo6sxh1sxTN+n5soRW21yHkEYG2M+FOxz7Ct5AAWzhfe0OAEESXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-30_06:2020-09-30,
 2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300093
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_072819_564247_CDDB8A73 
X-CRM114-Status: GOOD (  29.23  )
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
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>, "Grupi,
 Elad" <Elad.Grupi@dell.com>, "Engel, Amit" <Amit.Engel@Dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhbmtzIHlvdSBTYWdpLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4gDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MjksIDIwMjAgMTE6NDggUE0NClRvOiBBbm5lciwgUmFuOyBsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcNCkNjOiBaaW5nZXIsIEVsZGFkOyBHcnVwaSwgRWxhZDsgRW5nZWwsIEFtaXQNClN1
YmplY3Q6IFJlOiBrZXJuZWwgcGFuaWMgaW4gbnZtZXRfdGNwIHdoZW4gcmVjZWl2aW5nIG1hbGZv
cm1lZCBhZG1pbiBjb21tYW5kDQoNCg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KDQo+IEhlbGxvIGFs
bC4NCg0KSGV5IFJhbiwgdGhhbmtzIGZvciByZXBvcnRpbmcNCg0KPiANCj4gV2UgYXJlIGludmVz
dGlnYXRpbmcga2VybmVsIHBhbmljIHdoZW4gYSBtYWxmb3JtZWQgYWRtaW4gY29tbWFuZCB3aXRo
IGlubGluZSB3cml0ZSBkYXRhIGlzIHNlbnQgZnJvbSBob3N0IHRvIHRhcmdldCB1c2luZyBudm1l
b2YgdGNwLg0KPiBGb2xsb3dpbmcgYSBjb2RlIHJldmlldyBvZiBudm1ldF90Y3AgZnJvbSBsYXRl
c3Qga2VybmVsIGFuZCBhZGRpbmcgZGVidWcgbG9ncyBhbG9uZyB0aGUgd2F5IEkgY2FtZSB1cCB3
aXRoIHRoZSBmb2xsb3dpbmcgZmxvdzoNCj4gDQo+IG52bWV0X3RjcF90cnlfcmVjdl9wZHUgc2Vu
ZHMgYW4gSU8gd2l0aCBpbmxpbmUgZGF0YSB0byBudm1ldF9yZXFfaW5pdC4NCj4gbnZtZXRfcmVx
X2luaXQgc2VuZCB0byBwYXJzZSB3aGljaCBmYWlscyAoZXguIGhvc3Qgc2VuZHMgbWFsZm9ybWVk
IGNvbW1hbmQpLg0KPiBudm1ldF9yZXFfaW5pdCBjYWxscyBfX252bWV0X3JlcV9jb21wbGV0ZSwg
YW5kIGluIHR1cm4gY2FsbHMgcXVldWVfcmVzcG9uc2UuDQo+IG52bWV0X3RjcF9xdWV1ZV9yZXNw
b25zZSBhZGQgdGhlIGNvbW1hbmQgdG8gcXVldWUgcmVzcG9uc2UgbGlzdC4NCj4gbnZtZXRfcmVx
X2luaXQgcmV0dXJuIGVycm9yIHN0YXR1cyBhbmQgbnZtZXRfdGNwX2hhbmRsZV9yZXFfZmFpbHVy
ZSBpcyBjYWxsZWQuDQo+IG52bWV0X3RjcF9oYW5kbGVfcmVxX2ZhaWx1cmUgY2hlY2tzIGlmIHRo
ZSBjb21tYW5kIGhhcyBpbmxpbmUgZGF0YSBhbmQgd2lsbCBhbGxvY2F0ZSBwYWdlcyBhbmQgaW92
cy4NCj4gbnZtZXRfdGNwX2hhbmRsZV9yZXFfZmFpbHVyZSByZXR1cm4gYW5kIG52bWV0X3RjcF9k
b25lX3JlY3ZfcGR1IHJldHVybnMgLUVBR0FJTi4NCj4gbnZtZXRfdGNwX3RyeV9yZWN2X3BkdSBy
ZXR1cm5zIC1FQUdBSU4gYW5kIGluIHRoYXQgY2FzZSBudm1ldF90Y3BfdHJ5X3JlY3Zfb25lIHJl
dHVybnMgMC4NCj4gSW4gY2FzZSBudm1ldF90Y3BfdHJ5X3JlY3Zfb25lIHJldHVybnMgMCwgbnZt
ZXRfdGNwX3RyeV9yZWN2IGJyZWFrcyBmcm9tIGxvb3AgYW5kIHJldHVybiB6ZXJvIGFzIHdlbGwu
DQo+IEluIG52bWV0X3RjcF9pb193b3JrIHdlIGNvbnRpbnVlIHRvIG52bWV0X3RjcF90cnlfc2Vu
ZCBpbiBjYXNlIHRoZSByZXR1cm4gdmFsdWUgaXMgemVyby4NCj4gbnZtZXRfdGNwX3RyeV9zZW5k
X29uZSB3aWxsIGNhbGwgbnZtZXRfdGNwX2ZldGNoX2NtZCB3aGljaCBjYW4gYXNzaWduIHNuZF9j
bWQgYXMgdGhlIGZhaWxlZCBjb21tYW5kLg0KPiBudm1ldF90Y3BfbmVlZF9kYXRhX291dCBhbmQg
bnZtZXRfdGNwX25lZWRfZGF0YV9pbiByZXR1cm4gZmFsc2Ugc28gd2UgY2FsbCBudm1ldF9zZXR1
cF9yZXNwb25zZV9wZHUuDQo+IG52bWV0X3NldHVwX3Jlc3BvbnNlX3BkdSBzZXQgdGhlIGNtZCBz
dGF0ZSB0byBOVk1FVF9UQ1BfU0VORF9SRVNQT05TRSBhbmQgcmV0dXJuLg0KPiBCYWNrIHRvIG52
bWV0X3RjcF90cnlfc2VuZF9vbmUsIGNtZC0+c3RhdGUgPT0gTlZNRVRfVENQX1NFTkRfUkVTUE9O
U0Ugc28gbnZtZXRfdHJ5X3NlbmRfcmVzcG9uc2UgaXMgY2FsbGVkLg0KPiBBZnRlciBrZXJuZWxf
c2VuZHBhZ2Ugd2UgZnJlZSB0aGUgY21kIGlvdiBhbmQgc2dsLg0KPiBFdmVudHVhbGx5IG52bWV0
X3RjcF90cnlfcmVjdl9kYXRhIHdpbGwgYmUgY2FsbGVkIGJ1dCB0aGUgaW92IHdhcyBhbHJlYWR5
IHJlbW92ZWQgYW5kIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCBpcyB0cmlnZ2VyZWQuDQo+IA0K
PiBJIHdhcyB3b25kZXJpbmcgaWYgdGhpcyBpcyBhIGtub3dzIGlzc3VlIG9yIGlmIHNvbWVvbmUg
ZWxzZSBlbmNvdW50ZXJlZCB0aGlzIGJlZm9yZS4NCj4gSXQgc2VlbXMgdG8gbWUgYSBmaXggZm9y
IHRoaXMgd291bGQgYmUgdG8gbm90IHF1ZXVlIHRoZSByZXNwb25zZSBiZWZvcmUgcmVjZWl2aW5n
IGFsbCBkYXRhIGluIHRoaXMgc3BlY2lmaWMgZmxvdy4NCj4gQWRkZWQgYmVsb3cgc25pcHBldCBv
ZiB0aGUga2VybmVsIHRyYWNlLg0KPiBBbHRlcm5hdGl2ZWx5IGlmIHdlIGRvIG5vdCB3YW50IHRv
IGRlbGF5IHRoZSByZXNwb25zZSwgZnJlZSB0aGUgaW92IGFmdGVyIGJvdGggZmxvd3MgYXJlIGRv
bmUsIG1heWJlIHVzaW5nIHJlZmVyZW5jZSBjb3VudGluZyB0byBkbyBzby4NCj4gSSB3aWxsIGJl
IGdsYWQgdG8gaGVhciB5b3VyIHRob3VnaHRzIGFuZCBjb21tZW50cy4NCg0KVGhpcyBpcyBpbmRl
ZWQgYSBidWcuIFdlIGRlZmluaXRlbHkgbmVlZCBhIHJlZmNvdW50IGhlcmUuIEkgcmVjYWxsIHRo
YXQgdGhpcyB1c2VkIHRvIHdvcmsgdGhvdWdoLi4NCg0KV2hhdCB3ZSBwcm9iYWJseSBuZWVkIHRv
IGRvIGlzIHRvIGRlZmVyIHRoZSByZXNwb25zZSBzZW5kIHVudGlsIHdlIGNvbXBsZXRlIGZldGNo
aW5nIHRoZSBlbnRpcmUgaW5jb21pbmcgZGF0YSBhbmQgdGhlbiBzYWZlbHkgZnJlZSB0aGUgY29t
bWFuZC4NCg0KSSdsbCB0cnkgdG8gc3BpbiBhIHBhdGNoIHNvb24uDQoNCj4gDQo+IFRoYW5rIHlv
dSwNCj4gUmFuLg0KPiANCj4gWzEzNTM4LjA0NjM2NF0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0
OiAwMDAwIFsjMV0gU01QIE5PUFRJIA0KPiBbMTM1MzguMDUxNzYyXSBDUFU6IDEwIFBJRDogNjAz
IENvbW06IGt3b3JrZXIvMTA6MUggS2R1bXA6IGxvYWRlZCANCj4gVGFpbnRlZDogR8KgwqDCoMKg
wqDCoCDCoFfCoCBPRcKgwqDCoMKgIDQuMTkuMTM0LWNvcmVvcy1yOTk5OS4xNjAwNzc0MDk1LTE2
MTAgIzEgDQo+IFsxMzUzOC4wNjM1NzRdIEhhcmR3YXJlIG5hbWU6IEVNQyA5MDAtNTMyLTAwMi8x
MTAtNTUxLTkxMEMtMDEsIEJJT1MgDQo+IDE2LjM1IDA0LzA4LzIwMjAgWzEzNTM4LjA3MTA0OV0g
V29ya3F1ZXVlOiBudm1ldF90Y3Bfd3EgDQo+IG52bWV0X3RjcF9pb193b3JrIFtudm1ldF90Y3Bd
IFsxMzUzOC4wNzcxNDJdIFJJUDogDQo+IDAwMTA6bWVtY3B5X2VybXMrMHg2LzB4MTAgWzEzNTM4
LjA4MTIzN10gQ29kZTogOTAgOTAgOTAgOTAgZWIgMWUgMGYgMWYgDQo+IDAwIDQ4IDg5IGY4IDQ4
IDg5IGQxIDQ4IGMxIGU5IDAzIDgzIGUyIDA3IGYzIDQ4IGE1IDg5IGQxIGYzIGE0IGMzIDY2IA0K
PiAwZiAxZiA0NCAwMCAwMCA0OCA4OSBmOCA0OCA4OSBkMSA8ZjM+IGE0IGMzIDBmIDFmIDgwIDAw
IDAwIDAwIDAwIDQ4IDg5IA0KPiBmOCA0OCA4MyBmYSAyMCA3MiA3ZT4gWzEzNTM4LjA5OTk4MV0g
UlNQOiAwMDE4OmZmZmZjOTAwMDc4MWJjNzAgDQo+IEVGTEFHUzogMDAwMTAyMDIgWzEzNTM4LjEw
NTE5OV0gUkFYOiAzMWQyNDdjYTE5NThmNjNmIFJCWDogDQo+IDAwMDAwMDAwMDAwMDA1MTAgUkNY
OiAwMDAwMDAwMDAwMDAwNTEwIFsxMzUzOC4xMTIzMjJdIFJEWDogDQo+IDAwMDAwMDAwMDAwMDA1
MTAgUlNJOiBmZmZmODg4NjQ0NWY2MGNhIFJESTogMzFkMjQ3Y2ExOTU4ZjYzZiANCj4gWzEzNTM4
LjExOTQ0Nl0gUkJQOiBmZmZmODg4MzA4YzQxOTIwIFIwODogMDAwMDAwMDAwMDAwMDUxMCBSMDk6
IA0KPiBmZmZmODg4NTBiOTZlMmJjIFsxMzUzOC4xMjY1NzBdIFIxMDogZmZmZjg4ODUwYjk2ZGU0
OCBSMTE6IA0KPiBmZmZmODg4NjQ0NWY2MGNhIFIxMjogMDAwMDAwMDAwMDAwMDUxMCBbMTM1Mzgu
MTMzNjkzXSBSMTM6IA0KPiAwMDAwMDAwMDAwMDAwNTEwIFIxNDogZmZmZjg4ODY0NDVmNjVkYSBS
MTU6IGZmZmY4ODg2OTAyZGRkOTAgDQo+IFsxMzUzOC4xNDA4MTldIEZTOsKgIDAwMDAwMDAwMDAw
MDAwMDAoMDAwMCkgR1M6ZmZmZjg4OTdkZmU4MDAwMCgwMDAwKSANCj4ga25sR1M6MDAwMDAwMDAw
MDAwMDAwMCBbMTM1MzguMTQ4OTA2XSBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDog
MDAwMDAwMDA4MDA1MDAzMyBbMTM1MzguMTU0NjUwXSBDUjI6IDAwMDA3ZjU0NzE2OWJlYjAgQ1Iz
OiAwMDAwMDAwMDAyMjBhMDAxIENSNDogMDAwMDAwMDAwMDc2MDZlMCBbMTM1MzguMTYxNzcyXSBE
UjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAw
MDAwMDAwMCBbMTM1MzguMTY4ODk2XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAw
MGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMCBbMTM1MzguMTc2MDIyXSBQS1JVOiA1NTU1
NTU1NCBbMTM1MzguMTc4NzI2XSBDYWxsIFRyYWNlOg0KPiBbMTM1MzguMTgxMTcxXcKgIF9jb3B5
X3RvX2l0ZXIrMHgzMGUvMHgzYjAgWzEzNTM4LjE4NDkyNV3CoCA/IA0KPiB3YWtlX3VwX2tsb2dk
LnBhcnQuMjQrMHgzMC8weDQwIFsxMzUzOC4xODkzNzJdwqAgDQo+IHNrYl9jb3B5X2RhdGFncmFt
X2l0ZXIrMHg3Yi8weDI2MCBbMTM1MzguMTkzODE1XcKgIA0KPiB0Y3BfcmVjdm1zZysweDIzOC8w
eGM4MCBbMTM1MzguMTk3Mzk1XcKgID8gDQo+IG52bWV0X3RjcF9pb193b3JrKzB4NDAwLzB4YTgw
IFtudm1ldF90Y3BdIFsxMzUzOC4yMDI3MDddwqAgPyANCj4gcmVsZWFzZV9zb2NrKzB4NDMvMHg5
MCBbMTM1MzguMjA2MzczXcKgID8gdGNwX3NlbmRwYWdlKzB4NDEvMHg1MCANCj4gWzEzNTM4LjIx
MDAzOF3CoCBpbmV0X3JlY3Ztc2crMHg1Yi8weGQwIFsxMzUzOC4yMTM1MjJdwqAgDQo+IG52bWV0
X3RjcF9pb193b3JrKzB4ZWEvMHhhODAgW252bWV0X3RjcF0gWzEzNTM4LjIxODU3MF3CoCANCj4g
cHJvY2Vzc19vbmVfd29yaysweDIwNi8weDQwMCBbMTM1MzguMjIyNTgwXcKgIHdvcmtlcl90aHJl
YWQrMHgyZC8weDNlMCANCj4gWzEzNTM4LjIyNjI0M13CoCA/IHByb2Nlc3Nfb25lX3dvcmsrMHg0
MDAvMHg0MDAgWzEzNTM4LjIzMDQyMV3CoCANCj4ga3RocmVhZCsweDExMi8weDEzMCBbMTM1Mzgu
MjMzNjQ3XcKgID8ga3RocmVhZF9iaW5kKzB4MjAvMHgyMCANCj4gWzEzNTM4LjIzNzMxMl3CoCBy
ZXRfZnJvbV9mb3JrKzB4MWYvMHg0MA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbnZtZSBtYWlsaW5nIGxpc3QNCj4gTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQ0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
