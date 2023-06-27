Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D61AEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYxMIJvRg1Oey3RCMYFyil5GkiXZqz/lRTENon81azs=; b=QCK4iydCmrQ2zxNUeBTpdhJ6yz
	0Q1K/GKzmFKhWezW6SQ4kLEHhnNAkJNiEl2EnsuM7Z11yI8sJfbFmN+lvg689jMydTUqNs0LNH6/Z
	W1hACdFU+ni67PpsZfG8oVVxj0NGekWLVwmQTsKaMc2zBZON9mt8Noo+f9m7pdlSLbzFcAIzHIhI/
	lHFF92JRe7KtWIBZ9xZMCnMvURHcOOsTwO33kJTJgHldBJ/JCu0plRFUetGmnd2nkupwN2I9zpPLm
	JWCHbz4r8izfaJauleGRDDOWm6BAeFOmEtGubVIMC2M9CFj2SbfymJb5MWAG3tYY9XSrLUEqfcE8M
	OE5NmHTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qE22G-00C6B1-2X;
	Tue, 27 Jun 2023 06:18:44 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qE22D-00C6AF-28
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 06:18:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07B8D215E6;
	Tue, 27 Jun 2023 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687846718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYxMIJvRg1Oey3RCMYFyil5GkiXZqz/lRTENon81azs=;
	b=rWw1V/46zjmLZk5yt5sKpHwFCugNWowccN+igIO8xikiSvedQ/ZCnwX02z87q70HZNSMsM
	5ZnnVgT94EILgB1nPHWOlFd349sczFDb1T2f0Hhi1bU7W339+4bXqpqKRvDmA4fJC75k5F
	pCLyjNZMYev5GgaFBzqsxhIV1nqmwqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687846718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYxMIJvRg1Oey3RCMYFyil5GkiXZqz/lRTENon81azs=;
	b=bWeUXihaX0NCVcFt5Fd4ObQ4+Z2UzTYexWjkYnFApqEFZaAWhOdFkv6tQNs9lDAZssJHXQ
	c/35esmV511d3JCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB71E13276;
	Tue, 27 Jun 2023 06:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8BYcOT1/mmQueQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 27 Jun 2023 06:18:37 +0000
Date: Tue, 27 Jun 2023 08:18:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <s7ojt6ad3i3t4ddqwxvxsxv4zxisz6skomogwbw3qljbuqkwr6@akwaxv2cyg2d>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <3ea88e87-9b24-4f7a-958c-97e27d94ec30@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea88e87-9b24-4f7a-958c-97e27d94ec30@moroto.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_231841_856195_EC424E3C 
X-CRM114-Status: GOOD (  21.22  )
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

On Mon, Jun 26, 2023 at 02:33:18PM +0300, Dan Carpenter wrote:
> > @@ -2943,6 +2943,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
> >  	/* force put free routine to ignore io queues */
> >  	ctrl->ctrl.tagset = NULL;
> >  
> > +	if (ret > 0)
> > +		ret = -EIO;
> 
> All these checks for ret > 0 make me unhappy.  I don't understand how
> they are a part of the commit.

We have two types of error message types in the nvme subsystem. The negative
values are the usual ones and positive ones are nvme protocol errors.

For example if the authentication fails because of invalid credentials when
doing the authentication nvmf_connect_admin_queue() will return a value of
NVME_SC_AUTH_REQUIRED. This is also the value which gets propagated to this
point here. The problem is any positive error code is interpreted as a valid
pointer later in the code, which results in a crash.

> I have tried to look at the context and I think maybe you are working
> around the fact that qla_nvme_ls_req() returns QLA_FUNCTION_FAILED on
> error.

The auth blktests are exercising the error path here and that's why I added
this check. BTW, we already use in other places, this is not completely new in
this subsystem.

> Also the qla_nvme_ls_req() function EINVAL on error.  I just wrote a
> commit message saying that none of the callers cared but I missed that
> apparently gets returned to nvme_fc_init_ctrl().  :/
> https://lore.kernel.org/all/49866d28-4cfe-47b0-842b-78f110e61aab@moroto.mountain/

Thank!

> Let's just fix qla_nvme_ls_req() instead of working around it here.
>
> And let's add a WARN_ON_ONCE() somewhere to prevent future bugs.

This makes sense for the driver APIs. Though for the core nvme subsystem this
needs to be discusses/redesigned how to handle the protocol errors first.

Thanks,
Daniel

