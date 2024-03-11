Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F545C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMs6q0bzyb2M8jsBlGbSyrI2+XvHZAIqPvz+bwF4Zrg=; b=OYWZqK2OwQszCX+xxJONd3bY+9
	umKF2f9BHK13cIkxSjVk4RAr1HK4K+YkcfdEoScjP0agoJrdPWMDRuBShnnjTqk5Oc6eRKeQuxhfb
	KjDlUMd3gJDzRYsUW2PtPYW4BkBDT9aC4BPbBCmSlilu9QctgJ7dRQFZe9+AAA0VP3l/qZbfHu14b
	0ya7pcv+CIXN3biV58682iDXyQMD3Ii3TIxJEgwHt8UQtWHQX+nFB0QPn/G7/FAKAdW0LQEmTziz0
	bEWJ8xat6Fel1dzPdBTmR5estubDBDpUFJ+uwmDm1llIJA3WfiFAz1NjWkbhoTmOOy0fhAT9tPott
	LM/JqyOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjXU6-00000000AeN-1KGj;
	Mon, 11 Mar 2024 04:41:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjXU2-00000000Abo-1V0y
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 04:41:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DFFB6CE0B01;
	Mon, 11 Mar 2024 04:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7149BC433C7;
	Mon, 11 Mar 2024 04:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710132100;
	bh=MUUHNLxC/A0fSUnFLFpiuifJJLsSSzmv2T6jsEdUnX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zur+UW2xZFyHMcfm2De+mXDfGCoQqwUIxUAUqnyUdp7yR3QMBRjIk2hGBrSGVLMPJ
	 1Elr67FTn3ATN/hBpeAYWkzYNnw6fT/l1I0AmBNTy0Ww7DhIZue8byMQ7/A5unEUEK
	 CYpOUEuehazRIOpa437gh6Ms19OW1oW6rFA7YBr/ngWI8u896CgCq/OnTfn5c/tI2N
	 bvaNxQ7pHN49RrEw8N3jtp9VeZwRydT9DDRV4LXD07NTikBaK/R5bjwzJVjd1SMyBs
	 VWjmJZMywQh4vo9OiPWTfUFUdgpnpoYpba3fyeCHtnPcdK+to9aYnmF6YVKPN0xmPn
	 JfDAfkdk0O9BQ==
Date: Sun, 10 Mar 2024 22:41:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-block@vger.kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
 <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240310_214154_598116_6824F563 
X-CRM114-Status: GOOD (  12.96  )
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

On Sun, Mar 10, 2024 at 12:35:06AM +0530, Nilay Shroff wrote:
> On 3/9/24 21:14, Keith Busch wrote:
> > Your patch may observe a ctrl in "RESETTING" state from
> > error_detected(), then disable the controller, which quiesces the admin
> > queue. Meanwhile, reset_work may proceed to CONNECTING state and try
> > nvme_submit_sync_cmd(), which blocks forever because no one is going to
> > unquiesce that admin queue.
> > 
> OK I think I got your point. However, it seems that even without my patch
> the above mentioned deadlock could still be possible. 

I sure hope not. The current design should guarnatee forward progress on
initialization failed devices.

> Without my patch, if error_detcted() observe a ctrl in "RESETTING" state then 
> it still invokes nvme_dev_disable(). The only difference with my patch is that 
> error_detected() returns the PCI_ERS_RESULT_NEED_RESET instead of PCI_ERS_RESULT_DISCONNECT.

There's one more subtle difference: that condition disables with the
'shutdown' parameter set to 'true' which accomplishes a couple things:
all entered requests are flushed to their demise via the final
unquiesce, and all request_queue's are killed which forces error returns
for all new request allocations. No thread will be left waiting for
something that won't happen.

