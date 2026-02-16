Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22484E63F20
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ws+B8LwxpC41h3sg8e9U7gjWorr/Z8QZhDckTjirWs=; b=L2vYsz6iat80zxEbhtbmgoYNEh
	C6iCed2g5zgH2S7QqHoWNEv+RCzehOM0s516hgdEO9+D18CjWtdfhDfYT5FkfuZF5nbh7W4Fi1igF
	+KYFZJd+4uIjS5Ec4jT6lfj5rpE7bB6uu5bk9AzW0jqSNl2AzsjNXNYPnV7YVHEGneBlcPoOgsEL8
	JTYfXVXY6NQ0vrQpcD6OomialTyYN3u3XIr/cxIqTAkC88u8YLGA+w5KT2/eZZxQPf2cW8IXavQ6e
	zqiIdvbyIBcTgouIEkkYWg3yRhN1xhthWQx9d6fqDPcRHNgAuMFgyPXeg9wNmDZpGYWM4HiJHrVnB
	tV/kN9kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrmaJ-00000005oct-0mmR;
	Mon, 16 Feb 2026 00:35:31 +0000
Received: from mail-southcentralusazon11011034.outbound.protection.outlook.com ([40.93.194.34] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrmaF-00000005ocJ-42k0
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 00:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSJ0rQFkMpNOIRE3mcB+DpgM9rZGCdqKMEf1Hy1sFHeFE8DqF8qSjIj/98evNkcxERTi9+CXmLknuo8vOyOGtaxxXYPUWQHPT/Be87Vc2tTowOmLIE+ZLkP9CKXwopQv/q8QFbCwM/H2PiTrMh2LhMbwaBLrw38PqhMTH5NJWjzPmer0WZD7ppnr+Ef+EFwULo0CbAAgMndpLP1vNr1fcFxtWN23w4lR6tN82uLymOYTj6lpvgxywTMVf8Fdno5qTaImPTSgDPSQby9ndDGpO2ez3GBIBv+zlGBEMeE6gAr6XSGh4ZSDbtu68y1z/XjAeWoQUG0ho5rc4gmajcZm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ws+B8LwxpC41h3sg8e9U7gjWorr/Z8QZhDckTjirWs=;
 b=bQFH9JhE0fxitxOy/4EJA9cmyEfkt2LoQxsu0ZllyOW9v522ca8V0vlAzh5ZF1ePcgHjnq1EdxrI6iIRPVmmDBIg20mfjPDu2Egt8TvHygS15NHULm4yPt0sfTFnYSeA0VBF6sw7dZvzvUcAiov5369a0WhWhJldb6EvWSvSSoPxRP0gVqC4RrrsiJeFwhlxiyvswYiQ8tbFVFjMEfbRX52JAqdgXGC3ZJCr6ymUBCZq3wFh+HKBNZCCwHCpDu0RQCEbWVLybISK2T813A6b+6TiN4U8tgMf8dFMGkgsT142GnU1yxZHK3ajSFlaiuGqm5OFiRbvSDGL/iVpNuZk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ws+B8LwxpC41h3sg8e9U7gjWorr/Z8QZhDckTjirWs=;
 b=ZXu0RUty9WYh7ThiAkmQvnmzSNJZu25tcZvcYsaxjjaRZ8tw3KUahN0T3RAY+su1tCl6eBjNpKxzaIL98h917VK5FfOpl8tCmqlAr1Ujh4ZhS2zeTTfqvQEA/cZXWkYbJ7osPxRPAdrGWje22DcUth0c7BOTk1aHLAKGd3at/06p8HaqKO7/QItPSXMBalu/V66FE/8x6sZkW3FiIMH1oGKDinzJwyUjjQCVzhGz2xDe3q3awzOX9XLJjWAqOUCCgzA1iwO1aTuAKryAr3Pv701+KK2e1QzlTT26NqAMi9jk6NS7dZKedILyTW5bA/cDSlhMoD3twFmvBaHpHsLFrw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 00:35:21 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 00:35:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, lsf-pc
	<lsf-pc@lists.linux-foundation.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] Topology-Aware NVMe-TCP I/O Queue Scaling and
 Worker Efficiency
Thread-Topic: [LSF/MM/BPF TOPIC] Topology-Aware NVMe-TCP I/O Queue Scaling and
 Worker Efficiency
Thread-Index: AQHcnp2VnTVZ3WHiJU6y//asjRzJqLWEewiA
Date: Mon, 16 Feb 2026 00:35:21 +0000
Message-ID: <055b2be5-96c8-4882-b7a0-93b1765f80b9@nvidia.com>
References: <5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com>
In-Reply-To: <5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: a9f3d267-6d0b-4d46-44a6-08de6cf344a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVg1a0dvZzR0clpFZmVlU25EY3RxcXBkcjlUdXB6bFdlQmpReGw3akJHczJp?=
 =?utf-8?B?RWlQWTZkMkFad1RsOWl5NzEvNkYrSmdwbnBUYkJ5dmdSWjFnNDBMNFBKMmlM?=
 =?utf-8?B?Y3dsa20rMkdTU05yYjRTeklET2lydGhSOEJNNy9mcVIxZVhRWVlCZHFLcThP?=
 =?utf-8?B?c2xMWVEwRjVJdWdUS3ZyN1RnamdFK3U5c0c5aGVIZ3MvZFdtaUFrNWsvckFS?=
 =?utf-8?B?bnhQSmtoZm1taFA3Sk1FdGZPNllNTWdYYjF0dHcxb05tc1c1Y3haNk9GV2VT?=
 =?utf-8?B?SlQzSU9wdDEwUk1wRUloUGxQb3JxbWNFZXRBSGtXM2ppODdNVXJ5RUxkSEts?=
 =?utf-8?B?SzRFTkVpVWxEQ3pOU3VPeGt0YXhBY21mNG4ybU9PWEpGbG1ESEREU1ppdk1u?=
 =?utf-8?B?MzVHSStVaGhmOEdXekNQQ0Vick1ZUjJUcTJySDNHS1lDSlNRZytUdGlvbHRl?=
 =?utf-8?B?Z1FEMnVUNXhqM0RFNi9pL210MDhNWjNubVJmZXB2K3RMcUM4L00xVmJEUWsv?=
 =?utf-8?B?Q283bndiR21OaUpLMkNjMk9vVW5nSFY4b2xUU1lCcDUyT2ZzSlVoVEp4YUky?=
 =?utf-8?B?cUFCV09yS0pBdDI3emJWdXh6bGltQ1YycStUZEdHRnFuS0MvbFUwdUdsd0dH?=
 =?utf-8?B?QnVITnJkV2pxUVlCcHFFWVJReGxLRFRkSGxYZDA5OEhYRjRSUmszTTdLbWlI?=
 =?utf-8?B?dEkyN3JhZWlwNUw2Zy9SMWpIWUJHd3daeUlQcWwyMmVvWlNkQWdrSmEwN3lO?=
 =?utf-8?B?c1g3YU5aMEptT1Y3b0RKTXRFWVRMRThxUXFYV05BYzdhczNkWlZSL0dOV01G?=
 =?utf-8?B?a05CenBXK0ZReHJrT2x2L0xscWtoazBzdVg1RnhOMnQ5aXRmMDlpRVFjeTlW?=
 =?utf-8?B?aXVaZWZkTUhHVGVLdk05Z1FKa2JoVlZURVkwWlRUMUVQYnpkODRkbXFZZXl3?=
 =?utf-8?B?NUsva1BqUFN2aHJ5VmU4cmJjazk0OUU3N1M5dnhacU9YeC9lYWFmYzRIZC94?=
 =?utf-8?B?b0NRSWRlL3IxNjgxM0FUZmg4N3ZCRDY1NkowWVVXVUNURC83WDJzR2JHM2Nn?=
 =?utf-8?B?SmlwVHdKZ1pZbCtMUkc3dmcvZC9XQ1RKeXVROHZsZWVSR01qekI5Nkp0Vk8x?=
 =?utf-8?B?dVp1MlB0eUxoYXEzQUFMakdZQzdLMU9KeE5nMStnL05DNGE0MFhVWlM0YUg4?=
 =?utf-8?B?K2JDV2JtZU1xYS9VblpkVEdZUVYzY2dYRllGOU1sUDB0d21HS25XVzVUZlJB?=
 =?utf-8?B?V05tMnY0YllzNUIxWm1qcEtvUUFuV1IzenRxcGsxMFlNajlYaHdWUFk4Yk9v?=
 =?utf-8?B?b3hzWk81Q3pwdFI0SWFlWlV3d2p2SWYwOUM0ekU1T1gxTVJ4M2RWZTNaYkhl?=
 =?utf-8?B?MlRkaFNEQUlURDlzZGJRbzBtUWFWdzdZR0xMYUdBT3pRMmRzdzVJRWlvQUpo?=
 =?utf-8?B?VDhpSDNjR1NnVFVMZ3BRdnpyeGlkdUNTN3p2b1Jic1F1VzVwb09xUjd4Rkln?=
 =?utf-8?B?b2R5RWJ3WGE5TlFSaEVUWTJURWtGUEZJVkhSQVRLY0l2R3d6S2ZaY1BjTU9i?=
 =?utf-8?B?M1VMR3FrcTQvMS9yNXhpSDlwTWtEZWUyWC9mRW8rR21PNi8vVGVIOGd5cldq?=
 =?utf-8?B?ZEVCUS9jY3g5RVIwM1BHUEVmelFJaXF5bklJVHRyZW9hRHpjUkxuUkZCa1k3?=
 =?utf-8?B?dXN6MFBXTitQOUx5QXhYbkdUalgrY2dwa0l0bHdzK1hxMkZ5cWNnNFlESm9R?=
 =?utf-8?B?RXp3VkdYT3FyeVBlL2NXYWVsS3hKVGQ1U1RSc1pacWgzR2xERERIK01JbUJy?=
 =?utf-8?B?NzI4MHY2bmFGci9hQ3Jwcm9ubklOYTlGbm9LV2x3MzR0RmFqamR6bEwyR1Fw?=
 =?utf-8?B?by9nWjRiRWNmU2dyc2lYZjFqWGpNK1l6anFIQTQrYTJrZTFGZWkzdGkvQkNw?=
 =?utf-8?B?WUpUZ2RGQnNwTkIxNDNGaXpja041eGdEQ1ZFWklhNVkrbGlUaTJoKzhPZHAw?=
 =?utf-8?B?Q3lvUmczckozU21OcG5heUh1QnhWRFhjaUdvSlIveGtEVzU0ZmROVWtJWTZD?=
 =?utf-8?B?czJNNGJSbFlCNU9sa21KNGRHQ29GdHM3MlhST00xdUxCdTYzVyt2aDdZaWxr?=
 =?utf-8?B?UHk5ZitjVXd3aEIrVXRmTjMvODdyNGpjT0lNV3daQ1ZyMG56cERObUoyZDNz?=
 =?utf-8?Q?WxW2IdYoGiFP4qdvPJ+boVE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRJMFRBRkxKNCsyWWU2d3ZwVU92cW05dXRvY3l3ZHYyMi9yR2tIdW9DdHFa?=
 =?utf-8?B?RE1ybGlhUmpsbDZpZ2laS3FLQUxpcko4WG9TSlBjZ3E2U2U4b3h3Zm4ycVVH?=
 =?utf-8?B?a09hNFBwcnVDeDVUdVFKekNwYkdMOE9Sd3NLSkJoTEg0NmNoWlU2bmFadFZ4?=
 =?utf-8?B?cnpWMHM0djZHak0yNk5icU4rN2xmRk5EWDdhNVZVU0NFMDdDQVFYeVlmc0FU?=
 =?utf-8?B?RGp2cXRqam5wRlkwdHp2SGtmUGZmVGJUNFdkRHlaQ2lxRERXNmsveWhWRXZJ?=
 =?utf-8?B?SXRPbzF1ZzJIRnRyVlNyU2ZyOHoweGh1bmw1OFpoMkFBKzhpdWJmcGhsZGc5?=
 =?utf-8?B?Qk9LV0RzUTZhYkRKeURieU5KcWdCMnQ3cmhsMjlac1dqT3dIeU9pWXhaZTFN?=
 =?utf-8?B?eEN4RkhNeEFmbUdkdnA1eHJ5SE9IMUpWQ2JpRWxzVWxuSWQwZGhpUW1BTnpV?=
 =?utf-8?B?S21iUzJHQy9OM0ZmSEJkZ21OOHNML2o0Umk2elN5YjNQUGZmaGpFMmJlTkxV?=
 =?utf-8?B?bGhFcnlEREVZOU1DV0RpdjIwMWRwTHpJd1RYZnJmMEM0SHFKMHR4QWwzcnFk?=
 =?utf-8?B?d2d1MXU1blZWdlljcmwzZ0t5OW1yN1B1anlUSXp2UW9NNGQ4dHMxMFpia0FN?=
 =?utf-8?B?SkdEelkvcWVEMndrakJRdFdwanY5dXIxaEpzUXVuTjUrbGxWc1BtUVJNMHlB?=
 =?utf-8?B?cVRwL2MxV3pubk41VzFwL016bm8wZk5sVnNvMDNUR2RMRDFvRHVra3MwVGI0?=
 =?utf-8?B?Z0lrWmU1QU5vZ3h1STZZSVY4RTJCUmNIckFBYVhleGpOUFhCWmZRRVNCN3pm?=
 =?utf-8?B?OGt1Qk9oOTRpcmZWUEw2RHEwOUY1ZDRQUUJncVovRUJIUFdwVXh6dFVsQXdU?=
 =?utf-8?B?RlRWeG9wanM2N3gydUJIQUpDS1RjbWFuc3dyd3EzaW5VRUNrakJBaXB4WWJU?=
 =?utf-8?B?eHBtUytVNHhjeGFIczhROXBwSFJCcUJZclRIMnVNdThrMzl5cnc2Qmhhd2M0?=
 =?utf-8?B?VzE4Tjg1YTJqSzBubkk0WVJpNkpmeUE2WUVrSTEzUmoxYzMwM0RjaWtxdEVR?=
 =?utf-8?B?QkZMVVRSYld6YnVJWm1zeHFtRGhlNjZ4RFlBbVgrY2VmbDZzNUl0YS9tdFpi?=
 =?utf-8?B?MFpNbUhBSWVkVWJIY2RWbDRDR1ZPK29pUlNTenZzV2lkbTQwVUozRjlkbGd5?=
 =?utf-8?B?TDlxakpPWWtQOXladVQ5TlE0YkVmMUQzVmllcDhwSGJZb3BkdUZyMXNXaU5n?=
 =?utf-8?B?Q3JqOGJUMWdpWGF6d1oyWW5aQTVONzFkMHlHWnZkZW9jdStQL1JIbGlLN0hu?=
 =?utf-8?B?Z1hzbzhSdHh5ZWVpRzhDTFVPUTRZUkZwWXdWZnNOUFJZSERSYkpReUF6Mm56?=
 =?utf-8?B?bEJHSm5jOStVSi9hRnJUMVJxUmYxdVVpMHpabngzUkZGR1NrMkhlU1hhWWxL?=
 =?utf-8?B?QmRmV0xuZEFvZEhvM2oyTVUwK2xpdWNKUGV2eTBpbHJvY2Uzd2wybXE3RVVp?=
 =?utf-8?B?L3JpNmJJUVA1Y3lFbmtTeFVEalhERHBONnZ1T1VEVU1ubnVrTWpqYldsN2ZN?=
 =?utf-8?B?OGpYbHZLMjdyZzRtdXd6dk1aYUkvUlEwQUEvUHB2c1dIcndzTDBBUjlqN3R0?=
 =?utf-8?B?Z1ZuRUU4b0lwZm1JU01abHdqOGovUjB1d00vM01wR0dEWi8zOE9yVUZmZUtB?=
 =?utf-8?B?a0JBTnZQLzBlemZtTkcwdUpVTXNhMHFBRmsrZXd0ajQzMndoRzB2QitLY0FS?=
 =?utf-8?B?R3lnZjEzdWF0ZUpmeG5mSkhiTCtyOWtoQnVFUHhrbkYxSitzTXR2UFZ0WjZl?=
 =?utf-8?B?WkFKb01CSGU5RDdSc1ZyMlhROTk3cWJLWUxZcVhmeG9zZ3RMa09kTU5jSnp3?=
 =?utf-8?B?ZE52blVydTBuWEJXUDFBVEdxWng1ak96ZDc1WlhLVVhWN2ZaeHBrQmU0ZnNj?=
 =?utf-8?B?aGF2WVhFVHArcnpOTW1zSDJoNG85UDNIVCtqZG9NRUd2RFBBc0VYdmVBdnFi?=
 =?utf-8?B?VEVhdm5SSC9GZEU3TWxuZDM4M2ZWM084c3NrbE9UTEVHYkF0bkVHZHZTeU9m?=
 =?utf-8?B?K3U2THRadGpDWDI4QnFiRy9jTzIyWXZXV2FqS1ExUWFCSVhMakVLUVhERzN0?=
 =?utf-8?B?NlJpRGwralhhSkJKZzJHUHpJNEV3WmlobzNlaWpPcHJ6SXp5bTlwVVZNUTQy?=
 =?utf-8?B?UHg1ZjZrcytXUmZ5eURVVUdQbGtSMDMzTWQ1SnJ2aENvUFBtSWlPYkN1RDEv?=
 =?utf-8?B?clFsdkNKT2FRYUpwYmVBNGFPcjJUdkVKSXJ6eEVkMThTRCt1VWVjcGZmQkUy?=
 =?utf-8?B?WjBHdElVb05NSFQ3VGpleGgyRFFEK0o4VkluYzdzOE1GTHFyQ0J2U0wrM0tG?=
 =?utf-8?Q?2CY39B12i4EtyGpkEwPmOwlfT6EFxVer43KSaUiYXaCRX?=
x-ms-exchange-antispam-messagedata-1: j71OShkO4JtEeQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <800EBD55A7665F438C314EE57558EEAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f3d267-6d0b-4d46-44a6-08de6cf344a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 00:35:21.7661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8Ocir9PySLceY45X6t69vM32Vx4SfPqlwx8jbDTWzmV78AqnbLikG7EOyzmJKCGaYqBI4SmibTbkoKuY2jOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_163528_008372_E7E4B4ED 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
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

T24gMi8xNS8yNiAwOTowNiwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KDQo+IFRoZSBOVk1lLVRDUCBo
b3N0IGRyaXZlciBjdXJyZW50bHkgcHJvdmlzaW9ucyBJL08gcXVldWVzIHByaW1hcmlseSBiYXNl
ZCBvbiBDUFUNCj4gYXZhaWxhYmlsaXR5IHJhdGhlciB0aGFuIHRoZSBjYXBhYmlsaXRpZXMgYW5k
IHRvcG9sb2d5IG9mIHRoZSB1bmRlcmx5aW5nIG5ldHdvcmsNCj4gaW50ZXJmYWNlLiBPbiBtb2Rl
cm4gc3lzdGVtcyB3aXRoIG1hbnkgQ1BVcyBidXQgZmV3ZXIgTklDIGhhcmR3YXJlIHF1ZXVlcywg
dGhpcw0KPiBjYW4gbGVhZCB0byBtdWx0aXBsZSBOVk1lLVRDUCBJL08gcXVldWVzIGNvbnRlbmRp
bmcgZm9yIHRoZSBzYW1lIHRyYW5zbWl0L3JlY2VpdmUNCj4gcXVldWUsIGluY3JlYXNpbmcgbG9j
ayBjb250ZW50aW9uLCBjYWNoZWxpbmUgYm91bmNpbmcsIGFuZCB0YWlsIGxhdGVuY3kuDQoNCg0K
Q2FuIHlvdSBzaGFyZSBhbnkgcGVyZm9ybWFuY2Ugd29yayB0aGF0IHlvdSBoYXZlIGRvbmUgcHJp
b3IgdG8gdGhlDQoNCkxTRiBzZXNzaW9uID8NCg0KLWNrDQoNCg0KDQo=

