Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9568C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2Dc9bL1aqDEmy+B5DfrC0bnnDFyM0EJACZOHlChTDA=; b=b1XlMAL7d1pUnhwAWs60DLf0WJ
	3QI+wEAbOhBMREbktbw1suhub3RRS5cMFCA7e4klbu4RhXgcZCc147E1L2CI4jKN9hB+eSisyp7N/
	caKdO0rPI7quC2bWkRQVY3Xn8t4Hi+O/qyA8B2oGtFl5gEbU/q+4hCSgbMuyYGEfBw+ZgYEai+Ajy
	4sUxOeU2lR9vpI6Edk8KSx/tT4obWKpzP/xvefRhoF2Sm4RwmSiBQWUgtY0Oo3qYMgdQcIrd05m8m
	jSS5dhxYmx1CG2SxY7kUgozpyuiJhlIIDTFH7ZQiLjw3HnzfmQ9uJ/zwlPhvWPGUpCJ5+0+heC3iL
	Z+wRiS2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps0nu-006Y3N-1C;
	Thu, 27 Apr 2023 12:32:54 +0000
Received: from mail-bn8nam12on20616.outbound.protection.outlook.com ([2a01:111:f400:fe5b::616] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps0nr-006Y30-21
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 12:32:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MItS9inSxWEpFXMl1Og4A+gELcS4NCNYnRPo/X+ZeypBed0S+zmdtwtf3PYZZgG3Dc0e+cF5vv7c4BItIx5naLCdowNY2IkniS8orykEBIFhC+H4wtuxjAwEW5T1xsYsYB327zevOJMRwbqXG30KkMIEpl7GLjGZY0vIjFKVTzs+ZLzWgMlRV4VZJTwhSS7X9hkXl/aIKO/MWDrVAkySdk5C840Qo/orZ/dRH9ag7UrAOjnvUkBzerjFsDme3duGw1ifoe8LHXX79i7JAi68PYNmJxDDP7uv33bCq8skyS2A/0Xy+NY2WDvXH/H8aRgwM4AByRfGzMnGVXWZ8r4Rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2Dc9bL1aqDEmy+B5DfrC0bnnDFyM0EJACZOHlChTDA=;
 b=kmk+0ch/7CMAQ+Y0DiX9XhfGiNUq81JyVlByRjZGH81zNPTlyQbELjuiNTwk4Atcrp3XAThhWEBChwq168fOk5EC6bbQVv1udrceT7OSm8b3gp7XGvNKiEThlJeEldKWlvEjVMHWOZ8uA305eha3drPLyMFgnTqljY9jLOz6Iuz65g6Dggn047PFKkWZGJBWSF1tIJlcxB3wJ4UtS5DZZggo/UhfRInd4NBmGbIU7fIsj5d/HcFBuOL2+5mhklH5tnG2hdbyXv+93fyjtATg9X+5GzDcINJe0wkpCwlMHUb5mlW3O9Y9SgoX+jZAVlS6VLDah/k4eccD5WMjfz1KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2Dc9bL1aqDEmy+B5DfrC0bnnDFyM0EJACZOHlChTDA=;
 b=IIczweGRq1NdHnrL1DszyRMJKBfADmLO7x8nwyhFzrnoOA/b8z8SiY7PGgIfo2iC/nM1x5czkGCSLVWGEoZvh+3gpUk5prrWVwmxBeyLcfCMWehnEO5F8d0LGKXldfgYLgsOn6UtEVtEw/M9Q1MXbtJPYx+QvPxyew7dRgDQxud5Lk4B3b2P1KL32sw9357jo6z3AeBx2HvuFiJtxFXbxJwZ7lPfN64Cj/OaXzH0xEKc41ks+RmA/QTWJ/wjfTxT+99kwoHIE4rDPA/c7wQqqy+sauhN3BcRlUyKh/u/wEaMaIJm6UwlNMvhofeYVcphlL/ZHnxQRt0GbZVDzIa+rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 12:32:47 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 12:32:47 +0000
Message-ID: <bc3aac8e-d505-9737-f83f-e797801b856f@nvidia.com>
Date: Thu, 27 Apr 2023 15:32:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] nvme-core: fix memory leak in dhchap_secret_store
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20230427080456.18232-1-kch@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230427080456.18232-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe5b85a-67ce-419b-7446-08db471b8200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	DCWmuGHLS205bLSCxuEWHm+7bDZSWmOQoc46NA0Oa4xodJwpc5pemT0P5S90O9jXPJNMspeWmg5wczu7PsE8kY6dnqTkulFr2S0z48HYcytDE2wyvhJnd3zdKJZ1pcarkxIy98BnR5MOtAOr+mdBAb4g0s5vnZoQJShuT599CPCpopo1vEJ1XBOmtlGlWW8oQXTbj9kdx7diQA7MnUQ1my1VrAAuILrLG7lyYZiajSs+KEpIUqh7F2rlRD8eOtwIOmnTkJsRp+hVPalJNw+JNEm3VGQWTVs44sWVtcAbxdkXxPkRIHrsKbQ0NT5K4/JlXylVb7yvRFx3t4FkVbJGbvdJQ4Szk+AUidjcXW++5g+TX8o8fFebyXz8yCxl1QDBVow5sm0oKICFyy7S9xoQI4zBUJaKDp1w+SwfoVUbnxC2YV5cr6QqWqDLer4QiT/kmMFT3X2f83k0dgIUgAtqRjhR2oK7Dx5u0vgfKgzJt8FnXN/hVkcYtgDr8jgSTs9srfjWBkRkiwqa+GCHydj5d9pijhkwl9UdIkw89f22e49RoM2C39OyOdhjgMyWXXEa9/jBw99fidtmds3jLe3Gc00pNlQKwLpBbdY76Bmf609FTlpKZun1TAKGMlhvGqLuPVDUVurlsHonelr7nWDDkg45bdS7Bcpb7Z3+8xlhM88=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(316002)(38100700002)(8936002)(8676002)(478600001)(41300700001)(31696002)(2906002)(4744005)(6486002)(6666004)(86362001)(4326008)(66556008)(66476007)(83380400001)(66946007)(5660300002)(31686004)(26005)(53546011)(2616005)(6512007)(6506007)(36756003)(186003)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?aVBpRm5tUXFRTXBiT1M1eE9HczR4cTdjUWJ1dzl4b2pQbDhqUTJockRiVmZI?=
 =?utf-8?B?ZTBHOWk1dTB3L0VPQ3poZmxQZElmS2xBVWxEeGZROGpvaVVlNGdsK2tacDkv?=
 =?utf-8?B?UFdjRWFpdkl6SVZSM2R1OG5RdGZsMlpNcUdxQXdLMW5VbS9BbjJTZks0K1k4?=
 =?utf-8?B?bHRwME8xSDdLSmI3V0s3OGpMbjNSSjhxRVhxQ241NGYxOUo3R1BlbFZrS1BE?=
 =?utf-8?B?aytXenJ4ZmJTNHdjdisvQ08yWDNMck5ETGZLelRoSXhEekpPWEZQTVB3eTdN?=
 =?utf-8?B?cDVlN0tiWExaUGRnbTI4OWY4dEVjRjU2VUdXalBYR0FNK1M1ZUFjRWczSmgx?=
 =?utf-8?B?dHhKTG5nTnd1aGZWRW0zWFJKL0ZWRTRKRHJIeUZoTUFVYlpDelp2MHBGYlZS?=
 =?utf-8?B?aTNnNDNjNFl0bklJUW5PTGNJS0dycElLZitvb2ZtNEJmOVdBVGZ3eEZSeElv?=
 =?utf-8?B?dkEzb3ViSzlZcTBHTUEwQnhkaUJLZ2VKUGRmTmNhMHk3SXRjbkdRTmpsMFNQ?=
 =?utf-8?B?Nk1yVzY5VHdnSVg1UHNpSjVRaDRzb05NbEdqWXNySTB5c1BWb1ErMG1DdWU4?=
 =?utf-8?B?V0xYVDVWS0VrSjRYemg5amVRamx0cGYyekxuQXUrN1Rocmd4NVhJdU9YdWFh?=
 =?utf-8?B?bGtycThycEdsSUIveFIzb0xLY0FSOGxiMjhLTGJzRXQrbSs4Y0c1Z0o4M3Rk?=
 =?utf-8?B?Vis0ekdlenBGME5zQXZ4a3FGb1prZVVvdHlzSmx0bXNXZk5qSUdmWVpLb3VI?=
 =?utf-8?B?VzhJNmFBUzRIdGtuK3dLYStTYXpwejFOcE9GR1h4UldsSXRXU2tVNGdTaUlK?=
 =?utf-8?B?YUFGY2Nod0ZtaGFORUhtanNyY1BVZE5kZTBLbW50ZVhTcFZBR0tLcUVOeWh6?=
 =?utf-8?B?VHhpWitYQlFITFc3TE9ObWhNcUJ4Q3hFaUdVeTNCbUFVdStQd3NwWDlNSmpP?=
 =?utf-8?B?dzc1TEdHRzZLWER4OWRlOHJleDFrUElpdXZPOUZ3YS90VUFRQ1VLc2Q5QTNV?=
 =?utf-8?B?WWl4WFZlWXUvYTA5QjBoTkFwK0pBRXV4WGdIQXl0NXhQM2Z6RmZwSzRGYlJi?=
 =?utf-8?B?VVcvcXRJYWJnWno0VTZYOU52WXZFM083Qmd0V3dVQ1NFeHUxcWtMZTFVVm95?=
 =?utf-8?B?VWVrMGMyY3BUZDFNWWQyUERLYVFMYWYvcys4bjdPL1lIVEVtQUJpdlU0MVZ3?=
 =?utf-8?B?dEZ4TG5HUDJ0ZEFTOGdLTjVIU3VLQkZ6andNS2tGbTNpdi8xR2gxSHZacGs5?=
 =?utf-8?B?bytsL3ZROWVIRk5Zc0crS1J3bmp3N2Zxdm8zalhrWmV1VStIb1daeXY3NjVW?=
 =?utf-8?B?M29qcWtoNHg2SkNiQXNXRUxDTHFkV0VYZXNJTjEwd3hSNy9xRktHRnY1RUti?=
 =?utf-8?B?dGRDNE02MXBqN012UVh5NlNWM0JLMkdFOVdMQVVkMW9MOWZwOHNia3lIdXZQ?=
 =?utf-8?B?VlVnZXVmVHljeEIvS3phQUtITWYzWEFmTzZaR1Z4WXo4YzRNNU9NanpVd0VP?=
 =?utf-8?B?N2s4QytjbC9ncUFiOUs5YWRHelpaVUhRNjQ2TDgyTHBiWUtUZ2ZhUFpDQ0VM?=
 =?utf-8?B?dUtqeE9rMU5SaHRJSjVzNW41M05WRnhwYmlHL2s0cDh6ZVpYMDM2ZFJUbkdq?=
 =?utf-8?B?MHJIRDBMQ0VsNEl4WDl6c1JlRzdmQTlsQkRRQURoWWN0dWw2bHdVb0dHSzh3?=
 =?utf-8?B?NkVRVnlWbFJzdXg1WkNFbmFUTGhyTnIwZWNNUVc2N2JlYnRhalJBdENpdFVt?=
 =?utf-8?B?NDI5ZDJFeTgrajhoeGpNNm1MeXY3aG5GdGxLNlNZOVBlV1FZR2FCUlBIRjc1?=
 =?utf-8?B?RGRMbzQzTUlaRkNhRjFDQkh4QUM2UGxhUWhmMXpRc3JTM05NL2EySG1qZ3JN?=
 =?utf-8?B?bjV5VTdlbDhFV3dsWWdYMFlCL0RlUGVJWGpWbTVnMGZPRHhXeERiWTY1bGJr?=
 =?utf-8?B?Z3l2L1lCVVRkV2FSYWd6aCtmc28rK2NDbEVhYXRROHgxWE1lVy9JWnozUDVi?=
 =?utf-8?B?bmxTUmxWNXZpa3hoNTl2TDBJYWJ2QWRycUh0MlFRaXo0QkVhNUltcjhKZXlP?=
 =?utf-8?B?bWdtM2phZUg2UlVGVFI0bjhpVTRhTWpmei9lRGw1N2RINFdUWEEzVmJuby9y?=
 =?utf-8?B?Y2swZkVRbHlKbmh0MU5DMW01WEZOaUJRT0lOUEZtUysvZk1sSDFpcEtQKzNR?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe5b85a-67ce-419b-7446-08db471b8200
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 12:32:47.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZfyqa0Ni6o2dhJIQWxTJLDHcQ18sgkYViEsKfZA6QP5EBLqHt1d1cj4w5yCNNFoip1gii+QEreC4WA//e66yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_053251_672404_A42B8801 
X-CRM114-Status: GOOD (  13.61  )
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



On 27/04/2023 11:04, Chaitanya Kulkarni wrote:
> Free dhchap_secret in nvme_ctrl_dhchap_secret_store() before we return
> when nvme_auth_generate_key() returns error.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 518c759346f0..5a9d97c0c0c1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3814,8 +3814,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   		int ret;
>   
>   		ret = nvme_auth_generate_key(dhchap_secret, &key);
> -		if (ret)
> +		if (ret) {
> +			kfree(dhchap_secret);
>   			return ret;
> +		}
>   		kfree(opts->dhchap_secret);
>   		opts->dhchap_secret = dhchap_secret;
>   		host_key = ctrl->host_key;

This doesn't solve the leak we have in case strcmp return 0 (also for 
patch 2/2).

Can you please address before sending the next version ?

