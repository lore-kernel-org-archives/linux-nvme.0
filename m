Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BBDE7716E
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Dec 2024 04:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Date:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9vv6mg3evQH6pT0UIrg+Lqw1FTasEvqQXdGlwfTrHNk=; b=Y+Slq9hmQFwavshe5OCV+wuRoJ
	HVdTYpjCgkQZ6pHp/dsehpe6koLdQoOMPAbqFoqpVjCbL2EVEHfpf7aN0oYu5+00OI+IVvnhiu3iF
	UFKjFyUDGPsjGgQvUHxVFuhWgIU8GV5lCUZzUouCURL1qZCIITi/DatZ3oZvGaLeL74e4PbpVrPpv
	Ih9bD9tpNmobyhYAMKLpE3dx3dMgE44RljSzcQ7K2JcSVzqWsmodZ56jO+jkmgRSz/eRz0OAKwi1k
	G8E6z9Fys0mXgO2yF+FoKHDZ61Njm/bhuMbRVCRKaUuTf5higkeQZd5F28jSVgv7CVCP6CRwn1RPs
	PkXNqc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJmL4-00000003IlX-0JPl;
	Sat, 07 Dec 2024 04:22:42 +0000
Received: from mail-southindiaazolkn190110001.outbound.protection.outlook.com ([2a01:111:f403:d408::1] helo=MA0PR01CU012.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJmL0-00000003IkO-44TB
	for linux-nvme@lists.infradead.org;
	Sat, 07 Dec 2024 04:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBiGhCjuPW57YJTBUXeDBglrxCq9TQ+qbh6l9GkfQrGckBnItYCqMQ0bXy/YzATD0qK4yu5q9UQuTfIbFfElOLRNWcZLqFVQNYtBmWmV9eE1ODQTl+vAZ1s75sKwmDqe09m6eIi2ZNEEOmgTTXMn/W/2B4IgzsFItpby69EIn8FQ5o8TUNg1UaIZ1Na37y3Ig7sDcTuvIpxyGKx+YFaIUDQqP3Hb4lDRVNW9ckv3/XCeEhznRXVSC3k/Dh0egZIQkVRalguKAIc39NhnIT1qoSyE3Ln3BRFu4qMNMzxl0hZbmqvAQO+F/oADfF9KtAg2PN45GaUm7gR9ZcyuOHw2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vv6mg3evQH6pT0UIrg+Lqw1FTasEvqQXdGlwfTrHNk=;
 b=ZO1WjmlFpdmKATYfJ4fglkSTGv/uAgPRAhVNrKdOL+LhPfaKf+v8pUHJ1f2VzJQfMfI41q7X2jJPxfWHej42qtxd2i7B8MKqG/SXQAt1oICSP0pAF0cbxYCjYSiwCT9yc2Isn4bfiyJP060KugWXWGG7dgYp6KsopnUok8KZWbjDDsQXAcKydm9lDX0SiW8urt6CcaqleJ78KIangOulF9MSBq/dk1zH/hU5BF2HqxUhD+DFS7VQHRjnyC1Y50HUIMteDo0jvyONXlje+A+b6+zFZjy1rVUYphgw1yy9i+OYfgGrsEGPGUpgPwGSLsv2DCLoeXOdIKNigSSR+OEjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vv6mg3evQH6pT0UIrg+Lqw1FTasEvqQXdGlwfTrHNk=;
 b=ow4OSKp802FPNSdAmEypId7aHLElIqY3fHt2xxr1BFL0rNy1npvnZjfKtUIN3BmLsvbqub2yhSoO/zdco66gYbcMu/QvzpWSRD6y2XsB+mflRlOTfHq3ArtGPktdCKa+Zt1nVVQ8/sKzjYGm6ptXkblbyz/WW7zkYi6NRaSPHOFLpHeHnY0O1qh+OCaPtujPA5wjyD4hSlrkU4U2K2NY58gvF2YZlAU0Ygv1oFkzFHNuIf8f7uI29Yx4+5cxngp7wz3eY4Moy9IrApWTpt25zPs2JYvZdF7dp536SItAwyU4/giVB+UP+BfyZcAkEfk+eIi5xd/mph3uEUT2R3llmA==
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::20)
 by PN0PR01MB6405.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 04:22:25 +0000
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4]) by PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4%4]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 04:22:25 +0000
Message-ID: <PNZPR01MB4528CE2B4B42BD765EC8DDE1FE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 7 Dec 2024 12:22:13 +0800
User-Agent: Mozilla Thunderbird
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, fengchun.li@sophgo.com,
 Chen Wang <unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
Subject: [bug report] WARNING when nvme_probe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::20)
X-Microsoft-Original-Message-ID: <f855508e-2d19-4118-a63d-5789b0a0fc90@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNZPR01MB4528:EE_|PN0PR01MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9786ca-d89b-40ce-e143-08dd1676be37
X-Microsoft-Antispam: BCL:0;ARA:14566002|7092599003|15080799006|8022599003|6090799003|19110799003|461199028|5072599009|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUpaNlZUUDlPem1VZmplYnYvNUtydVFpZnpxZlg0d0JtTEdBaXRCeTljRko1?=
 =?utf-8?B?S29tc0ZhQTJXRjh5V2FEbUZCbXJVUWhxdHRTam5WZzhlenY5bXdQSFVyMTJy?=
 =?utf-8?B?ZDBpcmlwL3dZMnVrWDliTTRxaFRjTS9QRytjVEVDcWN4SVZEM3VCNTIwckM3?=
 =?utf-8?B?bVE3aU9JaXJRNDBad0NLWXRLNVRNU2RjZFBFdytNNVhMaEdiV3BQY0xIbkxY?=
 =?utf-8?B?cEJ6WDVkdERzQW9QbmlXUkd1WjVDOHlWUG9MR1RlalhLUEV1dmRaN09vUnZo?=
 =?utf-8?B?QllwS0s4MGRLeCtYMU5RL3JkeXA0azAzU0p3dVpSbFUxb2dCbSsrUHM2S0l3?=
 =?utf-8?B?OFdUczcrM3NEbEhpTm9KeDZDeXFtdGdsREpCdG9NUHg2NVpHV0hjQXlSbUsz?=
 =?utf-8?B?OTZ0Nng5cEFob3lOK0RqamNkZHVwYklMRzk0Mi9FRmpWQTBmdHNjdWxEVlZ6?=
 =?utf-8?B?QUttMWxLU0RQQkd4U2pjRGdVcTBCcFdOTjlMRVVYTVBCWHdzY1VhYUNjdjlJ?=
 =?utf-8?B?aGVnd0tOeFVlWXBoMWRLU25oRnN1amZqZnRMVXdJWmpZTkRXTVlNTE5Da2hP?=
 =?utf-8?B?ZzFWRS9CZldyUEVKNCtSTFM1RlRUOUJZTUdiNUVEUmNxdHF5dUNIdTBFcGFZ?=
 =?utf-8?B?SUV1Z3BhNkk0WTFMUnEvMy9TRHA2QnVXUmFrOFJ2Y0V4VzQvSUl2RWUrZ1I2?=
 =?utf-8?B?QWFLT2NCdlpFczlxWDV3OTBHQ1RtZWRRR2J5UFQ5QUw0VFZSV21uUXJRL01v?=
 =?utf-8?B?dXNmQ1BwL0VJUWE5L0FWb0I2bStTWjBBMmF5TXRTTFF3Nklna2Ivb2pYVHlr?=
 =?utf-8?B?d0dETHgvR05sZUhEOGI1aTJHNnBOdXRwOExzMHJ4L1ZDSWZyT0hJRzIwaXRw?=
 =?utf-8?B?dzJHclpCai9SSWdtemthUTNpTDlzVHh1SnB2amMxSmxkNkIvdGVNVXpyd050?=
 =?utf-8?B?TXVrWkV5VWx6RnVqeXRvallTUWRXTlRHZkNlZEVPYWtZTnFsREdmd09mdjZa?=
 =?utf-8?B?cWEvdERDLzV6dmpMc3gyWkw5aHlmWUdpVkdIeXd4eXIxZ2xBQ1pwNjI0bzZV?=
 =?utf-8?B?d0tLQU5PV2ZaUlB2R2RxeGFibDR0NThuTGZyNi94bGVoOG1VR1JYOTFuQmRj?=
 =?utf-8?B?TFVPTFNBWVM1ZXlRSk1TLy9MQitpNStCdnBhQUJyUkIvVkdMOGRJRjZ5b05t?=
 =?utf-8?B?ZHAvTm0rUzluMXF5QTR1UmVHQnB0WWlJVFI4OHJKd0F1Ukw2cmJwcWh1OU83?=
 =?utf-8?B?QU5lRFRQemYxd01xbGhPQnR0N2I4RG1oZlF4TGNPeDhMekc5Qjc1blJxYUth?=
 =?utf-8?B?MXpkQ3ZDUmRTejJTZ2xGbktRaUU2TllmcGJOeCswbmRqWk80OU8wRFV4NnZy?=
 =?utf-8?B?ZmxwTnZQYXlvMEVtMlJRSEl4c2RCSEtoOG53WFowblYwN1AyZC9BSTZoSngy?=
 =?utf-8?B?RmhPanB5NFZKazFlRC8zT2t4aTBzVGZIeDliSUs4TVVYTkNGTEpsK1paZjJr?=
 =?utf-8?Q?el4xoIUFIgTBdvEhLIDBNBwWmAz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBwZFBTK1JpZkQwRUFkcWViZGNaWjBDL2xobGtMaHJ6dTB4dHZQdk1EOFkz?=
 =?utf-8?B?Wk8yb2RJYndYMzhWVHk3VFdOYjVyQU9WdDE1VUFnejVyNi9wMWowSnQvb0J2?=
 =?utf-8?B?akF2WXQwWEFlU2hGaStPL1RUa3o2aitqRWNMUUZHcUw4NVU3a1NwcFNWNm5S?=
 =?utf-8?B?UXlIc3lpcXNXODVxVXp3Tnp1NjVpYlFiSUNSNjdyVE94VjR1YldTbFBFMDI0?=
 =?utf-8?B?WUxzczBSazZMWi83bklpR0JBUW1nVWVWNXExdXhxSWREQ3VqS29KeUZ0dlc2?=
 =?utf-8?B?UG5MTFdUSitiZEI0L0wwYnlVdkdiMVhVSDhlK2FnQjI0dGtmQ2NaK3pyTzFO?=
 =?utf-8?B?Q1ZXOUdOZ1dtVGU3aVQ1TWFLMFFKVGJzd0o0T1I0VkFMVFNEN3kycHJMMlM4?=
 =?utf-8?B?ZUxmaDBDeHJLT0tUSjVieXhDUEYzUW1ORmZhRjBJSklud1FPMENkem8yY2VW?=
 =?utf-8?B?TDYyb0hkTXpYVXFmeGtTMk8zeUtVMWVXNzNkenRNMlQ4ejNCaEs5cEVqcUMx?=
 =?utf-8?B?b1UwSkNYK3lpK2pOVmhHN3h5Q3pNNlcwdCtPbHovaXZ4REhTVEVMU0RkQ0pn?=
 =?utf-8?B?ZDBPZ0VmTG12b2VQUWVpenNoZUVyRWtiR05GMGsvbGZDWXZkdTE2aEZ1ckNl?=
 =?utf-8?B?Zno3TXlSQm5xWEhPM3JiVUJoNFkyM05QanR4ak5SYW5WR3ppZzVYQ3NUTSsr?=
 =?utf-8?B?aVIxMHg1T016dXZpZS96ZWp6bWc5cFEyZDFwRWVsZ21YMWt0YngyQmJTdFhi?=
 =?utf-8?B?UmFySkwyT2UyclphSER0TkZZOEJNeTZZLzBsakEySUZhdVN5cG9jTTVvRVkx?=
 =?utf-8?B?ODR3WVdQdERWczN4N1VtQVJWWGptSEhlbXp6VGNJN2k1Y21FYnkwK2VEelcy?=
 =?utf-8?B?RER4bUxtZHNRMTQ1UDF6SHFVSkhjMnRWazgybXl3Ujl5ZzRWVDlMVjhES215?=
 =?utf-8?B?R1VhazdsNGdscnNxWTlRUnNSZGErL0ZGeGR0TnhUM2R0N0h6eXBMWmxSdytZ?=
 =?utf-8?B?Y3hOMkl6YWt6ZVpGZjdGK0hGYURFcXEzRFo1NEt1UWs1eHpQbFhBQjZMdUZU?=
 =?utf-8?B?MzJnVEdHamJObFROT2xOMjRVdGZ2aktqKzVsWmZ2R3o3ZnV4YWtvTjVBN29G?=
 =?utf-8?B?UGRwVUFYSFd2anFVanN2NWhQUEt4K1g2bzAwU0RKcVdzci91aFdjTlpmREE3?=
 =?utf-8?B?dURjSUt4NzM1bjhXSHhVMU1sdE9LTlFvNnZ5b3FkZDlNZzR5aU1sM3NZZnE4?=
 =?utf-8?B?NjlpQkVtc1o2SVpmSEZjMmZoelVXb3dBOUQ4QSsvUWxYT050b3JqdCtGQkFs?=
 =?utf-8?B?SWRqNmpMNjJrVFc1bXNSVWtFTlVjckFQclEyTkRvYlZRRkRLclduNEVjcE1F?=
 =?utf-8?B?RUlyOGpoTDhRZGZOMmp0Qk15eThleVpjSmNlekpwMTl1bi9LdlFmeE9FVDZy?=
 =?utf-8?B?N0hOck5yRzdORFpOemo1QWY5OG9yNzZHMEJpZ2lFaStQR3FPemVQZFIvazNi?=
 =?utf-8?B?SUd2azVqRE5VcjJQZXlDaXp2a3d6MDAwYjhVRytXY1pqZElncHlGL09TdHdL?=
 =?utf-8?B?TlJ0aDFkc2xBSkZiMnJjRTZETXZsVHQ4SkYwZGdyN2c2TUNZSW53RmRyS3M3?=
 =?utf-8?B?NDYwcjh4UExCdmxEKzVERnNUL1dDMW9lVGpyQjloZTc3OXlsRUJheFBRNkhj?=
 =?utf-8?Q?bIwxsoamjNYk5lPcK4h6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9786ca-d89b-40ce-e143-08dd1676be37
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 04:22:23.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6405
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_202239_270281_A0DAC1FF 
X-CRM114-Status: UNSURE (   5.26  )
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

Hello,

When I test with latest 6.13-rc1, I see kernel complains as below, but I 
don't see this in 6.12 serials (6.12-rc1 & 6.12-rc7).

I'm developing PCIe driver and there is a RC switch which has some 
devices conneted to, including a  nvme device.

Can somebody help double-check and comment?

Sent to NVME related mails and CCed to MM, who might be interested in 
this question.

Thanks,

Chen


[    2.075408] ------------[ cut here ]------------
[    2.075414] WARNING: CPU: 51 PID: 403 at mm/page_alloc.c:4727 
__alloc_pages_noprof+0x788/0xd08
[    2.075432] Modules linked in:
[    2.075442] CPU: 51 UID: 0 PID: 403 Comm: kworker/u257:0 Not tainted 
6.13.0-rc1+ #1
[    2.075449] Hardware name: Milk-V Pioneer (DT)
[    2.075454] Workqueue: async async_run_entry_fn
[    2.075467] epc : __alloc_pages_noprof+0x788/0xd08
[    2.075473]  ra : __dma_direct_alloc_pages.isra.0+0x1f8/0x434
[    2.075480] epc : ffffffff8029e252 ra : ffffffff800d1f96 sp : 
ffffffd7017bb840
[    2.075485]  gp : ffffffff82072a28 tp : ffffffd701761c00 t0 : 
ffffffd703b023b8
[    2.075488]  t1 : 0000000000000000 t2 : 6d7768206e6f6d77 s0 : 
ffffffd7017bb9e0
[    2.075491]  s1 : 0000000000000cc0 a0 : 0000000000000cc0 a1 : 
000000000000000e
[    2.075495]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 
0000000000000001
[    2.075498]  a5 : ffffffff82013d7a a6 : 3fffffffffffffff a7 : 
000000000000003e
[    2.075501]  s2 : ffffffffffffffff s3 : 0000000000000000 s4 : 
0000000004000000
[    2.075504]  s5 : 0000000000003fff s6 : ffffffffffffffff s7 : 
000000000000000e
[    2.075508]  s8 : ffffffff8213d190 s9 : 000000000000000e s10: 
0000000000000100
[    2.075510]  s11: ffffffd70034d3c0 t3 : ffffffd700260f00 t4 : 
ffffffd700260f00
[    2.075514]  t5 : ffffffd700260000 t6 : ffffffd7017bb6d8
[    2.075516] status: 0000000200000120 badaddr: 0000000000000000 cause: 
0000000000000003
[    2.075521] [<ffffffff8029e252>] __alloc_pages_noprof+0x788/0xd08
[    2.075527] [<ffffffff800d1f96>] 
__dma_direct_alloc_pages.isra.0+0x1f8/0x434
[    2.075533] [<ffffffff800d27ac>] dma_direct_alloc_pages+0x28/0x11c
[    2.075537] [<ffffffff800cdc54>] __dma_alloc_pages+0x3a/0x54
[    2.075547] [<ffffffff800d199c>] dma_alloc_noncontiguous+0x8e/0x1c6
[    2.075551] [<ffffffff80a3f352>] nvme_setup_host_mem+0x2a8/0x446
[    2.075558] [<ffffffff80a42dbc>] nvme_probe+0x730/0x802
[    2.075564] [<ffffffff806fb4dc>] local_pci_probe+0x40/0x82
[    2.075572] [<ffffffff806fc1a6>] pci_device_probe+0xca/0x1f0
[    2.075578] [<ffffffff809a2964>] really_probe+0x9e/0x33e
[    2.075589] [<ffffffff809a2c80>] __driver_probe_device+0x7c/0x132
[    2.075595] [<ffffffff809a2e0c>] driver_probe_device+0x38/0xc6
[    2.075601] [<ffffffff809a3182>] __driver_attach_async_helper+0x4a/0xc4
[    2.075607] [<ffffffff8006616a>] async_run_entry_fn+0x34/0x126
[    2.075613] [<ffffffff80055a16>] process_one_work+0x172/0x316
[    2.075621] [<ffffffff80056626>] worker_thread+0x2e2/0x448
[    2.075626] [<ffffffff8005ee4a>] kthread+0xc2/0xe2
[    2.075633] [<ffffffff80e8de56>] ret_from_fork+0xe/0x1c
[    2.075645] ---[ end trace 0000000000000000 ]---
[    2.094302] nvme nvme0: allocated 64 MiB host memory buffer (16 
segments).
[    2.223519] nvme nvme0: 1/0/0 default/read/poll queues



