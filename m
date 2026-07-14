Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB8BC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f09tq0yW8lKaVEyHycKz9O3X+YIKwt3inUZZFLpb5NI=; b=FnmrlhiXMWYcDsiRb93Fj3BW7w
	fjVJnA6PggeaeD/bAzaalQM6cF+MAKiqkh1mAqBtQ5mhCFi2Ikmtw2SsQpg3yTygpq32S665ZONhf
	xLoOm3kfIIc6Gvo3FvgUpBf++GD1c1kZQtfhypGZxifxIjGalILp3xO28+76ixtqnOYaUqFZwF71i
	XNLFBbsSZFKvR0sLR2cPu18qKflHtnmKwLYMCCJg8UXRGIxj+XLuxKXykiep0hfdMrPFQ9gl2kG5z
	UCAXp0ULNfsZEBUPVQFCe1rndQcDLpHgu/z6bHNwBUcxVn9D5Du1vuhPFGyrc8zxbCN/c4wqYj5FT
	zMmsSNGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjYMA-0000000BHTo-0CYN;
	Tue, 14 Jul 2026 08:19:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjYM7-0000000BHSp-0Hz9
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 08:19:08 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLESDg1396354;
	Tue, 14 Jul 2026 08:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f09tq0yW8lKaVEyHycKz9O3X+YIKwt3inUZZFLpb5NI=; b=
	iro9MMSHvXmxxUGPXOj+HZQnhfdrk2wiC72uidnRqPervuYT51U/evqAgN/qXEn7
	i1fHIaMUezzxU2gQkinyXwjSjbpT2K0RIKfL6RliWc1qduE7FkCra0tBxN6efoY1
	ZYgkWFCabVG0GX6DylWz5urD8bscbK25p5/aFtx6pfd7vctIVaY9vjvfeTbYYNEP
	bODUEIbqVZGqFevNEOjKOjk5zCss37hlNh+j5dxRezWxaUrOC1Xhxlorlia2zdGS
	bad0TFyVAnT0jD0raMZz2CDIfaJfbdFF4Iq37OCYUX1d19cnir0ZnhoQEE7fGldO
	5xV1kO1PEvM0EJBxQIA1SA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0upgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:18:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8IVaE001176;
	Tue, 14 Jul 2026 08:18:46 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qvwau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 08:18:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd0bfIUqqVhI4fD6sc8WsGo4sb7wAHq7u2JNMLsCciXvraCSGMc8Wz5LlF70/mioRq5x/9bghXevToROjRN+VxvHZVlDXNWMdjHKQswKedQoQ1ghcIIo0OZPEg3IJuWLLe4aRBDB1MHZFgz4MkcHA+D1Ey+bNPYYfUvrnV9Xawxq/wxk6EoyZz26eyr50aX8SLT5WfvwCcXF4ndTP417NjJQBuzc09SbxhiXks+ScwuCtrKg2NhPYfe+/2h+wgzL69u9lA1nQ75zFNN0SHtbTnm68lFRjvu9Ftz1+DTfaHPV5oIHn8tPtGM2ubZ1MTqK8dvlBOJ9txrQ1PszTjC9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f09tq0yW8lKaVEyHycKz9O3X+YIKwt3inUZZFLpb5NI=;
 b=KIO1BIu2UPhIAL47OyHX3VvIubLTFllguFu6zLMWg9uEx+YCM1ijWrFs7ldsKoKpof6fHluW7tXvOKiFrJRmvJFv1OEPoeLEvuCu6tNOMMm6pRIpHP5EQFRfRN1uz4U3iIjycg8zgYqhgAE2GewjSx634FyOsyF8MA27kiSBQZAoDVwYKjYAi8vDRQ7ryotm844yCaFyiIJDHbQMnK5GNanyz+DRuhkwoaQvQ7U+fqX2/x2ZjK0VGK28akmmeO7S0KBx6/t3RoEgB2LHeiuqvpCmKqCPA6p9Utn2rwQfZpC/M27QlsdPjFqoMFz/rTGfoNmQFZkprDuGzzhiBgSv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f09tq0yW8lKaVEyHycKz9O3X+YIKwt3inUZZFLpb5NI=;
 b=drp7VSbiLvCSr6VAgNvtUXZvQ6bX9onSLyHVLmkEHCMMOFUraaXfj2SSFbLPZ6LUFqidG40Cw4VmILJ+za2NyFNMel5kDLwvNWxHzvJ6CTnHMsTypTATe3ayf/9xPiKVc4Ndk71NZG4nXnUpEhTTFeiS2EWKekBEq1esDAxtkLg=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 08:18:42 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 08:18:41 +0000
Message-ID: <1be7cde9-e065-4980-ade9-6efc9278c12d@oracle.com>
Date: Tue, 14 Jul 2026 09:18:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify
 Namespace
To: Chao S <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Maurizio Lombardi <mlombard@arkamax.eu>,
        Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
        Weidong Zhu <weizhu@fiu.edu>
References: <20260515185853.2761456-1-coshi036@gmail.com>
 <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
 <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com>
 <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
 <CACd_6n1h6NW3DS1MDKkcr=r-uxGQ=HspMLN6TWtLc26Vct8sYQ@mail.gmail.com>
 <e4650024-1706-46b5-91f8-57f2c358fcd3@oracle.com>
 <CACd_6n2AZvgi1B8Vn8S6NwytDkqHmS=4z-1sxjmk+FPfWv_JMQ@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACd_6n2AZvgi1B8Vn8S6NwytDkqHmS=4z-1sxjmk+FPfWv_JMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba55316-1798-4d2a-54e9-08dee18083c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WyKgQuM1s/LnYweZ/sVO/xVdgBceBoq6NMcwabv2zCsCaA2OPG2oeuqNV3JNwTIBB6cVlMKyP9e4g2hYm5XgsV+UVOaIouQGPFybGn2DluqVSe/hgEWN+g64QPKRP3Wa+anvN/QDkbUHDk7VR6nDKjsdn2BMXG+qFjJr4nKCD+v1+uAo6Ydz3fxsKOzyNtub0SJxABIWyossdSCW8pYaiNb/V/BEjQ6cfEfYEOIS/lH61Sx+eEeRGxMXMbYh2MLWG/WpOo19CmkOwzWRbtpA7oB90TFhGMUQdIsSSWdgP03OVKktHLKX37qYP5kWHxaNfETJP0fpWyInF3Rg1mK2Q0SIiRP+M8Kk+V1lpcs7RtosQV5w2/QhQ6UHcGUjfomtUS95ac6kLzJ5ehNRPqm08T/rjL+DS1zTbgYiYff4mR8Od2WgMAQ95xT7AwXcbtfyQHpK1K3Dsp/08EEzliWiWIU6Q7LAnzxtE7lHyfpcOZrGPyuOrArtU2lWvIuqBZlU/ya8znxtOstFusvgpV3b7cy8Emcvic2gMBYO13BoxIA8m5UnJFQu+BASOagdt1xIb8GbmsEjvYlHQDr1C4h1WpsXOuV6bks4jfwZcPWejra559yYJKcEloyU7kR7XSJ+PJ/AwXEDXdGTseq1Wld0PM3YrjLa/L1wkhgXeAgOmAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJSS2hvekxGZUIybEx2N01xOENwTElJRHc0TTc0N2RoUFlHQlZSUHBhY291?=
 =?utf-8?B?YlVyVDBoaGcraDVKTmpuV1QyOE1veE5uTjJyRHJzaEszU2NmaWQwODNhbXJj?=
 =?utf-8?B?d3o0dGZ1YXE1aDNLRFZmTm5Od3J1b1JhSDR5OFlPcDdGM2Fqa3VZZDc0dTFn?=
 =?utf-8?B?YUY4cHBEVzNKMHMwWm5aSVB5eDR3U2NMczRzbnVHT0VyaENUOE9SSk5pcFVM?=
 =?utf-8?B?b3ZpMWVkMGdzcUt0d0xoTFMyanVOM0RTRjNhUVVsRjRjWUE5dEpUTmI3MkI1?=
 =?utf-8?B?akR1WjJObkV1OUZuK3U0TGRuWGdpcnR3bHYvckJudkpNK3R6S0lNMkRPZmhL?=
 =?utf-8?B?cld6YkEvMFdFOURSMS9Hb3FSdEpGMTNPa1JwZGw2NDdjNmlYR0tMdHJRYlV2?=
 =?utf-8?B?UzBFeGM3RWlqZnZxbFN2L1B1bG9mdnp1WU82a1VzdFAraXVZMnBVck9KUXV6?=
 =?utf-8?B?TXVQbTVUYi9aSzQwaE1lL2RxY2l2NVd0amg3VnorYUFDL2JSM0c4Ymg0WHZ2?=
 =?utf-8?B?OWJZWlZJNXdtNFEzN1BMMEdHU2FsNWphd0toR2pBamVqYm5xaTI1WVpjeERZ?=
 =?utf-8?B?bUozbm1iZmlBaUtwVDZUeC9vaytlcU1KRExXaG5EbmhPN0dJMkkwNE93NUJX?=
 =?utf-8?B?eFBuRHBqRnVDeitrdit0dmlVNWNvcWl0OVFDRXcwUkNqcEEveHVtcU9xNDZm?=
 =?utf-8?B?T2kzb3lpQ1lDOXdJQ29GRVZqYjF6bE9hOElpeU83ZGFkSi9kNnZ6WTRTQmZ6?=
 =?utf-8?B?YTAyN2Q4aWVXRTVmbi9DMlNLNkhVeE1Ka1hqNFRuQWFBbWl1dkNkY1M1Z0JC?=
 =?utf-8?B?OXRuSERnak1LQk9LKytCZFM0RVJQU0xFRVFxcDFoNm1MODhvQzRkRGtVNkJt?=
 =?utf-8?B?Yy9YZUtIN0VraGxSRzRBU3VoR0VvaUhlV2JsamQ2VHlHMDB0MHB1elhaQ01K?=
 =?utf-8?B?SnUyK25BK0EwQTMzeXNaYng1RnVwRzRRejFhNGx2b3JyaDE4c045clptWlZZ?=
 =?utf-8?B?d1BJQ0thZHVNK2x3UnRzbE9ibFM5T2JVK05vcnZhcnFQb1FzTHNUNEcrWUVu?=
 =?utf-8?B?YXJ4Z240Z1dSbkVDZmV0Z3ZnNmtOSGxDZnYrVktzVXFjTllLY1QyRjlrU2lP?=
 =?utf-8?B?QjBLMjcvemlQWU55bjgyNXowaDRueDdGVkdwN1d3M1NGTXpZQVEvN0RHeU1Y?=
 =?utf-8?B?dU8ySituTkROZnc1V05WZG5JeUkwMU1SKzNSOHF4cU8rK3hNdmk3OHZISWVY?=
 =?utf-8?B?NEdqWXBEdnhoRmVMS2oxRmNGMndPZytiMFBvSk5ub05GREZwdWFtallUenlh?=
 =?utf-8?B?YVRnSGx2TFdHQm5pUjJGZkhTdHRPaWV4bnpEcHV4MDNMaWh0RjEwRkppMmk0?=
 =?utf-8?B?N0lxVHdIRlRVSCtMS3Y1TXJUOXBuNnVpWWlBdGlLNC9SSEFaU2M0YzlQZUEz?=
 =?utf-8?B?NnNGekUvUk12Yjg1ZzJjcFhXRlA4eHdrUW5KcW5aSFVwZ0pwTHlicnhDMmxp?=
 =?utf-8?B?MGZKcTdFazRoT3l5a3oxQ1ZHVnhTdndyN2Vuei81S3NpWTFvWk9yaGRxU0FV?=
 =?utf-8?B?QStra3BvemhzTmFBQ2xUVmFWNWd0NGF1cGY1aTJGL3VMU0xaNTBYbnZFM3Nt?=
 =?utf-8?B?Q3pCa1F1VzIzeU9rek80WTBhUkF2WGVnNHo3LzM5QWM3b01TV3RxU3B5emd4?=
 =?utf-8?B?ODdlUy81ZGYyVjVlWDBEdHVIanY0MHo3QVRrYTl5Z3B0OGRCSk43Q3VHMnhP?=
 =?utf-8?B?Z0ZxVFBXbXh5RmhFT1RYU25pam4xSHAreHNEZ2pVczJxY2wvMHU2Z3kwVHFx?=
 =?utf-8?B?RTFGOGFrNzZ2UmMxZ2VYaUMvRERadDI2ZU4wMXh5VTNkT0ZQWjdtSXVHcmpT?=
 =?utf-8?B?NEtIKzVZcGFkSjltd0ljbEF6QjNPSTV5UVlkaUhPTzRFV2lOR2xQblh0c2RB?=
 =?utf-8?B?T1hhMmE5cHZJRlgycWpjYUpveDBmNVoxeEFQaS9ienpoUHprN00vTVZMekR2?=
 =?utf-8?B?YStLQmlOdUFVTEJPMHJkclVwRHlscStybEVRWktzSGJmSm1JWmQ0Uk5lM0U1?=
 =?utf-8?B?enprTHNteHJEOXVRM284OUQ4clNLVExzUHVQdVhBRHM4RVZzbzhqQk1CckVH?=
 =?utf-8?B?QXh1cmdMSFZOVkVTRDZoaHZ0amxNb2VxV1VTdE1aUFRGb0l1NWhPeWpiaVlP?=
 =?utf-8?B?ZGdTTUhYU3RRb2cycTd0Qks2dHRLTS9veCs0TWM1dmw2bnRqYm52WmIxRU43?=
 =?utf-8?B?dU54Ukl3bU9QQ3hmZ01WK1Fja0xKcHMyek1NUDFSYmtFMVRUdkhmNXc4Zm1L?=
 =?utf-8?B?SFhDaU8rbmppb0tVb0VjalVuWkFoRlZxQm4yRk5HUnBGN2R0VndqT1JLcmNK?=
 =?utf-8?Q?y+dDEPKd/CRudNFU=3D?=
X-Exchange-RoutingPolicyChecked: Vlxug18bpuE/8y2bi654jr5y1cD5T1ZZcjX8rRDPkd5fHbw2rGwXfZVXT/Dfay8V0rgA4QEM9OpaKxxK5eTStyfWw/yoUecO2jQserGJvSb8ywEjREovhtQygmVXn/DQwTbyrZXvJIkiU4ZQ7pgMYhOgIZtzguFLUJCpbtpaWYx6WOzhMGyftgg52uuHsAtq2+PsnDxlW9g6h2c3UwDnuW8zsDCk5vRbfdBkdlnWrm3SJVoSr/eByjmhYxCcqfEL/ejxLsbD6levhhVqGhHv/zGW3Znc2btWdV1wj7KTZOsnTP0O5v1klPrNluTncz0hNtKEhL7SMlLPIDM4XmUvLg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CWO6VBg3se4hP+Bft1FSNuOBNLtPP+kJbIdzhRCPflOTsVam9Kv1Q5ue5rxtoM4xTLklhDudp0IbXmkj62EQapRBlnMEW+NSDRfSmUepCILJCzhA+ryziyuoWbcNptR24R0YZ+2CS5wXGpBMK8wS962N8k2WbbiEA5tThwJtqQRY7bSHyjFzUjCc3WkjE5rgfJbphGwPqHaKzaVm/ghCuNAcW2r72mALp3GE2XMFJNUxp1qpOb8H/g/8JsNJT/lK0ECdx30aNIzg32qVC/Svs+8E1rIC8WHeBg2Qlneg3SNpSXf5YgV38rEwlxRaqG1tCYdQwe7lMkMg0B6E6BsX6ga1pzVQljPAI8PVuCCcPS1DGYrYdZBfJYFnE3wtHe0QKbIlZWb14EHkOKhxGUALxabj7y2WSeQ/Mea7zgqxSiVbiooJYcnQwEwuNMBpUNcn8lQ1gJxgWGVJ+DKhFMd9c9c8n6jjY8slI1omSM3xGM7BGnRrtP8f8+r43F9tglv7SihpuiI7kD7Pm5FQC18KbHWnfHN7bIPHxpr25WG6c6+AFtvu1VJ1TEKcp25bnoClQbGLZH9UCwkn7R8lvmUvXGStvptfkaN5rFUclP44ivk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba55316-1798-4d2a-54e9-08dee18083c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:18:41.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntCTbWY0xvECer2VgrXQqvsHztXhgaMeopAkucnPY6+K+LRyjOOs3D5W9oLiJiWf0oT3KNuLxJ5r/Uh7et8FfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140086
X-Proofpoint-GUID: x0H-0vzLLpmtWIo9OymGbWP6bTJVX3fs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4NiBTYWx0ZWRfX28le9jGcj3UE
 +UJ3RUTvcZF5JlR/D6qYh7qvLx0tdzC88M7lfrWawla+MGK+k7VXEbQDSXBuZpt8NzkDD+vJeS3
 JT31Oynz7Nz0y2wySE49FEztBY0e8CYrlNLymzuwtQlZv5tX1cBo
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a55f0e7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=WvBVADTLev54Cb35yisA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4NiBTYWx0ZWRfX2nUHrXB0WFWk
 fy3f8pL6IADMcg3DjXoQUB4nb4JcDVnrMmEDy6gIfNq2QnnnTLlRsIX1CIbCLtKLrfcnrj3GeNw
 m/H6v037AC871aH55/ZdJjWY79qb6NXPJFlJqkETKIqcsnvsBTme7N+0P9KTzZh0NlPWqJKMrPc
 bnJjepcNCTRZl0bVV2FmVF3FSTXWM4vP7UdSmRMY1ffDU07/4bxEYRn2YXfBmoPX809Jd9S3xuO
 QAOWDs/4HW2hbkLmG7WH0+VFLcHAII1rxz3b+3LBiVTcxXfyy2AH0lwUzr+gVtdt5V8zI3JGEJe
 soOZnq1cFGuh3CMY3sz/xtz7lDe0RJ5GAnDK34FeZuZQ/0Yj7yv28jPByredqQshZEKJgkf8h6J
 25KE8YU0GfgmEuyTbIYxDyyAU6G+11CJzAmAvEtzfXofc1K8Fvw53iJJUCOx6bCALBOkAbxpnDc
 /jy7hyMQYI5M496rw9G/FH8u2l3u1nRcRxxIUwwc=
X-Proofpoint-ORIG-GUID: x0H-0vzLLpmtWIo9OymGbWP6bTJVX3fs
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_011907_113860_04DC0AC7 
X-CRM114-Status: GOOD (  20.53  )
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

This response took almost 3 weeks. The previous response took again 
almost 3 weeks. kernel development may be relatively slow moving, but 
it's not that slow. You need to respond much more promptly to keep up 
with current development.

> 
> Here is the concrete change (drivers/nvme/host/core.c,
> nvme_update_ns_info_block()):
> 
>    unsigned int memflags;
>    sector_t capacity;
>    unsigned lbaf;
> + u64 nsze;
>    int ret;
> ...
> - if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> -    check_shl_overflow(le64_to_cpu(id->nsze),
> -       id->lbaf[lbaf].ds - SECTOR_SHIFT,
> -       &capacity)) {
> + /*
> + * check_shl_overflow() also rejects a data size below SECTOR_SHIFT,
> + * as that makes the shift count negative, so no separate lower-bound
> + * test is needed.  Feed nsze through a plain u64 so sparse does not
> + * trip over the __le64 provenance of le64_to_cpu().
> + */
> + nsze = le64_to_cpu(id->nsze);
> + if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
> +       &capacity)) {
>    dev_warn_once(ns->ctrl->device,
>    "invalid LBA data size %u, skipping namespace\n",
>    id->lbaf[lbaf].ds);
>    ret = -ENODEV;
>    goto out;
>    }
> 
> Two things:
> 
> 1. Drops the explicit ds < SECTOR_SHIFT test as redundant --
>     check_shl_overflow() already returns true for the resulting negative
>     shift. I confirmed ds=0 and ds=8 are still rejected without it.
> 
> 2. Routes le64_to_cpu(id->nsze) through a plain u64 local, which is what
>     silences the C=1 warning (sparse loses the __le64 provenance when the
>     value is passed straight into check_shl_overflow()).
> 
> Behavior is otherwise unchanged. Since the original is already in
> v7.2-rc1, I'll send this as a standalone patch on top of mainline
> (Reported-by: you) unless you'd prefer a different form.

My fix is now in mainline 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.2-rc3&id=92f58587a04c94985fd4a9e3575720b054c432bf, 
so any change which you want to make must be on top of that.

> 
> Thanks,
> Chao
> 
> On Wed, Jun 24, 2026 at 9:15 AM John Garry <john.g.garry@oracle.com> wrote:
>>
>> On 23/06/2026 21:37, Chao S wrote:
>>>> BTW, I have thought that check_shl_overflow would catch
>>>> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).
>>> Confirmed -- check_shl_overflow() returns true for the negative shift
>>> that ds < SECTOR_SHIFT produces (_to_shift collapses to 0 and the
>>> _to_shift != _s test fires). I checked ds=0 and ds=8: both are still
>>> rejected with the explicit lower-bound test removed, so it is redundant.
>>>
>>> For the C=1 warning, the minimal fix is to drop that redundant check and
>>> feed nsze through a plain u64 local -- as Keith found, laundering the
>>> le64_to_cpu() result through a non-__le64 type makes the warning go away:
>>>
>>> u64 nsze;
>>> ...
>>> nsze = le64_to_cpu(id->nsze);
>>> if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
>>>         &capacity)) {
>>> dev_warn_once(...);
>>> ret = -ENODEV;
>>> goto out;
>>> }
>>>
>>> This keeps check_shl_overflow() in one tested helper and avoids a
>>> wrapper. John's nvme_valid_ds() works too; if we prefer that, I'd name it
>>> for its actual sense (it returns true on overflow, i.e. invalid), e.g.
>>> nvme_ds_overflows().
>>>
>>> One note: I'd lean toward keeping check_shl_overflow() rather than
>>> open-coding the bound. It folds the lower-bound (negative shift) and the
>>> overflow case into one tested helper, so we don't have to re-derive the
>>> boundary by hand -- e.g. the lower bound is on ds itself, not on the
>>> post-subtract (ds - SECTOR_SHIFT) shift, which I found easy to get
>>> subtly wrong.
>>
>> What exactly is your proposed change (to what is in the tree)?
>>
>>>
>>> Keith, since v3 is already in your tree: do you want an incremental fixup
>>> on top, or a v4 to replace the applied commit? I have both ready.
>>>
>>
>>
>>


