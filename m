Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADEAC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CpmykJHsyL2I+MzK3iFlOiNDMQrd9eAY2f2+NwhNMLA=; b=w9HjhPugLkKOWwJXQLBdsGhZqW
	GWhEGPydk/Mx/oKjw1mRWcpfiHEq95eywrGuVeLOdEDOXatg/yGZhovovksdtlL1a3yiIVErGTSC0
	ow6/N+mbjiJUTssJy/E5vOTwrNaGsRUjqvWlsmKinMScLo3y8Rx1J5Gksa5ghgZriJKeSHaO3aFTs
	XUG9huk6tSg4bDj42XlQ6GMfHq/WNIdw4DeHogJjKgN6El1UCSePEhWZFVE/MHBi0+FHvSjRSPQjx
	K/Qz6epiBbXmwTvJO7VMSvraxE/pehtea+zwNigH+oV6cyPvFWFY1ZytPTzYpSF3WhcJlnFbYPIqX
	XxlTQ+xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJtId-00000000vZH-1Rsy;
	Wed, 19 Jun 2024 11:16:23 +0000
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2405::600] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJtIW-00000000vXY-0THv
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 11:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFeXVfwHomIlK61WfEWeA8fMU96KKZHFKSYhBo3DiVKVZ/2xVEqSFcxKgdWeKxjlvrOQkLKVWX/fXkcHbTL3x33GJ3wQcRKYdNF/i7f55XtS5q/CLbEDHQOddRfnVDL64ugUnuJsU8w8pB74sB8TO74EzdLZZA8KrkraES0KqAaCpVAssYz4petTi/lCQEGnYB9NaexxkvFpL2jv7+l1/+VP7TUW+1xiReeImf8O0ILyKR1fQNQb5tUddsQdJNA34+Dy3/6sPl9Y3YzS85FygpDoBcBV5F/+KLz9lEHPwXd0/FV3C/OxP+LWMcIDea7CE1ixHZ8WUbUeWVdbH0C94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpmykJHsyL2I+MzK3iFlOiNDMQrd9eAY2f2+NwhNMLA=;
 b=BNEGQLKyiDOlCW+pN6HnKmY8wXgEXawtSdFEyJzfBuEMzjEq0zQLBboR/ygy9jNdJzNBWlrXZDrSyaOth/IqMJMwb7vU3ufVDhh8/rKA1PZWtfww6WRjX7QMAxyNSmaU21P4MLRNUmrl9L9OMWJv1BL0JrzIvkGICja8423osNjCMKMEHpl74CBX3ELiLK+jm5uhbP2vzFPvk1oP70wqUa5kvT48VlvTqRxj+u/yWaR1c11RHOUMwFlOh6Uw3oUcVT9Av/l4QA7jkqdOucLhkjwYNBdz9u/jRAeRIMovScYymqEHQr8OTuryHxByk++YVxv5Ns3pP/poOhEH1mlKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpmykJHsyL2I+MzK3iFlOiNDMQrd9eAY2f2+NwhNMLA=;
 b=Sy6FujNh8HBusEHsjsZ/nQ9DTtDhm/eO18kk1UAnnEcxOkBjszB2KQ/O2pIKEbEtkraJ8DNEWR86zD67AGQuKjHrF5c9SnrkciG3g+ayeTOU0JNJs2GgJdxc1YTDxdwrlZ5Paa481e1l3rr/72rZEgeggl35TM+Yvu3JnBR6ElfmYnosAPVHX8lDMWEua3HXx1RW59wHOx7w3jdbGszCXrX7b1Fk9gd5C1Ty1OsoVgBAnoNbiOGv0INT1/rfqmwV6RNc/lfpwRX+yRgqu3kLs/q/mQ72Ind/lWUPDp0yXPbCRcJqasxs8ZMzVj9O1iILm1xHfYWbfv/TMtYSlo8a2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 11:16:11 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7698.019; Wed, 19 Jun 2024
 11:16:11 +0000
Message-ID: <48eccd53-9b7a-4362-8941-5c587b12efdc@nvidia.com>
Date: Wed, 19 Jun 2024 14:16:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Sagi Grimberg <sagi@grimberg.me>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
 <d12f32f0-ac4a-4bb1-a3e6-a1a606d4f89b@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <d12f32f0-ac4a-4bb1-a3e6-a1a606d4f89b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfc492a-b157-40de-c84f-08dc90513971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk1ock1jYmRRQzNzeTZPMUVqOG9UcW4wbXdWRk00L0lkZW0rY2VsRWg3TEhx?=
 =?utf-8?B?ak1wTU15Z1lJdEMxbldWRnlYcnR5MGlMbENPbXYreHBPZ1pUSFZKRUtmWUdq?=
 =?utf-8?B?QnF2RWwyNXozRW1sK2h4TEZyU0x3aWNOU3NSSFh5U2MvQkNLcXZrRDZBZW5O?=
 =?utf-8?B?R2M0Tm95eFR2SWo2SXN0dTBYZmlHZklhTHRzVVdVOUlkcGxZNExaRTRwbXEw?=
 =?utf-8?B?V1BwM2JTRm1CR0o0VG5xLy9BSWFjZlpmeHVSRnh4ZnhCT0QvRVhGS1BXckli?=
 =?utf-8?B?M3dCc09PeFFGY254ei9kQ0lscGpLRHdRNW9OMEtjN3VEMUNPMS80bjFYZTFY?=
 =?utf-8?B?RGdvOUVUWlRrNDFManZ2QW81VkVTczl4K1hxUkxMQzUwMk1RdUpxanZCbGs1?=
 =?utf-8?B?SndLZmI0MDFBUVRIdDByaGEwSzR3c0ZQekVuOU1JU3ZPckt1aVNTYUNzNjdQ?=
 =?utf-8?B?Z0w2dU9MWUx3ZGh2RFdod1JXczRpTC81S2drSnY0YkVtbTVxWEE1NEx6bjNq?=
 =?utf-8?B?T242S1NZem5Qd0U5M3gweWQ5UzZ4cHYvc3lRRVkwWi9LQWZrM01xZU1DUXR6?=
 =?utf-8?B?YUd6TnQvdVlHSTUyalFTZmd6L01iQi90U2hVdUZnT2hHekpBUzk0ZkNuRTZZ?=
 =?utf-8?B?WXpuazJmVlZ5cjljT0E4WkIzVW53ZFptN3pvakl4dTRuTE84Y1N4ejBqVEhO?=
 =?utf-8?B?WEQxajZNZjVKS2NtNisxRGNzNmg2QVFLWVBDMW5ZMzh5T3luWVVpZnVFK29T?=
 =?utf-8?B?clJVWVRXZ091eFVLUWNjbGVyMTc3OFozOWVDR1l3TG4zbUd0SXFzYTdHV2p6?=
 =?utf-8?B?SG1oWktnWFNuOVd3dUVocUJqZS9JZEVtazA2OW12dXB6UGNLZElFYVRMdEU0?=
 =?utf-8?B?SVVZRlFWMmtXaHdyMERoem9uNWRYeTJGR2pKYUgySWljV0JQbCtsYXlEQjJp?=
 =?utf-8?B?ajQ2elhnOXl2NXV4VE9JQ0JJMlBaVUhlODhiMHVzbm5WVFhSQndNRlR3dzZO?=
 =?utf-8?B?eHNXMkRyK3QybWlkUlN3Mnlpdkd6MW1QcS9qaCtYK1Z5YnRDK1RyREU5V3E0?=
 =?utf-8?B?VnlCaUxEdGZTdGZGa0h3U3IxVFhhYVg5Z2tPaHc4dnI2U04raTM3cjNjSndr?=
 =?utf-8?B?bFlrZVc2VDk0Rmd1aldqRFM3YXhrb0szNWlTRVp3dVVqLzF5MGN4QU9yajRy?=
 =?utf-8?B?ZThYTlB2K2RHc290VUhqVWsrcW5QZ3ZzWHpOQ0dXQ2dvU1pkVG9HS09icHBR?=
 =?utf-8?B?ellIWnBPT1FWYU1GQlFwMkdRb2s2WFg5NkhHaE5iY2tiUmNCT3RwSWpiYms2?=
 =?utf-8?B?aDFVSlk1K0VBUS82K3RuWVFsa1d0U1VadDRqTTBudDduZUxKOGdEemszdzdC?=
 =?utf-8?B?VUs3cTg3Y3dYd3N3aThSMjlnZVh0V3ZBZEVtNzEzS3k3Z0hpM1NmS0ZId1pG?=
 =?utf-8?B?Wlg4NDBId3YzdkliUXVmUVBxS2lZSHVJdjlqN25zMDBlKzVJRFBieE4xQVBG?=
 =?utf-8?B?cXVvU254TGV3bTF5NDBvMG81dldVa3hxTnVIUGZ1MDNKWU9qcXdLa1EvRTFD?=
 =?utf-8?B?R05wY2xvVDY0djE2STNFa2NkbzJJQURJOU1RWWNERjRPajVjUTk3MkZPbjFT?=
 =?utf-8?B?N2hraWlnRGYwSFluK1RLSlU3d1lZOE5PUm9hbnozZVFIRFlMT0RXTnJralZn?=
 =?utf-8?B?ZG9lZ1BvdEcra0lWQ1Z6eFptWGJmQ2tZclV0Z1ExVVc2TXhpSHlJNzZhTzVO?=
 =?utf-8?Q?r7Ipj1ERXsJnePJ6kzggmvRZPGg7TG6BZQV0bWP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lncURYQ1Q4Ykcxdk5rTUx6M0lpektkeVlqU1J3RUEwT1lQTE9JNUgzL2RH?=
 =?utf-8?B?YnppQ1UxNE9CSUpzMDRQLzJlNU00TjlFSUZRTmt4M1kybEhsRHZKQVR6S0Yy?=
 =?utf-8?B?VlBOYmlKVDZ3VE96MUh4ejY1TkprcGFxUytRa1YyZmZpbm1aN0lEZWMzaDZM?=
 =?utf-8?B?LzhEMFprS21DNDdVcDhvZXV1dVVpQzIvZ2xFQ1l0UU8zOE1ZZzJKTXZGcXJz?=
 =?utf-8?B?VmYzenVIMFdUaGxyRTk2cC85a0QwNDRjQ2pHZS9wKzlVeWFqSnZCUE9EanNo?=
 =?utf-8?B?YytSbXZZcUNWNFdLeEtmWWN5V0hzRnF4VFZwcFZvVXl5eUZQRFZUSFBxcHhr?=
 =?utf-8?B?K2J4clRaNi9aTFRic0JXWUlET25BT2ZpV3NCSStOMkVmKzZ2V0xJSE95bm1a?=
 =?utf-8?B?dDhtT0Y4T29LamQ2ZXpFMEpMTlhuUG1tTElCa2sxT2lCY2ovdmprMVhSN2k0?=
 =?utf-8?B?YklNRG5zcEg1dXA2MzJXWVkzVzNCQXRxdnpNTXRBaXdxd3FMNmdrcUlQWllO?=
 =?utf-8?B?V1ZGeis5YUtDZ0JHcFpsMDJYRDllNk43MXF5SGorUXVwTnk1S1lZTHV3TVZs?=
 =?utf-8?B?aTF6L1RFSmtlK2RhSm04Y0kvS04wZGRYSzQvcVNUMTRmR2tjd0tZTy9KdEFy?=
 =?utf-8?B?QUgwNiszQ1IyWmNsbHJVMktjd2tDZUJyZ2JPd2dISG9BQmpSVDJYVHNKUWp6?=
 =?utf-8?B?c25Kb0ovZjRPWUU2SFR6YUhqQUpiWDRXYi9naWZpWUlsUXJhUVJ4L0I2VHJ6?=
 =?utf-8?B?bkNDUGppUmNJQWNkSDc3dWZLMDJVZ0d1UmZoV1dvQlMxTG5POTRxSVZkaTBS?=
 =?utf-8?B?Z2hDMjB1SzJPUUxiclhiRmtZcUpQMVRnZHMxWENvVnJUemxDS2NXaklwNjVK?=
 =?utf-8?B?d0wwQXFubUVkMDFFU0tNeE1va2pra3lmNlBlb1lEb3dpU1VBR0JrYnlzRDZC?=
 =?utf-8?B?WWtETkhQNDlIT084M0NIV01KMTZUNy9YdHc1NXdqdnNtcDZlQnZzV0FOYlRW?=
 =?utf-8?B?VFB3UDBlMTl3WHlNUUtqbWJ6dWxEM1Bya2hzS3Y4R01hbXcrV2ZtYWZ2SFRY?=
 =?utf-8?B?em1hQ3MrSzVRUkROcGVKU2lrS0pDK0w3cWtidDlJVVAxVHlyOG16Z3VhcXA3?=
 =?utf-8?B?Z0pxL1RXcmNVWEZRREMwTFJsZUloamJPOGFGOThJblp3MHRxeTlsMGJFcGZX?=
 =?utf-8?B?OVk2TjFqUmlMdGx3MFFFU3l2U1Q3ejFac083eitQWFBqU095TGVoVG5UQXdO?=
 =?utf-8?B?TU9kOVdEYlRhenNXQWRvMEptbUFSZk90cXJ0R3dzR21KVStEOFcxRUFLajdZ?=
 =?utf-8?B?WXI5RVl1NkxzTXNCVTFXeEd5bktYa2htTCtSV28vQWFsQUdoMDlUTElxWXQv?=
 =?utf-8?B?aVJOeDEwK054NkhIL2NjSks3MG5lVXRmYVlGN2FLdjQ2QkVBRU5iVXJVdnNy?=
 =?utf-8?B?TGVIeFE2RkpTVGVBZ0Q3WnVXUmRmTUNoMHBHM2tvNmNkanc5RVJzU0o5WU5t?=
 =?utf-8?B?TWIrd09SUGRMRXlkNVV5TCtxa2t4S013ZEtHRmM1aTNmTlV2ZFRYYUlVTEVC?=
 =?utf-8?B?VllZRzZjN3UrajF5bUV1ME5WdElVcjFvbThaMW1PUWRlbjdkUXBlQkduaHIx?=
 =?utf-8?B?aVVYelRvK0pYNjdMQlFQeHJlWDloSUNoNWdDSGdYblhBVnAzZ1o4N3l2R25r?=
 =?utf-8?B?MGJTSk51NWxnSWIzcWZzYmI0dWR3M0JQYkhHOVFCdHVtVHZjSHVyUmNVbE5Q?=
 =?utf-8?B?RjVrQXdWdVlZbFB0MDNBeUZ3TnFDK21vRDQrMVg4WkFLZ0t0SGtqT2p5Q2tI?=
 =?utf-8?B?VUhOUDVyMFJJNlZpZWN4bFc0WG4zMU9nWW9zNHBCc0tjSVROdmVGL0Q0ODNS?=
 =?utf-8?B?NlhLK3dibVY4MGZjNnJvMEptQk4wN25TOE04djR3ME1FeDBNSjNXS0cyV3h5?=
 =?utf-8?B?dldrU253SDg4N0RyUE41K1BNbStVSzIwVEwwNStmY1dHTEZZMmxpVk9YdUY5?=
 =?utf-8?B?dktzNXlwT2c3NWsyZFpyeEs4MDR0MUFDTE95NFpOQU1UQ2dCa0s5MTVULzRQ?=
 =?utf-8?B?aXFwQVZCZ2hoMnhkbkRpM2dIMVdJQVQ3aTRGK2NhKzYra1RjdGw4ZUY2MVlr?=
 =?utf-8?B?U25hY1NoUU9qQ2tUcmVITXAwT1RTcndVejJraHJxQWJ6b2R1WFVPNitURG42?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfc492a-b157-40de-c84f-08dc90513971
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:16:11.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADcsMgOWIhmrBZy/x07Irj2NIEmq3/6nwU/zt1OP+OQ1CbNIw4L1FPiyCHvdIBY6NqUwey8DPUCgznPeOLBp5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_041616_222095_2D72C29C 
X-CRM114-Status: GOOD (  25.39  )
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


On 19/06/2024 12:09, Sagi Grimberg wrote:
>
>
> On 18/06/2024 3:10, Max Gurtovoy wrote:
>> To avoid leakage for QPs assocoated with SRQ, according to IB spec
>> (section 10.3.1):
>>
>> "Note, for QPs that are associated with an SRQ, the Consumer should take
>> the QP through the Error State before invoking a Destroy QP or a Modify
>> QP to the Reset State. The Consumer may invoke the Destroy QP without
>> first performing a Modify QP to the Error State and waiting for the 
>> Affiliated
>> Asynchronous Last WQE Reached Event. However, if the Consumer
>> does not wait for the Affiliated Asynchronous Last WQE Reached Event,
>> then WQE and Data Segment leakage may occur. Therefore, it is good
>> programming practice to teardown a QP that is associated with an SRQ
>> by using the following process:
>>   - Put the QP in the Error State;
>>   - wait for the Affiliated Asynchronous Last WQE Reached Event;
>>   - either:
>>     - drain the CQ by invoking the Poll CQ verb and either wait for CQ
>>       to be empty or the number of Poll CQ operations has exceeded
>>       CQ capacity size; or
>>     - post another WR that completes on the same CQ and wait for this
>>       WR to return as a WC;
>>   - and then invoke a Destroy QP or Reset QP."
>>
>> Catch the Last WQE Reached Event in the core layer without involving the
>> ULP drivers with extra logic during drain and destroy QP flows.
>>
>> The "Last WQE Reached" event will only be send on the errant QP, for
>> signaling that the SRQ flushed all the WQEs that have been dequeued from
>> the SRQ for processing by the associated QP.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/infiniband/core/verbs.c | 83 ++++++++++++++++++++++++++++++++-
>>   include/rdma/ib_verbs.h         |  2 +
>>   2 files changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/verbs.c 
>> b/drivers/infiniband/core/verbs.c
>> index 94a7f3b0c71c..9e4df7d40e0c 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -1101,6 +1101,16 @@ EXPORT_SYMBOL(ib_destroy_srq_user);
>>     /* Queue pairs */
>>   +static void __ib_qp_event_handler(struct ib_event *event, void 
>> *context)
>> +{
>> +    struct ib_qp *qp = event->element.qp;
>> +
>> +    if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
>> +        complete(&qp->srq_completion);
>> +    else if (qp->registered_event_handler)
>> +        qp->registered_event_handler(event, qp->qp_context);
>
> There is no reason what-so-ever to withhold the LAST_WQE_REACHED from 
> the ulp.
> The ULP may be interested in consuming this event.
>
> This should become:
>
> +static void __ib_qp_event_handler(struct ib_event *event, void *context)
> +{
> +    struct ib_qp *qp = event->element.qp;
> +
> +    if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
> +        complete(&qp->srq_completion);
> +    if (qp->registered_event_handler)
> +        qp->registered_event_handler(event, qp->qp_context);
>
>
Good idea.

Thanks.

>
>
>> +}
>> +
>>   static void __ib_shared_qp_event_handler(struct ib_event *event, 
>> void *context)
>>   {
>>       struct ib_qp *qp = context;
>> @@ -1221,7 +1231,10 @@ static struct ib_qp *create_qp(struct 
>> ib_device *dev, struct ib_pd *pd,
>>       qp->qp_type = attr->qp_type;
>>       qp->rwq_ind_tbl = attr->rwq_ind_tbl;
>>       qp->srq = attr->srq;
>> -    qp->event_handler = attr->event_handler;
>> +    if (qp->srq)
>> +        init_completion(&qp->srq_completion);
>
> I think that if you unconditionally complete, you should also 
> unconditionally initialize.

Non "SRQ" QP will not get "Last WQE reached" event. Unless device is 
defected.

Anyway, I'm ok with your suggestion. There is no hard in initializing it 
for Non "SRQ" QPs as well.


