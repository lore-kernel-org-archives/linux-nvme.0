Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8395C71155
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 11:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spp8abQhjj31nlS0nFNg3pQ6wi/0Vy3zd4DCVShuQyI=; b=RAuNkydf+H1MAQWTJFOakmVA5A
	sDcYlOGnaPYQEZ2RGPE2CtUjag5VkBZzxrZVH+n6QNY4CpiCbX6z8E3NxxFnOGarXXmTcnRub0ec1
	33O2+OjyJvGJgTI7Yc7JpUULbkR42b2dhGUDTLa0Okfe32WkQyZHuZ0whtH1+adOpHqRiWAXNDDKd
	mqe3vDvtiH2GoWxRNBTJ2HrjNxu7Mc0dwprciuwUb7EBoGCH8NrSmmdCnr1DXZIIOY28CNmc5KZhq
	Rurxy7RUkLrRMAmiKjKJfB3duLS/lruyab4bqwTVKLHoPbzmnG240bkTkIRnpMO1zDw2wgPXySG2B
	0J2h0VhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR7wu-00000004Bml-0V32;
	Mon, 16 Jun 2025 11:24:24 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR6wi-000000043Ms-3UDc
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 10:20:10 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7fg3p031612;
	Mon, 16 Jun 2025 10:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=spp8abQhjj31nlS0nFNg3pQ6wi/0Vy3zd4DCVShuQyI=; b=
	jf5Daf8rcCPgx20MGghkFICXPM229PibXoyOxlpZrN03jOXQEz8s0t4HqJe8oHyS
	a7hNvRTMNJwlHbwGq8mxwGBNFj/rcJ+p+PuZ2Qcbr/mEtPIlEvtWgmFxDgWouHV/
	+GOoayKu+0hz61mJwJnlJaNKLQhfcwSLQ4mIzfpACcycQJmzcoj20gpVgdtla0UJ
	sOcQjH+8zj/4oY4rZQy2ZHb7rOIjcFXhxWTfht+dfdKMUr0Sifc5P3FHM80fczkQ
	gEuHNtxMPjeFXPo4QfBH6c1N/HyQLyDZKKeV7Wlwud0XAkhmyfWiqotoBgNyeP35
	G5adgfF5lBMtdUghhvDQ3g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd253p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 10:19:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8GxPZ035100;
	Mon, 16 Jun 2025 10:19:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7fstg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 10:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxbNj9guHBXkfJ4fgNyCDso++jDnI4QrVgo5BnZt+DQB+pl3hbCILfxXmSTKWsy12exAVe9ldZCTalnXTSuq65/3E6yPvIyPNX61JdLz3M9IT3k8VwJqLdZZI790Dy0wQBGck3TkXBvwUOJRDN7dFna49JOnzhKKOL5N7KeheGzvCcpVqzakmthSa0xyeuSAcqftG1DRs4A3K1xJnWwCYKGYrwSvtLR9MOrlDM8bRDD+hMlIch9HqrY2sjFpzmnTVXYAw29wy5BFdq+iRojRqiVhZj0Wsk0woatTbzqBHYiR3uLQucJzmxDZTeRMNgvWVBmz/Uo8prLv5JMKtUHJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spp8abQhjj31nlS0nFNg3pQ6wi/0Vy3zd4DCVShuQyI=;
 b=As/jYcVhlTwbhGP0Q5BAkem1gph+/wIK6qXdRZsquR3c/y6B1wj4TnvFY61/tNw80VgD7YGdEwrQG2If7CdnfDSrbCmclisOJPYS7qjHrdjAqdFJdK3IcLIGtncHkEnqWUYJmatz8DJEA3O2/T2V3SKN5e5a7ZHxj+E2+4UvkX7iZt4MFtoeTShAEmPmNpN4OhlEKQpLTFc07tUcOl7auta/Eg+MXqqv1Uly2PUWkCs/qR0iAlpNZBPp5JOZwNqf+9cBEv9tFnBwgMOv+4SRFmTeHyyD0eDfOuLV/4jq8zegKhZCb59vTBnr4k6nrrZyQXXo50xS2pK6NYWwYHdoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spp8abQhjj31nlS0nFNg3pQ6wi/0Vy3zd4DCVShuQyI=;
 b=UwDG005RKmayk8Hih5tJ7iY7WORZkQNEAkWrlhtgQo160mUBbNH13diaLJrjvXVhZLJsK6oR9vBy/jmHc/uCTe66nf5c7+JBhcWXhlnZelX45QxjY99WtQkXJ+4ALfMKembGGdz5vcWMYlDhlmVfuzoDyQ93cndSuDw9E0Ul6wk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7170.namprd10.prod.outlook.com (2603:10b6:930:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 10:19:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 10:19:48 +0000
Message-ID: <19e6e970-9bda-4822-8c86-e3387b1b4594@oracle.com>
Date: Mon, 16 Jun 2025 11:19:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Alan Adamson <alan.adamson@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <20250611055432.2401372-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250611055432.2401372-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4421df36-9a1b-404c-c164-08ddacbf5257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0wzRy9ZUUd4OXNHaGhOakp0dlVTWW9nd0xsTTFXNjdKNE04Nmt4bnZvQ2RC?=
 =?utf-8?B?NWRySXR2a3UyWnpPTlRrWjlzaURBbnEveHFMRTR3ZXRFTEFzL0hoSUlFNElk?=
 =?utf-8?B?QldUbTVwZEMyRzJjRmFCMkplMGl6UDlLcjlpdVdpY042a3VFWXVyV3dKVzJl?=
 =?utf-8?B?cFA3cjdhUFRMRTZGbjV6T0lQbDFLNzJwOE10YUhOM2ZsL0dhd2c4QnRmVHFz?=
 =?utf-8?B?YktKRnNyb0RpR1dTdWtkTzNORkdjUTY5WXlJZ2g5UEx3T2RFeU5yVlJoTVBU?=
 =?utf-8?B?NE9Vd3hFcC81cjNRV1pqUWhrbHNvV0EvaTNvZTAzRTVZOWMxZnNVaU11T0hx?=
 =?utf-8?B?REMrUkE4UUhmNXE4ODUrdVhJUTBoaEZ1TU9hS1RHTkJlZllxYWNKZ3hvL3Fx?=
 =?utf-8?B?eFl3UkNON1JSNE9ITnA0Kzlrc2oyMlZHOG9ZTllDdFp5Zlk5RzB5dkEvTXFR?=
 =?utf-8?B?SmJkY3lTb0VBYU9WSjFiditMeTJCOGVnUWl2YThwR3laQXgxbWxLaWY4WEx5?=
 =?utf-8?B?OEg4MlpBZzlDUHFNL0dKYTRoMGNaUUdTc3NObE45ckxNSmV0ZWZUbGZadkto?=
 =?utf-8?B?MElRWjh1UE1Hc1RTY0hiSVBTUmNYZEI4TEo2RkRITytDeDRPOTdnbGVzbER5?=
 =?utf-8?B?R3RRdWZ1YmxDZ1VHdTVrbEp2UUQ2VjFCeUl5aWI4WTh5dS9BZHpHMkVya21H?=
 =?utf-8?B?ZnlBOVVRU2NiWGw1T0krQVNsd2I3UTZCMjI2bHNsRzh6a1hnWGZ5Zk1MM3I2?=
 =?utf-8?B?VW4rOHJGd2JRMlRZeGkxZzVpTjQ5VU15Mk0yYXhOWW1TTnQzUVJvNmUxTkVU?=
 =?utf-8?B?czZkcEFZN3Btc21QUzk5UWMramR6eXlkWUYwRFRqQnovbUxKQ0dobUZXMlRn?=
 =?utf-8?B?Uk5SdGIydXVQdXY1VVJveTV1ZDYyV1RwMysrSUZhUDFScjlMd1JRYlFheWZC?=
 =?utf-8?B?eXc2cnRhaHZwREl5V0FtNTh3a0Q0M083N0RxMWpmbkFaQ3EzNXlySDRvQitJ?=
 =?utf-8?B?c2pMc0xNR01MU2hITWZZNlE3OU1lckFXVm5WbkdKSlVVSzc5QlZJNjhVcjdP?=
 =?utf-8?B?NHJhOHQ0ZFRiUHJXcm5FNmhoT1ljUzEwOU9RVjRldFBCRm9TMC8rSjZ5aUR0?=
 =?utf-8?B?c3dnWGVOTVh3aUEwckZDVlpOc21nMjhJZ1h1MUhjMjBVTXFOUnZqdHNodTBr?=
 =?utf-8?B?Y3M3SE1qNDlLM3Y0VHJ5UE8vNWZwQ3IwQjRGaGNITjNtUHFPTldkOUJFdFUw?=
 =?utf-8?B?eDFJa1k2Wi9jSVZ3TkF4aEo5eVhDYkFoV3ZzZEQwVVRkZEhmMGxyMzNpb0NZ?=
 =?utf-8?B?V21LcFdOT29ndm13cmRYUnZ4Zkh6ZjBsU2tublVyOFVYaElBbnFzYXF6M0dF?=
 =?utf-8?B?MnRFSUk1T0pueTdBYm9sdlY5VFpvb3JmL0tlYTF1TkcxYll5a0Nqb1NNbG5n?=
 =?utf-8?B?VXdtYWhLZkJnY25XV1Jva2p5QzRnK0ZxaklGRG5uYXZ2QzVLS3JYRVpVdDRn?=
 =?utf-8?B?T1ZjV1QxT2szaW5obW1hemZRSnZ2OGNjcFVQT1dXQVovRE5BV3BSdnBnVmRw?=
 =?utf-8?B?V3RlSHhPdFRwQkxhMTltYWYxVmZMeFFZOUViRG1EZDg4WTFPbjg1TE4wSmxt?=
 =?utf-8?B?TXNEdUdGSU03cHQrWGt4VVF3TFBmRnA1SjM5U3hMVVphYW9NdXJpZG9wWFFD?=
 =?utf-8?B?UlI0bUdRK081SUU1d0JmQkhPRkpndzVQSmhZL2RORUQrN3VwWmZaTmVlejBz?=
 =?utf-8?B?SmJIdEZYaFYzVDlRbkFxM1dxbkM2aWQvTjEvTlNIM3lyUzNwV1ZrRDRibXRG?=
 =?utf-8?B?RmEwVXUyb004VWpwL2xuSVBHdHdLY3hrVDhlSU1NbDRjbGRDWkYzQktrbnNY?=
 =?utf-8?B?MER5VWV1Z2J1em0xVTBSZldmcTNNbmFUeVJuTFJzUzF3eWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Bwa3N3ZWRITFpaTzJLYjFNV0JYTjlJcVNKWnVHQVdRVG0zMEJNQWkxUXo2?=
 =?utf-8?B?WkNwR2VaUDFyRGlzSGdTREVNdlg5N2R2cUlERkptOGErUmlQbWRja2gvVkhP?=
 =?utf-8?B?Nm1aQUZNWWt1Ulh0YnltTzJjYmRPcmJDMXduRzZ5dHJWM3JrQWh5TkptL081?=
 =?utf-8?B?bzNReUVLdEQ2UU45Q01oeU9kZ0Y5WVNyelhHL25Gb0svOU91M2VUald6VGNI?=
 =?utf-8?B?ZnhmMi9tOFV1dTdPOFhGb1dabGtRbGF4NDJQWlluNWMxVW0zck9Sd0wzTEl2?=
 =?utf-8?B?ODhnSFdaaWVXY2Nwc3Q0eVFneEpGTmV3Ui9tVVhyWTJUbU85SkZUcmw0WHVP?=
 =?utf-8?B?OXJxTG05M0VoRlQvcGtYWVVXYy9peENOdWFPYll6R3p1MldYQlRQRllJYlZt?=
 =?utf-8?B?cXJabjRkTWJGcE9pbWwvM2E1R1JxUVVIK3lOR1M4OVI3dWNkRHZVdWRqNzlh?=
 =?utf-8?B?bFFXYyt1MWVUb1cxekNxVUt4b0JzZ0UwL3BEZkFiYVgwT1hNekREZTQ1VU9G?=
 =?utf-8?B?RkM4aVEzbjZtUk1xTHdJeGp6Zkt0cHV4YVFXL1NRanNlV3hBMFViS0w0d3Fp?=
 =?utf-8?B?Z1Z0N3UxQVRTNmVQblJZekQweW10ejljcjgwK0c0dysrQVZpWHBuVEVkRFd6?=
 =?utf-8?B?TG5ZWVV3ZTlCZk1Pd200SXY0V29DYWlIdlZieGxoV2Z0MFRPenNDclBwSGpV?=
 =?utf-8?B?YldWTFc1Rm9qcmpzT0h2b0g2WVQ0TktiN2ppSnpnYTdPMGl0c3pQVGJpZTlp?=
 =?utf-8?B?WjhQSm4vdzV5UWxVT2tkK1VaZUtFVWdHOUJiMERIWmhaNFlNQU12dkRoYU1B?=
 =?utf-8?B?amlyZ1p0d2w0L0lUdk0zamNlOHdhZEhJVlRwc3pUSkYxd1hzOVB6WHJsYk95?=
 =?utf-8?B?MGxWTjRLN3k3RVdlN3JtLzZzaHpZbzRHK0xqWE40Wk5DT2JzSDRxS1g5Skc3?=
 =?utf-8?B?K1dLbTJQNXBZN0VLOW51eUswZkZWZ2txZ0wzbUNRN1NpU2t1aUY2V3RseVhR?=
 =?utf-8?B?YXJjWUI0TlFhRmFEL2NjblVZQnNXMmdYLzRLQWJwaFN0T1phNWdPYnFneUkr?=
 =?utf-8?B?YlQzdlRIcWtlcGNuQXdpcEswVFZPR25OU0NZR1lVZWUzWlhhanl1V0FUaFhm?=
 =?utf-8?B?M29YQTV0VVdkbVM4bVAxMjh3amswNnBadGVydTVNdFhqMU1yK1VOa1plUUl1?=
 =?utf-8?B?RzR4UEgxdTZwZWV0bk9FSTRxRUZGY3lBRVZxUHM4N05WWUxaRmdUWWZqVUl6?=
 =?utf-8?B?eFdkZXJDTFZTLzlPY3JjRFltZXJwTkdrUVcyNmpzUW9ZaHd1cHZuTXRWOW1L?=
 =?utf-8?B?cEJLdHlUd0NKWWxhZ2dVeExjMFdKY0VIRHRSQ1U5UzhQNHIwQXphVHNqSFZZ?=
 =?utf-8?B?TEFRNDFpaTlhMFRBNGNvcHFpUlhIdGZQS2JpYkF3M1BWVnRZUjVpNmxXNk9i?=
 =?utf-8?B?eXlHRUwrSlh4dWV1d2hlWUtnWTNJK01Ic2lZWEV5eE1UYWlZOTRFNnJDS0ht?=
 =?utf-8?B?dDFNQStITDBMS00vNG56Q2RsZTMrY0Z5K053Q0pCQStRenJNUjVNMDlZL3Av?=
 =?utf-8?B?L01kb3ZSa2p0Z2VuanVKMHlMRHFKMTZQMHVCWU4wRDBITlFia2x3U0w1L0pi?=
 =?utf-8?B?OEdUOXNPNmFwVGlCQlRubm9UYnB3eDVKaHNkcUJyMzFoOThGZ1hXak54dXE5?=
 =?utf-8?B?SDRQcDBiSWxGNnNHMFA4VTJlSjFrdEJ5d24vU1AxL2lmdU1CanhRYlA5bVBI?=
 =?utf-8?B?SmdOVks4TTBDYmZXTUpvNjV4YVA5MVZFZzgxbDlYekFLZy9HUXNTQnZTbUZj?=
 =?utf-8?B?WVpUZHowRllYRlc0SUFIaVcvMmd0aFNxNXBUMy9wTGgyeHVyaWVwLy93aE51?=
 =?utf-8?B?STNnemxnYWg2U2pnNUlOeFh0NVl2K3llNGpaSjFqSlRiZ1R1bVB4eTUvTU1J?=
 =?utf-8?B?aFFVY2tzVGY4eEIwQllnNEdHeUhLYitnL0FPOGVBL2pyQkxKa2lCTXBiSmVV?=
 =?utf-8?B?bkg2MlNHUmRzNWxiUDNQN0UrZ0xwVFhYamxVajU1UnZpWGpYV29UalRaQ3Vi?=
 =?utf-8?B?TzFiak9tUVJxemZkQWM5bTI2UGdaZk9EYStjMmxrK2ZoOURLendpWTB5TVhn?=
 =?utf-8?B?QkVJK1NwL1N3UEFaVmUrc0c0eUtmTDZkWklUQ3AxeUZiTVVhRk9PamtLZWls?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ztEEhAytmKvFKMv2Fs3PzU/nAN3Z1OkEbCSkSmCTlXM12xfpKL9idk00RyEf4yIX29Q8yHCnJ7LHEyxzkmrrI6KlLFrRTYOHNcFue/eQsePyv04qkgf0G1H+gOV3bycE9TSA5FaH80mwNnsUkwMynj00+Y6OJ5spHwDnyKoDXoHjZnkioWMna4jT0zR2bGQVbvT4x8JtIsSlcZJCutudmZFJyqawg2zTh7/gY7j0Ka8EhPsdXuPK+A5Gw4jNB7RvXWehHh3QR6fsHs2jjJT7mdV74FGOAVFrdMHdSOTjzSJdm7oPzZGb3zg7Gw40AwyBjij9FgeGl7nIgO5+mlqrnHe+vU9AmwCYaPAGws3M/sZDrIbYkfaDL2AyXgqmQ5v/lbY2dY15DVx8tEpG04yFZM5NJJBIGxquAi70oBCgZ6kNEMMIVBFvbbVHt/++c0NWycDyyXWMc7ICoVTuHJrl/9xrAZBJOukPPtKUjFOtXHVHYd6wLAwBFlYn5qlVGHG02GuiobPuyB3QQluM93/zSZ/xWHm9puFwYWzrDFRiVaTEdaSohfuTZ/EuZT2YsO9kvB0mjPezvklH4OOBqwIYW5ivGIKDXEm7ca/9aJhtQTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4421df36-9a1b-404c-c164-08ddacbf5257
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:19:47.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mma0MkeRawGIua+zp2Fw2QDo7E8C2khzW7x2lKLr2K8oRifaSCf84OYyZixvTgIi8e1HEeBvagIQK0DY3FD6kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160065
X-Proofpoint-GUID: 3sXEopIXT89l_RZfAYybWtttr0qPY-fE
X-Proofpoint-ORIG-GUID: 3sXEopIXT89l_RZfAYybWtttr0qPY-fE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NSBTYWx0ZWRfX3MMB9colzDOA PWeHbuH4QaOBx49rt9SaPHtfKSsrC8bw24YTnoRVQF7tdTHsdKmIT3Ol78Y6ZbOloStVE5Lie+M zjXugs8xRdg6sEV6VD2JbkYq2hMQeNPSbXfaZIwvYSthQsdrATUTvZXULeUAgcBoHJWuMeAFRbr
 ADEr+uogtcZiwECpI6wp2E0nzMTbUTuR7vxR4QWNTZEae2mS/osbm9SDl30tSmdEcYJEH16NjYr rF+QudyFxyMma9iz8LNPPIluQWPlsM1tzjHr+uesZ+KVuJ8TWZGR6ze36tEL5QN0hpIP8YiG+Ka Yztnz69lV75r7iE7pJyQLWFWacJFslN3SnhMETBFLg7dYlPPKJpEgV3ARpPgaEKvBGKHrtwrq8V
 PYkFEk0M0Gf8ybh+kTbSuGXnVM/FbZ6iCiqemjcYOY/TWymmK/jcZ/ReKG5wnSWzNZdPYebn
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=684fefcc cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Zh0Jnx2r_rzOCRuNRrcA:9 a=QEXdDO2ut3YA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_032009_254971_28D745BB 
X-CRM114-Status: GOOD (  12.92  )
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

On 11/06/2025 06:54, Christoph Hellwig wrote:
>   		ret = nvme_init_effects(ctrl, id);
>   		if (ret)
>   			goto out_free;
> +
> +		ctrl->subsys->awupf = le16_to_cpu(id->awupf);
>   	}
> +
> +	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
> +		dev_err_ratelimited(ctrl->device,
> +			"inconsistent AWUPF, controller not added (%u/%u).\n",
> +			le16_to_cpu(id->awupf), ctrl->subsys->awupf);

Could we just disable atomic writes instead of doing this?

Or are there bigger issues, like the value returned from 
nvme_update_disk_info() for setting the physical block size is just not 
valid?


> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
>   	memcpy(ctrl->subsys->firmware_rev, id->fr,
>   	       sizeof(ctrl->subsys->firmware_rev));


