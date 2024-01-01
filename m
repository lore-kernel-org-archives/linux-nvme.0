Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB7BC47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 10:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uysJrgqg9Ij4aCnB2H5hMnzY70KYuzUEpJtybqT0H7g=; b=CuC4T4NvcOjMZYdySZ08i3SvLJ
	pCoiFiwSCYpLp1yT0qxSvV/y+KAyfzvWzYQBNtkkom7Ff+fF6o2WlZs4vSEynHM2GJ2ET3B2sLngv
	0pvCDabjTqgJ0YgFwY6H1dJLXNQChiHBbj1ZhCxxaCXn5IcxkIXfNG4iv/UYMG/FAXrq8Mi/ff2oB
	hUBE7MwhAHkkG89+kjJSnu8hjFCNLJxTcB1Mcr6fNdvw4FeybT+SlIMx4zZEn+HANc5p29CYVcDpP
	eSfixQtKYH39GSJ/OLf5r14KzlMGV/lUncJqMZh8ep/N2vWveKdJ6sKOVYTd+gNXB22ssk5aJXqYu
	exO7CFuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFBh-005sY7-1i;
	Mon, 01 Jan 2024 10:06:25 +0000
Received: from mail-dm6nam12on2062e.outbound.protection.outlook.com ([2a01:111:f400:fe59::62e] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFBf-005sXq-1O
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 10:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9+OObmpYN/ECgdDPvgr4ioYB/rFK37DZd+OFEeSHnXAhB9Q7alMG3WgIX1y6HS8trsTDf7Kga6bXvv882rJ0HOaSKu8ZvheZrD56fZiTYHI9VAHTYccVSNMZfevt/F2MZh8j/Vl4YGaQJDsdSLWEt8HIqYFCjwH1b/cCL4a1vCMtFkFMR2WCUnkyL3/QAQUC2iNcTFwUp8UlEscgmhGvAn1s7YM6k9kgkQwXAGFwt0zseLNWHr9UN64NOpurfC4P2WwJQZacGU6zTvvDbqfhDEUvRmKIXtikm5cFjEr7IIzEZmKmwfu/FbP1Ad0txzk/g7W0wnS484QCMUsMrmRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uysJrgqg9Ij4aCnB2H5hMnzY70KYuzUEpJtybqT0H7g=;
 b=RVyiXxBNuEwDaZovf8w0DdZcthbyIcG1tx/zMkiIAty9TmGtPIRWP04ZCx2KpX9m1lHWfpAsbGf5D5fmOHKxjoo2xl9IwiOtvyhZf7eQ1n/xtPIlFJTqYvZ46ceC1HhhFcqMssR+HbhBuFcafaQ7D9mFZsgcF5IsznimYp7G3wev7US8sOOGWEWuRXYm0DahM7DxMLa2s8nYwQlx0YdW9JNkgB1WnWemkdcVXwyLDY4V5egD3iVp32o2NXOCukFUAmK5/lMHwIqxFYVFYskLL6TvuIrfcjWFsFisuZfpBPqVh1PwLYBuOSQspx928T0RD+CMRyEOol/ytzIBvCRvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uysJrgqg9Ij4aCnB2H5hMnzY70KYuzUEpJtybqT0H7g=;
 b=gOWos4XK7suOCsLdW9cU5r5TPUoP4gbwUk8YDQpW37NeD5rSuvf/Q3bpZyTyk+8gG/Wcc6YF73JjdWDMkVBYWEFPeY+1hKfihaH4jvJ4jUkwXhRbLmldgKbSdN+8PNkOqeQyLIRqwZRsOU0p16MEb2ZLaBaK2YCoXsHfr9CXKjsxdXLDF0OeoAG9D6pva65rDhnlUe86szwdSTtudEACTgUOApXbfvvaXTV7BQ/QgMhLwPOnFkG7NqTaI3EYNbKcBR/YirGAiHzZLX/CbKRqhKDE19RNNVCqDDqLbvZCegah+EFeo/6JNNhelAWFHIqBhEB0g8dOWcrVH1W/rqtGLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 10:06:18 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 10:06:18 +0000
Message-ID: <24453b86-800e-4a92-b78b-5fe7d92a9c8f@nvidia.com>
Date: Mon, 1 Jan 2024 12:06:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] nvme-fabrics: move queue size definitions to common
 header
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-4-mgurtovoy@nvidia.com>
 <41e49eb9-24e5-47c8-96a9-12d47cfe3367@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <41e49eb9-24e5-47c8-96a9-12d47cfe3367@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: e36114f8-0e01-4a22-efb4-08dc0ab14bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5mdhosLN+2DmneHpHHKQAjMhwvlp2xIh9WLISww8onCJN3W/A6e92KMzx53VwjVxhPjKOHS8IOnI2S280OnQQoo/rHAaJpF+juXctYMqPwZs6ad4C5orMfnVztj6liQuqDwxpNlK65i1RDxIEnoElI7cCHo3kvTILtU/gV15yIREF1U8Lv4Ad2l7RAkAFhZQOYfjwAH6rd09hZoeoJAOpI7NpW+L8RK2FKHU+g6UL07wHiyOOoUY7U30xaUqiE0/PMElTjycXt7ZSvaLIsu0Zb8NPc+0eY3YIla3G5QFzXAcTS2XLDKoYuHolynN0gbJkk/iFF1Usr8dTwzrd4l35fmHSJaq/KlHoJ5oW10lIkp35s026XGis2RQ9eJ9paIPZbRZMTwO16++XR7LvHrppiJ7o4zFEYXO9w7nAHpVOdu+Td+30/tZRrZVJvonlKYkzVFLT/KliXt2vWa3zjRVWUEjydNrXGohviLnCNeuRM620iyKrAVKjsjncXV0gsDxR/hJXGc49+itwmfqW69e7K8cs9GoXUrxp98PX19/NHvgZLnyz7QYKOAYwUh/1ob+G6ClS2zwt/TUpPyAK/bGK3m2iVNcvOAEnsRS3dd2oBljGzQWBuaXnx3p5IpGh1Z3qcZYnZAkdWsQ0wUFbUQLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(26005)(107886003)(6512007)(6506007)(53546011)(6666004)(478600001)(6486002)(41300700001)(316002)(86362001)(66476007)(66556008)(66946007)(36756003)(4326008)(8936002)(8676002)(31696002)(31686004)(38100700002)(2906002)(4744005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXVlN1EreFdNUmRXT1dtbCs2RGNkNEt2NHVLV1E2eXJpUUlhNEdhem1PanlJ?=
 =?utf-8?B?MVBRMVB6NHhPd25ndUhucTA1TlJLMFVpUWRFR1V5YjRHMHgzL2xOK1haYU02?=
 =?utf-8?B?aCtQSjloV2VoY3QzYWlZYzF3Z1lqODNDUi9NTFhFWW9BVk80MTZZTENYUjc4?=
 =?utf-8?B?YkpEU0t3WExFdkdzQmgycWpSd083dVJYWEJZNU9sb0JtMkZ4WG9qMDdOdlZp?=
 =?utf-8?B?WGdSY2RQbFRzaVlqblFYdGpoV2MrVDBoa2tHOTFtK3ZMZGthMDlHaGE1S3Y2?=
 =?utf-8?B?TFlDMnIzeFdNVURrNXRtV0lQZ25RMTZybUdqU2p6elNIV3dZdHJMV3VnUjlk?=
 =?utf-8?B?eUV4QllLQ3dRK0ZhWitPZnlhNzUyblVncjVVa1BIRnNGQkk0ektaeFcrQWNi?=
 =?utf-8?B?aGh0aVp5cnhpeXl5anhaZVRkRWFKR2hEMVlFaGUwN0ZZWDIxYUdWeUFBUGFB?=
 =?utf-8?B?M3ZSWGljWHpIMElDSlRHb2l2NklacTlvaC95UmluYzNMRzRaMU1NQlgxNHgx?=
 =?utf-8?B?M1krRVp1cDZUNVRzTFpCa25WdklIVXpaSVAxRTRqd2xLbkd0ZG5oV1owOXFS?=
 =?utf-8?B?RVc2anFKaTNGMStKdjJ0SDd2am14bW1XUVMwK2J3MGgxNmJvRS9sT0F3ajlH?=
 =?utf-8?B?YWJnc3dCQWJMbnRiTDRITUUwdGhMNG53WkVoN1M3eVB1YWdIUXhKdUNKSHVE?=
 =?utf-8?B?OERjbk9yam9EU1JKK2NlK1c2S1BQZ0thSm1wMllaV09jV2dRYWY0QTZWZG5v?=
 =?utf-8?B?Mk9VN295aFIva1VZb1FzZnh4Tmg2UFFyaENjcWZQMXFFL1VsYUZZd0pUNWJo?=
 =?utf-8?B?NnpDTEtuZmNzZkdDdHRxdlVheHh3bFh5blc3TmgzaGNGZUxYc2VDZTIwMzNX?=
 =?utf-8?B?amx0Y0hOcnRDTXpxTmFaWHdxeWk0ZHlOeWVUL0NGL2M5UlQrRnVGTjh4bHFt?=
 =?utf-8?B?dkltYVJKUCtIeGRhTzFTOHZXaC9lc1RMSHRYaDUwVkNsY29YZzJKc1czZ3ps?=
 =?utf-8?B?YWcyUStLdXp1SGpaQTJIV21lVVFsNCtLcnFlQ0lZSnZYOGFod1BoSVdxcG1E?=
 =?utf-8?B?UFJuaXRNVzMvdWlaMnF5ZHM3dk5Zb251a2JKS2hXWmdqL2Z4UTA0by9PWE40?=
 =?utf-8?B?c05teVp5MmxDY3FVc2cwczZBZnp0RGZzUDI5Zm1FdkZFeW05TkFrejdSbVNp?=
 =?utf-8?B?a256cGtVeHZOeXFkZHljUUlkMGI0NXprQ2NjUFFXMitCNEd4MVRVOWRiTm1k?=
 =?utf-8?B?MzUybHhubkJuNjM3T0RUOVFtSWtha3FXenFXNTdhRDZ6bEJEcjJnQVhqc3R5?=
 =?utf-8?B?c29PcDg5ZXo5N1kvL3VVZm9WNlhHcVlQOE10NHVsWGk4RWJQNGVQUkxSUFRo?=
 =?utf-8?B?VkJzUjhHNGJUaTNlZDBvMS85SjVLRjFoVU5MYlZxY3pRR3BuZnFUV2VkZmky?=
 =?utf-8?B?VHdwK1FUZDJOOVRRZzZWV1lhMHd5YWE2dTFmNmJYZnBmU0NFbThMWnJOb29x?=
 =?utf-8?B?RFVZRk51eXVrUUEyZmhEMHBWS2d4aGM1UE84dUtQL3hlZnp2SkNLMWg4WWJz?=
 =?utf-8?B?eHFZdUdKSWpvUndQWllMSGgyZW53SEIvR0gxQzdIcm5PRXJTUktZaUJVYnZS?=
 =?utf-8?B?YkJkWUZmeHZUWi85M3RJOXJLN0dWYlg1c0NUbHppQ3Z6U1FkY0svU01hQkdU?=
 =?utf-8?B?emkxeGx1QUhENXhtZlg5b2N2aWdMS0NPaHMrbFRCWTVSUS9IL3JFVDNYQmJp?=
 =?utf-8?B?aXgrS3dJMlppSWlzTTJFeThVV1lKYTF6RWQ1dHFaUVZ3UENPL01wVTVpK1Ux?=
 =?utf-8?B?TjQ0YzNvUkJ4OGc4aytlWFNwTUFkQ2xiZTVUdUhrV0wwdUFPenE5dGxXNVFr?=
 =?utf-8?B?aS9aaEZwdXp3dWxzY2pSQUxDNk1WTnJMMy9FbVlaTTZBSHpVUmJMQVg3SFdn?=
 =?utf-8?B?blV1U2tMK0tia0VkVjRjZkRiYmlGaStZS1VGdWJEUW9KUG9wSkN2K1k4ZXR0?=
 =?utf-8?B?VjFkMTFqeEdnS0tEZkU2bkxEaEJPdm83ZG9kRXAzN3lYblFhL1hiamFpN3pu?=
 =?utf-8?B?VWUvMk1FbUh5bTJvOVN5SWNnQkRMMGpCVWllUzRTeXdjUGZ3R3N5QkVzNmRj?=
 =?utf-8?Q?ZN/jBU+NwpzqA/Q/3/+3f8dzw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36114f8-0e01-4a22-efb4-08dc0ab14bd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 10:06:18.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoZAiYenE55TOQc07dTsIgjpfsnBeOEYM7XpAL2qTATa8RaEqZvzvLgtdWgjkQ72NGhTdFdv2uCA89uYrY91Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_020623_477582_ECDC018C 
X-CRM114-Status: UNSURE (   8.93  )
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



On 01/01/2024 11:27, Sagi Grimberg wrote:
> 
>> These definitions will be used by host and target fabrics drivers. Move
>> them to a common place.
> 
> Don't see why these should in any way be common.

why not ?
why should we define these values separately for hosts and targets ?

> 
>>
>> In the future we can introduce a common nvme-fabrics header to ease on
>> the maintenance of the global nvme.h header.
> 
> nvme.h is the wrong place IMO.

I've mentioned that it will be better to create 
include/linux/nvme-fabrics.h file for common definitions for fabrics 
drivers.
But we can do it incrementally.

