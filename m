Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E6FC71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ysbMQJYBo7XUIbPVZAZkZapYx0N7xMuXOJusHpt1QM=; b=lTy4WKliTkuV0j/L0FSvHKrfY0
	adHRa7L9MM6Va3/e5EJnQtHEVq7Z+pnnpyRba1Km/Wxgpg3yqWhMQJI6l1zwGyajQWNRXlsb29yww
	ygLGaNIMkhBDG8YJFtxalj0A39sTw9xY5HUEk5dL39RgMXoCDofJVLi/ORuk0RhOHoFvCYh1bsMW3
	+mTLNODSTgTkaLWVPgo9KQ2Ady3AyTFTxUeymqc2whvU2JlK9cedG2s8pZG4s8778qDwdMqdCz4Jk
	nuReNAxp286P3pXJOMSLOQQwgWlP7VHzHCp9D0td9PNbPQg7m8rRI/BD2lV6l7Eok2U5MlN3IerFg
	F4hhIHFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9P9-00000004RuI-0N7g;
	Mon, 16 Jun 2025 12:57:39 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR8Ls-00000004FkL-2hRX
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 11:50:13 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7fhAL009145;
	Mon, 16 Jun 2025 11:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/ysbMQJYBo7XUIbPVZAZkZapYx0N7xMuXOJusHpt1QM=; b=
	G5OON3GkghxTVcT5XUrlEaKo7afEvNOidwQyGrmfmxHYYAkB4SgUeqHt6uzhQqwx
	6hLtEV+rd6PIE5NndSWJydBOEBGJ3WafCNYEAdXNWV0dXmC6+vd8ZMgKwA3GPtrO
	r441dTzfq/2gVO7N+QWEXn4jaAMTqId2OA3vf/28hLMnXz0pIkfvVS22Hb3L42Ro
	dRU/fnWaqOC/C3Ck2NBgzp2dEVUOptm9GZX//IuOh1MePcHzb1lmYmx84L8CqGB+
	6FINhWKhaXbzmg3jwVWMT9AZlKO786G8iizKWJCshYHj1+CM7Hwc7Ksv+sKDOb9W
	ft4/Wuvn/bzRli+fRk1udg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900etard-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:50:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GAiO3R000846;
	Mon, 16 Jun 2025 11:50:03 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7tbat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls93p4t13V7MS567N7a+E0nKexBfX55ogB9QEpjn5OzDcGwstA4QrWxRQpzIwHUyFpK8mP87ZbnVGZzEkjhSd/omRge8GW3i33urRPoQxeQj0TnX98WrtEAQVeZVW7Wpg6aLWDGXVxDSoybWneoqEDCErtexc9TVEX+Ab6o6WPx6QIsp168u/Bk41JfT/KPmAE+cSAtd6OEGauNVM0s2SLQgeliBnJJOvwcTRKESnkt/Xwi0W5e5xkEDlWjEgrQT0rTx14paRrreohc8LzdnyhfijtDDwOGZnX83T2CIAq1p50HO6Lhx0ZTua4MjE+CF2DBumX7D+7CcZ45AEdtkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ysbMQJYBo7XUIbPVZAZkZapYx0N7xMuXOJusHpt1QM=;
 b=cmyT906HEg/tIOnUa5nK7BZcwf9T8eB6uLHYmfZdPCdSVsfefzJiMuBxkvwNKySehDNbuthRE2ZYkTTPEW8PgnspJMudmSd0T4RW05VZtdWV0BzVJ+Rkw1IDzNRvXV5HIKdYqqvi+KFijbVv805oromK+rq4sliwMZkuVLxG5QxD0X6tA/4F+xLeQz7ktYRFuuiNQaYQ8ibMMtyklwwLPPovN7tGxB9J79Do+j85KeV4yekh4Vvq/5dOjDOS9uaoCLJfSAea9YBDI5Vnf4mdnl/upzHsdhS/9kcAuJF4Y1NX9uyW56h1JEiZKQ5ZQgND2sCKge3Re7aa0Ee7grvDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ysbMQJYBo7XUIbPVZAZkZapYx0N7xMuXOJusHpt1QM=;
 b=OGYUpJS/rwok0lw1gqGMKvwOh/JWP8MyMHBLdixR4mDbWjx9Mccs04v4sS/2jUW/i1oLOQTNhqoho/L5RhToMqj8o/Jss1r/Cqt/rkOD0smOU9GZ0Uk/DgdxjYcOD9COEy/qGVVMJnJ2V7XdVCUfHWt+gdiRpI/hT6QTgrB2BBE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6404.namprd10.prod.outlook.com (2603:10b6:510:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:50:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 11:50:00 +0000
Message-ID: <c3341347-f6fc-4d77-8a04-655a3c220103@oracle.com>
Date: Mon, 16 Jun 2025 12:49:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Alan Adamson <alan.adamson@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <20250611055432.2401372-3-hch@lst.de>
 <19e6e970-9bda-4822-8c86-e3387b1b4594@oracle.com>
 <20250616113755.GA22348@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250616113755.GA22348@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: c94b8c85-66be-4444-e483-08ddaccbec47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2xTQldCSzkxaExtNkhNbmh4cUxnR1RrbnhESkxOdDk5T3paMjg0SFNqanZj?=
 =?utf-8?B?NWNaeHg1N3ZrSGpwZXFWTFQ3cTB6a0REcVV4K2lmcW1CanRaTGJjb0lIbmJU?=
 =?utf-8?B?MlZ6V3VUekNXbGEwZlZDYS9RQi9tb2pUY0l3UDZmczRsYUhmZFhZTzFKbW5Y?=
 =?utf-8?B?SUFINm9ueUhQZWVLM1pFV3FOYkk0Qkd5Wjlob25sb24ySWtPV2JHTlR0LzFn?=
 =?utf-8?B?SGwwaCtGVlFvRnd6RjVrN0NOd09NNnZhem53UVYyZWJLdHFpL2Zxb0F2S0dt?=
 =?utf-8?B?eVRzcERMWmRmcHpaYzh6S0lXTE5GcUVnc0RFSEpvYjJ6QVpNalRVNEVGMFYr?=
 =?utf-8?B?eEVvRllqZ1V1djVXYloyZ01xZFJNK2FneGc3VjBIYXNJWURlQXl5a0t5VGw4?=
 =?utf-8?B?Y3FFZDZDSHdTckNvRHJseGdlQk40dmtRTkxuY0YyUHlIUlhPUGQyVDI0OHlE?=
 =?utf-8?B?bXVtNEZBUUtUckN1a2pnWWxEQVF4ZWNScExvdXRqN2x1dG1vN3UwaTVRTFV3?=
 =?utf-8?B?Q3pPQ01mY2NIUkhqZ29XeklxT2luZlREZGFQN2M4YmdWWjNtSkpxek1BcE1P?=
 =?utf-8?B?RjhuNnBzOVJDMk5EZ0JJZllONEtKeDFHbWhLNDlGNGNMMXhSWlpmUW5RUStL?=
 =?utf-8?B?SENHK1hvSDA0VzBXQVpQTnNLdlc1R09UZEdJQkpuaEdBTnNQTW01a3NpbEYx?=
 =?utf-8?B?ZmkrbmZMMHpuNFpLbmVaaERzK2FJb1NraWdiTjRMSnpReHBITlZ5OFNhK042?=
 =?utf-8?B?MG4vamV0U0NIaUxWTnZKTERERXhoZ25mOFVtWTlQTmozVm55aTRXa0ZmdERt?=
 =?utf-8?B?UTBrQUtEb2tBbDhQdVFDdEY1ZlNSbGRlSDhWaVlIczJuaDMySEUvOXdiVXV3?=
 =?utf-8?B?aUhyZDVBNHo2dXRiMDZDYnNOenNLY2VtbWdFbmdrTGUxc293VGNiZ0NYTlFH?=
 =?utf-8?B?Zi9NUlZsandra1hMejloRUZzT014R3d2aEs0TTlpYXk2N2cvY3hISGkxcEZE?=
 =?utf-8?B?V3B6bUpKSDQxcXo3SnpmK1lucEFiYXc2UkRzQnpEMnRoSVVRWmpLMzM2TVg4?=
 =?utf-8?B?YjJnaDJJSWI1SSt0YkErSUd0YkNnczB2UGhxTWJienQ3VE5IeS9IQ2VYSzZH?=
 =?utf-8?B?eDI3TDlrR3VpTnFvdkYzOWJ6cThERjUzNUlRWlAvWTg2QnVwckROa2Z6aEs5?=
 =?utf-8?B?OXJpa3YvZGpxb21zY1d4SW5Rb3UvZUQ1WjRyMTM4SzNSYXV4eS9wZm1KMnpm?=
 =?utf-8?B?Zm1xQWhxOFlrTzdFcmlHSkRpM3VOUE9pMlNGazBYS29Hek5iWUI3TlUxY0Ir?=
 =?utf-8?B?bjZ6cUlBRGN2eGJERkxGbkpMcGtqRkdITTQzUG5VTDJDYW9PeVdGaWZyd0Zm?=
 =?utf-8?B?YzV2WndhNmF1dFBuUW5FWmp2c0p6WTNXY0gvK3ZleHZ5cGdiZ2tRYUNhRVJ4?=
 =?utf-8?B?OWdxbmo4b2luMC9oS0wvdWx4SExBTHR1UHRHTjU5VU9PSzVPWk94ampnaXp3?=
 =?utf-8?B?TllHOE1qazZySEoxM2ZXZEVSQXNzcTBOSWhaTUFtcXl4RStPZGFlc3hiUjlF?=
 =?utf-8?B?bTRxQWJpM0dNbmxneWpHc2NaYm42dmgySW5QMkZWNGRCZUxOYiswM0s0b1VG?=
 =?utf-8?B?b05hYXlLZmp2WDVMa0lKUGk4Qk9Ya0xpRkF6YzJuODVRQ3lyNklxckI3TzE0?=
 =?utf-8?B?QVFQNzAyQjY2MkQ4L1k5Uno0MUhmVnJyd1FBeWtpeVZoOEpsMC85dGVaSXkw?=
 =?utf-8?B?L1Y4RS8reFIxdHlKT3poUnpBMVpna3JoK2dFSDlSWTVjRDdIckNqWGlrbUZv?=
 =?utf-8?B?UWNYZDkybkZrV3dLQmpILzRBZWx4SnNscXdVZDBBOGVRZHhoRkMwNk5JWTlG?=
 =?utf-8?B?Y2RKOENlUG5qN3RpbEVaQkNUMGtOcW9ORXl2NUNvbjJDcUFkZXV2QkF1RlRT?=
 =?utf-8?Q?hv3FD9yUb2s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JpVzNqOERDSlROTGwxZWZuVWxBWmp2TUFkb2RodWwwMm1TVHZNVXJlb0l0?=
 =?utf-8?B?SlovNTZkeVhudGIxcG8yVGcxMGJoNGNhUTZrZnMwOUZNamRPN2FtQnpzYmta?=
 =?utf-8?B?UkdEMnJIbFlVZklyS2FldVE2UXAwRFlodTl5Z2QxM0pzY3l1Z0VvZzdDNFpU?=
 =?utf-8?B?VGVubkdoNDBDSE1RZVI5ZUZxUXIzQWlGMWxnQitzQ0N2UnpOS3hoUUNsYmN5?=
 =?utf-8?B?RHJUZytXSkdPSlBLRjRWWGlaNEI3Q1h3YktJRnA1MGJReExnb1R5aUxUbFVI?=
 =?utf-8?B?cW1lL0RJN3NXN3o0VTB6QUJQZmc1b2RNNFovQWFrUFh0YzFQSmp6U0ZRM0lB?=
 =?utf-8?B?T1IrTlBnTCtuSEgzMDBmcllzVmVmZmd3RlRqWGxxVWhWU1R4UmhxMFVZY3B3?=
 =?utf-8?B?RmtJRHdManFvb3MybWp3K3JCd0RERGNHZkxBc04wV2dJeTBTOFo0R0ZNUmJ3?=
 =?utf-8?B?dm1XMkR0b3FYa3hia1FpTzZuSTFUVmhEczFEUnlVMStGN01FYmUvc1hPRXVX?=
 =?utf-8?B?b3F1Mk53WHZEbHJqVXRPV2RjQ3NPamhXUXluTGtHd0tCcEx5NDBwNFNQV2JL?=
 =?utf-8?B?YkdQWS9SaTdNc2JLbk1vUGNGR0QwbTh0eG9PT0lBZ08vTEJRaHcvUnlXWmM4?=
 =?utf-8?B?NlRzck5kZ3pKRWVJQU5iS21PM1czUlpTTXM3azM2bVlLU2dhUkZ1T2dCOEs1?=
 =?utf-8?B?aVNyUmlqYzZ2Z0VUVUlxZU9yWXZvdW41NU4xVndvWmtScTJrS3VFQXhBZ0lw?=
 =?utf-8?B?WVhxUXgrMVpkek02amVkSmZSZjlXdFhhdFYrUVk5Q1ZmUXYydHE1S2wrMWhJ?=
 =?utf-8?B?QzBaaWIxNGxWcjcrdWFxMDBVekhzYlVZSzU5NmVWTmJyYlJ6RUIzdERWYzlG?=
 =?utf-8?B?WmZSL2Z0K3daMy9rbUlGMmVlSy94UDZhWksvRlBKdGZSbm9yZkRZS0x0R2lt?=
 =?utf-8?B?OUNRZ2hETnJxS1lQeS8zZnNiVyttblZOL2VaM1YwdlEvYllIUEo3em9pN3Fp?=
 =?utf-8?B?K08zZ211dGo5SXVzOGQ5eEVwM1NINEQramRoZUszbjZIbTB1SVM1bWV0UWN0?=
 =?utf-8?B?V3FzK1JXMSsxMS9jbDRXWmZNbUQ0djNQQWkyWDFNZ2Q1OXAyL1F3K090cDE3?=
 =?utf-8?B?a04xa2pCSmRrZC9tRWRMZ3lRUWUzb0paMjZvV0NPWjlnRGZVUTYyS2dmcjVl?=
 =?utf-8?B?UjN6czd5OUx3MDBuaXpEd3cza2tncGh6ZUdlS2NuRDN1YmtTV2NibnRPaTN5?=
 =?utf-8?B?amZ2Wjd5K3AwY2Q3VVl4QXc0Vk5vS0VSKzUzY2VKeHhXWWtRMFNzakpQZ3kr?=
 =?utf-8?B?Z25RYkJpY1RDRVY3MnN2NG95czMvUW5kYWRrVjNCU3dXMVB6U1d0akFrZ24x?=
 =?utf-8?B?WWdFdGJxeVZwczNYa1cxVjVhTTFGNDJJWkx6akE0RElVNGdUWWwyRkpqb1oz?=
 =?utf-8?B?VmlxYnJkYmNKNmpjcUw0SzVYSzhVMlhjTFR1SjUyTFRFMDJoSFMrUEJ2NGxM?=
 =?utf-8?B?UE02L2QyK3FJYzFnbEV3ZVZtK3M3NFR3RWl5cGhMMkJmNGRxMW9pcWg1azYy?=
 =?utf-8?B?RURhcEVLY2tuSkgrRFlLeEY5YUZwU2doVkVnQTV2dlN1MDQreUJxSFRpRmVW?=
 =?utf-8?B?UCsyNUVsVWsrUzNHWFRaMU9qa1BBVDYwK0RkT3ZNYVF6d2ExY1pMN21PdlNN?=
 =?utf-8?B?TVJwZ3hXSTNMbENrbUoxd2VNUzVzTlFiRDViSnhjbmNFS3liSWMwMEJqWnhX?=
 =?utf-8?B?RExWTDQ5dWpBK2cxUElWZGl0U1lXV2dxbXdqWjZWTm1HdmhXL0hTM09XOWdi?=
 =?utf-8?B?ZnB2NFMxZWFrNExGeEpZSkU2cUY4dDFITGVXTExtQzRDVnEwTXlNK0kzSlFR?=
 =?utf-8?B?dVA3aGxFY0dXTFZaM3RFUTh4M2VYTTFqaGlIS1lFV0k3RXFZUFJmcmpBLy8x?=
 =?utf-8?B?VDhNcHZUeCtIUWM0M1ROQTFJYjF0UFNVUWF2NWI4RE5BTVA5WGpwcXlhc1ZQ?=
 =?utf-8?B?YXZsWkxVSGJTZDJBQTRaWGNRbUZIRFl3SG4zMmNlRmR1ejc2RXo0Mm5LQXF4?=
 =?utf-8?B?TUlObmtRS1hHUlhoNTk1NDZSZm9uSmNheU9XN0VIR2lkWC80SEZXMEdRaTgy?=
 =?utf-8?Q?O/ejoIPFnLBrUo09fuHCbqkZr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Y0E1gatWVYeGnDH+8rf9uRyXmDCD+69jndalnA+2R8Gte9gvOV7dwxJBsE1uG+WXERstQQTwT8GP7ilbrtWPCcvRV8FyQQm3tewvYyjEsTozhArYqRsFSUwiPmzpYrsQT0cSe2Ttwt6tyC6mOJN14ayMuDvUVu/8krGYerFsazsEcUq7vLQCdXHJStFk8/6c96wRKLx/ovq+KQ7F4vXYwKVm3bwcohfZhq2WfkVR/VbLwvWL0Xken+L9e4Adn1l4PI3fJokG1wR2TVObBeSI27u/+MD5e4cnEfRvGDk6AfKGbQ+k4QSkw/Bjlscqx3/02P7b7zpFso0YG3pqhdP9qcvFKUDcei5zHmWX7VwnNx5Oq9jJrfsAYBEixHPgFvuXE4WD3PZskheeCpxMyAwl+Ivf2QBoW9QX99Rw02rBoUIfMPDlS/qPrxNEfumPVKc3GypfCrKeA/ihycrE+yT3eUmv3eV/yQe7C8YDFa3ukiUHC2o4/w7jBeSX46ceEfaDC/UzI526LJ4Gn9QW08L/THxvvh0h12iOU+Jh4ZSDpqIAK6p+E2xknNuIGS3QD5lFqLekGRnBklLLmyhECzSaIIksvhPm2nFIJPxlO370JI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b8c85-66be-4444-e483-08ddaccbec47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:50:00.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlupzzV9BpFJBF0Xfc0frq9ek5z+X79mTaJt3jgGhNlZgGQtiB9jEW8kuYrv5jfAORGJJrULb8DSGeQKWvrhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA3MyBTYWx0ZWRfX7KTSoUNrSf1Z aeGh4hn1puYrphJqStf6rpvf00RZJMkJKpeMOJUFiKFxRYXugW4wwHHR0nVjcD+EwN5UZecB/xv 9ayWsfDh0sbFEnlZfSvdv/yrrQFyf1Yt4ScXWRqjv+QueCZmFr0JRlw/xkEYSgh7Zs5ddmnjaOJ
 uULtTGZfBsMuyRYCcCpWu79R2OPqHDWgY1Wytgk4YIbBYAhgt+IH6UN7B3rcQDrikhtrYbN/2KQ xZH2IE1RYWoDUTDPsI39y9bjxb9XaZFUo6s/ULuFoFk55VIkKKkREPLoMDuMihjNOpH0nld+c5S 2vAChQL0eng/TjozWGdY+dFMWB02pLTrZcCstRLTMxVdKUUYO4WO3MFmO2MqkpxRZXY87jT7Yvu
 R7GHVECBwnNG0gtxY6pkW4DqvWmGMGMuwrkDrg5zWG4wgvO/5drVRqjhsQ9VG4AohNHVnc5x
X-Proofpoint-ORIG-GUID: oB2drwtSWx-S_k-8TheaUC3thLG4hiqS
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=685004ed b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=xFv1LAIhNjCOIIx2tysA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: oB2drwtSWx-S_k-8TheaUC3thLG4hiqS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_045012_696248_8DD56232 
X-CRM114-Status: GOOD (  13.50  )
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

On 16/06/2025 12:37, Christoph Hellwig wrote:
>>> +	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
>>> +		dev_err_ratelimited(ctrl->device,
>>> +			"inconsistent AWUPF, controller not added (%u/%u).\n",
>>> +			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
>> Could we just disable atomic writes instead of doing this?
>>
>> Or are there bigger issues, like the value returned from
>> nvme_update_disk_info() for setting the physical block size is just not
>> valid?
> This brings up back to the old problem of how do we tell the file system
> and/or application that the atomic write size it probed suddenly went
> away entirely because a new controller disappeared.

Yeah, xfs does store those values at mount time.

If spinning another version, it would be good to explicitly mention this 
for benefit of forgetful people like me.

cheers

