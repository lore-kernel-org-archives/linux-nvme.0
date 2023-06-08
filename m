Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4D0C7EE25
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 05:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0oRJf+kD/Tnpa+2cgEv1g3JfZ1gNERji3l3Lkgtj4Zo=; b=xbQAGhV4DaiQUUSXZxWHRvjYpr
	I1uMSFB5nOO8PFuTADt+3nlr6RFwDwn+rEX1hbiMS0IMv/q1wYHxqx3loxXmD0p7Z7v+eGa63gbSp
	lgXLH84OhP3dtC/g6fL1WAY6BvPhYvrzuIm3ICsKIh+5h8PxAzcTUvC98J1hE83NRToZJq3UTPutD
	K8AUnmuX7jqwtXniUW+R15FZAlWO1i3Fc9xZ5eZ2CbdHQ8pNd8CgW7YHrl54XmmGU4SfK9fZi5gUM
	qr62wLT4ZV1OVCkjFV9dijOJI3DGnp93aGwA94hd2t2OK2JfG40tKvY5j7c1G92BkvjeVQrkyhrYu
	BMVCIzFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q78aS-008BZJ-36;
	Thu, 08 Jun 2023 05:53:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q78aP-008BYb-0u
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jun 2023 05:53:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D911D6732D; Thu,  8 Jun 2023 07:53:20 +0200 (CEST)
Date: Thu, 8 Jun 2023 07:53:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, Amit.Engel@Dell.com,
	kbusch@kernel.org
Subject: Re: [PATCH] nvme: print disposition on err req completion
Message-ID: <20230608055320.GA11784@lst.de>
References: <20230605064933.46933-1-kch@nvidia.com> <20230607050059.GA19879@lst.de> <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_225329_487674_7B73991C 
X-CRM114-Status: GOOD (  13.74  )
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

On Wed, Jun 07, 2023 at 06:08:16PM +0300, Sagi Grimberg wrote:
>> Hmm, not sure this is the right way to approach it.  I'd rather
>> redo how the trace points work by having a class and the ondividual
>> tracepoints in nvme_end_req/nvme_retry_req/nvme_failover_req.
>
> :)
>
> This was the original proposal (posted as a question to the list),
> and I proposed this approach. You don't like it?

 1) the different dispostitions are really very different events,
    lumping them up does make tracing harder because you need to
    manually filter every time
 2) I really don't like exposing the disposition enum outside of core.c

