Return-Path: <SRS0=c/Ka=3J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03568C2D0DB
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2020 12:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB7420678
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2020 12:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CKs5L37d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="q3K4qVw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB7420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T+DiEiS6ZHu4evXWCPEXL2Te0tGYvpJN++YqLWhY6V0=; b=CKs5L37dCgbpoqfFpFxMIZeG+
	F+DaCR9xqpE9c4pYbbkqP8XrZXHVpY9O478lWoMZySjF1lycpEneI3v8K5lvrM2u8FFQzsdyt9h4K
	I7kNhE9O51Q3LjSAnFgbF45Mixn+E+d+WSPKUwFWhxVZfSRQRY3+R+aBXxEZV1IYRJqyPGJs4dmLE
	LPeRE2lRSfs0ouyrcYlHwsSXn8jCfTmmH6SUeDbk9bY+pqxrjEhSOOzSbfSV2HGHR/5at6MWmv6FB
	5l5Sz7l9qubBlJpNG09CXZYWDB+q/8BeR+dLToEupjfwURKwnPn8EAJnO+3GoXsiWVOIorpYHuPgm
	890GbppYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itWXx-0000aP-0k; Mon, 20 Jan 2020 12:52:49 +0000
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itWXq-0000X3-9H
 for linux-nvme@lists.infradead.org; Mon, 20 Jan 2020 12:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE1VUKSlxDtqX6AqKaWVHJT3NNk2ZfK78QGplBBJMIyP7TVRDr5dTsAfwDlcMxfhZZq2lt5McVdeK44NkSlaOUNUv7K5EHFtV41Ya4HNmMAw4BVQGTCtY6TcHTn8swaugPClEyVr4MFvX/JvA35gVguPK5i5fit/INUIVZbpcVwnCg9/nmjO8+PTGfKWvxIjjj4jW4UhcSBgbxdL6ySiR8DZH/QUYwllcGiis3/hJ9PqWnsGpunoki0DdA77T6PQM255J0SzPGjvWbWTB2zDfit3fnS7kYoQ4JmmH0c0twzH1wKnNji7kraKpn1WbYQXwJUayauqAb4XT1pWhfgzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjLKKVBr35xivhUgm0I+qKkeCZbg1b2ntIi+2gbklbU=;
 b=jqildE+KaO9b4MFgTTohyD0TWkX3kfX0qxmlQ3MyFfQfp5YaUkJxJ0Z2hcfu66oJXS+067u1TJ27Ffzs0p6ZC5TSYow/ljgT/2/zUmzWQGaTSnweScSVBsNNkOVL/5JEn6CN/lK2fO2A/+8r0UjcVA8IwswRaMFYMq4gf5IRbG7oYGfxaRHvIvKthnA3p0Rohmo92ht166z1oZN/oiSV631PIuh+foOrbpPqhLQb4c9FUrXaq6PQu4EPQX5/sanXo0ij0O6rsetAp5+GzgKloZMlDzKGONaoMDS2dqdOf4J1Qc2rRl2T404HVUFEMD8PwVfpAJj9VUVVn0n9b0O0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjLKKVBr35xivhUgm0I+qKkeCZbg1b2ntIi+2gbklbU=;
 b=q3K4qVw1OzvWYHdmKU0Q40+32j+d2TurvaKlHq/Akb22ESoZabZpAawuonxy8q37EMTvTYqXa2sbYD8BoKsohW9XyhHFPa+3BMjLqvkm7sGlO3Y0hmpgZlboE4OPs/UU1eNLxEU6kgFTGRk+rrmj6hh1FSXfeiQSyrOUNA9IztE=
Received: from HE1PR05CA0372.eurprd05.prod.outlook.com (2603:10a6:7:94::31) by
 VI1PR05MB4735.eurprd05.prod.outlook.com (2603:10a6:802:62::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 12:52:36 +0000
Received: from VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by HE1PR05CA0372.outlook.office365.com
 (2603:10a6:7:94::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Mon, 20 Jan 2020 12:52:36 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT004.mail.protection.outlook.com (10.152.18.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2644.23 via Frontend Transport; Mon, 20 Jan 2020 12:52:35 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 20 Jan 2020 14:52:34
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 20 Jan 2020 14:52:34 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 20 Jan 2020 14:52:33
 +0200
Subject: Re: [RFC PATCH 1/2] nvmet: add bdev-ns polling support
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, <sagi@grimberg.me>,
 <hch@lst.de>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <20191210062557.5171-2-chaitanya.kulkarni@wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2c5f45ab-7ac1-b904-bc7b-1f272484b845@mellanox.com>
Date: Mon, 20 Jan 2020 14:52:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191210062557.5171-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(31696002)(26005)(186003)(86362001)(110136005)(16526019)(30864003)(5660300002)(2616005)(16576012)(81166006)(81156014)(8676002)(70586007)(36906005)(8936002)(70206006)(2906002)(53546011)(316002)(36756003)(31686004)(478600001)(4326008)(356004)(336012)(21314003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4735; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c0073b0-dc74-46bc-53cd-08d79da79f85
X-MS-TrafficTypeDiagnostic: VI1PR05MB4735:
X-Microsoft-Antispam-PRVS: <VI1PR05MB473583DCA764BDFCA681B482B6320@VI1PR05MB4735.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0288CD37D9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjlzZEZoCwU2EtS1YPFC7uEC/DVQAkHATLDJ1s8zI5vJhDxpbPvLTZ9IQIXYOM1vVmnagad+jHj/npJfX6zenW7qR1t6tuw9/WCYj3F4V4+yRBY6ksJcXE+YWCmhw9IJuzqU9lDdI/RYk+eozS9DfwVaSQ9Qc5C4h1n1HN7Br44l4l48r79Bl/8nbznioKGQugsuuIgbNUHz9niQ7BAFvzBC+P3PF7VX7t5JiipTtFU4OpDLLqbvpaIb/MgKXMJSMDyKButcJyjwnH6O93GzCnkN7OT1ZyMd0qg9N4CiNBy8sFud45xX7xL3Bm6e715eiqHMiPvfmck6cliLLX3IDU7mzQHU3TLE36tyoPQdQ615jHc1BI4hnXYmNY8wujSebrSmgm0VRgY1QieZoid6rCl65S7VI7HHNCWVdIgVd1UxObIUXBsiFO46jrLS2zq1Q3JjIni0PBcAjrsf2qnLvIamE1nI8VdHqH4sU14575Ug3kAylwNBLs8XdIrrYReBmToXXLlrpvItdnKrgRV6Ww==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 12:52:35.5186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0073b0-dc74-46bc-53cd-08d79da79f85
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4735
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200120_045242_514089_C663AF3E 
X-CRM114-Status: GOOD (  25.55  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 12/10/2019 8:25 AM, Chaitanya Kulkarni wrote:
> This patch adds support for the bdev-ns polling. We also add a new
> file to keep polling code separate (io-poll.c). The newly added
> configfs attribute allows user to enable/disable polling.
>
> We only enable polling for the READ/WRITE operation based on support
> from bdev and and use_poll configfs attr.
>
> We configure polling per namespace. For each namespace we create
> polling threads. For general approach please have a look at the
> cover-letter of this patch-series.

It would be great to get some numbers here to learn about the trade-off 
for this approach.


>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/target/Makefile      |   3 +-
>   drivers/nvme/target/configfs.c    |  29 ++++++
>   drivers/nvme/target/core.c        |  13 +++
>   drivers/nvme/target/io-cmd-bdev.c |  61 +++++++++--
>   drivers/nvme/target/io-poll.c     | 165 ++++++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h       |  31 +++++-
>   6 files changed, 291 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/nvme/target/io-poll.c
>
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index 2b33836f3d3e..8877ba16305c 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>   obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>   
>   nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
> -			discovery.o io-cmd-file.o io-cmd-bdev.o
> +			discovery.o io-cmd-file.o io-cmd-bdev.o \
> +			io-poll.o
>   nvme-loop-y	+= loop.o
>   nvmet-rdma-y	+= rdma.o
>   nvmet-fc-y	+= fc.o
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 98613a45bd3b..0e6e8b0dbf79 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -545,6 +545,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_ns_, buffered_io);
>   
> +static ssize_t nvmet_ns_use_poll_show(struct config_item *item, char *page)
> +{
> +	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_poll);
> +}
> +
> +static ssize_t nvmet_ns_use_poll_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	bool val;
> +
> +	if (strtobool(page, &val))
> +		return -EINVAL;
> +
> +	mutex_lock(&ns->subsys->lock);
> +	if (ns->enabled) {
> +		pr_err("disable ns before setting use_poll value.\n");
> +		mutex_unlock(&ns->subsys->lock);
> +		return -EINVAL;
> +	}
> +
> +	ns->use_poll = val;
> +	mutex_unlock(&ns->subsys->lock);
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(nvmet_ns_, use_poll);
> +
>   static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	&nvmet_ns_attr_device_path,
>   	&nvmet_ns_attr_device_nguid,
> @@ -552,6 +580,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	&nvmet_ns_attr_ana_grpid,
>   	&nvmet_ns_attr_enable,
>   	&nvmet_ns_attr_buffered_io,
> +	&nvmet_ns_attr_use_poll,
>   #ifdef CONFIG_PCI_P2PDMA
>   	&nvmet_ns_attr_p2pmem,
>   #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 28438b833c1b..d8f9130d1cd1 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -510,6 +510,18 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>   		ns->nsid);
>   }
>   
> +inline void nvmet_req_done(struct nvmet_req *req)
> +{
> +	if (req->ns->bdev)
> +		nvmet_bdev_req_complete(req);
> +}
> +
> +inline void nvmet_req_poll_complete(struct nvmet_req *req)
> +{
> +	if (req->ns->bdev)
> +		nvmet_bdev_poll_complete(req);
> +}
> +
>   int nvmet_ns_enable(struct nvmet_ns *ns)
>   {
>   	struct nvmet_subsys *subsys = ns->subsys;
> @@ -653,6 +665,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>   
>   	uuid_gen(&ns->uuid);
>   	ns->buffered_io = false;
> +	ns->use_poll = false;
>   
>   	return ns;
>   }
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index b6fca0e421ef..13507e0cbc1d 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -49,10 +49,11 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>   
>   int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>   {
> +	int fmode = FMODE_READ | FMODE_WRITE;
> +	struct request_queue *q;
>   	int ret;
>   
> -	ns->bdev = blkdev_get_by_path(ns->device_path,
> -			FMODE_READ | FMODE_WRITE, NULL);
> +	ns->bdev = blkdev_get_by_path(ns->device_path, fmode, NULL);
>   	if (IS_ERR(ns->bdev)) {
>   		ret = PTR_ERR(ns->bdev);
>   		if (ret != -ENOTBLK) {
> @@ -60,16 +61,21 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>   					ns->device_path, PTR_ERR(ns->bdev));
>   		}
>   		ns->bdev = NULL;
> -		return ret;
> +		goto out;
>   	}
>   	ns->size = i_size_read(ns->bdev->bd_inode);
>   	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> -	return 0;
> +	q = bdev_get_queue(ns->bdev);
> +	ns->poll = ns->use_poll && test_bit(QUEUE_FLAG_POLL, &q->queue_flags);
> +	ret = ns->poll ? nvmet_ns_start_poll(ns) : 0;
> +out:
> +	return ret;
>   }
>   
>   void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>   {
>   	if (ns->bdev) {
> +		ns->poll ? nvmet_ns_stop_poll(ns) : 0;

can you please use an "if" statement instead of the above convention ?


>   		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
>   		ns->bdev = NULL;
>   	}
> @@ -133,15 +139,39 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>   	return status;
>   }
>   
> -static void nvmet_bio_done(struct bio *bio)
> +void nvmet_bdev_req_complete(struct nvmet_req *req)
>   {
> -	struct nvmet_req *req = bio->bi_private;
> +	struct bio *bio = req->b.last_bio;
>   
>   	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
>   	if (bio != &req->b.inline_bio)
>   		bio_put(bio);
>   }
>   
> +static void nvmet_bio_done(struct bio *bio)
> +{
> +	struct nvmet_req *req = bio->bi_private;
> +
> +	req->b.last_bio = bio;
> +
> +	req->poll ? complete(&req->wait) : nvmet_bdev_req_complete(req);

Same here for the "if". Lets keep the code as readable as we can


> +}
> +
> +void nvmet_bdev_poll_complete(struct nvmet_req *req)
> +{
> +	struct request_queue *q = bdev_get_queue(req->ns->bdev);
> +
> +	while (!completion_done(&req->wait)) {
> +		int ret = blk_poll(q, req->b.cookie, true);
> +
> +		if (ret < 0) {
> +			pr_err("tid %d poll error %d", req->t->id, ret);
> +			break;
> +		}
> +	}
> +	nvmet_bdev_req_complete(req);
> +}
> +
>   static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   {
>   	int sg_cnt = req->sg_cnt;
> @@ -185,7 +215,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   	bio->bi_end_io = nvmet_bio_done;
>   	bio->bi_opf = op;
>   
> -	blk_start_plug(&plug);
> +	if (!req->poll)
> +		blk_start_plug(&plug);
>   	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>   		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
>   				!= sg->length) {
> @@ -204,8 +235,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   		sg_cnt--;
>   	}
>   
> -	submit_bio(bio);
> -	blk_finish_plug(&plug);
> +	req->b.last_bio = bio;
> +	if (req->poll)
> +		req->b.last_bio->bi_opf |= REQ_HIPRI;
> +
> +	req->b.cookie = submit_bio(bio);
> +
> +	nvmet_req_prep_poll(req);
> +	nvmet_req_issue_poll(req);
> +	if (!req->poll)
> +		blk_finish_plug(&plug);
>   }
>   
>   static void nvmet_bdev_execute_flush(struct nvmet_req *req)
> @@ -330,15 +369,19 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>   	switch (cmd->common.opcode) {
>   	case nvme_cmd_read:
>   	case nvme_cmd_write:
> +		req->poll = req->ns->poll;
>   		req->execute = nvmet_bdev_execute_rw;
>   		return 0;
>   	case nvme_cmd_flush:
> +		req->poll = false;

should be done in some general place for req initialization.


>   		req->execute = nvmet_bdev_execute_flush;
>   		return 0;
>   	case nvme_cmd_dsm:
> +		req->poll = false;
>   		req->execute = nvmet_bdev_execute_dsm;
>   		return 0;
>   	case nvme_cmd_write_zeroes:
> +		req->poll = false;
>   		req->execute = nvmet_bdev_execute_write_zeroes;
>   		return 0;
>   	default:
> diff --git a/drivers/nvme/target/io-poll.c b/drivers/nvme/target/io-poll.c
> new file mode 100644
> index 000000000000..175c939c22ff
> --- /dev/null
> +++ b/drivers/nvme/target/io-poll.c
> @@ -0,0 +1,165 @@
> +#include <linux/blkdev.h>
> +#include <linux/module.h>
> +#include <linux/sched/signal.h>
> +#include <linux/kthread.h>
> +#include <uapi/linux/sched/types.h>
> +
> +#include "nvmet.h"
> +#define THREAD_PER_CPU	(num_online_cpus() * 2)
> +
> +static int nvmet_poll_thread(void *data);
> +
> +int nvmet_ns_start_poll(struct nvmet_ns *ns)
> +{
> +	struct nvmet_poll_data *t;
> +	int ret = 0;
> +	int i;
> +
> +	t = kzalloc(sizeof(*t) * THREAD_PER_CPU, GFP_KERNEL);
> +	if (!t) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < THREAD_PER_CPU; i++) {
> +		init_completion(&t[i].thread_complete);
> +		init_waitqueue_head(&t[i].poll_waitq);
> +		INIT_LIST_HEAD(&t[i].list);
> +		INIT_LIST_HEAD(&t[i].done);
> +		mutex_init(&t[i].list_lock);
> +		t[i].id = i;
> +
> +		t[i].thread = kthread_create(nvmet_poll_thread, &t[i],
> +					     "nvmet_poll_thread%s/%d",
> +					     ns->device_path, i);
> +
> +		if (IS_ERR(t[i].thread)) {
> +			ret = PTR_ERR(t[i].thread);
> +			goto err;
> +		}
> +
> +		kthread_bind(t[i].thread, i % num_online_cpus());
> +		wake_up_process(t[i].thread);
> +		wait_for_completion(&t[i].thread_complete);
> +	}
> +
> +	ns->t = t;
> +out:
> +	return ret;
> +err:
> +	nvmet_ns_stop_poll(ns);
> +	goto out;
> +}
> +
> +void nvmet_ns_stop_poll(struct nvmet_ns *ns)
> +{
> +	struct nvmet_poll_data *t = ns->t;
> +	int i;
> +
> +	for (i = 0; i < THREAD_PER_CPU; i++) {
> +		if (!t[i].thread)
> +			continue;
> +
> +		if (wq_has_sleeper(&t[i].poll_waitq))
> +			wake_up(&t[i].poll_waitq);
> +		kthread_park(t[i].thread);
> +		kthread_stop(t[i].thread);
> +	}
> +}
> +
> +static void nvmet_poll(struct nvmet_poll_data *t)
> +{
> +	struct nvmet_req *req, *tmp;
> +
> +	lockdep_assert_held(&t->list_lock);
> +
> +	list_for_each_entry_safe(req, tmp, &t->list, poll_entry) {
> +
> +		if (completion_done(&req->wait)) {
> +			list_move_tail(&req->poll_entry, &t->done);
> +			continue;
> +		}
> +
> +		if (!list_empty(&t->done))
> +			break;
> +
> +		list_del(&req->poll_entry);
> +		mutex_unlock(&t->list_lock);
> +		nvmet_req_poll_complete(req);
> +		mutex_lock(&t->list_lock);
> +	}
> +	mutex_unlock(&t->list_lock);
> +	/*
> +	 * In future we can also add batch timeout or nr request to complete.
> +	 */
> +	while (!list_empty(&t->done)) {
> +		/*
> +		 * We lock and unlock for t->list which gurantee progress of
> +		 * nvmet_xxx_rw_execute() when under pressure while we complete
> +		 * the request.
> +		 */
> +		req = list_first_entry(&t->done, struct nvmet_req, poll_entry);
> +		list_del(&req->poll_entry);
> +		nvmet_req_done(req);
> +	}
> +
> +	mutex_lock(&t->list_lock);
> +}
> +
> +static int nvmet_poll_thread(void *data)
> +{
> +	struct nvmet_poll_data *t = (struct nvmet_poll_data *) data;
> +	DEFINE_WAIT(wait);
> +
> +	complete(&t->thread_complete);
> +
> +	while (!kthread_should_park()) {
> +
> +		mutex_lock(&t->list_lock);
> +		while (!list_empty(&t->list) && !need_resched())
> +			nvmet_poll(t);
> +		mutex_unlock(&t->list_lock);
> +
> +		prepare_to_wait(&t->poll_waitq, &wait, TASK_INTERRUPTIBLE);
> +		if (signal_pending(current))
> +			flush_signals(current);
> +		smp_mb();
> +		schedule();
> +
> +		finish_wait(&t->poll_waitq, &wait);
> +	}
> +
> +	kthread_parkme();
> +	return 0;
> +}
> +
> +inline void nvmet_req_prep_poll(struct nvmet_req *req)
> +{
> +	if (!req->poll)
> +		return;
> +
> +	init_completion(&req->wait);
> +	req->t = &req->ns->t[smp_processor_id()];
> +}
> +
> +inline void nvmet_req_issue_poll(struct nvmet_req *req)
> +{
> +	if (!req->poll)
> +		return;
> +
> +	while (!mutex_trylock(&req->t->list_lock)) {
> +		if (req->t->id < num_online_cpus())
> +			req->t = &req->ns->t[req->t->id + num_online_cpus()];
> +		else
> +			req->t = &req->ns->t[req->t->id - num_online_cpus()];
> +	}
> +
> +	if (completion_done(&req->wait))
> +		list_add(&req->poll_entry, &req->t->list);
> +	else
> +		list_add_tail(&req->poll_entry, &req->t->list);
> +	mutex_unlock(&req->t->list_lock);
> +
> +	if (wq_has_sleeper(&req->t->poll_waitq))
> +		wake_up(&req->t->poll_waitq);
> +}
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 46df45e837c9..ef2919e23e0b 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -49,11 +49,22 @@
>   #define IPO_IATTR_CONNECT_SQE(x)	\
>   	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>   
> +struct nvmet_poll_data {
> +	struct completion		thread_complete;
> +	wait_queue_head_t		poll_waitq;
> +	struct mutex			list_lock;
> +	struct task_struct		*thread;
> +	struct list_head		list;
> +	struct list_head		done;
> +	unsigned int			id;
> +};
> +
>   struct nvmet_ns {
>   	struct list_head	dev_link;
>   	struct percpu_ref	ref;
>   	struct block_device	*bdev;
>   	struct file		*file;
> +	struct nvmet_poll_data	*t;
>   	bool			readonly;
>   	u32			nsid;
>   	u32			blksize_shift;
> @@ -63,6 +74,8 @@ struct nvmet_ns {
>   	u32			anagrpid;
>   
>   	bool			buffered_io;
> +	bool			use_poll;
> +	bool			poll;
>   	bool			enabled;
>   	struct nvmet_subsys	*subsys;
>   	const char		*device_path;
> @@ -292,9 +305,15 @@ struct nvmet_req {
>   	struct nvmet_ns		*ns;
>   	struct scatterlist	*sg;
>   	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
> +	struct completion	wait;
> +	bool			poll;
> +	struct nvmet_poll_data  *t;
> +	struct list_head	poll_entry;
>   	union {
>   		struct {
> -			struct bio      inline_bio;
> +			struct bio		inline_bio;
> +			blk_qc_t		cookie;
> +			struct bio		*last_bio;
>   		} b;
>   		struct {
>   			bool			mpool_alloc;
> @@ -442,6 +461,16 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>   void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   		u8 event_info, u8 log_page);
>   
> +int nvmet_ns_start_poll(struct nvmet_ns *ns);
> +void nvmet_ns_stop_poll(struct nvmet_ns *ns);
> +void nvmet_req_prep_poll(struct nvmet_req *req);
> +void nvmet_req_issue_poll(struct nvmet_req *req);
> +
> +void nvmet_req_poll_complete(struct nvmet_req *req);
> +void nvmet_bdev_poll_complete(struct nvmet_req *req);
> +void nvmet_bdev_req_complete(struct nvmet_req *req);
> +void nvmet_req_done(struct nvmet_req *req);
> +
>   #define NVMET_QUEUE_SIZE	1024
>   #define NVMET_NR_QUEUES		128
>   #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
