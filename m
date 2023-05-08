Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FC5C77B7F
	for <linux-nvme@archiver.kernel.org>; Mon,  8 May 2023 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zy/hHgU++GdSUhhjSjq9U+W1itPAdgufVpZVtoeUUx4=; b=qyxbOkUHtc6id6uV+7OvWpaU0x
	J8I2GkJ/0kWSFOo9FeT8i+66cWjc85hTKUCFLzEk+8P4hgCLOBBOGtHp3GjGWpslHfUsxCMES7DiH
	cM9LzDaLdhA+5wWEpzeZrIa33SKKkL/16QL+sCmtMkY60MpLWAoF/feUY8VonMjY+C0BpGVd8mZGJ
	RNFl9pASl0lmrY7VkG5PZCvWAVtCrfzWcjyfoH1Ux/a0FO/HThxyC1Qtu5ElglMkLp5bRQXNWdAwe
	FrM16ib/3OZ4mZLOTaXJ/KQx/5AqwfCKzTDL4sO+oEiXLdyFWjJ3c4FMyw66VbjwsFq3tU1I6sVsc
	fSlp1YQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pw3r3-000yok-0z;
	Mon, 08 May 2023 16:36:53 +0000
Received: from mail-bn1nam02on20611.outbound.protection.outlook.com ([2a01:111:f400:7eb2::611] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pw3r0-000yn2-0B
	for linux-nvme@lists.infradead.org;
	Mon, 08 May 2023 16:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry/7U0sBnvOIbc3xgJAT5hAJmpvWmsI9VO3tFM0b6aWG2mwra08XLHulF23FW1EfAelP1vgNP5IH3R5dB1/eLYJ9JQeE2p1L63aHIwBWwWJTRmjCdz8lh5dZJJ0W3CdA3ezBsG2jQrMAfvsPYmOjhrpiPN8bskWbrn+j1ge0GAG/rpHAVyVvXe2qxMX7zHpWsUAd212j4JyOnAkQIK89VobwZhnuv7SAQqV4RpyOfheTgB7k/Pr/yed5/ZW2xmr+lDXV8nVMakbjlW8QAeqxtT0RZIX5+090kBZxjrbdVPxtSZO2G7Rfe3Zrg1wAa62LQmvN3VEXfmz8x2+hp3KyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy/hHgU++GdSUhhjSjq9U+W1itPAdgufVpZVtoeUUx4=;
 b=fX4MBfUEiVbBpS2mqtyUVrhB1aKuQLn4eHZmgi8y9KL7vSGgyyTgTcfnS/H7zMIVuAP3mUCcPH+cK/z0fMRicE7N+d5fYmnyIG6+HPxjfpGPWEh8qi8OgQqoc83bnj6FQiQ1duhLJRwPPOcKYus1hbhx/aKeg8gdlbssS1KPurlZcCMumvBt/4247Y0Poht3sAIxtAnZbtpqajMSCbkv405DkPezE0HMFNTMwww3iMJ7GiawTMuYQFbyLgJpiPa5aW88hwKwJt04YuaBg5RpzJy3qLSDHSVvE9xO2/sTEANwUB2oEcjn43JaEvweTkUPej1jAAVd9PKGwr9ozKVY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy/hHgU++GdSUhhjSjq9U+W1itPAdgufVpZVtoeUUx4=;
 b=Ules+mCguCYfni5MylLDD0dG4lzC9b2rg9mrQFe90omDjjGlBL1gq8/JeFq/rtv45LDOOEWrPPcpZsuY6KI1efXwB8DKQs9Iqj7+uW5H/r2zKGOrhIhQyctTycxyNW2pMfhSSx+1w8lUrpGBmIo3Jh8E7LcPn3zLOHvDaz90BxBx5Dnl+jFwZCCZbH1pgIJvpHL5NqUx+mhmJ3axQRAGq6HzwmXy5sdDki7KY4fGVvbo8hMr/GICkimFl6zFFV44NM5xWLZLVIlvKoqoIJCXbtVTw7MXqY3CexJsbzzGpiEs0Ql7lOlTsWaJvjxKXYLWxrmp4NMWKt3UITz+VGVVYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 16:36:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 16:36:44 +0000
Message-ID: <76dda7eb-55a6-e2fc-677a-05d08de738be@nvidia.com>
Date: Mon, 8 May 2023 19:36:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/17] nvme: add TCP TSAS definitions
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-4-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230419065714.52076-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: e6805cae-0025-4493-0e43-08db4fe26886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	VnSR73WDKQT4nR6KFTqiwYRxe1LizprCPYicyoyVgMh9V84bIDVLh/Pz3+poFeOtZo/bSY9qj3ye9LvaHDHv+YLVD/T3fLaCpOANUvDhzdk4ROUqO7ME7hIO0SWKSlHjLdovhxTUBSHDSostPE46i706UrnA7wt8wayR/9kgxF95Ch7j/gPClcA/oxDBGXxaTEIy88MKCtcy1ApQNLK6AaC5FDhGfukzWIvj+v+VCbzfbXlp5Cr/TwQX1KCcmZXKHaIYEOgJlw0/I88Oym0KmD6/XUHomZUQTbWMEnQ4yW3tHrISI+dQVkT9paXt1dJW/XUksGZY4YhfN54HYM8gYyKeHWcJqXH8S20KG/GEJyfQxM9Mmx7ud6U1ikIK+C7/lQdgikOR7sWEgQjZV92gLSMzmiGoG6v4UpVDLZ7R30GXRRzF7ZNK6WClO6/kRwMqOc06aa9zfRVFZSmE0ECc4SbrvftrcZ71bLHYVYtzPaCi+g5fI8EF/qnlC2Me5CkpMiwBxojsHS4YpW0tbgFLZIItYVNkbpAAdj0kw4AqHQ7EjgZNttmpZLQkqA6SCIRFkb74uQTHr7eRrApTEd/YSIyGM3tBtOc76vW+anDFkPBfO0fIuPM+ohaAc96u7jY2ek+XqXoZVpLwXF0MuZQ6gw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(26005)(6506007)(6512007)(53546011)(6486002)(83380400001)(2616005)(36756003)(38100700002)(86362001)(31696002)(186003)(110136005)(54906003)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(4326008)(66476007)(66946007)(5660300002)(66556008)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?aWllUWlqNHlzSzBhdnRpOU45M1JoMDlROUUzTk9jUkJzbzcyVzdOakcwcS9L?=
 =?utf-8?B?YzRxMmpqUW12MExDRnU3K25YaGE5QkF6SzNqMDVpY1RXZFoySlpHd1ZqaUlQ?=
 =?utf-8?B?M1dZOUJRUE5ydE1uK2VIaEd3UkkxRlZ4ZkMvNVc1RDlCbG9DSGMyVGF1ZkNy?=
 =?utf-8?B?T2R5eE1EOVNoR1BvRTNVSkc4RnBpRW5XTHpHTEsxMk53RjhBUGJwbEJwWUJI?=
 =?utf-8?B?R0hoWkNmNlI5RVZhMld6NGVSUHJldDhiSzd3UlhmSEVmYkxIMkhmMDRTbk1k?=
 =?utf-8?B?bmFnRFRWU0FpQ3ZQeFpNSDBnSDdSYkVPTkc2aXVxTlZxbG1PK1UwNyt2MVp2?=
 =?utf-8?B?dWN6YUdIK0RwdkhjbzFjcTdRVWVIWVpkZ2FJM0EyUCtDMUVmeHhLc1lyZ2ZE?=
 =?utf-8?B?SEVrTVJIWGRFT3RuRDIzNHZqSENVSFdMcEQ0SUZGbS9OODYyekp6LzhreVY4?=
 =?utf-8?B?SzZPUGZjcmQ0NkNlK3RLN01PMFR4TFphZ1hCelRCRGtUUnZXY1QrUjdRN3NI?=
 =?utf-8?B?OFpjRnRDTHVyaWlHRUowQW51ZXpQNkZGdHVCNmd0dFJhR3RqK2swOXN6Q2RV?=
 =?utf-8?B?NE00M2FkMDNrNmVyQXFsV09wMGhWUWpqbks4U3ExK2M2UjJiODdzUGdKTHpv?=
 =?utf-8?B?dWUvbno4Y2VkbDZsRTd0TVV4TEpObG02Z29lak14U1l2TzBBZGdZUElNeXRM?=
 =?utf-8?B?TVVLNW1oNWRPZU5ZTTZXV05UT0UxT0tRdHh4M1Jyc05xL3I4WWZnVWFvby9r?=
 =?utf-8?B?bGN4S1ZHbkZzSTljQm1XSTI3ckxyUllJWGdDOFVZTUphWHl2aG1BTG1kMi9y?=
 =?utf-8?B?US8vOFZjeGlqd2tUaWlpSUNJK2dMZHcrZEYyU0lnR2xka1VMbDg3L29YVWhM?=
 =?utf-8?B?Yk92bnk0WmwrOWw1ekZ3RWtlY3FHNjQ3M1pyWnV6aTczOVFXdkczU0xPaEhm?=
 =?utf-8?B?N0FHTUErZ2VzK01QaEhHeUpQZDluMkJ1ZHExU2s5bVppUklxazNKeG15dlZv?=
 =?utf-8?B?dGhTRW8rUFdNT0Zhb1FUTzREQ1g2QWlLRVlyN04rRFUvdHJlN3VsZ2VsOXlH?=
 =?utf-8?B?d0xmazFFeSs5alpBbmppVVh5dHlMNWM3eWJDRll3TllENmV6bTRLQXFEYmpS?=
 =?utf-8?B?ME8xeG5jT1FMTlppQmNGS05WN0RkYkRCQzlab2VMR1J2b2JLelBPeSsyMnNQ?=
 =?utf-8?B?WEMvZEtrU2NUREwyRHUydE4vYU5aSjIwMlNqUTI2K3o1Qm8vMGYvNEd0bW8v?=
 =?utf-8?B?Z1BxMFVLQ2Y4aTNDVzZ5d1VuMnViSHhkcmkvYW9iclVXR1lVempUaENNYzhm?=
 =?utf-8?B?WUI0YkpLSEFQUVc0M3ViVkxDT0l1blZrbXZZeGgxeTNVYU95cm0xUVpCZDJC?=
 =?utf-8?B?NTBvVHNpd0Q0amVRYWcwVkZUWnZRd3NUNWFBemdKQzh6K2hBbW4xSlNSbURj?=
 =?utf-8?B?TzBjRnhXSFRuTXRjQmR1Y1J1UHV1RUdYZUdubE9Pb0NBY0pGbVJSZG1mbjBX?=
 =?utf-8?B?dlhHQnh6YUlMUmFpNmgzRTRNQWFTK3dwcndpWHFzODVudU5YdHFaM3RVVHpL?=
 =?utf-8?B?akZQcTJWTEN2UE9iMWtkaDcvT1lOVnF6dHBMSmJhSjhzSXBaU2R4eFVQZGx3?=
 =?utf-8?B?WnVWVXhVRFdVSEdqQTErNkVrMlBYd0NqL3FVenlKT0hBNFpHL1ZZNmR5Wmlr?=
 =?utf-8?B?UXJJSUMzeFc2aG1LalB1ZEhxMzBDRXI3dmx6QyttTmMvYnd0Q2hBdk52MG9X?=
 =?utf-8?B?R3Bvc05rOVNZYm9ZOTRROTJDdE5OOFZWb09XS2hiZHYreE02YUgvNlJlQ3B0?=
 =?utf-8?B?VWYzUzZ3L2J6aGFiN2RhZnpZWmh1SmJPWUxZcGlKQTVpbUJoTGlXSkkzNTFv?=
 =?utf-8?B?RkcxbVJuQWVKSHl4MzNmNlZLazk5dE1TMnZqb2VJOVNWWmJVamlnUXdHWDM2?=
 =?utf-8?B?dFJ6NWQwM1M0b2NtcVdiZGJtQWxXREV3SGdIRmJ0YkU1ZkltZlJGVmp4ajZX?=
 =?utf-8?B?S1dDbjlCbE1xRFIzM0h0U25ncUpXTkhjbTduemFDVkNZZ2FxcXpLaTlHTXA1?=
 =?utf-8?B?NktyR0xlcENzRHJnY0dSVm4vR0ZXaWRLRTBoQ3BVa2JwTFJ0MW5HTXZEYnBY?=
 =?utf-8?B?ZHEvTzVsRXVaZStGb0JCQ0JnVlJPUmRxNGkwRC9pdnAyeHhLQzY5VlZMb2Jk?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6805cae-0025-4493-0e43-08db4fe26886
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 16:36:44.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49TC2QkUZQhH1Tf/KzQMd8gV8YQ1/gM5cObNhLq45GiFa7X+yVZCjfNAGnAxZgoqYy93sm/j5ataodIgTX+ZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_093650_170395_6AB612E7 
X-CRM114-Status: GOOD (  14.87  )
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

Hi Hannes,

On 19/04/2023 9:57, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---

can we find one sentence for the commit message please ?
Maybe describe about the handshake and sectype ?

>   include/linux/nvme.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 4fad4aa245fb..6e55a7a701e6 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -108,6 +108,13 @@ enum {
>   	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
>   };
>   
> +/* TSAS SECTYPE for TCP transport */
> +enum {
> +	NVMF_TCP_SECTYPE_NONE = 0, /* No Security */
> +	NVMF_TCP_SECTYPE_TLS12 = 1, /* TLSv1.2, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
> +	NVMF_TCP_SECTYPE_TLS13 = 2, /* TLSv1.3, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
> +};
> +
>   #define NVME_AQ_DEPTH		32
>   #define NVME_NR_AEN_COMMANDS	1
>   #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
> @@ -1453,6 +1460,9 @@ struct nvmf_disc_rsp_page_entry {
>   			__u16	pkey;
>   			__u8	resv10[246];
>   		} rdma;
> +		struct tcp {
> +			__u8	sectype;
> +		} tcp;
>   	} tsas;
>   };
>   

