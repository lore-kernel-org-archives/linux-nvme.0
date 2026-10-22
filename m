Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37723606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gx0fRDUD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jF43IVuv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kfBz61fRoC7Z3igoEcq37wqZzMC4s5u9se9kNfpr59s=; b=gx0fRDUD0IfjAsCcYOLaSmmGQt
	8Erf32NNfg+Q9Yvo1FL+fr/OGA8wkatd7UXXTAyrBD0VForvjQIYHuf93V14AVK75Ay8QFh4/KgZd
	RkIneWphc48AncMml8InsuYG783EgeWf0bkbzP/OBcdY8llQJpCZ/odOyy1XpFNzhqzf8GJmGep31
	4exaPhVfZXvU9Cy7VvRTxgyvXa7sCSvzIiMr7suw5PXQysx8K0vTxTD/6adcGrFZUV+TG5jkzdBT5
	vJ4bn8d/YTGdiYladclXkqcMBT01EiQRx8OhI5ImLIQ2I0epzPTuKcK+m/nt/nnaFFUQgr/dceALK
	IHzvnRKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK22f-0000000F9nk-44rm;
	Thu, 22 Oct 2026 23:17:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK22e-0000000F9ne-2Anx
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 23:17:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E1B96022E;
	Thu, 22 Oct 2026 23:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049CB1F01825;
	Thu, 22 Oct 2026 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711067;
	bh=kfBz61fRoC7Z3igoEcq37wqZzMC4s5u9se9kNfpr59s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jF43IVuv3l2UaN3yECjR5/T1XZRVtCqftTMnOpa+ZAbEThBgi1h0boIRWF8iz+4gC
	 2BLgIy6rmgUgpsu2nN+7Ctja4dG88mb6mVEVRiaKNEutxChrByYB8FMb5ac9WmUgS1
	 JmhbfSwKTBoZJ8iZIWfh2QMsRluYA55yD5htKA2p5qHQF3VJ4UyezzgIQXZ58GNHYe
	 FSurGAzW03U5QcIdZiYOm9K3YhwgVwVUF4HQS86S9dTDlStpP/FQnof5fWRz8BmAbs
	 jEuqfzyT9k5m/FUBYfxdYEqHLM6xLOKnmiYXTAJ2sk5fHGuwqvItRbPl+WjsMzwDzO
	 1h8I3vU0EwQ0A==
Date: Thu, 22 Oct 2026 17:17:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <atqZmctbU0siYmVX@kbusch-mbp>
References: <20261016141208.2641974-1-e.velu@criteo.com>
 <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp>
 <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp>
 <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
 <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:27:50PM +0200, Erwan Velu wrote:
> Le sam. 17 oct. 2026 à 06:25, Erwan Velu <e.velu@criteo.com> a écrit :
> >
> > [...]
> > > Unfortunately, no: there are contradicting statements here.
> [...]
> > If you think it makes the commit message clearer, I can send a v2 with
> > these numbers, the kernel anitly, and the driver level Flush latency above.
> 
> Hey Keith,
> WDYT of these explanations and additional details?
> Hope that's better and could be considered for inclusion in the next
> releases, maybe as a backport to the stable ones as incorrect
> detection of the volatile's cache status can lead to severe
> performance impact on this type of drive.

I just wanted to see if there was any difference in the controller's
Flush behavior when the volatile cache was enabled vs disabled, and this
looks like it's the same either way. The Flush should have been a no-op
to the device with WCE cleared, so something seems off here.

I'm wondering if the device is actually really respecting WCE set to 0
now. That might be tricky to prove, but it wouldn't be the first time a
device lied  about durability. Not saying that's happening here, but the
behavior you're reporting is suspicious: 15usec writes are not
physically possible with TLC NAND (your model says BiCS TLC) without a
cache, and your controller says your cache is volatile.

Anyway, the principle of what you're proposing looks fine to me from a
spec standpoint. I'll get this queued up if I don't see any other review
feedback or concerns that it's going to corrupt something...

