Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE4EC2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 23:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RghMB2OcWD8UUpyPAUPpoc8AX4EEscD96qxoZZtptJE=; b=a2PEp5yCzIxuyINmbMp3HyrxRg
	5PLLXl7Rp3ZeGH/712x8KLpb57BqqoI9kMxfG4FNeN4VFR208So8+KILnno/ZF1nFGyhoXz/zdisL
	2he7QUxXU11wQ2iJFrVuEuWIgY/DIsVu6IU723mUr4QgIxtwSqAqKwhqXTaavPf67tjWMrw35ZyvJ
	AIAG0w6/05feXAyyN/6QAphu4I3eDcUSNEAQC/l60JT7kmSey+I8hN1Lii86K4aGockAICJ5M+Vip
	+2uwjr6E0r8nWVN/K1/kOdqSAteux1EKpvn1iGbG29UvNBh6/I9cicMHtYz1Cyn7Z5gJExvOQbeCt
	v7Jmxkcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH9zp-0000000Avhw-2GKO;
	Mon, 19 May 2025 23:34:13 +0000
Received: from mail-mw2nam12on20629.outbound.protection.outlook.com ([2a01:111:f403:200a::629] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH9zn-0000000Avh4-1VLz
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 23:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ9bde5zws7GpJg0Wv5nWZ/QqIMReU5+Gq8jAVtAwPUSDtLu6ONC7hJGZzn5JLmKRGllSm98m5URXHy2184JdcGTbGgIH4cy6HN0TSI4RheUWI0tniKhr01X9uA2Q/0R3dSRx+sl5OVnjPH6k7y3rM7Tys5WnZqDBlhJgVYbZs5FQzKJWZBS4KpHmhTazv32nas498EOqrnnHUL4N0q/hhx9xzkssyoY3XF8Q4eorA9O+0eXqepkPx6VeCOnAWe9aU2z2AOx9midH80WpoaBEZ816FCVeAijtgLXIz6aJgDybZWtyd1bVW+JprT1bGg4BJE8JDoMJ1YOCHWi3nu9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RghMB2OcWD8UUpyPAUPpoc8AX4EEscD96qxoZZtptJE=;
 b=vpCAoWvFNFvj9OP49IYXBRFieDeExq7DwVsC+1UKTnc8owKbkn569nKeIgVGkOmRXvV8hdenWDCG+68gXmED0BoWJPT5sdMgUJ4It17esi27LLElB6ZMUgxBLVihW0+d6omx+L7tz3e3q5cj/91KF4fwOQXYzvKnXySkck5zKST12GtfWqADQVaWKNBnxygT4GTgElwqFtgf1xX1q+n+gZvva3mBzjfhFcy8iuG3KKC2gYZEexP/UAA/amWdJ0Mu2tEMby30EbSYdAPuoi0D733Gv7KXRDNUFG1D6024PMGDHQcNuzBgL23RGohWg4Y2LJ849StEqCeP2xMB7+QpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RghMB2OcWD8UUpyPAUPpoc8AX4EEscD96qxoZZtptJE=;
 b=Pxu4eNqokwX5RB5ILcDZc7Y4vdLhavZegfANeKsAenD6aWY3+J/fli02jJCIHe7/l4qmm87JQO4Wggcq4cjgG9edYDiN2uSc3MZTt65H6arNtwsdLeDlzAk600D87FzHtF+PnHr9TGuallwDX4DWjitLE46ovqIYjm9WtqlyUSseBvgUHFO5lGeVQF9eIp2On61QAM4exwZIUHAfeL2uvjvtozcCRf2nYOggCFiVBQGrNbrFjHug6Mn/WYABEf8RscxqH4P3MtJ0zF6D7lLwvg3CS1ZFCoX2lEsYk/d1u1JaP6c6YNGakat5Jfgl/7QqpWHV3A0B6GSGXoL3m7rq0Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 19 May
 2025 23:34:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Mon, 19 May 2025
 23:34:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: derive and better document max segments limits
Thread-Topic: [PATCH] nvme-pci: derive and better document max segments limits
Thread-Index: AQHbxjNuY6oYWz/8CEqkEYs/AXyx/rPaoJ2A
Date: Mon, 19 May 2025 23:34:06 +0000
Message-ID: <78852044-1678-4c32-9416-7d97d92cf545@nvidia.com>
References: <20250516072152.166131-1-hch@lst.de>
In-Reply-To: <20250516072152.166131-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7561:EE_
x-ms-office365-filtering-correlation-id: 7bccc40d-5e42-4fb3-9cfc-08dd972da58e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RDZGdkRSdjgvdFVyN2xzR3VWU1lzSzhNenczYlAxN3FFRHJUdzZrV291N3dr?=
 =?utf-8?B?LzZDUDQ5RnlBTFVJOW5YQVRjZlRNNnhRSzZBVE9RWENXMHZjOUNWSVVQdUt4?=
 =?utf-8?B?WjhxTFV5RldGTUxnVmVsK3ZHL09Sc2N1UEdkb2pVdTliZVEzLytiZUZyeDJp?=
 =?utf-8?B?K3NxdloxUGNVUk5GOEk4SS9hQitlMGh4SDRRdGJKV0UzRkpSalYwY2Fob2Fk?=
 =?utf-8?B?ZUhNbmYrOUpWMGZIYjk3MW10R0VvY0dac3RVajNQUXg1QXZDbm9GRVFZU01Q?=
 =?utf-8?B?LzE0dU9mbnVIRmVsZzlvclJkWEtGQXFsbTJBNnpleCswWitMSUJHaVZZOC9P?=
 =?utf-8?B?L2xGaGszOHlzdTJPY2pIM1I1c2RmZDM1ZTI5YjdjS1E1QzBMS0ZQZXJvWDg0?=
 =?utf-8?B?ejNJRUR0K1BXb1hxUHVia1pRSHJtTXFCMGRoUGxhOExzamc3bHBPMGtxM0dL?=
 =?utf-8?B?Q2crNENpVUdlMFJPK0NtU0V6MW10REM5clpLclRnNVdIQWJnUGU3UTlMeDkx?=
 =?utf-8?B?R1RFa1dnVGJIbjVQU294Q3huQW0yUUVNVk1zMUV5STRsQ2xpalFFQUh4WXRm?=
 =?utf-8?B?Ylg5b0k1YkRHWDE1Q2h6b2U0ejRTb3hCdmY0MHJDU01UMXNJUFh5dFVidjQ4?=
 =?utf-8?B?QmdaaVNORTdyREdRS1d5Z2J6bUlaRnk2WVNrMlFlbXFYVWh4NWwrRTdKd0JL?=
 =?utf-8?B?YUpxYklUOXBKTWN5ejZUaXFMSmRMS1JRZjMyMDVSZXI2R0k3R01NZHJYYkpJ?=
 =?utf-8?B?SWVZaWw2MlkwRTI2U1pwa1NYY2x5dzV6VklEeUFtdUUzNVpuNjA3WVdsbWta?=
 =?utf-8?B?N0p0L3lPa0xlc2gzcnlRREZVeGNwMXpXL2dLMnVVMCtFazdyVSsxWFI4RUZF?=
 =?utf-8?B?ZTU3NjZiekV5RVNtNEdDNjN1WThDZkkxblVoS0RIRVA3dTJ1a1lyWXVUWFhz?=
 =?utf-8?B?Qm5IN1M5ZTloMnlWVnJXV0lpYWU2Q3lUQWJ2QnhpN29MYnZjcjhTNEo4elRy?=
 =?utf-8?B?eE9pRXMxVFhRcGVCS0RvQUVwcHpYTStQL2dIUlpXZ1I0emt4VFJVY1A3d3k3?=
 =?utf-8?B?ekxsN3h6dXk4L0MyV3ZUcFNZQ2t6MjZ5SFROSmdiNUk5NkRRTGw0b3FrUEZG?=
 =?utf-8?B?L0dPaGdhWHZqREhIeU9mbDJDMFZCbE84SnFyRzJSY1BVMXZ5ekdMNW9kMldq?=
 =?utf-8?B?VU5hbHFtQlpkWG8xZVdpQjg1bHdNZVdpUHdKcWtQMDFLblhOMWc0anliYVJD?=
 =?utf-8?B?RDdycC82UGlBNFhyOVVHRnJlVjRhVTMxM2lQWmJxMGw3eElQL2Nqdm1NRUdu?=
 =?utf-8?B?K0hlNVVsWXdmbmFTR2hYclMzNklpWVExbHpHR2JHbnVPeXZDcWRKUlJNQnlr?=
 =?utf-8?B?c3ltZlA5S3pJc0xRcDRScWp4Z24wTGlJcWtMUG52dVREcGpWMmFUTEdaN0xT?=
 =?utf-8?B?ZmFub29nTzNCUGhXSklWNitjNERNUSs5VFBNUldtZGtuaCtlNFJUcVI1MlpU?=
 =?utf-8?B?K3NjbS9iNzJNYXBndndtQXVrT2NHTHBOYXlNY2RmczQwWjA5aGtWemJFVWw4?=
 =?utf-8?B?RkVnNmdMZW5JWnF1TG0venRUVGNEY0s0VVhYTVZqUllYUVA0dVZMd0MvZE9R?=
 =?utf-8?B?WnNwRmZSRi9WWUlxbDVaczk1N09pb0tSaDh0amxEUm1GcXFHZTl3RlFJWEYr?=
 =?utf-8?B?MWZTdDI4N3VEMUsvajdEM3ZGckpJNDR6a1Exa3YyalFHTVl1K1J1c1FBdU9P?=
 =?utf-8?B?Y1RwK3VEN2tKb3dWalhiVUp0ZitmRUlkWU54VHZkWmt2S1lsQXFpOUFXQnha?=
 =?utf-8?B?NEpONi8zSUlWdyt5aGg5ZEtsSHUwOEl0RDZXVTJUTWp6MTg1eGc1enQ3Tmcx?=
 =?utf-8?B?SGptbFhXdzZNTmdBbEpuSXRNemlFU2JlY1hrTk1EMFV3VVo1ditUZ016Mm5R?=
 =?utf-8?B?TWYwMFUvOVF6UzRrOWo2OHE5dkZqNnhqMndoOVNLaWhzbVFCbDZ0NWVjVXUv?=
 =?utf-8?B?NUZhN1VDQjZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2pqcm9DOEpiVFVMeWpMQy9lWE16MmRHRHdMYmx0UHgvQU5JaUxSUUptc1NB?=
 =?utf-8?B?WDRZVXJpamtwMEhaa3NZa0p1Sms3R3lPdm1tWjV6T0x2ZkxHaGs2NFh4SUpp?=
 =?utf-8?B?QkVVNDdIb3Q2YXA4R1ZiNUx0QjVOQUhKbkxYSndWS293cEo1V25hV05DM0Za?=
 =?utf-8?B?NGFtWmFXdk5DaWlpMXQ2YVRRcU9nYWJ3d2FyeDBVa1RsN0FuL3Z6dFNrQytU?=
 =?utf-8?B?ekZWbWpMenpVeUNPSk9pT0JQVUxjTkQwK1B1ODR5M0dYR1RXOTJzS2VCUXNR?=
 =?utf-8?B?VHNFdS9ob1l5REF6djQ4Vzdua1RNRHJ5aUhGeWdibkRwcFNXNlQvdE0zZmd5?=
 =?utf-8?B?Mk9HemdqWkxTZ2RVWHVPMjd3QUIydTFXbEtGMS9RTE9oVWlJVHA0aTdId29E?=
 =?utf-8?B?NVFaOXFqd0ZIZ1owbk5ZeFBoNFQzYm5TcGZhaVRlWU9EQ2xVVDQzL3JrZ1d3?=
 =?utf-8?B?TEJjMzFsWm55S1BEcEdqNC9IZkxaOFZTb0tsOFIycFhWUS9MbENLRnZHVnhj?=
 =?utf-8?B?aEhIMlJrT1pMcGs4NFdiVmVJN1JaNWdIV0Y3UFgzRy95VzNKZy9WRG9zUUtD?=
 =?utf-8?B?cmRDR0dtbzdMUEJLQmlXVVhmQ2JGOVl2ZUUrMWFVM0J4VFYwZnJBcXJITk1J?=
 =?utf-8?B?RkJTSXpkV0VqdnVrZDl1Mlova0E3RDZrMWpmZ3lRM3ZIbkxHY0lwUHNDcDVC?=
 =?utf-8?B?K294MHZGTXVSS3BJL1hpcE9KSzdBcVZrSkdrdzlBS1dUSkI5SDBNSGdrelJ6?=
 =?utf-8?B?eS8wdFJLUnkvY1M4OHFLQ1Q2OGJQMUwySjF6ZGU2TTR0QmNOdjZ2Nk9TeWlP?=
 =?utf-8?B?cFhMZlVjam5ja3N5Z25tYTJxNUdzM0JrTnQyRTAyVDZXVmUvM3V6SVA2MDIv?=
 =?utf-8?B?VzUrYXMrTzdZZHloSkV4MW9IRGNROVNXQkd2RTZWY2lyMFVpdDFtdDE1UDFo?=
 =?utf-8?B?RjM3UlVMMmJSZEJaRmZiTzhMa1ZWTVJmSEc2ZzJwYWVSc2pPSmJBMWRoeU1J?=
 =?utf-8?B?dXY2MXF4K1JhN3ZIQVV0RG9qZWlINHp1OTZKeG84cVVCUStGOFpGejgvL2xJ?=
 =?utf-8?B?ZDF3UEhMbFNRWHl5RnJDVXUrbUVNdE9ueUtkaEZqL3haV0VmWnZnVFBRcTFp?=
 =?utf-8?B?S2Q4cFRDc0FWQU1Ialp5eUozeXQxVkgva2hqTFZUcndXbVprWjB0TDhEWXFL?=
 =?utf-8?B?d3hPK0Zka3BtSlVlaHQ5RnF2SSs5TU9OYk5vVGl3U2dJZXAwMEZQWHhZY1VQ?=
 =?utf-8?B?eEZQb0s3M2dhbmd3LzhHZ01aYmlVaUlqblpEckJuOVNVQzBRWGxONVN1elYv?=
 =?utf-8?B?MUQxeXNJdlhWVzJnVncrQXkzbU51cTE2Y1ZkM0F2Tk9lWUpSdytTOGdRSEQ1?=
 =?utf-8?B?WUFpQSsxK2pqYVYydlNHTDk4WjltYnFhNlVNQktSeE1PdWdtKzNFcjBRd0F0?=
 =?utf-8?B?MnQ1V2w3aUM0bUdoblBzMFNLK2E2V011U0xXd1FHT3dSYVRZaGVqZ3p2QW5t?=
 =?utf-8?B?VTd3dUhCa0ZHeGc2ZkxzZXBxSlA3OHZLeUFEWHNtZkFOR3lnc1R3Y1BDMkpY?=
 =?utf-8?B?WjNvUjVrZnRWSmtoQzJkd2FiTGtNRVJjVWF5TVlva2tLc1Q0LzZPemEwRXB1?=
 =?utf-8?B?U05mVElxNW1Yd1FyaWdObS9sTHd2T1ExNTdFM1YrSTB3OWVUWURsRkxueVJS?=
 =?utf-8?B?SFZGQzVLcGNCb05lQmZjcUdocDFRMWg2ZFFEMGNLcjVRanc2QXhRbDlac3Zn?=
 =?utf-8?B?ZTJXTEVxeGR2N1VaSkUrRHo4Z0gwaUZQenErU2h0VlpyZjJERW0xcTljaGdS?=
 =?utf-8?B?OXNPbms1MmI4UnMrc2srSmVKWENaTnpRSDJEdDk3ZWhiLzBOd3ZwemNnTGt5?=
 =?utf-8?B?MEZmZTdZdW02RjQraHQvNyt2aUxMS1ZwWmFCSFluRmhpcHlwMU5lWHBESEFq?=
 =?utf-8?B?WVVTaGJYRlUzanFydTI0bFJjSHRQTXgxQjdxY1BOellpK1RBM3NVLzRrMTBu?=
 =?utf-8?B?RFU4a0dqNTFMM1lUcjJ5RHZHY3docVBTdkU1am02eW16ak05MStwN0tRNm0z?=
 =?utf-8?B?Sm0walNocEpMOHhpWnBIZ1BKVEFrZ08vUTlKeHV3RUlQbWZXUXQwYnFIcFRB?=
 =?utf-8?B?MGQvOEpYYWx1K0w3cTlSM2IwRGgxQ29BQ1JlYnZrT2ZjaGF3RGhQbU9CMC9y?=
 =?utf-8?Q?Sj0Bty8GXyzZT5+6Dlvo4cIuEM7omE+VtS5I3bXjaiWR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ADE2D686FE73C41925D465BFC852BFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bccc40d-5e42-4fb3-9cfc-08dd972da58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 23:34:06.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLn9uwl38bRy1X2yAMfvNEYJaQKFVH0p0PqlIvZsm3+6zIQHcZ7kI33v7fUoYRSXw7PI+CrzNP91Q+WWttNanQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_163411_395478_72AE8B76 
X-CRM114-Status: UNSURE (   8.34  )
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

T24gNS8xNi8yNSAwMDoyMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFJlZGVmaW5lIHRo
ZSBtYXggc2VnbWVudHMgYW5kIG1heCBpbnRlZ3JpdHkgbGltaXRzIGJhc2VkIG9uIHRoZSBsaW1p
dGluZw0KPiBmYWN0b3JzIHdpdGhvdXQgY2hhbmdpbmcgdGhlIGZpbmFsIHZhbHVlcyBhbmQgYWRk
IGNvbW1lbnRzIGV4cGxhaW5pbmcNCj4gdGhlbS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

