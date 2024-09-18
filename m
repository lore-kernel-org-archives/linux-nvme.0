Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E67CDD552
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyYqS5PphBo+shsKyOfqsNJLzDRLfQQ90aDZyVPCy/I=; b=4SvisczUIciOk8lhk84PVaHCBK
	Rp1BtLsbLRpSm7of/TLkbuqudV537DjgsYO9Mw10S6ZggtRNXXWMQSfHMQ8nohYni7cMDVyRbbPkh
	sx0y6sFLXG4R+OsRSb26r2kcJU52++DFaUX74hfFdkqLBgGQpGQ4e3oBB3JzH+GeaNsjYh4a6lU+L
	HM9KrcdqV17dwSqpPhiiaA5qvHr1LDdgHVCukOEs7iTtcFR6u9zv4eLivuxnpD50HMF0EkRi7uEJC
	dIyRF6FKEz+xC/+HmsipVW5h1WQQYXEKS8rKzZ4H8WqJ57uzVT2nSQkzvRr1+QW7N6yXa/5X1dbcX
	6RhUIPYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sr0er-00000008uRF-0Qi6;
	Wed, 18 Sep 2024 19:48:13 +0000
Received: from mail-am0eur02olkn20831.outbound.protection.outlook.com ([2a01:111:f403:2e06::831] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sr0eo-00000008uQW-03ja
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 19:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3yMRpqLhYy0D8IKtSMZrS1hv1/aLFSSlq2ltJoI20+ZABezjsXuPBr64WeICeYyOq9xfriZQJpQN2Hg3CQQ7wApN+hCtBz03BtNNPlmvuDBZSAAXKUT20NKcilfN9QYOK6kXP9r+Z0MeM5RnVCQQCnPkGwfD8Q3LAIGacn0xr9Ctr6WfdRaONrEnjMCA6htVNFjT7btu8CfOpxuoepttcIQ6o5KcqMONlFfTu8RqB/SKTDqIZWYg8wNpfwMYoprQ6cyvlw2Rq5KI+ugsV5gdM+8uQNpofWaRqLt089lNxBRKcMKeDoWeefT+/xbUbyHdO7E8J+KS4QcJdGP/3wuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyYqS5PphBo+shsKyOfqsNJLzDRLfQQ90aDZyVPCy/I=;
 b=Yz5hNudL9whtz1pc/Hgb1pGTNF+UdiNHjyyo3OpdrbPA2xH1kvnFt8L7x+vCC39Dp6hcgw2P+Fwhd438A34vACgdSKn+IMTGH9LHLu0vr3lx2DFQWHyGbIpBirlVqfvhxMBcPyxmG2Opnj3tJ3r9SEU8/Lk7/nflV7k9CiYLoxjQYV3F7uQj0Wb6RGOvDcL6y6KIWUClMM347Fw45uAjxpydmooS2wnwxaxWzOCW6v0q7sAAGIIR7wMceWNmpK0nXuqkIlTx3XnL52BzbV7zGs9jLQxABW2ZtJHZcR7wRg4eoVsYZV1QpeqGKiLUizfIh8aCpl1CAXYIHljG+axI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyYqS5PphBo+shsKyOfqsNJLzDRLfQQ90aDZyVPCy/I=;
 b=s81Cx4aAvoFoBQQdKSo8FJ6TlF1qyLNuVtVfQKIkI792guo3MYnDyz0AGNUjkhRdxpUJhxlqRoU19zXVe0U45W0XUsPu6Sya1CldKWhpHB97z1UAGDtHbMqQ57gz22KNw7T/6G6bMKaUz54osBOm4qDJ/ToVuAm3DauwwsQDZ3lvt1DSYZkhdnW6IVkq4yC3u+3bgOPJOb0r7YPmYmC66iWjGnM1Ew+oV2Fqks212Y9fSwsXAaWid4+cUqc8wgU/WNV5LjdcfARocxpd8TH3fei/xjqjTuQ+2KC8VUzjMpD0G/eUgkxN5XSfgXTb8BdgEMtf/akSzomqwnXkj7jmNg==
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) by
 AS4P195MB1693.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:511::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.23; Wed, 18 Sep 2024 19:48:03 +0000
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f]) by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f%2]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 19:48:03 +0000
Message-ID: <GV1P195MB2055B60E95C5ED0FB1B3910AEE622@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Date: Wed, 18 Sep 2024 21:47:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [nvme(t)-rdma Question] Understanding nvmet_port's max_queue_size
From: Jigao Luo <jigao.luo@outlook.com>
To: linux-nvme@lists.infradead.org
References: <a7449c58-9889-42d6-94e4-6ba4ee35e495@outlook.com>
Content-Language: en-US
In-Reply-To: <a7449c58-9889-42d6-94e4-6ba4ee35e495@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:a1::5)
X-Microsoft-Original-Message-ID: <fffd1ff8-ef60-48fd-b128-e0740114cd26@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P195MB2055:EE_|AS4P195MB1693:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f2cf4a-abd8-476d-3d2d-08dcd81ace8d
X-Microsoft-Antispam: BCL:0;ARA:14566002|8060799006|461199028|5072599009|6090799003|15080799006|7092599003|19110799003|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info: 1OrSAiXYXwIfK1eclopeM6jAivrRLrpfgQApQEIBZZz4t+t82GNk0AobWV8Z719OdytfowjzH0iNfH9QiR7xKQcl0tNMsshUeLRA3025mRKZjxYq7+fdbCKzRK6EazCWP2rVx1OqOWCQuIBjXh8EDBgCKotXh8QvUOv2Ct6J43689gS6XPfKQ0wx3SH8DRKrNjvHaPS3BeeiKK5uoDN1jeI3QzWpsbYmJwyxmgpG9wwPulS1mp40SOeSSdjyl/WvI8orRdq0lZnQ6rsMeTf9HFY/tOPlejSQFYpSHuoNPQ/R36xJuNwOBCJvVgWzMjAp2SRr7rLdKtEbj8OrRu/wR/A+Yph4G1eIoMAVbodih11h7+mYURLOxFLFrQikMUAOZKHCcrNmOGvW59+ep0UNrEV1/jtcVju5tmT5fSILCo3zbU73zH5+epOj32DMCTTFxkEvibUgyXzrIJJr9/5G+QD2B1xy8+w39VO1yviyswpT+FnaeOO92nNPFVbTecZVKmDecKZ4m9CI4uwUxqA9GlaR+WGtvTLris29OAjSlZkKpIRp1FNR4eAcJ/I0WuBne4azR0SfBMJrIWh0uxg1GizQSMZcQQ3APx/VeoWU7JiympxLz3thKXNrIssZi2PxUEMLJRT9i+qvgiO3TGNebHSOzjSeIzBeuwrNNqND+F7UQPtOiTInLV3ZzT+rAzfu7qQIAAdMF+DyOjS9YpjGn3UwAqZI1Hv3Gys7tN2vI+JO9NazlGYSCsTewyg5u+AkVgkP+EeSYi+FNzNtYbT+r3Xgohp2yqzhP3KdGDtd6C10Udl4y505Nw59uN9XQmEJcLlzgGD3lf4UwSgi5E6KSwhCAiqTI9vOdi8O3T6seSfmCl3bR10k+L2XOxb0Hwik7bTRezJKbYSOkYh9dIKgGnmnkuJWUh9BBcImMWPonfw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US82MjdadlNkSEVHU1ZKMWJ4NEZ4Wlcra0tKa2lMbkVXZDRXU3FBU3g4ZDUz?=
 =?utf-8?B?cy9CMjE5YVFaV01KeTdIS01wcnZmYWdHTWluUit6a1NYaFU3WDZxakhMYXNK?=
 =?utf-8?B?Qlg4SGxMN09xa3hOMnM1b0dWQ3BXcndhcmpxdjdGVUVFbWw3MHFHRU9SQzdo?=
 =?utf-8?B?di9Gc1RveisxL0pnOGRueWZQczJqWkdGNVFNTmVjUUNNSHJNc3lPSXhscWV2?=
 =?utf-8?B?d0YzelhYQmNtK0F0dXRTdW9zWkhsdlNsYU1TaHd5bFV3YlgrZHVRVEhvZk9W?=
 =?utf-8?B?VXpSblF6Q3FSU1lQc2lkWXg4RVVwcjEwSUsrWE9FR0JxSmNFU0VCZ0VlQ2V4?=
 =?utf-8?B?aktwZ2NpUDN3cCtkdjhxaDl5NXdvVXR6anlLejBRWjhBejIzNmdPN1VXRHVl?=
 =?utf-8?B?SkdGT01pTHlXUFFzcjJRUlFSVi9GemZ3d2l3blNGY040aEsrM1A3T3VXTWc4?=
 =?utf-8?B?WjFDQUoxbHd2NXkvUDM5cUVZV0VJeGpXS09ENTg1SUVpRFFsa0NxV0tsY0Fr?=
 =?utf-8?B?NlRXV2lSS2F4ZDdnQy9EWWZRTVF1R2hvV25LNHA1a2t2am1YUk1icXRRbm5z?=
 =?utf-8?B?ci9OWDQxTVkyWkdXU09FZ3BOc0VjKzczVysyNzhPYjgrZCt3cXhjbjhEQnEy?=
 =?utf-8?B?enptY1hPWWp1QUp2RGNKZGk1M3F6YmtZQ0FNbGRQRU0zVmdBODNKeDN4d05S?=
 =?utf-8?B?ekZtQm5RMkJuQ0VPUG9pVHZsZEtrcTcvZHMwUk1COWxJZU5LMnMrMTZzWFhr?=
 =?utf-8?B?MEFYbnRDS0dmaC90Nm5HYUptQjZZc2pZczNkZVdoWnZxbVVZcUgyellsUFhG?=
 =?utf-8?B?L0xHTEQrUVRicW1FS0hJdVdmK0VGOFk4Z0JOVHh5LzlTQmdJU3ZlRTh1akFX?=
 =?utf-8?B?OFFHL1BTRE1PZjJmbUQ0aEk0U21xVHdwZjQ5UXl5SmlTL2xLdlFTbWZlVDhD?=
 =?utf-8?B?NXRoUDBWVjlUVFgyUVNXT1VMbVVoNkFtbGc1SlI1S25uNVVkQ3B4eFhSRXl2?=
 =?utf-8?B?Ym1lbFRPamp3ek9zNWVub1g3RUVPeXVJOVpaZC9kSDU3azk0WHJ1OGlyOHhw?=
 =?utf-8?B?TjVWSDBNblZ4aUYxdmNqS1k3TzYrKzFTUFdlUVl4NXliNU5sTnp4YjhtZXNw?=
 =?utf-8?B?V2Q3dTJzTG1FOG8xOFdxMDEvSkxwMGd6QVFPMkM3ZnVQL1lKVldlRTZVSUJo?=
 =?utf-8?B?TGsrenBiMDJ2Qm5Qb2JYTE9lUFQ1ZDJ1T2c0U2cyWGVnRjNtUGw4SU4zemh3?=
 =?utf-8?B?WStnUnViSmdnTGpsTW8wV2h4VFhhbXNNaGkraVlzT2RkZnVoZTBjYXhPb2Vk?=
 =?utf-8?B?VXJCeWpXSHJ4UHNINTZJU0ZHem5mVGJhSWxlVFRVOUFSOGNXc2dENTROL0Ri?=
 =?utf-8?B?bFJxUG9qRGlaRXBIYXlYL2dnZFpSc3o3SFFqSHdRb2J2b1RYNnoyUW1pQWFw?=
 =?utf-8?B?T1A4Zjg2ZnJ2c0hNVU5zeXplWTV4U1dyLzM5Sjgrd1ZiYlRMZUVIcFRBTldR?=
 =?utf-8?B?WFQwanJQRmM2Vk9IL1dNMFliQ2lraHpuczdzNUtJR0VYR3FXTDcxVitZQXBk?=
 =?utf-8?B?dFh0UUFJZ245ZzBGWFRLaitSVEVjOVpNV3BrQ0J5dHZ4ZjdsbER0RVhpd2M4?=
 =?utf-8?Q?BNXBn83Ehh4B8nJK2A03mwWzWAbs0vyUoVAjo1/BjgXg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f2cf4a-abd8-476d-3d2d-08dcd81ace8d
X-MS-Exchange-CrossTenant-AuthSource: GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 19:48:02.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_124810_080711_73D3BEC1 
X-CRM114-Status: GOOD (  18.39  )
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

Dear all,

I am writing to kindly follow up on a question I sent, which I realize 
may have been overlooked given the busy nature of the mailing list. I 
would greatly appreciate any insights or suggestions regarding if nvme 
over rdma has a limited queue size set at the target side.

Thank you in advance for your time and expertise. I look forward to any 
ideas.

Best regards,
Jigao

On 9/16/24 4:35 PM, Jigao Luo wrote:
> Hi nvme-rdma experts,
>
> I’m trying to understand the queue size (max_queue_size) for NVMe-oF 
> over RDMA. I came across the max_queue_size field in the struct 
> nvmet_port, which appears to be capped at the max value: 
> NVME_RDMA_MAX_QUEUE_SIZE.
>
> First Question:
> I would like to confirm my understanding of this setting: The 
> max_queue_size is configured on the NVMe-oF target when setting up 
> ports for NVMe subsystems. Once set, if an NVMe-oF host connects and 
> runs FIO on the nvmeof device, my assumption is that an iodepth 
> specified in FIO that is larger than the target’s max_queue_size will 
> not be fully utilized. Is this assumption correct? Alternatively, 
> could having an FIO iodepth larger than the target’s max_queue_size 
> negatively impact performance due to this mismatch in queue depths?
>
> Second Question:
> I noticed that this patch set enables max_queue_size in the 
> configuration entry and increases the max value from 128 to 256: 
> https://lists.infradead.org/pipermail/linux-nvme/2024-January/044145.html
> My current kernel and driver versions are earlier than this patch 
> (mine is Linux 6.6.1). Is there any way for old kernel to view the 
> current max_queue_size value? I’ve checked via dmesg and 
> /sys/kernel/config/nvmet/ports/, but I don’t see any reference to 
> max_queue_size.
>
>
> Thank you for your assistance and insights!
>
> Best regards,
> Jigao
>
>

