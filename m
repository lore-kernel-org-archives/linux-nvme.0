Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EADE77179
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Dec 2024 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxwgmCeQC2JIRzsYwdefo+PK6/qTErQw/zeQVl0IVK4=; b=ddGcSs6R5oZY7Ahx/y4t+YFnjd
	P96JKs8P+5AngHr7Ej/qDCix+pOAxy33JTfuIl69jg8A5flAE6qZraVFhhJrQhtWbdFbWdtg87Tzw
	GSuDcgqEcfKDOV8JeDotnvmGQ+wjIyRo3K8S5jCo8bGAOdbEMgW1uxlAEzjAJ/hDI5XOQ2d36lhDJ
	/Cj7Bb6lTP7lco21Ix12PEHPHJY7PGSWllgb+JulB2trHyXvRTemaUYcMGJU0rc7ux1arR8BsrKum
	+NdK0MTAgT3wjXlK3NxC06EWaPsRQIF3qs/hL0p9lRnLA+qqRu8zcOeZpWT1MY+AAISJ3IH0LY5gP
	zlAAK1nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJmOl-00000003J5f-0XKA;
	Sat, 07 Dec 2024 04:26:31 +0000
Received: from mail-centralindiaazolkn190110001.outbound.protection.outlook.com ([2a01:111:f403:d409::1] helo=PNZPR01CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJmOj-00000003J55-04PV
	for linux-nvme@lists.infradead.org;
	Sat, 07 Dec 2024 04:26:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAZIRGIRvu1U3zhKbg/Dg2A/Z6dXwORePHvP97w8JTrhFWuJP2KNNPZ3BiTcarrC+ib19ZOUaFhdtGRiaKnUL5X/1EdYPCWnaAdvs/PgK0qEWtu14W5IG+EsqWNjzjvhPvplsX4NfKIid+d9zJ9g+TvpWkmcxi5GB0qtfzDhHYCjLRRfTwaWJnnQDgZhmxk1F5j3ulWo69BfA8TLWTnx1YdtCx0Ya8Wbvd/IkYSa9rZ3TsyPumsCgCdrTvVRp6cOQ4JzwUZ/XxjI9ILZwMK9pqcau2JpAQWGGFT87eVKD8hgQXbIfzobnXwAKq5eQBBUOMgWA2Bb0r/FrdS9NCcWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxwgmCeQC2JIRzsYwdefo+PK6/qTErQw/zeQVl0IVK4=;
 b=g8ex36PJcEc/kFlu5UZb/fwIet7Vsk6pZZAYcK6mvmxBY9XnFnOl22uNeMouC/A9LpNAx+qjhuLLjLNhc4jryyvmcsecGueHqGyVTvu9ImemoQxOV4VMkCJ8wsXGPahyvQJBHUtLtKnDeKL2bGJiN56QJmFy8xpFOxPF7p2L0A00ZVLCo2Dp/ylpuTN03DydmFJmUTUvIxHzj3wMw6oS+CGKL/bicFuvnRFJJ91fbWc7KV9bX4h62hwfAv7yub4+LZr7LLADTmjkvZUT8ewnGXknFn0X9IRUS1rkAGywCc9B2gBFvrkg14H3sL1emIjTEajQButUkMeZE3rvghUmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxwgmCeQC2JIRzsYwdefo+PK6/qTErQw/zeQVl0IVK4=;
 b=I0U9dHxZz6n3rK1eGj+qkaSbliyNRRq66bLRN0nm3g0qVZ3vA+dHLFoswkRVfzkNu2G2VwDpT/B7z+ouclZTGemnXP1hegOnhwXBn3z8xhJ8fbYdNpgpPeNJY2Te/2a9GLMUp2Wlh45zfXRBu037Hmt7ogzV0zOFn9kcfnJtUPxxnguDsoYdvSBGEdkkDngEr1G2U2NyhXvH2P7p5/vgKBwCB+5Io3apUDGBAGw//v0EGuWC7koyE/igV0tq9zI4qxRTcnyysexLwpU1mgYNXiKevuz0enZEFSHWdoZlsrHVoCTQJVtmCb31m+CL2DA6kMjij1BVbd+4wfC5L5vpCA==
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::20)
 by PN0PR01MB6405.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 04:26:18 +0000
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4]) by PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4%4]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 04:26:18 +0000
Message-ID: <PNZPR01MB4528980B1F286C5843B70DBFFE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 7 Dec 2024 12:26:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING when nvme_probe
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, fengchun.li@sophgo.com,
 Inochi Amaoto <inochiama@outlook.com>
References: <PNZPR01MB4528CE2B4B42BD765EC8DDE1FE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <PNZPR01MB4528CE2B4B42BD765EC8DDE1FE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::20)
X-Microsoft-Original-Message-ID: <a88a6ff1-0886-40d1-b419-d59ca38acde6@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNZPR01MB4528:EE_|PN0PR01MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9110a0-38f8-4be1-183d-08dd16774b76
X-Microsoft-Antispam: BCL:0;ARA:14566002|7092599003|15080799006|6090799003|19110799003|461199028|5072599009|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVGNWdkamgwaWNrYW0wNFoyQ2JlTGJUQWk3L0N5aXhIOHFGckloQW5UTThy?=
 =?utf-8?B?am1lWjEzbTQvd3lGZTFOUk1kNVpZOGdoeS9DZ3NPdjdkUmZjRitWeDU4aUhB?=
 =?utf-8?B?R0VBajJiMHVMOG96NHp4M1B1bThYSFFqUmcxN2M3QWRkK0h0eWJjZTNnTk1n?=
 =?utf-8?B?a0U5OUhjWmQ4YlFQc1Q2Rms0VlFmN3lYRUhQdk5QSlI1ZVBsREJ0TlJ6K3JI?=
 =?utf-8?B?TUhzbzRoVCs4UktPNUQ3RWEvbkFXUTZ5SC9IVyt6SFVsTzdUVDlLeE5FVVNo?=
 =?utf-8?B?QTBiVDNQL3NUNmdZRGdaL25PSDNIMUJiblZDUDBCYVJzNDJrTHh6UlZ6dy9P?=
 =?utf-8?B?NUo2UHpieXk2L3AyeGVMVWlRQmNadTBPNzNEZnVNenVsMDR4cUFWUVZqVmZO?=
 =?utf-8?B?dk93dEROQnBMdEJBU0RUdkpHcDJJNlJqdnd1R0Y5RUl3SnFjcFZkVTVKcmxB?=
 =?utf-8?B?eCtzeVBEN0hmeXNXOXZ4UzZCMG1BUi9GeUVOTFk5ZlRRbi91OUlmRSsyczAw?=
 =?utf-8?B?VjBGdzlNdUo0K0FmOVZKUm1Zb3NZMVVkNXRCV3lFcVhjWFRIWlFrdEdsRWw0?=
 =?utf-8?B?VU9MandOZ1FzR01oSXYrdDlVbjdlaDV3cEJzUXpPUC95OUl0UzE3SU1VaENa?=
 =?utf-8?B?eG9hbTBsRlMxS0IwZGJqUk9vUmJpWS80cnZSOG5JOUUxYXVoNGN0MWc1UzRm?=
 =?utf-8?B?UnNtUEhIeU9lc0ROTHJCYzlZMHlDYXlJNWRsV3VlZ3ppZU5ZUnJYMlhMaHNQ?=
 =?utf-8?B?dm9VTllSWmFsRmQyWml0SXNCTktWMVRoUyt0aFprM1RraEd2bmFERVZURDBU?=
 =?utf-8?B?QU5TZ29Ca0s0Y1RxMFY3YldNSFFROHFocVdLamVwU2paaWFJc05oVHRSZEFN?=
 =?utf-8?B?UTNjc1YyNTA4a2hJWlNzMUwzbjM2Q1BJc0poWjF4RkMwQys5U0U1NlFqVThV?=
 =?utf-8?B?S3VzSnNUUUdxMEpqYW83WG1QcHo0OXVsWnNUWGJXRzM1N3BYSDNKZnM3T3h3?=
 =?utf-8?B?dFdsbFBGd1dmQTBvTnFZUkJPTmNXODRMZ3lpMlh0cWd5UXpTa212SXdpd2VG?=
 =?utf-8?B?cUZRMEtqNCtVU0xtZUxycndGNkk0K1lJMmoyTnhvamFBL1hIUjNscUhldVJI?=
 =?utf-8?B?VDM1Q001am83SjI5M1AvSDE5WC9INmRQN3VVU2x2L2F6T2tTektSODV4TkFM?=
 =?utf-8?B?Y1dhdjBDN1ZBYUlPMnBqZ2ZWZUw0U3BqdHo4UzlSdENwOVYxUnF6cFZoRFl0?=
 =?utf-8?B?NzBySmQ2YTE3M21NbGV0SE14alE4bkQzNll3cHNaZGRWczhlcU13RlV4d2Y3?=
 =?utf-8?B?ZXg3RWsySDgxai90WmxVY1JyaEFtN3RUTHVQODgvZXZUdk9aeUNpbnp5ckhz?=
 =?utf-8?B?R3JmU243Y0E2V2pwVklVY01EcUVvbmFhdDVFVElZUGlmdldwTnFub2c0bjZE?=
 =?utf-8?Q?LjF5RZzZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2doZ1BEdHRpQUVqbFNsUUphcnY0aFM0VEZrM1lFQTU3Ump6ZFNJT0pXdHEr?=
 =?utf-8?B?UnYwekdkTnZrWnYvS2k3blJDTDVzQXZya2dTYUJFMThJWjZ1SVllQWhuTkQ3?=
 =?utf-8?B?SU1mMTJaRHhjcUZBdTEwWmVpUjFUdHBHUUZmV1NaT3dkMlB1VURyREYxOUxZ?=
 =?utf-8?B?Mzd4MjNXbVVVcGYraVZmaDhRQTBEWm9KR05PeDNvaXZqcTdWVGl0bUljb0lB?=
 =?utf-8?B?MHJTMzZyU0QyWFlNR1YwQ1FVdXpNY093QndsbHhmZTBOUE1ScnpsaWpWU1Fm?=
 =?utf-8?B?amZmbWJPb2hrejVPZ2IrRWJNd3E0azVSRjVac3NXREJDYkdrZHFoYkI4Vkcr?=
 =?utf-8?B?TVFnNVpHRXNLckN4d095M0orYlJNNTBQeFJxL1ZXMVRQaThWRHhaa3ZjQTFv?=
 =?utf-8?B?djVwaTlvUXpOUG9qaXhpRjB4UnYxNGp5Y21SS3lJVTVZZFJOdXFLZTUwRWRV?=
 =?utf-8?B?N2pRUWUyTXdnR21nTHk5S2ZnczZZV2V2TUZMeDVkSWMvWVNvNm5TKzRyN1RM?=
 =?utf-8?B?VEt1eGEzQWZyV2FRaWJscmcxZkcxQWtMTHZrT0YrcHQ3RS9OYTZrb2lnTE9J?=
 =?utf-8?B?NHNObTJVdXBxRld6dk5SK2ozSkJtb0dqaVJMRE0vZHhPc2RIVWgvY2o4VkZ4?=
 =?utf-8?B?OTVRUjZvN3B2UHQ0Qlo2bEJETHJISXZWY3M2cDEwVlJORkRweWNFZUhFQ0E0?=
 =?utf-8?B?bDBOdUVveFBPalJPczE4RjVRcTVLSWdDeC9tR2trZU04WDhWVTZIMG5qV1JI?=
 =?utf-8?B?WnVHMm5CeGFpR2JCUyt3T0tCOXNCdHEvRlJrMVRLVVBhY2Y2aHIxVGdYNHdn?=
 =?utf-8?B?UklKcXh3U0NBTzlnTk03LzdzWWQvWnhPdWFLQWZ6VXhmb25FTnpRbjFWaTFH?=
 =?utf-8?B?QzVrQmxOQlk2bFpCemVLOU1MNzZ0REZ4QTJMYmc2aENOTGdGWjI0NEJjV0pp?=
 =?utf-8?B?UXdDT0pGWGoxemxZU1pTY0ZXem5ZYTlCV1poZm5Kdzhzck9hazlzWjlTK2Y2?=
 =?utf-8?B?VW1TbzJ6dzBUdGtaTlNIRjN6TWFFYlo3RkU3cU5XeGxVTEVqMjFBTFk2djFN?=
 =?utf-8?B?T2t1K0g1MzBpNndYWDdHRHFnL3hUcllNSkhRUnU0NmxLKzA1Q3V4RVNaNm9Q?=
 =?utf-8?B?ZzJuRi91TEVVY21JOVllUnh4T2IzT1dYL1BweVRjKzhaOTdwNnM0SWJ6M01S?=
 =?utf-8?B?STV5bEpPTnVBMVFjYjBFSGxLS2NoMit5dDJvYkhLWmNGazhpNU9Bcm0vRDNU?=
 =?utf-8?B?NWdmV2JjNW40Mk92SkxYQTFoSUZuRElSR00vRXRVS2x1YzJyY1dRR3B0Z1RR?=
 =?utf-8?B?WWo3V0V3aDlBcHhvMnNRTnZzaVhpT3k1VW9NMlA1UU55YU5GMG5EaGkvWTBx?=
 =?utf-8?B?YU1tUUlrNU5FTm50U2xWNjZLaXhnalZEZy9lY0ZsNkRNQ3MwZm5WTEI4SWhP?=
 =?utf-8?B?ekRveU0wbmd1UlRDMXJuN0tIOUlMUWFFa1RWT0doTFNZOEVReEVSTzZYWFFw?=
 =?utf-8?B?K0ovcTQyRlpnRmdvM1N6TForRVR6R3A4WHJRWEpPdGpsWmVTRGVpNUNTNjR3?=
 =?utf-8?B?MHJ4cng0dytIbGZmVzlGUHRnQlk1U3B6UWFxT1I4bzhPMncxcXRVNDBEN3Nk?=
 =?utf-8?B?TVpDd05RRzhyRTl2b3pyckpOeG9VMzhIRzRaMEFkVmpKa1BnYitOcjVUZ2hq?=
 =?utf-8?Q?Ifni9xqBxQw9QxxxG291?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9110a0-38f8-4be1-183d-08dd16774b76
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 04:26:18.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6405
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_202629_098413_04493380 
X-CRM114-Status: GOOD (  10.35  )
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

Adding CC to Inochi, who might be intereseted in too.

On 2024/12/7 12:22, Chen Wang wrote:
> Hello,
>
> When I test with latest 6.13-rc1, I see kernel complains as below, but 
> I don't see this in 6.12 serials (6.12-rc1 & 6.12-rc7).
>
> I'm developing PCIe driver and there is a RC switch which has some 
> devices conneted to, including a  nvme device.
>
> Can somebody help double-check and comment?
>
> Sent to NVME related mails and CCed to MM, who might be interested in 
> this question.
>
> Thanks,
>
> Chen
>
>
> [    2.075408] ------------[ cut here ]------------
> [    2.075414] WARNING: CPU: 51 PID: 403 at mm/page_alloc.c:4727 
> __alloc_pages_noprof+0x788/0xd08
> [    2.075432] Modules linked in:
> [    2.075442] CPU: 51 UID: 0 PID: 403 Comm: kworker/u257:0 Not 
> tainted 6.13.0-rc1+ #1
> [    2.075449] Hardware name: Milk-V Pioneer (DT)
> [    2.075454] Workqueue: async async_run_entry_fn
> [    2.075467] epc : __alloc_pages_noprof+0x788/0xd08
> [    2.075473]  ra : __dma_direct_alloc_pages.isra.0+0x1f8/0x434
> [    2.075480] epc : ffffffff8029e252 ra : ffffffff800d1f96 sp : 
> ffffffd7017bb840
> [    2.075485]  gp : ffffffff82072a28 tp : ffffffd701761c00 t0 : 
> ffffffd703b023b8
> [    2.075488]  t1 : 0000000000000000 t2 : 6d7768206e6f6d77 s0 : 
> ffffffd7017bb9e0
> [    2.075491]  s1 : 0000000000000cc0 a0 : 0000000000000cc0 a1 : 
> 000000000000000e
> [    2.075495]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 
> 0000000000000001
> [    2.075498]  a5 : ffffffff82013d7a a6 : 3fffffffffffffff a7 : 
> 000000000000003e
> [    2.075501]  s2 : ffffffffffffffff s3 : 0000000000000000 s4 : 
> 0000000004000000
> [    2.075504]  s5 : 0000000000003fff s6 : ffffffffffffffff s7 : 
> 000000000000000e
> [    2.075508]  s8 : ffffffff8213d190 s9 : 000000000000000e s10: 
> 0000000000000100
> [    2.075510]  s11: ffffffd70034d3c0 t3 : ffffffd700260f00 t4 : 
> ffffffd700260f00
> [    2.075514]  t5 : ffffffd700260000 t6 : ffffffd7017bb6d8
> [    2.075516] status: 0000000200000120 badaddr: 0000000000000000 
> cause: 0000000000000003
> [    2.075521] [<ffffffff8029e252>] __alloc_pages_noprof+0x788/0xd08
> [    2.075527] [<ffffffff800d1f96>] 
> __dma_direct_alloc_pages.isra.0+0x1f8/0x434
> [    2.075533] [<ffffffff800d27ac>] dma_direct_alloc_pages+0x28/0x11c
> [    2.075537] [<ffffffff800cdc54>] __dma_alloc_pages+0x3a/0x54
> [    2.075547] [<ffffffff800d199c>] dma_alloc_noncontiguous+0x8e/0x1c6
> [    2.075551] [<ffffffff80a3f352>] nvme_setup_host_mem+0x2a8/0x446
> [    2.075558] [<ffffffff80a42dbc>] nvme_probe+0x730/0x802
> [    2.075564] [<ffffffff806fb4dc>] local_pci_probe+0x40/0x82
> [    2.075572] [<ffffffff806fc1a6>] pci_device_probe+0xca/0x1f0
> [    2.075578] [<ffffffff809a2964>] really_probe+0x9e/0x33e
> [    2.075589] [<ffffffff809a2c80>] __driver_probe_device+0x7c/0x132
> [    2.075595] [<ffffffff809a2e0c>] driver_probe_device+0x38/0xc6
> [    2.075601] [<ffffffff809a3182>] 
> __driver_attach_async_helper+0x4a/0xc4
> [    2.075607] [<ffffffff8006616a>] async_run_entry_fn+0x34/0x126
> [    2.075613] [<ffffffff80055a16>] process_one_work+0x172/0x316
> [    2.075621] [<ffffffff80056626>] worker_thread+0x2e2/0x448
> [    2.075626] [<ffffffff8005ee4a>] kthread+0xc2/0xe2
> [    2.075633] [<ffffffff80e8de56>] ret_from_fork+0xe/0x1c
> [    2.075645] ---[ end trace 0000000000000000 ]---
> [    2.094302] nvme nvme0: allocated 64 MiB host memory buffer (16 
> segments).
> [    2.223519] nvme nvme0: 1/0/0 default/read/poll queues
>
>

