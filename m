Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FD3C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbIwaj58F5r2p/cdBOHBiP2PsOrRTyIlikimNnnNpTg=; b=bVzNDKXKQdRNxh80h1tOfCL4B7
	B0HCAyxGH7FGthuFn+89IA8Tx4dQzKR3R2YC6CqfRiFPu5qt2GykO4lwghqjMtPkUkb6umG270fZ2
	GRFz60qSFHyBCrEBQCVvxA1A88P1Oh93KHUnmRIUFReVlOe0GRmdJFGlcMAtLf66qAYk/foV0Mc5g
	VxHtrAEWhWTaYQc5tQDee40bjJ05OC9naF4cnuz3VWVilSi7gEtJQf9Ruwp3wRZjq+8rMuCCD0eZj
	IA9mjfdEzbdtcSDbppVjEujoHZBGikidt+4Qd23GgxSaNVUqnTqixvX3qwMMDzCff8a2f7Uv8XWDp
	XaBXwoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbSo-002mHc-16;
	Wed, 24 Jan 2024 11:30:38 +0000
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSaQA-002UkO-24
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 10:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdURSlWPlXMrmK7XJVGW2T1oNgnPyKJMngH2fUiER3QK25jLGc/vHv0dF01f3xCYL9wlWFIUOVk6KuzSkaxkf50eyOplgRT8XsmL6hqo31FO3VDUNPw8vIBxJ0+B+mmOpE7MfAj7jNwOS8bh0SSyhSE2LdBdgARentvTSj5mh44TnxKK1zgdu/qAsawGLy9XvO1nBKH4WdPnUA1Ix19UZO6rNgGeF9groEK7rkV0k5EORyCqjIw8ZfhrJvHDHDeS5FSkBXqnQEFcqkCb1/Roj/curjlKTaS6ACtaEm8R56vie/7cpqxpvhBndEFYSaCbQIrd80fYbTOwqLISkAs5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbIwaj58F5r2p/cdBOHBiP2PsOrRTyIlikimNnnNpTg=;
 b=f8A5SMo/6oTgCRdGVwZExyoN/3miEqToeBwJ0ZX5R/gwH6xeHOLlYsFi4yvnG2xD8TvGAEMmwZ+k14tqjQh05IvKik/5yjtWoTQE1Of9Lc4WMqgxQN6pm5RtmPpovV/pvWGuhSXxKKPeeIb4dkm5+BiC+znRaGa9nN/UY5P8vmqbdQbEe8IX3shM3yQ4KOme1KUOWT9jZaFDnA682e80dVfp4W/hLVqKDR80rzQXYphMqOxkEQf7G14ZPQjBZEoZ/LiiMnD2pBtGr5Bl0bYo/hm/dP7mDdfCVPOY5S5MZds29zG2KS8HKhuF5bAmWVMUV6ZJZmrLp7aZ+YvP380EjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbIwaj58F5r2p/cdBOHBiP2PsOrRTyIlikimNnnNpTg=;
 b=UL7y0udbYR9w3ct4+sxOdG//GlHzoFNgFy+CWQYusk54GlavXOQyfN/3dWR68Sgkiptfzs1w1/MPlxao3YzRgt5md1QLBxsXhaDhD8rIefvbqjkeiNegV6Mb03bu7xxe+yR6WlWsZK8zANpOTp7fwkanET5OGNPtFxwJ0M52gHn4pHoDsDYFfjHB79I86vuZowOFPlRwwQmmIqqSUOnAwMqIg4BiTRAAKqGnqhTD/CRRDjnInAw2d7zehooA822FauiqMdLHSCQQr7LtfcqeYMzCs0Tl592EaAaNOyrGiuRRPq2Ti0XPzrSzOxdgg4tQeYf1jf+g9RnTkVAF3Wltuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 10:23:40 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 10:23:40 +0000
Message-ID: <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
Date: Wed, 24 Jan 2024 12:23:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de>
 <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
 <20240124094832.GA31289@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240124094832.GA31289@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 570fc38b-b935-4711-150e-08dc1cc68889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9wqQu4AySFq5UTLkTHbbFLy8/vKLAMnhICgCPY2ZTaQQgKH7B3CuIMLqpLZ+DS6L6HF/55eQlGweRWm0OkkJZH1S3uoutztUJ836XRHed/T4BEVmD1tN+DzsOHSoYZyVN6hCrAIdUqOgrwqvPOsPpNqdf+gG74qjFRW7nmZe1ZDswCV1VAwNLfS98SVkNGCDOvNw4dXJjMrQoMWQqwrDLFNYdpHoeq+N/QcYKAXifNLoAS0p/vITxO28FWWz0/PvINXXa914Ozl4qXYja1jfm3duD0jKw15lrmoDtTNtBlLx09dTXvZQzBUIzYDplARaCI40fAmHLLaRW7+vkAmxWQcE+PG/WZQ/kumFjDKlWHAs5neWQ7Wpr86hhUvuOiUkVvfkL/jTV2MDYxxSFL3FOlE8DCzgcD+T1hR1tvVYHJ/v3w52b58zI7Vuv/U/oRNYHMsx2nBRl0Z1U3Bt9TQnVhm8MFPCtSbu+uLx2mYHlJXSrHRVh3JqXSxCjWsBRq+rMnVi0tTbhxdWmFuXGGlkcsgGCuqqa6VcWsX1Dx9Kqyb9kwcO/ashpLrAE3n4K6xTHPvcCuNiREwIHCpGe2Gj0jx9QtAhLjcpADr9E92+ogP3aRSolY8EVfPIHG9J6ec6fI/0h6u8nZRGMEbm2/QDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(53546011)(107886003)(8936002)(4326008)(6512007)(83380400001)(5660300002)(316002)(6486002)(6506007)(6916009)(6666004)(478600001)(66476007)(66946007)(2616005)(26005)(38100700002)(4744005)(66556008)(41300700001)(8676002)(2906002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZMN0pMY3hQcURYbFhSaTRDZHRKcVp5LzIxTjB6eXNhNm1kdGlTQTMzSU51?=
 =?utf-8?B?dGs0TzY3aTNuYWRWVHhoTTRkU2s3T2dNRXB4Q0RqMis3WVVHL2Q4U2Y0UUtv?=
 =?utf-8?B?dThMQWdQbTNWNmY2T0R1L1N6ZkVwS1BOaTJpdUxRMW5iMWlPcEZsRFFXeUFM?=
 =?utf-8?B?cWxlcUM4aXo3ckt3NlplM0hWL1J1NERyZ1RRQVRZT2d2c2VOR2RQQnkrd0wv?=
 =?utf-8?B?cjkyRk8yRXZpN1NXVXA3VnVmelkxSDV1aHIwNXI0SXFTZUtyRzZaWVdaZEpD?=
 =?utf-8?B?d2NLbWRjT1F2M3hrS3RFdlMrSk5qWmRDN0VqSDQvQmw5T3lOV2R6a3RGWFp4?=
 =?utf-8?B?TnFZK3BBSWhFTFMvU3JjNk5rbVpOTUhUN2RpZ3ZjRXJlT01qbGlFT3BSR1do?=
 =?utf-8?B?TCt1TXBqYXRIRUxzVENkeElQSlhKRUdiWkhwb2VCb1lML2ZLS0orRDVqT2Vl?=
 =?utf-8?B?ME12a1hKM1Z1SmYvOGc3VVpkSzlwYTJlK3l1c0VyZ0hwRFB4Y2g0OXVRd0V4?=
 =?utf-8?B?Q2RueWhBVjVWS3AyaStIdlR3K0o5S1ZtQ3FIWFMyN2pzR05tVWV3L2VSTll2?=
 =?utf-8?B?S0d1S1FEWlJWOHM3dGVXRnJ0RU1pdFBpVG5MQjNhTWMvelNzb1kwQ1VaQ1ls?=
 =?utf-8?B?MkhMV1VuaUlLdzdEc3BzaVg5eTgwTEhTTm1URGRYbmFBNVBmbVdEajBtb1V3?=
 =?utf-8?B?WmhybytyeEZQUUFvTWJtbkZlQm5oZGF4R0V2YmRKbDBMdkZnNVFlVWxGdjAx?=
 =?utf-8?B?Qzh5Q2p2NnpPblJMOTdhTXR5MWFCWTA3ZGlxbVNHQjNxb014aU8yS1RJZ2Ni?=
 =?utf-8?B?Z2pQeE5vMHJFVExLZEsvNEJiZWl4a3RkTEZRejNwMEEwTWxiYjNGcFFTOExE?=
 =?utf-8?B?YTNLYm0yTmxsYVJNcnZobm1IUTljOGtuZ0ZGLzVqY04wYTBJd0c0THg0RGJ4?=
 =?utf-8?B?d3QzNEhidlE0VWZmVi9icFRaZFQwVm0rTGhxUmhkcEt4TUNtQ1U1WVFabjFu?=
 =?utf-8?B?TUFFVGpjU0JLekd4K2Y0Y1hsT2ZjVHh0N21vR2JubWZ6K1dsSEVvNlZqQ2lL?=
 =?utf-8?B?Q0cwbjArUk1Ec0lmYllxMmlrVnBtWGc1RURGRktLRmIwZTA0UUgxVHBRbTYz?=
 =?utf-8?B?ODFXN21zb1J2VnhmN3A3SWtDdG9VTjE0U21aRHlnVFlidnA1QmZFSndVOXQ4?=
 =?utf-8?B?ZXB0R2ZMTG5YMFB3VkEvb0l1dkE1bFdtMTFXeWRVQnpuYmQ0N0lJZnBwQ3Ru?=
 =?utf-8?B?RkJWSmNiek5ESnkzcDNxNTRoekRaby9Sb3MvQ21PajhRS0YvTzFmcHY5UGdT?=
 =?utf-8?B?cU9kbVVJNE5vWlBMVmxpc1FteFlrQ1pCZFhTb242RVJGaDVDV2FhRFlXVnAy?=
 =?utf-8?B?Z3d0R244a0FkVUlhWmMwTHhkWXdoSzlUVk5YYis5a3pNd2prZEhqT1NvUjUr?=
 =?utf-8?B?T2NwcXN0RWZ4SjhCUFkwbWtIZVM5c281OWNJdXR1TkZxRnlVYm1CNSs5UDIv?=
 =?utf-8?B?VUtEdldyZDc2ckMyRXZ5cUpsK3QyeWY4RXQ4UE9oVkhYSDNNTkdudzNKRnJI?=
 =?utf-8?B?V1ZqK050dTU2RlkzWnVEMmhoZVYxUThkeHY4L1RJQ3hRRzlaNXgxYmdFektj?=
 =?utf-8?B?STB1RWZSUUZMUTZQMDBJTXk1Z0RBZ2ZvdjM0MTlOQ21ucldQRThYTHhkRzRO?=
 =?utf-8?B?ZzVwRVg2WWUwNmh2SE5RQmtEbmN2WlFTVmZOMFM3OGcwNTdJdkhVOTBrRlFC?=
 =?utf-8?B?Y054VHAwS1dxVHNYM0x5aXhuUGhUbEJTcHhSVHowakxZcUQ5WTdYTC84UWhz?=
 =?utf-8?B?YmxCMnFkYk41TDZhYzRMcjJPUnVGaW1Mek04YTJSS0NGcy9qUEo5YU5DdzB6?=
 =?utf-8?B?N0xpQXQzRHd1ZFRCQ1dHV2pRNlFkMDJQSDNMdk9VejE4c3p5ZDZlS3JUTHBR?=
 =?utf-8?B?U2VmTm1Od2dXOXdCN0k3U0pMVTUzM0pXb0swR1o5aTdGVVNJZko3UDJYcFhw?=
 =?utf-8?B?MDZYenB2UE11YVBoV1c3YnhmQ0ZUWlZQQm9LeUN4aThFWUNDY0JjVUN2TExu?=
 =?utf-8?B?Y2dDdjlwZFdHZ0FldFlwV2dEZkd5ckQySjkzaWxYTHArZjVkRHdpdWlaUlhS?=
 =?utf-8?Q?J4mL9pZF6HV4XvWZcbworSiXH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570fc38b-b935-4711-150e-08dc1cc68889
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:23:40.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaG+hfPGP7Ol/S9kAqlgzEHr3wWAl1hbt2zbrzddBaQEM8B2wd16AgfP/30+9+p/hD+wpKrkZ6AYP83mjl0kYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_022350_680061_8BDAE6AD 
X-CRM114-Status: GOOD (  12.77  )
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



On 24/01/2024 11:48, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 02:47:30AM +0200, Max Gurtovoy wrote:
>> for example if a the PI was supported on the port before re-connection and
>> wasn't supported after the re-connection.
>> We must first identify the namespace format/identifiers before kicking the
>> old requests (otherwise we will get IO errors).
> 
> Why would the namespace identifier change when you reformat?  They
> should only change when the namespace is deleted and re-created.

Even in this case of re-creation we must sync the namespace identification.
For example, if the port went down, target re-configured but disabled PI 
offload (it was enabled previously) or someone replaced HCA to one that 
does not support PI. The queued IOs in the host would have integrity ctx 
even though the new ns/disk doesn't have ms/integrity settings. it will 
immediately fail the IO during nvme_kick_requeue_lists.

