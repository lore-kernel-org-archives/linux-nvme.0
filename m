Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A821C0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDZUnqGvQ5bbQbthi9tR7qQvRU2W4mUePRQQt9XGHbs=; b=Dr6ZWg1obqu8q5f2+RMgZB/eqj
	3Q7gxdeXQHIT1H2s44wfjXv5zAz8AwOLD++IVWjoirQrH784UiVqmrQGDC84q5attm6yn/W2DLHLO
	55xxtayZhZsII7F6HfCL0gATiPEQ3dGZyKiuIT0LhhX6oyEvyGgiOzxEQPmdySUYxMjoyhqTxQnxC
	8xs18szsA5wiyOC0zUe5+cpDqYpjwj1ZUVYGjGkorO0RezA8PezP6Eh6jaHSFHrtnLg9U/vtLcAbS
	pCUnrY4cRbEcJNMtpwAKSGkZOFuqghbPt4mR69nC6syvBjcFaZkkfIWXh783XuMt6K3646KEttQs1
	mgyoE+Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdlTW-0000000A7le-21YA;
	Fri, 31 Jan 2025 07:30:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdlTT-0000000A7kz-1Uev
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 07:30:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F3BF68C4E; Fri, 31 Jan 2025 08:29:48 +0100 (CET)
Date: Fri, 31 Jan 2025 08:29:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Message-ID: <20250131072947.GB16012@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org> <20250129060534.GA29266@lst.de> <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_232959_536658_959A91FC 
X-CRM114-Status: GOOD (  24.32  )
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

On Thu, Jan 30, 2025 at 04:25:35PM +0100, Daniel Wagner wrote:
> On Wed, Jan 29, 2025 at 07:05:34AM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
> > > If a lot of request are in the queue, this message is spamming the logs,
> > > thus rate limit it.
> > 
> > Are in the queue when what happens?  Not that I'm against this,
> > but if we have a known condition where this error is printed a lot
> > we should probably skip it entirely for that?
> 
> The condition is that all the elements in the queue->send_list could fail as a
> batch. I had a bug in my patches which re-queued all the failed command
> immediately and semd them out again, thus spamming the log.
> 
> This behavior doesn't exist in upstream. I just thought it might make
> sense to rate limit as precaution. I don't know if it is worth the code
> churn.

I'm fine with the rate limiting.  I was just wondering if there is
a case where we'd easily hit it and could do even better.

