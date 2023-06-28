Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE2FEB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 06:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pb1MWnUMmUFEexxqK5EEY1JTSgmlRyHzP6MrqQFpEXU=; b=wN7HKm58szrKQb8fAK8lL7QZfP
	mryHq/XpWilPPYF7sZav6Rc/JQ8DGxMcP5TSpwkS85FN2mBSVHF2co5P9kTOTsgMT6atZNWn/MvL2
	9kUEu9dVmrEMC7Gx34LznEnF1cfTRbX2JhEQpheQRkOtAiDJpkpk8QeAXKI4Ab/jziuGxVlPIgM4w
	haHlLXfNWPSw5LCx3NkwHxl+AYnBsLCdmRoBaRbzUs9KFYaImnIzgM7NvhFtCJ/XButwBZfTCIXMH
	NmA/DrZZ56ClZ7C4+wf8+GZVrkB7a8khR+JYo9PXVQrKgxwA2bPe3vuSSk7xvwyUKZrc6CFiwL7rq
	a1IYSPVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEONL-00EwFA-2x;
	Wed, 28 Jun 2023 06:09:59 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEONJ-00EwEJ-0m
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 06:09:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4FBA21864;
	Wed, 28 Jun 2023 06:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687932593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pb1MWnUMmUFEexxqK5EEY1JTSgmlRyHzP6MrqQFpEXU=;
	b=YaYej1+R30o+dQs1G1sudkf9gCXZ0aUOD8y7MDYkVUrM2fmAol6PYiPYlr8/urWhqNoxuv
	pOz5DwJ0yjft0n+5PVkUBxNfVdphIqR89aw6bvhctKCYmYBx1HWz5ZSFE4h9FWIt2/1yzn
	6TnSC/0XOK77BpGtD0iCczdutNkgAcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687932593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pb1MWnUMmUFEexxqK5EEY1JTSgmlRyHzP6MrqQFpEXU=;
	b=PUzBZ2/mZv5KJOFaiPsbNDAfkGGcOcY5hMmJO3e1mdDxJDKhWegvRSFRNcN6r6/SYK6dvQ
	3EUUToqhETgvzJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF98B138E8;
	Wed, 28 Jun 2023 06:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id c9RlLrHOm2QcEgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 06:09:53 +0000
Date: Wed, 28 Jun 2023 08:09:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <ygfgqglmntpqiopzq44aqegehnlroarteqjtmih7mulan4oukv@jmtupz2jnafv>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_230957_425296_19A0B3C3 
X-CRM114-Status: GOOD (  24.00  )
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

On Tue, Jun 27, 2023 at 10:22:53AM +0000, Shinichiro Kawasaki wrote:
> On Jun 20, 2023 / 15:27, Daniel Wagner wrote:
> > When the host has enabled the udev/systemd autoconnect services for the
> > fc transport it interacts with blktests and make tests break.
> > 
> > nvme-cli learned to ignore connects attemps when using the
> > --context command line option paired with a volatile configuration. Thus
> > we can mark all the resources created by blktests and avoid any
> > interaction with the systemd autoconnect scripts.
> 
> This sounds a good idea. Question, is "--context" option of the nvme command
> mandatory to run nvme test with nvme_trtype=fc?

If nvme-cli is called without the '--context' option, the command will be
executed. Though if '--context' is provided as option and there is a
configuration which matches the connect parameters but doesn't match the context
it will ignore the operation.

The blktests tests expects that nothing behind it's back is fiddling on the
setup while it is running. So far udev didn't trigger for rdma/tcp but with fc
it will.

Thus, it's mandatory to use either the '--context' parameter or alternatively
disable the rule with

  ln -s /etc/udev/rules.d/70-nvmf-autoconnect.rules /dev/null

BTW, when the udev rule is active I observed crashes when running blktests. So
there is more to fix, though one thing at the time.

> Or is it nice-to-have feature
> depending on the test system OS? If it is mandatory, it's the better to check
> in _nvme_requires.

Well, I didn't want to make this a hard requirement for all tests. I guess we
could make it for fc only if this is what you had in mind. The question should
it only test for nvme-cli supporting --context or should it be really clever and
test if the udev rule is also active (no idea how but I assume it is possible)?

> >  _cleanup_nvmet() {
> > @@ -337,6 +383,8 @@ _setup_nvmet() {
> >  		def_host_traddr=$(printf "nn-%s:pn-%s" \
> >  					 "${def_local_wwnn}" \
> >  					 "${def_local_wwpn}")
> > +
> > +		_setup_nvme_cli
> 
> Can we move this _setup_nvme_cli call from _setup_nvmet to _setup_fcloop?
> _cleanup_nvme_cli is called in _cleanup_fcloop. I think it is a bit cleaner
> since those setup/cleanup functions are called at at same level.

Sure, no problem.

