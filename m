Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9411EB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C1xQ8MqkKy+8OuTLkZBQ/goyHoU2LZ0wgEutL0qbUUs=; b=djI2dBeEXfJVvD+zzVigP3Z4cz
	RTzhHdvLB5NjjPjX76eNK5BxxxtpCQI7BJkLH+PGoaNwH0Xz1tMCkzcqLqsyOv3q+QSX32U5CK57u
	ZnWg7FBJMs9uiTtCbsZkX6j4VYnFcuws4boo0kzsfkSe0i35oxw8LzSUT7lw/D73slCZB3pwySVMx
	7LNIrYFdXe+ORysX1+rkHa1WSfO7F2kJM8/vAbtRx7J23fnsGFA1lOsSc+cOi9FgEKNaG1SSCOaUF
	wh/3HpVVqnlcuV3NFdGHrT1LEeDg4pdMcMXUzS9l9kFQlihRo28A7ESybL1SuRhC+gwsNxUCvbt4A
	xaDDLUrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzN9-00Cr35-2t;
	Mon, 10 Jul 2023 22:28:47 +0000
Received: from mail-dm6nam10on20616.outbound.protection.outlook.com ([2a01:111:f400:7e88::616] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzN7-00Cr2T-0w
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 22:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEGe1wzyFXOkOhTC5Km72BPC9nFNTUY3G1wifCFhFWSqF2GfcdqxHZhX6lMFUtBeALHl2CKWeFi+UJF2KLxoju1Nv9SLwaTIUoIs/Mzh5C6tJdjBCE5RSa5fJo6wq2HJJhUYxibUBmBUej+QK6s7KEq1QPwF2R5vJEz9CLSaINjQT2VvRQEg6vNu86LapJt3QOGqMVV7YUa48BKjsAXRsZRnc206Svh0qlLHLWDGRQjPTiyk6ErG8WnED+qV6ndKsZjK8upxtOoH14ydjs0JQbfjgiemgKH5RvSlqbWJh9dxZL7FAON4Net++A7o2gMBpBmU/LkWuNpTvy0jfDCcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1xQ8MqkKy+8OuTLkZBQ/goyHoU2LZ0wgEutL0qbUUs=;
 b=YtNjUuXWUJzQx0EycCJZ9RsrHdDUyopwCofWKZDQsTD8RVbOx/cq5RYRcw/dt5zOT2RvJLaLYR2yuSafb57DDbR20zfl0NOazSwqR2c8EEtUyETzEURH9nqzaGcKk5MSfHm/pf0YQv2yzGBRuBBAo4kCHPVU8HX/qlqnyWQnuApCyy0KMwirD42qrVx7dBc25di3LbvLPl0ZaicWTXuPTY61Jq22acZaVAQMtXrPybvNzvztD2xPjteUovzob2gMd0BSy9Y+v9IDCuH92DK2a4TAzcZHRhuiOZ8f1tq2vzZhWwEhtgZRvnY3dZbvBvXdgv2URQlccoc4YUBdwm98+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1xQ8MqkKy+8OuTLkZBQ/goyHoU2LZ0wgEutL0qbUUs=;
 b=35PUJK/j1BmF1P3fL7CcLzjceJyXx6QGCCPP/WO6QWalpa6FLprC76u97QVhzzU2o1xY5OWjAihAs7eeAbBKMyP9AirBq/emmuX/XlXVuoYLJW+W4ENTA5xVPhvzTY3AT7zr+lox0FEYeWM17/EXK8iyN3J7NV+kKAblFZ26bco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 22:28:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:28:33 +0000
Message-ID: <4edb1aad-af46-1489-0b59-cb122b409186@amd.com>
Date: Mon, 10 Jul 2023 17:28:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] nvme-pci: Add suspend quirk for HP mt645 thin client
To: "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Zhang, Eniac" <eniac-xw.zhang@hp.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230706180653.761247-1-alexandru.gagniuc@hp.com>
 <47378415-b5ac-77ae-3cf9-01030a0c24f0@amd.com>
 <SJ0PR84MB2088ABC543710226BB8889DC8F30A@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <SJ0PR84MB2088ABC543710226BB8889DC8F30A@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e83cdeb-3b6b-4793-fbbe-08db8194fef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN2NzYRQ62D1zWF9USU4KPTeuNpcixR+6KKpPDh4wld3C+hKU2GSQO6T4/MIAeZF9iL3xGPoiKHHxSHm10nMukh/3bqWqIoBegbbi6M23YqR+q7IzWei2CVtDJkTiaBnrsr/6S3uKOSn9GXqFENIrI4G7JdZ+ywDXYbVNQ0JJ7tnj1Vovxc56Kp8foxZeHquho8XC3eDThEsrTreDYxBiTCl7OIB9W6Uru69M6AbTYlsgQ8RS4aSSwcjHz2lcbyIKUY6q+xorkPBhGFLnuZskW2g0fKw6TVpkC6oXyMmiBvoh5WLJlBPKEjPC/gGMXzcUwKDqyexeCUQ4odmnPQJDNkjFSccOSBpGxZs/V01C1pxlm9fNF/t6zzLgBzghumonY4Wn8V5m6/67zu0XtqAYiw02fFDloC4jmDHhTwAmAXYndpFfMbuDmUw+HLcJXHMTrEDV2Gl0PuYmnuhnc/h/qTmI/hZrb0wgvpmTwrXgfTpQtF5FkgTXmF2XVfxLDyWBP5YzOfe23ESKIcXgrpJZI13ikQ+qFR/stpaDT1WJikpVlEYyjU2OILx5/CbbYJDKi3bE5RvnElOOcwR3swbU5hqi4bg6BvvWt8E4g2GJLYtkkxzgO3HfTo4CONJr3MTi39ItA3fKgSswby14YZ6WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(31686004)(478600001)(6486002)(54906003)(110136005)(83380400001)(36756003)(86362001)(31696002)(2616005)(4744005)(2906002)(26005)(53546011)(6506007)(66946007)(186003)(6512007)(8676002)(38100700002)(5660300002)(4326008)(316002)(66556008)(66476007)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEkvUnp1V0lNWGpvZG9ZeGFyRXlzN1VNNzlTMXhWZFBJYVp6cTM5TGxXNTZh?=
 =?utf-8?B?OW1UeEFQSWY0Qm9jSUVIV0VpMUl3bmtWbVFkdDl5aVhualNOWWdERHg4bWky?=
 =?utf-8?B?bE0yeG5GNGVXQ3V2WDloeEw0a05STzRGellGa1U3THBlWUJxbVVSZ3cxWEx6?=
 =?utf-8?B?Mjl2ZHJ4R2dFalJBZ3pDZnBEcXdLcnF0YXJTQjRPdUpwU3ZhejBmdGxwZ0c2?=
 =?utf-8?B?OEFWYiswaGhud3FGS1B5d3NZSGRDdnU3ZmE4YlYvUU9zYUZOaGViR0hVUCtj?=
 =?utf-8?B?SlArNG02d2dObllZTkFZWUhJTEJELzZZMHA0UTNGRHIzZk4wVkxleXo5cy84?=
 =?utf-8?B?WFpQVUx3VVlXWmZ3aDlCMkN5UUxXNFlYbVNoWTVVbmc1T2EwMEVQb2s2Um9l?=
 =?utf-8?B?bjZXUElTOGFDbkpTOXh2VTEzZXhvZWJyVjhwdS9oSFRyNzR2UTNRdUJBUUpi?=
 =?utf-8?B?TWwzQ0xEM1lsZWJMeUYwd0QrR080eDRtWG96bzhKSGFRYmg4eUhQZ2ZMQk1L?=
 =?utf-8?B?SkFZcnNsVEE1VmdoSU1pUGlDRDQ3RC9BVWtnVmFhbnprTldnQ1V0dllBTjg3?=
 =?utf-8?B?ZnNZeXM1M1JZaE1HQlhocjZGeE13UW1sRjNpTTBZeTQydTFxZ1hzbHRNTVNY?=
 =?utf-8?B?b054eEFjYkY2bXh0ZDJQRU1wcDRlRDhKcXdzWlBHWTlSNjY1M1l2bFNqSjlC?=
 =?utf-8?B?M09ZQUFmdjZyaExmN1Z0Sit6cDhoemphbnRmQkR5cnpqWEowYkJsTm9zOHRh?=
 =?utf-8?B?dGZIeVQrTTRDM0lFOHdTVnhhY0JCRWlvbEMyVDByZUpKdnlvaGFXN1NEa2lZ?=
 =?utf-8?B?U1dSbWVGREcyVjAwV2pKWUYyUVpEVEhXMWZ3RTg1NGkrUkZCYjNWQVo1MFRy?=
 =?utf-8?B?dlV3UGc2TE5pZ01SdDFKcUhtN2ZlYk40c0ZTRFJFK2RoUUMrbXpEUWRRbFRp?=
 =?utf-8?B?dUUxeU1IaXdUMEVwRnVudW9HZ2NmanQyUmNvRm55QmYrMjB3WG4xUGJ0VkFl?=
 =?utf-8?B?NkJrQ01waGlmd1laZHdaZndaYjV5SEZvRFVaSzJLUnZsWnMxSE1ub3RQZmsv?=
 =?utf-8?B?VFZURk9hMDV3L2FEV3pTdWNHTDd4dXRGNEFBMGx4ZmoyUUlIZUZRb3Vib2lj?=
 =?utf-8?B?aXdiMnRydFlTcmZWVGJLOUl3K25pbkUzYlRPVHNWbjlqOGxYTkVTUWUyQitF?=
 =?utf-8?B?Nlk2L3VVamZnS01sRWdhYURBVmdldis5c2FXMDM0U1BxcEpQRjdmUW53dE0y?=
 =?utf-8?B?ZUxxZU9WNzZ4RUxJcFpqTVdxSStuQ0NBL1B0Y1JYWkU5MTRpSCtTT3pZYzR4?=
 =?utf-8?B?c3ZFSnNnU2IyeGRVNFRsMlRoOWVnL3ZxNHdSTHBaM2c2VUVoNzU3WlhNNGdH?=
 =?utf-8?B?SS9QWDdXa3pmWW5ZNXhkRnNQR0luZ1gvUHlwcy9lVGxKSnFqcHNrQmFvanE1?=
 =?utf-8?B?TU4vRElYTHpNOXRXLzVQc3dIUytnMHlDNW9PWktMSUNtY1Q4Y0hLeGk5RVp4?=
 =?utf-8?B?NkFWbTExV0wyM2hKeXpTYUxOQkVxNGM2M1hwclJFNlNiMlV3Yks3N2wxY09F?=
 =?utf-8?B?eWh2RktZQVFxbndoeTBlU1daN09DT3dPS3o0bDlrS3ZBZnFETlA0Zm1oNnlv?=
 =?utf-8?B?SjhYS09VT0FHeW1TQUpJckRUMEIwL0NjSzlyMC9SdnZsUm1MaHgrQzhXa2E3?=
 =?utf-8?B?NWh3aXd1M1BMWTdxeUJIdXJxWHM1b29MN1J2TkFDdVRKZHF4SVJsMTYvcklh?=
 =?utf-8?B?dFZCOFZyUDRxRm9Nbi9aaCsyN25lL2oveFIyU1pQblhpZTliUUhyUC9IVXBn?=
 =?utf-8?B?VVc2endFZEV6VkY2SnFaVzUyVFJZdERsUGgyTVg5QnpMa1N1bEEzbDNtbDE2?=
 =?utf-8?B?YTBLTnJNRm42Yk9tK2YvTTU2OUNnVWpnbThicXFvL3RVTFQ4ZjV2YTFZRkRu?=
 =?utf-8?B?VkFOOHkzQ0REUi8wWVhjWER5eXZQanZPYndEaUE1SDZ3Y0FLRUxnLy91Q3dF?=
 =?utf-8?B?My9Ta2VOZ2RSL0YwUnVLcEpFenJvQWI4QXNhb3NCYTVDRms2VUdYUUhIY2FG?=
 =?utf-8?B?Y2dEdHNsdE5uVnNkUkdVd2pHTU9UTmc3bVRzTzd4c2g0RTg1NDZzd2VMczU3?=
 =?utf-8?Q?FiiA/U87IVPuzk0LLwmxIoh5v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e83cdeb-3b6b-4793-fbbe-08db8194fef0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 22:28:33.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tOUvAEYhElQEquCEw1XWpKzuMpZFB7Kzx9Gmu49dnWOAygOtDbc1A9icB5YQncXdUF07itoa/us7UWMKwK0UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_152845_330248_423F31EC 
X-CRM114-Status: GOOD (  12.49  )
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


On 7/10/2023 3:06 PM, Gagniuc, Alexandru wrote:
> [snip]
> Hi Mario,
>
> The product link you posted is correct. I was not aware of e2a56364485e
> when I developed the fix herein before v6.3. After some quick testing, I can
> confirm that e2a56364485e solves the original issue.
>
> We do not need this patch then.
>
> Thank you,
> Alex
>
Great, thanks for confirming.  Just as an FYI to you we don't have any 
intention
to grow that list any further.  Those were added because the platforms 
came at
a time that StorageD3Enable was just being introduced and there were 
bugs with too
many missing it.

If you have future AMD based products that use newer hardware such as 
Rembrandt or
Phoenix that you need to fix this in the BIOS properly.


