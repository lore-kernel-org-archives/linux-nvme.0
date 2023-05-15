Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AF3C77B75
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mOVtWAvMy6O10Nw74rr9Eq1VCWl4rkJkBCkR5JhMxO4=; b=bMkarhYUI4smN5XTIA6oZFLuad
	GdwNQcAvgJxo22k+F1Fn1ZdC7b52ew1faadDwK87ZHJaZdPNcADYjzpnfRnt4IAO+uzx5E2CAa8HR
	0gv3KWm0vY626ak2cRt1ASJoNbcaheG+Xon6482yt45s4YWDrxHCmtmvBz2uHui1oVLRXBF1Pm/Z0
	sdTmNJ8iztVUXkId2Ms3lMaDANh83+yU9XNpr1tNbIDdNJuEfwF2foYHHgJh1XX9TlD+NrUauQqns
	JaZlA3r6Bj25lbRNdIxGCfmyhzDSSQLhSiB+4VEo/LXL2RgbJHLcM/b6J02ImgysKGAISesKIJubD
	hdZxzQAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pybbE-002rY2-25;
	Mon, 15 May 2023 17:03:04 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pybbB-002rWB-32
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:03:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVqcbmevV/o28ZZN8nHmaf5tWRvhzKNff+rmCAcIRZyP+8XnY/LUHeP0/1L6rfhJ3AgZFuzHGcsap8Bb/zUgRNObuuXdzDGw7TLVZfLbWk06QR7GI4LVCgOwI4Wc6AIbn+0qqrPPfIhsUkUv+Bj6QQT7x1kgJ2P2Eg0NSVq/hoD0SJg6Ax0A1GLgBhCSzby0fFoGZs1UhX3GRLm67m+7YATIrKCYR6wGnuaYgjC9gGvD/70zjy6LSj0CajBkvab5LHoz7NSJ1s9ndeia8wXus2pMyOvufwnRDbAJ/OkomHtPlK3rtRb7LITXAdrH4YHAp3sIj5J8/6yWGaPXhGdGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOVtWAvMy6O10Nw74rr9Eq1VCWl4rkJkBCkR5JhMxO4=;
 b=WWySzHMEtc0iV8t1mb4lUFdYovzj7UurYLDaUZAKsy7DB911vFXq4yQ9qE+5JeJTToBqTePp2R5i5bJH0CGbuy6OK9n3pBf6/+UKbPQp6Tj4PZ8B7WyScGGQX+24CmUR0hbssTn4QkLNN19gwP9KNIHUJlEeqtUuIXvrMaCpTLwwhQm2BuZc2D6Or0JsS+LwQjhWW5VMkfFaIVEZTHc2TVVGXUMDmpWChhrc7OCBOPMHLWyTljvnr93+E2L9zK3otScmzSD5JVLzmpg4pJvfJD3cmi6eH51qt9swRnD3qGTQPqwrqyOUQrXy9k5SYfcThqENVBeFEPDdAxo4P2+NtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOVtWAvMy6O10Nw74rr9Eq1VCWl4rkJkBCkR5JhMxO4=;
 b=phYGTBR/Mf3m7sPWsUOmWal4+WqwrviIYEBc/wYQONaU+ym6i5cjmxaBBom+G35siH2YWj1CebTuXfraOBBgMCWjkcqNt2aoMG8rEYq02O2T3UtSNHtOwb3JqlGebo2J/rAKY5DQbJiBpOIjvYM6DOLn7AoLwT18wjqoCu29p8TmaLUOL10Q1SOsdcsUa7Pn5E+uQBAx/JayTTBOE5geJyl1tAT6dY3T2layUgXciBmIez53c3fBYcWwsKF2NDHcqp0OG1kRcKq9+CRU/XbX3nVmUjigyqd4R3lpStwwVAxmwyXW2C+QpIPVR0UGt7qhXVO9qp7Ej7p8MAlfew/Wvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:02:46 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:02:46 +0000
Message-ID: <e7a523ae-743e-154a-3077-cb24f79be9ee@nvidia.com>
Date: Mon, 15 May 2023 20:02:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c file
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 axboe@kernel.dk, oren@nvidia.com, israelr@nvidia.com
References: <20230424211242.19614-1-mgurtovoy@nvidia.com>
 <ZGJITKis7X6Eaot/@kbusch-mbp>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ZGJITKis7X6Eaot/@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc5a3c7-efa8-4b61-e420-08db5566348c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	4AP252KaMOFjPawFc3aqC1UwvXCbUBTWZeAhq73bRMMp7YVPyS0lkLKIlOAnd09BFfySe3a5KtBll0m1ngiugyOVHrN3Dwxw9Q+P6tBNSUTVboxXTTsYMLIdDvXIl0N7lnu/t/2DT3rMbbNyaGGJrbvthphlnLwPPD56SNFJPXmmqvQE/DAzPaC6iBqAUT0DaB2hD0AXzgV3XOelLxRSsfLsMhwneKyKlU7qnZWo4wehXgPe4iE7MVSmebjVp6oMRBku1RNFmDEn6Jq3E1Jv94K5UB9aszuAF9nF1F0PCkCDA1eTwukLCq9EEkodLCxbHBKuMHRpdOI3sRTUXfxblJCdOeh+uR4DEk9FlzzzDcD5Y1veFOZY4uUQ/4/ZfBL0weZEIvsKQGk2Tsp/DGjzhgIELGCreUbHcmAPYX6Vs5+BGeza8uPmdtVmiqqaFgCvR+3/rg30wkvUHcRyo+9kD6hs0YFHD0Q4mK81I99GXlrvMlea30oWV3d8uFyHhSIi5taGkQd7ZLHYllInwEYjbH1xVRwNRbfEJktGYy98iwcH7GciJK7hOq64L97pFJH86sHMe8ARev2LEkjil47KZEiCAhemfVgq9bp8jK+cEnLwzSCEpi9pDpWxpqfd0v+96RCDmhCa2ByALCz2U2ZE/A==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(36756003)(86362001)(316002)(66946007)(66476007)(4326008)(6916009)(66556008)(478600001)(6486002)(4744005)(5660300002)(8676002)(8936002)(6666004)(2906002)(38100700002)(41300700001)(31696002)(6512007)(2616005)(186003)(53546011)(107886003)(26005)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?L1dTd3E4RGMxTEozVy9uQ2J5MjYrMEZQSEdWazFvNzl1Wk04ZlZabWxuT3lE?=
 =?utf-8?B?NFJteHBnVXZMbFVJTE9lQ0o2RHBOdXhSNXVlTlA5d2VoeTVsZHFxaG8va2ho?=
 =?utf-8?B?dXdYR3ZubTVwY3lycjA0c2JVSlluNUUxbnh2R1kwNWxPTW5kOWZsSyt3M0h3?=
 =?utf-8?B?aDBQSm5vU0RTbDFIV3E1Q21VTDlHMU85MkdLTWZ0UGNWNENSdGFydWp0YjRE?=
 =?utf-8?B?STIvU0VhR2c4aDY0N3NzTHQyNklKZTE0RTNQTGNEWEowS0NYSE5qZGdKbmdz?=
 =?utf-8?B?cUFLck5mSmxWclJLNm1HVXcyR1NUZ05na3FmUVdIQ1VVOEorQUk0MlkxeEM2?=
 =?utf-8?B?QTh5bGdEQVJuTFNnRWEwVXBHeSt4WndCb2hDSUVtcEp2UUV0dVBzR0g0NzhM?=
 =?utf-8?B?UjlGb3hoTnhpSHIwNXZLcENWVUlBS0Z3NUlDVXN0aTBZKzJhemgyamVTNU55?=
 =?utf-8?B?WjZ5RFdjNUNhQTRuT3lBdFdSNUpCOU83Qi91VXNIMlphdHNuZWF1RWEvRkQz?=
 =?utf-8?B?MVJXc1B4REZjQ1AyOWp6L1R5OTFnLy9USFZvam5Id25JWHg3ZVk4L0J5dm1i?=
 =?utf-8?B?QkcvaTJQR0F6bnIxWjFtWmd6SmQ4SWdYWGN4dUU2dGtLOXJmWm1WMkNQd0xp?=
 =?utf-8?B?M0xZNk85MmhyN2RkOTZ0Zy9JcmJjV3Y3bUNra3FrSmxQQitUZGtDUVdKOTNP?=
 =?utf-8?B?YXlCSk84QS9zWXYxbHErVnA4cSswQ3F3bFFaUnUreWdkZmdKMzNvSHZLZEgr?=
 =?utf-8?B?OVh6UU53T0t5OEl5Q0Y3T1dLaFVRS21Ca3VrTWZ6Vjg2cUJxYk50K1hFUWt0?=
 =?utf-8?B?Z000SGdyUzZ6NVB2TzlnUWRzY3RyK3BCUTh1Y3pYWHZ2ZEFvZTZ2bGhWMG5x?=
 =?utf-8?B?MGs1R1hjUE5MZTZlMkZ4TGdIUUdLVGw2MWhZbmNwbWxoZkgzN1lKd2I4TDFv?=
 =?utf-8?B?RGpDYnFnaURTb0dSM2ZtdUd4TFF1QiszZjBnMkNVQ2NtVkRjQ2FHUERLYVQy?=
 =?utf-8?B?UzE3bktYaWRhRUYvWlp0Vm1RVzN5NHBrc0pzUVJrNVdabVFyMlJsUHR1R1pn?=
 =?utf-8?B?Smg4ekc4dzA3MzN5eHRyV2VqOUUvWS8wZTBuTFY0clFJemFRelhna1I5WVMv?=
 =?utf-8?B?enhJQnBRVzkvV2pLOWJUOThOTytDLzgwb3JORUtxa2poRHM2SzVDcGkwQzVz?=
 =?utf-8?B?MG93V2phTnFNTk9yYkNpc2MydjBkV1YyNitrS3BkMlU0U0E1M1FjaGFSd1Nq?=
 =?utf-8?B?TFZjVWZxTG9DcmdYcUdjL1lNU1NGMW91SVljNSszUFlFT1pvOHh0c2E2STVU?=
 =?utf-8?B?TWtZS05JUTJ0QnVVVk9aNnJLS2Q3aDJkekp4Z1RZVFpaQmR1WXFPOVFlMXdK?=
 =?utf-8?B?OWttU2YyZE92T2ZIcHNXUVNmc0RBR1BjSFRlV3YycDlYNEtwMy8zY0VVTWE5?=
 =?utf-8?B?VjN5WTJRWTlmOGlPQk82d1hOOXZiSkh5eUFXSlcyaEFaTjJTdXArdkZDQ1JQ?=
 =?utf-8?B?MGdIbzhFVjV2K3lmUkU1WS9Ubzd4eTVlam4rVjdOaFdHd0w0anB6Wm1SUlor?=
 =?utf-8?B?b3JVM1oxWFh3Q1N2aWdkUkppRjRpMjBiZ1F5dkllWmw1WUhmMVpnRmVlQVNR?=
 =?utf-8?B?Wkd4SkFDVVR0c1U2WGhXQWZvNlI5NTZzRXQzTHNJcFZaaGpZMnp2aGRxaU8x?=
 =?utf-8?B?TjlreFdXSE92MlR4bktSOUwvU1lDOXlQWXRUSjByVnB3dEoraldQU2NUMGpC?=
 =?utf-8?B?eExmKy9lczJLT3F2bjNaSEVyRXFhK3grMjN5Q0M5WDJiSVozdUhqUTBtbzB6?=
 =?utf-8?B?MStrWEU1b0VBSXN2b1ZGV3BMTFRDdGl4R3VqYU8rOWl2RDhyWXltSHY5alhG?=
 =?utf-8?B?MFk3ajhpK0hnT3FxRUg1bzZVbEpTNCtjLy91cnN5YlZVcUtXcjlzQld3UWRY?=
 =?utf-8?B?VDdaUTIwcXR0Qlc3QUdNSGJIUnVqdHRrZEpwbjQ3U05rOTAvNWJmQnM2cmNu?=
 =?utf-8?B?dmQ0TGxqRytpYVdqOEtvM3lwVGtMNmYxTUJHR1NxVkQxRmdjSTlnblVtbUdL?=
 =?utf-8?B?RTJuMWVUTjJ0eGRkQXFOdHFCTEtZZkE5cS9xTllyTlhQQVdiWCtSRXY1QmJR?=
 =?utf-8?Q?FvZi095nQcuAuGoGGwgavuC1y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc5a3c7-efa8-4b61-e420-08db5566348c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:02:46.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShnSy5HC/idH5JLPJezg8fmsVHcyzmqEuQXQKFzP1hrheFHSUr/64rNozCuegCYQehBeu37IWFDPetQq1ua/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_100302_009577_E5155F3D 
X-CRM114-Status: GOOD (  12.71  )
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

Hi Keith,

On 15/05/2023 17:57, Keith Busch wrote:
> On Tue, Apr 25, 2023 at 12:12:42AM +0300, Max Gurtovoy wrote:
>> The core.c file became long and hard to maintain. Create a dedicated
>> file to centralize the sysfs functionality. This is a common practice to
>> separate sysfs/configfs related logic from the main driver logic .c file.
>> For example, in the nvmet module the configfs interface has its own
>> dedicated file.
>>
>> This patch does not include any functional changes.
> 
> Thanks, I applied this for 6.5 with a couple minor changes:
> 
> I merged Chaitanya's dhchap memory leak fixes first, which touched some
> of this sysfs code, so I simply used the the result when moving the code
> to the new file.
> 
> I also added an 'include <linux/nvme-auth.h>' in the new sysfs.c file
> for when CONFIG_NVME_AUTH=y.

Sound good.
Thanks.

