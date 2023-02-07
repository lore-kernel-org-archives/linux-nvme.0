Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08241C636CC
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GquC7uAcGO84v41KLpQUCgTCcj8Q8VAey3MvcQQpeTU=; b=JU4pRHZKsX2ecOw7vFTS+eSlAd
	3+wrbwslXeLj7lhPjyxVf6CUOHgSVqiCQeXRUPYKfiyR14RaDX1BmsN2XOtZ+ECT9O2wr6CKWBmEo
	MTWd1XRJ6syIGy+XL3SJ0pzFkGyN4AbUB5yH87ROzaAtCh0OP8KZMK26+1Vcw5bF5zk3K7CfvTfah
	CrifgFjnloCPojRCC3pOAwc8js7NY/42Ah/2lsiCyF4MP78890RgzU7+cewYA5DmFoLE0561prQL+
	YSG8ot83uWVMLXOxw/Kd58/lG4mvlX2isM1jAJRcjW5rTyitFiwmyN7qhIqwaW9o8zwGEXQ25y86f
	iYICoDwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPTHl-00DAj1-Cl; Tue, 07 Feb 2023 19:05:45 +0000
Received: from mx08-001d1705.pphosted.com ([185.183.30.70])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPTHi-00DAiX-9T
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 19:05:44 +0000
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317G078Y012219;
	Tue, 7 Feb 2023 19:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=GquC7uAcGO84v41KLpQUCgTCcj8Q8VAey3MvcQQpeTU=;
 b=Qt9fIGXj95nJH8ez4u7fkydP5oj6y0AALIYR5/T7Znoq/GZkzm5kc9hKkZJAsspGlyH3
 22FX/nX+qABSD4dLV8f6oejlEJeDSNv1j8TQc6Yndxkv45wTZe80E5as9MIcuZNNBIkz
 GZONQbKVfyd/dSeC9QH+8215cC0b6am9qq6j/uy0ujPJfiKroJ4VOmFqbNuuO4cRCdEz
 MzAD1guy4aU+h0hik+MooITVQXb8fpNESuQZ1vuB7DoYPJLS8HYe3arla9rOLGo7Ro/w
 DVY8fz44W9fbO9Wdz932paHWINPLxCoIiTqQw8d1Z9D42I4j7VYI0QMBqLDVsUOipgaG ZA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nhe583e3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Feb 2023 19:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCSPrP+KiUGYxcnFH8XfSbd4/u8mG/p1+DN5lwM6I46+cBwohZekfdpwjHKNW2daUvpnrpU1fwtY33t8PV1pXAmYEJh/xkYRAjlLYgM+AH5qODlbrTGJKX/DOOafWykjZOktzXKcx6uM/wJKpUBdcvTLUagzdHsh9zgukIyPLYklfmqVTqX47cdotjyFzflG8ZZDeLG0183oNirAlXV+MDtR5fq5oCK2NfjWk7wscOI4jHzA1BgAJUQU0GBUDXDQdXfgISLP0yIXClnNYSmx6Gby8M65TkyiFpblQvLZ2sDnUE13NYitGcRQA+0Y20xTl0+LNf9oZ2gsFaZWP+0QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GquC7uAcGO84v41KLpQUCgTCcj8Q8VAey3MvcQQpeTU=;
 b=big8Zp6c5Ar82nZuwjgzwvVMqlwfxbfsSs4JlCNzBJc75+aLyefKmMgvOn51PMiLVwMXPR7/h0FjyTA2i1rw8BX/YRfjTnwWi7+5Np882RM5KuF5dx1oWTuitE0nyTNg+BnquuDHCrenUTK1UhiQ7xS81H/NTQlZBs4GbDk3k4c62mV8sDJd2v0hpyLs/Paqwe5FjRuAIYURtscmmLUB/hnuZKAN6xGvyWZ+QX12ncWOKJnX3xDNThS/5y0aPYwE3JCxWikdYVqDL8/v3Jo1PNkhtjXwO9Bz1yMpAX2u4hPygxJRqEYxWb2T1jH1jywc9cngZehDTSd3iNDiFgLxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by SA1PR13MB5586.namprd13.prod.outlook.com (2603:10b6:806:231::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 19:05:08 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 19:05:08 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Klaus Jensen <its@irrelevant.dk>,
        "Javier.gonz@samsung.com"
	<Javier.gonz@samsung.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "Lewis, Nathaniel"
	<Nathaniel.Lewis@sony.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Klaus Jensen
	<k.jensen@samsung.com>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBwgAAQ4gCAAF+mkIAAAwkAgAEdYVCABGnaAIAAG+4AgAALJ4CAABkAAIAAgJNAgAB0rgCAACN/AIAAigeA
Date: Tue, 7 Feb 2023 19:05:08 +0000
Message-ID:  <BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
References:  <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
 <CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
 <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de> <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
 <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
 <Y+IpsEd8kMoljOAa@cormorant.local>
In-Reply-To: <Y+IpsEd8kMoljOAa@cormorant.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|SA1PR13MB5586:EE_
x-ms-office365-filtering-correlation-id: 5eefbeed-20ec-46ee-e4a5-08db093e3b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Qdsjnaq2WL56qEYcTRzumpbD0nFwp95DARtP8+0iEhA1SZhhfvlL8nY+QU/TusQ/mCpvmtZGeRXSLmb1+7buHS0qeJ0tQIK1f4FbpZoG/qj8z2hA4Sq/90HjDoZqNfdjqRnWTYIiSNrzOz6prjC+383Hnsu6ORnsw0mhjdrb9dyPIYGUGt4R2+DnH7Ak1OEm3iHeEiLMMl3YuSKdNPyqqXel+/Oj5ljPAtTwOD8aDraE+nbwvnZ9Equ511g3xZq2JS3IIRj3C4TGQ15P+bYBnD2/rW6Ya30htg4K/IJ6aUR+XET11T5WakyRiWEnXJyNdcDoROF4A8xVYMfceo3gtc1/Mfgyi6HPCTBPprWL2xIC6K2iJbJDdtac3fk/xZJhoacOqXj7beoxftiESqgSlmjD53Y3aTH4RMFWjKxWO7B6fRPrMzdKCQVoL+ODdIvZgynHOYojJVgrpmEWMvDm/hmHa7apnDXxIP68Q6IUNJOPVDuHHXiVm7avFc4LiKQxvxYC+NtiiBBHystF4YuUHhVlDM2jJ0ztfRT6q+h128tGQNAmONpgQroaSlSJDrcs0uQN4zLJKcJtMM6dhHyhvgaEAABjbGVCKgBzCPmTTtjhEv27YJM0/6MdmBWGUrEil6d6v+M+icPBuERp6eNCJHWBk+IxGd3ii8FtgnWmc40mluYZELajOt6zjDfaKKCXIMTv6mmoIMaxP6wdugt6Zg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199018)(66446008)(4326008)(66556008)(66946007)(66476007)(2906002)(76116006)(7696005)(122000001)(38100700002)(86362001)(71200400001)(54906003)(55016003)(33656002)(316002)(83380400001)(5660300002)(52536014)(8936002)(8676002)(110136005)(64756008)(186003)(53546011)(26005)(9686003)(41300700001)(6506007)(38070700005)(82960400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RkxrTks0WWZLcm1jK3F2OFFGL0pubHFtam1lVC80ZDdxSFVQYi9NZ0w3RUxQ?=
 =?utf-8?B?TUl3M0p3aUdRQ2NRTC9XcXRPRG9lTDRzeEJFN1hKSnoweHN6dDN4bFFZaHdE?=
 =?utf-8?B?UlpsN3BDTjBabkJSbkFIemc2RGlZSnJrTURZYiszcXVlZzVtMlRhWFU4V0U2?=
 =?utf-8?B?SHFkcjB3cUNWQjN5YzBMM3dVTVdKWDEvSnZlSjlRanVYd21pL0tXNDBTczdK?=
 =?utf-8?B?VkZIUVFRZlpUaVlZRjBFVTNyRCs3VVFaTG1xU1RGN0kwVWNmUDdPY2d0V3RQ?=
 =?utf-8?B?cjlBbmp1c1dUblBJVVU0VkNtMG9vcGdtdDYzUEV1WHNPNUlNWS90cXh0TExZ?=
 =?utf-8?B?NHNsZXZ1S2hhbDVTdzNXczlLZGUvWWtFOVgrUHpsVFc1M0NCYkxpNFcwRXlG?=
 =?utf-8?B?OCtFS0loUkpLUUVtSlFxblpYTzl1a3l0dElYRXZtQlZKK2pabGhlR0RNMlRU?=
 =?utf-8?B?MGN1VmwwbjI0K283UmpCN2kyMlZ4cG1PUHUwYlBBVDhpeGptQ0N0UmozVXIr?=
 =?utf-8?B?MGlMRzU2WHpRWmtKZmk3cjIwbG9raUNUK3ZDSWliYk55TTFCajloaVFjTyt5?=
 =?utf-8?B?U1MxVVozd3F1TGhQMExKMytuNkhGck9tTDErUzNpTkxUSDROcFBiWFVPcm9I?=
 =?utf-8?B?akx1L3M2c3YrWGlocm12cU1VcXQwbzF3dkdVYnVjcmN3R2wwUFFiR3k4OVBp?=
 =?utf-8?B?eGc1d3dDVlVqdTdKeFBDelVoODFQSEZpUnJLWVhLVWpFOE52WGhFNkxqK01J?=
 =?utf-8?B?L1RLZmppdS9IcEJ2K2l5czFJVHVEdzVvSVF5T3FDalp6aHFza251d25pUkZi?=
 =?utf-8?B?YmZwMmZ3djdsakk5TFlidWdEZW9QUENCY0FvWldRMExxZnVDdWlETTBLaTBt?=
 =?utf-8?B?WVlwSTVqTCtIRzhtejYwSWljZEJGL0FZRmV2YVJrY0NGTFVMMEwxMWxyV0pj?=
 =?utf-8?B?eTZxNzZyWVZZa0RuYzk0N1ZxR3dmQVR2b2dvVXRrYjdBcnR4WStkaGU4dnlE?=
 =?utf-8?B?dThXOTB3NlpqUndXTTdDVkFoY2w1OWdwUVk4d1BYT3BzZmR6QWUydHFUQmE2?=
 =?utf-8?B?L05RVEhJVWt4Qm90eTZ4YTQ3eTAyUVBUby9QN2NPeHlZMmJyWXllYlJ0REdj?=
 =?utf-8?B?eUJ3WG5NNEhicWRRalV6UERicW9PVzhhTVYxRktHZlVwenVNM3Fja3pDTUZW?=
 =?utf-8?B?cDNELzE5VGdaQXFsVFhBRkdtRyt5MGRMUld0ZVBtY2NMMXJZblBqc0E4Mmdh?=
 =?utf-8?B?WDhUNE1wWVI2MWpWaUk5Rk1NbWFvSFM3RFV1WS9YR3VKQkZaKzRTMFBUVzVW?=
 =?utf-8?B?R2NYQ3N6N1RkUTJGd2NMQVpGbzgxL1NMVWFQaXBzOVo2aE8zOFA0c1lnMkxO?=
 =?utf-8?B?QURmU0Y1ZHYrWUNKWGk1MVZpNjRla3krKzJWb1JFVk1VU05ybW1XVVJsV1lL?=
 =?utf-8?B?N09FM0d1bnZ1ZjhjZTgzMmNFeXZWRFRUTVAwRlArekl3akdHMm5DM2lpbGw3?=
 =?utf-8?B?U3pQUXZQa01aU250VGZ0OG4zSWo5dHRLa1EvOThURGRDc2YxWFdmV2JncGda?=
 =?utf-8?B?UFFJSUdrRkdZZEFGRG00ZGQycnhHRmx5clprZ0xMYk5RK2JZa3REUm9tMm1o?=
 =?utf-8?B?MWtwMGczTENUeGtKd1ZhZ0tYQmhsYnFwRG1MbGVvOWFCQjBnN2Vpc2ZvdS9Q?=
 =?utf-8?B?cWg2V0F2QzBKSnV4K0J6ZVR2T1lzSFRzeFZmVlR1TE5BaXRtOTdJTU1oMUU1?=
 =?utf-8?B?NXBsM3BPaHJzT2psWmdlcFhqQXN5MlZOdW5BL0lqeG9RV0VlT0Zhcno5NHUr?=
 =?utf-8?B?TnB4LzBSeFNYWDdVcmRhZmtMc25jMGZnaFF4OGxqNC9hS2ErYVlLZUFHdHRB?=
 =?utf-8?B?LysxN2h5V3NnUERuMEtaRm5xeVNtaTF2RUREWHA0a3E0Q3QvMkk0cnR0WCtC?=
 =?utf-8?B?U2FYK2RnMHdydHNCUWRDRUxKOUZTNVlBNXpaQmtMdHNyeWIyZU0xKy9GOUhF?=
 =?utf-8?B?TTQ2dDdMQmMyeXljUmkwTWo4eFBYTXhOT1l3TEZ1cVZ0dCtvNkFtcHNweUIz?=
 =?utf-8?B?OUM5d2hzM0EralRiK1lsNGQ5V0w2NXNEOHk5cldtaVRnMVVpekp3WWlBQ2xp?=
 =?utf-8?Q?oj5DzU4KZEqbToV6GhfpPXlqL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?a1liKzdPVFJ0YjJ4UHBRMzBYcGJmbzIrbVVZSFRxMmRvM29OTC9qdzZOSWF5?=
 =?utf-8?B?b1ZTd2NDRVFqVStla3dTTFA0OTJOSkFjNU5DM25zZ3BvTHlHMktiOGQzOXRS?=
 =?utf-8?B?YkRxT1I1MFVadHRpQzkvdEVBME9ERG9NRWhIWE45Vzh1ODcxenFJSVJPazFL?=
 =?utf-8?B?aHozcDZSSXplQUxyeHJtZDhUSEdiS2ZLNXgzRjY2TlJ2andhSGhmbWlBeERR?=
 =?utf-8?B?TUhkb210RHdBTzlkNGRnblJBYUlFbjROT2xYbnlTVll3VUxQcGNDNTNaQWUw?=
 =?utf-8?B?cG91Y1ZEWUNTa0dwTWUyclMyNmRQNW9vNlgvQWRRNmFIWjN0dWxPSGtoRlVx?=
 =?utf-8?B?NXJRVDhFNGZpMnJXSXBBYzFHSXFORjZZSGdUMmlVZ2l2d0ZGS0hsRlNFaDBS?=
 =?utf-8?B?b3JvNmVRSHNZanR6UHU0bVdLZEUyZDRZMytWWjZGb2tuYmhYa3dGZVBLSDNi?=
 =?utf-8?B?Q0l3Rlk0M2t4WGlRVnRHOEU4Y2prY0JqdmQxcDVlbUtwZUM5Y3NoQmhlcER2?=
 =?utf-8?B?dncxTDZDNUlLT09naTJ3MGREZ3VtQmlmN1gvM0dSSjdBejVpby9qVlR0WEtG?=
 =?utf-8?B?am9NaUlKd21KaHRSMVBONFVxR0t4R0x3aEx0dHYrdi93Vjg3NlphdE5memQx?=
 =?utf-8?B?b0QzVEgvbS9kbTVLQktrRDNubmQ1RVpJOUxBa3JmWU1JNE4wSk00ckx5QmVN?=
 =?utf-8?B?K21YRGdKdlZUMGpnQ0pJcFFBOGdSS1djZ2FmcHk3QmhRS0NxRW1PNWNFOHlo?=
 =?utf-8?B?MFlVQW9TdWxUUHVZYXhjMVRLL29LVWNaczhaZEVOV0tmZHJzRWU4MUUyWHI3?=
 =?utf-8?B?UVExVGFxRDlZdkFkMmFzRU9xY1VOOVh1UlNUcXcrTFdlQTg3eDRaOUd5V1VD?=
 =?utf-8?B?YVdyWHFrdDkraUV1cW9rYmxMY21acVdOVm55ZmhhK2d6Y1l3Z3dPNEwyN3RY?=
 =?utf-8?B?a0ZOTzJWUStSVUdWUDhqSndmUzAwa1JUVEttTVhRMU1xdnJLelBIWm9HZUhS?=
 =?utf-8?B?ZkdMQzRBM3VzZDBDUUEvcEpsRHRFRW9Zakp4V1FIcDBla3REa2R0NmJtcXE1?=
 =?utf-8?B?STNqbGFkci94THcwUDVLbllsckRrWXpMTmFaYUxQcisveVI2WkNqUGllWWFF?=
 =?utf-8?B?OEwvR1RNRFNPUjNBdHdiNVUwcHV3TjNRTlErNFNkdGhBWHkzM1dRVUJrRzNa?=
 =?utf-8?B?dGFoK0ZVVm9KMHVKKzdTSE13N0pXbTFyR2ZsOEdkSHlTQTBqK3JXRnNjUWlW?=
 =?utf-8?Q?+0cmFZITmqvryZo?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eefbeed-20ec-46ee-e4a5-08db093e3b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 19:05:08.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIB6BnhkBt4dxk2UVRIBFLGb/7KG6TiL6pBKh0psX7zYa3xMnfxrtmpCci7skZw6Nrtg59cb9SZRtaBGSJGFjdwAogjjc9mSDEa1sQ/eVxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5586
X-Proofpoint-ORIG-GUID: oy_JX6d68xv58RRYMvULyZe_0u0phY_G
X-Proofpoint-GUID: oy_JX6d68xv58RRYMvULyZe_0u0phY_G
X-Sony-Outbound-GUID: oy_JX6d68xv58RRYMvULyZe_0u0phY_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_11,2023-02-06_03,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_110542_650174_8789F420 
X-CRM114-Status: GOOD (  31.10  )
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

SSBhbHNvIHVwZGF0ZWQgdGhlIEtlcm5lbCBpbnRvIDYuMi1yYy03IHRvIG1ha2Ugc3VyZSB3ZSBh
cmUgb24gdGhlIHNhbWUgcmV2aXNpb24uDQpJIHJlcGVhdGVkIGV4cGVyaW1lbnQgYW5kIEkgYW0g
c3RpbGwgZ2V0dGluZyBlcnJvciBvbiBib3RoIGRyaXZlczogUE0xNzMzIGFuZCBQTTlBMywNClNv
IEkgdGhpbmsgdGhlcmUgbWF5IGJlIHNvbWUgcGxhdGZvcm0vZncgZGlmZmVyZW5jZXMgDQoNCkkg
aGF2ZSB0d28gQU1EIFJvbWUgcGxhdGZvcm1zIHRoYXQgYmVoYXZlIHRoZSBzYW1lIChSb21lRDgt
MlQgYW5kIG90aGVyIGN1c3RvbSBtYWRlIGJhc2VkIG9uIHRoaXMgZGVzaWduKS4gSSBzZXQgdGhl
c2UgcGxhdGZvcm0gdG8gZG8gT1MgSGFuZGxlIGZpcnN0IChpbnN0ZWFkIG9mIHJlbHlpbmcgb24g
cGxhdGZvcm0gRlcpLg0KDQpEbyB5b3UgaGF2ZSBhbnkgc2V0IG9mIG52bWUtY2xpIGNvbW1hbmRz
IHRoYXQgSSBzaG91bGQgaXNzdWUgZm9yIHRoZXNlIGRyaXZlcyBzbyB5b3UgY2FuIGNvbXBhcmUg
RlcgcmV2aXNpb24gYW5kIG90aGVyIGRldGFpbHM/DQoNCkkgc2VlIGFsc28gaW4geW91ciBzZXR1
cCB5b3UgaGF2ZSBOVk1FIGNvbm5lY3RlZCB2aWEgdGhlIGJyaWRnZSAwMDAwOjAwOjAxLjIgc28g
aXQgbG9va3MgdmVyeSBzaW1pbGFyIHRvIG15IHBsYXRmb3JtLg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogS2xhdXMgSmVuc2VuIDxpdHNAaXJyZWxldmFudC5kaz4gDQpTZW50
OiBUdWVzZGF5LCBGZWJydWFyeSA3LCAyMDIzIDI6MzcgQU0NClRvOiBKYXZpZXIuZ29uekBzYW1z
dW5nLmNvbQ0KQ2M6IEdyb2Nob3dza2ksIE1hY2llaiA8TWFjaWVqLkdyb2Nob3dza2lAc29ueS5j
b20+OyBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+OyBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT47IHNhZ2lAZ3JpbWJlcmcubWU7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgTGV3aXMsIE5hdGhhbmllbCA8TmF0aGFuaWVsLkxld2lzQHNvbnkuY29tPjsgS2FuY2hh
biBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT47IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ft
c3VuZy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBudm1lLXBjaTogZml4IHJlc3VtZSBhZnRl
ciBBRVIgcmVjb3ZlcnkNCg0KT24gRmViICA3IDA5OjI5LCBKYXZpZXIuZ29uekBzYW1zdW5nLmNv
bSB3cm90ZToNCj4gT24gMDcuMDIuMjAyMyAwMTo1MSwgR3JvY2hvd3NraSwgTWFjaWVqIHdyb3Rl
Og0KPiA+IEkgaGF2ZSB0cmllZCBzdWdnZXN0ZWQgYXBwcm9hY2gsIHdpdGggc29tZSBtb2RpZmlj
YXRpb246IHBjaV9kZXZpY2UgDQo+ID4gaW4gcGNpX3Jlc2V0X3NlY29uZGFyeV9idXMgaXMgYWN0
dWFsbHkgdGhlIGJyaWRnZSBub3QgTlZNZSBkZXZpY2UgDQo+ID4gaXRzZWxmLCB0aHVzIEkgY2hl
Y2tlZCBkZXZpY2VzIGJlaGluZCB0aGF0IGJyaWRnZSB0byBzZWUgaWYgYW55IGhhcyANCj4gPiBE
MCBiaXQgYW5kIGJhc2Ugb24gdGhhdCBsb2dpYyBJIHJ1biB0aGUgY3VzdG9tIGRlbGF5Lg0KPiA+
IA0KPiA+IFVuZm9ydHVuYXRlbHkgZXZlbiB3aXRoIHRoaXMgYXBwcm9hY2ggSSBzZWUgdGhlIHNh
bWUgaXNzdWUgZm9yIGJvdGggDQo+ID4gU2Ftc3VuZyBkcml2ZXMsIGFuZCBiYXNlZCBvbiBrZXJu
ZWwgbG9ncyBJIGNhbiBzZWUgdGhhdCB3YWl0IGZvciANCj4gPiBzZWNvbmRhcnkgYnVzIHJlc2V0
IGdldCBpbmNyZWFzZWQuICBUaHVzIHNlZW1zIGxpa2UgdGhpcyBxdWlyayBkb24ndCANCj4gPiB3
b3JrIGZvciBzb21lIHJlYXNvbi4gKEkgdHJpZWQgYWxzbyBpbmNyZWFzaW5nIGRlbGF5cyB0byBk
aWZmZXJlbnQgDQo+ID4gdmFsdWVzIGJ1dCBpdCBkaWRuJ3Qgd29yaykuDQo+IA0KPiBUb28gYmFk
Lg0KPiANCj4gSSB3aWxsIHdyaXRlIHlvdSBzZXBhcmF0ZWx5IHRvIGdldCBzb20gZHVtcHMgZnJv
bSB0aGUgZGV2aWNlLiBXZSBoYXZlIA0KPiBub3Qgc2VlbiB0aGlzIGJlZm9yZSwgc28gd2UgbmVl
ZCB0byB1bmRlcnN0YW5kIHRoaXMgYSBiaXQgYmV0dGVyLg0KPiANCj4gUmVnYXJkaW5nIHRoZSBx
dWlyaywgd2UgYXJlIGxvb2tpbmcgaW50byBpdC4gV2lsbCBjb21lIHdpdGggc29tZXRoaW5nIA0K
PiBpbiB0aGlzIHRocmVhZCBsYXRlci4gQ2MnaW5nIEthbmNoYW4gYW5kIEtsYXVzLg0KPiANCg0K
SSBkdWcgdXAgYSBQTTE3MzMgYW5kIEkgYW0gbm90IGltbWVkaWF0ZWx5IGFibGUgdG8gcmVwcm9k
dWNlIG9uIDYuMi1yYzcuDQoNCldpdGggYW4gYWVyLWluamVjdCBlcnJvciBmaWxlLA0KDQogIEFF
Ug0KICBQQ0lfSUQgMDAwMDowNDowMC4wDQogIFVOQ09SX1NUQVRVUyBNQUxGX1RMUA0KICBIRUFE
RVJfTE9HIDAgMSAyIDMNCg0KSSdtIGdldHRpbmcgYSBGYXRhbCBlcnJvciB3aXRoIHR5cGUgIklu
YWNjZXNzaWJsZSwgKFVucmVnaXN0ZXJlZCBBZ2VudCBJRCkiLCBidXQgaXQgc3RpbGwgcmVjb3Zl
cnMgc3VjY2Vzc2Z1bGx5Og0KDQogIHBjaWVwb3J0IDAwMDA6MDA6MDEuMjogYWVyX2luamVjdDog
SW5qZWN0aW5nIGVycm9ycyAwMDAwMDAwMC8wMDA0MDAwMCBpbnRvIGRldmljZSAwMDAwOjA0OjAw
LjANCiAgcGNpZXBvcnQgMDAwMDowMDowMS4yOiBBRVI6IFVuY29ycmVjdGVkIChGYXRhbCkgZXJy
b3IgcmVjZWl2ZWQ6IDAwMDA6MDQ6MDAuMA0KICBudm1lIDAwMDA6MDQ6MDAuMDogQUVSOiBQQ0ll
IEJ1cyBFcnJvcjogc2V2ZXJpdHk9VW5jb3JyZWN0ZWQgKEZhdGFsKSwgdHlwZT1JbmFjY2Vzc2li
bGUsIChVbnJlZ2lzdGVyZWQgQWdlbnQgSUQpDQogIG52bWUgbnZtZTE6IGZyb3plbiBzdGF0ZSBl
cnJvciBkZXRlY3RlZCwgcmVzZXQgY29udHJvbGxlcg0KICBwY2llcG9ydCAwMDAwOjAzOjAwLjA6
IEFFUjogRG93bnN0cmVhbSBQb3J0IGxpbmsgaGFzIGJlZW4gcmVzZXQgKDApDQogIG52bWUgbnZt
ZTE6IHJlc3RhcnQgYWZ0ZXIgc2xvdCByZXNldA0KICBudm1lIG52bWUxOiBTaHV0ZG93biB0aW1l
b3V0IHNldCB0byAxMCBzZWNvbmRzDQogIG52bWUgbnZtZTE6IDMyLzAvMCBkZWZhdWx0L3JlYWQv
cG9sbCBxdWV1ZXMNCiAgcGNpZXBvcnQgMDAwMDowMzowMC4wOiBBRVI6IGRldmljZSByZWNvdmVy
eSBzdWNjZXNzZnVsDQoNCk1hY2llaiwgY2FuIHlvdSBzaGFyZSBmaXJtd2FyZSByZXZpc2lvbiBp
bmZvcm1hdGlvbiBhbmQgYSBiaXQgbW9yZSBkZXRhaWxzIG9uIHlvdXIgcmVwcm9kdWNlci9zZXR1
cCB0aGF0IG1pZ2h0IGFsbG93IHVzIHRvIHJlcGxpY2F0ZT8NCg0KDQpUaGFua3MsDQpLbGF1cw0K

