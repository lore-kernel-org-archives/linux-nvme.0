Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57F2E9A03E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxtdUblLxgI2athe8UzyhUzefFaGZx+vhltLmeld5Ds=; b=wTvkjv2BgoVquDa7KFxjQHl8Vb
	CTYRtgfLhyftAkWzqDLceAZwIfxgICC32XyG8Abf/d7soZNhx+3sVUm1j53+H4xwKaQukuV5pkD47
	NzDTLrKMdIE/mchfx0YIrQ1VY76kU0VR7BX0CJQSjiDbx2uEI1VGOr2UDhza/sF0khf6L1J6oMjJy
	G3OJkFFFSLstJ+Qmo638FhG9ZqpCylB+tl6jxHGzO/ETUK5sdsho6lNNMbI/kl+RerHUZ8CSdXSLE
	F68oLEHye+/rlRPNC03eJeNUL2M+P+RqtOUGqvPKlAwjyrQANYV+QQmROQZb66ETTFtBHlWVs2Kgd
	/LjSCS0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsd2K-00000009TVl-1OSh;
	Wed, 18 Feb 2026 08:35:56 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsd2G-00000009TUN-3lPg
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 08:35:55 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I5QIVL066174;
	Wed, 18 Feb 2026 08:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gxtdUblLxgI2athe8UzyhUzefFaGZx+vhltLmeld5Ds=; b=
	rKqTqQxIA8ry49aXTRJfXT1wBRbuFjBd0CJaxuanyfrit+rS2hBM1SaB3WRmPgeK
	NTv9CC+SyPND4Qft/yBhWOS/vqXYy7mni/ZOz1D6yKUq5g/aySAG6V73A6O9qxxc
	cGtDA7bl/fyNcZBlTJkf3sTbOix+H6OxOF1h9UE+llvNWeg28I6FTcs1j4kh5mK9
	qmNwsMSiCfRBwT61vyPZTZjjsSsOtSUsDWJFShsmKpr3uiyF80KHAt5g4V8wKeIj
	30zMBniKNnFc//gWzF68reei19qKNsyQ2WvmUWoCpTpBCwkWS6/f33gYAZlCtSXg
	gjKFEN0B4iCWGKBzzfd63w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0452w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 08:35:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61I7EOd7023193;
	Wed, 18 Feb 2026 08:35:45 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2db12d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 08:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvLsbeWvvFi9Wzmd8m4pfB1CMab8hCC1PIt5lVgCbapNgk0wwy3XgMMmR/lZj5P/NvhD8gptWBWdrTkxd6Tu5pNq2ti6T3uzAALAusO5npbZr7SEQt4pZuW583s+bV83ShtvsI/UeKNi3Jqn9CeDlhkRmfPHl4K3pZC52lV/Ef2ZJKQ5ugsnaoOzQvfliHJnlXdvCba7mvnXCivXRH1x0dFHhmL5clHhQQ4sRM/+8CZ0Zqgo/A8ewaT2k/h/1xXRYltwccVi4ZNyrs0Y206jF2LSJzG2CJ3rNFhTPA1LgUdcBcQfeIBMZccE9qwLEyT783BYA+3lP8Qz/gg8OiibDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxtdUblLxgI2athe8UzyhUzefFaGZx+vhltLmeld5Ds=;
 b=NrBya/Grr4ramYMME9VJza3ZgstNM+tRQwDix6ZELX9HXeICGlns5TdYAnbG+f29URymEdFtJUPncgL5zm5AwkL8F1FvvOugpVPzM9N4Xaf/LwDsLui+Q7QRk0igVg4z3LTNQ5rP4+u3cWgGFnSYsoP0k03NTAAZT8Av6iy9+do1hkb0cJPrt1bKIxYlvIBqu1t/oMJqFfuPol3BRcw/MGp10luic2BCv+83NAZ+0TzBaLeeT+kHX/wykNS1Rqx2P/gg9P2KPykLAY4hBRpStwGAYo+oIZpvhtzUYyM+DWD2SsljyKqy6wXtS5B/VL+8YK/ZqY8yeCVKbEkG7BCglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxtdUblLxgI2athe8UzyhUzefFaGZx+vhltLmeld5Ds=;
 b=Q04an16XYexsRtzwZwRZVqzPxnUqj02YqfR+0nWvxEc1ruaV8RfHhKvyfcDKkYVRtp3EdbIT2p83trC7sn6QEZ6cudm4xmT+l3sXz2eXPpLb70lUBEq3HwBMReaedE2laSOr9S91v9trSEsqQx/4MBZIQkBSg8mJ2GyAnPMV27k=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB5191.namprd10.prod.outlook.com
 (2603:10b6:408:116::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 08:35:42 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9611.012; Wed, 18 Feb 2026
 08:35:42 +0000
Message-ID: <456eff58-7faf-42cd-88de-81ec300ea642@oracle.com>
Date: Wed, 18 Feb 2026 08:35:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch via Lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <049a177d-85d6-4c9d-9a9a-f07391046101@acm.org> <aZTL8srSowTU81Rz@kbusch-mbp>
 <yq1seaydbee.fsf@ca-mkp.ca.oracle.com>
 <f658021c-471a-4f30-bd76-1d5c7b7d79de@suse.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f658021c-471a-4f30-bd76-1d5c7b7d79de@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e930cd-5e80-4aac-2870-08de6ec8b3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|3122999021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHlkWjBrRU1ycWw0L0JyNDZzd0ZDL2ozQ0FKNjZIOGwwdmJCci9KNGtVeEps?=
 =?utf-8?B?Q1BKZjFCR3pNa2RXUFMyTDgwVGtpZXVZdXdodFFlTU8xMlVUbC9MYVVWTW4z?=
 =?utf-8?B?Y1Y1ZEZ1QXNKVERtM3ZiRVJ0VE9tOHlDNDVFa2gwSXpDY0N1aVlLaTVzZ2E0?=
 =?utf-8?B?VVMvNmpmOGFSQnQ5Q0pMK1d2NzV2cHlKSk9UVUd5ZlJyYm5teFpJK0xVTU84?=
 =?utf-8?B?cW1VWHdWcnRxb1BkMk1TV1c4Y20ybHd1R1hJcGhEUDh2MUU0NFg1dkVQdjBz?=
 =?utf-8?B?K3dBbkxEVnZEbVZQWm1sMDVFWkdnamp5anZDSXR2TjVxRW5lSGZSeDdNU3pT?=
 =?utf-8?B?QkxCS09lTThhVGxuYjVJNHZtVUZia2RZcUJoc2Vyb3FHTi9wdzNOMkd3WCsr?=
 =?utf-8?B?SC9aVHpERE1Xc2R4T045RUNBNUIrREU4VmhzZzlPN1RlRTRxMFpwOG9FL1Vp?=
 =?utf-8?B?MnAzcW55OVJhU2NFSzhqNXpMdFllZGpRZS94MlJWNVVMUzVabGtoS1NLVllt?=
 =?utf-8?B?dS9aZnFBUzMzd3RaYUlSV0dPR1dGcG5CbXo1QmJjOFdwVFpSWnJFdWJXQlc4?=
 =?utf-8?B?VWFlQ2tKUW5kOXRzZENqcnYvS2xFVTd0cTdaTjNKVmppVmpIcUpWT0ZVRnUx?=
 =?utf-8?B?U1ZBNWwyaXFSL1grK0R1bHpCYkdFdDlSd2dzWktIU3c5blZtMFBRNVBuUE9v?=
 =?utf-8?B?bTFtYnUzYzhyUTZvSExQaEVxNjZjdUd5bUNlVi9mUFBPNCs3ZXdQTkJ0NjFw?=
 =?utf-8?B?VzVaUjZHT2ZKMDN6MlFNT2dPTXVpTUNxOXZFMHJUczg5NnhhbG9UL2dXREJJ?=
 =?utf-8?B?QzRpYlp5K0FjTW9pMm9zelNNSXNWOFZaRUFvcm5INS9ydlFOL0I0b0pPZmRU?=
 =?utf-8?B?elVySkU4aFJIWlBWZzR4M0VBTUtwSEtHaU45dVJrcE1NUzNuRjU5di8vVkJa?=
 =?utf-8?B?VERqYitxc1JUaFJvLzYyYjFOVTVla3AzMnJTOTdGclRITEg5Ymc2UWwwQjly?=
 =?utf-8?B?R2M3THRoMzFub3kyQUhCUXlTeTJuQ094VjJpeURFdGdiUlBmLzg3Y2NxMVl0?=
 =?utf-8?B?MDN1TFFrWHBiUm05WEdBVUpMRWQ3U2dKaFhxTUpmKzdpWEt5ZktlRTVraUI1?=
 =?utf-8?B?WDRkK1ZlSmhRem1ndHoySzVLZ0M2OG5rVXd0b28wWnVHWFdhcDRsZTd1TzhV?=
 =?utf-8?B?bnpXd3l6bW5JNnNhOFpzTTlMaGpjQW5WUWkyeDhqRm5hSTBhR0ZCcW50djJP?=
 =?utf-8?B?TkhzdGYvVGE1RTF5SnVXRi94cjV5ZzRuYU5kVzZScmVFaFJVUlQxSFZLTUZv?=
 =?utf-8?B?dXcwTkdmNERwRmg3bVhKWStPd1pDK1hVRldNMnpDdXMwa3Z5YmlxZW05bUhz?=
 =?utf-8?B?a1NKZXVsM0pIWlBFbDh4eWRpSkMzakw4T2ZvTWNpMjl5SnFWMk4wY0wwMDdu?=
 =?utf-8?B?WjZrdmdSYjRDKzEzMXZIQVJzSzFGcG5BNDFVK294TmYvQndlcWdzWUUrYWdz?=
 =?utf-8?B?b05GaVg1RUhjbTZkOUFVRlVGL0tJNVQxWHpzS3I2YXprQUhsRTlQeU8xYThJ?=
 =?utf-8?B?TVFWS0c1a2tueWdGVkJEYkFuQ2swU012N0JPNG8yVjNoa0tIeTlxQjFpK01n?=
 =?utf-8?B?MXh4cjljZzZOZkVHdnVkRU5PVndpbHlhRytPQkwzVjRXcW00Y1RlNTZTSnFQ?=
 =?utf-8?B?aTBIQTR4cThLK1JSeUxpUnJYVXMwWWhVbWVUMFVkbnJraVZPV3pSUkdZRitz?=
 =?utf-8?B?Z2l3eVVKWGtWSWxJVjdMQTU4VjlJVEFYQkFUWjQwOHlIN05uY205N0N6WXU2?=
 =?utf-8?B?OWpERDZYRGdIeU5NalF6ZzY5amRUYjY3R3Q1NkRxRFh1TWNvVW1qY3QrcGla?=
 =?utf-8?B?QjhYaGNzSmZLKzF6RHpCWlNQQnd5NVFobC9aR0RtMnoycWdzYW1seGtBOGtp?=
 =?utf-8?B?Zk9URFF6VGlSMU1BNTVaTDRncHF4RHhtOXBJS2RNZUU0OUF5WEhNOXFRQ29Z?=
 =?utf-8?B?LzNudkNLQTZlOEJFcDR3empCOHYzcHF6dHJTYVJiSFBUSXY5RUZHL3JwRndP?=
 =?utf-8?B?ZFhvVFd6endCR29YVHpGVEZSMVBOT09tOFJwRjJWa2YreCtSVkZIWlBaeEY1?=
 =?utf-8?Q?yLDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3122999021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTlQa1pQd3FwNFVDUE00S3BSM2FDMkIzdDdLRGRkVDhiWG9rb216MHU4UjNv?=
 =?utf-8?B?YWhQSzZ1QURmSHhRNjFkNGx0Q3B0QWQvakE1OEdVWUc4bnh0UHlvamRyNTM0?=
 =?utf-8?B?R0VDK0dJcWVBOUhIUzZmcDFldFJ1bXYyajJGTDFhS2JrczlEdWVDWWw4UU5q?=
 =?utf-8?B?UE5OZXVWRzNWVWlxR2EwSjczQTdhaUZyb0FyOUJ3YVZCdit2a2V6UnVOTmtw?=
 =?utf-8?B?dk9YbHdHMmNySFFZdkpTci83T2ZWK3VkRTZ3RU9aSGJQNDg0aHJ4WGlTbUxL?=
 =?utf-8?B?akZ4MHNGeUx2QlQrTFBVbkZ3T1Q3d2xwZSsvUWk0NDdWRXhUUkJQQ3BxeHRj?=
 =?utf-8?B?cnJ5WFZ6OE5UdzdHT3lOeEhjTnFNZUhCVUVtYkdNNTh3bVpKQ2d5dlNNQnRy?=
 =?utf-8?B?ZjlWNEd0eW1wOEJ0aXJ2eVJlbDRWbEF6Qzl4UzAzRlBkYWg3QjNFa0lFSTcz?=
 =?utf-8?B?MFNsOEtDeXE4RGkybXVtOWgvUU1qM3JwNi90L0pSM3I4dkl2T1RxRDVOOXhH?=
 =?utf-8?B?cHV4V214Q0JmNWcxL3dtcFpEZkdOZUZsTDN5aFhVVFJXSzNZeWgvbHdFTTc4?=
 =?utf-8?B?dlpIajE1WTZBYUVzdGhhaHNGZ2RpRkt5bnIyRFl3QW5iTEE3bW9VaU91OHh2?=
 =?utf-8?B?bWs1UTJqVS9BcWJRVkdML1lWUDBxdDI2YWhRT0RWZDQveTVDN3pUMkcyanJU?=
 =?utf-8?B?dnd5YjlhWi9ucjhaVXQ4QUs0NUc1dDJRNStaUktZM3pHbVMvWXQxTmJVdFlB?=
 =?utf-8?B?dmUycUh2RmFsdmtMSnpGSE5kZFdZdENEUlhVMENqQmxvWXVJNngxTkJjc2pY?=
 =?utf-8?B?SXZNS3hidFZWWWgvQUNWU1UrYXY4Mi9UNXdRQmdMV3V0czJLZDI1SzJuQjZw?=
 =?utf-8?B?dDZmZFV0aXNCMG9zVUxOLy9RRU9qOFdrbG9aK3lQTmRMbGdtVDVYdFUzZ3Vz?=
 =?utf-8?B?MW1MQkdnUHBZQ3djbitqRlE3Vm9McUlQYkh5a0tVNENnQ2lKZ3JyR2duN2pr?=
 =?utf-8?B?eTlVRlBrY3VOeUJPbUJMbzc1aS93SDFDZ2huK0hCQjVVRlRObmEvbkl4eFVa?=
 =?utf-8?B?QkREb1N5eUI4cTFFVVBlWFlPd2FORStVd0R4UDJaQ1lHV1UzaXpZazJzNFRp?=
 =?utf-8?B?aHZvaDZTV2U3Yy9xZFZ6eitGOCsvQzVIelBscXpseERSc2VUdzNUeTdTbVZp?=
 =?utf-8?B?bnQzKzgvNjZSQ3RHbXYzRklqQTZhS090dGJlNk4xc2huM3J0QjBOR2sxUFlh?=
 =?utf-8?B?akUxOGFmV2pPSUZidmNkTWZib21aRmt6NUtNODJxckJrdWgrTGFEZDNFd2lU?=
 =?utf-8?B?VFRSSytrVlJCeGtTWGxZcGR2b21PTG9iNkQ5a0xxTWNFdlFDL2xjS1A1NGw3?=
 =?utf-8?B?OG5EZmprVTZ2UjlnZThXVDR0UG9sOUsybEo4OXEyY2Y3dkF1UGFoK291a0NH?=
 =?utf-8?B?MDVBUW1tUXZLRm55b2VqOHlBSklBcjh3UjFiNkZQeU9uYWtEc0hBbHUrL1hq?=
 =?utf-8?B?aWhqL2xYQ2crb0d1am5WQmVOQWhtYjJZYVR3MzlvaHdZMzd2OS94Z1pyOEtq?=
 =?utf-8?B?ZjBGUXhpcUFtb0o2b1hNQ3JsR0xMaTRSaTJZS245dUllT2hYcDFGOHpFZm1W?=
 =?utf-8?B?amlIWTVUYmY2cnMyMyt5K3EzTjZTYlU0UDRYNmt6RkxWZWgyRlpsM3pGYjRW?=
 =?utf-8?B?WWp4U2NPTVA5RzVHamY2alIrL09ETlFoOW9EMUEyeVphL2EwNUYrcWRMc0t3?=
 =?utf-8?B?OTU4RTZneTR5VlVFTU5vMHlNaEZxVStBWjdYY1pkNlJzaG05ekdYeXVFVnNP?=
 =?utf-8?B?L0tXUkQveDZrWThGTjIwWFYwa2RkUTRBcThEK2JCM0c5K2NRNmIwMUNjQU85?=
 =?utf-8?B?ZUN6dFh5b1V2aGNOcCtPWU5PMk1Mbk5RWjJNVUJYMVM5b1ZtTU9tbTRXOFkw?=
 =?utf-8?B?Tkdjb0diWnFBV2tBSU0wcCtORWt3bVFBbDRPWnRJczZiTy9iQUZlZmZHNFAw?=
 =?utf-8?B?S0E3WnBHVnFVZDZLL09QbVlOSkk2K2JEZ0tFdGlPSGcxSkdaNk9aaUUxTncv?=
 =?utf-8?B?ZnlNUmhMTDFFaTNmQitPRnNFd3lRZkwrUnRQTW9qaTdBdE1YSDFIVVB4ME1h?=
 =?utf-8?B?RTIrSGgzQU5EZGFmV0pLOVRlbEFCSDFXRytpMEdZSlE2ajk5VkdjS0Mrc3Bz?=
 =?utf-8?B?dXFpMlRiRXp3dkxCNVF3My9ZVWlDbWIwTmRhZlY4U0FYdjZLajh2TWQ2eE5Y?=
 =?utf-8?B?am1nVHpGbVBONVBLUmZ5SU8vbldubndBYnJrWnhSL0Q3cXhMOHh3cTVWeWpU?=
 =?utf-8?B?bHJ6WlBnbTNaSlo2VUZNS0lmc3JXenVjQmxxNVBlRHVBbjYvM0hsQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jw+BL62PKfNhyHMhAJVITjCSMDW0h7sWEqi+d5wOyXlpk694avjkXm5k5f4KQnVKpD003vHikjtlyCCjNhnQsq51e/A7ig5Bcu0vah+gPSQdfJhobjzoQRYckQ0SNDQGNr4gnZQUN+B5Y1/ByKgTAEwin2wdBNLV90uibz0obRXmaoYxjKyr6G4INtG/2tWUdhAZIeWJQiZNLBiaEyIX0sTL254cNZ2SCtDOHN9nXl4U+1ZIhvfVAatBDv8clHsPEa0dl/ewDtILV99ImjrId0wnrY/wO5HoeNb5imWH4Zq2Jr8VrRm9XN6gbbsiO5dPQ/n2Imy7Fa+v8sjZTnE83z+m7AKAVg/AKVZDxqx3HKOds0FGQdowzkBceryNH9qNcvzw3MqTqyHlmAV3rP68zs7VgrrVBMzS5UMKxDtH8HxBmtuxT0+rAXv5MBtZ77ZtgP/d/m760ccODi1jYiIzMhsbvzTi/zjPsy544ZWdVcNKDynGQXd8m+CGoe2Oik9+Ojp/OaH7//0z0iBUisgTM1OFFLA1PO9ak5bP8MeyZm6tJbz0AhdH5rEUUptIVcApuXWQyjveyK6/RXZPpyBYszXKuSWwfBKHMq//uxJvEQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e930cd-5e80-4aac-2870-08de6ec8b3e6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:35:42.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rITbKwgm1gpdevPCAu2sZf4pudDbi4ffIyuICSsXdswMeC8W7/+009lyOT7QhsNakc3cxcmHHi+gEJ5IGX0JoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=900 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3NSBTYWx0ZWRfX/rtH2GnM2AGo
 vtBhonoNLYlSBs320VA4mofeAW3mdLgxGqb1q6evZKFTS3I8gkRXov04WYTyhjKX6QX9rpKsM8q
 z3aG0toQLP/Clh9+Pd2GB9bBmx5k9EmIb9Ypxir2iYEX/Vw1VZF9OAYuUYCSmKDMELUKCT+qFh0
 hdVKMvszttmBCgSZFDl0dc3opK5r1yFMxpbyedEz8vMOx8Hymj331b5OjRj1uX4H8k9bu2fvD8c
 0SYquG7rYaEBTguu3MFBkPgVOE0BKF2P2OEkhO9y/65U2YHpN14ppO6sRdK9DqspnsRZZUzln1F
 jYpZ0ts4bxxgNFwgoBIPvomJ3GdYGe/tguZXJzVdAW3hxHDN+tXPbpUSlGnPLGszVNYfxeZh0ki
 dHR143Pq/oKqFqO/NZ/UuVERgPhtynNnM/DId9qiovWrOTpt2AqRJUQTpK1Qq3dZxFiSJfJ13u8
 Nri8YvWRbbkgmsT4PjRJeBA4N4g6sld5Djgm7lQo=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=699579e2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=vjwIlvYnAEAcYukg8NYA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12254
X-Proofpoint-GUID: V5c-XkhxfojfqbntibvnC22omQwlMHeZ
X-Proofpoint-ORIG-GUID: V5c-XkhxfojfqbntibvnC22omQwlMHeZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_003554_398645_25C1A996 
X-CRM114-Status: GOOD (  16.01  )
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

On 18/02/2026 07:35, Hannes Reinecke wrote:
> On 2/18/26 03:39, Martin K. Petersen wrote:
>>
>> Keith,
>>
>>> For nvme, we can detect if a device is multipath capable.
>>
>> Yep. Same with SCSI...
>>
> And that's how we handle things currently. We've learned from long and 
> painful experiences that there is _NO_ way to automatically figure out
> if a device is multipathed. That will always be an admin decision, so
> there needs to be an opt-in mechanism.
> And that needs to be set _prior_ to probing.
> And you need a driver-specific opt-out, to disable all devices from
> this driver for multipathing (UFS, USB, ATA, you name it).
> 
> Once you have that you can declare all ALUA capable devices with
> a VPD page 83 device identifier as multipathed. Irrespective of
> how many paths will show up.

What I am going to post introduces two mod params.

scsi_multipath.mulitpath and .enable_always

Any scsi device gets multipath treatment when either:

a. .mulitpath enabled and ALUA supported (scsi_device_tpgs() non-zero) 
and unique ID from VPD page 83

b. .enable_always enabled and unique ID from VPD page 83

And all of this will need a new SCSI MULTIPATH config option enabled.

NVMe host driver has similar params.

