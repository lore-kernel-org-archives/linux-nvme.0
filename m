Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4B8C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgVt82JE2OhYrFI+mqrNMIifmfvl9LmnhZsxX0zKZ4c=; b=EjcepHxLOA6ujsQEbSqVxTRUqH
	c2oFIwsgR4WdQ1opFYWwWsQaevw+0voQHqSFOS88gLmtOD9i4IF8dEcYgVHSJBKndqo9WCHysZWNl
	Vvn7x+fFojaqzDrujJkkmYaRvKG4SUmlJbo1Fs3ovhe5+oAgCPv+34WPTWZnE6kP3H7gjumSDNQQq
	ElmMQYY/dbdqY/f3YmRgq/1TG7WyiVhmsDlSe7ElaaX7UIqaZlc4riywUpp2VC2gFYzW9SkCCzClw
	DIDQZQh8ePPKQV+lWOewwlgrUG6MdLGqzKdBujgKJr4WZcQtKiHtz+WiMW63cwObXctW5Z0ErKGvj
	ETXRhwaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJntr-0000000HWJA-33k9;
	Wed, 19 Jun 2024 05:30:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJntn-0000000HWIO-0vj4
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 05:30:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1EBBD68B05; Wed, 19 Jun 2024 07:30:16 +0200 (CEST)
Date: Wed, 19 Jun 2024 07:30:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: align I/O cpu with blk-mq mapping
Message-ID: <20240619053015.GB29159@lst.de>
References: <20240618120345.64761-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618120345.64761-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_223023_431114_3B88F852 
X-CRM114-Status: GOOD (  15.00  )
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

On Tue, Jun 18, 2024 at 02:03:45PM +0200, Hannes Reinecke wrote:
> Add a new module parameter 'wq_affinity' to spread the I/O
> over all cpus within the blk-mq hctx mapping for the queue.
> This avoids bouncing I/O between cpus when we have less
> hardware queues than cpus.

What is the benefit when setting it?  What is the downside?  Why do you
think it needs to be conditional?

> +	}
>  	if (wq_unbound)
>  		queue->io_cpu = WORK_CPU_UNBOUND;
> +	else if (wq_affinity) {

Missing curly braces.  But this also means the wq_unbound options
is incompatible with your new one.

> +	} else
>  		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);

Overly long line here.


