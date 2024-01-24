Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB76C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/60vc7VGbHXMynQ7QFhV6hNe/wK047pqjiKonqRvWM=; b=tzESbqDJti4asA6s+hT5b5G9+S
	nILBUFzcSUckJ6Yv9r/JTSjvgLhTC5D/8aeuZciLZI12jDDM3dEnNfVow0vcLRB3RZuvd+5sO1WAI
	0X9RHuVPbBNJsVDXqKRwv0XP7cK8cn/WCY7UhWLoS8JQvNk3P3hMeGbZIV+OA9QxghIe/s+5i5MF/
	k+T4r9ncOWmhyYiPpYE5IgcV6gRIyCtZd3bYVJr85/NDKvUt5TjwHGJs0lcv+Nj1UfXDEcabo0DdN
	yl3cumIv/POTI02XVRds3RD9bO6vey/GopzybHjSTxyVDtWmFm/W1GlvjCt/E+JiojViGALTePofL
	BC0zwkSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSdLv-003TaQ-2R;
	Wed, 24 Jan 2024 13:31:39 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSdLt-003TZK-2D
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 13:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfzU4OEx20jgYX0Ppzlhy9sNktaTzcSdUt6MOHDYwhpTnV3OliT7j+cRYUEj1RaarU4QRgQ9XS6uZjfaO7rsTG46bkh2ZCf36ymS5P66z4++Qf0diTmEYBK2FcNx0m/ysetUOpxpBS89N2NsGz4/d9V8WjuPMMIF4JZCafKaQcHep/pgZaZjucEYCEoxp7dBELqnvNQqsYiMNk3qN0e4IlneUBw5FGZbkQglXvyPfVKNCXEzKuc001uusjxP7zJFnJ2Wqd4oxKdCBoHTatSYrwk+DPs5Fq1MHHacjEoTQupVty9ItkqwzbutV8Jv0NyeFxSJqV8Bj+3JjmARUkoq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/60vc7VGbHXMynQ7QFhV6hNe/wK047pqjiKonqRvWM=;
 b=lDy7JCIi6dwUNjuBMzXVgSTp+/mqQBMFRGX9op+8E8MYYwFokFvcVwme2351rLq/+USYyCSgaxPubeVkQ3T2XlRqfSzrCuc+TAO8o62Jb2TFrMA0sx6Zk3uZDwmGMV14iefLNb5NREYaxPavgrYMYoWt3OyzJNZ303+0oMh8MWCZbYzOI3mACD180HxNXILs5C9EE6rkhflZPrKo7zvt4pS2X3y+/j1+DEMAGrqYRhUIQ7A8S9gk7QchGUbCgbYzfOWXY6iG/665HiLb05PzOMV2Wt09S9ipnmVZAaJPqgzmyLlkuGYc+a5OLJiDCQbnjVWRK+OO7JxV8ceXnYdFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/60vc7VGbHXMynQ7QFhV6hNe/wK047pqjiKonqRvWM=;
 b=JnDbDeLKjxvaa2I0n62TVwNNE6H7EUh4jjZW/SfjCSQDqRh1NkhtobwY/N5d36+hsiDOXT4D/hWVwpYd+NqePOXiooFGo/cLjIfzOnTjBoaKbpDyTVvozmGwtfBS8CAY+nYBNPNOjD3Y3p/71Ev+16ITW/em3XMicfTvo98+mIYiqaBCft9KqCSnfHLlCRzRpJUjxDEwCrt25ZL1+hCcQ8jF7YvaKnLKG8SvVj6Lny6ECnItJr8+vXpqk7SOwEPK6nNy7sSWuu/VIfWcWokyLaoAk+pg7/TfyTh80fpRCHfQXLY0Yukf8HiFF9MgbAFDeNNtxWcgA2uVh4Uf1TthEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 13:17:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 13:17:17 +0000
Message-ID: <b5910af5-2978-47d7-a312-830398c1402f@nvidia.com>
Date: Wed, 24 Jan 2024 15:17:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com>
 <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
 <60f3e0d6-1fce-4f88-84f1-154a5cde4f7f@nvidia.com>
 <42fcd973-223a-4753-8b53-b4aa0b97f414@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <42fcd973-223a-4753-8b53-b4aa0b97f414@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: c4040a5a-6c2d-45b3-9a51-08dc1cdec982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oyb38ghFx8v+cWPo9HYveQ68D8J3/kD05/xS8Sw7aAjmGuPDRuJaQbyXv2kUlmaUN2PxBVwiP71wYd7AlR6lTTL9gpcv+BqDCokSjmgvuB1i4MGEFMGD25WhNErWDx7GPREf6p+9ZHxdDMkTZqz/rJMPOTroRvAtVvZK+jpPzdwiW1WvA9aEqL6Tv5TkJg7G+nfIB1vU6xNkInHhF+Iwq1pjWzC1eQPyugzcWMAtpAX7QQPxfLcS2PGCG7MfECezmdk9jYSMyz+2htuCznZA+QEMrOLSXxL1uhMJomUPIVbrXmBBhMkciY0fjKtdocfmIYYzIg91SNQb2GKFw1HzwLaP2eif5WDkUgSoRam1QNtx9N36g/NQow9RzKhK9ZTerJF4+MhwHEfZtwAjKmCUH8PPVfxvZccpep8tf8VJTGrhQq/w0IqULv1TtqzpfNXlBGHK3xquir4vyFlJm8VrAXcXn8YzhaDrW9oyJNqKiDK8mbOltPo0+XeYSWywxWNpAJ68YaIqQtRzOjzaZjpyU0UPRiOXHh6GcL+bjSadvSY5usJjhafMMGHs1muezXrWiUdWL5v5DdwKsMOjOprAOiR91/gK44vkbez18X/XefGzsQuJ462WuKPK4AmFShWj5PYq69bL0u0hMhZuelzgpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(66476007)(316002)(66946007)(66556008)(478600001)(38100700002)(6486002)(107886003)(2616005)(6666004)(53546011)(6506007)(8936002)(4326008)(8676002)(5660300002)(31686004)(83380400001)(26005)(2906002)(4744005)(31696002)(86362001)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2UrU0pmVEhUc1duUnA0dWdmSzRjUnNTMmcxQXQ5YzkrY2FzdVhTWGtLcDQ1?=
 =?utf-8?B?dWxSZEZhVlU5ZmM4VU9RdUpYLzlvT0VZdjBjMVIwU0RPWUN2ZFo1T1l3RVNI?=
 =?utf-8?B?SEIya295NjVaMjVxTFVyODVtSm5TUDdCZFBKK2I1WXc2c20zWWlybVFFMERo?=
 =?utf-8?B?Lys1UzFzYUNWbHNtZjY5TXdDSU4yTXFXemt3Um1HdGV4N3h6anFxM1psc0RV?=
 =?utf-8?B?RGhwZklpNWZ0ampreG1jWlppZXQ5QkVIczExZDVTdmV3VUYyU3JJcWJPNDVE?=
 =?utf-8?B?anFXTGVXUWo5TnYvUFoyK1NkeUNRTVJjdFJaUk12c05NbU1ZdkpvZzh2VWxC?=
 =?utf-8?B?dWVvSVQ2S2FweWF2UUlkY092RG1OZlBQMWtsNGNONlFhcFNERXVrY01hODdj?=
 =?utf-8?B?ZGJCajM5M1dxVWxZaHp5UVNrMnBzK2E0bVB1YmtZVjFSN1ZEWit6N1hBSUJ0?=
 =?utf-8?B?YVdrZFVzUDErZ292STRSbkQ4R0FBMitMZ2I2YXliWDhGSmpMS3JPTERPRGtw?=
 =?utf-8?B?TCt3VVkrVWdUeUNwaW54T3pvZ3FkVGtTSW1UQXlZY3ozNWppdFovemNBVEU4?=
 =?utf-8?B?OU5HS2JScElCbFhRUWFsSTVBS1pxYWNkd1l3UTdkempJV0lzd3dIZy82bjJn?=
 =?utf-8?B?YTRoRjBReGtOWWJwYTdhSVVwZGtETHdRUnlJMEJUajViUHFKTVJWN2hzNkhw?=
 =?utf-8?B?ckVDaldhYnoxc1NoM3RzVzdTMlRuWW1TdVdMM3grYWQwYmVFZkFDZ09CZXdF?=
 =?utf-8?B?K3ZHNGphbGpGeGNwTy9BMDlYUnFRRXhsV0p1aG45c09DcDRPbHlrUkJBZ3NZ?=
 =?utf-8?B?NWd6bHRqbkFlNTRCRjV1c1g5aFZVL2IrcDV6aXZ5NlU4bWZma1hkemlsZDZL?=
 =?utf-8?B?Vm44R3lRT3ZBcGdtaXpqZW9mbjNLQWFOa1hVaDlFdXVtR3E1OFlGaHA2ZlJ3?=
 =?utf-8?B?bTAxQTloaGlDVm54c2pWVTR0MTBZdlRIUVQ5V2pmaS9wMzQ0UTBLZ3JnRlZY?=
 =?utf-8?B?TnZZU2Z0Z3Y0cUxHWkhoYis0WTJjR3lrRVp0S1BJVmdMcXZybGcrYmFuRlhj?=
 =?utf-8?B?TFlQRzRVT0ZuT3hwVXVpTDhYRXN2M2xvR3liVGN1TjFXc21nRDhtc1BrVnMw?=
 =?utf-8?B?QmFBZW13ZHd4Vnl3dTFiZGxUQVlPQWoxK2loSDhpT1BUMFRUM1VTa2VGWVNL?=
 =?utf-8?B?V3NSVm9FWmtkNVJ4SzVObE1XU0o4RnBjK2ZYZ1hFdDV4aUt1ZXA5bTc2RWdJ?=
 =?utf-8?B?U2huZlR2T1J5Q3N5QkN3ZEI3ZmhzbEV0MWlqRTlKcWJsQ1ZNUVhWdldKc2tW?=
 =?utf-8?B?YzY1UENjWlZYSy9VK0MxemVmWk42bW04U25UaTVkRHBnWUdnbEc4TU5oK3pD?=
 =?utf-8?B?MFFZbUNERGpYZkxGNmtlMk5sc2pMMkFYczliQk5wRkQxemE4ajNReVNsYmFs?=
 =?utf-8?B?aWF4TmExd1hScHZUVmo5a3pYaENxMDRnWUlBOVRaekM5VFFXUGV4TWlWS2h3?=
 =?utf-8?B?d0wxV3VSS05GSlJmNFBJOHdzNnl2RHdBRitMaG1ZK1JmL0lwbnpWaDRaZ0RH?=
 =?utf-8?B?NUpTejhxdzkvaDUrOVNOcVdKZmVRdnRYRWpsMXNpaS9DcHo3S3l1SUNRTnpY?=
 =?utf-8?B?aGVnbUNRYys3Rk1YQnBSY2V4Q3hRUC9VR2I1SVJXdlp1MzJxaWtkakxlTGFy?=
 =?utf-8?B?VDVreXRZa2RpUHN6aVk3Z3I0bllETUpzcXowZnNrK003dFJqMXFRVklPM20x?=
 =?utf-8?B?VGN0Wnl6dDRIQ0t4ZGV1cnV3ODVWUFFzbTBCRjJDMlhzNjRvZithWVM2TmJn?=
 =?utf-8?B?aTdBdlJJeFpsK3dZWlhYN21DK3VBZkFHQUE3ZnJPRTJvMVVNdENmUTAxVVJq?=
 =?utf-8?B?bG95YktlN09BM2ZYcmZxMExLejMrRm5kYVZuZVlZRWZ6Z08xZGZ4cGtXMUR6?=
 =?utf-8?B?bk9tdG8xclpQdHJldzE0UDVQM05GSFZMeGdMR1VOWlp1NW9hV2dFUUtWVGE0?=
 =?utf-8?B?NFQrRHdYUzRpby9hRVRXbWVDYjcxcUJycnR3aUl1ZDFpOGFNKzdjM3lvNnkv?=
 =?utf-8?B?Rm8zSG53ajEyMWM3WDc1QmpBOUVOQ1FtR0xvblpnM1FnT3UxVWZBaHNZK1A0?=
 =?utf-8?B?TXQyTGlSblg4YjlmS3YrVWJXOUUreEdMNWpZeXlpSFdoT2s4akdwSUw3RHRk?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4040a5a-6c2d-45b3-9a51-08dc1cdec982
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:17:17.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH3veaev5Z7EbguKltqmpMCUiRPsPzQF+UcduaVxGmO6ZX+dOVRnmo78SD3ZGAxFxR6D/OTHsHJOKAyEyY1KXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_053137_728058_5D9CDE34 
X-CRM114-Status: UNSURE (   6.42  )
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



On 24/01/2024 15:10, Sagi Grimberg wrote:
> 
>>>> @@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>>>           nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>>>>       if (ctrl->queue_count > 1) {
>>>> -        nvme_queue_scan(ctrl);
>>>> +        nvme_queue_scan_sync(ctrl);
>>>>           nvme_unquiesce_io_queues(ctrl);
>>>>           nvme_mpath_update(ctrl);
>>>> +        nvme_kick_requeue_lists(ctrl);
>>>>       }
>>>
>>> I really don't think its a good idea to block ctrl start
>>> like that.
>>
>> like how ? scan_sync ?
> 
> Yes

why not ? this is control path..
we have to make sure we issue commands to a validated namespace.

