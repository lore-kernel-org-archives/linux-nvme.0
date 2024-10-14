Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFACD18139
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5uoOkFd1wQrJPoA0C+suSdJ1FFS3rZLzjDQuChnkbg=; b=IWh4ZVM5bVUWMpNDMyKFohhjoV
	IWymraV0c8KThOiREMVuAeEV5A5e9NsScs3JMS+Q4AEPoGPWdqmccB/tPLstrviNEbaMFO+uINFED
	AGYCfxgZ+nzcetkIV+alOTeCOXwQo8Uf2Q0u1hTC5PkTw+OTRSxuoeKd0LbKtgIschBsO6BilxSPC
	/vJagIVVtWzdqcDdtN/6qrtdT0OlC5TsyXejARBJSx3h8Cwi/ChuwgKlfeMoxij/n25NYlvlTDxcv
	efZWIueV3Pvx6q5G5mToHy5PhT1zbMeZ8SdPl0ukRYvQbfotAQiffDz6o3WMaALDtBHru7lUu0yJo
	5JKk/+4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0P8J-000000065PW-002Q;
	Mon, 14 Oct 2024 17:45:27 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0O28-00000005sdO-1cVg
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 16:35:02 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfitC027182;
	Mon, 14 Oct 2024 16:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x5uoOkFd1wQrJPoA0C+suSdJ1FFS3rZLzjDQuChnkbg=; b=
	a2H9IVCFfaMIYp7+umGwnxr6KzWZLWs5XI295OdZti4d6gMzqyGl2jDPhX0U3+6f
	quIrNj4pKJaPbRy4ohKZSnaE9Oym78n1LGSbhVNUwtJcrvgPmgSrZ72jSN7OXFfD
	vltLq5a3e6FqdAqWoxjtLPkzP9pjscawU21flmLTChqk7sNRjPYpnNe9J0qasKao
	f2p1I8mJkM/pX7+G7aR/K6r/5eO6PunoGEOtn5VrQOECGfGjWHYc9qQ/AM4mI6fV
	yE+SvJf0Z/IIHffQ5c/dgiYQkXyH4fJgM8VBoFQGMq4P3cbPqoZRoemltKK6XB+u
	mTKW3KAy+lH9GlPFm6+OwA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqsxrc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:34:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFibfV027339;
	Mon, 14 Oct 2024 16:34:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjctr75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqsU0YNrkIsYZRNzJVSnBTKZypsFWWyUiqWJ5i7LkcUmhoRqjJoUS0j8oDajs1xloA4j6bneGRlwgUnElpRj0fxsKIc5fVqxEHGhGf3qQ5/c87N6rjJwalscZ/JHjdDZVUC6kludrrJo6MQfNVDXcxGC1FwR3Jc1bMDq0V2P9BweLvCaFoSGuJ2IblZEVLKiU/IO/73pWrRkCNI8w0m0WKZsQD8Mxubnl4NrpIAMd8ZPORzpfDE0bguZciwa8j+qMXGIu61P3TKDFDR1mbmaO17Fmx7z3EE89TVIWJvd/oFmoMFO3WNvX5HOS0sLM7z5vZVb01oSgsWTVQFt8Gg7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5uoOkFd1wQrJPoA0C+suSdJ1FFS3rZLzjDQuChnkbg=;
 b=DZ2eZWu4z2Z6YLzgHAaOrxPoJJwbPcQ+CX+nqnXmZrKeoL0tdwUpytwdDBLt1cW6WgbcdDtVyVkGnF475axRpHORvKWtjrffktDQ7xk4tdsr6r4erbsh+D/8dBOITkoayjjrhYYEICTQPLAbGaTV7A36M2T9Qvyg/kwSGhT+AjulaBtpz8NP0BDx97MX5h531v0HFrcFWwkjLdesZaN/WrXV7xgd1iFZ97a5bPGuP1wi3HfvJs5Nw+kZ2PX/GRAMnw1/I3S/5dOxU9/4wv0vjRic+IWIzTnBG8c06PWk+GXfsaDg0Zz8/nRJA4tO0sD8/JXBJXaG+uCJL4E/s9dX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5uoOkFd1wQrJPoA0C+suSdJ1FFS3rZLzjDQuChnkbg=;
 b=m3sp31rl+lgUat5RB8dWjB/o5pm32m0odrvxmPWRY6tBydQ/3LvOOupabzwwTQeGcxsZrNT+2Uiv2QFylHc9rVEh82VnNN4jVEZo/oL6yRhJ9xqq5d3BCDxrbPkwWGOkgs+KksOe5NlphCfMQAML/Rzt0jIeGVBkpWdTKngOSIA=
Received: from SJ0PR10MB6430.namprd10.prod.outlook.com (2603:10b6:a03:486::20)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 16:34:37 +0000
Received: from SJ0PR10MB6430.namprd10.prod.outlook.com
 ([fe80::e879:90c:8ea8:63a9]) by SJ0PR10MB6430.namprd10.prod.outlook.com
 ([fe80::e879:90c:8ea8:63a9%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:34:37 +0000
Message-ID: <7c75a9e6-777b-4bd7-b825-75cd3b792f17@oracle.com>
Date: Mon, 14 Oct 2024 09:34:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] NVMe hotplug bug in kernel 5.15 with
 CONFIG_INTEL_IOMMU disabled
To: Artur Piechocki <artur.piechocki@open-e.com>
Cc: linux-nvme@lists.infradead.org
References: <2ea8ff1a-dcd6-4829-a096-63fa30d92b04@open-e.com>
 <61fbb21b-c0cb-4267-9275-d4a94ff89179@oracle.com>
 <b5601674-5a26-448f-bb56-a1704e927d2c@open-e.com>
Content-Language: en-US
From: dongli.zhang@oracle.com
In-Reply-To: <b5601674-5a26-448f-bb56-a1704e927d2c@open-e.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To SJ0PR10MB6430.namprd10.prod.outlook.com
 (2603:10b6:a03:486::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB6430:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bbb9f4-67a5-4dba-433f-08dcec6e17d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFZnR2pqVzZxUW9xTE1aR0VCZmcxczlkNXltME45VVMwbFFrMlJUSXgvblgz?=
 =?utf-8?B?UEdXRW5MQ1FqR0xLT1VTR1d4WU1kNW5YTGlzYnRHV3AvSFNSaUIvT1RoTHlL?=
 =?utf-8?B?MjhRSGFjOGE0c2lIWUlFQVR3TlVscWlCTWgrYWRvamordURuWit5SHBjSHBw?=
 =?utf-8?B?d3lGWVhCYkp1SW5VZlFQK3QvTjQxNk9UR0RiNVV0SzlIRnByQVBBWURHTUp3?=
 =?utf-8?B?L0dmcThZSmNwUGtFOHdNYUpYODBockVkdXppLzQxSlVDb1N0aHAyZExobUpL?=
 =?utf-8?B?VGwyZHVrNXlFYU1KK0FSbTRIcU1uT09EZEV5dXFTSHRYNGpUZWZBZkNRZGpp?=
 =?utf-8?B?OWhPa0Vzckc2N2toWHVRTjBtZVF6YUtoWXZJamwwWWJHRUR2ZUFPWXhQSjIz?=
 =?utf-8?B?V0oyR3VNUFVqbGJ3VFloazZEUXZaUnJmcDZTWjNmeXpicGVxeEw2WWJ6R1pU?=
 =?utf-8?B?ZkR0OTgzbzZNNFY2NFRWeDV1ZUVucjBsN3FRNkxjc2Fsb1A3RGtPWlNScCtF?=
 =?utf-8?B?SEkrTHZOeCtsQ2prL3Q2bzJKUWRiRkdYN1R5VzIyVGtjOHFyRldwZ1o1MmNt?=
 =?utf-8?B?MFRyR1lyODJmVnVVdkJzdVFrbitQU2hGK1JTS2hoT0dIcTVtN3VKb1BZazcz?=
 =?utf-8?B?VDVnSzkxMVpWblp4d2VUNjMvU0FMQm9YbUExWnBvb0ZLc1N3NWN4aW96clZX?=
 =?utf-8?B?S2FkSHk0NEFQUlBLOXd3Q1UrUUtYUUxGYzc0c0pIQTVXRS9BWU0zTjArL05z?=
 =?utf-8?B?cXpJRUx4VFpDT0dzOTEvWUUwSnY2WTRvdzZGNTFxMU9uZVNOeEduK0JueUxB?=
 =?utf-8?B?d242aHJhd3ZkcmJ5d1FzSlNRUTZvNmhKOG1UaTllWFJxV2V2Qy9KalBxMXl6?=
 =?utf-8?B?eGFpMjVPa0ZZcENtSStZYkF3c2xZNVdla0t3SGZKUDlFZCtENTN5MTJsYjN3?=
 =?utf-8?B?ZStWYUxhSGlCL1lLd0Q1VXpjVExWbG1VM2lhZ085NmhYT3FEQUxISmZLeG41?=
 =?utf-8?B?dHoyemtRNnJYb2VPd01sV0grNytzdWM2S283dHBORkdGZGpWSzlOSHR4V0FE?=
 =?utf-8?B?S2lOMW9FSEtYekFpSUJPcjEzQm5MS0Y0UmM1dE1QMVlaVXRlS01TTFllZkta?=
 =?utf-8?B?d3Zxck94RDNVVHNWVlhJODRSb1VJM3RRKzE2N1VGbHNBVUEwa3VtcUtaV1Zt?=
 =?utf-8?B?VWhDVXQ2Z2kvMmJwU1Z2YjQ2U3BWNU1selQvUndacFZnUlhtaDVUY3pEM0RO?=
 =?utf-8?B?cTNhdWk2TldUOGQ2WGNFL3Y0Z2FqOW1MdCt1MU9zbXdSR1ZBanQvb1hnNUdT?=
 =?utf-8?B?czFZQWp4VlVKaEhYd2ErK252RlBDNnpjUy9aRE5abkdkeDUwZTNPOTJsU0V3?=
 =?utf-8?B?Y1pOcUJheWxidTVRaGVhVDh6bkY0ajY0UTFOL1AzblBHcE1JM3FUbFN0YnAr?=
 =?utf-8?B?ZzcrblZ0eURRb0w0UlllV1NoaVVIU2RCUWtwUmt1UVFURVQ3N29IeGsxR05U?=
 =?utf-8?B?elVQd1hJMjBwZ3BDR1ZRQ2lXM09GMW1YQkhwWjZMK3pwZnJ1ZWRIVmtSM3Nk?=
 =?utf-8?B?UDNFSXRjdzBrTFNqczVuaWVqTUVibWQxL1B3VjYyN0VDOVo0aTJhaXdza29N?=
 =?utf-8?B?dmRGaytoTkhCTjZZRFNQaXZqQnJVSHd2ZzJqdnlFU3lNS2RXMTJhS29iaFJ0?=
 =?utf-8?B?YStXbmN1M3dHejdnd0ZLcWN6NGtNZHdWWmdEaG90S2E4ZzYydWVoRjN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB6430.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGMxQ1cwTFZkUGxrRUdtVUcyc1gyM1ppVVNDVFhZcDF5QnAzQ3lBdlBDemlV?=
 =?utf-8?B?QmZwSE9YRThlc0FoVDdSbEZzeXQyM2NTc3JvQnZFK0hOMytEcVJGZXdkTmxF?=
 =?utf-8?B?U2VDS0xkUm9SRW84OTgrWURSM3FzT3dleUgxM0Z5K0ttT3hub0FFdmsyb2Zs?=
 =?utf-8?B?THFzcDlWdEhDbllJeEJ4aGtzS3dnWFY0NitvTy91MFo0Q3hyV0hJN3g0MWJl?=
 =?utf-8?B?SlRHOHMrc2VWUjUvcWhkeDBsY0p3eE1qbnpPU082b2JDYUdBYWFMS3BmWUFs?=
 =?utf-8?B?WXZoaEpPQ2NybXR1NDhuaUFKRlpwNkpNZ29rY0Q3WXgwNXVsRExlMUFFM0dR?=
 =?utf-8?B?ZWtwOFIzV2ZBcFBWWks1aE5YemIvOEhsRHBwT0F2NkcrT0l5SnczSURkMFFT?=
 =?utf-8?B?THQ2dkJwcTJtanJXeFR5NVJZUnk0YjF0Zkh2aWszQWdHZ0ZieCtTNzd1NFd4?=
 =?utf-8?B?YmszWnZmNlpZRHl5eHBIR3QvQnhhaFVEOWRCN1dFWmRzdnpUM0dTRnc0am1r?=
 =?utf-8?B?MWxBOHh4Mkg0czVrVmtiWEJ3c3RNcW9tNTNjcGxQRWdYaUtBTVFoOFN4TDhp?=
 =?utf-8?B?S2NacGNwbHlvSStzTGFBaXlEZXVJSVR6OGFkcW1GMXJ4cDBKcVlaeWloR0ND?=
 =?utf-8?B?Z2REeU5OZENMWjdpM3Rxak1PYXhHRi9FYmkzS3UxM3ZxWlRMUmZsdWVXS0Fq?=
 =?utf-8?B?Yitxd084UWl1QndTR3pqZmJLblhyNkREeHMvend1ZUxPWVJ2ZUZKMXZTa01I?=
 =?utf-8?B?NUtZVjg1bE5Zbm1KNVF0UmNOVlhuTmUyb0FpekVISjY2cjNQUXFZYkpSN0x0?=
 =?utf-8?B?R05FejRtYWhmQWFab2RDK2lLWGxpdG9CeXFiV2M4SFYwTmduR0tvdDl2U3VE?=
 =?utf-8?B?U2tXb20rdzZhaEd0djNJOTFPMVMxZkVNTGd1d1ptNEhEdFJpcmxDY2wxekJq?=
 =?utf-8?B?a0Zhajg2cGlLYWNhT05UTjVIdDkzQ2p3YktMaklQOWk4YWhqeXBHQkhDTDJE?=
 =?utf-8?B?U202dUNNdGlpM2p6M0JCdEp4Q1k2NFVHSFRBTkswYXB5RkllTmQvd1FROVBK?=
 =?utf-8?B?Yks0UmZUSzFhUHNJSkJCZWluelFTa3BUZFNUcjdpNm53MW1UNERvb1ozMlo4?=
 =?utf-8?B?NGxYc2lSc0N3SHdtd2F6a0dnYmtQN25xY0wvblZmbDdtZTBmQnNYMkpLV1cy?=
 =?utf-8?B?SFphMG5yYW1zWkNWSTdhUVhTT0JITnJUbFhZOG1RNXNhdXVJTWlDeFBLNTN4?=
 =?utf-8?B?ZVhmajZSWEZ6VVQveitzNTJSY0x5M2d0cmNSUkx4ZFdtTSs0Q0x5a1JMMjlJ?=
 =?utf-8?B?U2NwYVhkeGF4OVhUaFVGazBmU0lQNUZVOUh2YnkvQXBtdkRMVE9hQ2xId1Ey?=
 =?utf-8?B?NS9QRHlMTVNLSFJxWkRYMjU1T0xDV2t3bndiQTgzYjVkamJxQyt6S1cyZzJt?=
 =?utf-8?B?RlBYWXNSZVpxYW1jK2M3R1A1UDNVenNTK2hXQkMrUlduZEZYL3lTU0JNaUlV?=
 =?utf-8?B?b0tGaU1WbDRUd0hBeCtJdnB2bm8xQWd2NW5Vbm1QZlczbzZlNGpCTzd4anl3?=
 =?utf-8?B?Q1VGN2doeWVUaW1zZ3BROGNjdER3Zkk1cCtjMmpzY25EVnVEeWJCcDRITzJL?=
 =?utf-8?B?am5PVThTZkxhV1lCYlNOTlRJWXNaZ1U4UlI2Nkh4WDBlS0dCV3VOdUxzaERH?=
 =?utf-8?B?K1pXWmVOWlp3N3E1amdMdW44UDdydGV6N2ptWWF2Y2RvSm1nTFNJM0dJdlBL?=
 =?utf-8?B?L1ZYdTk5bUlQb3hSd0dzU28xNlY0N3I4Vk1Jd3VtWExPbVR6WHVIeHpRMnp0?=
 =?utf-8?B?MmlPalQySFg2UGpIalVuTDE2T2NHa1FDZHFVNFk3K3M5TVdXd205SWw1ZUV6?=
 =?utf-8?B?bTJsOTloTXRObnBHTGljTmo3WmFSVTJnd21qVjZ3SXA3bmNGYkRUaFlqclpr?=
 =?utf-8?B?THJpYm9UR0FnaHZLL0dNM0F2SWkvNGhlalg4SzBCQnlxUUprcDZtZEtXVENp?=
 =?utf-8?B?aDF3SkRNVzh2cVhKaG10ZjFJYldmbTV1c2xPeW0zK21sellaR3VHdXBNQUEr?=
 =?utf-8?B?OTZpNTdnTFFEQ3V0ODh3Tk9tWGczUERXR0lwdEE4UlVZUGRlc3c0K3BLZGlj?=
 =?utf-8?Q?m94pnXjrmPHacagYPC2Cgx5Yk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KQx4+auHS2XQC2mDF7TLspeibSM6FlwwsMB0cL1lGAqfLd7YRSijxXXUMJGafCtIFvAeO2aKqSaPNP/MuSjbv5y8CI4dM0K7ceOCOYTYUX5dO9Z/TJA+WgaHZiG+n7ZFYliMZhKNwMIMWDyPytL9UEMPA30zUpyaFWeB5fhTSMY+0aTUWHnhv6hguhON+75VRci2XQAWWBnIp89fK+6NucfkVM7JCt27h4FW9WQmjEKQxQZmn7ZbcM8nmnzytBoJxPdj8OJrHD7ve/GpaKWx3QSlKnwOgK/D+3gx+aFs3KffsI4i1iZ9VDtQeRX54ZTf5lKiDGJRJ7h4OsWcIcnjOVa9lwYeBwfJpfEpwdCTmBZZQaELgliEfWGRI7Nt5oNfUFLt5dHBDQVCjAwDsp5UsThoHBwc6pw/yGb4iWpR8hIEtpjYbF3ElST/snHVmRV4W5V1Xftzh8zsU64+zwgoH+kh6fygnWCrN0DxdaLInLB0EFYNA1FUNK+3A390Gtt8oFlnkytUidkj0sTa/HTJF8dAAmm3eVr2flbEeGI32mLSvpPtZB6bTdA0S8q4wqPeKk0n71JmuwHbbwFku6iuGYw6x2lvK5z6U4411ur2ohA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bbb9f4-67a5-4dba-433f-08dcec6e17d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB6430.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:34:37.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +z1aw8U8Gvjaf500DlslgoBEJGiXlYapESzShlEKt03cV2TjfG+akV8K6xH0W3ItfcEmEX7P5a3sVxa3sIUZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140120
X-Proofpoint-GUID: OTfJ5puwGAa2Z1D6y-vRYj-Uh4R5pOWm
X-Proofpoint-ORIG-GUID: OTfJ5puwGAa2Z1D6y-vRYj-Uh4R5pOWm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_093500_594287_F4D58B53 
X-CRM114-Status: GOOD (  22.48  )
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

Hi Artur,

On 10/13/24 11:49 PM, Artur Piechocki wrote:
> 
>> Hi Artur,
>>
>> On 7/8/24 1:26 AM, Artur Piechocki wrote:
>>> Hi,
>>>
>>> I am experiencing a repeatable (potential deadlock) issue when
>>> hotplugging NVMe devices on kernel 5.15. The problem occurs on a Ubuntu
>>> 22.04.4 server environment when Intel IOMMU support is disabled in the
>>> kernel configuration (CONFIG_INTEL_IOMMU is not set). This issue is also
>>> reproducible on the native kernel 5.15.161 without any Ubuntu patches.
>>>
>>> System Information:
>>>
>>>      Distribution: Ubuntu 22.04.4 server
>>>      Kernel Version: Ubuntu 5.15.152 (also repeated on native 5.15.161)
>>>      Hardware: NVME Micron SSDPE2KX020T8, Intel(R) Xeon(R) Gold 5222
>>>
>>> Description of the Issue:
>>> When hotplugging an NVMe device, the system experiences a potential
>> Only for the sake of curiosity, may I have what does NVMe hotplug indicate?
>>
>> According to the log, the server is a baremetal, not VM (QEMU/KVM).
>>
>> Jul  5 09:49:11 tarox1 kernel: [    0.374071] Booting paravirtualized kernel on
>> bare hardware
> 
> This could be due to the fact that the Ubuntu kernel has built-in
> support for paravirtualization, but it doesn't necessarily have to use
> it when the system is booted directly on bare hardware.
> 
>>
>> Is there any method to hotplug NVMe to a running baremetal server?
> 
> The hotplug event occurred through the physical removal and reinsertion
> of drives in an NVMe JBOD chassis that supports hotplug functionality,
> though I’m not sure if you're asking about a different aspect of the
> process?

Thank you very much! I never know we may do hotplug like that.

Usually I use QEMU/KVM to hotplug the NVMe emulated/VFIO devices.

Dongli Zhang

> 
> Additionally, the deadlock does not occur on kernel 6.1. However, I
> would like to point out that kernel 5.15 is a long-term support (LTS)
> kernel, and the issue still persists on that version.
> 
>>
>> Thank you very much!
>>
>> Dongli Zhang
> 


