Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B2C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 13:07:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514D960C41
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 13:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514D960C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pojM+gTaZKVvIkqU9rEGTNU8DiSBBlgs5IATF7mSfbc=; b=dggznxLK4NsY42Qf/lYwo/0V0
	+4jGkfGT3QE+rEwx/sGY9wb+oi7GxqpfyuOVOsjAKFktg4WT1d7y6Ppu9SkWBatkeyUxdmunErq/E
	S9amS+8XEYvY3lqO7EQEICnm2h8hItFuftQP2Zh7Ngs1Po6lV8PGhsmnVD18wCOwp5jDNmKACmkDj
	euRupplc8RTI1OSnCBoE69tOiDMNYisTj3pa0A/sKjz3EcezRg4hEp30WJeKwUSnrkrLqbiodCuDj
	KYxjXTnJ4NeBiiQEggXjucgDzkYNinkSC2EZrDpky+gQ+9EqpbDYt2YckpLmyO8Ru8dfXanQKH+km
	yENExMvDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRaYX-006bwg-Ku; Wed, 31 Mar 2021 13:06:45 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRaYS-006bvd-UY
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 13:06:43 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12VD2NOf023157; Wed, 31 Mar 2021 09:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=vvOyRjf81KXzXvnKjKtJGGKJMoKwV4PLaaER+6MdFsg=;
 b=Mw98ON0Ur82tjAJCVmqDgzdaQdRcoopzfq+JtAF7g6QVs5x9TkfdizKc3Btr9f2Ul5Yy
 4NhVbF+bBVrP8RCG/mPH3Fn/2tYMBsFPXrRq0mZdLDrFAcbCXAxGcI/V1zWM5uYPxbe9
 J+hxKWm4l1MsP3UDUzx9V8MT7ZNbCIUOqRfPP5SBwXoHR75S7J37OTLULB8x5lQsG3E1
 BkngIqaMiaSyISOoae/YuezYsjbXDQiCkw6QPUlbyxeuO5ov5KK6leV/E6rxi92qUk7K
 X6hPo/fz7a9L19k+H7EOMzvIp0Vgee1obaQ+20OxJC4khObrwtEPYTJ+cG0LI5sOCS47 dQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 37magt2vsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Mar 2021 09:06:35 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12VD1vcO062671; Wed, 31 Mar 2021 09:06:35 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by mx0a-00154901.pphosted.com with ESMTP id 37mabx3y0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 09:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRSxNMUUIyADdWqW1FD+CMt/KwONPi28SsJ3xnx4lLJn4/yohKDEMrau9hWcpj0EZnT8k+HV8+ZTK73bUUpQhMXNdDeOXgH2tFdTiXSvx1KySOa+5lWTWK9G2ai7tHu/PRvH1Krv8ZT2h+0aDT0UNaQy6OgM/csxMFJSgKRSuSjtC4bKWi7rw1SjdVVHgdFCsuZQTuZv7sI2rgm89DsvneUVkmBvwDmS4HsBEue9L722KnOj7KRGqBC9wo+gFm+t89VmzPk6l1H2cn1sMfvhApKjOAM5SNPitZ2BxY34qP2ISefVp/HOklbDmmIP7LnZo3MR5jqOeKPvtOLsCLafrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvOyRjf81KXzXvnKjKtJGGKJMoKwV4PLaaER+6MdFsg=;
 b=QbfBna+bs6pzMoqJDFs5KWwWReDtJn6NjorDtYVgtc87KnjTTKhvAMJLhjjGP23FZMJl9Gf0M9xnCo4zSyFdnWtkUfA+Ty0DRIqmq/UQLnyB9JXwHDHqg3zDZ+ccQxRNbBF96chT9MezVZS16AGaEKVJDG8r413226kBBnuIM3OPsIPe9zfb/SM0Kc5wqGCxhMahepdf6fZsv59CjG29GWtof8IxeARSwUxX4nj/Xk9Dtm5+gtfO7EWivp2UPCiVAqRo9NlLVGKvhCDoOt2+e5BsZVBsr3vx/cpMo9zqbbb3xOM1XNrOZYDiSGVdVGwv+yvBkvvqExN8NrX0pSvYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB3292.namprd19.prod.outlook.com (2603:10b6:5:194::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 13:06:33 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 13:06:33 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXJYmFWNPDZWEGj0+lTpdIzo7CNKqduYcAgAAKYmCAAAubAIAAQqXw
Date: Wed, 31 Mar 2021 13:06:33 +0000
Message-ID: <DM6PR19MB40114F5BA24069932444406AEF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB40115FE64DF309D2591B9879EF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <20210331090738.48806-1-houpu.main@gmail.com>
In-Reply-To: <20210331090738.48806-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-31T13:06:30.9863981Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=600504c4-5e66-483f-a964-94d2bc4e6fb1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c19f9332-1963-4b0d-38e2-08d8f445cf08
x-ms-traffictypediagnostic: DM6PR19MB3292:
x-microsoft-antispam-prvs: <DM6PR19MB329213396BE29212C1667F0CEF7C9@DM6PR19MB3292.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WT9/sY01v690EdXTC4ZOMOPimXfOgG6j3BF6puHGNEIBWb0PeGnb+o58l/xHU7Khhs9QjUEGpAKoMQrEVIt84+ozZI4O1YIbvEfHS4PJ4oJxui1M0OIHAQrNPyunAXtdVccW2JfTUxzUa+xHUyvR3GqgHbdrop0GUNdPrXs1cgEqE8gOR6wD7KWjHoLEFJTULzbOIaDTLyl/lffQ0qe8lcSPEKn4PF+JKhAHfsY4fUyCE00ytlKMaSGvcmhq+ixuVI6GOLwvmQlyCXJFyGJMOYbvw21iWlS/RdETNz/Bw1m8Nrbess9lZXZ5bU4KImsvTEuJ2piMFPtuDf9I51lZNRbPSbNZh5UnULFJ86TAW2ncjT4Roep2bT4YEPv3ru9vYegQKHJeUV02/12uAKPD0Bkrig6YMluMgTbmfEB2wCN8iCCAzgeIWTCpmCs1+R4M07eQOnykqOQDMgYJE5ovE38JTnI8FMKQ+wWHj6DUq988jdRtuGvs/fPxwRNjoI7Tve+Lx7h7nIvnFWsK9A1gG2IYBdfjLrp5FMJ+bNPawAZZn5yN1LJ22xPeY+ic5iQbtvPkpE3fXYU8JwHxwsg8btMT/GMkq4AcnlGuUwPz9/lpo9eTz+WPbkeFd+GZIZP0iGHvI4y7HvbSoQrpgWmWu2ohGZmZhltI1buZ+tUQwMI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(5660300002)(8676002)(76116006)(786003)(66946007)(55016002)(64756008)(6916009)(52536014)(7696005)(8936002)(186003)(26005)(316002)(478600001)(54906003)(83380400001)(38100700001)(71200400001)(9686003)(66556008)(4326008)(86362001)(53546011)(66476007)(33656002)(2906002)(6506007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cStiZzNqZks5NFNuNlV1ZTVoTG03UVQvZjdjYW56U0ZldkE3U0c0WTFNL0NO?=
 =?utf-8?B?SC9nN3hNcFNyTk9NVzdzY1B0ZHd0UDNPbWVRNGp1NFQvZU9IcDJzcld2V0FR?=
 =?utf-8?B?Q2hsSzYrVmtoa1JlWGsvLzZUNEVYdUREMk9kemhOaVY0dC9QRW53SnA1QmdY?=
 =?utf-8?B?LzdHL0srRWwvZ0g3R29ZaExtVVBXa24wRis3NEw1RUlqQmJHQ1laOTNKaytn?=
 =?utf-8?B?TW1JNGFIdjcwUjdWWVJWTXpVdTR4R1FOZUxjSmxYN2RxRjg2NEU5T3NYNmdj?=
 =?utf-8?B?bi9DK2krWlB4SG82QWtxQ01jKzZBcGE3OWg0VHMwU0pZbStNU0E3OHplTzMr?=
 =?utf-8?B?a1MrdlBiZkVMYi9lU1pLY0pZZi9tOXBoc0JLM096UjFHRnV4ZWtVZnhyUUc3?=
 =?utf-8?B?Tm11bDlFY2pIVXkzQ25GNW82Qms3YlFiQTlsVjV5cU41SVdJbW5mMWx3OEdn?=
 =?utf-8?B?OUR1OGlkeWxSSmRNdlFGcXJsM0hpa0pYWm52SWxKK1RvbFBseDVUQWpyMTBT?=
 =?utf-8?B?aU5JY3BiZ1RWMkdSa3dybHpTRW42UkdjaXVKNnAvQWJZOWdyVzFNMm5GWlV2?=
 =?utf-8?B?WXZOK3dvVXRBUzVnVjJab0xDcGZvL0pFRlJhNjRoOHNGcGNUUUYwY0h4L0JJ?=
 =?utf-8?B?UmxzOHRMWHlUY1VzZDdOVTFWY3BGZ2NqbmJSTGI1NzZJYXZja3VVeEYxQUtN?=
 =?utf-8?B?eXo3ZWlDUDZvbVR4eWNNSEFkQVNTSWdMNTV0SGJjRVI1Tk1UL1poZ3IxWEJ2?=
 =?utf-8?B?MWdUaXIxYUtmSTB0WVFVRTdPR2h5Y3FTcUpmeWxwN0xYYkpkQXFFbUhybS84?=
 =?utf-8?B?eXhZeHRsMks2YVV6N0YwNkJONk5sRnZSaitBVWNQZFM4R1lzYUVUV0IrYWM5?=
 =?utf-8?B?VUNMZ29kK0J5d3RLMlljaGxOSkxwOHp6SW9ub2pwbzlMN0JZWDNwNTZuZEVM?=
 =?utf-8?B?S1d4YUJzc1dpUU9DVDQ2Yk9lMENQaFUyRmM2UEpLMFpPOTVuczNaMkZSS3FP?=
 =?utf-8?B?VDZQRlpkY1JjWHVDQjJEZW1WSXVKQlpucUxmM0ZDaU94Z3lKSGR1amthUjFI?=
 =?utf-8?B?RDJOSitMakdFZElqd3k2VytHTlZnSHBFZHl3MTE5MjIwbVlGV2ZlQ0FNM3RH?=
 =?utf-8?B?TXZxa3ByN3c0YUJFa2pHeGZESXBzd0ZTOGMxZUtVTDZxaTJvaVdQdnVkQWpY?=
 =?utf-8?B?dytjdy9pVzZ2SlpIak1EbnFRU05aaWZOekNwbCs5aXpOUGZENDJBbnZwME0v?=
 =?utf-8?B?eW10bDFuQkpJNWRjekV0bXpqT1ltakR4bWJnbTZkVW5qSTNpYjFlOERLVzE0?=
 =?utf-8?B?L2hrUmZueEhZOTE3UGt2NVF5TGt3WFcxaEE5UGwwM3JBWFFXdDdQd2h5TGJZ?=
 =?utf-8?B?dTM5TFVaS1NxMTJpY1c0Y1YwM1MzWlBHZSsxK05YTEpkLzJoYXRRd3F2TDZ3?=
 =?utf-8?B?bVYxMDIzMnRINjlvM2FuL0dwNE9VekRjcktrbmNTclU4L2dKeVVHeGk2cVZP?=
 =?utf-8?B?Qm1xSTV2MHhTai9MWlNjQnBPSHVSWVVWRUp4a24xT2V3cHdZVy9LTklxTmxD?=
 =?utf-8?B?aTRtRUgvMFFCaVVDMDVVVEV3Z3ViSTRnYlB2cHBzNGwzVmZDV0hvNnNNSkg1?=
 =?utf-8?B?Q3JhdjhNeCtrM0RqY29OUTE4NGt1OGxqTGZLMmRjaXZsSlo5UDI0YytWRUw0?=
 =?utf-8?B?VHltTlIzdUdhUXEyT1NZeHNnZERlOXNid0tzSzc0T3RJdC90QU1UL0ZBMjVI?=
 =?utf-8?Q?WlTYWC22VKBFEcQ6E+oq0lIsr9sv4w8lH8XrrzH?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19f9332-1963-4b0d-38e2-08d8f445cf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 13:06:33.4944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aRLZDjTTlx02ErHXE+Am9o7I8sBx72UrzXNRjfn8/bSfvLM17H6IEVb9c8/6yfZRzHhDQ0QQVZ3bm2JCOqbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3292
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-31_03:2021-03-30,
 2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310095
X-Proofpoint-ORIG-GUID: LSpP5LLZkTfAbpB03xQ5TMYcjLQaJJgl
X-Proofpoint-GUID: LSpP5LLZkTfAbpB03xQ5TMYcjLQaJJgl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_140641_524556_CBEBC17B 
X-CRM114-Status: GOOD (  17.15  )
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

Right. Thank you for the clarification.

Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Wednesday, 31 March 2021 12:08
To: Grupi, Elad
Cc: houpu.main@gmail.com; linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: Re: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

On Wed, 31 Mar 2021 08:28:46 +0000, Elad wrote:
> Not sure I'm following.
>
> Once req_init is failed, nvmet_tcp_handle_req_failure is called and changes the state to NVMET_TCP_RECV_DATA.
> In state NVMET_TCP_RECV_DATA we should not queue the response before it is get off from the list.
>
> Am I missing something here?

1. nvmet_tcp_handle_req_failure is called, 2. Return 0 from nvmet_tcp_done_recv_pdu 3. nvmet_tcp_try_recv_data() from nvmet_tcp_try_recv_one(), After finish
   consume inline data, nvmet_tcp_execute_request() is called. Here
   NVMET_TCP_SEND_POSTPONED is not set. As nvmet_try_send_data_pdu()
   is not called yet. (it will be called after we return from
   nvmet_tcp_try_recv_one()).

Thanks,
Hou
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
