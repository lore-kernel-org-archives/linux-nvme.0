Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:34:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7741320823
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1/MUP2Cf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ADn+apZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7741320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1vTvb3BB/vdwFMJTYSuGliwf7h5KjJhLBmH/KTcc9To=; b=1/MUP2Cfg4DCqUBvED8MSWPG0
	a04GkR6k6gRm6yoEOE0pDBXYMpx9kkF4R21ANNvE9Wt2iiroL9yvyg8HxTA2Dr1G5rQTfLAq3UdLe
	jd9EDodE2LPX2dHmnFTtPDh0GJXbVdCJhR2u4dithsXwiTbQ/sufPyZeSpCNPwyyyWDZwS4Qzntvb
	DbJXCOCMhSsCEvTZZSyMJ37RMvE2I5stxt/WmBF6BjQ0psVcIvbftAtHdZzeApHGQ2gcvGZgyjUep
	5oHPfgnWed454ILr1+FLE+GapDB3lL/IJQcScaix4v0qyRs2Hv+UAqgEWUQ7oZo4SUbLnmcIzuH58
	D3qJhrIaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo0rg-0000Qr-8Z; Wed, 24 Jun 2020 08:34:40 +0000
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo0rc-0000Mq-Pv
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A90tP1F838xXCrp1ODtNf4nv5NhE39e9VlWA0VWP9GBE85tLb4DttR/q0gL1PfQt9BH0e2FiRDBIschX2oDzsYHghCACxFAVcRE6gBeW/JciziewNcGuQNv5xR9Hq7BcziZ/JQkvxK4vcJWqRjdblpNZPok14fM7ryoDuWdGKoWlJVjIqE2ON/ZVg342bPzhOXRkr02ylxcoOMGil6gpIf3loxT4S/9ZyyjbiyD7cgr7Z3UIvvIikpFgqr4oRxhx3zMddMdLsHQ087jhkV/DSsuyawT+c1yYtyBgvXFvaZ7r0cxg96b48t6hsTf05nzbdwGHslfKJmm+026wZnRhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX9UNpuGJbi3GTlc9Ywf5V/5Xv5R6PiH66dbwsG+Oug=;
 b=hmcmKwW8cVHSAh2yFeefxh1YkoNqK8obly3ymnzqZfBwQjYydwFnqDPguOySm5Eu47cX/tzoKXRM/X9Io+q8xSGyEBeySjxUXEzLgMbqxKZ3mJy3AOcLLeG1EgnMLsKAudxbPoYWrVJrKD08WknajcL8CKVk06qBFmhIcRQNA4O+CYZI0dRVxKqjNm89RfVktglW2w4U9tfv8jM1NuEsWT1rR/ggFs8N2g5TuDHuTNeWuRQl9e8FQ5Xop8cekNf1VvfHo/RnL0hHqZpZyE3oCuU28lsEBsyLbd+nfUieBfQ/x1wMa7CCwaiD3/5KZSP25C4s+ez1XhfYQVEBMGdP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX9UNpuGJbi3GTlc9Ywf5V/5Xv5R6PiH66dbwsG+Oug=;
 b=ADn+apZimLIpmnYzDRS/0lBTw5AKBWX+Cs/f/uDBB/tTnoTkaudOoc3MKFi/AGXLabuiINRhNN1OQnev/0q2N/D0Z3gOHUCOZhFb6298tTvO6tbXg1bQiwVBUKtC42umP1ADgWU6YbmGInh5I1rnKHzgq5e+PLL3QtgpIb6Q5NA=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR0502MB3699.eurprd05.prod.outlook.com (2603:10a6:208:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 08:34:34 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 08:34:34 +0000
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
To: Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@nvidia.com>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
 <20200623152236.GA3072004@mellanox.com>
 <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ec6b1a89-0cc0-1378-6d29-29b9d255c7f5@mellanox.com>
Date: Wed, 24 Jun 2020 11:34:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23 via Frontend Transport; Wed, 24 Jun 2020 08:34:32 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98a3873e-cd69-48ef-29c7-08d818196c2f
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB369980FECF44E9AA319A8120B6950@AM0PR0502MB3699.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt3PfABb5NIUMlp+nENsWvZXDlgv2z7GaHM6cUFd/6cWkNDdO+jBoaBhf5Ariknnquvx+0LJVjuZCuLgqb++ymqxEHt34uuT64JDJAq4V1khaaF3nITHgpSSLLIYVTCjH7j/Y/hNS4bbCBGuYSrX2U7xzdVJVuIPZVMhdN8y6ebLqjF0xbKaVLNBUMIs4GK3FPz6PNXzK13UzJXXbWXqh5Uln/L9KjF1h8qDaJxj/bn+GNy5fqGs8RBN0cvqUnZesealhD95Ti3/7rS4BN/KqTQ6tqXQegoGJWlxnWKpSNXBH3Uirk2NXwHRtYObJampjKysYg6VqJV4Ql/ss5+bc7St9t7g/IA1Y2aGHpQKDo7ThNB9GaBD7pPgBfZWZfrk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(83380400001)(36756003)(4744005)(31696002)(6666004)(478600001)(86362001)(31686004)(16526019)(52116002)(186003)(66946007)(66476007)(26005)(66556008)(53546011)(5660300002)(8936002)(4326008)(8676002)(2906002)(110136005)(16576012)(316002)(6486002)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: f+WjNW1lSUAK41gwEKxwDGcqNDC5750NmI38mnFuVEpqmuBUyW2PC4vAfo4wcMGnQDHjRzKfJxrcz2Ys7uBSCGCls0fP6vlFDEwdaFM+rxYhXsPjrXk+qUPHgORWMSWSRvsaQya+UnW2FKuxnhDZTDZPsAwqYk7Wrj1bjkWb81b1mlkTGW7PO5MIq/zfJF3VXMrI4KOmYsRKkcGFcWyr12L/BK1LbAqjDtFuBSsnuf7NldTY1491MzZlQByYkm8vASZ1nR17zJDZqe+R8kfVo9FW+M6qL9LMhtHQRsWeWLsh/wYWz1VbZ2AgEr2lhWI65h6Isn8OciifNJSIFmQ3pEDrNRNIN1KTsaYI1NcV3OpZ7yQWfpgmlQ83hBQ8ik/x+m9smehrgkb76lwZeH6AA0S28seCRhjOpFYz9JcG0YjfV/AwwUVNLHlXPSo1R8AUXbHF8gXJQqdesR8ciZ3bcED/WgTdI94nxgYG4w1MNuw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3873e-cd69-48ef-29c7-08d818196c2f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 08:34:34.2893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5yOZztuR89yHJd1YPAzmFN8BIvHGe5fOcZ/UFnO3XvnRYat44Ry6KXE2psXysLPkjdVUc3ln7xC8O4qLJX2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3699
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yaminf@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, kbusch@kernel.org,
 ogerlitz@mellanox.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/23/2020 8:34 PM, Sagi Grimberg wrote:
>
>>> The completion vector index that is given during CQ creation can't
>>> exceed the number of support vectors by the underlying RDMA device. 
>>> This
>>> violation currently can accure, for example, in case one will try to
>>> connect with N regular read/write queues and M poll queues and the sum
>>> of N + M > num_supported_vectors. This will lead to failure in 
>>> establish
>>> a connection to remote target. Instead, in that case, share a 
>>> completion
>>> vector between queues.
>>
>> That sounds like a RC patch? Where is the fixes line? Why is it in
>> this series?
>
> Agree, this should be sent as a separate patch.

The reason I sent it in 1 series is to avoid conflicts. Since all the 
patches can go to nvme-5.8, I tried to make life easier.

We can do it separately of course.

Christoph,

would you like to merge patches 1+2 from this series or should I send 
them again as well ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
