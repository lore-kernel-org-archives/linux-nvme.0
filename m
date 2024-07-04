Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70818C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 05:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4UH8Km1LRzks5lPP4rWr4zhJO0izHiyvA7fZ9kGt3Y=; b=uxUHFY1/d0ArRAko9Cf30vosy8
	WeciGbrUl+gSndh7BpbJUY1iP/WwZSI6UqdkSMUNf3RAgNIeXh1wPW87MsIfyNCdJZ6a0zanhQbrw
	NLdPzVikNUE0Qmq5rzI1w3Dmbrdme39TM7RzzknzYSSMAbxCO2JJdhQkgncsbJmRIU60HOrbWXUKr
	qnfXL/c1d1BraiCBJIothNSpnwogk4DwjtppRQT+MO810wB6CVr6trWlNp9mDLVTDoVDxY/jRa+UP
	O6nXeXAOPblTb5dLb1JZCo8xf8du2wMWG/A0b5Op6svSm1q5Q/PHWGsXNYGZf/jduHYXKEmHg0JJi
	vxTmIqFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPF8t-0000000CDmi-0ms7;
	Thu, 04 Jul 2024 05:36:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPF8q-0000000CDmA-2N5j
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 05:36:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B773568AFE; Thu,  4 Jul 2024 07:36:13 +0200 (CEST)
Date: Thu, 4 Jul 2024 07:36:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Message-ID: <20240704053613.GA19735@lst.de>
References: <20240703135021.34143-1-hare@kernel.org> <20240703135021.34143-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703135021.34143-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_223624_773921_AEE14A04 
X-CRM114-Status: GOOD (  13.31  )
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

On Wed, Jul 03, 2024 at 03:50:18PM +0200, Hannes Reinecke wrote:
> Implement per-controller I/O workqueues to reduce workqueue contention
> during I/O.

Gee, I can see that you are implementing it.  But given that workqueues
are scalable contexts I'd really like to see where you hit limits.
Maybe it's totally expected, maybe you found a bug in the workqueues,
or maybe you just did because you need some of this later.

You'll need to tell the reviewers and also people finding the inevitable
bugs later on why you are doing this.

> +		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);

.. and avoid allthe overly long lines.  Maybe by adding a helper to
de-duplicate this code?

> +		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);

> +		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);

> +	queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);

> +		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);


