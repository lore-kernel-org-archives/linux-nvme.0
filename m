Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207FCCD1294
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iYN0UOinI0X2xecGwBqtylXaOKJ1t7O5ALI3HbU0Z1c=; b=0gZw5KihJxKSrr9God2HUBwIIe
	s6Vfum2l6xHUyiqDvIN89g07blb4VNHo3LZZaGyGH5Pj274w6KVHBLfRny8l6YH511plmEl7K9XA1
	1NW/d/dZBr66GjfzLehootcDVdCaTcZsed3WuaJIn5aKVkzEWyjEh8iJ94noJM4xrst3w+z41oHtX
	Ur4m8XD7pyIthsEt3Hi5Bib8fMOdj5h4SPPgceVcE6Lf460gwJCok3lYRlMp/7+TIqOHDMVvWKLUE
	V5tK/BeVTyCTfvPwmshqBPknFmlDPXEIFNOs4c4c3Nshu6dU9DdMQYk5Y+u/Aao50pJQIGEASRiG3
	NW6CinsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxuy-0000000FXXW-0cnm;
	Wed, 03 Apr 2024 10:32:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxur-0000000FXQI-08Tc
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Apr 2024 10:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=iYN0UOinI0X2xecGwBqtylXaOKJ1t7O5ALI3HbU0Z1c=; b=hEjo/mxwdM1uROco427l1ETtNx
	FTUWc/piC5Mk479SkO1Cql+QhRl5prwx8LJHO4eylEnBPgCzleTlNXrCcSGaxtzrqc2Bg4Noy+jch
	E8LixnkPNg1bBqGyxnSJqyBEW02kDrj94wlS7o5Jo8+MT/POnUxQMVLMU28KbottTNGTGIoY3RL31
	uQC1uZGRc56lwdZge5IUue83sZDcZHfMsfBHSANuCC1wtQ62P7HZK/5AxS452ujDe5yiwPYPxEU06
	XtDctjj2ZUZaFwiXDtgHTys57rulz/UVbcd6Uqyw+/5oKj3XHP01j6SHbwfKEqIMkgk51HtxNrDHT
	9oSjrUOA==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxun-00000004AP6-1puw
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 10:32:23 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4336ODJB031466
	for <linux-nvme@lists.infradead.org>; Wed, 3 Apr 2024 06:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=iYN0UOinI0X2xecGwBqtylXaOKJ1t7O5ALI3HbU0Z1c=;
 b=pBnHHoxnLuObj2R9mLr21YbYHjbrVo7K7lj5TYA0xlW2igi/xmeOnKr9NMGklZIO4Pa5
 XmXTlTDfHEh8JlzNiK8XD2luiJ5P3PTtGHsNjdDsftDbXUsIL0NRv7FJDglUxzGcXgGS
 7en1tFyurltH+0omkwV4XvmF8v/wpdRxB+xNdySpQlkDwA0zog3V1H5np0dWQU9XY8yn
 LnvhpBAiCLKWCu8hzqxeSCHDCrXdKaZ+u7hBR285yreKbubA4gVyxWeFySaxW1a9QO9b
 UNg3SgsiYKcGw21STFrshcbf5kNITmdLQv495gM7nbnjwdIEjMv7mdWaLLS3iOOjgMI6 Gg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3x6fdqnaym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 03 Apr 2024 06:32:15 -0400
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433A6WN3010772
	for <linux-nvme@lists.infradead.org>; Wed, 3 Apr 2024 06:32:15 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3x89xrqhx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 03 Apr 2024 06:32:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsRILvFUNqwojTa7eQXko8cWSPS1DyhBdAqSdjUfY9IAy65QdVrxhDqEr/TPttt5j4+U3AZo38qcnujU600G1XJJzYQG5wgtfEr7M05W7oZC++oBzW7qiBAhInaBCeX6K/pDCIoDuIb6x3vzVLJcfE/GSoysLO++jieriGlXUKlZ/6sU5sv6xwCOqd60Fuv2NZyV6pFHCTGe9FL/7WeLg4DASm0wr9VjCM1UzAmkTdXvzdqO9/yOd2a+lHXMVllXMMsrB4KKPwAYaJeo4HesrDdMaHhHlH4XDvC8hDOiuJtfJELylqDt/SW7NChASsq8gdHHeKbb776bqp/0Yk15Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYN0UOinI0X2xecGwBqtylXaOKJ1t7O5ALI3HbU0Z1c=;
 b=j2O6NK3fL8TqlsYYfQgW5QrGmvPDq9zTKMPctNkDvD85JquTXbPGe78/tlhbGEMyLP9xi53eU9eBNDns+W7YHLOPnVq2J/rGyehvr/SiWC66X/HcAMFZqVhwX0DudCksEl7Fvkz+c8p8uqqeSE8ac0n7B/qebzLtFHVHADuf/1ds2XF1LqNFp8qRon/ugQ6oTC0SjYOCoTopA/uv3A1orE90p4IEST+vDOQbCeU+eFFgIVdICvVjLZic5REqimJrcNreMUZ04mU7A/H6UbbgPrl66dJGMtP/el3MUAg4QXRw6SHhrHreypGeEeFNjeKDVeQbJbXFKdz3ImsJLioMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SJ1PR19MB6379.namprd19.prod.outlook.com (2603:10b6:a03:456::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:32:10 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::5e50:f156:27ee:9dfc]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::5e50:f156:27ee:9dfc%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 10:32:10 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "Cohen, Yonatan" <Yonatan.Cohen@Dell.com>
Subject: =?utf-8?B?bnZtZS1jbGkg4oCYbnZtZSBjb25uZWN04oCZIC0tZHVwbGljYXRlLWNvbm5l?=
 =?utf-8?Q?ct_flag_(-D)_is_not_supported_anymore?=
Thread-Topic: =?utf-8?B?bnZtZS1jbGkg4oCYbnZtZSBjb25uZWN04oCZIC0tZHVwbGljYXRlLWNvbm5l?=
 =?utf-8?Q?ct_flag_(-D)_is_not_supported_anymore?=
Thread-Index: AdqFsgnyvqzHIHnlTjiW3Ot2KELfkA==
Date: Wed, 3 Apr 2024 10:32:10 +0000
Message-ID: <CO1PR19MB48850C446CA2FED70F7E5D69EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=66bfd431-f224-4682-888e-dff83017722f;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-04-03T10:24:57Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SJ1PR19MB6379:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQF3D9zZGfoAgZdGw3Z3Awnbg9IX8SjRqOKyPPLULFIkjlANoMidqdep7oQ13hJ5cOoO6FqlI0DWZozJflplo1qBNRnPzCJ1O21+JLCgY6n+SFSg6Sv/38mDwi/2zjTQB6O5M71vZLSJC3TgnOQHZHQMJz7pMLg22LegX51547QWIDaFh4FSk0Dl5NmoIAH4pHG4cgL6w+VBK6XTE6mvLbVGBffkZqVuJVCQdKCNqSkeQ310QfrYdqexagyrlr3geteUD+nY6vqNiqXApE48Ml2IAujeIrnS8v2p2kjsux1fBp5PezO8y1i/ZihFi7TjubNL7RisoVu4ekAdaSVVwO2EyfW/l8R7isPRls/zzAyZVDPBf9Yp940hgeB5tlEICSrbpM8+gMTMWdVfHmDdT8tSWA530EvJnlqE4IQ+ZILy1b/frQ/+9OAn7W6DQyOKUwLIhoxcdGWOl0o6+Qa3A4u7MFGKA0yCnR0rBMk09wMATMeo2cvnX7ZOkmIqyPIY2Wbq72xqD8b36ut6JPXYQwzzyFlkgc2SzXRwq55A73ZXMROFT+aOke+YFLDD7mqjadBvHmplj9BXw+35uNQoaUX4wMzgqS6HY8Jwaszyt5xMlOa9ssnypdLl7eWXXwIJEWM42PoalgfpwQv2Oto27RprNncl2KC1wRC39hq+y6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS92ZGZFWDVtclVHY1ZROXBGVVNCSDVWRXoxUm1TdTdubXJiK1BrQUVPWmpj?=
 =?utf-8?B?SXpzcDdEemNmcjVVQnJ4VnFEc3RSRkVYVXhRaGovTVVaaHJKeFUvRWJRTVNh?=
 =?utf-8?B?anJKUzFGampaM1g5OS9RMDRYVGVnTFlBc094NytLTXVGdmlFaFpYS0dnWld0?=
 =?utf-8?B?OXVLazFuYWtNdmZ3UVZmWnNjRGhpZng3RERRT1FQcDNZbjRMZXgra1dmenB1?=
 =?utf-8?B?ck5Ga0xBZ2s0T2ZGc29OWUJDVlE1Y0NFaE1VME9XNjBLMTlwSzZMUXcrR2tt?=
 =?utf-8?B?RENPMjA5RlBXb2ljQXVHU0RrWUp3aEdGSExlWmlGT3VMdzU0V1NJakhJVXg4?=
 =?utf-8?B?U0xBOEtSTjlXZVhoMTBnUXlUZ2VvN3lCUFdwdityWWJ0by84VEFnWVg5VmFX?=
 =?utf-8?B?V0ZLNGZKRFB2S2ZOd241Z1IvTkwrSWRpM3JsbEgrOThvREN4QjhVTGpFcmgr?=
 =?utf-8?B?Z2xPekNDMDNnWG9mSmJtUTRBSUROK2FicC80UFlWQjZXd2VVWitIdlhRNXk5?=
 =?utf-8?B?Q2hpcEhlbUhqcGxiYTdSL2NCcTd5YUIxekpUejVwaURYWEs0ZTZPS0ttWktG?=
 =?utf-8?B?TnFyRjU5MXdWMHB0YXVwcTZ3ajhQMFdVaHdOWDVKSXZhSDRvSnF2UGtWa2NE?=
 =?utf-8?B?MGNqYmRvUEFHdEE0djdwNEp5eFMzdmZhYkZJY3NGdEVOcytJOHVUZlpmQTdY?=
 =?utf-8?B?RlJ6WDJRVWFWQ3d0dCtDSm5MOFBoZEZUam1DZVZXdzA0MEkrM254ZHZHalpH?=
 =?utf-8?B?L3FNRWoyZTVYQzA0UXZoaG1oR3NMR0xRTHJvT2hjTUJ0cGhHOWZjQ3FLSXM5?=
 =?utf-8?B?bytQdCsvOVk0ZGVPWnMyUXBJVnh0MWYwNDhuTlUxb3JJdmk2b2x1VVdhakpi?=
 =?utf-8?B?NFRpYUdZRHNNRStyUDNPdmlYd1Rxcks2ck1mTzVJYVdYR3l3ellJNFRXYkQz?=
 =?utf-8?B?QVBVcmJ0dlNFQUhMeW1FOWZPaThpdFVQNHhZbjBYU1FPVFF6cnZpZm1wUGYv?=
 =?utf-8?B?QS9MOVVkUWpYL05mb0lpZUlFWElGc1VkSU9GNC9mVzdENDhEYU8vdVRiM0ZT?=
 =?utf-8?B?Z0QwVDFvbjVEeXV0ZExLV21lYVpIdDRUaGUrdS9VS0dwSEZRNUg5UGVOOTYy?=
 =?utf-8?B?N2V6MXpNSkN1L25HZWp2TWhYMGcrY1NyTW1lWldtOURvOVd4ZnExaTZSc21V?=
 =?utf-8?B?MGltRHNHbkRNYXU2SGNQbXpIeHZHMTNBTjRCMm4zV2FNZDY2ZE1ncEsvZWRN?=
 =?utf-8?B?Mk9nSFNlTDNvbStvOXFzVEY4UmVGVEJlcVZ5dFpNZk0xQmlubVJtdGZxdm5K?=
 =?utf-8?B?V2ZDazZ6RG1UUTVuWnFpZjR6VzROeWJLdkFxWnVpYndKUHJIM2RiMG1jWm1t?=
 =?utf-8?B?WlNZVFA3Vnk0U1VJTE5KL2ZJY3E1MWRTdWJqQkdrWHN0bHBCeThJYXB2bzBO?=
 =?utf-8?B?ZjFsd3hzeDg3VUhtTHpiT2dLU3JRcy9BUEFKUUJXaStwMmNBcnBNYktxcjRw?=
 =?utf-8?B?Nzk1VUIzQXJvTDJXeWZkM0pHa2pVUDluQlpBMEt1cUxmK0JPMytzSFlGdVBQ?=
 =?utf-8?B?QVpyWm02QUs4dldEUXNiUTlLTlFJaEpEbGNXWFJocmdVUXFwa0ZWd0pYSzNX?=
 =?utf-8?B?RlRtcytramNIcVJ2bThHcy9Jd3NQT2VwRXpQaGFHdHBUN1RvbVBzcDhDcjVx?=
 =?utf-8?B?R0pmOWlKTnFZc1Zud2hLVGI2RVQyUEZxMmZsOFhTZFRseVJOUmJsRWtFS2ZR?=
 =?utf-8?B?NkdEMVRoUjY5Q0dyODMwTkRjeUNMTGo1WlIzMDJlQm9MRXFCNmdDYXJwZnpu?=
 =?utf-8?B?a2RFR3FLYTdOc2lIVDVweDlNUTcxWFgwS1JGNkduRHR0QXRUQUd2VHVOanJ4?=
 =?utf-8?B?YlZrU1lrOUMvNDNLNHpFenoxY1N6MUFzUnlDUHhvYWY1QnRHTDIrQTVld240?=
 =?utf-8?B?VTloMUYwYUNYbXdTUUh0T25NREp0Qk0wanlReWN0NHp5MHJuMlVPWURuUnhr?=
 =?utf-8?B?UllkdG5VOXZOQnZleTlaN1Y5cEQrc2FJY0VtSjV4Q3ZiNjc1alJyd2FxRVNo?=
 =?utf-8?B?eTZ3RkVpbjFZK3dTZjNmNUVuRWxCUWF0b2laTU00bUl3VTJqREUxYW9NSEpV?=
 =?utf-8?Q?CT3X01Xfhm99fi1yko0O4PNAh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a790360-8652-441c-9a13-08dc53c951c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 10:32:10.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEH1w8AQjAeyKT+MnU0BQ3v4RbDRULUKRaGZ1p48oOLwZ5NdpzPw1aXESUr2yrMvjjSJEWTG+yt131mDRXL2DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=712
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030072
X-Proofpoint-ORIG-GUID: A7RjQ7X9uSPVbs8ns9vRInSok6QeKMVH
X-Proofpoint-GUID: A7RjQ7X9uSPVbs8ns9vRInSok6QeKMVH
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=778 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_113221_862437_48311FAB 
X-CRM114-Status: GOOD (  13.83  )
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

SGVsbG8sDQoNCkl0IHNlZW1zIGxpa2UgbnZtZS1jbGkg4oCYbnZtZSBjb25uZWN04oCZIC0tZHVw
bGljYXRlLWNvbm5lY3QgZmxhZyAoLUQpIGlzIG5vdCBzdXBwb3J0ZWQgYW55bW9yZQ0KbnZtZS1j
bGkgdmVyc2lvbiAxLjE2IOKAmG52bWUgY29ubmVjdOKAmSAtRCBmbGFnIGFsbG93cyBkdXBsaWNh
dGUgY29ubmVjdGlvbnMgYmV0d2VlbiBzYW1lIHRyYW5zcG9ydCBob3N0IGFuZCBzdWJzeXN0ZW0g
cG9ydA0KSG93ZXZlciwgd2hlbiB0cnlpbmcgdG8gdXNlIG52bWUtY2xpIDIuNCB2ZXJzaW9uLCB3
ZSBnZXQg4oCYYWxyZWFkeSBjb25uZWN0ZWTigJkgZXJyb3I6DQpudm1lIGNvbm5lY3QgLXQgdGNw
IC1hIDxpcF9hZGRyZXNzPiAtcyA0NDIwIC1uIDxzdWJzeXN0ZW1fbnFuPiAtRA0KYWxyZWFkeSBj
b25uZWN0ZWQNCg0KSSBjYW7igJl0IGZpbmQgYSByZWFzb24gdG8gcmVtb3ZlIHRoaXMgc3VwcG9y
dC4gYW55IGlkZWE/IElzIHRoYXQgYnkgbWlzdGFrZT8NCg0KVGhhbmtzLA0KQW1pdA0KDQpJbnRl
cm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCg==

