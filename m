Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8804C77B75
	for <linux-nvme@archiver.kernel.org>; Mon,  8 May 2023 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cnOLf/Z816iGWsge+ojKFvv9QD5t0I/48dwZUYr0D38=; b=vJ1FwBYgASxho7JZUIHDVDTgkc
	SCU91MW2dmAweMtyTygBFHQy8G3pxHXzDl60aaaIyo/VS+J1e3SDrx/+duRVn5fv3w67gG7Xtlx79
	RMYjDERv043nElOby1URuNOv+XS+eDz8Ayh6cn+NaisXH+fN0zmFC8iZG43o3g4oUAkX1n4y8g5Hp
	igSk52owq99d/OYeehYHN48BTBLDJnxb3RODh9o0EE/SVgcVQcs6S+QIG7cPRXDOV62DcqUqGrABm
	VVuDlkkbbEoUS7nGSgFLBlPhR9WG9hYgatsYBkBx6in/JzFZjXs1CPYk+JOSue59+Qg1iK2hTs8re
	6XKHEyrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvwiW-0002EB-1h;
	Mon, 08 May 2023 08:59:36 +0000
Received: from mail-mw2nam12on20606.outbound.protection.outlook.com ([2a01:111:f400:fe5a::606] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvwiR-0002D9-0R
	for linux-nvme@lists.infradead.org;
	Mon, 08 May 2023 08:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMf4wIO1HTwbB6hcKk1myxxDzvgyrr51uZx9LBfF7yaAs7KwTTrW78Kx3Nub6/tYf/ef5kcYZ5nfebBlOSHERz/8W3JdeSn/X2AwH0+6Yb0DTqVpVAqYtlkwdEh1N/uE7dW4Ei4bgrWlqsy8BVDz2sTzCorV+mEiDy1xv7AaQI2XfAZxavqLBdxAeCnU+j23sF9nzdXZDO7dGkCwCEoQpUI8I/4OzM+DByg8B3zbn2JB9qVni/EZaRHdGPvuYL+q5p3q1+TRmVpUK9OV5iYPp3r2Rye+r+6J8ctaE/mkUAmQHfMnOaXRnSwo3dwxCpMFy3BIqilYllCpC2qKFfZVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnOLf/Z816iGWsge+ojKFvv9QD5t0I/48dwZUYr0D38=;
 b=Ej3HKBVKqlBF1+rCr5+WxcnW39bqUMAw7HCXrHkmcoVgvGzn2g74kfmEB2Onz1sCjN1Ne/NyIwp54sWwLmQkXbD2DEl1PhbS4Un88oUPj+fBp5MY5hMu9kxaQOI1s9o6YwW1o4fyMV1JkPxV0QlfTSoaTZX/g0Upzx6LteL1HOwLMGh3ERAnC9C2uc5Z/golzBPVpZ5nUt4G5VHWB3/FGVAuF9JoEv0piiTVBVswj+VqoifDuTEzyA8Bq52aWgnk/+ofmzv0GCNEc/I8bhTeQGjoLzvC34HqbQ9R1uHTmnLKug5capJ8PXTUesTJjnFS5bGEkSgj+WctuZJI5NxrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnOLf/Z816iGWsge+ojKFvv9QD5t0I/48dwZUYr0D38=;
 b=EjwWLWU1FAtjxsQOHMS3tBcgEOM9VHZT1pF0VCToarma8nCDvqs6kvY1V/eZHvcZ8T2BMuBk6XUrlGnNIr1v+8QmYDDAbarOSlr+G8Cgx5/8KqkiCMp7kCR9sejcHu7ggoMHy1afBlTx9xbDrzWqls376759e9bQhq8T+5rCQpAfkiBROTJxKvxfDgxLfB41THQs7sn9U8sPXDYWvj8Cbnydq5D/mudoC4SDozkOXD3MuS+7QHGh8dkVf/iGN5IMGVY5vJQ06nIyUv2REDooWYWsLhzRJ3c/Fjr8Pw+y4KXRZAHQLNb2taMQgdj3mRV4cT2MGLjuEWuMiWgc1eFW/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:59:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:59:25 +0000
Message-ID: <91742b06-4138-82a8-050d-bd41cd2f8aa9@nvidia.com>
Date: Mon, 8 May 2023 11:59:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 02/17] nvme-keyring: define a 'psk' keytype
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-3-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230419065714.52076-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bada529-6bbe-4ca0-ee8c-08db4fa285ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	xV+KA8usNx9hov/BjwNh4ZhfznAa1yDsZo0gb7gApH98Xw4MXBwSCXjvIKbQn98BPXVXlMyciso8qqnUABN+jp6KFWRhcCS+uYqiCRdsLpql17SU45Cudng4/fAUcMakxIbi1S625Cnp1w0jh8biBmavOdSyTjt8MsjCWMH+IHTtQblrzJsga5pEkGHG0rvlcbC+6BkRT6AzuBl4vW8GaSHSzfZzUgiiKI6ltIRgJIUTUBTghk4Aw13enkHN9eNsLd55syIf7SC8wlzJviENgVZXMwbRufH6/OrU3FoR2egE4B5dcFdIIny54RqAk/oMtPkplARvdk/AvTw+a2rZvdWVEYpAC/v7FZ/E+1JJM/2Z03py1basRyfhoiJAKT6Mg16S5ABDnyRHkEMqzCangby9Pve2wDInaJ2ZgcEdV8B/xt4XH7oAXfY4aAD+N5GBIZpEBChb1AIgTMGFpCHvdje5om0BV3Hb3dj5QRX/LBjOfCVdLeng8VGwYOUk/po16eqwlqfkUh8cu8qxVHCSI52CtrVzjx4ubrOw+dzsVAY6ihPw+HVLysbz6Z84UdzBsZcJ2nUShCg9JZZRud07aVr24MwMNXWGHpH2THFLy4jqBN7532JweoTMgNVDW/jlP67AnvIgUaFkkXwnGkYpSA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(8676002)(8936002)(5660300002)(86362001)(31696002)(2616005)(186003)(6506007)(6512007)(53546011)(26005)(38100700002)(478600001)(54906003)(110136005)(6486002)(6666004)(41300700001)(316002)(66476007)(66556008)(66946007)(4326008)(36756003)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?UGpDbmx3OXRRY00weHVuTlN2SS94M0g0bVc2Z3N3QXBRbGN0czdWUExZMmtk?=
 =?utf-8?B?ZFJua1ZVL0FPNmVoL21ia0lzYlhCVnFEa0hjYUF6OHBCeEN3OWJDMzJjOVNU?=
 =?utf-8?B?NjU2STRVOGxDWXptQWlCK2JiZWJzNFhNbUp2TWdJNTBnRk9KMzFGZmYwL2VC?=
 =?utf-8?B?UzJ2WjNXZEszdjV0R1h3dXhaZkJ5RGdIdXRleDV0Wkd0d3VTODdJeXR1bUpV?=
 =?utf-8?B?ZmExTHNvQURML1NaUzEya0FQc3FvdmlIaUxYSlZNcy9INzF5VmxtZEtFVk5p?=
 =?utf-8?B?K3dtdnVvSkJQWGw2YmxkbG1NOVBPVERJTHNvMXIwSlljRmowYTJ4cnh4MlBh?=
 =?utf-8?B?aC9hcVFXUzBKTzVWUjVjUVhkYy9JWUJ2VDVCSHQ0ZWp5UG5jNmZzODhlZ2Zw?=
 =?utf-8?B?K2xmcDZuQjhuREt5SVIvWFU4U3NrS1N0dXNPUDVJZTErdzZ6emZaRENiVTFi?=
 =?utf-8?B?Z2pXN0ZoTXBwOEdETFVLUkZzZWVZNy9JZEs1VlUyazZXMHNkdGUyQi94VVVm?=
 =?utf-8?B?TkwzRXZmczhuQ2oyU1B4WXJDTjVhU2NWbEd5UUpTNkRDQVNvRDQ3NjZvRUpC?=
 =?utf-8?B?WW9pdmx2MTBjVVZwQzkreDZYQi9KL09Oc0daMVEvRUVxd1hYTE5TZGY3d3Zi?=
 =?utf-8?B?aHdxVm0vTVFJL0xsN3VYMFE0Yy9wakVoU0pSZi8ycUprRHdTVER2cjgxdVlR?=
 =?utf-8?B?MUFERVJMdmtadWhVanFFVjZ4ZEd5dVZKdWhHYTR6SFB2Z205V1dIRTJjOExS?=
 =?utf-8?B?UVZzR3lqNW5ackRKVTVJS0RxTGk4TjU0QW1aMEsxbWZWeHlpUjR5UFNqdGRJ?=
 =?utf-8?B?eWlJZDVRZU1oZHM0YkwwQ21DaTU5VGQ4a21acjZuZXBacEJEUW52VWVScWNt?=
 =?utf-8?B?YitMR2FwU2xxNFVnR0NMbEIyTjZOdGZqTkNtRjBVZk5GSmJmZWZVRDZJaXRO?=
 =?utf-8?B?WmI0UHlZTkJrQVNCZE8zUEE3U2FzZmNDUkVWcnAxR3VhTmlhYU02aGcxSlJT?=
 =?utf-8?B?MFhnb1hrK3NIQzlHYTFXeFBvV0NqR1BTSFpHZTZsaGNBUGZzNFo5ZnlJL05G?=
 =?utf-8?B?MU9wdTgzaWVKeWhmQTRaRmJLOFdCSDhkSVNGV1pKNGNDMjQ3T2FISXlOYXR5?=
 =?utf-8?B?TDhkZzRMRTc0MTFZOW0vaFpmS3B0cVJ4dXRFSVdGaXdSeVJkQmFCM1ByNlNP?=
 =?utf-8?B?UGphR1V1eVRFa3l3akVOdURGNWp4OWQzMVAyQnpEWVNYM1kzUmVkREtXMFhw?=
 =?utf-8?B?ZVZWd3R1ZmxzV1k3RmJoZnQvVzJNMWtxbEd6RFdqdjU1WVZLQU9OZSt6VzVv?=
 =?utf-8?B?WGltRHJZM21MK3NNcU1qZFpnZG4xSEJySVVsSVErbnd1R28xL1IweFg3S0lG?=
 =?utf-8?B?YkREeXhieFZwTGNicHQ4SzZvTVpxMisvbFJsVkRGcXZxaklOalV0RmkveHZB?=
 =?utf-8?B?OThCSXpzYjdVRGhmZlBTaHNTRWN1REJFM0dja1h4K1IzdTgwaHdDb05hRUlj?=
 =?utf-8?B?MlBrU2YvM0JnN2lYNHdET1VKQktlUDdLUTZET0M3YkEzVkhJbXFSMXNkZGdH?=
 =?utf-8?B?N1I1eExKd09IVklCWW1NUGVxU3J3RERSanVMZGxnUG0vYUQ5Sk5Yd3IwZlNL?=
 =?utf-8?B?WWNvYSsyUmdkbjZmOHBjVlhmNDFUTno3d3dldkV6WlBTdlJVR1NFVzRMbklx?=
 =?utf-8?B?akhTWHNQSGdldndPb1QwWGJXVFpTZW9jakVBL01tQjdlQUkzcDRmMTBxVkNQ?=
 =?utf-8?B?UFlvRTkrU09NRGNMZFpxMjdURmR5MGVnMnMrbEFVWWFvZDQySlM0R2h6Ky9T?=
 =?utf-8?B?dG14dDN6MjlYcDZyeEJZUG1scHJWSTlLMGlpZkh1OHNCK2tFUHUzRVFDODc4?=
 =?utf-8?B?SlNNd0ttYm14Ly9SQVZpQXBZR1FqenAyb0dwWnBEV0ZUU0xNRDF0Njc1L0F5?=
 =?utf-8?B?ZlUxVm5tOUNMZ0x0YzRVQ3M0Smt2QytxL1djSEI0Vkx4Nk03bENlVndIVFJT?=
 =?utf-8?B?QnF4OFlmM0F6T0hvRHVISWoyYXJrS0IvcWFPaWdnREtvdDdVaTNBRUpZMXlk?=
 =?utf-8?B?VkdpK2VUTG4zK0JmUklOdjBGN2FrNWtUYWtZUU9mZlB2S2RWRUUwSjNXUDlU?=
 =?utf-8?B?cGtpMUtjTVFIRi9uVjFvVlF6WDA2VlhOZzhjTGg0aDlhRVFwRENHN0xnbHdV?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bada529-6bbe-4ca0-ee8c-08db4fa285ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 08:59:25.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU1QJCbut0ZNvPVKJfkj+SOSvFAkOTX5dXnpL9uWR33ZBIAE2rFirkwxksMzLLgJe85X4ttTsv2exVa/qdwDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_015931_194486_5858B801 
X-CRM114-Status: GOOD (  17.71  )
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

On 19/04/2023 9:56, Hannes Reinecke wrote:
> Define a 'psk' keytype to hold the NVMe TLS PSKs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/keyring.c | 94 +++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 5cf64b278119..494dd365052e 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -8,6 +8,8 @@
>   #include <linux/key-type.h>
>   #include <keys/user-type.h>
>   #include <linux/nvme.h>
> +#include <linux/nvme-tcp.h>
> +#include <linux/nvme-keyring.h>
>   
>   static struct key *nvme_keyring;
>   
> @@ -17,8 +19,94 @@ key_serial_t nvme_keyring_id(void)
>   }
>   EXPORT_SYMBOL_GPL(nvme_keyring_id);
>   
> +static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
> +{
> +	seq_puts(m, key->description);
> +	seq_printf(m, ": %u", key->datalen);
> +}
> +
> +static bool nvme_tls_psk_match(const struct key *key,
> +			       const struct key_match_data *match_data)
> +{
> +	const char *match_id;
> +	size_t match_len;
> +
> +	if (!key->description) {
> +		pr_debug("%s: no key description\n", __func__);
> +		return false;
> +	}
> +	match_len = strlen(key->description);
> +	pr_debug("%s: id %s len %zd\n", __func__, key->description, match_len);
> +
> +	if (!match_data->raw_data) {
> +		pr_debug("%s: no match data\n", __func__);
> +		return false;
> +	}
> +	match_id = match_data->raw_data;
> +	pr_debug("%s: match '%s' '%s' len %zd\n",
> +		 __func__, match_id, key->description, match_len);
> +	return !memcmp(key->description, match_id, match_len);
> +}
> +
> +static int nvme_tls_psk_match_preparse(struct key_match_data *match_data)
> +{
> +	match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
> +	match_data->cmp = nvme_tls_psk_match;
> +	return 0;
> +}
> +
> +static struct key_type nvme_tls_psk_key_type = {
> +	.name           = "psk",
> +	.flags          = KEY_TYPE_NET_DOMAIN,
> +	.preparse       = user_preparse,
> +	.free_preparse  = user_free_preparse,
> +	.match_preparse = nvme_tls_psk_match_preparse,
> +	.instantiate    = generic_key_instantiate,
> +	.revoke         = user_revoke,
> +	.destroy        = user_destroy,
> +	.describe       = nvme_tls_psk_describe,
> +	.read           = user_read,
> +};
> +
> +static struct key *nvme_tls_psk_lookup(struct key *keyring,
> +		const char *hostnqn, const char *subnqn,
> +		int hmac, bool generated)
> +{
> +	char *identity;
> +	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
> +	key_ref_t keyref;
> +	key_serial_t keyring_id;
> +
> +	identity = kzalloc(identity_len, GFP_KERNEL);
> +	if (!identity)
> +		return ERR_PTR(-ENOMEM);
> +
> +	snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
> +		 generated ? 'G' : 'R', hmac, hostnqn, subnqn);
> +
> +	if (!keyring)
> +		keyring = nvme_keyring;
> +	keyring_id = key_serial(keyring);
> +	pr_debug("keyring %x lookup tls psk '%s'\n",
> +		 keyring_id, identity);
> +	keyref = keyring_search(make_key_ref(keyring, true),
> +				&nvme_tls_psk_key_type,
> +				identity, false);
> +	if (IS_ERR(keyref)) {
> +		pr_debug("lookup tls psk '%s' failed, error %ld\n",
> +			 identity, PTR_ERR(keyref));
> +		kfree(identity);
> +		return ERR_PTR(-ENOKEY);
> +	}
> +	kfree(identity);
> +
> +	return key_ref_to_ptr(keyref);
> +}
> +
>   int nvme_keyring_init(void)
>   {
> +	int err;
> +
>   	nvme_keyring = keyring_alloc(".nvme",
>   				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
>   				     current_cred(),
> @@ -28,12 +116,18 @@ int nvme_keyring_init(void)
>   	if (IS_ERR(nvme_keyring))
>   		return PTR_ERR(nvme_keyring);
>   
> +	err = register_key_type(&nvme_tls_psk_key_type);
> +	if (err) {
> +		key_put(nvme_keyring);

I see in the nvme_keyring_exit you call "key_revoke(nvme_keyring);"
Should we call it here as well ?

> +		return err;
> +	}
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(nvme_keyring_init);
>   
>   void nvme_keyring_exit(void)
>   {
> +	unregister_key_type(&nvme_tls_psk_key_type);
>   	key_revoke(nvme_keyring);
>   	key_put(nvme_keyring);
>   }

