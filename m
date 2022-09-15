Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2F8ECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Sep 2022 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Doj1K3/bZA2+DWtI/Gb+Jvq6i/4kBiqqVu5pjUqLMQ=; b=kF4xcGfdejIxyESE6GQp7UnjrZ
	vanRQi8NLxfFeQmBdvEgv6ZR+cwR4Fo7lh1NMxJI41430yJXzqRQOfuQpUQTbT3wwW/oE7UlUxSwN
	pIbVg7tf9vo0N698ftulYNwfKas9aW0/mlOHXylJbHRSFfCC4/njDkY6g3O8jAl/OJcGYHh1pMq95
	OZRXsMzlYUrYLGukKwOynFzULLDOPjFSdsLrv0Q8GVmIT4rF02i8qP16Rp0oBjACQwFGDUimGE3O/
	R1NFgxYrnVuagLarfKh8wkn+uNz+VGzhvbNedKcyyexlL8yzh1DpeA4JVQ4A+d0LMqHhryNEQCs33
	PPO7sZHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYn7T-007l42-75; Thu, 15 Sep 2022 11:33:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYn7O-007l0y-1J
	for linux-nvme@lists.infradead.org; Thu, 15 Sep 2022 11:33:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E689033835;
	Thu, 15 Sep 2022 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663241593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Doj1K3/bZA2+DWtI/Gb+Jvq6i/4kBiqqVu5pjUqLMQ=;
	b=lHKOLnwnAvk916/SBwJF1UEOmu3DsP51fxXPWzGabQak/VeYa6VW17OUj31wotS6CEMGve
	SF7U1OoQx4XhybbTsJtiUIOofqQvKuqfSlnuyebDQztSwY8aU8lPmHjqCWbe2AqyNTM61r
	FzZCRcfKJ7jr/hyAkmjDvtZBzNxgVgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663241593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Doj1K3/bZA2+DWtI/Gb+Jvq6i/4kBiqqVu5pjUqLMQ=;
	b=I6CI5RcnR75LMmwekc3gdxBPN+ER3Sxw1buYM4pd8GZKvni0iUOTpcMQKbyX1/wDrXzOls
	5wShaKSZdAi7XgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8C7313A49;
	Thu, 15 Sep 2022 11:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0KjSNHkNI2NNKwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 15 Sep 2022 11:33:13 +0000
Date: Thu, 15 Sep 2022 13:33:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220915113313.26mpn3ytnhv4oout@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
 <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
 <20220914110717.pvzm2666mklkg73a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914110717.pvzm2666mklkg73a@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_043318_260983_AA9C393C 
X-CRM114-Status: GOOD (  14.98  )
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

On Wed, Sep 14, 2022 at 01:07:18PM +0200, Daniel Wagner wrote:
> > > [399664.863585] nvmet: connect request for invalid subsystem blktests-subsystem-1!
> > > [399664.863704] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
> > > [399664.863758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> > > [399664.863784] nvme nvme0: NVME-FC{0}: reconnect failure
> > > [399664.863837] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > > 
> > > When the host tries to reconnect to a non existing controller (the test
> > > called _remove_nvmet_subsystem_from_port()) the target returns 0x4182
> > > (NVME_SC_DNR|NVME_SC_READ_ONLY(?)).
> > 
> > That is not something that the target is supposed to be doing, I have no
> > idea why this is sent. Perhaps this is something specific to the fc
> > implementation?
> 
> Okay, I'll look into this.

I didn't realize that the 0x182 can be overloaded. In the case of fabric
commands it stands for NVME_SC_CONNECT_INVALID_PARAM. So all good here.

