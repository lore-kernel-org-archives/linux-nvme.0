Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBBC2FC34
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLgflI80NKdzlYfawzK+BRUZa/qPmPFjU/xjykpSZCY=; b=t/XbHxYyhPamxFm0wZ6OIhZ9M+
	RiKMHPrihnNQO41N9d7wizIMh7DSijoSGLyYJlCaHEuCCBvEO47BJXFAY89WN1iVpbgafo0fwhZZy
	wB2OvBQLzv6mvx+BEnnKr50y2xz23ynDAfuP92nTNaCVrsQd4gr6H2C/Ckmj/TQR8jzvzZnV8L6XA
	6qox3Ps/qRiyADwCDsJWF2jPbW2lulp8gmX1cN2LHiifTpSLB+t8+70XtMgujaqUrCJ3EQA2G3pv0
	lSMSuNoBysSy9l7jCRpqj0+2fXrfRzMbuOHhwPGeXEjyHDVZH+Q4m8W02ZKv9r+QjmTZn69RXtAy5
	aoOL8wmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWdhR-006W4J-2R;
	Thu, 17 Aug 2023 14:10:09 +0000
Received: from mail-dm6nam11on2060b.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60b] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWdhO-006W3L-0q
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 14:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5Tzy3NfZgnpDJey7E+i2tal6dJJmOv+kUW4CoBuh/QqI9wVmTBjCDM8V/nENr4QngMBcQpgnK6wVDdZa1AFZSlcwwi23qJuKUlGb8pIhrXY+4xgnSk43K/bWbfgSb+OnmlnDyA+X8+FWKWdwsjwxfRUm0uYZGAGt4C/YzJhvEgtMJjCLSQ5EP38YTxvl3sF6V37+verbG3gB6DL5iUD7jKxVDR/YCHhp96DGn18K4zF00f8Eurur4iecYmQoOey2HgKGNhVNK318YkCGzWjuvaDBWZFjX2xR0xVlDUi6HNmu3NwXVMpV7pAM9Etly3T28QP5c4Me50xQBq36FDM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLgflI80NKdzlYfawzK+BRUZa/qPmPFjU/xjykpSZCY=;
 b=Rn5NBc8wumkBXGJ+6clQt3enhLaQvgIax0iq9DLFEywAi4SnAls4iFIRx9AmCQT+2NvLesbMI7g/yJtuQP0P4rcdNx3bul99tKnSJFI+NgCtsUolLS7obkPYcVY+P9oQIksDyUgOCvio4GOl5/4JMOLSCRU0Ze2qul+D9GOusKiVOy05/KkJo9mzUKvn+gKZpJsBp8xCnZ7x/sD08a5AdMbhlCP7L6Qj9Oo4kLJxyYB5JR7q++bEess26aObq0/jPlt2J5SS5OXC5BjX3QInjv1lV8R3VOwwgd6R/DWfrMWBN0z2/8MZHViL7WFBJ+ZMT1LkE3tbdQ9kiW+XztDWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLgflI80NKdzlYfawzK+BRUZa/qPmPFjU/xjykpSZCY=;
 b=Vy1Su4+y2t+p1RtH8IqJdtHR9IqsAM4JRuduX8WrrM3irFsOeZixC2Pbf2UNLx+WymOvnCwiTfhhT4E68oiQEcf47x068vXxf7mXxg+/EZ3r1xQ2/2t4O9XWheAJI2Tsn5A/g1+TB6h6PAg8NcleMTkb+45cWnwggajHsO8GVql+qn/0hYZOLOjWchyEaMxMyFpfumbwma8+z11cLujqT30r1iXDst2EUkSQ1YdzAnOWHKdZalXVxzxyQbIedukz7Ad5S7+DBsAJdGREGaBtMc7s9vsRljDlWKeObC10MUfuHfAexn8LgSFku6lICEnyhgmsFBtS7xFXbnc5sgAGFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 14:09:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:09:51 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
In-Reply-To: <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
 <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
 <253pm3nuojy.fsf@nvidia.com>
 <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
Date: Thu, 17 Aug 2023 17:09:45 +0300
Message-ID: <253bkf5vjyu.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa9c355-e33e-4655-8a1f-08db9f2b9f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oij0zbIlF/Vvrqf3UQlk39rO9AI0hsiXgFkzFRGG3OmGIian+CPfVSBadyxUgyeBdMP/CZ2GkbcREYS7KPg/Bx6M3CyiGaIxC6IgsSycXm5gbGnXlPslBFA/Tz7XfnAYF1oiXbIEGjDjsU5LgDTpDET9wVOfZjIDTvM8e8mj128GvOGBUEXmdhIRg9mBw2QNTKGwtgCBMD+G3FL45uUy2zLK0YWU2/BHYHU978E7AQunFBSpGa82xkG7wgTuglPV7tghGeK8c1SMy7mSGnxL75/xX4lWHap9PAI7lFmkb7eCnr+gAVwwJ7D+gY6U/O4+nPeUAWpq49rfyveGz455TialgesUEFku//yCydHT2IyPI8HY/gqYIXRrd+hGC6OQKG3eIJ8GwaekYjqOE1lNJddkCPuM+VQHLJBQJ1UI8hFoYqwUCKB2LyTVvHHS9aYE+8hgVtNfkwGmCBRvxBn35ZCpr+qNKl416HZuyR+Ga4TDFa0zNS936yfMgkepSZVOjgP/oAkiVhhP9PaCUPq8F957Z+gnUNYHwH0kxmWKWISpVsva9h/HrvRDy87loJjk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(1800799009)(451199024)(186009)(83380400001)(66556008)(38100700002)(66476007)(66946007)(316002)(478600001)(7416002)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(6512007)(6666004)(6506007)(6486002)(107886003)(26005)(2616005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSJEn8BMKfSldRszZa0fqJ0p6H2snS5t0wrVWdSmqO6E+qBT+ant/q+j+wwy?=
 =?us-ascii?Q?OxdqVxkIu0N4OPG74ysF3Ljn6zjUCPy8O87JhJbvL86fa/TrG/kzfY/FqXMx?=
 =?us-ascii?Q?retHUxx6u/i4LE7Al1cWnjfZt5khKz5SS2QBmLfS/WrOYCY66kMPhUG7FxBh?=
 =?us-ascii?Q?kfJsvEZGz98loLZTraWtYhlZlVTnpKHlmPgceW2NYg4mf0i1g0+AQt/LMnIn?=
 =?us-ascii?Q?7U3GxM4rgklDFQc4r5sBFv3Qt08IaRkv7kV2cvdi9ktN8pl9iaHMtZdd9Jkk?=
 =?us-ascii?Q?tufdjUUhYC5PrOTXKZS1BklsTEImlUyLykV9keAZSsG/rHY9fgoTsOp6pgB5?=
 =?us-ascii?Q?cP+ULaWMABFySa+WFxaj2/t1+lfgYUB5kNMy5QMsXQ5Eaenn1m6aA6mpx93M?=
 =?us-ascii?Q?LIaW0CxqLyy1DQ0EOoHPzvEdMd81hFYljbDRm/fzoiS1h89EKfULBNadj7en?=
 =?us-ascii?Q?cjdYic78JiZg0Z8ZZCvHB2X2IfLIFww254/DkpAIXYEDvTshG+lzN9kPRgaz?=
 =?us-ascii?Q?1rGgLv88GdjgkNQ/y6jMgSMs725RsooQjsZBcNPjL+x9M3jxQZaXde2kJkrW?=
 =?us-ascii?Q?gRbzQJ8wZiyE6ZD8kGuZxkJULJ3IuUooImeWcZ0MZdCOhEuK378SkeSRz/FD?=
 =?us-ascii?Q?Z4pIYR86hd4XOEET37xCZ6a21j36qxx69cW7t4U8dR04saw95/qn/50KONWZ?=
 =?us-ascii?Q?Y43gfIAEAbI6Bj4977JhxCi0kqzhbX9bsNNozhMkBQ1SxIp4ZAc5G320fePa?=
 =?us-ascii?Q?G5HrDxpvguAR5QHhtDXQlisIERPRv5v/19NEDPuRU/7EqKFH48+jFVpgm+/z?=
 =?us-ascii?Q?kQ3b22CuRgYIZet+0M88Egf0Vy4O2DNqVNXpiooLjFTRvIzlmthyEuKRE0yo?=
 =?us-ascii?Q?OCNK7puHjEhfeBmGJX/STy7BJ3oxeNz1f+eJAsY6JS9s6YsELe0Rr5R83Kp6?=
 =?us-ascii?Q?RzjUWy5fE1mXzSK0oELXhFqEZt+ykKKj8i3ZJAXQtqx3USsBC9dlNo3KLhHf?=
 =?us-ascii?Q?E9PiYLC6W2J+ywfa2JrQH2HhFGiTtbs+tk7RrgPO0ByPG5IwtIkhG/ZMBZeI?=
 =?us-ascii?Q?5bGcDVGwCL60+E2ZFrvG5eva0q6jDY0lgISxJ2Trdw4mtfPMHwKumUPBsTaT?=
 =?us-ascii?Q?zgF6mJO7Yx9UrPfVgVSjvoP4FouM0y0tXg3JtT7IJ5gOZofppgk+Z9Hh9rQj?=
 =?us-ascii?Q?gk0bIrdw2kf/dexY+rW/dompNFQ4CiJOIpjJVp3i1Ke7AUZhnCZEU1HyqiAD?=
 =?us-ascii?Q?V+OEFGKkcymJ/RE7pPrg+JkFn9J4LxslSwaAH01N1N+Rw9ELMfaoKwspexse?=
 =?us-ascii?Q?Lsxwr2uJ/cB8mBoc9/LmRW2n6aMy1kvGPvFPqGnvjaJw/bgq1D4n1zvpdB2p?=
 =?us-ascii?Q?/w5o7T44Zdn/gjbdslQ3tSQIHvJG3hFYcAgGmSPw/+OGk3XQ8agWfQVONxjL?=
 =?us-ascii?Q?a50q9PNPPI2wNTXL68sS6f7DAE0YVwYBq/hwgUuI5bztQuY5NI5kzRZJS0zj?=
 =?us-ascii?Q?QbVhxj6OvqHlBas2jV42hW0WRKt8HSvuc0YBalUF2YvmggjzB1wpv6m/wygk?=
 =?us-ascii?Q?0U2b45cLmZXq36S5gd7oKNbe+Da0g0w4VnVECH6p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa9c355-e33e-4655-8a1f-08db9f2b9f80
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:09:51.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/OcQVxl51tdYvQTbdTceADZ0GjSMiu56mEiT5sFi+ZXkBSpahv8mGDhbwvC2MBUi9TqbX8adPgoRfRUdPEwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_071006_325728_EB248DBD 
X-CRM114-Status: GOOD (  10.80  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
>>>> +     switch (event) {
>>>> +     case NETDEV_GOING_DOWN:
>>>> +             mutex_lock(&nvme_tcp_ctrl_mutex);
>>>> +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
>>>> +                     if (ndev == ctrl->offloading_netdev)
>>>> +                             nvme_tcp_error_recovery(&ctrl->ctrl);
>>>> +             }
>>>> +             mutex_unlock(&nvme_tcp_ctrl_mutex);
>>>> +             flush_workqueue(nvme_reset_wq);
>>>
>>> In what context is this called? because every time we flush a workqueue,
>>> lockdep finds another reason to complain about something...
>>
>> Thanks for highlighting this, we re-checked it and we found that we are
>> covered by nvme_tcp_error_recovery(), we can remove the
>> flush_workqueue() call above.
>
> Don't you need to flush at least err_work? How do you know that it
> completed and put all the references?

Our bad, we do need to wait for the netdev reference to be put, and we
must keep the flush_workqueue().

We did test with lockdep but did not notice any warnings.

As for the context of the event handler when you set the link down is
the process issuing the netlink syscall.

So if you run "ip link set X down" it would be (simplified):

"ip" -> syscall -> netlink api -> ... -> do_setlink -> call_netdevice_notifiers_info.

