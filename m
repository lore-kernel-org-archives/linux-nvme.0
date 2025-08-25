Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F144C8303F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VqHDpzhxQ+CyeJ+G8QZT9mK7JidT+GhF2CTKDufdjCQ=; b=AhjRJSYZgPS+ObGS5azVAzVtuu
	Tl+Y/WBKMLqVwsoAo/VmF+g/ehmkXCFaWWM+JDpfTgiv6jZWfNgOWlZkzt/4RiTFwnc4UxDB0Jo6W
	qDRefrOCMgTWTHn0s5onbOaYd7X1JPYevcjakubkL3HCjLVGnP7M0URJQbAS98QZwbq5v1IdK6Wqv
	wFnf3L7ROVyJQPCGwI13RYNJ7byM3EOuKzdNRTfe+0y2iO5bfiFUBjSQOqkM5QkOZYfs/P9EwXx/x
	YLTayuMWGqrfb8S1RYFcE7QkUxW/RUR9DsxdCa1+La8gc0VoJxObP1C7Q0kltG5H2sC/HLYTjH1Ln
	QeBCEQBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqcYP-00000009B73-0eDX;
	Mon, 25 Aug 2025 19:08:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqapg-00000008oFS-1QY7
	for linux-nvme@bombadil.infradead.org;
	Mon, 25 Aug 2025 17:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=VqHDpzhxQ+CyeJ+G8QZT9mK7JidT+GhF2CTKDufdjCQ=; b=lONb75WPs6yuSHD1MMoVuoeR6S
	wbfT75UPO5zOIiHzVwWy5bTi7DQdOqg2ZB+ikkbq3Cq/Rjw9q0g5Xx0UfqRPYTIljPmxVGdXGEuR/
	83x1POhKZn8me4/CCCpTrxWvV4ZhuQlkbIPlMQHfO/JrxmgJUnBD0zu8++k39VoHKAxUpAEhnUQMO
	3Ob3FGJ5MzGCdNAyd7XOS+dqToHHAjd+vfFLRpEeFFx8KiC7rmCmpHCEotm3yKpsaMijvWVOQAqd9
	OyhkpBbbGJzE2gKac+wfEtvA2tzPqG2Lp+K6gcvAXC0pMw2b04P5GN+PTL8SNI7bXS8ypW8WozOpz
	IIJrPbLw==;
Received: from mail-dm6nam11on2062e.outbound.protection.outlook.com ([2a01:111:f403:2415::62e] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqapd-00000001xZh-0EPa
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 17:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2PBDW4ONp3MsnqIWJbtXHjJBuYRpiUiOF6poLtc53B5m4NWxNWPipj6W/Poa4D5MQySA/mQ5uzjCcauz/PaodICO19hZsKJv+3U3jkyaKx8mF8P9dt+2nX1Y6l9tHyqYQuSio0vKFwMojx5DP7dQOBsjrJwvUNEgpol0IiE2uNJ/A96Wmhwy2/JjEl6upmv9okERtEornUwUHZv7JQ+zeKJvXtG7RitXOPZvir/ao78q31hyCM44zmjIVl14udg7YtCrgU8x5mwQqbmf1f5At6phLQLk8IMQaq+HK/A0TqSk9hmGuY11OOVnzlnWRsSk0CNXKpzXFYNeZ6Ih20+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqHDpzhxQ+CyeJ+G8QZT9mK7JidT+GhF2CTKDufdjCQ=;
 b=N7mVURNJ/Z/xakwcYKmiaob+mY6YD0xO0vpz4MUEbILkME3+G6SqM8oLJjCS89U9X7KWQUg4xF9AvyFkiknIqTFeIQL5ZFI7jbqroebVUZoEX3sKI4L/qB1WPJnMtoObm4ZaVYtyKVwyHqOvuVQ3x97vGzvOobdaUlBtL7wmGpWojBAE6N97BPryyD9MZ2I+Gm1q2QQ2FYHD63sa3Quxghscrb2IKm+eo5ywkYIS6wgHkEYrEyRJuW/6Rb//nohNucVYlqVnCjZ/f9EAVLECRJqI9PDSRZRS320S/xhJHDAhYPyEzUdbv3lkC0uyjpVVPASEQk/KCzv5prRDA6nyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqHDpzhxQ+CyeJ+G8QZT9mK7JidT+GhF2CTKDufdjCQ=;
 b=uNyMnNHPKRghuCjYql+/zORNVL2mA9BZAp41tShx+cDKdNz8maLgRCb0A6SoYArwTnexpuF1boRZGjDO8H2dd5COJr2Cm/s8TnuT+czg7wX9+2KbnFooCmseUXJ9dMs7Urq6yZe3eh0x2u31CR4uNp5LK6FFVVO/+obD9GU+I6I6jE9tR1L+MldCSQP/lQKYKxfpw5V6JCpfkh1GRAlWbshXxqS6TfWHBnJJwuW/FkjBpBXiBuTRIaoy7ihE0nmp6Mk0cWCzfeW6Mf/iiRyyZaKK6MBp8y9gGK8mkIlIttWCmY60WF/4zNi5Xtd/MsYRrcpvIHr+N5GhMJ2VWtj0yw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:18:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9052.014; Mon, 25 Aug 2025
 17:17:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests] nvme/054: fix nvme reservation preempt and clear
 operations
Thread-Topic: [PATCH blktests] nvme/054: fix nvme reservation preempt and
 clear operations
Thread-Index: AQHcE3l6wWb4L+10bUuTjcWwXrWeDLRzoXWA
Date: Mon, 25 Aug 2025 17:17:59 +0000
Message-ID: <b9d6ed36-9d0d-4eb3-930c-32fb6cb9e24e@nvidia.com>
References: <20250822150006.3248193-1-yi.zhang@redhat.com>
In-Reply-To: <20250822150006.3248193-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7535:EE_
x-ms-office365-filtering-correlation-id: cdc24efe-cdbc-42b2-68cc-08dde3fb576c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejVtbS9BOEREM0R6dFZONDRGSWRHWUdJYldGd3c1Q0c0VkpYV2JRNHdnZitt?=
 =?utf-8?B?UGlyUmE3VkRsOGdickk1clZlSVd5UWtSMG1mNEE5Y0JJWmVSWjFVdXdacVJr?=
 =?utf-8?B?bmg0b1A1WDVGU2tlR2EyR1plNUliR3U1UmFEeXJZZDBJSVAxclFRNWhaUGZQ?=
 =?utf-8?B?UjFuM2NXZzFGaytLaW1PRTNZVTNWQVVLM05TbDNFZjdDU1FwaDQza3cxVk1F?=
 =?utf-8?B?YXJ5TnlMK3o2M0h1dHNRc3BNYjB3QlphcXFZTEJtMWxhU2M2RzY3L21zNC9v?=
 =?utf-8?B?WWR2THJ3eUhxcWpINTFKWEFPWmFycm1KSmJocExzdVp2QVhTdGE5WmxtN1Zh?=
 =?utf-8?B?d0pZNjdTcDJrQmFLZ1p4WWlIbFJOY01HN2xBVTVXc2RwODA5VHhXZmVaVG42?=
 =?utf-8?B?bXd3dWtXTEowWUNMWUZ1N2Exai8wcS9QdDRjOUoyMmhVU05GY2R0eUhCYi9n?=
 =?utf-8?B?MEdBcDl0NnBPM3lRQ3BOTjZKbSsvdWk0MWl3eEMxS2xPcjB3U1BmdnRIZ3dL?=
 =?utf-8?B?dzJ3YVNiUDhWRWRiVmFCOUJHRVkwUE00bytqdklrZEc1TnMxb3k4eXJKRUln?=
 =?utf-8?B?djN1b3ZqbVpYeDRvWU5leHowZlFtenFoWjYrN0NYcjRNOTRGYTZUOXI4OXY5?=
 =?utf-8?B?RHI2SEd1dUNrN0V2MVJqS1FwMmFXcm0xRTQySVdWUFgwNTNyS3hMcWtnMzBs?=
 =?utf-8?B?Um0wVHdqdmIvNDcvQmhIeW9KMkErSmc3clRvMUNINnJYTitjb3VPdllvRFNw?=
 =?utf-8?B?TDlxeW5HdFNWUm8wa2N4Y2RBcDhieFk3cnJNdVRmYnhTTWpzVXhtOUE4M213?=
 =?utf-8?B?RDIyajdKZDdFQ3hLUHM3cngwWERzandwWkxSNXBsYmZKdm9aNUNtNXRBQ1BL?=
 =?utf-8?B?dE1ibXFSOEsyenYyeXlpZURuSWNyNlNUelhocitrSFZwRTRXeGZtbmhZQ0Vw?=
 =?utf-8?B?RmVrMzdobitoZmpDZnowWlNTWS9hNURtdDFweUNQeU5tLytIL01wQnpnZGdH?=
 =?utf-8?B?dkdUbHpleVYvTEhEYWV2RXhNT2ZTWFVNUGg3SDllbXhQS2ZITEhRMDMxcGlR?=
 =?utf-8?B?akozbTFzMW5TWDFSNmwzSkVxRGRMSW1nUTNkYU9GWjNDRis0L0tPWFNRRlFQ?=
 =?utf-8?B?QmorRmQxS1RERHNyUUpYYlBVWTB6dDBsU3BhVmZWdm5GSlBMeVY2V0s3SGNl?=
 =?utf-8?B?RzJsaTJ3UlRla0hIU0FHaHZIZHpmR3p5M0x2RmZXYkNFcWRHZUdYa2dyWWRz?=
 =?utf-8?B?M3E5Y1lOR0tHVDh4VHAyc0V6SDlDRzUzTWVxSWsrU29VblBwbGo0RGpRVjNj?=
 =?utf-8?B?Qk1teUJtRzU2UTRvS29ibUpKbzV2U3NDSzltekJoWFVTb1o5Mnc1REdUZ25R?=
 =?utf-8?B?VDVTcDNxcDRrcHpDMlRIZVg5cWZkTVVpNEpnUkcwZmJBbU1jWnlLVXJzSXVX?=
 =?utf-8?B?S0NMK0Mvd2VsUzQ2VTFvdkpFNEg5VWJsV0xDWVFaMmJsLzN1aG5Idko3WVI0?=
 =?utf-8?B?YXJGdTVUYjh2R0x0TUhmb0lFcmx5TUtGYTJvYkJVVUQ3cXVtdWhDRmo2ZU1p?=
 =?utf-8?B?N0dvS0g0enRrMWlVaTB0T0IwTzVwTzgvcFN1bWJ6K05qVkJaSlVuYSsxckU0?=
 =?utf-8?B?TGFxTGY5Tm1weXBiY05HZE82aGxjd04yUFZRM24xVFFraW52SkYxclNreGVM?=
 =?utf-8?B?dXpKTG5ZNW5Wb1FVZks2akNpSk1uMi9kUmE5UEh6WlRlbkdleEpocW82clkr?=
 =?utf-8?B?eHZWelJMSHNsNkxvMWFPdkpmc2EzSGV1OEZXUkp2ZndzTkdyMnpJQVBQcnpD?=
 =?utf-8?B?YnVCNEV2K0RWdmRnRDB4K0drbFdjSmQ2RG9pdGpxbVF0ME14dkpuVkhQM1M4?=
 =?utf-8?B?cXJ3c2pHT2k5NXM3SjJKUmdtUXBHVitiSmxralJObmJlaFY4RmhQUktNbUlj?=
 =?utf-8?B?MkVyQlR1TnlzRm9rZmY3NGRGNVBob0piemVxZlQybVp3V1ovYjlDbEVJYnBp?=
 =?utf-8?Q?do1PU3umu3nqAFMBcRTmaFH666B34U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjBJVWZXakhmcjhTMmUxOU90U2t4ZmJyaWlLK0t2TDJDL0lpTVJQMlZMbUJQ?=
 =?utf-8?B?RXgyZG1Sd0l3QVFmenhSNmtuUW0rZXB2Qk00Q1o4aUYzbFZ3ckw2UEI4dGJq?=
 =?utf-8?B?clFjbExqbldtd1lVbWxyMUYxUVdZVFVIVzE1Q1J5M2ZCR3RMU3YwQU9RL3Vy?=
 =?utf-8?B?RUFvSjZaUjBiVTVoZ2hBRzhib0FOMEJ0VUk2U3VVUGVrc2hRbVBIZUpmUU1M?=
 =?utf-8?B?ZzAybVRqSTN2Vmw3ckh2TVhEU2ppOWZidVJyaDFvc0tJcEV0WTB0eHJhMzlz?=
 =?utf-8?B?TnhuRllYSnhleElCbk12cjk1VkNFZW4yd3gvUEJsNFlhSk5IMkNqWERKMkYw?=
 =?utf-8?B?YVorQU5NYmRnR09DbUZOUDVBczVsOWcyejVkVU52ZEpDdFE5NkZlQ1Fub3Jv?=
 =?utf-8?B?SFQ2MGNHby9NZGRWMXU4VXZNenlxK0hxbHJ5SytmOWE5VFVVWE83dXNNRUNQ?=
 =?utf-8?B?TkE5Kzl2Y3NzYnJrUTliM3U1dmNreGtXbHhXZlJXeElwdzBxclF4c3NoeG82?=
 =?utf-8?B?cjl4S2F3SDlJM2xxcWV4WW1jWDRoVk1RaDlxbnRnUFFTN1djVWxIMFMyOWlJ?=
 =?utf-8?B?cE5DSjVVN2RuY0IrZ0JuMFdvekZjYmhNNlZlRDFuWldUMmVNZzNaWW82V2R0?=
 =?utf-8?B?QWtKMEhiVmkrTEhDdkRJNlAyTlp0dlZQRG9xZkhKOENWUjBNNWs0NUNBclZo?=
 =?utf-8?B?Tk9mTDNCOS8xLzFYaEN3MWR2R2hlMEgwcmpDbHY1eTBtei9GT0VES0RWSVAy?=
 =?utf-8?B?ckJCMFkzcDFWRGp2ckpkS2F6ME9BVEFoSjczOFpDSXBacDA0a2FnaVR6VzMz?=
 =?utf-8?B?ZzZFVU9LeDY5eGlrbFJiczFpZFd0YzFFdDBseWsrdFdnWnNURFdjVlBtSWpx?=
 =?utf-8?B?cU1STHFya2VnQUZzRlQyUms4OEV6T1R4QmFMempJeVhnaytiVnJST3VoU09u?=
 =?utf-8?B?UGJsOUQ1UWh4VEM0WFJ2ZVBPUkFxMHorQUZHUkJiSWhwZ2c5ZmpleUdYSWtK?=
 =?utf-8?B?bGZDa1ljYTY5ZVk5RHREdDNXNUIydFJ0OVB0UCtqZ3ZsZ2xOLzJlU2kvL0RO?=
 =?utf-8?B?QkJDVkdUemV6TGgvUzhZSjZyK0lmc1NjT0ptMXBtaU5TTlNUTS9kOGVyVHBM?=
 =?utf-8?B?SWZhdkxvZDVaMmZYWThSZ21aeGxTVHE5Qkh2ZzFLSWpzb2IxOVEydnB1cEcy?=
 =?utf-8?B?UUNGYUdjUkRPa0krZG9MZkhkSmFaMkVOd3RLU3lUWmhqU2hyNVBvYWI4Q0Nh?=
 =?utf-8?B?ME4vZCtZbEIxV0JyWmkyejJJamFGeFNKKzdoUlJqNmN5OWYwYVVJdFlmT284?=
 =?utf-8?B?QVFsV1hGMGtNS1J4eGc5VytQQ1dJY0FMUkloOW9zN1FnUUo2ZnQrSVF2TFFL?=
 =?utf-8?B?WmM2eWhJN2VuRlBtZTl2eHg2NVR4ZkwxdlNqdUtnMk1UV3NndjVuN3RFdmxM?=
 =?utf-8?B?WFRiWEhRYU9QcVhqZ3VRTXdtdXhRS3NVQVJvdEV5L20zWjRyTTUyVTgvYzQv?=
 =?utf-8?B?SzNxNnZ3V2xVN0p1NjA3RlFvZXhJQTViV0NCT0VHV21FWGF4amVRclhLV05N?=
 =?utf-8?B?UGFZYlZ6UnJYeHJIRzA5NmNwOEM1V2NmRjNWK0wybm9TdENLaUhYODdVTnY5?=
 =?utf-8?B?enBkTUJWZmJ1Wnc2UHZ3OUhZbm8zdzNQdFN5L1htOTl6UWtDbmdlNEFlM3VX?=
 =?utf-8?B?dktzdWdad2JFTXgzSUg0MnlNeFVXY3NMVE83OWpQRHFKb2tqMnRtQ09zclhD?=
 =?utf-8?B?bUVzVkhmQzc4U0pvTUVKSHVBRVJhTlEzZnpYTnltOFk5bEJXVkZOLzM1bUNG?=
 =?utf-8?B?RE9ZWkprV1MxeEUxcHl2aml5MWY3ZnZYcGtWcU9WNU1tRW9QZUZ2R0hLWlRy?=
 =?utf-8?B?aTFPUlNld3A1MEFTbm5HdVQ2RU5iY05KOUkrUWtFOXhDTTVXRlRoWmIwaTRu?=
 =?utf-8?B?dnppNjBmQUxEK0hFaEloL0JyM0hLcGd5SGp2Y2ZaZlIxM2xlL2Q4emI2aFZl?=
 =?utf-8?B?OFJNUHI3MnNiTmRpbTM4TXlSbTRzMHg1U0pqbnRXbFE1ZTJyT2NKRWM2bWFL?=
 =?utf-8?B?dDN4NjAzT0hEUTB5Wm4wZzVvUkUrOU5BQTcwSTM3TVU3K3NEOHRPa1lobkZR?=
 =?utf-8?B?UkY4K2ZqalpqVDI0NWRkQlY2ZVlkbVYrOGY1MXRlOWsyRVMwcGxqeis0Mmh3?=
 =?utf-8?Q?DFVrRh4KCcomnAw0p9pT5I64jjEXIFrgLXi9Nk2k+OcB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0220686F9209A4195F0C5CB1381AA1B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc24efe-cdbc-42b2-68cc-08dde3fb576c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 17:17:59.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djqeMpp7EA3wEGW4nWwlbK1BHddD1jMTfCH1Yu/KNLx38O7UFt1ooc3RO/wjSPkKseJ28oF+PQPH55DbD3zSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_181809_242810_2968572F 
X-CRM114-Status: GOOD (  12.96  )
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

T24gOC8yMi8yNSAwODowMCwgWWkgWmhhbmcgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggZml4ZXMgdHdv
IGlzc3VlcyBpbiB0aGUgTlZNZSByZXNlcnZhdGlvbiB0ZXN0Og0KPiAxLiBNaXNzaW5nIC0tcHJr
ZXkgcGFyYW1ldGVyIGZvciBQcmVlbXB0IG9wZXJhdGlvbjoNCj4gICAgIEFjY29yZGluZyB0byB0
aGUgbnZtZS1jbGkgZG9jdW1lbnRhdGlvbiwgd2hlbiB1c2luZyByZXN2LWFjcXVpcmUNCj4gICAg
IHdpdGggLS1yYWNxYT0xIChQcmVlbXB0KSwgdGhlIC0tcHJrZXkgcGFyYW1ldGVyIGlzIHJlcXVp
cmVkIHRvDQo+ICAgICBzcGVjaWZ5IHdoaWNoIHJlc2VydmF0aW9uIGtleSB0byBwcmVlbXB0LiBX
aXRob3V0IHRoaXMgcGFyYW1ldGVyLA0KPiAgICAgdGhlIGNvbW1hbmQgZmFpbHMgd2l0aCAiSW52
YWxpZCBGaWVsZCBpbiBDb21tYW5kIiBlcnJvciBvbiBzb21lDQo+ICAgICBOVk1lIGNvbnRyb2xs
ZXJzLg0KPg0KPiAyLiBSZWR1bmRhbnQgcmVnaXN0cmF0aW9uIGluIENsZWFyIG9wZXJhdGlvbjoN
Cj4gICAgIEFmdGVyIGEgcmVzZXJ2YXRpb24gcmVsZWFzZSB3aXRoIC0tcnJlbGE9MCwgdGhlIHJl
Z2lzdHJhdGlvbg0KPiAgICAgcmVtYWlucyB2YWxpZC4gVGhlIHN1YnNlcXVlbnQgcmVzdi1yZWdp
c3RlciBjb21tYW5kIGF0dGVtcHRzDQo+ICAgICB0byByZWdpc3RlciB3aXRoIHRoZSBzYW1lIGtl
eSwgY2F1c2luZyBhICJSZXNlcnZhdGlvbiBDb25mbGljdCINCj4gICAgIGVycm9yLiBUaGlzIHJl
ZHVuZGFudCByZWdpc3RyYXRpb24gaXMgdW5uZWNlc3NhcnkgYW5kIHNob3VsZA0KPiAgICAgYmUg
cmVtb3ZlZC4NCj4NCj4gVGhlc2UgaXNzdWVzIHdlcmUgZGlzY292ZXJlZCBkdXJpbmcgbXkgbnZt
ZSByZXNlcnZhdGlvbiB0ZXN0IHdpdGgNCj4gdGhlIHNhbWUgc3RlcHMgb24gTmV0QXBwIHN0b3Jh
Z2UgY29ubmVjdGVkIHZpYSBOVk1lL1JETUEuDQo+DQo+IExpbms6aHR0cHM6Ly9naXRodWIuY29t
L2xpbnV4LWJsa3Rlc3RzL2Jsa3Rlc3RzL2lzc3Vlcy8xOTANCj4gU2lnbmVkLW9mZi1ieTogWWkg
Wmhhbmc8eWkuemhhbmdAcmVkaGF0LmNvbT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

