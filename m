Return-Path: <SRS0=VvGj=GU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E78AC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Jan 2021 09:47:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76A7229EF
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Jan 2021 09:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76A7229EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVOslVPK9AWXMylAfIjO/c0FwNgSNC6i0auQRjS4DR0=; b=eGR8tacyPKlDZLqQ70OynG9hE2
	PSc0KRYm8dLkNctqnVeRqP9yTCt5WbK/DHNCBIv0q9qNFjx4wPxMPZ5iWnSBbLkEwjqVRD0AyviMX
	wlKZYhd7bWSrRuqAGkRXYwT0wGC43kDeAUkLEWy1VpWBmr9R6k5vjUgEcRXvhLUNc+IwxkfwktNj4
	ehD2zmaDMtw7AkKnSDOMjteUvT1QRufAheoPuY7IUxrNj4+Pzjd7hzvgcoOovrokCjUC0ZpudsFD2
	Tau6K1T6AK+R/bGTCTPuHR69uf4Pi/76IsMFgOb2Rs6dbANV5xuzcqB0QdrqK0RfHwUvFDyBjBFyZ
	74b1X2ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l14eL-000479-Qj; Sun, 17 Jan 2021 09:47:09 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l14eJ-00046V-1d
 for linux-nvme@lists.infradead.org; Sun, 17 Jan 2021 09:47:08 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10H9gIOR001626; Sun, 17 Jan 2021 04:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=sO3E0K1P2DtaXw2JFzn+kNIBER96toNGdGw/jiqqVBg=;
 b=fkgSraLQi1xl48KAft+vrq3c6FqKWs/q5NLdKIgU8rtpxvlNGHvri+v9Z9QtPnPepn1Z
 NFqt9H2EgsXSExPevik9rKyJiJZmQQB8KtfP5URktOWm6+FS4qrw+qOpjo8nev1rc1Y6
 ue3mJF4t/T52NCn4EdmPCw3TYUqH5Y0sergkgPzdKrU8NNPn6bfqZ7bRsTt4WtJT0awo
 h+rkRNMvD6gSLcKR+6zb+7w6wh4jE1O2QIv5XeQxvUH716wrKUyeRu8fhkCjoV/PKmLj
 6dcVWO8VxtXDw7qfieDJ2/10Y+dgecZkIjzP9unuOsnIMJ/DDDLInzJcJ+JWxTm1GfgN Gw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 363vv11f54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 17 Jan 2021 04:46:58 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10H9fghh185937; Sun, 17 Jan 2021 04:46:57 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0a-00154901.pphosted.com with ESMTP id 364e181ssh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Jan 2021 04:46:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQW4++BHD1yNUWHmblOAHulVMb8TJk0al3MYQfR45NvnIBQukXqLdphBReGYQf2NGKWIdJqpPdLL0U/WdD1mwTaxEPzTQ90wonxrDKrvHQP8EvoEKvHiPd0Cm9esErnYHDHjJLOVTYz/1qhvqRDLPZYfoCQGVdkYcQ6HYyansCaXfjeuyLIVVX7cRkdEOK3hyRZYOMgn8xEcuvIPBAfzJTm09B6beRybZ7RnLiNVbFuR8pRjoQfqUIDUdR5A87tImuGE8F2LNYfCKegfSXuza+2gl4J1gEpJuq+1JWxooadDG35T/0jSZLVu9xGqD8IaD7NeZ/3C/voaJROS6h1Q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO3E0K1P2DtaXw2JFzn+kNIBER96toNGdGw/jiqqVBg=;
 b=jR97a+HeALi/ybDaXJDalCV7zf+DCZCsimMwXnX4M/6ojlvvyDrzXByu6DT45SDiHj5pTjoM5raT7ko0+twDcRnQtrs9NIOB4yGGglbMeWgNj9U+w2TqauK20h064xGDfRiOsYl7wDCLfCA5kdVozdenR8aB7HDhGL8nzruLg/QBZfK7PoOcc5BRFj2/Lukiy1C6mL3chRffoON1bSoXJA3h3kJR37AbazvXBbdAt9Le4fYtgjRHdy064CCQHP5eX7AhlAMGAV6QP4Q4GAmX/r9KrdVYvpAulzcco32/3B3jtHZH7SEKHAJaCEHkDcQRKjKiMzS7qg5XJ9LYCEG8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO3E0K1P2DtaXw2JFzn+kNIBER96toNGdGw/jiqqVBg=;
 b=kUO7IRRU/Mk+L/K8SGhokpm6tt+WIE8NLZyqDUGfKiPIHCVmOF0evkGbTAQK2CpLE091pcRuVQNXAq9eyOcYPg3wjMb+eYmklFeJ7FDNSNiCcsYjZRCnxd8Ay1r6P6UqMTGK3rLbZIX1BXHItDuvYv+HqlytRh4/0SP7oW+j3fc=
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB4091.namprd19.prod.outlook.com (2603:10b6:5:229::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Sun, 17 Jan
 2021 09:46:55 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3763.014; Sun, 17 Jan 2021
 09:46:55 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KomKNIAgADakqCAAJ7gAIAABJXggAHRIICAAh/SYA==
Date: Sun, 17 Jan 2021 09:46:55 +0000
Message-ID: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
 <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
 <f5b8dbc2-7960-894e-47ea-b18665536e70@grimberg.me>
 <DM6PR19MB4011A4116FAB37BEC28BBC91EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
 <6459e22f-f2f2-9183-0862-654bcc5e90eb@grimberg.me>
In-Reply-To: <6459e22f-f2f2-9183-0862-654bcc5e90eb@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-17T09:46:51.9559312Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=58469963-4dc2-4484-bb01-6ef8e94a7820;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0356b099-49b2-4d1e-41f0-08d8baccd393
x-ms-traffictypediagnostic: DM6PR19MB4091:
x-microsoft-antispam-prvs: <DM6PR19MB4091A2DD8E7F7731AFA22BCCEFA50@DM6PR19MB4091.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: groooLc4eHXKtY+rsqWgYSelWEDndpY4LLc63ovJUBVQtw06RAyqz50+uH9PgDRMBTAGB1EwHfb286gfif3fF+I6GA6fuiDlw2bl5C6Mo9h4MdyTN8oCQqhTVr1s5EWpL4F5A/x2MvMLdznthS0OM22iSHuHajGZS15rVVm9KZ2uKFMuQbxlU/OlFQqMhG/j+X6YIUsWjeSdpJcPgNmB2zO/H2QIEScKfkHrF5zq4rEP+1mc340CpDdfPoZV2xri9CWnkG/ilniklqQt+LuMJ0o3JhA7bq3mWGlpiRaJtI0BDujjozHA1xEo9n7zRgKt6LHdbgaoLYR68PUvLdGdJsu2bz2kTMI1EIpFSsrh8Evf7yipj5VSSw2RAzA/qEM7/dcg3PxNxlHitc4uF3r4W3J1Vk4j7L8vm4iT2f3eVeBrdtpEeg6G8AmX+Zzup/qzZxtvLoqeQqV54wkwPNaeHiE/5pSAwQjBn/hJvtBXSskzZbqTqhzLJmw5esjk8oyofIKxVdVIAJx+ogIh4FY/MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(316002)(110136005)(53546011)(786003)(8676002)(76116006)(478600001)(186003)(6506007)(64756008)(66556008)(66446008)(86362001)(66946007)(66476007)(26005)(55016002)(8936002)(9686003)(83380400001)(71200400001)(52536014)(5660300002)(7696005)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RTJnQnpPQkVLc2Zzci9hZ2pKT1l4d2l2akdqVUhJVWdTUHY5ZlZaaWNnMTZp?=
 =?utf-8?B?L3lsOW5zc2xoQ3VTVUlybWFvdmh2RlM0Z2cwbUN4VHpwVnBleDA0RUtrMnJ2?=
 =?utf-8?B?QWlDNy9sZWEyWFpmcHJndTR6bWZuTng0YnRDL1MyVXF2d0dGdFN4TGk1QW1I?=
 =?utf-8?B?VGFNTHU5VjVQb2lXK1FvaDFhOGxNaTdMZGNCaUhHT3ZrOTNmMEl4NjVuVXhL?=
 =?utf-8?B?ZDZlbkhEY0c0TDcrRk5DT3RIbG5tQlM2ek1CZ0tnTytoOGduM3hBK0Y5UFVS?=
 =?utf-8?B?VjY0OFNZMEx1RGlRUHRDYU9QbnVhdTdrV25RT3JMMjh5QTk4QlowU1FHVjZ6?=
 =?utf-8?B?SjJvT3A0M0psamlFcnVGbkpnK3lrcXEyazVveUgzOEpqWUtMMjRDbmVxdytH?=
 =?utf-8?B?VUxVbGtBUVZUMjN0TnEraDB2Q09oWFdBSVIvWnEyRkFLb3gyRkMxc2dlcU91?=
 =?utf-8?B?WWkrWWJWQnJKT2UrTGU1YjNhQy8yZHZrbGZHRklsSkZRV0dCZTFWSG9Pbkl1?=
 =?utf-8?B?N1hvWkRuZ2lnY1VBaE9lN0JUVjEwanNxdlg3K1UwYnpjTmNlTnlkZk9NV0dq?=
 =?utf-8?B?ZTdTRUREZmczeEtneTRYbEFuN0VFVEVZVEVlYWtvb1hxUU4vUFAwMSt1Rmk2?=
 =?utf-8?B?dUNTbGVFSUc1d1h1cWxJSEdaQlNUU3A5QjBuaEtYam5RbnZERktadWVOb3J2?=
 =?utf-8?B?VldaWkgwZHVueDl0c1MrM3VVbk8rSWs2UjlUcy9SYm13dGV1RGJGZ29yQWZy?=
 =?utf-8?B?Y1FDTWJOOGZzbUZ4cVo2aHRoR3d1ZW05c2huM1IxTmxnMTVzNDlrVjJ2MFQ4?=
 =?utf-8?B?L05aY2dSUndSWE9NTG5Pdm9Ca3BtcHErZ3lJMHVsTmd0SnBvOXAxeFVOYmR5?=
 =?utf-8?B?cGkxeFNMT2ZFRjVtRzdFeU5sWVlwU04rWEJPMXpneWRMaVBjN3FtWStrWGlu?=
 =?utf-8?B?RCtBSlFqODN0aXlNY1JEbi9NRzBJM2hHY09ocTN6TVllTHQ1QVZzU2FtWUlJ?=
 =?utf-8?B?N2lZdlJ1UGZieEZlSTlNcTFRR212U25pMTNuS3Y1bWRkL28yZnptanM2L09Z?=
 =?utf-8?B?cEhFWGhra0hmcFRqbDZGb25rRjlranZHN0wvSXRRUmlSRitPUDNaK0VCdlpM?=
 =?utf-8?B?K1QwM1VwV0p3RXdGS0x5TTNOcDdwbnNnZ1hWYWhBcGNKK3E1VGdCSHN3cFJQ?=
 =?utf-8?B?Sld2ZGN2cVhHeWt5R0E4NXJxdnRhek82NXRUelJyWk9YamxaUUR1OGk5LzZ3?=
 =?utf-8?B?VG0rYWtVaSs0bWRNaVdWellqQzAxSVV6dzg1SlNLUkFwV3NCb1dxRi9VaGo5?=
 =?utf-8?Q?f+Ys10NB6U/HE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0356b099-49b2-4d1e-41f0-08d8baccd393
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2021 09:46:55.7846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IgRej1qyL3I6alrTWwrjXclLjZG2xLc1jYVVgZJ0tB+n5GkUfaNG5aNpsuQXGV2pcHYzGXPcwXkwEEuSJrr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4091
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-17_03:2021-01-15,
 2021-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101170060
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101170060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210117_044707_321132_054E0A4A 
X-CRM114-Status: GOOD (  12.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Yes, it was reproduced with the validity check of resv1 field of connect command.

Jan 17 09:43:36 FNM00183301763-A kernel: nvmet_tcp: failed cmd 000000006fe9c801 id 0 opcode 127, data_len: 1024                                                                                                                                          
Jan 17 09:43:36 FNM00183301763-A kernel: general protection fault: 0000 [#1] SMP NOPTI                                                                                                                                                                   
Jan 17 09:43:36 FNM00183301763-A kernel: CPU: 10 PID: 615 Comm: kworker/10:1H Kdump: loaded Tainted: P           OE     4.19.158-coreos-r9999.188fe4a1ba192d57eaaa3462db70e1d9 #1                                                                        
Jan 17 09:43:36 FNM00183301763-A kernel: Hardware name: EMC 900-532-002/110-551-910C-01, BIOS 20.12 11/12/2020                                                                                                                                           
Jan 17 09:43:36 FNM00183301763-A kernel: Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]                                                                                                                                                           
Jan 17 09:43:36 FNM00183301763-A kernel: RIP: 0010:memcpy_erms+0x6/0x10                                                                                                                                                                                  
Jan 17 09:43:36 FNM00183301763-A kernel: Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe         
Jan 17 09:43:36 FNM00183301763-A kernel: RSP: 0018:ffffc90007bc3c70 EFLAGS: 00010206
Jan 17 09:43:36 FNM00183301763-A kernel: RAX: 34e40d75735a3225 RBX: 0000000000000400 RCX: 0000000000000400
Jan 17 09:43:36 FNM00183301763-A kernel: RDX: 0000000000000400 RSI: ffff8887f03368ca RDI: 34e40d75735a3225
Jan 17 09:43:36 FNM00183301763-A kernel: RBP: ffff88884ead9d60 R08: ffff8888b53e0530 R09: ffff889789776b4c
Jan 17 09:43:36 FNM00183301763-A kernel: R10: ffff8897897766c8 R11: ffff8887f03368ca R12: 0000000000000400
Jan 17 09:43:36 FNM00183301763-A kernel: R13: 0000000000000400 R14: ffff8887f0336cca R15: 0000000000000000
Jan 17 09:43:36 FNM00183301763-A kernel: FS:  0000000000000000(0000) GS:ffff8897dfe80000(0000) knlGS:0000000000000000
Jan 17 09:43:36 FNM00183301763-A kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 09:43:36 FNM00183301763-A kernel: CR2: 00007f592924d890 CR3: 000000000220a002 CR4: 00000000007606e0
Jan 17 09:43:36 FNM00183301763-A kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jan 17 09:43:36 FNM00183301763-A kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jan 17 09:43:36 FNM00183301763-A kernel: PKRU: 55555554
Jan 17 09:43:36 FNM00183301763-A kernel: Call Trace:
Jan 17 09:43:36 FNM00183301763-A kernel:  _copy_to_iter+0x333/0x3d0
Jan 17 09:43:36 FNM00183301763-A kernel:  ? tcp_write_xmit+0x403/0xfe0
Jan 17 09:43:36 FNM00183301763-A kernel:  skb_copy_datagram_iter+0x7b/0x260
Jan 17 09:43:36 FNM00183301763-A kernel:  tcp_recvmsg+0x238/0xc90
Jan 17 09:43:36 FNM00183301763-A kernel:  ? tcp_sendpage_locked+0x44/0x60
Jan 17 09:43:36 FNM00183301763-A kernel:  ? __local_bh_enable_ip+0x60/0x70
Jan 17 09:43:36 FNM00183301763-A kernel:  ? tcp_sendpage+0x41/0x50
Jan 17 09:43:36 FNM00183301763-A kernel:  inet_recvmsg+0x5b/0xd0
Jan 17 09:43:36 FNM00183301763-A kernel:  nvmet_tcp_io_work+0x116/0xb40 [nvmet_tcp]
Jan 17 09:43:36 FNM00183301763-A kernel:  process_one_work+0x206/0x400
Jan 17 09:43:36 FNM00183301763-A kernel:  worker_thread+0x2d/0x3e0
Jan 17 09:43:36 FNM00183301763-A kernel:  ? process_one_work+0x400/0x400
Jan 17 09:43:36 FNM00183301763-A kernel:  kthread+0x112/0x130
Jan 17 09:43:36 FNM00183301763-A kernel:  ? kthread_bind+0x20/0x20
Jan 17 09:43:36 FNM00183301763-A kernel:  ret_from_fork+0x1f/0x40


-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, 16 January 2021 3:19
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 


>> This was a silly typo, did you check if it addressed your issue when you applied the needed change?
> 
> Yes. We applied the needed change before testing your patch, but still had kernel panic on recv flow when we had unread inline data on the socket.


Can you share the stack trace?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
