Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D3CC77B7C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81Gko+jAIJEUOAETmiHC8qR9XUyAgcoRO+Y1eAw5Xnw=; b=QaEHgWsJXRSXm3D3SmZz1euQhX
	3bQSmnTL/+C+l3VdJ1k44FPZqznvFWrwPsfsAoBqyhn/JY6ygGSnO1eXv5QxRkcVTBXOVpGt7aPvV
	oNG7d51E9csJuc7WKprxQP/DrZksiOiIAc/jLQc+ljPVl1ege8ZncjmiYdaLLhXcjZKy9CAC9T1xN
	iNPO1ehRD1pUN0LYlhMNxdeAAY0hoE1QKWjcJ5KWTdSj5jFbQt82ykA76IuuwH0vni00biPuzn2fN
	pNfZx5PJjZCobMgsRutpUZJ4G3jTkSfkZP+bsF3xK4bachEae8l5rXa9Hl/h3XSKYaZdfWQl2pjxB
	Ex3JDBmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwJxL-002mid-37;
	Tue, 09 May 2023 09:48:27 +0000
Received: from mail-dm6nam10on20621.outbound.protection.outlook.com ([2a01:111:f400:7e88::621] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwJxI-002mht-20
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 09:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP7t4tVtVit26Z8Pvct4GJTB6Pf/JXbUfggCLdAPYhoX9uxDZkeO/hK7CvimSv0/jsRrt8xR4+q49+38lT/cdv1xy8LAqtSizgJWhWxBgstPGN66Ixq43xztPAi5KB/5lLFmL/fYEO7UpMYzrsdq8FyIEwVENppXe5/BT/lkg1Xw7NE+yY2pGfXcKbZtQOOmSE8QY0w4WSmuAb0ljuto2aR4aqxxRmWTcsc+JrNA1DzyxOP3TYTlOWCyZr5KttnxpqY4a5tv/STWhvkp4c3R9afL0A35NQz0DihxHGXUet7qgSDHkyvHPYgL3mDY0DuzwS3ZMdTTHO0djXpr3Ih40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81Gko+jAIJEUOAETmiHC8qR9XUyAgcoRO+Y1eAw5Xnw=;
 b=Oo5nUiy0xW/wuOyAbTqDkblQBs74fwZTfBmMpfPcbGlelQcCDjyxHXS6/vWD92tbvSjFL7XiugQnQ1dshDMB2ehqirR27UAnR15hDmyPp4ojjfEzCz0yK3a2vM2yBFcbveBDYh49yIEs51tNRFEIVORG+AxLvXZKfPyQVwzfk+2f85Iz/YHEfr9MSHUKriPaYXTg2Do4clD9iP6toj+ppP7mhyrbpOUygaQuzUhfGx7uPnQv1m3ul+57Innk/ExvpuSfGuSAnNssQNhoFAl3osKXfZSMS8NYvmBke/8xYMxZK4YD8IhRAhJylLI5TRfMVXiziWSc+3qQwkfO/+HE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Gko+jAIJEUOAETmiHC8qR9XUyAgcoRO+Y1eAw5Xnw=;
 b=PK+SqmbYWBcJ+qCZ99Lef04ReCtZKdo0LldRfUaWhufEALCu6qlkoCujKDv05qF8vCKYaNNhleBpf5mmTTItK070T4FS3W+kuTJC67V4sgE3LWqFNC+GmFeb3qPPqSs8eujNRe98tB7yirGm7liyiMBYZr2hYsMdndQwqFSIoF6G2Af0mqoHW7PbieThyh0EQ7t9vV58Ok+nlvIrXmR9AUJBaRe75jfdVPDGkCZvJhVRTOi+l2UmgpkqwYNVWvzpnpKpvMH4tgsg8NyAexR25nUaEV2LsI3kYT388M27+DnIxQWQ1nnK57kf1O2h/mR1EwU3V7T866vIqYVcdnmsjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 09:48:19 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 09:48:19 +0000
Message-ID: <31551564-2fcb-50d2-99c3-3d09473fce06@nvidia.com>
Date: Tue, 9 May 2023 12:48:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 11/17] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-12-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230419065714.52076-12-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: b10aa87b-569c-4715-032e-08db50728500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	7/PfVycwP0b2PPxThiTbYrrk5668ZNi+cU8hwsw4qt5iatqnBH8+L8etjmLPULeCWzis3pxhoC3Y0nhGsYvS5ZqXGdj7SKewevHp5E8Zw669/snvGH2GPhjhzkkGT8UrPDMCR2AY4crKj0WgZv0DT5GK29Og9gIxUDGR+hlC5BGAWi4Zp3UYwz331a44OFjAY3EmimLTA100iael+cWqFUbVSb5ke7aLeuSLjMwBX1MVKldulFooFzhf3TAS5OfuDhoNGKT9+0jZZQS3W88dHzXDdSbdm/X03tohjdE3rQ9oOsXZuKFDHFa+TraXKFhnYa3+8M8T1BWm61+XXKLBQDkGj2MmTq3xS2drmO+aCsR0HiFEkVEYHMJDT/vrWQY3xQ5gYULp4bCKCiIlrRAJkHAO6acLz/GuKdseiTetyMlOKPUanI+qUydmId1tPCERbmIWZnlSJSQppPgiUTs+FmQ0KVoLMXknWCwSD2ILvRF5S4aVukWL3/eE/RJusqxynjd62Sbdo4qc2FtNWv44311OaH0n2V9O56Cg9RyGUzBw8ZBycEAZhAvfDgCn7w6D6voBh+LUnam3jv9Qzh51JEzbc1gikDIjIrOZ+E3IoROeQKiqGb2lKhwuUjuXkqERO2cEbz9KNtzhDUrJeKVqB2XY+XMaF/y0An2ymf5DeJbygHFLMhziU8yCF8rTB2+p
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(31686004)(966005)(66556008)(4326008)(316002)(478600001)(66946007)(6486002)(54906003)(110136005)(86362001)(66476007)(36756003)(31696002)(83380400001)(26005)(2616005)(53546011)(6506007)(6512007)(6666004)(2906002)(5660300002)(41300700001)(30864003)(8936002)(8676002)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QzJBTnVOVVF5ZDNjL2NSTzhJcHJtM3BRODZOK0dPTFVpRms3bzB4TTdEVGkx?=
 =?utf-8?B?bjBNeStVUzVLRGRLNWZMTlZUQkk3czRUTXpqWGNuQUNsY3RzaXVtMWxCc1h0?=
 =?utf-8?B?UE1Hc1NWYTlGdkthY3Y3Wi9EVStVRU85aHVjaFdiN3BpRjc4NnpMQzd4aWdT?=
 =?utf-8?B?WlJIZ3VXYTNhSUZnQlpKaDBqRjY3ZU1hV0ZIdFNJM29IeXdocVovU20wSkxX?=
 =?utf-8?B?ZWt5eWFyUDNIS2thZFcwNG9CTDU1N1pRbGsrYXkyQXFib2J0MENTWkYwVkxs?=
 =?utf-8?B?YlllTzd5Nk9zSitoVHk5eGV1RWJZMzZrRFZ6L2tjSVVrU3ZKRW9JbWZMTEY4?=
 =?utf-8?B?U1YzSDF3Y1JNMmRHR0tUK1BiM1R5bDJOQloydUM5bnMxbFc1N3paZXhQaGxn?=
 =?utf-8?B?NnlsdjQ1cjU0OUVNMlFVd0gzNUJoaWY5Z2o3SmltMkExL0FDNjBkK0tqZzdK?=
 =?utf-8?B?QlhSR1RqU2RDZWlzUm5jZUdLc2MzdmdrblI3c1pSYjQxV2ZNL3l0dEM5MXVw?=
 =?utf-8?B?ZnBzL3REbERRUnFVTFFyUEdvRHN1UFlKa09KY0FVbXdVbHBHcUx3Wm9nQ0cv?=
 =?utf-8?B?cjRmejAxZ3dmcytyRGtkU21RVEtocWFBaDJpVFpoc2x5RmIxYnhIQVkrUmVh?=
 =?utf-8?B?aCtBM1dYZURtT0ZDTWtESFBpbjZEMVIwZnF3T2hlcU1MT2ZGTWl5N0hhN0Q5?=
 =?utf-8?B?ODJMMEEzVE5abTN6N3haNDVhemx4Ny9tSk9ZNDJ2aUx1aHBjM3dDMWhhTjBr?=
 =?utf-8?B?UnBDU0h1dTdwKzhJWDY3anhYdmlBTjlBcXlSd3RscjBWQkFRZ09nK0EwQkU4?=
 =?utf-8?B?aEw5N0VkOGgwbENrMk94bzBwazBIR3pIcTRsWDM0c2RXcElRRVpoMjVyZDg2?=
 =?utf-8?B?dUhtMW1FYVVMZjNGZkRSK0dTRFJMdGpGWUVZWTZLNEkrWUI3Y0FoSTF0Tmoy?=
 =?utf-8?B?ZFk4R3ZpTndZc1J2bnhJd0I1ZlRLUHpBSDFBK1VXQm5scE9yT3hwWU9rbUVj?=
 =?utf-8?B?TXdXY2JNblFoQ1BVb0xpM2xnd3dYYU0ydFZOd2l1SC9XUnVudWd1Q1A4emJ3?=
 =?utf-8?B?UUdQOVhoVDNVWTRqY0g1ZnZSS2pIYlh5UjNVRWZrYWxMZkdJcmtFUnRhSjNj?=
 =?utf-8?B?MDE2djNnL3FDYmFIUER5b0dJcVJGVDNTSlpFeHNUam9GUWlKM1lJZHIweGNq?=
 =?utf-8?B?Q2hhK2s2V2oydUQ2OEhNRWtrN1dGQTI4K1BPTFNaLzN1RlJyYWM5VHFOT3Bw?=
 =?utf-8?B?U3JBT25td1ZFSmNVSVJUNUhiNnZxeEVyRU9aVnIwczBpeGNBWVVna1dzbWRw?=
 =?utf-8?B?VU4wMis0NSt5ZHpZWXRTQ01nYmlaU2lDVHNKZ1Fqb1M1UlltRFpFdmhkM0NY?=
 =?utf-8?B?KzlwOHJ0Sk9ibjVjQ1BCQVJFdVY1d2VDcnlVb3MyZ3FxVkdFdC9zL2w3aUNn?=
 =?utf-8?B?eHpFMjdETVZ0eUhJMGl0YnR3dnRFZy9hOWRsUm1UQ09lMlZSc2JlYjRTZjlv?=
 =?utf-8?B?WjFSQUpYTE1CYjljcW1hazAzbnkzMjlFQUYyTzNoS0RtY3pNUTFGMGVGeU4r?=
 =?utf-8?B?MUJ2cDZrMkZhNjVWcm9MUXhQWlVPS0ROZGNoL2FJVVE2bXpxTXkxNStSbm4r?=
 =?utf-8?B?L3VYRC8yRWx5ck1PNi9xQk5KOXVadjU1TGRienAvY3FWMjhMT2hVUllXSEk1?=
 =?utf-8?B?MDI3blZ5TW5FL0NIUW9Yc2piWkRUYkMvajNzek1zbjdpeVVHWUorTHliUnIz?=
 =?utf-8?B?bEppalE5RWx2MnBlbTlFYWtwMHFveG5IQmRhN21ORmVESlR3T29nMnhOTlVk?=
 =?utf-8?B?T0JBTDZWZnEvVS9QRjhYQ255d0VXRmtzcUJVTlpMMktQNFZQdWszWGpmRDZI?=
 =?utf-8?B?SHdWU3B3eDZxVzRHZ2grQ0kvTnVOTDRpU0laczFjb0ZFUUJsVHJMMmlOenRa?=
 =?utf-8?B?K1ZnV0F2T1AvKzA4MVNTOW1VeVVwWHBKY1p6enkyY3VSRERFM283Yzlwb0h1?=
 =?utf-8?B?cnRrK0UzcHZucDlFSjN6Q3BLcFBrQ3Q2RWMwdHc3V1N3NWt6OGRYcEVxbS9D?=
 =?utf-8?B?c1IwS3dJTUtRMTJFR2FrTnFocjhVcVc0NCtnL0REY0NVMENEZEpHUXZEMkJT?=
 =?utf-8?Q?dKyfxn1lp+trPAOsfOvlnmVIt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10aa87b-569c-4715-032e-08db50728500
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 09:48:19.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdRZkc4WcOmuv64sM9iVtIV+gzBBYdeNB6R7Nf/3p6wrv11SNKv+W+nEFPfBy0fU5hmNlDI4iS54WbJ+RyZxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_024824_708505_F49FF6C7 
X-CRM114-Status: GOOD (  29.91  )
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



On 19/04/2023 9:57, Hannes Reinecke wrote:
> Add a fabrics option 'tls' and start the TLS handshake upcall
> with the default PSK. When TLS is started the PSK key serial
> number is displayed in the sysfs attribute 'tls_key'

Can you please explain the flow for the TLS handshake in the cover letter ?
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/Kconfig   |  14 ++++
>   drivers/nvme/host/core.c    |  23 ++++++-
>   drivers/nvme/host/fabrics.c |  12 ++++
>   drivers/nvme/host/fabrics.h |   3 +
>   drivers/nvme/host/nvme.h    |   1 +
>   drivers/nvme/host/tcp.c     | 129 ++++++++++++++++++++++++++++++++++--
>   6 files changed, 174 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 2f6a7f8c94e8..96a74041bb0a 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -92,6 +92,20 @@ config NVME_TCP
>   
>   	  If unsure, say N.
>   
> +config NVME_TCP_TLS
> +	bool "NVMe over Fabrics TCP TLS encryption support"
> +	depends on NVME_TCP
> +	select NVME_COMMON
> +	select NVME_KEYRING
> +	select NET_HANDSHAKE
> +	help
> +	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
> +
> +	  The TLS handshake daemon is availble at
> +	  https://github.com/oracle/ktls-utils.
> +
> +	  If unsure, say N.
> +
>   config NVME_AUTH
>   	bool "NVM Express over Fabrics In-Band Authentication"
>   	depends on NVME_CORE
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 79aa215aec76..937013127c91 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3889,6 +3889,19 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
>   	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
>   #endif
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +static ssize_t tls_key_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (!ctrl->tls_key)
> +		return 0;
> +	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
> +}
> +static DEVICE_ATTR_RO(tls_key);
> +#endif
> +
>   static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reset_controller.attr,
>   	&dev_attr_rescan_controller.attr,
> @@ -3915,6 +3928,9 @@ static struct attribute *nvme_dev_attrs[] = {
>   #ifdef CONFIG_NVME_AUTH
>   	&dev_attr_dhchap_secret.attr,
>   	&dev_attr_dhchap_ctrl_secret.attr,
> +#endif
> +#ifdef CONFIG_NVME_TCP_TLS
> +	&dev_attr_tls_key.attr,
>   #endif
>   	NULL
>   };
> @@ -3945,7 +3961,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>   	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>   		return 0;
>   #endif
> -
> +#ifdef CONFIG_NVME_TCP_TLS
> +	if (a == &dev_attr_tls_key.attr && !ctrl->opts)
> +		return 0;
> +#endif
>   	return a->mode;
>   }
>   
> @@ -5080,7 +5099,7 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
> -
> +	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
>   	nvme_auth_stop(ctrl);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index bbaa04a0c502..2aa8fb991455 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -609,6 +609,9 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
>   	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
> +#ifdef CONFIG_NVME_TCP_TLS

This ifdef is redundant IMO.
We have to many of those already in the code and we should reduce to be 
able to keep the code maintainable.

> +	{ NVMF_OPT_TLS,			"tls"			},
> +#endif
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -632,6 +635,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
>   	opts->tos = -1; /* < 0 == use transport default */
> +	opts->tls = false;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -918,6 +922,14 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			kfree(opts->dhchap_ctrl_secret);
>   			opts->dhchap_ctrl_secret = p;
>   			break;
> +		case NVMF_OPT_TLS:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			opts->tls = true;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f7..5db36e250e7a 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -70,6 +70,7 @@ enum {
>   	NVMF_OPT_DISCOVERY	= 1 << 22,
>   	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
>   	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
> +	NVMF_OPT_TLS		= 1 << 25,
>   };
>   
>   /**
> @@ -102,6 +103,7 @@ enum {
>    * @dhchap_secret: DH-HMAC-CHAP secret
>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
>    *              authentication
> + * @tls:        Start TLS encrypted connections (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
>    * @data_digest: generate/verify data digest (TCP)
> @@ -128,6 +130,7 @@ struct nvmf_ctrl_options {
>   	int			max_reconnects;
>   	char			*dhchap_secret;
>   	char			*dhchap_ctrl_secret;
> +	bool			tls;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
>   	bool			data_digest;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..fbcc0ccf2ef2 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -347,6 +347,7 @@ struct nvme_ctrl {
>   	struct nvme_dhchap_key *ctrl_key;
>   	u16 transaction;
>   #endif
> +	struct key *tls_key;
>   
>   	/* Power saving configuration */
>   	u64 ps_max_latency_us;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9deba481ae6a..d25695cf4e03 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -8,9 +8,13 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/err.h>
> +#include <linux/key.h>
>   #include <linux/nvme-tcp.h>
> +#include <linux/nvme-keyring.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#include <net/tls.h>
> +#include <net/handshake.h>
>   #include <linux/blk-mq.h>
>   #include <crypto/hash.h>
>   #include <net/busy_poll.h>
> @@ -31,6 +35,16 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +/*
> + * TLS handshake timeout
> + */
> +static int tls_handshake_timeout = 10;
> +module_param(tls_handshake_timeout, int, 0644);
> +MODULE_PARM_DESC(tls_handshake_timeout,
> +		 "nvme TLS handshake timeout in seconds (default 10)");
> +#endif

Module param under ifdef also sounds redundant.
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -146,7 +160,10 @@ struct nvme_tcp_queue {
>   	struct ahash_request	*snd_hash;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
> -
> +#ifdef CONFIG_NVME_TCP_TLS
> +	struct completion       tls_complete;
> +	int                     tls_err;
> +#endif
>   	struct page_frag_cache	pf_cache;
>   
>   	void (*state_change)(struct sock *);
> @@ -1502,7 +1519,79 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
>   }
>   
> -static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
> +#ifdef CONFIG_NVME_TCP_TLS
> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> +{
> +	struct nvme_tcp_queue *queue = data;
> +	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> +	int qid = nvme_tcp_queue_id(queue);
> +	struct key *tls_key;
> +
> +	dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, status %d\n",
> +		qid, pskid, status);
> +
> +	if (status) {
> +		queue->tls_err = -status;
> +		goto out_complete;
> +	}
> +
> +	tls_key = key_lookup(pskid);
> +	if (IS_ERR(tls_key)) {
> +		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
> +			 qid, pskid);
> +		queue->tls_err = -ENOKEY;
> +	} else {
> +		ctrl->ctrl.tls_key = tls_key;
> +		queue->tls_err = 0;
> +	}
> +
> +out_complete:
> +	complete(&queue->tls_complete);
> +}
> +
> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> +			      struct nvme_tcp_queue *queue,
> +			      key_serial_t pskid)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +	struct tls_handshake_args args;
> +	unsigned long tmo = tls_handshake_timeout * HZ;
> +	key_serial_t keyring = nvme_keyring_id();
> +
> +	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
> +		qid, pskid);
> +	args.ta_sock = queue->sock;
> +	args.ta_done = nvme_tcp_tls_done;
> +	args.ta_data = queue;
> +	args.ta_my_peerids[0] = pskid;
> +	args.ta_num_peerids = 1;
> +	args.ta_keyring = keyring;
> +	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	queue->tls_err = -EOPNOTSUPP;
> +	init_completion(&queue->tls_complete);
> +	ret = tls_client_hello_psk(&args, GFP_KERNEL);
> +	if (ret) {
> +		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
> +			qid, ret);
> +		return ret;
> +	}
> +	if (wait_for_completion_timeout(&queue->tls_complete, tmo) == 0) {
> +		dev_err(nctrl->device,
> +			"queue %d: TLS handshake timeout\n", qid);
> +		ret = -ETIMEDOUT;
> +	} else {
> +		dev_dbg(nctrl->device,
> +			"queue %d: TLS handshake complete, error %d\n",
> +			qid, queue->tls_err);
> +		ret = queue->tls_err;
> +	}
> +	return ret;
> +}
> +#endif
> +
> +static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
> +				key_serial_t pskid)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> @@ -1626,6 +1715,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   		goto err_rcv_pdu;
>   	}
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +	/* If PSKs are configured try to start TLS */
> +	if (pskid) {
> +		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
> +		if (ret)
> +			goto err_init_connect;
> +	}
> +#endif

Maybe reduce ifdef here and use IS_ENABLED ? (might be done in 
nvme_tcp_start_tls too)

>   	ret = nvme_tcp_init_connection(queue);
>   	if (ret)
>   		goto err_init_connect;
> @@ -1769,10 +1866,22 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
> +	key_serial_t psk_id = 0;
> +
> +	if (ctrl->opts->tls) {
> +		psk_id = nvme_tls_psk_default(NULL,
> +					      ctrl->opts->host->nqn,
> +					      ctrl->opts->subsysnqn);
> +		if (!psk_id) {
> +			dev_err(ctrl->device, "no valid PSK found\n");
> +			ret = -ENOKEY;
> +			goto out_free_queue;
> +		}
> +	}
>   
> -	ret = nvme_tcp_alloc_queue(ctrl, 0);
> +	ret = nvme_tcp_alloc_queue(ctrl, 0, psk_id);
>   	if (ret)
> -		return ret;
> +		goto out_free_queue;
>   
>   	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>   	if (ret)
> @@ -1788,9 +1897,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	int i, ret;
> +	key_serial_t psk_id = 0;
>   
> +	if (ctrl->opts->tls) {
> +		if (!ctrl->tls_key) {
> +			dev_err(ctrl->device, "no PSK negotiated\n");
> +			return -ENOKEY;
> +		}
> +		psk_id = key_serial(ctrl->tls_key);
> +	}
>   	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = nvme_tcp_alloc_queue(ctrl, i);
> +		ret = nvme_tcp_alloc_queue(ctrl, i, psk_id);
>   		if (ret)
>   			goto out_free_queues;
>   	}
> @@ -2699,7 +2816,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   

