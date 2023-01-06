Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC0AC54EBD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYMhyarsBRQ+VETwFMkHokLlxNy1sqp/XfO6ldjLdJ8=; b=ceAsntuYv/IZGyMyLmOrZPRvmg
	fekAc+O+e85w2gv61AFQO7u5ne8JtM+cZtj3p2nreuA35nhOdkskEGXOxz5NVyfZOSF3x+ug4wU7W
	nXuqGTCovmoiWT/6WvKDureIbxjMgEgWvcopCviDAseZi+ye2NaQurda0EDDL94BYqi+lYkYQ5v0z
	bzBjAhYLpZNO4vHTtfte8fJlYMWlSZ5GYvpafl3imu4IQm8B1JkzLvqV6/jbT5pcMsdWgXcEVLHLU
	6H4VdobK4VCC0GRvvz8MtYO8QKj8VQIyhCAqPHjcvVPU2q4ulZjX6y2Kl8Tdp6l3ZLShicbMce99Z
	aAPPeKNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDsfy-00EeG1-7D; Fri, 06 Jan 2023 19:46:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDsfv-00EeF6-2W
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 19:46:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DB48C61E00;
	Fri,  6 Jan 2023 19:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172C3C433D2;
	Fri,  6 Jan 2023 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673034405;
	bh=RC+7jNFfz356TGtdHHoxbg8HQDc+gy6Ocwp4kB4SOc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sP6VlBaf5AufaxGdLcOAq0OnL/jfhJ+H34TavKWv+B+MxWxV1TAsp1GwcwOG8X7Zj
	 R/h8WqJLI0KuQvP/cxxbvJBbh4oXAnbTYmgBoHzzxtgGcqgWpvD8521HAIBkSlAXqE
	 ggpwI1qP1rXgM6qO+hJgN220/ha7RCkc5u/KwPzK512HpToOEI7YWVvFXaZe3VW063
	 XtK5adj2+BJNSUB8LCKmsDBGicbFmu9F3+rbSqSS6iTKrn/+fIxUN7FdFmswvTQk8+
	 iRGj0XylP7yzJkdYwYQgFqzZ+3LUK+wDUBNftbp52BZI6kP/04n9ZHO3GVP/qwLYBu
	 9eneQgTzjsatQ==
Date: Fri, 6 Jan 2023 12:46:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nick Neumann <nick@pcpartpicker.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: trying to gain understanding on BLKRRPART and "failed to re-read
 partition table" error
Message-ID: <Y7h6okidN679ZtPh@kbusch-mbp.dhcp.thefacebook.com>
References: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_114647_191201_F505CFC1 
X-CRM114-Status: GOOD (  25.54  )
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

On Mon, Jan 02, 2023 at 04:52:28PM -0600, Nick Neumann wrote:
> I've been using nvme-cli 1.9 (default on ubuntu 18.04 LTS) for several
> months formatting nvme drives repeatedly without issue before running
> device-level benchmarks with fio. I always format passing in the block
> device, e.g., /dev/nvme0n1, and haven't had any issues.
> 
> I recently started playing with creating file systems on the drives to
> do file-based benchmarking. After doing this, I've noticed that
> intermittently the format on a drive that has had partitions,
> filesystem, and files created will fail with code ECOMM on the
> re-reading of the partition table. However, I've struggled to make the
> failure happen reliably. This is the error I'm talking about:
> 
> https://github.com/linux-nvme/nvme-cli/blob/c3db2bfda5346f68344a9e6d795319a7bf35d19e/nvme.c#L5212
> 
> The current nvme code has multiple guards on running the problematic
> BLKRRPART, and one of them, "cfg.lbaf != prev_lbaf", is enough that
> current nvme-cli would not run the BLKRRPART for my nvme formats.
> 
> But I'm hoping to understand if these guards are actually fixing the
> issue I'm hitting in 1.9, or would just mask my issue... that is,
> upgrading to current nvme-cli would make the error go away, but it
> seems possible that changes to how I format cause BLKRRPART to run
> would bring it back). Are the added protections for the block device
> format case to avoid issues like the one I am hitting? Or is it
> unusual that I'm seeing such an error?
> 
> In case it helps, the system does not have the drive or namespace
> mounted in any way, and the format is being issued immediately after
> the system is resuming from a suspend. Happy to provide any more
> details that might help.

There really is no need for user space to do the BLKRRPART ioctl
anymore. The kernel takes care of the rescan automatically, so unless
you've a really old kernel, we might be better off just removing the
ioctl.

