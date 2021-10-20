Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06452C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:43:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F8C60FC3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5F8C60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCvYhiGPtVOfoAo/MZLGA1ySWF7YV65Q54TffnHIMjA=; b=DAa4/2Mh+XzoJhsttfxtCpobAb
	yggGojWTEZBwE6uGTJXYmekGncia1dL1SpaG7taQL6QH30aZNDKDNfTMfYUWyWli9x3sN0jk+3b5f
	SVfKMDyRUUc7NDb9JG4bf+z8c6Q+s0vW/xxnLO5drrDe9P8OobehkuitjwLHcTcAz2i4VsedaDJ5V
	EY/wV1YVRNTf5d5csLPZmHGpz3hgNxiHMlrIo2ks5C4zgLuWuHTuPplljWPjwA2xh6jPTA6PYgF88
	PscSyGF+7+fCA5iAmTXV7Om35ujnBMlIVztLpXbOMyXB0m+2Ruc9LiKw68Tlfd4O8lWIi4/MAuPHo
	HA4hnKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdDkl-0056us-Tp; Wed, 20 Oct 2021 15:43:43 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdDkj-0056tV-Fk
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 15:43:42 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KCpE4m028125; 
 Wed, 20 Oct 2021 11:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FCvYhiGPtVOfoAo/MZLGA1ySWF7YV65Q54TffnHIMjA=;
 b=syyA/hYwXG2pMIC71IfhrtqUeK0fvm514jVtrYzFCoXeuV6suuCMYhGJixAKDLNC5NsP
 Y/aQFjFmDC1P7/2LqDKlydVtLCro+mp5k4rupC4xDbpOuZ2crI2E1n5ent6/5LtH1Q5N
 SYUXGHXU+7UKdNthxACxYpeqlQR0c8VA4rsKePfAiMfJebs1gNVUcCtJSEO5o+LiLVy3
 9Q21YxsJmClihme30thry7qDHsEVyQ+WJxB2InT8FSmYeCU6RFoLnpi2xHESr9QyHNuR
 YhP5uBG9bso/dYrMIYGhT5O2/o2uvrU++eOxgeYSMjxm83pIc1h2YWkQUk+9WEDeqj3G uw== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 3btkg08uab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Oct 2021 11:43:35 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 19KFK3qj085229; Wed, 20 Oct 2021 11:43:34 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0b-00154901.pphosted.com with ESMTP id 3bt781c2fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 11:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezRFNYEGU74rs7t1yjassry11M+XhXnSvCAuGYNZwpjAeO18xy3R0F9jSVz3ANHTmp7/W5FOuAioSsQSjUYvvu8N/WAtaYw/geYn6QdihOpPNlBry9B+4ZyOkSYgxTd9oqPrkitkVstHvmOCfnPXuUybJZNJ8rY3VQTrpl1E0RJeGw0DAJFELxOU1Mv2oa9Q/wuR07KDW0HDUSd2KZI+hgtqQ6a8jdhvxfeFBeYnuA+XclJsSuX5+afw6lNej6LPGGI6a3GquIa828Bw7dwLXS+D51NwzcX0TfRChBdIAiY9s2fxWdntkf+E2Rc5z6kCEm7brOKmirndif8+BqTefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCvYhiGPtVOfoAo/MZLGA1ySWF7YV65Q54TffnHIMjA=;
 b=Ir5MgAyXQt7ufqjmg1NpeslKRGS0DFMpfHKoOlcxZ6+i/Uu5d7irzHxICSkYJs3LJNdWukKCNf1n8RgcWW1lhyuR6cY1J4OC7VqNGHZCR7Z7eazkTrFd09a66DTo+S+uQ5oqkH55r1tgAZzh97GX+3Mn2V8bnV86qNA9Lekob9ral+cW8jgx1slrjmq+fVp3BlBpIUmnm1Hoq6ByJ+Lsal0udYzKVAWmGUO84jVWiZ7Whj2AAWXQfls24WObE7BRI9SuEwLKDiYZsrEMMDjVIYG7IaZylWiGJqbFp/ax/g2yMTC/14MJ/FeKUs2s2xBDtmMLUYYVu/5/Ha42+LWRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW2PR1901MB2153.namprd19.prod.outlook.com (2603:10b6:302:f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 15:43:32 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::7d75:a751:e366:2bc6]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::7d75:a751:e366:2bc6%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 15:43:32 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] nvmet_tcp: fix header digest verification
Thread-Topic: [PATCH] nvmet_tcp: fix header digest verification
Thread-Index: AQHXxN0a4q6RYcEmW0GV2etyjeOl+avaPSUAgAAm1hA=
Date: Wed, 20 Oct 2021 15:43:32 +0000
Message-ID: <CO1PR19MB4885C691C3B1B15AA139A9E0EEBE9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20211019113307.31852-1-amit.engel@dell.com>
 <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
In-Reply-To: <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2021-10-20T15:43:29Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=29c3ebf6-1407-40b8-989c-f9f0a875083c;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93b5bb32-4a70-4961-9f44-08d993e05f0f
x-ms-traffictypediagnostic: MW2PR1901MB2153:
x-microsoft-antispam-prvs: <MW2PR1901MB21533DA417EE8264081E35E1EEBE9@MW2PR1901MB2153.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8Ijhw0IMD9c81QOUyVGt9Mi5uAZlgXu7vcHYZvgRLTBqp4nPcVVT+MQwwhQxuV7zjPWmNKNlXGqtwvLj86SIiffiqcd4SpeHaiiTwGC9bthmzObefAoUZwzZ29lotfoh0O1vc452KbXGmyAC9U2N9F5UU09FL2cTgs9htKPwegA2QsQ8h9M019KFn2pj4jIP6zgIua6QkM+EZX7W3mvf4cZbTR6maw3BdSXkDWhEUPg4Afb0QznmCfn0Hj8Oy3NBfxFQ52uPztKgcPCy5eIWBVeqHqbzJs4+zx3bh4cc6WAUSMpKZhoGtCz1ueo+MwBJWlftL6c43SxIiZzDR59JOn64XSL9d8Ja63VKqKYT/ZQehVVddvLlRQVPIhD0VGfBzbqgGqZZdQDqZWFg7LnygsRC2DGncYAwtdzSAr3ZQNTtDkmiT27Dz41uzS1bwviMcvBUXqjeV2qveH+e8VyXzySKKKWiUVprvvgkakUQBlP2rpzdzS5U/sJfbUsedw125b6h4drK7BTt0yYdvymcnz+hb7xIwTzSko/h/soBcFm8T4XinvNonC197XF93eR/es6q5Ufl9gPQnBW0yDyYG3Bqjtjikd3mzfiKrLIj1vW2nO053bSqL0N1LFdlhfgpVGefTt0EwI3Io7cA7QAyb21XfwV9QSNY2zsG7JHfAgd5dxZdSw0tnrVKAm2rBp37DYBQYCdW4+M+VRNIPhE8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(5660300002)(38100700002)(55016002)(71200400001)(316002)(8676002)(83380400001)(6506007)(53546011)(122000001)(26005)(508600001)(76116006)(186003)(33656002)(66946007)(2906002)(66476007)(786003)(8936002)(38070700005)(15650500001)(66556008)(64756008)(66446008)(86362001)(7696005)(52536014)(82960400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0tSem0vLzFQaU0rMmJKTHg4dDVZVDVBMXd5SURFWjdqN0Y4Q3hTVG9xZ0ZL?=
 =?utf-8?B?THlsZjVkZEQ3d0VveVNVRFR6cFNjMmVSM1pTOFA5U1BPc1RJU1pObzhrcDJs?=
 =?utf-8?B?dTYwa2FDV1RGalQyQlhyKy9iMEt4SGNLUmtobWM4UXFaNUVuUUtBeTQ1OVBr?=
 =?utf-8?B?dHYvQloyNTJWVnhYMHhkR1B1QW92aHRXcWNTTXpTK1dTbmxYYndtdjFGdDRD?=
 =?utf-8?B?ZDhHQS8zWUozNVl5ZkFjV2J5blhFTnF3cnZVMzN5RlFJQUp1bFQzTHJVUGN3?=
 =?utf-8?B?dlI0bGpyeGpnVDRSODB1SjdENEU4dmxTSkU2RVVTQlZlTHRRNnJFVGFQbkFB?=
 =?utf-8?B?VVRXUk9BNmlzRmt4R1FSWUhGajFubS9tdTNaamFGbE4xbDVmYXVsdjFYTjFY?=
 =?utf-8?B?NjJ6SmVzdnNxUm1YeUhzTnh2RXZzUkhRYkRseE9FaW4yZHFPV0VidXJlRWxx?=
 =?utf-8?B?aFhGQkxYZncxM3JOOU5rVFAvMVptdnZaYnc3VGJNVkF5d1owcWV0V0pkSWxS?=
 =?utf-8?B?UWxxZ253bUljdkY2MXFJMmxKUElScnVCZmc2NG94ZkVEL1BhejdvR2gyb1ZG?=
 =?utf-8?B?cGpEajZOUDltSGZnTmpZVjk1am5NU282dHY0cXQ1d0pySHBPb3RMQWE5azUx?=
 =?utf-8?B?NWE2bzE2aUI5OU5YcHF4a2JQMjhEWnhUR3lnK0c4NmhwWS9CdFVWZ2hreU1n?=
 =?utf-8?B?TE82RHdSQXp3YkxBR2MzSmFFbDAwMWZDK1R5YVVLWUhwUWpSSHc3NXlEMlBw?=
 =?utf-8?B?SkJlb21kNHUyaTRVVlpDMGtIMjYxbU1tUTRxMElaSmJ1TGZCU04zRGdXZ1lu?=
 =?utf-8?B?TzdOOUdBejd6dEdTaUNoNHhRM2xsWXF1QXlSbVV2a1VJaGlRd2lSbVVQb1h0?=
 =?utf-8?B?T3FlNEUvVmZiSjZNT1lJUVlZTnZWUEdTdFh6UFE4YzRyVVNBdnlaRGg0WFdH?=
 =?utf-8?B?dzV0cElaUjRSbmFXT3VRYzBraVVvWGRwb0RzcFQwNEx0M1IxSnk0MWdhTzk4?=
 =?utf-8?B?VXlyUHVzNWcwQlVRVjZiSHJOWU5VNlhDd0ZTSENtYWs1WVBxRzlzR0JGY25K?=
 =?utf-8?B?ZW14NllDWTh5aUQ4aUVvZjRObmo4OXFLSFBLcU5FKy9WYnRqc2kzaTdWQzBs?=
 =?utf-8?B?NFl2SXgybk9FUVJDVlRqdkxheEJXUXVYUXVGNEUrL216TmEzSE8yR2pVdU1r?=
 =?utf-8?B?TWJGc2ViRUYwYTR4NVYzci9wbVVCQ3J2enNFNkI4aitjWTU1YlB2OVZXMGhW?=
 =?utf-8?B?cUdzbExnTEphZjdzQTlmTzNpOFpmdjluRDMrN1NQcmVPcTBBWkVVU3htM0ZO?=
 =?utf-8?B?NzVKZ090VEQwaWtLalBxN1N0UUh0ZlVxSmdiQWlLZDdWNHVWVzlxSG1PY0s4?=
 =?utf-8?B?TGdQbTkyVEhRellsSGFlNCsyZVV4M20rd0NvNFEyTnVJUnFXczc3djZlcVh6?=
 =?utf-8?B?NDZDUVZwOFJOVHFiRS9WTXMwQklUMDlCVVQxTDRmcXJHaUw5bi9Vdi81YzFK?=
 =?utf-8?B?ZEpDb2cxalZybk5SMUlyTXNOUy9lczF0dHYvUkVveUpjMDl2MEpla3ZsOVF3?=
 =?utf-8?B?YUtKQThIL0FRMU1kN1kzb0NSbVRhV2g1UzBPaEwva0NpRmxBeGZXZzMzOXBm?=
 =?utf-8?B?MU56eHozdUtoOG5laWpuWHlxZ1ZMZlE2a0JqY01BUkRYeXFPdUpFSjN0U3FO?=
 =?utf-8?B?bm5ndDVXdWh2TjFZMkYzb2QxNnF1N3VMaEZOV2xBdmlBRVFGZ01KS1N1eWlw?=
 =?utf-8?Q?tUAFksrS/eGx4ALD6Y=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b5bb32-4a70-4961-9f44-08d993e05f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 15:43:32.4590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Amit.Engel@emc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1901MB2153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-10-20_05:2021-10-20,
 2021-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200089
X-Proofpoint-GUID: 5ECsIuTf0Gfp68GxSUCi5U6XCzvNlohl
X-Proofpoint-ORIG-GUID: 5ECsIuTf0Gfp68GxSUCi5U6XCzvNlohl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_084341_555370_AF84897E 
X-CRM114-Status: GOOD (  26.32  )
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

T25lIG9mIG91ciB0ZXN0cyBmb3VuZCB0aGF0IA0KV2l0aCB0aGUgY3VycmVudCBjb2RlLA0KcmVj
dl9kaWdlc3QgPT0gZXhwX2RpZ2VzdCBldmVuIGlmIHRoZSBwZHUgaGVhZGVyIGRpZ2VzdCBpcyBi
ZWluZyBtb2RpZmllZCAoc3ludGhldGljYWxseSkNCkZvciBleGFtcGxlOg0KSW4gY2FzZSB0aGF0
IHBkdSBoZWFkZXIgZGlnZXN0IGlzIGNoYW5nZWQgdG8gMHhmZmZmZmZmZiwgcmVjdiA9PSBleHAg
PT0gMHhmZmZmZmZmLCBhbmQgbnZtZXRfdGNwX3ZlcmlmeV9oZGdzdCByZXR1cm5zIDAgLSB3aGlj
aCBpcyB3cm9uZw0KDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4g
DQpTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE5LCAyMDIxIDM6MTkgUE0NClRvOiBFbmdlbCwgQW1p
dDsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBoY2hAbHN0LmRlDQpTdWJqZWN0OiBS
ZTogW1BBVENIXSBudm1ldF90Y3A6IGZpeCBoZWFkZXIgZGlnZXN0IHZlcmlmaWNhdGlvbg0KDQoN
CltFWFRFUk5BTCBFTUFJTF0gDQoNCg0KPiBwYXNzIHRoZSBjb3JyZWN0IGxlbmd0aCB0byBudm1l
dF90Y3BfaGRnc3QuDQo+IHdoZW4gdmVyaWZ5X2hkZ3N0LCBuZWVkIHRvIHBhc3MgcGR1IGhlYWRl
ciBsZW4uDQo+IFRoaXMgZml4ZXMgYSB3cm9uZyBiZWhhdmlvdXIgd2hlcmUNCj4gaGVhZGVyIGRp
Z2VzdCB2ZXJpZmljYXRpb24gcGFzcyBhbHRob3VnaCBkaWdlc3QgaXMgd3JvbmcNCg0KQW1pdCwg
Y2FuIHlvdSBkZXNjcmliZSB3aGF0IHlvdSBtZWFuIGhlcmU/DQp3aGF0IGlzIHdyb25nIGFib3V0
IHRoZSBkaWdlc3Q/DQoNCldoYXQgaXMgY3VycmVudGx5IHBhc3NlZCBpbiBsZW4gaXMgcXVldWUt
Pm9mZnNldCwgd2hpY2ggaXMgdGhlIHRlbXBvcmFyeSBvZmZzZXQgZnJvbSB0aGUgcGR1LCB3aGlj
aCBpcyBlcXVhbCB0byBoZHItPmhsZW4gYmVjYXVzZSB3ZSB2ZXJpZnkgdGhlIGRpZ2VzdCByaWdo
dCBhZnRlciB3ZSBmaW5pc2ggcmVhZGluZyB0aGUgUERVIGhlYWRlci4NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQW1pdCBFbmdlbCA8YW1pdC5lbmdlbEBkZWxsLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9udm1lL3RhcmdldC90Y3AuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
dGFyZ2V0L3RjcC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYyANCj4gaW5kZXggNmViMGIz
MTUzNDc3Li45NTRjMjdhOTQ1NjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
dGNwLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYw0KPiBAQCAtMjY4LDcgKzI2
OCw3IEBAIHN0YXRpYyBpbnQgbnZtZXRfdGNwX3ZlcmlmeV9oZGdzdChzdHJ1Y3QgbnZtZXRfdGNw
X3F1ZXVlICpxdWV1ZSwNCj4gICAJfQ0KPiAgIA0KPiAgIAlyZWN2X2RpZ2VzdCA9ICooX19sZTMy
ICopKHBkdSArIGhkci0+aGxlbik7DQo+IC0JbnZtZXRfdGNwX2hkZ3N0KHF1ZXVlLT5yY3ZfaGFz
aCwgcGR1LCBsZW4pOw0KPiArCW52bWV0X3RjcF9oZGdzdChxdWV1ZS0+cmN2X2hhc2gsIHBkdSwg
aGRyLT5obGVuKTsNCg0KSWYgYXQgYWxsLCB0aGUgY2FsbGVyIHNob3VsZCBwYXNzIGhkci0+aGxl
biBhbmQga2VlcCB0aGlzIGdlbmVyaWMu

