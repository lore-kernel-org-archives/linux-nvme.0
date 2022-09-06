Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760BFECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfsiLCgUf4d6POfl/eN+OVOUxchsT0AbBjQu5JPKh5I=; b=y9HNuv5joTwrKpkVd1Wsz7Je8K
	FWgIs1cYL3l/7pJTeu8EpmSBT+3wGtXF3okHydoYuPx6eMi+BdeEqnbysGgZoj3zCCRRXbWvDn/RI
	hdf0rCzBMV3bQNpfHcRqRMlRQb6JI1qi38MM+LeD5sYfiUJI9KtUso0sUaTkr0ex4xGniC+jqlFWM
	XPigUNtdtBZE4GaHsFDNu0M39U3YH9UCNNcNoSKX+eF1srhhkyuwT+9TtSu7Im1KtiEJgBNQcfcPl
	8dCfop/f9OFKcOL+UHT5e7IY5IgVQbcABC4V1miQQycr6QA6UJZjNm2yHa9ua7c2zqvu+qnwh/3+W
	OX6rGcNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVXv8-00DRLt-GU; Tue, 06 Sep 2022 12:43:14 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVXv5-00DRK0-H6
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 12:43:13 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2869fsrb010758;
	Tue, 6 Sep 2022 08:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=qfsiLCgUf4d6POfl/eN+OVOUxchsT0AbBjQu5JPKh5I=;
 b=FtdUr1MQCSditsE871/a3RlrzRicurxm1hr9CHPclXA6ThhKJZDqx4SMUak3iUjU1SVY
 rT2MLNT25xbqzdBwd51H5JjlLaAwKGY7GntdEGP3fJsYtsKuR9y8ANNUzVUZxpO/kgfP
 pf3yiSUDMU0gGFKR1jEPZuFv/MBG8FMQgv42DihT/GfmpZCCA657njXH6aiF0XeKsnjA
 CxRMGeLG7h/+zrTeUSOcdu0+BrT5lxg+C3fLrXgfi5Qsa3TilQmuqrNF2qx1PBTbmkVZ
 bLVOEbjM9GIEvAjPzC/Be0jDoiQd9T0KcM6/O1tUo+2FbCQL7T/UFtlTDgsnaOm5a8kr WA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3jc3kp23f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Sep 2022 08:42:46 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286CO17M001545;
	Tue, 6 Sep 2022 08:42:45 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3jdgcst8f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Sep 2022 08:42:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLh1mQe8zrrfWBhEGmvehlXVMtEK+vi7FcGFXMyfLq0orApSr28ZjZs9RqCx629NejAYfZO3PQkgMh0JDo2uGT4ZrGY8HG3xTWytg86194zqEPzQm+FaFPHDZoAGD9kwx1dkzbSYf2mq3cEvQSuktQdpfp2p5qJEKAwfcDpYVLZrrPzwuSR0ncKPjvFvHo2pVgfsZsLsjqFme2jtGXoOiAyjpDIyNg9ePPQl6uzrddyk3EGI3BialYK2qAHlNk+ztoryNekjkBAlLFcBH/x12ePPJftfSMecYecNsLya3Ucig3LZYAxbUy2SSSHNtBeVaVZXRYvq9Su+U6FJJxVXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfsiLCgUf4d6POfl/eN+OVOUxchsT0AbBjQu5JPKh5I=;
 b=X9t0YC6R5as/QU9dSRpU1JiGHD/0+4IhqYlknOVn191w3B+IZbYNNEOOtmChf3ejlp+DzQQrT6PJhOR9MH/ldk2t3U+yb5OmDrFbvgdZY41/scEa1fsJ+gekMOhrPdeJkqOXtkIcUNKpEb6SOoxk85ctQh2SU7WYYwcTOF+TZxZFBah7Fqfv6svdx7EVMy2+aUwTNeBDzvmzPzgFyUMaS02GzUmwAJkarelBPNImRXxi1kC1zA6QGEKJlYa01OfkFVTBRrPc4R9m1POCq9OXw+QMgCI7Ig7RWFd9cv6L/CUmvj9ghey8Uj+wNHOimK+3F8h1Iu3y36mTCbKZ8rKMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by PH7PR19MB7121.namprd19.prod.outlook.com (2603:10b6:510:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 12:42:42 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::ed2f:81cb:243e:72c5]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::ed2f:81cb:243e:72c5%8]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 12:42:42 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v3] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Thread-Topic: [PATCH v3] nvme-tcp: Print actual source IP address through
 sysfs "address" attr
Thread-Index: AQHYvteZ8MDcNF5ar0CkdLJO3LxfEK3Qd70AgAHiM6A=
Date: Tue, 6 Sep 2022 12:42:42 +0000
Message-ID:  <SJ0PR19MB45440F0F979FB14315AE6B4DF27E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References:  <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <e98a1c28-4994-470d-6fee-ed569de536ed@grimberg.me>
In-Reply-To: <e98a1c28-4994-470d-6fee-ed569de536ed@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-09-06T12:26:01Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=ec448ade-7956-479b-8db9-dec864d81508;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41974d6e-ba79-4df1-ae0e-08da90054a76
x-ms-traffictypediagnostic: PH7PR19MB7121:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  bpojOlYir0WplqZBHcVsvpLaehn0sUBx/avWLB25/BKjp5uIYfjn9Tg+jnbjkbYPM2eJdFH7eHisorXtePuz6T2LZmheelJ8nxqgyjLUZYkHnWjHoG9ZBH2sQ6+QS7Tp2bHhTxdYGGGsADs4M+4siN2y89Hn6OhQMkV0iO/As/eWVMeafwyHrGd6brr9KKkSTmTJD2stfC90D7fYsWmItBNFCIgwIMbfPnIrZNZ7GDHHzK0OjfpX+Tp4zdmbAyc7hYhA6IikNc4D5ZKn5M4vUzBwotZ1QoQ8QcZULtH2cKHA/qU3ewnhv7jUe7dgqGXLubCKlmxsNnbl8Nuu8OoZCz2DPDIw1YdsYsTQzi3kWVB7Sm9tyNLT9QUBrU19xIc4zzSpQYLtdeX1dq4pLsfBXpMgYs5c/jTbtnH3lfRAlnbVOMGFUPGlSU1yvPEn7RJvc8p/wEM7bOmBY3EFydmqtJcYBwEkp3ZMkLck3uIg9GeosrffjWufPA65U8RjPt4o+7QZSStYChmyDUrsgfwVsAoa16525n0vApggTSBu7zg1tXljyRd4rC5/dAcnnD1i1FvbLmZujl1fj+KycXNkf4NAnIVy2A21XeOGtY4Q6bgbda1AistaSyc9M0VlswSqyOXk3SOngR/hjqsvjFokKI1Co+teb/3aLUH/R1irnaZ3lqJSiyioZ3uVqCSZF4BamsK6teHnGYYjH+d+jPm8KkNTpnSsndkypzv/fwCMvF+DjlkGK9Vbztmlx3AS5pNn8i+fe4QrQUeEKkYG+v4Jeg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(66446008)(8676002)(83380400001)(4326008)(64756008)(66556008)(76116006)(66946007)(8936002)(5660300002)(33656002)(66476007)(6506007)(7696005)(478600001)(26005)(41300700001)(71200400001)(186003)(52536014)(316002)(86362001)(786003)(54906003)(55016003)(110136005)(122000001)(82960400001)(38100700002)(2906002)(9686003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?alBZV3VHcHVQRERHenZnZzJCakRnaHRtZ2JENTNzb04zMUlYVk1qWkRHZUd5?=
 =?utf-8?B?WW9mM3ovdE8rR1d2U1g5QmxEUWdwY0ZzNiszZjJ6SHYzaVpEY08zekNHeXFE?=
 =?utf-8?B?QnBxVlhINm1QTENKeVB6OGZyamVJSCs4MERYMVhOZFQxL3l0N20xTWRvUkl1?=
 =?utf-8?B?N1VkT05nRmNDM2diczYrKzYyaVhhV2Z3eUpuMXFjUDdJZkFuV0Ryb1RwNDF1?=
 =?utf-8?B?TGk4cngzMUZudVBMSHZockZ3TEVhY3grN2JvZGk0cHNsU1FnNlJMNXpQNndw?=
 =?utf-8?B?Kzk4Vzc2TEZ6ZDE2S2VDYTVXOXJ6UjRTemM1cUlMRUw2WmE4Q1Y4NHREWjNI?=
 =?utf-8?B?bmZXdldvM3BNcGlqOGZzeWp6aThROFk0dmFMQzcyMzBia09IWVovTjJVU1Ns?=
 =?utf-8?B?bllaZXFFcDVBajdvNUVrYjgxRVVPQzdsN1ErWnFaeUVYbWdlRHIrL3ZpSkZU?=
 =?utf-8?B?OVJHd3B1dUxkMjBZOXlnRUhXY255MjJYV0YvRE8yVlI4TkYvUzlUV0w4Slpn?=
 =?utf-8?B?K00vdFBGL2ZVekV1WUZyZjRheGRieFNJcGNHVWloWnlHaWx2V0pCQnJYV0RB?=
 =?utf-8?B?Q1Z4MnN2Ri9YU1ZCbUIvcGlPRURUcXU0elE0cjNCNVhCWXAxS3JvaWx4cXRK?=
 =?utf-8?B?UFNLdjJ5U1RTbTNyanUxc056ZXRiS3dKd1RoM3JYK1FXYi9EYjNzYysxRTdT?=
 =?utf-8?B?bkFSU0ZnMStpdzlQakFiWUlISndIS0Z1NFQ4TFVwL3BWWTlqQU1kcEZ3S1JC?=
 =?utf-8?B?aERsL0pjVTJxN3NzZUx6aWRRbHNuKzN2dnB5VWJJWU11d0hJUHVmeHYzZUN2?=
 =?utf-8?B?ZVdmck9WREMzc3p5ajZsMWZVelk2MUtxWUx3K3EzWmNLa3gzMU5xcHd2cFpV?=
 =?utf-8?B?UnlCcnFHQWZHRmJoZStINlZITlZZekpkOHBhc2JSVTE1TDFLaWZyUjdrakZI?=
 =?utf-8?B?blZaWlFOUUsrY3QyY1YwMlc5U3ZDbWVFaWpZVk0zTHF3aG0zUUs0bytzeEJN?=
 =?utf-8?B?MHY0RjVQQzhYREFvWFdmbDhxNzVLd25CTlRkeFN6TTVvVldQV0ZZZURNWnVV?=
 =?utf-8?B?b2tCbnRialVtbkZJTzBNOGgxdnRkcmZUdkcvb2E5MVNXcG5ZemVTU24vZFA5?=
 =?utf-8?B?cmxacTNxanlYenVCWlVXVDVGeUU5azFvV2pEK3pibmVMSnhmM3V1Ly9HNGRu?=
 =?utf-8?B?Skg2bjByZE5LQlp0emEwWmVMakFFaG4rczN1bDNPNFBnN3VVWjFFT0U3ZkVL?=
 =?utf-8?B?MVowWTlmQkZYVTZ2UTZHTW82VzNmakJ0b00zbkpPcFljTEVsYzBlMGc2dUdm?=
 =?utf-8?B?L1VOUUcwYnUwV1pYSnk4TXFqekNpdEI0OTJuVUlQRkVkUkc2ZHNiUElWamZW?=
 =?utf-8?B?QVBlcEZ1d013eTcwTU9XT1BnVkxmMkVRQzhqempndml3ck9NR3pQWTRFVU9l?=
 =?utf-8?B?MzZLazNLR3o3SmVwTHo5ZjRTTnFhQ0VTRzBrdWhia0VOQ2V5bENzNXB5NkQ5?=
 =?utf-8?B?R3BPQVlHakpsN21jNnZpVXlQTG16Y1RqR2hrK3R0RUhaQnhMVnAzck9qc2xD?=
 =?utf-8?B?OHcxTWdMZ0V0bDcydEJZMDJyUzRqTlZPd3NodDM4OTE3c1Z4VHNZN0U2UWVG?=
 =?utf-8?B?UTNWaFZXM3A5UEhyb2N4NVlwbUlyejhMOHZTUytJcnZVdHNRQ3pteHQ5YVRu?=
 =?utf-8?B?UzZhNDd0RjRCTVlRWDlYMGFSb1ZodFpqUVVBRzQ4UkR5clF3aXZVb1UzdmV5?=
 =?utf-8?B?NmRndkE2aWk5SnFhZTZMakl1R1ZlZTh1Rlh3K2xOUENnQmVRY0tLd1doS2xa?=
 =?utf-8?B?S0YxU0FJWVRZWXE2b3BMb081R1ZTWkJKYUp0Vkh2WFZLM2RFcUY3S0tiT1VK?=
 =?utf-8?B?QUVxN2hvODBDYkMwZG4xQ0FEc3hrcE9yQ0YzMVRZWlNMRGFMaU9iRko4bGkv?=
 =?utf-8?B?Q2E1MkI0M3pvVjVJZ0ErR3dLS0hQWHBvazdhekE4SHl0bythRGx1WDNrWHJK?=
 =?utf-8?B?ay9CSHdjN0JjdXRHTjRMdTFjbk5Kd2p4cGFkU1ozbmxkLy9yejFmMGNTd1Ux?=
 =?utf-8?B?V1ZPVDEzNEpoLzJqbkZZNzVKYW1tUzMyTDBHdVJiSTZQeUNiOTB5Z2RrQURZ?=
 =?utf-8?Q?cPn+9JtCT77DwFnqfuHV7KZ5c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41974d6e-ba79-4df1-ae0e-08da90054a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 12:42:42.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULSj5ySEwgSirmk/fVl1y4whq2TBYGwmC+kaTj9P2MIpd1IDCrlKwK7BJSFGjfqOjaUuR0iuFViqaGhQR0fbOTOOp/ZSYeoro+AkcFVVkC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_06,2022-09-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060060
X-Proofpoint-ORIG-GUID: _UAc4LMIEXYJ4nJ1dy-MU5hx18ZsNyY1
X-Proofpoint-GUID: _UAc4LMIEXYJ4nJ1dy-MU5hx18ZsNyY1
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_054311_853858_E4A7ABA2 
X-CRM114-Status: GOOD (  25.90  )
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

PiA+IEZyb206IE1hcnRpbiBCZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiA+
DQo+ID4gVENQIHRyYW5zcG9ydCByZWxpZXMgb24gdGhlIHJvdXRpbmcgdGFibGUgdG8gZGV0ZXJt
aW5lIHdoaWNoIHNvdXJjZQ0KPiA+IGFkZHJlc3MgYW5kIGludGVyZmFjZSB0byB1c2Ugd2hlbiBt
YWtpbmcgYSBjb25uZWN0aW9uLiBDdXJyZW50bHksDQo+ID4gdGhlcmUgaXMgbm8gd2F5IHRvIHRl
bGwgZnJvbSB1c2Vyc3BhY2Ugd2hlcmUgYSBjb25uZWN0aW9uIHdhcyBtYWRlLg0KPiA+IFRoaXMg
cGF0Y2ggZXhwb3NlcyB0aGUgYWN0dWFsIHNvdXJjZSBhZGRyZXNzIHVzaW5nIGEgbmV3IGZpZWxk
IG5hbWVkDQo+ID4gInNyY19hZGRyPSIgaW4gdGhlICJhZGRyZXNzIiBhdHRyaWJ1dGUuDQo+ID4N
Cj4gPiBUaGlzIGlzIG5lZWRlZCB0byBkaWFnbm9zZSBhbmQgaWRlbnRpZnkgY29ubmVjdGl2aXR5
IGlzc3Vlcy4gV2l0aCB0aGUNCj4gPiBzb3VyY2UgYWRkcmVzcyB3ZSBjYW4gaW5mZXIgdGhlIGlu
dGVyZmFjZSBhc3NvY2lhdGVkIHdpdGggZWFjaA0KPiA+IGNvbm5lY3Rpb24uDQo+ID4NCj4gPiBU
aGlzIHdhcyB0ZXN0ZWQgd2l0aCBudm1lLWNsaSAyLjAgdG8gdmVyaWZ5IGl0IGRvZXMgbm90IGhh
dmUgYW55DQo+ID4gYWR2ZXJzZSBlZmZlY3QuIFRoZSBuZXcgInNyY19hZGRyPSIgZmllbGQgd2ls
bCBzaW1wbHkgYmUgZGlzcGxheWVkIGluDQo+ID4gdGhlIG91dHB1dCBvZiB0aGUgImxpc3Qtc3Vi
c3lzIiBvciAibGlzdCAtdiIgY29tbWFuZHMgYXMgc2hvd24gaGVyZS4NCj4gPg0KPiA+ICQgbnZt
ZSBsaXN0LXN1YnN5cw0KPiA+IG52bWUtc3Vic3lzMCAtIE5RTj1ucW4uMjAxNC0wOC5vcmcubnZt
ZXhwcmVzcy5kaXNjb3ZlcnkNCj4gPiBcDQo+ID4gICArLSBudm1lMCB0Y3ANCj4gPiB0cmFkZHI9
MTkyLjE2OC41Ni4xLHRyc3ZjaWQ9ODAwOSxzcmNfYWRkcj0xOTIuMTY4LjU2LjEwMSBsaXZlDQo+
IA0KPiBJIHdvbmRlciBob3cgdGhpcyB3b3JrcyB3aXRoIHVkZXYgZXZlbnRzIGV0YyBmb3IgYXV0
by1jb25uZWN0PyBhbmQgYWxzbyBmb3INCj4gdW5pcXVlbmVzcyBjaGVja3MuLi4NCg0KVWRldiBl
dmVudHMgYXJlIHRyaWdnZXJlZCBieSBkZXZpY2UgcHJvcGVydGllcyAod2hpY2ggYXJlIG5vdCB0
aGUgc2FtZSBhcyBhdHRyaWJ1dGVzKS4NClRoZSBwcm9wZXJ0aWVzIGFyZSBmb3VuZCBpbiB0aGUg
YXR0cmlidXRlICJ1ZXZlbnQiLiBGb3IgZXhhbXBsZToNCg0KJCBjYXQgL3N5cy9jbGFzcy9udm1l
L252bWUxL3VldmVudA0KTUFKT1I9MjM4DQpNSU5PUj0xDQpERVZOQU1FPW52bWUxDQpOVk1FX1RS
VFlQRT10Y3ANCk5WTUVfVFJBRERSPTo6ZmZmZjoxOTIuMTY4LjU2LjENCk5WTUVfVFJTVkNJRD04
MDA5DQpOVk1FX0hPU1RfVFJBRERSPW5vbmUNCk5WTUVfSE9TVF9JRkFDRT1lbnAwczgNCg0KVGhl
IGNoYW5nZSBJJ20gcHJvcG9zaW5nIGRvZXMgbm90IGFmZmVjdCBkZXZpY2UgcHJvcGVydGllcyBh
bmQgdGhlcmVmb3JlIG5vIGltcGFjdCBvbiB1ZGV2IHJ1bGVzLg0KDQpXaXRoIHJlZ2FyZHMgdG8g
dW5pcXVlbmVzcyBjaGVja3MsIHRoZXJlIGlzIG9ubHkgb25lIHBsYWNlIGluIGxpYm52bWUgd2hl
cmUgd2UgcmVhZCBhbmQgY2hlY2sgdGhlICJhZGRyZXNzIiBhdHRyaWJ1dGUgKGZpbGU6IHRyZWUu
YywgZnVuY3Rpb246IG52bWVfY3RybF9hbGxvYykuIFRoZSBjb2RlIHdpbGwgc2ltcGx5IHNraXAg
InNyY19hZGRyZXNzPSIgYW5kIGV4dHJhY3QgYWxsIHRoZSBvdGhlciBrbm93biBrZXlzIGZyb20g
ImFkZHJlc3MiLg0KDQpNYXJ0aW4NCg==

