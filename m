Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2446CF9C6F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQZFsx5uUTCAcVzsC7kBi91yDAGoGdoFgvWv2tB1/5k=; b=VNOPw3dZmKMDdJSaTGYJ/jOnDF
	vA+2sQ7X6E4JeGZk7fKDnhlTwByqORrtOcthILfLo7oHw1eQ7ILDiuzAeHQJ32HYQudl07huDIKEL
	MUBnoIFMaJ20AqnJkEjkviXpJIuaAUTELt+qKAgMsY2auOVhdeTnW9eFUlhvW7X4AG29JKWTtRsuk
	OPrNXuSp2yzOp1+sO8tw43OxiwcQiO50gywjFS/4DNsSvQ1wBBOME4frcLF5KNO5Vr8TBrBEUjX2C
	Hhvtl+hdoZruzkPb6U4sUfB/0uxgBYm6H8KltAdSVO4kvFQMfWpibMfBP2Pl0QB5FyZaIuhuM5M4v
	coksLd/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st3zF-00000002DVD-3ml7;
	Tue, 24 Sep 2024 11:45:45 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st3vz-00000002Cn1-2sFN
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 11:42:25 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OB7rc5023045;
	Tue, 24 Sep 2024 11:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=JQZFsx5uUTCAcVzsC7kBi91yDAGoGdoFgvWv2tB1/5k=; b=
	HfyhJ3VWmUhPc6KW5byZSdu64iaxH1OKRDqu1886P+mlZVMnlZzeqIfHLuKcb5DY
	94Eh4hneCZ3Wrnls4kzgO+aV16ih3jQsxiBZU8B8rkl0oyUwnGuRyLDjPEnPnLAu
	oJBfM8I9x6hIU7KNkHfBkky7yfkN70a20zvoS6twgcD7JIPeVwdfAfIL52ENAsHp
	OoDFfxeTpN+nyxhENOfjb62q2ugGLq5llF6wUXJS8OASAtS9yYkNGHDwRKk8aux5
	EBLhyNHQw3BVSlgS7pt7T7r4F0nqgqJb4tcIm1AhcsIWVpjn8ef0+9aCLhLxTfBi
	sFrKrPPM//guOPpiKde89w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr1786k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:42:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAhNiC005403;
	Tue, 24 Sep 2024 11:42:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk941wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBjLAvFKuQUZnrONveXPw5iibVHekiBTC8A7hFfMFRexcXFI44ne2mc9/ZvSE6XaDFs/s/R8P/0miiJe2Sg9kRbgeYxzTNZ4Yck7gvy6uDggOYFFce2kOYIE7jINMVeREJarY0/X6jQEYx6C2eOSlyAm2XCKWtjpBIBZay57bN6Lwrjy8i2RTlJuG8Ui3UVaEKhmO1364esjJ9+aUzq96jUV6PmxWs9gXfZAMlEJJioN2GqBFTwQYfr7MgbTDs3gUxCWsX10JkHXNkWXq3XAAHfoAxd3WEnfGz2uRNPE8RN8Coswq1abhIL7od99RbsyXtZUJZN84DWcprc193pVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQZFsx5uUTCAcVzsC7kBi91yDAGoGdoFgvWv2tB1/5k=;
 b=Eddeg5zSKTiamPu6dtHVGJUGZ2FvvR5FcEABG+TihDDKzqe7CXf3MOylHZ7xTn+IkI2I5TQjj1RkbZLMAMwi40KN69eCBxB92cTwR8Xr/o4R6vBxXJN/iU6QJx5b2hDiYaVcPZOFrxooustcscwpXcVSYhRqts90FGHCEPtwi4kwpjoj8LUNbxpWZKxjbQ6uokI/j2t785pP9Shi4I4ojUUf19LHXV7PYr6O0DN/7goasZZZkrgV7vTavLtzFWLgCe4qfbREJ2fg0j/CzCabEsbaD2Hw6nQEWU1kBoplxjWt3ce8qhavQCAGMcMAjlNOUkNosZy0yS9yH3mzQwZFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQZFsx5uUTCAcVzsC7kBi91yDAGoGdoFgvWv2tB1/5k=;
 b=g3zzCMWHKzaFBwGDiMPVZ2AgXiEvaii3T/MUOkTYJt3ssPo1jV3sRPtF2cRKMASEg641cKUHN3G6FK8gkEDKWvDkYeTsk622uPLxO7TQzmTpoSh3l6GqRI46dFLoHnQ5LR6xv4RMYQx0SdenEBYhCx39T9T0RIA0ym7UXJsSXOk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 11:42:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 11:42:09 +0000
Message-ID: <27712543-4f5e-4b17-9092-b0ea6ff58a47@oracle.com>
Date: Tue, 24 Sep 2024 12:42:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: null terminate nvme_tls_attrs
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0196.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c445e8-f25e-49e1-2089-08dcdc8dec75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDhXVzIzZ2JaQjRKb0pDd2RqNUt3VVNkRTBhS2NNV1VCRDdNQUlOSkliM0dJ?=
 =?utf-8?B?T0dMLzV5SUZJVjdYd3JSbDB3ZldvOTVVYmVBZHVTeGRwREN5MXZ4TTlFZFpL?=
 =?utf-8?B?Rk9iOFZheTJlbGdrSXcvOTU5UEJUSzZ3RTZIMDN3Ym1lbzd3Q2lPSFV6cWk3?=
 =?utf-8?B?OE1Zb0JKcjlGQmM5ZlprWFZUUFRVWSt6MWZrajB3cncvanUvemJRMW5xWEZp?=
 =?utf-8?B?ZG44MmkveUJnR2x0M2VRdFRHeDdvMUxhanJzblo3Q0FsQ1JXSm1jeUpFMG95?=
 =?utf-8?B?SldLMnZ0UnRvMC81MlphdTBDcmZmV1NrNVdqN2xzVzVhd241RlA0c3JCN3A1?=
 =?utf-8?B?cFBpRllIT3hLOTFPbzlRZlB3T1hIWW0xenJuME9XSlV3Y2RvSnN5NC8zb3l3?=
 =?utf-8?B?NnpRNzUzMW5tYUZGaGNsUXgycGthUnRydE1GbWFsbG1hcitYbFV1dkNHTHJO?=
 =?utf-8?B?N2tTaFJWT1BkTWwyU3graVhjZW94ZWU2bmJOT3oybjFHVTBEUVlGek5sNW9x?=
 =?utf-8?B?OHd5a3AxVC9NYXBuSzFyempDZ0N3Q1g0WUhCT1BIUzE1RWJtbWViSFNJWVpj?=
 =?utf-8?B?bG8xRk03NytPaDlrS1VkL3ZIYXY5aDExZVFLKzBBR3RmekxWQ0dabjdCM0Ji?=
 =?utf-8?B?Q1NqejFQb2tEWmhTSVUvUkJncGdGVzRna28xRVBHU1NEQ0lPK3BSR01DQ3gy?=
 =?utf-8?B?UGFHY3VJb2dhNmg1ZlBUUWdHeWRJYlEwdGxudFcwM3VEZVpRcjBzcFVCbGR1?=
 =?utf-8?B?bnFMUHRpZ0dsZEdNOFJRMUIxQnYwdnA5K0F1NFg5YktVQTN1YllFL0lBejhB?=
 =?utf-8?B?KzQrZ1ZtQzk0S2pDcGV6L1FHa1FLL0pZRTlKRnZZSEZpV3NrYTlaU2c2SlB0?=
 =?utf-8?B?SHNMSTB3Y1dKbi9vMmxCWFRwUGRFU1pXaUpkQjFIY3dNeExsUkQ1dENEYTZp?=
 =?utf-8?B?dVFsREdSSXZTWU9rVjMxZXp0U1JqYTdmQktHMk9yOHNRK2QxNStuMjh5Z2JL?=
 =?utf-8?B?aitlUFV6b2VneklRT2R3R3dSM1pRTVV2d1FwaEJqOFpqUHRzK3FwN2sxUUhw?=
 =?utf-8?B?UTk2N2FtUS9rS29IaE05UUxtTmwwLzhLeURxK0tENjdQVjRmYXpYNDIxdkdj?=
 =?utf-8?B?U1cvVmIxQjhGQnJ2dkpHN2FreFpJNTdpUW5LM1VZanEyZnpGNkswNDJ0N1px?=
 =?utf-8?B?WFlkU05MaFlZWHBZTmJkN1pYMWJNUlVSNTR0bWVSTXRiQnZnOElDdHVIb3R2?=
 =?utf-8?B?TG83cXQxSXI3UVNucGhaYXVSeVBWVG84MXFGdTYvRVh2cEtzNjNSOFpRQXJs?=
 =?utf-8?B?TEF4a0R3N25tT1VMSS9lVFZpNjY1MkFIQ204SnNRb3NSL1lmUHdFVWo4YWFR?=
 =?utf-8?B?Rm01MWhKQ3NZOFJrYVZzYlcxNGg5dk01RG51OFlTVzQ4SktmcmkrMmluTmtK?=
 =?utf-8?B?UUNoWnhoQ1Fuc1VQVmV2TE9wK1Yyb3o0ODFrNHlnV3BUYXFya01FMHlyelZ4?=
 =?utf-8?B?cy9uYWkvSk5tTlFBbHBkS2VsWE0vZkNFSC8xWG9zUWhsOE1CVlRoTCt6UjNk?=
 =?utf-8?B?dUFVSVRZVnh2eHcvMXVUOVU1T0hBRUYwbGRjSU5Md3V0UThMdnM3UGlDSVRo?=
 =?utf-8?B?MHd6clN2czlaTnRXVDhlcTdRYmVseEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRWMWNsVUcwS05LZDkxMTFUTGZVbEZ3MExISzk5WGp4RGt1ME0wVXIxb1k0?=
 =?utf-8?B?eTRXSzBFY09McGpLbG0wNmZVbXg5ZlVZVFVXQzgrakNaUnA3a3JVdTN2WG1R?=
 =?utf-8?B?eGt0U0FNeXo2QUxRU2JUNm5yN2pnRVR2cEdIOFkyREl6WUpUVmJpaktMT2ZN?=
 =?utf-8?B?R3hpQU1WUnJmTnNoblFJaEs1VXpxZGRuczA2NFRSYlEzRkZhdEthdFg0dFMw?=
 =?utf-8?B?WHBScFd1NDdncFQ2cGczL1hwQ2NucVJ1WVNuU2xJRldER2NiWWZoNzljNHBs?=
 =?utf-8?B?NHROSmt2anRvZUFTRCtRcU9vVXFsTFRYOFVKWlBEZlU4c29EaFlHQnlhaENQ?=
 =?utf-8?B?MGhpc2hNK3R3UHNzOXZzQVcrRlhkMzRESXFNZ2FuMHJnM3YzaUFrbGhsdXBI?=
 =?utf-8?B?MXgydGFtcGNSbVhmWlJ5cDhseDR5eHZPdlpLazNGSFkzclY0ZFlCbDVwYk9p?=
 =?utf-8?B?MlZUdnU3eDNWRXdBTDlLTnJrYTR5VkVxeVVtdkRxc3FCZklhMnFEZCtza0Zy?=
 =?utf-8?B?N2ZlUElMaFVuZ051TS9EdlJmUUl0eEF2QzVGcjBrNWZFSHJ6TDNQcU12dnFn?=
 =?utf-8?B?eGgyK0ZwNFNPdUxZMTdKaXl4VlN6MXA3SlA5cXREOW1wM3ZVQkk3bnlhVzBH?=
 =?utf-8?B?V2VjaXdFU2hITDhBQktIZExMVytyL01LSHgwRlgrclg5WG9nekxONUxROEMv?=
 =?utf-8?B?bUd6eFBnSEhTc0w5bmEvVlJaSVg1K1dUcGhQeXF2RU9YWDBTcHVtdXVNNG5u?=
 =?utf-8?B?SHEvVmt1bHRSUlhJNDJnRE9vM04rVkxkVXA0TllTbGJCQzNreEtzMjloRzhn?=
 =?utf-8?B?SjJBN1VJL2FIRjc2TXo2UWN4TVkrbjluWEFXWkU1WCtYanpCd2RQTVFaQTQz?=
 =?utf-8?B?TkFUSXorWDRSVUZ1QWJxbCtwVk8yQzdTbUtNZW1SU0M2ZjBLSHlha2gya25V?=
 =?utf-8?B?TFJQL29IWW56b3JhYWFRdEZ4bGRwSVZUcDNyREtjMFVBSk43ZEVMOEszbVJl?=
 =?utf-8?B?clRUZDBxcEFZVm1lek85UXVycXNoREtnalpLbVBPei9pbWtyalFTcHpqMHMy?=
 =?utf-8?B?cHc1bHBiZTZMWWMvKzJmb0htQVlrSWg3SmM0bDJmUVdidmp5V2J1TFpuTTZU?=
 =?utf-8?B?ejBGZmRWVjhCZVJPdm5wWTNrSERjbjBUL1NqUEpmZ0QrUnBjaUptVUdHT0J6?=
 =?utf-8?B?NzNQd0hQeTJWeWR0ekJpRzhJK1J5TjJTWUR3TENUZ001aDJtYTRrNjJkQWZx?=
 =?utf-8?B?WkVVMldjdW1WYi9Bd0RyS3ZtS3hWYnQyelg0alJoNTJNbXJaYU5lYklrSzU2?=
 =?utf-8?B?Rzc1MDMxSXhDdW5ta3ZKeTdtMDU4RHN2YTV2elU3UlJocTJSTnJxY3ZhWFBS?=
 =?utf-8?B?V1ZNOURXOEZWY1BOZERYMjdSeUxUS1J6WE4rZWRYTkxYdWFGdHNscGQwZW1a?=
 =?utf-8?B?UmZla28yR0xlak50Z2pjTzF6QW9MTldKSjYyM1pacTJpeHdjcWxTWTBvZUND?=
 =?utf-8?B?bTZnZTE0K2ZScW1IMERYUEJWK3lDWnYwVjJHek5vUGtPLzEzV1NrSUozWVh4?=
 =?utf-8?B?bVkrR3hwMmJHeXVoOXN1REFVRE5kNUkvVzZtVTZzWVp0WUh4MkNiT01HaXha?=
 =?utf-8?B?M3hQVVRmRVpkSWxMT2wySzhNMlk2OUN6aTNpNUZkMlNSbTZ2T3BxbXJjU0JY?=
 =?utf-8?B?NjdpcU51MUZSK3hHMmtYN0EvQmhFZytkMEY0L3JpcnZPcmp2ZzhMd2hxZGVZ?=
 =?utf-8?B?T2xmSVRUTmNxQjBkWnNxYU1kUW5hdWRIVTcwbmZDbWViNGhoWEs1TUpjUnNB?=
 =?utf-8?B?NzdqVlYxQkNRSHlaa1hSazFxanB0cVRScTc5N29RUWxOYytyQytYVUJ5Mm12?=
 =?utf-8?B?dkNXUTJqZHBib1VZQm91elZVZnZhK29TYmtlOGNUQ1JqZ0duQzVoQkcrS2Jz?=
 =?utf-8?B?bnpyMlJ4dm1rVGdHRTlJMTRvdjk3MnNpSnN2MTR3RXVkUklrTEg0c1NsVFlG?=
 =?utf-8?B?U2VNVXFkZ0x4bGtjNkdoNmtPc3ZPZlhuMHB4RStnR0hhOU1MS1I3TGZkdzVU?=
 =?utf-8?B?Q2l3S0FxRDhXV0lZaTgrdFJqbHgwNkhweS9pb1hGSlk2bFA2cXRtZW5ad0Yz?=
 =?utf-8?Q?uBfIMNkc49nRDZez0TATTW9l/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: imFCSI+l2/Th1WxNzjWNWUYRvhaoe+9CymORHytSqkwMdL13eQv/6RuUV2lNgss25vrpy2PZzGnNShyE32Cjdl0t/cJdBSEx/u5/+Ke9fQpfj2IQz2mLwR1/AUHMH3YdRuFfU0ZDt3lQyvisKB86lS7IhI829TBEl7stAgewwUlpP+r2ZNKsIkFF1sxQUu79KyTrhCiRrCIVhXZbnCveNjkxWk1d5YvjaAO8She88IIiuuQJGRtPD2EbjZk5A8VbBX78utyWO3bk2EOvKSDnZH8j0AiaHp+RPXenqV+914ooHyyNUddTiQ5Yad0PQyhE6nngPOHtEiXSJi++KeVmew+f4RmDW0jNkCBlsfo9fqzVxODMr/Q1RfpWUdeILVsOZT2Tpn1d587jXCRmMa0GVykjOsbFfHASl3INbfCbt0IQRYia4YWVusR3sODUuTVK+bG13ijmspKL8xO7STLLjTGPVnpF2UT996J/cjChRe6xNeJ4d9caUQb8/OPjseGCY76Z8jff+N7gcu+284ywREjSAY46l7IY7zNzkQKw1S1/9/px/6eXupSrqx48hxIBVX4Qyn1qPkvdZ9jfxj6P+X1evtE+RsKds552FMZ/QZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c445e8-f25e-49e1-2089-08dcdc8dec75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 11:42:09.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmXiaWvQqc7WOfKCEl/WEMpKM6rRTYciG0ymyglT6ri/w/nQ5OzD5ybTi4Egk5Xy4kZjOAZBVpZPcYEO+t8avA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240082
X-Proofpoint-ORIG-GUID: nGHdSkZDt9rAX5PnzZZUEYqBoK24tiEQ
X-Proofpoint-GUID: nGHdSkZDt9rAX5PnzZZUEYqBoK24tiEQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_044223_743116_D4AD5466 
X-CRM114-Status: GOOD (  16.04  )
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

On 24/09/2024 10:01, Shin'ichiro Kawasaki wrote:
> Commit 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
> separate group") introduced the struct attribute array nvme_tls_attrs.
> However, the array was not null terminated and caused BUG KASAN global-
> out-of-bounds. To avoid the BUG, null terminate the array.
> 
> Reported-by: Yi Zhang<yi.zhang@redhat.com>
> Closes:https://urldefense.com/v3/__https://lore.kernel.org/linux-nvme/ 
> jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm/__;!! 
> ACWV5N9M2RV99hQ! 
> O7ofbvpkFcN1G5ZtEfcoa89swFeTDXZf8d8VLdkl9BCbv1ofMOt5QcsWBZHT2cfK6Tzf5bWPI80AFNaRRJ6UMEA4Eiv3$ 
> Fixes: 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a separate group")
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/sysfs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index eb345551d6fe..b68a9e5f1ea3 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] = {
>   	&dev_attr_tls_key.attr,
>   	&dev_attr_tls_configured_key.attr,
>   	&dev_attr_tls_keyring.attr,
> +	NULL,

nit: no ',' is required for a NULL terminate

>   };


