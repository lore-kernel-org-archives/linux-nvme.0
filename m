Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F59BC61DA4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5CwwlnQ+lGFlzWuZHsVwS1Zj/T8QZKQ3zOz4e+slVG4=; b=47bU8UD02RVyLinskbKK9osWtu
	Cg9OdsK0HOgDwuCng0Hu+4iOrWB2IlnHotDRbTA75ZyInAgG5RUOnZEWj5G23KhUNIMj8MvfppjqJ
	guSUYbvLoBBQilNULZrr6rElUKbGncRyFS95AuwlfyamcQyetz2Kr5l78/yTihS1LfdllrbF5xZYp
	koM1fohyzcyU3NFrDllRVOmKW58F4Cm/X26/KRArq/grn6xTH2MrhNb4ti+RKE7xGATmZj/HcbMGw
	NpqSbUvQk8EvlvmBbU5ukyasI0sXlJircB5BY+M4F5unoBgLK6EhqDpMfEalbdUBYcNqJCkZZBmKy
	wqX5bHiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPD9p-00AQ62-AD; Tue, 07 Feb 2023 01:52:29 +0000
Received: from mx08-001d1705.pphosted.com ([185.183.30.70])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPD9l-00AQ3U-DE
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 01:52:27 +0000
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3171MSrs011554;
	Tue, 7 Feb 2023 01:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=5CwwlnQ+lGFlzWuZHsVwS1Zj/T8QZKQ3zOz4e+slVG4=;
 b=HTW6rIiQwzwU30WeZ9qyCOyfMjuyFUxZaosNy+HD7iUfxBlslsqNq1poSf0pG5/123Y6
 WmFm/CIFQcw4zLzQqnQQEdCmkEbO3rDJVwLKkOEx1D3wLUEwYHTiJ23iR9F/IvvP53sb
 BN0oQL8XFG/3C4A4/AyIsZngbplX1vmWBfn3v8RMJs9RmrY1XIXi3Pur5LM3rKolo4Dk
 xNmnANCx4xNGrzUyCrlSw0N/DkodLvjjaveB6YBB59etVKriHPLInDlJq/rR1UtG99ui
 ZTXzff0HtU+zSWu4++zyAt004avcrM0Anvsaf8MT2yxlcGSpgRMC7ccAdQvTL5JYLvw5 Vg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nhdx7ae3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Feb 2023 01:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNfOgAK4h+vH1tcex7dM5nseJPyaND4eXl3qyeO3ZCp4AQbp9Eini07tBw800PoU939DZy+9n8f3wLaW27KI0H3jG7RJxTYMnp+3KmI0VV64E3/tIuixZpuNWvqkEUOFoQnBp+2xjHvG+CEfD2yeZRt4wzQrwa9zrfJVvQKUxFHk+Jg4yNoQ2jW0WeMEwGAidcb4755QXFliTf43HCIkdxtmOgroyW0EepCH6p56RoqU2cWrcv9BPwD/ZUTZHKWKul945zBs7OGnmDLDcV9Gh+beiv5EbzJ2aEAL1UWElhgVxidkgZeIgd5ZyB5IdmYnxQfc7ZPMax6p2dSAuVQMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CwwlnQ+lGFlzWuZHsVwS1Zj/T8QZKQ3zOz4e+slVG4=;
 b=OIHCpkoKvVopcGu5znqE0wiKYjROqUc/uVXD8mbDkPqSYyts2Jgzs9+PdpSaB2ed+JMLYhl5lM8NbF1GWLhV+CYlsdsDgyiyq5lfP+t8I0HBtc8NHXi9ffDPX0zSCj5gkmSr8WwnNT13KhTg+Cr4Z/ShJPu0Q+yowC+naKb3WpvE+l8hEUqwqrqUUMFRAHX0qbAiIq2uFLgpgGf7IgM0qGRnKgdTmohTG05jZ7gVIlypLMUXxWeutyPQsr9TJlSW0Ml70E5koW8Nm4ivVkHGQaFXw2BVmPWJWwKQT/FFNYmUeKhokbHj/dzdPWmNrk5MFwivHP9gZ6faWbrqvqmvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by MN2PR13MB4119.namprd13.prod.outlook.com (2603:10b6:208:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 01:51:36 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 01:51:36 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Lewis,
 Nathaniel" <Nathaniel.Lewis@sony.com>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBwgAAQ4gCAAF+mkIAAAwkAgAEdYVCABGnaAIAAG+4AgAALJ4CAABkAAIAAgJNA
Date: Tue, 7 Feb 2023 01:51:35 +0000
Message-ID:  <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230202101818.GB14931@lst.de>
	<BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
	<BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
	<CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
	<BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<20230206140220.6af2b6k7belue2nh@ArmHalley.local>
	<20230206154218.GA12556@lst.de> <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
In-Reply-To: <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|MN2PR13MB4119:EE_
x-ms-office365-filtering-correlation-id: 9394ef42-279b-48b4-5fb0-08db08add88e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  tsCm2WcEPvuyKLbjdGJ2gbaV2KkDmyPv9ebor4in0dRsh+hgLADJOThPA1vG8Zgm2gRarsGEL/qQnEZeWa9pMPpXX4jZ5A2nlJdfOdPLjKrTAPXJB6JP1tnUFiDqPo1qgzDjIpS7rgekalXYAYx4ZZ9T3KnBw4OdsWbgF4R5Llezd59F2n94Cp41uQX13zuKpy4RXt2Wiv/uYV9YLIy6eUkf8gPXTsAP87tJwmahuNg9pxvRRD8z1ImYKqKktnVe0qn6AGwbFcvBfgNxuoUHg+jhLkHvuN1+2UT6pGbSk5I/U2CRTziDgfmdiYX33v0emxeaw+8hnYHjhKKkx6+AZLhj55Z10SGbcZm11Jc7WbN8QsmQ5TSHM+aTQARTFl19ZKHe1gtrhSgwknbxFwQicdbklYBodHvM3UWwrjFsv1gpEjsuCCOeWRvKShkJL7EQm+BneSJNBBHLNMVKFfcMCh/6Ul7Ot5v0i4V/Qaa9ux0D+VawkMlZqblbRiEFkZxvz68I0qJ2nARz2FaVd6+hNwfqcdNjx9hI1pwgVdT8SFI14SiuSWANLzeq6REVf5yzCF0GitjeAWQiRcbPZvU79MdufGn0sJqQB+lI4fSBs7T5E+uCAvqp962mDi+g4uN2bBKkUXWoCOoeHzJNdXcd6/TsmuWhmKJ+XqX52Yro/YKY7KAvOexS5t0xcAdMGMLsnaxzXJekPD8TEaQrI1JawYdJJ1i0Wux+xPHW2t9QV6F0xAmt5GcGHe3Fu1YIYG34
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(38100700002)(122000001)(5660300002)(54906003)(52536014)(110136005)(82960400001)(316002)(33656002)(38070700005)(55016003)(86362001)(186003)(9686003)(64756008)(7696005)(2906002)(26005)(478600001)(6506007)(71200400001)(66446008)(8676002)(4326008)(76116006)(66946007)(8936002)(107886003)(66476007)(66556008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Y3JVbjFvL3gxeHF6a3JFNXlYYzVEcnI2NmZhNUhlbUlHVUVBamRHazdsSng0?=
 =?utf-8?B?SGxzdkY2WnB2UDJ4N0lhcXMzNUx4elRrNlhsZjZjZ3FKRzFGV3ZIeUNoUnRN?=
 =?utf-8?B?WTZtdVQyc3ZZUE9qeGxiL2hibTRVS1JXenM2VFlWTldZb0xJcVVCY1JlLzUw?=
 =?utf-8?B?WVVUcVk4bGJqYVJKWlJEZ0NaYXVENkF4aHNIVE9rQmJHZHYyVFdrYkpyOWpp?=
 =?utf-8?B?V1JGbEtzWnFlNU5XZlUvdmp3dzZxUm4yYlF5NmR6UWhtUHlzY0EySjlzU0w2?=
 =?utf-8?B?bEQ3Rmd6VWVieWx5bVpHSDYwSFpnRlNaTDJuWXJGK1FmMHFtNTIzdC8rTXVq?=
 =?utf-8?B?RTV4TjNRR00vRi9VMldsamc4NHNRcHpYTG9TaEpORkpxN2FrV0U3ZkdkanhB?=
 =?utf-8?B?ZkN4UDRJUTdVaGVFbDN3bFduaDdWT0piSEdXSWRWL2NZREsyMUxSdDJQakRn?=
 =?utf-8?B?QkErajcxL0RoT3dkandGMFM1aFdIR0RsbHJjcW9NK0E2TWVtZFJvQWRvakVo?=
 =?utf-8?B?czhJQmNvMWVib2pYc2pjaCtyMmVXd1hLUzRmaFVsWk5Ha3FQTU9IaHZ4aWJS?=
 =?utf-8?B?bFBpalgwdmNKYmRIK1ZzUU9nQkhITUl6VDAxckFieEx6dS9uZFBvM1R6eHIr?=
 =?utf-8?B?U2QrWkkvMFQ3NFg3WTNmSkRTbzdJa2U3NStncmhzNHM3TEs4eEVsLzhEZ0x6?=
 =?utf-8?B?VEd0KzgraDdtajU3UU4zYUgzbG9KSkh5Nk5oYkYvdVA0T0k3KzdUVUhNRitW?=
 =?utf-8?B?emtmM2lqd04wRGpkM08wZGNSS21oRmx6ZjNNNCs0L1E1STQ2QzNEdmZkcEM4?=
 =?utf-8?B?eDh2YU4zbDF6NkhGSUxxRkZQK2tvNTFQQXE4dFR4NVZmZEFZQ2xFTE9mQjF3?=
 =?utf-8?B?UktBa2xraGJkSXUwcVNIcFVGUzZLNVpDNkNvYldWU3Bkc3RqNEtFRGxzbzBn?=
 =?utf-8?B?WHpyM3RYS2JPd0N4eUFjVjNuSkxIK05DdEFzYjJyZG5KQ2c1MGh3cndHSTlX?=
 =?utf-8?B?Nnd1V204MEdEaGQ2UHpzdFJNdHNIeGh0d2FkQ25DVlkzS2Rmd0gzdWNmM0J0?=
 =?utf-8?B?cURSc0JVV1Q2czRxRWZhNkpodlg1UktmV0pGaHp6STBlZWg2YkRrNDBXV01I?=
 =?utf-8?B?eVZTNHhLOU5qTHhURXNiUE8rMVlTZFp0SjRTVFIzelVYWkZCbXZicGRhNW53?=
 =?utf-8?B?bXRYTVZraEpwWmxDVlU1ejV1SkFNRkkvZW9WM3dZR3RwNFh3VGtjZElCdkdK?=
 =?utf-8?B?cllpWUx6Y1RqRWdVaVBueUhjamtvSWZJM1M5S1o1bHV4SmcxRkQrc0RxV3FN?=
 =?utf-8?B?Rm81a2J6c1VGVitrdDFPZkdoYmxTanp1VHR3SEVGNytFS0c2N2ZkUStkcXJO?=
 =?utf-8?B?ek9JQ2ZkRUNYZ2lpM3dMa2lFK3NqQVYrZ2Z0WUZrRUdLK1JYeEUzenZzcEZJ?=
 =?utf-8?B?MlNOV3R0ZjJ4eXpGN1NSRWxPcUN5TTFXNWFMSHk5WCtBRmhGUFFOWGR5b2hN?=
 =?utf-8?B?MHlxM0dNcEh5WUNPNGUzOU1yYmw4Qll0TE0wWkR2NC91WjNGSWdjZUFuVG9v?=
 =?utf-8?B?ZmJrclJLNld3OXp6QmlpaVIyWDJiTlhScVhTejRwclovUUpLOHRjMW44VWFR?=
 =?utf-8?B?L3RKODR4TnY3VVZnZGxwRlZXSjRuRWxobUxicFlRVk1IR2hJREdlcHlzSXhB?=
 =?utf-8?B?bWZHUUdPZUsrTkQvZlJ3dGdoRVZHZzA5Mmg0UlhUUjRWdVhSd25Oam9DejRY?=
 =?utf-8?B?eEdKeHFGeWErRmZBMWlQMmNsMXFncHJ2a1l2QUJrcmdxb1dPNXI1V202dWZ4?=
 =?utf-8?B?YzdKOGVzTHlQS0FTcFFVOXhKcklycCtpMFpGNCs1UHp3Q0lzS0RJc0ZDMk1h?=
 =?utf-8?B?SEMvL1NGQTE2eTRkU1RmcFh4MUxBVzJMWlN1VjB1Tzl6TGlIcklGaGJkdDMv?=
 =?utf-8?B?bm42NE55UnhXYXZsLytpcW40RDNvRWlkdmlJbGRXbzhlMm1sZjV6dmNzRjYy?=
 =?utf-8?B?Z3puTTduUHdhbXZRcmhmdXMvelFhek5NTVVpVnlBK2ZOYWE0cHdWQmx1SXdH?=
 =?utf-8?B?UTYzcmN5ZzFWOUtZbzJ5amdVNWl0bTZoUkhZOTBYUEFtZDlPT2hHZWlJQXlx?=
 =?utf-8?Q?LKETB8OXOhLop4hBGY/BuM+B/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	cJBmk2hgGW3/yZtGFz72zk8nqfeCijNmCBTdWE1TMzTVDeSFAtupMS8AeueqjIV4oAcmvg456bYdrbcDW/AyQ1QOunfER8lyss7hzNxEjkyS8AyHcrbiKFl4/Cx8UnKdVmAHh3Nrgc+OPc49BmcPAVjwgX5iHnLo2/sqRSAZjo3897rHahW27so7CW8M+pAJPam4cnA89U+mtvgYp3dC1UYs4qKc2eopBKqwTi2tK5UjO99/sSFqCvTkE1cetdBMg9Ajz33B/3Gh+3TfmLxPxYTat5ewfU5ES+Xz6L9bik+pe4TBt+LHDPoqiXxXp0fveOZoKIOhbbpmnvqSzAlmNckjrkf8mBlxUlkmoo1Tvak8iPB2sh3MhIzR7TehmexuSdiOZTDfQaU96aOv3xobWkY5GjJOaRfjn6kiT9zKrzKstGkl2j58C6pcl+CkyPN3uNVvp3wVp41GUIcNXHJTsS2bOJDMMavD9SOHsABpjJmGlU2wYn2fagxcD4p/djgMoJeU1B84gU3mKcZRQevveXiPxxsG8VMNBsZLX3jFUwsbO8/Bc/5pJBpe+p/efsfAYijxTmIOSlKlKkpUfhQ2bwXKiDlSnTvhDgXkheF8X1cSgDXZ8di0iDcjNYXWBw8u7LvPQGb5X1hkcuhBNv2LacGn5kRmiM7ZqC1o+tN8vPEflWHwSllBowVlqYnea+bKRzz38AHps6SxPFuMIf9Y24QecJu9VqsNmBR7Tfqs4e8XQloaxzvz28z1owiVlM4Tq/+XO5CSGgH5ZaooowQgGEkIDayJAaJsIOIZ6dyTXl36YeNLS1Yc6WH2M+gaLKV84bu2nxy9Sl5a+7y5G6f6VKosbXBZba5mPxeKTvxcHA0uuNMfrB/cvQKd1gWsO3//+1My3DNw4LQTu32BQlRsGw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394ef42-279b-48b4-5fb0-08db08add88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 01:51:35.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPaAvgYLWJSlWyjoHj1KC0EbGgCkevexuvH9UnIlJyOPIwRsIV2EDrc1TZmn0scLVWxXQ47peC9DfNx+Sz8W0e6ORE5awKsZc82NRc6Gs0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4119
X-Proofpoint-ORIG-GUID: tHJvLAWcqUUijXM3k9Ts7CtDib_g6rmn
X-Proofpoint-GUID: tHJvLAWcqUUijXM3k9Ts7CtDib_g6rmn
X-Sony-Outbound-GUID: tHJvLAWcqUUijXM3k9Ts7CtDib_g6rmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_175225_783152_60BAF76E 
X-CRM114-Status: GOOD (  22.16  )
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

SSBoYXZlIHRyaWVkIHN1Z2dlc3RlZCBhcHByb2FjaCwgd2l0aCBzb21lIG1vZGlmaWNhdGlvbjoN
CnBjaV9kZXZpY2UgaW4gcGNpX3Jlc2V0X3NlY29uZGFyeV9idXMgaXMgYWN0dWFsbHkgdGhlIGJy
aWRnZSBub3QgTlZNZSBkZXZpY2UgaXRzZWxmLCB0aHVzIEkgY2hlY2tlZCBkZXZpY2VzIGJlaGlu
ZCB0aGF0IGJyaWRnZSB0byBzZWUgaWYgYW55IGhhcyBEMCBiaXQgYW5kIGJhc2Ugb24gdGhhdCBs
b2dpYyBJIHJ1biB0aGUgY3VzdG9tIGRlbGF5Lg0KDQpVbmZvcnR1bmF0ZWx5IGV2ZW4gd2l0aCB0
aGlzIGFwcHJvYWNoIEkgc2VlIHRoZSBzYW1lIGlzc3VlIGZvciBib3RoIFNhbXN1bmcgZHJpdmVz
LCBhbmQgYmFzZWQgb24ga2VybmVsIGxvZ3MgSSBjYW4gc2VlIHRoYXQgd2FpdCBmb3Igc2Vjb25k
YXJ5IGJ1cyByZXNldCBnZXQgaW5jcmVhc2VkLg0KVGh1cyBzZWVtcyBsaWtlIHRoaXMgcXVpcmsg
ZG9uJ3Qgd29yayBmb3Igc29tZSByZWFzb24uIChJIHRyaWVkIGFsc28gaW5jcmVhc2luZyBkZWxh
eXMgdG8gZGlmZmVyZW50IHZhbHVlcyBidXQgaXQgZGlkbid0IHdvcmspLg0KDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQppbmRleCBmYmE5NTQ4
NmNhYWYuLjZlYzJmZTA0Mjc2NSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL3BjaS5jDQorKysg
Yi9kcml2ZXJzL3BjaS9wY2kuYw0KQEAgLTUwNDIsMTkgKzUwNDIsMzggQEAgdm9pZCBwY2lfYnJp
ZGdlX3dhaXRfZm9yX3NlY29uZGFyeV9idXMoc3RydWN0IHBjaV9kZXYgKmRldikNCiAgICAgICAg
fQ0KIH0NCg0KK3N0YXRpYyBpbnQgcGNpX2NoZWNrX2QwX3VuZGVyX2JyaWRnZShzdHJ1Y3QgcGNp
X2RldiAqZGV2LCB2b2lkICphcmcpDQorew0KKyAgICAgICAgdTE2ICpkMCA9IGFyZzsNCisNCisg
ICAgICAgIGlmIChkZXYtPmQwX2RlbGF5KSB7DQorICAgICAgICAgICAgICAgICpkMCA9IDE7DQor
ICAgICAgICAgICAgICAgIHJldHVybiAqZDA7DQorICAgICAgICB9DQorDQorICAgICAgICByZXR1
cm4gMDsNCit9DQorDQogdm9pZCBwY2lfcmVzZXRfc2Vjb25kYXJ5X2J1cyhzdHJ1Y3QgcGNpX2Rl
diAqZGV2KQ0KIHsNCiAgICAgICAgdTE2IGN0cmw7DQorICAgICAgIHUxNiBkMF9kZWxheTsNCg0K
ICAgICAgICBwY2lfcmVhZF9jb25maWdfd29yZChkZXYsIFBDSV9CUklER0VfQ09OVFJPTCwgJmN0
cmwpOw0KICAgICAgICBjdHJsIHw9IFBDSV9CUklER0VfQ1RMX0JVU19SRVNFVDsNCiAgICAgICAg
cGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgUENJX0JSSURHRV9DT05UUk9MLCBjdHJsKTsNCg0K
KyAgICAgICBpZiAoZGV2LT5zdWJvcmRpbmF0ZSkNCisgICAgICAgICAgICAgICBwY2lfd2Fsa19i
dXMoZGV2LT5zdWJvcmRpbmF0ZSwgcGNpX2NoZWNrX2QwX3VuZGVyX2JyaWRnZSwgJmQwX2RlbGF5
KTsNCisNCiAgICAgICAgLyoNCiAgICAgICAgICogUENJIHNwZWMgdjMuMCA3LjYuNC4yIHJlcXVp
cmVzIG1pbmltdW0gVHJzdCBvZiAxbXMuICBEb3VibGUNCiAgICAgICAgICogdGhpcyB0byAybXMg
dG8gZW5zdXJlIHRoYXQgd2UgbWVldCB0aGUgbWluaW11bSByZXF1aXJlbWVudC4NCiAgICAgICAg
ICovDQotICAgICAgIG1zbGVlcCgyKTsNCisgICAgICAgaWYgKGQwX2RlbGF5KQ0KKyAgICAgICAg
ICAgICAgIG1zbGVlcCgxMDApOw0KKyAgICAgICBlbHNlDQorICAgICAgICAgICAgICAgbXNsZWVw
KDIpOw0KDQogICAgICAgIGN0cmwgJj0gflBDSV9CUklER0VfQ1RMX0JVU19SRVNFVDsNCiAgICAg
ICAgcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgUENJX0JSSURHRV9DT05UUk9MLCBjdHJsKTsN
CkBAIC01MDY2LDcgKzUwODUsMTAgQEAgdm9pZCBwY2lfcmVzZXRfc2Vjb25kYXJ5X2J1cyhzdHJ1
Y3QgcGNpX2RldiAqZGV2KQ0KICAgICAgICAgKiBiZSByZS1pbml0aWFsaXplZC4gIFBDSWUgaGFz
IHNvbWUgd2F5cyB0byBzaG9ydGVuIHRoaXMsDQogICAgICAgICAqIGJ1dCB3ZSBkb24ndCBtYWtl
IHVzZSBvZiB0aGVtIHlldC4NCiAgICAgICAgICovDQotICAgICAgIHNzbGVlcCgxKTsNCisgICAg
ICAgaWYgKGQwX2RlbGF5KQ0KKyAgICAgICAgICAgICAgIHNzbGVlcCg1KTsNCisgICAgICAgZWxz
ZQ0KKyAgICAgICAgICAgICAgIHNzbGVlcCgxKTsNCiB9DQoNCiB2b2lkIF9fd2VhayBwY2liaW9z
X3Jlc2V0X3NlY29uZGFyeV9idXMoc3RydWN0IHBjaV9kZXYgKmRldikNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQppbmRleCAyODVhY2M0
YWFjY2MuLmM5NDhmNmIzZmJjOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQor
KysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KQEAgLTU5OTIsMyArNTk5Miw5IEBAIERFQ0xBUkVf
UENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDlhMmQsIGRwY19sb2dfc2l6
ZSk7DQogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4OWEy
ZiwgZHBjX2xvZ19zaXplKTsNCiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9J
RF9JTlRFTCwgMHg5YTMxLCBkcGNfbG9nX3NpemUpOw0KICNlbmRpZg0KKw0KK3N0YXRpYyB2b2lk
IHNhbXN1bmdfZDBfZml4dXAoc3RydWN0IHBjaV9kZXYgKnBkZXYpIHsNCisgICAgICAgcGRldi0+
ZDBfZGVsYXkgPSAxOw0KK30NCitERUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lE
X1NBTVNVTkcsIDB4YTgyNCwgc2Ftc3VuZ19kMF9maXh1cCk7DQorREVDTEFSRV9QQ0lfRklYVVBf
RklOQUwoUENJX1ZFTkRPUl9JRF9TQU1TVU5HLCAweGE4MGEsIHNhbXN1bmdfZDBfZml4dXApOw0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNpLmggYi9pbmNsdWRlL2xpbnV4L3BjaS5oDQpp
bmRleCBhZGZmZDY1ZTg0YjQuLjIxMTJjYmE0NWFiZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvcGNpLmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGNpLmgNCkBAIC00NjQsNiArNDY0LDcgQEAg
c3RydWN0IHBjaV9kZXYgew0KICAgICAgICB1bnNpZ25lZCBpbnQgICAgbm9fdmZfc2NhbjoxOyAg
ICAgICAgICAgLyogRG9uJ3Qgc2NhbiBmb3IgVkZzIGFmdGVyIElPViBlbmFibGVtZW50ICovDQog
ICAgICAgIHVuc2lnbmVkIGludCAgICBub19jb21tYW5kX21lbW9yeToxOyAgICAvKiBObyBQQ0lf
Q09NTUFORF9NRU1PUlkgKi8NCiAgICAgICAgdW5zaWduZWQgaW50ICAgIHJvbV9iYXJfb3Zlcmxh
cDoxOyAgICAgIC8qIFJPTSBCQVIgZGlzYWJsZSBicm9rZW4gKi8NCisgICAgICAgdW5zaWduZWQg
aW50ICAgIGQwX2RlbGF5IDogMTsgICAgICAgICAgIC8qIFJlcXVpcmUgYWRkaXRpb25hbCBkZWxh
eSBmb3IgRDMtRDAgdHJhbnNpdGlvbiovDQogICAgICAgIHBjaV9kZXZfZmxhZ3NfdCBkZXZfZmxh
Z3M7DQogICAgICAgIGF0b21pY190ICAgICAgICBlbmFibGVfY250OyAgICAgLyogcGNpX2VuYWJs
ZV9kZXZpY2UgaGFzIGJlZW4gY2FsbGVkICovDQoNCg==

