Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36A606A31F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HOXhqGMr;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i13iFEKC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yCiw+rX+fsiYKg4+Xt0kNsCCKdpXkd881XRjokICVRY=; b=HOXhqGMrXcHCVLnjJrBNQaRziB
	efdinf1FAbQQqixWOUeDKxWy59x8mjjp6Yq4dJO5a3C/9Q+WsvWctZOXyGjTnUc031k/8i+80ecr/
	uVyJFVEt8gaAZijjCM8itdFy7sAxbFU7B8bwSjokWk7kbUU3OSQKhON223K3ELOCpi0a9oTOPEdx3
	y2pTDPcP+TLBvPR8T3g2EkN5CbRajxYD7x9H4OKWfute5Ly0jaI/brxepPIfpR70oPajuiomhPw63
	keZ6zGBI6imsQvoGDcWg8zUAjmUwF5cS6pgXh9BQs2ah1jSxEiXqQVC73GDWe7AO3sMRgZ54NCkjM
	tgWAVrHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSl48-00000000qRP-2Rl6;
	Mon, 16 Nov 2026 00:59:24 +0000
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSl45-00000000qQg-2dB4
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 00:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QljtocrU+MhXn/NzMKvQEFsSbItxXGcvx8rwqJ1QdbVksLoHsdQVyDXUq7SNT5J8we3HMVcf1Do5uycB7Zbq/yYaGqXUm+i/HwTEAnDhR7EN6Utj2pENy1437Rg33VcmxM30wsu/0FDXuA51cED5wx992VmotcUJyQkLyw1rO5ccImqIyhhHSJUHN/Cwaxd8D0HsE1HH2nQPdHJvPtUiJFT6Mjt7FhwlygdDCVS+CDv10AtANmmTyZffm3PUGKcKmrpL6tMjnHOM2c23tAlLFT/0rs09rw1LIgZ4KYViT8x8ogokVI6NtMz1aEx4Q9x5jlh1Qfa3IikmRa1yMPk3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCiw+rX+fsiYKg4+Xt0kNsCCKdpXkd881XRjokICVRY=;
 b=AQa3MRXwv4UK80jXWLGLAJ+73tlfuT8C1YazrY4hlNqkem83HqE9wTSF93JPGt4uJGSkol+GnsJw0FWBKcYrq0w8n1MIL9RawGST3eN83TW+md/Z5J/vz4ypAPW+u26an7Y4oRpx5vhPL71WfvaZz9Uk7H1rtUmcewoIwS+hTlFPD839k499DdcD2lZSOWefK2DSWhqrphCg0hh9zJlrFfL7rfNamGalKa374ds+nBDgPtS9Ju/nITXEw/r41c/93dfcGPsb2fkYmHRrCrX5nVh/yR6CsMgtAC5KwSM23G1MGdG5smScf+qpozIBO1QJbtwxJ1CHHArRGqGA6ri0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCiw+rX+fsiYKg4+Xt0kNsCCKdpXkd881XRjokICVRY=;
 b=i13iFEKCMdVctvAzBEhDp7hzZQl4OnkDLejLZuOi2xv/4v91oeZshWE2q/15ed0d6GzMObjyiZFVWAGgFqKrzZLAVCP2hAostH7Bg8Rbo0xUwc6IthBLcH8Rx6VCdgcXYbQQgnZ3bN3XPcdTkS2x+/CYv4Q7/PH96T1caUhSV3EgAVN/LgWOULKPsHmIY1TGAqJu8j6Sh8HdT/7ENHef7PLD1AoLwvXfnr5fozk7+URyb30BwVTyVUdPu+dUrI1/5iWwxNDaRFovJsqEZpXt/xn61zqh/dG3HVEkXYrGyem+7LPmLA1qrT99NQJemadSR6gh3uf0rDCf/icLavzbOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 00:59:13 +0000
Received: from IA1PR12MB7542.namprd12.prod.outlook.com
 ([fe80::e0c3:786b:5b9a:bf77]) by IA1PR12MB7542.namprd12.prod.outlook.com
 ([fe80::e0c3:786b:5b9a:bf77%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 00:59:13 +0000
Message-ID: <63f323c5-53bf-475f-808a-b6819b187bb0@nvidia.com>
Date: Mon, 16 Nov 2026 02:59:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-rdma: add a module parameter to disable T10-PI
 offload
To: Stephane Thiell <sthiell@hudson-trading.com>,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
References: <20261112210105.992764-1-sthiell@hudson-trading.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20261112210105.992764-1-sthiell@hudson-trading.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To IA1PR12MB7542.namprd12.prod.outlook.com
 (2603:10b6:208:42e::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7542:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dd01f1-d6b8-4131-f129-08df437cd431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|5023799004|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: aoq7EnzU84AJF/P5Zn1Lcc/b609bcB0PrVSxoQFkmLkDeMcs3ZPTUCUB4bG2xM/8yZ6i/eqyqcnxnpd8z2tXNxD0HId33dfkiNCs39zpSPeCZs7DPZXFkQK2h6pUnMgyl5Koi1IxCOhGaEvtAX8VLkV/k6UtA39ti/+bdTSrW+icR2R4dSk5PvLefTOr/A/gfrMewtheQfSqoL1DByYTwRyhdcUC6M6viGDMhRayLz77Zbvz1GRjE/su89QB9rk36i6r7EKT/bRqH3y4DoONqK1/5ukN52lMK+08zf8/kaffEx56lvLMaVwXvJBnHH2/Y6tESrKNiGGMRnVk17bO78+ZwfdGtDZ268h9uEL+rXJV/sTJi7Zb28ibJXf6LXcUdfCsOY3VkQmIZ+UMP7aeWUAQmb1yQf7CgqNM6euQvLRa4bkhdcXqyOCgsDQXddbAAwQeCUabG0w+JfZZ2rH/of7G/R3lYbj8w16xppAsST67TS1AiuP8/MGTbrl455peA7djuFyt/lxqWh067A68CwPmRAWtVV2Z6bYnYlNO8g8Neuse8libAWNJvwriJU2PcPI7kLpvE0h1Ydmt0G0jr6S+KUF/MKoGzlgH4sLeD0bK+l3DmoLRMJhXgN7l4KSG0Ddo5FLxPtPwQwg7ZGvb3pw/F46H1/yK0GFvPmm55FQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7542.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVvb1ZOVTI0ZFdQMTA4YUx5bityWGl2ZkVicEM3VXF6RmQ3WVNUWXJoakEr?=
 =?utf-8?B?cWNZaHNVUnJjZlFKa2xxdjlWcE9BVllUN1FweWp2Q0dNaVovMHdEMmUzRnJm?=
 =?utf-8?B?QzgzOXI4T2hHTUxha1hVc2M3V3F5WGNlS0hSODAvamlaOWh0NGlrNGFLejZV?=
 =?utf-8?B?YU5RcXd6dE1PWmQ4b3FLSjRpVTNHMDg2TzVKTXBudUd2M1lTQUU5Rytyejc1?=
 =?utf-8?B?MXlEZTkrZ3AxSkcydDNVcW9xaXR6ZTNQSzdQOVNxTUJHdmcwb0pHNFR1dHdl?=
 =?utf-8?B?bnBwUVYzalhCV1RDK0gydUVjWnBnbWZhL0lWZDQ0WnRodk1tekxQeStxQmY4?=
 =?utf-8?B?Z2hmWjBiMXRTYkxTM1lUeW8zeGZsM3h1a2hCb09VQk9ka0tuemRIMWZtZEJD?=
 =?utf-8?B?d1JvWVBVazNPMW00Q2h5QjJJaGdLZnAwRVVYdFhEZ0FLcjRqb3h5bnVWeDFJ?=
 =?utf-8?B?UjBsZkVndWIzMkdYQTA1WlNTc01lTEphNU82VEJnZnpHMjluMVE3WDFBUUpQ?=
 =?utf-8?B?anpoREdKK3phUVV4QnR2K2JiR0xiWVVBU2ErUlF5bGlLTXZIWjhZdHRlVWRV?=
 =?utf-8?B?eGNzZTVRaFRvWkl0NTNsSTkyWkFOKzRGa0FNYzBwNU1zbUVQTGREbmJaYjBK?=
 =?utf-8?B?NURieWM5QXdEVW5ocWNEaHlrQkpLTE9jMGM5YXBDYUdUVitmd3JXYXV3Z0sr?=
 =?utf-8?B?aUV6ZUtYUmJzMFA0NHd3S3FvdlBYZ2Y2d2hXOUlDeHN6Qis1WEtsSis2bDlZ?=
 =?utf-8?B?UFdOdEFXYUZLUzZwY25nQ0VveVdudUw2QXNtOVNNZThzUXc0RG5LNkhUeVor?=
 =?utf-8?B?TTZVWmljbTdPeUF3Zk1jTTk2dko1MVN5ZUx6ZEJHN2VqdmVwMEhLMHpzZm1w?=
 =?utf-8?B?OXJKRjBLcXhLRkQ4WjNVVFpuYXBnVnNYcGgyL3FDVmtJYndSRVNwWW55aElV?=
 =?utf-8?B?TXgrQkdEYjBaTVFOTTI4WVRodUMzSnQyY0VWYXpDeTBFK3pmemNIZ1pKSU0w?=
 =?utf-8?B?VW53SjZkTWN4eFlwWHB2WEdiTWFWZjNlWFlPbHlNRVZPZ2MrU2tUeHlxSGdv?=
 =?utf-8?B?RlgrcTdmTFczaG5LcTllZjkrZTgzbHNOV1RDWldubGZqMkszZnVoRERmaE15?=
 =?utf-8?B?ZW9kRmE1UlhyeHBJSEphSVAxdnRJbWVJdE5lSGxybzV0bmVjb1pjZHpRM0Ro?=
 =?utf-8?B?MXRxQVJaZzJEdU5qL01WbUt1bGRtdi8wV3dpajRNbWZ4aHJyZmt6cDhCQ2Za?=
 =?utf-8?B?UmhEUzFjVzhaOGZGS3kzdFhweGlUaWt1cDNsZ3JpRVNzQVBrZXYyTDg5UXdD?=
 =?utf-8?B?RnFwbWkrbUM3VXRZY1JkTlVwSitxVk90dlg0cWpWcHE2aVN5a0Zzb05Yc1Uv?=
 =?utf-8?B?OU1OaHE2d3N2TnFBNjZKcERTYWhBamtuZzFrTThJMHRNdXJGVkpLS1Zhb3dn?=
 =?utf-8?B?V1hlV1RwSkI3SkZnVW1yOHVjdXlpOXJxWTloZTZPcWIrK2JRd0MrQXJXUFlO?=
 =?utf-8?B?ZGhuclFjdWRQeUQrK0cxVDEvbEhhTFgwSFc3YzYwTGFIMjQ2R2dkdzJGRWhk?=
 =?utf-8?B?L3dHQ0hEZ1VpeHFOa2RYUkROMHdEMjNnRm82VFQvY1FWZ01SRGpoUms1RVpl?=
 =?utf-8?B?NXh6VktTV3NkQWdJTjQzZ2YybW5HckpQZ0Nab0ljNE5XYmF4ZkQ3L1hsNE5k?=
 =?utf-8?B?RzdnRFVZdFExbWl1UUdQUlFTR3RVQUoxTFFLOFFTb0ZRV09lUzVCeWhYeElB?=
 =?utf-8?B?dnJHaTg3WUJZL2U3OU8zSVUrT2hlbXZHT2QrNldxZXREbkZoNHR6ZVNoNzRJ?=
 =?utf-8?B?elM0KzloWjM0Rkg5MVJucWdSOVNacFpQNG95Ymp1WVg3TXZkYkd6VjRCV25w?=
 =?utf-8?B?akxYMGNQQmIyT1JOYWtzN21FTi9NS0djcUxyMUNwNlZzMllvbWEvY01CNFAy?=
 =?utf-8?B?ZVNNL2gwQXd4bHZrVVVlVnlCM1B0R0t0dFpPblVSVzhwZWtEZzF6a3hqYUw1?=
 =?utf-8?B?RU9USENzWFQ5RUZWWngyem9pbXR3N3JzWCtROTJxUDNuSGpENkEyUVdHaVNr?=
 =?utf-8?B?WTJSbW5TRzVHNVZ5T2F6QnJoRDB4L1RlWWVCTG1LWDQycHNNSGQ4QXBha1JH?=
 =?utf-8?B?NG1IWVYwMVdlTzIydzNaN0gxWFZaQ3lrNFRhU0wvcDYwSHo5Vm10Nm1mSnU5?=
 =?utf-8?B?MmZ3d21YcExUK2toSHFtRXJOT2QrUDZjNzdjYUxZYytrd1N5blhPUE9Db3Y5?=
 =?utf-8?B?WnFtamRiWHYvZ0d1cS8weDlOK2NjamNzN0xvUDNVemlicUFrR25EbnhQVDIr?=
 =?utf-8?B?UWpFU0dib0hNR0FrSS9yc0Yxb29jcHhCSmtCc1JNc0RhdC9EdTI2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd01f1-d6b8-4131-f129-08df437cd431
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7542.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 00:59:12.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlzTlau7KdUI6IjiFyUM4e+ZFDKQv9VHNuD9vqNZPOBTmAe9Kx45OGviPcLUuRkcWZVpEt6TfuNPqG6hmVLtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_165921_669095_B6E3BD6F 
X-CRM114-Status: GOOD (  28.43  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 12/11/2026 23:01, Stephane Thiell wrote:
> When the RDMA device advertises IBK_INTEGRITY_HANDOVER, nvme-rdma
> enables T10-PI offload for the controller before any namespace is
> known, and every I/O queue then allocates an integrity MR pool of
> queue_size entries next to its plain MR pool. Hosts whose namespaces
> are not formatted with protection information never use these MRs but
> pay for them on every connect, reconnect and disconnect.
>
> On mlx5 an integrity MR is three mkeys and a PSV pair, so each request
> slot costs five synchronous firmware commands (four CREATE_MKEY, one
> CREATE_PSV) instead of one, the same objects are destroyed again at
> teardown, and the HCA context memory per slot grows about fivefold.
>
> Measured before the parallel I/O queue setup of v7.3, with 48
> controllers of 24 I/O queues and a queue size of 128, connect went from
> 172 s to 46 s and disconnect from ~150 s to 35 s.
>
> Add a pi_enable module parameter. With pi_enable=0, pi_capable stays
> false in nvme_rdma_configure_admin_queue() and the controller is set up
> as on a device without integrity handover: max_integrity_segments is 0
> and no integrity MR pool is allocated. Namespaces that work with PI
> offload keep working, with the controller inserting and stripping the PI
> (PRACT).
>
> The default is true, so the behavior does not change unless the
> parameter is set.
> Signed-off-by: Stephane Thiell <sthiell@hudson-trading.com>
> ---
> v2:
> - Changelog: correct the PI namespace, teardown and timing statements
>    (v1 wrongly said a PI namespace gets a capacity of 0); simplify the
>    memory figures.
> v1: https://lore.kernel.org/linux-nvme/20261112194838.928882-1-sthiell@hudson-trading.com/
>
> Measured on a 6.12-based kernel; build-tested only on v7.4-rc2. If a
> per-connection fabrics option, or creating the integrity pool only when
> a PI namespace appears, is preferred to a module parameter, I can rework
> it that way.
>
>   drivers/nvme/host/rdma.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 32189fdfc0f5..267de27b743e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -156,6 +156,11 @@ module_param(register_always, bool, 0444);
>   MODULE_PARM_DESC(register_always,
>   	 "Use memory registration even for contiguous memory regions");
>   
> +static bool pi_enable = true;
> +module_param(pi_enable, bool, 0444);
> +MODULE_PARM_DESC(pi_enable,
> +	 "Use T10-PI offload if the RDMA device supports it (default: true)");
IIRC, when we developed this feature, a connect param to control PI 
offload was part of the initial patchset, but the community didn’t ack it.
I think that connect param is a better option than the module param.

Later (Jan 2024) I proposed a per-connect option, nvme connect 
--disallow_pi, together with uniform metadata settings for the ns head.
Some of the code for NS settings was merged in a separate patcheset that 
didn't include the connect param.
I believe we can also merge the connect cmdline param (better call it 
enable_pi and set default to 1 as suggested by the community).

I'll check the status of the old patches internally and update.


> +
>   static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>   		struct rdma_cm_event *event);
>   static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
> @@ -806,8 +811,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
>   
>   	/* T10-PI support */
> -	if (ctrl->device->dev->attrs.kernel_cap_flags &
> -	    IBK_INTEGRITY_HANDOVER)
> +	if (pi_enable && (ctrl->device->dev->attrs.kernel_cap_flags &
> +			  IBK_INTEGRITY_HANDOVER))
>   		pi_capable = true;
>   
>   	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
>
> base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119

