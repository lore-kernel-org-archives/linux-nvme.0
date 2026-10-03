Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C0DCA5FDD
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 08:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucSAknIQTWd2n41lQDBKm04Nx/vRSVBG0KgZQDAP9/Q=; b=QFM0a0ex9604WLfeyhCq66Qq6a
	ZLIaIXGusgkT042jLn2pX8EjlIv+sWVVdm6XDmQ/hNG3c3jtozitxfW3XdWnMk/HlgdcC+P5ixJL9
	KQ0t8MQ77FpZ8V83IG8Axrg7d2I0Qcxwic2QrJ3vkRsPF6Q7zN+QAsvnFS2j3rR3XP257WtQ2LiaD
	lk7+66E+pzj6TJs+ofpDvFBB1y18xjcRptShlKl/5lrIdD6ExGhAcIOwHV/oQEKfwMBEX9oKXK3x4
	R77vJ+1dMxMnaWTCnKKLTi1Ue+k1owcKkvBBbwCdh8dd8i0hxUSR1hzShdbqxLn9gEdflHcNMlysB
	aKc/xEtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvW2-0000000DDcA-2Dxa;
	Sat, 03 Oct 2026 08:54:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvW1-0000000DDc4-0xuV
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 08:54:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A1A3D40A91;
	Sat,  3 Oct 2026 08:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366411F0089C;
	Sat,  3 Oct 2026 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017684;
	bh=ucSAknIQTWd2n41lQDBKm04Nx/vRSVBG0KgZQDAP9/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJj8lUQVZVgNLj8NqHsa8571jRvFgOzqZybfDlzI517C2xmYETQCADlf4vPVWuYyF
	 fn+ieXoclVHBFzqtS3z5DkAdb+guyyRr2RvF25aPhr2UDEF7irihs4ki5SDKeXVM+5
	 +koZHgHogIijApulUH407abpAY1vyOUJEcwnlX04sTOGk/cHIjVE8XFjU0F1Cbh7FH
	 ivH12X0XoIVkE5g7V+h2GgXAUfLOngg6RnYBkZTCDE0rKfqkUdtDV0ZA1Yuw8EG3Ir
	 c8rGnNu2GyxSMIWOtsPkS3imojFDBfDlVIdI5ss6mb5WqYzPHKMtRxLDJ/EDqWv8I0
	 Q1V2+QM0q39rQ==
Date: Sat, 3 Oct 2026 09:54:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/2] nvmet: fix FID 82h status codes for invalid NSIDs
Message-ID: <asDCzjTCApNDwS8R@kbusch-mbp>
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920033500.3209138-1-kanie@linux.alibaba.com>
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

On Sun, Sep 20, 2026 at 11:34:58AM +0800, Guixin Liu wrote:
> The Reservation Notification Mask feature (FID 82h) defines its own
> status code for NSIDs that do not name a namespace supporting
> reservations:
> 
>   "A Get Features command that uses a namespace ID of FFFFFFFFh
>   shall be aborted with status code of Invalid Field in Command. [...]
>   If a Set Features command or a Get Features command attempts to
>   access the Reservation Notification Mask on a namespace that does
>   not support reservations or is invalid, then that command is
>   aborted with status code of Invalid Field in Command."
> 
>   -- NVMe Base Specification, section 5.2.26.1.33
> 
> nvmet routes the namespace lookup of both handlers through
> nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
> unknown NSID.  That is the correct status for the generic
> namespace-scoped admin commands, but not for this feature.  A Set
> Features 82h naming a nonexistent NSID, a Get Features 82h naming a
> nonexistent NSID, and a Get Features 82h using the broadcast NSID are
> all aborted with Invalid Namespace or Format instead of Invalid Field
> in Command.
> 
> Each patch fixes one handler and translates the lookup failure to
> Invalid Field in Command.  The Set Features broadcast, the
> namespace-without-reservations case, the disabled namespace path
> (Internal Path Error, commit 505363957fad ("nvmet: fix nvme status
> code when namespace is disabled")) and everything else keep their
> current behavior.

Thanks, applied to nvme-7.3.

