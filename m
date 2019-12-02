Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57DC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 01:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8A4214AF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 01:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SWNvpV+o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8rLkkuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8A4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U9RMimBgVoZO3HNJ7g5YxJJYlU1jEXzfhEThtJONGlo=; b=SWNvpV+o5XTph8
	zuBzPbAdOPfBR0borep7YUWZkOGnmfLpZD1wMsZOcF9PFR0VOtD9cRHt3YGMiFB+DELkO6yQJrsBo
	H1KyLYRtDUWU/urR0Q4u9rokkpWIF9im4PCjVEcrl7ItNtivAdvrLvvZCw6+C8lYqkxbgtWU7If1f
	kw/e4n36ZsPFzCmjWmj/2LgF7GljUrol3NZyNp1vO6/LGE/UzKZHLHIVbmsMPGrL2fLIz5e7YD1hI
	w9PlzGg996zoq9FkG2WYW5diGDzinMqLMfKf5DwSMlyhDqo7875+myLLzaHLA1HZp8FHWcGXGHw7A
	FKM+8KnzJEjyZXWBtTGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibaXp-00022k-TP; Mon, 02 Dec 2019 01:30:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibaXn-00022D-BM
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 01:30:32 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B2A620881;
 Mon,  2 Dec 2019 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575250230;
 bh=/HPGD8Nd5BxXWoI/ah3d3DR1HJDDJ7cw8ffGCo0zEHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s8rLkkuQb3QMUdAjl4PFvTBdie3H5RclHPp5Pqsbka2XAEc1RaX2vzrGD5Ijvmj5U
 MFMJj2D9Lmg1w/VaSYBkl1/0kJqrHhwHRpNhb0Wmd7SH12nE2J+aulWjvHeZqdCeq1
 ZTny4Hzo/v7op/9Fk+gk4dQK+K17tX+gfgDkQvZM=
Date: Sun, 1 Dec 2019 18:30:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Message-ID: <20191202013027.GA5732@keith-busch>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
 <20191129091302.bngxlcsbexiktqbk@linutronix.de>
 <20191130181020.GB5273@redsun51.ssa.fujisawa.hgst.com>
 <20191202011031.GA24512@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202011031.GA24512@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191201_173031_411019_12EE2F2D 
X-CRM114-Status: UNSURE (   8.78  )
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, helgaas@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 09:10:31AM +0800, Ming Lei wrote:
> 
> Even without this issue, threaded irq has other issue, such as, IO
> latency is increased obviously.

Sure, I was working on something for this. I think we can have the
primary handler complete the cq once and return IRQ_HANDLED if the
queue is empty after. If new completions are still pending, then it
can return IRQ_WAKE_THREAD. This should also allow us to remove the
nvme.use_threaded_interrupts parameter since this should get the best
of both.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
