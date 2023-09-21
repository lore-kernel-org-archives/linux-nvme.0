Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E16E7107F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Sep 2023 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MScDonCc0b62yv07BQ13rVCo8KQjUi3gVW4pFVPxsqo=; b=tSjCWbgEp07lD2Y20BrLNxw+Oa
	XNf6EBByykpSJ02Qu31tFBH2k5HyK85sl5PBGWdqonGuNWOHDUAw2eGAYevxT3Dqy4cBqxITn9kI+
	w+0RFlogZTZn35MBbuJ/zkSvX+wvByhH4wYjZc3LI+0wuYhMl84e0lP2H68tL/al/s/21DaHFzdf+
	urkPedF4e+dapZfPn2XB5UZNHIKuOAZr3/3PmDvk4tOk+M6Yvu/zSvyTlNlFndhfaazFMVPoQPp4d
	+QPmmStQ/D7qY6PNs4sRZhTqwSkIFGUYhe1q3lgGlE6Ae7bVjkuuXf7a2P/dOlPRMTBFoebo1qZxz
	c7JG9Fnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKmj-006Izg-2l;
	Thu, 21 Sep 2023 14:36:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKme-006Iyv-26
	for linux-nvme@bombadil.infradead.org;
	Thu, 21 Sep 2023 14:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MScDonCc0b62yv07BQ13rVCo8KQjUi3gVW4pFVPxsqo=; b=LNWiczvh6S0yRM5PBcneT4roRr
	ZRo7Zc2/JdYb2QPmsbPcQ5S++lW6/EO5cN2/47SeC2G6NnvRWiS2auw1o3aCuQNO4kpYJJS5LQoW7
	R6S37NiiebnZM/u0p4luF3qXLwAUB7ZkrapRlPJ6LWHpE1SZDuqa6dGDO6n7gofvmR44489U/XEME
	xSwrjfLW7e4EuQaLRV8jheo6rOfxDQ00ETnUvqPIfKMap6XxGRrl81uSzQcnTllOcuivSkqg/DHDj
	bKVxUeLyld7cuAwh2xKvhlpQigU0ANsnhiDVbpgr7MzcPQ2n6HMpI7i+Gk/hXgA1ObKDwW9btg+Ey
	7WQGgVMw==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKmX-00FRty-1l
	for linux-nvme@lists.infradead.org;
	Thu, 21 Sep 2023 14:35:59 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LDLmCP006292;
	Thu, 21 Sep 2023 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=MScDonCc0b62yv07BQ13rVCo8KQjUi3gVW4pFVPxsqo=;
 b=bHXCzO2osOuAS7MdaAJj4vBhxSQ5hZgTy4f8cnxKlskaNBNwK9BA9XKSlgxiGKZJo2Of
 YshCHYc27tRzUxvFqoEDsalfLnNAKNkL3zjZAwVjQRXjAw2qk8blhFXXckzuzqVnUv5t
 asLH1PK6DWdxpJ34uPH6+hM8mx4Hd6gHu4EdpIhtoG3IvzHbazkzTHHBqF5p8ASONsBS
 kJ77qKltaUid+3EwlyCcv/g6syoeckWbk1nbZWNvcTvmmARHO0yy5+SciExpx5/pQ4bv
 0WLuzynAPd+75EgQbQZWOdkSMFNQ/CaMZwPx3EsZnWwqMkTioQcKWYp63RO8P+jtrjyz aQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3t57e4rhgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 10:35:47 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LDnBel036318;
	Thu, 21 Sep 2023 10:35:45 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3t8hy1cr94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Sep 2023 10:35:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Oy+gcfwbWYjVYY7Qe4H6f+lfhfm3oePdHx8rVy0sxKS3Rr4m/iEIIzrds6U9Wyip0I7W+myySbr/1dv8Ysy2xWetgTIME2/SGjxbiyzpsEOzzYIMM54bGltJPkIBFg22XKe7YoPCQiLNwgIvfJNzqMtwhCl/dyRWY8ykVqVU2FevjW+RymxIBj+67Bd4WnXUy37RMKyJtjkyw6uTuqslX9Z+GTIwcr50a/rdnZqUYQj1dBU+xLvZa3CzgH7t4J4SLe6vssP3vSk9RsgQiusUsC24FRUZybpiQOOdgqblUgUXA//90Z2mBOBCy9VjUCMU5D3yHJmO+fZDcNicEN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MScDonCc0b62yv07BQ13rVCo8KQjUi3gVW4pFVPxsqo=;
 b=Ntc+zvpXzJT7T2jZzXpuGeakRt2Fgs6oD928/YUauAA/P/3vpabvY2xnYBg//Ib6RgyABQLPKLDtDOFQ8SzOeNKDpsnJAW5ZyghYJXvVW0ygMLb/zGy9M1e9H+TTxwNNGKrFwnmSscwtZOEg4Ct324zCQkZ10aVBUv0BeKCQZZEHRli+/l2rt0mfeLFKLNBCN/Yb0RwYqlWJ1gJzfOq8kbWzDfuYwD0Jw260hD3QYGU5JjX+th8WmNLT690mZaS6fDuUt/qMPa1a+xG8cG5+zdWpB1HLPmkTyyR4w1GB1dBN+ASvKGS5rtm0UQaDvvDSQii8yLfZN/hzA/6jTCOVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by MN2PR19MB3982.namprd19.prod.outlook.com (2603:10b6:208:19e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 21 Sep
 2023 14:35:41 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::ead6:2ad8:b994:f780]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::ead6:2ad8:b994:f780%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:35:40 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>,
        "Zinger, Eldad"
	<Eldad.Zinger@dell.com>
Subject: RE: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Topic: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Index: Adnq7iO1RAClALWAT0iWmuSPClnDIgABdewAAGkrfkA=
Date: Thu, 21 Sep 2023 14:35:40 +0000
Message-ID: <DM6PR19MB40116A2E3CE52362399227F2EFF8A@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
 <8e8072d2-1564-4879-8f00-682f5367bee0@grimberg.me>
In-Reply-To: <8e8072d2-1564-4879-8f00-682f5367bee0@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-09-21T14:34:37Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=3dafdc79-f067-4237-8200-a30845c6a2ee;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB4011:EE_|MN2PR19MB3982:EE_
x-ms-office365-filtering-correlation-id: dc2531aa-e699-4908-3492-08dbbab00782
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iA0jFLAZ0n/Y/ASjuPhfQqOUYovGnM3PrffxHrMUDIR5Ws1WA4Qz6GN6zomIYagLK0ZoL/7EUSKQBpXtZoadCJ994vkZtp2KXOZtcgoKL8OBTTNqngyaYoSU708QxaTnG4l9zDPlgxuTRLaMYohO/zEnosHwQGJjmU+Szisx5gjOSkWW2kYqf4zdlZOcDT5rVsRdOrkjML/GxtG12phvbnJXhVQ//XvJ1T/8Ow8QttTWDiccxTRoDD+OT7S6Ajj6QEoM+WfXvBYi9gWWxexnOH8ko0cX/UGW388CE83fOYbevVOy12wQuouqQqR/vZkgCNnzFaQSHeCw65x6ceWK95QQM/2CTrdzOv7aOqSj9amT8GxTjZc6xas1DKIzuy2DWFCQV91qiq7yaTR2njzbdGxPXdW6bWsZUQbMpJ3cSPzrzSVC3y/5Xl+14B6CozYBLDuYSWGysSh6tIlYFo8tL9KE2/m9mEkCN6o+a9U25rlm2TDlu84yEDjrfqeNnwnzuGInop0azu4ARKOyyc7yHO/p6xookMVgDp0isui9TF40b2h3RkUMGeTT93FBairjJI6s3T8aQp6q4iz7OsGReyjdb1htbaXe4RaFPUdTVRpluxpg6i2B9pvG+S/I2HWY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4011.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199024)(186009)(1800799009)(107886003)(8936002)(4326008)(8676002)(55016003)(5660300002)(52536014)(316002)(786003)(9686003)(41300700001)(122000001)(38070700005)(38100700002)(82960400001)(86362001)(83380400001)(2906002)(33656002)(71200400001)(478600001)(7696005)(53546011)(6506007)(54906003)(64756008)(66556008)(66476007)(66946007)(76116006)(66446008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3hMeUFKa0dJajV3aXBZOHlRNzFlbmZGRHpFSElpMDFtOUwxdG5SUmZFKzVW?=
 =?utf-8?B?ejhUUWtFcG4xSllaZGhLSkhxbEdVWU5qNmFma1NjaDlJUEJST1ZBZkM5RjAz?=
 =?utf-8?B?K3VQdDBEVHREYVFMTUdWaWlMdll1d0ZscDYyUTJYWjBWaVJpdm1YbjNmKzZE?=
 =?utf-8?B?YlIzZEloSGR6VWN4WFV1R094RXlyd04vcTI2bzQrL25RUk9SbTc2d0lBUzgr?=
 =?utf-8?B?STZxZ3RXT0I3bE81Uk8rUlNTd1JCblRjTTl4N25TSitjTkpnd0xMYVh2TGJI?=
 =?utf-8?B?ZXhJWG4zZFRpbmlyVjZaUkNFREw0SmgvVnRHNitqRlNyUVVXeGQ1dGxMcXNa?=
 =?utf-8?B?TUZ4ZFQ5Y3p2bXZsWDNYRFMyeUY0OGxuZ0FNa0piUTRJQ2J5dEoyWlB3NXUz?=
 =?utf-8?B?SGRGcS9sNFMySktiWWIwUWhZR2oyelF2TExycE9HS3NqYkc5YTdlZFcyeW84?=
 =?utf-8?B?SXZmamNOZEQwNUZnTE9Yd0JSUXlJVEIzSGVFK09PNmdhWjlMSXdIaVgxV25s?=
 =?utf-8?B?TlgzMWNWTGJ5b3IvV0NjMjUwZzBiSXFPZlk3c0hWTlRTNTE0WERNWjZGRmdV?=
 =?utf-8?B?T0FsZzc3cUxmTXpZY0ZTQ203UCtZeVZwdEFqWXVtYzJtN0xoRGp1RjJIYXVN?=
 =?utf-8?B?UkxYcStxOUdySXNDY2dWdHZnSjNTeUdnRTdwaHYzTnQ2OWIxNExJMlpMYVJi?=
 =?utf-8?B?RHRrek9CY0pQWGNvOVVqcWhvTWVFcStmU3IzODkwUm1qeVE2SDNoaUF4MzhB?=
 =?utf-8?B?b3ZTQ3lFa0liQXVBdVBPeEFYN2JiU1hlcWp1b1YzaXRxQll3b0VSanExMEt3?=
 =?utf-8?B?bzhOSzd0OEJoamxLSTdKKzBZTFZWZEN4RUFXZGJBekVwbTJpZklQWFRsWlNk?=
 =?utf-8?B?b2FBWjZUdXVKTVY3NHJlSGVxWFVsVEwydEhTekQxVE9PdFRXTldSaTRENGE1?=
 =?utf-8?B?R2FkTk9USERkWHhPWkhsL0dxRWVHeWEvTi9HZ0djbWRiTUdSc24vWG5SOFR2?=
 =?utf-8?B?VlM1QWx3c0JzUlVOUWdSNjM0cFdZOFJtUFFVcTNBQUtlL2JYbzFNWjQyaWI5?=
 =?utf-8?B?M0FQL25wU0NHRjZ3UFhYMnM5V01XT3BidjNYc2J1TjhjWHNIVnpuYXZYWDhs?=
 =?utf-8?B?QU1LWmVUc25IZk5Ea3dRcGdZR1lMTnNUdnNkQWZ6dEovcWJaTE80aHdKV0NY?=
 =?utf-8?B?S2piT2ZpWGVKaWxWbXl3eHlNNTFGVElWRkJJQ3dDdkhMNVpndGlyYWxxdmdQ?=
 =?utf-8?B?dHFKaERrWVFCU0c0VW9LMy9JbG9oaTEzb2JBQit1YlVZTlZoL205cFFqcXdD?=
 =?utf-8?B?cStTS1dtVkUxQ0poOTJXandiTVZCczQ5QjBQWFo4OG0rSHNQRForZy9lUkkz?=
 =?utf-8?B?bzZlMHhtTGNTQmUvejNIUjdmTFJLaGlIMm5lQWk2M014WjJvQzBCNTRRZmRP?=
 =?utf-8?B?MnRkT0xHOHdiTTl6L1p3SkVnSGZ0RnhyNS9tRk1hbDJtZ0ZnMWJFRlRFQU16?=
 =?utf-8?B?aEQ1VThWcnVuS015VDVBUm9KZHIrdmVVTXVWRjQwWVBwTzNYZHh6d2VYMWd1?=
 =?utf-8?B?bWd5aEp3TXlvd2FuY2NDZW5RZDVMKzF3ZTVLZEhwSGg0enRGZ240b0c3Yjht?=
 =?utf-8?B?eFF2ZWlwcHFDNVZucU1qQnh2bzdzK2NjUGk3VG45eHBPR1AyNml4M01GU3BJ?=
 =?utf-8?B?azVNZTNpOW5ENnlUNGdxcUxPTVRBOWxTYVFPK00vc25oWExlVldIclNCcm1C?=
 =?utf-8?B?enAxVUdBRHNXb3UxNm9MU3RkNFRtS1Q1b3ZnSEJFOUtEYzFjVHhGYkl2dEFZ?=
 =?utf-8?B?b0lVM1V5cnlVbUh2R2Y1Q2s2czljTEd3MVJPKzBUdUoxV0VEZzg1elF3TTBY?=
 =?utf-8?B?bWljbTNqcmphRTlGbUFMblNQNE1JYTU5T1A3cDQvLzMzU1NXd1Eya3lqUHYy?=
 =?utf-8?B?Nkc4eW9PWU5WaGk1SzlOU2NHdlZkUDNabkNTMGllTEVrWUYzWkJBcWovSlNr?=
 =?utf-8?B?bW9XUjB3b0RWZWp2YytkS0FJU0lOUGsyc0hQaDhWdjBEcmV5MS9seTcvcDdk?=
 =?utf-8?B?ZUpSNnVmZGxFR2NrOUV4QTRGSDhxSXF6TWZTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2531aa-e699-4908-3492-08dbbab00782
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:35:40.5966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSWnK/kfywGzOTdOxxqZ5soLRXYxL1uLmMb59N9MmJ94r9kTsjcYTLCnvnJmu4+iHBXQK0meemxFqjToSKVRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210125
X-Proofpoint-ORIG-GUID: nsiajRpiXLAW0qQPsMAe5gNjLChmU_TW
X-Proofpoint-GUID: nsiajRpiXLAW0qQPsMAe5gNjLChmU_TW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_153556_547303_CFAB9D29 
X-CRM114-Status: GOOD (  29.14  )
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

VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVwbHkgU2FnaQ0KDQpJIHdpbGwgYmUgYWJsZSB0byB0ZXN0
IHRoZSBwYXRjaCBuZXh0IHdlZWsgYW5kIEkgd2lsbCB1cGRhdGUgb24gbXkgZmluZGluZ3MuDQoN
Ck1lYW53aGlsZSwgaXQgc2VlbXMgdG8gbWUgdGhhdCB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUgY21k
LT5yYnl0ZXNfZG9uZSArPSBOVk1FX1RDUF9ESUdFU1RfTEVOR1RIIGFsc28gaW4gY2FzZSBvZiBm
YWlsdXJlIG9mIGRhdGEgZGlnZXN0IGhhbmRsaW5nLg0KDQpFbGFkDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiANClNl
bnQ6IFR1ZXNkYXksIDE5IFNlcHRlbWJlciAyMDIzIDE1OjIzDQpUbzogR3J1cGksIEVsYWQgPEVs
YWQuR3J1cGlAZGVsbC5jb20+OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNCkNjOiBF
bmdlbCwgQW1pdCA8QW1pdC5FbmdlbEBEZWxsLmNvbT47IFppbmdlciwgRWxkYWQgPEVsZGFkLlpp
bmdlckBkZWxsLmNvbT4NClN1YmplY3Q6IFJlOiBudm1ldF9zcV9kZXN0cm95IHN0dWNrIGZvcmV2
ZXIgd2hlbiBkYXRhIGRpZ2VzdCBpcyB0dXJuZWQgb24NCg0KDQpbRVhURVJOQUwgRU1BSUxdIA0K
DQoNCj4gSGkNCj4gDQo+IEkgaGF2ZSBhbiBpc3N1ZSB3aXRoIG52bWV0X3RjcF9yZWxlYXNlX3F1
ZXVlX3dvcmsgaGl0dGluZyBodW5nIHRhc2sgYWZ0ZXIgMiBtaW51dGVzIG9mIHdhaXRpbmcgZm9y
IG52bWV0X3NxX2Rlc3Ryb3kuDQo+IFRoaXMgaXNzdWUgcmVwcm9kdWNlcyBvbmx5IHdoZW4gZGF0
YSBkaWdlc3QgaXMgb24uDQo+IA0KPiBJIGFtIGluc3BlY3RpbmcgdGhlIGNvZGUgb2YgbnZtZXRf
dGNwX3JlbGVhc2VfcXVldWVfd29yayBhbmQgSSBzZWUgDQo+IHRoYXQgdGhlIGNvZGUgaGFuZGxl
cyAnZGF0YSBpbicgY29tbWFuZHMgVGhpcyBtZWFucyB0aGF0IGl0IGNhbGxzIG52bWV0X3JlcV91
bmluaXQgZm9yIGFueSBjb21tYW5kIHRoYXQgaXRzIGRhdGEgaXMgc3RpbGwgaW4gdHJhbnNpdC4N
Cj4gDQo+IFRoZXJlIG1pZ2h0IGJlIGNvbW1hbmRzIHRoYXQgdGhlIGRhdGEgdHJhbnNmZXIgaXMg
YWxyZWFkeSBkb25lLCBidXQgDQo+IGRhdGEgZGlnZXN0IHdhcyBub3QgcmVjZWl2ZWQgZnJvbSBz
b2NrZXQgeWV0IChha2EgcmN2X3N0YXRlIGlzIA0KPiBOVk1FVF9UQ1BfUkVDVl9EREdTVCkgVGhl
IGRhdGEgZGlnZXN0IHdpbGwgbmV2ZXIgYmUgcmVhZCBmcm9tIHRoZSBzb2NrZXQgYmVjYXVzZSB0
aGUgc29ja2V0IGlzIGJsb2NrZWQgYnkgTlZNRVRfVENQX1JFQ1ZfRVJSIEhlbmNlIG52bWV0X3Nx
X2Rlc3Ryb3kgd2lsbCBiZSBzdHVjayBmb3JldmVyIHdhaXRpbmcgZm9yIG52bWV0X3RjcF90cnlf
cmVjdl9kZGdzdCB0byBleGVjdXRlLg0KPiANCj4gQ2FuIHlvdSBzdWdnZXN0IGEgZml4IGZvciBz
dWNoIGFuIGlzc3VlPw0KDQpEb2VzIHRoaXMgKHVudGVzdGVkKSBwYXRjaCBtYWtlIHRoZSBpc3N1
ZSBnbyBhd2F5Pw0KLS0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jIGIv
ZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYyBpbmRleCA5N2QwNzQ4ODA3MmQuLmY1ZWFmMzQ1N2Fk
YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMNCisrKyBiL2RyaXZlcnMv
bnZtZS90YXJnZXQvdGNwLmMNCkBAIC0yMDQsMTAgKzIwNCwxNiBAQCBzdGF0aWMgaW5saW5lIHUx
NiBudm1ldF90Y3BfY21kX3RhZyhzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVlICpxdWV1ZSwNCiAgICAg
ICAgIHJldHVybiBjbWQgLSBxdWV1ZS0+Y21kczsNCiAgfQ0KDQorc3RhdGljIGlubGluZSB1OCBu
dm1ldF90Y3BfZGRnc3RfbGVuKHN0cnVjdCBudm1ldF90Y3BfcXVldWUgKnF1ZXVlKSB7DQorICAg
ICAgIHJldHVybiBxdWV1ZS0+ZGF0YV9kaWdlc3QgPyBOVk1FX1RDUF9ESUdFU1RfTEVOR1RIIDog
MDsgfQ0KKw0KICBzdGF0aWMgaW5saW5lIGJvb2wgbnZtZXRfdGNwX2hhc19kYXRhX2luKHN0cnVj
dCBudm1ldF90Y3BfY21kICpjbWQpDQogIHsNCi0gICAgICAgcmV0dXJuIG52bWVfaXNfd3JpdGUo
Y21kLT5yZXEuY21kKSAmJg0KLSAgICAgICAgICAgICAgIGNtZC0+cmJ5dGVzX2RvbmUgPCBjbWQt
PnJlcS50cmFuc2Zlcl9sZW47DQorICAgICAgIHUzMiB0b3RhbF9sZW4gPSBjbWQtPnJlcS50cmFu
c2Zlcl9sZW4gKw0KbnZtZXRfdGNwX2RkZ3N0X2xlbihjbWQtPnF1ZXVlKTsNCisNCisgICAgICAg
cmV0dXJuIG52bWVfaXNfd3JpdGUoY21kLT5yZXEuY21kKSAmJiBjbWQtPnJieXRlc19kb25lIDwg
DQorIHRvdGFsX2xlbjsNCiAgfQ0KDQogIHN0YXRpYyBpbmxpbmUgYm9vbCBudm1ldF90Y3BfbmVl
ZF9kYXRhX2luKHN0cnVjdCBudm1ldF90Y3BfY21kICpjbWQpIEBAIC0yNjUsMTEgKzI3MSw2IEBA
IHN0YXRpYyBpbmxpbmUgdTggbnZtZXRfdGNwX2hkZ3N0X2xlbihzdHJ1Y3QgbnZtZXRfdGNwX3F1
ZXVlICpxdWV1ZSkNCiAgICAgICAgIHJldHVybiBxdWV1ZS0+aGRyX2RpZ2VzdCA/IE5WTUVfVENQ
X0RJR0VTVF9MRU5HVEggOiAwOw0KICB9DQoNCi1zdGF0aWMgaW5saW5lIHU4IG52bWV0X3RjcF9k
ZGdzdF9sZW4oc3RydWN0IG52bWV0X3RjcF9xdWV1ZSAqcXVldWUpIC17DQotICAgICAgIHJldHVy
biBxdWV1ZS0+ZGF0YV9kaWdlc3QgPyBOVk1FX1RDUF9ESUdFU1RfTEVOR1RIIDogMDsNCi19DQot
DQogIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1ldF90Y3BfaGRnc3Qoc3RydWN0IGFoYXNoX3JlcXVl
c3QgKmhhc2gsDQogICAgICAgICAgICAgICAgIHZvaWQgKnBkdSwgc2l6ZV90IGxlbikNCiAgew0K
QEAgLTEyMjEsOCArMTIyMiw4IEBAIHN0YXRpYyBpbnQgbnZtZXRfdGNwX3RyeV9yZWN2X2RkZ3N0
KHN0cnVjdCBudm1ldF90Y3BfcXVldWUgKnF1ZXVlKQ0KICAgICAgICAgICAgICAgICBnb3RvIG91
dDsNCiAgICAgICAgIH0NCg0KLSAgICAgICBpZiAoY21kLT5yYnl0ZXNfZG9uZSA9PSBjbWQtPnJl
cS50cmFuc2Zlcl9sZW4pDQotICAgICAgICAgICAgICAgbnZtZXRfdGNwX2V4ZWN1dGVfcmVxdWVz
dChjbWQpOw0KKyAgICAgICBjbWQtPnJieXRlc19kb25lICs9IE5WTUVfVENQX0RJR0VTVF9MRU5H
VEg7DQorICAgICAgIG52bWV0X3RjcF9leGVjdXRlX3JlcXVlc3QoY21kKTsNCg0KICAgICAgICAg
cmV0ID0gMDsNCiAgb3V0Og0KLS0NCg==

