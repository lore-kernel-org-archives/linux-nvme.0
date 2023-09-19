Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1B0CE79AA
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQpDxpfXXhl/SOoD/UlicBtMCB+b/3umDLLE/x3xU4o=; b=WcJXtx+o5tbaCfPY+8zaNTSkXi
	qM9SVJzvd5RR8wZEfqTO5YNZ7T8y8jM4c+WsKEmjcsYDJjipLLN4VTAYmCmlaT9vKS8bXfagrPkCO
	ldbu8lJ5Xe9O7VHBg0sNSVgB2xCw+c1KS6YEIIPaQqteOABsIUZ76TXuMb2ty1A5ph1u5EqUBdw+2
	+ZOXWqOrCDoL8SXl7cQbJe30coJSrqLIxALK8TQhHBnCTx9xP5khZYI5K5IoyIafrxVZ78utblsU+
	7B1NeJSVdvU1T2G8fgNWTtPc0fx1ynbkumq1JfwfdDk4TNxD4oSTcuoW52OkmkN0YLssA7fSRGQIR
	dObSSA0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qidBc-000oi8-0t;
	Tue, 19 Sep 2023 16:02:52 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qidBZ-000ohE-1O
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 16:02:50 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JFxHwB019035;
	Tue, 19 Sep 2023 16:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BQpDxpfXXhl/SOoD/UlicBtMCB+b/3umDLLE/x3xU4o=;
 b=H7xdddrUgV6Ddbr/L/Zm3DGh4Mcs8x4L0QRcEcOosIAZmutyMOiik7Z/d2xB79U4aTBm
 VxFCaFL09J/wZJDTHc3uyubHgQk31npNclgypdTRDE5MFtHwH4EzXI/bjY8ZlQFX0lRh
 ZDsbeQiGqBQ8vBNrRyBmahm5E3xWJq5kH0TWIP9YtPtd+lKxr8UU1+heSjIbBv1eQYv4
 y5uY9PmPqxwZVUh0c1FsCthtxxdijRED5kUmX5jR7589bpkU4oo/W91WeMZZaEdMVtIo
 tIXuSPIuFk4abT7+gwKSkWZSB4dBhguGnM2U12q4V8QRz03UDuQBMnvnhTjzjnew50r7 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352wb3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:02:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JFQUZA030778;
	Tue, 19 Sep 2023 16:02:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5vb92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbkHkR7qJIp0vs8qZJ4vSRP9Ggd4N4GuFFKyRMT3RqqP5v5pIN0QDjdBZqbbytvxp/p8QIzWdyNGEMZM4uK3CwCnexkBPxFxU8+VRlRn+hE9eE1vWtmu9CxecsgM2mf/74VyWBlZyFokDA8hYDBnx9+/sdhDc6bY0Mf39JnF6W73HPqgsqTtF4FM7ItCv0Bvm9RtinPfMjJ1kAlINm7U1MalCXLkm8NZPGmQ+2Oh0RoFu9Ob4k1y2NZjjElxSdNi6Dwpy+bBxvk2odTz1MnkV6zbS+HQg5A5MOuhEQboS0vAVVXRgQ+qc8YtaOKFjAb0DPZe8tHZKsYapkH5Pbsydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQpDxpfXXhl/SOoD/UlicBtMCB+b/3umDLLE/x3xU4o=;
 b=kj62IAxBz354K1VKJ99PiQa9guOSPI2Lsrv+Q4rdUxG0voKTrzWWK0ktgUojbSBGFlJ9RrTxO1fh70dB8VA5ih19tSwZqIp5q1K7BsnkF6DShN9ohCja4wSI+71YYWfcOFzgslelxG0cg+JWQCXsYYsQSXgvgPWStnVPgQb5790YiNquNZjXPZqXi9z7eaFGc1pWNCl+gLLIldMM13mLHPHjXvMEfIXoTBHZ/LIla+OXu2xuOH9FkJGyma90hC/eVUQgMuZ78o8nuGHKC1ySJxyurSXmCEoBbugFqeiBQ0JlF9WSxlpwk2aBssfMzQmdIrZm7NQ5GglftGfZ3JVqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQpDxpfXXhl/SOoD/UlicBtMCB+b/3umDLLE/x3xU4o=;
 b=LpMVZpvKrfbTZdElV/OD6y73Po4z8dcx1lBaasWUwfBWEiDcefFgtitAjHL5yIZ2B8NJ1whd5gdsNuMFpHo5gx2+N/lBkq1D3W7SoGr7N59MhRfTZ+nRzw5gsfJGGbvPGjvxgecL+PULk2/TvZVeKZgbR1L/b7O8l3fFvpT+0HI=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by IA0PR10MB7665.namprd10.prod.outlook.com (2603:10b6:208:484::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 16:02:30 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::9f97:8257:319b:9ef8]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::9f97:8257:319b:9ef8%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:02:29 +0000
Message-ID: <8ffd46aa-81f8-4b82-9bfa-1753bb7610c9@oracle.com>
Date: Tue, 19 Sep 2023 09:02:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
 <20230831231827.3896883-2-alan.adamson@oracle.com>
 <20230905065348.GB19754@lst.de>
 <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
 <bb57e86e-654b-a4b1-e60a-7573e59c30ed@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <bb57e86e-654b-a4b1-e60a-7573e59c30ed@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|IA0PR10MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cb73c2-c039-4499-fc8d-08dbb929d36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLwemCYmQpTziZQeltqmSgJLE43IyUeK1DwgY6MzUPZfAXq54yO/EFVNYEtFkwqDCqgL/preLKx7w+ga0BI9JEB73N5AOgpA8m4LSabMLRqW2J95g1CsPLWkPqn+H/okdroVJ5/tdFhpJff56ZgCTcn62EM0WOYMf1mOMMrOd5zSNBo1X/4nJ0xEuTfBgd4ATHk71JehhMbKqbswwMpfyG9JzW0fzIDxq36+HLZ9rKbhN19o/28G+hcQVe0m855BwToepEMqUK8vW5bInITqsZcKIPL0PlrqrQQCx5OVkEb9AXn0z2yc8rQo1DBQBfvH25hE7XQ9SfeY+G5iGDs8dkFfxCxfgPUvEbSTbvdK+4XoSWt9nkNGJH38vnNYMhuGrVmMqefng9BPuMgfOXHq4UX5yL4vzRCxou88RBisNkO3rFT0GtC+wJCdcnydGNfhW+3PrgrbHEMEnnAJjoGGv830aIvRjtktFigLajx4ydizCuQI4YiDhHlFCQ9b2qsrue2CrH+UOrLITw49Al5vO1v68oYju4dhzNPPc2ATLRMUeyQCikXURBJ0zqahEm9I7m85II8P2BK1ot0/KugX0LvmBJYfziIgYufuDqJolo3KBjLqBJlGpD1EOMiisQbI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(186009)(451199024)(1800799009)(6512007)(9686003)(6486002)(38100700002)(53546011)(31696002)(478600001)(2616005)(66556008)(66476007)(6506007)(86362001)(83380400001)(26005)(66946007)(110136005)(8936002)(41300700001)(2906002)(5660300002)(36756003)(316002)(4326008)(8676002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpJem1rSlhiQ0VuSk1CMmk3V0JGd3dWUE9PV2tvclZRclpmY2pSdklYTGpr?=
 =?utf-8?B?ZjFrQVFuOFBMUWRyY05McUdvaiszWHV0aytCZEgxT3o2cnpTNlRjaUNVZ2ZG?=
 =?utf-8?B?TnFCNnJoOFhTM0Z4MlJ4Y1hONW8rUEJVNk9LN04vbXNhR2VWVlkxdDEvQUR0?=
 =?utf-8?B?bXpteFRrWkZ4aVF2TXFmQTh6QTVnWE1uY1l1ZXFJWGptTVRNam55UmR5RnNJ?=
 =?utf-8?B?aUkzR3d0bEtXV3Z3OXNBeHY4dE52V1FRdFkrbExZQVdYYW9RcnlBZFdncWNl?=
 =?utf-8?B?VitUNjduVHFpWXRqMTAzQW1MQjQzbEpKUnRoTHZJN2o3WGdLTnVpdGVnNU00?=
 =?utf-8?B?TlpEMm5MbkplNmltVlFYcGNlWkc5bENyVWVSKzZuajhjeGthTzRjOHlSaEhp?=
 =?utf-8?B?OHVMTXk5VVZoc21GYlQxVWM0Q3dHY3AxVldTNHBHQ0ZnQ1dFaWhTRk9rSytJ?=
 =?utf-8?B?eFptNkVPNU4xWEhrYUFqMC81L2Q5Snp2Y3ovcGhGb2NkdlpKejVwUWgwRXFw?=
 =?utf-8?B?SUN1Sy8yNHBVVVZYb1dZc1FrWDA3VEhuMVBVQXJHcjBTdXhzYjNBYjNoQmxx?=
 =?utf-8?B?aDRvUi9WOU9hTER3M2FCa3VwNTlXZHJLeGxrbmkzOGxHTDVZM2NtN1VHblp6?=
 =?utf-8?B?d1kwMUVuMDRZZUpyZndqc2JVdXE3Vk5hUUszTkl6N1JiQnNBOFRObW5TYnBG?=
 =?utf-8?B?NGFjSytDbGVyYnNuMnRZTDVVSDNSbHM1SmpHeWJ6c2MrbXNQWlZPMlJncUxt?=
 =?utf-8?B?NFExRDhsamJ5TWNYVDJkVkwybXg2aFlyb2VhWHdtanp5OEVNQjlGY3ovSXk3?=
 =?utf-8?B?V3lKa1IrajRyZnBuQ1RvdmF3enRPNFZGK2hYblRKYnZVU2Y5MGdkM0VJY0xL?=
 =?utf-8?B?QWp1akNFWEJuREJIMm0wQnFWN0tVQmtXbnZkT3VIYUJ0MkpqZnM3Q3VvRGFN?=
 =?utf-8?B?OWt1eVZ5VXljOEM4d1dlSHJZZDhFTmNmcU14dlJVbDNBT055YWdpQVp4TFBz?=
 =?utf-8?B?S1NIVnJ5alJaQUxXZkd3UmtHTm9MRVYrdWdwUDl6OThEYi9MQ2hVS2paU2Vj?=
 =?utf-8?B?L0NiWVpCbGdsbTZsWkFweXFDbWxNcHdmR0NiSHoxNlpDM3lYY1NaMGR1VkRE?=
 =?utf-8?B?aWErcXhiZ3p4UVBNZXZUanpNQUFKbnh3a0pkdW0zWFRkWmVLTmp1NnFXN085?=
 =?utf-8?B?S3JXcTV5UTE2L1NjcXFDUmVIRVdnS05IYmQyOG50UUdLOGRDVWczV2tRYkpn?=
 =?utf-8?B?Ry90ZXUxcGVyV0NKUW0reDhrWGh1NS81bVoyOEtVYU5ZUkxEUGJyeEZHYXFk?=
 =?utf-8?B?bDlPKy82SEdJRVdKQlg0UmsxTHU1RUR3emZISEZzaC8xT0plenM5SE9rczl1?=
 =?utf-8?B?MEhCV0xGVDA5NFRJaEhCVTJ4WnZITU1RUE9TcTlWbG56RHBydlE3RGRiZ0wv?=
 =?utf-8?B?MFJpLzRPMzlZbW80eUx5dVZPVFBMYTVGRlRTUGpZVzlTM2c2WlIyNmsvaTZ3?=
 =?utf-8?B?L2MraVJDUWNPdGErZ1lmbUI2eFdldExzUkY2WkZjeXhRd09yV2ZKRXdCUjNQ?=
 =?utf-8?B?bGFnWFFKS0hqL0RsYmRWbGV6dkROYko2UFlhY3AxRlYzNUlKVTZiQkxNdk1D?=
 =?utf-8?B?VVVzKzFWbFhPMDhvNFJJMklVcHVVTmdGNzZiT2tPRVI0d2Y1UGNabXpJZWJD?=
 =?utf-8?B?cGdRRnVrVjJOdzNFNVhpQ2cxWHJuREJBOHNabnhzTjZkdE5yVmRyTWM4L1FO?=
 =?utf-8?B?WUhHYm5FenJNWlZsQlhrUjhmeUN4aVZ2c3IyaXhTdi9nUFNCOUV3RHR3OEFn?=
 =?utf-8?B?Q1JoYm5nekgrZFliaXhIc0NXWmlzVytCdU9aa3JnWGxwOFdPbFlTME9yTTJS?=
 =?utf-8?B?cUZUYmtBcjN2VDFVMFkrTEg2VVMwUGhhWmd3Z3lYeVlhYktldlJCZHV1VHBW?=
 =?utf-8?B?V2pLMUIrU0wxN3BiMVlWSnNKeFBkRmVzVnU5VnBiRUFQVG1GS3dZQUtTY2FV?=
 =?utf-8?B?a1QrQi8rUUFQWFhqWFAwN2p3WTBVTi8yeTJTdGk1eGp4eDZBZDB4Zk1xZi9p?=
 =?utf-8?B?d2hWa2dPQ2duS0M5cmFqR2dPSk5zQ09IYndxOE9OZVF0aGd5eHJpTEtHU2lV?=
 =?utf-8?Q?lLvNnK+aicawAgr6tQP8rYB2k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ykInCo7SLVqzawk0Hu+KMlrh379iY4fOx1hoGNUSoqUAR7abQK/yYIPNOWRc+3c9OYq3DSIL5ofH1/50t3fnVGG0SEtOda+vi+Jfgo3HC5Yhri7kE1cekc7E0e0I9oPn83J43P2xt5vI2NLYXwft/kp2efeOw0jePwDh1VS2UHQ1SF6q9g8imQbP6lUBdmzIJv62EeIU4UBxJ9v2Ll9nQOPSfZgj8uhtcAI18NUNII2pjIAQAfkWlF6uB2dfROyM75nltYMz3qQ1sEfgZO1G1/v935Hhi3wIRHes2OC/c99ujMmMdtOF/X87te+ylKTz13+5bBA8Cm5ZE1O5LDiy26bD46qCK1x229yGfJ8cPsWIAmD2fOywjFc5qCvW019n14sF94NFd956HgmpWhWbRzzCM2i/kE/AhBKNy55UXV4dLx7Dqw8PUqb27iPBph9gcKnPxXDqzM4/YAZqNZoQ2kh4JzyMleSjnfb/RDh2noPxgZxN5CyzSB8Fs+7rczoihw/J0+2/Y16gIot3CMqAMkHu3vZFcY5gP/sbBVMy9ApxBkV+54IUuCO5dgSWwiVueS/C6bCDOUf9A4CRLUiGpt8ECa67tdAnLcCab/dpx+9OuRKXrc1T6aiGGp9ALR6JdQO0CBYNLL5TG1e1Fved22TPj1J3DUMvU9ordFgTcILnEUbbZY1DM0tA0ltrIuCm6+Hs9LFIV+1la1noOMxueMo/ciED3ztaUMCp4KnfSaLGGGof3qpnlYa0GDmvsV8fK91hawA6/Z9Hk4JicKxInAFdRdzelWlE8gdhTgR13Ws2I19BA1pwYtVtPCMzXlSWBnYFdTwP5sszTINZZA2TFIdPJZXKBVq++jOheTBJW9auTBMoOI+U6zT2poWMJK4W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cb73c2-c039-4499-fc8d-08dbb929d36c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:02:29.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EUDv6U+iYECQYmSNN4wGNmTzsQsDYf3o6Cjgiy/fAXmxKKo4Vj4Wh3RZGzyuwhfJ8ALZWissyrtPumJk5L7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_07,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190138
X-Proofpoint-ORIG-GUID: QRp7Xs_ID8TTxb6v_AES9Rsad2U0NDhO
X-Proofpoint-GUID: QRp7Xs_ID8TTxb6v_AES9Rsad2U0NDhO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_090249_635265_12AE40A0 
X-CRM114-Status: GOOD (  15.82  )
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


On 9/12/23 4:39 AM, Sagi Grimberg wrote:
>
>>>>       if (req->q->queuedata)
>>>>           req->timeout = NVME_IO_TIMEOUT;
>>>> -    else /* no queuedata implies admin queue */
>>>> +    else { /* no queuedata implies admin queue */
>>>>           req->timeout = NVME_ADMIN_TIMEOUT;
>>>> +        if (!nr->ctrl->passthru_err_log_enabled)
>>>> +            req->rq_flags |= RQF_QUIET;
>>>> +    }
>>>>       /* passthru commands should let the driver set the SGL flags */
>>>>       cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>>>> @@ -687,8 +720,7 @@ void nvme_init_request(struct request *req, 
>>>> struct nvme_command *cmd)
>>>>       if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>>>           req->cmd_flags |= REQ_POLLED;
>>>>       nvme_clear_nvme_request(req);
>>>> -    req->rq_flags |= RQF_QUIET;
>>> Isn't thisw now dropping the RQF_QUIET flag I/O commands that we
>>> previously set?  While we're at it, why do we only allow passthrough
>>> error logging for admin commands anyway?
>>
>> While working through this, we decided that for IO commands 
>> (passthrough or not) error logging would always be enabled. For 
>> passthrough admin commands, error logging could be enabled or disabled.
>
> Why shouldn't it apply to both?

Currently, we have /sys/class/nvme/nvme0/passthru_err_log_enabled that 
enables/disables logging for admin command only.  Are you saying it 
should also enable/disable for IO commands across all namespaces or 
should there also be:

/sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled

/sys/class/nvme/nvme0/nvme0n2/passthru_err_log_enabled

.

.

Alan




