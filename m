Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C43C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLpoVjnf11dl/ji5LMAo8cROGGRdckh5OoGKDIRtODA=; b=ram+tbHvPzuNfxoiKhszn62lyP
	NBsJgi6eNsDyY0zGF2SQFld37XrihhRsAw+RbJxQcsSP79Nk1jR2GrzsbXu/6ZlSTrLZuJ5IcBYMu
	Ka7NiupAcnebCa6LNZv2JLpdUHvvADc3ChtfvuhBDLRbToshe0Va38OalF8zHcRXdkqozDIHkEUuC
	Q7nyHldHUHZlnqSz8ju816l62YWwSKr0gGXpEn5h/KtS1JbT4FRZ6djq9SBg5bomOPlv6vjfGwjFw
	eZV40JRJCa9a8qudxpdcOfaTmmtZGNP/VVuIWigPUXMljV29KdsUa7nsHBxzKS5ms0B2FVNRDGRHk
	rc+qpxdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPF9x-0000000CE95-14jD;
	Thu, 04 Jul 2024 05:37:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPF9u-0000000CE79-1XgJ
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 05:37:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B28168AFE; Thu,  4 Jul 2024 07:37:26 +0200 (CEST)
Date: Thu, 4 Jul 2024 07:37:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
Message-ID: <20240704053725.GB19735@lst.de>
References: <20240703135021.34143-1-hare@kernel.org> <20240703135021.34143-3-hare@kernel.org> <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_223730_571467_060FF4DA 
X-CRM114-Status: GOOD (  16.54  )
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

On Wed, Jul 03, 2024 at 05:19:39PM +0300, Sagi Grimberg wrote:
>
>
> On 03/07/2024 16:50, Hannes Reinecke wrote:
>> When 'wq_unbound' is selected we should select the
>> the first CPU from a given blk-mq hctx mapping to queue
>> the tcp workqueue item. With this we can instruct the
>> workqueue code to keep the I/O affinity and avoid
>> a performance penalty.
>
> wq_unbound is designed to keep io_cpu to be UNBOUND, my recollection
> was the the person introducing it was trying to make the io_cpu always be
> on a specific NUMA node, or a subset of cpus within a numa node. So he uses
> that and tinkers with wq cpumask via sysfs.

Honestly, I think we really should kill this unbound module paramter
before it causes more harm.

