Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA01C10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T096P/jea/v20EQLmzAQnOtNCLktAjXGBuowm+Xu4Gc=; b=h6gR+7Azmw5s6Z1EKE+jtD52Po
	D+0ENgITxeRg8KxqQUARwkrrDVHCxtE6E8TH5NfmBf3DkRckQIrbCN56/gglTophh3Igu6bls/0rh
	7yV0gCnnDYDeG97uxWMpXGkTcw9WF/6yE8yhyop1eyHQLI+3hxoCsqcPniJHXnjstyYagrwe8rHrS
	uwQurBqovTk3EhFE8lgtspffH+vXSYgTqifiG25a+smgWr2KgLiiv7fJarro7fM+fK3xAlYloJvoX
	jZ9rnLyqBBC0vyY7noKWgRi5tDIqu9sO9Obxj7RACP8jquyv/4NsnHy3Zi7BbA0knQZh44X90JG0o
	sfMopmiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAElI-005T8C-1a;
	Mon, 04 Dec 2023 19:37:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAElD-005T76-0h
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 19:37:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 68D1E61240;
	Mon,  4 Dec 2023 19:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70582C433C7;
	Mon,  4 Dec 2023 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701718662;
	bh=0B6qI7yaImDylh0YMgRVbhCUJKzhgt+Boa80ygB2x2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kxw+4Sa5aWZsRGjXXiOHaG8CDEWcJlA5x5hnxHIRWPRej0cwRs6208xvHr8NityLR
	 D2YPCyfYf3HvefW47SdvcmD5BSKOg6C/ltGeCDMJvEiK3N0Wdr95QzjjZn2SVQ4yZo
	 XnyB8Girl3wrr+wuOzERc2oVoM9PtUBJcpC6fja9bcXjNXhCCYaQ0t6DAtrWFyVxKv
	 biwGmCx6zcNSHB0JcW3IK3VxmOXYBgjBUTWTAhWbW0PnCSl5PZrtvhp404vXqWSPb4
	 BEYrnvI+Hi4pZdTD6rr4hBcRTxkjBV5wVNcJp3N3lPSNkC6NJjP5rY2ePXEflOqIJv
	 KdiE3phqDFmSw==
Date: Mon, 4 Dec 2023 12:37:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, asml.silence@gmail.com,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW4qggTr44dWT4ft@kbusch-mbp>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <9c1ee0ee-ccae-4013-83f4-92a2af7bdf42@kernel.dk>
 <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_113746_046310_3508E389 
X-CRM114-Status: GOOD (  13.79  )
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

On Mon, Dec 04, 2023 at 02:22:22PM -0500, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
> > On 12/4/23 11:40 AM, Jeff Moyer wrote:
> >> Finally, as Jens mentioned, I would expect dropping priviliges to, you
> >> know, drop privileges.  I don't think a commit message is going to be
> >> enough documentation for a change like this.
> >
> > Only thing I can think of here is to cache the state in
> > task->io_uring->something, and then ensure those are invalidated
> > whenever caps change.
> 
> I looked through the capable() code, and there is no way that I could
> find to be notified of changes.

Something like LSM_HOOK_INIT on 'capset', but needs to work without
CONFIG_SECURITY.

