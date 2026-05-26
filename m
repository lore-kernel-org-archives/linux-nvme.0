Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B68CD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZF0Xuto6uiUSOPIHK+KkXFZeKq6Z9bOcLYd9Gbj9YVc=; b=XoDGNyZeB1yUNzIc+MJ0WRN07Q
	3xwf9+meTCiAkAz4LavgaZZdmOZz2hWEJLUl8m307Qcqi360pL97QNqg/PIO+nAgRTjCDDaLpfb3M
	6MaZDDDhrRaFKWqmLpCejfA4zVlFf6DLe7keEntql/mFVQv7syN3OuYCuHVLSMRjQP/K5M7QiBnAG
	6/MQr1CQzNZ1FOrDzwLb8G6zLvTCf2APsdnbzpMamzBOTyxn4EYU4GUEXFaXgl+M5BUDrdXzVdCgT
	5xHK7rD7I65a7M+ZWO+8vD5Kgm5DtabyzYqOW3qjEossk5ki5e+r1AQcOtwnFCMu4Plv3jgRXgTQg
	JWYPRKog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRs7g-000000025wl-2Y99;
	Tue, 26 May 2026 13:47:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRs7f-000000025wa-1Asd
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 13:47:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9795B60534;
	Tue, 26 May 2026 13:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BBB1F000E9;
	Tue, 26 May 2026 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803226;
	bh=ZF0Xuto6uiUSOPIHK+KkXFZeKq6Z9bOcLYd9Gbj9YVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PFh9vQp0/XvryC3QbV8OO3Ik7ZnQX+3xovWrbvJmIF6bJ2/enMqb1rwBraHHMUryN
	 vsnZtnAc9ws2/Psww6OBYv4a6rAL6gFWDpwmdycviBpcjZ5jN96QAiIiIKAOKtQoF3
	 EfgjWZMH2gTwQgg5XSPy0pI/TF3lrtRMJeMJlc6wFQ+Sclk6CONgMdqU2mXqXvY5Nk
	 HTr76jXuRgEvQP5i++cLXJd6aFIuXkbMpPMow0rYFFxqM9FhomsxNA0SA7Mdtyx27r
	 C+sDcM06OBCc7ZwsRe+wfSn5E+FCoY88d97lKy+dcsjth5adFUP7OQu1GnRzrmFJ6y
	 uuZrY/kqggsJg==
Date: Tue, 26 May 2026 07:47:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Bommarito <michael.bommarito@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: log when APST skips a state due to latency cap
Message-ID: <ahWkWI5yvuFj232G@kbusch-mbp>
References: <20260523114552.101452-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523114552.101452-1-michael.bommarito@gmail.com>
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

On Sat, May 23, 2026 at 07:45:52AM -0400, Mike Bommarito wrote:
> Add a dev_info_once() at the skip site that names the state, prints
> the actual exit_lat versus the current cap, and points the user at
> the module parameter to raise it.  Using _once keeps the line to a
> single instance per controller; users that want to see every probe
> event can still enable dev_dbg.

The "_once" is not actually once for each controller; it's just once.
Some people have found other similar debug prints to be confusing when
they have multiple controllers since it looks like the seemingly
problematic controller is not consistent across reboots.

