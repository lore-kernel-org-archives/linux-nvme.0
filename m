Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B45C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CWpXXXyREb+amIi0zhfsuuwmT6elHeid6ihrvnTWDI=; b=DtHhwXw7DgTwSAp74nO6hFWm8R
	7J9aHOr+MJnCXRvzmh/DTkyNqqvtYsb78exepJbBtBr1nLc2nKmcs6By2TCUUzsVVyOFsgBiDOeKw
	E7joWf6IDiGVkv4tZuUpNlZ+lr9nG4TnxqfO36N/PbA3Wp6Vb+nCiO/iIRPgtvWfLaDEy+qPGKYvY
	aAViIpPj/0UsHUyBpSlUGi1vge5T6MnU8QqUYq6HYMxkiyXK2DbjMscYhAdnUDCi8ud87d71Peuwy
	cii6s9vc0cbKgWaHlEerLygyjH6khDM2QQjPBRui47e3aaX+Wno+NT20FoEfoFhMkMe4AhZOSiBAo
	FL8FNgrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol5Vo-00HP76-Ua; Wed, 19 Oct 2022 09:37:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol5Vl-00HP3Y-IP
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 09:37:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F75E20420;
	Wed, 19 Oct 2022 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666172233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CWpXXXyREb+amIi0zhfsuuwmT6elHeid6ihrvnTWDI=;
	b=SHnfQ0rkHyufblI87rqfVF9w9KlQZtFi6ksLVpiOhDvYMjQvfJtTvN9CxaylTZcZE/plUH
	k3/Nw9gTKOAtbvSd5pUz8PwSUU61naB5inwX31ANKds2m+K4dYKu763BtcCsbNa96BwlH1
	j5+h4awZgERKgLW1DEQwEMI9/SiOTRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666172233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CWpXXXyREb+amIi0zhfsuuwmT6elHeid6ihrvnTWDI=;
	b=UOtC2HNsuUOsQYHmgZ7UDMDxOfVgTFtXNLrUXmUuUNLv6lR++3IGXuDlRzeMqUR9gBZcnO
	mFKA7sjiFHyb7MCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91F3D13A36;
	Wed, 19 Oct 2022 09:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dpy5I0nFT2OUCAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 09:37:13 +0000
Date: Wed, 19 Oct 2022 11:37:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_023717_773385_6CA10384 
X-CRM114-Status: GOOD (  12.08  )
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

> >    Possible unsafe locking scenario:
> > 
> >          CPU0                    CPU1
> >          ----                    ----
> >     lock(fs_reclaim);
> >                                  lock(sk_lock-AF_INET-NVME);
> >                                  lock(fs_reclaim);
> >     lock(sk_lock-AF_INET-NVME);
> 
> Indeed. I see the issue.
> kswapd is trying to swap out pages, but if someone were to delete
> the controller (like in this case), sock_release -> tcp_disconnect
> will alloc skb that may need to reclaim pages.
> 
> Two questions, the stack trace suggests that you are not using
> nvme-mpath? is that the case?

This is with a multipath setup. The fio settings are pushing the limits
of the VM (memory size) hence the kswap process kicking in.

> Given that we fail all inflight requests before we free the socket,
> I don't expect for this to be truly circular...
> 
> I'm assuming that we'll need the below similar to nbd/iscsi:

Let me try this.

