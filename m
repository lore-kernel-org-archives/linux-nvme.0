Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D6D59D7F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rg2vXLxBoM2pIgyyMqXZMKbPytqrJkmW6nwq5thwrcw=; b=ZO+VypcBCU/HrIaJkRsxRJ/G4K
	N9k7AIhKnG/yAgzHrNQSxec0SgV2/nbmfrizShy8idt46fpLd1W7s6+bag9RlsSJJq2RxPd9ryNy8
	l3UQ0I7W5gOUZijyzzoGnMshos4pZhxPCYbw638jaBNx8KWkaQ2vl2SSz6c5B3ZWLsbj8it+QXyIK
	VB5RdnHATVNiWS5w37flv5FdOOSz4xKw527/wH9Y0itf9z0pGVOyapql82L7509TM5N76OQ6Tsw/e
	hGN/pN6jP+/34Z/7YTUm8KTrc3FgLWHWfL7LPHZBuSFSnOiReGjwlIboihRfas7foe7am69HHHkeE
	6YxUqs+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFikv-00000009Jkg-1RFz;
	Mon, 25 Nov 2024 23:44:37 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFiks-00000009JkA-1l5Q
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 23:44:36 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXYCf013531;
	Mon, 25 Nov 2024 23:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Rg2vXLxBoM2pIgyyMqXZMKbPytqrJkmW6nwq5thwrcw=; b=
	jsuKUtk1IV53WVuHNiSZy4BPH04wiEoQA3jOxVxlcdukgBeWMAq+OrlW5CnXRL0x
	xE8S6fuEsogAkCKJv17Upn2oghzMGc41C1V/llMHvD6+CunKW82g06V7XqhG90kI
	/tWC3rPIh0peUcaQTr+aqDdFHJN24wchhV7nsFTW2XHgIpEaXTGkU3J7nNt3ObBj
	Jb9cO7OB6z7gwdZVKbQdFbOeFfxNkRNTHXeUKgOARq7JI2v8XilLzEJzwNPAEB4A
	WvzmNKA1cX8VzWtzUK8gYBv4FrQh4AlQMCNpbR3PuNJVToMCnS0d5MlIM/B9vqkK
	nfghLYBRccsNvlmOLU/Kgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384e4a8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 23:44:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APLw9Y0002641;
	Mon, 25 Nov 2024 23:44:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g8dw51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 23:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTVtcqSj5vaEbVVnDChxqENUTRppx+BdWkX4P/LPMuQFstrlCZdoAe9zPGnaYrW1Xfxq9isD3f0m2TLdRyToPE5i3YzO+Hx+fvAKfzD3XzAmJU/7FsLgW4Q3bhl0I0TaTB4ge9TLwMiyK4JjGnPdc78WiNf1r6P9VC+xR0KYKOZKuiGYdMippn0qFKwTbArrgEzzhCLwN68XCTf/pQG3VnxA4HS6kb855h75M6FYoXl7u7pWf8xMoReVeehgKdYcJfYW3YOj+7rMBMF/tnkMOawC+krT574cTC6zJpJS186rQ/r4eHFuyu0k1t6m1UHPiPsNsICMXzIICQ7AOksrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg2vXLxBoM2pIgyyMqXZMKbPytqrJkmW6nwq5thwrcw=;
 b=taGjNL5vRWkNSJzd1xRlP00OvLcyGrVedn0qBpjln9VWQQcFA/HcAsojpBLa6RpoD3UpwO94OVLbOGpcg6CNrnuAXZZgoJv8cIWqTGmW0818eOH5L/jdZWYArRjTCsygbscrkcD3Kvc/Wzly0VdNOBmPEvYBF6WkkjR0fVmi80gJBDzv1d1XjHay1AH7u4J9+71RBNRq7WHIhr/QtJpWqpBlaCnafI9TOAN4d7wgPA02zKUOxn/ihu5B6VlGILHslCNcnpACda6LOsw2sNoNAQmT3DwFniKMjyes11OQQQXtX+Nf34BAG/avYT66MzWiWE8zPkCdBhZJUqDDyz4UZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg2vXLxBoM2pIgyyMqXZMKbPytqrJkmW6nwq5thwrcw=;
 b=xEFm27i32ZggdQblq9DBV+CLOLgmQRRdZ4cZox6r9SjbwZgHJnSdFuyU03YpghSliLBI7LXq/VWloaBtdPYS/Dzq3LW9L7oHR0aomwaILi5wf8YNsCkko9tvMF5yPZ0LnZhiemKuD17MNvE2i1idt/ZmhOVYlDvzFsdcOxYi/1M=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 23:44:09 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 23:44:09 +0000
Message-ID: <da3a8c0d-67f4-463d-a7ff-6c7581b4ea7a@oracle.com>
Date: Mon, 25 Nov 2024 15:44:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] nvme/039: check for logical block size of
 test device
To: Bryan Gurney <bgurney@redhat.com>, shinichiro.kawasaki@wdc.com,
        linux-nvme@lists.infradead.org
Cc: bvanassche@acm.org
References: <20241125193933.22017-1-bgurney@redhat.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20241125193933.22017-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f271f21-80ac-4f84-a131-08dd0dab0eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEpuUXl1blNyVnF2YnE1UGNRZVE4ZHdkWEJRSVFSQzNpcUQwckp5K01jN3M5?=
 =?utf-8?B?ZzhhOVRMdzZwQVkydjBOWHlrQjZMcjFuYmt3Q2plV1FaMTlSK3BYb2pWQTBB?=
 =?utf-8?B?M29hdi95eVlQODl5ZmVyY045L1pjYmVrTlF0eVlNKzJRWk1uYkxQSXlaQ1Rw?=
 =?utf-8?B?U3RUcDk3Y0JHRElZK3hCWlZyeVlIajMvRGI0QUpuMFNkdzV5bUVyNUdNRTlC?=
 =?utf-8?B?V2NiRFZvVDk2S1NjWlFqcWp2MGo4a1JrN1FobEtrSUZQWGlaTzVYeDZBeGZ6?=
 =?utf-8?B?bE1HR0ZwV2ZlTTMzaTZ0ZkJvWVVIVE0rNmtkaW1vYVV3UkVJWTRRQ2F5Mm92?=
 =?utf-8?B?ekpibVEza0lBVjNrcUVtckgya3dXTFVwa05NSytwL2hCb2ZHMDAwaElJRzFM?=
 =?utf-8?B?S2t3aGpra014c1JYdUJXWmlOU1pycWlKTVduVmEvOEtMdDQ1MDRlUFRiRFFu?=
 =?utf-8?B?S2pZWlVRMldWYmhTUExhMFpBNWc3S0pranA3b1cxV3J6cWpmQnFwTHNOcVBm?=
 =?utf-8?B?a25OaFdzb0VZczh3dW1DUDkwRWRaelVIQzFWM01FbEhKUWtuQWZ1eCtBT253?=
 =?utf-8?B?NXF5NGZwRThCU0YrMnViZEVteUVvcmlFZkN3VVhqVFNubVliVzF2T0E3dlJi?=
 =?utf-8?B?eTdRQWwweTJSOW80Z24zMlRQVlpCUm5xUVdVTTJyeEFHTmFhd1paM0xsT0pD?=
 =?utf-8?B?SGdvd0JGdEtUbDBaaE43M2Jrc0E0WHNMMk4vRksyWXJyS1l3UnJ2NW90VVF5?=
 =?utf-8?B?Q3hlcXBBQUlFZjZORTNBZnUzcE1ydXBMU0svQkhqVElLbTFLSlN2czVpNjk4?=
 =?utf-8?B?SHI1bkxya3pNYTREN1AxNGxteWZETHpib0ttQmdzbElTeUsrV09TOEZjMUo2?=
 =?utf-8?B?QXdtN3NmekhkZHFSWDFMVlZTa2tFMXoxTGF3SnJCME45dFdnaEtkbnlvRmdq?=
 =?utf-8?B?L0dBaGkwb1VlTm0zVzgwekRraEZJUmdZRG5ac0tNQUFEVU53MHY0RS94aUM5?=
 =?utf-8?B?ODF3eVFlRElQYXNWS1BydmNoTzVzdkYrWnh1VkQ1S1V0emE4TnFsbFJINHZE?=
 =?utf-8?B?a2NmYUdyb00wdlFyZE04Yi9TRERpa1R6MFNKR1lNS3dwbTFzcG51czVGVUVD?=
 =?utf-8?B?Y051OER6MnpWbjgxQm5JNXAwN0V2c2xyK0FOTDAza2xNdmVUcHVxWmNNVm5V?=
 =?utf-8?B?T25MZEJWZjJRazNFQWsyKzNESExYUkFVN0VDdjA3RWFlSFFUUytJTWd5YUpz?=
 =?utf-8?B?NVNSd0R2ZkhGclRLd2RuZXd0cVNjTW1hSTNpZ2xZWGhFR2lsK3hST1d2NHVq?=
 =?utf-8?B?Z0xpUkFKdHRNQzV1UHpqdnVJTUVFWlhwMEpIRW8zRnNFNy9aVUFIZkhYZ2pF?=
 =?utf-8?B?aVV6VnN3VkpoMDNuM1ZFNEhpY041djFIS3ZkeXlzRnFPMlk3U2xmR0lwbk5j?=
 =?utf-8?B?YzFVUWZzSE1pOGdtTnF1NVo4ckpwYVRmeklVWDFOWlM0cXB5eGcrRUVHd3B4?=
 =?utf-8?B?RCtSbys5UW1SeDZTVUNIUVNQZ1Zxei9wYTk4cWVlaFJxVTRjNTNyVGlLWUNp?=
 =?utf-8?B?ekhPNENIVzJ4N09ES3FBRnhiOVNYbHlLVEZGWkdlQ0VoWHc2K0RnQU8zZHp1?=
 =?utf-8?B?WnFFZnA2Z0JrcTZtc1Uxekh3bFVkekN6M1hOVFowTXdwcUFmbUIxTE1qMHov?=
 =?utf-8?B?bXUwNHVmWG42ZkZDRmcvSHJOcWxsejRadjc4RGxWc05BTDdUN0NycFVRTXZU?=
 =?utf-8?B?WWREUGhzQUJIbVRDYUM3L3FEa1VZSENYdlRRS0Y1SC9nNmxQVFIzNGx3NUtG?=
 =?utf-8?B?eWs5bW5ldkdxU0YzcDhBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXpEOUZQenZ2dDVnNTJiN2JORTd3T2lvRzQxL0VhYWlLL1gyRVQ4bnB1ZVpq?=
 =?utf-8?B?NDRFbCtvWlJiWWVPeEwzNUJpU0cxek9sUEh2Q1ZHZlBzd1VLMk9QVEZ4NWxt?=
 =?utf-8?B?Mlg1NEN5Y0R0a21PVk9YMDhlRWM4WXF0THNDdjcyNFlLSlJKMG82Nm9PNFg5?=
 =?utf-8?B?SytvQVNTYWxmQXVleWUrTmZqUkpKUitDbnlGMlpYVnkyU3NXUFQ5KzNkR3I0?=
 =?utf-8?B?ZVNJYlhPRnZscHlieFF3SmxRaWxySkQvd3hTeDNuaisrUVhHMkJqNjJaSDlt?=
 =?utf-8?B?VG5TaUxsanlQTGpMcFR5ZVd3b3lWY3VISy9meU9pQ1I5UUkwb0lvMXp4eXJ6?=
 =?utf-8?B?YVB1WXBiV3JiMEYvNGRsZzVKTklzdW1LVTlkSXB1cDA1S3JQODgwUTNYYUth?=
 =?utf-8?B?RUJZaC9Xb21JdkdZS2pWMGxia3F0bzE4WjIxWnUzZnovaHNibUI2c1pma2Nl?=
 =?utf-8?B?bFBiYXYraWpBSmdpa2RrNmNsZ011QmxGU0F4Sm0vbUNRdm1seHh0Nk1NRnp4?=
 =?utf-8?B?UytBM0VLdnN1dkdZckJ3R2xOZVdiU2s3aEs0RXlZcDRNQmJKR3UrMXA3OE9G?=
 =?utf-8?B?NkRFeEVqaTAyUzRrc0VOTy9RL3FTSzhpY2RGQW5kdkw5WGovb3EzbjRRdTFX?=
 =?utf-8?B?cGZEVU1EaFJsaFM0RzF3SWFPTFN0ZlE3MEVhRWRSMk5XTCtpcmN2VWJMdURa?=
 =?utf-8?B?cXZzUjcwM2dZQUtmL0VEQ2JyVVNIOTE3MFJzWnZjWWVscFhPSUpXU2FNdUVP?=
 =?utf-8?B?RWVBUnVYbFJHczYzNG5sRUo1Z2ZLR0JPT0ZZd29YUmdRbmVLc0hFTHowU0cx?=
 =?utf-8?B?czNGTUFBdDFSTXVpNGhDd1B0OEZRaFloT0o0QW1hZGl0NFFJaFlRZG52K3RS?=
 =?utf-8?B?Z01MZ3Vhell3dXNJRDE3Q29CemRjRXF6ekZkNk9iZ29SMmhtVCttUUE3WGJH?=
 =?utf-8?B?dWVDVmJ5ejFVSDYzT2RaUGN4bzdmVnBML0QrY3NUTG5HZGhoQlREelV3eG11?=
 =?utf-8?B?ekc2QTk0dTJaQWxGZjBBbUJLeTJuMXRLUXh0KzJERTIxOWJzQXc0YSt6SWk5?=
 =?utf-8?B?ckNMalFxS1B5WlBjaGJMVGlURE44OVVwQ0szYW9odzNja3I1bU5seE55K0Yr?=
 =?utf-8?B?enRuc0tVWHZOaSs5L2g0SzVyT29tZWtEUElLVGVmRS9ZYjJ1UzJvdW1OSWFR?=
 =?utf-8?B?VVBhcFdtLzI2VHBkRHI2RTBLVG1ZUVB3Q1NMTzFGRmt4VGFmY2d0azNPYVFi?=
 =?utf-8?B?UVM3UEtuOE5PcU9DMjB3ekJjZzhEcWIxMzVBN0MrdW9HMEZFaVppZzFvaGE0?=
 =?utf-8?B?bHB0NmZJaWRTRmJ0WXkveUNXVkRaK1VlbS9pQU84RWVYeGtCVHBaUmxVcWE3?=
 =?utf-8?B?YTRobmI1UStXN014dWVHMmdSaFNYeUZNR2tOQmViZWUvRDBpUEF5ZVBBR1lj?=
 =?utf-8?B?V0h2eDJZMlhSYVVkMDNXUWxRek5rRktTck16MW1IS1U5R2RiTGQzVGxLNzNQ?=
 =?utf-8?B?STErWnBQNys5ZTIzVlFNeTEwYTFaM3AzUVFZWHgzbVl4cWhVTDRIMmNKTWEv?=
 =?utf-8?B?d0ZHeGY3V1FvS2FudU42QkJzUkJxQmRoakVyNkhXSUV0Tit0RDRCTVRpTVRq?=
 =?utf-8?B?a2VYS1lMYmNDbW9wUUxLODFFTWpOTkNYYnc5ck9HNlBidDc0aEllU295RlVK?=
 =?utf-8?B?YkhuTTdkMUJuTXg1dnMzU2l0emVUNFhZbEoyNGdNd1ZJOUV3dmEvMWxFU3Fj?=
 =?utf-8?B?dzdiWFNyTFVtWndZQ3Y3bVZYZFA2Zy9OTHJhaGYyb2JaWWFUa1czdUtNOGd1?=
 =?utf-8?B?OFMwSEJIb3kveER0T2xqUEV2ajRpTFlRQzByL3hSdERreEhpeFNOZTJDZ2xB?=
 =?utf-8?B?TFU5b2pxaDlIOHRBaHZuVmhqQUhqQVUxWmRIYzZqY3F2VkQ0ZlpwMnFkWTRN?=
 =?utf-8?B?NnZjLzJCSG8rUFJmQzZkeVdyTG5jL005SHI5MExONmhlNlUvOG9aNEFEY1Zi?=
 =?utf-8?B?VUNBeDN0UE4yM2hYeWZrM1lLNmt4dDBRZXJoZy9oallOVCtTb0dnRzNWVVJx?=
 =?utf-8?B?VzVXeDY4ZFVkaGNBOVhPZ29PNnNrT1NiMTBPd2UvYzI5SjFOTHFuVkZVUlpQ?=
 =?utf-8?Q?8SAm4WPa0kN0vloHXQIeMFcXc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pPte7S65/EGyVaTsEEhGemKzjsXm2NF1cMbJTPATUt3n6CGOE3PUMAEASYOuaFwMcEkHLHs9pcNaUNOvSQmOtwc+AvpLYLwmVUfEaS9+hp0vUjcew/318fmsnl62C+SSJKqgvnhr4oNZINAhm2TJOxBVzMzhwixk4FwxTmUaj5X/yvMWvmxbL0vWAGRS/gPArZs0qgnc+ruWzPppH/6BJsGHKrwJ3nDprzi9miFQ5OZHPMzrNXHuhSWWinjDOcef61tQRV6E+RtOoKKxn+MN3X88qACRLKQw6q42di8CRGQlVtmz+hEWO41d4UQMQOjbDQO/6X3V3TOgv2iwhmP32ffvKwU7H+q1h/cZ4xT5nOWgwJSuRLqjywxyNkCGSehH9xA0nJIeH6CdoFwaV/1xuHbQoorzlo603YOZNTuCp24hFsAwmnwUu07wF/MMW2AqMcbdA3oiC0vJBzXqS3riC9yjIPyrmernRen7YEh3He+QzIynN6TWMelI7UaUgrL6nVZ+Kiuxbb13+pWbViB1DMYO5f1bQUpZRQIaxsbfGW25YjuUF61xGmvS09vPkvOLdRSypEngZCOh1kk1b8wTH5qEdSgjUvS70xctXPQ23Yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f271f21-80ac-4f84-a131-08dd0dab0eb1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 23:44:09.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1WVGUyROu87eIPgiqKzQv5WV/FLQwcGTo4UVo/MPzyzW9e8CumVuRToE7t4KPSdp5mSQq+U5+R68JTdMQuoQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_15,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250196
X-Proofpoint-GUID: p8PUpOmzlfutlu3iysvc009AIGeTf72h
X-Proofpoint-ORIG-GUID: p8PUpOmzlfutlu3iysvc009AIGeTf72h
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_154434_872458_AEE197A7 
X-CRM114-Status: GOOD (  19.82  )
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


On 11/25/24 11:39 AM, Bryan Gurney wrote:
> This test has hard-coded 512 byte values for the dd commands, which
> will fail on 4096-byte block devices.  Create an LB_SZ global
> variable that is populated with the result of the command
> "blockdev --getss <dev>", and use that result for the block size
> of the write commands.
>
> Also use this variable for the "--data-len" command of the "nvme
> admin-passthru" and "nvme io-passthru" tests.  (On a test with a
> 4096-byte namespace, leaving these with the hardcoded values still
> passed, but update them for the sake of consistency.)
>
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> ---
>   tests/nvme/039 | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tests/nvme/039 b/tests/nvme/039
> index e8020a7..eca8ba3 100755
> --- a/tests/nvme/039
> +++ b/tests/nvme/039
> @@ -37,7 +37,7 @@ inject_unrec_read_on_read()
>   	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
>   	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
>   
> -	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
> +	dd if=/dev/"$1" of=/dev/null bs="${LB_SZ}" count=1 iflag=direct \
>   	    2> /dev/null 1>&2
>   
>   	_nvme_disable_err_inject "$1"
> @@ -57,7 +57,7 @@ inject_invalid_status_on_read()
>   	# Inject an invalid status (0x375) on a READ
>   	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
>   
> -	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
> +	dd if=/dev/"$1" of=/dev/null bs="${LB_SZ}" count=1 iflag=direct \
>   	    2> /dev/null 1>&2
>   
>   	_nvme_disable_err_inject "$1"
> @@ -77,7 +77,7 @@ inject_write_fault_on_write()
>   	# Inject a 'Write Fault' 0x280 status error on a WRITE
>   	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
>   
> -	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
> +	dd if=/dev/zero of=/dev/"$1" bs="${LB_SZ}" count=1 oflag=direct \
>   	    2> /dev/null 1>&2
>   
>   	_nvme_disable_err_inject "$1"
> @@ -119,7 +119,7 @@ inject_invalid_admin_cmd()
>   	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
>   	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
>   
> -	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
> +	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len="${LB_SZ}" \
>   	    --cdw10=1 -r 2> /dev/null 1>&2
>   
>   	_nvme_disable_err_inject "$1"
> @@ -145,7 +145,7 @@ inject_invalid_io_cmd_passthru()
>   	_nvme_enable_err_inject "$ns_dev" 0 100 1 0x1 1
>   
>   	nvme io-passthru /dev/"$1" --opcode=0x02 --namespace-id="$ns" \
> -		--data-len=512 --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
> +		--data-len="${LB_SZ}" --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
>   
>   	_nvme_disable_err_inject "$1"
>   	if ${nvme_verbose_errors}; then
> @@ -174,6 +174,8 @@ test_device() {
>   	ns_dev=${TEST_DEV##*/}
>   	ctrl_dev=${ns_dev%n*}
>   
> +	LB_SZ=$(blockdev --getss "${TEST_DEV}")
> +
>   	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
>   
>   	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

Tested-by: Alan Adamson <alan.adamson@oracle.com>





