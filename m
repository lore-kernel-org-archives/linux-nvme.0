Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A60C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SvPhQvSYrTyA968TKgVyEvRwHO0pOanVdg7N7j9y+4=; b=hYQpevdIhyQRlccBOhFGLKmoW/
	BnXQkHMuJlF/tmzAhS/2R9KFBOJoHvHLW4qikcQRKDDfoBUoAqNb8TS662PQoY1mIkvMScuqzw2Oh
	ZTX4iEV3lJc4116oC6AICGuMYiwX85cq+cUMnA6L0T26Z35G5GfyrH+GBBGQvSz7V8fBK6/EKVeOA
	ZsDkixuzy5gWhADaDKzuAP3bGZQ6yzT4fIt3hUJbgbgPhh/KYNZ6LqLtsiqm2kK3ulwHqb+oER02O
	LoXn/TT/kAAyb70MS+B0wCDzVnrZjpbEm6rdTsMgPVjuCLJ+Mm2itQDc2EqEWzaw6CMVyXoRDO4MU
	bVKetLYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKJuN-0071Y3-OS; Wed, 16 Feb 2022 12:59:47 +0000
Received: from mail-db8eur05on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::629]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKJuK-0071Wa-R9
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 12:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1pTDVBZp4/9oh+nzNA6+UnfOM4TqB0mrzRkW0z0g08Gn+bEL8dJqUEYAr3mIVvoDaIgaRT8IkyxNMGR6oHGuuFBL8fm6ORbnRhrAkw8LA+GYnMbvAI+5pAXDK89fx7NWitj3lxvFaEjz6qpMtt+wc+75txkJ9wkfhlhrdbVF5kaXhA9Pcz89EY3Cofov1f85V8YBnhKRmtb+jxSfZEL9/k7Yf2JUBGgF3BHsqKvuAzKQ1meEO4V/W4IEmWZHhTGfHcwkzgtxeR0mOhOrZD1lBGZJ7sp9tKemwSE1jEe3ErIbzxydc6DSpwRu/+gxYp73prkAonjpmBwKQAzcu2whQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SvPhQvSYrTyA968TKgVyEvRwHO0pOanVdg7N7j9y+4=;
 b=XSxTOOu7BvO+/pb3dCuhIrsAKW2Q7tkqjNZfOnldRfgqO+KIZwC4BHnmmfynUsqf1qQCzEM406VXxTUsyzRD7XGm82bc2V5C6fz+S5k+8cnVnwL7jXzsNyxUwaH+CFbwt4aGFJJQsnbJD1xxokX1EYW6GvbZcXlmtEdibgEDDA1ERA8E7hL15Rx8crMVbSLbGl0YcYXAsIXkUFB7UzOwSpyxwiGwFjuD01LJDatt3R5otaTgjlsQiAt2WG+iKPh3WJd4/X9qQmaMQnG6d6r66ezEWrh+kDvgDX0QcwQ6YDeM9IkLfAzpJWk42S8uzN0u/fyS7s8H/fo+3llM2BrNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SvPhQvSYrTyA968TKgVyEvRwHO0pOanVdg7N7j9y+4=;
 b=IEQc08cZCh4baDtoqmFQmNVQd1G2SHERUORjY/va0/eezIanF/aFmWyILilUoDMZJZrr8QqkUeJcruHefxtLIDucKBXxZTyJlZfP2EHlg3l6vNGLq3x8AizLmloHVBFDCa1IkV0K3hf/VlSDXMMkMXLJuuJKjTrxGFenJ2g7OEw2fgW6tB9T00EeHgKqVThdKYXfQBhLjPlGxXoO5MF3olJWLfghPARBdC8e0JhsNay9epaW9M/Ur2saC5b4Wbc1XIDHOMsMwO5RFzT+sC/EFaE+0m2wDT3nsAJqDH9X6FKpjWKqgPeGBHLM4Bt6xUhEuqmcxZNzHcdB12sWrl4fxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
 by AM8P193MB0865.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 12:59:38 +0000
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0]) by AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 12:59:38 +0000
Date: Wed, 16 Feb 2022 13:59:37 +0100
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220216125937.d6brzu7labgywxcg@ipetronik.com>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215201738.GA26945@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215201738.GA26945@lst.de>
X-ClientProxiedBy: AS9PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::25) To AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:307::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ba03df-79fd-4efa-69a1-08d9f14c3026
X-MS-TrafficTypeDiagnostic: AM8P193MB0865:EE_
X-Microsoft-Antispam-PRVS: <AM8P193MB08652E3FDDF71C136512E60E92359@AM8P193MB0865.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrSqddV/lVcqnyKui8NJvVvk4sSDBnacAs3Qm1skVrFLOyzpTKSyfYlV7apNijAQq224NTgVMyWUMiZXSfMpVnlh8a1d6QwPuSLMxHQ8+u8LWHiTYRuRwA7ckPd1FMYv8Ed+tyuKAdlFmTQHO7xSPg4mcvIJconX0oRrVkIap+ZMG75x4Qpr1R7RSeEnPRsKqGBrsXn3ecvYU3v2jleYVEvGRCbJHx+93yRzZMd8UdbpPc+Z7QZ0NrR23yP3wWFFsQx+J+CSRCXPwkny9V22+hoW5c4CTL3t0vkq5aNgyOcuXII9mRDQGJ9ZqxdgzbdzKD2/FXSSskQqFvJ5TUYVuQnafob76YrqRmDcVt8HqYsnimMtMe01+elt4iik365mJRq2M8ePnWQ8oJ59kMTObL+3BqhcnrmjZ9oE8PSkLe4v4Whz9yPg0tLnAaxp9dIubZ2QGJyzorMBhcWyPx7Oy66cO3Ot/TUcT8xEWkS8p3SqjbUQaMbqn5uPgmuzzSnozaoTf4+UCofsSBdoKx3uKCbF5pfOe2Eb67BTiWuB9Swm/PREAQ7Zz8bnq54p9K4x0xO7pI73q6UfIcrR1y6fbQlLTQoC/v2Fk1egxmApQkhrE857L38N6AsWhuObsWbFN0K9WMnccc97h+zNmxgb5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P193MB1572.EURP193.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6506007)(1076003)(52116002)(8936002)(38100700002)(4326008)(8676002)(86362001)(2616005)(186003)(66476007)(110136005)(54906003)(316002)(2906002)(36756003)(83380400001)(6486002)(66946007)(5660300002)(6512007)(508600001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FoJClzlxgdOPLIydC78Z9LSt9OzL/ulsnHU3kuk3Xn4ZVR9qNNFzx2VQQrgz?=
 =?us-ascii?Q?g7QUjRa15OvbwJ9niPcwBoUhc6mjMraw6tvEv7OlOz9bl8TSaLuHJaZaFGEO?=
 =?us-ascii?Q?HJ8wurpRb0NY8kJrpSeBWQLLK6Ibr8YzBlZjhnggk6EwE+OkzpHjTBwweCLg?=
 =?us-ascii?Q?GtluGkE3VFo6EjUxltOH6OdRov1QHqB0xwUth8ks+KiFu5phjMQcIzzQVDWJ?=
 =?us-ascii?Q?KhydwRYFdamf+J2/xwWi8xV31h2mWhS3+8dJtMu90FvO9p1FeaiNkwzjzrTQ?=
 =?us-ascii?Q?CaQCJ7/WTYD1yWhH9YA03xuTNCTQTXB0sWQl6mYrd92L5UsOrcc6fgZVUyhY?=
 =?us-ascii?Q?REStwIbX8i4xkXxKPjqUt2/rJNVgbFULbYKgl2YrUQe/46bIEa+6XbVNS8ae?=
 =?us-ascii?Q?Hfjd5+01IRHI5mR/+8yyra0Yq+GlR6qEt4SFbhcbflhK72Gsi3UD4D49onmj?=
 =?us-ascii?Q?TxVIijwkbiPtvTB50HjOArzUjICKmD7VVh422IZl7vRd9n4Wi/YfzAEENCBQ?=
 =?us-ascii?Q?Hoe/eucTqrERJNHF8S+JAHec3Yph+Iu9q9AuA2nF6ki7PTUXAmt9r5EA8dqA?=
 =?us-ascii?Q?9jdd7q5Ugg09wzRVvpDy0iNuLjEIIZ47HCyyYJQtleSo6d4flaNWJyAoAWaz?=
 =?us-ascii?Q?1EuM2MbvhCrFxnAyuuCfWwd2eOslxdQCAizj7uPaaF4+YJ5FbQBtr23PC8Ff?=
 =?us-ascii?Q?lCfw5ZLNChHNzgn3eynqpC2KujhMx2xdmVjoh3ShxTo1rIrKRXpVYDwVHO45?=
 =?us-ascii?Q?jvERNA/9112h3Lla0Hj81Wqa0hs6HfkTnNA54WWlrBfa2OC+s3l2r5CJhHzQ?=
 =?us-ascii?Q?1AJ8iO8+RrxVlytDjzGpRHutLi7L7k0++9DQXUhpXpsRNUj2omPkcvhnxEjg?=
 =?us-ascii?Q?oP7ooRDOCqNjpWseV4ZXj29nESvWddD5YXrVOHZkejWfITDDplHuxEXDhkfD?=
 =?us-ascii?Q?t6AiNWr2xbuinecqTcLHohTQRF5L2UFH2Si6+kXdheUFoXKve6CImvR90DoS?=
 =?us-ascii?Q?pl1T/9jL4OZZ7CPD0im+PpNxIYgY3qzq38HBgHA6ZwKNNCxAiDHqboGIAg4f?=
 =?us-ascii?Q?zdOiQc2v07pHjOvKzaSWwAO3xYihIYUabWNOn/1mMQnjAtrLqMZUgpe1EBPu?=
 =?us-ascii?Q?Wi3PD/P8CoI8uLKUzfp3TCHI9AxZur2yu1yraphcw6BNJoN4LPyM5lpGn7NZ?=
 =?us-ascii?Q?OIm3yVOqyb8BqVahFZ4Dr+PTCVFjdGmSFfSKI6NcnHGqGn8+hCZyAgX7J9Tm?=
 =?us-ascii?Q?SW09ob8oHB/KXQSn59E88NacL0YuAt5PUMwI6iN3eNmZ4Tcnlba8dXoNugy9?=
 =?us-ascii?Q?v32twdPgAGiYE9v2hN00Dhc/hy8z0lsbDUXUhPeVhz7yIYEgMjm84lhcE9zS?=
 =?us-ascii?Q?5NXZ6fwx2FpShBtqfNrDZO4aA5KPW1N3AvShSxHELqDZfBdVJQU4IVC6Z/0O?=
 =?us-ascii?Q?cDSa9Ya5tXYflsstwIn1Sz/QsQgZLSqmLLYKKX6WuJSoJkCBtaExX9opMV7N?=
 =?us-ascii?Q?X7vR8mu1KXpAAtlNkPJlKexFdCmN8V1e2y/EKvgewMOgrabb+egcksMAQdD3?=
 =?us-ascii?Q?Rb98ErG8JqCL/XlRerqdjvSUXZLhTrrhqT+7qiDmSN0x6ZKvqRxbcQzPyayE?=
 =?us-ascii?Q?q3S8xMdVTtmrMp1LrzccwbViEZoBQHSdB+ZkHdvqF41GFkF0Uba4imaQyDK/?=
 =?us-ascii?Q?DMnugNZ9A7D7kw2KuTl9suC0dgWzk0gt2mMw6izKltxzIyiGcjidC9VauKlw?=
 =?us-ascii?Q?W8UeMH7cVWNmTOBf1dSXkdobLyol1sM=3D?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ba03df-79fd-4efa-69a1-08d9f14c3026
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 12:59:37.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udy324qWAzUEndWE+jQJJWVN68xQZ/VCZWSj6OnhNDVuacpYaD2RXarp68csTl1Kh0ihuIPJzVTsi+f6VqUXeDh9LNG2N5sAs2QLcNeSHmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0865
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_045945_162983_D2283048 
X-CRM114-Status: GOOD (  19.75  )
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

On Tue, Feb 15, 2022 at 09:17:38PM +0100, Christoph Hellwig wrote:
> So, I think in th short run setting GD_DEAD is the right thing as a
> non-invasive fix, but I'd rather do it in blk_set_queue_dying to also
> cover the other drivers with a similar pattern.  blk_set_queue_dying
> is never used for cases where q->disk isn't valid so that should be
> fine.

blk_set_queue_dying() is called from blk_cleanup_queue(), which in turn
is called for all kinds of queues without associated disk, even ones
with failed allocations.
But according to disk_release() a disk which was once associated should
always outlive its queue, thus q->disk should indeed always be safe.


It's a little unfortunate that the existing doc on request queues was
so outdated that it had to be removed.

So I was trying to figure out if blk_queue_dying(q) should always imply
(!q->disk || test_bit(GD_DEAD, &q->disk->state)).
Assuming that there is a 1:1 relationship between q and q->disk and that
blk_queue_dying(q) was previously used where GD_DEAD is now, I do hope
so, since GD_DEAD should just be a weaker form of QUEUE_FLAG_DYING to
allow killing the disk way before the queue.


> 
> In the long run I think we just need to remove the fsync_bdev in
> del_gendisk or at least make it conditional.

But wouldn't that require you to pass a flag like SURPRISE_REMOVAL into
del_gendisk and passing it along through delete_partition()?
You would still need GD_DEAD since someone might remove the disk while
you are syncing, so this only sounds like an error-prone optimization to
me. After all, syncing on graceful removal seems to be a sensible thing
to do.


Fiddling with qemu will probably take me too long unless Hannes already
has something up his sleeves.


So I'll submit V2 after I regained access to the test setup.

It will probably just look something like this:

```
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -286,6 +286,8 @@ void blk_queue_start_drain(struct request_queue *q)

 void blk_set_queue_dying(struct request_queue *q)
 {
+       if (q->disk)
+               set_bit(GD_DEAD, &q->disk->state);
        blk_queue_flag_set(QUEUE_FLAG_DYING, q);
        blk_queue_start_drain(q);
 }
```


Thanks for all your input,

Markus


