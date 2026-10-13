Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408F7CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GV3/2pwMIoMbwD/i8kgVO4kcDg6oal1jEHBE+1WtdcI=; b=mF8X0UnNL2LqCKMKGIwDPw5a+m
	Snu+AOb4h2Rs6HfVpmeRGUOwkS5il7FE/zgMSGK+4ZEEtLOJcKEpSJLXWDMWkuldpLT9nKUxGmW9w
	aT1M12Y5FUJo93SYvJoCJYeFvyTUL92YhmE12Darq2a3Gz39E/dQ5ELkgpoVaHpfJcTuu7hmwPnAR
	ggcmHphG4YXKLfMAo2afKuzHMnqSjsTFgABmDt1FrGEKPBxdeOBlBw81tgZ0aE2FtuxyBIctukcPv
	29CcUqcEo7EkMCt00KEVZssYVWzaK+1+KqJG/jYVZEhmbeRScqtT5gl0cPzyPd65Apb6LMBcBUgcF
	eeSx+A3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeeS-0000000DOUn-3byw;
	Tue, 13 Oct 2026 15:42:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeeQ-0000000DOTG-2Xql
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:42:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 07E4360A5E;
	Tue, 13 Oct 2026 15:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318D91F000FF;
	Tue, 13 Oct 2026 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906169;
	bh=GV3/2pwMIoMbwD/i8kgVO4kcDg6oal1jEHBE+1WtdcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPTg0/SKFoCLSUtdRlvaXBWnQYZlMPKvxmObOtG3V36ZTxgCZpIlJGNJGQn4DwUrM
	 KHSShqwOp9l61ErqpuUZkg693PJmCyIBoJRLqfHMk8js4FNqM2+F+eMj2PsWPUY9O7
	 jzNiDuL7WWm7O08luPowsqt87qWgv6yAJVF0ztOKAFZp7gzjoCRp5Ce+xSKAh3Mpcx
	 8TB7c4NQbAf4jXwQ98sFF+Ifui0cE+lUxEdnEF6INixtHwNeLr5tJY+OtqgR7DY74l
	 /MA2SvwxdChwUauZWv3BhMFd48STi8d5KPYiz+QiGhCLYNj7WfZf6Rn7FqcyUZdRdf
	 1eZ+dw+452WeA==
Date: Tue, 13 Oct 2026 09:42:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+da94a51633758d13bd63@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet-fc: don't drop the last assoc reference in
 nvmet_fc_delete_ctrl()
Message-ID: <as5Rd6jGQNtJpW0C@kbusch-mbp>
References: <20261008191848.47066-1-raghunathpalla.0209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008191848.47066-1-raghunathpalla.0209@gmail.com>
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

On Thu, Oct 08, 2026 at 08:18:48PM +0100, Palla Raghunath wrote:
> syzbot hit a recursive locking report on subsys->lock when a subsystem
> is unlinked from an FC port.
> 
> nvmet_port_del_ctrls() holds subsys->lock while it calls ->delete_ctrl()
> for each controller. nvmet_fc_delete_ctrl() grabs a reference on the
> association, queues del_work and then drops the reference. If del_work
> gets to run to completion before that put, ours is the last reference.
> Freeing the assoc tears down the queues, the last nvmet_cq_put() drops
> the last ctrl reference, and nvmet_ctrl_free() goes for subsys->lock
> again:

Thanks, applied to nvme-7.4.

