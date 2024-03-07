Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EEFC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhAddCueojHrL7qPHkN1/TxTPP5rdVIyKbedjhNztC0=; b=etnYZrZ2ZsYH+VJpO0PbdTrkBj
	PBRSXcWIY77pxtrYUCFtyEOw5KP77Nh7nhqVAE3PMmVjGmZ0hkj1MUN7w3s6xpxgpG43+jPy4BapL
	sLcbiAueCDtZlQYBJuX/9z+YQquFzOlG40/KMp6ymxeU/pu6vlZJSwwBTgwhFjxSernd7O5ShZanz
	f/XkkD3QmG7axZfJAYnkAQ9jjgBRr9sn2AZRk9h1kTan/Ehyq3syZ/KLJG7Y+hAYZE4DnxuvzcoSy
	7tvQeLefL6w7+oYrXwbRJll8nvDzWAOSTSCKWteXfO2FfpWZ2t5mY0HuY2X3ro7OMUbVrhdnFrrpy
	JZzDkSdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFUh-00000005FCK-3M2D;
	Thu, 07 Mar 2024 15:17:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFUd-00000005FBC-0fE0
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 15:17:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D296D61C3D;
	Thu,  7 Mar 2024 15:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07169C433F1;
	Thu,  7 Mar 2024 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709824628;
	bh=bcLaWbBdhUfJxU9PF6Qxo7YRYTZ8kvqVGWXXOykqSHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6BX5Gb8dHBGAgqEHmtm/z5NoMyr0XGC4ohF8EapfRMPzoiaWvmVpWGF7/Whk2sVN
	 HJ8zaCB8Z5cx6V1j/pscPkfgQUZ2Df9XtiOkN1DnVlp+jzaNbEwluCRCPKZqOVihHy
	 VedeRFyzlUGBaPnJ/S2fcv3zLjDMJ2X6fatx+5hXLfH1qp5K3UhPa5vt12cMPMUlbn
	 JLFsQqxrAnchzuptZNZn6rIqrLjm+7boixC4PZXRtm2lL/DCAakRZp1j7jrIT+ciER
	 izIff1KnKPMZLJ01HVlb1v8i1PiTF12yEvdQ2+GLGKTLT+JA6rSK/JjX43Y3LEDelr
	 kwd/aUvRCDN3A==
Date: Thu, 7 Mar 2024 08:17:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	maxg@mellanox.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Message-ID: <ZenacXkUAh4I1gkK@kbusch-mbp>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
 <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_071711_332476_7D00FCF6 
X-CRM114-Status: GOOD (  24.81  )
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

On Thu, Mar 07, 2024 at 09:27:21AM -0500, Len Brown wrote:
> On Thu, Mar 7, 2024 at 4:29 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> 
> > > Some words are alarming in routine kernel messages.
> > > "timeout" is one of them...
>
> > > Here NVME is routinely setting a timeout value,
> > > rather than reporting that a timeout has occurred.
> >
> > No.
> > see the original commit message
> >
> > "When an NVMe controller reports RTD3 Entry Latency larger than the
> > value of shutdown_timeout module parameter, we update the
> > shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
> > informational debug level instead of a warning level for it."
> >
> > So this is not a routine flow. This informs users about using a
> > different value than the module param they set.
> 
> I have machines in automated testing.
> Those machines have zero module params.
> This message appears in their dmesg 100% of the time,
> and our dmesg scanner complains about them 100% of the time.
> 
> Is this a bug in the NVME hardware or software?
> 
> If yes, I'll be happy to help  debug it.
> 
> If no, then exactly what action is the informed user supposed to take
> upon seeing this message?
> 
> If none, then the message serves no purpose and should be deleted entirely.

It lets you know that your device takes longer to safely power off than
the module's default tolerance. System low power transitions may take a
long time, and at one point, people wanted to know about that since it
may affect their power management decisions.

This print was partly from when NVMe protocol did not provide a way to
advertise an appropriate shutdown time, and we had no idea what devices
in the wild actually needed. We often just get a dmesg with bug reports,
and knowing device's shutdown timings was helpful at one point with
suspend and power off issues.

You can make the print go away by adding param

  nvme_core.shutdown_timeout=<Largest Observed Value>

But personally, I don't find this print very useful anymore, so I don't
care if it gets removed.

