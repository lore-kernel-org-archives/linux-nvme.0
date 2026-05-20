Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DB3CD4F3D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CiazzLAxOO8pAmSI9/Ylx3CGiVTeqce81qz0PZYcXi8=; b=bmSC+bj3M7/YLqndaEaMEdoh6X
	LJQR1a3lKF/YaUs783M+Nfj8QY0e5XrzUmOAo3S6cUAduQpBUyYLW6hziuJpkI4EIgHBN63KVYnco
	5yFwjwEuD0BHimEt0XqtGIn5nOA6Pc/e/WcJSIaDBoxeLQxUyFg07OJVVLA0ggoi85p9FTgI3CU/G
	E2Ug+t6+Lbm8/w3u4QaHjgwbT2sT3pY46vuBcFtJZJGp1AVlXVLDul2YFfRQ3ZKAr+znPQfZZjo6p
	JEvneGOJriBkO4qYSiq5OutEekHmjwgrqSZ4tNgvPPHRfAbLNrUj9DqWPWu6iPafQ9XEawSxtb6e6
	u5dThlLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPmVN-00000005aiy-3T49;
	Wed, 20 May 2026 19:22:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPmVM-00000005aib-0tl1
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 19:22:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BF0A60202;
	Wed, 20 May 2026 19:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ACC1F000E9;
	Wed, 20 May 2026 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779304975;
	bh=CiazzLAxOO8pAmSI9/Ylx3CGiVTeqce81qz0PZYcXi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frWJACXwi2vDR6cM6DtgBvuWwGP5iWT4YBB7RNjXAWgyO2bsYmPrNUkg709vm5jEe
	 FplP2XL8wh/v5Fz70oQHBm4VD055371+/fIIqcsfK92Elkqb6uT26N8O0mnLXJkEUl
	 GiedW0YpxyO21UaqWS7VYRJSWhOzenXUYxoibOxVRN+FIqAWeaYZ7zqzkRWCBDsdCt
	 L7wH5XEFSbvoSurl9i3uSBElUYUqnGs/6L63Afcu2T3muf66XVEwk2cT3n99dpaBxI
	 4texWQpztrflwmoT1/nmxUWGCJVAa9XtziBh71EgDBa8if5PPoN58/yR/nvIbYUTEs
	 Fg+OUT+hl/AZg==
Date: Wed, 20 May 2026 13:22:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V5 0/7] nvme: Refactor and expose per-controller timeout
 configuration
Message-ID: <ag4KDI5o8tfM7YgY@kbusch-mbp>
References: <20260514083255.41109-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514083255.41109-1-mlombard@redhat.com>
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

On Thu, May 14, 2026 at 10:32:48AM +0200, Maurizio Lombardi wrote:
> This patchset tries to address some limitations in how the NVMe driver handles
> command timeouts.
> Currently, the driver relies heavily on global module parameters
> (NVME_IO_TIMEOUT and NVME_ADMIN_TIMEOUT), making it difficult for users to
> tune timeouts for specific controllers that may have very different
> characteristics. Also, in some cases, manual changes to sysfs timeout values
> are ignored by the driver logic.

Thanks, applied to newly created branch, nvme-7.2.

