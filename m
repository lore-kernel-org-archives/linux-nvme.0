Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7135DC47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nT5pzaHWXowlAnVqCvihTtZf5X2/WS5eDuqtTqjrsi0=; b=vxx8BBAMQVljquWktvykcaOqlk
	jx9psOA5Ob3kyOfrbAXaXKdNmsoxQDfrrrWH5D1XBrACc8npDETqkjfug6r+jSGMSd6AhiqCGDtDg
	ZyYYb0ogKKc8u8JW4HDqzzPIRNfdnnu6r/DjMEur5r9FdiOYh3mt/7pOwhoUNKAs8hui3UELR7/Hc
	CefvWaZWNhJrIxt5gDRb8v10jPqV5VXqnw1fZ6y/lf3gLkTyMWFth8iGyygMz/wuEBL8+Jqs5n8p+
	FKsVeeS0QmSMBBBZRoNMNPXklRryB5Iqx1b0b5IUbkTqQYtzmvfjbAhJeuXLVojZNTJkkf2COTSKk
	PPf0b8uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUQtv-0000000Cd6V-2LVY;
	Mon, 29 Jan 2024 12:38:11 +0000
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2409::601] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUQtt-0000000Cd5O-12fT
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 12:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjHU/coS9kIrdWR4ckDKXjkdi3YK311KYpWVsdixUoCARVuCNHOQFf/BiecsegmV5YZMzY6RzBGIoiUP+jNM792sm6LZA8KpkF4G7Byf6I5agjLjA1Lk1goVH8G6io9WMQ7SFJO4NyenE0KlItf2k6W1GOAGiZvcl5rQTl/BxbctmHLlG3wwEN0ZzlXwJTxSsd0Nvkh76FYIVtOC8wgkPomV3ooLLxzsj38Nrbqf7NEdn3v3fqD5BctpXDf+lOWYgrYGG2pfTqtvnxJl/Y61aQ51SzVAuWSPa9ADl5X5Al8mBWduFWqjGVdHGCv7jx9mlyCnCGis9KOQWwWhK+zanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT5pzaHWXowlAnVqCvihTtZf5X2/WS5eDuqtTqjrsi0=;
 b=ThRk4VLZMzO5xPJnSjOWNNYH0QHi3pB0hDoYRjU9ZTglS7t8I+EUeFOHiIXGUuWFpHUUB2DHIgnUzbVuVaaXfQJCkNmYciHOsKLbEUwu2p2AB0mZxMaIlf1xCIZxnopsBFhhrgkRN2C3J0HiXjfE6OgTee7e87Y7kyFYy7lABQO6dsx2UX85puOtgRLkBxV/e0KVIL7vJfHIRRpJQ40qsbcg+yvi+h7Xr4/TvFjnea1wdGCSm4vt83jGIPQ5UcTSb074+efnTzxoEKfJ+JQ3i3RfmRUBDtV4Kl/velGFi4AvOfGYMyaG2oaq1yxPvXODCw6HkqPA1BojqKvl/KJwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT5pzaHWXowlAnVqCvihTtZf5X2/WS5eDuqtTqjrsi0=;
 b=tueh139c5XCtcOCZxpD/zQXIs8fFMwjkcdr3WDh1x7ZThFn7TB+n6SYsJeGerY7osq/67xy6aEDBiVnghLvoENj6ZK/IMRdHodnHU0AfigeE4TrH+G3E3UliO8NvkT7siIHfU//495Wb13Hodx1BVCjYbdxl2fuDPe3vnCf5At8X4ERpJPKy66Mpg+MIRe7McnD4b7RG01m3Q8rBOUlmW9f59eP8938/BiBj5dzhbWhHCyShNdYyzDonFaSCSJvLtjn/KB8EiF4TPKJU826eJd2BNjlVqCkBnn8WVH2SLsWqVD77eTHXTgWn5ekh0w/+KmryhhR1b9sCGZWsmw09wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:37:59 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:37:58 +0000
Message-ID: <8d3c4f09-a1be-45b6-9452-7a14609a62d1@nvidia.com>
Date: Mon, 29 Jan 2024 14:37:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, oren@nvidia.com,
 israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de>
 <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
 <20240124094832.GA31289@lst.de>
 <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
 <20240125144130.GA18804@lst.de>
 <d8f4c989-00a2-4545-87de-a70da312beff@nvidia.com>
 <c7b2670c-416e-4451-9c29-439595df5213@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <c7b2670c-416e-4451-9c29-439595df5213@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 65eef425-ca94-415d-aba8-08dc20c71fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEm9AY2OPAdeoLT2oqJcJlHypE9oKKjWbUA+n9txBslwmufUcF1ivb045x2nXNeuMXP6YT8drwLPiss7BFeK2ZZByVFwQ+0MGEm/0qeB+84ecaRDyiinPFS/3y3RvpOjFEM3WQJFEjwD4x0nPSrHzrd3MZu1pEtdr+5ybgof7sNjQC5sXbuocEVvcY+2bDbeFkJ4Sc7OjTJcsfsvKHiZMdTDL5ZBsZvlBLSwzmTEkmRlpBCcinIQ5C0GDfxhqBM4LeURi3yxEMlHwXtBg5B8yobS3u7sPC2pg0TzxcbTlV4FQ4BzOXVTR+vUncmFbBQb3OwnjRpIbMXr8ADPTmQM+knn578MD+OZFzrwX0+Mn9pOBi0e03bG0XqsDPDy5wYeD7Mpq34Ogg6WvUnkSIKi/Raho1lH4+x/lY+N7sVROAhdZgTaRdPjXm3WNW30wEfVpVEEl4VHyUpY9EqN6pZ/kOhqQB+3nUOtpy4HapI0Ydp8QJyvDpZM79h11y9GJRLbXISkURYbj4yI32vNzejeWrg/8YXwk8POZg0O8azmTJhAHfvtaGV01Dk8aqYWQZUs6xYEEC92WkE1RbkH5uHUSHwPmCUEFEhtyQwZSxlHtKZe9L56daXtLydDtp1HPgIwBgz+x9n8oR9S+6uYldTDaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(4326008)(8676002)(8936002)(5660300002)(2906002)(31696002)(86362001)(66946007)(110136005)(316002)(36756003)(38100700002)(66476007)(53546011)(6506007)(6512007)(478600001)(6486002)(6666004)(83380400001)(26005)(2616005)(107886003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdDM1FCazc0cWxrdDRqdTZBbmdXbklQWDFrQ1RYbk1wWHM2Q3N4SjViR2px?=
 =?utf-8?B?bFg2Y2U3eVY2V1J1ejcvZ0RZU2dMRG5mQUE3SWdWNHVXTTRaenI1U3pna2ZH?=
 =?utf-8?B?Nk0rSlk5S3ZJcWdOYjVWM3M1czVMNkQ2dVZEVjk0Z0hDRDNRNXVNQVR2aysx?=
 =?utf-8?B?cXFxa2ZUS3hJNXlyaVRZQjBwaHl6bmFGV0VCVVdnMVFyZkI4d0hEY3Y5aWVK?=
 =?utf-8?B?R1ViYjU5U1NocmlhWE5Pc01xV1hva1V2ZGVvbHNyTit2SHYwOW5maDc4NThl?=
 =?utf-8?B?OHpWOFFybU5FNW5OTUJ5SlM0N0ZIQ0RxYzZZSjZRVXpjdmZMWE5yOTdWeXdp?=
 =?utf-8?B?Mk5PN1FvcXpFZjlIU1gzU0JrVDB0OVYrRDNLdWpLL2dnSFlBclVWWEhFSW5K?=
 =?utf-8?B?OURNdnFLTkhaeG8wY2Q0NlVGVUFiZitycGhiSXpNWW1UMnFFVGp4bmg1OTBY?=
 =?utf-8?B?aE9TcENKbitNc0xSdmRVK2RUdW1yWkxPWVU5YTNKNmhDU0Q2Yjk2dndGalVr?=
 =?utf-8?B?ZngwUlEzZkxKWFhwUk9wNnQvQ093a3UvK0s3TEZvR2p2a0U5NVEzM3dVdXQ3?=
 =?utf-8?B?dWpESURkbXNGZldXQTBmZFlZYzM5Zm90Nzh5SThxUzkvRW83alMyc3gvdW9k?=
 =?utf-8?B?S1lUbE5kaytoeW0wR2VESkRyeHo4TElYUER4dW9UVW02WUQwamJ4M241bTFo?=
 =?utf-8?B?U2ZLcHY5TnkzdGJWaHlCT0IzNWE1RWZYOE9CTS9qeVQzTFRwNzBBU3djeE9E?=
 =?utf-8?B?d2l1QTJSRzkxc2pmb1hvZVNlaCtzT3JnN2pQeEJpbmZzbkFYOWVlTTVFa1Jq?=
 =?utf-8?B?a3hBTjhMTnFXbk0rL3FMZG1EazEvVFVMZDZiU0VBUkxSOXhPelh3SzVjaXFP?=
 =?utf-8?B?UGZmZlJUd21qR2FpMzNNeUZkSmRuSmY1bm4zaEhKZklQTnNNRmNQNHZLRXZ5?=
 =?utf-8?B?R3hYNDNqdWxxNVlmZlBSVlhzTGFYbVM4MmJZSGFDZFFGYTY4dXFJakp1L05h?=
 =?utf-8?B?cFBkOW00dGZzK3drYy8yVlJoS003SDZLR0d0YmZqMm1tV1dKQnFBL2Q0Z3g3?=
 =?utf-8?B?cXZKZERpVXpGeXZ0NWliWEtpaHBnemdDV0hvQXhwZ1dvNDAwUTU2RVMvU1dj?=
 =?utf-8?B?bDY1dFNkSDZ6UjM0MjRtOWo5ZVhSSzQ1emRUTUJOTXF6ZUFmZjlxaFE4UFUz?=
 =?utf-8?B?OGxYajNaTzFqbG5pYUR4b1BaOVRRT2JqalZiREJSU01MRUJPUzE4YTYwdkpr?=
 =?utf-8?B?YlJtc2JtcFZRaUZPRHQ4d1ptZlhSTEdIVkFXbytXWWZVRTJneWJTUks1OUpN?=
 =?utf-8?B?dkxtcncrdWhseWg2bU9XeHF3aUk0cW1WaFlDQjh3NXFIQXdVeUxsb3hBZ1ZL?=
 =?utf-8?B?SUVoMVJrRkx3NURZZWp2QUJoWmxNT3JOVVd4S0s0OTh4SmRvREs2MzhzNDBp?=
 =?utf-8?B?all6eHRadmhBRkpGSys1MGFMM2FVTDlKRCtjbURuVzR4UTNPbUcxbFFra0h3?=
 =?utf-8?B?dDdsdEVhdmZZQjY2V1BZTEQzYkdyQUYzVTlGcERZOWg5V1gyVXF4VHlTMEU3?=
 =?utf-8?B?VkxYbG1VY2h5dEpSWTh4ZS9PaGN1dm40Y25valJZVElKT0d1ZVNLZVhGZ09I?=
 =?utf-8?B?bkV4aGYxTjY2OGZVbGdrdW9temFucXE3V1VrQUhkdm1xMEVGLzcxZVlRRkFD?=
 =?utf-8?B?S01semdsMzBPREszUjVSWlpWRWFqbjRjbkpOWHpIeWZsVWZZMHJDWkRSSmtv?=
 =?utf-8?B?Z0E0UzZQcldUeUtIaTFhbngxK0RqNytOWGNjbW9IZFJjcTUwUFhmSnhIVG5o?=
 =?utf-8?B?YXpJVmk4TzlpTEd3eUZKZTRQU0pLV0JrRk0vWEdjcnRUZjFXQUdzR09rbVEz?=
 =?utf-8?B?TTZ4TEdlOFdwU3h5SmZhWkNEdUNuYms2aWRHMHZjd21YNUVWSlVpaGt1N2t6?=
 =?utf-8?B?YjRhNXNyb0luSVFsdjB6SVZnME9DT2J4RUtGb2FhT0VpZmhoaVdGQTBpYzNh?=
 =?utf-8?B?ZEVFQTgvME9nVERJVXJtdlRYK3NwaW9TbWJ5NU5zcENSWFU3V0F1QzlRaHlo?=
 =?utf-8?B?T29xQzUyeTk4b2YxV2o1cjVRUFFwZVd0VlE3eGZWUmcvemdIeE92d09YeUgy?=
 =?utf-8?Q?IzHMNHL4Cn3BQTCuDc1bTwvi2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eef425-ca94-415d-aba8-08dc20c71fdc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:37:58.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb5cP55SOj2pJE533JqjA+dFeq5Whe41XOmyB0YWB0vJulX9xdv7MvGSbmhAJfeNCCqfJhVmMDwcCP8Vl6WWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_043809_348772_2589F1DD 
X-CRM114-Status: GOOD (  21.11  )
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



On 29/01/2024 12:48, Sagi Grimberg wrote:
> 
>>>> Even in this case of re-creation we must sync the namespace 
>>>> identification.
>>>
>>> But a format is not a re-creation.
>>>
>>
>> we currently don't support format in fabrics so maybe I didn't use the 
>> correct word during my answer.
>>
>> because of the dynamic nature of controllers and namespaces we have 
>> the identify ctrl/ns commands in the specification and we need to use 
>> them.
> 
> ns scanning has been notorious to cause issues when executing with
> controller resets. So I don't think it is a good idea to make ctrl start
> block until it completes, especially not for an esoteric case that
> a ns that suddenly was reformatted between reconnects.
> 

I think that making sure that the namespace is active and validated is 
not esoteric.
What is the concern ? is it the time it takes to validate a namespace ?

>> Re-queue requests to a non identified namespace is bad behavior. It 
>> might be even a spec violation (I need to dig into the spec for it 
>> probably and try to find some description on that scenario).
> 
> It can't be a spec violation, the host cannot know if there is any
> aen pending (for example NS_CHANGE) when sending *ANY* command to the
> controller.

I think that AEN and reset flows are a bit different. The controller is 
free to be modified at any time (even when no Admin queue is opened from 
the host). It may have out-of-band management interface (for example the 
nvmet cli) and may not have any association (AQ) to the host to notify 
on changes.

