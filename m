Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3C7C6FA86
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HyDG02c9cJ6gZAbqpQSke0paNWiFB9xIhGCSDaz5ZqA=; b=vfjSNLJdAqjic1c77FT72X15F8
	uR7ZnOa3MSLyipuWYWGVvZnpwE9731Xup1aGPEb184xnlodaFQhplTDqTm/2mlZFkmJDr1sfY+gHP
	D+ZQxIrz05eMUHASub1kq1CqggrJCKwpGrTH5/lo25Arx4/tsxcEW2aMVIj02sdOlwhgsJW575zZi
	9gVhrXiirlln7rVpmhWF6JM78H5kI2p3KEvbjqGLIs0vhb/JWYGJiLscD8iZUmpuj+GjeX0ugS+kF
	75thaDnOws/HIdn6sV/Uhx4MUXF2CpbGmZlMgt/Vur0Eh94izuH72HZeqM/Y48hcKS8RQ5SXQNSpb
	06qE5xNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odRoP-00Ef2I-Ug; Wed, 28 Sep 2022 07:48:57 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odRoM-00EeyA-Qy
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 07:48:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A777121E4A;
	Wed, 28 Sep 2022 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664351330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyDG02c9cJ6gZAbqpQSke0paNWiFB9xIhGCSDaz5ZqA=;
	b=V/IFxsJZJU04v3aFtNrIz4OctcoS9mo1iSQfxxeBHTZO9vorSe3GoMdzjZAH/RCVh+76em
	cuRbSsp4bziEW8PAWfKmMoyfhmlFoYpR8A7lAGr3owuHq4Hre81S6UapBe2F+WL7XMkTZ3
	WeNvqYi2ghOYckrZgZojSAAo8klVnq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664351330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyDG02c9cJ6gZAbqpQSke0paNWiFB9xIhGCSDaz5ZqA=;
	b=9yGPbMgpppnpuJBhtEco12Qpz5pcmBpRSiIZNTvTydnZJq297B4hC9CCpbuvrSvpATI9do
	jS0bPpGFspgPERBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9877B13677;
	Wed, 28 Sep 2022 07:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wlbQJGL8M2MrQgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Sep 2022 07:48:50 +0000
Date: Wed, 28 Sep 2022 09:48:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Message-ID: <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_004855_038568_AAACB442 
X-CRM114-Status: GOOD (  21.38  )
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

On Wed, Sep 28, 2022 at 09:55:11AM +0300, Sagi Grimberg wrote:
> 
> > In order to be able to test queue number changes we need to make sure
> > that the host reconnects.
> > 
> > The initial idea was to disable and re-enable the ports and have the
> > host to wait until the KATO timer expires and enter error
> > recovery. But in this scenario the host could see DNR for a connection
> > attempt which results in the host dropping the connection completely.
> > 
> > We can force to reconnect the host by deleting all controllers
> > connected to subsystem, which results the host observing a failing
> > command and tries to reconnect.
> 
> This looks like a change that attempts to fix a host issue from the
> target side... Why do we want to do that?

It's not a host issue at all. The scenario I'd like to test a when
target changes this property while the host is connected (e.g. software
updated -> new configuration). I haven't found a way to signal the host
to reset/reconnect from the target. Hannes suggested to delete all
controllers from the given subsystem which will trigger the recovery
process on the host on the next request. This makes this test work.

Though if you have a better idea how to signal the host to reconfigure
itself, I am glad to work on it.

