Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A8E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 06:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LfJDIEiPVhmH/1xSraDeaDrnw8IUOipaXWYyx6tIOU=; b=b9ACA1kwffVpmHsMSdXEbmo72E
	baZQ3rpcaGRe6eNhsJPMWFCbw6jYVNxCOsQjudvJ+5AIvZRniDMnfGNKxel71AFQJIxa11xrUxryv
	7ZsKGx0e3fxtADDFG9r17GxXcCrnLzAz6uKr8uW2jWxkGrBeDPRpeLIn6rk06Mr7dXNrOVirLQcMj
	/J7qTKe9PkBlouQBkXefm672pvJBpgMK2Iu8EAwfNZekFQA7rk6Xfs6qlGhjl+RQETCLFCeP6G4Jh
	eUjUqf08v7uCusfoC7ERSoZD6+8J1refGR/wf7zB137kroLnj5KmfDuv1xFB7qcuRT0SY0d0z4NsJ
	4EYO/Gpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbbx-0000000CGf0-2Bn2;
	Fri, 03 Jan 2025 06:56:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbam-0000000CGYZ-1s0R
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 06:55:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBE1168BEB; Fri,  3 Jan 2025 07:55:26 +0100 (CET)
Date: Fri, 3 Jan 2025 07:55:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Fix I/O queue cpu spreading for multiple
 controllers
Message-ID: <20250103065526.GA28251@lst.de>
References: <20241224120457.576100-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224120457.576100-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_225532_624422_EA0B50FB 
X-CRM114-Status: GOOD (  18.02  )
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

On Tue, Dec 24, 2024 at 02:04:57PM +0200, Sagi Grimberg wrote:
> Since day-1 we are assigning the queue io_cpu very naively. We always
> base the queue id (controller scope) and assign it its matching cpu
> from the online mask. This works fine when the number of queues match
> the number of cpu cores.
> 
> The problem starts when we have less queues than cpu cores. First, we
> should take into account the mq_map and select a cpu within the cpus
> that are assigned to this queue by the mq_map in order to minimize cross
> numa cpu bouncing.
> 
> Second, even worse is that we don't take into account multiple controllers

Nit: your commit log is overflowing 73 characters in a few places.

>  static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)

Can you add a comment extracted from the commit log before this
function explaining the logic?


