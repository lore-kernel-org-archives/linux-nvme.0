Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30846C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WlTXyipMJ+WR1f5BClOgceg+gmbw93PpTuFljmD8Dmc=; b=o9HVIyNA4/oaAP7U6j3v2Clluj
	rmEDZLuQmzmlFeHA4YGg0CkZmi5oEOGIjSwFYPdOK7NIYMigpWO23EbeP2k8d2C778OrkEyiFkZEJ
	+syUGULcXIY4BZ4sip9XPkufVF1hokQCC+aH8Dwj+BtwWe/ALyJjTW0tU9EqgPpBADlDDuSp2gCK2
	DS3FuAcxpPve4eBKZgYAG6a9VJatV98LUWeoFa2b1n5cKqgWjTxA7ofbVn2pbNbEz52hFEApFlgEz
	iUzXqKVVtQ/3Y6lkzb4Lwhzn6IKEz5i4nDVpYVN1NAErpnoeIYUPVIMtIN9CUXEmb+7IACUrClv4A
	XrEUfODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiExA-00000005Qjc-3bG0;
	Fri, 10 Jul 2026 17:23:56 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiEx8-00000005Qj5-01Cs
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 17:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpBvHWCCvtzqwgcrMCBdLLGAmtaLrhOMROXGqMzwh9TAJNTpIBH4VD4fjYvuEEEcRH2Nk2sJ+Vr4OByjKdUVwzl94O/kA0KM0XY0/D/VdJW4mgU8dr02edsiJYBCitOlGMbxgFrdjwP6dtucS7lWsxczPL4Q1OnP/6ldNzYcOhHc2EM9Ungct0v/P31u1DblLNBrngzgE+1oXBM3+yCrioaUXSF5lfa0pX6yNYZnfv0eX+abhxKS678r1TI2HECQc+H0f0TeFc5+3iSu5eYlegzVb7XZ54Fot3LhxSlYLuxsla0IHhwpp2S+GaBRrhZGYUSNT68XmJmR2kZCABYeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlTXyipMJ+WR1f5BClOgceg+gmbw93PpTuFljmD8Dmc=;
 b=kyRYwxxgq+iuKvmL+yT9+b4xPWKjZuZN3JQiOheTMkiPZxSjr8cHGOqA/lcz8Ur1XaFCSoJEY59oyvk7Xkyfik6zXuhFgTJKgTcVo4/B6zRA58E+pIcdcFznF1Z3to3+ukEgZAJyY1fgYt0Yon0nqz9spfKC7iZBFs4oGaX1Z65EKpZNuoYwP6oWJhntAr20kyK1A3mu0cBfkMRedBF+JSDG0WrrC2bhOLxqOYflKnKIh2y6oCq9D+tRMFLiSSvGAaAFblug4+Cmb52b9ni01GZLbYnXvkGOmWwLPYt5ZFKn1N+BarK5UPn1btZaVhkHwwoc9SHUq8H92bdUn4mWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlTXyipMJ+WR1f5BClOgceg+gmbw93PpTuFljmD8Dmc=;
 b=XqP07ykVJda4+B5umuo0gzHz7RncHHSGZUn6NAz0JICZ2iCd/XDG51cwCKYupb1s4s0x/pNjp2nCAupTifmalBLMPciRno2H4elarXA+sYEOBy2heR11i8GPluiZVjlByRbcfCTCpXPhvtkDlENihLUrpNay3InUGcz83vuxya4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 17:23:49 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 17:23:49 +0000
Message-ID: <9ba92d40-1a9a-415d-a6c2-3f589620f18d@amd.com>
Date: Fri, 10 Jul 2026 22:53:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
To: Frank.Li@oss.nxp.com, Manivannan Sadhasivam <mani@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::14) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|LVXPR12MB999195:EE_
X-MS-Office365-Filtering-Correlation-Id: 232ec373-cdd6-468c-3e22-08dedea80154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|921020|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: rcuwYNcHiKF48ozzwhcU3T6AkGKhYk0KmYFzzrCl2Dl17sxtAa0YmgMcQe60yjCGQ3mwlveD9cvot3ASoLUTk0t+0vY+UeILLN+0VK8nLR+JvFhlKFOPWNwxOoMVyAMSmd2kgIl6cXrRS5QzEgl31ibaYceQ3QIENdudas3/jDAlwi1QoAibVCAECWWCTUoxdriMzOnXJCjmT8lplMPRmbsBkvlNJxUKNs7TVUALxRo1NvGGN6BfIHoF/BXOBq89yn6CZJ/XaOh30Jpba2oES+HnGfQqyJea1rK2NOaoLFUl4Q0QbtapVplL4mgo1S7eh2Wf72W+fLrS/S+hqDclWws3hs9jd0uk9jtKjGVlkgCWOG3C3mkjO5kpyGq8nFLLKrhc6vlRM3r4RDlS2oXtd+IjbIY3u2rtj7zL9RkdGkkexGfu5d8urY5CL1UYfVwlLoSYTEBlQMX7Q5C1ZulEsds7rlGTEt2D+9616OJewE61Awi6f0UQMsBZTsGk4spf0Hj6ZFhAeLCO2pOjSddKzkjvYxPKrXFgPbAhLOz98pS+bc/7D7gTdJgSIxp6yra56IGL1ZqN/zgpWHc99GmY3xckacjW/xnn/d9rXas3N7CbAhODot1OQR5Ao+O/T72Ujfd7upl0T/yrrDPazaTsJh8Wp/Xba7XFIqSAPBZ5h5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(921020)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNBeitJYjNscmMrb3V3bW4xZ09vdHhENVdaZitRV0FLTi9NRnl0d3Z5Wk91?=
 =?utf-8?B?cnpiYnMrVzJxNXdza3FtdjRvaHNJaHlkNVFoNG1Lc2RyRm5idEt4MThuem11?=
 =?utf-8?B?azJaVFhFYlY3NTVlY04xM2tYYkVFS2pWOTNGemdxOW96OFhDc2NWMllWbXNJ?=
 =?utf-8?B?Qnd1aEVSYmZuT2VYNUYxZE5VbTcxeXdyb1Y5QTRqREVqMzdNVzNmS3Mya0hZ?=
 =?utf-8?B?S0JFOEFycHpuUVJ2U1ora1hkUWhzNzZ1NE1YSDl4bkxvSWFNbDlhYXpmRGxE?=
 =?utf-8?B?b3RPVlR6blVaS1hGaXczUEdWb01lTThhYVp1UnMrTHZDVHo1NmY3U0VxbVZs?=
 =?utf-8?B?dXphQWR0ckh6akdXUm9yTEJydXJMYWpqV2VaOE12RndoWFdoaklvbURKdjRo?=
 =?utf-8?B?ZXhoWGRlSVlWNmtxWmdqYVVaemYwMDdDY0M1RTM5dE91N1ROaUVjc2lONGR1?=
 =?utf-8?B?RU9sS3VZRXUrdFk0L2pkWHhTMWZsTzhHbVBScjByYW8zYUMza2krRXpYYzRQ?=
 =?utf-8?B?bWxXWE0vS2RiUTNoUXlPeHpTOFBERkk1d2RLeC9FdkNsd0JjaVlTSTM2ZVdC?=
 =?utf-8?B?Tkd3aTJJVDRuQUZDRzZoQWFaOEFhekV6am9DTXhJazJjcmNJSDJGYXdqOGp6?=
 =?utf-8?B?UENkT2NFNDhkaUU0eWxWSG1EVDQ1K1dyUDBtMVpLNUpiRCttMkFTS1B0WGxD?=
 =?utf-8?B?ek4zM3JiUVZ3OEg0UXRlZWxWaTB0V0xBSXNvbHFOOXk2b0QrWm91MXJZYUly?=
 =?utf-8?B?YzJjY1gwZVQ5Qm9MQXZDSUp2eDBGZEU2Z21LT0lZcWJFSC9ZQnRpeXNzd2hD?=
 =?utf-8?B?a2dtWVRkbHNVcGd1UHhoR2plYkwyc2VjM3Rpc2VVSnRGbTgxYnVqdkJmMDRW?=
 =?utf-8?B?UG8rMHU4UGRrUFF1ZHVxdnlidUE3SGRmekZNREt0U3VOZkNzdTVZbFB1UGZV?=
 =?utf-8?B?NmExYVVBUTdid2w5VXJiYWhGNGp1OGh0RUtodUp6YUREZ0psWUo0b1Ruclg4?=
 =?utf-8?B?aXUxaVliTXFwYzRYblM1TmJWSE1hNGNmOFRxLytyRG1WUjhXTDJrdnhMVFhE?=
 =?utf-8?B?eXdKNkNuQkdqNmM1SGVSOWk3OVNlRkJrdVJwZ1VqYVpEUHVwakJzSTJhdEZu?=
 =?utf-8?B?RGVFL1Q5cVM5ekhobmZONkwrclpCcDZ3bVQ3OTBkK3UvV0h4L1hEazNoY3dw?=
 =?utf-8?B?b29POUV6dUpkd2ExNTFxMW5ib1VuUFROdkp0dHBqWkNjNkdJZVdSaGdLQ1dN?=
 =?utf-8?B?VU1KZDRiMEpRMlZQNkJvRXVrZWVqRDF2L0wzVklLU1M4UTd6T2k5SnJwQ2F5?=
 =?utf-8?B?Q1RqZ25uZGF2RnFRaE4wYmt4aGVGRFg1VFUrVnJmRkxFZmNIOGxpMjM4NlNR?=
 =?utf-8?B?MWRsSDAzRjZYek5OdDZtMUsxZ2R2Tk82N2FsN21leEdaVDN6bENLYjZ4bkUv?=
 =?utf-8?B?TWZqWmJCM2grSkNNem9Rdm1HYlljMWxEL2hJTmtDYTVtOTh3dDdjMlAydUVh?=
 =?utf-8?B?K1pMMUZHVDVCRUtOVDljTFQ2UGZGS05xbERmb2syRjZEeDRrcU1zbEdMb2hM?=
 =?utf-8?B?UjVMaERvL2lrWDhUUDBIMElja3F0c3plWlVEQXkxUE8rRlkxU1FWcXNnZ2J3?=
 =?utf-8?B?MG1MQUo2NVA4RHJielV5WVZlazljREFER3llcTI5VDNNOW9RZlhkTXBJTm9I?=
 =?utf-8?B?enhRLzZQYmZjK1F1alhrdjRURVlHaGpOWG9ZTEwyanJqbFdKeVFmQkZITWRD?=
 =?utf-8?B?ZVVmUW8rUkJTRjJ1ZVBkdXdoSW82MGhjZHlicXZJR0pjZSsyNlNYc2czbWVo?=
 =?utf-8?B?MHI4emhJNG44RW03emxGK2FsbFg4Wm9YMmhQU2ZIOENsNHM5TlZWQ29LMGZy?=
 =?utf-8?B?QkxlUFBIUzZJVVc5SEhHbnpBQ2ExVU5EYm1adVUyY1RaK1NidHM5aUFDcnV3?=
 =?utf-8?B?Y0tUUEQ4SmdUVnRrMGNCazI3RGprb3RmLy9hWmRsZFJvVCtvKy9vQWZodysw?=
 =?utf-8?B?SWdFL3BMWktMbkgydVhWenhQcVhhekhIblo0em43YW1qaExhNWlmckRqRlhM?=
 =?utf-8?B?NFpyaGUyMzZBOXhRK0d6QUN1c2lDcUwrQTFSNTVONHZrbklyK0N0UmpEbUVU?=
 =?utf-8?B?ZnJhTGlMZ2RDak1UejI0VTVtQUFCTFFXVDFaT1VXVFcwMWUvbkZ4RUNpeXVn?=
 =?utf-8?B?LzJ3NzlYcS9MYUtJLzB0a21xUHR0Y2xGK01ucXE1VGdZMGlZbUZDaTFuY3ZJ?=
 =?utf-8?B?bWxacDViYkFVYnJqM1JvSWRtY3pjMnRuakJoVWhINDNTK0gyNDlMWEZ6cDNF?=
 =?utf-8?B?U2N4NHlaQ1oxbFZiaE9HckRkN3JvMXVkVnc3ZUdwZlAxb1FqbkFtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232ec373-cdd6-468c-3e22-08dedea80154
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:23:49.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTDUZVYa7gDsTH5dqS57aK3QL4LRrzpJ+T1S0XQnjKuxDfAGA9/lcjx/wqfXB7nUP8TQutT/YubWxTEqTEsoSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_102354_084177_814A38FE 
X-CRM114-Status: GOOD (  19.56  )
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

On 10-Jul-26 22:17, Frank.Li@oss.nxp.com wrote:
> Basic change
> 
> struct dw_edma_desc *desc
>         └─ chunk list
>              └─ burst list
> 
> To
> 
> struct dw_edma_desc *desc
>              └─ burst[n]
> 
> Flatten desc structions and simplify code.
> 
> I only test eDMA part, not hardware test hdma part.

The patch series v5 was tested for non-LL mode on HDMA.
The testing included varying data sizes for transfer and running C2H 
(Write) & H2C (Read) for a specified duration on all the 8 Read and 8 
Write channels.
non-LL code works fine with this patch series.
For non-LL the changes are similar to v5 in v6.

Tested-By: Devendra Verma <devendra.verma@amd.com>

> 
> The finial goal is dymatic add DMA request when DMA running. So needn't
> wait for irq for fetch next round DMA request.
> 
> This work is neccesary to for dymatic DMA request appending.
> 
> The post this part first to review and test firstly during working dymatic
> DMA part.
> 
> performance is little bit better. Use NVME as EP function
> 
> Before
> 
>    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
>    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>    Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
>    Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
>    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
>    Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
>    Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
>    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
>    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
>    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
>    Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
>    Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
>    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
>    Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
>    Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
>    Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
>    Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
>    Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
>    Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
>    Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
>    Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
>    Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
>    Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
>    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
>    IOPS=261, BW=132MiB/s (138MB/s
> 
> After
>    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>    Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>    Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>    Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>    Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>    Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>    Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>    Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>    Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>    Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>    Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>    Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>    Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>    Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>    Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>    Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>    Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>     IOPS=266, BW=135MiB/s (141MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v6:
> - use size_t for nburst (sashiko)
> - remove unused field (sashikio)
> - leave pause and resume as it because there are other problem for it. It
> is not fully functional, need fix later.
> - Link to v5: https://patch.msgid.link/20260709-edma_ll-v5-0-e199053d4300@nxp.com
> 
> Changes in v5:
> - Fix cover letter typo
> - Fix double subtract found by sashiko AI
> - Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com
> 
> Changes in v4:
> - collect Koichiro Den test by tags
> - use addr in argument when set ll address, found by sashiko
> - fix iterate burst problem when exceed max link list, found by sashiko
> - Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com
> 
> Changes in v3:
> - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> - rebase to vnod's dmaengine topic/config_prep_api
> - Add non-ll-start() callback to handle non-ll mode transfer
> - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> 
> Changes in v2:
> - use 'eDMA' and 'HDMA' at commit message
> - remove debug code.
> - keep 'inline' to avoid build warning
> - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> 
> ---
> Frank Li (10):
>        dmaengine: dw-edma: Move control field update of DMA link to the last step
>        dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
>        dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
>        dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
>        dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
>        dmaengine: dw-edma: Add callbacks to fill link list entries
>        dmaengine: dw-edma: Add non_ll_start() callback
>        dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
>        dmaengine: dw-edma: Use burst array instead of linked list
>        dmaengine: dw-edma: Remove struct dw_edma_chunk
> 
>   drivers/dma/dw-edma/dw-edma-core.c    | 220 ++++++++-----------------------
>   drivers/dma/dw-edma/dw-edma-core.h    |  67 ++++++----
>   drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
>   4 files changed, 304 insertions(+), 392 deletions(-)
> ---
> base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> change-id: 20251211-edma_ll-0904ba089f01
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 


