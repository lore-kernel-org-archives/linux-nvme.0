Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7503C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbnp364VejAOhHEWXNEjinbIt3s/fy4dlXsrFO/iHpo=; b=Q8/tnec94aYfH4hxxoISpy+aqp
	JXSCbd0B62YKHl4ZKnl6poxRdoZ1bDhDwb5wRNM+FglB+DAOjo8IsFtA5QBebZyqnrEAhr3ptyoB5
	Vnb0itbnGWrSXJfmS6pVp4uhwzqFkq0f3YtsTxrQr8WAVjDhAWppzQFxJSjoMZS4vqZOzgcGYMFd6
	YMjSfXVPamwd8y7cadAAXs+HS6maLH10DobUKbZ/ujmG1Xl6QPFhi1h9V3tWzOm1pnyL4+JbQ743j
	JajWBlAeEbjtLYjFPKmo707DnxVf4KO1H0u0OBtFa66/oPWNaedl0t8tepFr6VlMm250lquxMDxMh
	XZ/P4TWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAE8q-005OEh-2X;
	Mon, 04 Dec 2023 18:58:04 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAE8m-005OBh-2M
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 18:58:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 37B20B811A3;
	Mon,  4 Dec 2023 18:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC67C433C7;
	Mon,  4 Dec 2023 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701716278;
	bh=aPVj9XXl+eRYnePRnmQ+vWxwVHPDe57ND1UdEZVfc00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Br4L24tPwBBeQzb7SaBAjh5gs52tLThxz5a9xZZf3Ih+92YiX6JVVf2u55xvtfDt5
	 CtOWxn08iOEd2/lIMP5A5NEf5bn0S5YMqmmLN0P90rOkkeZITdqRINxGI4vAYnW4Zq
	 7A2CVx0syvQH8uuc6wBJFMzPc2KI6udtjMiRqb8Wp0LWorMlx53vfAzD5M7PRXiFkJ
	 /d0NEHAD+ZANV+j3CUwESxkzhAa6YxibLNUA9PZLPThYBV4v9iWeVLQguYZWNrGnOR
	 88Nk+4GtrS2cBbqr2zRl/fCaWLOJv/f3ZbtWrLfU7GhlTtyfqtfZgyTfeJSDLQ4fmT
	 QObQoZRZMZweg==
Date: Mon, 4 Dec 2023 11:57:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, asml.silence@gmail.com,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW4hM0H6pjbCpIg9@kbusch-mbp>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49zfypstdx.fsf@segfault.usersys.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_105800_912727_FC3DE852 
X-CRM114-Status: GOOD (  18.64  )
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

On Mon, Dec 04, 2023 at 01:40:58PM -0500, Jeff Moyer wrote:
> I added a CC: linux-security-module@vger
> Keith Busch <kbusch@meta.com> writes:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > The uring_cmd operation is often used for privileged actions, so drivers
> > subscribing to this interface check capable() for each command. The
> > capable() function is not fast path friendly for many kernel configs,
> > and this can really harm performance. Stash the capable sys admin
> > attribute in the io_uring context and set a new issue_flag for the
> > uring_cmd interface.
> 
> I have a few questions.  What privileged actions are performance
> sensitive? I would hope that anything requiring privileges would not
> be in a fast path (but clearly that's not the case).

Protocol specifics that don't have a generic equivalent. For example,
NVMe FDP is reachable only through the uring_cmd and ioctl interfaces,
but you use it like normal reads and writes so has to be as fast as the
generic interfaces.

The same interfaces can be abused, so access needs to be restricted.

> What performance benefits did you measure with this patch set in place
> (and on what workloads)? 

Quite a bit. Here's a random read high-depth workload on a single
device test:

Before: 970k IOPs
After: 1750k IOPs

> What happens when a ring fd is passed to another process?
> 
> Finally, as Jens mentioned, I would expect dropping priviliges to, you
> know, drop privileges.  I don't think a commit message is going to be
> enough documentation for a change like this.

Yeah, point taken.

