Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511AEC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:01:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC04E6146D
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC04E6146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lip+BAaPpFfvdIpUtl/jVsuVHU71gzZ//hiuEhZKwBo=; b=TKaHpGYlcUwWDvoNHOpz1Zlq7/
	9iOaxC+VrEDhk5LmzIL8jPdCwduoD/rVa1fYY39RC1EhydEMyQKI9PFmajqvBXCibX9Ai9/dwI1Ad
	RjcSIUTPWqfhjTQVAxUhxgSHqVm+bTTTd8BeBO61drOOKSWXadAtNEnTzixVWi4uKGcte39Miv6la
	IH8MbVApwqpW7xkHNbwTIe4Ch+U9+4w3s0IVF6Yc+q+tSQnc2PJWnaD+oav2HhXhZIW5QreIZSJdV
	2Jq61/EoPGr4YqtARVJM0ToZGeel2ztaJIRvQQdGJ7y0UrtoGNr87vOWFf9BSDe4YyS+5sdzYI6NO
	mt8Bosvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBdUj-0006Pr-MU; Mon, 15 Feb 2021 13:00:53 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBdUg-0006PE-Eg
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 13:00:51 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11FCvkgl030631; Mon, 15 Feb 2021 08:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=9mLOaGhDMo37UGzc3SDiKfsJbXBMr8MoU0ZK0UlLuO8=;
 b=maxi8ay2L2n2wi5DlTC/TfSLwjtONOrxaoc8ZLJDZiIEminSAi5XN0eJ/wEyGqqDrNbt
 ZXWWzDLUX5UdM7oYi9vmdV4JlIkEUA/PFRmrVClZ+QLbfyaUwQYofRLDerbefgrxP0DR
 1OpQTNxrNsLDGvkOi1Iw6NQzM1sOdrTCgJ2E4AH2+BZW8Cpn6erDfl00EDCdci30IDXl
 1NOTT7J9a8SYOVR0ccUZlXVIsV/xxWYOaJ49iWaeW5965xqW39CeeaqPAqLcCPZWBdZe
 Sr8sjdJWvP/74bDnnxlKizkoWLtPZUdmpigdY/ZHbylZ914r1aetQ6voWo0G7QFDVpBs 4g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 36p8qyvdu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Feb 2021 08:00:37 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11FD0C6e054728; Mon, 15 Feb 2021 08:00:37 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by mx0b-00154901.pphosted.com with ESMTP id 36pvyv727d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Feb 2021 08:00:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9WpaECPkb8QQtcOHcV6cObIPX/xmGYa3BdlmW6dJakfHcSKtq9raadwCHBSpg8EM60xoAnH2Q+W6KTyL2wbNGRg2iixYzhFTtbsha5hKNOjGon5haBjNF230cm//hlPHNQFc0LM5oQEIw04OYEkus0VMvfDC5csOPLlj8Jiwvu+MjGgfr0BsnwTa6AoNCjZXnC5U4rEwcr0x2AjM0EDZN+iqGHtFRaYodgFDCiTgqWgeeyIYabGn9cxra/oNpQozTvewCweoqe6uQdt0sg9/iEIHkgOInhhF6EPrIe2Py3ZA9CHhwAWhNW1PNdYsgAo+EHzj7XyE2mXkxuQOzY6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mLOaGhDMo37UGzc3SDiKfsJbXBMr8MoU0ZK0UlLuO8=;
 b=euO4iuPxiw5X2wC+zO7mOZbyjczo+k33YOWJnxA/XgSfGBRuK8dvitjp0Fg3JTKUtg2NOVumeaUuGOFGeJBiJtT4p4hXOADpt/MymIfHnWKA2lgzpbDA+1aJXsyGrr2MBeJSC32TQs/QkJ/URIRxrYPEJM93BqMbziu9+qbfLhcG43oZ2LraJup+LPM8qyzRtQ8RuLmvwCEIoKOqO9hCCnoN7gPMz/d5gTKJRU2sSMJwqEnQMSbjTfjjgoNLJp+4uN1h4nBXoNGb7zW1jqQrqlyfdRi8ga1D4ZHt8kuEtuRG5S20df70NgrKSiOqivyo7m/OoGOhPEVVC3DuYNdRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB1129.namprd19.prod.outlook.com (2603:10b6:3:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Mon, 15 Feb
 2021 13:00:34 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 13:00:34 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: RE: [PATCH] nvmet-tcp: fix potential race of tcp socket closing
 accept_work
Thread-Topic: [PATCH] nvmet-tcp: fix potential race of tcp socket closing
 accept_work
Thread-Index: AQHW+/e/dRBHiedMuUyXvtpAN8PgbqpUL6OwgADzdACAA/AwsA==
Date: Mon, 15 Feb 2021 13:00:34 +0000
Message-ID: <DM6PR19MB40118CA60B63407DDE5AEB33EF889@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210205194725.625035-1-sagi@grimberg.me>
 <DM6PR19MB4011C3BCABE1663D864ECB67EF8B9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <d26978a7-b9a4-8925-1a34-c5e194eb342b@grimberg.me>
In-Reply-To: <d26978a7-b9a4-8925-1a34-c5e194eb342b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-02-15T13:00:30.8794834Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=757c1247-be6f-449e-9da5-ede28598e1ca;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [87.71.82.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaeb6d7f-84a7-4ae5-e41f-08d8d1b1af06
x-ms-traffictypediagnostic: DM5PR19MB1129:
x-microsoft-antispam-prvs: <DM5PR19MB1129CE5FD12FF1DD954EC881EF889@DM5PR19MB1129.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8D8C8QReO0FzBLyk506hrUgbl6EvPrsXWLNSERuOgYcmz/UKXgj+4Lkr7TskcO0syG1IWXq4Bo9XO0Rg/v30arpV+MJ57+hNpykto7SG2sb1Pt01BPwFALFLpHR1sxozz3tIhsppIR7hbBtDCwUzMkBrq6kCBQx+byNUuDAgHWLQMhvZg9LxHPKX6C75oy1xvnYqMkWbx7ksSbEI/H0y1L175CkDiknAysgrlMeBuT8TZd3oUAqLnJP8v/osh7fjWIWoxr07R4JkZEyrVBE1RZcT4N9dbkVcPdSFjD4pSARhyKtKVV8ObLpoC5JkGPmwStAT/Ac0QI3xlond28lColyYABLBwH0A/eOPO4AfD1QiwxmOm0Pyd5gcRx5raTO5DLN11DeLcBO0yLH3qVEvD7Ra8OxOBBA9UIN4unJylqXfixYIsTGeX6nvUfKyPaJdmdaCtN+epKaIpzNklDCxJfwgndtxquI7cyC+HcSk+YxGccyuH6gmijfvIvFaTgGBFA7Urd8Zwfk/FHkFUvOBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(71200400001)(110136005)(66946007)(76116006)(5660300002)(316002)(786003)(55016002)(52536014)(9686003)(26005)(33656002)(86362001)(478600001)(186003)(64756008)(66446008)(8676002)(53546011)(6506007)(8936002)(66556008)(66476007)(2906002)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YXd2c2Q4WWVQbGZONDdLVXhqc2tDS0FmSnBsNSt5bnZ1R3kxa1Z3d3FtNThn?=
 =?utf-8?B?dktiZlE4MUxBNGxFclIycjhRRmVkR3crTHRabkZmSjJpSklqSnEwSjJpVkh4?=
 =?utf-8?B?akNzWjJ2Q2s1ckQyemd4Uzk1VUlOT2JocEZzOUphR2sySkFnOTlBWXVwcU51?=
 =?utf-8?B?RWJoZGpWL3hnNm9oc1ZoQkhHMHFkZFJPVFhWR2F6ZWpOenl2T3laVEM5THFt?=
 =?utf-8?B?OFB1cUdvNm0xUEN4MnJtTmtnZ25Rcy9Bbm84bEJ6WkdVdldkalZyUDRIOHRN?=
 =?utf-8?B?c1RrekpGbU52UUhpdXdWSVVodWJWS0gvWGd4UCs0dm5OUXBOL0ZCM2ZMMEZm?=
 =?utf-8?B?MjJ5RUV1L295M0hBemcxcG9FQVMyUnRPbWVubnQ5MUp1dVIrME9qMzVuaWhX?=
 =?utf-8?B?M0h5QlNHdG1uZytCZWFQajlpNEhiR0lqeVpKbkgyeWFnS1NTQ0s0TVdPbk96?=
 =?utf-8?B?TkpHelBVMjdFdk5NZk9IeWVIcmxDS1N1QURlU0dtbStRM0xsUFNOZ01PeC9D?=
 =?utf-8?B?MXlFcGxGWDcrTGpJeUxEYXFXNEszMGRURi94MnJPT2RQcktIN05KSXZPMFB3?=
 =?utf-8?B?TUlYanMxanpFL0JScVpaUXNYMS9RbU01T0hIcWxyeW1WWkFmNEdCSml5WmJK?=
 =?utf-8?B?UzRpYlpHNFNSV3QrbXMxS1lMcmlEd3cxV1VzMWlwZlltQlAxSmVhcTBLUXBT?=
 =?utf-8?B?VzhoR3ArQldLaklKMXk2eVJwcEZTTXJKUmxlYTRPM294SFpTUU1rSGU2cjlh?=
 =?utf-8?B?ZGtUK2UzRzR3Wk1YUjVUemEwOExIS1F2UFVKN1JWVVNPUXM1dkxpd0J5MytO?=
 =?utf-8?B?aG40eGN0ZUhuQ1NxK2lZQzJtS0VCbUwvbHNtZDNuaUFiWms0UnhUNEtHVDBW?=
 =?utf-8?B?eG1KVnU2YWFrT0VDeEFJQ01ERk5OYkc1dkh0L1VUZG1nSWQ5b2paY3d0ZnFM?=
 =?utf-8?B?alFOMXdSMzFWUVBPaDk4aW9Dbmhyd3diR29Da1ZvZERQQ2ZocGplYVlZak5J?=
 =?utf-8?B?SUNiZVd3bUIvTWkxSTJNdzJvY3JNY0ZJdzlnV24wcitkekFxQ0FHZXNVTlZB?=
 =?utf-8?B?UlNwU0FkY1JSR0RzMW82dVdIK0c0aHN5dHhiemNDaEZvSlNHeFJYZXMycW5y?=
 =?utf-8?B?MGhpbExxYkpmcmRqTnFqeEo3elRwZ3NySUFSTXdENm5LQnJuWStGSjQwaWh0?=
 =?utf-8?B?cEhSd0NPU2l2TUZmQkhvOHpBcmM1Y2d6SXo3Y0JxdzZPcm15L0x2WXY5SkZh?=
 =?utf-8?B?bkFJUUNaUUdnb2VTT1RZZzdMTVE2MW1KaGFSSEFzUURTZ2J1ZVlQbXhhSHQv?=
 =?utf-8?B?bW9wclRxUUljU3lxRzJzN1JvTitMNUlJeFlLNzZLWVE4N0Z2dFZyejRSQURm?=
 =?utf-8?B?bnVYVnpZazhmU0VFUTdidDJmS2ZRRC81MWlLWkFUQ1pkdWlCejVXdHgzWHkx?=
 =?utf-8?B?OXMxdTdESjh4VldubktqWVRrNG1DZUZxaDBITzBqTTlOL0tleUh0b1FUcFJ0?=
 =?utf-8?B?VTU3UFQwUEgvYnduZXdIZWwxZk10TXVRRkV4YnFqalc4MFgreVBvMmUza09T?=
 =?utf-8?B?MDUyV2JrdTM3d0NwVHAwNUpESVp6Sk9hWGtzMWNJRFYyakdDSEtsUUV6ZjA0?=
 =?utf-8?B?VTVNQVYra3VhNXhzcmc3dzZpZGNtVFNnd2FDS2VzeTBmcnN6YURLZ1UxSkF4?=
 =?utf-8?B?blQ4RG95ZHhodElhamV6TmtyQUpHd3lXTDJiUW9tQmhERHl5Y1JiR2E2cHg2?=
 =?utf-8?Q?bojcgYdCsQm8hmCLkY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeb6d7f-84a7-4ae5-e41f-08d8d1b1af06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 13:00:34.8487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qUEjxuH62HvhgRqjFb8NiWXsFozbMmISNHZqSeNjJhzr9BDK1mYfIpzcDQS9kAqRh/NAMcN30w3gsBg2jspfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1129
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-15_06:2021-02-12,
 2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102150105
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_080050_618943_2D1C22DB 
X-CRM114-Status: GOOD (  23.30  )
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

Yes. That's about what I meant.

Does lock_sock protects against invoking socket callbacks?

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, 13 February 2021 0:22
To: Grupi, Elad; linux-nvme@lists.infradead.org; Christoph Hellwig; Keith Busch; Chaitanya Kulkarni
Subject: Re: [PATCH] nvmet-tcp: fix potential race of tcp socket closing accept_work


[EXTERNAL EMAIL] 


> Sagi,
> 
> I think there is another race in that solution.
> 
> Please consider following flow:
> 
> Thread 1 taking sk_callback_lock and goes into the else block (state is TCP_ESTABLISHED), going to line:
> 	sock->sk->sk_user_data = queue;
> 
> at that point, thread 2 invokes sk_state_change, but this is still the original state_change callback because we didn't set yet to nvmet_tcp_state_change.
> 
> Thread 1 continues and set the callback to nvmet_tcp_state_change, but the sk_state_change was already called and nvmet_tcp_state_change will be never called.
> 
> In that case, there is a leak, and the queue will never be removed.

Are you saying that this is needed?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index ac2d9ed23cea..d82df6cca801 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1486,6 +1486,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)

         ret = 0;
         write_lock_bh(&sock->sk->sk_callback_lock);
+       lock_sock(sock->sk);
         if (sock->sk->sk_state != TCP_ESTABLISHED) {
                 /*
                  * If the socket is already closing, don't even start @@ -1502,6 +1503,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
                 sock->sk->sk_write_space = nvmet_tcp_write_space;
                 queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
         }
+       release_sock(sock->sk);
         write_unlock_bh(&sock->sk->sk_callback_lock);

         return ret;
--
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
