Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DBAC54E41
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JEswWbBKF2EclVzK7Fs1wCLFc+b3+ZnxiWCsNEJwEIo=; b=iW+zR/V0Ml35u2lcaH6KAk3yQ1
	S5cDQu8cqPRlpSpd3vtNMHleVylmiY37vi2LK0P2LO63c4OhNwTW5jLd6KOK7PTQ8qBWN1b59h15e
	FdOa8soqp0q1G1jJDvchYcTgRI3Uf4N5O0CE8oAQYOxsDQw3tTEKgpXq6ZTFMVkkOyrymPBDXc7oq
	EgJEereZSh2rrX2prWTUljOQP9Zu1azNRO/FodSI/MN4BXjdswx0lhyCGOTPyYpdWQJPb9l6upD1l
	vPNkyNz3OPEm2/7sXZ8uhBlH0kbfQZ4A9HMwctNXdYbve0a/Okll3Lpb3pYq4ZA08yslBlAYogyW6
	kAJGIQyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfEMB-00000008In2-0aQM;
	Wed, 28 Feb 2024 07:27:59 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfEM6-00000008IlK-2JBI
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 07:27:57 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E047226CE;
	Wed, 28 Feb 2024 07:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709105272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEswWbBKF2EclVzK7Fs1wCLFc+b3+ZnxiWCsNEJwEIo=;
	b=qPlg60GT99HQju1YrxQt1MuA5leFqJUZvCVAwXrB8Msq8PbWmVs809Ek0QA/Lq+8ET+kfQ
	2gANqTWrOpBqJ8RCOGS9/uwGxf4oAfufcIO1kh6wIXdFNzznkZB/XQVkWzYw2d/SPfk0yy
	tE1dDi7ZGWbEXh8n5FnRj3wuj4aUuPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709105272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEswWbBKF2EclVzK7Fs1wCLFc+b3+ZnxiWCsNEJwEIo=;
	b=pT6Jx7OyFae3KGEuGfkleLX35pjRhzpuN6RS++06doZUNq0xvyB/EhuC4hAWJi5dZgLq0w
	JrfDgjuBS4di5XBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709105272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEswWbBKF2EclVzK7Fs1wCLFc+b3+ZnxiWCsNEJwEIo=;
	b=qPlg60GT99HQju1YrxQt1MuA5leFqJUZvCVAwXrB8Msq8PbWmVs809Ek0QA/Lq+8ET+kfQ
	2gANqTWrOpBqJ8RCOGS9/uwGxf4oAfufcIO1kh6wIXdFNzznkZB/XQVkWzYw2d/SPfk0yy
	tE1dDi7ZGWbEXh8n5FnRj3wuj4aUuPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709105272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEswWbBKF2EclVzK7Fs1wCLFc+b3+ZnxiWCsNEJwEIo=;
	b=pT6Jx7OyFae3KGEuGfkleLX35pjRhzpuN6RS++06doZUNq0xvyB/EhuC4hAWJi5dZgLq0w
	JrfDgjuBS4di5XBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 49FA7134FB;
	Wed, 28 Feb 2024 07:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LU+lEHjg3mXmNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 28 Feb 2024 07:27:52 +0000
Date: Wed, 28 Feb 2024 08:27:51 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: Re: [PATCH] nvme-fabrics: check max outstanding commands
Message-ID: <73uh4vwpacq22ttzlbrouvtpwysbcy246d2ejgpobsrtb2chaw@rlbdjiqzbdsa>
References: <20240223033004.55756-1-kanie@linux.alibaba.com>
 <Zd4f4PaoOM6WSF4u@kbusch-mbp>
 <89bcff20-e07c-4f62-9ef8-36cbbc3d6def@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89bcff20-e07c-4f62-9ef8-36cbbc3d6def@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qPlg60GT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pT6Jx7Oy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,alibaba.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 5E047226CE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_232754_779821_9FBB2F76 
X-CRM114-Status: GOOD (  24.16  )
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

On Wed, Feb 28, 2024 at 10:23:24AM +0800, Guixin Liu wrote:
> 
> 在 2024/2/28 01:46, Keith Busch 写道:
> > On Fri, Feb 23, 2024 at 11:30:04AM +0800, Guixin Liu wrote:
> > > Maxcmd is mandatory for fabrics, check it early to identify the root
> > > cause instead of waiting for it to propagate to "sqsize" and "allocing
> > > queue".
> > > 
> > > By the way, change nvme_check_ctrl_fabric_info() to
> > > nvmf_validate_identify_ctrl().
> > > 
> > > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > > ---
> > >   drivers/nvme/host/core.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 0a96362912ce..5cdd22f591f9 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3084,7 +3084,8 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> > >   	return 0;
> > >   }
> > > -static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> > > +static int nvmf_validate_identify_ctrl(struct nvme_ctrl *ctrl,
> > > +				       struct nvme_id_ctrl *id)
> > >   {
> > >   	/*
> > >   	 * In fabrics we need to verify the cntlid matches the
> > > @@ -3117,6 +3118,11 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
> > >   		return -EINVAL;
> > >   	}
> > > +	if (!ctrl->maxcmd) {
> > > +		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
> > > +		return -EINVAL;
> > > +	}
> > This part seems fine, but I don't think you need to change the name of
> > the function for this addition.
> 
> OK, this will be removed in v2.

And please run blktests with it. Last time, we had some fallouts when a
new check was added. Thanks.

