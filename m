Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0534C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:32:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823B561284
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823B561284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YtavE2xw/VvDqzu7fNwkIAnwzCVCrwv9fXFkiVHtA0A=; b=L3o4LYrnriDKXrAX23jxGfi/eR
	w7CEkgfdE6XMbpQu1/2PowggcT0P6NLlw94olnNXoz99r+dJbMNCZxR8vM9eqf0ytBzhla1YArfOx
	g4lsx7jgLs+gxB4jj6Xu63pcYUb6JT6bkeJp6gqNfjrh82PfKrGN7A6cVGJrNhHfug5IGzmICHaBE
	/wZrJ7NSbuX/NWLLlB7uofXhCWq4kM4OBcAsqkT5zQ+xc3CY/DpsVGDMqyyQRFQjbXGZXPlw3Pn1D
	nu9ex+l5C26HlzJgmhF+/lYDNxzSHDaQ7IWeLmCFQgee3u4BLBirf+TsXhHN0+TClIgglJ0lPsNcQ
	wb5zt8Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmKoB-008VxB-Ix; Thu, 27 May 2021 18:32:40 +0000
Received: from mail-co1nam11on2085.outbound.protection.outlook.com
 ([40.107.220.85] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmJQL-007uA5-MX
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 17:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxVJzqyuTJwryUQhMYL+zXwqsoN7R//rK0cqvAZ8ua9UGOP5RA/wx1H0T5dVt+b5eFhbcncg7IergCjrNo3HAwgcQ0NRLFh0fN0UKGFa21PpbiNLkgzhOPKXdgJms6cuMjJcqO5Pc2dYMJY4dTrLjXPRrvTEoJKWIWTzExJN/heqyhBACrNYj0o6yLpfiC/ZkJ6wstXByObywameVwwPC+zEtfRbTx1TU/daB9GGjR8xkYL5s3KDndgR0zD0hSPZdO81E0sPnoau3btn7Woi7H690nefuEzHKUpNeE+M6CE6mSsOgoeJeUOMfz+x6Nlk66Bi9TSLQqY+EOsKc3j+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u6fw+8rTkCNEiSYsJPtKAfaxWDO9cOpVAqMezc35tc=;
 b=SI8EEl2uXkK4XRW8hNf4nA2dptXQyDuqLUd1jTxsqAW0V81Q0B57Ts3zUUQVIu2YU4+sY6dSoAIO9ZYINAZJ7rwa0lzxroseRGn8kTDH97RocJFLT/9KGftCVKg7YhqTNqgp+i2mwet4vg95gkuL0codvKYP4MK7rqZT7bIGm08NZRsDo1JU6hbxtFIG0w9GBC0LS8eoD5B2j3//MOo3LZ1+9g5RmobK3jGUgbnuI8c6hEXm+WiWfaaWV0gybQG3GzXrjfQDETHEvTqkkM7M40bC1GXOcloDk6VChP5vRMhbCYH57RCUu33z6Cxap9D2qkT4mAu1tCCKYe9NzvZz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u6fw+8rTkCNEiSYsJPtKAfaxWDO9cOpVAqMezc35tc=;
 b=enSzhU5iOgbsdDO7NzEUJlTtWSGC8t2J+v8T4k7rsWOaI90DAOnO6933BGAsqxw5jg2vwHTKSGeJAoRdiovO4pS5gy9drJzA9y1Apj3oL4o4cUk94JkX12nn2TqWnaK3HcoDVtZJ9pClyGB8xFtWqxZdmy8Hheaw2CQdT8IJpN4=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB3987.namprd12.prod.outlook.com (2603:10b6:a03:1a8::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 17:03:48 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Thu, 27 May 2021
 17:03:48 +0000
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
To: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, rrangel@chromium.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210527135941.7634-1-mario.limonciello@amd.com>
 <20210527143548.GA32170@lst.de>
 <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
 <CAErSpo5za0x1fXm18YNzdNRFdaucVs=9Hhh2kqRS_baWos5Vgg@mail.gmail.com>
 <20210527165844.GC3706388@dhcp-10-100-145-180.wdc.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <7926de24-d3e2-4e01-87fb-4a906e21e021@amd.com>
Date: Thu, 27 May 2021 12:03:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210527165844.GC3706388@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.51.208] (165.204.77.11) by
 SN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:805:ca::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 17:03:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2b17863-ac37-401d-e51b-08d92131650d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3987F8E61E2AA8DB9652C63BE2239@BY5PR12MB3987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OIoOuCGG+ki05i8XO4zP2yF+O57gJT1H8kDCn0uC8J4h/6miqzHqYptEIl8icjj2+fqP5D3RwOvVemQvM6LIsxFDiilRs6KVlz4+nK4f7J7L/CGDDK1lHS4rWwU5VLg3bB4dexSsiwtTn/b0MXsuWhYkWHk2npww0/fQYVBSra3G95BuSOcdHEbG91psVHEDCsFpm6HsA4iLZPNYiCe7Iiw/NKobKJqjayRRMGPX549/FpUU0im8FW8KkpYbrvX80x74opb26TYLoLJQs5w+nZvaWXbeBDGz1J2/mNbdMKI2hsblsarPgMSTufOMD+1UxlcyxLstW86vgrNLC+MWU3F9lAwNcYqVdi2rJJ+VIEpPFbK9BWeYQIt9MxsDeYekuVWC3frd0AzSEpcdGAcUJ09OmkJmMvSvSkk/kNHMJ/uHiqoA92+7wn2ErcuGqNT21v9ECDoPAIyG+JC8sjr58C/NW/bRj9e6/MwulUrfXd2z2KlY6DoK1NdEiacvixL0nxoUTdErPDWgfRKqB/cHB9ffTJAQBSDoiDr9Uow9J7OZ+GBXzPI+CDRa2PKR/cQIsIJslTE7U+FZMkBdWsUd89WQqDenlVw/Eua5Jz+dra//ENtdyLSQZ1VU6RfjZM4jrTL3Vnzd5v5Tsomgbh8jLnPZY0ZMPSzKuc5199Je3n4+hL1kDoUBlL+u4GeUW0jo2aE0gQkMGoT7YzRiki45ZwLCR5W7IVbBjzl4VPgi1J3F/SjkCZhAiAgRNITJam7NQMQ5PUCQs35XXgE89Zi3yfbXUAO6GhCJeKLpX5sA4lniNj3l50iDsZiYjCgtl3+EOyWhBcEThv4XWBHyORgEm+mcFiE1XW4/WMGiNK4lAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(2616005)(66556008)(66476007)(4326008)(8936002)(5660300002)(38350700002)(38100700002)(186003)(2906002)(31696002)(956004)(16526019)(86362001)(26005)(16576012)(54906003)(52116002)(53546011)(45080400002)(36756003)(31686004)(966005)(83380400001)(478600001)(110136005)(8676002)(6486002)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z3R0bUtLUFY4OXgwcEtBRzJtbWdNMHRwV0gxVHE4NFE0cHE2UkxTNXVtMzNs?=
 =?utf-8?B?VysydmNCSWVJdy9sY1RQbVppaVFyWmNHUGxBUUtzd0RpWU9mSk9VRll3cVMw?=
 =?utf-8?B?VWZuV0JZS3dqV1lGNU1SUVNJRExQYUJKdnZmL0NzTWdxTjIrTGxnWXhJeTdh?=
 =?utf-8?B?am1lWDZGYWdYM0kyVlZuQWhoc1lYTGRoSDVUVnlpQzE4c2xiNXI3WUJuRVNH?=
 =?utf-8?B?OHh5bi9aSnVDOXhhWWdVcmgrVW5JWTlqWjdCUWoydkhMSFpBaUVTT3pjQktn?=
 =?utf-8?B?RmFVVi80Z0pRVVVoZ0QrbmtVeHV0NHFydnFTS0ZSMjhiY0wvbzBJTHFJMkhR?=
 =?utf-8?B?c3FKMEJ5K0plMWkzemhvdXp0L05ZQzlXWjhjd3YwOTROT3lsOG9GQU81Wnhh?=
 =?utf-8?B?N3lZMFFvbCt1eW9lUUgxc2ZRWVRXb0NhWE11MU9kckFoeUhiTEJDUUZSc1lH?=
 =?utf-8?B?bEpxeU9MR01Ib01hN0ZLc0xJVExzZDRhVUdWS0JYcHFRTlJYcU9LRjc1NTk0?=
 =?utf-8?B?MUttbEFjN2RRckxLZmJrS2hpdi8vOEJhRklyL0ZlTS9lUEpLN1N4TklkZDBR?=
 =?utf-8?B?L2p1dHNmck9JUVpPc0piZmErRWlyWkI3UmhlV3hBbDlON1BNNVREcFFTdUlH?=
 =?utf-8?B?bDdYMTZIUUdsZlZlYzhYWXpGdm5aaWRtTzNuYUNEMTZsNlNrRG9paS9KM0NI?=
 =?utf-8?B?NTdSWG5nVEFvTkhOQ1d6QUlRTHlJR2R1WDE3SDMxZzV6SmJENUFMaDhMV3Zx?=
 =?utf-8?B?bWtCMFVOQkJWTUVIWGVFTGJDWncvUy9yTVE1SWtDaXR2ckdtVU1KajlneVNB?=
 =?utf-8?B?WGt2WlFrV3czaGFsZnZRN0t5WC9TejVTWFFnR1QvS3oxWWFRNmJHTEVzaG9E?=
 =?utf-8?B?cG9GNnhHcElHSE5aTFlDeWt3aDRXYmNsUTJkYVI3dU5vNEF0YzdvcmJFTWxM?=
 =?utf-8?B?NXRWVTZTYkEvM1dIYkNqSjMrKytOTW5FcU9NK1YxMG81cUF6L2liMjd1eUpa?=
 =?utf-8?B?K1JlVVd2T0FiZkM5Vzdwa2JaSmIzZExsblM4NTk2TEFEak5rWXNZOXBkUzl1?=
 =?utf-8?B?S3NYY1E4aVBRMXg4S0dKSjBya2hLR3I0d0IrSkUwV2s2QkIxd1ZmTFpDYW5F?=
 =?utf-8?B?UGlWa1F4OVVML3FQVWtvLzZNNFljRlVwTk1Vb3RLRVdDL1VhV0dMZkVnTzRj?=
 =?utf-8?B?V2UwemwyM2lMeGtSaTZJYkV6ZDlEcWc5bHRNS2VvWitIUFBjUGwxTnhOdVRh?=
 =?utf-8?B?QWI2K3Fnazc3ZXlFN01EcDAzSjBMb2FxcFNiQThYdVBsZXNzSkFWL0t5VkFw?=
 =?utf-8?B?bXF0cjVTbkZxSzRwMlZxMXZVR2Q0MElRdzNyRkNjMUFJQnZLdExqT2tPSjJz?=
 =?utf-8?B?U3doL05KclE5ZmREbjQ4OEV3eWIvMU1EcHZtdzFFRHRQb0Q4am92YVNRRVFL?=
 =?utf-8?B?QWUzcncxdUhRUGRFVE5WZ1YrV2VSbWE3Zm8yYytRLzRVNUU3MVhDMzRKSmlO?=
 =?utf-8?B?dm91bjJqODIrSnl5NzF6UEozWlpMUHRZaWlxVW1janNGSm54UHZyVmF2NkpH?=
 =?utf-8?B?cTJ4aDVGNWhGVkFodmZZL3NDV2VnZFluQ3RYTFNGWjZLQVhwQ1YyYVRBdmUy?=
 =?utf-8?B?SUdmQzJ3b0ZTZWEzbTdIckxTNVhzWVJQakJHNnlqTmgxbkVVclpkYkVMRHhk?=
 =?utf-8?B?MUM4Q3hvN01jNEZwNUloQUc4SUhXVGMrTHBSSXZzNVBBZjRWOFpLVjMwbUNn?=
 =?utf-8?Q?Eo4t/BglcwfBMwAQI7yvkwqebNeLLPXuqILb0nj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b17863-ac37-401d-e51b-08d92131650d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 17:03:48.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAxG85ZlnwgXeHbTR0ubQkqU5hq/elCAQ16UtLhmoLgfG12iYwm7PXzuC5kIF/rfR7Uzi4KkJojVcj3Nlyzk6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3987
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_100358_025260_16CEB6C0 
X-CRM114-Status: GOOD (  32.84  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/27/2021 11:58, Keith Busch wrote:
> On Thu, May 27, 2021 at 10:52:43AM -0500, Bjorn Helgaas wrote:
>> On Thu, May 27, 2021 at 9:44 AM Limonciello, Mario
>> <mario.limonciello@amd.com> wrote:
>>> On 5/27/2021 09:35, Christoph Hellwig wrote:
>>>> Adding Raul who has been asking for something like this as well.
>>>
>>>> I'd also really like to move nvme_acpi_storage_d3 out of the NVMe
>>>> driver.  The Microsoft document that the original document references
>>>> makes it very clear that this is not NVMe specific, but also covers
>>>> at least AHCI.  On top of that the platform simply can't know what kind
>>>> of PCIe device is in any given slot.  Last but not least this will also
>>>> allow us to add quirks for devices that fail to properly mark this
>>>> misfeature in the ACPI tables.
>>>
>>> +Bjorn
>>>
>>> Back when this feature was first submitted, that was actually the
>>> initial way that it was done, but Bjorn had preferred to see it move
>>> into the NVME driver directly:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-nvme%2F20200625173053.GA2694537%40bjorn-Precision-5520%2F&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C5480c9a7da154bb519f908d92130b272%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637577315313175138%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xDn4vxurgMOokOvwLHdqHWa3tlSRUzh5XPBJdBmBUHo%3D&amp;reserved=0
>>>
>>> Bjorn, are you OK with this coming "back" to PCI based on Christoph's
>>> comments?
>>
>> My point was that the PCI core can do nothing with this information,
>> so it doesn't seem like putting it in PCI doesn't really gain
>> anything.  The Microsoft document you reference ([1]) doesn't mention
>> PCI or PCIe.  As far as I know, there's no PCI spec that mentions
>> "StorageD3Enable".
>>
>> I agree that [1] doesn't seem to be NVMe-specific, since it also
>> mentions SATA, so it might make sense to look for "StorageD3Enable"
>> somewhere other than the NVMe driver.  I'm just not convinced the PCI
>> core is the best place.  I have the impression that it's possible to
>> have non-PCI SATA or AHCI devices (correct me if I'm wrong), and
>> "StorageD3Enable" could apply to them as well.
>>
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdesign%2Fcomponent-guidelines%2Fpower-management-for-storage-hardware-devices-intro&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C5480c9a7da154bb519f908d92130b272%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637577315313175138%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uEOEgtuxZI3mkSU7G%2BUvZ2d2C18%2BcQu%2B1748kHhSuzU%3D&amp;reserved=0
> 
> I agree it doesn't appear to belong in PCI either. This should go in
> ACPI. Here's my proposal on top of this patch:

This seems fine to me.

+Rafael for comments on this approach.

> 
> ---
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d260bc1f3e6e..ab8a0dfae2df 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1340,4 +1340,25 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>   	return 1;
>   }
>   EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +bool acpi_storage_d3(struct device *dev)
> +{
> +	struct acpi_device *adev;
> +	u8 val;
> +
> +	/*
> +	 * Look for _DSD property specifying that the storage device on the port
> +	 * must use D3 to support deep platform power savings during
> +	 * suspend-to-idle.
> +	 */
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return false;
> +	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> +			&val))
> +		return false;
> +	return val == 1;
> +}
> +EXPORT_SYMBOL_GPL(acpi_storage_d3);
> +
>   #endif /* CONFIG_PM */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d4eef8caa4cc..8fbc4c87a0d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2828,33 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_ACPI
> -static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -	struct acpi_device *adev;
> -	u8 val;
> -
> -	/*
> -	 * Look for _DSD property specifying that the storage device on the port
> -	 * must use D3 to support deep platform power savings during
> -	 * suspend-to-idle.
> -	 */
> -
> -	adev = ACPI_COMPANION(&dev->dev);
> -	if (!adev)
> -		return false;
> -	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> -			&val))
> -		return false;
> -	return val == 1;
> -}
> -#else
> -static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_ACPI */
> -
>   static void nvme_async_probe(void *data, async_cookie_t cookie)
>   {
>   	struct nvme_dev *dev = data;
> @@ -2904,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	quirks |= check_vendor_combination_bug(pdev);
>   
> -	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
> +	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
>   		/*
>   		 * Some systems use a bios work around to ask for D3 on
>   		 * platforms that support kernel managed suspend.
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..dd0dafd21e33 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
>   int acpi_subsys_runtime_suspend(struct device *dev);
>   int acpi_subsys_runtime_resume(struct device *dev);
>   int acpi_dev_pm_attach(struct device *dev, bool power_on);
> +bool acpi_storage_d3(struct device *dev);
>   #else
>   static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
>   static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
> @@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>   {
>   	return 0;
>   }
> +static inline bool acpi_storage_d3(struct device *dev)
> +{
> +	return false;
> +}
>   #endif
>   
>   #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
> --
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
