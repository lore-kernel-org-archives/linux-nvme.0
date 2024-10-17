Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21847D3C52B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmRI9TIj3khlOzr2A6Ivgigos07ruIK63A/3I+bhZf0=; b=A22b3Rjov/JUlAeZmGEE3zsUeK
	hU6iAdjdPnVeBHWdiEps3IhbT6HzhyfZtTDLQA5LtO5ErQn0nVo+eMT6400dTevdJmSVB7D5jrXjA
	wt9FoBi43ehO5YdRuTjnu+igTkNgBPDMWeSBBxfVzrEXsCAYPGQCPvFLljXeab3cjs5jAT+44zXsc
	YOK1JW4lmOVonKq9yo51y5rHp3QVH/L0Y/3YEDOol0F7sMB0QTKf1vBBGHrAZa1XFEaKhuhhQnfzV
	/DEuKxMFKl7W89sOxqINiXxuEWCqAsism1wmwAX5/+9e7oykmCpSbFb6PQPGtTaD6Edn3B1huV9td
	N56J0WCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UrM-0000000FoXp-3cG0;
	Thu, 17 Oct 2024 18:04:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UrJ-0000000FoX7-38xD
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 18:04:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5ABBF5C10EA;
	Thu, 17 Oct 2024 18:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103EAC4CEC3;
	Thu, 17 Oct 2024 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188264;
	bh=TFJHgUwRLWGurUOcgrhRTbFijfWX0DW1MA2R39PJRdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1GfJSXoHa8kkQHvN7xjvG5k6SJRagWZZF9rUWHGWLADV/LRWcHMrNuo1Jc/K87eh
	 JzUg+MPJzYx7v3UxySKdBOYatloqUBp5m9qywkjplZ0QSRYll0YNJbrzoTq3d3iW4U
	 A9q1zIR/KOKKSNnh8qBmHnWd1UjaFUnOzKvlR1SccvEYhFvU//AKJwYjBAIGjouoSB
	 3ih6X5XIbflVu9Fip9M343CaMuvb+NiKLEeqbUo72Qz+pLZLGrN4MVvtEvaKtQ+1Jf
	 crnCw91uGc6OQISRdHt2/HQEM7IAL4o69LR7RP/sqhrdquz3NIgYyJWpOpe/pVVTrI
	 uNqlCYBEmosHQ==
Date: Thu, 17 Oct 2024 12:04:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Message-ID: <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
References: <20241017172052.2603389-1-kbusch@meta.com>
 <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_110425_858280_7BF54399 
X-CRM114-Status: GOOD (  12.19  )
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

On Thu, Oct 17, 2024 at 11:39:24AM -0600, Jens Axboe wrote:
> On 10/17/24 11:20 AM, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Commit 505363957fad ("nvmet: fix nvme status code when namespace is
> > disabled") introduced a mutex lock in the io path for target. The loop
> > target connects this to the blk-mq submission side, so it requires the
> > blocking flag set so that queue_rq doesn't happen inside an rcu context.
> 
> Looks fine to me, but might be worth looking at doing that a bit
> differently so that the target loop driver can remain non-blocking
> as it should be considerably more efficient.

That's what I first looked at, but it's too hard. Maybe if we can make a
lookup that doesn't rely on searching the configfs group, but it's
definitely not this nice one-liner patch. :)

No rush on this today. I'll think more on it.

