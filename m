Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142DDC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wU8pkTmoPUtlHuTbtOjh1rwTeyzSgUWEFrDpP95aFPw=; b=gOC+wyrglxADGDdgw6CSloc7n9
	b9oc2+vsaaRKVPXluKvOB/heP4rfysmV/8YpoKgIokPcvHMpcovzC58mdW9Co9FkxhVP0YU24GaFD
	GKDMn/eNCHz5hxQhRGLHPU0M3oMyUxYDem4fbUjzBGnt3WzBvOwvShpGOqYNk/T2Dad1cwddWJGKm
	Ayv3Kt1fYYTmG3nkd+LMbLTwxjeo0/YTyk4EVAi+gQBL/gOsqKffjXOmYk6t/Oq2ZkShvlsaMBWFj
	3U38sxBw/vaTbyodzcvog84KnDdVhDHyOdDVMIy2e5bqxXOOnGfF1xninIWfJjEhx3p48fKlBFqS5
	VMAK9R9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9s2-00CIuW-1k;
	Wed, 03 Jan 2024 22:37:54 +0000
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com ([2a01:111:f400:7e88::614] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9rz-00CItQ-1V
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 22:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3l/f8474isY+md3p83rJYQwMUk2MNNuDIpBXmVe8fkaMTxvpcgNwjBnd2SFGbJSgjwnvq+PRgm/Rmc9pEjwpsLcYxsymoXvGStoYSChHgVejKVrgHo/y+sqCj5QnlnukH6VBqpXXrnl+qxgiG2t+YbMfpPaQtyHJwpOEbj43nPaY/MNUszZgtShMk/EZr/7YR0tngwB7AjicnhUpfTlVqCIg4MW+N1DlyQ6pLOkyllh/zPHFUNa6rs9g9n3nPWNs19yP7ThT89wtf/+pNOcGBO4pz+UqKdC5gUAo/9F7Eeh19S0mtOb2GzfsGEzAaf1S7C4/jpizbfLSrWeNHeEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU8pkTmoPUtlHuTbtOjh1rwTeyzSgUWEFrDpP95aFPw=;
 b=LuSYEdi+LpZ91FWeU2pdifwgwJpf6zU+AMnPCPBYQUXkJ0tesE7B8U4mNsIaxJexcke4kvTwlnh1HMQqPDD4bvrc9EKCeHkeG7vmnkUNaiORKY2WShXF7GWpFvWQKAeFfBsYmudxjesqKofPnvhc+UuASmtPYUrkHRl21ZyV1yJZAB+BIEQobCQt2YlSCUXWCSrnZuXvShGyiN5+JPtkCRzJ4CzDMUrNG9oOy2ELgdw1YFp/e+DDMt2hjHpOL5r7KzT4mPRWpXwt1r8gSt++CYvDS9KsQqzmjEenWf/7Zk5dsxpGMXMm0KgQQBhy2iqd+PLEouZRvNTJG63512Ok+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU8pkTmoPUtlHuTbtOjh1rwTeyzSgUWEFrDpP95aFPw=;
 b=RtMJSRgfRol6R8H51OYdMoqNj109eq7MntXk45s6SjC7iVlo8B9SONItH3yKAIg5Z9xykz2+17OYLg8ni1sYULiAvxa4c5azcTu8gg9oc2kU3iYVnLUuKBUI0U6Xv41tcbGA4TipD6bXrtIJ61EIxeURRNj7MOgiX9P1bJAhZlnbU15BgVuwqmdSfPuumUuYRuz5eY9AbyqClwRXDG2kU2p+5v7dlp27sPbJf+WAbBIE9ACZlldCwOHFBRoWD5yJQzZ1x7g56tBZpr0qaX0qyMcCuwWjD0xZ5ng4rpUaFc/4DFc5QCccJnQNW0PpXwy8I8CMAejzXbaoMJSSSMHDvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 22:37:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 22:37:44 +0000
Message-ID: <ceb1136f-30a1-41c4-b735-257d801b4efc@nvidia.com>
Date: Thu, 4 Jan 2024 00:37:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] nvme-rdma: introduce
 NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-8-mgurtovoy@nvidia.com>
 <d55384fd-42aa-4aeb-8a7c-f36c6a9dc6a4@grimberg.me>
 <b1363b4b-ce14-4797-9080-40e9d37a6b97@nvidia.com>
 <ae25991c-b4be-4652-beb0-843e1c3f7a59@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ae25991c-b4be-4652-beb0-843e1c3f7a59@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e1a526-6129-4077-1741-08dc0cac9a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x01u1L2nqckX1ebZRgJj7QnTFNp9bevLSV6FI980jLm979w/s6XiwSbIVWyThBFGVlVtHlIPe+pxLNY3fXZt7EcHmtiRnohqTdfsoab/loGrn9polQ36OcksipHpvNzI0f0L32plV/oexE/IEjamwpJwAuIK3UeEOcqLMxkUzJkkFlDZkFTD1My+ycrDmv1rzxCAJ9KZ4pmkWqsdSmIVfH/4b8RoppGEC20PgvvJb2/N98Kl63TWLr+f6b3qqlJ7GRjV8ifw+J0AelucP3hTj9oKwTuUrUzTAcDI0IaCOtRYYiEGBqok/5rOANUTCONmkrF3TSD4yAcHBGl3LAo1nbipMUau8SFnx42tlKiOoNONeQ9/RZsJQyStS3qIe9P5uX0U7RFDBLB0IyjeH+WtrPVhGe5v4fVrZaF9pLMrH9Bkj5ENivCZcFSNC1PhdgT2rdvMxY6m3tjn/v0MuxC8Zubuz2jnomK7CF1TRfVPXk+2lQF6TFkrsKFVTfkWpEYkeDJc6GG6wwvB4UyhThBeb5irvTFP6A2ilwrVF/9RSg/H+wHz/qi2yZQOVxXHs3HWJ2bez+IjxWPf1uxi7RqUYgavGY5nfPy+ZXpo4SQzPGBcri5Kl6F78XbSanpW69L5R43gLjWBV9TI8zjPfPRERQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(6666004)(2906002)(478600001)(8676002)(6512007)(66946007)(6506007)(6486002)(53546011)(66556008)(66476007)(8936002)(316002)(4326008)(5660300002)(4744005)(41300700001)(2616005)(83380400001)(107886003)(26005)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9ZOUZudzN2RWpYR0paMHFGU1crVTE3Q1JZR1dnZGZPZGtWSnZtcUhaV3JS?=
 =?utf-8?B?bWpjODl3dkxNV1NpbFR0ZWtWb09nakZHaHVFT0NMcHVnemZBUW1sM2lyZUdI?=
 =?utf-8?B?Ry9vbktxUzFMVE0rSTJ6VUp5Nk94NFJKVWRwcjVCZHdDMXBkcGROVzRvUGlK?=
 =?utf-8?B?WEU2V3VlZGN3NWRiNDFVWmJoN0VmekNnVkRNMkFZY1JNZjUva0NTRVFuU1NV?=
 =?utf-8?B?OFVXM1NmRDZDRUI5czBGTFVPVnBZMVgrVm5UMnJUbWRleDBWU1hzZEZUMFBy?=
 =?utf-8?B?V2o0VmlDWDB6azhCbnllRzJDcXZyVFpaVm9OZmttWXFVV3pGM1QvZzVuU1RG?=
 =?utf-8?B?MWdkd0RLVC8yNkhldzFJaXo5N25xVkFRb0Iwcm1UUXBDUy9HaCtNbXhWak1B?=
 =?utf-8?B?ZkV2S2VpYUwvV0o3Yi94ZElFWXpNdFk2U0tHMWk0R3d2OWF6eTcvclVLMHIw?=
 =?utf-8?B?SWd2T3ZPWkNqMHdjWXloVXN2b3hKYmRjRi9rWWJCS1JxcldwSDR6enR3aUZC?=
 =?utf-8?B?eDkyQTgxenZ0YitmMkswVFZWWXNtSFZUM3NtcGFZNi9jZ3ZhUUMrNld6aXlE?=
 =?utf-8?B?RGo3dnhnSHkwU3RHYUtROUpFaHYxeUhNb0R1MlcyTVpnd0ExRi9hMmNNL0ZX?=
 =?utf-8?B?MEVTZmhqRjNEd0Z5aXEvQkt2TGV1M0hVOEc2SWdlM0JZcHdhc0dQNVJhTHFQ?=
 =?utf-8?B?QlhPRDVNcU9GWUs4L3F0QzlsbEJ4NjRsek9TaE5lYTgyMWNQMWNTZXlUZkFQ?=
 =?utf-8?B?bGVFdGlZSzlDanBlY2s3aHVDeEJJWkNQU3N6V3FmMUZXQ0VubkFpOHhHbmpt?=
 =?utf-8?B?Y2I1bTZSdjJvN3lRa3FaejM0cHpkSHdQWmRnTllnLzdxb0ZmSk9tUy9oenht?=
 =?utf-8?B?Vm1SSmV1dWtDdC9GaEF3UGt1Sjk4eVdTSkdZWm1YM2kvbm5FSTNmM3JkV2k0?=
 =?utf-8?B?ZUNEUHJIbk1LQVpSSDFkb2lTczF3bVRIQUVhczc3ZFlHcGswSFNmRGR5NERz?=
 =?utf-8?B?OXFNOHdzYURJcGxWdGdvTWV6NTduekUvQWJDZmw1YXBCN0ZhRmtKTWRhWVhs?=
 =?utf-8?B?ZGZ3ZXpTSEJuVXNtMHRMWGk4V1dGY2tMUlBRM3Iyb1dkbHI1QzJUeFZCVTRE?=
 =?utf-8?B?a0tWWVdhMEcxaWRrMjFoV0VQZDlrNzBwNDlPMVVvSW14ZUFIOXFIMVpUT2lW?=
 =?utf-8?B?RkxwR0Uyb2lZYllVNnAyVDd4c1JsTWlYL3NOMXU2UWZDM05SbDRwMlNxUHQ0?=
 =?utf-8?B?UGxvay9rc2dlV1pweDJkK0p3bDVpaWVuRWQzK3Q1UEJwaGFxT2ozWElkM2FG?=
 =?utf-8?B?V045eldkN0ZpaDEzWFlpQXMwa1ZPcHR2REZaUFF5a0djNEduWGRHaUZLb1hS?=
 =?utf-8?B?ekVrcWl3MUYyT2VJSVRPRVlodER5bXk2V0N4ZFcwS3NXNy9iSGozakpzeUJQ?=
 =?utf-8?B?RU1wcG5EcW1YY0Nmd25mWkFWdkozV0ZvblBQUUhrd1NSQXRQUURNVFVuZktM?=
 =?utf-8?B?cWZGbTJzdEprTER5OGJtRytwUHNKdU9qTkZCZHhZelZZNG9rSTR1WnRhRmVM?=
 =?utf-8?B?eG95WFVPdC96bVBtOGFvWEM2UUVnZjVKSzdnQmxyK21xa0RDTmxSSHJ0VlRP?=
 =?utf-8?B?aUJKSGxZZ0FGYlVwWlNMZVhxTnhiRW9DZEdLcC9zL255SFB0VnVCdlBvcXpL?=
 =?utf-8?B?OW8wc1crTDVKV2o3T0xXTUl5eFNLeFZaenpjN0VnbCtGSlduQWdMOWl3MkdW?=
 =?utf-8?B?Q1lHQ3RlVytNUXMyVEdTL09BVkFuRUhWMmtSM0tNSUx0Q3ExbTJ4aEVnd3ha?=
 =?utf-8?B?Z1ZRV2FFQVBWeDk4SmhFam1aaW1ZUWJZek00eTIvWmo5UVp5UkZkSWdadGdG?=
 =?utf-8?B?aUlKUHc4QWc5V1FpMnllejZ1OG1yRXYreHhVelJjMUZ3b01DSWF1RlhnWVpv?=
 =?utf-8?B?bmdsTTdnNEhEbHdOREZCckt0TU80cEl0dXl3MmtFRDBEbWdRRjlwV0RBUytM?=
 =?utf-8?B?YllrZlpTc3JUMFEwU3dQSmpvbUNNNWplc1JYSGc1eUJqSzRFamlIaVltd3ZX?=
 =?utf-8?B?WTFqNFVCZVMvbThWa2I4WmtqTUpPWU5mZFR1QnMzSmc5MHFyVWZNTE82d3Jj?=
 =?utf-8?Q?eDINMqkmDvvXGQXymLtAClFdX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e1a526-6129-4077-1741-08dc0cac9a1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:37:44.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7GTb80z9M+W2Y7blK0zoHYj1PE9FMgDUC8OUh0cPmd4m/Jrx7PR6kqBk7d1hItzoOkcXxuPcbKLP4G2bkb7fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_143751_608312_0ECF7E77 
X-CRM114-Status: UNSURE (   9.05  )
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



On 01/01/2024 13:21, Sagi Grimberg wrote:
>>> Another completely arbitrary limit...
>>> Can this come somehow from the rdma core?
>>>
>>> If not, its not making things any worse. So its fine by me.
>>> Please comment that this limit is based on testing the devices
>>> that support PI.
>>>
>>
>> We are not changing the logic for PI controllers at all in this commit.
>>
>> I can say something like:
>>
>> "... We'll keep the maximal queue size for metadata controllers to be 
>> 128 since there are more resources that are needed for metadata 
>> operations and 128 is the optimal size found for metadata controllers 
>> based on testing.
> 
> That would be better, yes.

np.
I would like to send a new version.
any other comments for this commit beside the language for the commit 
message ?

