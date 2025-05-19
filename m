Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7587C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAHxkih6MapGJWbR1m8kbkPZbApOjHK9gX6S5RgbjuU=; b=pBhhjiaZbAI7Fhs3lNyNPd2b/h
	58hiMTFsYeD918E8iDop69B8MQS2txDoU4g6hM8Fhs0m/j8JcoKQVpzk01MCpnMpWQt1laSAACO1C
	aJMXnOT5o7HkR0NlSJrejSIFUFBJT0w0joHSWx8BoWCaWkmF+bTELkswpbqZdmEPvVn5Qes1pA5pl
	Ul0lCjdp9/3wftdhOd5F55GO5S/oSdxv9S0dwfE3Tct1N+4V4U9kaE2F9+KBxDnFGwNOCtj9I4Pfw
	xzVixe3XT7DCUgJeXbwAe0yS5nk70VmIl07wNT4Xl+/lhWK2VPSjxqnfI5b82MSNECZ1ugrKhFPoU
	XopK8G3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH9xT-0000000Aufg-2nmX;
	Mon, 19 May 2025 23:31:47 +0000
Received: from mail-dm6nam12on20624.outbound.protection.outlook.com ([2a01:111:f403:2417::624] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH9xQ-0000000AucN-1r62
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 23:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxB0+gHuiBzpBTEPOiaxTrH7m4ZJeaAug3WjSPWWwjm84fog2EtyyyMzSFz2oc0xv/kTDKzOFdYpl5BVqSHM0E/WiZsrbdoWgOiZnx6KoiIRGPmkxX4Q18vGnMaKK8I2Jno+UG97LTe5zJbOBpvTrOAhZw7UL2ZsHr0V7EYbIpplIAi5V8pLFHi6Da/3xvhAXhAhi/SyTnWHeAupP5Z7JiuA9xUw5WpdQybAy8rLgQXAcWyZ7IMu2gaa+ia4aU7JPef+NMdWjclasmCDOmlFYUAUt6fFnKjCrmM/J0pGMMGOh7unlbn6lK2ggbQVaSToVK8Q2GNiK23UJXJnedsi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAHxkih6MapGJWbR1m8kbkPZbApOjHK9gX6S5RgbjuU=;
 b=Wlu2jJF+g2moBMmwf8Ddnwbmc9bDZXISWTo7gvyWFxb5/j/8tkVeLhNKy0envuFNVdwGTQ7DjMkJTJ41Tgfr9n8C2igr7iBmDRqCLQKUaxanlkzfZw3y87KTTDSdluze9uFJmnXPtuoXUBMT740dFZx1xhZukXuDZvCrWxicXkl/5j1vJ1yNHrNmR0DuH+s3DpEMFBPoi0yIxYQrQXSCno27nROQPAusnhSoWOqsVNw3y1HBH+mFSj+ki57nN6tNf+hOMQue7ZYESmGQJHgIDkTaoIJlVkB1j+5ejAE0mvKf3BPw4cYdifQ7XqhkdCaR/5KIYu0Bj5jA/BaVli07cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAHxkih6MapGJWbR1m8kbkPZbApOjHK9gX6S5RgbjuU=;
 b=iFfbr3QqTltqBjIh97QdwDbKoL+LIFnG08dAmpoMpzQ+oJ2klnLUkhS8jeKZ/Pnyz1XPaI4vYZMoBvgh3xR4EI1PskVpQLBAn53k18/rWyzyoYovO6RbEK4WgLjidNkHhg5wmnsrd0vgw1rNEPRNGwMMDSB0uQ3PuQf3U8nXjFYttBP0NejBrEGaiXyhS4Dmz/ByLbmGpOSpbsSGshNuFf3yZwmmq/ii/Im2Wqcov+lInrFq6A1JpGITSVX4lCHuUidUDJisiybuB0yjo2u9gQR0wAIVPeGrFlaPMDaleCUuOhXN9FoH2Y8/wOPTtEJxCVoqgR9qsK8CiJhh+Qv0Uw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 19 May
 2025 23:31:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Mon, 19 May 2025
 23:31:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli & json vs blktests
Thread-Topic: nvme-cli & json vs blktests
Thread-Index: AQHbyIHBcRAaAKIVKkadBVKxisXJSbPZtkGAgAABYACAAAI+AIAA4XAA
Date: Mon, 19 May 2025 23:31:36 +0000
Message-ID: <0362bd4f-4655-4f93-8023-945cacf31aba@nvidia.com>
References: <20250519054905.GA6156@lst.de>
 <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local>
 <20250519095642.GA21183@lst.de>
 <c8ea015a-8b60-4ffc-a706-f7eb5b65042c@flourine.local>
In-Reply-To: <c8ea015a-8b60-4ffc-a706-f7eb5b65042c@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7561:EE_
x-ms-office365-filtering-correlation-id: 9851baa4-8117-4b3b-67af-08dd972d4c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MVpjK2NFVFBFU0RpYkh4SGZwaFJTMkNWTVZkeE5QVXExRURWT0M0RisvekxM?=
 =?utf-8?B?S3EwZDU1TFRzOXpBdlJoVEN3ZlVyY3UwQWdjVFlxeUM1Z0U0dCtWSjFMc3Aw?=
 =?utf-8?B?L2tzV2Z2VzhkZHJKdUg1dFNrbFZYVlRNNGIzSURBY2FLOW5UNlVsbC9GZ0dR?=
 =?utf-8?B?Y1dNK2ZiOHUzV2lUU1h0ZFpFbS9GdTZqVnU0UkFPbUk5U0F1R2tpMnB2eXcw?=
 =?utf-8?B?LzhhSnFNRDVFZzl5b0N4LzM1WTBBbDAxM3o2SjNNVWtNbjl3ZVhsUkVuMjNG?=
 =?utf-8?B?U0lKNUhYb0VWb0NlSDREU01abUUvSE8zOE9aM1pNSUNRN0hpbUNGN2JidjdQ?=
 =?utf-8?B?ZFozcmRza2ZNdnZmU0cvQ1ZLT3pwU1V6bEZOa2ZHcTFnUkx5Tk8yLzZYQWJB?=
 =?utf-8?B?dlVJU3BFcjVOWVN4ejRkblVQeStJTDk4ZDZnTHZGdDdVZC96aGlUTVBwVE5w?=
 =?utf-8?B?eU11eE9pdUdGYmYyM2tGV0RtNnQvWjcxYmhmR1FhYlNWckx0U0xaQ2Fnam01?=
 =?utf-8?B?UG9tNkhSNG1Zck5rbm9paXBya3d0SFFHZnFaZW1Tb2JrMEtUTkw5b2lwaW5a?=
 =?utf-8?B?dTlHN0ZMRG9CbzhCdndMVDdlTEt1dXRBR3ZoYkFUR0dLMktNMUxYWHp5VENS?=
 =?utf-8?B?N1JMZG12YnFqWkx4SDNHSG5meTR4ODZ2R0Q2d3p0MktyeHpGbElBcGh5b0lN?=
 =?utf-8?B?Q25HYWlNRkU4YTlKYWVhd2R3RlVjYnJNdmduT3k2MFc1Vm9rU0IyRUJqL0Vy?=
 =?utf-8?B?eVJGcVhiUnFKNkhzSmhPQzdQeXF6SWdmakFyWURCRFlyMUI1YTBTSDBPSjNF?=
 =?utf-8?B?SXdlR0FKRmNrekFkMXBEdzNmTjhYSExnVU9iejBBK3V3SlNoSitvMGtqc3Q3?=
 =?utf-8?B?TlVOajBZb3dFbU52L3RYeHhTUHNvKzlpOWwzWGxlK3AzeGdKMVlGRzJ6WjJU?=
 =?utf-8?B?TExoMHRlM0dUN2RoY0hZcFI0Qk1XTFQzUzdRdDVBYkZGcWdUMmRleW5LV0FB?=
 =?utf-8?B?RDJVeGN3citYYUNQSVVzWWRXY0NYN3VWVFlySmc2aW1nZitreElmZCtoT0di?=
 =?utf-8?B?eTVzcGljckNhbGdoY1pqaFlzNzc0NjJ2bFpJNk0xS0VUdlZmVy9MVXBERzhY?=
 =?utf-8?B?am80bk94ZHZKanJWc0VkemNjMTF2QTBpTHduMEZIQ3plK2VOdUNDMzdyUTBy?=
 =?utf-8?B?Q0tna0RlR3RSQytMYmJIM3lUcUFOZnZhVVRHTHV2V2FiYk8vVk5WUTA0YlF2?=
 =?utf-8?B?MkZTdG1SYnlIdjNIeDJ3czdtanppRUk3cS8vMlFIbmRtck93QmYya0JlYkdm?=
 =?utf-8?B?N1IvQ25vVmU2anIydzVrcFJpTlZQZ3RldHZrU0FOVzY0UmVDSmxXZlBWZnYr?=
 =?utf-8?B?dDV3bkx5OHIxa2hxR3EzSXJDTkhPL1RIUHVObWVpNjFWdFRDZWNaeCttNVVi?=
 =?utf-8?B?L3JzNmhXQlZWS2hCK0lOekFVTzAyU2h5OUh4WW43cy9idXllSnQycVV3SEFm?=
 =?utf-8?B?eEd4VFd2ZDFieEpnSCt6azlOTDBmVjJ4aU9JUEtPRU13blo4NnN1b3E3MDhM?=
 =?utf-8?B?MU04RjJLZmVXS1hWdENOdTVURzFzeDFUdngzSkpONlFwMXlXbHZaNWFzcEFJ?=
 =?utf-8?B?MlM5eHV3amN4akQwcVZwWkI1WkptNkVaeTNtTzk1YzdkRTl0ZHovaEJLYWdr?=
 =?utf-8?B?blR2QnNDOC83eG9BT2tBQUt5WFBKSWNpOHVVcndxVDBicUEzV3V6NG5YMFln?=
 =?utf-8?B?b1diL3lqTDZYS0RHcGZtRmVLWTh0KzRoNVNwYktPQ2ZsQ0k3M1gxRDJ5M2J6?=
 =?utf-8?B?dnBDRnd6MmM3TkFlV3Rma25wSjRKYWp3SlBPOTB2VWJNOHBSeHhybmlrNUVE?=
 =?utf-8?B?dktxTnE3bXB3bXBHS0hVbUdsaTlVazhJWStUbkg3L1ZDdEhwS0s0NXVMQXJr?=
 =?utf-8?B?NVZGRUlzcnlvbnd1dDJPWFVrT0xiMXJINWRyRWxvUnpOUTdLbU1MUEZhRnli?=
 =?utf-8?B?MTdOQzFxSENnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWNuZE5aL3JFYXBNTEJsc0psd0NUMlFDeHhZMkpuZlF4UEtTT1RnWW5SUE5n?=
 =?utf-8?B?M1JMTC9OYWxyaGpuTjNwdFFSMTM3ZDR4NE9oRWNZVW1QVHNCaDRvTlJ6S1d5?=
 =?utf-8?B?RExmTE1xRm1FRDNsM1ZBcTJXSTAxQkhmR2pMbzNJUmFoSUJMZGJDci9MWEx0?=
 =?utf-8?B?TVdFYklNWm5OdUQzZnhsQ1ZMcTJ3Zmlsc2ZqcHZ3Z3ZSV1ZMaHo4WE1idmdW?=
 =?utf-8?B?U1Uvd0l0cXRPNktxOUk2a21VOXFRMkhoSXg0ZlpkUFg4ZmM5dzJ6VjBjVld4?=
 =?utf-8?B?RzY3dFVGbXJkWVJkNmplaVNmRGZDeGcvT2xDZWdUNUVwUWZKZ1p2RXU4a05i?=
 =?utf-8?B?THAyeEQzQnkxK1lMTXk5M2UwMmFYMGhNTTkybjdROGd6NXBtcWJmVjVxODA4?=
 =?utf-8?B?ZkNkMFNaUjhBbmRoTUZQWCtpMWtkajRsdkVqZ1E1Y2svMWRzQVdHM2JwZkpt?=
 =?utf-8?B?NzUreld2d1VQQnVwN0c5cHM5ZUF1UXhZM2MrN3RCT0xFbnJpUGJWWkZzRWto?=
 =?utf-8?B?NEdjRHFWZzJ5KzNJSnpJZVlCUElWdG9KbEhEQzVSYmVkN2hQMzJaZmxoeWFG?=
 =?utf-8?B?MEFHS3pFSW1jNy9QT0RTY0Rya1FKV1lYbTh1T3Q4L21Cd0tQYStUL0ZNb25i?=
 =?utf-8?B?aTdPMURPcmZydDc3bjNBa1pIZ2dHOS9rMjRXdEtTcDkzbDNicEtPZ2lJQW1u?=
 =?utf-8?B?Z3ZhZXFreDk2WVhvdUJISkNMOENUMXVjWHVKdGhhaGhjU3JsZy94Q1htVHpa?=
 =?utf-8?B?OFVHV0xyUVhpUkRZMDBVb0YwZXBYNjlybzV6eS9Yc1lHRG84Um5uRGpjTm1p?=
 =?utf-8?B?ZjUvODNKcGZmRldoZ3BBczNzRm4xZXhrZHJhQVN4Z1ZHVjFVb1RFRG44RFRk?=
 =?utf-8?B?dW43TzRBOFVJYlFNakJRVU1neTJpbk1IUWdVVFJXM0x6Yk1ncU9QL1lmSXRY?=
 =?utf-8?B?ZGp4N1IwTFI5UzhqRjZaeG53R1N1SHdUUUt4b090a3ZweVJhYWkvZVBWSVdE?=
 =?utf-8?B?VE5UNURpQUNzZWRMbU5RTi9ZUDJiNHl5UnhRcU83b3BnUWRZa2YxMWJKYm9m?=
 =?utf-8?B?bytHaSt2a0xUeTZXRUp2WWxqRkU1UUtMV1RlTWpQcFB2dXI1UXhtNGZvT0JK?=
 =?utf-8?B?YzRla1E4Z2IzQk1XSVdxZHh3UEppNlg0RFYrWStjUjk4SjdDdDg2WTFpbEtB?=
 =?utf-8?B?THBoQVZ2aG5qbFVYVFlncWpGY1JZM3hvM0VQTWwybGZjNCtFVkxXYW14WEg2?=
 =?utf-8?B?bUg0YTBOU0lWNVhzQmt5U25TV01mVlZOSVN0VjAyMlB1RXQ3VW5kNERkUTVH?=
 =?utf-8?B?MWZqUHBXZ1BGR25Gc1RISGwvU2RBSjEwbStaR25rSjVvRkZzUW9MbE5Ra1J3?=
 =?utf-8?B?bGhtQmJ0aUJldkhhK0dybjhybzU4T3R3bmtyaTNsUWwxZVVPWC94K1NsbmZl?=
 =?utf-8?B?K0NQL1RIN0FTSFJlbHQ2ajhnNWx3RjBKUTY0NDJhNmJFcXdkMWYrMFJoOXFQ?=
 =?utf-8?B?U2hneEJYN1hxNTlUdDdCOGJjcTFxVFpkTUZHRGhYR01EZ2c5QUxMeWUyRG44?=
 =?utf-8?B?ems1RmVYcGVLb3ZXZjE0bHZQYVJuMWZqQ09taVBMMUxXTmYxL2ZieDRMNmlz?=
 =?utf-8?B?WWJTZnRhalhsL1VRMy95RmEzYmZEL09lNnJCc3RRakxTZncwUGVjeWFhRGZs?=
 =?utf-8?B?T0lxdFFwRXZKS3dJQTRoSmYxRk9mSlduL3Ziby9BYkFhK3dYdUNHQVB0c1I0?=
 =?utf-8?B?M1FhNkNwTGtWMmljcUdVS2ZtSnN6RldjL3ZsRFZwcHNiaUZvT0ZYNjZNUHB4?=
 =?utf-8?B?dUJoNlhSQjZxS0M4YTViNGtaWjd2WGt1cmw0S2NqQllZTmZLdWhPaFU2MjZT?=
 =?utf-8?B?TWJFMWRFdFFva29ZNGhaUVc0QW5TajhGeExTQ0lqL0ZCc1ltd2F6a01lTklI?=
 =?utf-8?B?TDRnSDFPcGovcFJveTVGQ2xXbWRuRHZKTTByNXlFMWlsOVROS0tGbXlmN2VY?=
 =?utf-8?B?OTdYT0dlMCtjenlDdVcrclBEYnJqdmpFd0p1aEpWZ2lZNWEvd0duZ0lFQmR3?=
 =?utf-8?B?UUVVeGJBbE1jb2RmZzVFaVR6RTQxaWpTeUJkcC9aMysxeWVDcnU4Z1hyNHpa?=
 =?utf-8?B?UXplZHFrM2w1bUlGZ0RNMFBSV1d1d3I2WVNEQk5vOG9rd1pBU1gydlFZYWlm?=
 =?utf-8?Q?Fi9SJp9A2pSVHVVNXBqA/XoSeFnyWLa/lijFE4pyYJl5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70FD872AEEBD254180D05221C282134F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9851baa4-8117-4b3b-67af-08dd972d4c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 23:31:36.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiDI8WRSFHNJXvncXbmWpoF80dT9XZlp8IjbyPHBkpzZxCvsvhpK3eC9RH6mCkpAfOL+i8UIFRGg7O+Bqq6+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_163144_483334_C65F73D9 
X-CRM114-Status: GOOD (  15.36  )
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

T24gNS8xOS8yNSAwMzowNCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gTW9uLCBNYXkgMTks
IDIwMjUgYXQgMTE6NTY6NDJBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBP
biBNb24sIE1heSAxOSwgMjAyNSBhdCAxMTo1MTo0N0FNICswMjAwLCBEYW5pZWwgV2FnbmVyIHdy
b3RlOg0KPj4+IE9uIE1vbiwgTWF5IDE5LCAyMDI1IGF0IDA3OjQ5OjA1QU0gKzAyMDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+PiBtYWtlIHRoZSBudm1lLWNsaSBidWlsZCBhIGxpdHRs
ZSBsZXNzIGFyY2FuZT8NCj4+PiBUaGVyZSBpcyBubyBtYWdpYyBidWlsZCBpbnRvIHRoZSBtZXNv
bi9uaW5qYSBidWlsZCBzeXN0ZW0uIG1lc29uIGNyZWF0ZXMNCj4+PiB0aGUgbmluamEgYnVpbGQg
aW5zdHJ1Y3Rpb24gd2hpY2ggYXJlIGZ1bGx5IGhhcmRjb2RlZCwgdGh1cyBpdCB3b250IHBpY2sN
Cj4+PiB1cCBhbnkgbmV3bHkgaW5zdGFsbGVkIGxpYnJhcmllcyBvbiBhdXRvbWF0aWNhbGx5LiBS
dW5uaW5nIG1lc29uIHdpdGgNCj4+PiAnc2V0dXAgLS1yZWNvbmZpZ3VyZScgaXMgYSBkZXNpZ24g
Y2hvaWNlIG9mIHRoaXMgYnVpbGQgc3lzdGVtLg0KPj4+DQo+Pj4gSSBkb24ndCByZWFsbHkgc2Vl
IGEgcHJvYmxlbSB3aXRoIHRoaXMgYXBwcm9hY2guDQo+PiBUaGUgZmFjdCB0aGF0IGEgbWFrZSBj
bGVhbiBpcyBub3QgY2xlYW4gZW5vdWdoIHRvIGZpbmQgbmV3bHkgaW5zdGFsbGVkDQo+PiBkZXBl
bmRlbmNpZXMgaXMgdmVyeSB1bnVzdWFsLg0KPiBPa2F5LCBzbyB0aGUgTWFrZWZpbGUgaXMgbm90
IHJlYWxseSB3b3JraW5nIGluIHlvdXIgd29ya2Zsb3cgYXMgZXhwZWN0ZWQuIEkgc2VlDQo+IHRo
ZXJlIGFyZSB0d28gdGFyZ2V0cyAnY2xlYW4nIGFuZCAncHVyZ2UnLiBJIHN1cHBvc2UgaXQgd291
bGQgbWFrZSBzZW5zZQ0KPiB0byBtb2RlbCB0aGUgJ2NsZWFuJyB0YXJnZXQgbW9yZSB3aGF0IGF1
dG90b29scyAgJiBjbyBhcmUgZG9pbmcuIFJlYWxseQ0KPiB3aXBpbmcgZXZlcnl0aGluZyBhd2F5
LiBMZXQgbWUgZml4IHRoaXMuDQoNCnllcyBwbGVhc2UgaG9wZSBzaG91bGQgZml4IHRoZSBpc3N1
ZSB0aGF0IEknbSBhbHNvIHNlZWluZyBmcm9tIGxhc3Qgd2Vlay4NCg0KLWNrDQoNCg0K

