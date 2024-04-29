Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1AC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pu5iSzAe8tfRujWiTCluM5Xl9zjhhsTk/hEfFkCepJA=; b=BPrDp+zJ5aks2kJVV5cxo7VFCi
	kddr8aqOjQTHQfOFhSItCGY1xe+9Nj1+Ufn0fTZeEUCzbI3uz9eCFOCaAxO8s4LNxw00TY3oH/JBP
	Fw9puS0jAdrsyt0IdkYsgloX5b6pmR4UbF7T69upnu/Jh1HF26XWMqzE9cRw9qFVZ0yNqUzjizVmb
	U2SKx1Wwd9kiJwaRexcY1JqHR5U3deYhJECrG3wtpjWLw6bRxi82tKMo58usBAcPBdpVn0Oj5Awfl
	LoIlPCFvBHjD90CZ7PsGfgq/YcVL5+XZYEVhma2pQ4qJpAs5s90lEYjDlypL+0sHU0QDDZqtPpsR4
	hn72GzKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1QcI-00000002oqW-2465;
	Mon, 29 Apr 2024 13:00:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PYf-00000002XIc-2SwS
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 11:52:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 011ECCE0B37;
	Mon, 29 Apr 2024 11:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BB3C113CD;
	Mon, 29 Apr 2024 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714391550;
	bh=2eXDb1FP/V4/syx3UpD2itU7SPeytqAeO6esZnmilQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhZQgl/hQj69NYQcMJiXXsrJprJZBlCAfTitOcw45JaZFu+fPw4txHu0Up8NQ4MEu
	 mVBoaJ1E0n1oSH4El3DNydXhDUGzJMFYAhJ4BnTgZqfVr2fAI3oAZlXsH1OYFPBnxs
	 3HTMbPwwRV+/GedXH3la2rxK5A/Sw6oq64uxD4ParvVeaV3EDLBQGBwaUTTk7Mn+e1
	 llyJHH5sUKhxNBBrPLUdEoNblKFstsKLIzgpzKgFBEbHAC5COd3cdeHfRPMNjxiAO8
	 fFJKSCpihEs/f4sSUEGnselRdQeuXtPUx0Rk0A+QWhvjtetAb/c5xI5X4YIwH1MSi4
	 Xy5ocxnu1PBYg==
Date: Mon, 29 Apr 2024 12:52:26 +0100
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	jirong.feng@easystack.cn
Subject: Re: [PATCH] nvmet: fix nvme status code when namespace is disabled
Message-ID: <Zi-J-hOrAhu5F-FK@kbusch-mbp.mynextlight.net>
References: <20240428092540.77366-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428092540.77366-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_045233_966975_15C9D14C 
X-CRM114-Status: GOOD (  14.02  )
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

On Sun, Apr 28, 2024 at 12:25:40PM +0300, Sagi Grimberg wrote:
> If the user disabled a nvmet namesapce, it is removed from
> the subsystem namespaces list. When nvmet processes a command
> directed to an nsid that was disabled, it cannot differentiate
> between a nsid that is disabled vs. a non-existent namespace,
> and resorts to return NVME_SC_INVALID_NS with the dnr bit set.
> 
> This translates to a non-retryable status for the host, which
> translates to a user error. We should expect disabled namespaces
> to not cause an I/O error in a multipath environment.
> 
> Address this by searching a configfs item for the namespace nvmet
> failed to find, and if we found one, conclude that the namespace
> is disabled (perhaps temporarily). Return NVME_SC_INTERNAL_PATH_ERROR
> in this case and keep DNR bit cleared.
> 
> Reported-by: Jirong Feng <jirong.feng@easystack.cn>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Applied with Jirong's "Tested-by" and Christoph's suggestions (spelling,
word wrap, and unnecessary 'else') to nvme-6.9.

