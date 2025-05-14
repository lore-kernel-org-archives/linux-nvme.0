Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3ECC3ABD9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 07:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8q6kx8cRb3VzVOTa1Zrw/hiNycsghLM3Ce97fZwg5dY=; b=1n8jquDfU6MEoqEQuSH6JnPknh
	ss2BPU+kmT0/ja9yBBW3beOEuspWugTqlPT463IzsyiEZPf8OxuyfyZyTcmj+FM3Ld3APZ/rIgU6x
	Zdmq5bUfjnIlKHhgSdmBgD2jOqNSx6jznmnerDHt2CfMRMK0hGuyjEAoV2wsFM/E6GP0J8p2eF0bb
	xgvUQfJzq/KH05PIFu/pjC+ibK1tiFgifnpEm8diMbtSJ+A86+whvBo2vO9gt5CQ90WOzS6oO8uAF
	04ir0NHu9AW6Wx4krF7KvRynL4Byt4p2egs07wRdMTRR4XGuo4Z6GNU1SnvC8YaJRHvvbgtiCR2+y
	V+Ibv+EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF6PY-0000000EHV2-2N5T;
	Wed, 14 May 2025 07:20:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF6A6-0000000EFC7-3F0H
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 07:04:20 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fvcq028074;
	Wed, 14 May 2025 07:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8q6kx8cRb3VzVOTa1Zrw/hiNycsghLM3Ce97fZwg5dY=; b=
	U6zukAMaX2/A06X1wb+cEu4ClSqNqJfiy84F0DhAxyGc9f5DxJ+trZ+4r0a75+wQ
	j/OaylwlGlxYCQmIb8+o2uEpaYULFZsxBTyKduq6o71aYGvw7M4Yo7YQDw62y51e
	YhX4X5lEu4ZOUS6HQEy/uHn9G1qaBRBZH5BHz5VN+KnY3c55lV/BQKrmYk1r5F8j
	EKu9E5YDs9StGJYQmVVdiqb5pLjUBU1rdGp4vnysMrFcS8Wt3P0encYm5ULFI35m
	mFS9e9GlNNv7IQpz37Bg8pceKrE3/uOkZf8vDjuwoHsQ7hNQWFKmFKBX0espwma6
	eS23pbv0t05pb3bS8xgyig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmgw2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 07:04:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E5gImi016894;
	Wed, 14 May 2025 07:04:03 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc5f9tw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 07:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKH5VBCBNW82bFaT7oIXIVnO8QzBnEp66ackgYq8Uui8ah5NLfg8zVA9sPVDFxcodV4dpWlcdl4MaeLhibnschz5/r72ImqYoCOSLWuP7c2HEg9NPUZyLDAkJpiW1fI4yzV8I4aWblWixFQMj1Wv6X6oI+kKBIiqDiUgcGZ/7qq7Z8U9XuGcplPeQKsnKoD9dAmY/PJCi3UzymvzVnuDf+fDhuWnF+oRsAGtV7yE4Wgw6zXS0CHkSIOj/b6RTzNJVU533zz+z3cT/gGag3UaKpkQ0osxZN+/rJmAMMyAPSc3KG5GCAEUpjqB9vhHbbTjV9v70TdumpaVHk1/R4AFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q6kx8cRb3VzVOTa1Zrw/hiNycsghLM3Ce97fZwg5dY=;
 b=GZ/KqjTSFWsLDqCSVod3RdxJSsBdopDMSD9Qlpdk5agt2DG8OFTpb9sEZGn4jHKCgzo/WeQLes233zvi6xnBSI0Q9AuG5FBCG3iKVioEmyR7Vd2nU19xM7nSP0cNFwkDTB3pUCYHho+pUzFb78H5IrcIci3/M3kQ3dBVrMbTlU2Db0AiuwcAJZ6NR4CO3X4onbV7CsV+ZkarQam9Ia1ncdn6maobTkhGXbhG8DcGRbgZGi2YgHB+m+71LbG8dsbm0Wr4nHvBRnXJLVS01tj7mfhpCvTcgGF/nLKgRW7BT/OhNw2A28A7rIFmEnIdQDpELCfdIcFiciMQV69MxytGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q6kx8cRb3VzVOTa1Zrw/hiNycsghLM3Ce97fZwg5dY=;
 b=dEBBgBfvaD8ga6DM7CUcUGIGXFibudY8KY/AeJ1dkxrYIoW6r/ZAe8GHJdDVV8DYJb3/DSJxgmE0/Qga0jB1CGSnQwy3fgsR33om/JjvPBciFWOmGUzyVhL4utQ9hXdsg6Eh0Dx5+V2yt8By3p55bhGaMDMX616G3T7j7ZdGwPI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Wed, 14 May
 2025 07:04:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:03:59 +0000
Message-ID: <908caa6b-b904-4a77-9970-36ff61f759fd@oracle.com>
Date: Wed, 14 May 2025 08:03:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere to
 a common atomic write size
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org,
        kch@nvidia.com, kbusch@kernel.org, sagi@grimberg.me
References: <20250508223802.277311-1-alan.adamson@oracle.com>
 <20250508223802.277311-3-alan.adamson@oracle.com>
 <9ae170fd-0f27-4da7-b475-61530b061c85@oracle.com>
 <20250514053546.GA24782@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250514053546.GA24782@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0273.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c465f2-e676-4158-25c2-08dd92b58058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFdaVXkxbG9GY3U3R1VBb1Vja0cvSzlMZTJuTEloY0FtTDRQTVpYTVZJTmJt?=
 =?utf-8?B?VFVIWS9XeGN4U3o4cENKMEdlbDNQRjZvSzV5ekdyNjc0N1lQNjZWVndCVlZJ?=
 =?utf-8?B?Z1pTK1dPWC90U2dwaHNya29KZ0xSV2hwMmhmOUdEdUtjK2p0WTd6Z3p2Zlc2?=
 =?utf-8?B?TGwwQjY5TDVVNFdPWGJOb3ZEaFJvNjJpVzJGWUZIYlcyM0k5OEQ4R3k3QXUy?=
 =?utf-8?B?MCs2RkhnK2JkZXVpMDUvNm9BT0dkdHVIMWc1M0pOTEY4Vk5icFUzTlVUTG41?=
 =?utf-8?B?ZGcwUkpNSDd4cGJJblhnekVqZHlObFZnd3lKOEF1TEltbTlNbjNYc0pSZlUz?=
 =?utf-8?B?bUJlQld6cXdRTDZJemZYWnVnL0ljZTBUNi9tS0ltQmtJMWJUZmtyNklxeXdn?=
 =?utf-8?B?ZnJCcXVsU0hjVlBPZGVGaGprWkRBd2xxRUxyd3FWUnVDcE9nUHh3REcrazhX?=
 =?utf-8?B?dW1LbTN2U3R5OHhLcGJYSFhsbFgzNzloMUxFL2tHVjkyK2hQTGxqeTJ3MlAy?=
 =?utf-8?B?TXJYODBqTlJiQkl0WGRXWDJpMWtQK29FczRTbWgrL0UvTW9DRnpvMENobUF5?=
 =?utf-8?B?cHpTRTdVWlhxQkRrUy9ZNkphZUJnYU02djVaU01zeWxVR2lWeHNNMTZoZGhH?=
 =?utf-8?B?TTJPZlFPd0ZSbWRDYnRMUGhQYW5CM3JsQlhFc20xay9jV1JUSE5sN01nM2RJ?=
 =?utf-8?B?Q0lYNGFvMy9VTFNUMmxhWDVoTlIwLzREdFJQYTlTMlNpNHJGa0h1ZzBQaTZX?=
 =?utf-8?B?RUIrUi82bGo1UXExSG53S0ozYmpranlpL3pRV09mM3BBK1doUTl4akRNU2E0?=
 =?utf-8?B?Z2VNU1E2eUZ3dDc2djFSaFpqaS9vZmZEZDBFUHVScWpXYlNkUDZKdHFLUG54?=
 =?utf-8?B?eHNORmQ2bDZHUkpVNnpMWGZ6b3hLTXFpNGR3MTBoMVlKWTcrVlRXc1RmYVZX?=
 =?utf-8?B?MG9hU1ErL3hFQldhdk5FOHV5RjZrZHRETzhlQ3N1M011ZUxQTHlLckZaTEw2?=
 =?utf-8?B?U3E3T3JPNnJZM2d0UDV3d2FaMmJ4Z3h0QXliOGZPZnFtOFE1WGwxS0JSN09y?=
 =?utf-8?B?ZE5xZVN4dWpQcXQ5STV1OW43TzNhQzdNT1FndE5HWUhRVnpYdDlTdVVFQVky?=
 =?utf-8?B?b1luVU5pRWtvNy9OczBiZm84MmVoTEMzK0cxaks4MGlOcTVTMEwrclNDQXRU?=
 =?utf-8?B?bTBjZk9PNk5DLzFyK1lCelVqeDZOd082UEhFMXB0RU5vTHo4T3BZZHBvSjdY?=
 =?utf-8?B?ck9oUHVNNGZGSGtrYVFyTENoT3d1cXpZUVlLWHhDVW9ka2Z3TjZSTUwwTjZL?=
 =?utf-8?B?YXNMYXN4dXRIc213Q1YxbmpmeVhqeE9hQWFSRWMrU1VMUHE1MlV4WmZkYStN?=
 =?utf-8?B?T3NoOGRsZExhRWZ4cCs3dC9wT2F5eE5CbXE4WVdmb29mME5xSjAyT1JLeHZs?=
 =?utf-8?B?Sk1qbGxzT1NnOEZCWGhnbytJM25yKzlwNXV2MmVsMnRxaHQ3ZDkrUzhGM0VC?=
 =?utf-8?B?RE4xV3pDVHpkYlFMWHNXM1B4enY2SmlKWk55UGlIaER6bmdUL2t1ZHZSNDZX?=
 =?utf-8?B?WWRHUzYwV1c4S1RDbTYvd1J1aDA3YWRDNmxhYnRwVWNFQ2JGeXFiRTZwc1Jp?=
 =?utf-8?B?cGtXQnF1NG9TUkNyTnAydS8vQno5N0h6ZCtCQ2FhQ2JBbE8xUEQ2Q3VaWE8z?=
 =?utf-8?B?QVFsNXpuQ3J1eHpFelVFM01jdWtmOTdKTFhwWWNJd2kyU2Z6QnRKVHZzT0Y3?=
 =?utf-8?B?ZWE0cGhKSHBXZ2ZzZExNOEFhOFR1WnllWTJPUUpqV2ZXazl3a3AzL0ZZUG1I?=
 =?utf-8?B?WkFWN25OMHNxQytRNTRlZ0YxaWlSRzhLdlA5RWFCczVSZTQycE52MVcxTkZN?=
 =?utf-8?B?aVg4SE8xWmZsanN4K3ZIdWtCaFNzZ3lPazllOUZHYU4rdDRBOUt2NG5CdTF1?=
 =?utf-8?Q?girvGXAo7uc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJqeUprN08zMUI5U2VsVzQ1RnYybHkrRGtXWEt5NXZJL2JTbkVBZkpGT0Zs?=
 =?utf-8?B?dkZCQVZ0d2RVMVZMTmE0YlB0cXJ1dG9LOHFYSFdLM2k3andaeGNQTXpNUGtQ?=
 =?utf-8?B?RUVQRkdIaUtBRWZFbnJvelIyUFZLNDcxNDZiWEZqOTI4MHRKeWoyMkF3OGVm?=
 =?utf-8?B?SzRLUWl3STYybGRYQXdWVUJETWYyRXJsbGpxeW9LWmVlR1lLSURnWTBodHUy?=
 =?utf-8?B?T2Noek9IdFJTL1FzYWdXb3B1UjNrNTFyY2dENWpKZGgvU3lRTHBHdnNWMzV2?=
 =?utf-8?B?RVRZVVBrZGZBLzB5V21TcFFSZ29tQTU5aHp2ZlZtbFFzSm5leEM4cVJYTHAz?=
 =?utf-8?B?TERlcis3UGU3MEZJNEVMNVRkR0w3NFJSN1lVZk5SNzRUVWdETXV0S29mSTdy?=
 =?utf-8?B?ZlZoeTJOWlBVNFI5OUNhbVhDclNyR3o2T05Lc2M2SEhkdEVqRDhJaDFDN0lq?=
 =?utf-8?B?S0dlZ25PY2pCTkFXMlBXY1Ntc08vMXBFcnMydm9zRExmYTNQM0pub1FEQVY3?=
 =?utf-8?B?ZVZtWXdENmt4aldTM1pmVExqeTFRMWVpWkpzWjhmMmhsWCtDN25yNzJZUnl2?=
 =?utf-8?B?TUVEUU9SR2NSYWhsZHRjUGZycS9KTktxdnhqUk4xUjgxaU9ZVmRIQStUWlMy?=
 =?utf-8?B?SG5jNk8ydHdrUnRtTDJ3MUdvTEVkMjlrOGpUeU9OWm5sV1JtVWFhOUFuM3RQ?=
 =?utf-8?B?SXIrditoRkpkbml4YnVrd1pZeENNK2Z5M3djckNvM21BaFRCQ3RnTCtCaWZv?=
 =?utf-8?B?U1RKNlhpRVlXUkEySW51N2dQczRWdjBZbXRGQ1RUY3dyTDQ5amQ4ckEzbSs1?=
 =?utf-8?B?V3JBWWQyQ2t2dHNuSmV1NFFKa1hNZmlUYU5OcGlFWWJ3OUJabVlYL2hXUVZ4?=
 =?utf-8?B?SGdSRktoNDlnU1V5Uy9wemdUdWEvVHdMVFFzTEQwd1FrYmFjWjVtU0MwSGhF?=
 =?utf-8?B?SEdJeFQ4dnNPV2pqRUQyVzdkTVBhVDhLRDV4MERIbkdBa2J4VUU4WElLNndK?=
 =?utf-8?B?NENTTWR3YUJRanhJRUhlY0hyVjBDVGZFOGpSa1B2NDErcGE4NFk2enl1MDBt?=
 =?utf-8?B?SHBuTkpQUkNMTWZXNG8zcVVWNmxoZEcxWmRXc05YUHhRbHlzVHdWRldMakwv?=
 =?utf-8?B?TEV6Ym5NcDE4NnI4UnFyV0RtR1NodE1qalA3Q1dMdC9tNXFKNUFvMG5zOFRM?=
 =?utf-8?B?QlBjRXF5VC9Qb2xEOGRiMW0yanl2RkFtdUJFaFRaNzR6aS92TkJRUkVUTmhF?=
 =?utf-8?B?RDMvNExZbnM0Z3h3N21hMFlUcGJ6NUtRaTRKVlBBdThKSDBaQmdGVGxjbDBN?=
 =?utf-8?B?U3NOeSt6cmx3U2V5bGdSUlprNkk4VW0vYTBQSGV3czNzZTE4NTFndU5RT1BL?=
 =?utf-8?B?UWU2ZHFXUi9Iek1qeVVJVlBVNU1YcFlPaHJ1bzRyL0twd3ExaFh3S21HREcr?=
 =?utf-8?B?Nm5JOFJEblZNVEJIOENIKzdBK0I2Ty9VRkpWbjBUQ0Z4UjU0azhnb1VUdWJ2?=
 =?utf-8?B?L25vcXd2RFQ0bzBHMmppUUp5LzdNNzZoanNtMTA2UlBZTEdaa3g0ZFVhNSt3?=
 =?utf-8?B?aEwrVklZbmFCUW56WWt1aHBEeWxDbVZSV1B6Z090bld2NklaSU1naVVYbHpV?=
 =?utf-8?B?REFDbG5sbXZ1M0FMSkFUWXd1V0k1QXJSZmp4RFBUZ2U5VFl4UGVLcitPUndn?=
 =?utf-8?B?cUdwWTZLWXFpV0czMFEvM2NkSWIrZVdpcTZDNmlLNVdvYWREWGFlWkdkaCtZ?=
 =?utf-8?B?citleU5IYXk5ZWE4N1VkbWFmeHB0NTIxeHFNMFBiUzdrSitWR2dmSWtHaHlr?=
 =?utf-8?B?SlA2YUZxdGo1b295ZmtGNzB2T3ZDd2craHZtVWV3dHc3MmlMbW5CRUVMWmp5?=
 =?utf-8?B?ckpBQXZpNWZ0dGZHQVNKc2lVQWhsVkp3V1Q3V2RlTHRlbkMrQVpnZnVUNjRy?=
 =?utf-8?B?OXF0UHZUcmowbk45NzBUR29yc215ejY2Y2RqdVZTMGZlRktXKzErcHZKd0pL?=
 =?utf-8?B?NitqRkM2UHMvN3pGL1ZGQWdNUWxVZFM1cTgzV2xBc0JuZDZxSmpFc254YXgv?=
 =?utf-8?B?dUozSmVuVGhPS0JoVFlBeWcxTkRQS0V2N2lqa21Gc0d6b1hsYmxlNTFiOW1p?=
 =?utf-8?Q?pTczF3GhwlGdjfpj0wmMtq0jA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /C0X1Baqy63GCj0X1L8/4jgu5Oxb7CkW3sxoXhmVnwW/JFm938fbeNnp5Dm1kblVkUYkYwJUNpOgzNdXM9S592JBtMNOupTTAGXB6VESRmdOxwjQWtSwiY5e2hYvmCF+rl33V7ouOTmy6D9ojvkQFGZIsh4BnhZBIdep4vql3uApi9fiOj8IgKXyuKZRpUD17SIzaw9ZUWvRGXlMVfdqMBZgjhsBtSjmzmfdSGTgvf+ux87qz17qHGyR7jE2wRUclEJo6EDJXy2+3H+8+BoI7gHKW40CU/qpYrnNuO94tGVbq12kxhLIfJNUYz9uqCaa644cC86GlPd+LIbqLIojA9/iZdFw4G7W3DYilnoDQeEH7XyDvjRlrejUKmy0JeOmKxRExoodx/AMff8nYsWuiHOIgLfVLbmx74Faps8+YQ3A2/rOExmjhu8PKRWyKNMNKZdtGcZwlzSVyH9A0qlfDB6I1b9E+kbxds69eHbBFpiChU8YCoulfD8Z0y+42kmdKMLMBPTPeTUZCMqYN7LsBm4hkGQVXhkFuQOjcGrhjd5AUNpJsMNjlymQQgb7mzJoIKdNJvZxDJc05cgzujlcPCQTvwJDT1U1edI/8bQt0pg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c465f2-e676-4158-25c2-08dd92b58058
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:03:59.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8JakeHLiv5iG1ZGGOm1YndLDAT6WQPVLTlcuY7n0DAQ55rer6LzMxdBDWAxXMFnNAjicDa7Bf6PIChFaGM3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140060
X-Proofpoint-ORIG-GUID: 3iHRqfMlz4NCeOvv95WI26zfbLqYEVII
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=68244063 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=r1Cc1G3hxZwiHpn_nf0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA1OSBTYWx0ZWRfX0ABuBlrb1Spq 9lrGxBENdAEZy7U8ZuEzV/dP2GAotEsEWJ7WElWX1dmiUCjip1XGzDgAcqYuvkKRtsCulksWiS1 lIRsJrrfH9NppUVUEMiN8DN5MofqD4mAYbQF71WC0XEAUWviyF7dOweBi5ItfoLpE6WHFGOiu04
 WcMr1bfTOECdK5qFnAfz20Nq9v//nUkISI2/XrgW9DZDWgThNRyGLnbwJ92kmoBQ3GwLvW8RPf6 KpQ1DIMNwrHXVfdhCOLbJ2yOHgZKoVGBVozTLYvwGaDOsR/NKC2IghdCmcRGosF3UrVxA4J2+Qs TCDa1Isvu+wbSHaFaxXWzKVdB5sXw8TYLdQHjDTbTLeRpDgZhfCwumjbiQxuGyjtHixCUWZD8vZ
 77eXuXMPZA82oiFPLE6PZkL/zLxjZwqIlLpn/TyntphNpry4cOL3ZWcDCJGwbP4WzPSgdYGc
X-Proofpoint-GUID: 3iHRqfMlz4NCeOvv95WI26zfbLqYEVII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_000418_827927_0C045E46 
X-CRM114-Status: GOOD (  16.14  )
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

On 14/05/2025 06:35, Christoph Hellwig wrote:
>> I am not sure why use > and not !=
>>
>>> +				pr_err_ratelimited(
>> could dev_err() be used?
> Yes and yes.
> 
>> "%s: Inconsistent Atomic Write Size,
>>
>> we could mention that this is the powerfail atomic size, and not "normal".
>> But I suppose that we don't use "normal" values anywhere, so it could be
>> assumed.
> I'll keep it as-is, the message is already borderling too long as is.
> 
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -410,6 +410,7 @@ struct nvme_ctrl {
>>>      	enum nvme_ctrl_type cntrltype;
>>>    	enum nvme_dctype dctype;
>>> +	u16 awupf;
>> was it intentional to lose the " 0's based awupf value" comment?
> I'll add it back.
> 
> Can I get a formal review tag after this?

ok

Reviewed-by: John Garry <john.g.garry@oracle.com>

