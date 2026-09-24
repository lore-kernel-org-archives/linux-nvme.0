Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0C0C9830E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mth+udyl4shJuTkd6p94FaAdssxMiU2m/RJPfhfFqY=; b=uyftIJnlDi5bwML/Cw50iOS2QN
	DXMev0CwxoA63Np70qP7tvl0mlUYigBT2nsspHdfqANa+53fzAJWxyLepvmJ074LRCFYunxXto8o+
	6WZa8VT8zaB5HIIT9DZN2hpIxzUts8LMcjyWS+ozuL7IDg7Zd3yBVKUPW1N0cBtqtHK2pQZFv8VfS
	XBmsqgeevxwEIbTamwah/4PJlHAVYUhA3V92J2xlDETWwbQ76w/aAcXJV6uN/USbEhrvWGlbhZDDb
	CV9J1E4MvKabDgY7S66i0IfYW+b4netmzAZMJrvC5cJj1GSWq7n6c95ef2+FPJbRORkKDpoXlASub
	lybO3KjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9lcD-0000000BSy1-01hc;
	Thu, 24 Sep 2026 15:44:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9lc7-0000000BSxW-2Bjg
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 15:43:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B543F601DE;
	Thu, 24 Sep 2026 15:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3B01F000FF;
	Thu, 24 Sep 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264638;
	bh=3mth+udyl4shJuTkd6p94FaAdssxMiU2m/RJPfhfFqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uns0tLZ94/wZQNd9IxDW++FfeLwvvbl/fmfWaGlUaXDd5grtwvV55NLgTxiG7FIWu
	 iA0U2nPP4f4+LSQa9XXTIhDMMUsRbWur3PZVfXAMO28HdT3lTE4xPOugUd165Zems/
	 upYUjWSP2JkNKoi/YXdhAeQiLRnat4hqx9G9gmVHI/9RL1Iedn+uvUJIyCIidrwDxW
	 ScN4GUNyO+JQbIgH75xqH8XO+AZNu17ON+2RLYDqqKtFq9BHKqx7763/2B4rBo8/ym
	 kOZLcHssKDqM/1ADG5esDZKy0C+eZqFO3esE+iSCS3Kk9FXp+3ILaBsbu/xU6kXCc2
	 8dL1TGi5KQGiQ==
Date: Thu, 24 Sep 2026 09:43:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: hare@suse.de, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com, sjpark@crusoe.ai, saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Message-ID: <arVFPIKeT-HoYF2K@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai>
 <arRJLL4ki-sVQnHf@kbusch-mbp>
 <20260923225753.49224-1-kiyer@crusoe.ai>
 <arR3zlpx3Xm2mRt-@kbusch-mbp>
 <20260924063524.26807-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924063524.26807-1-kiyer@crusoe.ai>
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

On Wed, Sep 23, 2026 at 11:35:24PM -0700, Krishna Iyer wrote:
> Yes, exactly. Some namespaces should keep waiting out the reconnect
> while others should stop waiting and fail their parked I/O, decided
> by a condition only userspace can see. Here that condition is a
> killed process stuck in D state on parked I/O that nothing will ever
> consume (for us a SIGKILLed VM the host must reap), and it could be
> any consumer known to be gone. Failing that namespace lets the
> process exit, while namespaces with live users behind the same
> controllers keep queueing and carry on when paths return. A
> controller wide timeout cannot separate the two, and there is no
> duration to pick up front since the trigger is userspace observing
> the event. Reconnect itself is untouched either way. So the kernel
> provides the per namespace switch and the decision stays in
> userspace.

Okay, I see. Pehaps instead of having one controller export all the
namespaces, why not configure your target to have multiple subsystems
the client makes independent connections to for each namespace?

