Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCvLjD04mPicA+teUEnu7UMI+31z91dCFBmyDtosoQ8=; b=FqbhAD2SCIMLo+AN68OzD95bmc
	2h830YA8Gs7N86L48uHfJ8/M77ttefRJqzZBlzBPiRliTEz76ZGwiHqQBbMivq0jnkhP4CIHiBYWp
	DmfrKXsOyxTgs68MvqjrGkBreUm7afuLPJ00/L89ldjlDT9k7BJi60dSY9NYNbin0Nz2e0Sro7/h4
	2L77YsvygydVy3zZXEiIu9MT3RsrgmyfmULf0GqTe7hFQjuXlq/viI3lE/4JoskaFLaq703nu9pqw
	AAoQPFRC3mlz0EqhMdfnNV4L6DEVJ4/wuVD2Ds27SiYlG9w1JyID2C1++Uy/sFHI7Fpa9BGLkpjzA
	3LhCxmFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFfGT-0022Pw-0J; Thu, 03 Feb 2022 16:47:21 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFfGQ-0022PW-0I
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 16:47:19 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213GLh2G031934;
 Thu, 3 Feb 2022 11:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=vCvLjD04mPicA+teUEnu7UMI+31z91dCFBmyDtosoQ8=;
 b=w5dfTuSrhLdTpwfSVXz+2GCDFkk16N4nWs8n14AKHhvNTw54mofbt7IJ8uiiaUFoZagr
 Wt8s640ki61000Ejk5vBFfMVtJ2eqNOjWhHHfFv1u3lY0Wwf95LiwtQGRdhLpcsHhZ3x
 5LjEVWHseG3PPEkuJGZ0MIao/t8woq5WTF3ux5oqxnZu8Dr5GLcYE8i0z8WXi+OlQhaY
 FQDpEP4o/h9DVB02tVBM0lI3kQO94eh258l05ddi3/59Ne8W6mJGFee9aGfFlLLSvo0f
 y148LjlCrQOH42/43MMpyLKbiZneMQVR7EZZ0brrK5dKoKYhBzbPosF1xn0GsWTXD4UR cQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3e020uuh49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Feb 2022 11:47:02 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 213GjI0m001411; Thu, 3 Feb 2022 11:47:01 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-00154901.pphosted.com with ESMTP id 3dywuq8jkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Feb 2022 11:47:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlACxAGFSThRQiglrQ0w46DVMWSiolqut21TrugQIS7fCvludMkmN359WQVjuiok7wt8IzJ1w+MWyJSqdiwF8tYQynwmGkBx8LfRNcV6wmtyh4adEynQVao9ETHswV2+bwOw/+/n8ygsh6nYYvfj3Np9cTE4YZZFza7ES8BA7tl7UiZ3IGZ/OfTx2JCbOCCfodHLK020AEDVQrih04J2K8xDO+BLZQVswG2rWMRPblsm8Ufg4Az3MtFRLPq2j4D8IMtvPz00zEM2OKkRYEuxMBYMZESv9wOvM00uCvPBlfzjljorvNTIk7nK60hLM6aXM7k80fX4JL49k60i+gd3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCvLjD04mPicA+teUEnu7UMI+31z91dCFBmyDtosoQ8=;
 b=Htia2nCNfweCElLFN9TWsgjaW5xaYDnu4dxV2eGzlCKglpifrp1U/NuO+u4617qeXtgY4SMQGzzsVSn4rtkMEyxdjNErTA/PYu0irJZI8lkIpwE7bNOuYkhSGVlU0HhZjZSEbEeaWIxh0Ivh8BStVXt0AY1lkHiQ+bdB0smWhJTqBrUF00YfAHWGcxkqbJoLP/LHjsWve1Uvc+g5e7RRrokTIbckjvaaDl6iPKh12IPi5c3Biox0Eu7A403rV0zO3BDRTyMUsn8Ut7TcEjs1om3waLgu1EnTW9Ia5OtbTiFUrPUGyZtl0mVvRliZ84IuA9alAu6wpQL48YXbUosdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CY4PR19MB1558.namprd19.prod.outlook.com (2603:10b6:903:142::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 16:46:59 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 16:46:59 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "Hayes, Stuart" <Stuart.Hayes@dell.com>, "Rose,
 Charles" <Charles.Rose@dell.com>
Subject: RE: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Topic: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Index: AQHYGHzVH84DVIVYUE+St1ikwYiM3ayBa48AgABM5JCAAAtkAIAACSOwgAAHLYCAACJKgIAABKcAgAAM7pA=
Date: Thu, 3 Feb 2022 16:46:59 +0000
Message-ID: <SJ0PR19MB45447A22F305FFD65477164CF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
 <SJ0PR19MB4544B435D22B0F19E2B7CEBAF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ea56c568-9cbe-3087-21b0-81023ead927f@grimberg.me>
 <SJ0PR19MB4544CF86ADD8F3771CA9E4BEF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <d0fb3f06-a35e-c8f1-ae5d-b6871c913bcd@grimberg.me>
In-Reply-To: <d0fb3f06-a35e-c8f1-ae5d-b6871c913bcd@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-02-03T16:46:57Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=a1d7d903-7c92-4d85-9e71-64157182d8fa;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a64ed06-ca71-425e-c5a4-08d9e734cc0b
x-ms-traffictypediagnostic: CY4PR19MB1558:EE_
x-microsoft-antispam-prvs: <CY4PR19MB1558969715F59240B1644C9CF2289@CY4PR19MB1558.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVQI20H6TleWeIef5gn3OegzkKMSVTn/mtz5++vf5bwtTHMWe9jeZwoyX8nMx6dTOVH0xKpwAGsn5JbcUXYnNnVXAyVZyqV68Wkjod80hDnjpNiWeNMRCe1dGonScDuw0iYyCRa/POqgENYY4bh/LMvR4Vxf8q7c3uOhrVkWqLZfP+pKGlhgzNMmOylI4fQDG82X1D8QfWWQm6AMGRFR9qLPTFjqYxCC8uAaSjtxGCoLf3CJ5RHzRHdaoV821bIjGqGIWl31RcjgAfevkRRIIuKPIn6Iq31r/SpZLheAGEbkU3LpPnAgl9KhyPKcCnAI+Ru/Bn1W5xkuHU2BIZJveQXKukGc8NSi+1/xGGVQUMu5F2av9cL7V1Ew+3eX8BK87HNPgeNOipavf0NhgC182mJNPHkSTbsvHRAY3XIxaDwnss2x+5LWrDEK2eAMCnQyVuAzHgeUqw+q4EwHpHYzBD2YjnjzFN07Nj3H8RtT80W5tlTeGnlOtQfhlXcPjkm6iuUuBmath5Eytx0EgQeJPB8sa73MJMG1RLq6ap0P+PRIcgonEun2QqstrdGcHtFOXvPNhyeQCM9/WZYgE0+iywd+VGmHUk3RN/9vdd2TV6xoNq833LONbR0L8Wi/cTExqV/YZcU6eVtc194MQNNEn7gwZ24nlTEW05acIU+9TK9B7h33pHvX7qD33wwfpyj7W7KLylR5uu15Ac8OvtJotQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(5660300002)(52536014)(26005)(186003)(38100700002)(86362001)(82960400001)(2906002)(9686003)(107886003)(55016003)(7696005)(316002)(110136005)(83380400001)(66476007)(66446008)(66946007)(66556008)(8676002)(54906003)(4326008)(6506007)(33656002)(8936002)(786003)(38070700005)(71200400001)(508600001)(76116006)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amtINkVldHA4bWZLNXQwL0RKSkRiWWViRU9JclRxdmNsVloxY0lsTWZsOEZU?=
 =?utf-8?B?T2QyNURCVG5XL1poaEdjcTVNUHBRV1pRWnU2QVlZTlBubTlQYTV3Z3BDVm5M?=
 =?utf-8?B?UXlMeGpWTnhXVTJXVVUvQUp5UzFPWTBPc3JwckZNQXRiVzZZN2FKcENMemxS?=
 =?utf-8?B?dnZvL1V0L1BjbnJvb1RFOU9nWEpLWU5Ld1BkdEcrUkN2ZjlNWVRGYkh2TXF4?=
 =?utf-8?B?VkRPeTR5Q1F3TkxOSU43ODZpd0p3RGJUbGVyc25yaExyN2tPTkxla1RlWGQ1?=
 =?utf-8?B?ZEJmeUJqaS81aHFnNmdjN2RJTzB1c0swNmZWWkhzUXhzc0pnOUZONHFJeFZm?=
 =?utf-8?B?a1hFWEJ0a3J5WWF4MTd0YkIrM3IyVE10b2FuaGF1STlNZWRIQnN4bW1YYVVO?=
 =?utf-8?B?ajdSNHU1WWJNbzFsYzNNbS8xb1Y2QkowMHREYUdPNXRaTmp0K2dtblJLRTRy?=
 =?utf-8?B?Q1dYYWNvSWRRRHBBQldDRE1WNHJydENKS2FyTkhkbytPOURBZUt4TFVPSGhG?=
 =?utf-8?B?NGdGMjEzQ2NiVXNpd2F3WUYwbTZycDRpbHdZUUVMVDZhdE1Hb245ejdESytB?=
 =?utf-8?B?TTZrMS9LUlIwUTk2TTBFRndzNUdGMVdFeElPa1VFQ3Q5L1dLa2p4a3pYMGJB?=
 =?utf-8?B?WWZnZjkzcDljQXdnTFVVeE1lbnpWMzJuM09oUnBJM2VCZmVZWWZIL01ybGNr?=
 =?utf-8?B?MkxNVldxQlRtS2M5K1VuQ0o0ZThHUzBPTzB0NnZIbW14ZmxnQ25QRXAwcDNJ?=
 =?utf-8?B?T2ZMQXo3TVZGd1ROZ0d5bU9jL1ROWEtpZ1B0U04xWWpBejNCS0dDRkRPZlZX?=
 =?utf-8?B?YkNBVmtsMnVvZi9wUnBqVzVYQTZabDFTOEpQMGg1eHlwelFiMGJCekl4anRZ?=
 =?utf-8?B?SENRN1JMUWJWQ3BMRlZ0ckcyR3FRTTJHeWJUU3BoSmJNNnExRkE3UVdjbVda?=
 =?utf-8?B?aC90dnhLM1puQjR6R3V2WFR1YzY1NVNSQStqZkgwck9uTUx2VHlWeTA4bnM4?=
 =?utf-8?B?djFTNjN5VHUrU3cwQkx6K2YrR09WeG4zU2IwZ2JXYnNKL01rK0ErY05mcERo?=
 =?utf-8?B?ekRxRGQ5TU1xQUY1MFd5YlBuU1BKS0VSMXRkREZuUlYxV21nUElaZ2wyVndI?=
 =?utf-8?B?T084UllNdlhDQ0ovcXdzM2NnZk5tdkQrK3Y2ekg5UmNXd2xaeVNvTEhMUU9X?=
 =?utf-8?B?NDIzZVhlS1NHQTdIdTNoOFAwMno3OHltNk42YnB1WVBFNnlOanBzQWNIRzls?=
 =?utf-8?B?bk9BcFJLT2grQ05hOXZoV1BVdUgwR2QyYkhITjJucHJFbUs3cWZWblJFVXRq?=
 =?utf-8?B?L2FtK2JydGpzNVVVYkhqcnBPWXkrRU9zVEQxN2JDQW4rcnV0TXFqQVRPYmJ1?=
 =?utf-8?B?d0Q2UHVpUDNCWEFYWnRQQkRLbFJCVXBtczZ1dGRxZmovWkgvTWxSVG95ZE1n?=
 =?utf-8?B?MFhvM2Fmek9iTDFWWFdvT0VCdzFxM0VUdGQzTzRvNUVIR1F5R1pTRGVKK2Vz?=
 =?utf-8?B?aUwvakJLNVVlbXlxTzQySk1GMXBveXBsUzlqNklRQ2ltZUwrckxOS2Q0aE0w?=
 =?utf-8?B?TlVqaWhURkF5L05ueEVVTGY3REhQLys1RTg0NHZCeUx1bnNVdC84eXJkSkRL?=
 =?utf-8?B?L29ZQUZPWjFjb2lqcDhEdkJGRTJFTDBDeU9PMUpxMXZacnh0bitoZnd2VDd5?=
 =?utf-8?B?dGNoWDZ2bnVmV0tQdyt5S3lzL3d5Wm9zTW1YZWFaMXozaGxxQkJGM3U4TVhw?=
 =?utf-8?B?WXkxVzZPZjB5bUU4VWsyRFBTUmV0Y0pqbVM0VGcwVlFwL3ovK3NWeFBWakdr?=
 =?utf-8?B?eU9JRG9YNCs3Z1c0c3N0dmY0UXgyWkorejlvRnMwd2tiZkluWUc4cWUwL2hp?=
 =?utf-8?B?WFp6eVFQT2tjZ1Vkai9ic0RWU1RYQTg4RHdQU3B3NnZWWjRqUHpqaVYzeDli?=
 =?utf-8?B?N3hicmVENzNXWjcxK0NRV0JmeGRVaENUa3ZtS3A0WXgxaE1KcEdlMHF1WXln?=
 =?utf-8?B?R2tXYldXTWhra0VpOUhWY1VXbWFweC9EYStTQ3FxeWM1elplcytoSGFRWWto?=
 =?utf-8?B?cFhnUnIzVkNKV0hhcTlzaU9FN29lVXNnRHpOOGNLdm5HczRMSW9EdkR3Z1hC?=
 =?utf-8?B?WVdZUm0vRTN4YnBFUFA0c2VyaGEwM3U2RTc1YWhRM3ZpWm4yRFRXVnRYY01M?=
 =?utf-8?B?VERjSWh3TlIxQUlzRkExT2Q5NldnMU94dUx5SjBHWVhrUW5rODVvc0lzR3pV?=
 =?utf-8?B?QmQrUTBBRlJlc1VuOWRONWpEdWpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a64ed06-ca71-425e-c5a4-08d9e734cc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 16:46:59.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqczN8EzEvJXkHBuoxTTkKhZVYz3Qybp5RDch1yV2y+TUZaBT3VrxPEcaMvNFBh48tJbV7RT6HAl2c7nV6ThcqgB0mpWZWAUsSH252MgkR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB1558
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-03_05:2022-02-03,
 2022-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=715 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2202030101
X-Proofpoint-GUID: ILOhGGw3opP6hbAeXdoMsDALtEZvUq6v
X-Proofpoint-ORIG-GUID: ILOhGGw3opP6hbAeXdoMsDALtEZvUq6v
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=809
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_084718_237202_6134A5C0 
X-CRM114-Status: GOOD (  29.66  )
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

PiA+PiBUaGVyZSBpcyBhbHJlYWR5IGFuIGludGVyZmFjZSB0byB1cGRhdGUgc3lzZnMgZ3JvdXBz
LCBzbyBpbiB0aGVvcnkNCj4gPj4gdGhpcyBzaG91bGQgZG8gdGhlIHRyaWNrOg0KPiA+PiAtLQ0K
PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jDQo+ID4+IGluZGV4IGMxMWNkM2E4MTRmZC4uZDg2ODI4Y2Y3NzIwIDEwMDY0
NA0KPiA+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4gKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jDQo+ID4+IEBAIC0zMTE1LDYgKzMxMTUsMTEgQEAgaW50IG52bWVf
aW5pdF9jdHJsX2ZpbmlzaChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KPiA+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+ICAgICAgICAgICB9DQo+ID4+DQo+ID4+
ICsgICAgICAgcmV0ID0gc3lzZnNfdXBkYXRlX2dyb3VwcygmY3RybC0+ZGV2aWNlLT5rb2JqLA0K
PiA+PiBjdHJsLT5kZXZpY2UtPmdyb3Vwcyk7DQo+ID4+ICsgICAgICAgaWYgKHJldCkNCj4gPj4g
KyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+ICsNCj4gPj4gKw0KPiA+DQo+ID4gSSBq
dXN0IHRyaWVkIHRoaXMgYW5kIGl0IHdvcmtzLg0KPiANCj4gTWFrZXMgc2Vuc2UuDQo+IA0KPiA+
IE1hcnRpbg0KPiA+DQo+ID4+ICAgICAgICAgICBjdHJsLT5pZGVudGlmaWVkID0gdHJ1ZTsNCj4g
Pj4NCj4gPj4gICAgICAgICAgIHJldHVybiAwOw0KPiA+PiAtLQ0KPiA+Pg0KPiA+PiBCdXQgcHJv
YmFibHkgd2Ugd2FudCBhZGQgYSBuaWNlciBpbnRlcmZhY2UgbGlrZQ0KPiA+PiAtLQ0KPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jDQo+ID4+IGluZGV4IGMxMWNkM2E4MTRmZC4uOGZiOTRjYjE1ZmIwIDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jDQo+ID4+IEBAIC0zMTE1LDYgKzMxMTUsMTEgQEAgaW50IG52bWVfaW5pdF9j
dHJsX2ZpbmlzaChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KPiA+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+ICAgICAgICAgICB9DQo+ID4+DQo+ID4+ICsgICAg
ICAgcmV0ID0gZGV2aWNlX3VwZGF0ZV9ncm91cHMoJmN0cmwtPmRldmljZSk7DQo+ID4+ICsgICAg
ICAgaWYgKHJldCkNCj4gPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+ICsNCj4g
Pj4gKw0KPiA+PiAgICAgICAgICAgY3RybC0+aWRlbnRpZmllZCA9IHRydWU7DQo+ID4+DQo+ID4+
ICAgICAgICAgICByZXR1cm4gMDsNCj4gPj4gLS0NCj4gPj4NCj4gPj4gV2hlcmUgZGV2aWNlX3Vw
ZGF0ZV9ncm91cHMgd291bGQgYmUgc29tZXRoaW5nIGxpa2U6DQo+ID4+IC0tDQo+ID4+IGludCBk
ZXZpY2VfdXBkYXRlX2dyb3VwcyhzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPj4gICAgICAgICAg
IHN0cnVjdCBjbGFzcyAqY2xhc3MgPSBkZXYtPmNsYXNzOw0KPiA+PiAgICAgICAgICAgY29uc3Qg
c3RydWN0IGRldmljZV90eXBlICp0eXBlID0gZGV2LT50eXBlOw0KPiA+PiAgICAgICAgICAgaW50
IGVycm9yOw0KPiA+Pg0KPiA+PiAgICAgICAgICAgaWYgKGNsYXNzKSB7DQo+ID4+ICAgICAgICAg
ICAgICAgICAgIGVycm9yID0gZGV2aWNlX3VwZGF0ZV9ncm91cHMoZGV2LCBjbGFzcy0+ZGV2X2dy
b3Vwcyk7DQo+ID4+ICAgICAgICAgICAgICAgICAgIGlmIChlcnJvcikNCj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyb3I7DQo+ID4+ICAgICAgICAgICB9DQo+ID4+DQo+
ID4+ICAgICAgICAgICBpZiAodHlwZSkgew0KPiA+PiAgICAgICAgICAgICAgICAgICBlcnJvciA9
IGRldmljZV91cGRhdGVfZ3JvdXBzKGRldiwgdHlwZS0+Z3JvdXBzKTsNCj4gPj4gICAgICAgICAg
ICAgICAgICAgaWYgKGVycm9yKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3JlbW92ZV9jbGFzc19ncm91cHM7DQo+ID4+ICAgICAgICAgICB9DQo+ID4+DQo+ID4+ICAg
ICAgICAgICBlcnJvciA9IGRldmljZV91cGRhdGVfZ3JvdXBzKGRldiwgZGV2LT5ncm91cHMpOw0K
PiA+PiAgICAgICAgICAgaWYgKGVycm9yKQ0KPiA+PiAgICAgICAgICAgICAgICAgICBnb3RvIGVy
cl9yZW1vdmVfdHlwZV9ncm91cHM7DQo+IA0KPiBUaGlzIGxhc3QgaHVuayBzaG91bGQgcHJvYmFi
bHkgYmU6DQo+IAlyZXR1cm4gZGV2aWNlX3VwZGF0ZV9ncm91cHMoZGV2LCBkZXYtPmdyb3Vwcyk7
DQo+IA0KPiA+PiB9DQo+ID4+IEVYUE9SVF9TWU1CT0xfR1BMKGRldmljZV91cGRhdGVfZ3JvdXBz
KTsNCj4gPj4gLS0NCj4gPg0KPiA+IFNhZ2ksIHdvdWxkIHlvdSBhZGQgdGhpcyBmdW5jdGlvbiB0
byBkcml2ZXJzL2Jhc2UvY29yZS5jPw0KPiA+IE1hcnRpbg0KPiANCj4gWWVzLiBUaGlzIHdvdWxk
IG5lZWQgc29tZSBtb3JlIGV5ZWJhbGxzIHRob3VnaCwgbWF5YmUgdGhpcyBzaG91bGQgYmUNCj4g
ZXh0ZW5kZWQgdG8gZGV2aWNlX3VwZGF0ZV9hdHRycz8NCg0KSXMgdGhlIGxpbnV4LW52bWUgcmVw
byBldmVuIHRoZSByaWdodCBwbGFjZSB0byBzdWJtaXQgdGhpcyBjaGFuZ2U/IA0KVGhpcyBpcyBh
IGNvcmUga2VybmVsIGZpbGUgYW5kIG5vdCBqdXN0IHRoZSBudm1lIG1vZHVsZS4NCg0KU3VibWl0
dGluZyB0aGlzIGNoYW5nZSB3aWxsIHByb2JhYmx5IGRlbGF5IHdoYXQgSSdtIHRyeWluZyANCnRv
IHJlbGVhc2UgYnkgd2Vla3MuIElzIGl0IE9LIGlmIEkganVzdCBzdWJtaXQgdGhlIHNtYWxsIGNo
YW5nZQ0KYW5kIGxlYXZlIHRoaXMgYmlnZ2VyIGNoYW5nZSB0byBzb21lb25lIHRoYXQgaGFzIG1v
cmUgDQpleHBlcmllbmNlIHdpdGggdGhlIGtlcm5lbD8NCg0KTWFydGluDQoNCkludGVybmFsIFVz
ZSAtIENvbmZpZGVudGlhbA0K

