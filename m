Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72957D13C3F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqWFWKpOoNfI8jLUjPMPuOfDyuzzb4CJnbTlfC2jPhs=; b=vwTIMmLkdmChmrwTbatkU1c7PC
	j0ssuvP1qg0nBcUn0g9mQ4jqWBIeIxyN/YSdGoZVUeSgUyq8Q+wSddhT7nlVs0zQ/Vsi/xSA3YmXL
	OEzVQynXz6iq+yECdS9Aa8N/kJgwTTcc7thr5bljwDy8YGYQZmSNLdSPSF/v/TWkkUq3ov0U4Fbb7
	WhA7rmvxOEApto0SYpGvKg6OT54yO2OR3VmfCcLvX4aChYaEc0PnSdkvIfCGyDjbwQbR0o1GL501X
	Ysow5waM2taQ2Kin78f/3TH8wziwI0qzBb3YTZlUJDMxUlmvTExTQ3CClpeMPr3ojpNiaxzHD/9fv
	a5VELcfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP7h-0000000CpVP-2zDc;
	Mon, 26 Jan 2026 16:07:29 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP7e-0000000CpUz-2rGH
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 16:07:28 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q1RO0J4124073;
	Mon, 26 Jan 2026 16:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aqWFWKpOoNfI8jLUjPMPuOfDyuzzb4CJnbTlfC2jPhs=; b=
	PgjpOJP6TaMcfg0wPFnBoG3PaOAj1h1RTGv0xk+zUsGftZOAgFyzoa4TY66nyY+E
	tGK6ut+QLIz98LkRbtseYpN+2xoLgHXUqoIIcpWzMn+6HzHAGp0otFUSibzFJeFC
	5MzQcxLulMnncBn7uU+xoYIfeIw28I28spIeCsa6HDI1NmNIDYGbnhhl5766at9Y
	NwpwvUIg3xb35WchZ6oLjagjYz9VV1mcvXQmbSH6R4ALWHHUgdaN36EHNCP+87+E
	d7B9ydSP5UWeE3g6s8dB+5OiYRS7otWKw94xF2aDaIWKM03NW2E9PAp13VaosyDX
	gfA3BRF3axV9ieAYzLG9GQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmra410-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:07:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QEKKxf012232;
	Mon, 26 Jan 2026 16:07:12 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh84w67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuDOY7E6+l5DqF4aT1TDoaIqnHsQJd2TXBMqP+M3GktoQRoK6Ijqe+WN9l1BMDKYMwxyKg/dId45pEITHjevQhMlcr2Je8LcGTyC15K79GOMJy3Mq4DsP46ZiWVnPcp/5MTmiEZ+F1zMwE/hCBP5pF0AJLzTEVSB1pUVNyrtOp44YjSAW5yWV/2yYG5VlVnGVZgf4SQRP7m1yUSMg5EV5QnwCKvALQF0jiKYxKQFXg9dzf2SLeuWIMwe/AzGUeuDYYtZ7QBWNY2WIssnNVRpqjdjnDQTqlmMSM2GgNmuq5LLPOatcqpGsmutTe7Gv7FyHm/8Ip5AmpjqU0x58feXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqWFWKpOoNfI8jLUjPMPuOfDyuzzb4CJnbTlfC2jPhs=;
 b=gGNmMi2PprqI2mH0rEkIw0M2NfG6+jBmftk6PKR713ZWKLgQW+0KYiU7X3d8WptVQkq6SBezzZJI4FeKl0QWKvyduQF24ZaTCyZNfk93ZSy3U3mTxr6XIdUgClxg2aXxL46hNjI4/DcMggCYeZKJSN9UKiT3ujNCyVTCPlrLTfE3dNAwLO+0rbtwR7zdXcGKH9tY1RdUZUHA6uGa3ijJhs9XI8x+GgGuoApX2kzpP2SEjH+u8FTvavvyrE+ve+FdO1Q1MAEPEfO/XIMVVRiXqzAo1zoohuppBWFdc6QA0COgsD5fZtDExJRd0g6XWktF6UDQmoDINEIgpnUwJBP9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqWFWKpOoNfI8jLUjPMPuOfDyuzzb4CJnbTlfC2jPhs=;
 b=CXzmYCGjVsE1bRqQKvc6VlriN9Iwwew/c7bIXylf07FP9n3hdJ2jX9KjAJv88oXfuhRwCcd1jEkOcYMv7Mpm9mCEWrHDyJ10rCzHGhBEcDJW+mH3JPhBVdsYFXHN56mv3zM1q6jbT0V78KBiSOOlv/ymhiKBQd4iZeeHzk9uTHo=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:06:57 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 16:07:04 +0000
Message-ID: <39e1aaa5-5e18-4018-b1fe-abf596dc79a6@oracle.com>
Date: Mon, 26 Jan 2026 16:07:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: stop using AWUPF
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        nilay@linux.ibm.com
References: <20260126132842.3332090-1-john.g.garry@oracle.com>
 <20260126151441.GA9705@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260126151441.GA9705@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0579.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::20) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA4PR10MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6806540b-fbb0-4682-02bc-08de5cf4f247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wko3WldudW4yM05WbDZ3cGdXK0c4dUMyTS94K1hvWWlpSEdTbTkxbWkwZ2xG?=
 =?utf-8?B?Zm5VNTUvVHY1dDZsdXQwTDB2SWROSEticmxGcUJUZmMxZE05eVZlM3g2REt5?=
 =?utf-8?B?Y1creEV1TFdrVDVQb2VucEVNNFBPTVUxN1lWY1JCdDlLbWdEY2pFVk5aNkRL?=
 =?utf-8?B?b1hpQW9zQ21PWVo0dko2TFNZVFVOUEdLc01FYlZjc0hTc0NCTXQ3Mk5sdG1x?=
 =?utf-8?B?TW0xT2xVb09aKzJMeUhKRTlGamxoUWJQcFBlSm83K3cxQmxTKzRUMVQ1Zm4x?=
 =?utf-8?B?UWd3Q2NiaGZFZGx6Z2FCbnl3MUo4V1dNSWZ1WHdLQlZIcUxERzlnZUZkZXpv?=
 =?utf-8?B?ZXI5OVVpSTV2T2VlZ1dmdFN4V0xNdUZVcXlXazhtblUreSs3ZlA3NmJVUGx0?=
 =?utf-8?B?UmpmTytoQzdIem8rdDlWVGJPTHhuT0NMUFQrWFhLNW1LR3VGR0dtWkowUm45?=
 =?utf-8?B?ZnVFeStrSG8xK0tlWlhjK2VjVG9NcDc2R0xpb3lWd2RnaUNKLzVHZkJMVGdV?=
 =?utf-8?B?UEU0U3ROT2lPbGNJd3Z3dzg4UmZSaW5WY0Q0bjQycXNBNDI2WThINHE5cWp0?=
 =?utf-8?B?NkozWThyZVk3TE1HL00wekRxRTczby9aWnZmM2dMVThYQS9IWTVxVkhNSVlk?=
 =?utf-8?B?SldEa3BsdGozaXIxcVl6MFpFK05HR1grYzJqdmlZdjIyRmJ6OXBaT29udDFZ?=
 =?utf-8?B?RzNaYkhnODYwWHBEQlR6MWJiL0FvVUZjYjRRMyswOUlVaCttdUo1VWlXSGpT?=
 =?utf-8?B?a2x4cW03SVZtZ2dsajhHOXNVTEhvLzFjemVGQUNLSXJuRUJienRFRDF6K1lt?=
 =?utf-8?B?L0hidjc3bjNXQ2E0bjlDSyt6cnZlMzhZTCs5cHVMcTY1MVZmRzRJbk5TYTJn?=
 =?utf-8?B?a3NwdWJONFRvR0k5VEhheEVtZmR0bnJJdWJBOURUZkovM21MY0REd0RtS3Ru?=
 =?utf-8?B?YWpQWTAyelJBWHpvdCtKRnlmUllMaldIS0t3Z28vZTNvQmZpMFVaaU15N2wv?=
 =?utf-8?B?S1IwV1hTbFZwVC9iNG5oeXQxTHVXQU5QL1o2eHhwMk0zYVZxalQ3Zk9xVGdx?=
 =?utf-8?B?ZlpTMzluTFF1MGRLT2Q0NUlza1MzODdMRGVJWnREN2F3VnJEUFIrOTkwQW1t?=
 =?utf-8?B?S0RNbHJ6TGpjTVRONFlQWURtclFmZFBLZnFYdG53cTZjcTBIY3E2T0lHam5P?=
 =?utf-8?B?M25lMktBTDRHRFpEdFhGaFhzeDVNUlNRcDhRZHNYSTVpUmF3amZYQVk1QlF0?=
 =?utf-8?B?QU1UT3dxSFA4SXc4SzJ4aFVSM2l1VWtndlp5U3FOaHlWTkJueHRadkdPazQ4?=
 =?utf-8?B?SjJPVkFMbTFOTUJnMzFoUXdiaGVIWk9yMVQ2SkVTY2NwTFM4SWgwRWZ0aVl2?=
 =?utf-8?B?M1JwT042TklHWW5zWkNDN0VqZDRKWXNlT1ZJMWNxdmVVbUNjdU1EQVBzVWw4?=
 =?utf-8?B?a2NlWVoyeVNmZDd0N1FKSFVwTDZleTlSQURMZHZlS3pQL0Y1REFud3ZYMmxT?=
 =?utf-8?B?bWsxa2JrT3A0STZnQy8rNFlya1VWQ3d4dEdWRGxoVTJCcXcxQ0paSnpTZjFO?=
 =?utf-8?B?YjhyMGt3YTlNVmlETDdUaElNbEVsenlLc1JVTlBCNEpBcjMwbWN3Z2YrSWUr?=
 =?utf-8?B?WU5aNk41dmFQRFoxUFd1QUQrT2hLQk9lYWZvY0JrUEs1N1JjOEFTV1U3Nisr?=
 =?utf-8?B?MnV3REJvM25SbVI2aHBLWnFpR25CMldhY3daN0RmRUNuRzA5REJibG5hbWIw?=
 =?utf-8?B?KzBuSDYwWkowcVhkUGhYazhPaVkzbEJBUTgrMVEzSGJvSXNHWXJyU21ydS9J?=
 =?utf-8?B?WjJMWGVSWW55Y0VVRXA3b1JtSVJRNnlGbGl0Vy9yYlRYQkNoTDN1Q3E2dUo0?=
 =?utf-8?B?VTU3N2hFamVZeGZUTjN2T2Z1SWFWbCs5R2pCL2ZHQkVPd0xud2pBNGJnMEc2?=
 =?utf-8?B?bk9OMVU4K3ZjZkNKbzNWa0IybzM5K3NKNXNMQ3dSTGdtYkhUekZxQjY3Z3lk?=
 =?utf-8?B?QVU4eFFQMUI1bFk5Um5WSC9CWlZzVytTekxUYkIzVjdIMFUvc3JXek9UdXh4?=
 =?utf-8?B?SWNBSDVaZGZBRUI1bTZzUCt3d2IxTWNaNHhLL3paUGVaR0ozMjFZYW50Q2Nk?=
 =?utf-8?Q?HiL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRSR3FJYXBHWFB5WWdNUkUyRXBxS2NTOXJIOEVqRjJQRHdjcDF0Rk9OT1BS?=
 =?utf-8?B?ZWxFc3puaVBYbGdPalFJcG1kc2dXVHpBdkhCTzNYYUY5V0IrcFlNajNvMFNR?=
 =?utf-8?B?a29nOHM5RnN6SkoxdlJtMXI2dytsMDFrTG9mTjROeEwxSUM2ajZZWnhORzYy?=
 =?utf-8?B?b0hZdVNNSjVTeEdvWElRNWpTaEY0THdVVlR5RlZKRTlqUi95cjZIN0hUd2k2?=
 =?utf-8?B?NUFleWxFOHFHaCtJUXNMZnlNZ2d3eE9Dc1RIalBGNnVKZ2svYy9GRDFBS1lC?=
 =?utf-8?B?dnh2TjFqdk9HTnl4QkpEOVJ0VVZ6UUZnaXI1bWlib1ZWN3VKRkVQcC9TdzZY?=
 =?utf-8?B?WFhCT2psWVNCVlQ3VWUxd0VyYzI4Ulh4UkQ0bzQxT2hReFJjbG5BL1hYelJS?=
 =?utf-8?B?ZnJzNm1BTngvU2Y5TnZ4N09ZZXROMnBibjB3cmc5VFo5L01odmo4TWtaeHVn?=
 =?utf-8?B?QTdjMXNYbzNIcFZPeUtlTm9nMUY1YTkwNmZpMWFFcVI2K3RqVThnQnNMWGRU?=
 =?utf-8?B?TTcxUFFrMVlJVFhYM3Ixa0kwc2pTOXMrTTZqT1duMUNna29VTXRtSXd4eUFl?=
 =?utf-8?B?ZUpzcEdwb29XWGxLelk4QTloSUhrTlpiaWRrQmF6L1Y3TDNPV20wQnJkR2Jp?=
 =?utf-8?B?WDBpNGRvSDllODlZYVdJV3BlNnp4YXZ5QnVQSitrTGgzVDdJdFh6bTR1Y1Jx?=
 =?utf-8?B?SGJUU1ZESWxKZEc2QnZHdGthT1IzVEluU3BtNFJyeisxdDVnL1NJUC9VUWs2?=
 =?utf-8?B?WStCMEIyY0hwQ3gvQ1VRWXN0eTdSZXBRb2FoNXNPaVQvZno0bUpSckFORHQy?=
 =?utf-8?B?SHd5emFSRXFOcy9qRVJhWG8rRFhqMllNRkFTWHdiZ25KWVVqWG9MaG5vcEJz?=
 =?utf-8?B?RUsyZ1ozUUgvRktYaXRIdmJYYlVRK0R0VkRYVjdRK2tGVzhLY1hUZE1la21Z?=
 =?utf-8?B?SU91MU0rRlpyQ2Z5QWVYd2hrZ3UycjJObHRCNGxOZ3VQTHJrUTllNk1XMXV4?=
 =?utf-8?B?SmhXdW1GaDhSS0daWlpoaEFSODVyN3pIZXdCTVB2UGg3akFVZ2Q4azN6L04w?=
 =?utf-8?B?eUdtRjU1OGhvWHBLTHNXbHZIMkhzQ2oyY2lhSmtGc2d5RHRuM0ptOEd3RjBz?=
 =?utf-8?B?OStFOWFBd0pPSFc0Wjh6TklMRUxpOWlhQktxMlAvcFhMdlNrWk9KMWRiV2g2?=
 =?utf-8?B?TU9rekdkb2xPZU9PdEl3ZFlZNDdsYUYvQ3JYLzJremhENlpsYnhrdThtQVJT?=
 =?utf-8?B?b1lTQlE0LzRNZmVGVkZCMGJDNndsc2lJZlNieU9tSGY1TjN4VjlmUkVRZDNw?=
 =?utf-8?B?L1Qyc3RWQ3pxc3lLMTI3ZVVtZmUzVFVEN0k2WStvVEsxdDlzT1lVdWJJRFFj?=
 =?utf-8?B?azJJQm9wa3czclZZL2VzSVQ5RHFCTkYwSFZrUW85VjBYN1NTQTJKNGpZREZH?=
 =?utf-8?B?UHNmU3hqd0pJUGpqQ1QxODZTVXNLeDJBd2tXNjBiWXk3MnpNdmczRmNwZVJ6?=
 =?utf-8?B?S29XM0ZhKytOZCtoend0dVQ3VFVtdWV4di8zQ1BTaTZ6MUR5Ynd6WExyb3pE?=
 =?utf-8?B?MnZXaVNsN3ZkTFIyY1ZNZnR6Zk5pbkZPS2QvUHNvTEtZTEFpZkRrNGt0ZEN2?=
 =?utf-8?B?SlpHZkRxVEJmbFBDR1BmUVRBbnBTVXdrWWF5QlE3bnJEdnRPeHhtSTQyNTcr?=
 =?utf-8?B?ZHp0djIxT3VmTEt4Nk51K2dZdmlFWGljdVNiaHFkak5FSUxndGJzWkZLdkxa?=
 =?utf-8?B?T2dUME4zWEZlRVFWTUM5NFFUczNNY1lMcC9FRnNjL3ozVlRnWjdoTjN5azhD?=
 =?utf-8?B?cjR6NVMyekNoZkp6WWJ5L3V5MVNaRjM1dlpGemdKME9SV3MxU2xFTnBRbmFX?=
 =?utf-8?B?T0haNGFWVUpIMm0zREVkQVZJMSttSW50enpWR3JEaGV4VVpPVWExaitXQU5X?=
 =?utf-8?B?MXNaWk5Pa3Arek1zM0NacEZzMjF1dVEzQTQxK0k5ZUNkeElSb0tFMytEUXdu?=
 =?utf-8?B?WmhhY0JwUisvV2l0TE5MZjdjZXpJQjg1UEhzbUNucERJUFM5aFU3b0FTRTBw?=
 =?utf-8?B?QWU3VU4xQi84TTNxeGcxMVE0SGR6b3lKcm93eW1DcVBNUkFSWXh4MU4ya3BU?=
 =?utf-8?B?WGU3K0E4MkVNMFpDYUZoR3F4a1VXaU0yejlpWi81ajZFQVlSRjZmaHA3UzVR?=
 =?utf-8?B?V21UaTg4UjFpbnA3Znl6STFoTkFrUzRMQ01tSTZrRFIvZFkwNEJjYW1kVHNw?=
 =?utf-8?B?aFpwRHpTWktqalVqNHRNanM4MlJGNUQ1cUo4SmIvVm1qZlV3UnY1L01tMXNo?=
 =?utf-8?B?RlJrUXFzWjEycEY5ZlhEZzBUTVZnSmcvMnJhdUd3TS9tQkpjN3FDdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +WnUvhSTv6NqiVW9w3s2xr0+l5x6scFheZyCy5A3lOoc3IzbGZshDNxn6AgSLD58MzRTK4QGti/pni9KXQ2nUqHcR4U0zCgTV9yUspfh+lAlXD9FBEmfL9uBwmDalS/w8gGVcdHL2dzNvxY0H00T0uhw6tmggZW10mIZwTHkZk/tLHWJWg5AlzLsIv2MGxle3rxlAD8H6sll969L2sgnMp4vzR6J0FCkq5Zh6DSJYyXsBnqyDxLXrE/plspqXdruvVIiww6rBG6N/S9hgSU13MfNNv8JPKt56dwq+P/4OMlXYYKMM6o7LRFHwVlbC3fcpFagzUP7HBpYU5zBQfBgMLxX9JAluzhEmHYXaIaG7z6NKSO7qC/xXgFsrtRmNmipw1n0OijUxvEWgSwV0GUqUOFg1vu1KMEp0SNS1sLeOhJbcFdhdqIbv1Bcg09n7d8zDetAXsIWF87sasewN8oDEzi3LQigAf1Ob8CtfCPTJWTcgxrgU4jSikP3bUfUaR/PctCz/A84G2MNYIXB4f4xLHnv+GSXjFg2CMNSXIid2WLGLzF4pGBLZmLn7UlzK2jmpjlSpf1SwHpRZ6LRTLBXQApYfHcuJ6qFv3FDvshdiZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6806540b-fbb0-4682-02bc-08de5cf4f247
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:07:04.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg4ySWc5Gj41GOTlaWGRunqzLG4DbfdRCnjsb+HPoWgwXCwucG9ka8ioowyrlU0NnTiZmdvpJSEFbEucPGwq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=787 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260136
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=69779130 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OY7yeNgLn51Ac9zya4oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QPpdGKbGsYktdvRAuoufMPC1yOUSpOgf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzOCBTYWx0ZWRfX7xMIB9jwszE1
 d4OHKD4z8Cq3Hz4B4q02+o/WU//rSc615NbNC+V3eomBUeVO3eW3wDBvsRZDJClG6bfqk8n5i4P
 hCE49EL5WE55FwbfV/glnsV7RTMVTjp5hWresJVCugOZvKnl6UTEVjiA5aRTvr9Ds95dbedzF2n
 V6iq4Q/wBcbP877WDcBH2EI5BV72Vd3nSIfb6/aFTt3eTc/PsXzm+9dBUcKKcV7krX+4LLRDAmy
 RAXNZPKdmryJyR68jnbJWe3wzlm4qjw5cLTzxcRAVSQe/Pw6M+oPbQMq1OBLwM16OV3VDiw5FeH
 6Mvm2+3XXeaECNSDkvyWX+BtWSU6td/R3KPFP/dS54zNsO7kgNT8/vtYxnKVLxFNoGYqGim3HwW
 nl9gyjX4LTLk4Mp4ZP8oiXo9r00yni+dWYmyfVGbpAMcJCD0JAg0Ule4BQx2jwZLybU8k0kTOUP
 kQelRPWhyggYNg/8LOA==
X-Proofpoint-GUID: QPpdGKbGsYktdvRAuoufMPC1yOUSpOgf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_080726_754324_CEE62B0F 
X-CRM114-Status: GOOD (  18.04  )
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

On 26/01/2026 15:14, Christoph Hellwig wrote:
> On Mon, Jan 26, 2026 at 01:28:42PM +0000, John Garry wrote:
>> As for the per-controller AWUPF, how this value applies to shared
>> namespaces is missing in the specification. Furthermore, the value is in
>> terms of logical blocks, which is an NS entity.
>>
>> Since AWUPF is so poorly defined, stop using it already together.
>> Hopefully this will force vendors to implement NAWUPF support always.
>>
>> Note that AWUPF not only effects atomic write support, but also the
>> physical block size reported for the device.
> 
> Can you add a dev_info to the kernel log when AWUPF is set, but
> NAWUPF is not? 

Sure

> This might really help with debugging any issue
> if people were already using the atomic write support (hopefuly
> not..), or if any other issue arises later.  Otherwise this looks
> good to me.
> 


