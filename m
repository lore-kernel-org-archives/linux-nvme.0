Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9D7EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=avXPAACYSAlZHMghdcHSals4fAe6IeHKJ7Zw9seN9jU=; b=sr3Vsv+ybv+Bi44TtNduEaIkUW
	4W0AG3qBBuRfTxLe88nHuKwEHxu9DfQoJ9HN1i29w6ZyAQhaFp8x6cA0rGUAutbyhr4msA/UAVHq2
	mfusL7cAPJQbD3SCOBSCEUKIJxJb7TeA+erxXFsybl4bPVssqDNxYxe2AjewqrQR36kglzPxwNZ+4
	lbcTpvQszViSHEhCu7ueuh9QlgkN7XFuV3Hm17DSnoWLhETwtVW00imbFRRqg+mhqzNrWm1o3+vm6
	dP6ojuk4W7hXpd4HhRgFsFKRqLBg3XPyT8Yd+bovmGbo898YsJUfn6AES7x3GAyrPeZlKHZLhSOyK
	Wgnzs1Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEB9U-00DaWV-0H;
	Tue, 27 Jun 2023 16:02:48 +0000
Received: from mail-mw2nam12on2061f.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61f] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEB9R-00DaVi-0d
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 16:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8BjH49puaiQQqYd5fC71tKiqjW55HdPfK1BjbT8lxpzUFM3acVdL/gxoUoTlVLbtooHSuFflj+tkPuEXE/aBkaMckOVDCMjtq+oy90jYxkwWHz0kdlwsgD3NsCIYU3E+pavfBpyh2pViy95N0Gr/HPi0im4FNxQmIHzHPDCCOTn9qv9PFWpITJ3UK6S7m9mMapMYIfhe0IVTxIFnn3Yy2uTfkBjzCnxHtjfw09kbCuyKUh7ywosZ1emKfRxmx9ixkiifEK9FMiAKUE6iCAad4XeuhyRPGHagvZVaHpqX1nsWdw1pdX+SL7yWxyLh17H8GpnbRH5fq2JEp2l45VtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avXPAACYSAlZHMghdcHSals4fAe6IeHKJ7Zw9seN9jU=;
 b=m7D5HIyCW2RSB9beLkhCF1gmIlrhE4Pi5Kf9sk9jaw7W8LK6zJ2vfjmPCsJBkF3OIv8gjmELou7kEVdflA33HTW/qgtF26502MiI2EAuehZC4fTeJzEb1StQNuL12G4z8vuYWESNHQrWGKn7R9S6iD56w14CsN7/nrzavLeQkquvMefr85/PzdTtIG5zmyY7qoM+t0woUCuNXxHZ5+5d9MDRVm7Ase0T5JvHI+IO/UfQ0v44iOmUdD1k5qT0lZgFUK7LzTzwuaLnEVlLO+NKNHVV2a8z2QB80DvZVHT5Lzkq6RVbpu+D2dhlZ5FbsNQGNa89F85OAN9DHyuv9PJiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avXPAACYSAlZHMghdcHSals4fAe6IeHKJ7Zw9seN9jU=;
 b=Mdd7d+UDAX9EECX0Q6GO/bzKfb0owQ6LaBs92uMd8X89iGEM6564Y7uEiwTXuk32ouYSq4a3t9nTrm6srDDaqzfDf3t2pU3MAdEYwMmij3/2fUdeXHxi69QPaTRQ9ltJxYN0RzpvAo45e4ksGpz5Ejd6N4p32ihFf86TAMu+JWL7ZxVWmFHkoBXPJhRuWRfl+WJBX2VkvXz8uEQD0BttoJ4PFAFkCrnsKIpQ6nLwXhb5FPJkFiz57q96Q982lQM1jDXieg9dGSM4udIeY+i3Ufbg1ml1XN5FQeZg3wN3QLCTRX//Nit0M9T1Rcd/2gUGPNmHjT7EKD5FtqD6hwrzvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 16:02:32 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::b1d1:d11f:8bc4:a39d]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::b1d1:d11f:8bc4:a39d%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 16:02:32 +0000
Message-ID: <c68c669a-21e0-b257-5a1c-bfabf8d6f558@nvidia.com>
Date: Tue, 27 Jun 2023 19:02:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme-core: check id->mc before setting
 NVME_NS_METADATA_SUPPORTED
To: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20230624103502.8772-1-irvincoteg@gmail.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230624103502.8772-1-irvincoteg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4415be89-217e-4933-7021-08db7727e9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xcjCMGafkrejEAXyVF4cBe5YuDGv6FF9AR0kel+Z7o84BCBZYyoeeSnO3pt2aKzf9tFku8FMUafe4xnQVcj+IRjUHKVSb7kHU8CsJ4V6qc5Rn7kB2Rg63YO5ugwUlw2Q2FSHdqPmtUG250AzZmqVnSKoIL+3lX1NbacShzfQ37qbJtXysYxPZbgkgZcrJTMgq3cFvg8Y5jgKFXGwd5wlwtm2Jt9IJ6ks5nY+xeDXzIaHLbWUEtwGBRUdpW0r2nD+0UcCPPp/VGR/iXxAeR1tsg+MnZ6SqwwoRe0cEaOI+I0xeYK+m/0jt3tVmaPGBS2OF6hhsLgVxU0CCmKiFJOieTjZKSw3O9As/9D8S+tCJyYiZ57bMV/+BHTUtNQIxW200ePtnbaBvvAWolIGSn7xxEzhRBP+7ITcchtFJgl8NlgbvrlsAlMGe+5CX0YYkx541sCjBu7f5obrRwB0R0lZQitwZDTCu7ZG2Ke9sGy6d1lmgOt1MLYT8CR1b4cT+x2Uxr2uhCKLUT9zz61tMnxhjaZLYhJYLK+1zZ6hAITu1tkOZxJj288UoTeiSqdVu2/He7X1arULiCQlS6GBYOam1u3Gr/Q9zjtqDPjacveqoWchLHLqeRSvaW0DfgVaqEZ7rzotaT7SeUGluBn1noHkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5032.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(31686004)(316002)(66946007)(66476007)(66556008)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(31696002)(86362001)(2906002)(41300700001)(6486002)(53546011)(186003)(6506007)(6512007)(6666004)(26005)(83380400001)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Uwa1R6WDJzYllNdEhwcHZkbW14eTBLeWhob3BHTEJwMG5QMjZ3K3JIZElF?=
 =?utf-8?B?MlY4MU9UMFUrZmowaTRBb0FoVjlna2RvdkxXY3lxNnk3eHFnY3RJL0JKU2VT?=
 =?utf-8?B?bnVXVU5acG9xa2x2SER3NDdRWVNFT0dJR2huRWhENE5zdVV3Q3cyaTlvenB2?=
 =?utf-8?B?TTBBTDZzbUJYRzNNSHVDZHBmWXBDbjB3UVd6Tko0RDZ3VXpzYU9zZloyMGN3?=
 =?utf-8?B?TFBLUWc3Y0RqeFpDUXNlemFjTHRkbmlTTG4zWFVXdExjMll6d05UUEo5OVkx?=
 =?utf-8?B?WDFYRFlmZ2ZXc3BVVEh3dVhZMHAvaVJ2MWFIWStJaTRnMUliaWdqUlJRVTE2?=
 =?utf-8?B?RTM1Vzk2U3ZpeUFxekk4VFlUakIvbkgva21FeWV5ZjVwbXhxTDFDL1VLSG5G?=
 =?utf-8?B?ajBoalN1a2Y0dlhndEQ1M3JNcDVyM0txbzJNQklVV284amZTa3krZ3A3N2Zy?=
 =?utf-8?B?T2t0bEd1aDIwL2p2UVN2MS81ZGVCdVhOWXdkL1VaeXdscGFoYlJZeU82SE4w?=
 =?utf-8?B?elVpZWRlUnlzMkdSbFNKRGEzYXZhZFJHK3VzeGNQazRyMC9HMnZJem1CdmRy?=
 =?utf-8?B?V1VFZm1XWDk3UE1BQjVaZGx1UHd5QnVjUGlpTkRZK0RxTkdmeEFycEx4enkz?=
 =?utf-8?B?Wll3Qy9kRDcwV2lhNUd1TVZZWEZMNU5wNzdtTW1SRHRvVG9pb0hwOGxwRml4?=
 =?utf-8?B?Tk1YYjRFVGFOc25RVFZURStSRldzeDlWVXpqSFVRTEtTSlgzYnZEcGRrdFpW?=
 =?utf-8?B?TjRzamFjd1kzdEsxS0FqOWIwSk1qMFhGTEliV0tBRno2SGV4MUV0ZzhvdlFI?=
 =?utf-8?B?T0UrNzlydUlNVWU1MWczSkozc3FhbW1ZN21ZRjdKdzlYZ1YySy80bm9zM2hH?=
 =?utf-8?B?QnpHeGwzbDlwM3ZEdE9tY3ZmNzVpdEUrUUZ4N21DSGtqcjNKbktqdFA1RXFl?=
 =?utf-8?B?VndyTTlyMHRBSEh6Wm9JMWp1U0dyTitleXAxeW9DVlhCb2pTVXFiZG9HV3ls?=
 =?utf-8?B?YTZPbzFZdXhQNEQrN1VEVHprMUFNa3NKb1hGamxRMUorYzg2WVdBTlphRzRQ?=
 =?utf-8?B?UDl2OUxMdDQ0WFRaTTROZXAyQVQ1bGlPam5PNW5SZXpSZTY4SFNPK01mVy9R?=
 =?utf-8?B?N1FpUUdlTUNvclovZUFGaU81NzhvczliT1QrT3dnbHFRM3dHcSt1L2R1Qjhr?=
 =?utf-8?B?cW9WNm1Qa1Z6Wi9aSWJ5WjdwWlQ3a2lBT2p1KytMWXZFM1VBZ3AxRWJFTWdY?=
 =?utf-8?B?cnVwN0lmRjhJUU5USkdDYW9TMTFNLzA2VVZyT2ZONEhWRlgxZklzVWRhQWwy?=
 =?utf-8?B?eXYxZTZqYVpoNlA4WFdyWlJTZE1TemlDazBKVmlxbGFEcStSd2FiTFZocGc1?=
 =?utf-8?B?RWhyamlnU0VLb2xrcVVxOUt2V1FXd1ZlSTNiVjhsc21WRzBwUkpwRWlwK1F2?=
 =?utf-8?B?WDNKejlFMFpPaG5IM1Z3Y1JmRDlEZ1FtVFRQQ2lxNlBzUGN2MHZQcWpRMTRZ?=
 =?utf-8?B?MFgwSHRxSlIwVVFhNzBIUmdrNWR5S2RtZ1NyYXJ3eCs2UDhKak91M3BVclQx?=
 =?utf-8?B?cmF1NWMyRFg0UG16ZFRSeWJ3allVNUc3MjYxS3BCR0VHeFpKZmZuekNsc2ti?=
 =?utf-8?B?Tm9iKzhubW5CZ2xpcGhnNExDRktNaFE2VmtoZHZ3WWtyNFNMVGhCWHhlVTE0?=
 =?utf-8?B?ZFQ0ekJaa0RkRzZqWUgvdFBCTThuY2h6SjhtTEVzUm5NdkloTzZEeWFwM1ha?=
 =?utf-8?B?Qk14SEZ1S3dSK2x0M1lXQXNtTmI2aXhkM1g5Q1M1WVFST1UwUlZscjMvMklR?=
 =?utf-8?B?SHhzY1lRaFlnY3ZvbjU0cUlGa3F5UjgrZURYaCtSMk9BYlNBRkR6T1N6OU5D?=
 =?utf-8?B?N2xZRjBpNk83ZUIyUWZMVzV0V2lqdXRCMVlScU9KWHR1TnhNNG5zN2lEUG11?=
 =?utf-8?B?T1Fmais4NHVaQUNJdG95Qi9OMG16OFJhdGh1b1NoUXVkWDAzTjdQT3hNK0Zv?=
 =?utf-8?B?NWFyeVNuZHE5SlhTRUZTMXFEQkc2MHloS2tKRldRNHNJZW90WVJldkhwcmxH?=
 =?utf-8?B?eE9vR1Z5U2hMK1NGSmxCL0JJTzdWTEhrNEFjRnJQSXJ3UWEzUWUwY0pzakdv?=
 =?utf-8?Q?EPpqiE9+rVJzu2oPLWInrNNs4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4415be89-217e-4933-7021-08db7727e9ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:02:31.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJFAqa6H0maILxkhyUZW80YvNqbrmYd6oEKSZahR7XUSdmhrY7L84404P7ia0DA5WkCdQtqiOX7SuVBboFesMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_090245_252669_F49CA30E 
X-CRM114-Status: GOOD (  16.82  )
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



On 24/06/2023 13:35, Irvin Cote wrote:
> The NVM Command set Identify Namespace Data Structure defines
> the metadata capabilities field (mc) that determines support for
> metadata. Check for the value of this field before enabling the
> NVME_NS_METADATA_SUPPORTED in the nvme_ns data structure.
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>   drivers/nvme/host/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..465206b5cf6f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1841,7 +1841,8 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		 * Note, this check will need to be modified if any drivers
>   		 * gain the ability to use other metadata formats.
>   		 */
> -		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
> +		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns)
> +				&& (id->mc & NVME_MC_EXTENDED_LBA))
>   			ns->features |= NVME_NS_METADATA_SUPPORTED;

this probably should go into the WARN_ON_ONCE above since it violate the 
spec.

>   	} else {
>   		/*
> @@ -1852,7 +1853,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		 */
>   		if (id->flbas & NVME_NS_FLBAS_META_EXT)
>   			ns->features |= NVME_NS_EXT_LBAS;

we can check the NVME_MC_EXTENDED_LBA here and WARN_ON_ONCE if there is 
a spec violation.

> -		else
> +		else if (id->mc & NVME_MC_METADATA_PTR)
>   			ns->features |= NVME_NS_METADATA_SUPPORTED;

same here.

>   	}
>   }

