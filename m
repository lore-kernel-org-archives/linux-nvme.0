Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F011FC88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDiF85frZeJEZAOsgR1xXVkqQfoqGin6i1WTRB+Jd8U=; b=BLWlMVNey4Od9cJJgtblMSIe0N
	nmJ7qw1YUXcIKIeCvM6RjgmTN5REP28ZQJw1DUFFATQaEZoO9tQetNi4DOpprkdbr0GqW+fy+VyaH
	jn7YDY3V1x2+S+sV65bm/6zCa4FRkGEpnSBmlXqJIlsO0OqQ1vk97geqp01DrjUVLWtLS1qST/aSp
	XJqnGnCASkmgtGaF6l61DxJw1RD/hCwRlt8Ejo4bNWJnV12QpHc8txQFsNLVIJsOPmQfGC9EPfcVG
	6Ep8H4zzxUV5R0ay36ipL0SuJHAlXmwDE6ZmKjJL38nqvzMATeUideO2FZmgnwYW2FsOqPi+i2udo
	hU36p17w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68Ty-000000048zW-0B1L;
	Mon, 14 Sep 2026 15:20:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x68Tv-000000048zF-3kax
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 15:20:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BF2E60261;
	Mon, 14 Sep 2026 15:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FF11F000FF;
	Mon, 14 Sep 2026 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399231;
	bh=IDiF85frZeJEZAOsgR1xXVkqQfoqGin6i1WTRB+Jd8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkPnyJhLoy4Rrr8wztJFIKP4HSL3lWn9MOsjCvcfmrQuLoTH9Pca40ZLYnysE0Lvb
	 5NuLoo43VyLjv49t8PPWQlxTwDzB7kyz28b75bf4vY2GeKB3Mml3b5IR7Pncq0HbGY
	 XwnH0KLurBNnplxzSJKTifyXTCiq/LbqPupTb0XIhw+fSMe6K3gz9/Qzx283x5CNv4
	 XZq+Fe78RdFXrQ7OVk+sA+6ZY2AoTR5skLuxFXBXMCYSbTNWk1NJmQJuHFveZbcprn
	 6qC0l93atwe2m+AXTZgz3Qe7jR35hYjpw28/ALfbeD86ECl7g8fJkKYyeparxyWvNm
	 QzvHSelJfSRxA==
Date: Mon, 14 Sep 2026 09:20:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: syzbot <syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com>,
	hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nvme?] WARNING in nvme_loop_reset_ctrl_work
Message-ID: <aqgQvIG17WgKKoFs@kbusch-mbp>
References: <6a9ed559.6e6c5f9e.240462.0003.GAE@google.com>
 <6aa6c282.4c28b7d0.c1bba.000d.GAE@google.com>
 <DLEXGM8VZOW9.1J9A20FEP43RM@arkamax.eu>
 <DLEYMPA5WF42.2GHC28RDZX90E@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLEYMPA5WF42.2GHC28RDZX90E@arkamax.eu>
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

On Mon, Sep 14, 2026 at 12:16:53PM +0200, Maurizio Lombardi wrote:
> Maybe moving the controller to CONNECTING state before exposing it to
> sysfs will prevent the warning:

I think all the transports set CONNECTING after adding the controller,
so this would have to be duplicated for all of them, right? But why do
we allow going from NEW to RESETTING? I don't think any of the
transports do that anymore, so we can remove that transition instead.

