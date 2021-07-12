Return-Path: <SRS0=IqcX=ME=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85DCC07E99
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 07:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EE361006
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 07:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EE361006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XAcg4faQ0BnqP2UF8wV2Us4CE2AmVrp5OzGK1k6uwIs=; b=MOlkLy0w8NjRUC
	p2wuWiRgI+wlH+DKI06b5Qd0HMLrBgYA3uNKMRZky1kw1Ad3xdO4OxyT3hF/hYFPZHGKXxLkN+xko
	n6mk+y6OmREjVVqAYVpDv0885FeNr0MW5KgWhjx0kSmdKGJFM7/z6na4GU141U6Kb6NTsygH5jLVx
	5pyS8anFhNHAIoGKYCaUq4f+YMSxKkArTVo71gdIbmhwlrG01gmKLxQBTUEeDqQTNJH7kON0+QfPr
	7vwleSQHJ06/xdGKsxZK+vmvbN9BF4YQicoDZShLfSqQ9XxmykCoiW5c7yGBvPZdLXjsNFEwiiWU6
	34UcdigdtnSrS3qBvzqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2qNC-006LaH-Ei; Mon, 12 Jul 2021 07:29:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2qN9-006LYU-Dc
 for linux-nvme@lists.infradead.org; Mon, 12 Jul 2021 07:29:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B7F6D67373; Mon, 12 Jul 2021 09:28:53 +0200 (CEST)
Date: Mon, 12 Jul 2021 09:28:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V3 01/10] blk-mq: rename blk-mq-cpumap.c as blk-mq-map.c
Message-ID: <20210712072853.GA12347@lst.de>
References: <20210709081005.421340-1-ming.lei@redhat.com>
 <20210709081005.421340-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709081005.421340-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210712_002859_658547_F22AFC81 
X-CRM114-Status: GOOD (  15.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 09, 2021 at 04:09:56PM +0800, Ming Lei wrote:
> Firstly the name of cpumap isn't very useful because all kinds of map
> helpers(pci, rdma, virtio) are for mapping cpu(s) to hw queue.
> 
> Secondly prepare for moving physical device related mapping into its
> own subsystems, and we will put all map related functions/helpers into
> this renamed source file.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I don't really see much of a point in this - we still create the cpu
maps, and if there is more code here that doesn't matter much, does it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
