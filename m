Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F29FC47DDB
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DyboI4W+UftpxjYEjCxG7weGZY0zdxMFjppp9QLmlew=; b=KasU59LIlJ6Ts6St6/Yka8CJd4
	DXMHD9ybrCzgLpQYJuo/EeLPrsbVKu8q4cVFd7FnTcKpBTdEqcxGRD3wLchQvlfRvCAQulM0Bnoap
	+yL7HTvSGahyZ7CVJQO5PcNmLVFb3hHChFV242enQF8TlLVHRxax9ukdq66Fu1XKnlOfnF/pKbb8Z
	OV0elgv0Pp+adYzkzT1uI3D1FrlpvL28hoHu9czL9LpdRa8gWOkiNdF95qM0CCaHWziM9J8olqAtq
	AgQewuWcRLD/w/Tk0cRjKQxj+aw2YSyvXtVMGEKQ9Vzh8v3u4pMwH9BqTQ1rS4F7IwyoStSKo6lUw
	9y18j1fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVUVK-00000007UnV-0bRt;
	Thu, 01 Feb 2024 10:41:10 +0000
Received: from mail-dm6nam11on20610.outbound.protection.outlook.com ([2a01:111:f400:7eaa::610] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVUVD-00000007Uke-40sH
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 10:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao4jHbZQB389gT5Hqa+qE7yUR3ySStqx3Xy3Yp/WyE82chHpFLJU8Ha2N5u3rocwFQpdtLaLs/ang2mK0DVhenN5CQNNKb1ubZ9WqJ3c/y4UhsFyctQowlctLXyNfmfC05OKVLvDJ+YMSmLVKGCQ5kFA4Dhj/WeECb9LlkzRa2xqxkfJCJr3OEghxXCEnnwuj/Py7b3VcIDHe6hNhnKPeNZvscnbhEyhb5GCp4NFiC3clUrn0CJindCKIbcAFUxXVwt15UMLuFo6GM6sODdrumHD0oYe4kB/kbqyrQt3Ud7JnZc4td3cjzAvYjyfNjZwepwfdj8MeoXziiT1oZ/1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyboI4W+UftpxjYEjCxG7weGZY0zdxMFjppp9QLmlew=;
 b=Wr/lq6jSQH0VDfg8LbCsXgHTJcUTA1KSGLGKIWKsowJuqZvMYBKMWc9cdDBjfvKJTacpIgy5aDdoIBzUvp/Bcx+hvv6in9G8hlzuPfhNfJLx7W4t7x4QKA+QkJfC8xJf3U1aLf1TO+doQeXlEY0aG8kLEHOYW9LAu/HcDmsyeHVgXd43UU0ubzbnuiQCP1qN95X34BuKAXUANjlGTDORVNjcCL15sJvSRiJTdql6WNLoeHP6/0RdkgYj+d83azo4EanVUhJbpy5bcDYb5Kx8R7jedvqkA4Ke/VAlY9TEbN8qqUskCWL6g8CvIU9V1qOu9sQjv8InPs0UjgBGBrsgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyboI4W+UftpxjYEjCxG7weGZY0zdxMFjppp9QLmlew=;
 b=O63PaAHAgDWvgz+xPQyLZBfSaDk57rveVabn4NHzQ2t9t6i840DDX2MsbAFf3dILk2k5FY2Ic7hdRbcxvbk9DLsToq7TQ4nooxFXGk8IJcN3bp8pYbZQCB9g0nn8QfQZTqbIWv3os0JfuV/1yOZ+OdInDEuuylzgoVsAcG0ISlsknEEkxRlyPsityp8qhlux1k5XlZS1vvc9U/DsgbXsNiD74pYnnwkwtydma4ULaQV+VOYTz+2TqfMTBSTgcqMx8jw4xjeY7JQrsIefWPHfpLg8C+eQtIG7DA/rnvtlkmf88p1vg+fPklAYh8QsrChftcUHnH/7ylLJ6N1s2dwZkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 10:40:49 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::b3f:993b:6a9:17bd]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::b3f:993b:6a9:17bd%5]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 10:40:49 +0000
Message-ID: <57fd58ac-7361-4af2-8c51-84a93604de31@nvidia.com>
Date: Thu, 1 Feb 2024 12:40:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI offload
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, oren@nvidia.com, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-8-mgurtovoy@nvidia.com>
 <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr>
 <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com>
 <acr7me2i63tk33ljxst55ifobw6vqnp7mtnsiuv5fszwimrcyj@lnmydpvawzfu>
 <juclu4662fnok7u6bh5hnekm7ggqly523nnh5mfbzf2nyompjr@ykwshckwj32s>
 <20240123090413.GF30773@lst.de>
From: Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <20240123090413.GF30773@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::8) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 0413705e-6ab4-4c3c-12c5-08dc2312418c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rhd/EciHFbx7Ee+D+jEyWAHP0LKIYHbBDC1XEIkfbQbqTZNZnBOeEHOIvc+g3/9EJjF5q+hKTVRe2V33xPjr2PyjoRsN0UGGVKsU2ndID20H/QThBkUioSLqDzypE441vE0MIQs377bJPlFKEMtfceGPMUbnlSrhRy/2VhME3blOjdypxEh2a0DJRKLnVv63SU/hT/GwnhiyPimoiphHOhGhyV+dbpOELUGIDfGjR/ArKsyVbTOUfrL62e2qaM3brMCY0Z5kCScMzJ1ZmNwgwNtrmnRjylcj2XSPdA2uNiiLtGcFyRaMOKfw67DuZvJ9Kz7/3yPJqC1Dup+3QhIRAvc6DGFt+r2xDCeWCgeYvR86As5N2Bi7zQ/f7mGzYFBQdaaNmwYtdIS5MjHNXKgdsiWA2LRFSsWgPba9ThpgWvX4aUCH3kWbQrFtrf6FA09GOfbYGoMwCb7E5401zKhiPuo3LMJoo/AAz7iI7tHTMXb9g3y5DTn1S1IvVbx2btMTHFbbeQrotSXdVP+Fd7HkMdyOSTP2IuOgssfsekyrtbWB10H8drhA8PRciHyAND+CF7ya1L0N/4IV0H80wTvnx8kSeC2OgocPGD7oGrnXTTpfLTbarne0IaNLdvU6RafigJe6JX7cVAYAHoyNLycmxQjMttkUFCFNxNo46KMDytaWAPGaPujWIwwqJXKfah5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4409.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(86362001)(26005)(6486002)(36756003)(38100700002)(478600001)(6506007)(2616005)(41300700001)(83380400001)(107886003)(6512007)(53546011)(6666004)(8936002)(316002)(66946007)(31696002)(8676002)(4326008)(66476007)(110136005)(31686004)(66556008)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhTTUtlQ1REZ0g1eDdpUW9LYUNOUlRXVUdNNTA0bE1XWXF1aU5jQ25pVDdQ?=
 =?utf-8?B?R1dNWlgzc2hQNHBmcTRpbklnQ25OU0o0N053cDQzcUhaeFhnRmdub1JDaVpp?=
 =?utf-8?B?TlFlSmFVS2lSMWpRdVhhWUFaTVd4VzhNUDFPMjFzM1d2Vzd5QTJtQ2FGVUJm?=
 =?utf-8?B?eFdqZjJNMjd6elVsbVpLeHQ0MHAxOUpRT3ZjdXdWemx0NVhwS2V5UEZKNFZi?=
 =?utf-8?B?bXJ1cTdMR2JrblV4K2diQlpIVXc2TE5adEoybitlY1VuS3dORklqTStxdVJa?=
 =?utf-8?B?OGpjaFhtZUJMMWNSenRxTncxaEhZS0JWbVNndWx6eC9jdlNOeWRoMVRvcmVO?=
 =?utf-8?B?c1hpUGM3d2VjT1lOY2c4Rlk2aW8yN2NpRDl6d3FuMi9mOXRKWWFhOGlvUkxv?=
 =?utf-8?B?Z3RIZ0l1clVaODNwTnVwRnkxd0lCYUdKMUpFWU4zdUZVYlZ4SmRPQ1lzOWVR?=
 =?utf-8?B?Yk04OHpkRXowMTJGekQ3T3FBczJrdldqODgxYnNPQW9iMUVVcFFqNUMzMUlV?=
 =?utf-8?B?em1nYzNqUFVuSWpIR3FydlN3bHBwZ0hQQytUZnorWkJzMUhuTnFaWEJYUnRr?=
 =?utf-8?B?ZnJqQUdiT0xXb2dpWHMrUFJjd0NQZStJZ1BxNzFIOVpnU0VmaU9UTXVHSHFk?=
 =?utf-8?B?RmJCZTF6bS9ncFh4VUg4SklYNHJ1K3Z4UmxPS3lWNGFWYllML0ZyRXRiYU4x?=
 =?utf-8?B?K3QydlpqR3pwekg3MFF1eFo5NGEvdDhQY3hMMXZRQTF3VEx3ajcxYnVyN2N3?=
 =?utf-8?B?ZTFsWUthRmVkRHdVSVNHTlpwVmtQYjFjZXM1bldDWVNTOGJZam1nRFUzdXlD?=
 =?utf-8?B?amtxNXhlUFVDa2xiNGpmS0VSUXBrTFlzR0NTRGIwcjRVdk14c2RwWjcxVitt?=
 =?utf-8?B?YW9OVUYxaTNTVDY4YmtsWUoxTzJZRzdSSVVZUVN1RWhqamVoaUh4OFZzYTNu?=
 =?utf-8?B?TFppUDNJaU83U1hvQ01Zdll0MFplUjZ3Qk54Y0lXRGZYSVVHY1MzOGIrbGQx?=
 =?utf-8?B?RDQvcFF0V0FDZ3J4MXdGNWkxOWxvZzNMbVNFRCtNZE5EVUxtaXpuSnFYenpk?=
 =?utf-8?B?bk5YUFQ2SG1wNnVWTldrdTFBbnMvRGVIV3dwaVVOV1BNZDZqNlQ4S1dYN1Fx?=
 =?utf-8?B?OXhybTRYeG5lVWdDUEt1TUMzM1IwRUxmSnBWeDNVbnF4NTVDN0wvbEcvbXdt?=
 =?utf-8?B?dUhEWkJadmhPRjlPNExBbzR1dFpUTytHNHZXeWRSU2lFd2pVV21sUE1UZVRl?=
 =?utf-8?B?WjdJMU5URDJiQVVaWWE4Ym5xdmpDZXhSeDQ4dHNEU0JPWVFTQll4MWVCaUla?=
 =?utf-8?B?K1dpNHZ0bCtiY21YY1JxVGpYOHpIUmt1cTJjbTNEb0dONWlsSjV3QkY4NnVu?=
 =?utf-8?B?S3J0Y1NXWVcyR1FiR1pWcmwzTlA3QXhLQ1Y5Ri9VMVlFd3JPT2FHbGZIZ1lQ?=
 =?utf-8?B?TkhyRzhZWUFyTENvcHRRZ1hyV0pndVBIeWVDRk14aWVBcCsyMG5sSnQ4RzE1?=
 =?utf-8?B?Ulc2WUFMTWJ4TU9zK1lUa09ZcG1BUXNsQ205SHZxZXAxOUhCMFUzTkgrVlFt?=
 =?utf-8?B?QVo2Qmo5RXpFMHRvSzdXRFlvSHg4UjkxVnhtS2FJS2kva0hDcGpIdjBtbnJK?=
 =?utf-8?B?NmxqR2F1WkFOU3pZUTV0YXY4WDQ5MW1ZOEtrSFVDL0lmTmlmdE9KSFNKTUQ5?=
 =?utf-8?B?anJXd2hsMFdVeHoxWXJCWU9saWpzOGZXTVQyaXRDT2gxUnBtYllIeEl4Ynpr?=
 =?utf-8?B?bnNMZVJwOEJjWmNYSSs5SkxwcGRXNVdOL3pIZ2NGdit2b0kvdU9qYjBnUkxO?=
 =?utf-8?B?N0U3VG1GTHN0ZjM0dk5FMG55amNTbTlCbG00S3RsYWRFY1JPS0FLdW1oUUtB?=
 =?utf-8?B?OW9LdFlNM3M3YUVUcE1rOUd0bjUzdGNacDl3amg1Y0kzUUpxdE9wUC9JZXhB?=
 =?utf-8?B?UXAyU2FaanB6Uyt5aElBcmVtTEY0amw4S0ZPMEJFWjJtZEJVR3BZYVByakdT?=
 =?utf-8?B?eGZORk05Ty8zeU9STmtIWFVNZ0x5VnJtZStXeURKeUVkYVkrUE9BRjBRYzRt?=
 =?utf-8?B?aWxUc0NRNlhDalhhRVJnd1NseFIzTkRqSUZpNjJ1VTVrL0xGT0NXMXhqakcv?=
 =?utf-8?Q?E+n0Yi7WGql/OqXD9IrW6oX2l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0413705e-6ab4-4c3c-12c5-08dc2312418c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:40:49.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDQ/cTtKv1tPMoameOa5D2vAdYJ0YyCo28DSZ6YmyymEeQhdGWfjnnH9QiSVmNtuVPSxahHsv54XQk3VaSc6WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_024104_037242_F2EF899F 
X-CRM114-Status: GOOD (  18.52  )
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


On 1/23/2024 11:04 AM, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 04:28:53PM +0100, Daniel Wagner wrote:
>> On Mon, Jan 22, 2024 at 04:27:08PM +0100, Daniel Wagner wrote:
>>> On Mon, Jan 22, 2024 at 05:17:11PM +0200, Max Gurtovoy wrote:
>>>>> What about 'enable_pi' instead of the inverted boolean logic?
>>>> we can't change the default behavior (that is "enable" by default).
>>> But couldn't we just have
>>>
>>>      enable_pi = true
>>>
>>> as default then? This should be the same as
>>>
>>>     disallow_pi = false
>>>
>>> ?
>> Ah, I get it now. This interface doesn't work this way.
> The match_table_t infrastructure does allow checking for paramter
> values, including boolean ones.  And this would indeed be a good
> use case for that.  Extending the existing boolean only own
> flags to that would be nice as well.

Do you mean to do something like the bellow diff?

Regarding extending the existing boolean flags, are you talking about 
hdr_digest, disable_sqflow, data_digest, discovery, duplicate_connect 
and tls flags?

I will try to do it without breaking the existing nvmecli, but I am not 
sure if it is possible.


diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa88606a44c4..6467b32e5d50 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -673,6 +673,9 @@ static const match_table_t opt_tokens = {
  #endif
  #ifdef CONFIG_NVME_TCP_TLS
         { NVMF_OPT_TLS,                 "tls"                   },
+#endif
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+       { NVMF_OPT_ENABLE_PI,           "enable_pi=%d"          },
  #endif
         { NVMF_OPT_ERR,                 NULL                    }
  };

@@ -1020,6 +1024,13 @@ static int nvmf_parse_options(struct 
nvmf_ctrl_options *opts,
                         }
                         opts->tls = true;
                         break;
+               case NVMF_OPT_ENABLE_PI:
+                       if (match_int(args, &token)) {
+                               ret = -EINVAL;
+                               goto out;
+                       }
+                       opts->enable_pi = !!token;
+                       break;
                 default:
                         pr_warn("unknown parameter or missing value 
'%s' in ctrl creation request\n",
                                 p);
--


