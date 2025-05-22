Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99878C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DhLAXSDnKHLhLHOwFk7SnqyrfCg8rF8vKXKx//k05/8=; b=wjJkLjRoMLqxKueJWk+is5o7G6
	kZaxR+pVubNmfU6tjR4q3njvXvpSB2MCXX/vRUJE91x+E4uzObH48Voa9mXHugh2bjveMj/7u3r+t
	wrdgo6UQzJHQZrz2rnziyXgP1Rzqd6+ItZUDT/VJksU98myUhY0Dor7NSZKDsvFrvI5ty4QS8PBmX
	oeeJ23csgrfyK9tBsF3qZbZKQXKmPHukfc4d1ElgaMth4cuvvcXKZTa4ApWrUksJam/0sN1Kgbrwm
	TWo7uGELd2YV6ApvCvNTREsBG59MmdjbOaLu5RUaGt4MCLz88Ds6YXbgjHg4lyD0WNVM+jx0SUVDB
	R8sjptpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uICBW-000000025jz-2mjM;
	Thu, 22 May 2025 20:06:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIC9V-000000025Jw-1RRw
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 20:04:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E84D49E8B;
	Thu, 22 May 2025 20:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1310AC4CEED;
	Thu, 22 May 2025 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747944268;
	bh=ujPvrlK6afswZBMUhFP2/Msh5uLTbbmYZGDthbnXzYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYIRLkA3ofWRtgwBneRk/csi4yx0dAaY06a0TTBv2S0V0uc0Zg3ptWD02PXTZ8QkP
	 ZgEFO0b4P8S4tjY2E9a4JIGRUC75N9ohwxfXohquA5nXNUC9keF4rZMkfZZeeObF+4
	 Q9Q5KLS5hcNeEE9Y8Zrp+PpCM/oW4IZf3Zh4L8D7YUGd9zGCzAYRN48ZMD0J/Mx+xE
	 pDTkHAK9TwW3OScoirx3t5R+xYiwO8QN/trp7CoomgDcH/CwSzOkSsTrNXNOu1sp1C
	 +uprQyOUqdL1Te8Tf+Iz3W1cGhoCLDV5RRz77wobPGVQINfGKbn5672q3I/PU/1C49
	 soniJOr1zqauA==
Date: Thu, 22 May 2025 14:04:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aC-DSTUfgBjNH28H@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <468be217-40d5-4674-891e-d11cc96b1c2a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468be217-40d5-4674-891e-d11cc96b1c2a@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_130429_397572_D6331A7E 
X-CRM114-Status: GOOD (  11.82  )
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

On Thu, May 22, 2025 at 12:22:22PM -0700, Bart Van Assche wrote:
> 
> Is avoiding code duplication still a goal in the Linux kernel project?

I feel like that's a generic goal of software development in general.

> If so, should the above code be consolidated with kcopyd into a single
> implementation?

This patch provides a synchronous interface, similar to other services
in blk-lib's APIs, like blkdev_issue_zeroout().  kcopyd, on the other
hand, is an asynchronous interface with its own zero-out implementation
(dm_kcopyd_zero). It's not like unifying these operations for different
use cases was a priority; the implementations don't have much in common,
so its not really duplicated code anyway.

Now, if we are able to settle on the REQ_OP_COPY implementation, then it
wouldn't be a big deal to have kcopyd use it too.

