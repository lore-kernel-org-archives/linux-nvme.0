Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F3FC36008
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jlv9fqtsZUZTS63QpIy6vTZT1jUG9V6BEfo2IIUzJHo=; b=pbYbOuiYlj7nhncKaoRR/YbK0L
	a8TesxR4ronkVKlgOyHpHhfEKDk73hYPOy1yKcNx9J05Elm0QBPpTvcqQNr2fqlCbGdv3uclgn+5t
	xmXguYRwwCNgE4+jRYyjH/YTdzkNo66mN7glkxPA56L+V0k157pW6UBC4cF2EinoOyufzGj4uz2ZR
	x9d+tediZ2aDysKQd2wE6L3B7vBNsaLd6ftXGTeG6NOUnacImt/ZaKsfqjChWQB7BfpewH6WD2ZZH
	967u0AjFBFOTGdiJ3+EQvWT++UWO3wZ6zIBifDbziz3+OL+93uzYiwizQk3z1YmctZHWgb1KFxs9U
	tn8druGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzWIS-00000002Duv-1Fdt;
	Tue, 01 Apr 2025 07:44:32 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twAU8-00000000XAA-2jzW
	for linux-nvme@lists.infradead.org;
	Sun, 23 Mar 2025 01:50:46 +0000
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MKjJtV003241;
	Sun, 23 Mar 2025 01:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=jl
	v9fqtsZUZTS63QpIy6vTZT1jUG9V6BEfo2IIUzJHo=; b=oTG83XK0KGa2inY0kI
	4b3jaGZ8Poexa2f7IFFGyb4VWMq40NIGWU3/VMVEZKdF83Ytvj7dGXqsC1oj6Bwl
	ImelicypUXZo/7zGdB13S/Y5RKWIxBfD0FtHyP7hzvGaaus5keseLBOBT0POiUCC
	k3DRR+mVyWUJ9G5bu68Zmjw8x+YlsZuK6dxVjX5BfPO25kUpUtRU1AuS2QV/Nkbv
	eHRotXQiHnfEnfpSpiyAUTp7F8jalxfQEigTlzF0CWoqsc5D8ega5/ZlC4B3DgdU
	Sq57X5Z7Gvz2TQnldmkySBFFfmHfeFSq8k5Qda/8sl/OAvF97n4lnaryKg+AM+k7
	eVlg==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 45hpdfcapg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 01:50:40 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CAEFF8047A4;
	Sun, 23 Mar 2025 01:50:39 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Mar 2025 13:50:34 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Sat, 22 Mar 2025 13:50:34 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Mar 2025 13:50:29 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InK/E12s6h4IROQ8ewdh66f+g6H+nxcEcCBLYbCM/LJXbEwFaPiDqVqxKkdM6TdZpu7DuzW+tDLpq//8MNvzZiijJz47g//XtWE2cp6A+M3eKvQQZYTBy24esAYUYM59FeyZvbLgaSyhEEU8hs3btXEAyvvUJb+4ZY6bRjw0DiLCRc5Nv4o7Nj4QMxjGvxkEC1VyG0aM+PSiW5YAD+4S7q5/RQhUe1GBoFAywe/vm3MBWdlsggwXRNNj938NQVaja1lfH31yyUnS4suJ6y53Rox6CJtzb9Mrw7NiNFr5r93rj7wmu4U54937E5Jrfekek6gR9FG7WgrhzroMCGQp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlv9fqtsZUZTS63QpIy6vTZT1jUG9V6BEfo2IIUzJHo=;
 b=MswYQktSgQNo9aD58o5kfiZN4mQWIrCaqhIixswW34Li6iu08/GUR3q8ecwQYYvcAmO5pUAbLfcxUokSFbIdC7e+ZOBXDbasimksQBUtWcQ1HuIeUBjqgmQ8kV/49r+2VGAbOz8CFERy0SFgycbHBae1JsuJjAxqdGREUBgQNBBpzrIjD2K74g6qiDFJd/V62VJYJ+LK7vQzPW8d++gKAchQi5xwm1vu9X6m5AmLotyfaB1QFVXDmz9N1z3WX6/Jata+oBKgxAL89QPkxcmAY9FTNZ0cd4pNGVYRmC+v0GUJzFPSqePr99xbyLqQcfP6tBi+Yc0b8hFcfGgCLBPddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:166::10)
 by EA2PR84MB3753.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 01:50:27 +0000
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836]) by PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836%7]) with mapi id 15.20.8534.036; Sun, 23 Mar 2025
 01:50:27 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [LSF/MM/BPF TOPIC] Migration of NVMe namespace between subsystems
Thread-Topic: [LSF/MM/BPF TOPIC] Migration of NVMe namespace between
 subsystems
Thread-Index: AQHbm5XzkJxs+WmQXkedmp9tBqbU+g==
Date: Sun, 23 Mar 2025 01:50:26 +0000
Message-ID: <PH0PR84MB135848617616C0EA5EB9F1A798A52@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
References: <PH0PR84MB1358059A6504FC5D37CE327298EF2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB1358059A6504FC5D37CE327298EF2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1358:EE_|EA2PR84MB3753:EE_
x-ms-office365-filtering-correlation-id: 412cd15d-caf8-403c-f95f-08dd69ad15ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lEjcFDaxvHMoQUJAeDjH93AWWEdHTT9JHhSRUiJrqF8VOqOydLvEj8qBNIwr?=
 =?us-ascii?Q?1uTctFMpe8zXBel31N8ad5h+IkVG98mynwkVYQ/NeMpo72dZjcnQ85t8ayX/?=
 =?us-ascii?Q?J7JKyu7U0xLHqZW2gkxJPVFNz2dTefyhFe0g+bd7u2t/H7RqZyuGlMrviVNM?=
 =?us-ascii?Q?I/+VQuvRtoKE832ZJHdPMi8uI+0XTZqL3GX4FZOQH8OfRS7XkN+1alKUdTXc?=
 =?us-ascii?Q?tfiNn3GgUrsKwjb2w3d20jbQp5IFw3njtTItC8ShSkgI0A3ubQmIQV9/uv0L?=
 =?us-ascii?Q?AkCevOQK8KZB0FA+00/TKzW58olHbgMATBpUSe/LwajIQbitKmcnPz1Mz29R?=
 =?us-ascii?Q?dxXsmAcnlYkXaE+m9/tw6oAkF4Cb4GTjQNtYuHCxlD3nn5RjUWlVMfSycWUQ?=
 =?us-ascii?Q?6FG0nnDNYCrkyvf1rDAr2Wpg2WLgB9pZYljwST+CKq3b+uJnDvugDbf1uzjJ?=
 =?us-ascii?Q?IBhxeAIpHz1+WXZNM0X2QrFHfxu5lb1Dw61h1jsff4dSgzDX5m0zAzPIFs1R?=
 =?us-ascii?Q?XyDpZTvgMThoahMd3d47wDAnjPCMwX1ZPGtasukhx3SFYJn7dMaFGvpss+ED?=
 =?us-ascii?Q?UJuTW8Z/Cmyq72tErPxKmMC5CtaLlf68LZ6zZZK2Q2gBo+f7b12M64193stu?=
 =?us-ascii?Q?oYXxKAk7T29sRogK4PWURpxvL1QLJ3Mwq3SAxl6Ia14rVbJqGRQS+hlwIQeB?=
 =?us-ascii?Q?ByHyjy3RhFfbpKGuZjQrDg6BAuzsIPx0AWrSfUReWYI5ptK3Zc6znZST0HxL?=
 =?us-ascii?Q?gWJV8qHoRQ2iTtLlcuXErAjoXvUop2QXWWb/yRdlvDpeEjEWT1l4rcLpkg0K?=
 =?us-ascii?Q?9v8ob3sfJnrMPs3+fKqRv5zZ+yYqAWHTgbEmB6zT2NY/3K8d+b6xj1oE3NvY?=
 =?us-ascii?Q?21ukcxsBYZv8SSUnyKkdeEBJKYiyb8/wSiiGcQJDIPwlgBuuSckMXcrwCX43?=
 =?us-ascii?Q?8xH0zzRLArB0LmNUqFSacJ03Dd3ZSWyjszLZ/V6Fyy1v/OQfS0H3wwnlHW5w?=
 =?us-ascii?Q?h/QK9R8cwzdp6MSw4IFZSpMdyY1kCyVCqLmuK+gwlMjdRxCui+5hVcax3EHW?=
 =?us-ascii?Q?yt5vCTc01M40CLBJzTbSLTOMoJOV1Iq1xMcR02bMRx6vhlFYrSsQslee/w4Y?=
 =?us-ascii?Q?lt011b9qpkbaNzBUogOTh1m9tX35xXsNGCkMApufCDPiTTcr9R37JO+wsKpv?=
 =?us-ascii?Q?mYLgQh5QUVnWVymIm+mUFiTiw2cITepA5PN1vJEWVZsRVqRhEzFnIpdwe7CR?=
 =?us-ascii?Q?9oP9BT7DUrzAO6e/kMsq6042WNjpS5lvZNLnA0qlTWyD5FBtICxAMQb+g44+?=
 =?us-ascii?Q?AYurayp4rhrXYIRuhP8QtX7oPXhh/vwelz4icUU3773Pzob7umfgIN/apyOu?=
 =?us-ascii?Q?1LoeOPuGigtvqkN1HgEB+XN5Hpkcjto7HLWJxCfQcFhk7YlHbqyhnH51o0uO?=
 =?us-ascii?Q?5K0weZ4/BXSGhSSivHITOI7E5GPp5CTV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VA+QZMWIHdjfEY8Y892eCgR/WPu9SqxpQA5hLy6K+x3Jf86tROySMButn0ew?=
 =?us-ascii?Q?clgJBlomDoRxb0rlaByuMLmKesPDhGHX6gudXdACZ6HBQK2Eg7u9CEvD8iBv?=
 =?us-ascii?Q?Pam2LlhCdCf3461RKsKYD/SHVey/6giLLGT/WoThbK2lJ2j75Enc3I54zxXO?=
 =?us-ascii?Q?QwjpwM2gVH3sOe1IPmir0IX2MMtPXq6Jp0pDTmgsvlISZ1gDEq51Bjcf59lu?=
 =?us-ascii?Q?MEC9hmaAuxRvDlVWdYllqHcqmRDXVl0NkMxZUpORoUXTmQGw1QGrzEMglGXe?=
 =?us-ascii?Q?dX+tIQQFVEThbUoE8w6mrgHv4KEpsvvd7xCMLwrN0KWWl6zSA05cPs6FDScT?=
 =?us-ascii?Q?TETBe7IHV71Gbjc2SPvRTVJy3acNVU1v6M9nDY+VRhGJ7RDUrZybJBhTuvkg?=
 =?us-ascii?Q?cha68ogeFOHBD3/9MiOKgvdO4ATp4qaHE99FaFJfsUCGX0ARCuO73A0H82Bm?=
 =?us-ascii?Q?aw8hNiN+2ypqbiud/udspwTREGbP/1Fa4OHISNEigI1T2pFqbz/BRmu5+Pi6?=
 =?us-ascii?Q?Cu0Ec4uJu0KUXm9tjBccE6CNQyCc0lZwl3HnssGeD/gXqBfrEBBjUrlQgF2X?=
 =?us-ascii?Q?NlDIvX2pKn0ytEQUy6mXHtAkMlaJuQXpC3D3j2tE1gjFH0louF4azPl3pVlD?=
 =?us-ascii?Q?jIFgximQ6hRxIyDVeVpeBvhsHym3UXfZ35Pycwi1EqV2yv8FItCTux5C8adZ?=
 =?us-ascii?Q?XA3/EAWpPPzNcsdu7S+G9zgwOvkdlgcUuS6JG5Z1A6WBitf4O6CnKtlplbTZ?=
 =?us-ascii?Q?Jp4DkKgZ4/cjN3zf40ry8h40kZwt+Oy/csc71V5f/DxdPsV03qssEAn6HT7v?=
 =?us-ascii?Q?VAmMPw6t81vihMcS9Y+9qH03WQg8jr7dm4kI29jbAuNC1+zSs3qNySC8etKT?=
 =?us-ascii?Q?rgr8jZOMfkv5LhNmpiNFznFQq3MmRlI8ae6Ja2BYtxJexTDxSH3kwInwG9lP?=
 =?us-ascii?Q?op+MQLx/zN10y1NFjj+KLY5byeisVoLI49lf2BXszcKVKzGrhyv2NeOjUoca?=
 =?us-ascii?Q?ieWXNTG88NWcN5/joirjSgUcnTujnor2kUTiA3rQTbOmy4fNnRDXX1eLBPYe?=
 =?us-ascii?Q?GGef2luYPAPVVCKMUAUV5WiwLS+Oa1gUKSEDpNCAqlwx29RbExdX5vHaIXe7?=
 =?us-ascii?Q?MWK2wmbtLRSvif7jPvMdaLbr4BGMEv/pSetyTiw2cJXYaVFuuF9xW//WfW/t?=
 =?us-ascii?Q?u85+xYxg/DTNGagb/KJOqz4+N2k9s1h0jKXbnY27M//f/M9PkoYHtl2FknX6?=
 =?us-ascii?Q?KLGKIQ2HUuWH18F3tSyb3h6Sc/Y0o5sFUl5yBfLnNg1VPKmru2jGlwYzPac1?=
 =?us-ascii?Q?5uS4dJ0loORIR28s+3vk4yP9Y8lhafYD8poRyg/SzcM9leiiByPmhb5Bjv+F?=
 =?us-ascii?Q?PNC0A3Fep+5UxZLl+/yLSwMvwhzgXvSdlARO8YqhvC0rYCYNBKqVb2bTBekt?=
 =?us-ascii?Q?M005IPuUZ5lSlClNrvKOIQl8BGpIupeXBdmYtR0540Y0R/1QIsN+HdDKyewB?=
 =?us-ascii?Q?sycduhZHBmdwACbta6jtidaScPz8tAwOg3n0ICofh5hzSS02LLoz0EJWS3qS?=
 =?us-ascii?Q?TDfQtW+ruHC+RZWBKCLuRY+a8jutBcGz9vfIMkjU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 412cd15d-caf8-403c-f95f-08dd69ad15ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 01:50:27.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNB1rO8vSwAWbLg0qC/Y9025wTsMt/Gz1o7zPjeaVGhiLzRHdN7+kTFnFrEXsKHMwvN2NY4ZvbP8FW6kD2gv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR84MB3753
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 0jZ6_TNQyhiy2B8LBygcUZ83MW1DxAsA
X-Proofpoint-ORIG-GUID: 0jZ6_TNQyhiy2B8LBygcUZ83MW1DxAsA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=914 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230013
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_185045_209856_9E31B19C 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 01 Apr 2025 00:44:30 -0700
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

The topic previous proposed as [LSF/MM/BPF TOPIC] HA features for=20
NVMe-oF is planned for discussion at 11:30 Tuesday under the title
Of Migration of NVMe namespaces between subsystems.

A multi-vendor team has been working on identifying common customer
and where there are challenges meeting those customer requirements
with NVMe-oF.=20

For the LSF/MM/BPF meeting in Montreal the team has narrowed in=20
on migration of NVMe namespaces between subsystems as a common=20
requirement that needs design work for how to meet the customer=20
requirement with an architecturally clean model.

This discussion is in the pre-patch phase exploring the use cases and
customer requirements to establish a foundation for designing new
methods that will enable migration of NVMe namespaces between
subsystems for NVMe-oF.

Curtis Ballard
Strategist, Storage Technology
Hewlett Packard Enterprise



