Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5AEC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 04:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AzWRrkHJ3EGZ/MDnSK0WD+A4QS10aW66yWrn/BN0L30=; b=FJuPIu46iqxRnFZvwrBjcjP3P0
	g6zPNiLcnLstbQ1A1iCt5EcplNNTOr64INCKrkwF4WDT+RG8vD+noIEMyD1DYN+A9c/ykDPoQ5BBT
	YiUSswC8Ql15uO/SXFavF0m3IuVsdzofDnYIZ/+0N+j+EXinZF8lrlGltsUNZJlF7bzqcq6G7cmar
	rkQImrPEeXpiF9G5c3l8yvlK/+6iagYzmVs0CsN1K+Mr6geOMdkhXhC1SP+g3f2JoS+U/Zesn/WPV
	ZX2uQnc/YYAdBbyKYpySpnVGEDhQGNNI02ZkAz3BKEIPC9SnsBWXiBtOFwdjcwVmnepD8SodgWM3P
	ct4MZ9iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozsaS-006CJU-UH; Tue, 29 Nov 2022 04:51:16 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozsaQ-006CHI-0m
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 04:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669697472; x=1701233472;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Jqu6cDjk34RSq+LCVSDPL7ABEE5q1j7PspsKgUNVgYc=;
  b=gVkZ67juy3YVV+2JN+sGLyw1h2s1B95OXiC8Kyg/9VpvZ0JrPjPMlWcb
   KF5PcBqD9ZB71ssC7BMl/hM/VZ08HrRISjGryyx3JQCyal9AtApHY3WMJ
   hPaAMTDEQAn7Gr1Vf9gugKGWCXPMchd4R7AuzU/oL4yuRI2V6V+b2wTOz
   R3JCqSXdNjMm9eccRBKpOchnFw7Zs22kC1jWMZIEg25j3KN3t9bAY1eea
   FV9cC+G94H36KUbJdk1Z2NsPHnixzKT+gILtRZ5bmdBNx/RgsY9pa4hVO
   3rE+2rYqww6Y9bN2nTLicpwRZCoH3y01WZWxqOeo0YkN27W4K9SE0kis3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316155523"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="316155523"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 20:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="621311723"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="621311723"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2022 20:51:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 20:51:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 20:51:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 20:51:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fclJ2ti+zfE2G6cYKuYLVkVRs9uwySb+3JsGO+48eGLkCcbI+tMgTcITNvndc8d1Wurx7z2YYCH2s/jWVOIYXH6r2bneD8kaMfWQz4BqXX5CpT/mjpmuwo8rAV/9ewnYh++SGJQ4gzuaNYj3QrAr+t4JfNd1mKz3nijB4rL8oJ4Au0loDZMrFVWoIWBMs0SjY8MTp60WFuBdXgZcpNdk8HJBpISdtPOeXC9QSQPfKFWsO2J8yIxkHQvyMILwvKtjZ+0lKu4b79ha1A6Z++627vb4zBlW4BTxl4CAT/huvawix4tVWujbjqySZ83nAO2XqVlav5V5p20E+5yWqUCNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzWRrkHJ3EGZ/MDnSK0WD+A4QS10aW66yWrn/BN0L30=;
 b=DgfLQptylukZny/5sv/ZRr6xPF+bqlYTBV1rfT4ASOuY2y3m2eHe8EtMBOrsazFQSdONuqF04l4Vp0uxxlh27sPiNKf9nS1WutdZuaglfSiYzmqwKbl01EDFuezdJ93IEpgmIx1eygkVNhuDrXSRjP/p3b1lCVgAj3+JGewI33qVYkj9lmzWZnQDl9T/y/cUMN6+n81CuJLBKTpdcAepVoPgBnla0VKUkX7WiNOLhpjpFEoVfElZ7KqTc0OROWt1JXeSXP1mWfRGyKh344JCIcsGYwJqrEYnvWqp6fBHXZv5FutyqwWhV+8otV9VCi8jK/YiXSvDpw5aogHJOQ3lNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5640.namprd11.prod.outlook.com (2603:10b6:8:3f::14) by
 DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 04:51:08 +0000
Received: from DM8PR11MB5640.namprd11.prod.outlook.com
 ([fe80::ba45:6089:4ce:18a0]) by DM8PR11MB5640.namprd11.prod.outlook.com
 ([fe80::ba45:6089:4ce:18a0%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 04:51:08 +0000
Message-ID: <4cee0097-4f08-1990-112f-6e39229f59ef@intel.com>
Date: Tue, 29 Nov 2022 12:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221129014711.91305-1-lei.rao@intel.com>
 <15de4902-03e7-0d2c-4b4c-45d713d0f1fd@nvidia.com>
Content-Language: en-US
From: "Rao, Lei" <lei.rao@intel.com>
In-Reply-To: <15de4902-03e7-0d2c-4b4c-45d713d0f1fd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DM8PR11MB5640.namprd11.prod.outlook.com
 (2603:10b6:8:3f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5640:EE_|DM8PR11MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: f99e7275-c70d-46b0-67b5-08dad1c553cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boqkzVGMsThtPO+xBwJ7CcmxXdKkNnK81G4jEFMGSVyt5DROuWPP2GqsN4BK0OI25d0VIa2zpKcyQq68z5lOInZEaCFfS3sIvCVdd5VJrKGO6fhHa8k6PwKY8CkHGNaQfohz9zcQjz0OKxVpvFIG5BkpMkrcafvzlKppced73A830SDCYbc2hd0hflIdGezNO2pOVnVcammOe2sSbXAop1BImsudJl4uLm1HNKi489oS8WJqSnBsQ8gEQJbj2itpzPpnoEp2nCFt+gSea2D77t+EiPvYaU39HwziPQiRwyLOjZwL/lvvrdyaTnAHr8Y4hBL4U9kgE2CjrynDrY6i/UqoeVlaZske74RBOnIgIkDNjHngQhOiWk1CBZHp+kpnWVKBhH372y5CpS3DSc1ycuaSsjr/+gLmDzeIgS+9r9WZ0MCe8xZwiqr1GnIAB34SJobAFUYeExucGlQUbL/78Rojtg/CB/1ps8QvmUReCvElFRKdz/BZJNGU7knGhN+GeZ+i27X8a91Wbrl5FW9nf9fiAgMPqjVmnDdqHCMsBmWoATWy+Uy1XCoObzwmj7B3VU4RjOjMmnHyssr2ZleAwH5lvqcfpDB6Xm0Bc72gEJvZm/7/BcGBNYXeZ6Nsm6kB/SxEKUi7YRPWAKdENwz9AOy0p17iAKdgMXBExLrIjUvRMOvuAr8L70lPJVsBpMCVE1fy95Jw9xW95RghrhZkdd6shzF3g8zjg14v0NvRzOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5640.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(31686004)(83380400001)(6666004)(110136005)(6506007)(6486002)(36756003)(6512007)(31696002)(86362001)(38100700002)(26005)(82960400001)(186003)(2616005)(8936002)(5660300002)(8676002)(53546011)(478600001)(66476007)(41300700001)(66946007)(2906002)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlVaUG1PbEx4NEh1dFBZdWtVbXhrZjEzcEpQaVI4ZGRzN0RTb2U4eVdMMTNR?=
 =?utf-8?B?OUFJMXU5OEU2Zk5VQUx3WUZyL05LaDhsQUV2Qm5JMll3K3A4VWc4VWFHbTd2?=
 =?utf-8?B?eXR1RTFMUEFHRmVJZ3V2R29DbzM2RUxyTytScm5PSmVyVDRQdnE4QktWYUxm?=
 =?utf-8?B?MS9jM2xKK3BFRkFIVzdudThJRlkyVDBzZks4UHk0VCtBTmgvN3VGWUlNMi9x?=
 =?utf-8?B?aG9WTnZlckJvRGVBMFRpYTBsV0dTUDhCbXhPSVZVbU9NQ1cvUGY3bTFlY1lJ?=
 =?utf-8?B?U1NEeDBYUjVENjcrbTRhdWNRV2d3WEhvWUtPa2luR0NYdGhkeFRJNE5vckg4?=
 =?utf-8?B?ZWRjckdiV1lKbEk5eTBNWUJrZW4rcWhKZFk4K0tCM0RnTTM3UDA4WmlRMWRy?=
 =?utf-8?B?c3NsVGt1dUNnbThsK3FscFhmYkVhbDIxRXR6VHJBS3lBZ0ZnNTJoZjh2L0hH?=
 =?utf-8?B?RDI2T3Rqd3p3RHovdjdwMVVqYnFMc2J0NUVVT2ptOGxteDdSa0xUS0tRMVk5?=
 =?utf-8?B?MGxCK0NQSGNSbGxHdkNna3k3QXJmemdMZysxdzNVUUkwenBHQTh0QzFrZDdR?=
 =?utf-8?B?NERpczc5Q05zUW1XdFVkSHpRS0oxekdvOG4zWGUwczZ0NElVcEZSazFBeXBx?=
 =?utf-8?B?YTRpeW5obGtPaTQxSW5DeGk0K0lCQmFHdEN0UWdCR1RrMmJsTWhYeHJ4TTVr?=
 =?utf-8?B?M29XdWNESVBXWWtOZytjS2Z0UWJ6d2pmd1pxNk0razRCeG96UlFmbWd5WlN4?=
 =?utf-8?B?NzRWNE5PWmVzd3VFOFJQZFg4cTFoU2pYQ3AyR2pkYitzREhOWGFCNUtzMlNR?=
 =?utf-8?B?ay9mVkdoTjFCcWJkQzBpUlloS3ZVVzFMVFNmSEtnQVJvY2sra1RUeHJBbm5T?=
 =?utf-8?B?dUZjZzRzbU5rWWtrWUNIUHlOZU5KMC9YS1ZQOUh4dCt0QjFaa1ZmZ2ZsWk9q?=
 =?utf-8?B?NFVFNkphcUNCdnlIR0QyQVhPUi9XNmNTWW55a01XeVRVdFFGck8rVWJXbDI3?=
 =?utf-8?B?RGZGV0FQOXpDRmNiMFRxaUZRN2F3c1hjQWFFTlFoaXpQR2VnZ2MzRGFvUDBW?=
 =?utf-8?B?ZHIxNnhVeGViS01SOW96bVFWZlV0dXV3QkV3THcxYmc2QXl3Nmx3OG1IZ2pi?=
 =?utf-8?B?MTVPb3JmU0dwNzd6Nmovc3R1azZ5TVQ0MjRObWM0TG1IdVFBcVM1dHU2eEdN?=
 =?utf-8?B?ZXBid2ljeW42T2RBb2VucUtCLzBwZjF5Y09PNVc3dXI1REV6M2liK2VSMzBN?=
 =?utf-8?B?Y1kwemtncTFOVVpvN0lIL21VRDRwMTdJUkFiVXB0UmdaaHJ6VE9tUUgxRlcw?=
 =?utf-8?B?enNjbXRkL2EwNHVrY3gwTEh3bVF5TzZuVHFHK2dnbGMzakdRdURMNjBqY2pn?=
 =?utf-8?B?Rko2eHJjeWRmSWJINnRhZVhhQmVXL0NuMnlkMVZRYnF1S1BQb0ljY1JQK3NH?=
 =?utf-8?B?c0NHVGN6ZGdqN0xSUTkwUVdPd0F4L3Q1ZG1MWit2YzdwcEp1c2hHV1QwY0Jz?=
 =?utf-8?B?ekFFbkxkbkdSclM2dGJhMm9OWE8rOWkySXZ2TXV6c2U3a2l6RXRJeGkzemVC?=
 =?utf-8?B?MXBYUUJqYUZVR0dYekorUUJKdEtYdjhkYUZtbmNvN0VNT3ViNUFKOTJDblB2?=
 =?utf-8?B?MlZXVWM3VmU1M0pWelBnSVc5OXhjMGZ0TUUrZFgxK2pERmdQVkFBT1VGNVpr?=
 =?utf-8?B?aTBBeTQ3a2orVkMyVWpxa2xaVkdNSmVRZDgwMFc2b2o5eHVsQmxVR25CRFZt?=
 =?utf-8?B?ZmZ4R0QzMTNzc2V0RFhxcUFad0l6M3hiV1l1WTZRUmtxWExtcGU4aGpwS2Q4?=
 =?utf-8?B?bmRYdXQzdHZLdnliU2NidFF0TEVZL3cxTWdacXAxQk1MbkYxM0Z1Smkyd29q?=
 =?utf-8?B?eHVlUStjdTcyR2xsSWx5dmlVTTY1RnA1Rit5aTNjQjhLZGM5ZHMyUVczSjdo?=
 =?utf-8?B?cFJBNnlRY29PNGh4NUZ2VCsrM09menN6TFlKMW8rQXVucmYrM1BZMHRiZUJk?=
 =?utf-8?B?NnJZK2IyckZMbVp6WkhqK3V5ZEZPZ2ZobjltMzR1MFV6c3BkNnRZRmFsd1VP?=
 =?utf-8?B?N1laVmdnbUFRREtSY1AreEcyS0dEODZwYWJwL3F0UG5FRFdBam84a0hlUkd1?=
 =?utf-8?Q?RviLNiIYqz3bZDUZaERcWnWe2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f99e7275-c70d-46b0-67b5-08dad1c553cc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5640.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 04:51:08.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXOZRCZZeYpwlpVZAnJ/zUl8dYFd+/29WF5gNzfaGHX/ecMAiTNfUS0Nu1nkYW+3Yf9AsGgynmHEibQ5o/weWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5653
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_205114_221529_DF86E345 
X-CRM114-Status: GOOD (  16.58  )
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



On 11/29/2022 12:16 PM, Chaitanya Kulkarni wrote:
> On 11/28/22 17:47, Lei Rao wrote:
>> If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
>> field is garbage data. According to nvme spec, the prp2 is reserved if
>> the data transfer does not cross a memory page boundary. Writing a
>> reserved coded value into a controller property field produces undefined
>> results, so it needs to be cleared in nvme_setup_rw().
>>
>> Signed-off-by: Lei Rao <lei.rao@intel.com>
> 
> if it is reserved then controller shoule ignore this field, no ?

It's feasible for the controller to ignore this field. But our controller has
stricter checks, and if prp2 is not used but has a value, some warnings will be
printed. According to the NVMe spec, it seems to write a reserved field produces
an undefined result, so maybe clearing it is better.

Thanks,
Lei

> 
> not sure if original author wanted to avoid an extra assignment
> in the fast path with assumption that reserved fields should be
> ignored if it is then we should avoid this, if not then looks good
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 

