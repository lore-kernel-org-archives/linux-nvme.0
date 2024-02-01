Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B89C47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 01:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7uzPKXvpINXEjjHWrPnGCSGR3BBWk5ExsUKDZXdkRIo=; b=F1Tcp5+L+MNjcspemoU587edbb
	yBYZ+XmN5rvkAPkWJiCDJ0xrofo0CdL00ttS0+rKPMilbPdA2ch6ImTZf7kctqi0Mlcdq5l8wuSM9
	Y5jNSkm2LoYo6K2+jLB31gQAlyArg4nZHYum54iCO+9fmeYHnr+f1oVgmn3M5bDhioFwEF/LCzbip
	I7/XCtp5F0mewQy0bWWQabkw6Zlz+6uVGM6BX+RJoxxGrcstz8mi2GfW/Kd0Ba3C7N9UJGj7jIlGa
	AU5QQfYpx4c0/62LyckS8hQ2gGuy/9U20c6MjsW7dEJqOumibeZJyJBMrl8LllEyq9+agH5D/cLA7
	pKjlURhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVLaA-00000006A7N-0RLm;
	Thu, 01 Feb 2024 01:09:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVLa7-00000006A5Y-0aKh
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 01:09:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE65461B11;
	Thu,  1 Feb 2024 01:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10042C433F1;
	Thu,  1 Feb 2024 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706749769;
	bh=JQNTFJVRr5bZ6bOX/DRNW551t8GEdXicm8y2FFQtH5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haqwqWVar1zrVQabGf5q0ASaRJ4MwIhylg3U6qEgThlTTMjxRcGMY3M92Fm5e6rBA
	 N4/aLDb77VRx0P169LDY4JdmnLzeaQgxQ33gEz4FI5obXUnT5SYw92hGxsIpCXs9EV
	 baJOOIN1W/lGiU6i8ACLcZQvgj+tEOxFGfICxNvnxgpR9ASU1tpAxPFh1EKRXvwRoP
	 JPRo3nQESoMY1Ke9k7GKmCKv4SWu1x30DAbfoSHJ/rhL2q8aZuzYL3aFaHoZsUdYGB
	 8/oHsVjktmYtVYtDsebV1kTsJJiMV5xflu9I6xGtknnArzz+UHJRrWaSdD/6WnoRia
	 4oV0cTBR1aB9g==
Date: Wed, 31 Jan 2024 18:09:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH V9 1/1] nvme: allow passthru cmd error logging
Message-ID: <ZbrvRpfhzyM84Qrp@kbusch-mbp.dhcp.thefacebook.com>
References: <20240130001938.1103354-1-alan.adamson@oracle.com>
 <20240130001938.1103354-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130001938.1103354-2-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_170931_249141_08FCE863 
X-CRM114-Status: GOOD (  10.03  )
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

On Mon, Jan 29, 2024 at 04:19:38PM -0800, Alan Adamson wrote:
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
> disabled error logging for user passthrough commands.  This commit
> adds the ability to opt-in to passthrough admin error logging. IO
> commands initiated as passthrough will always be logged.
> 
> The logging output for passthrough commands (Admin and IO) has been
> changed to include CDWXX fields.
> 
> nvme0n1: Read(0x2), LBA Out of Range (sct 0x0 / sc 0x80) DNR cdw10=0x0 cdw11=0x1
>         cdw12=0x70000 cdw13=0x0 cdw14=0x0 cdw15=0x0
> 
> Add a helper function nvme_log_err_passthru() which allows us to log
> error for passthru commands by decoding cdw10-cdw15 values of nvme
> command.
> 
> Add a new sysfs attr passthru_err_log_enabled that allows user to conditionally
> enable passthrough command logging for either passthrough Admin commands sent to
> the controller or passthrough IO commands sent to a namespace.

Thanks, applied to nvme-6.8 with Chaitanya's suggestion folded in.

