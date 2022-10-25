Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC9FA373F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CWYoI2WZhRc6aix1qcCvQhNmUSXoi1BsYOrVyEhLnw=; b=UHkAcW75UxAjR6jtvLJ65DS965
	ww8XJBj4IxljppQCqhLL2THYcfhZG2BdX71Rvi05hfufi3lyy1hdN5mMhYohpDZuUszKvfmKHrfMF
	cTeTmRFLAwhl0RzX9dHKvDaaBtgtSsIPli54Z8/9AU8xcWkXwHa9el5Kz0vHagG/JTPYfCC2YrBjl
	yV8GU/xzG4+a7xsllIVncW+zCN4m1aqK9glqon/n0TpJxUeHj5JRdmuGPaQ+VVNA1FwKyq5xegLey
	0K0mvbuvm/VIisiPm+4TKSKNYPV+x+BwGxH+flZgRuTJrE4RWtXDLhT5T6pQ4JNSer5ytd4YrWSyL
	78/EYo+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNEA-006MrQ-Bw; Tue, 25 Oct 2022 16:56:34 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNE7-006Moj-CL
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 16:56:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 29B6BB81DBE;
	Tue, 25 Oct 2022 16:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB5C433D7;
	Tue, 25 Oct 2022 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666716987;
	bh=ZBLcGffm24JiZCfsAQf3HtlwG3ZmRXGjJL0Uq8lWr9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Stjat97zkac4Arts6gtl/Ig/fvAQzN+PrJ+Gi4glHtLxmS4+VnyT2A8XaCXe3cG3t
	 iLLorp8dOK61VQM0QTXaSsOTrBFqagNspyJwoU1Q/Q20cXGNB1v52bQNuD0/7yx8zD
	 dx+fh39kgYR4cq0UStyKhAvRUJvE3yNRDZ45lvYx6nvw7SYQgVh/klpcIn0Z/gfsw+
	 5OYA7Q/0lI5natYrnt6Sl7t1wqBfynZWMHqqnG3ycFMsjE+vrZsH2O+eG3dXNDHE7T
	 X2AX7vgg2fElynRgcnBcD+NWP6nt+7+yxBU2t+ECz4NsLz6mMDuccg8x9eRp1ZQADb
	 0O2hZTmtHAQKA==
Date: Tue, 25 Oct 2022 10:56:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [External] : Re: way to unbind a bad nvme device/controller
 without powering off system
Message-ID: <Y1gVOK8VXhZZbm/C@kbusch-mbp.dhcp.thefacebook.com>
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
 <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
 <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
 <Y1dJbgKZUU9z/7Ok@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1dJbgKZUU9z/7Ok@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_095631_593552_29276A85 
X-CRM114-Status: GOOD (  24.21  )
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

On Mon, Oct 24, 2022 at 08:26:54PM -0600, Keith Busch wrote:
> On Mon, Oct 24, 2022 at 08:02:33PM -0400, James Puthukattukaran wrote:
> > On 10/24/22 18:36, Keith Busch wrote:
> > 
> > > 
> > > Generally, the default timeout is really long. If you have a broken
> > > controller, it could take several minutes before the driver unblocks
> > > forward progress to unbind.
> > One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
> > thanks
> 
> In your log snippet, there's this line:
> 
>   kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
> 
> The next action the driver takes after logging that is to drain any
> outstanding IO through a forced reset, and all subsequent tasks *should*
> be unblocked after that completes to allow the unbinding, so I don't
> think adding any new sysfs knobs is going to help if it's not already
> succeeding.
> 
> The only other thing that looks odd is that one of your stuck tasks is a
> user passthrough command, but that should have also been cleared out by
> the reset. Do you know what command that process is sending? I'll need
> to double check your kernel version to see if there's anything missing
> in that driver to ensure the unbinding succeeds. 

I think there could be a mismatched queue quiesce state happening, but
there's some fixes for this in later kernels. Could you possibly try
something newer, like 6.0-stable, as an experiment?

