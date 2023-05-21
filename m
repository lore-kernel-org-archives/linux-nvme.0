Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19436C7EE23
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9XtrTONuSnpHQtLafTTnakYO9cr2WmIx7nUXvKp4nY=; b=WAoJHBHgjULjoBuPiNo2R4Uqb3
	Dk8oNJweSt93l5EOsevP7N0ACNnt619hgDJKcO34uxKKSAt8zuNxkWgw7L4kobmwZAgrOC8X0P70E
	cy0isO5hm9uStlL/cL3xnVQ+ruj46MN11EajlnIB2kc3NV6YYJH9zsDfMfAjYyrjwI2ReM4u2Tw8t
	7y5y7FUJpTxNv2bseqA5ZXrkO/rmjiLDzYs+Qx7dpLm2O84OGvd5AL+BlE4ecwf2s4MkpNfe47bD2
	5BowJc5RNRGMs0NdBuLYQsiRE8ombhGHVutnE3KETIZt7J3nYSSrpTfjRMglcy/G4ULPFRrh0L0Tm
	KUHFKoTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0foT-003XlT-2s;
	Sun, 21 May 2023 09:57:17 +0000
Received: from mail-co1nam11on2061f.outbound.protection.outlook.com ([2a01:111:f400:7eab::61f] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0foO-003Xkn-0X
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 09:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O83wODwOIefjbXqFcQZBTCQK30X1GwfBSNN8DHB8uhJAhIS0W23bKDk+ik90ICj1cVGSd9bcEluOunO6ekmFenfWyqlMe8thBPRQAWPs5T6a7PiwaBOCA0E5ueu+sCHYJcuZVC/Fzl8uc7m/zOG01TgrILAKyP0OvMG+SNcE2h1eQN5RsOmXN7UrCr6k48uWVKJ1W4BpfFtc406ZJNQjYU0i/1ps5EzlpLPitzBhGWUb6MEHcTEOyhxsFh3I7kBXMqHMPBf/jtuU3NbDhOhEA4d7SVsUr74TFCBPMsG4YF0vdJ1yxjpjSUVZesH/b2zf7qgUOgSGc5D5Oah44sBfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9XtrTONuSnpHQtLafTTnakYO9cr2WmIx7nUXvKp4nY=;
 b=TJpKzSgRGLMiap+9G39+29XrfdxDVvvuM+TtpXg18EBSqfspWuyX0ybajJKV0f/BKklY+c4viyvfkWFpX+/lf486NBTQZ13uYSe7Nb6sD/LxYHXeGjANNBuuCf5Z5P0nZtTQ9TX4WxHqKcG8zUF9i/VlRhAhCPtik1r6/srcAl3iSDfpj21Q32FpE5/HUpKKpJjT3JvSucg3qvir0ef43K/5GL+UphWiTyYzzdlDZh7KRPCWo8cUTEWUX96lkd5BHVQxQVu72/uQ6I8PUShuR87ZzZXLrY4c09DVKFM1/J4Jwxj0sydhTTHot3N8mpyF0IpkqJrxnPNP9kL1AYeAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9XtrTONuSnpHQtLafTTnakYO9cr2WmIx7nUXvKp4nY=;
 b=ZgJLtKs2/DCwowvA9SMY1hCw3qTmwdzNj4Yo+vbooVF7u7lQhy+qKP6UMLPIcovazDKJM5Tl3h7VqRJcDjI3cSEO81NzUhhoHPPjJQhdlcH9XnFuQZk1FFp1ivZrLIw/DXhm8ia9akVYxDRNYvS3jKVy5374IclsJskUarPQM2igL6Tl5OM3sNX23s2VW0hAvM12zrlM78L1/fPrC4TZIeKr58wfK56RnmYXQ2G0ZOIN5yzUjAtcFDcrHlCfQvr+Ex9weUQ/Iu+9IKD/xmQvuPFACL25EOPbb4BfIewBh21MJUNi1Yx7oO8YdprwH8Lq+MI6YcuRjxnKBrKT8jPxZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 09:57:05 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6411.027; Sun, 21 May 2023
 09:57:05 +0000
Message-ID: <2cca5c32-a928-5997-7dd8-31c12869a80b@nvidia.com>
Date: Sun, 21 May 2023 12:56:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] nvme-fcloop: no need to return from void function
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de,
 james.smart@broadcom.com
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <20230519094052.48575-1-kch@nvidia.com>
 <20230519094052.48575-2-kch@nvidia.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230519094052.48575-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f697d1d-01da-4a8c-5021-08db59e1bb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Z5h/YA2GInZHluee8ZkQ6+5XOQ3GoI21eQsw+XS2eki6pT7ioVd7yEJtxT+KUNfIS6TdOu7Z/qetzvoN3HH73/ZIwywUdPWOkbQR7r4UBHPwRghfueNEimjlIe17j3VhhtUqDONLg7CBc3kLDJ5DPzyCFiUjT6IvROC+0V82tBEV28zRhUQ6MgluH5CA9iLMpXMD6F5OeryLaAHbW0Vm3l1/NE6HGSaeQ0aysF2LhOASzeocdf7++nK/stsuNhkGGUpVIeIuY3cT6Z2SXzJVqFg64FPxK973NwU/AUCmYPeJzFosHF3050eS2QG7J8rh/NXUK3ioM14wMEkv5LMaT2TDnroP2QOJ9xJHT6DGztS3eepi5A+16/p+F8kg03hX2sJ2UfI1j/EcEyCB+KIbh+Xj3BaB4jacPuHAMuTblIIdlW1ePcAx82Z8A7mlcaVhr1lDCRV4mQpr93xFTCGM5m4PFkd15gPqRr2BwV+hbAJLvB+g6/Oc7TzukEt150mX4E+FQda165i+GG3T2ahAt8iuJHgxGgBR+sL2HSzPJvXvL342FwgE79x6QZlp3+8RobUNWh+aNQxaE69ZR/Xm4Iab8SC0+2+TGK4H6iNzbsxw2XB94ZJtkxq4OoMq1AAPiXZCSu5ZaZTsaiOiEs98zw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(8676002)(8936002)(5660300002)(83380400001)(186003)(26005)(53546011)(6506007)(6512007)(31696002)(86362001)(2616005)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(4326008)(36756003)(478600001)(4744005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?MlF3clhlKzZnOWtBQUVUL2ZrRnF6cVNQbUgrTVdmUGl1aEMwOHdUWGlzbzJs?=
 =?utf-8?B?TnpMblk2TkRKUmI4QThMS2Z5UHFIL3pnV0ZXemhUMmEvbGs5b0FDMVh1aS9C?=
 =?utf-8?B?ZExWRVJUNFlONjlodVlwRDZ0Z2o0R0c2NkJhekRXSDRBQ1hISFFtTmFScjlI?=
 =?utf-8?B?eXRYZHBtT25hWnBXbVUreC94MEJFVGluYUNXNDVMMzA5dmdKdGJPMXYyaXAy?=
 =?utf-8?B?aWxQR0tCVEZzZ2syMSszWXNPVWZHaVNwWVRYQTgxazlLN0pQSE5YdGxuNFIv?=
 =?utf-8?B?UEtLanRLRis5SGRVeWVldC92dkhuUEZzd0laWUJZZ3lkdGZxT1RLY3hQR3lZ?=
 =?utf-8?B?b2hZbnB4WFUzYk5LUGpWaVBmWjRhK0lMUldhY1ZFNWNGSUdWTTJXTlhaVzkx?=
 =?utf-8?B?MFR5aUdQQW10aWN0Nndwa0tkYjdZaDFPTktqSnB4SUtIMG56cGNXbUd4dWtj?=
 =?utf-8?B?RzFQUWNSaG5EYzRjbmthYTg1OWFmMnhYVUd6WTZXYUtPcUdBWjRPVWw5YmRC?=
 =?utf-8?B?RnIxQjhxSmpCUldxS3BsQVVvT0VCZGZrMWtEbTFiM2VlZVFpVWcyRVZKUUR4?=
 =?utf-8?B?ODU5L1BWMllVY0JhVTlEZDhuUklPSTE3TFlkSmFrb0hZeDlHUHhxZGlMeEdk?=
 =?utf-8?B?RXBzb0JpcHEwRHRXRlBVUGYxMXRBS0I1QVVFVytxd2VWdmNPUmRSQ1dhaHVR?=
 =?utf-8?B?a2tYMnk2QUtWaEpRUlNlWjNJYTJ3ZFZJM1dCd3RNTWVmRlh0TEh1Q3pZQ2Nr?=
 =?utf-8?B?WTVWRXg1RVp3eEJ1OHo1SkxkbWN5UC9MaUVHaXB4bHlrd1ZvTTBmS0JKZ01R?=
 =?utf-8?B?MmoraVhENGVyRzBWcGFPL2diNFlGYS8vTW9CM3BwV1I3d1l4UlVrT3lhcHNs?=
 =?utf-8?B?R05lelJQUkhBMWxPUWZ1VXBoTlBCUmIzcmk4eTFWYTJtRHIvODB1c3NlWjFn?=
 =?utf-8?B?U3l6OXo3VjVwYWRNTzRmbkRkTGZWTC9yOXhNdWtZc1V4OUtXZzliU3FsajRk?=
 =?utf-8?B?NHNSSFhhSyt6Z2k5L2NIcExKaWdLTW1RNmdiVmZnQkdUeVVhbk01RlRiUFRO?=
 =?utf-8?B?L29HK2p1R3Rtcm0yVE0xRHJzUkVuUWNMNVVjbE5WRVVXREltQ01NR3F3TUdV?=
 =?utf-8?B?c01JL0hZODh0UEt2YzVGQ0dpY2NHcm9LbWd2YnlCcGU1TDVVTDk0dTZiL01K?=
 =?utf-8?B?QVhTQ1IyMUhMYjhzbEFIYXBGTnRGWnRUTytpSis0WlJZU3AxdXJ3ZVBxYVF4?=
 =?utf-8?B?UjhzU0RVUUM4WHYrK0YxQU1EZ21KT1FDREZYNXd2S0ZCUi9SbkRWZGxlOG5a?=
 =?utf-8?B?OXBrdzVLTUd4d0FEWmZFbDlCZU8rVkU1U1BNUDNyblRIb3k1cExwdU5MYzRw?=
 =?utf-8?B?ZFduQW1OQnNYeExHMXRkdWdldGt6dTVNK1pXS2NYTi9RZFpxVzBRdnFycFp0?=
 =?utf-8?B?SWJRV1AvZ2tMZ1A3L1dkeW9iSUNzY25ZSDFIUHgrTjd2bDByR25xd055OTlB?=
 =?utf-8?B?TzFzbDdpS0ZDYXFNa1NBQUZXUDVEdmx0YnJ1MnhNR2FHbCtMMG9YVWR5Skxu?=
 =?utf-8?B?RzZqc0d4R2sxZmVxMlk5bzJJRE02TitPYWNwa2NzSFNUVHlvWFk0SVRicURh?=
 =?utf-8?B?OVpFREV4RWd3NUc4UXM4bE04dUN1TFRmQnZPb25mb2RBT3ByZGVzYXhzWW9h?=
 =?utf-8?B?bHdmS3FUdnpvelYwS1R4cUc0cUlLSHpxZS84a0hIalVmR200Nko1QlNQNkJI?=
 =?utf-8?B?b1BZT0RLMk13dWY2cXRKOHFWSnVRZVdRTEhqL2QrQWdpaFh2WGlTNFUxMEJy?=
 =?utf-8?B?TVpleHB1blRXQUptNHJ4Q0toWGUyQ1lTTmJSYzZGSVBJY3dLSE42NEN2Yk5a?=
 =?utf-8?B?Y2pjTmMxTGxPdExxcUVMdWo5VVBsdWczMThDQUZxczRJbHZhQUZwYXNKTDE4?=
 =?utf-8?B?b0R1UWFIZ2JiendpWHFLdmNsVWt4aVIvQ3RZMlZETzV0NDV3WE5HTTZFaERN?=
 =?utf-8?B?WVowVUJKODlLenZMbmpLNC9HRi9VbzJjUFlhZXZSSzlVYmdVaCs5S3ZaRG9I?=
 =?utf-8?B?WkVlNldWYzRSYjJYaVlTY09XRmNUc1dyOTlaeENVQWxWNU0rT1ZCY2lSbXAw?=
 =?utf-8?Q?3Ue0yzFsV39L0LVwnCgw/1a3P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f697d1d-01da-4a8c-5021-08db59e1bb8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 09:57:05.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8hX0xiX1OL+IKFQ7l19cBbicjgp/z6Xpy+PiK7Y/RdJHzRUK0kyex9J6AS7ttAwjsbSMnrE8B6JWZHpubTtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_025712_207501_5C187145 
X-CRM114-Status: GOOD (  11.49  )
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

Hi CK,

On 19/05/2023 12:40, Chaitanya Kulkarni wrote:
> Remove return at the end of void function.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/fcloop.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index e940a7d37a9d..1ab3d900f2bf 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -645,8 +645,6 @@ fcloop_fcp_recv_work(struct work_struct *work)
>   	}
>   	if (ret)
>   		fcloop_call_host_done(fcpreq, tfcp_req, ret);
> -
> -	return;
>   }
>   
>   static void

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


BTW, are patches 1/2 and 2/2 related to each other ?
Can you split between them please if not related.

