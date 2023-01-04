Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCFEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pvjVXiDVflajvdguyq2qMefrn7nhu6xfLeQUotX7loY=; b=NaGjK8Y0i5Gd4RtltuRfpDzSXQ
	k+OKbULsHUV8SuL4/Mqs7ZWje5RSMWBVO8iTkCaGaIrIthmai37+PZoCAejHy/BYNNPCz7CI9ZI6e
	8aqW3ThWr7x+QWi3HjvaAc2XG89WQIP9xZFCipa22y1wDWsZmqjNvDxRHU2BXRVcPH8rz4Y8gphnU
	xUiHXp/llK7uxArm8LgPD+8TGuWluKx0CqTQSGc3OL5hwara2tv7sBDM5wjmWKvXoc6uOjJK+t7yJ
	lBlBN/n7Pc0SGcWsD2ijbytyZgmEoqYC0ovG+cveAS6GX4vEmfioaHudjAPQizUnSMCIqf8T6MxIH
	Qp1KQXkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD13G-008OUH-RD; Wed, 04 Jan 2023 10:31:18 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0sN-008M8T-96
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 10:20:05 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3043RNTE000351;
	Wed, 4 Jan 2023 05:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=pvjVXiDVflajvdguyq2qMefrn7nhu6xfLeQUotX7loY=;
 b=zAE8YQBXVF6k0gG4CkV9jmVnlz34aQEACsIQRnckfkUjlt7PoWy1/lhQ899t5a4PcVyw
 sshjClaV9Wht4QCZCOA6g4BOHdPlKP1OWj6OL9KBxZL2vBKOqH7CVr0dZDKNnuwIcOeS
 jVeJSUjXJOlxDOK5Yabbh1VOH6gp/oIcI4CMEOWcHVZgUH44rB65iNzoSOl+IXDK4HZI
 7uuhU5ndMtY2J/bNVpP5Ba4ZMsAon48ZwR8wKTlL3LB/38gE4cdOXsQBuzvg0Zm9bGPH
 aNbcaicrpeVgqgyMfsU6ZEwf+JeL8K15lGp9mxNt69+NfIMFeZcnckFXc/e0Pi1mQtoY Dw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mth6fjajk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jan 2023 05:19:54 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304AI4Bu013600;
	Wed, 4 Jan 2023 05:19:54 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3mu36xjk7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jan 2023 05:19:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYQcwL8hRXVvMKObJYGSqxUe3M89P4iPAiu9zV7zssbmScpCWl4b3xNbHw7mkPf9zZPUQIO3+IOjenCUsTmdMQIBiK4VA3ODWjpSMpRlKx6rc4K0ykkAcxaTiD/N/vevKldxwL5PmDXEtQHiZW4tFoQSYXccIa5JpLZAAOK64189IYd0TUcOTExxIdlvcEYZSFMqY/uZyv4ZTUNC8JOL/bBvB+2Fwn2pC1M3C65SIT4ZYkxb7BkX7JpOGmcNh+4+KDQSCjaAv8R123kXfBM3RCoUOqA7pPc8twmKhyYYzw51TFVt1UtAXaH9MZD5PV/OdgobVFCEqSQWjNgVT9QEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvjVXiDVflajvdguyq2qMefrn7nhu6xfLeQUotX7loY=;
 b=YjQuX26hBiIn6zQqChpi4vBbdyisCmEF574MRP1kpBsDwfU2OEZIGHvbSxeyHTwI+Cx+nsYm72+4Q8+6gaOFwi/lyMY7CT2ikeEnBp0ODzQg9MInYHN8CVxcviYqAELW+5beQxrLj/OhTvtXU5hlxWt5RJhJ7Z3JX6jiEdCMmRGi9GbmziuzymzqLwFtWQAb9EquDrf1pYUNlDtXS08QUERm8DoEnJirghWc2QWALJQVaWwEfhfQC2cZGhxoU09fzBloaZGiMwpyakGYVQhJsq/CIS3FaVGXx+fzxAZDtNuHdEr21OWb4ry/AvUcri5AfyfdzuG+YGGCPKHiFdTwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by DM4PR19MB6075.namprd19.prod.outlook.com (2603:10b6:8:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:19:51 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:19:51 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Grupi,
 Elad" <Elad.Grupi@dell.com>,
        "Zinger, Eldad" <Eldad.Zinger@dell.com>
Subject: RE: nvmet_check_data_len() wrong behavior for nvme admin set features
 cmd
Thread-Topic: nvmet_check_data_len() wrong behavior for nvme admin set
 features cmd
Thread-Index: AQHZH3Qek1Bkt4f4YkGpY8Ga9cAU0a6MrPtwgAFdySA=
Date: Wed, 4 Jan 2023 10:19:51 +0000
Message-ID:  <CO1PR19MB4885CDE3B335B9EAC0B7192DEEF59@CO1PR19MB4885.namprd19.prod.outlook.com>
References:  <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b8154d21-d009-1077-e07d-980b249a56c3@grimberg.me>
 <CO1PR19MB4885EF6A9AE5135487F853BAEEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To:  <CO1PR19MB4885EF6A9AE5135487F853BAEEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-03T13:19:09Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=a4335766-f0ca-4e08-b277-f6b1f1f8f62e;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|DM4PR19MB6075:EE_
x-ms-office365-filtering-correlation-id: bd44ac6c-3468-4775-7c05-08daee3d3748
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  /OKwoYJ0gYWU8yw0ZRL1pwkFruQ1bNj4fkhWPemBe22dSs69rpb0H91nG+D8DemTzOM6F8hYx29o2ORQ3xhI/tdwaLHH+nx9bbFlYKAGYRDp+Q1SkP721FfBPEO8E59sHonZq+RJ+tCv6yRDcgqLaAwJSFUWEtv+S3IG28hfrs4W3vkIR7K5R1aSSiqNsxy1oBL1+pDiPgceJUbg6U2RztEZCFqBWjGqN64KaM4wpxVw9BxdholgUWG+q0HE4BGnzagn6VqjM+2ZBWviowhxJkBa+e6R+eWjc5FWmAbsxnRiMwmt67pdrXyWw5IiUgndlYOy4J0QCl8Jm6G/4rQb4TwAPfCKeLjncDx/ve6tskCA5Pwh8dqZ0A8Js64QGx5uNZtGJawpfjcLJPwPd2h16O5J83e7UhJk2XiU0k00M5hNXuxYqmGOqb9/15yQWspLbNJs9zRuD/OPlTsW/I8fK8uPdvyKeurYXc2+xQP8PmYdMyNcfAUxrJ1iSAXftG+B1wEx9gROBqOE1PG7m9PrczXe592cRD7f7Q6hPbuPyJF2jt9xi63VyNEF86L+l7QGMsuEyFDfhODkaQk5QcFIKXrDPfj2JhyAlKyrQUHM4z2ObRgVxCN4uvUaDfVMFGR/QSLn9yiiS3IT/q5zDoYCrlpbGtSJlcDYw+Um8eDgy6pjpUgx39+vA5wuChAOx/cTmP1GRhnHtNCWENzJHwyyaA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(5660300002)(4326008)(41300700001)(64756008)(316002)(66476007)(66446008)(66556008)(76116006)(66946007)(8936002)(8676002)(54906003)(6916009)(786003)(2906002)(52536014)(6506007)(7696005)(71200400001)(9686003)(478600001)(26005)(53546011)(186003)(107886003)(86362001)(55016003)(83380400001)(38100700002)(122000001)(38070700005)(82960400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YTIxbFNqamg0OTVBbC8xdUswM0ZkNDVqVmEzRDRKbkY4bHlwQkwrLzNrRGZk?=
 =?utf-8?B?ckZQWDVHNU92TlRuTWcxVUlnYUJhckNuTFZ0TzlvZjRiSnR0M2NUdEptS3Zh?=
 =?utf-8?B?ckhMZDg5a2hFNkhQOXJNY25ibnEyYXZlUVVJSlJmVnpWL3kzcFZ1b0RueWp0?=
 =?utf-8?B?bDhjSVBIQlhVcXZzczh6bGdHeTk0VDZucnVEMzFKVHd4Umc2U01GMDlPR0p2?=
 =?utf-8?B?WUhvWUkzQXhaV1VPREhocCszei82M09MbjMrVkZiUzdDUDF5UXRiQXYyL3Bn?=
 =?utf-8?B?bit2OEppNGdMeWZnWUJNd3BCWURtUVZUUG8ycWRQeng5ejdiVHFsUVpNZlRp?=
 =?utf-8?B?UHdSQjdZNHZNQ3Y5N0IrWDB1RUhHQzRTd3ltRSt3ZFdQWjlyMEpEbzN5b0x6?=
 =?utf-8?B?RUhPZ25BNlplQ3VmN0huOG9LWjNvbGsxZ0w1NEVJa1h1V2RqOWo5K3dPN04y?=
 =?utf-8?B?WFhtLzhoUk5BSDZ4UnNCK0JEZFJGS1J2YlljUWhxRUJoUmlxQlhFZjlMU3k5?=
 =?utf-8?B?cVB2Rm1SYThhZzlxTTExcmRhbVpSWXBBUEZKSU0zajdKV1NxWjU2SklXMkx0?=
 =?utf-8?B?amdBaWZtanU1bUxuQ0RibHhZSnloWEVxWkMwMWhvMWpLUUh3NnhCWnlhVUo4?=
 =?utf-8?B?OXMxVkNWWUx0aG5uL3BVdDRpd0lyWk9QODVyT29FZzU5cFBFMVNTeFJHVzl0?=
 =?utf-8?B?Z2dySWVyOHRrQlVBY0hGNjA1Y29DczBybnR4T2dlNUpweUZHUmQ5a3REUklB?=
 =?utf-8?B?UWU5WDA0SlpZSUlBYnFMVldJZnhaUGQ5MU0rZlVJQngwOE8rbkFPQjROSzRO?=
 =?utf-8?B?akNYUTU5YVdHMmV5a0NLVHdLZ05MSklYaUVSb1AxZmR0UkFrYWhLRjZScXJm?=
 =?utf-8?B?bytqaVovK01wVGVSdURYY0RBdC9aQzdvVjM4dXFnVHFnbHJaNzZObnVPVWhL?=
 =?utf-8?B?aUMzOXovQmtYd0VvZyttYUVHZGhWeWVwLzk5TlZzN2hJbERzSzF1djVRdkcr?=
 =?utf-8?B?ejFuS3BjL0UreUduKzNsWUxVdktLcHVKYWZURzMxTzBJWXk0TlhBQTZOUWRK?=
 =?utf-8?B?NEJOdzBTR0xOSUFDaUJ6cVVETm54OHdlNVVBRzJKQjNIVVkvd1BVT3FKQ2Zj?=
 =?utf-8?B?WUxjNmFCbHgwVUErNTgyZVhLYUlXYUREYS8rVFV6UEU5VjVNZGM2dUFQN1hl?=
 =?utf-8?B?M2JQTWpiTmVxSTB0MVBwVktFeVp2YmxjaVczdHIvRlBBUUpvUFM2U2Q3V1Nt?=
 =?utf-8?B?NWZ5eEQ0WkFmVk5qQmlidnF3bUhHejMvS01EYW0rdWR0TWRTMU5DWWtxT1Nl?=
 =?utf-8?B?Y1JYZHUxdHg3ejRsdW53UmtPUUg3QTJ5TjZZN0hWNHdpT1lOb04zZ2Uxd3N0?=
 =?utf-8?B?MlE5N2x5S3U1QThRRXBmbkJWdFhXNmI4b0U2SE9vbjZPekEwZHkxZXd0WUhK?=
 =?utf-8?B?bm5DR3gvQ1loZlZ5QTVIQ3UzN3I1alVxM1FtZ3R2MjRMZU5zRU9FdVM0cUZW?=
 =?utf-8?B?dDl1WkxnV2ROSXhKTjJnV0QvSGdTVWtrL205dFN0MHUvWXNyMVB5RFVaTkNp?=
 =?utf-8?B?aGxqWExmSXFSU2dMMlY3elZwNElyZlY5eHpqVzJlNDNjS1JGRjJOek9rSmNS?=
 =?utf-8?B?VWMxQzlNYVhHTzdKcTAvUk9xMS9aUE0vYUd5WTd1eVRzajFHZHBqTWoxckYz?=
 =?utf-8?B?K0RjcVAzeHpRb1h3cThvMU9DblVtWFpLbWtGNlFVRllNbHhYQm5EOVpnVGQw?=
 =?utf-8?B?R05pL2pzSjFGcC9DSFE5cVhGOVlFcGk5UG91dHhDT1liWXJKZ01PSHQxZG1u?=
 =?utf-8?B?N3pYSTVlRjlLUWNRekI5NVY5NXFBMldjcmgvVnR4cTdpZWhqamwvemFFZk4z?=
 =?utf-8?B?L0pEYWRJMU40cXZUL3c4KzY2TVU3MW5IY2YwQytTWDgwMzE3aCtjSkZvckha?=
 =?utf-8?B?SUFYY2V3VDFvTHpxdkVnNTdCRG55RThHWGZ5U3pVUHpaUzUwUW42Tzlla2Y3?=
 =?utf-8?B?b2c5NGhWTEpIN0VSYVRXNkk1dVFaTVY5R1llanlKODRzRENEdUxqZUpTOVBZ?=
 =?utf-8?B?OEo0K1grdUhMNXRvRGgySkFXZXFwTXZNZkI2KytJL0FJdjNQdFdmS1AyaUM3?=
 =?utf-8?Q?q1qaJLGjBQg7v8vHOJztksQIz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd44ac6c-3468-4775-7c05-08daee3d3748
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 10:19:51.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsGUcaqytvz4xNaKv7YVdQ3BNcgZfTNBCwt/+fmROHdRp4prIbcZhkjij/WJ3N/qaygSd2AS9CVZzKoC9GVesQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040087
X-Proofpoint-GUID: M95YrEVe_mEWMgDFBK7fPkYptwjwtDSE
X-Proofpoint-ORIG-GUID: M95YrEVe_mEWMgDFBK7fPkYptwjwtDSE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_022003_548485_CF2A91D6 
X-CRM114-Status: GOOD (  23.16  )
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

QnkgdGhlIHdheSwgd2h5IG5vdCBhbHdheXMgY2FsbCBudm1ldF9jaGVja19kYXRhX2xlbl9sdGUo
KSA/DQoNCkRvbuKAmXQgd2UgYWdyZWUgdGhhdCB0aGUgaG9zdCBpcyBhbGxvd2VkIHRvIHNlbmQg
c2dsIGRlc2NyaWJpbmcgYSBidWZmZXIgdGhhdCBpcyBsYXJnZXIgdGhhbiB0aGUgcGF5bG9hZCBm
b3IgYW55IG52bWUgaW8vYWRtaW4gY21kID8NCihhbmQgbm90IG9ubHkgZm9yIGRzbSAvIHNldF9m
ZWF0dXJlcyBjbWQpDQoNClRoYW5rcywNCkFtaXQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEVuZ2VsLCBBbWl0IA0KU2VudDogVHVlc2RheSwgMyBKYW51YXJ5IDIwMjMgMTU6
MjANClRvOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KQ2M6IGxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgR3J1cGksIEVsYWQgPEVsYWQuR3J1cGlAZGVsbC5jb20+OyBa
aW5nZXIsIEVsZGFkIDxFbGRhZC5aaW5nZXJAZGVsbC5jb20+DQpTdWJqZWN0OiBSRTogbnZtZXRf
Y2hlY2tfZGF0YV9sZW4oKSB3cm9uZyBiZWhhdmlvciBmb3IgbnZtZSBhZG1pbiBzZXQgZmVhdHVy
ZXMgY21kDQoNCk9rIEkgc2VlLCB5ZXMsIHRoaXMgaXMgZXhhY3RseSB3aGF0IHdlIG5lZWQuDQpJ
IHdpbGwgYWRkIGl0IGFsc28gdG8gc2V0IGZlYXR1cmVzDQoNClRoYW5rcw0KQW1pdA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVy
Zy5tZT4gDQpTZW50OiBUdWVzZGF5LCAzIEphbnVhcnkgMjAyMyAxNTowNg0KVG86IEVuZ2VsLCBB
bWl0IDxBbWl0LkVuZ2VsQERlbGwuY29tPg0KQ2M6IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgR3J1cGksIEVsYWQgPEVsYWQuR3J1cGlAZGVsbC5jb20+OyBaaW5nZXIsIEVsZGFkIDxF
bGRhZC5aaW5nZXJAZGVsbC5jb20+DQpTdWJqZWN0OiBSZTogbnZtZXRfY2hlY2tfZGF0YV9sZW4o
KSB3cm9uZyBiZWhhdmlvciBmb3IgbnZtZSBhZG1pbiBzZXQgZmVhdHVyZXMgY21kDQoNCg0KW0VY
VEVSTkFMIEVNQUlMXSANCg0KDQo+IEhpIFNhZ2kgZXQgYWwuDQo+IA0KPiBXZSBzZWUgYSB3cm9u
ZyBiZWhhdmlvdXIgaW4gbnZtZXQvY29yZS5jICBudm1ldF9jaGVja19kYXRhX2xlbigpIGZ1bmN0
aW9uIGZvciBudm1lIGFkbWluIHNldF9mZWF0dXJlcyBjb21tYW5kOg0KPiBDdXJyZW50IG52bWV0
X2NoZWNrX2RhdGFfbGVuKCkgY29kZSBpcyBjaGVja2luZyBpZiBkYXRhX2xlbiAhPSByZXEtPnRy
YW5zZmVyX2xlbi4NCj4gDQo+IFRoZXJlIGFyZSBzb21lIGZlYXR1cmUgaWRzIHdoaWNoIHRoZSB0
cmFuc2Zlcl9sZW4gdGhhdCBpcyBiZWluZyBzZW50IGJ5IHRoZSBob3N0IGlzIGxhcmdlciB0aGFu
IHRoZSBwYXlsb2FkIGl0c2VsZi4NCj4gRm9yIGV4YW1wbGU6DQo+IGZpZCAweEUsIHRoZSBkYXRh
X2xlbiB0aGF0IGlzIHNlbnQgYnkgdGhlIGhvc3QgaXMgOC4NCj4gZmlkIDB4QywgdGhlIGRhdGFf
bGVuIHRoYXQgaXMgc2VudCBieSB0aGUgaG9zdCBpcyAyNTYuDQo+IA0KPiBJbiB0aGlzIGNhc2Us
IHRoZSBlcnJvciB0aGF0IGlzIHJldHVybmVkIHRvIHRoZSBob3N0IGlzIOKAmE5WTUVfU0NfU0dM
X0lOVkFMSURfREFUQSB8IE5WTUVfU0NfRE5S4oCZLCB3aGljaCBpcyBub3QgYWNjdXJhdGUuDQo+
ICBGcm9tIG91ciB1bmRlcnN0YW5kaW5nLCB0aGUgaG9zdCBpcyBhbGxvd2VkIHRvIHNlbmQgc2ds
IGRlc2NyaWJpbmcgYSBiZWZmZXIgdGhhdCBpcyBsYXJnZXIgdGhhbiB0aGUgcGF5bG9hZC4NCj4g
DQo+IFdlIHRob3VnaHQgdG8gY2hhbmdlIHRoZSBjb25kaXRpb24gaW4gbnZtZXRfY2hlY2tfZGF0
YV9sZW4oKSB0byBjaGVjayBpZiDigJhkYXRhX2xlbiA+IHJlcS0+dHJhbnNmZXJfbGVu4oCZLg0K
PiBPbmx5IGluIHRoaXMgY2FzZSwgdGhlIGV4cGVjdGVkIHN0YXR1cyBjb2RlIGlzIEluZGVlZCAN
Cj4gTlZNRV9TQ19TR0xfSU5WQUxJRF9EQVRBIHwgTlZNRV9TQ19ETlINCg0KV2UgYWxyZWFkeSBo
YXZlIGEgaGFuZGxlIGZvciB0aGF0IGluIG52bWV0X2NoZWNrX2RhdGFfbGVuX2x0ZSgpIHRoYXQg
aXMgdXNlZCBieSBkc20gaGFuZGxlcnMsIGl0IHNob3VsZCBiZSBhZGRlZCB0byB0aGUgc3BlY2lm
aWMgcGxhY2VzIHdoZXJlIGl0IGlzIGFwcHJvcHJpYXRlLg0K

