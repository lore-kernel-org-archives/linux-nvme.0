Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E60C47080
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:52:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D17F61042
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D17F61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TZ9Mzh8d9ad/94Br8dOUCmm69x+5KmsZT4GkXIjrQSI=; b=y3GrXO+4424F4Z
	NqyqjL/xe3jI1dIqS0TEZkvnd09TujiEKAHoOkniMx4JuXJasmC9aGB9pnNY4Ylzt/YRYkH+A7NGP
	TYsHM881ZKd206+XOI58oBCfrW+ftSna4Dm3PMA67U0bMlP9YIXDaQzAxhZbPVM7tMRQco4TYSVK1
	FABIt9caexzeFI707Gy7BTX1isYN8wEAmtqocB3oQKluvXzyVNjHqru8puClWYXxPShYGKjqMnGM1
	F5Y015A4YU1nkr0cVVblZZffxl7jbS8k8jQQ2F1M5H9bDn8MHd4fYtNYWjoNUDai6vfrHw2lEaf3z
	kcP6I+KEnjPA5H/YgLVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo8Yn-000A69-4o; Tue, 01 Jun 2021 17:52:13 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo8YW-000A0E-7I
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:51:58 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 151Hh67H005733; Tue, 1 Jun 2021 13:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=hdiCW8afwJ9fHVx+uRcP8K5XV3XtQ8bqH+KfThWjj/o=;
 b=VkoXvpW0wTX0iTWHfdQKpVfQplm+V4KERA+osCTiUmlM2BHAs0TMhNEi1dQLou4Rtv/T
 UQUfKpFSJxcLicVvZWkKRdw06JDZfa3/3AolfAzo6y++DjcwCihWv5M0i+aCexdDQlaE
 Nhy9L1Bt4hsdWtS43w8wFtllUGIhvIQRnIPiflTP1T/oQraYHXvQHqSo4sG3+usnYxm1
 nn6PVTbZcFBTIGYbNuSHophaiFpA/sDJaoaFlEeugtbNiiyD55ISqJUFJ2rcVUI3Umg+
 s04hmZLsNBnUZAMVn2/rB+KnLCs5Onzlzoc4duP0VQCPZyCzVv+Pck1E9DB2gvh8PBaG nQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 38vv6j6430-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Jun 2021 13:51:52 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 151HojQn120947; Tue, 1 Jun 2021 13:51:51 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-00154901.pphosted.com with ESMTP id 38wdby3nva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jun 2021 13:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbk4GjZvUF2zazYuqsL2MYh1pO0t8wrcc/9sJdm4zRiKB8gufcZD2C4pavW/weNa8JMgtttes+eANb+fEzsvZpb7zSi9DcTXyrfF4fdH1q5pTRdAqctp3Xz3Bg1tEc2xyek6gaPveFR/jyu02u6MvP0xFPT8CAzxw3LsO1RcEcaJPP2AzLHai7XbudtttjOG4JFM7wBr+F9PRbfuanQAV4XY/jHWWTIlNmY0zrogR0BglgnlfogPb2fmcXcrTHk/OVYHZX1aRb6xsoZXfIw7e2J6JFhJbxKZU5t/qbzTWxWaRKDorBcOdVmINgpTYEJYOPsiFOi1RPFr+lMnSGJtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdiCW8afwJ9fHVx+uRcP8K5XV3XtQ8bqH+KfThWjj/o=;
 b=blPMKfh0jUMbsKUGo76wWa1Kvhvjunl1Hs6RrSyxfdSyFAC6pEbThDV6g2mmsG7hkzDf7AK/Weo7gSUL5e95/9zdLpytgghPKIqi9K0VuZ644H8iEaIn5dyj9WauRnYpKgr70qe/O6DtFb+ANpFAQoMQ/C6tGgRe4k1/O84w8ufrW/5r3cXvyLErf4D4oXBhHd5ijIHrhd9tii8lzD8XFCaSbEFnEZw1M7Tefp3EFmGGwTQZUJIsIKz1Qwp9B0Vi+rhL+RCEtw25BFKyl5AbvjtO0aYOGHIVr0aAjVuOXunbDrBKzhcAT3rb/anw3IFL5ntxZX9HXfAKAmCDePbu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW2PR1901MB2156.namprd19.prod.outlook.com (2603:10b6:302:3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 17:51:49 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a5a4:b285:7ff:2a37]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a5a4:b285:7ff:2a37%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:51:49 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDg==
Date: Tue, 1 Jun 2021 17:51:48 +0000
Message-ID: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-01T17:50:56.2685299Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8ccf8f97-10e7-42a0-9918-ab5a3aed1ed3;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [188.120.129.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61985f7b-909c-44ed-6740-08d92525ee36
x-ms-traffictypediagnostic: MW2PR1901MB2156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR1901MB2156772C8D95346D55B7ADA6EE3E9@MW2PR1901MB2156.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JmmmH30ZCCB23QpwIEZFm71dwstM++ua0QXByQDdT8RaKI82xYIyKMBBRv8q0pqiaZLOxE/RtTist886dJkO/qhGE7C1Bu3gbCmXQrwejhljwtEoh8nJV+BbVSvNR/MsSm/4o5ivNyD0Czg55DHiOBTdkVmln+DjNTSu5G3CZGIRZyZVty6G4OBmPD/eZ4syuz9OobhV6KDLZjzK6/FBmV2a0osIhGrgCvnQR+RnwU1cm794BAdSFA811GUCX74l8eLro1Tn4/ra5o5PIqs3QKN6B2m8lvdzJ9Xpy0roesAGpnrhweQ/iNZnOw676lYZ77eLs8tkdDX8bYleFJC6GfftgHes2rXGd506yyP18VFwfSzRSFpvD5xnOqhs5FqtRoYz4Dd6KI2a8lmmabJUPNtnQhj3ZxigFbaC93/4N6qSbUuyQLATunncegh3WQFCwPAEyDvNvskg0ufmdrW8O2ZXhH9Q0+IL6CzXecpEhqQwJP7SO2SKmOMm/E8iyjpKRnenuzVQMKbVg4yg6cBkkFTzX0909eDLF/yF+l/w8LPEVKOUh8X1JUi24OT1u23bNDu6qT7mP5cewg4lDF5wDwYFgNH1Ah+NGi8XqQ10f4o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(5660300002)(64756008)(26005)(66556008)(107886003)(52536014)(66446008)(786003)(66476007)(6506007)(7696005)(38100700002)(9686003)(8676002)(76116006)(478600001)(86362001)(33656002)(122000001)(83380400001)(71200400001)(2906002)(110136005)(186003)(4326008)(66946007)(55016002)(316002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?T3IvcDYydHFrWjBHOTk0eFdGNWNCVFBhSUhpdTgxUmFUdjhqRzlYUTBK?=
 =?iso-2022-jp?B?Z1Q3RUVES0J1cUtxc3pad2EwN290Ni9VOHhUckx1d1FVU0hqa1B1VlF1?=
 =?iso-2022-jp?B?Q1NvZ1NvWXdYaGxPSzBaQVVTRy9KQ0hPY0pGZ2NaRm5nNlVTQmU1RVNQ?=
 =?iso-2022-jp?B?TC9XZGJLM0lGYm42N25aNHB4KzJVdUZNMVR0Y1hJM0VDRmRwQUJwYkVV?=
 =?iso-2022-jp?B?VlZ6b2lSa0xJUTJzL0FaTFVXMERNS3QrQXFZM0VtVjF1bW9sQytyZk9p?=
 =?iso-2022-jp?B?cHAxMEgrWUhEMVI1eUVqZHg3NkNlVys2VW8waU9qWlVHcXBiRlZRMUFW?=
 =?iso-2022-jp?B?ZzRKLzZUOElNQ2FraE0vaHRUdlBDNnBqQ0NpbXBnRTI0cEFJVlhlSyts?=
 =?iso-2022-jp?B?eFpUcElRL2M1RmIyTGNWVTMwUDZ5eVJJcmNwQS9wcHdTdmhHZ3lIVkdB?=
 =?iso-2022-jp?B?dDRTRUkyVFZENkQyWHVQM1BBQWdPOTJXbTArMHNja0xVbW5WNFhXRGNk?=
 =?iso-2022-jp?B?WHpZTklLTzR3MVFlRXhaamp4V3ROL2JMOFpPaC83eVp6ZFczYlN3YnV1?=
 =?iso-2022-jp?B?cXk0MzNCa3JCTEFQV3VxZ0FzYzB4WU5kN0ZaZnhIT1VpTTdlWXc4MEN3?=
 =?iso-2022-jp?B?V2lCcG12VkhCajBnZ2gxWDkyTUFneXFSdnA3LytXSWFoS3hKaVhralN6?=
 =?iso-2022-jp?B?WWwrVEs3ZXcxS3hPckQ3UnIraEs1M1IzdlJLd3NIemZFc0MvbUxld0hE?=
 =?iso-2022-jp?B?SmZtYWNqOU56eFVTK3lpTFF5ZU1wSE5yeHQ0QnNjdTVteVFKVS9yeGdT?=
 =?iso-2022-jp?B?UStKUUhaVndCTk10UEZxWG9NMFpkbWlnQkhyZ0JqMUU2N1dDRkRndUdX?=
 =?iso-2022-jp?B?eStSZUd3T0RLUUY5R3ZTaFVucWNEUXM5Y3FpUllwMjBpTndLVHdPdXRp?=
 =?iso-2022-jp?B?UG1jUVVTaXFyNVc2VlVCTDdPcGxwQ1AwbjdDaVhoNlFybmNzaTJRMStn?=
 =?iso-2022-jp?B?QWJwU3RVMkRTWGFlR21qYTNRWDJ0dVdORVdGc1paYS9nWDkxMnJkUGVy?=
 =?iso-2022-jp?B?K1ZMemJWRHNXeDBEOEV6QjlVVVdMcGlxNThRNEZuSndNdTgvSFIvY1Mz?=
 =?iso-2022-jp?B?RzJ1S3FSb2NERUdNdzlHY0c1RzduVGd5QUh0TUcwdVo1d0d0Nmpra25K?=
 =?iso-2022-jp?B?d0V5WDc3STFRRU9EM04rUHVwZHFzZCtPRWFrK0N2emxORHQrMFpwZXA1?=
 =?iso-2022-jp?B?aGQ1cXVCZmhVREFqMC9LM2QvdlNZZHNzUmlhV0JhK0NGaUpoaXNuQmVP?=
 =?iso-2022-jp?B?Ym85elpDYVhMcXcxd2tHaGdpMmQ1c1ZxRGtlSjZ4TkdqZG9sa2x2c1RX?=
 =?iso-2022-jp?B?dGRKN0dYOUlCTFQxdENuVlFQaFBtUEc5NGIyZEdCMENuR3Mwa0VmUEhk?=
 =?iso-2022-jp?B?K1MxYmtoR1V6RE1lcmpIMGZwcHd3VWQ1Z2YzbVJqOVZaSllTbFNVdFMr?=
 =?iso-2022-jp?B?YjFweU11VDI1TitWdTZxcFNKUkJocUVlcEtwMXIvNkRyM1N3SVhaN1dU?=
 =?iso-2022-jp?B?VTMrZlphenVESEk1RXV5MEgySWZHeXdWbXhKaFRYajd3UHIyUkZlV1oz?=
 =?iso-2022-jp?B?MHRQSERYMWtweTMxZ1pTMDFhUUN2RmN2NkVGVmxRWHhkZW16L0RwOVFm?=
 =?iso-2022-jp?B?VUUwTWJ4Q2t3YTFycWlPUzU1TVBmbWNHaUptOUlkUXJ3eDZ2aHRsVktB?=
 =?iso-2022-jp?B?bjRJREJFaU9WajA3ZXRkajR5Rm5qbFd6QlZjR3dGYys1K3dnVGNZVmNq?=
 =?iso-2022-jp?B?UjlEY2RLUXJLRm5MbXVmem5RYXU0ODVUSHhxZzA5bU4wa05CK2xQb3dL?=
 =?iso-2022-jp?B?d0FST2NENGEyQUZqaC8yRVpyYk9CcTRaQVNqY2ozdFpGN3ZnN2RET2ds?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61985f7b-909c-44ed-6740-08d92525ee36
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 17:51:48.9170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBJ32YH2Wi8nnoYs2UR5ItN14Co6fOxs7vldedXitTOxl7f7Z8UdUBPLLUsT9eEF7ofFQDrly59DP/hmR9J7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1901MB2156
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-01_09:2021-06-01,
 2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 mlxlogscore=878 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010120
X-Proofpoint-ORIG-GUID: cKrxrYqwC113-Q4DEUsDm-fntzWHwO7s
X-Proofpoint-GUID: cKrxrYqwC113-Q4DEUsDm-fntzWHwO7s
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=985 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_105156_396364_710DBA2C 
X-CRM114-Status: GOOD (  12.69  )
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

We hit the below kernel panic “BUG: unable to handle kernel NULL pointer dereference at 0000000000000230”
when running with RHEL8.3 host. This happens after we reboot the target side application (when multiple ctrls/connections exist)
Based on vmcore analysis it seems that when nvme_tcp_restore_sock_calls is called (from __nvme_tcp_stop_queue)
queue->sock is NULL

Are you familiar with such an issue ?

crash> bt
PID: 193053  TASK: ffff9491bdad17c0  CPU: 7   COMMAND: "kworker/u193:9"
 #0 [ffffb2e9cfdbbb70] machine_kexec at ffffffffb245bf3e
 #1 [ffffb2e9cfdbbbc8] __crash_kexec at ffffffffb256072d
 #2 [ffffb2e9cfdbbc90] crash_kexec at ffffffffb256160d
 #3 [ffffb2e9cfdbbca8] oops_end at ffffffffb2422d4d
 #4 [ffffb2e9cfdbbcc8] no_context at ffffffffb246ba9e
 #5 [ffffb2e9cfdbbd20] do_page_fault at ffffffffb246c5c2
 #6 [ffffb2e9cfdbbd50] page_fault at ffffffffb2e0122e
    [exception RIP: _raw_write_lock_bh+23]
    RIP: ffffffffb2cd6cc7  RSP: ffffb2e9cfdbbe00  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff94b2aefb4000  RCX: 0000000000000003
    RDX: 00000000000000ff  RSI: 00000000fffffe01  RDI: 0000000000000230
    RBP: ffff94923f793f40   R8: ffff9492ff1ea7f8   R9: 0000000000000000
    R10: 0000000000000000  R11: ffff9492ff1e8c64  R12: ffff94b2b7210338
    R13: 0000000000000000  R14: ffff94b27f7a4100  R15: ffff94b2b72110a0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffb2e9cfdbbe00] __nvme_tcp_stop_queue at ffffffffc02dc0aa [nvme_tcp]
 #8 [ffffb2e9cfdbbe18] nvme_tcp_start_queue at ffffffffc02dcd18 [nvme_tcp]
 #9 [ffffb2e9cfdbbe38] nvme_tcp_setup_ctrl at ffffffffc02df258 [nvme_tcp]
#10 [ffffb2e9cfdbbe80] nvme_tcp_reconnect_ctrl_work at ffffffffc02df4bf [nvme_tcp]
#11 [ffffb2e9cfdbbe98] process_one_work at ffffffffb24d3477
#12 [ffffb2e9cfdbbed8] worker_thread at ffffffffb24d3b40
#13 [ffffb2e9cfdbbf10] kthread at ffffffffb24d9502
#14 [ffffb2e9cfdbbf50] ret_from_fork at ffffffffb2e00255


crash> bt -l
PID: 193053  TASK: ffff9491bdad17c0  CPU: 7   COMMAND: "kworker/u193:9"
 #0 [ffffb2e9cfdbbb70] machine_kexec at ffffffffb245bf3e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/kernel/machine_kexec_64.c: 389
 #1 [ffffb2e9cfdbbbc8] __crash_kexec at ffffffffb256072d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/kernel/kexec_core.c: 956
 #2 [ffffb2e9cfdbbc90] crash_kexec at ffffffffb256160d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./include/linux/compiler.h: 219
 #3 [ffffb2e9cfdbbca8] oops_end at ffffffffb2422d4d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/kernel/dumpstack.c: 334
 #4 [ffffb2e9cfdbbcc8] no_context at ffffffffb246ba9e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/mm/fault.c: 773
 #5 [ffffb2e9cfdbbd20] do_page_fault at ffffffffb246c5c2
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/jump_label.h: 38
 #6 [ffffb2e9cfdbbd50] page_fault at ffffffffb2e0122e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/entry/entry_64.S: 1183
    [exception RIP: _raw_write_lock_bh+23]
    RIP: ffffffffb2cd6cc7  RSP: ffffb2e9cfdbbe00  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff94b2aefb4000  RCX: 0000000000000003
    RDX: 00000000000000ff  RSI: 00000000fffffe01  RDI: 0000000000000230
    RBP: ffff94923f793f40   R8: ffff9492ff1ea7f8   R9: 0000000000000000
    R10: 0000000000000000  R11: ffff9492ff1e8c64  R12: ffff94b2b7210338
    R13: 0000000000000000  R14: ffff94b27f7a4100  R15: ffff94b2b72110a0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/atomic.h: 194
 #7 [ffffb2e9cfdbbe00] __nvme_tcp_stop_queue at ffffffffc02dc0aa [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1486
 #8 [ffffb2e9cfdbbe18] nvme_tcp_start_queue at ffffffffc02dcd18 [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1525
 #9 [ffffb2e9cfdbbe38] nvme_tcp_setup_ctrl at ffffffffc02df258 [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1814
#10 [ffffb2e9cfdbbe80] nvme_tcp_reconnect_ctrl_work at ffffffffc02df4bf [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1962
#11 [ffffb2e9cfdbbe98] process_one_work at ffffffffb24d3477
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/jump_label.h: 38
#12 [ffffb2e9cfdbbed8] worker_thread at ffffffffb24d3b40
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./include/linux/compiler.h: 193
#13 [ffffb2e9cfdbbf10] kthread at ffffffffb24d9502
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/kernel/kthread.c: 280
#14 [ffffb2e9cfdbbf50] ret_from_fork at ffffffffb2e00255
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/entry/entry_64.S: 360

nvme/host/tcp.c
..snip
1481 static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
1482 {
1483 >-------struct socket *sock = queue->sock;
1484 
1485 >-------write_lock_bh(&sock->sk->sk_callback_lock);
1486 >-------sock->sk->sk_user_data  = NULL;
1487 >-------sock->sk->sk_data_ready = queue->data_ready;
1488 >-------sock->sk->sk_state_change = queue->state_change;
1489 >-------sock->sk->sk_write_space  = queue->write_space;
1490 >-------write_unlock_bh(&sock->sk->sk_callback_lock);
1491 }
..snip


NULL pointer dereference at 0x230 → 560 decimal
crash> struct sock -o
struct sock {
   [0] struct sock_common __sk_common;
   …
   ...
   …
   [560] rwlock_t sk_callback_lock;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
