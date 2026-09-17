Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED87C982D2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7n9MNnLdK0bnfiNwW7b+9t6GurTfyrZvkZ7MrEPxSY=; b=c1CNr1Cvy8bzhS5e9DLFpSvrpv
	+TYvMN+3VzbiUImA5yt4khzB3Zc6/PlIi8f6gR6O+yHHEOu99UQg1uBBzxW8d4FeTGQZH13wkLvKa
	3ixb7/7wpJ98NmJQBEMtETA9dh8oJKIMREqM+mn8WO9vZ5udFWwdmHbN5PaKBdeKneplKKc+Bjm9G
	3Ol773yX5jhlP2YBDn08BsVwp1f1YBBGj4eQdiKnuIkgin/DHNE3/pXF1rcD2Zoy68YWaeHK7AUi7
	xfdu4WQpDRigAP1vNooRAMQmNlo68O2BN9lv/zyT2V7sp/9SMJiv7sBk+5x+P65UjlKxun/cC2c24
	p1YU/DLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7I5f-0000000CMjv-0O5n;
	Thu, 17 Sep 2026 19:48:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7I5a-0000000CMji-1ghw
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 19:48:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73DBF60232;
	Thu, 17 Sep 2026 19:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE931F000FF;
	Thu, 17 Sep 2026 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674489;
	bh=W7n9MNnLdK0bnfiNwW7b+9t6GurTfyrZvkZ7MrEPxSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UAV6mc5zf6bBk4LctH/7koxWui/qea9pfk55rmTwnThTTKdbELBmE3km2Pvjss7J1
	 oPltpK6rQLIKo1fLugTZ5uFyu4baTLcuCgNYj4j3nyfri09guj3iYyedExpANAOpGA
	 BiUBN7pTbSXvsmBoRgWmiT7N1DkWBxY6wNmjbA8AdSVO4hK5f3YouLHDg71RGshgOg
	 9sXC2uaCvckGr/89kdbEnfMK53/yo2l2AgGa9kwshZ913CpsV0M7anvJ42muvcf4aA
	 Z7zD7UlSKdL24n0bV/3o1b6e1xgRGBLBxq9yb7F7kvkW9p3Qrc6vzM1Rj4+pXRa3Ra
	 zpf9bIQrnDxvw==
Date: Thu, 17 Sep 2026 13:48:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, mlombard@arkamax.eu, hch@lst.de,
	hare@suse.de, dwagner@suse.de
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
Message-ID: <aqxD9livO4SaNKvR@kbusch-mbp>
References: <20260915095827.698928-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915095827.698928-1-mlombard@redhat.com>
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

On Tue, Sep 15, 2026 at 11:58:27AM +0200, Maurizio Lombardi wrote:
> During NVMe controller creation, the controller is exposed to sysfs via
> nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
> This creates a narrow race window where a userspace process can write to
> the reset_controller sysfs node before the initialization thread
> transitions the state to NVME_CTRL_CONNECTING.
> 
> If a reset is triggered during this window, the state machine allows the
> transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset work
> is queued. However, the original creation thread continues its execution,
> subsequently moving the state to NVME_CTRL_CONNECTING and finally to
> NVME_CTRL_LIVE.
> 
> When the delayed reset work finally executes, it attempts to tear down
> the controller and transition the state to NVME_CTRL_CONNECTING. Because
> the state is now NVME_CTRL_LIVE, this transition fails, triggering a
> WARN_ON in the reset work.
> 
> Fix this by removing NVME_CTRL_NEW from the allowed prior states for
> the NVME_CTRL_RESETTING transition.

Thanks, applied to nvme-7.3.

