Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E53C04A6A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqMzXLFLLMKqSPCmE+fHX5xvgIo7LlIZNxo3XeZ/msA=; b=zNUqOh7poADQyT4kR+dQu4Oy1e
	25eoSlIKDWT57P2MJ6C+vFBcDs88jcN0dtrF36v9e099BbGJZnWJmTFFxlQ9oZnKqiVS7A2/HG6dV
	tzB6nDQ0nzEfz3dzZL2v8A1LB2ND4Zmc9Fcp8TJ8ouQrOUln1kNbsetNFriRMguJz9fxB34DbLAaM
	0cPQLnX5DwyOm54BvGuBCM44StEwkV+YC9fui715kbthjEWZT9zYcGIoS59JGeQQVTb+Iu3kbVBtj
	nGDpIcTQnCy9ers4ZuA7O2WewOdpweNjlgoarl9wQ5UPuY3AwmLVT+3ogtY1vZJQDjH70o/JiCkVl
	ewjvYOdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5kg-007jnV-09;
	Thu, 10 Aug 2023 13:30:58 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5kd-007jmv-1D
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:30:56 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ACkiZn010101;
	Thu, 10 Aug 2023 09:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=KqMzXLFLLMKqSPCmE+fHX5xvgIo7LlIZNxo3XeZ/msA=;
 b=vPP3s618E+Q6ZuSsgjmIuGeeCvpmKm1VIk3ernyJJoBz6ED5lR6TtcesIdHL7PNWRAR7
 KoRQ4lBI8KJsLg7ppJtDQQ2dFSkBz2qN0R1fwTKIY6SN77aAcZbl6G7GUKxbzVLmyn7O
 zl+iSyPwwjMsESyJqv/Xnnn/b9mW8914Lo0N8kWOU8YISrCPu+58f85Fm34FyFzFuqN4
 gIPVTITvXAtqM2JEIIed8mBaaFpMitfr42dyvVCEV4fS6R8qHcUI/xXK2JDHQuqm4ep0
 XyTCKqNa7tXBfx3aWRkFRo6XDVWeoUJNI/9ubeEWaD9BfHJZzQq9rQU4sSf+wcwO6+Ea AA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3s9hkdpr3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 09:30:50 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ACp2VK022902;
	Thu, 10 Aug 2023 09:30:50 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3scrp0q0yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 09:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1qWuyUc0LAaoVOObgEtVKscc7oCNtC3O8iiRvmJA9IR8sakOvxnOQGIi1bCW0eD+05KsruuvsiCBbu/rjZSKWGYdNDapjifb7Z7R2dC+BYzUNUzbNxwwcLE/nESTjSH95tZ02JDvt5EgJjBBng3gxEGFUcUUMPNaU3xKkhDJfIdkKtpr2EcpFNMyzBavsRYYF1tyWEqSuAi41Mo2SjVt57sbI/ULKWwfEIf8Gw4fFmM9ijF6JDWgW9dQrp7ZfQElvzgxDG3EXCwdznc9DGFSfeUol9fZc/Xf2h15QI6Etqxra+FhrOeQaFIdKW4AlS6OlNzwHAGdf+4IeRqa+PPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqMzXLFLLMKqSPCmE+fHX5xvgIo7LlIZNxo3XeZ/msA=;
 b=a5Nl6Gsbq93OLdAy+sRiSMfhEUHT0ZmI9Y7ckLyL2M2VKD/JqbDo9kbyGe8o7bORV87HIJ676WjPBowXlKGMcF9cZNl2wBObCMc2QDyLc0OiUZmNuTyCVi+0Tp/mnB+zqKPxS3QGeM1lHh/RS7/jETOrsKUv/uojmasmCbV4z041exEQWuAyah+VpWAnBscWl9Dr7s2N8W7rJfvDQikiHqGCWzyICJRZ0ND5HEk+sJeE6RHOoCU9kyH0imZj2gBNPSPfYA5ReVxSonwi0kAC5cV7LCWEyw3C0bPxBRTaPWlc4UZKtbKXPtUpQiE+VpB3vAg4GGxuuCek4EZyx/qdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BLAPR19MB4531.namprd19.prod.outlook.com (2603:10b6:208:29c::19)
 by SJ0PR19MB4762.namprd19.prod.outlook.com (2603:10b6:a03:2c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:30:47 +0000
Received: from BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::ca98:8623:903e:b297]) by BLAPR19MB4531.namprd19.prod.outlook.com
 ([fe80::ca98:8623:903e:b297%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:30:47 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Daniel
 Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Thread-Topic: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Thread-Index: AQHZvhAkmXpdiy+gsk+OG5qt50hsbK/jiU0AgAAXWGCAAACjcA==
Date: Thu, 10 Aug 2023 13:30:46 +0000
Message-ID: <BLAPR19MB45314E963527FAF53BC5D5ACF213A@BLAPR19MB4531.namprd19.prod.outlook.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
 <BLAPR19MB4531C7650AB7205E9AE19184F213A@BLAPR19MB4531.namprd19.prod.outlook.com>
In-Reply-To: <BLAPR19MB4531C7650AB7205E9AE19184F213A@BLAPR19MB4531.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-08-10T13:29:47Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=236e70b1-6c8a-462a-a550-f9561fea44a7;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR19MB4531:EE_|SJ0PR19MB4762:EE_
x-ms-office365-filtering-correlation-id: 5364a3bb-b5ff-4bf2-b8d7-08db99a60164
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KZswA5tIX02oYTR6kfdleQuXIuU7fe1tWEvNKRdbyFuwjvHBqIO0YF9sNqvluzOobrTb373/+eiebmefd0HI0zhsYl+sJIrDAElbsfgsaF6qXC9lv7igVZCHrk3IfMm2ZJYXkqH72gS/F7Wy+4NDE8V4/L2HFwP0M0+Vw2HLg39ZRtbAfkGzoscOrTr7EiZiM4zC+oViJC0O+58VeK3j1gbXpK8v+fcRQvU9rTRDDr95Few8Ahz3lSm6KGJKiEi3RLZzQJLy7HJNCdVVvbz/s2AgN6na39TAlLAudM4XW9t8stVwJNj36udDZPT2I13QRl7zEA5swBCpKcETueafgPVBXB5Fxtomm9m/TwZlOTMaVSJEyEgVhLcU+tG+w4h9dIeqsggSkvoF1zCs5CSO4GV3CBVWevCUWDLBi7qsOtHY0jTzs1Eu9PXfOXZ7d/skH7lU7VMh+DeEWYf9WeAilwphFBqC8wbhg5DWRYpfm2m1WD6M4surz6WdynBe3ePXRZZa0Pz2f+GZbVFzlMn5tQb+AqDrFE5TIAYXur7F1ThncV/trdCfAM3s2YQQBeOqJ7t3yzGzmknX+eKi5BzllAl43iBLw2Baz2nLMHZsCJx+b99kJG6ZLZNz+RPmN+/N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR19MB4531.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(1800799006)(186006)(7696005)(71200400001)(9686003)(110136005)(54906003)(478600001)(2940100002)(26005)(6506007)(2906002)(76116006)(4326008)(316002)(786003)(66446008)(66946007)(66556008)(64756008)(66476007)(8676002)(8936002)(52536014)(5660300002)(41300700001)(38070700005)(38100700002)(33656002)(86362001)(558084003)(55016003)(122000001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGVXSURCTW9CblowK1hvcXdXbkkvSEJBeGdJdlpPaExtZURETE9Nemd4ZFVy?=
 =?utf-8?B?c1V0UzRTeEJjVXVzdUc2NVBaaDJjWmxrZ1BOVVljT2NHTmVqNGM4Mk4xUzZT?=
 =?utf-8?B?TUJxbXpqdlJrR3Q4S0x5ak1WbjB6SWlHUzdldEdPeFN1d09SNk5XZGhkZXdL?=
 =?utf-8?B?RHJaeG5kbVBwZFliaGxXdkl6LytQZUFPbHlmSlNiemNIdlcyUnNWaXU0S3Ey?=
 =?utf-8?B?cUlyb0hhbTVYbTdEU0kvNEhkY1MwNnFOYmdMdEkrQWxna25zd1Fvb3BuMXJ6?=
 =?utf-8?B?aHBKVm1LYXZJMW51SCtJVHJtc2ZwTUVOcWp4WVJsVm1meFlyM3diOHpVSTZx?=
 =?utf-8?B?WEh4bjAwN2s1UUx0bmROSXhOVGk0RGNFSU5MbFJGbjJ2SlVTZkgvbkpMMU5H?=
 =?utf-8?B?N0lIU3EvUXJPQkYyUFRwUUVsZGRhTXF4QzcwUnd6VTFlMzNQeDdlVDRaZUd6?=
 =?utf-8?B?aXZvbU4yYjlPaTJWbEVuc1JYaElaYThmcVU4RXU5ZEdPWGxlSjU1dTFZOFhB?=
 =?utf-8?B?MW9pcCs0b2R6VnByWFpkNHpRUm1RUCtZN3o0K2dPK1d5bStNQjhlSDFQVEZq?=
 =?utf-8?B?WWhJbTFXbXFzcUlORlcyKzNseEZnS2w2b1psTG1HODNIT0dYUG5kblI3NENN?=
 =?utf-8?B?d3pGTXpEZ0NQR3JmTU10Rjd2VFA0cklCOGtvLzU5ejVFRnRuTjRiODlWaldq?=
 =?utf-8?B?YW9KbytDRThETlk5VWlya3B1RlBvVUVJaEw3aWRRS2U0Wmg1YmNhZk9UZkI0?=
 =?utf-8?B?elRWV3NFcktCaEZWMjlwWW1QaXAzanRFd2N4TXY4ZEMzQk5HT3JwWkNBdXF4?=
 =?utf-8?B?aDBWY002SGpRZC9Yc2VTNE1WcWx4d05TbXRHR2JmeEJKbDNaTG0ra2U1S1R6?=
 =?utf-8?B?dnRjSmpaa2ZBVTlEWFNIeXRKVHBuSE5zZ09mMlF0VFBmMnozNUR4YUdzK0pC?=
 =?utf-8?B?Mno4SDRHMDZuYXFyMi9VdVI4bHRSNEN3dGRDcUl2V1hOZnpDUUh3UlN5aS9U?=
 =?utf-8?B?dkNhMzJtdGJXV1craVNQd2VNdVZVc1dmTmRCOFM0VldwWUtjdWpmMnloNGVr?=
 =?utf-8?B?clp4eGg5VTEwWDJxcFVzdXBKR1BubXZvdE5lcG01OGIwSE1SeFZIeTJ2bFJq?=
 =?utf-8?B?NFZ2QUlsNU4vOHoyOCs2Z3c2WWNNQzVQWGNValZKTzdnOWl6NE5JL2xCTFRr?=
 =?utf-8?B?Ym5lKzU3ZXV6M2dQUGl2RUwrRnJmaEFsa01XRmd2cVA3M0VHdEdFYmF0M1ZE?=
 =?utf-8?B?V2IyK3lWWkNqMTBjT1lwUGtYNzNZaVl3alpEUjJPRDdwM29lVlFrVjhseEN3?=
 =?utf-8?B?ZmJtMEZweTBkaHFCTmhnNy9OQ0VXNG1uRmpkb3lzRlpPelZFcVB6ZTFZZUdm?=
 =?utf-8?B?YVk5M0F2MzViRjQ5aUExam5iUVd4ZGVTTlFWbFByZWpRV0xrT0NvQUVENktB?=
 =?utf-8?B?QnQwTXV3Z1ppTUpEbVZUamlJL2M5S01CSFpvSTFMamYzYllpbm1FNHpGSkxI?=
 =?utf-8?B?a1BJZUN6ZGpEQVc0M1hnLzdhOExjejZRL05Wd0xtT2FZK1hCaCs2VjVUTVN3?=
 =?utf-8?B?eWVFQmU4RFI0V3JTc0tUUS9QNlc5QlU1SVBKV282ekMyUy93UDVidWl1Skxw?=
 =?utf-8?B?cFN6eGdONkh0dXU4ZnFDQUdIVkNBMU42SEw3YnM3d2ZRaVNINThGcERxWC9B?=
 =?utf-8?B?MXVodytkTHUxZjhBRE5XM3ovMGl3YS9acXRIWkxSMkppekZ4aVFLd0hqYnl6?=
 =?utf-8?B?ZTQySnM4N0RCdFRoYS8zRm5vOUZoTnNjbE5hUmVnNWx0azdYRWdYSVVuN2xJ?=
 =?utf-8?B?dGZzaUlmM0xLQk1TRHNWQU1ZYU5PSGkrVUk3L1ZpRk5tKzJTTnhSYXptUjY1?=
 =?utf-8?B?UGRka2piUmNKNVpnMjVucFRDZmljMllIRVRGcHlpdmlQUWpiQlNnUXhtSkd4?=
 =?utf-8?B?L1BUejRpeFdUUmdEMXZJeUF4UVd3Y2FYZEFMRHhvUUVNa0lEejhyMWRML08r?=
 =?utf-8?B?SmQvcVk0RE5TQ2daRGFNSU5hRGJ6SDJUalVSL3FiWFc0UjlJRFRIaTlkQVU1?=
 =?utf-8?B?S05MT3ViTVFaNzVEeit3c056QWtVSjh1Y0FNSUorSmh1c0FldjczWjJyMDRI?=
 =?utf-8?Q?p+jlh5uBVUjkIWxNece5qnLLV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4531.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5364a3bb-b5ff-4bf2-b8d7-08db99a60164
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 13:30:46.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaMOoDtrsfpBRWqlyKTtJQPS+YrToXax05NbLnKLFkeTSPTzp1X9YYNsiZ9TvjBZkDtgVtaw5/sPbiRYpuTTKqi7c832YX7w5UeweDiOgDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=233 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100115
X-Proofpoint-GUID: QzetC2YJm52Z1oo84qQQ4VK8i5arbBy4
X-Proofpoint-ORIG-GUID: QzetC2YJm52Z1oo84qQQ4VK8i5arbBy4
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=277 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063055_424057_D5CB17E5 
X-CRM114-Status: GOOD (  16.68  )
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

PiA+IFNvIEkgZ2V0IHRoYXQgdGhlcmUgaXMgemVybyBhcHBldGl0ZSB0byBzdXBwb3J0IHRoaXM/
DQo+IA0KPiBJIGRvIGhhdmUgYXBwZXRpdGUgZm9yIHRoaXMuIFl1bSENCj4gDQo+IE1hcnRpbg0K
PiANCj4gDQo+IEludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0KDQpPb3BzISBTb3JyeSBhYm91
dCB0aGUgYXV0b21hdGljICJJbnRlcm5hbCBVc2UiIGxhYmVsLg0K

