Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F650C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uinv1puPcQc9VhQPiifvjKwjD8akKsoSUMUTyvsqpC8=; b=I8FtS0cwTefw5YdxxTqERLDyWf
	X0cLJM5EWqnjgaUsFOsdvbkaAxu4nML4OdllYz7QwClpGXqrvv4v+9AbZWftiswdob7kuM615HEHw
	3dkJfa1qL3A6ZifE9UBE8hdcppYRXvdYpUYQsF+Ct0i1lur2PU9+Vo3sofgLwcGyUp1r4tJKRhBuc
	Q0Z3KoPzm5tITlg0/thP0uQ2Ox+UYXipLy8lxdg42savoF0b5CuyjwboKJXIeEFUEump0S1TVYAH7
	zoF6r94wLJCkURNYqrT1di+b+t+w4OBZD5tnB5D52Kv1aPacJzucCs7E0K2GSdIL99jlW6ORWacJ5
	nHBn2zPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDVTu-003GHz-Au; Fri, 28 Jan 2022 17:56:18 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDVTi-003GFg-EA
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 17:56:10 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SBQbAq026119;
 Fri, 28 Jan 2022 12:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uinv1puPcQc9VhQPiifvjKwjD8akKsoSUMUTyvsqpC8=;
 b=KZTFBRq2cqNr24OMTpMJu/qIOld/NcAAXMafVEXUfIFUwaUBl8ZU+y4Gyg3aD9W7iq9K
 29OB0/AR4FYd9LQpwXbsks0rHPDDRps4x2L1427ebyEoy6SmcBtRaVo9ZaAb5r8kcu8P
 2Fk9yTP9pvUK8CB6kud1WfcLrEIquXvHx0VLZBa7fgnnAHnoWaWnJB4YCAcvtGJ8Hu9B
 G/UfHqQUIRYB+ddr6xXkL4U0dwK0v30oV2pI6sKZpBQqDBG/j5SzejJ6XAXoJK0A9Ttd
 VboSLAG8T4QKLBG7+yYLgNFR4BcwWY26BLDqYig+oeTudJWX+QPn820ac+SScSejY70L YQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3dv8b2k8m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jan 2022 12:55:45 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20SHU5t6105242; Fri, 28 Jan 2022 12:55:45 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by mx0a-00154901.pphosted.com with ESMTP id 3dvdqbf55g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jan 2022 12:55:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O25g6HDJN/3eJxqXq2gr5aYxQt90XhhLVrIGGKXKGglR7GvBTYJPKP/rh0D+MNyKDHD5U+Ci7idaTeNMegmxvjHhGiH58URshXEtUhfYKLePYI1YLvIsDMF8fTHG1wF/0s6zg6O2nozYtbzzT8JV8uw0cWgbXUe+zMeqzkx9EJLglkzfbstF8jjyRiS0ebzCowmLNZnWIfDzAkVUnS7z9H1Gzorn1RE6Oyzczhhi3iGC3l5kwnfeo9AEn7gWSuzbJyc1isDSA3anstxrxihsSP96HU1ftIUdRlA7JZy9kE9PrpzumDFl7QtfNQXDQ4zrOgEBIer4ea26nsPyWZ6x8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uinv1puPcQc9VhQPiifvjKwjD8akKsoSUMUTyvsqpC8=;
 b=WqOUQjVD2UwmAHYP5N4WtZAZDsEJBMng+YXW/n+MncVn3dhGqWFQeebKP4CESLJw5w18g1Lp4E5wMU2Z4Nx8WHNS0UjrA+CVi7CNiXQFVDHhJVPSEWrHX1pdCRK2sXVA+IH2zIZn5EaMNeHDk8/YnYuNoUYFZVopPlzrRKAzA2m2Fayd4V4IBDiqZt9H0O7Fm/UYuiM8vLB+clxuSf/7SPQ9XmbctRX6Vpa7ocuAeOwLmMOxO5FGqjiheAWakzmgoa9rLaDXp3AuqIk7GYAMqqK9SdH6SdAcvfh1pStsDR/4/SC8qg4qKy2d0Poq0OOLEiTSSbjCAyOykaecRjY8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SA0PR19MB4569.namprd19.prod.outlook.com (2603:10b6:806:bd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:55:43 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::f01b:bbd8:4187:36b3]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::f01b:bbd8:4187:36b3%6]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 17:55:41 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Topic: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Index: AQHYEfxP/F7s1ilTfEGG+nDhesZTRKx2nSQAgAA92YCAAALhIIAAkHMAgAFJADA=
Date: Fri, 28 Jan 2022 17:55:40 +0000
Message-ID: <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
In-Reply-To: <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-28T17:55:38Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=70fe2bc8-093b-41d4-8179-f4ef24f64b7a;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cf55a7c-8861-41a4-f6a2-08d9e2876614
x-ms-traffictypediagnostic: SA0PR19MB4569:EE_
x-microsoft-antispam-prvs: <SA0PR19MB4569630F06599464EA1BA404F2229@SA0PR19MB4569.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MfTiAB//P+TUkN8lmVkwH/nkqQwoA5NhYwEUhZ+Q7R9+U5RjPawCiLps1j2oewnWvp1DblS0h20sS5n+F2MPvErbIlf4uXido9J1qCpgVIr3cb1LR/KitVaJxeKxXg4AouAIcysNtwwT9uiOu9su6UhJJaUa7Qy0+wfH4rIimDT8SBBVvsxFH+9SkT1LaGdKbi89/h6XzkjfrP781ThkhL2dsfPd0QOhlqIQ1OWacxSB/BqjYof3GhE8OpFV0+Rst8NCBrO86eQrCaBPbkoyXEMhQF7RXw2dlnjqTBYNqVupbIEi+TZf1rTYi1AWA4T2BAO9rOProeu6/89Tu4aCZOIi9yvtCYlgqHTM1VhzOTH1u0mSxlNHLJnbwgJSTSxnp54RR6RrgpLdELaGdEO4Otd7iFmYuuoTl0Ok/1Sd0VJklyKsiDyR3Gbz4YHezg2wBpM83Wkd+JcaglBerPQ3WOt/BuhPCifLabqmDZmiQnX8ZFOOikrrpA4TTSWTv1PwMIVBzD+aAfTlVNrN1enzb/x/dr5LkHeInBVFB6Y/ETIt/Z4+zlcyMziDQVNGLhGt5GUXSrc6fD57k+u47YjsDRwYlO30/zD4hWO+iKuCH8/Et048MpFkC9fUHJt67CSv87/7W7y90YRt1B/sIL0DCbjQw0LOS36ufcQArQxXBEEDVBjziMGj5/mKWE1awCwMkFCVMCot9CWQkcj/un/liQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(6506007)(7696005)(110136005)(71200400001)(38100700002)(26005)(38070700005)(122000001)(82960400001)(55016003)(66556008)(186003)(86362001)(5660300002)(4326008)(64756008)(66446008)(508600001)(66946007)(52536014)(2906002)(83380400001)(316002)(54906003)(76116006)(8676002)(66476007)(8936002)(33656002)(786003)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWozT0ltNHhTQU5YRkxzVmcxbW9leXZmeE9HeFRZa2ZlNEI3dGRrRHlRekNE?=
 =?utf-8?B?ZGRHODRDUERJM2hiQmUrb2crVnF2U0k2TnBOMFg4NjFFbWI3cXhISGdnenVI?=
 =?utf-8?B?OHgrc2xFM21GcS9OTDZ4emdraVpaRHU3UnUwb09ZQ1JlaENhMndvcWlTbTB6?=
 =?utf-8?B?Yml4amVMdnZ1Qk9TM3JsK2lsQUlzODRoZ3dWc1k1b1Z4QWF4NCt1Z29IQWd3?=
 =?utf-8?B?NmYrQVJGMDZYbGdOOEMzdkNmUkp2anF3WmE2UithMkhZQlZXMjlxQ1JkSHpY?=
 =?utf-8?B?eEx3Z1VkWk02RGNrOVVPMTFDQWs1NEtyMzNuVXJudlg2VGpXMVc5WXA5bWwz?=
 =?utf-8?B?TWwvQWlxOWwrSUJ2UWxEcHU3UGswWElsTG9OR2VKUkR4bmZ3T2c1aE9rZWEy?=
 =?utf-8?B?dWxIeWtzNEhGWDUyWnRqamJCYTZrdS9oQkNsTllBdUJ1dzNob3RxbkpweTI4?=
 =?utf-8?B?MHJKSlZ2WFAyOGIrYXZoNFNSM0huQjFmckJ1V3NEZWl3d0R2MC9pOVVySTZw?=
 =?utf-8?B?em5DeXkybURMdlhOUEVmQ0dEVWdzV3I0cHY5VzEwMEg2dE5BMUM2eTJrOFlN?=
 =?utf-8?B?WUZNeEZDZFhZM3FZZmdETXBqSTBzUVY5OG40VHR4UEhCdXJxc1YvRllwZzZH?=
 =?utf-8?B?QjBsUmo1K3hzQkVzQy9aMnYvcWE2dlZHUlRPMnBwVTdGMUl5T0d6RmpRUmRF?=
 =?utf-8?B?eVNlRTZWSS9uVW5OUjM2Y3JmM2tyTm5RNFk1ZFJMeDkzS3E4bkw5dGNMWlF0?=
 =?utf-8?B?T2U0WnVFa1I5MU41ZHUzc0crYjg0SWNUUjZ5alVSSUtxZUl0eEk0enJmYWow?=
 =?utf-8?B?cTZ5VmlJeG1UU1QrREtadVFKMlpzZkwwVkw1b2M0RTZzOTNJUEdVbmRBTlRU?=
 =?utf-8?B?eWZDQUhoK1lKaXJYL3k2dGEwVjIrSkk3SEVabThvbDRteXpCMFlaWmlFUHla?=
 =?utf-8?B?Snh2ZlB6d1ZXUXd5MFZBUVlueGdJNEZ3Rm5oTVhScTVEaXFvNnJYeldDYzhC?=
 =?utf-8?B?MGFDTDYxRnE1WWd2d0lsMDFLU3JIbi9QRzA0ZEtvSHhyT25zWE9PU2t3MXlQ?=
 =?utf-8?B?Nlorbnl3NmhyVjQ0aEUrWWFKY1orSnY0SmxoVHRhQm1ZWFFUeGdDb2RXd1dx?=
 =?utf-8?B?blB2UTZHNlJUVTRtb21vbitlRXZ6UWp2bFUrS3JXaDgwZUhOcnZ2V2hpVnMw?=
 =?utf-8?B?cHhkNnRNUy9mb3Q2R2oyNHdvVW5mWjF1ckRocFpzNCtTc0lwL3VpTFdkdk1q?=
 =?utf-8?B?WStQOFNURDBhWGgydndKUGNydzBOejRtTzFMOXFGWUx4V3doZnVNOEViK1ZN?=
 =?utf-8?B?TVJHMnA3aWI2Ym1IZFF1clVuek85Z1NOQW45V2lldC93OHJodDJKbzJXVWdt?=
 =?utf-8?B?VjlJaGxTNVhiVmlkZTVlOVVGWEZrQmdZUEtld25CUEFlb202RkF6UElQVzhy?=
 =?utf-8?B?ejhrdUJuaWN2ZlBmMndpbk9QRWZzVU44MTJYb0l4UHBmOXkvVVkrWnZnWm04?=
 =?utf-8?B?eGFBVnpOUnR2RGtTTjEwanJmdGV6WjZKRmFlNnZmVVZOSTlKOUFqRGp4dW1s?=
 =?utf-8?B?eFV5Mjhwemc0alRseUk2U3VJYW1MbWZiSTRzcGxCQjd6VU5Rd201OXJnOTRm?=
 =?utf-8?B?M2crWTFLOFZpVmpDVFkxbzE0NFQzd1dPY2RpVXRHcWhIZG03Q252MXJkZmVi?=
 =?utf-8?B?YkhBVFYzSmF5OGg4YmYvRHBXclQ4WC9zUW03Slh4cFJuc2VhekluL21QSndG?=
 =?utf-8?B?dThUVDVFWDQ1K214cjllOFVkQlRKRS9FVXhIRjBUb1Ara1NQc0VmbS94Ri90?=
 =?utf-8?B?clRaQkZrQllMd3lQRDcxUDB1aWZ3dEVmN1RFbkxVeWVEL1JaK1YrM1Y5c1Z1?=
 =?utf-8?B?TmNNMGdYTWF2TXorZmtuSnFRckdlbHpaMlNRQXd1TmdsQWlheGVsVWtKaEdY?=
 =?utf-8?B?eHJQcmhHYThyQ3VTVjZSUWNIRUg3dEpxQWNWcUowYmt3SXpMZjNNSHlCKy93?=
 =?utf-8?B?Q0NCVXhNc0dLODBRRUZIakthZXJNMGJoTi9JZjFzYnk4dWUxcDFBTkZuRG5W?=
 =?utf-8?B?ZnhKZXdmTU11U3ArTUhJeXozcUd0dWJzTVZGb0MzRWRwYXFETThmQ29oY05N?=
 =?utf-8?B?MytsNzRnVTNmRkg5Y3F1S3lGVGpmaHMzV2gxeWxrRlc4SHRpakF0Z0hKcGlr?=
 =?utf-8?B?WVVLZ2xkRlpvT2tuYVBLblNMa2s4TEc0TmZCSVkrNTY5cUZuaHVvRjNDSUdS?=
 =?utf-8?B?dWM4MGM1K25UaHc2dmxuQXNiVE1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf55a7c-8861-41a4-f6a2-08d9e2876614
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 17:55:40.9966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQjcZxNj+vCHU/swk9aTeJjaDiwWXeeyJpam3EWma+pT4I38VBHL1aZPIdkgFSIILr57z5jE4t0jEnqO1HNBlphLZnfEnw6u8nMxxkAtlC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4569
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-28_05:2022-01-28,
 2022-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=487 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201280106
X-Proofpoint-ORIG-GUID: AIZyY0Vah1K_Pmk0q2Sb8a-7PGU_JFGu
X-Proofpoint-GUID: AIZyY0Vah1K_Pmk0q2Sb8a-7PGU_JFGu
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=578
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_095606_560626_F0FE86CF 
X-CRM114-Status: GOOD (  36.29  )
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

PiA+Pj4gV291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGRlbGVnYXRlIGV4cGxpY2l0IHJl
Z2lzdHJhdGlvbiB0bw0KPiA+Pj4gdXNlcnNwYWNlIChpZSBsaWJudm1lL252bWUtY2xpKSwgYW5k
IGxlYXZlIHRoZSBrZXJuZWwgb3V0IG9mIGl0Pw0KPiA+Pg0KPiA+PiBJdCB3b3VsZC4gVGhlcmUg
aXMgbm8gcmVhc29uIHdoYXQtc28tZXZlciB0byBwbGFjZSBhbGwgdGhpcyByZWdpc3Rlcg0KPiA+
PiBzdHVmZiBuZWVkcyB0byBsaXZlIGluIHRoZSBrZXJuZWwuIFdlIGhhdmUgYSB3YXkgdG8gcGFz
c3RocnUgY29tbWFuZHMNCj4gPj4gc28gaXQgY2FuIGFuZCBzaG91bGQgbW92ZSB0byB1c2Vyc3Bh
Y2UuDQo+ID4NCj4gPiBJIHdpc2ggaXQgY291bGQgYmUgZGVsZWdhdGVkIHRvIGEgdXNlci1zcGFj
ZSBhcHAsIGFuZCBpbiBmYWN0IHRoYXQgd2FzDQo+ID4gbXkgb3JpZ2luYWwgZGVzaWduLg0KPiA+
DQo+ID4gVW5mb3J0dW5hdGVseSwgd2hpbGUgdGVzdGluZyBJIHJlYWxpemVkIHRoYXQgdGhlIGtl
cm5lbCBjYW4NCj4gPiBhdXRvbm9tb3VzbHkgcmVjb25uZWN0IGFuZCB1c2VyLXNwYWNlIGFwcHMg
YXJlIGNvbXBsZXRlbHkgdW5hd2FyZSBvZiBpdC4NCj4gPg0KPiA+IEZvciBleGFtcGxlLCBsZXQn
cyBzYXkgdGhlIG5ldHdvcmsgZ29lcyBkb3duIG1vbWVudGFyaWx5LiBUaGUga2VybmVsDQo+ID4g
dGhlbiB0cmllcyB0byByZWNvbm5lY3QuIE9uY2UgaXQgc3VjY2Vzc2Z1bGx5IHJlY29ubmVjdHMg
aXQgZG9lc24ndA0KPiA+IHRlbGwgYW55b25lIGFib3V0IGl0Lg0KPiANCj4gVGhlbiBhZGQgYSB1
ZXZlbnQgb24gdGhlIGNvbnRyb2xsZXIgZGV2aWNlLW5vZGUuIEZyb20gdGhlcmUgeW91IHNob3Vs
ZA0KPiB0cmFwIGl0IGFuZCBkbyB3aGF0IHlvdSBuZWVkIChleGFjdGx5IGxpa2UgaG93IGRpc2Nv
dmVyeSBsb2cgY2hhbmdlIGV2ZW50cw0KPiBhcmUgaGFuZGxlZCkuDQo+IA0KPiBCVFcsIEkgYWxz
byBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGUgaG9zdCBuZWVkcyB0aGlzIHJlcmVnaXN0cmF0aW9u
IG9uDQo+IHJlY29ubmVjdCwgYnV0IHRoYXQgaXMgYmVzaWRlcyB0aGUgcG9pbnQuDQoNClRoZSBm
YWN0IGlzIHRoYXQgd2hlbiBjb25uZWN0aXZpdHkgaXMgbG9zdCBhbmQgcmVzdG9yZWQsIHdlIGRv
buKAmXQgDQprbm93IHdoZXRoZXIgY2hhbmdlcyBoYXZlIG9jY3VycmVkIG9uIHRoZSBob3N0IChl
LmcuIG1heWJlIHRoZSANCnN5bWJvbGljIG5hbWUgd2FzIGNoYW5nZWQgd2hpbGUgY29ubmVjdGl2
aXR5IHdhcyBsb3N0LCBldGMuKQ0KYW5kIHRodXMgcmVnaXN0cmF0aW9uIG11c3QgYmUgcmVhcHBs
aWVkIGV2ZXJ5IHRpbWUgdGhlIGhvc3QgcmVjb25uZWN0cw0KdG8gbWFrZSBzdXJlIHRoZXJlIGlz
IG5vIHN0YWxlIGluZm9ybWF0aW9uIGF0IHRoZSBkaXNjb3ZlcnkgY29udHJvbGxlci4NCg0KPiAN
Cj4gPiBCdXQgbGV0J3Mgc2F5IHRoZSBrZXJuZWwgZG9lcyBzZW5kIGEgc2lnbmFsIHRvIHVzZXIt
c3BhY2Ugb24gYSByZWNvbm5lY3QuDQo+ID4gV2hhdCBpZiB0aGVyZSBpcyBubyB1c2VyLXNwYWNl
IGFwcCB0byByZWNlaXZlIHRoaXMgc2lnbmFsPyBJJ20NCj4gPiB0aGlua2luZyBvZiB0aGUgY2Fz
ZSB3aGVyZSBvbmUgdXNlcyBudm1lLWNsaSB0byBzZXQgdXAgcGVyc2lzdGVudA0KPiA+IGNvbm5l
Y3Rpb25zIHRvIGRpc2NvdmVyeSBjb250cm9sbGVycy4gIEluIHRoYXQgY2FzZSB0aGVyZSBpcyBu
byBhcHAgdG8NCj4gPiBzZW5kIHRoZSBleHBsaWNpdCByZWdpc3RyYXRpb24gb24gYSByZS1jb25u
ZWN0Lg0KPiANCj4gVGhpcyBhcmd1bWVudCBkb2VzIG5vdCBqdXN0aWZ5IGFkZGluZyBmdW5jdGlv
bmFsaXR5IGluIHRoZSBrZXJuZWwgdGhhdCBkb2Vzbid0DQo+IGJlbG9uZyB0aGVyZS4gSWYgd2Ug
d2VyZSB0byBmb2xsb3cgdGhpcyBhcmd1bWVudCB3ZSB3b3VsZCBiZSBwbGFjaW5nDQo+IGV2ZXJ5
dGhpbmcgaW4gdGhlIGtlcm5lbC4gSWYgc29tZW9uZSB3YW50cyB0aGlzIGZ1bmN0aW9uYWxpdHks
IGhlL3NoZSBuZWVkcw0KPiB0byB1c2UgdGhlIHRvb2xzIHJlcXVpcmVkIGZvciBpdCB0byB3b3Jr
Lg0KDQpPaywgSGFubmVzLCBTYWdpLCBDaHJpc3RvcGgsIGV0IGFsLiBJIGdvdCB0aGUgbWVzc2Fn
ZSBsb3VkIGFuZCBjbGVhci4gDQpFeHBsaWNpdCBSZWdpc3RyYXRpb24gZG9lcyBub3QgYmVsb25n
IGluIHRoZSBrZXJuZWwuIEFuZCwgYXMgeW91IHN1Z2dlc3RlZCwNCnRoZSBrZXJuZWwgbmVlZHMg
dG8gc2VuZCBhIHVldmVudCB3aGVuIGl0IGxvc2VzIGNvbm5lY3Rpdml0eSBhbmQgDQphbm90aGVy
IHVldmVudCB3aGVuIGNvbm5lY3Rpdml0eSBpcyByZXN0b3JlZC4gVGhpcyB3aWxsIGFsbG93IHVz
ZXJzcGFjZSANCmFwcGxpY2F0aW9ucyBrbm93IHdoZW4gdG8gcmVhcHBseSByZWdpc3RyYXRpb24g
KGlmIG5lZWRlZCkuDQoNCkknbSBub3QgYSB1ZXZlbnQgZXhwZXJ0IChhdCBsZWFzdCBob3cgdG8g
c2VuZCB1ZXZlbnRzIGZyb20gdGhlIGtlcm5lbCkuIA0KRnJvbSB3aGF0IEkgcmVhZCwgdGhlcmUn
cyBvbmx5IGEgbGltaXRlZCBzZXQgb2YgdWV2ZW50cyBkZWZpbmVkIChpLmUuIGFkZCwgDQpyZW1v
dmUsIG1vdmUsIG9ubGluZSwgb2ZmbGluZSkuIFRoZSBudm1lIGRyaXZlciBhbHJlYWR5IHVzZXMg
dGhlICANCnVldmVudHMgImFkZCIgIGFuZCAicmVtb3ZlIiB3aGVuIG52bWUgZGV2aWNlcyBhcmUg
ImNyZWF0ZWQiIGFuZCANCiJkZWxldGVkIiByZXNwZWN0aXZlbHkgLiBXZSBhbHNvIGhhdmUgIHRo
ZSAiY2hhbmdlIiBldmVudCB0aGF0IGlzIHVzZWQgDQp3aGVuIHRoZXJlJ3MgYSBjaGFuZ2UgaW4g
dGhlIExvZyBQYWdlcy4gTWF5IEkgc3VnZ2VzdCB0aGF0IHdlIHVzZSB0aGUgDQoib2ZmbGluZSIg
YW5kICJvbmxpbmUiIGV2ZW50cyB3aGVuIGNvbm5lY3Rpdml0eSBpcyAibG9zdCIgYW5kICJyZXN0
b3JlZCIgDQpyZXNwZWN0aXZlbHk/IFBsZWFzZSBsZXQgbWUga25vdy4NCg0KVGhhbmtzLA0KTWFy
dGluDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0K

