Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D820C00528
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKtnymo9BLKjAzCCZVciNLZvMc0xORujL4hCyHzOE4c=; b=MXZtjeI7VcYEUtT5xt8f7TFFOm
	hSC2JgmPxcgrbMS50MnDV/J7j8A0K0+rQeyEk3ynVDto3whLAAQxMnn/yHaXSzJroMb17dQlgtgHb
	GvvcWfuy7fWFYCPsg2LrWbr2TKxwa4AYgW2pwGWNDx6h8FwDY5K2J7s4VqrlJ4kEM3kmdO3fg7EWU
	huJ5jLiiB8FxFYt5UHnfBsVZV3wl5snZiF/uwHZ3RxxUOvkInQOUhh//bddlVbQVVhd5NcuwVki/5
	mnpVZJ8xCGpYIhWNeT+jMNj2FXedc2vI1TLEAdYsge7vrJIL8N8mlQ9hYO3Q5Bjajm8So/dntuPIj
	L7edaGQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJD8-002TZZ-1p;
	Fri, 28 Jul 2023 08:52:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJD2-002TXk-0s
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 08:52:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 998D51F8A4;
	Fri, 28 Jul 2023 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690534343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKtnymo9BLKjAzCCZVciNLZvMc0xORujL4hCyHzOE4c=;
	b=gXv6eHrvR/UWfZtWKuPI8GUxOYdPbsRflxT+0gHNH3rzlODSYFZSAZYlL4phngo5lr0iLW
	+Gw0rh/oclnk9UvR5I1yG4uAmzn7xyt1E/sZumrGU6hW1RVZCk7PWyYiKf60nvagZAwk1i
	6De5KlmovVCkdSS44cMosq2RFacZmHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690534343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKtnymo9BLKjAzCCZVciNLZvMc0xORujL4hCyHzOE4c=;
	b=JzlQ9CwhlQ0T1P9qLKLupGJ0J3d2l4fnF0oKTrdTsFGTJtyGLnAkLA/LmhI6G/RKun5pUi
	eX2r2ot3yc9iWcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89B1B133F7;
	Fri, 28 Jul 2023 08:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KdT3IMeBw2TMdQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 08:52:23 +0000
Date: Fri, 28 Jul 2023 10:52:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 05/11] nvme/{041,042,043,044,045,048}: Remove
 local variable hostnqn and hostid
Message-ID: <rqcyq6qhhiulveoi5t3sp3tkcwlyhwmh4qpvplskssfd6d2cr5@u53vr5xlizyo>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-6-dwagner@suse.de>
 <keqqev3paa2rtk5ysaitglnqfokeph7uvqh4z377atjlow65eh@buvr5azvul4s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <keqqev3paa2rtk5ysaitglnqfokeph7uvqh4z377atjlow65eh@buvr5azvul4s>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_015228_449136_9B6DB6F0 
X-CRM114-Status: GOOD (  17.85  )
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

On Fri, Jul 28, 2023 at 08:10:09AM +0000, Shinichiro Kawasaki wrote:
> On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> > Commit acc408477e85 ("nvme/{041,042,043,044,045,048}: Use default
> > hostnqn and hostid") switched the test over to use the default
> > hostnqn. It missed the change to remove the local variable and
> > use the def_hostnqn/def_hostid directly.
> 
> [...]
> 
> > diff --git a/tests/nvme/043 b/tests/nvme/043
> > index 6392bd8b2492..5569a7a58ad5 100755
> > --- a/tests/nvme/043
> > +++ b/tests/nvme/043
> > @@ -26,17 +26,13 @@ test() {
> >  	_setup_nvmet
> >  
> >  	local port
> > -	local hostid
> > -	local hostnqn
> >  	local file_path="${TMPDIR}/img"
> >  	local hash
> >  	local dhgroup
> >  	local hostkey
> >  	local ctrldev
> >  
> > -	hostid="${def_hostid}"
> > -	hostnqn="${def_hostnqn}"
> > -	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
> > +	hostkey="$(nvme gen-dhchap-key -n ${def_hostnqn} 2> /dev/null)"
> 
> As I commented on the previous patch, the left reference to subsys_name is
> replaced def_hostnqn. It means that the -n option value changes. I guess
> this change is fine for this test. Could you confirm it?

This change should be in the previous patch as you commented in the previous
patch. This is an artifact from my devel steps.

