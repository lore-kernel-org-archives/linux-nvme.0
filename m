Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED00DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DsmtZjNVH89zWxUmwuzfsZG7cjVYiAnYiJz8gLTKDaw=; b=x6iZbFooCmzgJAfyHQzQs5wDgY
	HsSDt27EwXVhsQcSt0CAg/eyZBNVjCo3uv0e6OQDeOs0Jbp7aBtP8fFqfPEadxjo8JnRe0PBTq9Rq
	S0WmEEkDEsCMpE5DQNUuEjekAgRAa92jR0vHF8pZ9FPGADqDj2TexY70mjPVL6v45LSSJVRhivHUj
	4ZWA+fyf8yK6Hba/fHddpQnp1qwzKWxkMCrtLfll34ZqHOR/2Lzq27aB8KCTIjvRWyA0hU1oUoBTM
	XNHIzokx2ysfdqZ9QXI1uhJL33Ucm8u3yHMniPlom5dpDSf8KEKNjM9AklVbSd1FK5jR6jzjC73fp
	ToTDk4nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngapZ-000phI-9p; Mon, 18 Apr 2022 23:30:53 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngapW-000pgk-12
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 23:30:51 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23INLD9P024754; 
 Mon, 18 Apr 2022 23:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DsmtZjNVH89zWxUmwuzfsZG7cjVYiAnYiJz8gLTKDaw=;
 b=0a+JmmWMhjxmIdU8Yd4fHmwE5J3+yX08QXk35nm1LzlBc2kkgn1mSigVFwZum3VFxUD5
 kJOrUWZlJW2GjtbvHFMtTdxVcFV9kTJ3Xc5xYrqLGYKS+8AQ0k5GeEN1kCyw5yVU+MGx
 YL6bSh9FLWegVO05vLC2usnbprQnktGr5zgMuQToyGeO1+cHZEEYf65LSSQdr7s5wkd3
 jj9htJGd7szDFOfF2SrA0mNsbneEyke3/LfL+SIIwkHRO1ubu2sn8lWFABM1SP1yhNVp
 7OqsceCNvlz+4Syn3QYKiB1lxPVeF6WhUu1Zdjpcb9pT57qcAeSCVFYrsitgIfHz8kGD Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9cguh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Apr 2022 23:30:37 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 23INCW59028007; Mon, 18 Apr 2022 23:30:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3ffm87yqbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Apr 2022 23:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq74hAYKMa+lS/433A4b6OryHd0AZ9yOmSsMg8qV2odTyhts4oF0NX6urIRimqIT0EI1fwJFuoHL7rqYR+yZEE8zYr6BfD6yKfOb0afC4hvVf5cBLDr2l6VS1fDKyhZJ93Y3jEf4K8HUoareP3xv5ztlM0Pp6Hx0xn3frbKeqNX/F4kAFjCTbfJW+E8BcyHJ8LoQtQx4NiqDF9bumCcTAB7L3qVGQRwR3DDuvLut4bFsSD76bfHtTNitrr6aUr6Kf61K63IEE41HeklmEiPvBMfu+35b/A4GogzrRnMIFUvN0cIYITDcMR8oBRK4BrQs9ne3axHy9w5uyuM/hARC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsmtZjNVH89zWxUmwuzfsZG7cjVYiAnYiJz8gLTKDaw=;
 b=eqz90Ab04fMfOk4PjrX7jyiz+ihNu6APKILlP3o19/C26OhoMqbfirSe7eASTqlvJqKvpRyRNZiKXkcRGhZPi0HAVnbiJdDTnPDumH8cpd582NSVz1+KM5nu7Qvm3qF6jrDUXbJVaFgL22n02w9rTy3IefVqKGKVxwb40HdWrzwzJLH43+VHTmEmD/ezCdJ5HBx+B09gXMgPwbemcfrKo2um01YNupeScNnsHa2s6kUMMDmGE6e7sr+6ERXwJ85wEzbFKBOWDQsRd/lu3oyGX3BdPkPyMAcgBLSA4SLJ3TkpZgaXBPtFC1j7IQGvu/kIBK8T7yyVMEKj7g22I79Rsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsmtZjNVH89zWxUmwuzfsZG7cjVYiAnYiJz8gLTKDaw=;
 b=tXb/OdjtXXlYux8JdY2eK5t04CxyLcOF8cRK1gv6bmLdCMPZfzLVUqCras8CH/WhxdxsGVRJFh/yjStbctikRQMNa0htKS8dVF5bZOEyfR5Epi4v5YtLf9QfNE+yGVasM/PU2HWone2KQOT0oPdd7to0B6ESxRoY7aEbxnXB7NY=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM5PR1001MB2265.namprd10.prod.outlook.com (2603:10b6:4:30::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 23:30:34 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%3]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 23:30:33 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index: AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4A=
Date: Mon, 18 Apr 2022 23:30:33 +0000
Message-ID: <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
In-Reply-To: <20220411055455.GA14480@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeff5f80-ad81-48be-35f0-08da21936f71
x-ms-traffictypediagnostic: DM5PR1001MB2265:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB22652EE8CCCD924FBE2D425DF4F39@DM5PR1001MB2265.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzU2IhEoEAZfKeCpWNMjaHNxbVinBv2VdTxz/LhjDGSI4lWWA9tDsqNn9aLSBXZWoSis9ncryXye8n7tC7pbZTIXximvrnRD3E0eI4BE1Xh2znXcgrWX6qfA7nZjneiY2+iO5R+FnpdUnHvYEa2STYC4y1ZTeED/AtlBunnZ8g+G2cgQRvAsDxvQSaP1Zkv5L4ZxfeHjQLWdZukefMhDUFphmPPLFASch30+sSkzqbRDPDI4jmPKjHsdTSVYzuVlZpP/foho4wjqsp+ZCokHMM5jqcIeNvyKqzD2/mN/Ncji1kCd2hME+9FXbZxXSkZVWlyM+sNPw3BnEDiw/ZxyQhgb6VHWmhZBBRhKqSUdD0gUqiEPyT8C+r6nbgYZVfaoRIbt0UurWZmCFYiyfUxvq8dvwDgve+zBeChAyfkz4Oh9neN9W8eAGvNRnamXlWlr+cC41IXqoZb5PmJIGhXDUJcEflLIQrzhhpY/WT8nwYq2oq81jhfHlkN7xUoFv3VAf5hzUqPByfJsR8jB3WsuTbA3/OCAbBnbg6vIzhyWN7YgYrVdU9NQ066GtZwXUZP79ggud0rLSh5D/jFoAArBSo7RREvdwZlNajf6mIcZDGKv2piDqmO78i3Cey92jZ+glJFQrWN1ttuiIJA61UM8kK2roILGwlhoVRo84s8gPrHGHPiFE7ne9ieft0mBsAVFBttj6m7lsiFHOx6n96uKPOyhxQ+KJ/Sd1gnRAhSe9Y40WAyo6aWIeMCqqezdIAWv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(38100700002)(54906003)(6506007)(316002)(186003)(2906002)(508600001)(122000001)(38070700005)(6486002)(44832011)(86362001)(5660300002)(33656002)(71200400001)(6916009)(36756003)(6512007)(53546011)(2616005)(64756008)(76116006)(4326008)(66556008)(66946007)(66446008)(66476007)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0g4dXBGRjIxOUxkL0ZhTXl4KzhrNW5keGY0c0UraWsxa0FzYTVRQzE2ZHhj?=
 =?utf-8?B?Mm1JWkh1Tk11Rm1rblJaYmFqVGJIMndmN2tGUnpBd2RtMXUwenE3RWRxcWpw?=
 =?utf-8?B?RXQvOTl5cjBibmhjcXJsV2RXZEJOMnpzdzVXLzJDNHM0ck44b2d4R0lDVkZu?=
 =?utf-8?B?SzgrdDU5dzF2VEdsMFNTamhGbWRXUTBtZ0g2TTBSVm5SdjlEbHpQRTBSRldq?=
 =?utf-8?B?c1NoVml0cU1Gd0F3RnZjKzFXMEZPNllaKzNRMElOdzZLWVo2UitVVE1rODA4?=
 =?utf-8?B?ckl1Y0xHYmhkOFRnSlNVQ3RTc3h5UHkya01GSDF2U0s5cHpZdU5aQktlYjVz?=
 =?utf-8?B?clJuWnFseUpxNEc1R1FhTENVcER0bVpXUUt3dHFyRUNGMVBYem5kRWNKcHNi?=
 =?utf-8?B?Yjk1c28vNDZGYkRVM25YU1hud2MzcEV0cWJITE0rSi9OMGEwN252OHFzVGNY?=
 =?utf-8?B?eWdRMDdKVjZDbzdEWTV2eGFTTDJUbFl0WWoyVHVhOTFVZTN6aHhwaDNpVVMx?=
 =?utf-8?B?ajFqUWlOWkxZdWxES2pjVmxqZnFhVkxybkZ5amhrUHBpNFo3ZXlUNUcvUlg0?=
 =?utf-8?B?VUVtR1g4LytkTUU5VkRTamlmQ2toWTBkNzBKbHhEVDZQRkc2RUdmeW9GZ0dm?=
 =?utf-8?B?NjdIMW0yRDJ5YllzSld4ZEIzUXFhNjNyWjdEaEhNWG1naEdHM25NbDIvS0JN?=
 =?utf-8?B?TzlPS1E1QTBlRjE0aDNHUEc0eENIaU5XRWlvSlhpNGlJenJiOGNjMmNLNjI0?=
 =?utf-8?B?UDFnUm1zV3liYWM5WVNIYTlMZTRNbHV0UnNha2FjQ3B4MlNmcTNsMzlYcS9z?=
 =?utf-8?B?ZkNUZDFXT2syT1JqTGUvR0JsVHdLTEFIdzBQeGtKdGpaQnEweEkvRmt4a2F3?=
 =?utf-8?B?WFpsRnllclcwSy84bTYzclkwTVNuSUZlanRMMVdvVTVPVjU2Ti8zWm1nUTNw?=
 =?utf-8?B?MWlDd1VTUC9DTGVQU2NrY0JFVHZYenFvRGQ5eHhyQWlNTjkrdGk3bWVlTGxq?=
 =?utf-8?B?TXI2YWMxQzROVDl4STFPV3RpdTBnRXJWdWZ2dnR2Tm9GbUtMSEtwUFYzVWdv?=
 =?utf-8?B?T1dubkkxY0pFL05jbXpkZ0o2NzRScDFPbHhnRmh5T0gvcFhuWVdiZ3NudEVr?=
 =?utf-8?B?ZWJDZkRtb0xVT1p2SHhod3Iva2hDZG1nU1RjK1FKMXpiOGo3ZnZhQTV1aFpw?=
 =?utf-8?B?blZkaHRpcnA2cEcydnhPZ2s3TTgxQkNubDFlMmlQVzd4aGljaUtFMGRFQm43?=
 =?utf-8?B?NU04N0RtaHYyVUczZUp4ekU0K1ZwQ1JUUzJZTUNKNVk5aW81WVUxSlgwVElx?=
 =?utf-8?B?b010TGFQUXE3M0R5R2pCekhlQStGaXlYemxBQlFRcms5L0paZE8yM2ZnZDlv?=
 =?utf-8?B?d2x4OGZRR1Vuc2s2bitlOHZUWTFaakR2WTFGdktyZFVMMmpyV0VNL2p3M3BS?=
 =?utf-8?B?RVovSm92QlJaQ1R0N25mK0IwRnFMZjE5ZHdFMmxpNUtMWnp6aktaZ3VKMVlB?=
 =?utf-8?B?SGtXUm8zTStDTG9rdE9Xa2p2WkphUHF2cjlKNzJ3UWlmMjByOHhkZjNNK0Q5?=
 =?utf-8?B?Zld5MVZTQTRleGxxcEpjVGx1UFMzSUtSbHR1aHoyQWxpRVk3WXpJTGMwSjF2?=
 =?utf-8?B?eVhpWTRjTDExTUJFM2pMY3M4YUd5bXYxVE5VcjJ3bXFVa05XTjA1RzY3YUVV?=
 =?utf-8?B?V0pPMzgxYzhxbkdEMTFmRzlPRDU3dVlmcUVuUzNMOUxUdnUrUWx0QUpqcGVs?=
 =?utf-8?B?M3orMTZ2bjZreENmeTF5bTl1d3JwN3dkdmlEdmsxcURTQW50UWpxZmJmdk4w?=
 =?utf-8?B?MEpDTVMyMkEvM1ljQUQ3OG04bGo0MXY4c012cWIzZGVYMm5iMXY4Q1ZKbFZQ?=
 =?utf-8?B?WEVRRUdtNVZXa1NKaWwwc2tFMzRiV1VMNk9nVVpyWTZ5VjNva1BBK2k2MTdC?=
 =?utf-8?B?NC82ay9ycXdEZUlYZ0JGck9Icmc3Lzc0UG9yc1kyaWNrL2syajR0U01LcGow?=
 =?utf-8?B?RFg5NnEwNUVub3Y2SmJOZkx1U2xHVlZlT0lqYm9yMEw1NTYrWmwydEhmbHA5?=
 =?utf-8?B?ejBkZFNZYW9XU05JUVh0NjlkYzViUjZwQTFHMlkzc2lIWHcyM1BwazZ6c1dX?=
 =?utf-8?B?OTlqa1pkMzNoMTFsRUY4Qmd4bUViNTNiak1wTUdJcit4NTBNK2pXRDVRNk1k?=
 =?utf-8?B?ZERtcTNhQkJjTDZHY1FBVVRHTWliNldXL1NKRUFyZUJ4eXpOL2dDdFMyS0Nl?=
 =?utf-8?B?S1pFTzROeFlhY1VGN0wwNW1VOUxueVFjRXpPSWpzenRXU2o4QnJZcllSV2kw?=
 =?utf-8?B?SkI0a2FrNFRCWDBDUi9tL282RU1GaE82M0VQVGFYbGJBNnlIMzRWemlnUjJD?=
 =?utf-8?Q?UMZc1Pzo5b39HY2kDCha9tTgXvjOq8Oy2UcGz71C4audM?=
x-ms-exchange-antispam-messagedata-1: S0qlDkrvVyIZlQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <72590A82E19FD54E9E06262F43A80C6C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff5f80-ad81-48be-35f0-08da21936f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 23:30:33.9477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9vY4hHMo+ZeUOWlt6naqGY/CLRvIMR4nyqZynpsroGsu529vlwoNmk8joCEmYjkket0q20Pt3n7WTz0XsmZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2265
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-04-18_02:2022-04-15,
 2022-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204180130
X-Proofpoint-ORIG-GUID: iC3zhrRVYw2Jh9ouxuD7_t9byPmpdaYN
X-Proofpoint-GUID: iC3zhrRVYw2Jh9ouxuD7_t9byPmpdaYN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_163050_293283_D426F54A 
X-CRM114-Status: GOOD (  32.62  )
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

SSByYW4gaW50byBhbiBpc3N1ZSB3aXRoIGJsa3Rlc3RzIGFuZCBteSBxZW11IHNldHVwIHdoZW4g
cGFzc3RocnUgaXMgZW5hYmxlZC4gIFRoZSBwYXNzdGhydSB0ZXN0cw0KZG8gbm90IGNvbXBsZXRl
LiAgVGhpcyB3YXMgYmVjYXVzZSB0aGUgVVVJRCBmb3IgdGhlIHBhc3N0aHJ1IGRldmljZSBpcyBj
b21pbmcgZnJvbSB0aGUgYSBkZXZpY2UNCmZyb20gdGhlIHNhbWUgc3lzdGVtIHNpbmNlIHRoZSBm
YWJyaWMgd2FzIHNldHVwIGFzIGEgbG9vcCBhbmQgbnZtZV9nbG9iYWxfY2hlY2tfZHVwbGljYXRl
X2lkcygpIGZhaWxzLg0KDQpUaGlzIGlzIHByb2JhYmx5IG5vdCBhIHZhbGlkIHJlYWwgbGlmZSBj
b25maWd1cmF0aW9uLCBidXQgc2luY2UgYmxrdGVzdHMgdHJ5IHRvIHRlc3QgZmFicmljcyBvbiBh
IHNpbmdsZQ0Kc3lzdGVtLCB3ZSBoYXZlIHRoaXMgaXNzdWUuDQoNCknigJl2ZSBoYWNrZWQgdG9n
ZXRoZXIgYSBmaXggdG8gbWFuaXB1bGF0ZSBOYW1lc3BhY2UgSWRlbnRpZmllcuKAmXMgdG8gZ2V0
IHRoZSB0ZXN0IHRvIHdvcmsuICBJcyB0aGVyZSBhDQp3aHkgZm9yIGJsa3Rlc3RzIHRvIGhhcmRj
b2RlIHRoZSBJRHMgZm9yIHRoZSBwYXNzdGhydSBkZXZpY2VzPw0KDQpBbGFuDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0
L3Bhc3N0aHJ1LmMNCmluZGV4IDUyNDdjMjQ1MzhlYi4uZTNkYjUzYjIzMmU2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQorKysgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L3Bhc3N0aHJ1LmMNCkBAIC0xNTksNiArMTU5LDQwIEBAIHN0YXRpYyB1MTYgbnZtZXRfcGFz
c3RocnVfb3ZlcnJpZGVfaWRfbnMoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KIAlyZXR1cm4gc3Rh
dHVzOw0KIH0NCiANCitzdGF0aWMgdTE2IG52bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX25zX2lkX2Rl
c2Moc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KK3sNCisJdTE2IHN0YXR1cyA9IE5WTUVfU0NfU1VD
Q0VTUzsNCisJY2hhciBpZF9kZXNjWzJdOw0KKwlpbnQgaSA9IDA7DQorDQorCXN0YXR1cyA9IG52
bWV0X2NvcHlfZnJvbV9zZ2wocmVxLCBpLCBpZF9kZXNjLCAyKTsNCisJaWYgKHN0YXR1cykNCisJ
CXJldHVybiBzdGF0dXM7DQorDQorCXdoaWxlIChpZF9kZXNjWzFdKSB7DQorCQlpbnQgbGVuOw0K
Kw0KKwkJbGVuID0gaWRfZGVzY1sxXTsNCisJCWkgKz0gNDsNCisNCisJCWlmICgoaWRfZGVzY1sw
XSA9PSAxKSB8fCAoaWRfZGVzY1swXSA9PSAyKSB8fCAoaWRfZGVzY1swXSA9PSAzKSkgew0KKwkJ
CXN0YXR1cyA9IG52bWV0X2NvcHlfZnJvbV9zZ2wocmVxLCBpLCBpZF9kZXNjLCAyKTsNCisJCQlp
ZiAoc3RhdHVzKQ0KKwkJCQlyZXR1cm4gc3RhdHVzOw0KKwkJCWlkX2Rlc2NbMF0rKzsgLyogQ2hh
bmdlIDFzdCBjaGFyYWN0ZXIgb2YgdGhlIE5JRCAqLw0KKwkJCXN0YXR1cyA9IG52bWV0X2NvcHlf
dG9fc2dsKHJlcSwgaSwgaWRfZGVzYywgMik7DQorCQkJaWYgKHN0YXR1cykNCisJCQkJcmV0dXJu
IHN0YXR1czsNCisJCX0gDQorCQlpICs9IGxlbjsNCisJCXN0YXR1cyA9IG52bWV0X2NvcHlfZnJv
bV9zZ2wocmVxLCBpLCBpZF9kZXNjLCAyKTsNCisJCWlmIChzdGF0dXMpDQorCQkJcmV0dXJuIHN0
YXR1czsNCisJfQ0KKwlyZXR1cm4gc3RhdHVzOw0KK30NCisNCisNCiBzdGF0aWMgdm9pZCBudm1l
dF9wYXNzdGhydV9leGVjdXRlX2NtZF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqdykNCiB7DQog
CXN0cnVjdCBudm1ldF9yZXEgKnJlcSA9IGNvbnRhaW5lcl9vZih3LCBzdHJ1Y3QgbnZtZXRfcmVx
LCBwLndvcmspOw0KQEAgLTE3Niw3ICsyMTAsMTEgQEAgc3RhdGljIHZvaWQgbnZtZXRfcGFzc3Ro
cnVfZXhlY3V0ZV9jbWRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQogCQljYXNlIE5WTUVf
SURfQ05TX05TOg0KIAkJCW52bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX2lkX25zKHJlcSk7DQogCQkJ
YnJlYWs7DQorCQljYXNlIE5WTUVfSURfQ05TX05TX0RFU0NfTElTVDoNCisJCQludm1ldF9wYXNz
dGhydV9vdmVycmlkZV9uc19pZF9kZXNjKHJlcSk7DQorCQkJYnJlYWs7DQogCQl9DQorDQogCX0g
ZWxzZSBpZiAoc3RhdHVzIDwgMCkNCiAJCXN0YXR1cyA9IE5WTUVfU0NfSU5URVJOQUw7DQogDQot
LSANCg0KDQoNCj4gT24gQXByIDEwLCAyMDIyLCBhdCAxMDo1NCBQTSwgQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgMDc6
MDU6MzNBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4gSG93ZXZlciwgd2hh
dCBJJ20gc2VlaW5nIHNlZW1zIHRvIHNob3cgdGhhdCB0aGUgdXVpZCBpcyBzYW1lIHV1aWQgYXMN
Cj4+PiB3ZWxsIHdoZW4gbm90IHVzaW5nIC1kZXZpY2UgbnZtZS1ucyBidXQganVzdCAtZGV2aWNl
IG52bWUgKHRoaXMgaXMNCj4+PiBjYWxsZWQgbGVnYWN5IG5vdyBpdCBzZWVtcz8pIHdpdGhvdXQg
dGhlIHV1aWQgc2V0IHlvdSBlbmQgdXAgaW4gdGhlDQo+Pj4gc2l0dWF0aW9uIEkgZGVzY3JpYmVk
LiBJIGp1c3QgZGVzdHJveWVkIG15IGd1ZXN0cyBhbmQgc3RhcnRlZCBmcm9tDQo+Pj4gc2NyYXRj
aCBhIHNldCB1cCB1c2luZyBxZW11LXN5c3RlbS14ODZfNjQgdjYuMi4wIG9uIGRlYmlhbi10ZXN0
aW5nLA0KPj4+IGFuZCBlbmQgdXAgaW4gYSBkaWZmZXJlbnQgc2l0dWF0aW9uIGJ1dCBpdCBpcyBz
dGlsbCBhIGJpdCBwZXJwbGV4aW5nLg0KPj4gDQo+PiBXaXRoIG15IHVzdWFsIHFlbXUgdGVzdCBz
ZXR1cCAoYnVpbHQgZnJvbSBhIGdpdCBhIGZldyB3ZWVrcyBhZ28pLCBubw0KPj4gdXVpZCBzaG93
cyB1cCB1bmxlc3MgZXhwbGljaXRseSBzZXQuDQo+IA0KPiBEaWdnaW5nIGEgYml0IGRlZXBlciB0
aGlzIHdhcyAiZml4ZWQiIGJ5Og0KPiANCj4gNWY0ODg0YzQ0MTIzMThhMWFkYzEwNWRlYTljYzI4
Zjc2MjVjZTczMA0KPiBBdXRob3I6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+
DQo+IERhdGU6ICAgTW9uIEF1ZyA5IDEyOjM0OjQwIDIwMjEgKzAyMDANCj4gDQo+ICAgIGh3L252
bWU6IGZpeCBtaXNzaW5nIHZhcmlhYmxlIGluaXRpYWxpemVycw0KPiANCj4gICAgQ292ZXJpdHkg
Zm91bmQgdGhhdCAndXVpZCcsICdjc2knIGFuZCAnZXVpNjQnIGFyZSB1bmluaXRpYWxpemVkLg0K
PiAgICBXaGlsZSB3ZSBzZXQgbW9zdCBvZiB0aGUgZmllbGRzLCB3ZSBkbyBub3QgZXhwbGljaXRs
eSBzZXQgdGhlIHJzdmQyDQo+ICAgIGZpZWxkIGluIHRoZSBOdm1lSWROc0Rlc2NyIGhlYWRlci4N
Cj4gCQkgICAgICAgICANCj4gICAgRml4IHRoaXMgYnkgZXhwbGljaXRseSB6ZXJvLWluaXRpYWxp
emluZyB0aGUgdmFyaWFibGVzLg0KPiANCj4gTm90ZSB0aGF0IGV2ZW4gd2l0aCB0aGUgZml4IHRo
ZSB1dWlkIGZpZWxkIGlzIGFsd2F5cyByZXBvcnRlZCwgZXZlbg0KPiB3aGVuIGl0IHNob3VsZG4n
dCAtIGl0IGp1c3QgaXMgdGhhdCBMaW51eCBoYW5kbGVzIGEgMCBVVUlEIGdyYWNlZnVsbHkuDQo+
IA0KPiBJIGNhbiBhbHNvIG5vdCBmaW5kIGFueSBjb2RlIHRoYXQgd291bGQgYXNzaWduIGEgZGlm
ZmVyZW50IHV1aWQNCj4gd2hlbiB1c2luZyBhIGRpZmZlcmVudCBjb21tYW5kIGxpbmUgc3ludGF4
LCBidXQgZ2l2ZW4gaG93IHVudXNhYmxlDQo+IHRoZSBuZXcgc3ludGF4IGlzIEkndmUgbm90IGFj
dHVhbGx5IGJlZW4gYWJsZSB0byB0cnkgaXQuDQo+IA0KPiBTbyBJIHRoaW5rIGZvciBub3cgd2Un
bGwganVzdCBuZWVkIHRvIGRpc2FibGUgaWRlbnRpZmllciBvbiBxZW11Lg0KPiANCj4gSXQgd291
bGQgYmUgZ3JlYXQgaWYgcWVtdSBjb3VsZCBzd2l0Y2ggdG8gYSBuZXcgUENJIElEIGFmdGVyIHRo
aXMgaXMNCj4gZml4ZWQgYXMgdGhhdCBzaW1wbGlmaWVzIHRoZSBxdWlya2luZy4NCj4gDQoNCg==

