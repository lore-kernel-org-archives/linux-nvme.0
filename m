Return-Path: <SRS0=8akd=JC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8D0C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Apr 2021 19:03:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6D66138D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Apr 2021 19:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6D66138D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bpXk+VAJNPWQAPFE7exXAkqYeVarPe1q6oK0RbmrWJQ=; b=p62GHrC83MBbM6xCwWQ6WtR3j
	RXStPRgrk4fwIqF1lm//8Jd/SxsR2bqbg0EgNCdCFTulEQSh9Vphwc+zyHbURwxutWyGy6pZ7O5q0
	aoLtZSlPAS9k+Gf+7v43lysjCWM4E6UFLeU60k0YTC++cMnVeRmgZlht8l4zQhd+8iaL0vQktC1Tw
	uGRZ8rK764GUKBU/PATpK5PoEmMVLd85QfPEFCLWf/2kIILCeDEgGBGnQLe80WkmIeNoe2/aCAkCs
	4AsyhqOaq4KPzgHY1uDL6R+HeCKgogY6RchKOpuk+QswFswow5JYhQDRlFSig9Qjp5kNHtJATuANy
	ktbhGo2Wg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTUVW-000QDn-2U; Mon, 05 Apr 2021 19:03:30 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTUVN-000QCy-Ct
 for linux-nvme@lists.infradead.org; Mon, 05 Apr 2021 19:03:23 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 135Iw5mc005654; Mon, 5 Apr 2021 15:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=m0ecolulTnrDh1jRezWliNsQWzFt/8cjc5XmAibxfdU=;
 b=Vdz4jNDwTCMYPkomIkdrStfKk+kEn8enicdwxvK8fSd2YzHwD/iHvQDAL6rNC7lltL/B
 3YW2jOH2nDRA/XpNAo5I+xwVoStCwHvtSdI4oV4UThCKizh0rcyDbMSQ1RRDPcRZKqrS
 jry4kn5TBMchjj2Ykz8mxggaSbU5nk3yXnpA1a5QCAHgtfhOgp4wBJBgZe1AVyRzJK/i
 BcF9zK2Uhcq0blL+RUxF5Y/CrBsOQlauDDsvJoSpZctyZsNl6BOaZBJDjGAuiaP95HAx
 ooWsJa1+bS476VCQYvL0f0LOoOXZ+LxQnuk+CppKsfauQluUcZswwbOvSE6vzWyT8O0s DQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37q2my4d3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Apr 2021 15:03:17 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 135IuNs4040365; Mon, 5 Apr 2021 15:03:16 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by mx0b-00154901.pphosted.com with ESMTP id 37q5qp44q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Apr 2021 15:03:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx/88mkaP294ScuJ3IWo+MjVq4Xygh2as5Mri1AFhu7Svpu9KFCc2hUEFyc/Uz0QmJ00xo+f6KVO07svcnTgZMuUDFD+FwqelBZdGIOyBsxlw4PKVlh6Gb4A74rMX6KG6dcZONPj/a5OIFAR+Lmm9kum+Ujw2/42CSwPIgeEGjUO0xEVFlCHpRnupuzDyw/x2vXSIu5HX1jWZ6Rz8TEkuse1/HjC7WMctrEGrIAe1cAmsNOh++lVkhISAVWtFjGakel5hn0y0kNXSblbUCWfNzQ8Qzww3hsgQGDBv2Qu0lDWtB6tuT/U7sdrDiSmDAu0FW/pW1ybYauNWHsqhyum8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0ecolulTnrDh1jRezWliNsQWzFt/8cjc5XmAibxfdU=;
 b=BE+onX6vFDkFjxQWzu7Mto6wX7MWoNtbGd0S2KSgSxpdsqBa5uAIyO90RUEADaXjBkdUsz4WNWEEhInoc3FRiTTJZH14NZByoZctsESVgoJ9lhAIwmTbo24WLu0ASaA1ChVi/YyJO+Od0um+UGtP3B1gcLc7mmiSMDF5t1dg5HPu2yeH2XQgZGe1nuWYfkWg1ENMAMxsa/9n0wl7U7iRTG2QDuj+yxRdEkJFZpI5xHPK0CGmQjac9Ho1aKTdvkwjow5/5Fyh2VDo4o8TSRtmN9fb7X04a49/IPcpzrSWDBHT7OGLY9enZOQrnpsN80XCs/umcMgKw196OBf/oB7amA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB0956.namprd19.prod.outlook.com (2603:10b6:3:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 19:03:14 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 19:03:14 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXJg4ljd9fP2lGgEaubk2tJqCUwqqmUBig
Date: Mon, 5 Apr 2021 19:03:14 +0000
Message-ID: <DM6PR19MB40119BA91B16B1AEA03147E4EF779@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
In-Reply-To: <20210331091314.48925-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-05T19:03:11.4318613Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=86b3ccec-bd44-4909-ac3d-6f12839b3779;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [87.71.31.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5afc949-b9ce-402a-d9df-08d8f86576d9
x-ms-traffictypediagnostic: DM5PR19MB0956:
x-microsoft-antispam-prvs: <DM5PR19MB095648585DAC9E72E603AD7BEF779@DM5PR19MB0956.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YgXy+zq3DY/yCmD8fXYn/aYGIu4YJrr94uQuXZYBnSFrd4zeJc39X47JndSmv0hAsZMx4kzwUkEwC6Ou953MPmK/EN5Q7Xn52g5nDvX2Xdt0Up1XpilkI6KU1vW1vAmMIODFJlHTqzclEJajkHWvANFHbQawAUdBMHphUC6pTxCm0DeXCyu50fACMnAo+76clUNflWeNpMHAITp1sfgBhNyTXSnpTJ2a+EcA09nUw9tOwztuoy2ZFHTdxbm96O6uA7lHF/55k2gzZdFrsVdAsArY75RY5r9+OF95vMJuW6apZkYiu3QzWwZ6tUgovX9bkv4Y8RvjG9S5aWl/DTLrBwC9C4ptkewYf5RGpziL/T5nLZCzFCacajMZxGRSmHbbllO13EVFCnsgkqc+K2Bc0B/YnMs/SFYWPOFSYNN3FUbswT+rAFtSFObDI3+CV3twMQRtwmGcGcWblfLYDw0QAp6EjPRx1Rt855BWRcuQdyLjY1zMGqNCt3pfBNDpZep3/4OKkGQqXvwsX1aw8BXCqVk5EwcroLfup8PLynH0tMifzGr94IaIvl3ycBnIBgZYHoxoR+MT5OozPuemRfBulkmZPCf9GXcPuW4XdCVJZTuZu0dmqV26JCXHAJl7czjnFHmiQ/MKvWMK3Vsmyqakg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(2906002)(76116006)(6916009)(55016002)(5660300002)(26005)(66476007)(33656002)(4326008)(7696005)(66556008)(52536014)(86362001)(186003)(478600001)(83380400001)(64756008)(53546011)(54906003)(8676002)(6506007)(71200400001)(38100700001)(8936002)(66946007)(66446008)(786003)(316002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VjNvbTBFcjMyTmJYQzltTkxKdXhBTHRHWHd4VWwrOFprUjZEOXdBT2t3NGxs?=
 =?utf-8?B?VDJydDE3VE9aVExHTUU4SVMxSjN3Vm5oVlVMOXV6T1BZejkyTjVrcU80L0ww?=
 =?utf-8?B?blNwbFMxL09ETDZ6aGFoeEUxbXdkZU5tL1hjR0RmczVMRThYTUhFNzJqR3dX?=
 =?utf-8?B?MGk1VXNQSnZiNEZPNWQ2R1c5c29SK0diQmR1S2NwSHFHbmluVnhMbW9RUnRs?=
 =?utf-8?B?eS9pMlVxUDV2bGUvM3QyWUFzN0diUVlKWTlZVmh0SHVPMS84UmJwc0ZBSjkv?=
 =?utf-8?B?cXdIa2ZqY2k0SVpZUnFhcEMyVjRRNFpPWGFlblBTaW5jNTJpOW9ZcGtNM0pu?=
 =?utf-8?B?NXVCcUkyZW5IVDF4b2JwNlpCN3p1RWZSNVlwcVFGcmphUW5XWVlQZVgxNTRi?=
 =?utf-8?B?V0J6Y2RlY202MWFubWtTbWRGalVjQ1lSaXpvMmVhdndOZTZrR2NZT1pYemlZ?=
 =?utf-8?B?dlFUeVNNY0ErQnZicjVuT3F1K1VjMXh1aWV0VEtNbHYwb1RoZ2MyVXFac2Ra?=
 =?utf-8?B?S3dnQ2ZQWTRRajZITGYwMEF0Wk5pWm4rcFZXcU5MY3FhdDhEa1BXQ29Zdk9X?=
 =?utf-8?B?aU92OGMvLzVXVnJmd3E5cXNsUGdRRy94TWRCVndITGlRb2lPLzZkN1hUZVlu?=
 =?utf-8?B?d0gwbWdWVEd5Q0srcWhJZ0J5LyszNEQ3R1hqaGRXM04yQUN3WjNEQUJHVnY1?=
 =?utf-8?B?TW5zQ2hTMVh6TXkrZVA2MjJUVmtyS0ZBRDdqZUNxaktVZXpjZHpDcXZFSDdR?=
 =?utf-8?B?L2pYR3orTlkvWlovcWplQi9MWndwTEpuL2p6Uk9hQ28vd1hnbitWS0hCcXVQ?=
 =?utf-8?B?M1N6cExlNFVqdXd5Sk85eDlqT3kzMExFZTV3Ny8wUDB3cjgrVUMxSmcvcjNV?=
 =?utf-8?B?WTZpL3dOSm9sdTlublVaSnZ5YUtnNEdQdkZnM1cxSWxwTkJJZStKMHRsVnhs?=
 =?utf-8?B?SnRUYXhpckJIWWwxT2pxdU1QTEtvNjY1RSsvb3l0RDBZcmxDeGZnTVRGc0Rw?=
 =?utf-8?B?NzVlSnY0eWRrRWRyU3pEUlkwdTVRWUlVeTNQelpIbmMvKzBqU0RZVkliR09B?=
 =?utf-8?B?djMxV29pQjhoUDRyUmx3QmE1MnJXRWZXVVFBTXdVeWhHQXJRV2tGeWlMdTds?=
 =?utf-8?B?ZlJGd3N6Tlh1ZCtTR3pVTzNvRnQrL3dJU0xjRS9vT0szSVRBUG8zbGNNQU1W?=
 =?utf-8?B?c2NhUkJTWXpZbUVtT2NMeFhXR00rZ2JMaFZmWHNTRFVXbFg4emI5UWVRZ0Ny?=
 =?utf-8?B?eHhrRlhGa1FnS2JpY29pSStnSGNNMkt2NmlMT25hTWtxNGdPa2E4VEJ0eGNK?=
 =?utf-8?B?cnM0ZVQ0VitSdVBCVkx0OWt2dHZhZTBmM28xMTVZa1ZwelJhN3FhTkpVM2wy?=
 =?utf-8?B?N3N5QWpSVkQwNlI5RHdZM0ZVRTRYWnZaaGN2ZjNxcWdmK2c1b0tWS2hhcHR1?=
 =?utf-8?B?YiswVzhBeG4zVnFPR3FobFhSUkdyaWFyR0x4eC8yY0Rpd2lHVEMwZTVub1Bo?=
 =?utf-8?B?bkNJYlVadFZveXg1M1l1Qm1ST1F6QVpubHZQYzIzbjRoL0FuQ2hueGxYcExL?=
 =?utf-8?B?bjhkL2pkejJhRE93M1F2NUMyc21JYzd1clFMRUNPNEpPeDZObk1zRmkwNnFr?=
 =?utf-8?B?RlpDSWFqeHNBUDdSTDlDci91akdLZmIrdnRNTUg0NmplYkFxUTNNbkhsTFpB?=
 =?utf-8?B?RFhFMk84NnFOeGNTNVQrOSt3Z1ZuZ1F2VC90b2lubXpDaGN6OXVDMXdhVERY?=
 =?utf-8?Q?UE6Jl7IO4FqB4YJXzY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5afc949-b9ce-402a-d9df-08d8f86576d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 19:03:14.0785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFW+GBOvbkoA1bGc8eeI85rj4n5q2RcuG6AgDRlUeHnhuvhOGYnKsBTD/BR08feCr8nyeZCQ5tJt6S4UC44NtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0956
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-04-05_14:2021-04-01,
 2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050120
X-Proofpoint-ORIG-GUID: kMVZtQNI9b1XVA8V-gxCouwXuhY3jZbu
X-Proofpoint-GUID: kMVZtQNI9b1XVA8V-gxCouwXuhY3jZbu
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210405_200321_974233_706B244A 
X-CRM114-Status: GOOD (  25.25  )
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

Hi Hou.

I tested this patch on our system and it solved the issue.

I think there is a minor issue with the spaces indentation in the patch:
+		    len && len < cmd->req.port->inline_data_size &&
+		    nvme_is_write(cmd->req.cmd))

Thanks,
Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Wednesday, 31 March 2021 12:13
To: houpu.main@gmail.com; Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

From: Elad Grupi <elad.grupi@dell.com>

In case there is an io that contains inline data and it goes to parsing error flow, command response will free command and iov before clearing the data on the socket buffer.
This will delay the command response until receive flow is completed.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Elad Grupi <elad.grupi@dell.com>
Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/tcp.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index d658c6e8263a..0759eef3f4da 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -525,11 +525,36 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	struct nvme_sgl_desc *sgl;
+	u32 len;
+
+	if (unlikely(cmd == queue->cmd)) {
+		sgl = &cmd->req.cmd->common.dptr.sgl;
+		len = le32_to_cpu(sgl->length);
+
+		/*
+		 * Wait for inline data before processing the response.
+		 * Avoid using helpers, this might happen before
+		 * nvmet_req_init is completed.
+		 */
+		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		    len && len < cmd->req.port->inline_data_size &&
+		    nvme_is_write(cmd->req.cmd))
+			return;
+	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);  }
 
+static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd) {
+	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_tcp_queue_response(&cmd->req);
+	else
+		cmd->req.execute(&cmd->req);
+}
+
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)  {
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue); @@ -961,7 +986,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(req->cmd->common.dptr.sgl.length));
 
 		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-		return -EAGAIN;
+		return 0;
 	}
 
 	ret = nvmet_tcp_map_data(queue->cmd);
@@ -1104,10 +1129,8 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		return 0;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len) {
-		cmd->req.execute(&cmd->req);
-	}
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
 
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
@@ -1144,9 +1167,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
+
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
--
2.28.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
