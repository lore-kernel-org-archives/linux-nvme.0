Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8A8C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5GGZTf7YIOPVl5t51klrS5MnAsVEXPeIqE8REmuLxg=; b=wkKtPXsxqXgpaV0ahkM50toQxd
	7AdUyauTR4gL6yuM5jzf2fR/fwh7Z7EXm2ZaQb5fbVibCWAa2+u68KCF1x3q9llI4FzyDemdH+J7a
	3ukdA367nqoe/YyN6ufRbsUv0MqRUOAdVVtkGjezXfXVDJGyv371vAq+pO4BNf1860fjv5hAqk9Lx
	7oIkcCXnR6QO3VSVxKtJqyGAz8pCcThPtYmpv49tsh7KoCKDzGUk+msjZe0jLgBWRb9FXmdENG/K6
	pb8Ti3ZNLG5G7VIN+iL9lqFAFapULx759uAGPBHD7fySVl7QkRcmgw7Cpt90go5OyTJ/P5J0O+5Da
	2GuawViQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npK1s-00E3AS-G6; Fri, 13 May 2022 01:23:40 +0000
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::623]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npK1p-00E3A4-8J
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 01:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCJIltnEFJyybZztcKAgph0ELokoyZqvH1kgxAcFgd7f+bH5PXaT1/PIJ+xbgU8fQqhUozT9s5W0Y3yg35qaph7oCYPy1WV2MddH9VozhTMEITevf1o7dp17Biz+UKUB4UbfXtUi+39Eqtj/Zc4o2uMgk3kMWFi8tD+IBTXJRzqgTurqg3ZGTlr4Gl4UVwbnok94rgKhXcYtvuFv8HHMatC3wXJbA/9BdZvhSPQM3PRaKf9uFbRSyhU9tRx+YV0g0V/hW75B1iPLEJpgsYbDXtjzbMTppYYvWifcMVGXm77H3KfH7OceT09pWY1g/ilOF9YaQrk0qgb5qoMyOinZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5GGZTf7YIOPVl5t51klrS5MnAsVEXPeIqE8REmuLxg=;
 b=nuFoOyG4ckbNva/SwpuPOGhOF4z9zLsvX6E6m7bTQ2Qyaj1w0ytIECZwPVdrHgBzL8Xarc6Qr9U0vKlcoDmz4tbevJSBldEk4YIcJchs2qWeKIYb0loIr2bmyLgXrWlh84lIRD+oUzs3Z8L98Y4nbpZcN8xop0ieHM2MEw3PnQB15QPbxQJNnAD+vknqearFK8XyYAIxNDehhfYAk9pco+NJ/xXgI4m2rc2y+VsLz9DlXN/poZljS3yYnIcxQ/1hS6erC8ZKXgDxtSV2JxVK8VWzoS63dYX74sC9odmdjVy4zc+ZugJGzSzw42RCyO8PZQyDyWl9TFne8H85EO/yhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5GGZTf7YIOPVl5t51klrS5MnAsVEXPeIqE8REmuLxg=;
 b=E7ih/YWzYhUZtR2/cYydTNQ1D75yEy8udIwfijESEmrpyJHtmG7hlp60+WxSzZogIkqWkXH/F7RcP9qaJs1uLU9FtvgYetBGdRd5ygtjjUGKLk31RfiP/ABZlNuF2r7NCg9yT85c472amXueXj/dfGPumWI+fXL5XM5OaGycGFPf/JaorM+uBhCq6u84hiPV19K6CzJ9ddZDiuSbiiGaKzZJo+Nj+kNlOZVOXDlBPSUxek12gTYkhxqSBfQ2eDg3rbrLLeVW67e5WchAW7LuA4SI+h2e4e+40oBh5/tRivIOMkeu8EJSok5Hhha/b7Hje23umpwm3WDH1t4NOKKCRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4783.namprd12.prod.outlook.com (2603:10b6:208:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 13 May
 2022 01:07:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e%7]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 01:07:25 +0000
Message-ID: <60ba95d4-ca30-546f-b179-52cd5be7e82f@nvidia.com>
Date: Fri, 13 May 2022 04:07:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] nvme-pci: Harden drive presence detect in
 nvme_dev_disable()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Stefan Roese <sr@denx.de>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20220506101534.1728011-1-sr@denx.de>
 <7fc45981-6f12-4cb2-9eb1-f18cfa69d0df@nvidia.com>
 <Yn0anJBHcSd1K2tM@kbusch-mbp.dhcp.thefacebook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <Yn0anJBHcSd1K2tM@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f0ca8f-072e-47cc-7d25-08da347cf127
X-MS-TrafficTypeDiagnostic: MN2PR12MB4783:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4783072B1D1B11679C1A706DDECA9@MN2PR12MB4783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JekaxKkaLoHU7GXzMwcy91PQl+xvlmp2uMnXReCoASmypY+MUnioC9jRp6sRQxbutmAKVlDj26yoQNpDR14zb6LtG+DkMGtqTKzYWd3Jgrq1pw+Fa6ZWx4vDivwts5BrCtxL2XWvBATop9Tk7kOtXp/80idsfoA7MeRW6VfN12oBRmYnudvePW+mCMleRDCNss3IGzo9TW1weeReCwwQOLuhV5z5V//OIVo3XL+JgyQsVUo0g1W+bmPBAFVyZzIYa8b1KrVZLeU6pPnSlzoAX1jq8UqiYkbrqrnxYPfkRI0xClIPE7qi2jrsJBr2Ypjg4S/pg31VQwAH2Rt+P+1X/+lUpPftfXVVb/DrZw2wfl9zi3+YZ3bVbWOK/bRDqkPSXRijxhLLYeIqrQEtjUW6HNkwoEaX3EHmsehZAa8hUnMikQp2rjiYMhUPjGwnQ1AWeilUV0bsS9z+QNRphyhqZRZYwdOUy5Py3JNYxjC5Q/QEDY/iaYcQ5kRaKu5PDBUpAWWT451rIpBFz8agkf8ia+acH9pconL8wM25BPBj3UmzguWnzgdfEegGDVTrJTAclS+MHtRdGr/jw8hBgKVCg4K0V5lkOcSQOGqnZvAuvqNSu1jamqDRrBGQNzrSVzNtFfoVCidot28xStSe8BCWKyaapLPy4jbKAGikynuVjqj4kcd5vwgXv9oY1pMc5qdfzfqf5UbwiVAQIAmd5GBt2IfBYSbtEQr7ZsllCLwyqg3/YNShF0WO17rlI2njzdxp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(54906003)(6916009)(5660300002)(66946007)(83380400001)(31686004)(66476007)(8676002)(38100700002)(4326008)(66556008)(186003)(2616005)(316002)(86362001)(6512007)(26005)(31696002)(508600001)(6486002)(8936002)(2906002)(53546011)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JDTVk0UDQyMXpIMk9IVmwvVXRWdDBKVktuMnovdGU1VUhqeDMwSllkMTVF?=
 =?utf-8?B?U1NTeTM0MFZrbjBKRmlOTjU0RTJvQWdXbkIrUHRiUDJEeXNrS2VUVHJXeDk5?=
 =?utf-8?B?T2pISnNKREt0bUhyTEc2SmZWTUh5aGdQckxpMTZDamhXVlRENy9XYnoxZ0xM?=
 =?utf-8?B?VVVmOGRTZGVrdXpKNjU4RWdBckZGUlVpVFJ0MFBGbjh6YW5KRWhuVjROZmcx?=
 =?utf-8?B?NUxhZXhoZzY3NDZWMDRYcHZSdUd1eEhmeXpWby9OU0xuT2paWWJISmlJYW5l?=
 =?utf-8?B?M1huRVR4N0ZXSWFOT216M21qMEpIY1owNXlYeTdFU2thMDJ3QmNObXJyODZZ?=
 =?utf-8?B?alh4N1M4UGVjWG5kdnR2WGdaNzVsNXdCZUdzOTlmdkVDYlc2aGtJYVJFeUhM?=
 =?utf-8?B?Sjk2RG9XRzBERUVXaXRGUUxJaXdSUi96VzdLZURqeWRUN0hldlhXUlpUWjVw?=
 =?utf-8?B?Y2xUUkN5M2V3UnNLUFhBQUpiQmxobGtwOUZ4ZVg2U1l0dXdZa0ErRmRBSmRn?=
 =?utf-8?B?UTB3WUd1R1RFWldRbkZkTis4SnByallCZUJlcUYzeDU2dGNrSkpINGpTQ01Q?=
 =?utf-8?B?M0RIWGZIM0ozb0d4ODM0b1VsQVRJUXZqaEpBeVlDM0RndGNuYk9UMUx6UG0v?=
 =?utf-8?B?ZjNkMGlLcXZScUw5NHZkQ0ZpMWhGTUQ4S0JzaTFkRisxRERxak1zQlE3RHgr?=
 =?utf-8?B?WFYxVXNBbldLTVhEaTlIV2w1QTlrNkJEK2tHYVFNK3VKc1RKRVVBbkhjSW05?=
 =?utf-8?B?OXNSdXQ3a0Z3cXlidWRhSWVySHVzTW5rSno2dXMxTXJxSlVRRjZOUlJBK2Qz?=
 =?utf-8?B?dHZ0dnV0UURUTDd5WXhodHFGYUNkaEszZHNyRjQ5RG5FZ01CSmVMa2VNaUVF?=
 =?utf-8?B?Y2FuR2V2YkUxQnpOK1NZcVVYL283OHNQa0JveWhTYWMvLysrbDYweUh5TGkx?=
 =?utf-8?B?QnN6Q2JSellqOHM1V0M0cU5PalBzS3NVSHFRYk5XamN2UnhaS29ZazhBVkhN?=
 =?utf-8?B?Vmo3aWlRajVoUURtT2w5T3VRbFNOWnRWaXdLL2RXTmU2cU1BeW5DdUFOcnhK?=
 =?utf-8?B?L0xDODhXWXg2bmVqNlBtUHFhejZ6dWxBNWxQWDJ2VCtRSG50QVpzVld1MDR2?=
 =?utf-8?B?eGVaWm85MUNzcnVKdHhZL2RrUWFnZkxEZzBUSUtWOE05eDVPSStvSlNSTCtU?=
 =?utf-8?B?cExZRHJ5VXc1RGlpL1c5RFpzYnU2ZHNIWVJYUmlxR3g1czJvWFUzVHNWU2FB?=
 =?utf-8?B?NmZBRGFwbTRvcnJJbkpGWklUdyt4aEpWSFFQLy9TQlZjcGVoRGg5YktLMURW?=
 =?utf-8?B?Rm5jaVI4SzVtRitkcEJZRzFScEtrUE5tK0pNcGxNeThIeHl0a0Q1VDNNUHgr?=
 =?utf-8?B?SEhiZEg3eWVSdG1ONjlQaU92SFVueUgyYm5KbWtQTGc0V3d4d21zdFZlY25s?=
 =?utf-8?B?OEJIaDVRQ3ZYbnZIQjBuOVFtVmtCNmhrb1BBdGhsY0I3UHhleUN2SDNhcnBR?=
 =?utf-8?B?aVpJcU9yT3dGWUgxSUxSaU5UWGxRdWNxbktXTDd1Y2ZnaUNacEI3eWZuUnVN?=
 =?utf-8?B?dWZsZ29kY0hIbWYxRFhRUE9DVWFRZmdFVitMTjdWZDNWWDFmWHlLK3U2QTF2?=
 =?utf-8?B?d0E5YzNqVlMzNWtFRFpwaGRka2ZKVGFIbkJOcTdlVC9pZndSU3doTkRpSlRj?=
 =?utf-8?B?OC9YNnVxZzR6cmlyWW1WVVZxR0FNNTAwODd5S1MwUmJFUjB1YjgvN3QyU2dX?=
 =?utf-8?B?OFJmNnNiQ0QxeFVqTGREVDc3aVh3WTVVdkVXdkZNU2lsWnBMd000bXByS3dP?=
 =?utf-8?B?STcyemo1aE5UdGVqclFzaFNWTWNWYmFpVWtkeFhseFRQaWZDZHY3UHNKOE9N?=
 =?utf-8?B?MDZqaElaZ0F3eVJQdEwwNkZUUkZYcTVVWDQ5VVpUREdTdlM1TGlmZkNVZUph?=
 =?utf-8?B?THBqM2JkOGhtak0zNE1HM1lHM09CQXZjSC9mSUtUT2hkY04yWnpFQ3RUcC9J?=
 =?utf-8?B?RDN3Nkg4d2RYTTBwYThtc00zQ1ljZkdNRUpBbUdwbEFZcFpDaVFISTQ1cFpU?=
 =?utf-8?B?VzZiNS9RWUMzem4wQklOOWtBUFhjT0JySXJJTXk1enZRdTBBaWlMMktzVXZy?=
 =?utf-8?B?SXErS2lLRjBBL0J3OEdwM29pRVEzYWlpT3BiNmNHSy9rV1hOczZLWUw2Wm9W?=
 =?utf-8?B?MDJKZmdRcXpuaGpZWkhwWmF1c3FLZHRSd21IVTBiWlcvcVFlYWlJcFdwbFBQ?=
 =?utf-8?B?Z3JKRkxLaEJMWS85SjZGN05USDE1TUNqQnRuRFVsaW81OXRpejMycTVWQXNF?=
 =?utf-8?B?TkFPMjh6RGFBM2M0TGcvcFdOOXFISmVGL0NHRVRDRENWbGk0SzEyRXZiZFcv?=
 =?utf-8?Q?akFtvN0H0ePmXGyQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f0ca8f-072e-47cc-7d25-08da347cf127
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 01:07:25.5800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PZlyJsZCahPBBiKFdRL9R8WrHbL4O+IiYRqTyycaYIjQo0mrt/soMB+YGycS3Wcy7Hzu87/bPLB5XNDfrRdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4783
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_182337_332226_610AB261 
X-CRM114-Status: GOOD (  24.50  )
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


On 5/12/2022 5:33 PM, Keith Busch wrote:
> On Thu, May 12, 2022 at 04:03:39PM +0300, Max Gurtovoy wrote:
>> On 5/6/2022 1:15 PM, Stefan Roese wrote:
>>> On our ZynqMP system we observe, that a NVMe drive that resets itself
>>> while doing a firmware update causes a Kernel crash like this:
>>>
>>> [ 67.720772] pcieport 0000:02:02.0: pciehp: Slot(2): Link Down
>>> [ 67.720783] pcieport 0000:02:02.0: pciehp: Slot(2): Card not present
>>> [ 67.720795] nvme 0000:04:00.0: PME# disabled
>>> [ 67.720849] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
>>> [ 67.720853] nwl-pcie fd0e0000.pcie: Slave error
>>>
>>> Analysis: When nvme_dev_disable() is called because of this PCIe hotplug
>>> event, pci_is_enabled() is still true. And accessing the NVMe drive
>>> which is currently not available as it's in reboot process causes this
>>> "synchronous external abort" on this ARM64 platform.
>>>
>>> This patch adds the pci_device_is_present() check as well, which returns
>>> false in this "Card not present" hot-plug case. With this change, the
>>> NVMe driver does not try to access the NVMe registers any more and the
>>> FW update finishes without any problems.
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Cc: Keith Busch <kbusch@kernel.org>
>>> Cc: Jens Axboe <axboe@fb.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    drivers/nvme/host/pci.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 97afeb898b25..c764a2a1d7f1 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2473,7 +2473,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>>    	struct pci_dev *pdev = to_pci_dev(dev->dev);
>>>    	mutex_lock(&dev->shutdown_lock);
>>> -	if (pci_is_enabled(pdev)) {
>>> +	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
>> sound weird to me that pci device can be enabled but not present.
> pci_is_enabled() just checks a driver reference count. It doesn't actually
> query the physical status of the device's link it references, but
> pci_device_is_present() will do that.
>   
>> Also why we get hot unplug event for FW upgrade ?
> It might happen if the device requires a Subsystem Reset to activate the new
> firmware.

but isn't the reset something that the admin should do ?

some power-cycle or cold-reboot or other reset.

In the reported case the device resets itself. I'm not sure it's expected.

BTW, for sure the fix is good for the hot unplug case but FW reset 
shouldn't cause this scenario IMO.

>   
>> is this the correct behavior ?
> I don't know if the "synchronous external abort" is normal, or how severe of a
> problem it indicates, but we normally expect accessing registers on an
> inaccessible device to be mostly harmless.
>
>>>    		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>>>    		if (dev->ctrl.state == NVME_CTRL_LIVE ||

