Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A8FC32793
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 05:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxhjjDZKGEogDvmZtSrqbGOXfyvTljeocrlRITks924=; b=GJCT0vyLTvrCrIJgdzPeaaG5K+
	Yx6ZGEvMUidUnFtQXic7ingYdfvB7QlEhtVEl0aoipEwoZg34gCJeBfS7L/TArfFKw5Q3Uozkk9um
	8e0AUtPta6zJjibpTcvllgg+v8AIdXw+6QA9OHxDmdZW2PwCxpvCqPiml/lgS0SFh63qeveMJuxDl
	FcWRP9A1ae2P/mf9S0jYv7fxEebqgfNSLjG07JGRPzlgveJ9UidmXMo8oUewH0Fzy+pOnhJdEd/gW
	qqQebUbaF64K4onp/A48ckp9V3fDuln8rHH8nylQnmhYTmScdnDiwOYhIpJXfeaajYDQIuyptYxB0
	IHTmfnWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI1NQ-00H0eN-4q; Wed, 18 Jan 2023 05:52:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI1NN-00H0dn-Jc
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 05:52:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CF9B06157D;
	Wed, 18 Jan 2023 05:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F88C433D2;
	Wed, 18 Jan 2023 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674021162;
	bh=3jEn4Qq7QVcgklbnw2N5AkX5nwsMw9vaj0fHxtWF6Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hj7RgjezBY8kJK1vG1IGx1MJl0dPO1koaz78lHfq67GJjJLdKMbf2zMgNlufi9sAH
	 ZIOY3ovvc4pmwYJ2LIR58SvUX81axq14BMvUjF7W2pmPI2ySFxDv6IFDpSwLRFmlSK
	 EwR/fkDph6NA3I40WXHO7wcCBbKPzEYbZqVc5+zR1DkKoNkGNEM6/QgQqvkDroTqd3
	 pKJnC4p9ww1x9wjoZamQ3WkNVotiBvhz1yWu2D5ZMX/pjzLeBYEhwpeKsn770kG+Jo
	 vegZ6rpLMEjSTF65JrE0deo3W+gg+IWMlvdZpk3SwG1bA6GmToThjNsmIK3VadcOay
	 SSD03jVUJRWdA==
Date: Tue, 17 Jan 2023 22:52:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] nvme-pci: fix timeout request state check
Message-ID: <Y8eJJ/9qo9c7jzLT@kbusch-mbp>
References: <20230118052244.741505-1-kbusch@meta.com>
 <20230118053306.GA24817@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118053306.GA24817@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_215245_725023_9B9E5D66 
X-CRM114-Status: GOOD (  20.89  )
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

On Wed, Jan 18, 2023 at 06:33:06AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 09:22:44PM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Polling the completion can progress the request state to IDLE, either
> > inline with the completion, or through softirq. Either way, the state
> > may not be COMPLETED, so don't check for that. We only care if the state
> > isn't STARTED.
> > 
> > This is fixing an issue where the driver aborts an IO that we just
> > completed. Seeing the "aborting" message instead of "polled" is very
> > misleading as to where the timeout problem resides.
> 
> Hmm.  Using a started helper for something that by definition is started
> doesn't really make much sense.  I guess the problem here is that
> blk_mq_end_request_batch sets the state to MQ_RQ_IDLE afte calling
> blk_complete_request?  Maybe we just need an explicit check for
> MQ_RQ_IDLE here as started seems like the wrong implication here.

We're actually not batching here (no IOB in the timeout context), so we
are either:

  a. calling nvme_pci_complete_rq() inline with the cqe
  b. racing with smp ipi or softirq

If case (a), we will always see IDLE. If (b), we are racing and may see
either COMPLETED or IDLE, so we have to check that it's not either of
those. Since there's only one other state (STARTED) that was guaranteed
prior to entering the timeout handler, we can just make sure it's not
that one after the poll to know if abort escalation is needed.

