Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17120C7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n9vWs6fI5Jc5DKXjDR6Nn2YfkK0NABoQzHE61MYYdFc=; b=t0u+d775zo6t2gjXJCF9u6X3LF
	qcJZbCapWZE5ZibLOgyuPMjhg4YWS66aCzukF6vyGRxt59CVb3cRve8OSLBgYwUS0JZaLegqixdlR
	DIdUX+VhKV47LVp/OAgKeiEAh+ovvUQrwH8eBTFX3w7Cn46GvBYSGYRcAHq7ct4BDo9IdSeTI7Rf5
	VuisXbC21mG8mIs4JNygm9Ntazbnl0cQQO4wkFWlcWV9PORieVnfgZcehgUJulEWG1d+rjlu7KIPx
	cjs7aHmqr9hTE6Q7lpTIhsCRBlTpIh8i8fe5lIEZeFj1uEMa9wUyX6qhgKjINx0ZYlB3LB1tXI/zB
	9qqIDzeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwHp9-002WSj-2f;
	Tue, 09 May 2023 07:31:51 +0000
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com ([2a01:111:f400:7e88::625] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwHp6-002WRs-2P
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 07:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQVpGR5fYQV21yuobO6BL7M/5iN/hJZSfswybcx9sWT27ogLxfmevPuPsAMB3o8OXptEkZgkEAWteDwGUr1ZXv2goBGm/K7B4fHr6q4zNMAALK+ChbE42Z8ImhiRPeYxqgGrTVLu/c6KB4CBEvuUeCm2gZXf8xgSr++PO0RGd41hnjWFxbfVTBhmCAiOa5MkS2yuDmEj/tW0+2KUSOPP/VLo+2mWJVn1OrUhkJtyLeoQ3PyxmvUTZ58b8VQC1VPbdw9ioRtSoOz+/UDjTZ1CEk9HMdB3kX7DfU1oN9hq5q5o1sR0ME1aAHWjdV5y8vKJgiTlAUdBMbNiJabeTOwvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9vWs6fI5Jc5DKXjDR6Nn2YfkK0NABoQzHE61MYYdFc=;
 b=IZZy9mILFRYwfWzWuoSXMM7U6kKb7oqmE05b8YXmMZpUGg+JFZrXrSmYaEdJCsibKLwmvmnWGakdY/c999eOC0i3VCrUrggXpfZqosIxjCO8nl1v5F8NB9McmZRPaERlPoAnz6i4X7V9l/hbqfBK+mWTY/rrCErnVhENWxW5gC7hL04BJGKGCMF/PLeP22e5hsGNx5bVJIMl/cA1emAUsIc+VKQRnsKJsm0P+zgkEMom8QWunYyvFU8/g2Yohto94KpaYx5Q9xVFyogVTDNzmbrfYGx6L2ZhN9IAEEoNbp7sqEYAGMTouRUXaw0r3NBGFS/im6mOkxhcyyFpt7Y27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9vWs6fI5Jc5DKXjDR6Nn2YfkK0NABoQzHE61MYYdFc=;
 b=LeeYcZluF3ULxRM7ouHFFAZg0/64RkDP2fWduXxoqNw5NDzkcFfzh3y+Bi1pgDZqnaGDM5x2JSICYDTGrejF4JLc4D+DK5R/d+qRsUzbmZI4fHNuShKd/057EVojh+VFZdBmzwGwIlarjRwBGXlQnjo6FfKVPcTaeAebo9hzTQTWL0RoZEyVhGJgGR1T9T92voJTK54ky1kzyC9UJUiCOoU+t8nL4sktULMTzW+kTOmYm+5h51XSjt9awPYYR/xkeaBxVQNr08J92hrwmVVT4E48aso2AjGKoQ6EiwjEB5WxQ4agIhd7tlGGzKsPlQMubWYt2OXQnyzg2GM4k7wtJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:31:45 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 07:31:44 +0000
Message-ID: <79ecbedd-9392-cc0f-dd7f-37668cd67d3d@nvidia.com>
Date: Tue, 9 May 2023 10:31:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 05/17] nvme-keyring: implement nvme_tls_psk_default()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-6-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230419065714.52076-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: ae25c785-61c8-4b06-b012-08db505f709b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	jJjP7tPHq1xYKUaG6VxHOFf/ABRE6Y5+kj6kqkH4Y43yEkUgEFcWiEU6Hbemlz5dsl66/GvXw4ptsMcurY5w9zLULBAS/ISlHiOOYY3ov/n7oKLxRHpiEogXYDrfSlw6UT1k1DAU0fPfNZZpoIjdX8zK7Wc/HWO3Zk3NWEPGyFjDLZfIg6U3vEoQsO8/i3AG8SEmnV16/1tyIVw83lNVXROno0WFLWhRwRLFjEAlGndyzY2vJ+ptrE3tym2tUVSVyFQp2rhelzhpKKFxSJFcWQcnr4AK3qRtrY2yVXqJzZvpScODe54bBt2sKvdc8s3jOiwgApCbPqhZjM3dy2mFgGYm58yXra5YMIF50t1aJw5D4dXGrRxPH/HcPno/MzPtID7wdYnn1wG0gxv10xm4NJh0Y7v7cpmlcvRdPMpXKu9Jd7U+KwpZCg7wKEq/cXz/Dwv2XduQD5s/90J734QUlKOEC6IyvLx227Ee/QFntohynrwCeZDy0BXyoUzWsSjxB7SFquezpp8eoFkUmaxYzLatTptrK1ntU+MfAjlfWASn2hYJFSkamxOuJIjkIE/JZT6MjSL94dP5q/GFemmhmudYeYSTESZTRTHl8BMrxId7ZGbUWuPzPVoMgqK3WOLu1SUgqxWSKFgoRP7Jx3LGHg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(2616005)(478600001)(86362001)(6666004)(31696002)(6512007)(6506007)(26005)(6486002)(66556008)(4326008)(66476007)(66946007)(316002)(54906003)(110136005)(53546011)(186003)(31686004)(38100700002)(41300700001)(8676002)(8936002)(5660300002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QkVWNzFOK1IwSUpNV2dJalcyOWhuS2h2SDduRUhzUFRjcVJHMkZ1ZXA0YTVB?=
 =?utf-8?B?TGo0aVE5MTRqVFpjWmQ0QytydTNIVXBTMzdLUE03VDFpWkVWYmNxZlYwRVNY?=
 =?utf-8?B?RkdSMThtcTk5aU0yMjZoUHRjV1dFZnFoeHYrV2thNVYyR2JIRUpBRkNTVmFh?=
 =?utf-8?B?Qm4xelBFMXQ5eXJZOURhREVMOTBVTldFalNqdDYrVHEzOXR1eFQvTk81aWF2?=
 =?utf-8?B?WXdGOHJqa0lYclc0WVcvVEJlNFloS2YwejUrWUdDUkNaYTFwbEtRTjF5MU1n?=
 =?utf-8?B?Y3FITGFNb2U5eDdZV1hFdjEweTRqMVE0RzJyNW0rTUpFVThqZ0hiclpINndQ?=
 =?utf-8?B?VnAvY3JNRnp5VHg2Nnc1QTVuRkxMbXpKaStoWWo4K2o1VUdPNktRY0xPcFdM?=
 =?utf-8?B?VG1Ra3BjZ0hCanNMRHdPOWNxNkZkd3JGWkt5RngyY0U4MTZsN2NabGk2RDho?=
 =?utf-8?B?TktMTnMvSUw5RWM0UGIzVnN6WHdPaFNucU00Q20xSWhKSFVhRitFcllJTzF0?=
 =?utf-8?B?RFZVMWtSbS9YN3FEK1RkUUVqL2tOQm1IUk14aXB4VkVRMTc0OXVNSTh3ak9r?=
 =?utf-8?B?a3VuM1BxSzl5bVYyalZOcG51MFJyUTNhSTNLWWNmQVZ1dC9VSkZPZjJOMUR2?=
 =?utf-8?B?bDQzRmlvUG5TWDUyekg5NFRCT3JvZUFsSm9sdFdwSi9Wb1V3ZEhKUU95d3dD?=
 =?utf-8?B?VTg1bmtPSUNOU0VuODNJVHFPOUt1WlZCcGtzL3JYTUxtNHJuaXpMeXE3azZk?=
 =?utf-8?B?c3VJMEJlVmt5UVhIS05POUtJUytjYTd1aC9Nd21SQUx0M3M1bUJaUjJCM2Jr?=
 =?utf-8?B?cG1ZUGprOTdoMi9JMnBLQlFUbEpZT291ZkgrRWtweVg5UGZyajZOMFBDaHBx?=
 =?utf-8?B?TkVoUUtaWUxYRkVXc3c2aSttcmZYbVpXdmlEQnhYQUZibjlaS0RWOVp3WER1?=
 =?utf-8?B?cUY1dlFLOFlkcXBVanh2UGs1c1lnSnpGZmF6YWdOcXE1U1VlVU4rRjRhemkw?=
 =?utf-8?B?NmNnRU9IeUZyM2NnTEJkUnZCZThiSUpIdUtCNERMamF2Z1pvUm9VdGk4Q3F6?=
 =?utf-8?B?SGtCaEVNN1QxT3BlZVpWNER5K1BHQ3JuMStnVXJEZHFMNkM5SW9rZzRUdk5m?=
 =?utf-8?B?K05pbm9KTFgyM21Da2Z5ZnZNN3h4bmZsY3lSMHMzWWtZNjAxL0c0TFVxcnVy?=
 =?utf-8?B?dXBPNE51bkVWZ250UWhuUDdkZWJZT2tlM2xpa01BYmFCcXBlQ2VpSlVVTS9B?=
 =?utf-8?B?d2NIazRsSnFIR0R3Z1pOZ0VwOEtRdE4rUjlZaERDVjVrdW1sUGg2TjIrTlpV?=
 =?utf-8?B?WEZHbjhCVUxkbmpWdElUTkpOa05TR0pWbnRrd2d1b20xclZvQVVYRk9UMFZj?=
 =?utf-8?B?dUZVbzF2N2U1eWNmbTdPQmxMcGNjZ05rOVhHcFkvb1FZQ3RxYW5lRHIzOGY3?=
 =?utf-8?B?c0o4Nnk2d0pheCtOL25tdW0wRWdMUnF0QW5VamwreVFRbGRQYXJBSkVLREMy?=
 =?utf-8?B?dmRYRXRycFBSRlRsRkpQSEdrZlZjdTNaYkRleGpNRUtjMDkvc1U5cm1ndFJi?=
 =?utf-8?B?KzkvTXQyU09ZVlhQVTllOW9jUWpnWHlFMU5ReU53Qzh2ZHhuU1dvcWkrVmF0?=
 =?utf-8?B?eXVmY3hJRG9vNm5xS1RrT05MMFBWR0F1NERsdXR6UFQxWklYMnNxWmxnc0pt?=
 =?utf-8?B?ekM3SDdCK2xxT3dUY1NDcktFcnJLSHBQOENsc3lhUnh1dHFMM3dmTWp1cnRj?=
 =?utf-8?B?OHNiV3pOdWxzVTN6Rk1SejA5aERQeUNQRFRsOGJid1MyR01xaDg3Y2lhMCt3?=
 =?utf-8?B?NzJjUUFJVDhOc2tnRThKb3VhclBCVytja00vQTg3NWpBK1QySHhtM2wrdlJy?=
 =?utf-8?B?ZUdUVGdTR0M4MWhzZnNmU2d1aVFSRTFsNUxvQWZLWjM2dTh1MVArREtRNld1?=
 =?utf-8?B?TTBtbnY0ZytJMTZtN1crL21GR0ZURTYxVkFhZ2ZkSG5rcjB4YUthaitoTWNC?=
 =?utf-8?B?a0MvTlBuMGNRREhGcXdwa3ljNE83aTROZDdyT01TMy83dTdONHdmZCtnM3NO?=
 =?utf-8?B?ZmwwcVZVeVA0MWdqUzVzRVBrcWV6VVM5MVZORk0ySUVkSmlweExueW5TdzRa?=
 =?utf-8?Q?S+4qk9UkvZDZAmsFxmi3xiy7A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae25c785-61c8-4b06-b012-08db505f709b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:31:44.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ReSnwoiKt7W7a4WaH6BsFpm02E0ewOrPbu7+1HIqB+TDWyHSvgp8oVcfFpbzbZ+ovG12/U0bRpxLcLnLyrHJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_003148_793259_F737878E 
X-CRM114-Status: GOOD (  22.51  )
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

Hannes,
I wonder if we can squash the keyring patches 1/17 + 2/17 + 5/17 to a 
single patch ?
And start the series with some preparations in the nvme/tcp for it to 
compile..
This will reduce the amount of commits and simplify the review.

On 19/04/2023 9:57, Hannes Reinecke wrote:
> Implement a function to select the preferred PSK for TLS.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/keyring.c | 48 +++++++++++++++++++++++++++++++++++
>   include/linux/nvme-keyring.h  |  8 ++++++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 494dd365052e..f8d9a208397b 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/seq_file.h>
> +#include <linux/key.h>
>   #include <linux/key-type.h>
>   #include <keys/user-type.h>
>   #include <linux/nvme.h>
> @@ -103,6 +104,53 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
>   	return key_ref_to_ptr(keyref);
>   }
>   
> +/*
> + * NVMe PSK priority list
> + *
> + * 'Retained' PSKs (ie 'generated == false')
> + * should be preferred to 'generated' PSKs,
> + * and SHA-384 should be preferred to SHA-256.
> + */
> +struct nvme_tls_psk_priority_list {
> +	bool generated;
> +	enum nvme_tcp_tls_cipher cipher;
> +} nvme_tls_psk_prio[] = {
> +	{ .generated = false,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
> +	{ .generated = false,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
> +	{ .generated = true,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
> +	{ .generated = true,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
> +};
> +
> +/*
> + * nvme_tls_psk_default - Return the preferred PSK to use for TLS ClientHello
> + */
> +key_serial_t nvme_tls_psk_default(struct key *keyring,
> +		      const char *hostnqn, const char *subnqn)
> +{
> +	struct key *tls_key;
> +	key_serial_t tls_key_id;
> +	int prio;
> +
> +	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
> +		bool generated = nvme_tls_psk_prio[prio].generated;
> +		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
> +
> +		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
> +					      cipher, generated);
> +		if (!IS_ERR(tls_key)) {
> +			tls_key_id = tls_key->serial;
> +			key_put(tls_key);
> +			return tls_key_id;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
> +
>   int nvme_keyring_init(void)
>   {
>   	int err;
> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> index 32bd264a71e6..4efea9dd967c 100644
> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -8,12 +8,20 @@
>   
>   #ifdef CONFIG_NVME_KEYRING
>   
> +key_serial_t nvme_tls_psk_default(struct key *keyring,
> +		const char *hostnqn, const char *subnqn);
> +
>   key_serial_t nvme_keyring_id(void);
>   int nvme_keyring_init(void);
>   void nvme_keyring_exit(void);
>   
>   #else
>   
> +static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
> +		const char *hostnqn, const char *subnqn)
> +{
> +	return 0;
> +}
>   static inline key_serial_t nvme_keyring_id(void)
>   {
>   	return 0;

