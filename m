Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35155CCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODFcwkmCnxQyXLxzTGIxj5UuaZVfAOuNQWCzjQ2O+a0=; b=J0AkcuCiYaQs0LM7SdYfiOJOR+
	w3Feh5JB30zz/GoRXOaCu/3y5hfiL56wPFOpHh+GFYEbaZvFCFsjUq0MOodI6T5VsP2PsgYCKqNqt
	wvI41oHzANORBVolUMbGYBaCxZBsvmHN1ARjJhyFiqfilTZccal7t40y4xql9QXvAyNlVL3nk3UVM
	PFQcqXpum12puyDQQXp53GicwrwXWmMUmDOOoZm3btxF5J9Cxc6IrGlYwYQiL0YGIP4G3gGn7z5aS
	NDT/biZyLxbTMsfsVBZf9KSNjVf7BW/ozwK/LsACVFB5LQVOIsA+sBpT+zBFX0dQ5Z6/HGEvp3S0j
	tbQlLLWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0Sa-0000000AYVJ-0DeF;
	Mon, 03 Nov 2025 19:43:24 +0000
Received: from mail-westus3azon11011046.outbound.protection.outlook.com ([40.107.208.46] helo=PH0PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0SX-0000000AYUo-1fWL
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 19:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFfbEhTSpt4E1yOmhHgxbIT/5iGwl9RysVgsRCx7W3LaQQVHFvpqkzSsAXRYXNwiuQn0PT6fcw6wqSLJ9zjRAKwXimm0IgCgN8BxNto72uwQP4B7zUY/hP0h4sqizwg/ccK/U6ep/Tggj0I8SODM0iYxv1eUhieBw12D6q4o9JrgUUB+25T3hEmwxgYNjctUe1TmQULTXvwl0gBpzXLf03p0kq3xwbKDTi86WvYjmMyEExPJOYuPZZKBBt3YKViaE0JXbVvnmpoIBecfJZ8TLhr5b+0eQjMnEfxy8wVyshyw/letpp3kL0KLa0Y4ORH3rpZpe1nZbQa1K9aBmaS4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODFcwkmCnxQyXLxzTGIxj5UuaZVfAOuNQWCzjQ2O+a0=;
 b=C9ryYRvp6o8rkcOUB3sGyFyt6ZW/ZgaWbja2xlq3by4B4iVCu41aoSD8HWJUkGgud/hUgQOI3gRhqAi7Ui4GwAs4qyonfrQSgborbo3xEqw2f8UxqD+O/u31m4byIYJSTyseg3YKf2hFhqzbKsU7VGPZ1Hy3iVRU38gm9zVdO+oXgFqiaG8h0Xh2H7H+1q2IHU4XnG7IV0k3aichfSg1IyG4YD/7XATyLnkUp275t/ZwETHBFVZNCAe6igEH9vDchCk8UuXwUc9ybWhdtV+Aop4Nv7Tf0ynXxoAOQYMSgl1dPF2rQbibfJxD08oggyuFzFKUCWO5Cg1JzpRgg2GsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODFcwkmCnxQyXLxzTGIxj5UuaZVfAOuNQWCzjQ2O+a0=;
 b=bP74lZn/RzVSldetuNAMUdx9kYDcZmmD/1QC2zhqprKKqD/VxlY29FhMK2CSmoTqgeBD44P2yuIInXWq1Bd4wOWFOw6U4s4VufhHJilxhevgwBbemIYkwiRrszX1jqOCHhP3kglAeeSsrxdrJu9kytSGKyl655LHyKYdYZsTHQNLvxqdmuhVaw4TY7eQ7PCRLlMYOHiVAxrju3XdS+dDeeCqLjuTGwQqQrXcas6pbnbgDS7OyjOxrs765BNUAZhMLmoPcGljaFsxt8b7b0x/bwivo+PNBEOoig0ZaALMiA+rP+YUHSuLTrepPDkZOIfuvGj+/7T72kVDy2D/Fo/GwA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:43:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:43:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Thread-Topic: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Thread-Index: AQHcS6dOT3rhmsQbb0GfUm6eWoYK8LTg16OAgACFP4A=
Date: Mon, 3 Nov 2025 19:43:15 +0000
Message-ID: <53b8bae9-03d5-489a-a9f0-e9323bd0252f@nvidia.com>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
 <20251103114621.GB15280@lst.de>
In-Reply-To: <20251103114621.GB15280@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS2PR12MB9566:EE_
x-ms-office365-filtering-correlation-id: 0c2d8bb3-bc8f-459c-dd5f-08de1b113b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YTExL3pSVXZEOWlGNzZpcm9wT08vNzRTbEdndlBDelYzSzF5MVpoVzhnTHht?=
 =?utf-8?B?bFdVRm9kODhxeVhoSnRxd09aT0NaTjc2b09LOWt3N2wwcEs3UlBVbnJPbWFP?=
 =?utf-8?B?U2hrTjRqdWEyakFqOHZzMi85TUNsdG9nc24rRU9MZDBWdXVrVjBzN2syb004?=
 =?utf-8?B?d3I4MEkrcTFwMnhxc1poVVB2QVl0TCtyS0JaR3lLMUJHcWVzc05ZdXBpQnl5?=
 =?utf-8?B?b3h2ZnQ0N2VIL2FmdDF1S1BNUlpRa2h6L2pXVVdNSm9oRXBod0tOQytlODRE?=
 =?utf-8?B?Mm5WOFZ0VU1IZmkycUcwV01LWENtWXFEOHptK3hyamNtNE83U2d4akJsZzdU?=
 =?utf-8?B?TDVkWlNnUkxaREQ0SlhtbTVFRUlPb2k1N0ZjbTA0cWoyb0xQQndlQ1VxWnE2?=
 =?utf-8?B?VkJMRm1RYzkwOXlOYlE0clhPdDVUUTR6QXhCd3lHTm91NG4vMkYwUjVXOVdr?=
 =?utf-8?B?aDNENnd3ZmwwL0xnaWhONEdvOHJMTUhPbTkxOVR0K1A4UWVVMjZieHVFQlZ3?=
 =?utf-8?B?eXIvTXRncksrVmo5bkErdEw0N01EaHdvWkU2UkUvNVFIbWFOdzh2Nlp4NzF5?=
 =?utf-8?B?SDZpOWhwYzJRNS9yWXJEYjljbnV4dUpiRHc4UHdGUFJIQWhjVUZ1RGlrY090?=
 =?utf-8?B?aWpCempFOEZhK0VoaGtiRUc2YVJJcFo3Z2dPNHQ3ZVlSRFVYcG8vS0N1RE93?=
 =?utf-8?B?RlpFbzA3RE5CN08reVd0WnB6bkVqQXpaS0FZM0lKbEhTQ2RJSzhHd240WGdz?=
 =?utf-8?B?VDFpUk0vbjBjNU5lTzBneW9tTXA0VnA5aVZpK3Y0b1FDQjlSdlp6VVFoMmd4?=
 =?utf-8?B?TkxlVVJoSXcvTFk4VXJqdVFxTVRISUt1Y0w4a05mMlo1eERCTS9rMjhNSWNk?=
 =?utf-8?B?Ylg2V0QzaUl1a2tabC8wSXVWS2huM05YRVJ0c3o1c3U3QVUyTmpBdmRSbWg0?=
 =?utf-8?B?ZVpoRytKT3ZyVFhQQU1YMW1CZS9tSVFlRUlMcnhqRktreUt5Zm9CR1F0YTBX?=
 =?utf-8?B?UUI1MVJNK3RtZ1FiUVNWYmNpditEWFFlVWVkYzEvTGV6UFQ2TmJpSGxZekZ1?=
 =?utf-8?B?dWNyT1ZnVjhZanBSV3VaenZVS0tyREdCMld1YjUrODhCZVhXVWVSSGk1Q2Ur?=
 =?utf-8?B?UHpyVXBqZ3NMUWloRkFFK3ZBcUlpNzFxZ1dybHNjY3JaQUQ3d0VVNUtzNmRU?=
 =?utf-8?B?dXEvUFVFRjdNakFXL241MnJZWnFKWEVsWU9leXo4dlZYNWNqbjdzZEZvVFZt?=
 =?utf-8?B?c0NWa2dGS1R0YUpnR1lONmdJMFB2a1Y1OUZlangwOUtWMHVKaGg0dm9kQjhJ?=
 =?utf-8?B?M1A3QzNWdDFwUGVGRm9UalZibUx5SHhMMExOd0FzN1hzSFNUTnhwdkJhS3dT?=
 =?utf-8?B?YW53eFR1THZmeU5vbk0zZ0QwNjlTSHg2VGNRZG14UGJ5MWFMVm02eXhBbkxX?=
 =?utf-8?B?eTVNT1FIVUlzNkM3MVNZNTlRaFYrLy9HT05sRStZTEthaWxzL1U4OHRlbGFS?=
 =?utf-8?B?RjlNWDZZZTVnLzlsVTlIdzVRb00xb01WUkROU01Cb1l6MlpuK3F1QUJOVFRi?=
 =?utf-8?B?NUs0eE5EMVplVnB6aTAzS2JwU1hDclcyQzNid0pRaFg2REgwS1FEM292ZjNP?=
 =?utf-8?B?QU9pZ0dVeWo2MjNBbW55V0FvT1UrbHVvRGRqVkFWYzRTK21TQkpOWWVEYWFH?=
 =?utf-8?B?YkxIOHhKcGtuMW5FS0IxVmNPQ294TFNTZ2wxQ0E5K05oSFBqZFgvdVN1M093?=
 =?utf-8?B?NTZ4RnBZTUw5enM2allTMDNiZlZRUDhyd2lvdHh1SzljeGxXcVJrdnJ2WXRv?=
 =?utf-8?B?ZGVTcDR5VVkzNzV5cUJxczdKQXpESlFMUXZnKzJBNEpXazY0MnM3S1lFM3Ax?=
 =?utf-8?B?dHBSbjRDYS8wcGRXeWdMb2s0elhuNlc3MVdVUkt5dEpuTkVYQ25pYzZubHpS?=
 =?utf-8?B?Qy93eTNES0NDVWdWdDJQeHBNUDIwclRiMjBKdmxrL1hGZlI2TE5nZ0VxU3JB?=
 =?utf-8?B?RTI3b01aMWREQmlIRWdzZ1BzSitWbUo4ejMwRjNrb3RoRGdyVTdKZ09wanp1?=
 =?utf-8?Q?KGTg5J?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2t0TmdpNEsrOURGcy9wd1VITHRVeWpsS3VwRCs1Y1lXZmNNUlZpS2cwUFFk?=
 =?utf-8?B?eVEyWmtsam9TSWhKQzZsazVMQmkyT2luZjhKdGEwbEt6Mkd3b1N4aUtTNnEy?=
 =?utf-8?B?ZHo4c1ZjNWl2cTFsWkh1Mkx3Y3ppcWxROVZSWXp6eWZ6K2Jwa2lZdEhGSm1D?=
 =?utf-8?B?Vm8rOVFETzQ5WHA4UVBnRC81UDdqL05kMzNkRlBIcE1xaHA1RzdUOWVpSmpP?=
 =?utf-8?B?aVJjYkMzRDlqbEFjdGRDNmxlMnZRUGFzZW84UXVmRy8yUkNGZ1JSQ1NMWHRn?=
 =?utf-8?B?QTBzQkFtd3A2RnhsVFdoWHQ2WTR1NE9hRWJxRG1qQmpiZ1hOd0thYkdoVDVi?=
 =?utf-8?B?U21KVGt0U1o5U3YzZC9mcFkrUENGNGVhZHN0Y291RWxycFdPMDd1UzZRRlRY?=
 =?utf-8?B?SVRyRzd1RXJkaDZHdzdxNjVMWWJQeXFCS0Y1VkhEc0ZBcFp4MFp2N3pYeGVI?=
 =?utf-8?B?U3ArMTZHYjlXT21WZE15dWljSHJxRlRnaWF0TGJCT3JvV2NLTUdwSjR5MzZH?=
 =?utf-8?B?TC84Q2YyN25YVGFvNFFJRDZWVEdmS3NhNWRTZG9iNUJwb21TU2loRkhPVmFl?=
 =?utf-8?B?SXJXRko1SFFOM09UZDhmcmNnZmJzVmtPMVkxalVkYmNxbnhZY2Ivenlhd1ph?=
 =?utf-8?B?d3VMdTkrcSswYXErbWpXTVMxMXRVc284L2MzRlI5TVdPbUFRRE9wNTVZY2tL?=
 =?utf-8?B?YnhGTWhsZGpybGRSeUo5QmJ5U2RINmRBRThnWGt0V2pTSGRCM3pjSk1iT1FE?=
 =?utf-8?B?cUdUMFp3enBsSUFoU1BmNTB2NkFGbzJDSDNXOFBSYngyZ0wxb3IvSjhrUmts?=
 =?utf-8?B?S1FJbmY3d1RiVkdPWHhZOVZ6bWxIa2VZRTgwN3ZtOW1vamVBSGFJaGUrN2lj?=
 =?utf-8?B?RWJXRTNsMVg4VTdUZUtwN2gvSEVBWW83cWNjVFFiNmZ2MjkxZTROYmd4OVZa?=
 =?utf-8?B?K25CQWZqZFNkeS96VDFTZEVXeitFQThpaVpxZHFpQjB2ZU1Jb25WbWRqTm5V?=
 =?utf-8?B?UWRjbHBBck9ZYTZwSFN2U1FhbVE1ZkphWEpLWmVVeHMyQkZ5R05Cc09hdzZ3?=
 =?utf-8?B?R3dPYmhxcVN2N0l4aWEybk43VjVTdndKSHZZRDRCbkY5akF1MHp1TDZSWnRm?=
 =?utf-8?B?RkRCMTY3c2VFQ0l6YVhOVitHNHhob1QwVGYzUEhNSXRQVEk2a1JySGo4RE9F?=
 =?utf-8?B?V21NbTlzNER4OVJoVHZrNC9sNXJXTVdNb09UM1pCblVYYUN2UnROLzlZQmRP?=
 =?utf-8?B?VUYzSVU2Y0ZNNFpnSFppMytLR0d1QUdRVXNoMzgxSS9peUhyUG5oMUdKeE9B?=
 =?utf-8?B?RTljWXhJNE8xUituMGp1aDhwNHJtMGZWK245UnpNdk9MR3R5Ly9UdFRDMzAw?=
 =?utf-8?B?c1dHdlJ2MHMvVm9rR3FwZUJ1T1VRTnRieFYwc293czBmVk9sKzNPN3hTb2tN?=
 =?utf-8?B?WnlpV0QvaXZieE4xSzFGeE1mNHNZakQ1STNTb0xBUzVsZ3lIR3N6czBtY0tv?=
 =?utf-8?B?ck02SzhvdkJxSmRFcEc3dHNSRjlybWx5b1k4SGVveXBzTHAweTFqaEtqc0Nv?=
 =?utf-8?B?Q3BxMlppZWJELzhHeFd6aWNyN3lheVJBNDhUaSt4Zkt6YjhHWnZSako3T0RL?=
 =?utf-8?B?RllsYlo3VzBpNkh0Uk5QcXZOeWsyMnNVZ0dSOFZWWUNDZkppcmdJMlRxMzJq?=
 =?utf-8?B?UXpveDYzNk9EUldBb0dyd2VvL3ZhWjUySk9zanYwM0JkZXlMa3FiejNVQjFj?=
 =?utf-8?B?M3B3dnBZMllqWFgwSTNIVjVZd2JPemJkNURHSTcrODR3QjIzU3N4bUVTMzlF?=
 =?utf-8?B?R0lkTFAxWExxZE05akQ3aW9uYWV1ZVpqOWpyc04wMUIwZzVOOUpsZVdrR2ND?=
 =?utf-8?B?Z3JYR1lyNXJXdmJJaG15YmJyMEh0eEZiblkzL0RhdFVOcG01aHRSV3NBaHRQ?=
 =?utf-8?B?cGlSdk5xNmJDd1k5OEVMTStHZmVtbnMvUmdDbDR1M2phUTBoRHVIYUNjeFNu?=
 =?utf-8?B?NmVjdUE0V3B6ZmRQYXNuVkRLZTdESXlaTHI0SjBFSEtWQ2YwSFBHRVROSys2?=
 =?utf-8?B?dDM4eUw1MjJxOHN6eFJyWnVzelNRSHdnL1U2UzhjRjk0U2ZRRzdZa2M0U1lZ?=
 =?utf-8?B?bjhuS0liRE05UExJZFBpN2xlL1dUbU5CcVYwM1ptakZBdE5kTUgzZk53YTdj?=
 =?utf-8?Q?7OlPYSl36JNYrOu7JzHSSybtLd7h+BEIjLmwWCxLgKw1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10E98AF0B358CC4DB636F040BF0A4B8A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2d8bb3-bc8f-459c-dd5f-08de1b113b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 19:43:15.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SG3RfzOb9GfRHejwuj0fYXJrsSEyhoYYCxOAJwSuZGIVPhgRfizJB+XPdDK+XX5+OJIBIbWFVD6G0OUwYUAPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_114321_445190_2E1DFA76 
X-CRM114-Status: GOOD (  11.22  )
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

T24gMTEvMy8yNSAzOjQ2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gU28gd2l0aCBL
ZWl0aCcgbGF0ZXN0IGZpeGVzIHRoZSBhdXRoIGNvZGUgc2hvdWxkIGFsd2F5cyBiZSBidWlsdA0K
PiBpbiBpZiBlaXRoZXIgdGhlIGhvc3Qgb3IgdGFyZ2V0IGNvZGUgaXMgYnVpbHQgaW4uICBEaWQg
dGhpcyBub3QNCj4gd29yaywgb3IgaXMgdGhpcyBmb3IgYW4gb2xkZXIgYnJhbmNoPw0KPg0KPg0K
aXQgZXJyb3JzIG91dCB3aXRoIGZvbGxvd2luZyBzaW5jZSBOVk1lIG92ZXIgRmFicmljcyBJbi1C
YW5kIEF1dGhlbnRpY2F0aW9uDQppcyBidWlsdC1pbiBvbmx5IG9uIG15IG1hY2hpbmUgOi0NCg0K
bWFrZSBtZW51Y29uZmlnIC0tPiAgTlZNZSBvdmVyIEZhYnJpY3MgSW4tQmFuZCBBdXRoZW50aWNh
dGlvbiAtLT4gKg0KKCogb25seSBvcHRpb24gbm8gPE0+KQ0KDQpudm1lIChudm1lLTYuMTkpICMg
Z3JlcCBOVk1FX0FVVEggLmNvbmZpZw0KQ09ORklHX05WTUVfQVVUSF9TVEFURT15DQpDT05GSUdf
TlZNRV9BVVRIPW0NCm52bWUgKG52bWUtNi4xOSkgIw0KDQpNYWtlZmlsZSBjb21waWxlcyBhdXRo
LmMNCiAgIG9iai0kKENPTkZJR19OVk1FX0FVVEgpICs9IG52bWUtYXV0aC5vDQogICBudm1lLWF1
dGgteSArPSBhdXRoLm8NCiAgIGF1dGguYyBnZXRzIGNvbXBpbGVkIGFzIHBhcnQgb2YgbnZtZS1h
dXRoLmtvIG1vZHVsZQ0KICAgbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvbW50L2RhdGEv
bnZtZS9kcml2ZXJzL252bWUnDQogICBDQyBbTV0gIGNvbW1vbi9hdXRoLm8NCiAgIENDIFtNXSAg
aG9zdC9jb3JlLm8NCiAgIENDIFtNXSAgaG9zdC9zeXNmcy5vDQogICBDQyBbTV0gIHRhcmdldC9j
b25maWdmcy5vDQogICBDQyBbTV0gIGhvc3QvYXV0aC5vDQogICBDQyBbTV0gIGhvc3QvZmFicmlj
cy5vDQogICBDQyBbTV0gIHRhcmdldC9mYWJyaWNzLWNtZC1hdXRoLm8NCiAgIENDIFtNXSAgdGFy
Z2V0L2F1dGgubw0KY29tbW9uL2F1dGguYzoxNTg6MTM6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg
4oCYbnZtZV9hdXRoX2V4dHJhY3Rfa2V54oCZDQogICAxNTggfCBzdHJ1Y3Qga2V5ICpudm1lX2F1
dGhfZXh0cmFjdF9rZXkoc3RydWN0IGtleSAqa2V5cmluZywgY29uc3QgdTggKnNlY3JldCwNCiAg
ICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQotY2sNCg0KDQo=

