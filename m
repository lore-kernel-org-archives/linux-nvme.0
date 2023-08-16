Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C0C001DF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3v+/Wi405rsVGzzaExajmDFKvpMN/i7HI4eeAj0pfWU=; b=dHxaSyTKRMVtj2Z3bOC02rDICP
	iGzcyXTrvAfoy/ySLCyKz4Z5HtxnREzQhwBfpXwFh5tEwqaWv7/MAi+ZacrXhOZMWsXo4heYO26RX
	OUlIYfpDGY6BTkee9Smneo4FtNZtYth7vb6iOLuOnk3eHCAonw26tlnwnMWOhTCOIDpiqKhSD72dx
	8+K5XtqISCqUhBD4pedjShFC8t7Hqb3XC+rfkc8821gLTCe6W8ehusBW62eTHIjqvr/E6SN5eQp1f
	57tT0NwgFyBf7MLEL/FTPdX7Vw2ekhUq75HgS3QgxnonnGApP+dnaiWyFR4boNDILJ+ttHsoK1pt/
	D1/EU61w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWCpX-003bIV-2l;
	Wed, 16 Aug 2023 09:28:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWCpU-003bHe-1M
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 09:28:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E7882186F;
	Wed, 16 Aug 2023 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692178115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v+/Wi405rsVGzzaExajmDFKvpMN/i7HI4eeAj0pfWU=;
	b=XkJanD5yZJgl8bb9mkFXnFDcEx4sySY7RY+x5ufziG1rwpF/bMKnVLphGL1drSm2Y6Ey8r
	2lT7PhBYmm0ZAupI2KUGviMcxa/21SjJBIra0ZxJQkCpVdaBiqoa3mUzdAlXW/yT1gA5IA
	GDxpTfIoyVkJNqCuwQ7H1OWX7j/+sB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692178115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v+/Wi405rsVGzzaExajmDFKvpMN/i7HI4eeAj0pfWU=;
	b=ULIR+MRWe5CidH1YupjqjCLKpm8hhUkOrppAkcxLSc/mnMVX09az9R0PI4dEpRV+H4MjkQ
	YJ1HkDHmpT3oQfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F29F9133F2;
	Wed, 16 Aug 2023 09:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Uq0mO8KW3GTYTQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 16 Aug 2023 09:28:34 +0000
Date: Wed, 16 Aug 2023 11:28:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>, 
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 13/13] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <lfr3tkzz3sqnsw4y7sqyxc42ptvzkyfqfpeko6gzs42jdgjl2d@u5fbzjksbztd>
References: <20230811093614.28005-1-dwagner@suse.de>
 <20230811093614.28005-14-dwagner@suse.de>
 <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_022840_624554_4389A3E4 
X-CRM114-Status: GOOD (  17.31  )
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

On Sun, Aug 13, 2023 at 05:55:48PM +0300, Sagi Grimberg wrote:
> > --- a/tests/nvme/003
> > +++ b/tests/nvme/003
> > @@ -22,15 +22,9 @@ test() {
> >   	_setup_nvmet
> > -	local loop_dev
> >   	local port
> > -	port="$(_create_nvmet_port "${nvme_trtype}")"
> > -
> > -	loop_dev="$(losetup -f)"
> > -
> > -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> > -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> > +	port="$(_nvmet_target_setup --blkdev=device)"
> >   	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
> > @@ -46,9 +40,8 @@ test() {
> >   	fi
> >   	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
> > -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> > -	_remove_nvmet_subsystem "${def_subsysnqn}"
> > -	_remove_nvmet_port "${port}"
> > +
> > +	_nvmet_target_cleanup "${port}"
> 
> It is very very strange that _setup returns a port
> which is passed to _cleanup...

This is the only information the _cleanup helper needs and that is why
it survived the refactoring so far.

> I think that _cleanup should simply remove all
> ports, and that setup should not return a port
> to begin with.

This assumes that blktests is the single user and can blindly remove
everything. I would like to play nice here and only cleanup resources
blktests actually allocates.

> If someone needs the actual port number, then it
> should either not use this _setup helper or
> query it somehow.

I try to figure out how to implement such a query helper then.

