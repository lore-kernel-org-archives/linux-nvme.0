Return-Path: <SRS0=8akd=JC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C50C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Apr 2021 19:02:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8466E6128A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Apr 2021 19:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8466E6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RbxqwZXmKlRsxAZe4UAigns/FKUec+eQyfQDJ0uXBvY=; b=gktOx3arCffFnPbyBCcBI5uWm
	I2sO7dxkAQ+IQ6ILm/QxmdwBAg0MFDMQYtTA++X1dcXmkm3Uq4gRr3iah6bztp7FzLkXa/+ztMX9P
	PrlBs+d+htygDUYmp7/Us/KeuQMHnnFgoVQjzOS9eBdPBTv5UYw1OH2iOW98a8+7AuHos69VvokuS
	5kvGxWVdLP5uAU7T7kGGgRkAudSIBSlC9h1X4lpEAy7F40p6VPB5rMxoP4hAibF+woZXCdoBkFbn6
	yDoQYVaTPq1VdT88S4DXXZFG35XOTKzjX0YGNdio8HMzHlSvBxY5onKMSl7aNv3Dly9R2DgSTwFlp
	J0FXLy6qQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTUTi-000Q73-4X; Mon, 05 Apr 2021 19:01:38 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTUTa-000Q63-Ih
 for linux-nvme@lists.infradead.org; Mon, 05 Apr 2021 19:01:33 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 135Iuocl003169; Mon, 5 Apr 2021 15:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=z4Qi7HgUibsZ/KxCkpKLE+DskWCYhPY36M73Iti3blY=;
 b=I4LRF65iXLWE8yImetrxZCYt5ZsoZ9iLDeFSr9iq5F1HPMNanpDe+rHK0cuSRsMOKqr2
 K1fftP29HcvnO8q3hbegecYx+zIKsbBwyRLVfrRWz1yOquP5lYhl9Hd6B94Quxss2PfI
 YcNDJjfMhcDZpDek+msDK62D2nBhSDXXFWmId+VLAlilKDa9Ob4l0ffxDjOAAjrRgGwg
 tNN7zOE8116WNm+3b4guZxfsBHm7TvfkcTCYZxOFXjbSiLvazFNLuZX/V/HWq2HK/9qH
 sw5HHo6w6A6rDSLl8avRrN6ISNeiDJ5ejw+ii0CrlxcVTl2PKtq12+4uqzQOCh+yXdjv yg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37q2n74btu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Apr 2021 15:01:07 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 135Ik3qv178309; Mon, 5 Apr 2021 15:01:06 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by mx0a-00154901.pphosted.com with ESMTP id 37q612mg95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Apr 2021 15:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYrpbaXrTXzvTnshHmRKvo+myebg56YHPKbkW46f8wBBkD/2xM0NC6KmNOd6Q+LK5vyPJtgBOC0bW1m1dNMI57Bv7mt4aKrdKCyGsAV44EBssAfAlCmjncWb0WhsxGDl3VQQh6qkpZ+w3D7Or7E8TthvTjGNUfvwcMDiVvV/vAs72D3mjafkbOHQroigI+zrzXaUXkVlE1b1uGtg+Pitne2aFVOHeFM9YllV9mFQT/c1zB0NyhHNzPfOuzFWcZFnQkb2poVmsqqoMvHvG8S8fALiM8X5vEwiGs1jQXIweFDcggJnTVoCP+WlIhpp3q+Z87GrAz7S676YlAExdC/zlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Qi7HgUibsZ/KxCkpKLE+DskWCYhPY36M73Iti3blY=;
 b=RScDxAK6WapDvyo+Uxbm9qhW4lfMUw6LNRNng5wCp0y/fkpPJoK8poI40ey0pSYNPmtBXuvHuL9P8PfNk8mhiQ9nxINiXsgHxS4FFI68fgFD7Axe+Qmn8YQ9rQlHaCfAN8VwDMtmv+Q6dWHCirTR9GDFxEh9j42FAThumW9TL8UkCVV+EkjtZVWObazCv+83quz+e97daAmKPAGeD4KXd6QVuH6Cves2VG+tP7jVcL+qUrId+vzNKJZ4qS2vsnOr/+vskWTflTPlwrJ11m9jPbFcOlWzo2RIZVbqX013hsGSZe5ZDqmqUr3FrJxfrj0wUioo/7VJtZczrkhAFFA6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB3594.namprd19.prod.outlook.com (2603:10b6:5:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 19:01:04 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 19:01:04 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Christoph Hellwig <hch@infradead.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Hou Pu <houpu.main@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXJg4ljd9fP2lGgEaubk2tJqCUwqqeEXFQgANZ0ACABORt8A==
Date: Mon, 5 Apr 2021 19:01:04 +0000
Message-ID: <DM6PR19MB4011D233D0F650E82A748057EF779@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
 <DM6PR19MB40112E2D348A3FF80009BDBDEF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <20210402161732.GA1872113@infradead.org>
In-Reply-To: <20210402161732.GA1872113@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: sagi@grimberg.me
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-05T19:01:01.2815402Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=28600aef-5215-4d7b-b1f6-8b931b98920c;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=dell.com;
x-originating-ip: [87.71.31.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280f90d7-904c-4aef-16ec-08d8f86529b6
x-ms-traffictypediagnostic: DM6PR19MB3594:
x-microsoft-antispam-prvs: <DM6PR19MB3594A06502EF88D3C778B4EDEF779@DM6PR19MB3594.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YB9vb1LtqIpA54v8R6GfIET0xcZbe78hjciUeAZivqkCuqLnzTNVTkn5fKLF1fYuofjSdRDdNaxywrDsjKgB8cnGq2abchA5AUlUDG3nXqYcjMFYUxhI3uKwdtfAK6dA7NNkh2hAQDNC9nw+EAnqRjrbM28qg18/7Q40PzWqW3t1AGzCZ9NZPXJGT/gpqzj5us+1SJjyEqNq+fANV0YjynwGnftgLCr5lDr8ststo+wZkRlAHfzIdu1v3oXkBJ//GlxgS4DMgUnLFuyCVHNvuP6iIo4Zx+rnTJ5DXMPSq8V5kak+3znKBshtMN5tP3VBvtusEv3qrN0+o/wy//oqmjSY5xNvXfKKX3cyNJlvJwC6/Ek8/Xjkhq6ErBkQAs5MdLtU29KzdOOz1GhTydkeTFtu2GRpaxdxXGInv2CWhVn/VOc6tcJxbPjcUJfekeBYPkpdlTkC+afvXlA8fKVmV05OjHMpvZnp5uR4ZH843PnN5o01fP/wWObhAAf1p3gZsSKpR3Ay4T/x0LpNf2yJeY7uFPpPSuPY9WqWwvX89G7uLEK2tDtRbpChG6ldMNaLfCPJ97G2Z4mtmVt/7njr7XR9AgKe6iHqkfmoBiHWOCGF3w1Q3oBbIiX+Lm2xlPDaEALN34oLy4zy/dDadK+XIJATRrwaT1UPikvGqms28C0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(8676002)(4326008)(26005)(8936002)(2906002)(33656002)(52536014)(786003)(86362001)(54906003)(71200400001)(4744005)(66476007)(64756008)(66446008)(66946007)(38100700001)(66556008)(316002)(83380400001)(7696005)(6506007)(478600001)(76116006)(55016002)(9686003)(5660300002)(186003)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejFPZVVjMmtsY0NWU2wyM2hmN0l4LzZVeVNvWHVSUWQwSVZyU1JHd1RDQlpB?=
 =?utf-8?B?NjZmdU96d0J4UEt6amQ1UkJWWE1ZMjBONGRVYUd5elR5dXM1UGpsR1VLMmtG?=
 =?utf-8?B?RHVOMFRQMVozeGt5ZmZmUEZ5Q1pOY0YzV1FtVE11by9aai9uSi9iZEEvSFF1?=
 =?utf-8?B?ZlNqbHlpc3NlL29SRVlCQ2VzUXJ0UGhxSExaei9uR2ZFQitSdkdSaUdPbU1a?=
 =?utf-8?B?OVZud09mZ2djMjRWNnFFVElGdjNYeWhNR2xGbnJFZ2hkNFlJTWJBcDFsSlpq?=
 =?utf-8?B?cGIzc00ySlhYL1BseXc4NzN2Zy9OVWFrN1UzcmY3U2JMNWZoand5NG82a3Vm?=
 =?utf-8?B?UmQrN2ZPTDFTWVlKV0xHOFdUL0diSzV1dWpQK016Ykw3dzFsdWNVa1hYRk5h?=
 =?utf-8?B?YlgwckVRWVVYc3BOTWViOEhWUnNEd1lDeE9IREhtekF5WSsvbHgwVWpwa0hv?=
 =?utf-8?B?S0RDMk1lalV0U3Y2cnNMWm1HQUN0bVZ0cGZ4amcyK1EyRVF4cDZHaFNlbmc4?=
 =?utf-8?B?bXdhN1BXa0NwRU9Kb0ZyUzhnaHU3blhRYW91UzB3VnRXajNIWEg5bEMrYjJv?=
 =?utf-8?B?MFBoSzN4bk9lVk8rTkt1d21qbGhqZUMrZldyNmJaOEVTR1NLQTFET3RPWU5u?=
 =?utf-8?B?TVpab3FvZ2RqZmZiVlVGS05DNXVPb0xHbm5XTzFDbnFRbklEVVUxZndFL0hi?=
 =?utf-8?B?ZnFYeTNnNytYTm9zWHdDOEVLRWkwMGlYb2IrN3M1WjRhVXFmWDcwWkVBTnNT?=
 =?utf-8?B?U0g2Tjhjd29Pa3pzNG96NGwwRVgya2d0bk43dzFWMFlQc2p6VnVwbS8zR2tj?=
 =?utf-8?B?SlFXd3R3eXNsRzUrREZWTUZBZm5iTTFBS015ekE1RFBVbEthNmxkRUd2RVVx?=
 =?utf-8?B?ckhiMU1WbHMvcHB5S3R5VzhRT0xpc2dkYU1MWTVxODJtSit1QjlwNTRhTGVJ?=
 =?utf-8?B?azdCdUNRTTF3R1hvNkNaSkFBU3NXWHZXeHY3bnpRamszNnBGN0k0WEUxaGs0?=
 =?utf-8?B?SVZ1UzhBSDlJaHNtemtvZ01YVzFXSXhkZEFITytPOGV4RzZ1ajVoRENNU2JT?=
 =?utf-8?B?VHNPNzk3VmNuaDJqZ3k1RHVLUUl2Ymt4VGtUak1YZkg0Uk9DdGo5UGM4MDF5?=
 =?utf-8?B?K1owM0NWWk9UM0wyRmg1VDRaS20ybUF5OEx1eWF0MlNtTzZqb2pPREZGYlRN?=
 =?utf-8?B?cEZ1STNWVCt6NGxHaXNXd1o3UnZmajJ6bGdXOHdHZHg4YzE2bFhxeG4yUXBp?=
 =?utf-8?B?S0FlRFRSSEJ2WUhHZE9zMmwrMUM3dWVDOW5BV3ZtVmZ2OHdFU2Q3OVM3YWpG?=
 =?utf-8?B?b0sybVFZaURTUkdLZmF2ZnltNUU4LytXWUNnWW1lZk41Y1NTYjF4cVptL1Z3?=
 =?utf-8?B?SHB3ZjNNQlFNdjAvcS9nekRjbDVFUldFUlVNM21pQkNEY01SRlF6czZ1cXdT?=
 =?utf-8?B?eTRUS2tvblAwdm05dzI3WlY5MytFTG4wZnlFaE8wQy9zbENxZTJ0KytDR29i?=
 =?utf-8?B?LzBOVjJRSmpWRE44UTU3cmp3TmI4UjZpNkpnR3BxUTRRNkhFRkJnNHg2UmtJ?=
 =?utf-8?B?WHM4MXNHUzVHRjFJSUZpMjhvMG85aDZmL2VIc0tFTTNhVURnZG1sTXE3SnJZ?=
 =?utf-8?B?c3MwQlZ5WlFwSVdNWXFBdkJITXkvTzlIdk5acC94eXF4ZEVCQTE1Z2NONTdO?=
 =?utf-8?B?blpzMHlwYzFRWXhFUmIzQjBHVElWZ1Nnc01ERklmTXRIVkoxQ2U2TEQzMkNP?=
 =?utf-8?Q?0TMsrT78NAJUM8LhL4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280f90d7-904c-4aef-16ec-08d8f86529b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 19:01:04.7432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2fdMTuoWd63IDEeq7hj2FLoBHJWEKgHb2B0pvcOrh/3bgwYN0lwJZdmERSVb4YSjhHlFChTTCnbfYEQi34ljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-04-04_01:2021-04-01,
 2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1011 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=945 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050118
X-Proofpoint-ORIG-GUID: _mEn9U4bcHwOvCM81xRzAGZPYXZ4hu5T
X-Proofpoint-GUID: _mEn9U4bcHwOvCM81xRzAGZPYXZ4hu5T
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210405_200131_297078_C4BEBC1F 
X-CRM114-Status: GOOD (  14.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Let's have @sagi@grimberg.me take another look please.

Thanks,
Elad

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Friday, 2 April 2021 19:18
To: Grupi, Elad
Cc: Hou Pu; linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: Re: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

On Wed, Mar 31, 2021 at 01:27:40PM +0000, Grupi, Elad wrote:
> Looks good to me.

Is that a Reviewed-by?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
