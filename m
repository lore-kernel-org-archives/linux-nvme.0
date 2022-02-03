Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1s+MPfRZJkcw6g2C60U7V27W2tY1UxRE5QjvKD2OOAs=; b=mIaUcB2tnYKor8770l0b3UKG01
	3IsD1tBQv1EsxZO2EV6/u5axJ1Io9Yi9KD/4HHQIyikMDReOXFfsPfAUEYrHSESwdr/rua6Iaw94e
	6nRK8EqlXh5zbrhU3IvY4zedpClQvIBCh8kKrwquDd31GRlRJ5U5mUWeHAS8lyyJExR0XF3a1Q4h0
	E4+q3UR10dvJ0uZiNRcsDWIVWdAJ7eGvJyBnyzyAazEGJt11Pc9MqVQdza3IwQYZUyb7KN/1A3A4U
	rVqC9U9ZPXY89SsUd9284GEvwEwr6dgxcHXgzsB6hJBxdfgBwtqRdlLYuOxqdYruCzCrVgB1wD/Jb
	Lpv5LIZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFbqs-001Mh6-CH; Thu, 03 Feb 2022 13:08:42 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFbqe-001Mcq-3Z
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 13:08:30 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2138cWmF015593;
 Thu, 3 Feb 2022 08:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=1s+MPfRZJkcw6g2C60U7V27W2tY1UxRE5QjvKD2OOAs=;
 b=poZ2gco2i9iXnd13xV2TwRYDo/g8KYRgncEvnzT/5uU1hWTZ18e3RiqwE3I86Z+GFLLf
 oCixVzvjttd05hzrCwAAM/9E4mWm44S/XKMP5PGnneCS8gvvUNHA+c4bODqAQkymssWE
 P0WCGD1KhUYKMrR8ydNER/zovJVz4HDyR2Im6ae2N3wx9erm9N+afsXF0dCCvo/rr4rB
 hvH0FUZYyQ9N0uxPO9upQnwjcz0+ZxCNsNHs/1u5loUlyHZSkmcwtM31vY1zywOuASMp
 8TcH75F87/VlugDrZpIXRXUAfLawPTcrljTdKw/5MLjdLSuUx4lqRxRfYHzceS6xW7w7 Fg== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3e01y5ajdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Feb 2022 08:08:08 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 213D5YAm180958; Thu, 3 Feb 2022 08:08:06 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by mx0b-00154901.pphosted.com with ESMTP id 3e0ch0ac08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Feb 2022 08:08:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxEzWGlcGhLS10pWY7+BeZOf0Vl7Q8CJI90mQYa3vN1ml9hPozfMorTzlQl3Rek9E/WRhsbvMOKU/z4qleR/9Jt35HNks052Sek/D49Mp9vkfB5ZCnf8lduoSbULhHWztO77HQCxVp9WJgs/IgmZvQFPndVBlpcz3RZPXGxTP4wYKxAZnT8ED+m2JKa1CDjWWkL17frPOGZ6HSjAs1Cl0BWL5F06cgHBSEtGlj+WxuHnHUTGbDev2MWvEuCFNSlWs/HclmtJGV+om5eIxO6u10J2PNoN8UMYct2wLX3mx3bMHy+KNhuTJYzVJMRefUJ3ODwhi2Q55SImEC6udZNznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s+MPfRZJkcw6g2C60U7V27W2tY1UxRE5QjvKD2OOAs=;
 b=exV8GRn9L2brDXiA+YYDIoygn53k8/AOsunuqg2OQEjp9HT4D5S41qjr/HIYZtm3GKKRFxQmdXalnuUOuI5pJ5n9K+tHCNg8YZAQqr8Vy7r8bJQYqoCsShPtA8FQ/3GYTAflGa4H/Nf539LcTN6hxDAC5YcxLsLJo11VmQxIWK7FRtqdDPrew/2EdmHFaOVmnWCaxBzo2gL4SNU1qkuHPvYG77VzfdYQXOYwi20rfA6bFh/1NREbh5tWfYqlObW/IfafpYxhBQt2MPMRtpTfsSibQZszAh9Bk/2uLNcob3cyZsfT+pjedhu/HP7ojmy9O9tXmBQ76d0iJO1n0cRCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MN2PR19MB4045.namprd19.prod.outlook.com (2603:10b6:208:1e4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 13:08:04 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 13:08:04 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "Hayes,
 Stuart" <Stuart.Hayes@dell.com>, "Rose, Charles" <Charles.Rose@dell.com>
Subject: RE: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Topic: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Index: AQHYGHzVH84DVIVYUE+St1ikwYiM3ayBa48AgABM5JCAAAtkAIAACSOw
Date: Thu, 3 Feb 2022 13:08:03 +0000
Message-ID: <SJ0PR19MB4544B435D22B0F19E2B7CEBAF2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
 <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
In-Reply-To: <68451fbe-ff4c-a89c-36d7-1b5829fab825@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-02-03T13:08:02Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=df8fbea4-ee9d-4f32-8056-70f41b3043c6;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c93810d-e587-4940-f1b9-08d9e7163695
x-ms-traffictypediagnostic: MN2PR19MB4045:EE_
x-microsoft-antispam-prvs: <MN2PR19MB40456F4277DEAEDC239858CBF2289@MN2PR19MB4045.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8I7t9JjJf/O6bOr/iSa/k2nTmxTafX19t0DtAAhP7898hgEfm3V90aa+/4cGEgipEkSGDPzkOK8I+H41MO0Ci5l4yj81Xw88Y2ALe0lk14PylIdSoyGI5YWOS+fiRWc7qORZhoBP9skrFTxYBvmNANfAgUFzj/LjsF4jEkgArJ9O13XHPCHpmntWB7rtEgynUZ1TKpprzVN5KmMbA4owBxk7HoSbCmHLbAsTGjK4ChsVgzxJ0f0XN00lW9lUm5+DoO1EcM0gHPUQ4geO5rURDcOePcJSgZc3MT52kObLE4t43vtk0KsbuQeW+SRDLwcJMjh/3E1jXYjdSL980X0lXaj8pmOq6ozydr4CQNzqkz/Jku+QMKAW6I25pJF6fgX0zoC7I0mnfAUmk1FglTqFomYlnHo1WtUORVT9hBm0BtR6yTJG6/Rlr40IkKyvpvZ13gUoIrwf4sz8E3d5QolGvx58FerNGplcr9xtdUM9uM80AJJn+91TEQNtk+SogpuL1g82gPeQJCHCBMiL3P+B47jl98XilKWXYzNdXvvO8Krt2lw/Ra091HGaGr2R1naqKLKuCp7DC+HEXrGoLYGLeLHeYAF6gpka7ty6fs3kyeCIhk7G6shnnuSAlr31GFh+N47m0AZ1BNYruRzlTByONVp+IzBwuLc2+VsGIT9UQx5XkiVIWZ2ID/maeedYqN1DeUzyJQX2J/W8vomHeLXIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(55016003)(66574015)(76116006)(6506007)(38100700002)(8676002)(82960400001)(83380400001)(33656002)(9686003)(53546011)(8936002)(71200400001)(66476007)(38070700005)(66946007)(64756008)(7696005)(66446008)(66556008)(52536014)(122000001)(186003)(5660300002)(54906003)(2906002)(86362001)(786003)(110136005)(316002)(508600001)(107886003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpXaU80QmxmWTYvemhYYVUrcHpneXV3Z2d6TU1vSUVXVytpRTNpbFZjVDlZ?=
 =?utf-8?B?b0x2U1ZVaU44aUhndkZsQUh5ZC9lU05FcXYxNDRMUlJ4YzRKVytiMTBaNzFj?=
 =?utf-8?B?ZjRNWkZsMUhkR0oyLzZoUHFMa2lSUDZWK25HSDBjQjBIa25kWHhmL1MyTFB4?=
 =?utf-8?B?ZmZyR05md1VMeDVQeTNhZjA5YXdCOHpDYlQra1RaMFFuaFhZclhhMGRkbTd0?=
 =?utf-8?B?cGJJNG9Sd2VvajF2MzRzbkJlbE45cGZ1Zk9wQmZ4QWlNM3UvWFpEcmttWm5R?=
 =?utf-8?B?SndDdGMvV21JWXZiNHdKbWozZEtKTDl5Q3NmUlduNmx1eGlJNGxDK1RUZGxO?=
 =?utf-8?B?ZENPTmJsRDJjVmw3aGF2Tk9YL2VBVVE4TTg3L3JlWUR3aUcxT3ZYN3FGRzdV?=
 =?utf-8?B?R3d3SU92TUdXRFpocy9rL2liKzltTDNkRzVMWjVQU3d5TUFRUjVKZ01TVGVL?=
 =?utf-8?B?YzZTYlNlVjhPOThFNkxRR3lFK1lUdEt1TXI3OTArcmx1UWJWYkxCU2U2cEhy?=
 =?utf-8?B?OFoyOGFGN1RvS2VHQUppYms5RVVNWmc1dkxlMS9CenVraDNaalpvOXJBRlJT?=
 =?utf-8?B?cnZQMVo1RWptWkhBNE5FNERuUTlKWXlldXN0ZU9oODBBMmxjQytVL1NBTC81?=
 =?utf-8?B?WkNBN0xBUTJVbmFHNFJnVVF2dUwrQ2lOOG14dnZkZmJYajR0RGxtdjhYaHZr?=
 =?utf-8?B?SDZtWnM3Zk9HallSaGRSUWRiQ1dDRU1rUVZMY0Q5ZTUwNDJ4T1p0ay9ZYm1m?=
 =?utf-8?B?a0VsRU5EV3p5dlZpUGswcFdKMDBxb0xkbG9WRWpMb2lXMlZrK1VtQk94cWhJ?=
 =?utf-8?B?MmxieWYrTGhzenVkRUxKcmN6OEUyTUNEdThOSGI5UFVTYmFIODNHa0pRSUZ5?=
 =?utf-8?B?ZVZXSkxyMGo3cGtEKzVtc2krOTFEaVB1cWgxRUljSkVlUXBaZFhHODlQeUtm?=
 =?utf-8?B?MWNLTlBoMm9obHhjSUFKcjlBbkVUd050a2l6MzVLYWVnaGFOUTNPdDRadGVa?=
 =?utf-8?B?aC9wM2JxNlNqWE1LUDcyYXYvZzJ1Slkrb1NEM1R2N25kZHB4Mm1EeHhGODQy?=
 =?utf-8?B?Z3Z0WjdBL3hIM2NqajFVdkNkWHErU0wvc1VRZVQvSDJ4NmpIVklPSEEydWtr?=
 =?utf-8?B?NENjMHU4VjJTaGQvRlU4TTlxdjZwUjlpd3lFcXpFY2F5SnJkYlhTeWlSUjBh?=
 =?utf-8?B?T0RUVmNaOUxhNmRCUjRoa3FRZTdnWFlYYlpicW5lTko0QlZWdHJwV0h0WUNB?=
 =?utf-8?B?OG5rQ2w1UFF4eWpPTFVORFF4eSsvalRORHNUUmZFTlR2T2hOVUpFdnZYZDhj?=
 =?utf-8?B?cGlrYnNxRDkrZkIyaE9aTnZKZkhhaEdIbUh4UEQyZHRKTkc0TlZSM2FtZDBp?=
 =?utf-8?B?d09ublpwSnpDVjcybEQ4RE1HWEFXMzdudVpsdGdYU04vempETTdQeU4vc0tz?=
 =?utf-8?B?dFo3TWg0Yjc0am1xaW94VDl6ZTRtUHVNZloyQnFmQ1lUTTNhSVN4NU1OL0tG?=
 =?utf-8?B?MTdpL1JwRTFZYldmSFFLWFJDM0htOFBJaGJnV0ZYMGtzWDdZaS9ZUmNTRzU1?=
 =?utf-8?B?SU9CVkZYTy96Si9qaHEwWkhpdXYrTHhXcXNZN0ZGclA1bTM2ejR1ZUcySnlD?=
 =?utf-8?B?aVdueGJQUlNQdGlWdWVKNUs4VlpLNVVENmVua2gxM1o4RUEzTGwvYVVZNlRP?=
 =?utf-8?B?UXdDMHQ4akp1V2hDOWUxYkhhV3BaOTNpVW10M1FNTm5pVGV6cnBnYTlzYTJU?=
 =?utf-8?B?SWt5TEx1YVMwZitTTmZHdUw3YTJIRVV3dmRHVjRURDRvczlxWk9wYUttUW1C?=
 =?utf-8?B?cCtxUWhYcVJFOE04Z1ROWWZCZ3pnVFlyR1ZFSU5oZHdCMUk1b2t1Mk9CTUZR?=
 =?utf-8?B?ZHJseWMxa2hTTHlyc0RQeTNWcnNWMTBBMEE3Qi94MlNZNHozcXhmc3c2Q3l1?=
 =?utf-8?B?N0hYUGR1L1pPN2JMK3dMbXg3UGlhK1d4M2RCSHJ6azJSUEU3VGt2YTVSZnFh?=
 =?utf-8?B?SkdiZjVzVTcvWmc5UEVibExlQjdmYmRPQ09GS1htV1VsUitIVFdjNmdlTXpF?=
 =?utf-8?B?ZUdRYzh5MDVEbm9KcTFwcGJwS0swT3YvK0YvSEdUUXJyLytaV1dZQk9HZ3kw?=
 =?utf-8?B?MXhmOGNmUlhiVzRKSjBvb0l0OEZKN3RWQjl2WkIzdEVJWEIwcmMzRlVpd3pv?=
 =?utf-8?B?eWNyL3MzUWNGV3hVTmYxNWx0eG9telpHanV2ejQ3T01ZdFhnK3k2bk53MFNa?=
 =?utf-8?B?V2Q1UmEwMzNQVjJtc2NPL3lnbEtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c93810d-e587-4940-f1b9-08d9e7163695
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 13:08:03.9323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HBaHtQUzwwbEpqbNFjKx4PcQQr5nh00rUsjA1xideX66xJHrAgXK88RQ9Y15qs2FOtdvEMcbj/7+wqNZ0/XDk09lMqsUyQ3ggg+2C3t4Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4045
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-03_03:2022-02-03,
 2022-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2202030082
X-Proofpoint-GUID: jVdVyk2uED4i6D2jHRpJDT-jBecOUaok
X-Proofpoint-ORIG-GUID: jVdVyk2uED4i6D2jHRpJDT-jBecOUaok
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_050828_337379_5335E906 
X-CRM114-Status: GOOD (  30.65  )
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

PiBPbiAyLzMvMjIgMTI6NTksIEJlbGFuZ2VyLCBNYXJ0aW4gd3JvdGU6DQo+ID4+IE9uIDIvMi8y
MiAyMjozNCwgTWFydGluIEJlbGFuZ2VyIHdyb3RlOg0KPiA+Pj4gRnJvbTogTWFydGluIEJlbGFu
Z2VyIDxtYXJ0aW4uYmVsYW5nZXJAZGVsbC5jb20+DQo+ID4+Pg0KPiA+Pj4gVFA4MDEwIGludHJv
ZHVjZXMgdGhlIERpc2NvdmVyeSBDb250cm9sbGVyIFR5cGUgKGRjdHlwZSkgYXR0cmlidXRlLg0K
PiA+Pj4gVGhlIGRjdHlwZSBpcyByZXR1cm5lZCBpbiB0aGUgcmVzcG9uc2UgdG8gdGhlIElkZW50
aWZ5IGNvbW1hbmQuIFRoaXMNCj4gPj4+IHBhdGNoIGV4cG9zZXMgdGhlIGRjdHlwZSB0aHJvdWdo
IHRoZSBzeXNmcy4gU2luY2UgdGhlIGRjdHlwZSBkZXBlbmRzDQo+ID4+PiBvbiB0aGUgQ29udHJv
bGxlciBUeXBlIChjbnRybHR5cGUpLCBhbm90aGVyIGF0dHJpYnV0ZSBvZiB0aGUNCj4gPj4+IElk
ZW50aWZ5IHJlc3BvbnNlLCB0aGUgcGF0Y2ggYWxzbyBleHBvc2VzIHRoZSBjbnRybHR5cGUgYXMg
d2VsbC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmVsYW5nZXIgPG1hcnRp
bi5iZWxhbmdlckBkZWxsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jIHwgMzUNCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPj4+ICAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8ICAzICsrKw0KPiA+Pj4gICAgaW5j
bHVkZS9saW51eC9udm1lLmggICAgIHwgMTAgKysrKysrKysrLQ0KPiA+Pj4gICAgMyBmaWxlcyBj
aGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYw0KPiA+Pj4gaW5kZXgNCj4gPj4+IDg3MmMzODlkYzZkMy4uYzY1ZDQ0ZmI2NWM0IDEwMDY0
NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ID4+PiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4+IEBAIC0yOTkyLDYgKzI5OTIsOSBAQCBzdGF0aWMg
aW50IG52bWVfaW5pdF9pZGVudGlmeShzdHJ1Y3QgbnZtZV9jdHJsDQo+ID4+ICpjdHJsKQ0KPiA+
Pj4gICAgCWN0cmwtPm1heF9uYW1lc3BhY2VzID0gbGUzMl90b19jcHUoaWQtPm1uYW4pOw0KPiA+
Pj4gICAgCWN0cmwtPmN0cmF0dCA9IGxlMzJfdG9fY3B1KGlkLT5jdHJhdHQpOw0KPiA+Pj4NCj4g
Pj4+ICsJY3RybC0+Y250cmx0eXBlID0gaWQtPmNudHJsdHlwZTsNCj4gPj4+ICsJY3RybC0+ZGN0
eXBlID0gaWQtPmRjdHlwZTsNCj4gPj4+ICsNCj4gPj4+ICAgIAlpZiAoaWQtPnJ0ZDNlKSB7DQo+
ID4+PiAgICAJCS8qIHVzIC0+IHMgKi8NCj4gPj4+ICAgIAkJdTMyIHRyYW5zaXRpb25fdGltZSA9
IGxlMzJfdG9fY3B1KGlkLT5ydGQzZSkgLw0KPiA+PiBVU0VDX1BFUl9TRUM7IEBADQo+ID4+PiAt
MzUyNSw2ICszNTI4LDM0IEBAIHN0YXRpYyBzc2l6ZV90DQo+ID4+IG52bWVfY3RybF9mYXN0X2lv
X2ZhaWxfdG1vX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4+ICAgIHN0YXRpYyBERVZJ
Q0VfQVRUUihmYXN0X2lvX2ZhaWxfdG1vLCBTX0lSVUdPIHwgU19JV1VTUiwNCj4gPj4+ICAgIAlu
dm1lX2N0cmxfZmFzdF9pb19mYWlsX3Rtb19zaG93LA0KPiA+PiBudm1lX2N0cmxfZmFzdF9pb19m
YWlsX3Rtb19zdG9yZSk7DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyBzc2l6ZV90IG52bWVfY3RybF9j
bnRybHR5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+PiArCQkJCSAgICAgc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1Zikgew0KPiA+Pj4gKwlzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4+PiArDQo+ID4+PiArCXN3
aXRjaCAoY3RybC0+Y250cmx0eXBlKSB7DQo+ID4+PiArCWNhc2UgTlZNRV9DVFJMX0lPOglyZXR1
cm4gc3lzZnNfZW1pdChidWYsICJpb1xuIik7DQo+ID4+PiArCWNhc2UgTlZNRV9DVFJMX0RJU0M6
CXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgImRpc2NcbiIpOw0KPiA+Pg0KPiA+PiAnZGlzY292ZXJ5
JywgcGxlYXNlLiAnZGlzYycgaXMgbWlzbGVhZGluZyBoZXJlLg0KPiA+Pg0KPiA+Pj4gKwljYXNl
IE5WTUVfQ1RSTF9BRE1JTjoJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiYWRtaW5cbiIpOw0KPiA+
Pj4gKwlkZWZhdWx0OgkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAicmVzZXJ2ZWRcbiIpOw0KPiA+
Pj4gKwl9DQo+ID4+PiArfQ0KPiA+Pj4gK3N0YXRpYyBERVZJQ0VfQVRUUihjbnRybHR5cGUsIFNf
SVJVR08sIG52bWVfY3RybF9jbnRybHR5cGVfc2hvdywNCj4gPj4+ICtOVUxMKTsNCj4gPj4+ICsN
Cj4gPj4+ICtzdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfZGN0eXBlX3Nob3coc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiA+Pj4gKwkJCQkgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBj
aGFyICpidWYpIHsNCj4gPj4+ICsJc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiA+Pj4gKw0KPiA+Pj4gKwlzd2l0Y2ggKGN0cmwtPmRjdHlwZSkgew0KPiA+
Pj4gKwljYXNlIE5WTUVfRENUWVBFX05PVF9SRVBPUlRFRDoJcmV0dXJuIHN5c2ZzX2VtaXQoYnVm
LA0KPiA+PiAibnJcbiIpOw0KPiA+Pg0KPiA+PiBQbGVhc2UgdXNlICdub25lJyBoZXJlOyAnbnIn
IGlzIGFtYmlndW91cyAoJ051bWJlcic/KQ0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3
LiBJIHdpbGwgYXBwbHkgdGhlIGNoYW5nZXMuDQo+ID4NCj4gPiBRdWVzdGlvbjogU2luY2UgdGhp
cyB3YXMgcGFydCBvZiBhIHNldCBvZiBwYXRjaGVzLCBkbyBJIG5lZWQgdG8NCj4gPiByZXN1Ym1p
dCB0aGUgd2hvbGUgc2V0IG9yIGNhbiBJIGp1c3QgcmVzdWJtaXQgdGhpcyBvbmUgcGF0Y2g/DQo+
ID4NCj4gV2hvbGUgc2VyaWVzLCBwbGVhc2UuIEFuZCBnYXRoZXIgdXAgdGhlIHJldmlld3Mgd2hl
biByZXN1Ym1pdHRpbmcuDQo+IA0KPiA+IEFsc28sIFNhZ2kgbWVudGlvbmVkIHRoYXQgdGhlIGRj
dHlwZSBzaG91bGQgb25seSBiZSBleHBvc2VkIGZvcg0KPiA+IERpc2NvdmVyeSBDb250cm9sbGVy
cywgd2hpY2ggbWFrZXMgc2Vuc2UuIEhvd2V2ZXIsIEkgZm91bmQgdGhhdCB3aGVuDQo+ID4gbnZt
ZV9kZXZfYXR0cnNfYXJlX3Zpc2libGUoKSBpcyBpbnZva2VkIHRoZSBjdHJsIG9iamVjdCBpcyBu
b3QgZnVsbHkNCj4gPiBjb25maWd1cmVkIHlldCAoaS5lLiB0aGUgY29udHJvbGxlciBpcyBub3Qg
eWV0IGlkZW50aWZpZWQpLg0KPiA+IElzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8gZGV0ZXJtaW5l
IHRoZSBjb250cm9sbGVyIHR5cGUgcHJpb3IgdG8NCj4gPiByZWNlaXZpbmcgdGhlIHJlc3BvbnNl
IHRvIHRoZSBJZGVudGlmeSBjb21tYW5kPw0KPiA+DQo+IE5vcGUsIHVuZm9ydHVuYXRlbHkuDQo+
IA0KPiBCdXQgbWF5YmUgd2UgY2FuIGx1bXAgYm90aCBhdHRyaWJ1dGVzIHRvZ2V0aGVyIGluIHRv
IGEgc2luZ2xlIGN0cmx0eXBlOyB0aGVuDQo+IHdlIHdvdWxkIGhhdmUgJ2lvJywgJ2FkbWluJywg
J2Rpc2NvdmVyeScsICdkaXNjb3ZlcnktY2RjJywgYW5kICdkaXNjb3ZlcnktZGRjJy4NCj4gDQo+
IEhtbT8NCg0KSSBsaWtlIHRoYXQuIEkgc2hhbGwgY29tYmluZSB0aGVtIGludG8gYSBzaW5nbGUg
YXR0cmlidXRlLiANClRoYW5rcywNCk1hcnRpbg0KDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBIYW5u
ZXMNCj4gLS0NCj4gRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFn
ZSBBcmNoaXRlY3QNCj4gaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgNCj4gU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxk
c3RyLiA1LCA5MDQwOSBOw7xybmJlcmcNCj4gSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjog
RmVsaXggSW1lbmTDtnJmZmVyDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0K

