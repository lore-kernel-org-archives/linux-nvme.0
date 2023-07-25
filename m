Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C01EC0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVjL4UhSzoBlrDSbgc7vzp1Jz7SDoXUOlax3PWxzyjI=; b=izuRifPy0kANfdI1oVAFBdldN2
	kaElCD5EjsU5ng6ykfztllMCva+CCFLVc61VDL/79e5tq3Vz36j1YpbaDL7KxMsOIAeuSaxJBqT8W
	G0xmhVnzRz1S7MfouFwmb8YmvTbz1rshHIwJdaDBrkQFvhmHUWciojbsJLlFQpaSaZDXk4XGECp2R
	DZwHGHwuDb1UA8Ped72gOhDdtRUGE4ro9XiuorMIFE6TYByHANyTM+t1AgTFvytJ9znnqtDdl4gpD
	xlyTzM+Ytkg2QkB7ABtHdbExaXkl2ge+R0pgm9veIZGvAnbgBGdFmW6kA556GCN7H/hKoKTOeragC
	dQqCeXLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qODb6-006mx5-0j;
	Tue, 25 Jul 2023 08:40:48 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qODb3-006mvN-2J
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 08:40:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D6592238C;
	Tue, 25 Jul 2023 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690274441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVjL4UhSzoBlrDSbgc7vzp1Jz7SDoXUOlax3PWxzyjI=;
	b=Dfcq9//5pFtA2txSoxOqxANwZMzmG/eSytFddD3B//7EnowMc6XgVfmMxXHpm4r1soY5sQ
	cwd7M2WvrbehaBvo9jQfdsItl1Vm38JkX0lSHwQ8JcQV84nCrmUbrpJfQtawgA0rYixSdE
	zkHIy+ZCDxiwVHN7sLHhonN6FOgTtx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690274441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVjL4UhSzoBlrDSbgc7vzp1Jz7SDoXUOlax3PWxzyjI=;
	b=rrdfZYJRvafe2H8ek8sIdFonlbD4biIgLKfexCXKe3wlHA37bgqEyJGpsNgVDElkyW/dWt
	eBsBVX9uAXKfl8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50CD613342;
	Tue, 25 Jul 2023 08:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ylWmE4mKv2QCPgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 25 Jul 2023 08:40:41 +0000
Date: Tue, 25 Jul 2023 10:40:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>, linux-nvme@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel
 does not support the option
Message-ID: <r3xuoptvmxqnbt6gi26b6av2jj4wbi3eixgd74lmdauxip63jt@pxmvqyljanjr>
References: <20230724090611.705366-1-sagi@grimberg.me>
 <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
 <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
 <udo5xyydb5jb6isnpcbutuegifww2kuto44k3yu3eb6mnctwia@d7lmpffppurl>
 <e23cbae3-2a31-070f-e03a-bb6b5ff1ad76@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23cbae3-2a31-070f-e03a-bb6b5ff1ad76@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_014045_916223_CA281774 
X-CRM114-Status: GOOD (  28.35  )
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

On Mon, Jul 24, 2023 at 10:49:31PM +0300, Sagi Grimberg wrote:
> > I've paired __nvmf_supported_options() with build_options(). We can
> > move the call to __nvmf_supported_options() further up if it helps.
> 
> We really should just have an interface to check specific options,
> because that is what consumers care about, not the entire opts set.
> 
> Inside you can do the open/read/close once and cache it in memory
> (although I think this is a really unneeded optimization).

There are some users with bigger setups where 8 connections are initiated. We
currently have 7 new options avaible which we are looking for. Thus at least 56
the open/read/close step in such a scenario. I found this a bit excessive hence
the optimization.

> > > Daniel? Any reason why we are caching these opts in an executable
> > > with a short lifetime? And apparently we need to be very precise when
> > > we rely on this cache to be stable.
> > 
> > Ah I see, in this case let's bring nvmf_check_cap() (although I couldn't find it
> > anywhere... I can remember I saw those patches)
> 
> I also remember making disable_sqflow check instead of a retry, so maybe
> it got left behind...

I couldn't find in my mail box or on lore. No idea what I did with it.
Sorry.

> > > If you prefer to cache it, at least do it in the start of every
> > > fabrics callback so we don't need to understand when this cache
> > > is valid...
> > 
> > I don't want to cache it, I just wanted to avoid the above mentioned
> > open/read/parse/close cycle for each build options.
> 
> So do you want to add the interface? Or should I? (assuming you agree
> on individual opt check) ?

Yes, no problems with an individual opt check. Just a sec...

