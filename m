Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107E8CD37BE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdwOQmwVk8k0vIS/u8Fkhog+WBWDMI7nmG2GdTDNweE=; b=Xt3qFgSMkoWfykm33gewhnHjAv
	kKBeczS92bB0W4GvpBp5+eY4LL5J+pdbZIvOUTpGre2FaMX7kcsl2Cp/WaL7Lhw5gMWPRPwMLmjMz
	HK6uYeARAxSKnAMGbcF0trzpF+rDDjtq5U+TjVGducze6aXDYsyac+Bwt6bDlZ9qsBV6vk99kEUcA
	JYuB262daPvKGEfv0wqesNmr8zj1hTD8URGVPbUws5trpmbROzv5YkHsC70FAANwaRS+jJgIKus4h
	H7TerLxwq1yUx7LzH/KfbSBV7YWP11acy4XoLHG3+ZrpTPWhtQtJU21oHgdH3WOsISQzzJpnrx6So
	ZFacoXWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMSGB-0000000E0rp-3pQU;
	Mon, 11 May 2026 15:09:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMSGA-0000000E0rR-0GZc
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 15:09:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 286956001A;
	Mon, 11 May 2026 15:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4835FC2BCB0;
	Mon, 11 May 2026 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778512168;
	bh=GJAWYiJlAcHkeIeDdONBvKlMKoSgGLoz6YiGZuP1hok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6K5fsHZnNkgSCgA8frn8wyRWv0J77Q/PqKmE5PC3kT9DVfBdKbahpKzF04H9C50h
	 PCy2J/QGYhLBQu1kRKuXr6Xg8bCIx6+cgzHTexW9r8nrDDkdnjtPwoAS7b8zw9X/ay
	 3QlAojSpF7Aih4Jlihy6SLrOHBjis/b2OibX7a1r32Wk7jSYyzQuf5EuAR4CwdxLXg
	 27W2eKHBx+ENzRHBN+JC06CGRsTnNxzd8TTU7T7KSXZo4mw3hAHmIas0OOVML5ipN3
	 VDoGWm1hT3hHDJE4oVYihMTH1vWV5L3mlie53MvkAZg45mNEuDxszx0KienDWWzQn4
	 2jWz9VwgkeMRQ==
Date: Mon, 11 May 2026 09:09:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected uevent
 and STARTED_ONCE flag
Message-ID: <agHxJrEzw08glN1x@kbusch-mbp>
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
 <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
 <20260511080746.GC29677@lst.de>
 <8074044d-291b-4ac4-acda-f27e94f3243b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8074044d-291b-4ac4-acda-f27e94f3243b@grimberg.me>
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

On Mon, May 11, 2026 at 03:54:04PM +0300, Sagi Grimberg wrote:
> 
> > On Mon, May 11, 2026 at 01:10:34AM +0300, Sagi Grimberg wrote:
> > > This should even go as a separate patch:
> > You mean a stadalone fix?  Because it already is a separate patch.
> 
> Yes, this is a race condition fix that can go separately.

Sure thing, I've applied patch 3/9 to nvme-7.1 as a separate bug fix.

