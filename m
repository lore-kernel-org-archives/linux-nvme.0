Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC4CCD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3InXmcFUk9ABufh6XM30zBlsr7h4PzfeW880+v7tjM=; b=nKXaq2OKO0LjPSxD7w9z+RSR0/
	N0IzBjP0NzPCFaoPN8eiPOHcaLnhj6IHZ4Vw6Id8qehRJFuYhXz+cQRaJ5qxOyAxvO/c0BML81CXu
	YyIchT8vt4ATfdms31lpEVu/HXrefLTr+TxJfWjwEXzX46loavBOn4PdfsWVk2x2EqGlr9hzSos7P
	eRcG8MVq3JtBZTWUBkWNLX8QUkiowqX2+v7ZUpTOWmepFXn9cwAWo9K6lj5LIpkqe5VqtIwy6NxYy
	FD+mde6Hb8j+eubLLXlAuQEMoZLN8s6Ob4RT1PlNrhIbv0FmAtQDDbyC+gGLXbFBMvaeAWhNZX0AJ
	ac0PrYYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNo0l-00000007kXs-0u2P;
	Fri, 15 May 2026 08:35:11 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNo0e-00000007kWw-0kmO
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 08:35:06 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F1rSl22945209;
	Fri, 15 May 2026 08:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t3InXmcFUk9ABufh6XM30zBlsr7h4PzfeW880+v7tjM=; b=
	QDGmM1hhebsYr+jyVIQoDNbfjg/jnNP66Z0vyoibhUmWjSXmciIC12oWKhT+8wtA
	l9Ifc8sc6J5seJfZ6Zm+IUQo/9NfoSNOrHXvYGNZYMR9k690XwaFKFzRrd9nqxOx
	BEN1zd4Emb5aV9szDEP02pZs35+K8HKTjMLMUji1x1NwkZQGXlwQa3FxFH2C3TIX
	critx9iSNgME85Ym01eNnSAiZXzv9KFX7Pa0BqXnifnJlabZ4sJnvf+iOSb32smd
	FCRVGdwUVqSvmXFCHCgQX1ba5WvzGhK5LjJjmm5QbE1QUQFg69MncurXeyMIhcpB
	qw1DR+saM59zfmpV4ckF6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e5m208u0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 08:34:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64F8Yl7R018341;
	Fri, 15 May 2026 08:34:50 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e5kw5fsj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 08:34:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBpjyZNgyqI6+WcN+P47OtBMAsTF0VkqdtA8NOsmf7crXbWBWlcv0hEpqYYFr32vb4N8t2yzZNEqZgj6yYYg+qqJ7N4X25Qf2bQZL12TMyEW/f2sWDkEsvH3nf7Nz2BciZ2njDKMejz6VydEnYAMTNN8Zmk+hV4ivYMkODU68Rb+MZr+4J3nyVzDPaGl4Y+HOl4zoxBjjQmEZjiYPb8dcY/mp3UwwvedsaMmACEiv6UAzpNz/39f4BkdOS9qZkC2uV+Kxfpu8CGrzrMaKvMaTag3EgvrPifWccdNgRTzieUlZFFmWKIFK77gJ5LZw8oD2M58XR2rwCLh8MvTPeFAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3InXmcFUk9ABufh6XM30zBlsr7h4PzfeW880+v7tjM=;
 b=qf3ajEO3KPSzhN8lu+mm4s5ofG/7DNPkRHr/b16EsVk2PQmTixcfFdhZSrURG+3jD8m/Ev5wnjU6R7pC8mPtWxZjHsPR9yROYTeHJvFE7G9pnXQ4l44/TE5LJuacD/cwstPQzvVe8eXnvOveNxX6uri42eIwOqve2hcAsMPq1EA6EONFeO0fwn0+5yjUHLzocxZEukAHpwfxz/PMhLZnXLBOvXgU8LKOJWsggmB86WSeZGbQ/YJGO/1XIMPLGAFjLJArTdODtyUpIQyh5r0OWjUlAzXVvJAN6G3OgkdWf/KNmv104dDbb/uiD9/AvMP6JPovBJsNFRkxLy+3uOOBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3InXmcFUk9ABufh6XM30zBlsr7h4PzfeW880+v7tjM=;
 b=A4N1o5jzO3tNmkhm84EKTnfN5v/tM/cH8en7YnUdkvztLI88v8iINyzCBc8ltaqpkclpgDyc89100jRXz/14rWYUKElrqXjB/i8yGtqz8ErwqHuR+n3JS8e8hbYwufoimK+wcA/EoINA9q7FfNXfUB8I0/znHbKZgMw7s1/dN1Q=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DM4PR10MB5989.namprd10.prod.outlook.com
 (2603:10b6:8:b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 08:34:33 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 08:34:32 +0000
Message-ID: <bea351b2-2cfe-4a3c-b2ad-7185b29a4af3@oracle.com>
Date: Fri, 15 May 2026 09:34:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for
 multipath_sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, bmarzins@redhat.com
References: <20260513095030.2771178-1-john.g.garry@oracle.com>
 <20260515044529.GA4003@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260515044529.GA4003@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d9e75d-5ef6-4aa0-d2df-08deb25cc9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: u03MnbYp57pCg4bdMDaZ49FgxPHxeqljqD7m8Ec9j/tWFT4qNM3R+v4LPTxTjvbQzUMPYAftXWxIHe0mL4WDMdUOTqY1oURc7Ar5kB9h4eqtqCqz+2Zn0/4r+4Qa/WyThFupQQ/7ZI0A66bWMBkdbLogGCGKJOZOVqZPr5nkZ6zyYUPo6zgmccW/zcGP0/vWlKFGrqZzQSI1xGdha6ThPR3XMq/xUKMIvhGiidkoC/T6Y2sAePPL7SAXKvt99lkkR5lCHPs0PzxXiD9CT7xtEdnhWWIL8TsjkQvicOsbyFgbgA0q+JqALLTT6ovhHDkDMORxkwv/UdCtU9wpXryZUjLqg58z42kOgrkyj1pwcPdZLxNEjQYVia1AQuF5143iL17KuvLCl26nNwogSk9ISuN0+/WMqz7CwVje6LYuLpSua6BAz7j5BVKsufC8px1yi4F9kFwVPg2Ev+qaLIb75N2ODDZrmLt9l135CqicVFc426urHuixMBQVcuh8GF//o9cAsgNspFaISBjTxJmdGIpp4be51NEq4MsjDmk7iJXsw4GE2XhFhebpZ9moHqQi4szrgLzYWWb4qgzJBE1lGFVk8ysTOuaAf1MBVWUzUwBMYn6YDo/avgz1wqR25xht5kd2S1WHOgOLGsnJAKOrfDWUSOtvuXnfELsy9Cuj8b6JsjGFPymi9yWMjAcYX+So
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVDQlJaSllVcWo4ZEQxSXpHVEdiaE5HUWFUL1BmSkVUTG5ZR0VVUEpaZjFG?=
 =?utf-8?B?R1Yra2JpR3hHTUpTZ1B3ODBGeTUybGZCZGQrTEk3Tkh6M0tlbWpPS0k1b1lE?=
 =?utf-8?B?TFUwcXdySEo3V3dqaDVERXFyZWx5cGRoVnJaU28rNWRheUNrdER6cWVURy9I?=
 =?utf-8?B?RmROUk0rQi95dThtaFNldzFFdmxVNlBFeEtxY3YvRGx6YzRpRGJaQ09OMUFR?=
 =?utf-8?B?RDJja1NPaXBpQVhOT2NIdERURUZIbUoyUnQ2ZW53VElZbGtwc25ZOVVaR1I0?=
 =?utf-8?B?cDBYZitnQWFYWmRNZFU3eit5ZWhuNG1TUUdpSVBWcmM4REZjL21Pc2hCdjM3?=
 =?utf-8?B?b2R3dGxWWGIyckF0NUZXS1NMeE83L2hFNTg0K1lOUXVtZHlDTEd0cUU5Q0lw?=
 =?utf-8?B?VmN1MHJzVitTN3BMRFkwbmwzeE1HZ3ZvUUdRenNuTnNrbi9kMDNvcHFrTkVP?=
 =?utf-8?B?NTNBbUFkMll1ZmY5ZWU0NUcyT2VRcU05cHAzTExpSXoxQUZlQUtKb3QwbTFL?=
 =?utf-8?B?ekwwM2I0a3RNdGgzS2MrbGc1bEszVEhJNEpKRUl2SVV2aTRmbGs0MVBpSVIx?=
 =?utf-8?B?b3BqandsblV3QzhsQWRSeUtXZkpmWWpqZksrc0hUMFQxMDdseUw5V1BHYUln?=
 =?utf-8?B?SVlPQVdKM1B4dGMzcVlKZ0tTWU43N3h0TDZmLzFaU1dqOGhtTm5lRXVOb1VF?=
 =?utf-8?B?dUVpcHU1MnE3cXdFRGZyM0NJdEF1OXdqSisrM2dwdEJJb0NKQ2VGZFFubzha?=
 =?utf-8?B?MEd4Mll2NWE1S0N0Y1RJL1FHZmUvWFlNbDdxOTFLSXdQa0c4Sks3T2xzZ0xY?=
 =?utf-8?B?WXRvUDlJMWRSMk1sR1BwYUxQcHV4KzFDSi9FQms3aEQvdU1xRjAvY1c1M2lw?=
 =?utf-8?B?cTRVdGs0ckZDK1FCTlY4NGJ3UGNCbW1lREN6M0Y1U0tVbGx3T1Nzc0FWWlhs?=
 =?utf-8?B?MXIreDdHa3dadzRLM1BMb2FLV2h1Q2tnUHpkbS9uaUlsVCsyVDU5MnBiWjEv?=
 =?utf-8?B?TEJEbVJnb3AvaG9xa0txNG9HQU52c3RLYTRoeG9nUnN5SXYyTjBQZXI0TTlF?=
 =?utf-8?B?RHlNNXBIdEovbmNIME91Ni9FTTZRWkMvSG1oM2VWTG81a0U4N2xFdnZKQy9Y?=
 =?utf-8?B?ZTY1QVJINHI4UE1Db1RCNlBTOURSaVNHaDd0WnFzbUo5d0hjNkJQQzloQzJh?=
 =?utf-8?B?elVKWWpzRWR1c3lTVjBycGFtZ2NXU2w4S2IwYll1RUZFa1daUkg0RHdTdjhp?=
 =?utf-8?B?ODRzNi9jS0hCbnNFc2J6STJxVktQTS80WkVlTm5ORUtWbys1N01FeFJsWUZh?=
 =?utf-8?B?NStZSWd5SkNNMnc3RmpGQlVuSjZnYTdOQXZJSXNDQ0d4S2tHamRwaEZQc0Fi?=
 =?utf-8?B?SExzbktCblpSM1QxUXNZT0JkZVlyTkxzejJwNmdwRituUDlybTMvdnNPRG9m?=
 =?utf-8?B?TXJVZmVBakxHZVNubGV3SkI4U21IQ2FueWxycUNJUEdxaSt6NFoxeGtzdk8x?=
 =?utf-8?B?bzdGZEc1VDlIa0ZiM1ZqMDV5dm0xbEJvRlY5ellXN2sxUlh0MUorVDdNdlY4?=
 =?utf-8?B?ZlczZDJ3cXFicXllaS80RDBacjI1Y1dGZ3lYV29JdGNJbDV6ci9OWGpsMW5M?=
 =?utf-8?B?c3BxVGMzZElBbDZLOHZXR3VldXdrTFZ2QS9XWm9ncnlucmQvOG9IVGU3eisv?=
 =?utf-8?B?RFZFWTVGSHNkdXg4OW43VTNFdEkyVEVXaUhBWkVBTS9SaCtlamZrdUNlK3dZ?=
 =?utf-8?B?dytFTmtTcVozSGY0bm9HKzExRDd3OURpZUJBTnBmZm5sbWRzL2xDaHNidHZ5?=
 =?utf-8?B?Y0lvR1d6TjZFRklJZDlwYWEzS3FOUjNIcGVHSjhVVHlxUTU3Mml3U3BBL2JF?=
 =?utf-8?B?SG5qVXBJS3NoQ2lyNDJtb3VXUEloWEwzZld4WmNFdVFJVndTZzZwTXBxVXVk?=
 =?utf-8?B?K3h3bVN5V0lHK0l4ay9IK3hJbFFWcWlSeTFoc3hFL3JxSUJsb1hSVEtrNDFX?=
 =?utf-8?B?RTdBc2wxWXdMN1BZVGxiR3BMT0dVTkV0SkJJMkRYK0lHNmY5Sm1jVzJUU3cv?=
 =?utf-8?B?YVFBa0Zjb0ZLMjZGaDYxb3h3WlR5QzRybTU2MTNOU3Jkd2dDaEUrZnhqQjha?=
 =?utf-8?B?bUp4WHRldEVpZjRNWThVNWo3Qjd4dVpkcVJZWDRzaFV4bmpkbDdxUlU0ZDha?=
 =?utf-8?B?N3FmcnE1YVdCMEY3aHU2UW14U1B0TkNOUndpU3l0bXpqcWdxTXFUMm1PalFE?=
 =?utf-8?B?ekZ4VHdUbGFleGVmWkJRQ2JncFZqRThucTZNTGxlOFl3d3ZFZTZLd3FYT2pi?=
 =?utf-8?B?M0VoazRkdmkxY3JIVTUzem5GT2JHSFBUWE5VUHFub1ducTYybHEyUT09?=
X-Exchange-RoutingPolicyChecked: Bq/WSlo0IvA+QMZ6OLfumgU+fj7cbXgRdoU5yYxSkFSc+5EiHFZqjXGP5+HfKuSORgx5vCcWG76Zl/U0Lc3XSWXYaKYqex+CM6ZdjTwM0BwetMiZJkZZcVahUaC20+MMYZGrZ/73CAoOnbdX5bcaU7O7lUaSsu0nBA/oLQdEIoAHQADPyRsMRItA4TTIjBx5Ab5sDK+Q584sJAdxzrrNUvwAeXWUZjbETgKgDfsvdrp4MMAvrs91Wv7qPgnfS/08O77lo84vMP9qVU3/4eRk85lpmsseldl5CFXUlh1V/4jamdFx8pL5+o+c7txa+Tsp1zxHB/hZrqX3DfY1t70UXg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3GzHvfKyWuBibZ28vpuFCSYGuoKk2JiuyHK32KzLwmv8OsHO2F5qYWJIDDrqv/SK7EKXi23MHmPX4LhNjQ/F65/KvUORu3hxw2tuKPJjBnOE1B8C1H2ilZJjb2YOAHVClsrUmHjxkdUxyNtmrt15/yhztqJNp35TurBxA/Bno05duMZXkLlDst3a73pfEEVDXA2sD2f5NzSb9DwAIjJk4X4z8OEng1xAsPKclAZ5cVtmPELU6anZYioFqV8SyZ8PH9W2lIlM1YLwvTf6a54Q5WldcNF1hObwI6zkqUlBMlCxCxooLlt/LBWMMYEJF+4k9QALBxAGxAXlC/CG4yiqmPz9IQWXKN/WaQo09fd7a9sq9uubOftA+BFlTTMhxFoVINOw5LqSRBkkLL8SPQ6gSa/vvjjLj91zV5VVJ2+skyyMzvXJ1nJf2UUeMfCDKzLRN2vNcAl22m+7Fb6fIjPMoRgEcBTCRmko+AwcIxZ4XZo44NeQmLUUj1F8hRkQVKx/9rBbX/qOlJtYEtQStshMKF+/jbW5EXYxuXtEIvIil12jgNaJEBDz9JgY1NVnYNQZR+ZbAGe9WDVFm+uCNdXuduCjf+8ooV94ulpjjP5N4hQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d9e75d-5ef6-4aa0-d2df-08deb25cc9aa
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:34:32.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDfokAHmiJsSGsxP3DCifIGiH5pSQg/9DBJZFBumwYizvOR4SIi/oATHDw8kexvo/XzfhQdk/5GlcOXMPKzoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=802 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605150086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA4NSBTYWx0ZWRfXxwwNUs62nXVz
 tgX7nuf9H9ep1QEkBUrVjA6V27w+2XiXgtlq48qFXcKxZ+kn3B7HWEqFO+7V/O/ALFCj0gFnnKG
 qNQvWYwqjLKVu19SwPDA15S2SmVw+t1E2/mMoRdkRCJFTSFkSWKtbqz+cCad+UxrKsNZhOuGc77
 gOm/GAUGjaus17Tl7ikLajE+oznqGv8OALi9UYMfX+P/aZt9/ht1TWRi3nKEY50rHUkrx7tuqyT
 81m25oLD2wGz1B0gE+STuhRu3jhWK/kU3MTeP+XIYdYQzAzLVKfePV8imMiz5h8LZ/cCvRFKvNW
 ZDiVy5Lenr4kBhPAwDH15mIyiMV2ZWi0YxSNM9rtJCb1o/71UXUVaqzEISuHftLBd+JM+qHQcSP
 8BTEx7P7vKNrOw5oq7T8M5hj+YQVVSPJums9vn71RPHIr01l+XZQal28sjC+gXTU/ljBJluXRQ5
 2mvHdOJePeHUwlgH67Aji9yNKDBYYQjMpwS0FQf4=
X-Authority-Analysis: v=2.4 cv=T9W8ifKQ c=1 sm=1 tr=0 ts=6a06daab b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=_c2UK31mSg8a9mq1D08A:9
 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-GUID: ODet0cekEnX3sojkJ_jVdmamI8-Jkyga
X-Proofpoint-ORIG-GUID: ODet0cekEnX3sojkJ_jVdmamI8-Jkyga
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_013504_342539_F4843C0F 
X-CRM114-Status: GOOD (  12.88  )
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

On 15/05/2026 05:45, Christoph Hellwig wrote:
> On Wed, May 13, 2026 at 09:50:30AM +0000, John Garry wrote:
>> Use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE instead of
>> DEFINE_SYSFS_GROUP_VISIBLE, which means that we can drop
>> multipath_sysfs_attr_visible().
>>
>> Incidentally, multipath_sysfs_attr_visible() should have returned a
>> umode_t.
> 
> Looks ok, although all the magic symbol name concatenation in the
> sysfs code drives me a bit crazy.

yeah, lots of #/## from those sysfs helpers

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by?

cheers

