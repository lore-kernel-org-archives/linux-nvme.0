Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6654C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:15:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D63620738
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BXKwfb28";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="gnQLz1ph";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="SLmDizVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D63620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J8lh62z54h8HL1TelwFWsO3D/j7J0kcp00+Y8ltT8Y0=; b=BXKwfb28PLhyIRyRJCP+2lxfc
	vYC6OIx6BcQPXtwj9j1YOutblWdkwvdLPzGIubaQAuvd8bXJ1zRchMHU2Akhxjt2gn+/JT7Skz8mp
	i46Oxoh/iGK9ELWyZmP1wwSnwD+LTcvVNn81x5pzc9NA3JYx9kO2HVmXFyxumfaoQSJqThdFDfRSY
	0g/flX9uKEgmDHdLC5hUKIJecbwRPJLuwMEzw0spaZMGVcGeXZ05NdQdHmypL4nopTRtRtg1VWnw3
	EClpuOwvn04Ye7MW1niGtr0vQS2q99Itj+r9Nu0v7bDR5iZqEN0C4foE6sXcTBcpbADAK/Vj5BgJ9
	KnLny66JQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8IJv-0005s1-JW; Wed, 19 Aug 2020 07:15:39 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8IJs-0005ps-DM
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 07:15:37 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07J78Ehc011618; Wed, 19 Aug 2020 03:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=NjyM20/LTIlB9vi0CgwwO4dRSIvwxBmFyogMlO/V6vg=;
 b=gnQLz1phX6vhd+MQPlUd63QAredJLeYiJ+yqXyAYQlA6t0U/1/mxVZnUjQfB2dZZNmGY
 yK37kth6U3apiu86TvniVPomAMsV8GoWg1G09OsV/7z9yaHgnuOswjzSta/DVt2Mpl3Z
 F5fzd1kHKThF63wLHjeu1CeDbt40EjVUg6qqO8Bl1fvA1Gbl3cmk7YmAIXZp1T9RGMpi
 m1A6kvOGSijGxeghkKGSJLSZX0gciF5RbE8YaueOy1ADxUQcvDeNxxFr0/VuvTLlivF4
 Dfz/b9HLTFRLrKE4u/HkpFdsHJJIElLpApPWDJ/MnvAK6jlOf1ZglnUPkwpb2gJPd4aN iQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 330cxpkv09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 03:15:30 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07J77ZRh179638; Wed, 19 Aug 2020 03:15:30 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-00154901.pphosted.com with ESMTP id 330y2srff0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 03:15:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7pK0vRjW33DWR9lMKxNfrmLQO3fnzTJsNK3LqVntg2j/GrELS07tpS11AEjCsxfLUyJDfy8pXDgRUtBNQXHM7agXnu+PyIesDJWCZciloZxDyUiST2HT7UK0AcjkPHroWhfiz8YqqgC2LU1JWimJWTR3+njtb6SUKIymJQSXCMiYM4uw+S80c2W7aCy7nlLACs+P9wDn0HaSPpKU9COpQIgeF1DLwSWBsM1FRR1OqcMef4e0WVvoUu3eJmBycTX2PW1Oy7TCKJ7ORBDaMdorTdUi/xkN9vH72mAuZb899VeJ561VEORlwv6ECx2i/38FZOsxXXVc7o/5sJT7Mda9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjyM20/LTIlB9vi0CgwwO4dRSIvwxBmFyogMlO/V6vg=;
 b=Mz67BuR2TOlmHGj7QCWsOWeuQphuG6klFE6ewHs22Knm8D4Ncow2Ia5PbsCjOCIuEA3yF5BFbeDTDtFBrJR/BKGyl/nhuRgQMjJDUalnfkP2q8cuOtHMFtgu8yiJfyBXCKBkvH5vOCKYOjVw6m41P5w0KJgniOWi/EgVVPjSP/M4riiVubx1YVjPjRRoJf9DVLFDNDs5bD0EqLbotlbpz1DVqxIPULzKg4kmPyvunm/G/1TTFTvM9+jp/4ycWeECbqfmmQazIZOKHv3IHQCr+xwyLgDntUnPpb0RiTz4poiHuil1LMjKeROsehrpWJmJwGJn27QuzCG9pIxWEVjH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjyM20/LTIlB9vi0CgwwO4dRSIvwxBmFyogMlO/V6vg=;
 b=SLmDizVM30EXSvzW9rVKejCtTa+zNOgi68qhLFjvhzC7ljHQHuWD557DYOekbypm2GPZN4HZXXz4RxeF9nVcqFavYL76UdahxmVjBjG8o72GPuaXqumh9tqpsHbncvQ7+LWDDi6Zn2mL05C+Tz5e2gFonVzbnfXWoYit1wgNyEg=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB3023.namprd19.prod.outlook.com (2603:10b6:208:ea::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 07:15:28 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 07:15:28 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Topic: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Index: AQHWdSwQNt51xVzDuEiiv7DIlV0weqk+DpiAgABKkQCAAAEugIAAq7qA
Date: Wed, 19 Aug 2020 07:15:27 +0000
Message-ID: <MN2PR19MB3005426D1F885A534E601B17EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
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
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-19T07:15:24.3152805Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=18b4cc07-3ea2-4711-a2f4-4a4fd29e4bd7;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8976d17-ef49-484b-2571-08d8440fa688
x-ms-traffictypediagnostic: MN2PR19MB3023:
x-microsoft-antispam-prvs: <MN2PR19MB3023F74E5E933FA838D714E3EE5D0@MN2PR19MB3023.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+h5kjjjCstYWH4gBTS8FQbMr3kcxXZpaNOCs/ndy6PRvK115k/GB/dYLXDAsrMGRt2UGHrgZumvW1iFAmpgmr7p34obkD632ZRsUytMjMVdjn+vssP42DRt/ZCvSEUViMGuwu5jImgokJznHSXixwZMPXBH/zw9oBRtfUFerMPb4vFY7pnGZtJlPC2Wz34lDZEg3/BviXsBiIpPhI7ZEIKdPaIE1Q9yWe3PrH9yS6+hA21arEB15x83W1jPV5v6xE5E3+9oRWabjt+k2MJZEv8KmN+pwbdy+jmGL42EIhDRg7fVCRbIhEzOCGwhjR45OcRUUwP8xUKaMpo88IFlaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(9686003)(66476007)(64756008)(66556008)(6506007)(66446008)(83380400001)(5660300002)(53546011)(186003)(71200400001)(2906002)(8936002)(7696005)(26005)(8676002)(110136005)(86362001)(33656002)(76116006)(66946007)(52536014)(478600001)(316002)(55016002)(4326008)(786003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Kn4eOEHwyjfcGLtXdOb4AXHdE0GPysCAEiqLpV/lHVUxnM+4bnzgBDqKglc9Z1gy0MBM7Nr0ut/EV8hVRQQNyV3OIWngoL2Yvc74Vh+IUj63395IfXXswn/UNbYYZyf3Q3FgTjBUD1ItteAj1MKgyya+9DyAHKvyiDVSgDkP7vDE/KDG3GN0fqH9NHfyGsELHhVuTxjN4KRdAXRD9TNOI3H/+uc6eaOkarkV3x0sQ1Df0FVT0fSfEPr9lCaTDdic7WB+f8AqEXNwDGSAJvzEExt86uwANbWhxqQO1wnAzgCna/knyhJsr5Ku0Lb1QWwYoF2uIalSwM6HNFO04LxCChbWMO01gDRZX0rDQKY49VSiydrhQBWa2qQ06MH0/BjfCytYtMSlMbmLp7U1PRTterurHgBn1Hs2Yz8xOQ/snPAuSYCADaAXnCfjiO6Jz2jDf/siJOvm+Mp9ejLrKhHcLyw4QWEJpDffz0DfEgRTpsla+ARRHzkTpUcSS9ZnjZaO5g5KH3cy9nYHe2kSANBXYpWlWjVxKeHqmk9L55uYQH5Eot4rz/ryKTIxjZAJ7WWlTxAbaIfg36bB74kaRftaNQOqu4ptQWx5s58I8T/OYgVXt8iKKs0QxYo2IaJj0ya+BBYd0MfExw0ublfMn+01Cw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8976d17-ef49-484b-2571-08d8440fa688
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 07:15:28.1384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFRVGjBAoLvOTyltE3zAU+1ILwo+cBMPZ4BOapqmhhQxnL+cDUN88TKe0hW7S1MD78k7dqQgZhHDCA9T8FtYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3023
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_04:2020-08-18,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=549 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190060
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=665 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_031536_707473_965F384C 
X-CRM114-Status: GOOD (  21.63  )
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

SSB3aWxsIHNlbmQgYW4gZXF1aXZhbGVudCBwYXRjaCBmb3IgbnZtZXQNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IA0K
U2VudDogVHVlc2RheSwgQXVndXN0IDE4LCAyMDIwIDExOjU5IFBNDQpUbzogQ2hyaXN0b3BoIEhl
bGx3aWc7IEVuZ2VsLCBBbWl0DQpDYzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBudm1ldDogU2V0IGN0cmwtPmthdG8gdG8gYSBkZWZhdWx0IE5W
TUVUX0RJU0NfS0FUTyB2YWx1ZQ0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCg0KPj4+IFdlIHdh
bnQgdG8gYXZvaWQgc3RhcnRpbmcgdGhlIGtlZXAtYWxpdmUgdGltZXIgd2l0aCBhIHplcm8gdGlt
ZW91dCANCj4+PiB2YWx1ZQ0KPj4NCj4+IFNvIGxvb2tpbmcgYXQgdGhlIHNwZWM6DQo+Pg0KPj4g
IlRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSB0aW1lb3V0IHZhbHVlIGZvciB0aGUgS2VlcCBBbGl2
ZSBmZWF0dXJlIGluIA0KPj4gbWlsbGlzZWNvbmRzLiBUaGUgY29udHJvbGxlciByb3VuZHMgdXAg
dGhlIHZhbHVlIHNwZWNpZmllZCB0byB0aGUgDQo+PiBncmFudWxhcml0eSBpbmRpY2F0ZWQgaW4g
dGhlIEtBUyBmaWVsZCBpbiB0aGUgSWRlbnRpZnkgQ29udHJvbGxlciANCj4+IGRhdGEgc3RydWN0
dXJlLiBJZiBjbGVhcmVkIHRvIDBoLCB0aGVuIHRoZSBLZWVwIEFsaXZlIFRpbWVyIGlzIA0KPj4g
ZGlzYWJsZWQuIg0KPj4NCj4+IHdlIHNob3VsZCBub3QganVzdCBzZXQgYSByYW5kb20gaGlnaCB0
aW1lb3V0IGJ1dCBqdXN0IGRpc2FibGUgdGhlIA0KPj4ga2VlcCBhbGl2ZSBlbnRpcmVseS4NCj4g
DQo+IEl0IGlzIGFscmVhZHkgZGlzYWJsZWQsIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcGF0
Y2g6DQo+IA0KPiAtLQ0KPiBzdGF0aWMgdm9pZCBudm1lX3N0YXJ0X2tlZXBfYWxpdmUoc3RydWN0
IG52bWVfY3RybCAqY3RybCkgew0KPiAgwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KGN0cmwt
PmthdG8gPT0gMCkpDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0K
PiANCj4gIMKgwqDCoMKgwqDCoMKgIHF1ZXVlX2RlbGF5ZWRfd29yayhudm1lX3dxLCAmY3RybC0+
a2Ffd29yaywgY3RybC0+a2F0byAqIEhaKTsgDQo+IH0NCj4gLS0NCg0KSnVzdCBub3RpY2VkIGl0
cyBudm1ldC4NCg0KV2UgbmVlZCBhbiBlcXVpdmFsZW50IHBhdGNoIGZvciBudm1ldCwgdGhhdCdz
IGFsbA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
