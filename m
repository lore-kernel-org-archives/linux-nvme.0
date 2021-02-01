Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E15DC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:37:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBB264DD9
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBB264DD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yJ1eEyZ6Cyi1sZp3LCaR3xHfdISEbRukuZlpd/cbROc=; b=rKiQ28QdagnU/M4ZiiEldHqtM
	18tEYIiQpZl7VpIzNRrksV1polrKnJ7bsFQgZ6ywBbk5uBtSy4K52T7QakNqi3BH3XenL0uIsSOgs
	LaBMANephoxxo5qaHwzpwFE/g+2X5R08tZd4yzvkXDUbZKrCrabqsgNU7J+++xStPVfyYtiudH7mb
	fpbuDT0qhXcvVAtKj6JwmcSSUlmzWoWhl002Zj+eUFP+4TVlX8Lzdb5iALwJkZhfC8zZOJl+PZVAg
	C2AgLAFH2wJ4lrkRKzCO8dx4cgQrOArbxz+fn5TNgDNeXmd/hhSgl7bxg8MA5+ya1bh5Yf7PcHCgA
	o5Iw9i2yg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6d8c-0007FR-PT; Mon, 01 Feb 2021 17:37:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6d8a-0007F2-VY
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 17:37:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4169F6736F; Mon,  1 Feb 2021 18:37:19 +0100 (CET)
Date: Mon, 1 Feb 2021 18:37:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Boris Pismenny <borisp@mellanox.com>
Subject: Re: [PATCH v3 net-next  06/21] nvme-tcp: Add DDP offload control path
Message-ID: <20210201173719.GB12960@lst.de>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-7-borisp@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201100509.27351-7-borisp@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_123721_141353_E129A3C7 
X-CRM114-Status: UNSURE (   6.77  )
X-CRM114-Notice: Please train this message.
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
Cc: smalin@marvell.com, sagi@grimberg.me, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org,
 davem@davemloft.net, axboe@fb.com, edumazet@google.com, netdev@vger.kernel.org,
 viro@zeniv.linux.org.uk, dsahern@gmail.com, kbusch@kernel.org, kuba@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static
> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)

Please use the same coding style as the rest of the file, and not some
weirdo version.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
