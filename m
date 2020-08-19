Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5607CC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 14:29:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AA32076E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUwjJbml";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="w4mUh/Q1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="qeCh6Ka5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AA32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xzE4yZVaLP4b7w7CMcaenlFusDwsGjhvCI9Cof7OB4c=; b=dUwjJbmlMhlRlvGihkjA1ijfi
	Ec3AnGtEN+Lni/SwFBMH6KRdWPnDHFXHlVnaKytVR2/BBFbOlaVWVJyZb0DwqheEJSdjIuUOOjTaD
	EbUzsStyfyjo/EEhwBN/7ueFb21UcXM5qv8A/0fxq835YJqmzENbcIfWZq2hQKDJvKDFBU8ylTDWr
	Tfl8G2ydS243SjWDd4jfZqfo/oo5BFPhaiGFdyF9XcvaVBoMH7Cyayop6AwfzCH0Mm0e68F7UKzH5
	GyBejKlk9qOjED+lnJbR/AySOvDmvwFaZhKgh7lI0bTwaZSuDWnv78fDjrT7iDroUglegM8euZXgb
	xfonzvV7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8P5o-0005av-2B; Wed, 19 Aug 2020 14:29:32 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8P5k-0005Zz-GB
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 14:29:30 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JEPZJR010841; Wed, 19 Aug 2020 10:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lKblCb5igPQjaEi8Nh+lUO8YQ48FEE3F+voyBS8vIEI=;
 b=w4mUh/Q1txu6XksrXG+syT66AYesJcbF17lH3ynWJBFsW40nt+2AM1kIU1ieYvhFBT0L
 k3XtolEjg8zFkN5Fxmx/0ogmKhYgryAgqnu1tORRh9HV8iB+p0JuzdUI2XVvVMC3ATBa
 8uv4KwsWXNeyQQktq3FCV/nZudJYi6gezkzmLCEQ9suf3qJLmVFV+EQHDx6XUFEaSNQa
 /l3Lo5/TFWuxkZCWbQREOAiNMOvKqya4iE96z3n9p5wH6RB4NT2vp7a3th3+toDYUOaj
 NeV11n+x7sDExat14nYoXeAgA6dAyFINNl7XymaMsxrHxTDGM3NAr2y+u7eUx3gtLqAz ww== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 3304hexqfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 10:29:22 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JEODnE167002; Wed, 19 Aug 2020 10:29:22 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-00154901.pphosted.com with ESMTP id 33131nb1x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 10:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COiQTF29xs/omDTdoq8e+4xW9EA+wrEBnmXPIQob8Al5mNbG9S0QGEKjXKg3OYBdBH4Qx410NryR+3TBBZ6kf5ybdanHTIGUiXlRSxxT1BqGvBUI9gBYvQz4cFXQ2fwfrV0AtN5drkhnWX/tBuBs8GCxYRIwo3bvdJb0g77antbGZdp4mSjTE6WW71gaVf21bC+2Z9gZErEqnCGW+uFZ/p57qet07XteCKRsaXNw2GoN/EBxgXtECf5WsqSMf74BVIKL2BOoDnO3GDXoKRIXtt1HKDN2WHtKFpT1N7EKCowHzzGBQrTdV+HQDjpqoH5okI7m5JftHNYwX9eI8ypSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKblCb5igPQjaEi8Nh+lUO8YQ48FEE3F+voyBS8vIEI=;
 b=OpX3Bs5co+rSWdJk50XwJI6VKv3obkgRNvLEIXTNUF8Hqs9f5qeq0BsEsxHIxRqRrOur8FCH00bkSAn2czyPYn3ll1ta5RprG4ReCEIJ6Krmm3jdDYbcIJgtJv6aTqC5FPmp67KkHdg+D5wzpFcyfc4wz1PEcOWdScXTbdJ43V+fXWVjK20/jxlHveOfYd1jA4pde8GJ8nQFRLJMVo/FiuayXLNJeIFTXzQLL7FQhYnxyjqr93JD5CZ2RnouMICmnPJw5nas+W5rC4H+MRV3iWKrEc1t6sysQNXFjLKSqH3FWC91zUwgM8EXZG7TVdKq+EEOAplsWDXvDF8UtNDGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKblCb5igPQjaEi8Nh+lUO8YQ48FEE3F+voyBS8vIEI=;
 b=qeCh6Ka5xe+MfXxGTt4mC0kDRJKBw8xUl2KUd2/ISIOGR7VQNgjr5hkIihMnFIA396qezsYh176tdHU/97hb3OjH1fy4HQn3qVkAPrcMDuGQv2LnnB8L4R6PMWmN+bG3zG0UuyJcPYFzCh/4FwqDrv9NlxkKhyT5a7nvATnS0ok=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB2799.namprd19.prod.outlook.com (2603:10b6:208:f6::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 14:29:19 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 14:29:18 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Topic: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Index: AQHWdSwQNt51xVzDuEiiv7DIlV0weqk+DpiAgABKkQCAAAEugIABJRfw
Date: Wed, 19 Aug 2020 14:29:18 +0000
Message-ID: <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
In-Reply-To: <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-19T14:29:15.9666344Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=164b38c5-b849-4221-970e-8dbf14b29b0b;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2979f3f-38af-45da-a9d5-08d8444c41e3
x-ms-traffictypediagnostic: MN2PR19MB2799:
x-microsoft-antispam-prvs: <MN2PR19MB2799C09A19D6CEF380A67477EE5D0@MN2PR19MB2799.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KU5VxhAMJWAk4LFYe8Gl/UoH+L2hbaxrFhniC0+qPFXxEy77pPkHHwuj7ZtX/4eMk32tZszunan9iwdH/sLodlY+KpiG+/MafWeU83rh9SEjLHYHe2FEtff/SXvwTOUr1IQ1AkRSXDBcobvbjOZtwxF+jiCITL4AP1TIRtlDGbA6o3K6jDp+BCkhIcqLDikWHFb9MZzPAZpIvi8LV/+ZYIlGcFznfyZRlD/K54nTcbgMCoB9gmCZyxhZfiyV/PLcmAYxAU0R0PZfFimlSa3w/aIJ2AjBO6jVlGLQU1OIDnn/0s5/LWffkwRVh0P1ukrWzBVEmIKTgrOCcduwdgUJYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(396003)(376002)(366004)(39860400002)(4326008)(83380400001)(66556008)(66946007)(64756008)(66476007)(66446008)(8676002)(9686003)(33656002)(76116006)(8936002)(55016002)(5660300002)(53546011)(71200400001)(186003)(478600001)(316002)(786003)(110136005)(26005)(86362001)(2906002)(52536014)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G1TePNjY36LkqiWHo9Tk8zArHu6tGFVXX/yGoe+9vLkfMnGF2w67th09TcP4weEAW+9muUlurNbQcbcjoU71+ucrBhkM2/J28Rz+ZzhGVxctqfQLaEH2JwearYV5k9LncmwxfheLoWPuX++SJWR0G78usawixOPzzaf8ntBEOJqTvldxFeqZ6zxNtePkI2hjBdetIhnAmSwwiyzB6EX0X0KzaIKzfagXTzZd8PrawOEIyHCEdCcpc6ogLMpjuDYXHlPtjl3fYM5ysPTI/s4o6QEYo551z2lQeVzzbR7nFVezG+iG/fXOLghT9tt5NHgmMPvMocuYYR4tu4KGgT65MpwM6oTfDsaReysVzixKYrdPxv+KZwd+nnWvmbnqk48YN9LCfSnKP8ea256TMWMEnbPbGYP4ix+s2PuQsPHgBp9kNueMB1x9RqC4seoYnMb4ibCgd6pNOceA49gs3Gc0r9csA1ui4R6DVmHlnfLUc1NcxxMBL+exRGqqqTzGvAqqwF6TsrimYAownP/KYnV6I7o36lOuaupP3m1rOwIf9XwhXhfUJj2KxoHoXrhToX7IDyrDExcvgo38IRKRL8OI1X6ZxqoaELx5t3U4iT6BMP3yEWuNYH4C+UgS9xWMzl7+MBzNlrbcfl76yYcrljETdQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2979f3f-38af-45da-a9d5-08d8444c41e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 14:29:18.5558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTQqWvIZUKcd2CtMAULReZ/jEWbgSIHgyykevnrBha9W15PkT1uLBfMxOuurnXDTVxNJIKyH3fYQ45OIZMl7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2799
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_07:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=763 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190127
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=873
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_102928_782424_A2A76566 
X-CRM114-Status: GOOD (  24.29  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QWN0dWFsbHkgdGhlIHNwZWMgc2F5cyB0aGF0IE5WTUUvVENQIHJlcXVpcmVzIGtlZXAgYWxpdmUg
c28gaXQgc2hvdWxkbuKAmXQgYmUgMC4NCk1heWJlIHdlIGRvIG5lZWQgdG8gc2V0IGEgZGVmYXVs
dCB2YWx1ZSBpbiBjYXNlIG9mIHplcm8ga2F0byB2YWx1ZSA/DQpOVk1lLW9GIDEuMToNCjcuNC44
IEtlZXAgQWxpdmUgDQpUaGUgTlZNZS9UQ1AgVHJhbnNwb3J0IHJlcXVpcmVzIHRoZSB1c2Ugb2Yg
dGhlIEtlZXAgQWxpdmUgZmVhdHVyZSAocmVmZXIgdG8gc2VjdGlvbiA3LjEyIGluIHRoZSBOVk1l
IGJhc2Ugc3BlY2lmaWNhdGlvbikuIFRoZSBOVk1lL1RDUCBUcmFuc3BvcnQgZG9lcyBub3QgaW1w
b3NlIGFueSBsaW1pdGF0aW9ucyBvbiB0aGUgbWluaW11bSBhbmQgbWF4aW11bSBLZWVwIEFsaXZl
IFRpbWVvdXQgdmFsdWUuIFRoZSBtaW5pbXVtIHNob3VsZCBiZSBzZXQgbGFyZ2UgZW5vdWdoIHRv
IGFjY291bnQgZm9yIGFueSB0cmFuc2llbnQgZmFicmljIGludGVyY29ubmVjdCBmYWlsdXJlcyBi
ZXR3ZWVuIHRoZSBob3N0IGFuZCBjb250cm9sbGVyLiANClRDUCBsZXZlbCBLZWVwIEFsaXZlIGZ1
bmN0aW9uYWxpdHkgaXMgbm90IHByb2hpYml0ZWQgYnV0IGl0IGlzIHJlY29tbWVuZGVkIHRoYXQg
VENQIGxldmVsIEtlZXAgQWxpdmUgdGltZW91dCBpcyBzZXQgdG8gYSBoaWdoZXIgdmFsdWUgdGhh
biB0aGUgTlZNZSBLZWVwIEFsaXZlIFRpbWVvdXQgdG8gYXZvaWQgY29uZmxpY3RpbmcgcG9saWNp
ZXMuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdpIEdyaW1iZXJnIDxz
YWdpQGdyaW1iZXJnLm1lPiANClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxOCwgMjAyMCAxMTo1OSBQ
TQ0KVG86IENocmlzdG9waCBIZWxsd2lnOyBFbmdlbCwgQW1pdA0KQ2M6IGxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZXQ6IFNldCBjdHJsLT5r
YXRvIHRvIGEgZGVmYXVsdCBOVk1FVF9ESVNDX0tBVE8gdmFsdWUNCg0KDQpbRVhURVJOQUwgRU1B
SUxdIA0KDQoNCj4+PiBXZSB3YW50IHRvIGF2b2lkIHN0YXJ0aW5nIHRoZSBrZWVwLWFsaXZlIHRp
bWVyIHdpdGggYSB6ZXJvIHRpbWVvdXQgDQo+Pj4gdmFsdWUNCj4+DQo+PiBTbyBsb29raW5nIGF0
IHRoZSBzcGVjOg0KPj4NCj4+ICJUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgdGltZW91dCB2YWx1
ZSBmb3IgdGhlIEtlZXAgQWxpdmUgZmVhdHVyZSBpbiANCj4+IG1pbGxpc2Vjb25kcy4gVGhlIGNv
bnRyb2xsZXIgcm91bmRzIHVwIHRoZSB2YWx1ZSBzcGVjaWZpZWQgdG8gdGhlIA0KPj4gZ3JhbnVs
YXJpdHkgaW5kaWNhdGVkIGluIHRoZSBLQVMgZmllbGQgaW4gdGhlIElkZW50aWZ5IENvbnRyb2xs
ZXIgDQo+PiBkYXRhIHN0cnVjdHVyZS4gSWYgY2xlYXJlZCB0byAwaCwgdGhlbiB0aGUgS2VlcCBB
bGl2ZSBUaW1lciBpcyANCj4+IGRpc2FibGVkLiINCj4+DQo+PiB3ZSBzaG91bGQgbm90IGp1c3Qg
c2V0IGEgcmFuZG9tIGhpZ2ggdGltZW91dCBidXQganVzdCBkaXNhYmxlIHRoZSANCj4+IGtlZXAg
YWxpdmUgZW50aXJlbHkuDQo+IA0KPiBJdCBpcyBhbHJlYWR5IGRpc2FibGVkLCBub3Qgc3VyZSBJ
IHVuZGVyc3RhbmQgdGhlIHBhdGNoOg0KPiANCj4gLS0NCj4gc3RhdGljIHZvaWQgbnZtZV9zdGFy
dF9rZWVwX2FsaXZlKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpIHsNCj4gIMKgwqDCoMKgwqDCoMKg
IGlmICh1bmxpa2VseShjdHJsLT5rYXRvID09IDApKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4gDQo+ICDCoMKgwqDCoMKgwqDCoCBxdWV1ZV9kZWxheWVkX3dv
cmsobnZtZV93cSwgJmN0cmwtPmthX3dvcmssIGN0cmwtPmthdG8gKiBIWik7IA0KPiB9DQo+IC0t
DQoNCkp1c3Qgbm90aWNlZCBpdHMgbnZtZXQuDQoNCldlIG5lZWQgYW4gZXF1aXZhbGVudCBwYXRj
aCBmb3IgbnZtZXQsIHRoYXQncyBhbGwNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
