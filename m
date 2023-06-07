Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627CCC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGZU5KzNgibscpqSIP3PsyIvYHttNQjZNcSHMEc67Dk=; b=iHJ9ZSEdrbkKEsaB3sSMz4oIh7
	zPbwARQyAlsQ5uY/vZgZH5O1vcxcpfosG3vy1njkbzbaoA9K8ar3R8KokqKj6MlAe0r1IROEZTODy
	3hS2gfFlYC/+ZqiJlAqpAzuGoLzw/6+OCr6U6GCRtOjWcALAWh9WsSwHIWAp11jLWsb/gE354vFEh
	wrGndSgoLkUzIc8mdWE7VipHz6sV+h6f0fF+vM0qi1CtH/23cIrmrE+DJAiuvFmJzVNQ+G4whqkjn
	7/QYW/X75g9Lkn1joQKDoKXJn/01x/vqXbRz9k6bzRDZ/vKfbd+10H7VSfpZz8YTkW6ThH+18trne
	CaZv9A0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6qsw-005aKb-0m;
	Wed, 07 Jun 2023 10:59:26 +0000
Received: from mail-dm6nam04on20618.outbound.protection.outlook.com ([2a01:111:f400:7e8b::618] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6qst-005aJY-0i
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 10:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgtbB2mCpsoVTntVj5Qx9SFsn93AT1iBwbr8sUJ+m4DWUcB8YuBGxYTJ1KWZgATIOFSY6XKDJ+vUj1quMpSmglm+g7O81/RBQJcQYzByON9y4lqEbDEe6yKf/PTlm8W7wNypjFPLoRSs5GOBrVNMXlRmArHSm+IsWUlW1u15a8NfZTTdGeqlatArb+YW3jeoHdOQpTlel+mvbmLW2qsxKsicbKX3wyAu+TzD43QJh4Y8t3tj9S4UzQv0tM1+GYVXTNkPxiK2CwZTYrEez8YLpLgDC7fvgBazn3XbGxCN3kBWgbXb5v4TJWw+jYYhmTbnfd5gxo0CcFyNS5lrG4QCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGZU5KzNgibscpqSIP3PsyIvYHttNQjZNcSHMEc67Dk=;
 b=aePdG7k0gtDioONocunAQ2mn1H+pz7e4mPgRaapdQk4lQvG08KJ2gGRsxS7LdrJ3YyA2Jg1RzOA3pF1w4smgSJbbQPNBHaWrDUTnv8Uv3F4gYMC/2MVjC9KNsdN5i4/wkq/wjh9GcOSdAu02RenUQUlXBW52I+H8deVnplhhQV8kL4mY76BhbTvmztKIs8hj/I77cndOcCLXXLHdIUbMzUdFKV/ib4MZL9D0a+fh9b8AFPNxXtf3su0SguAMqqcfd4IlzWD+CulCbXHxa5+AdpNvne/QtjEgq3d8WgEIKx2oYouhQ5youRdY3jST6lDzAFQBXp2K7wYevf6SUbjXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGZU5KzNgibscpqSIP3PsyIvYHttNQjZNcSHMEc67Dk=;
 b=ZKEL5jEhSXJ7HOG9lpyMqJu06VHjB8xzMa2CUObdSz2IDSIlQVt+nsLkr44/Pil4FbgfsXGhsGQtsVguBucrwVSAtiJIcomzuzVHGByOZ9bsWn4XsSJV8uzIhXr6IqbeRfAm6qtJsjuilv0cQibQwZ0qkieUG0PxOV9CV8tR3AHCoaNOtXwdWWTDQUvYqZZHcrQkdFPvGk39tLRjjVSbxwgmQ5Bfr7WJvo1LbqSoQxjvxTosh2NVmKqcqtlJ865vb+nXDJmrfA1KSeG1cKAQwBiP9BcwxO05sVw95i5tGQ4gKolEi8GzaXiVSAbQQv1p7hnOKUttmmoVugUJnEHMww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:59:15 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%6]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 10:59:15 +0000
Message-ID: <dc98df30-8be5-526f-2e56-5ed3218bb826@nvidia.com>
Date: Wed, 7 Jun 2023 13:59:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V3 1/3] nvmet-auth: use common helper to check secp/spsp
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
References: <20230605091920.34253-1-kch@nvidia.com>
 <20230605091920.34253-2-kch@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230605091920.34253-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd346b9-7fe7-4d05-436b-08db67463bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yxIs04/oZ5JDxaeNlUre22WqvHAr6bUcQ0ynNZfSJ/6kp3ohhLAYnJwUSLlVIp+H9ZwukiYgTmOqi++GZnwm3jH9/HLQho8PUgbcEdtWgalZ2DzG03sA2ZBvCp8litA7CADYrmj5hlpwuHnVNaWHUqnqu5KynvX6YRMcTlv8f2HrlIKYqpl7CDNyvhbr7v6+gs1lPyMyhwAM/F7k37uaJNlq190+fDgELLPzb2KERLfxIMjPvZTKpkwTFSnNruzEc1qGQr5YZpqRhUmGmjbb04dvCJ9E7P8A33XG4MLvjqjj+cGUamClmsejFmSHFGt9DkGA3GPdv0UlBExw6Tm8YR6i1hekvBtXK5AH31nR7hMO1J6bCtBy65cz8/deGh0fhj5mGkfx8hwiepLkCbcnB+jk6nDihcEgXEMCADgo/G8zBNBhAvVUSeNlUVZ+woPvGHoopxHUnqSRIi2fL3PIR3rS5S83fR96rx9fgKqPgP6cZRZ4I4wdVrddk6zkkKxTRFOgQfpfYrbLSYKebka+zi1eS2399ihaG3MlF+8GQCZbgMQxmKuB/d/2TZx6RPr0Q6XiTR2By+XRc2V9T7nufU/hh6kOFHYhhaKIRxBvXW2gTkmh7anrxGuHck02gBgT9Mb0LC03MYTaskiMpc1/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6486002)(6666004)(2906002)(66946007)(66556008)(66476007)(36756003)(38100700002)(5660300002)(8936002)(86362001)(8676002)(31696002)(41300700001)(4326008)(316002)(478600001)(2616005)(53546011)(26005)(6512007)(6506007)(31686004)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2JmekMwNnM5OWcvK1lHVDVDZ1F0Y3NWT2xtQ3FlR3V6VHFncDF5Z1FQcHIw?=
 =?utf-8?B?NjlVYUFMQkRycy9aR2NXcjFhQWhDaTRMK204Rml1U05wemcxUFNpcklzVHZI?=
 =?utf-8?B?bXR3Ym4rcVFSY1NwczJNWXp6ZFJHUDltcDJjRUlpVFZGcHNvRk5xNmpKbWdH?=
 =?utf-8?B?TDJjS01FekFFZmd3S2prN0NodjkvZHR5NUxNMWZLSnErWWVWM3MwNXhRTkNr?=
 =?utf-8?B?aHBMRStUWUN4STUxeG1GUmZ4Q3ZPL1RqaWtxcHdSVFpHM1craitwZzUxRE55?=
 =?utf-8?B?OG1ZMldlNDQ5WHhYS1NGcGZ1a0NXOW0yMVNjN1FTZTErbG9mU3pCc0hNdlZz?=
 =?utf-8?B?YkZ2cFpiaFJuR3JwWUpqc3J5Z1NOYmp0V0dPVHd4TWNHTE1GM2JSZWx5MnFH?=
 =?utf-8?B?N3JHSW9Ha3pSYnd4SStDOUxrWHhoUjRjQUo4UmhQMHZMMy8ydHF6Z0tRY0NG?=
 =?utf-8?B?UzFJaC9WejhJZlZacElLUmY1czZoSjZmNSs1RTFSc0Uzb0cwWmRLZXp3VFBt?=
 =?utf-8?B?SVdIOW1qZEFwbXo1TWpGbEl1YndZVFdLVTBQNDQvRmkwbURzSjcybDZ6QW9Y?=
 =?utf-8?B?YnhkdEtNRnZQSWtHbFBTa0ZyK0djeCtLcVhvWkEzWFZyOXdHNGk3cUh6MjdU?=
 =?utf-8?B?bG5XZWMrMDNXTWIvTEV4c3NrSEkrSkdpdEk2eTZZZmo0V3NHNVVHRXFBOS9J?=
 =?utf-8?B?WDJSQ1BmdDk1anpSUzZacmpHWTNXekNRRFBMRlo4cWZaS1NRNERWRnJjSnBU?=
 =?utf-8?B?eml2U1RMMUJHSGlORXJHLzJzZlJHSlBqOUI2c25oeUhoTXlrbWNuVGdxZlVw?=
 =?utf-8?B?UGdXSmxraE5JR2FvOTkweGFxNCs5RHZ1cERTaE1hTm5QSFNvTnVxMnUvZ0w1?=
 =?utf-8?B?aWk0ZTlkc3M0U2hjZzFnS095MHBWS1VtMWpPYUM4dkYyU3JDWDQ3ZTVTQmFK?=
 =?utf-8?B?eVBFQUJRdHM3NUNDejJYc3VXR3FTOURXTEdZYVZlOWEvdXVVRGVpRzlHTlc1?=
 =?utf-8?B?UFIrZGNrMytOQVZZTFF1ZDlmZzdBTnpJVkV0c0hMVnVLdERRaVFnSlU5WlBs?=
 =?utf-8?B?YWxNYTc1a1E5aHRBRkNzQjdqNUlOOEhIaHptbFV5K3FadTc0YTBJWE9CN0R6?=
 =?utf-8?B?ZE9YRHRqNjEvL21wcUJ2WXc4N3JXL2d6dDRpcWk0RVBnWjlOT0FjNkRWTjhI?=
 =?utf-8?B?VnplSnRZNElySUd6NGJiZTJMME05T1F3RFl3bU85cGhYRGFqSVE5SEVLcEdV?=
 =?utf-8?B?L0UzYXFvTHVLSVd4NVl5WlU4MS9LWUFGem50QnpDeDNVUVIrU0FBTE45cmcz?=
 =?utf-8?B?R0JXeHRVWmhiRVpMQWVFQTcveHlsbUQ0aHVEOFJIaVBjZDZEMWtQZnJoa3ZV?=
 =?utf-8?B?N0FZajBQR0JsMG1tZzg4N1ZDdjhPbVFEK0NxWUp1QnJ0U25DUUljeHRNcWdW?=
 =?utf-8?B?SFJNeldGeGVHNk1wYlFySmVSZDN1WlFjMXdRbUJsVm5qMm9KbEZjeFhKeDJo?=
 =?utf-8?B?UnF6L0J2ZDF5cEVqajFxQXRmTnlFTEpSUGFvcU1kNEdCQWh0Wm5leVFpTVhw?=
 =?utf-8?B?WTlKWGNWRzlER0NPdCtwdU12ck53NVg0NmlmZWM5Z21IWitDTFJNazJNR3k1?=
 =?utf-8?B?RDdNMGVPRmhGMVBPSGxiMjRsMlFGK1YzL0xLQlNzV3FuallyMUtMMXlVU29t?=
 =?utf-8?B?eTIvZHBBTzh5TzB5WElScEhHRXNhVklMd2FoeHFrUXNxUTQ2MzdTRmFOcE1w?=
 =?utf-8?B?eDlLWmRNeHhGb0ZodlZRQXhTM1JlUEVGU0pzazl1ZlRSdUdnR0l1SUY4T2NM?=
 =?utf-8?B?NjNObWhSbVorS0J4RHBKczI4bkpJQ1p6K0pSWithRGhvb3FJZFBJdER2TFFK?=
 =?utf-8?B?Q05hMGVuK3FDeXd4NTNKL012OHl3TWV4UEx0TGkzaFF1bnNLY0hTbDAydEdz?=
 =?utf-8?B?S2d4d3lyZ0JpeEp6L0ZTOW1KVFJSS1FQV0t4NWhlZ1dlMWd3a2lkY0NlSUhn?=
 =?utf-8?B?NFpKRzlGR2puVXo0OC9VQkxvejFXOWJPa1kxUkVjRGRvQlFWR3hUUmJvTnJ2?=
 =?utf-8?B?U0RWbTR0YUN5aFh4Nm1VSHN1V0JkakxRcVBzeVloUC80TXMrSXhYUVhoYnRL?=
 =?utf-8?B?ZWw3eU51NkJjNWlRb0c1dlM1NFhtUy96bW5LQSswQWovT1ZqRDFiREU1ZWFC?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd346b9-7fe7-4d05-436b-08db67463bb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:59:15.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiY0358Z7wCP4e/TDu/xjP1EWL7IHXdmisXqx1qS6reSoFsIW10d3/yvDgti2rU5yIMed1YETYrSpDNRlmX7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_035923_264991_0D9FA2D6 
X-CRM114-Status: GOOD (  16.28  )
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



On 05/06/2023 12:19, Chaitanya Kulkarni wrote:
> Add a common helper to factor out secp/spsp values check in
> nvmet_execute_auth_send() and nvmet_execute_auth_receive().
> 
> No functional change in this patch.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 60 +++++++++++---------------
>   1 file changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 586458f765f1..847aa12d2915 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -12,6 +12,23 @@
>   #include <crypto/kpp.h>
>   #include "nvmet.h"
>   
> +static u16 nvmet_auth_common_prep(struct nvmet_req *req)

The naming of the function is misleading a bit.
Function name should reflect better the logic of it.
This function is not preparing anything but just checking and validating 
fields.

maybe call it nvmet_auth_security_protocol_validate(struct nvmet_req *req)

> +{
> +	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> +		req->error_loc = offsetof(struct nvmf_auth_send_command, secp);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +	if (req->cmd->auth_send.spsp0 != 0x01) {
> +		req->error_loc = offsetof(struct nvmf_auth_send_command, spsp0);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +	if (req->cmd->auth_send.spsp1 != 0x01) {
> +		req->error_loc = offsetof(struct nvmf_auth_send_command, spsp1);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +	return NVME_SC_SUCCESS;
> +}
> +
>   static void nvmet_auth_expired_work(struct work_struct *work)
>   {
>   	struct nvmet_sq *sq = container_of(to_delayed_work(work),
> @@ -185,26 +202,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   	struct nvmf_auth_dhchap_success2_data *data;
>   	void *d;
>   	u32 tl;
> -	u16 status = 0;
> +	u16 status;
>   
> -	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> -		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		req->error_loc =
> -			offsetof(struct nvmf_auth_send_command, secp);
> -		goto done;
> -	}
> -	if (req->cmd->auth_send.spsp0 != 0x01) {
> -		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		req->error_loc =
> -			offsetof(struct nvmf_auth_send_command, spsp0);
> -		goto done;
> -	}
> -	if (req->cmd->auth_send.spsp1 != 0x01) {
> -		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		req->error_loc =
> -			offsetof(struct nvmf_auth_send_command, spsp1);
> +	status = nvmet_auth_common_prep(req);
> +	if (status)
>   		goto done;
> -	}
> +
>   	tl = le32_to_cpu(req->cmd->auth_send.tl);
>   	if (!tl) {
>   		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> @@ -432,26 +435,11 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	void *d;
>   	u32 al;
> -	u16 status = 0;
> +	u16 status;
>   
> -	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> -		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		req->error_loc =
> -			offsetof(struct nvmf_auth_receive_command, secp);
> -		goto done;
> -	}
> -	if (req->cmd->auth_receive.spsp0 != 0x01) {
> -		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		req->error_loc =
> -			offsetof(struct nvmf_auth_receive_command, spsp0);
> -		goto done;
> -	}
> -	if (req->cmd->auth_receive.spsp1 != 0x01) {
> -		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		req->error_loc =
> -			offsetof(struct nvmf_auth_receive_command, spsp1);
> +	status = nvmet_auth_common_prep(req);
> +	if (status)
>   		goto done;
> -	}
>   	al = le32_to_cpu(req->cmd->auth_receive.al);
>   	if (!al) {
>   		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;

