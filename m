Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285DAC3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27B323400
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S8IoRBYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27B323400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oGAz3I1JjeS7ZTG6+UXxJwwk7SfteVyVSlaFCKgCGj4=; b=S8IoRBYTB/6OvB
	kBXvLW4w3vov3KfqT+Xq4gzkMyXis7uGIUf4HrpTqRWed4IURyyWlhqgevd0sdhnlD96Uwg4o+RdY
	LktM3xo7kssU1J04vZqVJRrIvyr5tM9Ef1cyKg7FOgenekrAf0iYuO/HSpIE70QYmeFHVqlYRDi1l
	NG6t5yyCJP2uLv5qWX6nQkpJsCnP+4UlUKB43wcIOEw1tagGCoF24CEtkwwUkYX0zo2zYmpoVJe8a
	r4K66UesRO6Xr9bXg4JA65vtQjxVFGn4dmigDdgKCwApa0COWZb+lIBxX9ovLVpxxCRlMehLn9uha
	Y6OWvnWyFA4V2B6Xu1xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5OCZ-0000Bl-P6; Wed, 04 Sep 2019 05:51:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5OCX-0000BF-Ey
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 05:51:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B0AEE227A8A; Wed,  4 Sep 2019 07:51:26 +0200 (CEST)
Date: Wed, 4 Sep 2019 07:51:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 2/4] nvme-rdma: simplify error flow in nvme_rdma_queue_rq
Message-ID: <20190904055126.GC10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <1567523655-23989-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567523655-23989-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_225129_652001_A4B0E10A 
X-CRM114-Status: UNSURE (   7.40  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 06:14:13PM +0300, Max Gurtovoy wrote:
> Make the error flow symmetric to the good flow by moving the call to
> nvme_cleanup_cmd from nvme_rdma_unmap_data function.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Looks good, and also independent from the PI changes:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
