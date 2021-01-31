Return-Path: <SRS0=pTPU=HC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4530C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 15:47:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2384B64E22
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 15:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2384B64E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oENOlqpL8xMf0OkXYCYdrQkUOc2TjfgP+gH0IAfPLM0=; b=kZjIARc7mCUXdcIraTohOgg/Un
	T12bOCTU+QyYo4XGih4U3lYMILX/HB6S9x9NiEgHQ0ZUwy5GQOE601Ca1t0gzN2WTWcjWid1DaY4d
	RHGBuyyJRIIrEym/3JF+GjdAts8MheyNFWPD3/8E28S2/qiJW3R26NS7j+ZKy/MDkAYGgZiZq/s3c
	KYYihg5WLXacZxcrzNktHPo4R4MQxsYB9Qofz5DwGn51Ud73LcqjmQv/53zLCdLECaTrrIj8NqgMS
	5uYY8cPCMzDaE0JL72sA4CFj4leSQ+533v/4/31OsUQLAA5BVO8wArgLlAtxySyb8fpb0ND2I73bx
	bxZ9R3lw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Ewa-0004td-6J; Sun, 31 Jan 2021 15:47:20 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6EwX-0004t7-7F
 for linux-nvme@lists.infradead.org; Sun, 31 Jan 2021 15:47:18 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10VFcAsf020571; Sun, 31 Jan 2021 10:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Ol30J0h6Ia92+PlIY1i9dueJZJPhyaxsK2iD6espMH0=;
 b=K0dG0RSu77mm5dI1VrukxUt9ULT3KZZNJlE+MN8Ibu00BRP5B0g2uos/sYlgKVEXWpne
 LQxXYQxgjc3o5FOb4N1nXqBMZmh4Nc+jsZIX/tUjirpqi/xuvZUUD5dl7CK9vA6DOb3f
 qlbmUx0RqArUbEnpFZaw1E+sWmplDk+lh8QsJJfBu32eboS7/mRL0+1Jf7TL6+71dAtT
 HB6Twwnc35aM9jVRt6vzrIkmH9NlAgKiySH1iFMODLCZjxkihIuoYqftSq6/gRWquNEz
 DkuVnMnJ0uQp6MjDo0KMHKxlOaW5fmLAk4QqhT7oI73nAiDFcB6s1aLIm5kp4KQ3IFrB tA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 36d2waj2bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 31 Jan 2021 10:47:10 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10VFf0lW063273; Sun, 31 Jan 2021 10:47:09 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by mx0b-00154901.pphosted.com with ESMTP id 36dnmektqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 31 Jan 2021 10:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBqDfmff7U2xuJdiymtZo0gbL7mB7fndPctTG+WKKedLfPBZk8gejnbxIOo0dd93fw7nRuR3wZoczX3W+YBdpmyeroGKoeYFIs1pBZFske/JomZ/VGnTapfFUJuwd7x/oo0La6X0OwJjl8xkwwH5GA74lMj34EU9utlZXFi9zF1RgkkqSF/w47VyIb+1kyKVFIzLLUGRvnTYm+uAfIhYqOvM2bYCUfhnDP5EYvW6kOs5yW5sYX+S+ejFfZY8W8+ojBg1173IPzcWbxtOxrwqutbiOtGmGhpsebZ+aaTMpCIRQZucjVhiQ3xTxxh8E/YaBbkTaiTMYIOpSezcf34V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol30J0h6Ia92+PlIY1i9dueJZJPhyaxsK2iD6espMH0=;
 b=KjQHSB7cmM1iitOS7vnL86v6axfSYt9i0Lx5r1FPlDWLn4BycpiXGBYaAMWVEYsSnc1M4mXJPhGREuMoV38giC1nYTTRIPpsVKx9TOCxmjp7ypxf47WndAAnCFHC/kCPz5tgdULOTsuiTiyesakV0a+NAxtYM9YjG8cGZO3yA/aWf7bjwrIIPAmZqKWcaTg33nnUYP3kmSb+aBw/nIpGhjUUq8x2BZ/okA/shScaLR3DrHbaSvXKD8SJ4Ag0REGqjcjer48nyCJwA+O1L84949LgsLAcSapsTRi5RHEaL8p0NN+qEsKS+zmcmyAK1WriqHHMsvEeUD+8ygHCoF7D0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB4327.namprd19.prod.outlook.com (2603:10b6:5:2b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sun, 31 Jan
 2021 15:47:07 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 15:47:07 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Topic: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Index: AQHW9Yot5sDcdvF1ckSEbnpOtZTZe6o9l6yAgAAQh7CAAAjDAIAEM4Sg
Date: Sun, 31 Jan 2021 15:47:07 +0000
Message-ID: <DM6PR19MB4011E46B215215B04910F67CEFB79@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
 <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
In-Reply-To: <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-31T15:47:02.7280804Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d038c4e3-5f06-4cea-b555-65c3901efa07;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27478d22-d1fd-461c-6d2d-08d8c5ff76e9
x-ms-traffictypediagnostic: DM6PR19MB4327:
x-microsoft-antispam-prvs: <DM6PR19MB43270B4E1A77E1A12D863E04EFB79@DM6PR19MB4327.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PkSL0ByEefJgFFHUusXGdTg1uC2M0+m/OZUz+q+nqXbdzLWfovJ1g4l02pt+SZRMZIoBIcc6BtGcBgcn0Y+KsPjrXiHE71wvBaAN7p/qB2kD48IvFs/6tTkEwMRcsa3fXBY0fi/csizLh6ryKzrxGxu+F+vmGVufhcntY7SBcwOtVUQx535Tq5Aqw7cgBEGdSXXj8j04DPs3tE08PbmYR1Ac1dk3e+HWnXeBJj+A+yvEOpAMd9ky8DO2kUnsY3qDIxZEQjVgKFGnpiQMSvGXzJAcf7mKHu8OtyvCFIFhgIKg1rrAYr92H62oPdoZfs/JmgRTsRNqkJwgxhDN8a34RSj2x3f9jDiFyckLu3hmWX8NEU3PGw1xTPVTiXrIKs0dejqxRalrFKpEjoppNjtFZkVKfK6lRxEp4nLz1qBx4OUOOO2klYLM1BDm2W1K/vSS4+7pUMOLt21YsYerzaLgqqnGQxbWAZIYlcSh6NXSk2UlpWeC1AKs8xQ89NzoUW4C4RwiqWFzqPWv1jsTxEy5CA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(66476007)(52536014)(5660300002)(83380400001)(55016002)(66556008)(66446008)(64756008)(9686003)(66946007)(86362001)(33656002)(76116006)(110136005)(26005)(7696005)(186003)(2906002)(786003)(316002)(478600001)(8676002)(8936002)(71200400001)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MWJFYllwdko0SGYvR2dwYU1ySVhsMHU0V3ArNVc4alZ0UmVYTktnOXJpZnE4?=
 =?utf-8?B?RGdFRGFOVDYyRlpoTWFRMVR0V2R6bnFBZUl6R0xnMjNlbHQ5UENjK3FqSWZ6?=
 =?utf-8?B?c2FpMVhsUXU5SVpld3lQZGM2aVdPVG1hTW84L3gycnhFZHNzUjE1NUc4MXI1?=
 =?utf-8?B?TTFBN1E1WXB1RG5EVFlEM0QvNGJDVWhtVU1WNHNGSmh0ZkZnSnIyUm9IOHBL?=
 =?utf-8?B?YkUyc0cxUHpaRS9TRlJKdmxYZWg5b09oK2V2T25uQWhtck9nNTI3emFId1Nm?=
 =?utf-8?B?ODVUMU1Pc1Y2bkdSZDhvazZIaS9OM0orT2FYSlhTdFQzcXBuSXBsQXhzVGIx?=
 =?utf-8?B?bGNudzY4b3FwUVVsZ1pSK1lwblZXR1d6QzZTUnlhNVlMeUtaWk5CdWREaFhP?=
 =?utf-8?B?YXl0ZUI4Ni83RUFTR2ZXbzJvRFhPRk5mMWtOK1NmYWVQL1lFZzA3Y2t1bGdJ?=
 =?utf-8?B?VVVuYjgwbTNDeHVURGFVUTZoMnFYSUk3NUpxR3djTitzRjlTMGl1dHRlaDhi?=
 =?utf-8?B?cjk5MElycHFPQWdENWdqNjR5UW1JS3hHZVVzMkl2N2U5YXRWVm52K0orbnNJ?=
 =?utf-8?B?Yk5rMGdiWTJjYVZhckx5Y0VGL0l3cDFRMXIxMkJOd0xXUnZWUWYvZkRod0Er?=
 =?utf-8?B?b1BRVHdsQ2JPNWw2ZlhkTFZ1UW1zQ0RHU0FSTnJXVjBDWXlTZGRTcitlNmxk?=
 =?utf-8?B?cFJsdm01ellZM1ZqQmx1ejFZeHF5R0VRemZYcTE1bGNSNEZSSjdxNXpGV2dP?=
 =?utf-8?B?ZEdhOHEyaWlLVmpPTzJQUVVuN3BKd01MRTlBenBhS0IzdzNEVDREUnBjY1Ft?=
 =?utf-8?B?bDRPWnR4cDIzZXRINHVBYTh6cnRhZUtFWjMzdkdKTVozNEpibGxJbVJlZmQ1?=
 =?utf-8?B?d0pacXdjck5nOHRURllkK05zQ2p6cGZjOWdJSjExYkFENFg4WFFSL2JnN2dS?=
 =?utf-8?B?cXBKZmwycFJVcmV3QjltSHBEdkxFR0d5OUpNczhXTmNZOTB1ZzFYQ3FQUWdj?=
 =?utf-8?B?ZnVqbWM4TGVZcUM0dm82dHlEU0hIUVFpM3NsNW5vUWtBc1RqYnFGa3ZjY0J0?=
 =?utf-8?B?VDdWN1YyM1k5RE03blB3TklraHB5c0xSeXRZekVsZm0yS1dLS1NMMnhIOVBi?=
 =?utf-8?B?c3o3d3FZejg3Sm1XODd4ODl2TGQwRXN2L0FjU2RrYkdQMDVtNlhLMW9BWlBn?=
 =?utf-8?B?NFc1RmtmMmV4UmhUQW1TMmdiMlVaaHc5VDN1dFpaU2s2MTQ2OUUweDhmYXla?=
 =?utf-8?B?VjhZYWpUc21WQmxlM3FTQlNyaURudU5RM3UzbkVzUTA3ZmpnQTZwZmd1eTU2?=
 =?utf-8?B?T1M2WStEVXpuVzhEQ09FdmxlM28vRE04NmRaZFJOVzFWbytOZTZnRFBkTUJp?=
 =?utf-8?B?MU5hVHlXNkJXdmNpN05zSlFvRDNpM2pPMTIyQlJ1WkhreS9lVE5qMDZtZkdH?=
 =?utf-8?Q?uURegf0y?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27478d22-d1fd-461c-6d2d-08d8c5ff76e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 15:47:07.2449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtZQVeFdlQzK6jAGHZYEgon35L4xZhzBsTPJKmJQ6Gmbv9L+GRPiQqdSJm9eUcTV4iSESBcHl83Wj/C7tLjbpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4327
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-01-31_04:2021-01-29,
 2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310090
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_104717_379837_9396A884 
X-CRM114-Status: GOOD (  23.78  )
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

Is it possible that we will have the following flow:

Thread 1 taking sk_callback_lock and goes into the switch case of sk_state, going to line:
	sock->sk->sk_user_data = queue;

at that point, thread 2 invokes sk_state_change, but this is still the original state_change callback because we didn't set yet to nvmet_tcp_state_change.

Thread 1 continues and set the callback to nvmet_tcp_state_change, but the state was already changed and nvmet_tcp_state_change will be never called.

I think this race still exist even when locked by sk_callback_lock.


-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, 29 January 2021 1:34
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows


[EXTERNAL EMAIL] 


> That will work if sk_state_change is called under sk_callback_lock.

It is.

> In addition, need to flush_work(&queue->port->accept_work) in nvmet_tcp_release_queue_work because accept_work is still using queue struct after unlocking sk_callback_lock.


But sk->sk_user_data was not set, so I don't see how the release work can invoke.

> What about this instead?
> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index c41902f7ce39..6388d18ca7c2 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1494,16 +1494,28 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>                   ip_sock_set_tos(sock->sk, inet->rcv_tos);
> 
>           write_lock_bh(&sock->sk->sk_callback_lock);
> -       sock->sk->sk_user_data = queue;
> -       queue->data_ready = sock->sk->sk_data_ready;
> -       sock->sk->sk_data_ready = nvmet_tcp_data_ready;
> -       queue->state_change = sock->sk->sk_state_change;
> -       sock->sk->sk_state_change = nvmet_tcp_state_change;
> -       queue->write_space = sock->sk->sk_write_space;
> -       sock->sk->sk_write_space = nvmet_tcp_write_space;
> +       switch (sk->sk_state) {
> +       case TCP_FIN_WAIT1:
> +       case TCP_CLOSE_WAIT:
> +       case TCP_CLOSE:
> +               /*
> +                * If the socket is already closing, don't even start
> +                * consuming it
> +                */
> +               ret = -ENOTCONN;
> +               break;
> +       default:
> +               sock->sk->sk_user_data = queue;
> +               queue->data_ready = sock->sk->sk_data_ready;
> +               sock->sk->sk_data_ready = nvmet_tcp_data_ready;
> +               queue->state_change = sock->sk->sk_state_change;
> +               sock->sk->sk_state_change = nvmet_tcp_state_change;
> +               queue->write_space = sock->sk->sk_write_space;
> +               sock->sk->sk_write_space = nvmet_tcp_write_space;
> +       }
>           write_unlock_bh(&sock->sk->sk_callback_lock);
> 
> -       return 0;
> +       return ret;
>    }
> --
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
