Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFA2EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSd9VkjRVJb5QdG69kf1drlO9TuiIx3qOmCAY6Htors=; b=bhzXAWMNCMN3Sp2lNNZJdAZ3W0
	pLs8yrAZZHQU2nPITd/RT589Ycph9XO918dzpHNX07wfautpP2UjjL1qH/dEyXT1PeDpKZvwsTD2Q
	+vj18qanp+uOHzaHnxKV0gj4NHB9MaME1VgSgPoIB6aol/aZMxfDjeCizrmrL22e4ntsFWMgjqBIs
	bMjimoRaVJ8eHUDIJEgOhVa7TdY11JAryH62wl0yAhc3n6ShEBdbIi0/FusoES2c8Q9XKqSCeocWO
	HJ6lsiz1C1GDpaXq/QoC0cjkMh5jQ77whIyPfbAPkaj2ssH1/0DWrrRLN1iZL7h3mZZi9D9GuXZKV
	LgCYCkPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIkaA-00AbsU-09;
	Mon, 10 Jul 2023 06:41:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIka8-00Abs7-0V
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 06:41:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8385F6732D; Mon, 10 Jul 2023 08:41:09 +0200 (CEST)
Date: Mon, 10 Jul 2023 08:41:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to
 calculate io queues
Message-ID: <20230710064109.GB24519@lst.de>
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708020259.1343736-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_234112_335710_C5AB36DE 
X-CRM114-Status: GOOD (  14.79  )
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

On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> Take blk-mq's knowledge into account for calculating io queues.
> 
> Fix wrong queue mapping in case of kdump kernel.
> 
> On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs.

That's simply broken.  Please fix the arch code to make sure
it does not return a bogus num_possible_cpus value for these
setups, otherwise you'll have to paper over it in all kind of
drivers.

