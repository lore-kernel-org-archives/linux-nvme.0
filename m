Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8E8C53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FI6V0jJ8bPkXU47+DlmtFRU4ioIpKssIZvmexWj72wk=; b=bv/ulaG3Gw44XkyPBkrp1kmnrM
	jatNqlr44NjCFJuyaE3O9EDbA0h5T8L659k1vsf2QfVP2i7uD5fREvmsNde2GKyCvTf0Vy884yMWh
	zOy5Nx32WPjaJwfB1+J0g/HzS7+dWYL0OZGRtz4GyCYpEsTLxPpn8adDZ9/m00jM3YMYEEdcQLrWz
	1KKFVrLUC/MSIkYiI9O2W68PByBGKhZwpUA2si3G4J3H19osFz0rGrPNZ0OcNFSRKO0jd8A2BleVe
	sTpzBjoApzP7rK4lFfox6dqbht05mhuA4pkyEjihLL2SCZHK0hG8F62eQRZstUWRQY1Vqh0TXh4LV
	k7PeK62Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wof8y-00000004yPH-3ROA;
	Tue, 28 Jul 2026 10:34:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wof8w-00000004yOz-2GHR
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 10:34:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E4AE60A9B;
	Tue, 28 Jul 2026 10:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04541F00A3A;
	Tue, 28 Jul 2026 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785234877;
	bh=FI6V0jJ8bPkXU47+DlmtFRU4ioIpKssIZvmexWj72wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rO6E1lGGEtE0+Kon+Wl8fYx77twie7WQkferpRqgLDR4W6ZA/UOvuQKiXGuk62Crr
	 nCcsscvxYSIOsJJhySae9bs4jCjvsgh+22ZgPT5E+BaFxXsYTdCtBLWLhvbwFTVIXI
	 nKzCgWFr9aB9cjizjncMnDBJsgaIK27ptfXP50oM=
Date: Tue, 28 Jul 2026 12:34:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <2026072833-anguished-grout-9533@gregkh>
References: <20260725135111.14041-1-harimishal1@gmail.com>
 <20260725135111.14041-3-harimishal1@gmail.com>
 <amdqKEI44SKwq-K2@kbusch-mbp>
 <2026072748-unpopular-onlooker-4a2b@gregkh>
 <amfg_OFiyDadWb3v@kbusch-mbp>
 <2026072849-uproar-aqua-07c3@gregkh>
 <20260728051838.GA20593@lst.de>
 <2026072834-buffoon-entwine-ed16@gregkh>
 <amh6ivxaXV9lO_6r@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amh6ivxaXV9lO_6r@kbusch-mbp>
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

On Tue, Jul 28, 2026 at 03:46:50AM -0600, Keith Busch wrote:
> On Tue, Jul 28, 2026 at 08:58:00AM +0200, Greg Kroah-Hartman wrote:
> > I'm tired of it too, but again, if this can be hit by something a user
> > does, it ends up being a DoS on the machine :(
> 
> Why do you think has something to do with what a user does? The
> filesystem and block layers own the write stream, and the contract is it
> has to be within the reported limits. If it's not, there's a filesystem
> bug; nothing to do with the user.

I don't think this specific issue is something that a user can trigger,
as I really don't know how this code path works.  I was making the
larger statement of "If a user can hit a WARN_ON() kernel call, then it
should be fixed to properly handle that logic."

thanks,

greg k-h

