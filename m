Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6857C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OobI790ZWs3pnGj/Awx16RrbRjpQ1pv7JDEDOdqLcU8=; b=Ebr4V1Eoxybx3DdvQ973dqpHTT
	IpHV9s/GBAY4NqOS33qantu1ljhGNA56n5TRKYZxRqXzRWwf7DPfDyMvoQ05JjOU5P5qtYmR/5B8c
	/BOBNr/SdarC9wyyI3FumvllEZuB6epbqvw+Lwa2q8phIg0D6TovpbOHLF3CmPfEY+glCSAuN2w+3
	fGNZCq+LC9Wgbb+nkkJ4K42pMVPkBaRLdR1NZXl43ZXa1LLpxgm5q9sbLDDclN0s2rOTvnBnhue8J
	YltC4+a+O+4I3TiClWT4MFTQ4hToVeLPR5O19JDW1h9kArZMbzQTD5IiJefCC7BxHzdEb4TXthGLq
	5e0odTlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np8Tv-00By8w-FQ; Thu, 12 May 2022 13:03:51 +0000
Received: from mail-dm6nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::60b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np8Ts-00By8O-Eo
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 13:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIpCBdPFBi4Ro+Dod3MkkbIObJvSldgBQLvG68ghLlT/qoIKQy7QOI3m3g2ULuiTpXQIaqmFLIqnNJENdpPQqgnm9aTAr408ARrIA0ZtqNipNOdTiiCBvIoeAuVNgEU9CmigEg4pOa5sgvniWaJd0cmhHfuuFynw0ky1gfkpr7jzfVYyHN6L3chYvAP0wtCEycA0mVku2WSTxGXIxLfKIDyKXo9w1V8WCelHtdrny0z87/8IH/FwsikJrSGVR5aycmj5nijkP1t/csZ2N5GVuAvNzq8F74+jrEh4jhrCas5V5IZ0mVBBmQ3pVNnyFodNBSxIHGZvIDhrCxRTc6zRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OobI790ZWs3pnGj/Awx16RrbRjpQ1pv7JDEDOdqLcU8=;
 b=OWY76hpQ2qzbUp9dK8ExcDdmBM5fRBRngSKOebr8j+Jqquonip1b1YB5mKzdXfIRFBvbQI3r7MH19TKSIi88RK1NbvUynQaSOo+zAee7HJpePMMTbjEF2Cd+vlgXvhpf/LCPpScbJT+TcHx1azB5R9EFt27GXK714+RePTTYeVhzIkB2ke3q15mnv1gWaRllK2oRf49L9mGSNcGr/9v1PcQiza+nMf2jMlC4UinIw0RmmAcFLpZdCqK8GDI1LOYabspR0LJ6KssqQUnEtrZ+d7rGUxWhErxWYhlKoKG0EpdE+bJ/CqxnWrF1d/v7tp7U8vgQTLRR3LkYb9tVEszy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OobI790ZWs3pnGj/Awx16RrbRjpQ1pv7JDEDOdqLcU8=;
 b=IsJ/eDykKV3+njtKzcPdp2wcmFVwBjQVSH59ZTHRdpqVYAUTQuTuCKvRsudHifIIGF1BGd8DGY3CCdnspt5PfmO1WYj/vMo+nNN0Sg/n5arqdOdEztclweYOe4xxGY09vJKFJ5jzsfLVwT/a6JOJHx8/2wlof0DTmIPrnMo3upb17GEpBbcwt621GvRe8JOsnQc94dyuIz7NATOFBOVCKTKHmINopyp+NAvkGjgUY+NKWNd6nkKG5+Q75mAOwoOp0GgPxTHcXV2HeewpbZAae0cqwkajlQz4pjrz1lnLnn1EmMCBaFotZbIliyfVvGY7cFCnNWILQo0BDZBMTE1xDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by BN6PR1201MB0052.namprd12.prod.outlook.com (2603:10b6:405:53::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 13:03:45 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::8cf7:6462:3cd7:d1cc]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::8cf7:6462:3cd7:d1cc%3]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 13:03:45 +0000
Message-ID: <7fc45981-6f12-4cb2-9eb1-f18cfa69d0df@nvidia.com>
Date: Thu, 12 May 2022 16:03:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] nvme-pci: Harden drive presence detect in
 nvme_dev_disable()
Content-Language: en-US
To: Stefan Roese <sr@denx.de>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20220506101534.1728011-1-sr@denx.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220506101534.1728011-1-sr@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e94db87c-6473-4510-cb74-08da3417d85e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0052:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB005296E804B14E7084E29611DECB9@BN6PR1201MB0052.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOYZrTmkC5Dn2YlovGwRqP8kDX5qjT/Ety6cjW/2L1lD6v27/vJ8U4Wiln2rBBBDSbKGkLWGkL5cFOHszOnZNtSVEq+KJebckRLU5t/IoP7pP1iFZofCN/QhiArGCugtkB4HXY9rqi5OXW2+uhqgrk/5AaKsPz9KCdCBEKeJ7L4zFpOxe8YG1UHnSZAguiKfbTdG2XPQsoxqyLqgN4ctOOTkYRs7gTj5ApEIfjGONraWwhAd5dcbQCygWHs1JvEELdGsTRyoF+/NB4TutdHPei1ZZFw9KZ/O3NkwnJXUsEcb90MjHKRFt46WZg+FOCUOcmnk68Xowg7wDXVAmT9VIuuyOFc7AEByV1T6L5TRf1PbVyIzty0ZCSn6BldkbE7zZyLMJUFmsqCkIrqxn9hNokLPkgkRac/O6AC1AlWULF1r6ufmGU2UbcVAxjHDSOK3JA5u/rG3poYAjwQl7wALf30lKeIdgzzu3df1tvzNM34q+li1ulAojZEbR/+Np417AyOTLtIt6opQ0QQiYvd/75tqIWj0jfQ6siodaKNtKZ6nPbICemBGuIAcc4jnoIxuobABSOcKsxFhyIIc6EnVpvnyIB723oMAm62xlJOUu26vVpP8qwN1KjeHAWVu7t7FwblDXnjRfMjwCmR0Cu6N4V2CcHQYrH0YTj+5tdPXcAac+fvX/r1P/IUiIbpsCTIrxnov9+LeOVuERjqCmmqkzEVEBBGYfXZL2KKove9YqEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(38100700002)(26005)(8936002)(2906002)(6666004)(508600001)(31696002)(5660300002)(86362001)(6486002)(53546011)(6506007)(54906003)(316002)(83380400001)(66556008)(66946007)(66476007)(8676002)(4326008)(2616005)(31686004)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFlEckk5V3VMWlB6WGZmcC9ZOVlWMTJBZWJ5d0g5VnVFeXB1anhFSTdBUlFw?=
 =?utf-8?B?RG16MTJUTUgyYnNCOXJIY3EwUUdXVVRiTVkzZ0xjQjdEc1JSRDJCL3Vsb09U?=
 =?utf-8?B?VnU5bWs1TVNWa0JGQlg5NkVEM1lESDlzTUNKUjRsaDEwdEQvY2Vyc1QvWnBX?=
 =?utf-8?B?VXd6bzRMU1dBeUNwTUhMb0J0Z3BtMFExV3NreDFWanRuUFFwNUNFcWZBcHJ4?=
 =?utf-8?B?S21rMHc2RG1DVGs0aG9pdjZQeCtMVW9ua2Y4bFdjQ2s5KzlQOTdYL2JKQW5a?=
 =?utf-8?B?YmF0QkR0WUdvZHhVNWJ0VjM1am56WUxBVS9HVk1SKy9xa1haM3dOckplVURM?=
 =?utf-8?B?Q2kvbXJZSGRtMlFKOGNrMmg1UUp6K2RtUSswZ2dRMFprZHVhYUFPaHUzOERm?=
 =?utf-8?B?WWFrbit2Mnk4T2FxRERKd0dMOXRLdzlxWkhYNngxaDBsUXp4dHRQMEpIUXFK?=
 =?utf-8?B?Z0JIQ3krSjJGN3M2b25JLzd3aHc4Q05qWHNWTkx1bXhtaHJXVWdSTEM2OXU1?=
 =?utf-8?B?QnQvN0R5QnVrdlJTZ056cXBuZ0VlK2IxRVJ2eXg1RVFrWE9WUGRlcHlGMWZX?=
 =?utf-8?B?T1Q4amdxcGhWMEFMSVNzVnUxbWpkRnlmN2VHWVQxQ2xXd0hKM3ZNK21NWU1V?=
 =?utf-8?B?TkJvMlBLbnp4d1g3R0Q3SlpFMVp6Y1ppWElhd1V2WWJydkJSUEdrb1Z6cGVy?=
 =?utf-8?B?SGkxeEVNeUI5Q3N5Zk9qdElLc0YwSHE4TmpBNmVIWFdOMEFmc1lvRTRLQmk1?=
 =?utf-8?B?M0hjN1RmVlhudUkycWxKRVlXNld6bW1WQ05qNldPYUsrR2JSR2VIV0wra3dP?=
 =?utf-8?B?TzJ0TFNMaTZMV0FNYXFTaDUvTEhUeTl0eEtwTXNPNW9neXNKY0VweTVEL2RL?=
 =?utf-8?B?ZGFMZ2RndC95N0pJd2ZaOXFVaG16UTdJOEZQZ20zMWphWkVyd2lhMUFueXhl?=
 =?utf-8?B?ZVZoWjJvOTJDa3lkbERsa01sSGd2Q2ROYTNZc0g4WC9QNlk2WDB0S3V0RGwy?=
 =?utf-8?B?UGVwc3NaRGF5aUMzdllFc1dadHN3Qjk5WmMzUFMxZUIvVElWeGw0OWtoZmVY?=
 =?utf-8?B?YU5zNktyNHdBYzVFb25uZ2hlUjdGVDIweWdNMStIdTJaYTc2d3R5UWt2dm5x?=
 =?utf-8?B?VEFUSklRbkE0UVBGZnVkMHBsSmhUWTNtRUxhYmxRSk1JeUpVK0lTU0czNGI1?=
 =?utf-8?B?QjYrYjZjbWFNZnZmTzEzM0xqaEd2R21vaWNlelc1c3d3bytTY3BvdVJoRGt3?=
 =?utf-8?B?V1ZlRDM1UkZVc0tMYnh3R29QMGhkZmh4emJJVWVVejVLclNtamMvWVMrMngv?=
 =?utf-8?B?Yk9ZeWZCWmY1eWxsOHVWM2RQZ1hJTEl2emNoV0tyUnE4RUFwZmZqakg2ZXVM?=
 =?utf-8?B?WjNqY1l5T0dBVDZSQXdnMzRQdzBMTEs0RWk4NUQ5RUNGdUVFS0ZoZnpWdWgr?=
 =?utf-8?B?TElVV0xXdGxhTGhXZzRqMjVpL3lJYUoxbVJCME56elJxTFZDMDJqU0Z3eXdw?=
 =?utf-8?B?eFNEMkYvNWpjcDB3YnE4Y3dqQmZnOTNLOGRLNVFvSmlsMWZnWW5hYTNpWGdH?=
 =?utf-8?B?Z1g3YkVXQ3NEYlFUV0NSeHY1WnBRZENtZU5sUUtxWnhuazdFdDZnQnJtcHBv?=
 =?utf-8?B?Y2E0TmlWNExFcnZIbC9RMHRSZ0l3RzRmaTBwZ0N5KzRsY0pXd2ErdkR6UWZj?=
 =?utf-8?B?MjNLOWRxZkpaZGo2QlN2ejFyRFYybjBiVmpEWDczQUhiaHU2Z29wWmZLMkk3?=
 =?utf-8?B?NzVRZ3pZMEhqeWI0M0ZBZll3SkF5S083OTBFenVuU2dCbjF2Zzg5K1lzTGJK?=
 =?utf-8?B?aUVFY1ZkaFdQc3B1c0NPSGhLSndQZks3T0FUMi9yV0E4ZkFRa3c4REZteGhl?=
 =?utf-8?B?cWtYMnBGMVNHYjdvOFZjUDc5dlVqMUdsT2F2c0x1MDl1REpHb0JOcWw4K3NH?=
 =?utf-8?B?Vnl4cGNNVjlJN1RjWTlsQWVPdVlVMmw2aFA2cHpaNHc2eUVEemwwcmh5alNK?=
 =?utf-8?B?V2s2ejdRdEVFSVNHRm9kMzhTS2Y0UWdWMzJuSUJOTVJySlJyZ0xPMnFKVS9w?=
 =?utf-8?B?SEFLeXVpaktIUzh6aDlFWmFDUFpKY2ZtcEl6cFd0cS9mWjNFZExFdjlYZCsz?=
 =?utf-8?B?dXI0NCtqSHRBUlhRVEhmMlUxQzF5Y1I4enpyTHI2Qm5hRUpxK3BtbzV4Tlht?=
 =?utf-8?B?U0U4eGdMTTV1ZDdrRWZIWFoxWnd0VXhZcWtnVEVhc2p4anNzYmtVMnpoNjZJ?=
 =?utf-8?B?c3I3V05zdnczVDJYd0JpY1JFVnMxSmJFeUZWN2Q4MEg0dXRGcGQrU1JSV0ZT?=
 =?utf-8?B?Q3RNS3g2M1FVaWp4VXBQbGhRU1E4L0FSSHJWUnFURFVINXR0ZTJhUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94db87c-6473-4510-cb74-08da3417d85e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:03:44.9379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfe2H26zZBmfT9nn28s7QCKZM+oAOtcgdCcozCklBYCbxSrWEeU0ONf0mQjLUg9Jq+XrHdiGlRCR1LpxiuPj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_060348_547402_197A433E 
X-CRM114-Status: GOOD (  22.08  )
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


On 5/6/2022 1:15 PM, Stefan Roese wrote:
> On our ZynqMP system we observe, that a NVMe drive that resets itself
> while doing a firmware update causes a Kernel crash like this:
>
> [ 67.720772] pcieport 0000:02:02.0: pciehp: Slot(2): Link Down
> [ 67.720783] pcieport 0000:02:02.0: pciehp: Slot(2): Card not present
> [ 67.720795] nvme 0000:04:00.0: PME# disabled
> [ 67.720849] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> [ 67.720853] nwl-pcie fd0e0000.pcie: Slave error
>
> Analysis: When nvme_dev_disable() is called because of this PCIe hotplug
> event, pci_is_enabled() is still true. And accessing the NVMe drive
> which is currently not available as it's in reboot process causes this
> "synchronous external abort" on this ARM64 platform.
>
> This patch adds the pci_device_is_present() check as well, which returns
> false in this "Card not present" hot-plug case. With this change, the
> NVMe driver does not try to access the NVMe registers any more and the
> FW update finishes without any problems.
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 97afeb898b25..c764a2a1d7f1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2473,7 +2473,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   
>   	mutex_lock(&dev->shutdown_lock);
> -	if (pci_is_enabled(pdev)) {
> +	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {

sound weird to me that pci device can be enabled but not present.

Also why we get hot unplug event for FW upgrade ?

is this the correct behavior ?

>   		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>   
>   		if (dev->ctrl.state == NVME_CTRL_LIVE ||

