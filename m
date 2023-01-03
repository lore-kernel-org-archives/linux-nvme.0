Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD28C46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cLHgstpTm6nOBAHm2BwFPt5fHSjxwo2j1a6eeLR/r9o=; b=4Ineeo2ELbEN71gBTpJXOxpqiO
	Xx1d8td/JovcjKwCnEFQ51xRRhvuYhep/tLqAi+ov2TEZug/Egl3Wa5gSJP5MOTizOuW76nJB6XzH
	GQnMMEq5HD1FFCaCZbdQSR459aiV4ZfVXQ7V8T7TUve770znwsKFO9CEWz4Ic5jLutRW0wvIfroEz
	nVaomAQXocd95hP5AU8h6pkWEHYUpA4LRzRJpw9yphBb/MeGk9F9t682cThpcW2EQ4C1mmtzq29nk
	OX00WvL+oxXiLm2VG+IsnJLBu1jhiExxRENqD4CJ05clDNml9+fu5BIPUe6mWHDAKtU0nlYA6xFO2
	XBxVDEuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCjm8-002kIZ-VW; Tue, 03 Jan 2023 16:04:29 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCgjT-001LPJ-MY
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 12:49:33 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3035Qhh3004035;
	Tue, 3 Jan 2023 07:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=cLHgstpTm6nOBAHm2BwFPt5fHSjxwo2j1a6eeLR/r9o=;
 b=ODWGyJ6pK1QkdtWOPbzTMtNPcW2dUWix99kRnyifoKAEp4oxgFOckAvcB/FEAl4Fh3oy
 wAJh4079sGvut5cJ6x80EAZdZwg9B7/XwpqHj8YADku2YlJtlhF11bafFosL+YI0m9Fh
 W/gmpn1Cd/FJwYMIIxokJGQhAPJxOQF6vp3i6XOAPFsYkhCp1OqbPSZlaeROjQriewPE
 A7+xnA35ruf9hw1sws5jms4BpIg/YM/KvYd8NUihmYkcIdZi6wtDhheyQnlGpuQXdEMU
 2+KJLiHYJTSx8RoyOIIcjXLncUcNlzvWar9YjARuCvZE20FWzrXH0eS8q7v3Z7N3L71m bw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mtf21nayd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jan 2023 07:49:25 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303Cm9f2030086;
	Tue, 3 Jan 2023 07:49:24 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3mvhekt6gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jan 2023 07:49:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRi8OhNFixsER1r0xLL/HbDwf66OO0l6lQ2ercM43wnpXIU3ecE3oanG5zExup6XSylc0Uga4RQyhF/AKFNV8kO94uOp6PlAMZdtPL1ylOqt7ClVflXFSDTImix50uACo+ZWbQ4bxbo7B8JWg2vdrYspQjh139nPyd50Vcd37RtF/yr9+cYbmUheE0dMS8nP2bxoReNtlM9PhqR+Q6ZMr84zXToZP9ZQT6eM2U1O6XPEOyR3Wf+uAyjSWfqrk4F+VRFKqEP+D7G5F/0SsBGNjgHPU+GvU58FOrcKBXyn7U/YhP12jhoibTSGFCuZKMG62Iin0OZcUAb7goMqG3Ieig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLHgstpTm6nOBAHm2BwFPt5fHSjxwo2j1a6eeLR/r9o=;
 b=KO4Xdz+KSUeJmjZnrf6AkDfuWEZd8KhT/iRUZRfjfWZp+bAfavWDANc7HV34fYjL/53qTH5Itma0jBBwRJoxlGThC4bhksLGnEqQdmJFnhjJAXxrjExhckVTKI9ZurvvER+g+XNxvTTc4kLf+FTtgKy922siLlN9NeGcay6M9WtwS9pTrEeh0+1Ngou2tcFlXpBLCbAUrhYZFw8cSAaci6fjHifPFubGUM0dOUdovMM4M1meQNxhuEUNE2qEr86wGf5wRN/gh8bYt90c4C/w/SqoVBUI/2U8Lwwi7d4Xn61mkcCYsvyWfmj5CMDKOaKJXBkkRYMx3v0PFfSYtP4O4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SJ0PR19MB5445.namprd19.prod.outlook.com (2603:10b6:a03:3d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 12:49:22 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::71ae:4884:8c52:6169%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 12:49:22 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Grupi,
 Elad" <Elad.Grupi@dell.com>,
        "Zinger, Eldad" <Eldad.Zinger@dell.com>
Subject: nvmet_check_data_len() wrong behavior  for nvme admin set features
 cmd
Thread-Topic: nvmet_check_data_len() wrong behavior  for nvme admin set
 features cmd
Thread-Index: AdkfccfnhFPexme5QRGQ+V10qrv5iQ==
Date: Tue, 3 Jan 2023 12:49:21 +0000
Message-ID:  <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-03T12:46:53Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=d8be9822-f02d-4c10-94b8-1fc00c9abca7;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SJ0PR19MB5445:EE_
x-ms-office365-filtering-correlation-id: 599e2339-a8a4-4c6a-9f93-08daed88efc9
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  HainOWH0UB4LjsJJrCRAGtU799c87KCMsU9Nz3f40hutlLtElZoEpOtRy+CqYU8/mdKaJGPtZ6rgjer6sC8JPT/2VboDNCNMVXO5nRbd4tG84/JFh9PV1h4kuQFdXnNHvQlQUnwcVw4aNCNPIMF/toVCFMwkGt6lhEKt4jmaL/9obr+sY4z0Dulshnj3jFBt0gc5GvL+c4tcXDK+x7yDf04Wrl3gzRAFzWnzvo57AY+UacnBW+vhh+q6Cd9rEcqWc44C8Vy/v742w7tzrQhPwMCUUaX49nKWaHLGpmDD64TmfaaMbxgKp7QmRxQLvfgcUJb9Ugvrme3eJNuiENjrsClQ9BNKTN/aVzQGXc8YZDQGCqhc+n77istWTdQzasBunoDoUjAUBK4Uq55f1m9u6MirdPgZTdfvY1jhhLousGMjhQJiY0bxzI+Sloznujf/7fo7KVRoX24AyRsHOKinhroHZPherpvDZwsCpTjxeK/Y8rNBw3fPxBfd/QZpuvEQOeA4Nk5iuE25MSXdc+1nKjIjTyVIX55BHH0peBeMW50rDp8ZENgoizyJTqlBV7oEaX5fLLzYxzRL1V/G1zTljIfhvQgN6PigzrzgerLpgy9FsQtQiifn3GROccjin4oCS+cN5cOmQaHrqEzrEm/rVl/QXZDc0x0trbFfiSq1DLYeB8nBIWhaorU6bgjUp0nsl0wuAxA1dVheK7YY9jBI5JunsSDJ3LXroxsGQ8Dlifk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(52536014)(4744005)(5660300002)(76116006)(316002)(786003)(41300700001)(6916009)(2906002)(54906003)(8676002)(64756008)(66476007)(66556008)(66446008)(4326008)(66946007)(8936002)(71200400001)(478600001)(6506007)(107886003)(26005)(186003)(33656002)(7696005)(83380400001)(9686003)(82960400001)(86362001)(55016003)(122000001)(38100700002)(38070700005)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TGxVSjRzNFdReFVTbU5uRzlGOGRCWHdTSmpPUDBMRGIzVENjVERFdEFGV0lN?=
 =?utf-8?B?MHNlMlpINkJTVXU0WFVMVk90RWNpUHRmY3ZuaW1VV3pBYXBpc20wUEVOUWE2?=
 =?utf-8?B?Uk5wSHBEUnpxcFg1RnZYS2JDem5vZkgreEx6UHJWZE5TeUtJenI5b1Z4Znds?=
 =?utf-8?B?M1EzQTdqMlBOWDViSHkwMUFSOEFSK2hWOHJBVHlpdlZseVZUMmtRMzIxaTRm?=
 =?utf-8?B?UTFzL0dxcjBnWWQ4a3VKQ1hFZ3BZckxPK01Md2J6cmh1dldqNnN1UWJXTWkr?=
 =?utf-8?B?T2hJMy9xQmdtbGg3Skx2Mk1OUmtqMmRnZUh4ZTVvMmIzNWgxS0I4S1JocFhl?=
 =?utf-8?B?RjE5OUFsZGFoY0REQTl1S29YaWZGVlY1czNxdkR6QkVBWkhoeEZ0N3FBRVdI?=
 =?utf-8?B?dWt6TnV0WllCUnQ5NElYaDV5amowOU9lUGxBQmJmODI5VFUrRys2Zi9hcGRG?=
 =?utf-8?B?eGJCVmpaTE5vSjMzZG5UeFRTQmozUmYxK3lMOVk2amF6eEdoVEd1ZXBCcGFr?=
 =?utf-8?B?WXl4OVNaYWlRakMrY2ZvejRoenZNUEREaFo1YUVVNlIvdG4yNm5HZldsbFF5?=
 =?utf-8?B?cTVaS0dDcnZwL2lpc2JYTWVPdFVrUDJWbTIxT3RndDdGTFlwSjEvTU9PckZa?=
 =?utf-8?B?a2RCUVZwV0xqanQxWm4wdGcrOEN4S0RxbTVoZFE4cUprMmxvWG52QXE0RnRO?=
 =?utf-8?B?akMzYUNaSGR4NTZLRnI3RXQzeGppRFFYZHBHZ3pZUElnOWg4aXY2dDFxVjhJ?=
 =?utf-8?B?V0NkY3YrNVhsSnZ2c1paTFU3T0ZxQzBoWE9JL1FFc3F3WHNGNmhhblNyV3NX?=
 =?utf-8?B?Y01mOXlwQnFmcXl5ZXFndTVYZjhqb2tyWXRzMHlHalFOZTRDWU5RWDhpOTNX?=
 =?utf-8?B?emszTWVPdkticU1VRUdCY1d3UGdkYVFwdUtmRncxR1QybFlEcWtyUUhJWUlJ?=
 =?utf-8?B?RC9yeHJ0T3VYajVTM1VvdElidUlmTDZwdEtGUmFUVXkwbnQyTFcyMU04aFQ2?=
 =?utf-8?B?dmdocmlWcmdGYkQvdXhBa1VDOUZiT3pRTUw5QVRiNlUwVnFWU0FiK3E0YXQ0?=
 =?utf-8?B?L3pEeUV5K2EwbDljM0I2Q3lHcnNoeG8wcUZWeTJsSFBwdHp2NmFzcTlOV21k?=
 =?utf-8?B?R204YVZqbGMxb3F5S3dObjMvYkllalh0bnZvWU1QclRNZGkrZVEwZUE1dWYy?=
 =?utf-8?B?b1JncGYyQTRkaVc5dklqOGs3dUxkQTRTRGhhUXVNUS9jU2JvTzhzQjVNZUdN?=
 =?utf-8?B?NE9uK1J0c3ZHVmNlOFdncUYyU3BUNzQ3SDRZbEhIRzVNY1A4aGtRWXF1c0lW?=
 =?utf-8?B?RkFhUlRYNHZYVCtrTzlweFhKMSs0WldUT3gwYzgzQmJCRmN2K0tKRytmTHNX?=
 =?utf-8?B?cmdsVGJZS0c1aXRmVkJNellnbUJ2TUo4aVFzQmxrOGVMcXBtMElJaVBIeHVI?=
 =?utf-8?B?c2k2dU9LTkZEekY3U3VRMi9OY29WTGJFQWFPem5MU0FwdEl0Qm1vRENQRkwz?=
 =?utf-8?B?UjlXWit4eE9zTWVCK2ZHRWdnQktNQTVtSTErcm9TSEhBTlJzTmtDRlZSZGtU?=
 =?utf-8?B?RTFGUkl3ditQb2xWb1RrcGhPcERmVklSVnQwRW9uV2djOGJ6RXY5cGpyTXRn?=
 =?utf-8?B?UTl5RlZiWHRRNXNzZHBNdG9YSG9JRHd5blJxcGRCUXJnMXAvckdwSmN4OUFQ?=
 =?utf-8?B?c1lrQmhCZTV4QmxwOW5QdXhCNDNjSlRDWjJ2YlRwd21VVWN5YkUzV2tCUGYy?=
 =?utf-8?B?Y0RJK2lWRnlDdlV6MWNVcDBSSEdsRWhYUGcyVVR3OW03bWRLMUl5NUYxRk8v?=
 =?utf-8?B?MDhvSk5hMzFrWjJlSEdHaER4amdKZHRCL09NU2hYZ2dPZk9Yd3FIdVcybHpv?=
 =?utf-8?B?bnhLRlFFZnN1TkptMFhvZDdoOCs2dmhUNEczUUdSb0d4NWZieElJc1AyWXBr?=
 =?utf-8?B?V2FZd3JHazlqdjBRa011alg1dCtzb01nNnB6TWQ4ajBSbmlOTjVhOXFPS2hS?=
 =?utf-8?B?K0ZjdnNES0RaNU9OUXpCZXFLUURVYWNWa3B5Q1hCeEdUTXRtNHZ6UXZEMnh2?=
 =?utf-8?B?cGw4VTlPUHFHQjdRaVBqUldGbElTbHRWcC9hcDcvdzUrbkxVTlhMVkpLSzB5?=
 =?utf-8?Q?HfwHPyZptMUHTEJMO+OPViLjh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599e2339-a8a4-4c6a-9f93-08daed88efc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 12:49:22.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AA5wwJzTYT4hLZUeFojUNIgyYDSwXEy5+DnZvEA43BHRgUPaijoLfNX5/F0ypN+tmxIZlYPoT0XZIesf35KmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 mlxlogscore=683 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030111
X-Proofpoint-GUID: Ly7FpcUx-u8rFN8Sct8n3iplxYQJ_8ZC
X-Proofpoint-ORIG-GUID: Ly7FpcUx-u8rFN8Sct8n3iplxYQJ_8ZC
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=776 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_044932_005667_832D092F 
X-CRM114-Status: GOOD (  14.41  )
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

SGkgU2FnaSBldCBhbC4NCg0KV2Ugc2VlIGEgd3JvbmcgYmVoYXZpb3VyIGluIG52bWV0L2NvcmUu
YyAgbnZtZXRfY2hlY2tfZGF0YV9sZW4oKSBmdW5jdGlvbiBmb3IgbnZtZSBhZG1pbiBzZXRfZmVh
dHVyZXMgY29tbWFuZDoNCkN1cnJlbnQgbnZtZXRfY2hlY2tfZGF0YV9sZW4oKSBjb2RlIGlzIGNo
ZWNraW5nIGlmIGRhdGFfbGVuICE9IHJlcS0+dHJhbnNmZXJfbGVuLg0KDQpUaGVyZSBhcmUgc29t
ZSBmZWF0dXJlIGlkcyB3aGljaCB0aGUgdHJhbnNmZXJfbGVuIHRoYXQgaXMgYmVpbmcgc2VudCBi
eSB0aGUgaG9zdCBpcyBsYXJnZXIgdGhhbiB0aGUgcGF5bG9hZCBpdHNlbGYuDQpGb3IgZXhhbXBs
ZToNCmZpZCAweEUsIHRoZSBkYXRhX2xlbiB0aGF0IGlzIHNlbnQgYnkgdGhlIGhvc3QgaXMgOC4N
CmZpZCAweEMsIHRoZSBkYXRhX2xlbiB0aGF0IGlzIHNlbnQgYnkgdGhlIGhvc3QgaXMgMjU2Lg0K
DQpJbiB0aGlzIGNhc2UsIHRoZSBlcnJvciB0aGF0IGlzIHJldHVybmVkIHRvIHRoZSBob3N0IGlz
IOKAmE5WTUVfU0NfU0dMX0lOVkFMSURfREFUQSB8IE5WTUVfU0NfRE5S4oCZLCB3aGljaCBpcyBu
b3QgYWNjdXJhdGUuDQpGcm9tIG91ciB1bmRlcnN0YW5kaW5nLCB0aGUgaG9zdCBpcyBhbGxvd2Vk
IHRvIHNlbmQgc2dsIGRlc2NyaWJpbmcgYSBiZWZmZXIgdGhhdCBpcyBsYXJnZXIgdGhhbiB0aGUg
cGF5bG9hZC4NCg0KV2UgdGhvdWdodCB0byBjaGFuZ2UgdGhlIGNvbmRpdGlvbiBpbiBudm1ldF9j
aGVja19kYXRhX2xlbigpIHRvIGNoZWNrIGlmIOKAmGRhdGFfbGVuID4gcmVxLT50cmFuc2Zlcl9s
ZW7igJkuDQpPbmx5IGluIHRoaXMgY2FzZSwgdGhlIGV4cGVjdGVkIHN0YXR1cyBjb2RlIGlzIElu
ZGVlZCBOVk1FX1NDX1NHTF9JTlZBTElEX0RBVEEgfCBOVk1FX1NDX0ROUg0KDQpJZiB5b3UgYWdy
ZWUgd2l0aCB1cywgd2Ugd2lsbCBzdWJtaXQgYSBwYXRjaCB3aXRoIHRoaXMgY2hhbmdlDQoNClRo
YW5rcywNCkFtaXQgRQ0KDQo=

