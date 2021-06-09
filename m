Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44903C48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 11:14:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30206139A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 11:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30206139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R8SEppKV08vlpGgaqPDe5UnhbLXcomMrw8iHnl3u6Sg=; b=S6a719DFYKMevm
	bnx/NqpK7gqzmEGQIX1hzcIw0PEddaOyazsKhh3vezF9jW3qvvaKq3M69AGji5VJzNH4R2amcmUZD
	nOuAWIU/xC3gN4VHNhHO5BnjhZKnDEexJxUsxcmzeYzlS+lWn6xiy4g5nCQUnQzuDKv/xlP4XJKwt
	cUFN4O3lCOvwp97vItMrrWSyPrmaGLwQGngiVISwM8DMbzA79JakCPGkBB3+31nFaigRdkZXwP4yo
	UuMSOGXMYFtdqNl5+bPcgdYgZfdGjDNkZnr1bHVm15Ekog5bYtuXmBfSVGBSw4j8ig0dSJiSmOs76
	adL+TE0IUUkyEc7s1Bcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqwAB-00DGIQ-KB; Wed, 09 Jun 2021 11:14:23 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqwA8-00DGHo-4E
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 11:14:21 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 159B8BTB016340; Wed, 9 Jun 2021 07:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Vj9AfILnEyeDxX8BulOXRg/u1Q6T0SvA7bgk4IvCiww=;
 b=qaujhu6XwQHp2DmJBErMoC4bGOUnXgwwRL1PhflozplVK9g0jRhSnk4mHU8DUQxe4Pix
 T2efWOhGfcf1W9sHRpvyVFkoZ1DNvhq98VBHvxbzTo1OP+4spDn04B7xYMs0FHpsVSal
 YTV+5EVNGB/Qo7QYlKhkexr1WJdZUbLSfyfsTCQUQAv2G9bdsnAd29spLYBzvyVCsMoC
 ZAl9ekCfXagLZc5shE4mToe35TKXEMTfym241Pq8DCwFMgzsV8RdkbtmEsTqxyg7Ge84
 U8KptQiI0DS2Y2TGL0KAM/YGbFKPUKZwYxZCcdWPSMxZwxphbzyxN33RsmHlqyupqct5 SQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 391jcn26y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jun 2021 07:14:16 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 159BAGY1056280; Wed, 9 Jun 2021 07:14:16 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by mx0b-00154901.pphosted.com with ESMTP id 392rq83rta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jun 2021 07:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e45RjRdlNxNmXy707Sxw4OxBe0q54X7Mcdx7DWEWfRFM1ji/+Haba+w9HSHOfBpWogpkXOQq82ArMQfq3ECupX2usQySFi8MCKdN+eqrQawBK91JEI7qOw32+TG6k1/HNEV3/BiUg87AiH5ibPwvAS1S02uWCezmEzvdut6pndu2qE2R0IJvRiUS+WnT1E57t1Znh3+AoK5PJAfIL5NkGxewbGZTTKCYNRW8rQKswbvFPN4MsQvtrEUaOVIz4k/MNrzCrrUgmjfEaR0swrjxEOoJTut3SgSjkJVd0RCSQ4G2CxtAuK1iwG/zJodm68+zRupyq8zXua3iOcygnzt1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj9AfILnEyeDxX8BulOXRg/u1Q6T0SvA7bgk4IvCiww=;
 b=JLOBHfVf8nlEeP5TfPgP9bxrfiWPfcdXRF6fwrNQbNbMD/vrQUQlNdStKnMqVAOfbM8pfY6MwzBkT0qHQjL2li4tkFIt10gXUQFBH58bAbVBt00zwBvkNhhHNr4jcHrPSFmbfOyCPGMZTnNby7b1jrxYn/EN90GZ5Qxzmo7EFs+6unHz4GxRIw3/FCBE/AcBQGES4yCL9Irg7Uwnf0g4XcVRnq4xs/lskbEAv/gpOjO2NqwUEjMtwZcMiNKCfI6CQwPyruoJ1RSqbjMkCld79jc5/lXADNNp/8XV/+PY4e8eD/zlQkdPynv8m3UU6o+KjSVU24Ocsu24LNh42xLjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by CO6PR19MB4771.namprd19.prod.outlook.com (2603:10b6:5:347::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 11:14:14 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 11:14:14 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDgAm6yOgAUVC6IAAEPeXkAAAsPoAAAD2GkAAAVmfgAABR48g
Date: Wed, 9 Jun 2021 11:14:14 +0000
Message-ID: <CO1PR19MB48859E1CCD596402D4007458EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
 <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a76ecf8e-15d0-1ebc-aaf2-c93fee591602@grimberg.me>
In-Reply-To: <a76ecf8e-15d0-1ebc-aaf2-c93fee591602@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-09T11:14:08.5167618Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=4f655aea-9234-4315-beed-8fbd7e4c1e79;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [188.120.129.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37f1d4b2-96a7-47a3-5bb9-08d92b37b707
x-ms-traffictypediagnostic: CO6PR19MB4771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR19MB4771E081D2BDDC5224430A4FEE369@CO6PR19MB4771.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QqjW6AmdNuaBV/6qO5a/uJG22Gc6w3iLgQy8QcrZd8rUnPIsxwiecLqGgBdt9JPcr/DJqDQ7NnWmWJo0RtFHI6cTVZ1qD461E5A30gyQlYmjGJr2JZhd8mLQ+FCpsCaV/hIbztn4d+PdUFw9UFAua0+oT9UP38j/gRD4dmgi3qiNDDyNTKa6QDHYlMMQA1VyzgaHboge1MHmAPLgqx/oDpjcBJg62e/Dlf3V06S4YduX4cxtB394YK3zG2qk/xoXyt1/pNrPsq3BqS+7FWq/3aGKQY2YbXj+omu52pk2scTV88hQh4EGKIZ9VNjIZoSEyAguVEXMdQJKEXBrmQhqPd5roI8iL1jZ27nvc12jtfOw+GLqtRkyAB2ykSMA3rhhbci5pR0hjhkdbf1dSO9kkwrMPGpRO9VKzJ3USHg/0Gntx/DZoht8qxiOGWc7SFv1ZZ25JhOo2eoho/C50soOdepkqu0SvPjobbsceVnc176zg2Hu4tS0T8mg8niZdmkT/jcPnfalSo3J0KiKgUE8j0hF/lB+bdBFYftT3icjHm/Kfpu7S8tqR5YdiVpTWvl/oG8n2Lc1DY8KO+v3hKBliNL26tLx/dMX1RrarCAPiRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(8936002)(54906003)(110136005)(5660300002)(7696005)(83380400001)(76116006)(8676002)(55016002)(316002)(66946007)(71200400001)(786003)(107886003)(33656002)(66476007)(9686003)(4326008)(478600001)(122000001)(52536014)(26005)(6506007)(53546011)(2906002)(64756008)(38100700002)(66446008)(186003)(66556008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEpiSWliQ1RhWVlXQ0VhcjFRU2lKdWttays2OG9WQVJTUzQ0bDNzNnhOMUww?=
 =?utf-8?B?eSswby9xOEs0SCtKaDJGeG4rdG14OExjcGdMdUJLZWFHdEN1VnZ4SXppL3E5?=
 =?utf-8?B?R0RrZm1NcnRzWFJna3p5WEE3U09PcUE5OTBha1pnSldCWFdlaEN3Nzh0UGhQ?=
 =?utf-8?B?SHptTEdYVjhmK0JhZWFTYmV0SVF4NlpzSS81cFpObUNzNXB3bWpuWGlUVS9l?=
 =?utf-8?B?TXNWeldXU1pnWUZIRFEvWGFDdVF1OXJHMjdOd2VSMUlBVTBHVXptZHBDbE5v?=
 =?utf-8?B?ZkFiSVE4TjR0eklZKzBiNm8wL1Y0Y0hIU29YWGxBVWZEM2k2NW9XblNiYXg4?=
 =?utf-8?B?K2N2WVJXL2Z2MFVERVZlR1g2SUJEdWY1ajRYazlKRmlBOGRuRzZmcDgvSjY5?=
 =?utf-8?B?Rm5mb0pyeXNOWGVHSWRwWWErMzNPc1kycUdLMk4yZnFFSi9tTGI0aW9KY3hi?=
 =?utf-8?B?a2dwSVQwV0hRMk9rVWwxSHhYZmJHU3ZKd1E5VDMxU1BKY010RmU3M2pVcDd5?=
 =?utf-8?B?bTdhSXhuNXRsZGx4SHJ6ZXhCZ1lLV1pTY3ZzQTdmU2pJUnBiZXBFK0taV3VD?=
 =?utf-8?B?WVhzMlAyazZyYkhtZ1pVY2NkY2NLV21WeDlYaFVtWDJjZ2VvME84eGtaZGdr?=
 =?utf-8?B?V0dxVXg3U3NPdmowYStjZisvY3VFbWlGMExGUmRzdFlxTTVzYUJ0TXJmRWZ5?=
 =?utf-8?B?L2VvVmo3bkpnZnhVbVJqdXdRaHJMWU5yc1l3Z1ZTekJxV3lwRHYvSTQzVjVs?=
 =?utf-8?B?NDcrc0FITXJlcUNYVDc4bEVzeXh6eWh1Tk1lSDdLKzJDYWpJeTJ6MDRMbHpl?=
 =?utf-8?B?UndOVmsvN0xsT0tBaE9rUnRtSzZsbGl6dTc2Q2w5QXhtUnVVNTcyOGcxY2Zq?=
 =?utf-8?B?bnNSV1l1ZS9na1ZWS3o0MnZpbWVkNnVWNmk0NlhyV0tiTU41VmJ3eDBWWk01?=
 =?utf-8?B?R2RpZGMyTGYwcUt0T3ZwVlUzMnVUa1kxbjh4eHEwZVhBQWtSREpBS3JrSXh2?=
 =?utf-8?B?SzdhK2FKTzhaRXlobGNhSmZMNnM4MkFHOFFFS1EwcEthUjBhNjJYTG50ZUUy?=
 =?utf-8?B?bkZLZForVVRkT3NiYzlxWjFVUnM1UC81UkErMkVkWDgyYVIzYWs0OUt5Nlpo?=
 =?utf-8?B?RmJyQkhpY2lyaG1mbTFZUzlUL29GeXduVUtQSDdsQlg0ZC9QNmVZaCtQR1hh?=
 =?utf-8?B?WW5WNkJnQlJZMEVxRTNna29XN0tmeUIyWUpIdlpnazdlWjV5dDdWbHkxdS8x?=
 =?utf-8?B?VVJtdmVLeDFta0taQm9EUjBlUlV0NWtWQ1pCVHdqcnZMWU1ReTRocUJ2UFQv?=
 =?utf-8?B?S0tFV1FFdkRBTHJhL3VwOHZJN1NiRlJLWExiTFF5UGFucmlITWlMckNYVkpR?=
 =?utf-8?B?UVJoMjkwOGFnSzVFS2VkbzAyaHlhR0dHeTdKTlc3UG9TL29mMWJNTVNBM01S?=
 =?utf-8?B?U3EzMnU4OVRLRHNuVlBmK1R4NitjNVRaWlRQakhVM0RCS0t4Z25rd0dEd0Uw?=
 =?utf-8?B?V1NKdmppaS9Fa00ranF3R2t6WHZIMkk4d3BVc1NUaGk3Sk5jK3pyTWFna05t?=
 =?utf-8?B?QjhPNUwzbjRiNHRWRVR2WTRueWxvUnVJVWc3UW1PMWRTaXZCalVyM3NReFdS?=
 =?utf-8?B?akVqNFFPbU5LVjY1a013VjNtdTZZdlhmT1NCSVpLdzloaEJVUjE5cDlyRUJr?=
 =?utf-8?B?b01zSmNGQTZDYzh4SGFaK3FVUlI1eWJwR3VXVG41REswdzdvVjRReS9FcnF5?=
 =?utf-8?Q?oMqQwDYXsbT3RsE/80pawtV2SaIg9a6RMWtSpS6?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f1d4b2-96a7-47a3-5bb9-08d92b37b707
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 11:14:14.2259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FpZ8yH+KzFSj/7j+MoC/aDF+Ezkf7Kpm6JkYXrgxQp6UE15UHIrlrQnd+//FealHKcmSDi6AFpe34VoOI9OEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4771
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-09_04:2021-06-04,
 2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=738
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090055
X-Proofpoint-GUID: DWyEA3TKdpfRtSY2Fe5Er09LjDhQD9ut
X-Proofpoint-ORIG-GUID: DWyEA3TKdpfRtSY2Fe5Er09LjDhQD9ut
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=842
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_041420_365926_67F1F772 
X-CRM114-Status: GOOD (  17.20  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q29ycmVjdCwgZnJlZV9xdWV1ZSBpcyBiZWluZyBjYWxsZWQgKHNvY2stPnNrIGJlY29tZXMgTlVM
TCkgYmVmb3JlIHJlc3RvcmVfc29ja19jYWxscw0KDQpXaGVuIHJlc3RvcmVfc29ja19jYWxscyBp
cyBjYWxsZWQsIHdlIGZhaWwgb24gJ3dyaXRlX2xvY2tfYmgoJnNvY2stPnNrLT5za19jYWxsYmFj
a19sb2NrKScgDQoNCk5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCAweDIzMCDihpIgNTYwIGRl
Y2ltYWwNCmNyYXNoPiBzdHJ1Y3Qgc29jayAtbw0Kc3RydWN0IHNvY2sgew0KICAgWzBdIHN0cnVj
dCBzb2NrX2NvbW1vbiBfX3NrX2NvbW1vbjsNCiAgIOKApg0KICAgLi4uDQogICDigKYNCiAgIFs1
NjBdIHJ3bG9ja190IHNrX2NhbGxiYWNrX2xvY2s7DQoNCnN0b3AgcXVldWUgaW4gY3R4MiBkb2Vz
IG5vdCByZWFsbHkgZG8gYW55dGhpbmcgc2luY2UgJ05WTUVfVENQX1FfTElWRScgYml0IGlzIGFs
cmVhZHkgY2xlYXJlZCAoYnkgY3R4MSkuDQpjYW4geW91IHBsZWFzZSBleHBsYWluIGhvdyBzdG9w
IHRoZSBxdWV1ZSBiZWZvcmUgZnJlZSBoZWxwcyB0byBzZXJpYWxpemUgY3R4MSA/DQoNClRoZSBy
YWNlIHdlIGFyZSBkZXNjcmliaW5nIGlzIGJhc2VkIG9uIHRoZSBwYW5pYyBidCB0aGF0IEkgc2hh
cmVkLg0KDQptYXliZSBvdXIgYW5hbHlzaXMgaXMgbm90IGFjY3VyYXRlPyANCg0KVGhhbmtzLA0K
QW1pdA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8
c2FnaUBncmltYmVyZy5tZT4gDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgOSwgMjAyMSAxMjoxMSBQ
TQ0KVG86IEVuZ2VsLCBBbWl0OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNCkNjOiBB
bm5lciwgUmFuOyBHcnVwaSwgRWxhZA0KU3ViamVjdDogUmU6IG52bWVfdGNwIEJVRzogdW5hYmxl
IHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IDAwMDAwMDAwMDAw
MDAyMzANCg0KDQpbRVhURVJOQUwgRU1BSUxdIA0KDQoNCj4gSW0gbm90IHN1cmUgdGhhdCB1c2lu
ZyB0aGUgcXVldWVfbG9jayBtdXRleCBpbGwgaGVscCBUaGUgcmFjZSBpbiB0aGlzIA0KPiBjYXNl
IGlzIGJldHdlZW4gc29ja19yZWxlYXNlIGFuZCBudm1lX3RjcF9yZXN0b3JlX3NvY2tfY2FsbHMg
DQo+IHNvY2tfcmVsZWFzZSBpcyBiZWluZyBjYWxsZWQgYXMgcGFydCBvZiBudm1lX3RjcF9mcmVl
X3F1ZXVlIHdoaWNoIGlzIA0KPiBkZXN0cm95aW5nIHRoZSBtdXRleA0KDQpNYXliZSBJJ20gbm90
IHVuZGVyc3RhbmRpbmcgdGhlIGlzc3VlIGhlcmUuIFdoYXQgaXMgdGhlIHNjZW5hcmlvIGFnYWlu
Pw0Kc3RvcF9xdWV1ZSBpcyBjYWxsZWQgKGN0eDEpLCB0aGF0IHRyaWdnZXJzIGVycm9yX3JlY292
ZXJ5IChjdHgyKSB3aGljaCB0aGVuIGNhbGxzIGZyZWVfcXVldWUgYmVmb3JlIGN0eDEgZ2V0cyB0
byByZXN0b3JlIHNvY2sgY2FsbGJhY2tzPw0KDQplcnJfd29yayB3aWxsIGZpcnN0IHN0b3AgdGhl
IHF1ZXVlcyBiZWZvcmUgZnJlZWluZyB0aGVtLCBzbyBpdCB3aWxsIHNlcmlhbGl6ZSBiZWhpbmQg
Y3R4MS4gV2hhdCBhbSBJIG1pc3Npbmc/DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
